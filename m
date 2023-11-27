Return-Path: <linux-wireless+bounces-93-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F235D7F9923
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 07:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B20D1C20361
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FFF79ED;
	Mon, 27 Nov 2023 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm7Vw3Jo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC4E4
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 22:19:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a04196fc957so549962766b.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 22:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701065955; x=1701670755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq2/ktL6fbjygpxLrYuy5ClzVGgE/o4dubQFixruJnE=;
        b=mm7Vw3JojdG1I/Pv/Q7vm21rmsTj6O/Ei3PtMwlNM2lCMDFERqe0z3tX+GoPQFqlhp
         UX5fSsNa3dTkaD5n348mSUF/KiFSSwHLN7COrC7yQKJ6Zw8cjPGR7uHirwO3ixZI+R31
         E0gmPneC8qunAZvJ0LquMOnTD6wgKwo4y0Hj9jI0uydWuGtX/iRpZHDsZb9/e+JWHqas
         5YkM9uE0xTuHVv94cqkPaflVsoGCFMBo82bV+m5r/w5Vszjk8rxptpYYMYHsNE8JWXDc
         GW9IuKhlT6qNjM2qByzX0ZCyXEHFPTeUL0z+PhIkP0ZothLHq6FFrBHGe/nfvBN2EFMD
         vPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701065955; x=1701670755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq2/ktL6fbjygpxLrYuy5ClzVGgE/o4dubQFixruJnE=;
        b=H8IBD1M0/6vpa1E1DJbuaKhoh08LCk20K/t6BQTtGIgsFT+qT5iIVx5auRSn3rDio6
         Bb5B+KeFXzFFqaGvnMPYhBtgXwJW9l7GzJUsSkQKTP4Ct34mBYpynsrdB29XCD+x3oe5
         dCAfKBOF7A3ZV5Y36XrmcII8dCLAMqCKweUQzryF9C/MHpTpm48A5zSOMIaSf/Bu38xb
         G7uoe+UlbkLrSYmmJqI8cnaN5G321MIdBsPPRsRWZpQ23ZKTVlxoH5LC9hBhN50SAHix
         0AJwCkqnDzYX1GDaIxPLy/ujRQqzEfUn/oL0tEjcOiuVAz480FFBxv4LAmpt+6t4P+Dt
         1N2w==
X-Gm-Message-State: AOJu0YzxPVUnt48Ci1lxl1Vuv3lQPOFeiAf3GIboJakuawjNyHlohTyy
	WUhkymQpwpePsfDmvsOMO/25ANDx1VgFLJchMA8kQxUp/hc=
X-Google-Smtp-Source: AGHT+IFj6VrljdX+KnRzgJFglSJdROng91EXFXuSW8zFOALqIx5MPWfvQ5v6RZrBVbDlSE8+N5vUw2fItqgEeQmvf5Y=
X-Received: by 2002:a17:906:9c87:b0:a0d:9ba9:6255 with SMTP id
 fj7-20020a1709069c8700b00a0d9ba96255mr2958833ejc.75.1701065954439; Sun, 26
 Nov 2023 22:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com> <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
In-Reply-To: <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Mon, 27 Nov 2023 08:19:02 +0200
Message-ID: <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
Subject: Re: Lenovo LOQ rtw_8852be
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

seems like the same error persists after downgrading:

$ uname -r
5.17.0-1035-oem

$ sudo dmesg | grep rtw
[    4.859848] rtw89_8852be 0000:09:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[    4.860214] rtw89_8852be 0000:09:00.0: enabling device (0000 -> 0003)
[    4.861546] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 5
[    4.861550] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 3
[    4.861556] rtw89_8852be 0000:09:00.0: MAC has already powered on
[    4.867246] rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
[    4.867251] rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
[    4.867254] rtw89_8852be 0000:09:00.0: failed to setup chip information
[    4.867703] rtw89_8852be: probe of 0000:09:00.0 failed with error -22
[    5.305458] Modules linked in: fjes(-) rtw_8852be(OE)
x86_pkg_temp_thermal intel_powerclamp rtw_8852b(OE) rtw89pci(OE)
rtw89core(OE) mac80211 libarc4 coretemp binfmt_misc wl(POE) mei_pxp
mei_hdcp intel_rapl_msr snd_hda_codec_hdmi nls_iso8859_1 kvm_intel
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm
btusb snd_hda_core snd_hwdep btrtl btbcm snd_pcm btintel uvcvideo
btmtk crct10dif_pclmul ghash_clmulni_intel bluetooth snd_seq_midi
videobuf2_vmalloc snd_seq_midi_event videobuf2_memops aesni_intel
videobuf2_v4l2 snd_rawmidi videobuf2_common crypto_simd videodev
snd_seq cryptd ecdh_generic snd_seq_device joydev input_leds
intel_cstate mc ecc serio_raw wmi_bmof cfg80211
nvidia_wmi_ec_backlight snd_timer processor_thermal_device_pci mei_me
processor_thermal_device snd hid_multitouch processor_thermal_rfim mei
processor_thermal_mbox processor_thermal_rapl soundcore
intel_rapl_common ideapad_laptop sparse_keymap platform_profile
int3400_thermal int3403_thermal
[    5.308233] Modules linked in: fjes(-) rtw_8852be(OE)
x86_pkg_temp_thermal intel_powerclamp rtw_8852b(OE) rtw89pci(OE)
rtw89core(OE) mac80211 libarc4 coretemp binfmt_misc wl(POE) mei_pxp
mei_hdcp intel_rapl_msr snd_hda_codec_hdmi nls_iso8859_1 kvm_intel
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm
btusb snd_hda_core snd_hwdep btrtl btbcm snd_pcm btintel uvcvideo
btmtk crct10dif_pclmul ghash_clmulni_intel bluetooth snd_seq_midi
videobuf2_vmalloc snd_seq_midi_event videobuf2_memops aesni_intel
videobuf2_v4l2 snd_rawmidi videobuf2_common crypto_simd videodev
snd_seq cryptd ecdh_generic snd_seq_device joydev input_leds
intel_cstate mc ecc serio_raw wmi_bmof cfg80211
nvidia_wmi_ec_backlight snd_timer processor_thermal_device_pci mei_me
processor_thermal_device snd hid_multitouch processor_thermal_rfim mei
processor_thermal_mbox processor_thermal_rapl soundcore
intel_rapl_common ideapad_laptop sparse_keymap platform_profile
int3400_thermal int3403_thermal
[    5.310330] Modules linked in: rtw_8852be(OE) x86_pkg_temp_thermal
intel_powerclamp rtw_8852b(OE) rtw89pci(OE) rtw89core(OE) mac80211
libarc4 coretemp binfmt_misc wl(POE) mei_pxp mei_hdcp intel_rapl_msr
snd_hda_codec_hdmi nls_iso8859_1 kvm_intel snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm btusb
snd_hda_core snd_hwdep btrtl btbcm snd_pcm btintel uvcvideo btmtk
crct10dif_pclmul ghash_clmulni_intel bluetooth snd_seq_midi
videobuf2_vmalloc snd_seq_midi_event videobuf2_memops aesni_intel
videobuf2_v4l2 snd_rawmidi videobuf2_common crypto_simd videodev
snd_seq cryptd ecdh_generic snd_seq_device joydev input_leds
intel_cstate mc ecc serio_raw wmi_bmof cfg80211
nvidia_wmi_ec_backlight snd_timer processor_thermal_device_pci mei_me
processor_thermal_device snd hid_multitouch processor_thermal_rfim mei
processor_thermal_mbox processor_thermal_rapl soundcore
intel_rapl_common ideapad_laptop sparse_keymap platform_profile
int3400_thermal int3403_thermal acpi_thermal_rel
[    5.312399] Modules linked in: rtw_8852be(OE) x86_pkg_temp_thermal
intel_powerclamp rtw_8852b(OE) rtw89pci(OE) rtw89core(OE) mac80211
libarc4 coretemp binfmt_misc wl(POE) mei_pxp mei_hdcp intel_rapl_msr
snd_hda_codec_hdmi nls_iso8859_1 kvm_intel snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm btusb
snd_hda_core snd_hwdep btrtl btbcm snd_pcm btintel uvcvideo btmtk
crct10dif_pclmul ghash_clmulni_intel bluetooth snd_seq_midi
videobuf2_vmalloc snd_seq_midi_event videobuf2_memops aesni_intel
videobuf2_v4l2 snd_rawmidi videobuf2_common crypto_simd videodev
snd_seq cryptd ecdh_generic snd_seq_device joydev input_leds
intel_cstate mc ecc serio_raw wmi_bmof cfg80211
nvidia_wmi_ec_backlight snd_timer processor_thermal_device_pci mei_me
processor_thermal_device snd hid_multitouch processor_thermal_rfim mei
processor_thermal_mbox processor_thermal_rapl soundcore
intel_rapl_common ideapad_laptop sparse_keymap platform_profile
int3400_thermal int3403_thermal acpi_thermal_rel
[    5.507904] Modules linked in: rtw_8852be(OE) x86_pkg_temp_thermal
intel_powerclamp rtw_8852b(OE) rtw89pci(OE) rtw89core(OE) mac80211
libarc4 coretemp binfmt_misc wl(POE) mei_pxp mei_hdcp intel_rapl_msr
snd_hda_codec_hdmi nls_iso8859_1 kvm_intel snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm btusb
snd_hda_core snd_hwdep btrtl btbcm snd_pcm btintel uvcvideo btmtk
crct10dif_pclmul ghash_clmulni_intel bluetooth snd_seq_midi
videobuf2_vmalloc snd_seq_midi_event videobuf2_memops aesni_intel
videobuf2_v4l2 snd_rawmidi videobuf2_common crypto_simd videodev
snd_seq cryptd ecdh_generic snd_seq_device joydev input_leds
intel_cstate mc ecc serio_raw wmi_bmof cfg80211
nvidia_wmi_ec_backlight snd_timer processor_thermal_device_pci mei_me
processor_thermal_device snd hid_multitouch processor_thermal_rfim mei
processor_thermal_mbox processor_thermal_rapl soundcore
intel_rapl_common ideapad_laptop sparse_keymap platform_profile
int3400_thermal int3403_thermal acpi_thermal_rel

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Dr. Ali J. Ghandour
Associate Researcher, GEOspatial Artificial Intelligence (GEOAI) group
National Remote Sensing Center =E2=80=93 CNRS
Beirut, Lebanon



Phone: +961 (4)409845
Email: aghandour@cnrs.edu.lb - LinkedIn - GoogleScholar

On Mon, Nov 27, 2023 at 8:01=E2=80=AFAM Ali Ghandour <gandour.ali@gmail.com=
> wrote:
>
> $ lspci -tv
> -[0000:00]-+-00.0  Intel Corporation Device a715
>            +-01.0-[01-05]--+-00.0  NVIDIA Corporation Device 28e0
>            |               \-00.1  NVIDIA Corporation Device 22be
>            +-02.0  Intel Corporation Device a7a8
>            +-04.0  Intel Corporation Device a71d
>            +-06.0-[06]----00.0  Micron Technology Inc Device 5411
>            +-06.2-[07]----00.0  MAXIO Technology (Hangzhou) Ltd. NVMe
> SSD Controller MAP1202
>            +-0a.0  Intel Corporation Device a77d
>            +-14.0  Intel Corporation Alder Lake PCH USB 3.2 xHCI Host Con=
troller
>            +-14.2  Intel Corporation Alder Lake PCH Shared SRAM
>            +-15.0  Intel Corporation Alder Lake PCH Serial IO I2C Control=
ler #0
>            +-16.0  Intel Corporation Alder Lake PCH HECI Controller
>            +-19.0  Intel Corporation Alder Lake-P Serial IO I2C Controlle=
r #0
>            +-1c.0-[08]----00.0  Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>            +-1c.5-[09]----00.0  Realtek Semiconductor Co., Ltd. Device b8=
52
>            +-1f.0  Intel Corporation Device 519d
>            +-1f.3  Intel Corporation Device 51ca
>            +-1f.4  Intel Corporation Alder Lake PCH-P SMBus Host Controll=
er
>            \-1f.5  Intel Corporation Alder Lake-P PCH SPI Controller
>
>
> $ sudo lspci -s 09:00.0 -xxxx
> 09:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
> 00: ec 10 52 b8 03 00 10 00 00 00 80 02 10 00 00 00
> 10: 01 30 00 00 00 00 00 00 04 00 10 52 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 53 48
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 40: 01 50 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
> 50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 10 00 02 00 81 8d 90 15 30 20 10 00 11 6c 47 00
> 80: 43 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 10 08 0c 00 00 04 00 00 02 00 00 00
> a0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Dr. Ali J. Ghandour
> Associate Researcher, GEOspatial Artificial Intelligence (GEOAI) group
> National Remote Sensing Center =E2=80=93 CNRS
> Beirut, Lebanon
>
>
>
> Phone: +961 (4)409845
> Email: aghandour@cnrs.edu.lb - LinkedIn - GoogleScholar
>
>
> On Mon, Nov 27, 2023 at 3:43=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com>=
 wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Ali Ghandour <gandour.ali@gmail.com>
> > > Sent: Sunday, November 26, 2023 5:36 AM
> > > To: linux-wireless@vger.kernel.org
> > > Subject: Lenovo LOQ rtw_8852be
> > >
> > > Hi,
> > >
> > > Following below thread, rtw_8852be driver fails for Lenovo LOQ:
> > > https://github.com/lwfinger/rtw89/issues/235
> > >
> > > rtw89_8852be 0000:09:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
> > > rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5 (da87cccd), cmd
> > > version 0, type 5
> > > rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5 (da87cccd), cmd
> > > version 0, type 3
> > > rtw89_8852be 0000:09:00.0: MAC has already powered on
> > > rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
> > > rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
> > > rtw89_8852be 0000:09:00.0: failed to setup chip information
> > > tw89_8852be: probe of 0000:09:00.0 failed with error -22
> > >
> > > I am running Ubuntu 22.04.3 and kernel 6.2.0-37-generic.
> > >
> >
> > Not very sure why your host can't read PCI configuration space 0x719.
> > Please provide your PCI host controller by 'lspci -tv'.
> >
> > And, I wonder if user space tool 'lspci' can dump whole PCI configurati=
on
> > space on your platform, so please provide full dump by
> > 'sudo lspci -s xx:yy.zz -xxxx'
> >
> >   (you can get the device number followed '-s' by 'lspci', and copy the=
 number, like)
> >   03:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b8=
52
> >
> >
> > After kernel 5.18, we change to use standard pci API to read/write conf=
iguration
> > space, so if possible please downgrade to 5.17 to see if that version w=
orks to you.
> >
> > Ping-Ke
> >

