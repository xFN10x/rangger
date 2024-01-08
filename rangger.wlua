local ui = require("ui")
local sys = require("sys")
local console = require("console")
-- Basic Setup
console.stdout:writeln("\nrangger (Ranger) 1.0- Range Compressing softwave.----------------------------------------------------------------")
console.stdout:writeln("Copyright © 2024 FN10\n")
local win = ui.Window("Ranger 1.0","fixed",200,300)
win:show()
local tabs = ui.Tab(win,{"Single Mode","Batch Mode"},0,0,210,300)
local comingsoon = ui.Label(tabs.items[2],"Coming Soon!",65,130)
--Important Varibles
smbeforeimg = ui.Picture(tabs.items[1],"img/none.png",9,70,182,36)
smafterimg = ui.Picture(tabs.items[1],"img/none.png",9,150,182,36)
smimagewin = ui.Window("Full Images","single",910,400)
smfullbeforeimg = ui.Picture(smimagewin,"img/none.png",0,9,910,180)
smfullafterimg = ui.Picture(smimagewin,"img/none.png",0,198,910,180)
--Functions
local function CompressFile(File)
  if File == nil then
    error("No File")
  end
  local progresswin = ui.Window("Compressing file...",300,100)
  win:showmodal(progresswin)
  local progressbar = ui.Progressbar(progresswin,9,20,280,30)
  local filename = ui.Label(progresswin,"Range Compressing file "..File.name.."...",9,2)
  local workingfolder = sys.tempdir("rgr")
  print(workingfolder.fullpath)
  sys.File("compresstools//ffmpeg.exe"):copy(workingfolder.fullpath.."/ffmpeg.exe")
  progressbar:advance(20)
  local newbat = sys.File("compresstools//compress.bat"):copy(workingfolder.fullpath.."/compress.bat")
  progressbar:advance(20)
  File:copy(workingfolder.fullpath.."/in"..File.extension)
  progressbar:advance(20)
  newbat:open("write")
 print( newbat:write('\ncd '..workingfolder.fullpath..'\nffmpeg -i in'..File.extension..' -filter_complex ""aformat=channel_layouts=mono,showwavespic=s=910x180"" -frames:v 1 before.png\nffmpeg -i in'..File.extension..' -filter_complex "compand=attacks=0:points=-80/-900|-45/-15|-27/-9|0/-7|20/-7:gain=5" out'..File.extension..'\nffmpeg -i out'..File.extension..' -filter_complex ""aformat=channel_layouts=mono,showwavespic=s=910x180"" -frames:v 1 after.png'))
  newbat:flush()
  progressbar:advance(20)
  local cmd = sys.cmd(workingfolder.fullpath..'/'.."compress.bat")
  if cmd then
    print(cmd)
    progressbar:advance(10)
    sleep(1000)
    print(sys.File("out/"..File.name).exists)
    if sys.File("out/"..File.name).exists == false then
      outputfile = sys.File(workingfolder.fullpath..'/'.."out"..File.extension):copy("out/"..File.name)
      if outputfile == nil then
        print("out/"..File.name)
        print(sys.currentdir)
        ui.error("Failed to range compress. (failed to copy to file:ec2)")
        workingfolder:removeall()
        win:hide()
      else
        smbeforeimg:load(workingfolder.fullpath..'/'.."before.png")
        smafterimg:load(workingfolder.fullpath..'/'.."after.png")
        smbeforeimg.width = 182
        smbeforeimg.height = 36
        smafterimg.width = 182
        smafterimg.height = 36
        progressbar:advance(20)
        smfullbeforeimg:load(workingfolder.fullpath..'/'.."before.png")
        smfullafterimg:load(workingfolder.fullpath..'/'.."after.png")
        ui.info("Operiation Done")
        progresswin:hide()
        if ui.confirm("Do you want to listen to the outputed file?") == "yes" then
          sys.cmd('"'..outputfile.fullpath..'"')
        end
        workingfolder:removeall()
      end
    else
      ui.error('File is already converted. (cant copy file cause a file with the same name is in the out folder {'..tostring(sys.File("out/"..File.name).exists)..'} ec:3)')
      workingfolder:removeall()
      win:hide()
    end
  else
    ui.error("Failed to range compress. (failed to use console:ec1)")
    workingfolder:removeall()
    win:hide()
  end
end

-- Single mode menu items
local smfilebutton = ui.Button(tabs.items[1],"Add File",9,9,182,40)
local smcompressbutton = ui.Button(tabs.items[1],"Compress file",9,189,182,80)
local smfiletext = ui.Label(tabs.items[1],"No File Selected",9,50)
local smimgfullbutton = ui.Button(tabs.items[1],"Fullscreen",9,115)
smimgfullbutton:loadicon("img/full.ico")
smfiletext:show()
--Single mode functions
function smfilebutton.onClick()
  smfile = ui.opendialog("Open Audio File...",false,
  "Audio Files|*.4gv*.8svx_exp*.8svx_fib;*.aac;*.aac_latm;*.ac3;*.ac4;*.acelp.kelvin;*.adpcm_4xm;*.adpcm_adx;*.adpcm_afc;*.adpcm_agm;*.adpcm_aica;*.adpcm_argo;*.adpcm_ct;*.adpcm_dtk;*.adpcm_ea;*.adpcm_ea_maxis_xa;*.adpcm_ea_r1;*.adpcm_ea_r2;*.adpcm_ea_r3;*.adpcm_ea_xas;*.adpcm_g722;*.adpcm_g726;*.adpcm_g726le;*.adpcm_ima_acorn;*.adpcm_ima_alp;*.adpcm_ima_amv;*.adpcm_ima_apc;*.adpcm_ima_apm;*.adpcm_ima_cunning;*.adpcm_ima_dat4;*.adpcm_ima_dk3;*.adpcm_ima_dk4;*.adpcm_ima_ea_eacs;*.adpcm_ima_ea_sead;*.adpcm_ima_iss;*.adpcm_ima_moflex;*.adpcm_ima_mtf;*.adpcm_ima_oki;*.adpcm_ima_qt;*.adpcm_ima_rad;*.adpcm_ima_smjpeg;*.adpcm_ima_ssi;*.adpcm_ima_wav;*.adpcm_ima_ws;*.adpcm_ms;*.adpcm_mtaf;*.adpcm_psx;*.adpcm_sbpro_2;*.adpcm_sbpro_3;*.adpcm_sbpro_4;*.adpcm_swf;*.adpcm_thp;*.adpcm_thp_le;*.adpcm_vima;*.adpcm_xa;*.adpcm_xmd;*.adpcm_yamaha;*.adpcm_zork;*.alac;*.amr_nb;*.amr_wb;*.anull;*.apac;*.ape;*.aptx;*.aptx_hd;*.atrac1;*.atrac3;*.atrac3al;*.atrac3p;*.atrac3pal;*.atrac9;*.avc;*.binkaudio_dct;*.binkaudio_rdft;*.bmv_audio;*.bonk;*.cbd2_dpcm;*.celt;*.codec2;*.comfortnoise;*.cook;*.derf_dpcm;*.dfpwm;*.dolby_e;*.dsd_lsbf;*.dsd_lsbf_planar;*.dsd_msbf;*.dsd_msbf_planar;*.dsicinaudio;*.dss_sp;*.dst;*.dts;*.dvaudio;*.eac3;*.evrc;*.fastaudio;*.flac;*.ftr;*.g723_1;*.g729;*.gremlin_dpcm;*.gsm;*.gsm_ms;*.hca;*.hcom;*.iac;*.ilbc;*.imc;*.interplay_dpcm;*.interplayacm;*.mace3;*.mace6;*.metasound;*.misc4;*.mlp;*.mp1;*.mp2;*.mp3;*.mp3adu;*.mp3on4;*.mp4als;*.mpegh_3d_audio;*.msnsiren;*.musepack7;*.musepack8;*.nellymoser;*.opus;*.osq;*.paf_audio;*.pcm_alaw;*.pcm_bluray;*.pcm_dvd;*.pcm_f16le;*.pcm_f24le;*.pcm_f32be;*.pcm_f32le;*.pcm_f64be;*.pcm_f64le;*.pcm_lxf;*.pcm_mulaw;*.pcm_s16be;*.pcm_s16be_planar;*.pcm_s16le;*.pcm_s16le_planar;*.pcm_s24be;*.pcm_s24daud;*.pcm_s24le;*.pcm_s24le_planar;*.pcm_s32be;*.pcm_s32le;*.pcm_s32le_planar;*.pcm_s64be;*.pcm_s64le;*.pcm_s8;*.pcm_s8_planar;*.pcm_sga;*.pcm_u16be;*.pcm_u16le;*.pcm_u24be;*.pcm_u24le;*.pcm_u32be;*.pcm_u32le;*.pcm_u8;*.pcm_vidc;*.qcelp;*.qdm2;*.qdmc;*.qoa;*.ra_144;*.ra_288;*.ralf;*.rka;*.roq_dpcm;*.s302m;*.sbc;*.sdx2_dpcm;*.shorten;*.sipr;*.siren;*.smackaudio;*.smv;*.sol_dpcm;*.sonic;*.sonicls;*.speex;*.tak;*.truehd;*.truespeech;*.tta;*.twinvq;*.vmdaudio;*.vorbis;*.wady_dpcm;*.wavarc;*.wavesynth;*.wavpack;*.westwood_snd1;*.wmalossless;*.wmapro;*.wmav1;*.wmav2;*.wmavoice;*.xan_dpcm;*.xma1;*.xma2;*.wav;*.ogg;*.flac")
  if smfile == nil then
    ui.error("No File Selected")
  else
    smfiletext.text = smfile.name.." selected."
  end
end
function smcompressbutton.onClick()
  CompressFile(smfile)
end
function smimgfullbutton.onClick()
  --local afterimg =
  win:showmodal(smimagewin)
end

-- Keep running until window closes
ui.run(win):wait()