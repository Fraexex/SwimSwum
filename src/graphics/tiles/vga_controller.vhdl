-- vga_controller.vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_controller is
    port (
        clk : in std_logic;                   -- Clock signal
        reset : in std_logic;                 -- Reset signal
        hsync : out std_logic;                -- Horizontal sync pulse
        vsync : out std_logic;                -- Vertical sync pulse
        rgb : out std_logic_vector(3 downto 0); -- RGB output for color display
        x : out std_logic_vector(9 downto 0); -- Current x coordinate
        y : out std_logic_vector(9 downto 0)  -- Current y coordinate
    );
end entity vga_controller;

architecture behavioral of vga_controller is
    signal h_count : integer range 0 to 799 := 0;
    signal v_count : integer range 0 to 524 := 0;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                h_count <= 0;
                v_count <= 0;
            else
                if h_count = 799 then
                    h_count <= 0;
                    if v_count = 524 then
                        v_count <= 0;
                    else
                        v_count <= v_count + 1;
                    end if;
                else
                    h_count <= h_count + 1;
                end if;
            end if;
        end if;
    end process;

    hsync <= '0' when h_count < 96 else '1';
    vsync <= '0' when v_count < 2 else '1';

    x <= std_logic_vector(to_unsigned(h_count, 10));
    y <= std_logic_vector(to_unsigned(v_count, 10));

    -- Output color based on the current position
    rgb <= "0000"; -- For simplicity, output a single color or modify based on tile data

end architecture behavioral;
