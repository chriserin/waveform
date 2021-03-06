%Waveform.Synth.Def{
  synthdefs: [
    %Waveform.Synth.Def.Synth{
      name: "env3",
      constants: [
        # 0
        550.0,
        # 1
        7.0,
        # 2
        1.0,
        # 3
        0.0,
        # 4
        8.0,
        # 5
        11.0,
        # 6
        3.0,
        # 7
        -99.0,
        # 8
        12.0,
        # 9
        21.0,
        # 10
        4.0,
        # 11
        13.0,
        # 12
        22.0,
        # 13
        14.0,
        # 14
        23.0,
        # 15
        999.0
      ],
      param_values: [],
      param_names: [],
      ugens: [
        %Waveform.Synth.Def.Ugen{
          name: "SinOsc",
          rate: 2,
          special: 0,
          inputs: [
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              constant_index: 0
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              constant_index: 1
            }
          ],
          outputs: [
            2
          ]
        },
        %Waveform.Synth.Def.Ugen{
          name: "EnvGen",
          rate: 1,
          special: 0,
          inputs: [
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 1
              constant_index: 2
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 1
              constant_index: 2
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 0
              constant_index: 3
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 1
              constant_index: 2
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 8
              constant_index: 4
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 11
              constant_index: 5
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 3
              constant_index: 6
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # -99
              constant_index: 7
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # -99
              constant_index: 7
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 12
              constant_index: 8
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 21
              constant_index: 9
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 4
              constant_index: 10
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 0
              constant_index: 3
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 13
              constant_index: 11
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 22
              constant_index: 12
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 4
              constant_index: 10
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 0
              constant_index: 3
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 14
              constant_index: 13
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 23
              constant_index: 14
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 4
              constant_index: 10
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              # 0
              constant_index: 3
            }
          ],
          outputs: [
            1
          ]
        },
        %Waveform.Synth.Def.Ugen{
          name: "BinaryOpUGen",
          rate: 2,
          special: 2,
          inputs: [
            %Waveform.Synth.Def.Ugen.Input{
              src: 0,
              constant_index: 0
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: 1,
              constant_index: 0
            }
          ],
          outputs: [
            2
          ]
        },
        %Waveform.Synth.Def.Ugen{
          name: "Out",
          rate: 2,
          special: 0,
          inputs: [
            %Waveform.Synth.Def.Ugen.Input{
              src: -1,
              constant_index: 15
            },
            %Waveform.Synth.Def.Ugen.Input{
              src: 2,
              constant_index: 0
            }
          ],
          outputs: []
        }
      ],
      variants: []
    }
  ]
}
