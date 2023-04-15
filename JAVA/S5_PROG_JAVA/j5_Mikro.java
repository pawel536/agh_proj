import javafx.application.Application;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.Group;
import javafx.scene.control.Button;
import javafx.scene.control.Slider;
import javafx.scene.layout.StackPane;
import javafx.scene.input.MouseEvent;
import javafx.stage.Stage;
import javafx.scene.layout.*;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.canvas.GraphicsContext.*;
import javafx.scene.canvas.*;
import javafx.scene.paint.Color;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.util.Duration;
import javafx.scene.text.*;
import javafx.scene.control.TextArea;
import javafx.geometry.Pos;
import javafx.stage.DirectoryChooser;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.StringTokenizer;
import javafx.scene.control.ChoiceBox;
import javafx.collections.FXCollections;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.SnapshotParameters;
import javafx.scene.Node;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;
import javafx.scene.image.*;
import java.nio.ByteBuffer;
import java.io.ByteArrayOutputStream;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

//custom klasy
import zdjclass.Zdjecie;
import cam.Frames;



public class main extends Application
{
    private static final int FRAME_WIDTH  = 640;
    private static final int FRAME_HEIGHT = 480;

    GraphicsContext gc;
    Canvas canvas;
    Timeline timeline;
    AnchorPane root;
    Stage primstage;
    int flaga_podglad = 0;
	int flaga_zaznacz = 0;
	double pt1x = 0;
    double pt2x = 0;
    double pt1y = 0;
    double pt2y = 0;
    int pomz = 0;
    
    //wyświetlanie
    byte buffer[] = new byte[640*480*4]; //tu razy 3? (bo rgb, a nie rgba)
    byte buffer2[] = new byte[640*480*3];
	byte buffer3[] = new byte[640*480*3];
    PixelWriter pixelWriter;
    PixelReader pixelReader;
    PixelFormat<ByteBuffer> pixelFormat;
    Frames frames;//frames
    
    //do wybrania folderu
    String folder = "/images"; //////////////////////////////////////////////////////////////////////////
    DirectoryChooser directoryChooser = new DirectoryChooser();
    ChoiceBox cb = new ChoiceBox(FXCollections.observableArrayList());
    
    //globalne texty
    Text t42 = new Text("");
    Text t52 = new Text("");
    TextArea tf = new TextArea("Wybierz zdjęcie, aby edytować jego opis");
    


    public static void main(String[] args)
    {
        launch(args);
    }


    @Override
    public void start(Stage primaryStage)
    {
        //początkowe
        primstage = primaryStage;
        root = new AnchorPane();
        canvas = new Canvas(FRAME_WIDTH, FRAME_HEIGHT);
        canvas.setLayoutX(20);
        canvas.setLayoutY(50);
        gc = canvas.getGraphicsContext2D();
        primstage.setResizable(false);
        root.getChildren().add(canvas);

        //ustawienia folderu do zapisywania zdjęć
        try { folder = new File(".").getCanonicalPath(); } catch (IOException e) {return;} ///////////////////////////////////////////
        folder = folder+"/images";
        try { Files.createDirectories(Paths.get(folder)); } catch (IOException e) {return;}
        directoryChooser.setInitialDirectory(new File("images"));

        canvas.setOnMousePressed(this::mouse);
		
        //może to do funkcji rt dać? 
        frames = new Frames(); //frames
        int result = frames.open_shm("/frames"); //frames
        

        //start
        ActionEvent starting_event = new ActionEvent();
        rt(starting_event);


        //końcowe
        Scene scene = new Scene(root);
        primstage.setTitle("Mikroskop");
        primstage.setScene( scene );
        primstage.setWidth(FRAME_WIDTH + 300);
        primstage.setHeight(FRAME_HEIGHT+ 200);
        primstage.show();
    }


    //nazwa rt: od ang. real time - czas rzeczywisty
    //(podgląd mikroskopu w czasie rzeczywistym)
    private void rt(ActionEvent e)
    {
        //wyczyść widok
        root.getChildren().clear();
        
        //początkowy widok
        gc.setFill(Color.WHITE);
        gc.fillRect(0, 0,640, 480);
        root.getChildren().add(canvas);

        //widok z mikroskopu
        timeline = new Timeline(new KeyFrame(Duration.millis(200), f->pokazuj_obraz()));
        timeline.setCycleCount(Timeline.INDEFINITE);
        timeline.play();

        //przyciski
        Button btn = new Button();
        btn.setText("Podgląd");
        btn.setOnAction(this::podglad);
        btn.setLayoutX(300);
        btn.setLayoutY(10);
        btn.setMinSize(90,30);

        Button btn2 = new Button();
        btn2.setText("Zrób zdjęcie");
        btn2.setOnAction(this::zrobzdjecie);
        btn2.setLayoutX(750);
        btn2.setLayoutY(70);
        btn2.setMinSize(90,50);

        Button btn3 = new Button();
        btn3.setText("Wybierz folder");
        btn3.setOnAction(this::folder);
        btn3.setLayoutX(750);
        btn3.setLayoutY(150);
        btn3.setMinSize(90,50);

        root.getChildren().add(btn);
        root.getChildren().add(btn2);
        root.getChildren().add(btn3);

        //napis u góry
        Text t = new Text("Widok mikroskopu");
        t.setFont(Font.font ("Helvetica", 24));
        t.setLayoutX(20);
        t.setLayoutY(35);
        root.getChildren().add(t);

	Text t0 = new Text("Kacper Müller, Paweł Żurowski");
        t0.setFont(Font.font ("Verdana", 24));
        t0.setLayoutX(420);
        t0.setLayoutY(30);
        root.getChildren().add(t0);

        //instrukcja
        String instrukcja = "Aby zapisać obecny widok mikroskopu wciśnij przycisk \"Zrób zdjęcie\".\n\nMożesz też wybrać folder, gdzie program ma umieścić zdjęcie (należy to zrobić przed zrobieniem zdjęcia).\n\nPrzycisk \"Podgląd\" przenie- sie Cię do trybu podglądu zdjęć, gdzie masz możli- wość analizy obrazów.";
        Text t2 = new Text(instrukcja);
        t2.setFont(Font.font ("Helvetica", 16));
        t2.setLayoutX(695);
        t2.setLayoutY(260);
        t2.setWrappingWidth(200);
        t2.setTextAlignment(TextAlignment.JUSTIFY);
        root.getChildren().add(t2);
    }
    
    
    //int temporary = 0;
    private void pokazuj_obraz()
    {
        /*
        gc.setFill(Color.RED);
        gc.fillRect(temporary, temporary,10, 10);
        ++temporary;
        */
        
        pixelWriter = gc.getPixelWriter(); //frames do końca w dół
        pixelFormat = PixelFormat.getByteRgbInstance();

        buffer2 = frames.get_frame();  
      
        pixelWriter.setPixels(0, 0, FRAME_WIDTH, FRAME_HEIGHT, pixelFormat, buffer2, 0, FRAME_WIDTH*3);
        
    }
	
	private void mouse(MouseEvent e) {
        if( flaga_zaznacz == 1){ 
            if( pomz == 0 ) {
                pt1x = e.getX();
                pt1y = e.getY();
            } else { 
                pt2x = e.getX();
                pt2y = e.getY();
                gc.setStroke(Color.BLUE);
                gc.strokeRect(Math.min(pt1x, pt2x), Math.min(pt1y, pt2y), Math.abs(pt1x-pt2x), Math.abs(pt1y-pt2y));
            }
            pomz = (pomz+1)%2;
        }
    }

    private void podglad(ActionEvent e)
    {
        //wyczyść widok
        timeline.stop();
        root.getChildren().clear();


        //rysowanie podglądu
        gc.setFill(Color.WHITE);
        gc.fillRect(0, 0,640, 480);
        
        root.getChildren().add(canvas);
        
        
        //pokaż listę zdjęć
        pokaz_liste();


        //przyciski
        Button btnp = new Button();
        btnp.setText("Wróć do widoku mikroskopu");
        btnp.setOnAction(this::rt);
        btnp.setLayoutX(250);
        btnp.setLayoutY(10);
        btnp.setMinSize(150,30);
        root.getChildren().add(btnp);

        Button btn4 = new Button();
        btn4.setText("Wybierz folder ze zdjęciami");
        btn4.setOnAction(this::folder_podglad);
        btn4.setLayoutX(712);
        btn4.setLayoutY(50);
        btn4.setMinSize(150,40);
        root.getChildren().add(btn4);


        Button btn5 = new Button();
        btn5.setText("Zaznacz na zdjęciu");
        btn5.setOnAction(this::zaznacz);
        btn5.setLayoutX(712);
        btn5.setLayoutY(340);
        btn5.setMinSize(150,30);
        root.getChildren().add(btn5);

        Button btn6 = new Button();
        btn6.setText("Porównaj zdjęcia");
        btn6.setOnAction(this::porownaj);
        btn6.setLayoutX(712);
        btn6.setLayoutY(575);
        btn6.setMinSize(150,30);
        root.getChildren().add(btn6);

		Button btn8 = new Button();
        btn8.setText("Dodaj siatkę");
        btn8.setOnAction(this::siatka);
        btn8.setLayoutX(712);
        btn8.setLayoutY(380);
        btn8.setMinSize(150,30);
        root.getChildren().add(btn8);

        Button btn7 = new Button();
        btn7.setText("Zapisz\n opis");
        btn7.setStyle("-fx-font-size:14");
        btn7.setLayoutX(585);
        btn7.setLayoutY(560);
        btn7.setMinSize(60,60);
        btn7.setMaxSize(60,60);
        btn7.setOnAction((event) -> {
            zapisz_opis((String)cb.getValue());
        });
        root.getChildren().add(btn7);


        //tekst u góry
        Text t3 = new Text("Podgląd");
        t3.setFont(Font.font ("Verdana", 24));
        t3.setLayoutX(20);
        t3.setLayoutY(35);
        root.getChildren().add(t3);


        //opis
        tf.setText("Wybierz zdjęcie, aby edytować jego opis");
        if(flaga_podglad==0)
        {
            flaga_podglad=1;
            tf.setText("Wybierz zdjęcie, aby edytować jego opis");
        } else {
            pokaz_zdjecie((String)cb.getValue());
        }
        tf.setLayoutX(20);
        tf.setLayoutY(550);
        tf.setPrefSize(530, 80);
        tf.setWrapText(true);
        root.getChildren().add(tf);


        //czas i kolor dom.
        Text t4 = new Text("Czas wykonania zrzutu:");
        t4.setFont(Font.font ("Verdana", 14));
        t4.setLayoutX(702);
        t4.setLayoutY(445);
        root.getChildren().add(t4);
        t42.setText("");
        t42.setFont(Font.font ("Verdana", 14));
        t42.setLayoutX(710);
        t42.setLayoutY(464);
        root.getChildren().add(t42);

        Text t5 = new Text("Dominujący kolor: ");
        t5.setFont(Font.font ("Verdana", 14));
        t5.setLayoutX(702);
        t5.setLayoutY(493);
        root.getChildren().add(t5);
        t52.setText("kolor dominujący");
        t52.setFont(Font.font ("Verdana", 14));
        t52.setLayoutX(710);
        t52.setLayoutY(512);
        root.getChildren().add(t52);


        //lista zdjęć
        Text t6 = new Text("Wybierz zdjęcie do podglądu:");
        t6.setFont(Font.font ("Verdana", 12));
        t6.setLayoutX(712);
        t6.setLayoutY(130);
        root.getChildren().add(t6);
        
        cb.setLayoutX(702);
        cb.setLayoutY(140);
        cb.setOnAction((event) -> {
            pokaz_zdjecie((String)cb.getValue());
        });
        cb.setPrefWidth(200);
        root.getChildren().add(cb);
    }



    private void zrobzdjecie(ActionEvent e)
    {
        WritableImage image = canvas.snapshot(new SnapshotParameters(), null);
        pixelReader = image.getPixelReader();
        WritablePixelFormat<ByteBuffer> wpixelFormat = PixelFormat.getByteBgraInstance();
	//System.out.println("DLUGOSC BUFFERA:");
	//System.out.println(buffer.length);
        pixelReader.getPixels(0, 0, FRAME_WIDTH, FRAME_HEIGHT, wpixelFormat, buffer, 0, 4*FRAME_WIDTH);
        
        
        String date = new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date());
        
        Zdjecie zdjecie = new Zdjecie(buffer, "/"+date);
        
        
        //serializajca
        try
        {
            FileOutputStream fos = new FileOutputStream(folder+zdjecie.data+".pkm"); //nasze pliki będą z końcówką pkm
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(zdjecie);
            oos.flush();
            oos.close();
        }
        catch (IOException ioe)
        {
            ioe.printStackTrace();
        }
    }

    private void folder(ActionEvent e) ///////////////////////////////////////////////////////////////////////////////
    {
	directoryChooser.setInitialDirectory(new File(folder));
        File fold = directoryChooser.showDialog(primstage);
	if(fold!=null) folder = fold.getAbsolutePath();
    }

    private void folder_podglad(ActionEvent e)
    {
	directoryChooser.setInitialDirectory(new File(folder));
        File fold = directoryChooser.showDialog(primstage);
        if(fold!=null) folder = fold.getAbsolutePath();
        pokaz_liste();
    }

    private void pokaz_liste()
    {
	cb.getItems().clear();
	
        File fold = new File (folder);
	
        File[] lista = fold.listFiles();
        for (int i = 0 ; i < lista.length ; i++) {
            StringTokenizer stringTokenizer = new StringTokenizer( lista[i].getName(), "." );
            String temp = "none";
            while( stringTokenizer.hasMoreTokens() ) {
                temp = stringTokenizer.nextToken();
            }
            if(temp.equals("pkm")){
                cb.getItems().remove(lista[i].getName());
                cb.getItems().add(lista[i].getName());
            }
        }
    }

    private void pokaz_zdjecie(String zdj)
    {
        //kolor dominujący jeszcze
        //deserializacja
        try
        {
            if(zdj!="null" && zdj!=null){
                FileInputStream fil = new FileInputStream(folder+"/"+zdj);
                ObjectInputStream ois = new ObjectInputStream(fil);
                Zdjecie zdjecie = (Zdjecie) ois.readObject();
                ois.close();
                
                String data1 = zdjecie.data;
                data1 = data1.replace('_', ':');
				data1 = data1.replace('/', ' ');
                t42.setText(data1);

		long r = 0;
		long b = 0;
		long g = 0;
		long a = 0;
		for(int i=0; i<640*480; i++) {
			b += Byte.toUnsignedInt( zdjecie.buffer[4*i] );
			g += Byte.toUnsignedInt( zdjecie.buffer[4*i + 1] );
			r += Byte.toUnsignedInt( zdjecie.buffer[4*i + 2] );
		}
		if( r>g && r>b) {
			zdjecie.kolor_dom = "czerwony";// + Long.toString(r) + "\n " + Long.toString(g) + "\n" + Long.toString(b) + "\n " + 
			//Long.toString(a);
		} else if(g>r && g>b) {
			zdjecie.kolor_dom = "zielony";// + Long.toString(r) + "\n " + Long.toString(g) + "\n" + Long.toString(b) + "\n " + 
			//Long.toString(a);
		} else if(b>r && b>g) {
		    zdjecie.kolor_dom = "niebieski";//+ Long.toString(r) + "\n " + Long.toString(g) + "\n" + Long.toString(b) + "\n " +        	
		} else {
		zdjecie.kolor_dom = "mieszany";//+ Long.toString(r) + "\n " + Long.toString(g) + "\n" + Long.toString(b) + "\n " + 
		//Long.toString(a);
		}
		
                t52.setText(zdjecie.kolor_dom);
                tf.setText("");
                tf.setText(zdjecie.opis);
                
                pixelWriter = gc.getPixelWriter();
                pixelFormat = PixelFormat.getByteBgraInstance();
    
                pixelWriter.setPixels(0, 0, FRAME_WIDTH, FRAME_HEIGHT, pixelFormat, zdjecie.buffer, 0, FRAME_WIDTH*4);
            }
        }
        catch (IOException | ClassNotFoundException exc)
        {
            Alert errorAlert = new Alert(AlertType.ERROR);
            errorAlert.setHeaderText("Nieprawidłowy plik");
            errorAlert.setContentText(zdj+" nie jest plikiem .pkm stworzonym przez program");
            errorAlert.showAndWait();
        }
    }

    //jeśli wciśnięty przycisk
    private void zaznacz(ActionEvent e)
    {
        flaga_zaznacz = ( flaga_zaznacz + 1 )%2;
		pomz = 0;
		pt1x = 0;
		pt1y = 0;
		pt2x = 0;
		pt2y = 0;
    }

    //ma otworzyć wybieranie pliku takie windowsowe z folderu
    //po wybraniu otwiera się osobne okno i tam
    //po jednej jest zdjęcie wybrane teraz
    //po drugiej stronie jest zdjęcie z wcześniej, z podglądu
    private void porownaj(ActionEvent e)
    {
        //not implemented
    }


    private void siatka(ActionEvent e)
    {
		for(int i=0; i<11; ++i) {
			gc.setStroke(Color.BLACK);
			gc.strokeLine(64*i, 0, 64*i, 480);
			gc.strokeLine(0, 48*i, 640, 48*i);
		}
    }
    
    private void zapisz_opis(String zdj)
    {
        try
        {
            FileInputStream fil = new FileInputStream(folder+'/'+zdj);
            ObjectInputStream ois = new ObjectInputStream(fil);
            Zdjecie zdjecie = (Zdjecie) ois.readObject();
            ois.close();
            
            zdjecie.opis=tf.getText().replaceAll("\n", System.getProperty("line.separator"));
            
            FileOutputStream fos = new FileOutputStream(folder+'/'+zdjecie.data+".pkm");
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(zdjecie);
            oos.flush();
            oos.close();
        }
        catch (IOException | ClassNotFoundException exc)
        {
            Alert errorAlert = new Alert(AlertType.ERROR);
            errorAlert.setHeaderText("Nieprawidłowy plik");
            errorAlert.setContentText("Wybierz plik .pkm stworzony przez program");
            errorAlert.showAndWait();
        }
    }
}    
