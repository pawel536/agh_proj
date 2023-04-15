package com.example.jv3a;

import java.io.*;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.util.*;

class Handler_1 extends DefaultHandler {
    String loc_name;

    boolean bGrayTempl = false;
    boolean bBlackTempl = false;
    //boolean bNickName = false;
    //boolean bMarks = false;


    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        //wylapywanie kiedy skala-szkic kidy las kiedy skala
        //zapis wartosci-skala
        //przywrocic pisanie
        //malowanie

        System.out.println("Start Element :"  + qName);

        for (int i = 0; i < attributes.getLength(); i++) {
            loc_name = attributes.getQName(i);
            System.out.println("---" + i + "---attr name: " + loc_name + "\n" + attributes.getValue(loc_name));
            //if(loc_name.equals("stroke-width")) {continue;}
            //if(loc_name.equals("stroke-dasharray")) {continue;}
            //if(loc_name.equals("transform")) {continue;}

            if(qName.equalsIgnoreCase("symbol") && loc_name.equalsIgnoreCase("id")) {
                System.out.println( "---->" + attributes.getValue(loc_name) );
                //if( )
            }


            if(qName.equalsIgnoreCase("path") && loc_name.equalsIgnoreCase("d")) {
                StringTokenizer st1 = new StringTokenizer(attributes.getValue(loc_name), " ");
                double X = 0;
                double Y = 0;
                while (st1.hasMoreTokens()) {
                    String st2 = st1.nextToken();
                    if (st2.charAt(0) == 'M') {
                        X = 0;
                        Y = 0;
                        st2 = st1.nextToken();
                        String[] st4 = st2.split(",");
                        X += Double.parseDouble(st4[0]);
                        Y += Double.parseDouble(st4[1]);
                    } else if (st2.charAt(0) == 'l') {
                        String st3 = new String(st2.substring(1));
                        String[] st4 = st3.split(",");
                        X += Double.parseDouble(st4[0]);
                        Y += Double.parseDouble(st4[1]);
                    } else if (Character.isDigit(st2.charAt(0)) || st2.charAt(0) == '-') {
                        String[] st4 = st2.split(",");
                        X += Double.parseDouble(st4[0]);
                        Y += Double.parseDouble(st4[1]);
                    } else if (st2.charAt(0) == 'z') {
                        return;
                    } else if (st2.charAt(0) == 'a') {
                        return;
                    }
                    //try {
                    //    SaveToFile( Double.toString(X) + "," + Double.toString(Y) );
                    //} catch (IOException e) {
                    //    e.printStackTrace();
                    //}
                    System.out.println(X + "," + Y);
                }
            }
        }
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (qName.equalsIgnoreCase("svg")) {
            System.out.println("End Element :" + qName);
        }
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        System.out.println(new String(ch, start, length));
    }

    public void SaveToFile(String s) throws IOException {
        FileWriter fw = null;
        try {
            fw = new FileWriter("../jv3b_mp/ala.txt", true);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(s);
            bw.newLine();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fw != null) {
                fw.close();
            }
        }
    }
}

public class Parser_1 {
    public static void main(String[] args) {

        try {
            File inputFile = new File("points.xml");
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser saxParser = factory.newSAXParser();

            Handler_1 handler_1 = new Handler_1();

            saxParser.parse(inputFile, handler_1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class BlackRock {
    double[] pointsx = {};
    double[] pointsy = {};
    double translatex = 0;
    double translatey = 0;
    double scalex = 1;
    double scaley = 1;
}

class GrayRock {
    double[] pointsx = {};
    double[] pointsy = {};
    double translatex = 0;
    double translatey = 0;
    double scalex = 1;
    double scaley = 1;
}

class BlackRockTempl {
    double[] pointsx = {};
    double[] pointsy = {};
}

class GrayRockTempl {
    double[] pointsx = {};
    double[] pointsy = {};
}

//if (qName.equalsIgnoreCase("svg")) {return;}
//if (qName.equalsIgnoreCase("circle")) {return;}
//if (qName.equalsIgnoreCase("image")) {return;}
//if (qName.equalsIgnoreCase("g")) {return;}
//if (qName.equalsIgnoreCase("use")) {return;}
//if (qName.equalsIgnoreCase("text")) {return;}
