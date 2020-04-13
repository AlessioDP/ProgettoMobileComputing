using System;

namespace ProgettoMobileComputing.Models
{

    public class Group
    {
        public string Name { get; set; }

    }

    public class Position
    {
        public string Home { get; set; }
        public string Room { get; set; }
        public Group Group { get; set; }

        public string Text
        {
            get
            {
                return this.Home + " > " + this.Room + " > " + Group.Name;
            }
        }

    }

    


    public class Item
    {
        public string Id { get; set; }
        public string Text { get; set; }
        public string Description { get; set; }
        public Position Position { get; set; }

    }
}