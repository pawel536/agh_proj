package com.example.demo;
// ctrl + alt + l
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.shape.Circle;
import javafx.scene.paint.Color;
import javafx.scene.control.*;
import javafx.scene.chart.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;
import javafx.geometry.Pos;

import java.lang.Math.*;

public class Chart_1 extends Application {
    TextField t1, t2, t3;
    LineChart l;
    NumberAxis ax1, ax2;
    XYChart.Series<Double, Double> series;

    @Override

    public void start(Stage primaryStage) throws Exception {
        AnchorPane ap = new AnchorPane();

        Label l1, l2, l3;

        Button action = new Button("Display");

        action.setOnAction(this::display);

        VBox parameters = new VBox();
        parameters.setSpacing(5.0d);
        parameters.setAlignment(Pos.TOP_LEFT);

        HBox line_1, line_2, line_3;

        line_1 = new HBox();
        line_1.setSpacing(4.0d);

        l1 = new Label("a:");
        t1 = new TextField("0.0");

        line_1.getChildren().addAll(l1, t1);

        line_2 = new HBox();
        line_2.setSpacing(4.0d);

        l2 = new Label("b:");
        t2 = new TextField("0.0");

        line_2.getChildren().addAll(l2, t2);

        line_3 = new HBox();
        line_3.setSpacing(4.0d);

        l3 = new Label("c:");
        t3 = new TextField("0.0");

        line_3.getChildren().addAll(l3, t3);

        parameters.getChildren().addAll(line_1, line_2, line_3, action);

        ap.getChildren().add(parameters);

        // to mozna zmieniac
        ax1 = new NumberAxis("X", 0.0, 5.0, 1);
        ax2 = new NumberAxis("Y", 0.0, 5.0, 1);
        l = new LineChart<>(ax1, ax2);

        //l = new LineChart(new NumberAxis("X", 0.0, 5.0, 0.5), new NumberAxis("Y", 0.0, 5.0, 0.5));

        l.setLegendVisible(false);
        l.setCreateSymbols(false);

        series = new XYChart.Series<>();

        //series.getData().add( new XYChart.Data<>(0.0,0.0));
        //series.getData().add( new XYChart.Data<>(0.3,0.6));
        //series.getData().add( new XYChart.Data<>(0.7,0.8));

        l.getData().add(series);


        l.setTitle("Some function");
        l.setStyle("-fx-background-color: white");
        ap.getChildren().add(l);
        AnchorPane.setTopAnchor(l, 120.0d);
        AnchorPane.setBottomAnchor(l, 40.0d);
        AnchorPane.setRightAnchor(l, 10.0d);
        AnchorPane.setLeftAnchor(l, 10.0d);
        Scene scene = new Scene(ap);
        primaryStage.setTitle("Simple chart plotting");
        primaryStage.setScene(scene);
        primaryStage.setWidth(568);
        primaryStage.setHeight(420);
        primaryStage.show();
    }

    private void display(ActionEvent e) {
        System.out.println("Display pressed");

        System.out.println("a=" + t1.getText());
        System.out.println("b=" + t2.getText());
        System.out.println("c=" + t3.getText());

        double a = Double.parseDouble(t1.getText());
        double b = Double.parseDouble(t2.getText());
        double c = Double.parseDouble(t3.getText());
        double xw = 0;
        double pomx = 0;
        double ddelta = delta(a, b, c);

        if (a == 0.0) {
            ax1.setLowerBound(-5);
            ax1.setUpperBound(5);
            ax2.setLowerBound(c - 5);
            ax2.setUpperBound(c + 5);
        } else {
            xw = (-b / (2 * a));
            double yw = -ddelta / (4 * a);
            ax1.setLowerBound(xw - 5);
            ax1.setUpperBound(xw + 5);
            if (a > 0) {
                ax2.setLowerBound(yw);
                ax2.setUpperBound(yw + 10);
            } else {
                ax2.setLowerBound(yw - 10);
                ax2.setUpperBound(yw);
            }
        }

        //series.getData().remove(0,2);

        double stepx = 0.1;
        pomx = xw-5;

        series.getData().clear();
        //series.getData().removeAll();
        //series.getData().remove(0,);

        for (int i = 0; i <= 100; i++) {
            pomx += stepx;
            series.getData().add(new XYChart.Data<>(pomx, a * pomx * pomx + b * pomx + c));
        }
    }

    public double delta(double g, double h, double i) {
        return h * h - 4 * g * i;
    }

    public static void main(String[] args) {
        launch(args);
    }
}


