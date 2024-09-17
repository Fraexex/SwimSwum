-- tile_renderer.vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tile_renderer is
    port (
        clk : in std_logic;                       -- Clock signal
        reset : in std_logic;                     -- Reset signal
        tile_map : in std_logic_vector(15 downto 0); -- Input tile map (for simplicity, a 16x16 map)
        tile_data : out std_logic_vector(15 downto 0); -- Output tile data
        vga_x : in std_logic_vector(9 downto 0); -- VGA x-coordinate
        vga_y : in std_logic_vector(9 downto 0); -- VGA y-coordinate
        pixel_out : out std_logic                 -- Pixel output for the VGA display
    );
end entity tile_renderer;

architecture behavioral of tile_renderer is
    signal tile_index : std_logic_vector(7 downto 0);
    signal tile_pixel : std_logic_vector(15 downto 0);
    signal tile_addr : std_logic_vector(7 downto 0);
begin
    -- Compute the tile index based on VGA coordinates
    tile_addr <= vga_x(9 downto 4) + 16 * vga_y(9 downto 4);

    process (clk)
    begin
        if rising_edge(clk) then
            -- Read the tile data from memory
            tile_pixel <= tile_memory(tile_addr);
            -- Output the pixel data for the current position
            pixel_out <= tile_pixel(to_integer(unsigned(vga_x(3 downto 0))) + 16 * to_integer(unsigned(vga_y(3 downto 0))));
        end if;
    end process;
end architecture behavioral;
