{
  description = ''Pleasant Nim bindings for SIMD instruction sets.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimsimd-0_4_8.flake = false;
  inputs.src-nimsimd-0_4_8.ref   = "refs/tags/0.4.8";
  inputs.src-nimsimd-0_4_8.owner = "guzba";
  inputs.src-nimsimd-0_4_8.repo  = "nimsimd";
  inputs.src-nimsimd-0_4_8.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimsimd-0_4_8"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimsimd-0_4_8";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}