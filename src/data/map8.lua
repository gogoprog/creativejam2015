return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.11.0",
  orientation = "orthogonal",
  width = 8,
  height = 8,
  tilewidth = 96,
  tileheight = 96,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 96,
      tileheight = 96,
      spacing = 0,
      margin = 0,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tiles = {
        {
          id = 0,
          image = "start.png",
          width = 96,
          height = 96
        },
        {
          id = 1,
          image = "end.png",
          width = 96,
          height = 96
        },
        {
          id = 2,
          image = "obstacle.png",
          width = 96,
          height = 96
        },
        {
          id = 3,
          image = "bonus.png",
          width = 96,
          height = 96
        },
        {
          id = 4,
          image = "insect.png",
          width = 96,
          height = 96
        },
        {
          id = 5,
          image = "polution.png",
          width = 96,
          height = 96
        },
        {
          id = 6,
          image = "rock1.png",
          width = 96,
          height = 96
        },
        {
          id = 7,
          image = "rock2.png",
          width = 96,
          height = 96
        },
        {
          id = 8,
          image = "rock3.png",
          width = 96,
          height = 96
        },
        {
          id = 9,
          image = "rock4.png",
          width = 96,
          height = 96
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 8,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        3, 3, 3, 0, 0, 0, 2, 3,
        3, 3, 3, 0, 3, 3, 3, 3,
        3, 0, 0, 0, 3, 3, 3, 3,
        0, 0, 0, 3, 3, 3, 3, 3,
        0, 0, 8, 4, 0, 0, 0, 3,
        0, 4, 9, 10, 0, 9, 0, 0,
        0, 10, 7, 0, 0, 3, 3, 0,
        0, 0, 0, 0, 5, 0, 3, 1
      }
    }
  }
}
