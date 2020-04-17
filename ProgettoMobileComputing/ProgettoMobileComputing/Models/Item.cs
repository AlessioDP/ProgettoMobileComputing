using System;

namespace ProgettoMobileComputing.Models
{
    public class Group
    {
        public string Name { get; set; }
    }

    public class Position
    {
     /*   public Position(String home, string room, Group group)
        {
            this.Home = home;
            this.Room = room;
           // this.Group = group;
        }*/
    
        public string Home { get; set; }
        public string Room { get; set; }
        public Group Group { get; set; }
        public string Text => this.Home + " > " + this.Room + " > " + Group.Name;
    }

    public class Item
    {
        public string Id { get; set; }
        public string Text { get; set; }
        public string Description { get; set; }
        public Position Position { get; set; }
    }
}