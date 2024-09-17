-- tile_memory.vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tile_memory is
    port (
        address : in std_logic_vector(7 downto 0); -- Address to read from memory
        data : out std_logic_vector(15 downto 0)  -- Data read from memory
    );
end entity tile_memory;

architecture behavioral of tile_memory is
    -- Define a type for the ROM
    type tile_rom_type is array (0 to 255) of std_logic_vector(15 downto 0);

    -- Initialize ROM with tile data (example data, actual data needed)
    constant tile_rom : tile_rom_type := (
        -- Example tile data, replace with actual pixel data
        x"0000", x"FFFF", x"FF00", x"00FF", -- tile 0, 1, 2, 3, etc.
        others => x"0000"  -- Initialize remaining tiles with black or transparent
    );
begin
    process (address)
    begin
        -- Read the tile data based on the address
        data <= tile_rom(to_integer(unsigned(address)));
    end process;
end architecture behavioral;
