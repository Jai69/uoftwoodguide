package digitalwoodguide;
import java.util.*;
import javax.imageio.ImageIO;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.*;

public class Tree 
{

	private String type, genus, species, family, comName, location, collector, contributor, dateCreated, dateMod; 
	private ArrayList<String> notes = new ArrayList();
	private int catNum;

	/**
	 * Loads the image file from URL fileLocation provided as an parameter
	 * @param imageLocation
	 */
	public void setImage(String imageLocation)
	{
		//retrieve the image from a file
		BufferedImage img = null;
		try
		{
			img = ImageIO.read(new File(imageLocation));

		}catch(IOException e){}		
		
	}
	
	public void setGenus(String name)
	{
		genus = name; 
	}
	public String getGenus()
	{
		return genus;
	}
	public void setSpecies(String name)
	{
		species = name;
	}
	public String getSpecies()
	{
		return species;
	}
	
	public void setType(String woodType)
	{
		type = woodType;
	}
	public String getType()
	{
		return type;
	}
	public void setFamily(String name)
	{
		family = name;
	}
	
	public void setComNam(String name)
	{
		comName = name;
	}
	public String getComNam()
	{
		return comName;
	}
	public String getFamily()
	{
		return family;
	}
	public void setLocation(String country, String city)
	{
		location = country + ", " + city;
	}
	public String getLocation()
	{
		return location;
	}
	public void setCollector(String name)
	{
		collector = name;
	}
	public String getCollector()
	{
		return collector;
	}
	public void setContributor(String name)
	{
		contributor = name;
	}
	public String getContributor()
	{
		return contributor;
	}
	public void addNote(String note)
	{
		notes.add(note);
	}	
	public ArrayList getNotes()
	{
		return notes;
	}
	public void setCatNum(int num)
	{
		catNum = num;
	}
	public int getCatNum()
	{
		return catNum;
	}
	public void detailDescription()
	{
		System.out.println("Catalog Number: " + getCatNum());
		System.out.println("Common Name: " + getComNam());
		System.out.println("Species: " + getSpecies());
		System.out.println("Family: " + getFamily());
		System.out.println("Notes: "+ getNotes());
	}
}
