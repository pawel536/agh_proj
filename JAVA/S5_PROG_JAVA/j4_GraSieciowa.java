package com.example.jv4a;

import javafx.application.*;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.shape.Ellipse;
import javafx.scene.shape.Rectangle;
import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import java.io.IOException;
import java.net.*;
import java.util.*;

import javafx.concurrent.*;

import javafx.beans.*;
import javafx.beans.value.*;
import javafx.util.Duration;

//add animation
//add data transmisiion

class P_move {
    int x, y;
    public P_move() {
        x = 10;
        y = 10;
    }
}

class G_task extends Task<P_move> {
    DatagramSocket ds = new DatagramSocket(5253);

    P_move p_move;

    public G_task() throws SocketException {
        this.p_move = new P_move();
        //this.e_move = new P_move();
    }

    @Override
    protected P_move call() throws Exception {
        int i = 0;


        while (true) {
            System.out.println("Task's call method / Enemy Turn");

            updateValue(null);
            updateValue(p_move);//wywolanie powoduje changed

            byte[] buf = new byte[2];
            InetAddress ip = null;
            try {
                ip = InetAddress.getByName("127.0.0.1");
            } catch (UnknownHostException e) {
                e.printStackTrace();
            }
            DatagramPacket dp = new DatagramPacket(buf, 2, ip, 5252);
            try {
                ds.receive(dp);
            } catch (IOException e) {
                e.printStackTrace();
            }

            p_move.x = p_move.x + (int)buf[0];
            p_move.y = p_move.y + (int)buf[1];

            i++;
            if(i==100) {break;}
        }
        return p_move;
    }
}

class Game_service extends Service<P_move> {
    Task t;
    public Game_service() {
    }
    protected Task createTask() {
        try {
            t = new G_task();
        } catch (SocketException e) {
            e.printStackTrace();
        }
        return t;
    }
}

public class JavaFXApp extends Application implements ChangeListener<P_move>  {
    Stage stage;
    Game_service g_s;
    P_move p_pos;
    P_move e_pos;

    Rectangle rec1;
    Rectangle rec2;

    GraphicsContext gc;
    Canvas canvas;
    Timeline timeline;


    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws IOException  {
        DatagramSocket ds = new DatagramSocket(5252);

        AnchorPane root = new AnchorPane();
        primaryStage.setTitle("JavaFX App");

        canvas = new Canvas(960, 600);
        //canvas.setOnMousePressed(this::mouse);
        gc = canvas.getGraphicsContext2D();

        this.p_pos = new P_move();
        this.e_pos = new P_move();

        stage = primaryStage;

        Menu menu1 = new Menu("File");
        MenuItem menuItem1 = new MenuItem("Item 1");
        MenuItem menuItem2 = new MenuItem("Exit");
        menuItem2.setOnAction(e -> {
            System.out.println("Exit Selected");
            exit_dialog();
        });
        menu1.getItems().add(menuItem1);
        menu1.getItems().add(menuItem2);
        MenuBar menuBar = new MenuBar();
        menuBar.getMenus().add(menu1);
        VBox vBox = new VBox(menuBar);

        root.getChildren().add(vBox);
        root.getChildren().add(canvas);
        Scene scene = new Scene(root, 900, 560);
        primaryStage.setScene(scene);
        primaryStage.show();
        timeline = new Timeline(new KeyFrame(Duration.millis(50), e1 -> step()));

        //Group group = new Group();
        rec1 = new Rectangle(p_pos.x, p_pos.y);
        rec1.setX(p_pos.x);
        rec1.setY(p_pos.y);
        rec1.setWidth(10);
        rec1.setHeight(10);
        rec1.setVisible(true);
        rec1.setFill(Color.RED);
        root.getChildren().addAll(rec1);

        rec2 = new Rectangle(e_pos.x, e_pos.y);
        rec2.setX(e_pos.x);
        rec2.setY(e_pos.y);
        rec2.setWidth(10);
        rec2.setHeight(10);
        rec2.setVisible(true);
        rec2.setFill(Color.DARKSEAGREEN);
        root.getChildren().addAll(rec2);

        Ellipse ellipse2 = new Ellipse();
        ellipse2.setCenterX(300.0f);
        ellipse2.setCenterY(170.0f);
        ellipse2.setRadiusX(10.0f);
        ellipse2.setRadiusY(15.0f);
        ellipse2.setFill(Color.BLANCHEDALMOND);
        root.getChildren().addAll(ellipse2);

        Ellipse ell1 = new Ellipse();
        ell1.setCenterX(300.0f);
        ell1.setCenterY(150.0f);
        ell1.setRadiusX(15.0f);
        ell1.setRadiusY(10.0f);
        ell1.setFill(Color.SADDLEBROWN);
        root.getChildren().addAll(ell1);

        primaryStage.setOnCloseRequest(e -> {
            e.consume();
            exit_dialog();
        });

        g_s = new Game_service();
        g_s.valueProperty().addListener(this::changed);
        g_s.start();

        primaryStage.addEventHandler(KeyEvent.KEY_PRESSED,  (event) -> {
            switch(event.getCode().getCode()) {
                case 38 : {
                    p_pos.y -= 10;
                    break;
                }
                case 39 : {
                    p_pos.x += 10;
                    break;
                }
                case 40 : {
                    p_pos.y += 10;
                    rec1.relocate(p_pos.x, p_pos.y);
                    break;
                }
                case 37 : {
                    p_pos.x -= 10;
                    break;
                }
                default:  {
                    //System.out.println("Pressed other key");
                }
            }

            byte[] send = { (byte)(10), (byte)(10) };
            InetAddress ip = null;
            try {
                ip = InetAddress.getByName("127.0.0.1");
            } catch (UnknownHostException e) {
                e.printStackTrace();
            }
            DatagramPacket dp = new DatagramPacket(send, 2, ip, 5253);
            try {
                ds.send(dp);
            } catch (IOException e) {
                e.printStackTrace();
            }
            //ds.close();

            rec1.relocate(p_pos.x, p_pos.y);
            rec2.relocate(e_pos.x, e_pos.y);

        } );
    }

    private void step() {
        gc.setFill(Color.YELLOW);
        gc.fillRect( p_pos.x, p_pos.y, 30, 30);

        gc.setFill(Color.RED);
        gc.fillRect( e_pos.x, e_pos.y, 30, 30);

    }

    public void changed(ObservableValue<? extends P_move> observable, P_move oldValue, P_move newValue) {
        if (newValue != null) {
            System.out.println("Enemy pos: x = " + newValue.x + ", y = " + newValue.y);
            e_pos.x = newValue.x;
            e_pos.y = newValue.y;
        }
    }

    private void play(ActionEvent e) {
        timeline.setCycleCount(Timeline.INDEFINITE);
        timeline.play();
    }

    public void item_1() {
        System.out.println("item 1");
    }

    public void exit_dialog() {
        System.out.println("exit dialog");

        Alert alert = new Alert(AlertType.CONFIRMATION,
                "Do you really want to exit the program?.",
                ButtonType.YES, ButtonType.NO);

        alert.setResizable(true);
        alert.onShownProperty().addListener(e -> {
            Platform.runLater(() -> alert.setResizable(false));
        });

        Optional<ButtonType> result = alert.showAndWait();
        if (result.get() == ButtonType.YES) {
            Platform.exit();
        } else {
        }

    }
}
//System.out.println("Your pos: x = " + p_pos.x + ", y = " + p_pos.y);

//byte[] buf = new byte[2];
//byte[] send = { (byte)(e_pos.x/10), (byte)(e_pos.y/10) };
//DatagramPacket dp = new DatagramPacket(buf, 2);
//try {
//ds.receive(dp);
//} catch (IOException e) {
//e.printStackTrace();
//}
//DatagramPacket senddp = new DatagramPacket(send, 2, dp.getAddress(), dp.getPort());
//try {
//ds.send(senddp);
//} catch (IOException e) {
//e.printStackTrace();
//}
