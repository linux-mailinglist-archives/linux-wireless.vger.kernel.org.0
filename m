Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CCB198A21
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2020 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgCaCpG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 22:45:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51564 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgCaCpF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 22:45:05 -0400
Received: by mail-io1-f71.google.com with SMTP id m3so17963651ioj.18
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2020 19:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=36a8ZMwdVlBtz8gcVwheDNG6RwX+THxk9wo2rPRq/wo=;
        b=qlKhjFtXo0J+ODY6Y2z3alF/prm6zf7c9n3GtdD0D9TNXSmpmpA60dpVP7njM3SAct
         bR/fuUXZp7bapwcc3Vm5ZKNlal9HLoW3hX/Lle3HQZ59V+A6gj3+e6ywwgLzr8VtKciA
         7LFRsWqkUABMzwquZUpsw3JpS645AAfjR+MYmGz9MAxXevI1H4gYwiKFvhz0NPKvmliP
         x6kPKnnLKLjDMOAmdUfTclvxozxho12zHSAkygbYhzPF3iKeYI1SMXWrSsxba6NeBDjd
         gRR7tYk9PJgeUxH1z+CPPGgi/5s/q01hWgPHVmgpPIqGxiAnt5itkQp8sCj9xpu4VnwG
         b3yw==
X-Gm-Message-State: ANhLgQ3MOujmCMkBqcVCzPmLbv/ea4bLdvKS/zcBoCwhZKPlBce0jhpC
        HCLq/qIX60xeqCtsmbDcwFVax3uQhKXf+QQgu/jslQh15E4/
X-Google-Smtp-Source: ADFU+vtQEJtMZJdn5OG0vbSOyM51ErApYe8IR5ioTwgcoWpmBmDd76ZEvJuNWvadCsgVDW4IDbLJ9OZ92Ccswfe7J6YamT3s4SdB
MIME-Version: 1.0
X-Received: by 2002:a02:5ec2:: with SMTP id h185mr2085793jab.2.1585622702653;
 Mon, 30 Mar 2020 19:45:02 -0700 (PDT)
Date:   Mon, 30 Mar 2020 19:45:02 -0700
In-Reply-To: <CADG63jD_VnBJ-fHfStVq5=4ceAT=nwqkXdWzJPcfu1U=fF657A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0858405a21d8d1f@google.com>
Subject: Re: KASAN: stack-out-of-bounds Write in ath9k_hif_usb_rx_cb
From:   syzbot <syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

828/au0828-video.o
  AR      drivers/media/usb/msi2500/built-in.a
  CC      drivers/media/dvb-frontends/isl6423.o
  CC      drivers/media/rc/keymaps/rc-nec-terratec-cinergy-xs.o
  CC      drivers/media/usb/gspca/mars.o
  CC      drivers/hid/hid-lg4ff.o
  CC      drivers/gpu/drm/drm_vblank.o
  CC      drivers/gpu/drm/drm_syncobj.o
  CC      drivers/gpu/drm/drm_lease.o
  AR      drivers/staging/rtl8712/built-in.a
  CC      drivers/media/usb/dvb-usb/dw2102.o
  AR      drivers/staging/built-in.a
  CC      drivers/media/dvb-frontends/ec100.o
  CC      drivers/media/dvb-frontends/ds3000.o
  CC      drivers/media/rc/keymaps/rc-norwood.o
  CC      drivers/media/dvb-frontends/ts2020.o
  CC      drivers/media/usb/gspca/mr97310a.o
  CC      drivers/media/usb/dvb-usb/dtv5100.o
  CC      drivers/gpu/drm/drm_writeback.o
  CC      drivers/hid/hid-lg-g15.o
  AR      drivers/media/usb/cpia2/built-in.a
  CC      drivers/media/usb/dvb-usb/cinergyT2-core.o
  CC      drivers/media/usb/gspca/nw80x.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-i2c-core.o
  CC      drivers/media/usb/usbvision/usbvision-core.o
  CC      drivers/media/usb/stk1160/stk1160-core.o
  CC      drivers/media/usb/stk1160/stk1160-v4l.o
  CC      drivers/media/usb/dvb-usb/cinergyT2-fe.o
  CC      drivers/media/usb/cx231xx/cx231xx-video.o
  CC      drivers/media/usb/usbvision/usbvision-video.o
  CC      drivers/media/usb/usbvision/usbvision-i2c.o
  CC      drivers/media/usb/usbvision/usbvision-cards.o
  CC      drivers/media/usb/au0828/au0828-vbi.o
  CC      drivers/media/usb/au0828/au0828-input.o
  CC      drivers/media/rc/keymaps/rc-npgtech.o
  CC      drivers/media/usb/stk1160/stk1160-video.o
  CC      drivers/media/usb/tm6000/tm6000-cards.o
  CC      drivers/media/usb/tm6000/tm6000-core.o
  CC      drivers/media/usb/tm6000/tm6000-i2c.o
  CC      drivers/media/usb/tm6000/tm6000-video.o
  CC      drivers/media/rc/keymaps/rc-odroid.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-audio.o
  CC      drivers/media/usb/gspca/ov519.o
  CC      drivers/hid/hid-logitech-dj.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-encoder.o
  AR      drivers/media/usb/hdpvr/built-in.a
  CC      drivers/media/usb/gspca/ov534.o
  CC      drivers/hid/hid-logitech-hidpp.o
  CC      drivers/media/usb/stk1160/stk1160-i2c.o
  CC      drivers/hid/hid-magicmouse.o
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      drivers/media/rc/keymaps/rc-pctv-sedna.o
  CC      drivers/hid/hid-mf.o
  CC      drivers/gpu/drm/drm_client.o
  CC      drivers/gpu/drm/drm_client_modeset.o
  CC      drivers/gpu/drm/drm_atomic_uapi.o
  CC      drivers/gpu/drm/drm_hdcp.o
  CC      drivers/media/usb/tm6000/tm6000-stds.o
  CC      drivers/media/usb/cx231xx/cx231xx-i2c.o
  CC      drivers/media/dvb-frontends/mb86a20s.o
  CC      drivers/media/usb/gspca/ov534_9.o
  CC      drivers/media/usb/cx231xx/cx231xx-cards.o
  CC      drivers/media/rc/keymaps/rc-pinnacle-color.o
  CC      drivers/media/usb/cx231xx/cx231xx-core.o
  CC      drivers/gpu/drm/drm_ioc32.o
  CC      drivers/media/usb/cx231xx/cx231xx-avcore.o
  CC      drivers/media/usb/tm6000/tm6000-input.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-video-v4l.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-eeprom.o
  CC      drivers/media/usb/stk1160/stk1160-ac97.o
  CC      drivers/media/usb/dvb-usb/az6027.o
  CC      drivers/gpu/drm/drm_gem_shmem_helper.o
  CC      drivers/gpu/drm/drm_panel.o
  CC      drivers/media/rc/keymaps/rc-pinnacle-grey.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-main.o
  CC      drivers/gpu/drm/drm_agpsupport.o
  CC      drivers/hid/hid-microsoft.o
  CC      drivers/media/usb/em28xx/em28xx-core.o
  CC      drivers/media/usb/em28xx/em28xx-i2c.o
  AR      drivers/media/usb/au0828/built-in.a
  CC      drivers/media/usb/tm6000/tm6000-alsa.o
  CC      drivers/media/usb/tm6000/tm6000-dvb.o
  CC      drivers/gpu/drm/drm_pci.o
  CC      drivers/media/usb/dvb-usb/technisat-usb2.o
  CC      drivers/media/usb/em28xx/em28xx-cards.o
  CC      drivers/media/usb/cx231xx/cx231xx-417.o
  CC      drivers/media/rc/keymaps/rc-pinnacle-pctv-hd.o
  AR      drivers/media/usb/stk1160/built-in.a
  CC      drivers/gpu/drm/drm_debugfs.o
  CC      drivers/media/usb/gspca/pac207.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  CC      drivers/media/usb/em28xx/em28xx-camera.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-hdw.o
  CC      drivers/media/usb/usbtv/usbtv-core.o
  CC      drivers/media/usb/go7007/go7007-v4l2.o
  CC      drivers/media/dvb-frontends/ix2505v.o
  CC      drivers/hid/hid-monterey.o
  CC      drivers/gpu/drm/drm_debugfs_crc.o
  CC      drivers/media/rc/keymaps/rc-pixelview.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-v4l2.o
  CC      drivers/gpu/drm/drm_mipi_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-ctrl.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-std.o
  CC      drivers/media/dvb-frontends/cxd2820r_core.o
  AR      drivers/media/usb/tm6000/built-in.a
  CC      drivers/media/rc/keymaps/rc-pixelview-mk12.o
  AR      drivers/media/usb/usbvision/built-in.a
  CC      drivers/gpu/drm/drm_panel_orientation_quirks.o
  CC      drivers/media/usb/em28xx/em28xx-video.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      drivers/media/usb/usbtv/usbtv-video.o
  CC      drivers/media/usb/cx231xx/cx231xx-pcb-cfg.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      drivers/media/usb/go7007/go7007-driver.o
  CC      drivers/media/usb/cx231xx/cx231xx-vbi.o
  AR      drivers/media/usb/dvb-usb/built-in.a
  CC      drivers/media/rc/keymaps/rc-pixelview-002t.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      drivers/hid/hid-multitouch.o
  CC      drivers/media/usb/em28xx/em28xx-vbi.o
  CC      drivers/media/usb/em28xx/em28xx-audio.o
  CC      drivers/media/rc/keymaps/rc-pixelview-new.o
  CC      drivers/hid/hid-nti.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-devattr.o
  CC      drivers/media/usb/em28xx/em28xx-dvb.o
  CC      drivers/hid/hid-ntrig.o
  CC      drivers/media/usb/em28xx/em28xx-input.o
  CC      drivers/media/usb/go7007/go7007-i2c.o
  CC      drivers/media/rc/keymaps/rc-powercolor-real-angel.o
  CC      drivers/media/rc/keymaps/rc-proteus-2309.o
  CC      drivers/media/usb/go7007/go7007-fw.o
  CC      drivers/media/rc/keymaps/rc-purpletv.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-context.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-io.o
  CC      drivers/media/dvb-frontends/cxd2820r_c.o
  CC      drivers/hid/hid-ortek.o
  CC      drivers/hid/hid-prodikeys.o
  CC      drivers/media/usb/as102/as102_drv.o
  CC      drivers/media/usb/as102/as102_fw.o
  CC      drivers/media/usb/as102/as10x_cmd.o
  CC      drivers/media/rc/keymaps/rc-pv951.o
  CC      drivers/media/rc/keymaps/rc-hauppauge.o
  CC      drivers/media/usb/usbtv/usbtv-audio.o
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      drivers/media/rc/keymaps/rc-rc6-mce.o
  CC      drivers/hid/hid-pl.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      drivers/media/usb/go7007/snd-go7007.o
  CC      drivers/media/usb/cx231xx/cx231xx-input.o
  CC      drivers/media/usb/gspca/pac7302.o
  CC      drivers/media/usb/gspca/pac7311.o
  CC      drivers/media/usb/cx231xx/cx231xx-dvb.o
  CC      drivers/media/usb/cx231xx/cx231xx-audio.o
  CC      drivers/media/usb/go7007/go7007-usb.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      drivers/media/rc/keymaps/rc-real-audio-220-32-keys.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-ioread.o
  CC      drivers/media/rc/keymaps/rc-reddo.o
  CC      drivers/media/dvb-frontends/cxd2820r_t.o
  CC      drivers/media/rc/keymaps/rc-snapstream-firefly.o
  CC      drivers/media/usb/pulse8-cec/pulse8-cec.o
  CC      drivers/media/usb/go7007/go7007-loader.o
  CC      drivers/media/usb/rainshadow-cec/rainshadow-cec.o
  CC      drivers/hid/hid-penmount.o
  CC      drivers/hid/hid-petalynx.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      drivers/hid/hid-picolcd_core.o
  CC      drivers/media/usb/gspca/se401.o
  CC      drivers/media/usb/as102/as10x_cmd_stream.o
  AR      drivers/media/usb/usbtv/built-in.a
  CC      drivers/media/rc/keymaps/rc-streamzap.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-cx2584x-v4l.o
  CC      drivers/media/rc/keymaps/rc-tango.o
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-wm8775.o
  CC      drivers/media/usb/gspca/sn9c2028.o
  CC      drivers/media/usb/go7007/s2250-board.o
  CC      drivers/media/usb/as102/as102_usb_drv.o
  CC      drivers/media/usb/as102/as10x_cmd_cfg.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-cs53l32a.o
  CC      drivers/hid/hid-picolcd_fb.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-dvb.o
  CC      drivers/media/usb/pvrusb2/pvrusb2-sysfs.o
  CC      drivers/media/rc/keymaps/rc-tanix-tx3mini.o
  CC      drivers/media/dvb-frontends/cxd2820r_t2.o
  AR      drivers/media/usb/rainshadow-cec/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  CC      drivers/media/rc/keymaps/rc-tanix-tx5max.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      drivers/media/dvb-frontends/cxd2841er.o
  AR      drivers/media/usb/pulse8-cec/built-in.a
  CC      drivers/media/rc/keymaps/rc-tbs-nec.o
  CC      drivers/media/rc/keymaps/rc-technisat-ts35.o
  AR      drivers/media/usb/em28xx/built-in.a
  CC      drivers/media/rc/keymaps/rc-technisat-usb2.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  CC      drivers/media/usb/gspca/sn9c20x.o
  CC      drivers/media/usb/gspca/sonixb.o
  CC      drivers/media/usb/gspca/sonixj.o
  CC      drivers/media/rc/keymaps/rc-terratec-cinergy-c-pci.o
  CC      drivers/media/rc/keymaps/rc-terratec-cinergy-s2-hd.o
  AR      drivers/media/usb/cx231xx/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      drivers/hid/hid-picolcd_backlight.o
  CC      drivers/hid/hid-picolcd_lcd.o
  CC      drivers/hid/hid-picolcd_leds.o
  CC      drivers/media/rc/keymaps/rc-terratec-cinergy-xs.o
  AR      drivers/media/usb/as102/built-in.a
  CC      drivers/media/rc/keymaps/rc-terratec-slim.o
  CC      drivers/hid/hid-picolcd_cir.o
  AR      drivers/media/usb/go7007/built-in.a
  CC      drivers/media/rc/keymaps/rc-terratec-slim-2.o
  CC      drivers/media/dvb-frontends/drxk_hard.o
  CC      drivers/media/rc/keymaps/rc-tevii-nec.o
  CC      drivers/media/rc/keymaps/rc-tivo.o
  CC      drivers/hid/hid-picolcd_debugfs.o
  CC      drivers/hid/hid-plantronics.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      drivers/media/rc/keymaps/rc-total-media-in-hand.o
  CC      drivers/media/usb/gspca/spca500.o
  CC      drivers/media/usb/gspca/spca501.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      drivers/media/usb/gspca/spca505.o
  CC      drivers/media/usb/gspca/spca506.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_hsw.o
  CC      drivers/media/dvb-frontends/tda18271c2dd.o
  CC      drivers/hid/hid-primax.o
  CC      drivers/media/usb/gspca/spca508.o
  CC      drivers/hid/hid-retrode.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_chv.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bdw.o
  CC      drivers/media/rc/keymaps/rc-total-media-in-hand-02.o
  CC      drivers/media/rc/keymaps/rc-trekstor.o
  CC      drivers/media/rc/keymaps/rc-tt-1500.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt2.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt4.o
  CC      drivers/hid/hid-roccat.o
  CC      drivers/media/usb/gspca/spca561.o
  CC      drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.o
  CC      drivers/media/dvb-frontends/si2165.o
  CC      drivers/media/usb/gspca/spca1528.o
  CC      drivers/media/rc/keymaps/rc-twinhan1027.o
  CC      drivers/media/dvb-frontends/a8293.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bxt.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt2.o
  CC      drivers/media/dvb-frontends/sp2.o
  CC      drivers/hid/hid-roccat-common.o
  CC      drivers/hid/hid-roccat-arvo.o
  CC      drivers/hid/hid-roccat-isku.o
  CC      drivers/hid/hid-roccat-kone.o
  CC      drivers/hid/hid-roccat-koneplus.o
  CC      drivers/hid/hid-roccat-konepure.o
  CC      drivers/media/rc/keymaps/rc-vega-s9x.o
  CC      drivers/media/usb/gspca/sq905.o
  CC      drivers/media/dvb-frontends/tda10071.o
  CC      drivers/media/dvb-frontends/rtl2830.o
  CC      drivers/hid/hid-roccat-kovaplus.o
  CC      drivers/hid/hid-roccat-lua.o
  CC      drivers/hid/hid-roccat-pyra.o
  CC      drivers/media/rc/keymaps/rc-videomate-m1f.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt3.o
  CC      drivers/media/dvb-frontends/rtl2832.o
  AR      drivers/media/usb/pvrusb2/built-in.a
  CC      drivers/hid/hid-roccat-ryos.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_glk.o
  CC      drivers/hid/hid-roccat-savu.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt2.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt3.o
  CC      drivers/media/rc/keymaps/rc-videomate-s350.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cnl.o
  CC      drivers/media/rc/keymaps/rc-videomate-tv-pvr.o
  CC      drivers/media/usb/gspca/sq905c.o
  CC      drivers/media/usb/gspca/sq930x.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_icl.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_tgl.o
  CC      drivers/hid/hid-rmi.o
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/media/usb/gspca/sunplus.o
  CC      drivers/media/dvb-frontends/rtl2832_sdr.o
  CC      drivers/hid/hid-saitek.o
  CC      drivers/hid/hid-samsung.o
  CC      drivers/media/dvb-frontends/m88rs2000.o
  CC      drivers/media/dvb-frontends/af9033.o
  CC      drivers/media/rc/keymaps/rc-wetek-hub.o
  CC      drivers/media/usb/gspca/stk014.o
  CC      drivers/media/rc/keymaps/rc-wetek-play2.o
  CC      drivers/media/dvb-frontends/as102_fe.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/media/dvb-frontends/tc90522.o
  CC      drivers/media/dvb-frontends/gp8psk-fe.o
  CC      drivers/media/rc/keymaps/rc-winfast.o
  CC      drivers/hid/hid-sjoy.o
  CC      drivers/hid/hid-sony.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  CC      drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.o
  CC      drivers/hid/hid-speedlink.o
  CC      drivers/media/rc/keymaps/rc-su3000.o
  CC      drivers/media/dvb-frontends/zd1301_demod.o
  CC      drivers/media/rc/keymaps/rc-xbox-dvd.o
  CC      drivers/media/usb/gspca/stk1135.o
  CC      drivers/hid/hid-steelseries.o
  CC      drivers/hid/hid-sunplus.o
  CC      drivers/media/usb/gspca/stv0680.o
  CC      drivers/hid/hid-gaff.o
  CC      drivers/hid/hid-tmff.o
  CC      drivers/media/rc/keymaps/rc-x96max.o
  CC      drivers/media/rc/keymaps/rc-zx-irdec.o
  CC      drivers/hid/hid-tivo.o
  CC      drivers/hid/hid-topseed.o
  CC      drivers/media/usb/gspca/t613.o
  CC      drivers/media/usb/gspca/topro.o
  CC      drivers/media/usb/gspca/tv8532.o
  CC      drivers/media/usb/gspca/touptek.o
  CC      drivers/hid/hid-uclogic-core.o
  CC      drivers/hid/hid-twinhan.o
  CC      drivers/hid/hid-uclogic-rdesc.o
  CC      drivers/media/usb/gspca/vc032x.o
  CC      drivers/media/usb/gspca/xirlink_cit.o
  CC      drivers/hid/hid-uclogic-params.o
  CC      drivers/media/usb/gspca/vicam.o
  CC      drivers/hid/hid-udraw-ps3.o
  CC      drivers/hid/hid-led.o
  CC      drivers/hid/hid-xinmo.o
  AR      drivers/media/rc/keymaps/built-in.a
  CC      drivers/hid/hid-zpff.o
  AR      drivers/media/rc/built-in.a
  CC      drivers/hid/hid-zydacron.o
  CC      drivers/media/usb/gspca/zc3xx.o
  CC      drivers/hid/wacom_wac.o
  CC      drivers/hid/wacom_sys.o
  CC      drivers/hid/hid-waltop.o
  CC      drivers/hid/hid-wiimote-core.o
  CC      drivers/hid/hid-wiimote-modules.o
  CC      drivers/hid/hid-wiimote-debug.o
  CC      drivers/hid/hid-sensor-hub.o
  CC      drivers/hid/hid-sensor-custom.o
  AR      drivers/media/dvb-frontends/built-in.a
  AR      drivers/media/usb/gspca/built-in.a
  AR      drivers/media/usb/built-in.a
  AR      drivers/media/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
  AR      drivers/hid/built-in.a
Makefile:1683: recipe for target 'drivers' failed
make: *** [drivers] Error 2


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=12e89493e00000


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
dashboard link: https://syzkaller.appspot.com/bug?extid=d403396d4df67ad0bd5f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14aafcb7e00000

