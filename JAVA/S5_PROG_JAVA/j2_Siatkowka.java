package com.example.jv2a;

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
import javafx.scene.paint.Color;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.util.Duration;


public class Simple_game_2 extends Application implements ChangeListener<Number> {
    private static final int FRAME_WIDTH = 640;
    private static final int FRAME_HEIGHT = 480;

    int x, y;
    double t;

    GraphicsContext gc;
    Canvas canvas;
    Slider alpha, v;

    Ball bl;
    Timeline timeline;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        AnchorPane root = new AnchorPane();
        primaryStage.setTitle("Volleyball");

        canvas = new Canvas(FRAME_WIDTH, FRAME_HEIGHT);
        canvas.setOnMousePressed(this::mouse);

        gc = canvas.getGraphicsContext2D();

        x = 10;
        y = 10;
        t = 0;

        root.getChildren().add(canvas);

        Button btn = new Button();
        btn.setText("Play");
        btn.setOnAction(this::play);

        root.getChildren().add(btn);
        AnchorPane.setBottomAnchor(btn, 5.0d);


        Slider alpha, v;

        alpha = new Slider(30, 80, 5);
        alpha.setShowTickMarks(true);
        alpha.setShowTickLabels(true);
        alpha.valueProperty().addListener(new ChangeListener<Number>() {
            public void changed(ObservableValue<? extends Number> ov, Number old_val, Number new_val) {
                System.out.println("alpha=" + new_val);
                bl.setalpha( (double)new_val );
            }
        });


        root.getChildren().add(alpha);

        AnchorPane.setBottomAnchor(alpha, 2.0d);
        AnchorPane.setLeftAnchor(alpha, 150.0d);


        v = new Slider(10, 100, 10);
        v.setShowTickMarks(true);
        v.setShowTickLabels(true);
        v.valueProperty().addListener(this::changed);

        root.getChildren().add(v);

        AnchorPane.setBottomAnchor(v, 2.0d);
        AnchorPane.setLeftAnchor(v, 300.0d);

        Scene scene = new Scene(root);
        primaryStage.setTitle("Volleybal");
        primaryStage.setScene(scene);
        primaryStage.setWidth(FRAME_WIDTH + 10);
        primaryStage.setHeight(FRAME_HEIGHT + 80);
        primaryStage.show();

        bl = new Ball( 40, 370, 10, 30, 40 , 370 );
        timeline = new Timeline(new KeyFrame(Duration.millis(50), e1 -> step()));
    }

    public void changed(ObservableValue<? extends Number> ov, Number old_val, Number new_val) {
        System.out.println("v=" + new_val);
        bl.setv0( (Double) new_val);
    }

    private void step() {
        gc.clearRect(0,0,canvas.getWidth(), canvas.getHeight());

        gc.setStroke(Color.RED);
        gc.setLineWidth(5);
        gc.strokeLine(50, 400, 590, 400);
        gc.strokeLine(320, 400, 320, 280);

        gc.setFill(Color.YELLOW);
        gc.fillOval( bl.getx(), bl.gety(), 30, 30);

        double x2 = bl.getstartx() + bl.getv0() * Math.cos( bl.getalpha() ) * t;
        if( x2 > 680 ) { timeline.stop(); }
        double y2 = bl.getstarty() - bl.getv0() * Math.cos( bl.getalpha() ) * t + 5*t*t;
        if( y2 > 400 ) { timeline.stop(); }
        if( Math.abs( x2 - 320 ) < 30 && y2 > 280 ) { timeline.stop(); }
        bl.setx( x2 );
        bl.sety( y2 );

        t += 0.2;
    }

    private void mouse(MouseEvent e) {
        System.out.println("X=" + e.getX());
        System.out.println("Y=" + e.getY());
        bl.setxstart( e.getX() );
        bl.setystart( e.getY() );
    }

    private void play(ActionEvent e) {
        t = 0;

        timeline.setCycleCount(Timeline.INDEFINITE);
        //timeline.setCycleCount(100);
        timeline.play();
    }
}

class Ball {
    public Ball( double xs, double ys, double v0x, double al, double xx, double yy )
    {
        // t eksperymrntalnie
        setxstart( xs );
        setystart( ys );
        setv0( v0x );
        setalpha( al );
    }

    double xstart;
    double ystart;
    double v0;
    double alpha;
    double x;
    double y;

    public void setxstart( double xs )
    {
        xstart = xs;
        setx( xs );
    }
    public void setystart( double ys )
    {
        ystart = ys;
        sety( ys );
    }
    public void setv0( double vst )
    {
        v0 = vst;
    }
    public void setalpha( double al )
    {
        alpha = Math.toRadians( al );
    }
    public void setx( double xx )
    {
        x = xx;
    }
    public void sety( double yy )
    {
        y = yy;
    }
    public double getstartx()
    {
        return xstart;
    }
    public double getstarty()
    {
        return ystart;
    }
    public double getv0()
    {
        return v0;
    }
    public double getalpha()
    {
        return alpha;
    }
    public double getx()
    {
        return x;
    }
    public double gety()
    {
        return y;
    }
}

//System.out.println("step");
//gc.fillRect(x, y, 100, 100);

//gc.setFill(Color.RED);
//gc.setStroke(Color.RED);
//gc.setLineWidth(5);
//gc.strokeLine(40, 10, 10, 40);