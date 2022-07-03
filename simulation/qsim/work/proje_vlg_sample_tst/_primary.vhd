library verilog;
use verilog.vl_types.all;
entity proje_vlg_sample_tst is
    port(
        bin0            : in     vl_logic;
        bin1            : in     vl_logic;
        clk             : in     vl_logic;
        start           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end proje_vlg_sample_tst;
