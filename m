Return-Path: <linux-wireless+bounces-24314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC0AE30C6
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D114216A285
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB01A5B99;
	Sun, 22 Jun 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="BUa0od6j";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NXDYMNSD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from b224-17.smtp-out.eu-central-1.amazonses.com (b224-17.smtp-out.eu-central-1.amazonses.com [69.169.224.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85701F5F6;
	Sun, 22 Jun 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750609833; cv=none; b=bqs/Hqsp4W32H6EgWh1rU4RiB3kP+AUagGt/mEQVzY5HaNO2oiesMjHU3LzM4wEe/86L9XriyZ7iZJg/OCUDsvOGfDvNRYF6+36Yy4l7lvSwUPSrWA2yyEEANL6l5/Xk2JthLKQEdS6aHoahQnmJUSa2WQphNbekwMJqTTo7LlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750609833; c=relaxed/simple;
	bh=J788H5+g8//rd7Obly86d4FoXDeMX3S2OmtixCormh8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lzFCVzfxImYEwD+ycHdvWrLZZcvWiRTCkwWx2Fnq7AUIj522RqYXTgdzk9rdrViS8AH7srupNK4dLznvxk5CoZwICRVLe7NLw11oY3L01xsU4LnKTMrYhkobNjkclr/3sF3Pd48WQ+W+OIxkrqx5uq2kVGBkNR4u8ammSUKmbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=mail.riscv-rocks.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=BUa0od6j; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=NXDYMNSD; arc=none smtp.client-ip=69.169.224.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.riscv-rocks.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=2kaovp6zxy5nzp5wqunvdq5vkiqbeqln; d=riscv-rocks.de; t=1750609820;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type;
	bh=J788H5+g8//rd7Obly86d4FoXDeMX3S2OmtixCormh8=;
	b=BUa0od6jLPsidwDf+QJMZCzfZbgTnhJ05EgcG+BbT5uwJ9nYChen3UrAIqWMmlBW
	/ENLITTriiXHYwwVk0vvK1cAzvVY52Ob93X+5ElCoaIij1cpQhpyJdQmpcPf/wGOLcN
	zxZXibk//vDWscgsUikoaquYIrH6WX1bPn7gk+AnP/0J0f0RHCAXgN9NRha3q0xWeti
	nLGW9lnchn4uox35g6j87sLVj0MQEv8/tJc/dgzQl72VoC0PgIAZGxvrJqGY6qX7Nr4
	zlFHju+XodlfRc8WknFZS9XHVrDDNbws9saRKzBYCkeO0ZMIZtW1iFeJV4DyY4k//C3
	+1CRzMRQZg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1750609820;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:Feedback-ID;
	bh=J788H5+g8//rd7Obly86d4FoXDeMX3S2OmtixCormh8=;
	b=NXDYMNSDem2VN0eethNnKv0dcejq68+KpNT01iRu3qMoUitCLgNkpLxWJ/EYgfZi
	jJA5D/VDRLePYzMTBvwee5i5dxcwMBgm7yIhAGtfRbXX+0fDpisrSVHan2uDva9oyhQ
	0nOpZ9/1XV5LrnL5TQyzY0htie/9XYbJAAQm3daw=
Date: Sun, 22 Jun 2025 16:30:19 +0000
From: Damian Tometzki <damian@riscv-rocks.de>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: wlwifi AX201: WARN_ON in iwl_mvm_mld_mac_ctxt_cmd_common repeated
 UMAC FW crashes on 6.16-rc2
Message-ID: <010701979879f871-db0f9edf-6eeb-4bae-8fa9-f3110c40e83a-000000@eu-central-1.amazonses.com>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Gnkklz0/JNFkrAiQ"
Content-Disposition: inline
User-Agent: Mutt
X-Operating-System: Linux Fedora release 42 (Adams) (Kernel
 6.15.3-200.fc42.x86_64)
Organization: Linux hacker
Feedback-ID: ::1.eu-central-1.yMcBPu/jK26Vj3HVmCFyFk75QMsS8V3QY5HbXP/Qrys=:AmazonSES
X-SES-Outgoing: 2025.06.22-69.169.224.17


--Gnkklz0/JNFkrAiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miri,
Hi all,

with v6.16-rc2 I consistently hit a Wi-Fi firmware crash on a
Lenovo ThinkPad X1 Carbon Gen 9.

Hardware / FW
-------------
 * NIC  : Intel Wi-Fi 6 AX201 160 MHz (PCI ID a0f0:0070, rev 0x351)
 * FW   : 77.864baa2e.0 QuZ-a0-hr-b0-77.ucode (auto-loaded)
 * BIOS : N32ET96W (1.72)
 * Platform: 20XWCTO1WW

Kernel: 6.16.0-rc2 #440 PREEMPT(lazy)

Symptoms
--------
Immediately after NetworkManager (or plain `ip link set wlp0s20f3 up`)
the driver warns:

    WARNING at drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c:37
    iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0

The firmware then aborts:

    FW error in SYNC CMD MAC_CONFIG_CMD
    NMI_INTERRUPT_UMAC_FATAL
    ADVANCED_SYSASSERT 0x20103126
    Microcode SW error detected. Restarting 0x0.

The cycle repeats every few seconds; the interface never becomes usable.
Full dmesg attached.

-- 
VG
Demian Tometzki

--Gnkklz0/JNFkrAiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg.txt
Content-Transfer-Encoding: quoted-printable

[    3.280606] systemd-journald[487]: Collecting audit messages is enabled.
[    3.280888] systemd[1]: Finished systemd-udev-load-credentials.service -=
 Load udev Rules from Credentials.
[    3.280946] audit: type=3D1130 audit(1750608411.781:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-udev-load-credentials comm=3D"systemd" exe=3D"/usr/lib/s=
ystemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.285571] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.
[    3.285744] audit: type=3D1130 audit(1750608411.786:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.295334] audit: type=3D1130 audit(1750608411.796:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.320799] audit: type=3D1130 audit(1750608411.821:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd"=
 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.321081] systemd-journald[487]: Received client request to flush runt=
ime journal.
[    3.321117] audit: type=3D1130 audit(1750608411.822:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-random-seed comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.322889] audit: type=3D1334 audit(1750608411.823:9): prog-id=3D32 op=
=3DLOAD
[    3.322965] audit: type=3D1334 audit(1750608411.823:10): prog-id=3D33 op=
=3DLOAD
[    4.013508] Bluetooth: hci0: Waiting for firmware download to complete
[    4.014433] Bluetooth: hci0: Firmware loaded in 1803621 usecs
[    4.014487] Bluetooth: hci0: Waiting for device to boot
[    4.031423] Bluetooth: hci0: Device booted in 16572 usecs
[    4.034496] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-=
4.ddc
[    4.036434] Bluetooth: hci0: Applying Intel DDC parameters completed
[    4.037496] Bluetooth: hci0: Firmware revision 0.4 build 193 week 33 2024
[    4.037562] input: Intel HID events as /devices/platform/INTC1051:00/inp=
ut/input13
[    4.039483] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but it=
s usage is not supported.
[    4.040381] intel_pmc_core INT33A1:00:  initialized
[    4.092128] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    4.092132] thinkpad_acpi: http://ibm-acpi.sf.net/
[    4.092133] thinkpad_acpi: ThinkPad BIOS N32ET96W (1.72 ), EC N32HT56W
[    4.092135] thinkpad_acpi: Lenovo ThinkPad X1 Carbon Gen 9, model 20XWCT=
O1WW
[    4.092443] EDAC igen6: v2.5.1
[    4.092631] thinkpad_acpi: radio switch found; radios are enabled
[    4.092639] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[    4.092640] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[    4.094420] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[    4.120427] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.137601] thinkpad_acpi: secondary fan control detected & enabled
[    4.149326] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.149345] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.149727] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.149771] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.154528] thinkpad_acpi: battery 1 registered (start 0, stop 100, beha=
viours: 0xb)
[    4.155329] ACPI: battery: new hook: ThinkPad Battery Extension
[    4.159194] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.159681] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.159832] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    4.173244] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input14
[    4.190711] mc: Linux media interface: v0.10
[    4.198734] input: PC Speaker as /devices/platform/pcspkr/input/input15
[    4.203408] resource: resource sanity check: requesting [mem 0x00000000f=
edc0000-0x00000000fedcdfff], which spans more than pnp 00:04 [mem 0xfedc000=
0-0xfedc7fff]
[    4.203414] caller uncore_get_box_mmio_addr+0xe6/0x150 [intel_uncore] ma=
pping multiple BARs
[    4.227060] zram0: detected capacity change from 0 to 16777216
[    4.311235] intel_rapl_msr: PL4 support detected.
[    4.311265] intel_rapl_common: Found RAPL domain package
[    4.311268] intel_rapl_common: Found RAPL domain core
[    4.311269] intel_rapl_common: Found RAPL domain uncore
[    4.311271] intel_rapl_common: Found RAPL domain psys
[    4.407601] EXT4-fs (nvme0n1p2): mounted filesystem 95740c92-386d-42cd-a=
dd0-2c2c56c01c3a r/w with ordered data mode. Quota mode: none.
[    4.470697] Adding 8388604k swap on /dev/zram0.  Priority:100 extents:1 =
across:8388604k SSDsc
[    4.558181] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.558219] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.558230] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.558241] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.558252] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.558263] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.558274] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    4.573283] iTCO_vendor_support: vendor-support=3D0
[    4.575862] spi-nor spi0.0: supply vcc not found, using dummy regulator
[    4.582293] videodev: Linux video capture interface: v2.00
[    4.583178] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360=
 ms ovfl timer
[    4.583183] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.583185] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.583187] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.583189] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.583906] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    4.584945] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.584953] 0x000000000000-0x000002000000 : "BIOS"
[    4.600360] Intel(R) Wireless WiFi driver for Linux
[    4.600367] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    4.600573] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    4.611229] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[    4.611300] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=3D0x351, rfid=
=3D0x10a100
[    4.611305] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[    4.611612] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    4.614596] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    4.615882] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    4.623701] intel_rapl_common: Found RAPL domain package
[    4.627833] usb 3-4: Found UVC 1.10 device Integrated Camera (04f2:b6ea)
[    4.628773] intel_tcc_cooling: Programmable TCC Offset detected
[    4.635102] usb 3-4: Found UVC 1.50 device Integrated Camera (04f2:b6ea)
[    4.635803] usbcore: registered new interface driver uvcvideo
[    4.645801] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ p=
latform, using SOF driver
[    4.658205] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[    4.658461] iwlwifi 0000:00:14.3: loaded firmware version 77.864baa2e.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[    4.762772] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI =
class/subclass/prog-if 0x040380
[    4.762834] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (op=
s intel_audio_component_bind_ops [i915])
[    4.769426] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
[    4.791107] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask=
 5
[    4.791112] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driv=
er skl_hda_dsp_generic now
[    4.791114] sof-audio-pci-intel-tgl 0000:00:1f.3: NHLT device BT(0) dete=
cted, ssp_mask 0x4
[    4.791115] sof-audio-pci-intel-tgl 0000:00:1f.3: BT link detected in NH=
LT tables: 0x4
[    4.791117] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT=
 tables: 4
[    4.815449] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware paths/files f=
or ipc type 0:
[    4.815453] sof-audio-pci-intel-tgl 0000:00:1f.3:  Firmware file:     in=
tel/sof/sof-tgl.ri
[    4.815454] sof-audio-pci-intel-tgl 0000:00:1f.3:  Topology file:     in=
tel/sof-tplg/sof-hda-generic-4ch.tplg
[    4.832369] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version=
 2:2:0-57864
[    4.832375] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 K=
ernel ABI 3:23:1
[    4.864259] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[    4.929373] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version=
 2:2:0-57864
[    4.929378] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 K=
ernel ABI 3:23:1
[    4.930981] iwlwifi 0000:00:14.3: base HW address: 20:c1:9b:dc:2d:c8
[    4.938785] sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 K=
ernel ABI 3:23:1
[    4.938979] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Parent card n=
ot yet available, widget card binding deferred
[    4.959676] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[    4.962511] snd_hda_codec_realtek ehdaudio0D0: ALC287: picked fixup  (pi=
n match)
[    4.963201] snd_hda_codec_realtek ehdaudio0D0: autoconfig for ALC287: li=
ne_outs=3D2 (0x14/0x17/0x0/0x0/0x0) type:speaker
[    4.963204] snd_hda_codec_realtek ehdaudio0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.963205] snd_hda_codec_realtek ehdaudio0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    4.963206] snd_hda_codec_realtek ehdaudio0D0:    mono: mono_out=3D0x0
[    4.963207] snd_hda_codec_realtek ehdaudio0D0:    inputs:
[    4.963208] snd_hda_codec_realtek ehdaudio0D0:      Mic=3D0x19
[    5.006569] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 3
[    5.026980] input: sof-hda-dsp Mic as /devices/pci0000:00/0000:00:1f.3/s=
kl_hda_dsp_generic/sound/card0/input16
[    5.027019] input: sof-hda-dsp Headphone as /devices/pci0000:00/0000:00:=
1f.3/skl_hda_dsp_generic/sound/card0/input17
[    5.027049] input: sof-hda-dsp HDMI/DP,pcm=3D3 as /devices/pci0000:00/00=
00:00:1f.3/skl_hda_dsp_generic/sound/card0/input18
[    5.027074] input: sof-hda-dsp HDMI/DP,pcm=3D4 as /devices/pci0000:00/00=
00:00:1f.3/skl_hda_dsp_generic/sound/card0/input19
[    5.027118] input: sof-hda-dsp HDMI/DP,pcm=3D5 as /devices/pci0000:00/00=
00:00:1f.3/skl_hda_dsp_generic/sound/card0/input20
[    5.287934] kauditd_printk_skb: 35 callbacks suppressed
[    5.287937] audit: type=3D1130 audit(1750608413.788:46): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dplymouth-read-write comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    5.289881] audit: type=3D1130 audit(1750608413.790:47): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-binfmt comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd"=
 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    5.344132] audit: type=3D1130 audit(1750608413.845:48): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    5.347929] audit: type=3D1334 audit(1750608413.848:49): prog-id=3D37 op=
=3DLOAD
[    5.347990] audit: type=3D1334 audit(1750608413.848:50): prog-id=3D38 op=
=3DLOAD
[    5.348010] audit: type=3D1334 audit(1750608413.848:51): prog-id=3D39 op=
=3DLOAD
[    5.369949] audit: type=3D1305 audit(1750608413.870:52): op=3Dset audit_=
enabled=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:auditd_t:s0 res=3D1
[    5.403652] RPC: Registered named UNIX socket transport module.
[    5.403655] RPC: Registered udp transport module.
[    5.403655] RPC: Registered tcp transport module.
[    5.403656] RPC: Registered tcp-with-tls transport module.
[    5.403656] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.525555] nvme nvme0: using unchecked data buffer
[    5.562297] Bluetooth: MGMT ver 1.23
[    5.719702] block nvme0n1: No UUID available providing old NGUID
[    5.846492] NET: Registered PF_QIPCRTR protocol family
[    7.327372] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[    7.328121] ------------[ cut here ]------------
[    7.328124] WARNING: CPU: 5 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[    7.328160] Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broa=
dcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rej=
ect_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack=
 nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_sk=
l_hda_dsp snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_=
dsp_common snd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda=
_scodec_component snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel=
_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_co=
mmon snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_cod=
ec_hdmi soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_ut=
ils iwlmvm snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwir=
e_generic_allocation snd_soc_acpi crc8 soundwire_bus snd_soc_sdca mac80211 =
snd_soc_avs snd_soc_hda_codec snd_hda_ext_core libarc4 snd_soc_core snd_com=
press ac97_bus snd_pcm_dmaengine snd_hda_intel
[    7.328205]  snd_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency =
intel_uncore_frequency_common snd_hda_codec uvcvideo snd_hda_core intel_tcc=
_cooling snd_hwdep uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_=
seq intel_powerclamp videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp vide=
obuf2_common snd_seq_device processor_thermal_device_pci_legacy iwlwifi mei=
_pxp think_lmi processor_thermal_device intel_pmc_bxt videodev processor_th=
ermal_wt_hint iTCO_vendor_support rapl spi_nor vfat platform_temperature_co=
ntrol intel_cstate fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_a=
ttributes_class wmi_bmof snd_pcm snd_ctl_led processor_thermal_rfim process=
or_thermal_rapl i2c_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2=
c_smbus spi_intel idma64 snd_timer mei processor_thermal_wt_req processor_t=
hermal_power_floor processor_thermal_mbox intel_soc_dts_iosf igen6_edac thi=
nkpad_acpi platform_profile snd soundcore int3403_thermal int340x_thermal_z=
one soc_button_array intel_pmc_core pmt_telemetry
[    7.328262]  int3400_thermal intel_hid pmt_class acpi_tad acpi_pad spars=
e_keymap acpi_thermal_rel intel_pmc_ssram_telemetry joydev loop nfnetlink z=
ram lz4hc_compress lz4_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helpe=
r drm_suballoc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb bt=
rtl btintel btbcm btmtk bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nv=
me nvme_core drm_display_helper polyval_clmulni ghash_clmulni_intel sha512_=
ssse3 hid_multitouch nvme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vs=
ec cec i2c_hid_acpi i2c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev f=
use
[    7.328309] CPU: 5 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U              6.16.0-rc2 #440 PREEMPT(lazy)=20
[    7.328313] Tainted: [U]=3DUSER
[    7.328314] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[    7.328316] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[    7.328338] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[    7.328341] RSP: 0000:ffffca55873e32b8 EFLAGS: 00010282
[    7.328343] RAX: 00000000ffffffff RBX: ffff88f1cfb7dc98 RCX: ffff88f1ca1=
2fafc
[    7.328345] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1ca1=
2fafc
[    7.328347] RBP: ffffca55873e32fc R08: 0000000000000308 R09: 00000000000=
00001
[    7.328349] R10: 0000000000000000 R11: ffff88f1ca120028 R12: 00000000000=
00000
[    7.328350] R13: ffff88f1ca132008 R14: 0000000000000001 R15: ffff88f1cfb=
7dc98
[    7.328351] FS:  00007fa4f48b75c0(0000) GS:ffff88f55172e000(0000) knlGS:=
0000000000000000
[    7.328353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.328354] CR2: 00007fbbb9a8ffd8 CR3: 00000001640fb006 CR4: 0000000000f=
70ef0
[    7.328356] PKRU: 55555554
[    7.328357] Call Trace:
[    7.328359]  <TASK>
[    7.328362]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[    7.328382]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[    7.328400]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[    7.328419]  drv_add_interface+0x50/0x240 [mac80211]
[    7.328479]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[    7.328529]  ieee80211_do_open+0x57b/0x720 [mac80211]
[    7.328578]  ieee80211_open+0xa2/0xb0 [mac80211]
[    7.328623]  __dev_open+0x11b/0x2b0
[    7.328629]  __dev_change_flags+0x1fc/0x240
[    7.328632]  netif_change_flags+0x27/0x70
[    7.328634]  do_setlink.isra.0+0x325/0xcd0
[    7.328638]  ? cred_has_capability.isra.0+0xa4/0x150
[    7.328643]  ? __rtnl_newlink+0x1ee/0x3e0
[    7.328646]  rtnl_newlink+0x469/0x860
[    7.328649]  ? __pfx_rtnl_newlink+0x10/0x10
[    7.328652]  rtnetlink_rcv_msg+0x372/0x450
[    7.328655]  ? avc_has_perm+0x59/0xe0
[    7.328658]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    7.328660]  netlink_rcv_skb+0x5c/0x110
[    7.328665]  netlink_unicast+0x26f/0x3a0
[    7.328667]  netlink_sendmsg+0x207/0x440
[    7.328670]  ____sys_sendmsg+0x39f/0x3d0
[    7.328674]  ? import_iovec+0x1b/0x30
[    7.328677]  ___sys_sendmsg+0x99/0xe0
[    7.328682]  ? mntput_no_expire+0x4b/0x290
[    7.328686]  __sys_sendmsg+0x8a/0xf0
[    7.328690]  do_syscall_64+0x82/0x2c0
[    7.328695]  ? kmem_cache_free+0x490/0x4d0
[    7.328699]  ? __x64_sys_close+0x3d/0x80
[    7.328704]  ? __x64_sys_close+0x3d/0x80
[    7.328706]  ? do_syscall_64+0x82/0x2c0
[    7.328709]  ? proc_get_long.constprop.0+0x128/0x1a0
[    7.328715]  ? __pfx_do_proc_dointvec_conv+0x10/0x10
[    7.328717]  ? __do_proc_dointvec+0x1e6/0x420
[    7.328721]  ? __kvmalloc_node_noprof+0x269/0x6e0
[    7.328724]  ? proc_sys_call_handler+0xec/0x2d0
[    7.328728]  ? vfs_write+0x261/0x480
[    7.328731]  ? ksys_write+0xcd/0xf0
[    7.328733]  ? do_syscall_64+0x82/0x2c0
[    7.328736]  ? ksys_write+0xcd/0xf0
[    7.328738]  ? do_syscall_64+0x82/0x2c0
[    7.328741]  ? __x64_sys_close+0x3d/0x80
[    7.328744]  ? clear_bhb_loop+0x50/0xa0
[    7.328747]  ? clear_bhb_loop+0x50/0xa0
[    7.328749]  ? clear_bhb_loop+0x50/0xa0
[    7.328752]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    7.328754] RIP: 0033:0x7fa4f4c876c2
[    7.328757] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[    7.328759] RSP: 002b:00007ffe61af7b28 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[    7.328761] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[    7.328763] RDX: 0000000000000000 RSI: 00007ffe61af7bc0 RDI: 00000000000=
0000d
[    7.328764] RBP: 00007ffe61af7b60 R08: 0000000000000000 R09: 00000000000=
00000
[    7.328765] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[    7.328767] R13: 0000000000000016 R14: 0000000000000000 R15: 00007ffe61a=
f7d5c
[    7.328769]  </TASK>
[    7.328771] ---[ end trace 0000000000000000 ]---
[    7.329212] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[    7.329379] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    7.329381] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[    7.329382] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[    7.329384] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[    7.329386] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[    7.329388] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[    7.329389] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[    7.329391] iwlwifi 0000:00:14.3: 0x004C34B4 | interruptlink1
[    7.329392] iwlwifi 0000:00:14.3: 0x004C34B4 | interruptlink2
[    7.329394] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[    7.329395] iwlwifi 0000:00:14.3: 0x00001000 | data2
[    7.329396] iwlwifi 0000:00:14.3: 0x00000000 | data3
[    7.329398] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[    7.329399] iwlwifi 0000:00:14.3: 0x000256A4 | tsf low
[    7.329401] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[    7.329402] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[    7.329404] iwlwifi 0000:00:14.3: 0x0002B393 | time gp2
[    7.329405] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[    7.329407] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[    7.329408] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[    7.329410] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[    7.329411] iwlwifi 0000:00:14.3: 0x00489001 | board version
[    7.329413] iwlwifi 0000:00:14.3: 0x00130148 | hcmd
[    7.329414] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[    7.329415] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[    7.329417] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[    7.329418] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[    7.329420] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[    7.329421] iwlwifi 0000:00:14.3: 0x00130148 | last cmd Id
[    7.329423] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[    7.329424] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[    7.329425] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[    7.329427] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[    7.329428] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[    7.329430] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[    7.329431] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[    7.329433] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[    7.329879] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    7.329880] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[    7.329882] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[    7.329884] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[    7.329885] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[    7.329886] iwlwifi 0000:00:14.3: 0x80473604 | umac interruptlink1
[    7.329888] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[    7.329889] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[    7.329891] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[    7.329892] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[    7.329893] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[    7.329895] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[    7.329896] iwlwifi 0000:00:14.3: 0x0002B38D | frame pointer
[    7.329898] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[    7.329899] iwlwifi 0000:00:14.3: 0x00140308 | last host cmd
[    7.329901] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[    7.330012] iwlwifi 0000:00:14.3: IML/ROM dump:
[    7.330013] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[    7.330034] iwlwifi 0000:00:14.3: 0x00005810 | IML/ROM data1
[    7.330044] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[    7.330051] iwlwifi 0000:00:14.3: Fseq Registers:
[    7.330086] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[    7.330126] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[    7.330152] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[    7.330179] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[    7.330206] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[    7.330232] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[    7.330259] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[    7.330286] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[    7.330312] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[    7.330333] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[    7.330356] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[    7.330379] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[    7.330400] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[    7.330432] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[    7.330458] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[    7.330482] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[    7.330579] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[    7.330605] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[    7.331832] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[    7.331839] CPU: 0 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[    7.331843] Tainted: [U]=3DUSER, [W]=3DWARN
[    7.331844] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[    7.331845] Call Trace:
[    7.331848]  <TASK>
[    7.331850]  dump_stack_lvl+0x5d/0x80
[    7.331862]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[    7.331894]  ? __pfx_autoremove_wake_function+0x10/0x10
[    7.331898]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[    7.331925]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[    7.331953]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[    7.331977]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[    7.331997]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[    7.332016]  drv_add_interface+0x50/0x240 [mac80211]
[    7.332076]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[    7.332125]  ieee80211_do_open+0x57b/0x720 [mac80211]
[    7.332173]  ieee80211_open+0xa2/0xb0 [mac80211]
[    7.332221]  __dev_open+0x11b/0x2b0
[    7.332224]  __dev_change_flags+0x1fc/0x240
[    7.332227]  netif_change_flags+0x27/0x70
[    7.332229]  do_setlink.isra.0+0x325/0xcd0
[    7.332232]  ? cred_has_capability.isra.0+0xa4/0x150
[    7.332236]  ? __rtnl_newlink+0x1ee/0x3e0
[    7.332238]  rtnl_newlink+0x469/0x860
[    7.332241]  ? __pfx_rtnl_newlink+0x10/0x10
[    7.332243]  rtnetlink_rcv_msg+0x372/0x450
[    7.332246]  ? avc_has_perm+0x59/0xe0
[    7.332249]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    7.332251]  netlink_rcv_skb+0x5c/0x110
[    7.332255]  netlink_unicast+0x26f/0x3a0
[    7.332257]  netlink_sendmsg+0x207/0x440
[    7.332259]  ____sys_sendmsg+0x39f/0x3d0
[    7.332262]  ? import_iovec+0x1b/0x30
[    7.332266]  ___sys_sendmsg+0x99/0xe0
[    7.332270]  ? mntput_no_expire+0x4b/0x290
[    7.332275]  __sys_sendmsg+0x8a/0xf0
[    7.332277]  do_syscall_64+0x82/0x2c0
[    7.332281]  ? kmem_cache_free+0x490/0x4d0
[    7.332285]  ? __x64_sys_close+0x3d/0x80
[    7.332288]  ? __x64_sys_close+0x3d/0x80
[    7.332291]  ? do_syscall_64+0x82/0x2c0
[    7.332293]  ? proc_get_long.constprop.0+0x128/0x1a0
[    7.332297]  ? __pfx_do_proc_dointvec_conv+0x10/0x10
[    7.332299]  ? __do_proc_dointvec+0x1e6/0x420
[    7.332302]  ? __kvmalloc_node_noprof+0x269/0x6e0
[    7.332305]  ? proc_sys_call_handler+0xec/0x2d0
[    7.332309]  ? vfs_write+0x261/0x480
[    7.332311]  ? ksys_write+0xcd/0xf0
[    7.332313]  ? do_syscall_64+0x82/0x2c0
[    7.332316]  ? ksys_write+0xcd/0xf0
[    7.332317]  ? do_syscall_64+0x82/0x2c0
[    7.332320]  ? __x64_sys_close+0x3d/0x80
[    7.332322]  ? clear_bhb_loop+0x50/0xa0
[    7.332325]  ? clear_bhb_loop+0x50/0xa0
[    7.332327]  ? clear_bhb_loop+0x50/0xa0
[    7.332329]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    7.332331] RIP: 0033:0x7fa4f4c876c2
[    7.332334] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[    7.332335] RSP: 002b:00007ffe61af7b28 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[    7.332338] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[    7.332340] RDX: 0000000000000000 RSI: 00007ffe61af7bc0 RDI: 00000000000=
0000d
[    7.332341] RBP: 00007ffe61af7b60 R08: 0000000000000000 R09: 00000000000=
00000
[    7.332342] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[    7.332343] R13: 0000000000000016 R14: 0000000000000000 R15: 00007ffe61a=
f7d5c
[    7.332345]  </TASK>
[    7.332365] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[    7.332377] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[    7.821013] iwlwifi 0000:00:14.3: Device error - SW reset
[    8.026291] ------------[ cut here ]------------
[    8.026299] WARNING: CPU: 5 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[    8.026364] Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broa=
dcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rej=
ect_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack=
 nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_sk=
l_hda_dsp snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_=
dsp_common snd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda=
_scodec_component snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel=
_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_co=
mmon snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_cod=
ec_hdmi soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_ut=
ils iwlmvm snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwir=
e_generic_allocation snd_soc_acpi crc8 soundwire_bus snd_soc_sdca mac80211 =
snd_soc_avs snd_soc_hda_codec snd_hda_ext_core libarc4 snd_soc_core snd_com=
press ac97_bus snd_pcm_dmaengine snd_hda_intel
[    8.026435]  snd_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency =
intel_uncore_frequency_common snd_hda_codec uvcvideo snd_hda_core intel_tcc=
_cooling snd_hwdep uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_=
seq intel_powerclamp videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp vide=
obuf2_common snd_seq_device processor_thermal_device_pci_legacy iwlwifi mei=
_pxp think_lmi processor_thermal_device intel_pmc_bxt videodev processor_th=
ermal_wt_hint iTCO_vendor_support rapl spi_nor vfat platform_temperature_co=
ntrol intel_cstate fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_a=
ttributes_class wmi_bmof snd_pcm snd_ctl_led processor_thermal_rfim process=
or_thermal_rapl i2c_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2=
c_smbus spi_intel idma64 snd_timer mei processor_thermal_wt_req processor_t=
hermal_power_floor processor_thermal_mbox intel_soc_dts_iosf igen6_edac thi=
nkpad_acpi platform_profile snd soundcore int3403_thermal int340x_thermal_z=
one soc_button_array intel_pmc_core pmt_telemetry
[    8.026518]  int3400_thermal intel_hid pmt_class acpi_tad acpi_pad spars=
e_keymap acpi_thermal_rel intel_pmc_ssram_telemetry joydev loop nfnetlink z=
ram lz4hc_compress lz4_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helpe=
r drm_suballoc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb bt=
rtl btintel btbcm btmtk bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nv=
me nvme_core drm_display_helper polyval_clmulni ghash_clmulni_intel sha512_=
ssse3 hid_multitouch nvme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vs=
ec cec i2c_hid_acpi i2c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev f=
use
[    8.026591] CPU: 5 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[    8.026598] Tainted: [U]=3DUSER, [W]=3DWARN
[    8.026600] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[    8.026604] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[    8.026646] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[    8.026650] RSP: 0018:ffffca55873e3338 EFLAGS: 00010282
[    8.026655] RAX: 00000000ffffffff RBX: ffff88f1cfb7dc98 RCX: ffff88f1ca1=
2fafc
[    8.026657] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1ca1=
2fafc
[    8.026660] RBP: ffffca55873e337c R08: 0000000000000308 R09: 00000000000=
00001
[    8.026663] R10: 0000000000000000 R11: ffff88f1ca120028 R12: 00000000000=
00000
[    8.026665] R13: ffff88f1ca132008 R14: 0000000000000001 R15: ffff88f1cfb=
7dc98
[    8.026668] FS:  00007fa4f48b75c0(0000) GS:ffff88f55172e000(0000) knlGS:=
0000000000000000
[    8.026671] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.026674] CR2: 000000c001707010 CR3: 00000001640fb002 CR4: 0000000000f=
70ef0
[    8.026677] PKRU: 55555554
[    8.026679] Call Trace:
[    8.026683]  <TASK>
[    8.026688]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[    8.026727]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[    8.026763]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[    8.026797]  drv_add_interface+0x50/0x240 [mac80211]
[    8.026885]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[    8.026982]  ieee80211_do_open+0x57b/0x720 [mac80211]
[    8.027092]  ieee80211_open+0xa2/0xb0 [mac80211]
[    8.027179]  __dev_open+0x11b/0x2b0
[    8.027188]  __dev_change_flags+0x1fc/0x240
[    8.027194]  netif_change_flags+0x27/0x70
[    8.027198]  do_setlink.isra.0+0x325/0xcd0
[    8.027204]  ? cred_has_capability.isra.0+0xa4/0x150
[    8.027212]  ? __rtnl_newlink+0x1ee/0x3e0
[    8.027217]  rtnl_newlink+0x469/0x860
[    8.027223]  ? __pfx_rtnl_newlink+0x10/0x10
[    8.027228]  rtnetlink_rcv_msg+0x372/0x450
[    8.027233]  ? avc_has_perm+0x59/0xe0
[    8.027239]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    8.027243]  netlink_rcv_skb+0x5c/0x110
[    8.027251]  netlink_unicast+0x26f/0x3a0
[    8.027255]  netlink_sendmsg+0x207/0x440
[    8.027260]  ____sys_sendmsg+0x39f/0x3d0
[    8.027267]  ? import_iovec+0x1b/0x30
[    8.027274]  ___sys_sendmsg+0x99/0xe0
[    8.027284]  __sys_sendmsg+0x8a/0xf0
[    8.027290]  do_syscall_64+0x82/0x2c0
[    8.027299]  ? pollwake+0x77/0xa0
[    8.027305]  ? __pfx_default_wake_function+0x10/0x10
[    8.027314]  ? __wake_up_common+0x6f/0xa0
[    8.027320]  ? eventfd_write+0xdb/0x210
[    8.027327]  ? __task_pid_nr_ns+0xb4/0xe0
[    8.027332]  ? __do_sys_getpid+0x1d/0x30
[    8.027336]  ? do_syscall_64+0x82/0x2c0
[    8.027342]  ? vfs_write+0xce/0x480
[    8.027347]  ? place_entity+0x94/0x140
[    8.027354]  ? reweight_entity+0x1ca/0x200
[    8.027359]  ? task_tick_fair+0x5e/0x640
[    8.027366]  ? nohz_balancer_kick+0x35/0x2d0
[    8.027370]  ? perf_event_task_tick+0x4f/0xb0
[    8.027378]  ? kick_ilb+0x4c/0x160
[    8.027382]  ? __pfx_tick_nohz_handler+0x10/0x10
[    8.027390]  ? update_process_times+0xa4/0xd0
[    8.027395]  ? tick_nohz_handler+0xb1/0x140
[    8.027401]  ? timerqueue_add+0xae/0xd0
[    8.027408]  ? __hrtimer_run_queues+0x143/0x2a0
[    8.027413]  ? ktime_get+0x3c/0xf0
[    8.027420]  ? lapic_next_deadline+0x26/0x30
[    8.027428]  ? clockevents_program_event+0xa8/0x120
[    8.027432]  ? hrtimer_update_next_event+0x7b/0xa0
[    8.027436]  ? hrtimer_interrupt+0x125/0x230
[    8.027442]  ? sched_clock+0x10/0x30
[    8.027446]  ? sched_clock_cpu+0xb/0x30
[    8.027452]  ? irqtime_account_irq+0x3c/0xc0
[    8.027457]  ? clear_bhb_loop+0x50/0xa0
[    8.027462]  ? clear_bhb_loop+0x50/0xa0
[    8.027466]  ? clear_bhb_loop+0x50/0xa0
[    8.027470]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    8.027475] RIP: 0033:0x7fa4f4c876c2
[    8.027480] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[    8.027483] RSP: 002b:00007ffe61af7778 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[    8.027487] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[    8.027490] RDX: 0000000000000000 RSI: 00007ffe61af7810 RDI: 00000000000=
0000d
[    8.027492] RBP: 00007ffe61af77b0 R08: 0000000000000000 R09: 00000000000=
00000
[    8.027494] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[    8.027496] R13: 000000000000001c R14: 0000000000000000 R15: 00007ffe61a=
f79ac
[    8.027501]  </TASK>
[    8.027503] ---[ end trace 0000000000000000 ]---
[    8.027987] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[    8.028404] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    8.028407] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[    8.028410] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[    8.028413] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[    8.028416] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[    8.028419] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[    8.028421] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[    8.028424] iwlwifi 0000:00:14.3: 0x004C3468 | interruptlink1
[    8.028426] iwlwifi 0000:00:14.3: 0x004C3468 | interruptlink2
[    8.028428] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[    8.028431] iwlwifi 0000:00:14.3: 0x00001000 | data2
[    8.028433] iwlwifi 0000:00:14.3: 0x00000000 | data3
[    8.028435] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[    8.028437] iwlwifi 0000:00:14.3: 0x00025E44 | tsf low
[    8.028440] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[    8.028442] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[    8.028444] iwlwifi 0000:00:14.3: 0x0002BB55 | time gp2
[    8.028446] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[    8.028449] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[    8.028451] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[    8.028454] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[    8.028456] iwlwifi 0000:00:14.3: 0x00489001 | board version
[    8.028458] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[    8.028460] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[    8.028462] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[    8.028464] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[    8.028467] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[    8.028469] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[    8.028471] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[    8.028473] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[    8.028476] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[    8.028478] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[    8.028480] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[    8.028482] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[    8.028484] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[    8.028487] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[    8.028489] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[    8.028937] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    8.028939] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[    8.028942] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[    8.028945] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[    8.028947] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[    8.028949] iwlwifi 0000:00:14.3: 0x8046E0A8 | umac interruptlink1
[    8.028951] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[    8.028954] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[    8.028956] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[    8.028958] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[    8.028960] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[    8.028963] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[    8.028965] iwlwifi 0000:00:14.3: 0x0002BB50 | frame pointer
[    8.028967] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[    8.028969] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[    8.028971] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[    8.029106] iwlwifi 0000:00:14.3: IML/ROM dump:
[    8.029108] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[    8.029223] iwlwifi 0000:00:14.3: 0x00005833 | IML/ROM data1
[    8.029318] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[    8.029337] iwlwifi 0000:00:14.3: Fseq Registers:
[    8.029364] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[    8.029392] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[    8.029429] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[    8.029466] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[    8.029503] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[    8.029539] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[    8.029576] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[    8.029613] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[    8.029650] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[    8.029689] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[    8.029728] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[    8.029767] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[    8.029804] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[    8.029841] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[    8.029878] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[    8.029915] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[    8.030023] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[    8.030063] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[    8.030138] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[    8.030149] CPU: 0 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[    8.030158] Tainted: [U]=3DUSER, [W]=3DWARN
[    8.030160] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[    8.030163] Call Trace:
[    8.030166]  <TASK>
[    8.030171]  dump_stack_lvl+0x5d/0x80
[    8.030187]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[    8.030258]  ? __pfx_autoremove_wake_function+0x10/0x10
[    8.030267]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[    8.030340]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[    8.030410]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[    8.030481]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[    8.030540]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[    8.030595]  drv_add_interface+0x50/0x240 [mac80211]
[    8.030784]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[    8.030930]  ieee80211_do_open+0x57b/0x720 [mac80211]
[    8.031073]  ieee80211_open+0xa2/0xb0 [mac80211]
[    8.031211]  __dev_open+0x11b/0x2b0
[    8.031218]  __dev_change_flags+0x1fc/0x240
[    8.031225]  netif_change_flags+0x27/0x70
[    8.031231]  do_setlink.isra.0+0x325/0xcd0
[    8.031237]  ? cred_has_capability.isra.0+0xa4/0x150
[    8.031245]  ? __rtnl_newlink+0x1ee/0x3e0
[    8.031252]  rtnl_newlink+0x469/0x860
[    8.031261]  ? __pfx_rtnl_newlink+0x10/0x10
[    8.031267]  rtnetlink_rcv_msg+0x372/0x450
[    8.031274]  ? avc_has_perm+0x59/0xe0
[    8.031280]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    8.031285]  netlink_rcv_skb+0x5c/0x110
[    8.031294]  netlink_unicast+0x26f/0x3a0
[    8.031300]  netlink_sendmsg+0x207/0x440
[    8.031307]  ____sys_sendmsg+0x39f/0x3d0
[    8.031313]  ? import_iovec+0x1b/0x30
[    8.031321]  ___sys_sendmsg+0x99/0xe0
[    8.031334]  __sys_sendmsg+0x8a/0xf0
[    8.031342]  do_syscall_64+0x82/0x2c0
[    8.031351]  ? pollwake+0x77/0xa0
[    8.031356]  ? __pfx_default_wake_function+0x10/0x10
[    8.031365]  ? __wake_up_common+0x6f/0xa0
[    8.031372]  ? eventfd_write+0xdb/0x210
[    8.031380]  ? __task_pid_nr_ns+0xb4/0xe0
[    8.031385]  ? __do_sys_getpid+0x1d/0x30
[    8.031390]  ? do_syscall_64+0x82/0x2c0
[    8.031397]  ? vfs_write+0xce/0x480
[    8.031403]  ? place_entity+0x94/0x140
[    8.031411]  ? reweight_entity+0x1ca/0x200
[    8.031418]  ? task_tick_fair+0x5e/0x640
[    8.031426]  ? nohz_balancer_kick+0x35/0x2d0
[    8.031431]  ? perf_event_task_tick+0x4f/0xb0
[    8.031439]  ? kick_ilb+0x4c/0x160
[    8.031444]  ? __pfx_tick_nohz_handler+0x10/0x10
[    8.031452]  ? update_process_times+0xa4/0xd0
[    8.031458]  ? tick_nohz_handler+0xb1/0x140
[    8.031465]  ? timerqueue_add+0xae/0xd0
[    8.031473]  ? __hrtimer_run_queues+0x143/0x2a0
[    8.031479]  ? ktime_get+0x3c/0xf0
[    8.031487]  ? lapic_next_deadline+0x26/0x30
[    8.031494]  ? clockevents_program_event+0xa8/0x120
[    8.031500]  ? hrtimer_update_next_event+0x7b/0xa0
[    8.031506]  ? hrtimer_interrupt+0x125/0x230
[    8.031513]  ? sched_clock+0x10/0x30
[    8.031517]  ? sched_clock_cpu+0xb/0x30
[    8.031523]  ? irqtime_account_irq+0x3c/0xc0
[    8.031529]  ? clear_bhb_loop+0x50/0xa0
[    8.031535]  ? clear_bhb_loop+0x50/0xa0
[    8.031540]  ? clear_bhb_loop+0x50/0xa0
[    8.031545]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    8.031551] RIP: 0033:0x7fa4f4c876c2
[    8.031557] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[    8.031561] RSP: 002b:00007ffe61af7778 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[    8.031568] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[    8.031572] RDX: 0000000000000000 RSI: 00007ffe61af7810 RDI: 00000000000=
0000d
[    8.031575] RBP: 00007ffe61af77b0 R08: 0000000000000000 R09: 00000000000=
00000
[    8.031578] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[    8.031581] R13: 000000000000001c R14: 0000000000000000 R15: 00007ffe61a=
f79ac
[    8.031588]  </TASK>
[    8.031635] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[    8.031676] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   13.097206] ------------[ cut here ]------------
[   13.097215] WARNING: CPU: 5 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   13.097304] Modules linked in: overlay xt_comment nft_compat nf_conntrac=
k_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 =
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft=
_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr=
 sunrpc binfmt_misc snd_soc_skl_hda_dsp snd_soc_intel_sof_board_helpers snd=
_sof_probes snd_soc_intel_hda_dsp_common snd_soc_dmic snd_hda_codec_realtek=
 snd_hda_codec_generic snd_hda_scodec_component snd_sof_pci_intel_tgl snd_s=
of_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hd=
a_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink=
 snd_sof_intel_hda snd_hda_codec_hdmi soundwire_cadence snd_sof_pci snd_sof=
_xtensa_dsp snd_sof snd_sof_utils iwlmvm snd_soc_acpi_intel_match snd_soc_a=
cpi_intel_sdca_quirks soundwire_generic_allocation snd_soc_acpi crc8 soundw=
ire_bus snd_soc_sdca mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_cor=
e libarc4 snd_soc_core snd_compress ac97_bus
[   13.097434]  snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg snd_intel_=
sdw_acpi intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec=
 uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep uvc mei_hdcp videobuf2_v=
malloc x86_pkg_temp_thermal snd_seq intel_powerclamp videobuf2_memops iTCO_=
wdt videobuf2_v4l2 coretemp videobuf2_common snd_seq_device processor_therm=
al_device_pci_legacy iwlwifi mei_pxp think_lmi processor_thermal_device int=
el_pmc_bxt videodev processor_thermal_wt_hint iTCO_vendor_support rapl spi_=
nor vfat platform_temperature_control intel_cstate fat mtd intel_rapl_msr i=
ntel_uncore mc pcspkr firmware_attributes_class wmi_bmof snd_pcm snd_ctl_le=
d processor_thermal_rfim processor_thermal_rapl i2c_i801 mei_me spi_intel_p=
ci intel_rapl_common cfg80211 i2c_smbus spi_intel idma64 snd_timer mei proc=
essor_thermal_wt_req processor_thermal_power_floor processor_thermal_mbox i=
ntel_soc_dts_iosf igen6_edac thinkpad_acpi platform_profile snd soundcore i=
nt3403_thermal int340x_thermal_zone soc_button_array
[   13.097555]  intel_pmc_core pmt_telemetry int3400_thermal intel_hid pmt_=
class acpi_tad acpi_pad sparse_keymap acpi_thermal_rel intel_pmc_ssram_tele=
metry joydev loop nfnetlink zram lz4hc_compress lz4_compress ucsi_acpi type=
c_ucsi typec xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpuvm drm_=
exec drm_gpusvm bnep btusb btrtl btintel btbcm btmtk bluetooth rfkill i915 =
i2c_algo_bit drm_buddy ttm nvme nvme_core drm_display_helper polyval_clmuln=
i ghash_clmulni_intel sha512_ssse3 hid_multitouch nvme_keyring sha1_ssse3 n=
vme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2c_hid video wmi pinctrl_=
tigerlake serio_raw i2c_dev fuse
[   13.097668] CPU: 5 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   13.097678] Tainted: [U]=3DUSER, [W]=3DWARN
[   13.097681] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   13.097685] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   13.097747] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   13.097752] RSP: 0018:ffffca55876e36f0 EFLAGS: 00010282
[   13.097759] RAX: 00000000ffffffff RBX: ffff88f1cfb7dc98 RCX: ffff88f1ca1=
2fafc
[   13.097763] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1ca1=
2fafc
[   13.097767] RBP: ffffca55876e3734 R08: 0000000000000308 R09: 00000000000=
00001
[   13.097771] R10: 0000000000000000 R11: ffff88f1ca120028 R12: 00000000000=
00000
[   13.097775] R13: ffff88f1ca132008 R14: 0000000000000001 R15: ffff88f1cfb=
7dc98
[   13.097779] FS:  00007f2267b25840(0000) GS:ffff88f55172e000(0000) knlGS:=
0000000000000000
[   13.097785] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.097789] CR2: 00007f7d9707f604 CR3: 000000010a8ab002 CR4: 0000000000f=
70ef0
[   13.097794] PKRU: 55555554
[   13.097797] Call Trace:
[   13.097804]  <TASK>
[   13.097811]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   13.097872]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   13.097926]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   13.097981]  drv_add_interface+0x50/0x240 [mac80211]
[   13.098139]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   13.098272]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   13.098405]  ieee80211_open+0xa2/0xb0 [mac80211]
[   13.098529]  __dev_open+0x11b/0x2b0
[   13.098540]  __dev_change_flags+0x1fc/0x240
[   13.098548]  netif_change_flags+0x27/0x70
[   13.098553]  dev_change_flags+0x40/0xb0
[   13.098561]  devinet_ioctl+0x583/0x790
[   13.098572]  inet_ioctl+0x1e9/0x200
[   13.098583]  sock_do_ioctl+0x7a/0x130
[   13.098594]  __x64_sys_ioctl+0x94/0xe0
[   13.098606]  ? put_user_ifreq+0x64/0x80
[   13.098613]  do_syscall_64+0x82/0x2c0
[   13.098624]  ? __x64_sys_ioctl+0x94/0xe0
[   13.098631]  ? do_syscall_64+0x82/0x2c0
[   13.098641]  ? ___sys_recvmsg+0x9e/0xe0
[   13.098652]  ? __sys_recvmsg+0x87/0xe0
[   13.098660]  ? do_syscall_64+0x82/0x2c0
[   13.098670]  ? do_syscall_64+0x82/0x2c0
[   13.098679]  ? __x64_sys_readlink+0x1e/0x30
[   13.098686]  ? do_syscall_64+0x82/0x2c0
[   13.098694]  ? do_syscall_64+0x82/0x2c0
[   13.098701]  ? clear_bhb_loop+0x50/0xa0
[   13.098708]  ? clear_bhb_loop+0x50/0xa0
[   13.098713]  ? clear_bhb_loop+0x50/0xa0
[   13.098720]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.098726] RIP: 0033:0x7f22674fdaad
[   13.098733] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   13.098739] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   13.098747] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   13.098750] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   13.098754] RBP: 00007ffc322cbae0 R08: 0000560087cc1870 R09: 00007f22675=
f6ac0
[   13.098757] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000000=
00001
[   13.098761] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
c1360
[   13.098768]  </TASK>
[   13.098771] ---[ end trace 0000000000000000 ]---
[   13.099619] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   13.101021] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   13.101027] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   13.101032] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   13.101036] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   13.101040] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   13.101044] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   13.101047] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   13.101050] iwlwifi 0000:00:14.3: 0x004C8A12 | interruptlink1
[   13.101054] iwlwifi 0000:00:14.3: 0x004C8A12 | interruptlink2
[   13.101058] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   13.101062] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   13.101066] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   13.101069] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   13.101073] iwlwifi 0000:00:14.3: 0x0002B21C | tsf low
[   13.101076] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   13.101080] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   13.101084] iwlwifi 0000:00:14.3: 0x000312C0 | time gp2
[   13.101088] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   13.101091] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   13.101095] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   13.101099] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   13.101103] iwlwifi 0000:00:14.3: 0x00489001 | board version
[   13.101107] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   13.101111] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   13.101115] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   13.101119] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   13.101123] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   13.101126] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   13.101130] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   13.101134] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   13.101138] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   13.101141] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   13.101145] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   13.101149] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   13.101152] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   13.101156] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   13.101159] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   13.101670] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   13.101673] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   13.101677] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   13.101682] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   13.101685] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   13.101689] iwlwifi 0000:00:14.3: 0xC0081228 | umac interruptlink1
[   13.101693] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   13.101697] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   13.101701] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   13.101705] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   13.101708] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   13.101712] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   13.101716] iwlwifi 0000:00:14.3: 0x000312BB | frame pointer
[   13.101719] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   13.101723] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   13.101727] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   13.101923] iwlwifi 0000:00:14.3: IML/ROM dump:
[   13.101927] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   13.102195] iwlwifi 0000:00:14.3: 0x00005B2E | IML/ROM data1
[   13.102314] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   13.102386] iwlwifi 0000:00:14.3: Fseq Registers:
[   13.102441] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   13.102494] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   13.102547] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   13.102599] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   13.102653] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   13.102706] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   13.102758] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   13.102812] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   13.102865] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   13.102920] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   13.102975] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   13.103035] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   13.103206] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   13.103259] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   13.103311] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   13.103365] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   13.103489] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   13.103542] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   13.103618] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   13.103625] CPU: 5 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   13.103634] Tainted: [U]=3DUSER, [W]=3DWARN
[   13.103636] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   13.103639] Call Trace:
[   13.103642]  <TASK>
[   13.103646]  dump_stack_lvl+0x5d/0x80
[   13.103661]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   13.103724]  ? __pfx_autoremove_wake_function+0x10/0x10
[   13.103733]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   13.103794]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   13.103854]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   13.103912]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   13.103963]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   13.104011]  drv_add_interface+0x50/0x240 [mac80211]
[   13.104129]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   13.104255]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   13.104379]  ieee80211_open+0xa2/0xb0 [mac80211]
[   13.104495]  __dev_open+0x11b/0x2b0
[   13.104505]  __dev_change_flags+0x1fc/0x240
[   13.104511]  netif_change_flags+0x27/0x70
[   13.104516]  dev_change_flags+0x40/0xb0
[   13.104522]  devinet_ioctl+0x583/0x790
[   13.104531]  inet_ioctl+0x1e9/0x200
[   13.104540]  sock_do_ioctl+0x7a/0x130
[   13.104548]  __x64_sys_ioctl+0x94/0xe0
[   13.104557]  ? put_user_ifreq+0x64/0x80
[   13.104562]  do_syscall_64+0x82/0x2c0
[   13.104572]  ? __x64_sys_ioctl+0x94/0xe0
[   13.104579]  ? do_syscall_64+0x82/0x2c0
[   13.104587]  ? ___sys_recvmsg+0x9e/0xe0
[   13.104596]  ? __sys_recvmsg+0x87/0xe0
[   13.104603]  ? do_syscall_64+0x82/0x2c0
[   13.104611]  ? do_syscall_64+0x82/0x2c0
[   13.104618]  ? __x64_sys_readlink+0x1e/0x30
[   13.104624]  ? do_syscall_64+0x82/0x2c0
[   13.104630]  ? do_syscall_64+0x82/0x2c0
[   13.104636]  ? clear_bhb_loop+0x50/0xa0
[   13.104641]  ? clear_bhb_loop+0x50/0xa0
[   13.104645]  ? clear_bhb_loop+0x50/0xa0
[   13.104650]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.104655] RIP: 0033:0x7f22674fdaad
[   13.104660] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   13.104664] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   13.104670] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   13.104673] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   13.104676] RBP: 00007ffc322cbae0 R08: 0000560087cc1870 R09: 00007f22675=
f6ac0
[   13.104678] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000000=
00001
[   13.104681] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
c1360
[   13.104687]  </TASK>
[   13.104722] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   13.104734] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   19.706935] iwlwifi 0000:00:14.3: Device error - SW reset
[   19.708792] ieee80211 phy0: Hardware restart was requested
[   19.938233] ------------[ cut here ]------------
[   19.938242] WARNING: CPU: 6 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   19.938332] Modules linked in: overlay xt_comment nft_compat nf_conntrac=
k_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 =
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft=
_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr=
 sunrpc binfmt_misc snd_soc_skl_hda_dsp snd_soc_intel_sof_board_helpers snd=
_sof_probes snd_soc_intel_hda_dsp_common snd_soc_dmic snd_hda_codec_realtek=
 snd_hda_codec_generic snd_hda_scodec_component snd_sof_pci_intel_tgl snd_s=
of_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hd=
a_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink=
 snd_sof_intel_hda snd_hda_codec_hdmi soundwire_cadence snd_sof_pci snd_sof=
_xtensa_dsp snd_sof snd_sof_utils iwlmvm snd_soc_acpi_intel_match snd_soc_a=
cpi_intel_sdca_quirks soundwire_generic_allocation snd_soc_acpi crc8 soundw=
ire_bus snd_soc_sdca mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_cor=
e libarc4 snd_soc_core snd_compress ac97_bus
[   19.938456]  snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg snd_intel_=
sdw_acpi intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec=
 uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep uvc mei_hdcp videobuf2_v=
malloc x86_pkg_temp_thermal snd_seq intel_powerclamp videobuf2_memops iTCO_=
wdt videobuf2_v4l2 coretemp videobuf2_common snd_seq_device processor_therm=
al_device_pci_legacy iwlwifi mei_pxp think_lmi processor_thermal_device int=
el_pmc_bxt videodev processor_thermal_wt_hint iTCO_vendor_support rapl spi_=
nor vfat platform_temperature_control intel_cstate fat mtd intel_rapl_msr i=
ntel_uncore mc pcspkr firmware_attributes_class wmi_bmof snd_pcm snd_ctl_le=
d processor_thermal_rfim processor_thermal_rapl i2c_i801 mei_me spi_intel_p=
ci intel_rapl_common cfg80211 i2c_smbus spi_intel idma64 snd_timer mei proc=
essor_thermal_wt_req processor_thermal_power_floor processor_thermal_mbox i=
ntel_soc_dts_iosf igen6_edac thinkpad_acpi platform_profile snd soundcore i=
nt3403_thermal int340x_thermal_zone soc_button_array
[   19.938597]  intel_pmc_core pmt_telemetry int3400_thermal intel_hid pmt_=
class acpi_tad acpi_pad sparse_keymap acpi_thermal_rel intel_pmc_ssram_tele=
metry joydev loop nfnetlink zram lz4hc_compress lz4_compress ucsi_acpi type=
c_ucsi typec xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpuvm drm_=
exec drm_gpusvm bnep btusb btrtl btintel btbcm btmtk bluetooth rfkill i915 =
i2c_algo_bit drm_buddy ttm nvme nvme_core drm_display_helper polyval_clmuln=
i ghash_clmulni_intel sha512_ssse3 hid_multitouch nvme_keyring sha1_ssse3 n=
vme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2c_hid video wmi pinctrl_=
tigerlake serio_raw i2c_dev fuse
[   19.938720] CPU: 6 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   19.938730] Tainted: [U]=3DUSER, [W]=3DWARN
[   19.938733] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   19.938737] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   19.938799] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   19.938805] RSP: 0018:ffffca55876e3870 EFLAGS: 00010282
[   19.938812] RAX: 00000000ffffffff RBX: ffff88f1cfb7dc98 RCX: ffff88f1ca1=
2fafc
[   19.938817] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1ca1=
2fafc
[   19.938821] RBP: ffffca55876e38b4 R08: 0000000000000308 R09: 00000000000=
00001
[   19.938825] R10: 0000000000000000 R11: ffff88f1ca120028 R12: 00000000000=
00000
[   19.938829] R13: ffff88f1ca132008 R14: 0000000000000001 R15: ffff88f1cfb=
7dc98
[   19.938833] FS:  00007f2267b25840(0000) GS:ffff88f5517ae000(0000) knlGS:=
0000000000000000
[   19.938838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.938843] CR2: 000055aa38cae7f8 CR3: 000000010a8ab006 CR4: 0000000000f=
70ef0
[   19.938848] PKRU: 55555554
[   19.938851] Call Trace:
[   19.938857]  <TASK>
[   19.938864]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   19.938925]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   19.938992]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   19.939048]  drv_add_interface+0x50/0x240 [mac80211]
[   19.939188]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   19.939324]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   19.939451]  ieee80211_open+0xa2/0xb0 [mac80211]
[   19.939568]  __dev_open+0x11b/0x2b0
[   19.939578]  __dev_change_flags+0x1fc/0x240
[   19.939587]  netif_change_flags+0x27/0x70
[   19.939593]  dev_change_flags+0x40/0xb0
[   19.939600]  devinet_ioctl+0x583/0x790
[   19.939610]  inet_ioctl+0x1e9/0x200
[   19.939622]  sock_do_ioctl+0x7a/0x130
[   19.939633]  __x64_sys_ioctl+0x94/0xe0
[   19.939644]  do_syscall_64+0x82/0x2c0
[   19.939654]  ? sk_ioctl+0x4d/0x110
[   19.939663]  ? inet_ioctl+0x1bb/0x200
[   19.939671]  ? dev_get_by_name_rcu+0x67/0x80
[   19.939678]  ? dev_get_by_name_rcu+0x67/0x80
[   19.939682]  ? __check_object_size.part.0+0x34/0xc0
[   19.939690]  ? put_user_ifreq+0x64/0x80
[   19.939697]  ? sock_do_ioctl+0x107/0x130
[   19.939705]  ? __x64_sys_ioctl+0x94/0xe0
[   19.939713]  ? do_syscall_64+0x82/0x2c0
[   19.939722]  ? __x64_sys_readlink+0x1e/0x30
[   19.939730]  ? do_syscall_64+0x82/0x2c0
[   19.939738]  ? clear_bhb_loop+0x50/0xa0
[   19.939745]  ? clear_bhb_loop+0x50/0xa0
[   19.939750]  ? clear_bhb_loop+0x50/0xa0
[   19.939756]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.939763] RIP: 0033:0x7f22674fdaad
[   19.939771] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   19.939776] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   19.939784] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   19.939788] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   19.939792] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00007f22675=
f6ac0
[   19.939796] R10: 0000560087ccb0d0 R11: 0000000000000246 R12: 00000000000=
00001
[   19.939800] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   19.939807]  </TASK>
[   19.939810] ---[ end trace 0000000000000000 ]---
[   19.940665] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   19.942126] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   19.942132] iwlwifi 0000:00:14.3: Transport status: 0x0000024B, valid: 6
[   19.942138] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   19.942143] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   19.942148] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   19.942151] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   19.942154] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   19.942158] iwlwifi 0000:00:14.3: 0x004C345E | interruptlink1
[   19.942161] iwlwifi 0000:00:14.3: 0x004C345E | interruptlink2
[   19.942163] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   19.942167] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   19.942170] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   19.942173] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   19.942176] iwlwifi 0000:00:14.3: 0x0002AFFB | tsf low
[   19.942179] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   19.942182] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   19.942185] iwlwifi 0000:00:14.3: 0x0003108D | time gp2
[   19.942188] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   19.942191] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   19.942194] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   19.942198] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   19.942201] iwlwifi 0000:00:14.3: 0x00489001 | board version
[   19.942204] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   19.942207] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   19.942210] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   19.942213] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   19.942216] iwlwifi 0000:00:14.3: 0x04C3000C | isr3
[   19.942219] iwlwifi 0000:00:14.3: 0x00000002 | isr4
[   19.942222] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   19.942225] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   19.942228] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   19.942231] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   19.942234] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   19.942237] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   19.942240] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   19.942243] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   19.942246] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   19.942753] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   19.942756] iwlwifi 0000:00:14.3: Transport status: 0x0000024B, valid: 7
[   19.942761] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   19.942765] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   19.942769] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   19.942773] iwlwifi 0000:00:14.3: 0xC00829DE | umac interruptlink1
[   19.942777] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   19.942781] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   19.942784] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   19.942788] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   19.942792] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   19.942795] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   19.942799] iwlwifi 0000:00:14.3: 0x00031088 | frame pointer
[   19.942802] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   19.942806] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   19.942810] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   19.943036] iwlwifi 0000:00:14.3: IML/ROM dump:
[   19.943040] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   19.943154] iwlwifi 0000:00:14.3: 0x00005B21 | IML/ROM data1
[   19.943176] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   19.943240] iwlwifi 0000:00:14.3: Fseq Registers:
[   19.943293] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   19.943346] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   19.943399] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   19.943451] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   19.943504] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   19.943557] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   19.943612] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   19.943667] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   19.943720] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   19.943775] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   19.943832] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   19.943889] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   19.943947] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   19.944119] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   19.944172] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   19.944227] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   19.944350] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   19.944403] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   19.944500] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   19.944511] CPU: 7 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   19.944519] Tainted: [U]=3DUSER, [W]=3DWARN
[   19.944520] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   19.944522] Call Trace:
[   19.944525]  <TASK>
[   19.944529]  dump_stack_lvl+0x5d/0x80
[   19.944544]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   19.944593]  ? __pfx_autoremove_wake_function+0x10/0x10
[   19.944601]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   19.944652]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   19.944703]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   19.944753]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   19.944792]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   19.944827]  drv_add_interface+0x50/0x240 [mac80211]
[   19.944914]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   19.945019]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   19.945112]  ieee80211_open+0xa2/0xb0 [mac80211]
[   19.945200]  __dev_open+0x11b/0x2b0
[   19.945206]  __dev_change_flags+0x1fc/0x240
[   19.945210]  netif_change_flags+0x27/0x70
[   19.945214]  dev_change_flags+0x40/0xb0
[   19.945219]  devinet_ioctl+0x583/0x790
[   19.945226]  inet_ioctl+0x1e9/0x200
[   19.945233]  sock_do_ioctl+0x7a/0x130
[   19.945240]  __x64_sys_ioctl+0x94/0xe0
[   19.945248]  do_syscall_64+0x82/0x2c0
[   19.945256]  ? sk_ioctl+0x4d/0x110
[   19.945262]  ? inet_ioctl+0x1bb/0x200
[   19.945267]  ? dev_get_by_name_rcu+0x67/0x80
[   19.945271]  ? dev_get_by_name_rcu+0x67/0x80
[   19.945274]  ? __check_object_size.part.0+0x34/0xc0
[   19.945279]  ? put_user_ifreq+0x64/0x80
[   19.945283]  ? sock_do_ioctl+0x107/0x130
[   19.945288]  ? __x64_sys_ioctl+0x94/0xe0
[   19.945294]  ? do_syscall_64+0x82/0x2c0
[   19.945300]  ? __x64_sys_readlink+0x1e/0x30
[   19.945306]  ? do_syscall_64+0x82/0x2c0
[   19.945311]  ? clear_bhb_loop+0x50/0xa0
[   19.945316]  ? clear_bhb_loop+0x50/0xa0
[   19.945319]  ? clear_bhb_loop+0x50/0xa0
[   19.945323]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.945327] RIP: 0033:0x7f22674fdaad
[   19.945332] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   19.945334] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   19.945339] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   19.945342] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   19.945344] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00007f22675=
f6ac0
[   19.945346] R10: 0000560087ccb0d0 R11: 0000000000000246 R12: 00000000000=
00001
[   19.945348] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   19.945352]  </TASK>
[   19.945384] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   19.945405] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   26.442355] iwlwifi 0000:00:14.3: Device error - reprobe!
[   26.489163] iwlwifi 0000:00:14.3: Unregistering PHC clock: iwlwifi-PTP, =
with index: 0
[   26.524829] fs-verity: sha256 using implementation "sha256-x86"
[   26.585583] evm: overlay not supported
[   26.602785] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[   26.603012] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=3D0x351, rfid=
=3D0x10a100
[   26.603016] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[   26.664123] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[   26.664616] iwlwifi 0000:00:14.3: loaded firmware version 77.864baa2e.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[   26.805196] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[   26.877424] iwlwifi 0000:00:14.3: base HW address: 20:c1:9b:dc:2d:c8
[   26.914568] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   26.916369] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   27.146109] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[   27.147431] ------------[ cut here ]------------
[   27.147435] WARNING: CPU: 2 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   27.147496] Modules linked in: xt_MASQUERADE(+) bridge stp llc xt_set ip=
_set xt_addrtype overlay xt_comment nft_compat nf_conntrack_netbios_ns nf_c=
onntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_rejec=
t_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_mi=
sc snd_soc_skl_hda_dsp snd_soc_intel_sof_board_helpers snd_sof_probes snd_s=
oc_intel_hda_dsp_common snd_soc_dmic snd_hda_codec_realtek snd_hda_codec_ge=
neric snd_hda_scodec_component snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl =
snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof=
_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hd=
a snd_hda_codec_hdmi soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_s=
of snd_sof_utils iwlmvm snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_qu=
irks soundwire_generic_allocation snd_soc_acpi crc8 soundwire_bus snd_soc_s=
dca mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core
[   27.147576]  libarc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengin=
e snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency =
intel_uncore_frequency_common snd_hda_codec uvcvideo snd_hda_core intel_tcc=
_cooling snd_hwdep uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_=
seq intel_powerclamp videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp vide=
obuf2_common snd_seq_device processor_thermal_device_pci_legacy iwlwifi mei=
_pxp think_lmi processor_thermal_device intel_pmc_bxt videodev processor_th=
ermal_wt_hint iTCO_vendor_support rapl spi_nor vfat platform_temperature_co=
ntrol intel_cstate fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_a=
ttributes_class wmi_bmof snd_pcm snd_ctl_led processor_thermal_rfim process=
or_thermal_rapl i2c_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2=
c_smbus spi_intel idma64 snd_timer mei processor_thermal_wt_req processor_t=
hermal_power_floor processor_thermal_mbox intel_soc_dts_iosf igen6_edac thi=
nkpad_acpi platform_profile snd soundcore int3403_thermal
[   27.147701]  int340x_thermal_zone soc_button_array intel_pmc_core pmt_te=
lemetry int3400_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap=
 acpi_thermal_rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4h=
c_compress lz4_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_su=
balloc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btin=
tel btbcm btmtk bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_=
core drm_display_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hi=
d_multitouch nvme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i=
2c_hid_acpi i2c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   27.147774] CPU: 2 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   27.147781] Tainted: [U]=3DUSER, [W]=3DWARN
[   27.147783] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   27.147786] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   27.147825] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   27.147829] RSP: 0018:ffffca55873e3588 EFLAGS: 00010282
[   27.147833] RAX: 00000000ffffffff RBX: ffff88f1c46bdc98 RCX: ffff88f1c4d=
bdafc
[   27.147836] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c4d=
bdafc
[   27.147838] RBP: ffffca55873e35cc R08: 0000000000000308 R09: 00000000000=
00001
[   27.147841] R10: 0000000000000000 R11: ffff88f1ca120028 R12: 00000000000=
00000
[   27.147843] R13: ffff88f1c3e4a008 R14: 0000000000000001 R15: ffff88f1c46=
bdc98
[   27.147845] FS:  00007fa4f48b75c0(0000) GS:ffff88f5515ae000(0000) knlGS:=
0000000000000000
[   27.147848] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.147851] CR2: 0000556e9806b088 CR3: 00000001640fb005 CR4: 0000000000f=
70ef0
[   27.147865] PKRU: 55555554
[   27.147868] Call Trace:
[   27.147874]  <TASK>
[   27.147881]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   27.147938]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   27.147989]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   27.148039]  drv_add_interface+0x50/0x240 [mac80211]
[   27.148171]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   27.148307]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   27.148441]  ieee80211_open+0xa2/0xb0 [mac80211]
[   27.148562]  __dev_open+0x11b/0x2b0
[   27.148573]  __dev_change_flags+0x1fc/0x240
[   27.148579]  ? avc_has_perm+0x59/0xe0
[   27.148590]  netif_change_flags+0x27/0x70
[   27.148596]  do_setlink.isra.0+0x325/0xcd0
[   27.148604]  ? cred_has_capability.isra.0+0xa4/0x150
[   27.148614]  ? __rtnl_newlink+0x1ee/0x3e0
[   27.148621]  rtnl_newlink+0x469/0x860
[   27.148629]  ? proc_get_long.constprop.0+0x128/0x1a0
[   27.148640]  ? __pfx_rtnl_newlink+0x10/0x10
[   27.148647]  rtnetlink_rcv_msg+0x372/0x450
[   27.148654]  ? avc_has_perm+0x59/0xe0
[   27.148661]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   27.148667]  netlink_rcv_skb+0x5c/0x110
[   27.148678]  netlink_unicast+0x26f/0x3a0
[   27.148685]  netlink_sendmsg+0x207/0x440
[   27.148693]  ____sys_sendmsg+0x39f/0x3d0
[   27.148701]  ? import_iovec+0x1b/0x30
[   27.148711]  ___sys_sendmsg+0x99/0xe0
[   27.148725]  __sys_sendmsg+0x8a/0xf0
[   27.148733]  do_syscall_64+0x82/0x2c0
[   27.148744]  ? __x64_sys_close+0x3d/0x80
[   27.148755]  ? __x64_sys_close+0x3d/0x80
[   27.148763]  ? do_syscall_64+0x82/0x2c0
[   27.148770]  ? do_syscall_64+0x82/0x2c0
[   27.148778]  ? __x64_sys_openat+0x61/0xa0
[   27.148785]  ? do_syscall_64+0x82/0x2c0
[   27.148793]  ? clear_bhb_loop+0x50/0xa0
[   27.148800]  ? clear_bhb_loop+0x50/0xa0
[   27.148806]  ? clear_bhb_loop+0x50/0xa0
[   27.148812]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   27.148819] RIP: 0033:0x7fa4f4c876c2
[   27.148825] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   27.148830] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   27.148837] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   27.148841] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   27.148845] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   27.148849] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   27.148875] R13: 0000000000000050 R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   27.148882]  </TASK>
[   27.148885] ---[ end trace 0000000000000000 ]---
[   27.149737] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   27.150913] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   27.150918] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   27.150923] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   27.150927] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   27.150932] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   27.150936] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   27.150940] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   27.150944] iwlwifi 0000:00:14.3: 0x004C8A0A | interruptlink1
[   27.150948] iwlwifi 0000:00:14.3: 0x004C8A0A | interruptlink2
[   27.150952] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   27.150956] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   27.150960] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   27.150964] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   27.150969] iwlwifi 0000:00:14.3: 0x0002B5F3 | tsf low
[   27.150973] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   27.150977] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   27.150981] iwlwifi 0000:00:14.3: 0x00031685 | time gp2
[   27.150986] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   27.150989] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   27.150993] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   27.150997] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   27.151001] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   27.151005] iwlwifi 0000:00:14.3: 0x00130148 | hcmd
[   27.151009] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   27.151013] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   27.151016] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   27.151021] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   27.151025] iwlwifi 0000:00:14.3: 0x00000002 | isr4
[   27.151029] iwlwifi 0000:00:14.3: 0x00130148 | last cmd Id
[   27.151037] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   27.151041] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   27.151046] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   27.151050] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   27.151054] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   27.151059] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   27.151063] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   27.151068] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   27.151576] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   27.151580] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   27.151585] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   27.151591] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   27.151595] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   27.151599] iwlwifi 0000:00:14.3: 0xC00829DE | umac interruptlink1
[   27.151604] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   27.151608] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   27.151612] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   27.151616] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   27.151620] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   27.151624] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   27.151629] iwlwifi 0000:00:14.3: 0x00031680 | frame pointer
[   27.151633] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   27.151638] iwlwifi 0000:00:14.3: 0x00140308 | last host cmd
[   27.151642] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   27.151829] iwlwifi 0000:00:14.3: IML/ROM dump:
[   27.151833] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   27.151982] iwlwifi 0000:00:14.3: 0x00005B4D | IML/ROM data1
[   27.152098] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   27.152169] iwlwifi 0000:00:14.3: Fseq Registers:
[   27.152222] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   27.152275] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   27.152328] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   27.152381] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   27.152434] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   27.152487] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   27.152540] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   27.152593] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   27.152646] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   27.152701] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   27.152756] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   27.152811] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   27.152869] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   27.153040] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   27.153097] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   27.153148] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   27.153272] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   27.153325] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   27.153379] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   27.153387] CPU: 2 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   27.153393] Tainted: [U]=3DUSER, [W]=3DWARN
[   27.153395] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   27.153397] Call Trace:
[   27.153400]  <TASK>
[   27.153403]  dump_stack_lvl+0x5d/0x80
[   27.153418]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   27.153473]  ? __pfx_autoremove_wake_function+0x10/0x10
[   27.153481]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   27.153532]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   27.153582]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   27.153626]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   27.153663]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   27.153695]  drv_add_interface+0x50/0x240 [mac80211]
[   27.153782]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   27.153884]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   27.153983]  ieee80211_open+0xa2/0xb0 [mac80211]
[   27.154072]  __dev_open+0x11b/0x2b0
[   27.154078]  __dev_change_flags+0x1fc/0x240
[   27.154081]  ? avc_has_perm+0x59/0xe0
[   27.154088]  netif_change_flags+0x27/0x70
[   27.154091]  do_setlink.isra.0+0x325/0xcd0
[   27.154096]  ? cred_has_capability.isra.0+0xa4/0x150
[   27.154102]  ? __rtnl_newlink+0x1ee/0x3e0
[   27.154107]  rtnl_newlink+0x469/0x860
[   27.154111]  ? proc_get_long.constprop.0+0x128/0x1a0
[   27.154119]  ? __pfx_rtnl_newlink+0x10/0x10
[   27.154123]  rtnetlink_rcv_msg+0x372/0x450
[   27.154127]  ? avc_has_perm+0x59/0xe0
[   27.154130]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   27.154134]  netlink_rcv_skb+0x5c/0x110
[   27.154140]  netlink_unicast+0x26f/0x3a0
[   27.154144]  netlink_sendmsg+0x207/0x440
[   27.154149]  ____sys_sendmsg+0x39f/0x3d0
[   27.154155]  ? import_iovec+0x1b/0x30
[   27.154161]  ___sys_sendmsg+0x99/0xe0
[   27.154170]  __sys_sendmsg+0x8a/0xf0
[   27.154175]  do_syscall_64+0x82/0x2c0
[   27.154183]  ? __x64_sys_close+0x3d/0x80
[   27.154190]  ? __x64_sys_close+0x3d/0x80
[   27.154197]  ? do_syscall_64+0x82/0x2c0
[   27.154204]  ? do_syscall_64+0x82/0x2c0
[   27.154210]  ? __x64_sys_openat+0x61/0xa0
[   27.154216]  ? do_syscall_64+0x82/0x2c0
[   27.154222]  ? clear_bhb_loop+0x50/0xa0
[   27.154227]  ? clear_bhb_loop+0x50/0xa0
[   27.154231]  ? clear_bhb_loop+0x50/0xa0
[   27.154237]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   27.154242] RIP: 0033:0x7fa4f4c876c2
[   27.154248] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   27.154252] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   27.154257] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   27.154261] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   27.154264] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   27.154267] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   27.154270] R13: 0000000000000050 R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   27.154277]  </TASK>
[   27.154304] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   27.154324] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   28.126658] rfkill: input handler disabled
[   30.234226] Bluetooth: RFCOMM TTY layer initialized
[   30.234238] Bluetooth: RFCOMM socket layer initialized
[   30.234244] Bluetooth: RFCOMM ver 1.11
[   30.654739] iwlwifi 0000:00:14.3: Device error - reprobe!
[   30.858781] ------------[ cut here ]------------
[   30.858786] WARNING: CPU: 5 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   30.858836] Modules linked in: xt_conntrack rfcomm snd_seq_dummy snd_hrt=
imer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay xt_comm=
ent nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet =
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_=
ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp snd_soc_i=
ntel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_=
dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component s=
nd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundw=
ire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_h=
da snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soundwire_c=
adence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm snd_soc_=
acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocatio=
n snd_soc_acpi crc8 soundwire_bus snd_soc_sdca mac80211
[   30.858888]  snd_soc_avs snd_soc_hda_codec snd_hda_ext_core libarc4 snd_=
soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_ds=
pcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_frequency_commo=
n snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep uvc mei_h=
dcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclamp videobu=
f2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_seq_device =
processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi processor_the=
rmal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_vendor_su=
pport rapl spi_nor vfat platform_temperature_control intel_cstate fat mtd i=
ntel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi_bmof snd=
_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c_i801 mei=
_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel idma64 snd=
_timer mei processor_thermal_wt_req processor_thermal_power_floor processor=
_thermal_mbox intel_soc_dts_iosf igen6_edac thinkpad_acpi
[   30.858939]  platform_profile snd soundcore int3403_thermal int340x_ther=
mal_zone soc_button_array intel_pmc_core pmt_telemetry int3400_thermal inte=
l_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_rel intel_pmc_=
ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4_compress ucsi=
_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_=
gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmtk bluetooth rf=
kill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_display_helper poly=
val_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch nvme_keyring sh=
a1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2c_hid video wm=
i pinctrl_tigerlake serio_raw i2c_dev fuse
[   30.858990] CPU: 5 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   30.858994] Tainted: [U]=3DUSER, [W]=3DWARN
[   30.858995] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   30.858997] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   30.859021] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   30.859024] RSP: 0018:ffffca55873e35d8 EFLAGS: 00010282
[   30.859026] RAX: 00000000ffffffff RBX: ffff88f1c46bdc98 RCX: ffff88f1c4d=
bdafc
[   30.859028] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c4d=
bdafc
[   30.859029] RBP: ffffca55873e361c R08: 0000000000000308 R09: 00000000000=
00001
[   30.859031] R10: ffffca55873e3410 R11: fffff91b44055800 R12: 00000000000=
00000
[   30.859032] R13: ffff88f1c3e4a008 R14: 0000000000000001 R15: ffff88f1c46=
bdc98
[   30.859034] FS:  00007fa4f48b75c0(0000) GS:ffff88f55172e000(0000) knlGS:=
0000000000000000
[   30.859035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.859037] CR2: 0000556e9ab9e000 CR3: 00000001640fb003 CR4: 0000000000f=
70ef0
[   30.859039] PKRU: 55555554
[   30.859040] Call Trace:
[   30.859043]  <TASK>
[   30.859047]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   30.859069]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   30.859087]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   30.859105]  ? rfkill_soft_blocked+0x27/0x40 [rfkill]
[   30.859110]  drv_add_interface+0x50/0x240 [mac80211]
[   30.859174]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   30.859223]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   30.859271]  ieee80211_open+0xa2/0xb0 [mac80211]
[   30.859314]  __dev_open+0x11b/0x2b0
[   30.859319]  __dev_change_flags+0x1fc/0x240
[   30.859322]  netif_change_flags+0x27/0x70
[   30.859324]  do_setlink.isra.0+0x325/0xcd0
[   30.859327]  ? cred_has_capability.isra.0+0xa4/0x150
[   30.859332]  ? __rtnl_newlink+0x1ee/0x3e0
[   30.859335]  rtnl_newlink+0x469/0x860
[   30.859338]  ? __pfx_rtnl_newlink+0x10/0x10
[   30.859340]  rtnetlink_rcv_msg+0x372/0x450
[   30.859343]  ? avc_has_perm+0x59/0xe0
[   30.859346]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   30.859348]  netlink_rcv_skb+0x5c/0x110
[   30.859352]  netlink_unicast+0x26f/0x3a0
[   30.859355]  netlink_sendmsg+0x207/0x440
[   30.859357]  ____sys_sendmsg+0x39f/0x3d0
[   30.859361]  ? import_iovec+0x1b/0x30
[   30.859366]  ___sys_sendmsg+0x99/0xe0
[   30.859369]  ? __do_sys_getpid+0x1d/0x30
[   30.859374]  __sys_sendmsg+0x8a/0xf0
[   30.859377]  do_syscall_64+0x82/0x2c0
[   30.859383]  ? do_syscall_64+0x82/0x2c0
[   30.859386]  ? do_syscall_64+0x82/0x2c0
[   30.859389]  ? clear_bhb_loop+0x50/0xa0
[   30.859392]  ? clear_bhb_loop+0x50/0xa0
[   30.859393]  ? clear_bhb_loop+0x50/0xa0
[   30.859396]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   30.859398] RIP: 0033:0x7fa4f4c876c2
[   30.859401] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   30.859402] RSP: 002b:00007ffe61af7968 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   30.859404] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   30.859406] RDX: 0000000000000000 RSI: 00007ffe61af7a00 RDI: 00000000000=
0000d
[   30.859407] RBP: 00007ffe61af79a0 R08: 0000000000000000 R09: 00000000000=
00000
[   30.859408] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   30.859409] R13: 0000000000000056 R14: 0000000000000000 R15: 00007ffe61a=
f7b9c
[   30.859411]  </TASK>
[   30.859412] ---[ end trace 0000000000000000 ]---
[   30.859890] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   30.860106] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   30.860107] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   30.860109] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   30.860111] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   30.860113] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   30.860114] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   30.860115] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   30.860116] iwlwifi 0000:00:14.3: 0x00019D84 | interruptlink1
[   30.860117] iwlwifi 0000:00:14.3: 0x00019D84 | interruptlink2
[   30.860118] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   30.860119] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   30.860120] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   30.860121] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   30.860122] iwlwifi 0000:00:14.3: 0x00025185 | tsf low
[   30.860123] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   30.860124] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   30.860125] iwlwifi 0000:00:14.3: 0x0002AE59 | time gp2
[   30.860127] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   30.860128] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   30.860129] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   30.860130] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   30.860131] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   30.860132] iwlwifi 0000:00:14.3: 0x8031FD22 | hcmd
[   30.860133] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   30.860134] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   30.860135] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   30.860136] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   30.860137] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   30.860138] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
[   30.860139] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   30.860141] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   30.860141] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   30.860143] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   30.860143] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   30.860145] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   30.860146] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   30.860147] iwlwifi 0000:00:14.3: 0x00000850 | flow_handler
[   30.860591] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   30.860592] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   30.860593] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   30.860595] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   30.860596] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   30.860597] iwlwifi 0000:00:14.3: 0x8046E092 | umac interruptlink1
[   30.860598] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   30.860599] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   30.860600] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   30.860601] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   30.860602] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   30.860603] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   30.860604] iwlwifi 0000:00:14.3: 0x0002AE54 | frame pointer
[   30.860605] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   30.860606] iwlwifi 0000:00:14.3: 0x00110308 | last host cmd
[   30.860607] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   30.860716] iwlwifi 0000:00:14.3: IML/ROM dump:
[   30.860717] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   30.860737] iwlwifi 0000:00:14.3: 0x000057FB | IML/ROM data1
[   30.860746] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   30.860752] iwlwifi 0000:00:14.3: Fseq Registers:
[   30.860755] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   30.860758] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   30.860761] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   30.860765] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   30.860768] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   30.860771] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   30.860774] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   30.860777] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   30.860780] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   30.860787] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   30.860824] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   30.860865] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   30.860888] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   30.860912] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   30.860936] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   30.860960] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   30.861003] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   30.861036] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   30.861057] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   30.861061] CPU: 5 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   30.861064] Tainted: [U]=3DUSER, [W]=3DWARN
[   30.861064] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   30.861065] Call Trace:
[   30.861066]  <TASK>
[   30.861067]  dump_stack_lvl+0x5d/0x80
[   30.861073]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   30.861106]  ? __pfx_autoremove_wake_function+0x10/0x10
[   30.861110]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   30.861135]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   30.861162]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   30.861185]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   30.861203]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   30.861221]  ? rfkill_soft_blocked+0x27/0x40 [rfkill]
[   30.861225]  drv_add_interface+0x50/0x240 [mac80211]
[   30.861264]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   30.861311]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   30.861357]  ieee80211_open+0xa2/0xb0 [mac80211]
[   30.861401]  __dev_open+0x11b/0x2b0
[   30.861403]  __dev_change_flags+0x1fc/0x240
[   30.861406]  netif_change_flags+0x27/0x70
[   30.861408]  do_setlink.isra.0+0x325/0xcd0
[   30.861410]  ? cred_has_capability.isra.0+0xa4/0x150
[   30.861413]  ? __rtnl_newlink+0x1ee/0x3e0
[   30.861415]  rtnl_newlink+0x469/0x860
[   30.861418]  ? __pfx_rtnl_newlink+0x10/0x10
[   30.861420]  rtnetlink_rcv_msg+0x372/0x450
[   30.861423]  ? avc_has_perm+0x59/0xe0
[   30.861424]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   30.861426]  netlink_rcv_skb+0x5c/0x110
[   30.861429]  netlink_unicast+0x26f/0x3a0
[   30.861431]  netlink_sendmsg+0x207/0x440
[   30.861433]  ____sys_sendmsg+0x39f/0x3d0
[   30.861436]  ? import_iovec+0x1b/0x30
[   30.861438]  ___sys_sendmsg+0x99/0xe0
[   30.861441]  ? __do_sys_getpid+0x1d/0x30
[   30.861444]  __sys_sendmsg+0x8a/0xf0
[   30.861447]  do_syscall_64+0x82/0x2c0
[   30.861450]  ? do_syscall_64+0x82/0x2c0
[   30.861453]  ? do_syscall_64+0x82/0x2c0
[   30.861455]  ? clear_bhb_loop+0x50/0xa0
[   30.861457]  ? clear_bhb_loop+0x50/0xa0
[   30.861459]  ? clear_bhb_loop+0x50/0xa0
[   30.861461]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   30.861463] RIP: 0033:0x7fa4f4c876c2
[   30.861464] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   30.861465] RSP: 002b:00007ffe61af7968 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   30.861467] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   30.861468] RDX: 0000000000000000 RSI: 00007ffe61af7a00 RDI: 00000000000=
0000d
[   30.861469] RBP: 00007ffe61af79a0 R08: 0000000000000000 R09: 00000000000=
00000
[   30.861470] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   30.861470] R13: 0000000000000056 R14: 0000000000000000 R15: 00007ffe61a=
f7b9c
[   30.861473]  </TASK>
[   30.861474] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   30.861484] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   31.949613] iwlwifi 0000:00:14.3: Device error - reprobe!
[   31.985968] iwlwifi 0000:00:14.3: Unregistering PHC clock: iwlwifi-PTP, =
with index: 0
[   32.099189] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[   32.099260] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=3D0x351, rfid=
=3D0x10a100
[   32.099263] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[   32.142301] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[   32.142636] iwlwifi 0000:00:14.3: loaded firmware version 77.864baa2e.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[   32.266480] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[   32.334035] iwlwifi 0000:00:14.3: base HW address: 20:c1:9b:dc:2d:c8
[   32.368734] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   32.572054] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[   32.572852] ------------[ cut here ]------------
[   32.572855] WARNING: CPU: 5 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   32.572919] Modules linked in: xt_conntrack rfcomm snd_seq_dummy snd_hrt=
imer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay xt_comm=
ent nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet =
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_=
ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp snd_soc_i=
ntel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_=
dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component s=
nd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundw=
ire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_h=
da snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soundwire_c=
adence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm snd_soc_=
acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocatio=
n snd_soc_acpi crc8 soundwire_bus snd_soc_sdca mac80211
[   32.572994]  snd_soc_avs snd_soc_hda_codec snd_hda_ext_core libarc4 snd_=
soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_ds=
pcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_frequency_commo=
n snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep uvc mei_h=
dcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclamp videobu=
f2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_seq_device =
processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi processor_the=
rmal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_vendor_su=
pport rapl spi_nor vfat platform_temperature_control intel_cstate fat mtd i=
ntel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi_bmof snd=
_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c_i801 mei=
_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel idma64 snd=
_timer mei processor_thermal_wt_req processor_thermal_power_floor processor=
_thermal_mbox intel_soc_dts_iosf igen6_edac thinkpad_acpi
[   32.573080]  platform_profile snd soundcore int3403_thermal int340x_ther=
mal_zone soc_button_array intel_pmc_core pmt_telemetry int3400_thermal inte=
l_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_rel intel_pmc_=
ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4_compress ucsi=
_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_=
gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmtk bluetooth rf=
kill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_display_helper poly=
val_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch nvme_keyring sh=
a1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2c_hid video wm=
i pinctrl_tigerlake serio_raw i2c_dev fuse
[   32.573162] CPU: 5 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   32.573169] Tainted: [U]=3DUSER, [W]=3DWARN
[   32.573171] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   32.573174] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   32.573215] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   32.573219] RSP: 0018:ffffca55873e3578 EFLAGS: 00010282
[   32.573223] RAX: 00000000ffffffff RBX: ffff88f26e3a9c98 RCX: ffff88f1ca1=
2cefc
[   32.573226] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1ca1=
2cefc
[   32.573229] RBP: ffffca55873e35bc R08: 0000000000000308 R09: 00000000000=
00001
[   32.573232] R10: ffffca55873e33b0 R11: fffff91b44055800 R12: 00000000000=
00000
[   32.573234] R13: ffff88f28fec2008 R14: 0000000000000001 R15: ffff88f26e3=
a9c98
[   32.573236] FS:  00007fa4f48b75c0(0000) GS:ffff88f55172e000(0000) knlGS:=
0000000000000000
[   32.573240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.573242] CR2: 000000c00088bf80 CR3: 00000001640fb004 CR4: 0000000000f=
70ef0
[   32.573245] PKRU: 55555554
[   32.573248] Call Trace:
[   32.573253]  <TASK>
[   32.573258]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   32.573298]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   32.573333]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   32.573368]  ? rfkill_soft_blocked+0x27/0x40 [rfkill]
[   32.573376]  drv_add_interface+0x50/0x240 [mac80211]
[   32.573463]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   32.573559]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   32.573653]  ieee80211_open+0xa2/0xb0 [mac80211]
[   32.573742]  __dev_open+0x11b/0x2b0
[   32.573750]  __dev_change_flags+0x1fc/0x240
[   32.573756]  netif_change_flags+0x27/0x70
[   32.573760]  do_setlink.isra.0+0x325/0xcd0
[   32.573765]  ? cred_has_capability.isra.0+0xa4/0x150
[   32.573773]  ? __rtnl_newlink+0x1ee/0x3e0
[   32.573778]  rtnl_newlink+0x469/0x860
[   32.573784]  ? __pfx_rtnl_newlink+0x10/0x10
[   32.573788]  rtnetlink_rcv_msg+0x372/0x450
[   32.573801]  ? avc_has_perm+0x59/0xe0
[   32.573807]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   32.573810]  netlink_rcv_skb+0x5c/0x110
[   32.573818]  netlink_unicast+0x26f/0x3a0
[   32.573823]  netlink_sendmsg+0x207/0x440
[   32.573827]  ____sys_sendmsg+0x39f/0x3d0
[   32.573835]  ? import_iovec+0x1b/0x30
[   32.573841]  ___sys_sendmsg+0x99/0xe0
[   32.573851]  __sys_sendmsg+0x8a/0xf0
[   32.573857]  do_syscall_64+0x82/0x2c0
[   32.573866]  ? do_syscall_64+0x82/0x2c0
[   32.573871]  ? do_syscall_64+0x82/0x2c0
[   32.573877]  ? __x64_sys_close+0x3d/0x80
[   32.573885]  ? do_syscall_64+0x82/0x2c0
[   32.573891]  ? do_syscall_64+0x82/0x2c0
[   32.573896]  ? __x64_sys_ioctl+0xb1/0xe0
[   32.573903]  ? do_syscall_64+0x82/0x2c0
[   32.573908]  ? clear_bhb_loop+0x50/0xa0
[   32.573914]  ? clear_bhb_loop+0x50/0xa0
[   32.573918]  ? clear_bhb_loop+0x50/0xa0
[   32.573922]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   32.573927] RIP: 0033:0x7fa4f4c876c2
[   32.573932] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   32.573935] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   32.573940] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   32.573942] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   32.573944] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   32.573946] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   32.573948] R13: 0000000000000088 R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   32.573953]  </TASK>
[   32.573955] ---[ end trace 0000000000000000 ]---
[   32.574423] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   32.575070] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   32.575073] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   32.575077] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   32.575079] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   32.575083] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   32.575085] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   32.575088] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   32.575090] iwlwifi 0000:00:14.3: 0x000156BA | interruptlink1
[   32.575093] iwlwifi 0000:00:14.3: 0x000156BA | interruptlink2
[   32.575095] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   32.575097] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   32.575099] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   32.575101] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   32.575103] iwlwifi 0000:00:14.3: 0x000258CA | tsf low
[   32.575106] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   32.575108] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   32.575110] iwlwifi 0000:00:14.3: 0x0002B5D4 | time gp2
[   32.575112] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   32.575114] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   32.575117] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   32.575119] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   32.575122] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   32.575124] iwlwifi 0000:00:14.3: 0x8032FD22 | hcmd
[   32.575126] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   32.575128] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   32.575130] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   32.575133] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   32.575135] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   32.575137] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
[   32.575139] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   32.575141] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   32.575143] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   32.575146] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   32.575148] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   32.575150] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   32.575152] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   32.575154] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   32.575599] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   32.575601] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   32.575604] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   32.575607] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   32.575609] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   32.575611] iwlwifi 0000:00:14.3: 0x804763B0 | umac interruptlink1
[   32.575613] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   32.575616] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   32.575618] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   32.575620] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   32.575622] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   32.575624] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   32.575626] iwlwifi 0000:00:14.3: 0x0002B5CF | frame pointer
[   32.575629] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   32.575631] iwlwifi 0000:00:14.3: 0x00120308 | last host cmd
[   32.575633] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   32.575746] iwlwifi 0000:00:14.3: IML/ROM dump:
[   32.575748] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   32.575897] iwlwifi 0000:00:14.3: 0x00005831 | IML/ROM data1
[   32.576015] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   32.576057] iwlwifi 0000:00:14.3: Fseq Registers:
[   32.576089] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   32.576117] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   32.576154] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   32.576196] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   32.576237] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   32.576279] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   32.576321] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   32.576363] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   32.576405] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   32.576448] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   32.576492] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   32.576537] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   32.576578] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   32.576620] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   32.576662] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   32.576705] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   32.576839] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   32.576883] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   32.576946] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   32.576959] CPU: 3 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   32.576970] Tainted: [U]=3DUSER, [W]=3DWARN
[   32.576972] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   32.576975] Call Trace:
[   32.576979]  <TASK>
[   32.576983]  dump_stack_lvl+0x5d/0x80
[   32.577001]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   32.577075]  ? __pfx_autoremove_wake_function+0x10/0x10
[   32.577086]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   32.577161]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   32.577232]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   32.577303]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   32.577363]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   32.577418]  ? rfkill_soft_blocked+0x27/0x40 [rfkill]
[   32.577429]  drv_add_interface+0x50/0x240 [mac80211]
[   32.577562]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   32.577711]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   32.577861]  ieee80211_open+0xa2/0xb0 [mac80211]
[   32.578006]  __dev_open+0x11b/0x2b0
[   32.578013]  __dev_change_flags+0x1fc/0x240
[   32.578020]  netif_change_flags+0x27/0x70
[   32.578025]  do_setlink.isra.0+0x325/0xcd0
[   32.578033]  ? cred_has_capability.isra.0+0xa4/0x150
[   32.578041]  ? __rtnl_newlink+0x1ee/0x3e0
[   32.578048]  rtnl_newlink+0x469/0x860
[   32.578058]  ? __pfx_rtnl_newlink+0x10/0x10
[   32.578064]  rtnetlink_rcv_msg+0x372/0x450
[   32.578070]  ? avc_has_perm+0x59/0xe0
[   32.578077]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   32.578082]  netlink_rcv_skb+0x5c/0x110
[   32.578091]  netlink_unicast+0x26f/0x3a0
[   32.578098]  netlink_sendmsg+0x207/0x440
[   32.578105]  ____sys_sendmsg+0x39f/0x3d0
[   32.578111]  ? import_iovec+0x1b/0x30
[   32.578119]  ___sys_sendmsg+0x99/0xe0
[   32.578133]  __sys_sendmsg+0x8a/0xf0
[   32.578141]  do_syscall_64+0x82/0x2c0
[   32.578150]  ? do_syscall_64+0x82/0x2c0
[   32.578156]  ? do_syscall_64+0x82/0x2c0
[   32.578163]  ? __x64_sys_close+0x3d/0x80
[   32.578171]  ? do_syscall_64+0x82/0x2c0
[   32.578179]  ? do_syscall_64+0x82/0x2c0
[   32.578185]  ? __x64_sys_ioctl+0xb1/0xe0
[   32.578194]  ? do_syscall_64+0x82/0x2c0
[   32.578200]  ? clear_bhb_loop+0x50/0xa0
[   32.578206]  ? clear_bhb_loop+0x50/0xa0
[   32.578211]  ? clear_bhb_loop+0x50/0xa0
[   32.578217]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   32.578222] RIP: 0033:0x7fa4f4c876c2
[   32.578229] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   32.578233] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   32.578240] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   32.578244] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   32.578248] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   32.578250] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   32.578253] R13: 0000000000000088 R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   32.578260]  </TASK>
[   32.578323] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   32.578334] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   37.939365] iwlwifi 0000:00:14.3: scheduling reset (mode=3D5)
[   37.939371] iwlwifi 0000:00:14.3: CSR values:
[   37.939372] iwlwifi 0000:00:14.3: (2nd byte of CSR_INT_COALESCING is CSR=
_INT_PERIODIC_REG)
[   37.939451] iwlwifi 0000:00:14.3:        CSR_HW_IF_CONFIG_REG: 0X18489001
[   37.939476] iwlwifi 0000:00:14.3:          CSR_INT_COALESCING: 0X00000040
[   37.939500] iwlwifi 0000:00:14.3:                     CSR_INT: 0X00000000
[   37.939547] iwlwifi 0000:00:14.3:                CSR_INT_MASK: 0X00000000
[   37.939595] iwlwifi 0000:00:14.3:           CSR_FH_INT_STATUS: 0X00000000
[   37.939643] iwlwifi 0000:00:14.3:                 CSR_GPIO_IN: 0X00000000
[   37.939692] iwlwifi 0000:00:14.3:                   CSR_RESET: 0X00000010
[   37.939768] iwlwifi 0000:00:14.3:                CSR_GP_CNTRL: 0X0c04000d
[   37.939804] iwlwifi 0000:00:14.3:                  CSR_HW_REV: 0X00000351
[   37.939828] iwlwifi 0000:00:14.3:              CSR_EEPROM_REG: 0Xd55555d5
[   37.939851] iwlwifi 0000:00:14.3:               CSR_EEPROM_GP: 0Xd55555d5
[   37.939876] iwlwifi 0000:00:14.3:              CSR_OTP_GP_REG: 0Xd55555d5
[   37.939922] iwlwifi 0000:00:14.3:                 CSR_GIO_REG: 0X041f0042
[   37.939938] iwlwifi 0000:00:14.3:            CSR_GP_UCODE_REG: 0X00000000
[   37.939940] iwlwifi 0000:00:14.3:           CSR_GP_DRIVER_REG: 0X00000000
[   37.939984] iwlwifi 0000:00:14.3:           CSR_UCODE_DRV_GP1: 0Xa5a5a5a2
[   37.940028] iwlwifi 0000:00:14.3:           CSR_UCODE_DRV_GP2: 0Xa5a5a5a2
[   37.940072] iwlwifi 0000:00:14.3:                 CSR_LED_REG: 0Xa5a5a5a2
[   37.940116] iwlwifi 0000:00:14.3:        CSR_DRAM_INT_TBL_REG: 0Xa5a5a5a2
[   37.940139] iwlwifi 0000:00:14.3:        CSR_GIO_CHICKEN_BITS: 0Xd55555d5
[   37.940163] iwlwifi 0000:00:14.3:             CSR_ANA_PLL_CFG: 0Xd55555d5
[   37.940186] iwlwifi 0000:00:14.3:      CSR_MONITOR_STATUS_REG: 0X3f1d2630
[   37.940210] iwlwifi 0000:00:14.3:           CSR_HW_REV_WA_REG: 0X0001105f
[   37.940233] iwlwifi 0000:00:14.3:        CSR_DBG_HPET_MEM_REG: 0Xffff0500
[   37.970884] iwlwifi 0000:00:14.3: Unregistering PHC clock: iwlwifi-PTP, =
with index: 0
[   38.083583] iwlwifi 0000:00:14.3: BAR 0 [mem 0x4017004000-0x4017007fff 6=
4bit]: assigned
[   38.084001] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[   38.088222] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[   38.088288] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=3D0x351, rfid=
=3D0x10a100
[   38.088291] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[   38.129289] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[   38.129652] iwlwifi 0000:00:14.3: loaded firmware version 77.864baa2e.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[   38.269061] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[   38.341613] iwlwifi 0000:00:14.3: base HW address: 20:c1:9b:dc:2d:c8
[   38.379766] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   38.435558] rfkill: input handler enabled
[   38.530154] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000 PCIe Ro=
ot Complex Integrated Endpoint
[   38.531195] pci 0000:00:14.3: BAR 0 [mem 0x4017004000-0x4017007fff 64bit]
[   38.533152] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[   38.765637] pci 0000:00:14.3: BAR 0 [mem 0x4017004000-0x4017007fff 64bit=
]: assigned
[   38.769480] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[   38.769550] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=3D0x351, rfid=
=3D0x10a100
[   38.769555] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[   38.829114] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[   38.829395] iwlwifi 0000:00:14.3: loaded firmware version 77.864baa2e.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[   38.952616] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[   39.019674] iwlwifi 0000:00:14.3: base HW address: 20:c1:9b:dc:2d:c8
[   39.068765] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   39.271655] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[   39.272417] ------------[ cut here ]------------
[   39.272421] WARNING: CPU: 1 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   39.272469] Modules linked in: xt_conntrack rfcomm snd_seq_dummy snd_hrt=
imer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay xt_comm=
ent nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet =
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_=
ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp snd_soc_i=
ntel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_=
dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component s=
nd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundw=
ire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_h=
da snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soundwire_c=
adence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm snd_soc_=
acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocatio=
n snd_soc_acpi crc8 soundwire_bus snd_soc_sdca mac80211
[   39.272539]  snd_soc_avs snd_soc_hda_codec snd_hda_ext_core libarc4 snd_=
soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_ds=
pcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_frequency_commo=
n snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep uvc mei_h=
dcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclamp videobu=
f2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_seq_device =
processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi processor_the=
rmal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_vendor_su=
pport rapl spi_nor vfat platform_temperature_control intel_cstate fat mtd i=
ntel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi_bmof snd=
_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c_i801 mei=
_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel idma64 snd=
_timer mei processor_thermal_wt_req processor_thermal_power_floor processor=
_thermal_mbox intel_soc_dts_iosf igen6_edac thinkpad_acpi
[   39.272620]  platform_profile snd soundcore int3403_thermal int340x_ther=
mal_zone soc_button_array intel_pmc_core pmt_telemetry int3400_thermal inte=
l_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_rel intel_pmc_=
ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4_compress ucsi=
_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_=
gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmtk bluetooth rf=
kill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_display_helper poly=
val_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch nvme_keyring sh=
a1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2c_hid video wm=
i pinctrl_tigerlake serio_raw i2c_dev fuse
[   39.272694] CPU: 1 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   39.272699] Tainted: [U]=3DUSER, [W]=3DWARN
[   39.272700] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   39.272702] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   39.272739] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   39.272742] RSP: 0018:ffffca55873e3568 EFLAGS: 00010282
[   39.272746] RAX: 00000000ffffffff RBX: ffff88f1c40edc98 RCX: ffff88f1c4c=
a22fc
[   39.272749] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c4c=
a22fc
[   39.272750] RBP: ffffca55873e35ac R08: 0000000000000308 R09: 00000000000=
00001
[   39.272753] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   39.272754] R13: ffff88f1c3ef2008 R14: 0000000000000001 R15: ffff88f1c40=
edc98
[   39.272756] FS:  00007fa4f48b75c0(0000) GS:ffff88f55152e000(0000) knlGS:=
0000000000000000
[   39.272759] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.272761] CR2: 00007f60e297f000 CR3: 00000001640fb003 CR4: 0000000000f=
70ef0
[   39.272764] PKRU: 55555554
[   39.272766] Call Trace:
[   39.272769]  <TASK>
[   39.272773]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   39.272801]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   39.272828]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   39.272853]  drv_add_interface+0x50/0x240 [mac80211]
[   39.272931]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   39.272986]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   39.273041]  ieee80211_open+0xa2/0xb0 [mac80211]
[   39.273093]  __dev_open+0x11b/0x2b0
[   39.273098]  __dev_change_flags+0x1fc/0x240
[   39.273102]  netif_change_flags+0x27/0x70
[   39.273104]  do_setlink.isra.0+0x325/0xcd0
[   39.273108]  ? cred_has_capability.isra.0+0xa4/0x150
[   39.273114]  ? __rtnl_newlink+0x1ee/0x3e0
[   39.273116]  rtnl_newlink+0x469/0x860
[   39.273120]  ? __pfx_rtnl_newlink+0x10/0x10
[   39.273122]  rtnetlink_rcv_msg+0x372/0x450
[   39.273125]  ? avc_has_perm+0x59/0xe0
[   39.273129]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   39.273131]  netlink_rcv_skb+0x5c/0x110
[   39.273136]  netlink_unicast+0x26f/0x3a0
[   39.273139]  netlink_sendmsg+0x207/0x440
[   39.273141]  ____sys_sendmsg+0x39f/0x3d0
[   39.273146]  ? import_iovec+0x1b/0x30
[   39.273151]  ___sys_sendmsg+0x99/0xe0
[   39.273156]  __sys_sendmsg+0x8a/0xf0
[   39.273160]  do_syscall_64+0x82/0x2c0
[   39.273166]  ? do_syscall_64+0x82/0x2c0
[   39.273169]  ? ksys_write+0xcd/0xf0
[   39.273173]  ? do_syscall_64+0x82/0x2c0
[   39.273176]  ? ksys_write+0xcd/0xf0
[   39.273178]  ? clear_bhb_loop+0x50/0xa0
[   39.273182]  ? clear_bhb_loop+0x50/0xa0
[   39.273184]  ? clear_bhb_loop+0x50/0xa0
[   39.273186]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   39.273189] RIP: 0033:0x7fa4f4c876c2
[   39.273192] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   39.273194] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   39.273197] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   39.273198] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   39.273199] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   39.273201] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   39.273202] R13: 00000000000000f4 R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   39.273205]  </TASK>
[   39.273206] ---[ end trace 0000000000000000 ]---
[   39.273649] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   39.274241] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   39.274244] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   39.274246] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   39.274249] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   39.274251] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   39.274253] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   39.274254] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   39.274256] iwlwifi 0000:00:14.3: 0x000156B2 | interruptlink1
[   39.274258] iwlwifi 0000:00:14.3: 0x000156B2 | interruptlink2
[   39.274259] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   39.274261] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   39.274262] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   39.274264] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   39.274265] iwlwifi 0000:00:14.3: 0x0002560A | tsf low
[   39.274267] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   39.274268] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   39.274270] iwlwifi 0000:00:14.3: 0x0002B2E8 | time gp2
[   39.274271] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   39.274273] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   39.274275] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   39.274277] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   39.274279] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   39.274281] iwlwifi 0000:00:14.3: 0x00130148 | hcmd
[   39.274283] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   39.274284] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   39.274286] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   39.274287] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   39.274296] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   39.274297] iwlwifi 0000:00:14.3: 0x00130148 | last cmd Id
[   39.274299] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   39.274300] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   39.274301] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   39.274303] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   39.274304] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   39.274306] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   39.274307] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   39.274309] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   39.274765] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   39.274767] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   39.274769] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   39.274771] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   39.274773] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   39.274774] iwlwifi 0000:00:14.3: 0x8046E080 | umac interruptlink1
[   39.274776] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   39.274777] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   39.274779] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   39.274781] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   39.274783] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   39.274785] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   39.274787] iwlwifi 0000:00:14.3: 0x0002B2E3 | frame pointer
[   39.274788] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   39.274790] iwlwifi 0000:00:14.3: 0x00140308 | last host cmd
[   39.274792] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   39.274904] iwlwifi 0000:00:14.3: IML/ROM dump:
[   39.274905] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   39.274925] iwlwifi 0000:00:14.3: 0x0000580C | IML/ROM data1
[   39.275030] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   39.275077] iwlwifi 0000:00:14.3: Fseq Registers:
[   39.275104] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   39.275140] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   39.275167] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   39.275185] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   39.275208] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   39.275232] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   39.275255] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   39.275286] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   39.275314] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   39.275342] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   39.275381] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   39.275409] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   39.275435] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   39.275462] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   39.275499] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   39.275536] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   39.275644] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   39.275681] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   39.275734] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   39.275741] CPU: 1 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   39.275746] Tainted: [U]=3DUSER, [W]=3DWARN
[   39.275747] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   39.275748] Call Trace:
[   39.275751]  <TASK>
[   39.275754]  dump_stack_lvl+0x5d/0x80
[   39.275765]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   39.275804]  ? __pfx_autoremove_wake_function+0x10/0x10
[   39.275810]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   39.275846]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   39.275878]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   39.275900]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   39.275918]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   39.275936]  drv_add_interface+0x50/0x240 [mac80211]
[   39.276010]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   39.276056]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   39.276097]  ieee80211_open+0xa2/0xb0 [mac80211]
[   39.276138]  __dev_open+0x11b/0x2b0
[   39.276142]  __dev_change_flags+0x1fc/0x240
[   39.276144]  netif_change_flags+0x27/0x70
[   39.276145]  do_setlink.isra.0+0x325/0xcd0
[   39.276148]  ? cred_has_capability.isra.0+0xa4/0x150
[   39.276152]  ? __rtnl_newlink+0x1ee/0x3e0
[   39.276154]  rtnl_newlink+0x469/0x860
[   39.276157]  ? __pfx_rtnl_newlink+0x10/0x10
[   39.276158]  rtnetlink_rcv_msg+0x372/0x450
[   39.276160]  ? avc_has_perm+0x59/0xe0
[   39.276163]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   39.276164]  netlink_rcv_skb+0x5c/0x110
[   39.276168]  netlink_unicast+0x26f/0x3a0
[   39.276170]  netlink_sendmsg+0x207/0x440
[   39.276172]  ____sys_sendmsg+0x39f/0x3d0
[   39.276176]  ? import_iovec+0x1b/0x30
[   39.276179]  ___sys_sendmsg+0x99/0xe0
[   39.276184]  __sys_sendmsg+0x8a/0xf0
[   39.276188]  do_syscall_64+0x82/0x2c0
[   39.276193]  ? do_syscall_64+0x82/0x2c0
[   39.276197]  ? ksys_write+0xcd/0xf0
[   39.276201]  ? do_syscall_64+0x82/0x2c0
[   39.276203]  ? ksys_write+0xcd/0xf0
[   39.276206]  ? clear_bhb_loop+0x50/0xa0
[   39.276209]  ? clear_bhb_loop+0x50/0xa0
[   39.276211]  ? clear_bhb_loop+0x50/0xa0
[   39.276213]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   39.276216] RIP: 0033:0x7fa4f4c876c2
[   39.276219] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   39.276221] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   39.276224] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   39.276225] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   39.276226] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   39.276228] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   39.276229] R13: 00000000000000f4 R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   39.276232]  </TASK>
[   39.276234] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   39.276252] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   40.268980] iwlwifi 0000:00:14.3: scheduling reset (mode=3D5 instead of =
product reset as ME may be present)
[   40.268987] iwlwifi 0000:00:14.3: CSR values:
[   40.268988] iwlwifi 0000:00:14.3: (2nd byte of CSR_INT_COALESCING is CSR=
_INT_PERIODIC_REG)
[   40.269027] iwlwifi 0000:00:14.3:        CSR_HW_IF_CONFIG_REG: 0X18489001
[   40.269063] iwlwifi 0000:00:14.3:          CSR_INT_COALESCING: 0X00000040
[   40.269110] iwlwifi 0000:00:14.3:                     CSR_INT: 0X00000000
[   40.269157] iwlwifi 0000:00:14.3:                CSR_INT_MASK: 0X00000000
[   40.269196] iwlwifi 0000:00:14.3:           CSR_FH_INT_STATUS: 0X00000000
[   40.269199] iwlwifi 0000:00:14.3:                 CSR_GPIO_IN: 0X00000000
[   40.269203] iwlwifi 0000:00:14.3:                   CSR_RESET: 0X00000010
[   40.269206] iwlwifi 0000:00:14.3:                CSR_GP_CNTRL: 0X0c04000d
[   40.269208] iwlwifi 0000:00:14.3:                  CSR_HW_REV: 0X00000351
[   40.269211] iwlwifi 0000:00:14.3:              CSR_EEPROM_REG: 0Xd55555d5
[   40.269213] iwlwifi 0000:00:14.3:               CSR_EEPROM_GP: 0Xd55555d5
[   40.269216] iwlwifi 0000:00:14.3:              CSR_OTP_GP_REG: 0Xd55555d5
[   40.269218] iwlwifi 0000:00:14.3:                 CSR_GIO_REG: 0X041f0042
[   40.269220] iwlwifi 0000:00:14.3:            CSR_GP_UCODE_REG: 0X00000000
[   40.269257] iwlwifi 0000:00:14.3:           CSR_GP_DRIVER_REG: 0Xa5a5a5a2
[   40.269301] iwlwifi 0000:00:14.3:           CSR_UCODE_DRV_GP1: 0Xa5a5a5a2
[   40.269345] iwlwifi 0000:00:14.3:           CSR_UCODE_DRV_GP2: 0Xa5a5a5a2
[   40.269389] iwlwifi 0000:00:14.3:                 CSR_LED_REG: 0Xa5a5a5a2
[   40.269412] iwlwifi 0000:00:14.3:        CSR_DRAM_INT_TBL_REG: 0X00000000
[   40.269435] iwlwifi 0000:00:14.3:        CSR_GIO_CHICKEN_BITS: 0Xd55555d5
[   40.269459] iwlwifi 0000:00:14.3:             CSR_ANA_PLL_CFG: 0Xd55555d5
[   40.269483] iwlwifi 0000:00:14.3:      CSR_MONITOR_STATUS_REG: 0X3f1d0630
[   40.269508] iwlwifi 0000:00:14.3:           CSR_HW_REV_WA_REG: 0X0001105f
[   40.269531] iwlwifi 0000:00:14.3:        CSR_DBG_HPET_MEM_REG: 0Xffff0500
[   40.281790] iwlwifi 0000:00:14.3: Error, can not clear persistence bit
[   40.283522] iwlwifi 0000:00:14.3: Error, can not clear persistence bit
[   40.283849] iwlwifi 0000:00:14.3: Error, can not clear persistence bit
[   40.312837] iwlwifi 0000:00:14.3: Unregistering PHC clock: iwlwifi-PTP, =
with index: 0
[   40.424166] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000 PCIe Ro=
ot Complex Integrated Endpoint
[   40.424265] pci 0000:00:14.3: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[   40.425222] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[   40.652419] pci 0000:00:14.3: BAR 0 [mem 0x4017004000-0x4017007fff 64bit=
]: assigned
[   40.652794] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[   40.655617] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[   40.655683] iwlwifi 0000:00:14.3: PCI dev a0f0/0070, rev=3D0x351, rfid=
=3D0x10a100
[   40.655685] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[   40.694375] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[   40.694754] iwlwifi 0000:00:14.3: loaded firmware version 77.864baa2e.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[   40.818952] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[   40.886518] iwlwifi 0000:00:14.3: base HW address: 20:c1:9b:dc:2d:c8
[   40.921424] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   41.117814] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[   41.118615] ------------[ cut here ]------------
[   41.118618] WARNING: CPU: 1 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   41.118668] Modules linked in: xt_conntrack rfcomm snd_seq_dummy snd_hrt=
imer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay xt_comm=
ent nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet =
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_=
ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp snd_soc_i=
ntel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_=
dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component s=
nd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundw=
ire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_h=
da snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soundwire_c=
adence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm snd_soc_=
acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocatio=
n snd_soc_acpi crc8 soundwire_bus snd_soc_sdca mac80211
[   41.118771]  snd_soc_avs snd_soc_hda_codec snd_hda_ext_core libarc4 snd_=
soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_ds=
pcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_frequency_commo=
n snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep uvc mei_h=
dcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclamp videobu=
f2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_seq_device =
processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi processor_the=
rmal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_vendor_su=
pport rapl spi_nor vfat platform_temperature_control intel_cstate fat mtd i=
ntel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi_bmof snd=
_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c_i801 mei=
_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel idma64 snd=
_timer mei processor_thermal_wt_req processor_thermal_power_floor processor=
_thermal_mbox intel_soc_dts_iosf igen6_edac thinkpad_acpi
[   41.118848]  platform_profile snd soundcore int3403_thermal int340x_ther=
mal_zone soc_button_array intel_pmc_core pmt_telemetry int3400_thermal inte=
l_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_rel intel_pmc_=
ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4_compress ucsi=
_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_=
gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmtk bluetooth rf=
kill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_display_helper poly=
val_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch nvme_keyring sh=
a1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2c_hid video wm=
i pinctrl_tigerlake serio_raw i2c_dev fuse
[   41.118922] CPU: 1 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   41.118928] Tainted: [U]=3DUSER, [W]=3DWARN
[   41.118929] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   41.118932] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   41.118960] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   41.118963] RSP: 0018:ffffca55873e3508 EFLAGS: 00010282
[   41.118967] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   41.118969] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   41.118972] RBP: ffffca55873e354c R08: 0000000000000308 R09: 00000000000=
00001
[   41.118974] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   41.118975] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   41.118978] FS:  00007fa4f48b75c0(0000) GS:ffff88f55152e000(0000) knlGS:=
0000000000000000
[   41.118980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.118983] CR2: 0000556c95686760 CR3: 00000001640fb004 CR4: 0000000000f=
70ef0
[   41.118985] PKRU: 55555554
[   41.118987] Call Trace:
[   41.118991]  <TASK>
[   41.118996]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   41.119024]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   41.119049]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   41.119075]  drv_add_interface+0x50/0x240 [mac80211]
[   41.119154]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   41.119222]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   41.119284]  ieee80211_open+0xa2/0xb0 [mac80211]
[   41.119344]  __dev_open+0x11b/0x2b0
[   41.119350]  __dev_change_flags+0x1fc/0x240
[   41.119355]  netif_change_flags+0x27/0x70
[   41.119358]  do_setlink.isra.0+0x325/0xcd0
[   41.119363]  ? cred_has_capability.isra.0+0xa4/0x150
[   41.119369]  ? selinux_inode_setattr+0xe9/0x250
[   41.119373]  ? __rtnl_newlink+0x1ee/0x3e0
[   41.119376]  rtnl_newlink+0x469/0x860
[   41.119380]  ? setattr_prepare+0x90/0x290
[   41.119387]  ? __pfx_rtnl_newlink+0x10/0x10
[   41.119390]  rtnetlink_rcv_msg+0x372/0x450
[   41.119394]  ? avc_has_perm+0x59/0xe0
[   41.119398]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   41.119401]  netlink_rcv_skb+0x5c/0x110
[   41.119407]  netlink_unicast+0x26f/0x3a0
[   41.119410]  netlink_sendmsg+0x207/0x440
[   41.119414]  ____sys_sendmsg+0x39f/0x3d0
[   41.119419]  ? import_iovec+0x1b/0x30
[   41.119424]  ___sys_sendmsg+0x99/0xe0
[   41.119430]  __sys_sendmsg+0x8a/0xf0
[   41.119434]  do_syscall_64+0x82/0x2c0
[   41.119439]  ? __memcg_slab_free_hook+0x10f/0x160
[   41.119445]  ? kmem_cache_free+0x490/0x4d0
[   41.119450]  ? __x64_sys_close+0x3d/0x80
[   41.119455]  ? __x64_sys_close+0x3d/0x80
[   41.119458]  ? do_syscall_64+0x82/0x2c0
[   41.119462]  ? kmem_cache_free+0x490/0x4d0
[   41.119465]  ? __x64_sys_close+0x3d/0x80
[   41.119469]  ? __x64_sys_close+0x3d/0x80
[   41.119472]  ? clear_bhb_loop+0x50/0xa0
[   41.119476]  ? clear_bhb_loop+0x50/0xa0
[   41.119479]  ? clear_bhb_loop+0x50/0xa0
[   41.119481]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   41.119485] RIP: 0033:0x7fa4f4c876c2
[   41.119489] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   41.119492] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   41.119495] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   41.119497] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   41.119500] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   41.119502] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   41.119504] R13: 000000000000012c R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   41.119507]  </TASK>
[   41.119509] ---[ end trace 0000000000000000 ]---
[   41.119973] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   41.120254] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   41.120256] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   41.120257] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   41.120259] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   41.120261] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   41.120262] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   41.120263] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   41.120264] iwlwifi 0000:00:14.3: 0x00019D84 | interruptlink1
[   41.120265] iwlwifi 0000:00:14.3: 0x00019D84 | interruptlink2
[   41.120266] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   41.120267] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   41.120268] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   41.120269] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   41.120270] iwlwifi 0000:00:14.3: 0x000255AF | tsf low
[   41.120271] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   41.120272] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   41.120273] iwlwifi 0000:00:14.3: 0x0002B2B2 | time gp2
[   41.120274] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   41.120275] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   41.120276] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   41.120277] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   41.120278] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   41.120279] iwlwifi 0000:00:14.3: 0x00130148 | hcmd
[   41.120280] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   41.120281] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   41.120282] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   41.120283] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   41.120284] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   41.120285] iwlwifi 0000:00:14.3: 0x00130148 | last cmd Id
[   41.120286] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   41.120287] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   41.120288] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   41.120289] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   41.120290] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   41.120291] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   41.120292] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   41.120293] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   41.120753] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   41.120755] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   41.120757] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   41.120759] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   41.120760] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   41.120762] iwlwifi 0000:00:14.3: 0x8046E0A8 | umac interruptlink1
[   41.120763] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   41.120764] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   41.120766] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   41.120767] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   41.120769] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   41.120770] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   41.120772] iwlwifi 0000:00:14.3: 0x0002B2AD | frame pointer
[   41.120773] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   41.120775] iwlwifi 0000:00:14.3: 0x00140308 | last host cmd
[   41.120777] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   41.120887] iwlwifi 0000:00:14.3: IML/ROM dump:
[   41.120889] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   41.120910] iwlwifi 0000:00:14.3: 0x0000582B | IML/ROM data1
[   41.120919] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   41.120925] iwlwifi 0000:00:14.3: Fseq Registers:
[   41.120928] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   41.120960] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   41.120984] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   41.121008] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   41.121033] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   41.121056] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   41.121080] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   41.121104] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   41.121127] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   41.121154] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   41.121179] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   41.121205] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   41.121220] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   41.121244] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   41.121268] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   41.121291] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   41.121395] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   41.121421] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   41.121459] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   41.121466] CPU: 7 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   41.121470] Tainted: [U]=3DUSER, [W]=3DWARN
[   41.121471] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   41.121472] Call Trace:
[   41.121474]  <TASK>
[   41.121476]  dump_stack_lvl+0x5d/0x80
[   41.121487]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   41.121522]  ? __pfx_autoremove_wake_function+0x10/0x10
[   41.121526]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   41.121554]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   41.121587]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   41.121612]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   41.121632]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   41.121654]  drv_add_interface+0x50/0x240 [mac80211]
[   41.121732]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   41.121789]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   41.121846]  ieee80211_open+0xa2/0xb0 [mac80211]
[   41.121901]  __dev_open+0x11b/0x2b0
[   41.121906]  __dev_change_flags+0x1fc/0x240
[   41.121909]  netif_change_flags+0x27/0x70
[   41.121911]  do_setlink.isra.0+0x325/0xcd0
[   41.121914]  ? cred_has_capability.isra.0+0xa4/0x150
[   41.121919]  ? selinux_inode_setattr+0xe9/0x250
[   41.121922]  ? __rtnl_newlink+0x1ee/0x3e0
[   41.121925]  rtnl_newlink+0x469/0x860
[   41.121927]  ? setattr_prepare+0x90/0x290
[   41.121934]  ? __pfx_rtnl_newlink+0x10/0x10
[   41.121936]  rtnetlink_rcv_msg+0x372/0x450
[   41.121939]  ? avc_has_perm+0x59/0xe0
[   41.121942]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   41.121944]  netlink_rcv_skb+0x5c/0x110
[   41.121948]  netlink_unicast+0x26f/0x3a0
[   41.121951]  netlink_sendmsg+0x207/0x440
[   41.121953]  ____sys_sendmsg+0x39f/0x3d0
[   41.121958]  ? import_iovec+0x1b/0x30
[   41.121962]  ___sys_sendmsg+0x99/0xe0
[   41.121968]  __sys_sendmsg+0x8a/0xf0
[   41.121971]  do_syscall_64+0x82/0x2c0
[   41.121977]  ? __memcg_slab_free_hook+0x10f/0x160
[   41.121981]  ? kmem_cache_free+0x490/0x4d0
[   41.121986]  ? __x64_sys_close+0x3d/0x80
[   41.121989]  ? __x64_sys_close+0x3d/0x80
[   41.121991]  ? do_syscall_64+0x82/0x2c0
[   41.121993]  ? kmem_cache_free+0x490/0x4d0
[   41.121995]  ? __x64_sys_close+0x3d/0x80
[   41.121998]  ? __x64_sys_close+0x3d/0x80
[   41.122000]  ? clear_bhb_loop+0x50/0xa0
[   41.122002]  ? clear_bhb_loop+0x50/0xa0
[   41.122004]  ? clear_bhb_loop+0x50/0xa0
[   41.122005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   41.122008] RIP: 0033:0x7fa4f4c876c2
[   41.122010] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   41.122011] RSP: 002b:00007ffe61af7d18 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   41.122014] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   41.122015] RDX: 0000000000000000 RSI: 00007ffe61af7db0 RDI: 00000000000=
0000d
[   41.122016] RBP: 00007ffe61af7d50 R08: 0000000000000000 R09: 00000000000=
00000
[   41.122017] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   41.122017] R13: 000000000000012c R14: 0000000000000000 R15: 00007ffe61a=
f7f4c
[   41.122019]  </TASK>
[   41.122033] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   41.122046] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   41.613793] rfkill: input handler disabled
[   42.022279] iwlwifi 0000:00:14.3: Too many device errors - delay next re=
set
[   42.231310] ------------[ cut here ]------------
[   42.231319] WARNING: CPU: 0 PID: 1290 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   42.231394] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   42.231482]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   42.231580]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   42.231703] CPU: 0 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   42.231712] Tainted: [U]=3DUSER, [W]=3DWARN
[   42.231714] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   42.231718] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   42.231769] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   42.231773] RSP: 0018:ffffca55873e3438 EFLAGS: 00010282
[   42.231778] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   42.231782] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   42.231785] RBP: ffffca55873e347c R08: 0000000000000308 R09: 00000000000=
00001
[   42.231788] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   42.231790] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   42.231793] FS:  00007fa4f48b75c0(0000) GS:ffff88f5514ae000(0000) knlGS:=
0000000000000000
[   42.231797] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.231800] CR2: 000055c0bee05f6c CR3: 00000001640fb001 CR4: 0000000000f=
70ef0
[   42.231804] PKRU: 55555554
[   42.231807] Call Trace:
[   42.231811]  <TASK>
[   42.231817]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   42.231864]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   42.231907]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   42.231947]  drv_add_interface+0x50/0x240 [mac80211]
[   42.232048]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   42.232160]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   42.232268]  ieee80211_open+0xa2/0xb0 [mac80211]
[   42.232369]  __dev_open+0x11b/0x2b0
[   42.232378]  __dev_change_flags+0x1fc/0x240
[   42.232385]  netif_change_flags+0x27/0x70
[   42.232389]  do_setlink.isra.0+0x325/0xcd0
[   42.232396]  ? cred_has_capability.isra.0+0xa4/0x150
[   42.232405]  ? __rtnl_newlink+0x1ee/0x3e0
[   42.232410]  rtnl_newlink+0x469/0x860
[   42.232418]  ? __pfx_rtnl_newlink+0x10/0x10
[   42.232423]  rtnetlink_rcv_msg+0x372/0x450
[   42.232429]  ? avc_has_perm+0x59/0xe0
[   42.232436]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   42.232440]  netlink_rcv_skb+0x5c/0x110
[   42.232449]  netlink_unicast+0x26f/0x3a0
[   42.232454]  netlink_sendmsg+0x207/0x440
[   42.232460]  ____sys_sendmsg+0x39f/0x3d0
[   42.232468]  ? import_iovec+0x1b/0x30
[   42.232476]  ___sys_sendmsg+0x99/0xe0
[   42.232487]  __sys_sendmsg+0x8a/0xf0
[   42.232494]  do_syscall_64+0x82/0x2c0
[   42.232504]  ? ___sys_recvmsg+0x9e/0xe0
[   42.232514]  ? __sys_recvmsg+0xca/0xe0
[   42.232520]  ? do_syscall_64+0x82/0x2c0
[   42.232528]  ? clear_bhb_loop+0x50/0xa0
[   42.232535]  ? clear_bhb_loop+0x50/0xa0
[   42.232539]  ? clear_bhb_loop+0x50/0xa0
[   42.232544]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.232550] RIP: 0033:0x7fa4f4c876c2
[   42.232556] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   42.232560] RSP: 002b:00007ffe61af7968 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   42.232565] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   42.232568] RDX: 0000000000000000 RSI: 00007ffe61af7a00 RDI: 00000000000=
0000d
[   42.232570] RBP: 00007ffe61af79a0 R08: 0000000000000000 R09: 00000000000=
00000
[   42.232573] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   42.232576] R13: 0000000000000132 R14: 0000000000000000 R15: 00007ffe61a=
f7b9c
[   42.232581]  </TASK>
[   42.232583] ---[ end trace 0000000000000000 ]---
[   42.233042] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   42.233267] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   42.233270] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   42.233274] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   42.233277] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   42.233281] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   42.233284] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   42.233286] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   42.233289] iwlwifi 0000:00:14.3: 0x000156BA | interruptlink1
[   42.233292] iwlwifi 0000:00:14.3: 0x000156BA | interruptlink2
[   42.233294] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   42.233296] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   42.233299] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   42.233301] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   42.233304] iwlwifi 0000:00:14.3: 0x00026AAC | tsf low
[   42.233306] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   42.233308] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   42.233311] iwlwifi 0000:00:14.3: 0x0002C7E2 | time gp2
[   42.233313] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   42.233316] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   42.233318] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   42.233321] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   42.233323] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   42.233326] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   42.233329] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   42.233331] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   42.233333] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   42.233336] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   42.233338] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   42.233340] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   42.233343] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   42.233345] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   42.233348] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   42.233350] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   42.233352] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   42.233354] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   42.233357] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   42.233359] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   42.233828] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   42.233831] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   42.233834] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   42.233837] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   42.233839] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   42.233842] iwlwifi 0000:00:14.3: 0x8046E092 | umac interruptlink1
[   42.233844] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   42.233846] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   42.233849] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   42.233851] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   42.233853] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   42.233856] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   42.233858] iwlwifi 0000:00:14.3: 0x0002C7DD | frame pointer
[   42.233861] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   42.233863] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   42.233865] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   42.233978] iwlwifi 0000:00:14.3: IML/ROM dump:
[   42.233980] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   42.234097] iwlwifi 0000:00:14.3: 0x0000584F | IML/ROM data1
[   42.234192] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   42.234211] iwlwifi 0000:00:14.3: Fseq Registers:
[   42.234243] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   42.234271] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   42.234309] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   42.234346] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   42.234383] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   42.234420] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   42.234457] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   42.234494] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   42.234531] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   42.234570] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   42.234608] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   42.234647] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   42.234684] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   42.234725] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   42.234766] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   42.234803] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   42.234911] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   42.234948] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   42.235062] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   42.235072] CPU: 0 UID: 0 PID: 1290 Comm: NetworkManager Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   42.235079] Tainted: [U]=3DUSER, [W]=3DWARN
[   42.235080] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   42.235082] Call Trace:
[   42.235085]  <TASK>
[   42.235088]  dump_stack_lvl+0x5d/0x80
[   42.235100]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   42.235153]  ? __pfx_autoremove_wake_function+0x10/0x10
[   42.235162]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   42.235217]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   42.235269]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   42.235322]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   42.235364]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   42.235401]  drv_add_interface+0x50/0x240 [mac80211]
[   42.235480]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   42.235584]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   42.235681]  ieee80211_open+0xa2/0xb0 [mac80211]
[   42.235777]  __dev_open+0x11b/0x2b0
[   42.235782]  __dev_change_flags+0x1fc/0x240
[   42.235787]  netif_change_flags+0x27/0x70
[   42.235791]  do_setlink.isra.0+0x325/0xcd0
[   42.235796]  ? cred_has_capability.isra.0+0xa4/0x150
[   42.235802]  ? __rtnl_newlink+0x1ee/0x3e0
[   42.235806]  rtnl_newlink+0x469/0x860
[   42.235812]  ? __pfx_rtnl_newlink+0x10/0x10
[   42.235817]  rtnetlink_rcv_msg+0x372/0x450
[   42.235821]  ? avc_has_perm+0x59/0xe0
[   42.235826]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   42.235829]  netlink_rcv_skb+0x5c/0x110
[   42.235835]  netlink_unicast+0x26f/0x3a0
[   42.235839]  netlink_sendmsg+0x207/0x440
[   42.235844]  ____sys_sendmsg+0x39f/0x3d0
[   42.235849]  ? import_iovec+0x1b/0x30
[   42.235854]  ___sys_sendmsg+0x99/0xe0
[   42.235864]  __sys_sendmsg+0x8a/0xf0
[   42.235869]  do_syscall_64+0x82/0x2c0
[   42.235876]  ? ___sys_recvmsg+0x9e/0xe0
[   42.235884]  ? __sys_recvmsg+0xca/0xe0
[   42.235890]  ? do_syscall_64+0x82/0x2c0
[   42.235897]  ? clear_bhb_loop+0x50/0xa0
[   42.235901]  ? clear_bhb_loop+0x50/0xa0
[   42.235904]  ? clear_bhb_loop+0x50/0xa0
[   42.235909]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.235913] RIP: 0033:0x7fa4f4c876c2
[   42.235918] Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   42.235921] RSP: 002b:00007ffe61af7968 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   42.235926] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa4f4c=
876c2
[   42.235929] RDX: 0000000000000000 RSI: 00007ffe61af7a00 RDI: 00000000000=
0000d
[   42.235931] RBP: 00007ffe61af79a0 R08: 0000000000000000 R09: 00000000000=
00000
[   42.235932] R10: 0000000000000000 R11: 0000000000000246 R12: 000056359cb=
80e90
[   42.235935] R13: 0000000000000132 R14: 0000000000000000 R15: 00007ffe61a=
f7b9c
[   42.235939]  </TASK>
[   42.235969] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   42.236002] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   44.458213] ------------[ cut here ]------------
[   44.458218] WARNING: CPU: 3 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   44.458252] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   44.458292]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   44.458337]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   44.458384] CPU: 3 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   44.458387] Tainted: [U]=3DUSER, [W]=3DWARN
[   44.458388] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   44.458390] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   44.458410] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   44.458412] RSP: 0018:ffffca55876e37a0 EFLAGS: 00010282
[   44.458414] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   44.458415] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   44.458416] RBP: ffffca55876e37e4 R08: 0000000000000308 R09: 00000000000=
00001
[   44.458418] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   44.458419] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   44.458420] FS:  00007f2267b25840(0000) GS:ffff88f55162e000(0000) knlGS:=
0000000000000000
[   44.458421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.458423] CR2: 00007ff05a99bfb8 CR3: 000000010a8ab003 CR4: 0000000000f=
70ef0
[   44.458424] PKRU: 55555554
[   44.458425] Call Trace:
[   44.458428]  <TASK>
[   44.458431]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   44.458449]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   44.458465]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   44.458481]  drv_add_interface+0x50/0x240 [mac80211]
[   44.458535]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   44.458577]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   44.458619]  ieee80211_open+0xa2/0xb0 [mac80211]
[   44.458658]  __dev_open+0x11b/0x2b0
[   44.458662]  __dev_change_flags+0x1fc/0x240
[   44.458665]  netif_change_flags+0x27/0x70
[   44.458674]  dev_change_flags+0x40/0xb0
[   44.458676]  devinet_ioctl+0x583/0x790
[   44.458681]  inet_ioctl+0x1e9/0x200
[   44.458685]  sock_do_ioctl+0x7a/0x130
[   44.458689]  __x64_sys_ioctl+0x94/0xe0
[   44.458694]  ? ____sys_recvmsg+0xf8/0x210
[   44.458697]  do_syscall_64+0x82/0x2c0
[   44.458702]  ? ___sys_recvmsg+0x9e/0xe0
[   44.458705]  ? avc_has_extended_perms+0x196/0x600
[   44.458709]  ? sk_ioctl+0x4d/0x110
[   44.458712]  ? inet_ioctl+0x1bb/0x200
[   44.458715]  ? dev_get_by_name_rcu+0x67/0x80
[   44.458718]  ? dev_get_by_name_rcu+0x67/0x80
[   44.458719]  ? __check_object_size.part.0+0x34/0xc0
[   44.458722]  ? put_user_ifreq+0x64/0x80
[   44.458724]  ? sock_do_ioctl+0x107/0x130
[   44.458727]  ? __x64_sys_ioctl+0x94/0xe0
[   44.458729]  ? clear_bhb_loop+0x50/0xa0
[   44.458732]  ? clear_bhb_loop+0x50/0xa0
[   44.458734]  ? clear_bhb_loop+0x50/0xa0
[   44.458736]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   44.458738] RIP: 0033:0x7f22674fdaad
[   44.458741] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   44.458742] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   44.458744] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   44.458746] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   44.458746] RBP: 00007ffc322cbae0 R08: 0000560087cc1820 R09: 00007f22675=
f6ac0
[   44.458747] R10: 0000000000000002 R11: 0000000000000246 R12: 00000000000=
00001
[   44.458748] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
ca700
[   44.458750]  </TASK>
[   44.458751] ---[ end trace 0000000000000000 ]---
[   44.459327] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   44.460446] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   44.460448] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   44.460450] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   44.460452] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   44.460453] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   44.460455] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   44.460456] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   44.460457] iwlwifi 0000:00:14.3: 0x000156B8 | interruptlink1
[   44.460458] iwlwifi 0000:00:14.3: 0x000156B8 | interruptlink2
[   44.460458] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   44.460459] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   44.460460] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   44.460461] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   44.460462] iwlwifi 0000:00:14.3: 0x0002A6E5 | tsf low
[   44.460463] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   44.460464] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   44.460465] iwlwifi 0000:00:14.3: 0x000303F7 | time gp2
[   44.460466] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   44.460467] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   44.460468] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   44.460469] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   44.460470] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   44.460471] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   44.460472] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   44.460473] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   44.460473] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   44.460474] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   44.460475] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   44.460476] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   44.460477] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   44.460478] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   44.460479] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   44.460480] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   44.460481] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   44.460482] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   44.460483] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   44.460483] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   44.461073] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   44.461074] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   44.461077] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   44.461079] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   44.461080] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   44.461082] iwlwifi 0000:00:14.3: 0xC0081228 | umac interruptlink1
[   44.461083] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   44.461085] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   44.461086] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   44.461088] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   44.461089] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   44.461090] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   44.461092] iwlwifi 0000:00:14.3: 0x000303F2 | frame pointer
[   44.461094] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   44.461095] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   44.461096] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   44.461322] iwlwifi 0000:00:14.3: IML/ROM dump:
[   44.461324] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   44.461344] iwlwifi 0000:00:14.3: 0x00005832 | IML/ROM data1
[   44.461353] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   44.461360] iwlwifi 0000:00:14.3: Fseq Registers:
[   44.461392] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   44.461446] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   44.461473] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   44.461500] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   44.461527] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   44.461554] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   44.461580] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   44.461607] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   44.461634] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   44.461663] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   44.461694] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   44.461749] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   44.461776] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   44.461803] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   44.461831] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   44.461883] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   44.462007] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   44.462033] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   44.462065] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   44.462070] CPU: 3 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   44.462073] Tainted: [U]=3DUSER, [W]=3DWARN
[   44.462074] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   44.462076] Call Trace:
[   44.462077]  <TASK>
[   44.462078]  dump_stack_lvl+0x5d/0x80
[   44.462086]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   44.462115]  ? __pfx_autoremove_wake_function+0x10/0x10
[   44.462119]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   44.462146]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   44.462174]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   44.462197]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   44.462216]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   44.462233]  drv_add_interface+0x50/0x240 [mac80211]
[   44.462286]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   44.462334]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   44.462381]  ieee80211_open+0xa2/0xb0 [mac80211]
[   44.462424]  __dev_open+0x11b/0x2b0
[   44.462428]  __dev_change_flags+0x1fc/0x240
[   44.462430]  netif_change_flags+0x27/0x70
[   44.462432]  dev_change_flags+0x40/0xb0
[   44.462435]  devinet_ioctl+0x583/0x790
[   44.462438]  inet_ioctl+0x1e9/0x200
[   44.462442]  sock_do_ioctl+0x7a/0x130
[   44.462446]  __x64_sys_ioctl+0x94/0xe0
[   44.462450]  ? ____sys_recvmsg+0xf8/0x210
[   44.462453]  do_syscall_64+0x82/0x2c0
[   44.462458]  ? ___sys_recvmsg+0x9e/0xe0
[   44.462461]  ? avc_has_extended_perms+0x196/0x600
[   44.462465]  ? sk_ioctl+0x4d/0x110
[   44.462468]  ? inet_ioctl+0x1bb/0x200
[   44.462471]  ? dev_get_by_name_rcu+0x67/0x80
[   44.462473]  ? dev_get_by_name_rcu+0x67/0x80
[   44.462474]  ? __check_object_size.part.0+0x34/0xc0
[   44.462477]  ? put_user_ifreq+0x64/0x80
[   44.462479]  ? sock_do_ioctl+0x107/0x130
[   44.462482]  ? __x64_sys_ioctl+0x94/0xe0
[   44.462485]  ? clear_bhb_loop+0x50/0xa0
[   44.462487]  ? clear_bhb_loop+0x50/0xa0
[   44.462489]  ? clear_bhb_loop+0x50/0xa0
[   44.462490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   44.462493] RIP: 0033:0x7f22674fdaad
[   44.462494] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   44.462496] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   44.462498] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   44.462499] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   44.462500] RBP: 00007ffc322cbae0 R08: 0000560087cc1820 R09: 00007f22675=
f6ac0
[   44.462500] R10: 0000000000000002 R11: 0000000000000246 R12: 00000000000=
00001
[   44.462501] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
ca700
[   44.462503]  </TASK>
[   44.462505] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   44.462520] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   51.092777] ------------[ cut here ]------------
[   51.092782] WARNING: CPU: 5 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   51.092817] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   51.092868]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   51.092938]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   51.092983] CPU: 5 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   51.092987] Tainted: [U]=3DUSER, [W]=3DWARN
[   51.092988] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   51.092989] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   51.093009] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   51.093011] RSP: 0018:ffffca55876e3a30 EFLAGS: 00010282
[   51.093013] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   51.093014] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   51.093016] RBP: ffffca55876e3a74 R08: 0000000000000308 R09: 00000000000=
00001
[   51.093017] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   51.093018] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   51.093019] FS:  00007f2267b25840(0000) GS:ffff88f55172e000(0000) knlGS:=
0000000000000000
[   51.093021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.093022] CR2: 00005636d40ee0e8 CR3: 000000010a8ab003 CR4: 0000000000f=
70ef0
[   51.093024] PKRU: 55555554
[   51.093025] Call Trace:
[   51.093028]  <TASK>
[   51.093031]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   51.093050]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   51.093067]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   51.093084]  drv_add_interface+0x50/0x240 [mac80211]
[   51.093137]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   51.093181]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   51.093223]  ieee80211_open+0xa2/0xb0 [mac80211]
[   51.093261]  __dev_open+0x11b/0x2b0
[   51.093266]  __dev_change_flags+0x1fc/0x240
[   51.093269]  netif_change_flags+0x27/0x70
[   51.093271]  dev_change_flags+0x40/0xb0
[   51.093273]  devinet_ioctl+0x583/0x790
[   51.093278]  inet_ioctl+0x1e9/0x200
[   51.093281]  sock_do_ioctl+0x7a/0x130
[   51.093286]  __x64_sys_ioctl+0x94/0xe0
[   51.093291]  do_syscall_64+0x82/0x2c0
[   51.093296]  ? __x64_sys_ioctl+0x94/0xe0
[   51.093299]  ? do_syscall_64+0x82/0x2c0
[   51.093301]  ? __x64_sys_readlink+0x1e/0x30
[   51.093305]  ? do_syscall_64+0x82/0x2c0
[   51.093307]  ? clear_bhb_loop+0x50/0xa0
[   51.093310]  ? clear_bhb_loop+0x50/0xa0
[   51.093312]  ? clear_bhb_loop+0x50/0xa0
[   51.093314]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   51.093316] RIP: 0033:0x7f22674fdaad
[   51.093318] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   51.093320] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   51.093322] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   51.093324] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   51.093325] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00007f22675=
f6ac0
[   51.093326] R10: 0000560087cc4370 R11: 0000000000000246 R12: 00000000000=
00001
[   51.093327] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   51.093329]  </TASK>
[   51.093330] ---[ end trace 0000000000000000 ]---
[   51.094005] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   51.095117] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   51.095119] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   51.095121] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   51.095123] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   51.095125] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   51.095126] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   51.095127] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   51.095128] iwlwifi 0000:00:14.3: 0x004C34B4 | interruptlink1
[   51.095130] iwlwifi 0000:00:14.3: 0x004C34B4 | interruptlink2
[   51.095131] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   51.095132] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   51.095133] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   51.095134] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   51.095135] iwlwifi 0000:00:14.3: 0x000287DF | tsf low
[   51.095136] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   51.095137] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   51.095138] iwlwifi 0000:00:14.3: 0x0002E68E | time gp2
[   51.095139] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   51.095140] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   51.095142] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   51.095143] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   51.095144] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   51.095145] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   51.095146] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   51.095147] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   51.095148] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   51.095149] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   51.095150] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   51.095151] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   51.095152] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   51.095153] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   51.095154] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   51.095155] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   51.095156] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   51.095157] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   51.095158] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   51.095159] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   51.095670] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   51.095671] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   51.095673] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   51.095674] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   51.095675] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   51.095676] iwlwifi 0000:00:14.3: 0xC0081674 | umac interruptlink1
[   51.095677] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   51.095678] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   51.095679] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   51.095680] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   51.095680] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   51.095681] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   51.095682] iwlwifi 0000:00:14.3: 0x0002E688 | frame pointer
[   51.095683] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   51.095684] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   51.095685] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   51.095796] iwlwifi 0000:00:14.3: IML/ROM dump:
[   51.095797] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   51.095892] iwlwifi 0000:00:14.3: 0x000059A4 | IML/ROM data1
[   51.095988] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   51.096036] iwlwifi 0000:00:14.3: Fseq Registers:
[   51.096062] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   51.096088] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   51.096115] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   51.096142] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   51.096169] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   51.096196] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   51.096222] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   51.096249] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   51.096276] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   51.096305] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   51.096333] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   51.096362] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   51.096388] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   51.096415] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   51.096441] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   51.096468] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   51.096564] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   51.096591] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   51.096627] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   51.096630] CPU: 5 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   51.096633] Tainted: [U]=3DUSER, [W]=3DWARN
[   51.096633] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   51.096634] Call Trace:
[   51.096635]  <TASK>
[   51.096636]  dump_stack_lvl+0x5d/0x80
[   51.096642]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   51.096667]  ? __pfx_autoremove_wake_function+0x10/0x10
[   51.096671]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   51.096693]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   51.096720]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   51.096740]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   51.096757]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   51.096773]  drv_add_interface+0x50/0x240 [mac80211]
[   51.096837]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   51.096883]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   51.096932]  ieee80211_open+0xa2/0xb0 [mac80211]
[   51.096970]  __dev_open+0x11b/0x2b0
[   51.096981]  __dev_change_flags+0x1fc/0x240
[   51.096983]  netif_change_flags+0x27/0x70
[   51.096984]  dev_change_flags+0x40/0xb0
[   51.096987]  devinet_ioctl+0x583/0x790
[   51.096990]  inet_ioctl+0x1e9/0x200
[   51.096994]  sock_do_ioctl+0x7a/0x130
[   51.096997]  __x64_sys_ioctl+0x94/0xe0
[   51.097001]  do_syscall_64+0x82/0x2c0
[   51.097005]  ? __x64_sys_ioctl+0x94/0xe0
[   51.097008]  ? do_syscall_64+0x82/0x2c0
[   51.097010]  ? __x64_sys_readlink+0x1e/0x30
[   51.097013]  ? do_syscall_64+0x82/0x2c0
[   51.097015]  ? clear_bhb_loop+0x50/0xa0
[   51.097017]  ? clear_bhb_loop+0x50/0xa0
[   51.097019]  ? clear_bhb_loop+0x50/0xa0
[   51.097021]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   51.097022] RIP: 0033:0x7f22674fdaad
[   51.097024] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   51.097025] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   51.097027] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   51.097028] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   51.097028] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00007f22675=
f6ac0
[   51.097029] R10: 0000560087cc4370 R11: 0000000000000246 R12: 00000000000=
00001
[   51.097030] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   51.097032]  </TASK>
[   51.097033] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   51.097047] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   59.232573] ------------[ cut here ]------------
[   59.232579] WARNING: CPU: 3 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   59.232618] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   59.232660]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   59.232709]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   59.232760] CPU: 3 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   59.232764] Tainted: [U]=3DUSER, [W]=3DWARN
[   59.232765] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   59.232767] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   59.232788] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   59.232791] RSP: 0018:ffffca55876e39e0 EFLAGS: 00010282
[   59.232793] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   59.232795] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   59.232796] RBP: ffffca55876e3a24 R08: 0000000000000308 R09: 00000000000=
00001
[   59.232797] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   59.232798] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   59.232800] FS:  00007f2267b25840(0000) GS:ffff88f55162e000(0000) knlGS:=
0000000000000000
[   59.232802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.232803] CR2: 00007feb781bf260 CR3: 000000010a8ab001 CR4: 0000000000f=
70ef0
[   59.232804] PKRU: 55555554
[   59.232806] Call Trace:
[   59.232809]  <TASK>
[   59.232813]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   59.232833]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   59.232851]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   59.232868]  drv_add_interface+0x50/0x240 [mac80211]
[   59.232927]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   59.232975]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   59.233023]  ieee80211_open+0xa2/0xb0 [mac80211]
[   59.233067]  __dev_open+0x11b/0x2b0
[   59.233073]  __dev_change_flags+0x1fc/0x240
[   59.233076]  netif_change_flags+0x27/0x70
[   59.233078]  dev_change_flags+0x40/0xb0
[   59.233081]  devinet_ioctl+0x583/0x790
[   59.233085]  inet_ioctl+0x1e9/0x200
[   59.233089]  sock_do_ioctl+0x7a/0x130
[   59.233094]  __x64_sys_ioctl+0x94/0xe0
[   59.233100]  do_syscall_64+0x82/0x2c0
[   59.233105]  ? do_syscall_64+0x82/0x2c0
[   59.233108]  ? do_syscall_64+0x82/0x2c0
[   59.233111]  ? __x64_sys_readlink+0x1e/0x30
[   59.233115]  ? do_syscall_64+0x82/0x2c0
[   59.233118]  ? __x64_sys_readlink+0x1e/0x30
[   59.233120]  ? do_syscall_64+0x82/0x2c0
[   59.233123]  ? clear_bhb_loop+0x50/0xa0
[   59.233126]  ? clear_bhb_loop+0x50/0xa0
[   59.233128]  ? clear_bhb_loop+0x50/0xa0
[   59.233130]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.233132] RIP: 0033:0x7f22674fdaad
[   59.233136] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   59.233137] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   59.233139] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   59.233141] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   59.233142] RBP: 00007ffc322cbae0 R08: 0000560087cc16b0 R09: 00007f22675=
f6ac0
[   59.233143] R10: 0000000000000003 R11: 0000000000000246 R12: 00000000000=
00001
[   59.233144] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
ca320
[   59.233146]  </TASK>
[   59.233147] ---[ end trace 0000000000000000 ]---
[   59.234023] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   59.235138] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   59.235141] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   59.235143] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   59.235146] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   59.235148] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   59.235150] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   59.235152] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   59.235154] iwlwifi 0000:00:14.3: 0x00019D84 | interruptlink1
[   59.235155] iwlwifi 0000:00:14.3: 0x00019D84 | interruptlink2
[   59.235157] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   59.235159] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   59.235161] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   59.235163] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   59.235164] iwlwifi 0000:00:14.3: 0x00029446 | tsf low
[   59.235166] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   59.235168] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   59.235170] iwlwifi 0000:00:14.3: 0x0002F4C7 | time gp2
[   59.235171] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   59.235173] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   59.235175] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   59.235176] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   59.235178] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   59.235180] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   59.235181] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   59.235183] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   59.235185] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   59.235187] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   59.235188] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   59.235190] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   59.235192] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   59.235194] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   59.235196] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   59.235197] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   59.235199] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   59.235201] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   59.235203] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   59.235204] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   59.235706] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   59.235709] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   59.235711] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   59.235713] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   59.235715] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   59.235717] iwlwifi 0000:00:14.3: 0xC008158E | umac interruptlink1
[   59.235719] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   59.235720] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   59.235722] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   59.235724] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   59.235726] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   59.235727] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   59.235729] iwlwifi 0000:00:14.3: 0x0002F4C2 | frame pointer
[   59.235731] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   59.235732] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   59.235734] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   59.235917] iwlwifi 0000:00:14.3: IML/ROM dump:
[   59.235919] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   59.235939] iwlwifi 0000:00:14.3: 0x00005B11 | IML/ROM data1
[   59.235949] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   59.235956] iwlwifi 0000:00:14.3: Fseq Registers:
[   59.235988] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   59.236015] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   59.236042] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   59.236075] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   59.236101] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   59.236128] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   59.236162] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   59.236188] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   59.236215] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   59.236244] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   59.236270] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   59.236309] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   59.236337] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   59.236364] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   59.236390] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   59.236417] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   59.236518] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   59.236559] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   59.236610] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   59.236614] CPU: 3 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   59.236618] Tainted: [U]=3DUSER, [W]=3DWARN
[   59.236618] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   59.236619] Call Trace:
[   59.236621]  <TASK>
[   59.236622]  dump_stack_lvl+0x5d/0x80
[   59.236628]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   59.236656]  ? __pfx_autoremove_wake_function+0x10/0x10
[   59.236661]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   59.236688]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   59.236715]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   59.236740]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   59.236760]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   59.236777]  drv_add_interface+0x50/0x240 [mac80211]
[   59.236816]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   59.236865]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   59.236912]  ieee80211_open+0xa2/0xb0 [mac80211]
[   59.236958]  __dev_open+0x11b/0x2b0
[   59.236960]  __dev_change_flags+0x1fc/0x240
[   59.236963]  netif_change_flags+0x27/0x70
[   59.236964]  dev_change_flags+0x40/0xb0
[   59.236967]  devinet_ioctl+0x583/0x790
[   59.236970]  inet_ioctl+0x1e9/0x200
[   59.236974]  sock_do_ioctl+0x7a/0x130
[   59.236977]  __x64_sys_ioctl+0x94/0xe0
[   59.236980]  do_syscall_64+0x82/0x2c0
[   59.236983]  ? do_syscall_64+0x82/0x2c0
[   59.236987]  ? do_syscall_64+0x82/0x2c0
[   59.236990]  ? __x64_sys_readlink+0x1e/0x30
[   59.236992]  ? do_syscall_64+0x82/0x2c0
[   59.236995]  ? __x64_sys_readlink+0x1e/0x30
[   59.236997]  ? do_syscall_64+0x82/0x2c0
[   59.237000]  ? clear_bhb_loop+0x50/0xa0
[   59.237002]  ? clear_bhb_loop+0x50/0xa0
[   59.237004]  ? clear_bhb_loop+0x50/0xa0
[   59.237006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.237008] RIP: 0033:0x7f22674fdaad
[   59.237010] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   59.237011] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   59.237013] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   59.237014] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   59.237015] RBP: 00007ffc322cbae0 R08: 0000560087cc16b0 R09: 00007f22675=
f6ac0
[   59.237016] R10: 0000000000000003 R11: 0000000000000246 R12: 00000000000=
00001
[   59.237016] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
ca320
[   59.237019]  </TASK>
[   59.237020] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   59.237038] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   64.224607] ------------[ cut here ]------------
[   64.224616] WARNING: CPU: 1 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   64.224699] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   64.224806]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   64.224923]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   64.225034] CPU: 1 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   64.225043] Tainted: [U]=3DUSER, [W]=3DWARN
[   64.225045] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   64.225049] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   64.225104] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   64.225110] RSP: 0018:ffffca55876e38e0 EFLAGS: 00010282
[   64.225116] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   64.225120] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   64.225124] RBP: ffffca55876e3924 R08: 0000000000000308 R09: 00000000000=
00001
[   64.225128] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   64.225131] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   64.225135] FS:  00007f2267b25840(0000) GS:ffff88f55152e000(0000) knlGS:=
0000000000000000
[   64.225140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.225144] CR2: 00007f25ba8caea8 CR3: 000000010a8ab001 CR4: 0000000000f=
70ef0
[   64.225148] PKRU: 55555554
[   64.225151] Call Trace:
[   64.225157]  <TASK>
[   64.225163]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   64.225218]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   64.225270]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   64.225319]  drv_add_interface+0x50/0x240 [mac80211]
[   64.225451]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   64.225602]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   64.225738]  ieee80211_open+0xa2/0xb0 [mac80211]
[   64.225868]  __dev_open+0x11b/0x2b0
[   64.225877]  __dev_change_flags+0x1fc/0x240
[   64.225885]  netif_change_flags+0x27/0x70
[   64.225891]  dev_change_flags+0x40/0xb0
[   64.225897]  devinet_ioctl+0x583/0x790
[   64.225908]  inet_ioctl+0x1e9/0x200
[   64.225918]  sock_do_ioctl+0x7a/0x130
[   64.225928]  __x64_sys_ioctl+0x94/0xe0
[   64.225938]  do_syscall_64+0x82/0x2c0
[   64.225952]  ? mntput_no_expire+0x4b/0x290
[   64.225962]  ? do_readlinkat+0x128/0x180
[   64.225970]  ? __x64_sys_readlink+0x1e/0x30
[   64.225976]  ? do_syscall_64+0x82/0x2c0
[   64.225983]  ? ksys_read+0xbf/0xf0
[   64.225989]  ? do_syscall_64+0x82/0x2c0
[   64.225997]  ? __x64_sys_readlink+0x1e/0x30
[   64.226003]  ? clear_bhb_loop+0x50/0xa0
[   64.226010]  ? clear_bhb_loop+0x50/0xa0
[   64.226015]  ? clear_bhb_loop+0x50/0xa0
[   64.226021]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.226027] RIP: 0033:0x7f22674fdaad
[   64.226034] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   64.226039] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   64.226045] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   64.226049] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   64.226053] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00000000000=
00000
[   64.226057] R10: 0000560087cc46e0 R11: 0000000000000246 R12: 00000000000=
00001
[   64.226060] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   64.226067]  </TASK>
[   64.226070] ---[ end trace 0000000000000000 ]---
[   64.226367] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   64.227528] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   64.227532] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   64.227536] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   64.227539] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   64.227542] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   64.227544] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   64.227546] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   64.227548] iwlwifi 0000:00:14.3: 0x004BF43A | interruptlink1
[   64.227550] iwlwifi 0000:00:14.3: 0x004BF43A | interruptlink2
[   64.227552] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   64.227554] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   64.227556] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   64.227558] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   64.227560] iwlwifi 0000:00:14.3: 0x000257B5 | tsf low
[   64.227562] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   64.227564] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   64.227566] iwlwifi 0000:00:14.3: 0x0002B4DA | time gp2
[   64.227568] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   64.227570] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   64.227572] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   64.227574] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   64.227576] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   64.227578] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   64.227580] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   64.227582] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   64.227584] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   64.227586] iwlwifi 0000:00:14.3: 0x04C3000C | isr3
[   64.227588] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   64.227590] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   64.227591] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   64.227593] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   64.227595] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   64.227597] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   64.227599] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   64.227601] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   64.227603] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   64.227605] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   64.227981] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   64.227983] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   64.227985] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   64.227987] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   64.227988] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   64.227990] iwlwifi 0000:00:14.3: 0xC0081228 | umac interruptlink1
[   64.227992] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   64.227993] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   64.227995] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   64.227996] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   64.227998] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   64.228000] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   64.228001] iwlwifi 0000:00:14.3: 0x0002B4D5 | frame pointer
[   64.228003] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   64.228004] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   64.228006] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   64.228106] iwlwifi 0000:00:14.3: IML/ROM dump:
[   64.228107] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   64.228128] iwlwifi 0000:00:14.3: 0x0000583D | IML/ROM data1
[   64.228231] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   64.228278] iwlwifi 0000:00:14.3: Fseq Registers:
[   64.228302] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   64.228326] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   64.228356] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   64.228380] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   64.228398] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   64.228423] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   64.228461] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   64.228486] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   64.228517] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   64.228544] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   64.228577] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   64.228614] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   64.228651] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   64.228688] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   64.228721] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   64.228758] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   64.228866] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   64.228901] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   64.228940] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   64.228950] CPU: 1 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   64.228957] Tainted: [U]=3DUSER, [W]=3DWARN
[   64.228958] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   64.228961] Call Trace:
[   64.228964]  <TASK>
[   64.228969]  dump_stack_lvl+0x5d/0x80
[   64.228984]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   64.229035]  ? __pfx_autoremove_wake_function+0x10/0x10
[   64.229043]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   64.229092]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   64.229142]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   64.229190]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   64.229228]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   64.229265]  drv_add_interface+0x50/0x240 [mac80211]
[   64.229363]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   64.229456]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   64.229554]  ieee80211_open+0xa2/0xb0 [mac80211]
[   64.229645]  __dev_open+0x11b/0x2b0
[   64.229652]  __dev_change_flags+0x1fc/0x240
[   64.229657]  netif_change_flags+0x27/0x70
[   64.229660]  dev_change_flags+0x40/0xb0
[   64.229665]  devinet_ioctl+0x583/0x790
[   64.229672]  inet_ioctl+0x1e9/0x200
[   64.229680]  sock_do_ioctl+0x7a/0x130
[   64.229688]  __x64_sys_ioctl+0x94/0xe0
[   64.229696]  do_syscall_64+0x82/0x2c0
[   64.229705]  ? mntput_no_expire+0x4b/0x290
[   64.229713]  ? do_readlinkat+0x128/0x180
[   64.229718]  ? __x64_sys_readlink+0x1e/0x30
[   64.229723]  ? do_syscall_64+0x82/0x2c0
[   64.229727]  ? ksys_read+0xbf/0xf0
[   64.229732]  ? do_syscall_64+0x82/0x2c0
[   64.229737]  ? __x64_sys_readlink+0x1e/0x30
[   64.229741]  ? clear_bhb_loop+0x50/0xa0
[   64.229746]  ? clear_bhb_loop+0x50/0xa0
[   64.229749]  ? clear_bhb_loop+0x50/0xa0
[   64.229753]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.229757] RIP: 0033:0x7f22674fdaad
[   64.229761] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   64.229764] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   64.229769] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   64.229771] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   64.229773] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00000000000=
00000
[   64.229775] R10: 0000560087cc46e0 R11: 0000000000000246 R12: 00000000000=
00001
[   64.229777] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   64.229782]  </TASK>
[   64.229808] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   64.229829] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   74.274098] ------------[ cut here ]------------
[   74.274106] WARNING: CPU: 1 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   74.274171] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   74.274248]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   74.274332]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   74.274433] CPU: 1 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   74.274441] Tainted: [U]=3DUSER, [W]=3DWARN
[   74.274443] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   74.274446] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   74.274488] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   74.274492] RSP: 0018:ffffca55876e39b0 EFLAGS: 00010282
[   74.274497] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   74.274500] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   74.274503] RBP: ffffca55876e39f4 R08: 0000000000000308 R09: 00000000000=
00001
[   74.274505] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   74.274507] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   74.274510] FS:  00007f2267b25840(0000) GS:ffff88f55152e000(0000) knlGS:=
0000000000000000
[   74.274514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   74.274516] CR2: 000000c0019ff360 CR3: 000000010a8ab006 CR4: 0000000000f=
70ef0
[   74.274519] PKRU: 55555554
[   74.274522] Call Trace:
[   74.274526]  <TASK>
[   74.274531]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   74.274569]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   74.274605]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   74.274637]  drv_add_interface+0x50/0x240 [mac80211]
[   74.274724]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   74.274818]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   74.274911]  ieee80211_open+0xa2/0xb0 [mac80211]
[   74.274997]  __dev_open+0x11b/0x2b0
[   74.275005]  __dev_change_flags+0x1fc/0x240
[   74.275011]  netif_change_flags+0x27/0x70
[   74.275015]  dev_change_flags+0x40/0xb0
[   74.275020]  devinet_ioctl+0x583/0x790
[   74.275028]  inet_ioctl+0x1e9/0x200
[   74.275036]  sock_do_ioctl+0x7a/0x130
[   74.275044]  __x64_sys_ioctl+0x94/0xe0
[   74.275054]  do_syscall_64+0x82/0x2c0
[   74.275062]  ? __sys_recvmsg+0x87/0xe0
[   74.275068]  ? do_syscall_64+0x82/0x2c0
[   74.275074]  ? do_syscall_64+0x82/0x2c0
[   74.275079]  ? __x64_sys_readlink+0x1e/0x30
[   74.275086]  ? do_syscall_64+0x82/0x2c0
[   74.275091]  ? do_syscall_64+0x82/0x2c0
[   74.275097]  ? __x64_sys_setsockopt+0x1f/0x30
[   74.275104]  ? do_syscall_64+0x82/0x2c0
[   74.275109]  ? clear_bhb_loop+0x50/0xa0
[   74.275115]  ? clear_bhb_loop+0x50/0xa0
[   74.275119]  ? clear_bhb_loop+0x50/0xa0
[   74.275123]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.275128] RIP: 0033:0x7f22674fdaad
[   74.275133] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   74.275136] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   74.275141] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   74.275144] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   74.275146] RBP: 00007ffc322cbae0 R08: 0000560087cc16b0 R09: 00007f22675=
f6ac0
[   74.275148] R10: 0000000000000003 R11: 0000000000000246 R12: 00000000000=
00001
[   74.275150] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
ca320
[   74.275155]  </TASK>
[   74.275157] ---[ end trace 0000000000000000 ]---
[   74.275868] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   74.277068] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   74.277071] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   74.277075] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   74.277078] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   74.277081] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   74.277084] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   74.277086] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   74.277089] iwlwifi 0000:00:14.3: 0x004C34B4 | interruptlink1
[   74.277091] iwlwifi 0000:00:14.3: 0x004C34B4 | interruptlink2
[   74.277093] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   74.277095] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   74.277098] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   74.277100] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   74.277102] iwlwifi 0000:00:14.3: 0x00030658 | tsf low
[   74.277104] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   74.277106] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   74.277109] iwlwifi 0000:00:14.3: 0x000371C1 | time gp2
[   74.277111] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   74.277113] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   74.277116] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   74.277118] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   74.277121] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   74.277123] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   74.277125] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   74.277127] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   74.277129] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   74.277132] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   74.277134] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   74.277136] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   74.277138] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   74.277142] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   74.277144] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   74.277146] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   74.277149] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   74.277151] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   74.277153] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   74.277155] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   74.277509] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   74.277512] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   74.277515] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   74.277517] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   74.277520] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   74.277522] iwlwifi 0000:00:14.3: 0x8046E0A8 | umac interruptlink1
[   74.277525] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   74.277527] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   74.277529] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   74.277531] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   74.277533] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   74.277536] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   74.277538] iwlwifi 0000:00:14.3: 0x000371BB | frame pointer
[   74.277540] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   74.277542] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   74.277544] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   74.277648] iwlwifi 0000:00:14.3: IML/ROM dump:
[   74.277650] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   74.277670] iwlwifi 0000:00:14.3: 0x0000667A | IML/ROM data1
[   74.277745] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   74.277803] iwlwifi 0000:00:14.3: Fseq Registers:
[   74.277826] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   74.277851] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   74.277876] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   74.277914] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   74.277951] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   74.277976] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   74.278000] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   74.278024] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   74.278048] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   74.278089] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   74.278127] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   74.278152] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   74.278176] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   74.278192] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   74.278216] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   74.278248] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   74.278356] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   74.278396] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   74.278505] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   74.278514] CPU: 1 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   74.278527] Tainted: [U]=3DUSER, [W]=3DWARN
[   74.278528] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   74.278530] Call Trace:
[   74.278533]  <TASK>
[   74.278536]  dump_stack_lvl+0x5d/0x80
[   74.278550]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   74.278603]  ? __pfx_autoremove_wake_function+0x10/0x10
[   74.278612]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   74.278664]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   74.278712]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   74.278763]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   74.278802]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   74.278838]  drv_add_interface+0x50/0x240 [mac80211]
[   74.278916]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   74.279011]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   74.279101]  ieee80211_open+0xa2/0xb0 [mac80211]
[   74.279188]  __dev_open+0x11b/0x2b0
[   74.279193]  __dev_change_flags+0x1fc/0x240
[   74.279197]  netif_change_flags+0x27/0x70
[   74.279200]  dev_change_flags+0x40/0xb0
[   74.279204]  devinet_ioctl+0x583/0x790
[   74.279210]  inet_ioctl+0x1e9/0x200
[   74.279218]  sock_do_ioctl+0x7a/0x130
[   74.279224]  __x64_sys_ioctl+0x94/0xe0
[   74.279230]  do_syscall_64+0x82/0x2c0
[   74.279236]  ? __sys_recvmsg+0x87/0xe0
[   74.279241]  ? do_syscall_64+0x82/0x2c0
[   74.279246]  ? do_syscall_64+0x82/0x2c0
[   74.279251]  ? __x64_sys_readlink+0x1e/0x30
[   74.279256]  ? do_syscall_64+0x82/0x2c0
[   74.279261]  ? do_syscall_64+0x82/0x2c0
[   74.279266]  ? __x64_sys_setsockopt+0x1f/0x30
[   74.279271]  ? do_syscall_64+0x82/0x2c0
[   74.279276]  ? clear_bhb_loop+0x50/0xa0
[   74.279280]  ? clear_bhb_loop+0x50/0xa0
[   74.279283]  ? clear_bhb_loop+0x50/0xa0
[   74.279287]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.279291] RIP: 0033:0x7f22674fdaad
[   74.279296] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   74.279299] RSP: 002b:00007ffc322cba90 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   74.279304] RAX: ffffffffffffffda RBX: 0000560087cca620 RCX: 00007f22674=
fdaad
[   74.279306] RDX: 00007ffc322cbaf0 RSI: 0000000000008914 RDI: 00000000000=
00008
[   74.279308] RBP: 00007ffc322cbae0 R08: 0000560087cc16b0 R09: 00007f22675=
f6ac0
[   74.279310] R10: 0000000000000003 R11: 0000000000000246 R12: 00000000000=
00001
[   74.279312] R13: 0000000000000000 R14: 0000000000000008 R15: 0000560087c=
ca320
[   74.279316]  </TASK>
[   74.279319] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   74.279378] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   80.446490] ------------[ cut here ]------------
[   80.446497] WARNING: CPU: 1 PID: 1363 at drivers/net/wireless/intel/iwlw=
ifi/mvm/mld-mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmvm]
[   80.446562] Modules linked in: uinput xt_conntrack rfcomm snd_seq_dummy =
snd_hrtimer xt_MASQUERADE bridge stp llc xt_set ip_set xt_addrtype overlay =
xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fi=
b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_=
reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 nf_tables qrtr sunrpc binfmt_misc snd_soc_skl_hda_dsp sn=
d_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common s=
nd_soc_dmic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic=
 soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc=
_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soun=
dwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils iwlmvm s=
nd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_al=
location snd_soc_acpi crc8 soundwire_bus snd_soc_sdca
[   80.446639]  mac80211 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core lib=
arc4 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg snd_intel_sdw_acpi intel_uncore_frequency intel_uncore_freque=
ncy_common snd_hda_codec uvcvideo snd_hda_core intel_tcc_cooling snd_hwdep =
uvc mei_hdcp videobuf2_vmalloc x86_pkg_temp_thermal snd_seq intel_powerclam=
p videobuf2_memops iTCO_wdt videobuf2_v4l2 coretemp videobuf2_common snd_se=
q_device processor_thermal_device_pci_legacy iwlwifi mei_pxp think_lmi proc=
essor_thermal_device intel_pmc_bxt videodev processor_thermal_wt_hint iTCO_=
vendor_support rapl spi_nor vfat platform_temperature_control intel_cstate =
fat mtd intel_rapl_msr intel_uncore mc pcspkr firmware_attributes_class wmi=
_bmof snd_pcm snd_ctl_led processor_thermal_rfim processor_thermal_rapl i2c=
_i801 mei_me spi_intel_pci intel_rapl_common cfg80211 i2c_smbus spi_intel i=
dma64 snd_timer mei processor_thermal_wt_req processor_thermal_power_floor =
processor_thermal_mbox intel_soc_dts_iosf igen6_edac
[   80.446724]  thinkpad_acpi platform_profile snd soundcore int3403_therma=
l int340x_thermal_zone soc_button_array intel_pmc_core pmt_telemetry int340=
0_thermal intel_hid pmt_class acpi_tad acpi_pad sparse_keymap acpi_thermal_=
rel intel_pmc_ssram_telemetry joydev loop nfnetlink zram lz4hc_compress lz4=
_compress ucsi_acpi typec_ucsi typec xe drm_ttm_helper drm_suballoc_helper =
gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btintel btbcm btmt=
k bluetooth rfkill i915 i2c_algo_bit drm_buddy ttm nvme nvme_core drm_displ=
ay_helper polyval_clmulni ghash_clmulni_intel sha512_ssse3 hid_multitouch n=
vme_keyring sha1_ssse3 nvme_auth thunderbolt intel_vsec cec i2c_hid_acpi i2=
c_hid video wmi pinctrl_tigerlake serio_raw i2c_dev fuse
[   80.446808] CPU: 1 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   80.446815] Tainted: [U]=3DUSER, [W]=3DWARN
[   80.446818] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   80.446820] RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0 [iwlmv=
m]
[   80.446864] Code: 45 19 01 eb a0 b8 01 00 00 00 66 89 45 18 eb 95 41 83 =
fc 02 74 27 c6 45 19 01 eb c8 b9 01 00 00 00 66 89 4d 1a e9 7b ff ff ff <0f=
> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc bf 01 00
[   80.446868] RSP: 0018:ffffca55876e3840 EFLAGS: 00010282
[   80.446873] RAX: 00000000ffffffff RBX: ffff88f1c40e5c98 RCX: ffff88f1c02=
dd6fc
[   80.446876] RDX: 00000000000000bf RSI: 0000000000000003 RDI: ffff88f1c02=
dd6fc
[   80.446878] RBP: ffffca55876e3884 R08: 0000000000000308 R09: 00000000000=
00001
[   80.446881] R10: 0000000000000000 R11: ffff88f1c3ca8028 R12: 00000000000=
00000
[   80.446883] R13: ffff88f1c3f12008 R14: 0000000000000001 R15: ffff88f1c40=
e5c98
[   80.446886] FS:  00007f2267b25840(0000) GS:ffff88f55152e000(0000) knlGS:=
0000000000000000
[   80.446890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.446892] CR2: 000055ff96757310 CR3: 000000010a8ab006 CR4: 0000000000f=
70ef0
[   80.446895] PKRU: 55555554
[   80.446898] Call Trace:
[   80.446901]  <TASK>
[   80.446906]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x6a/0x1d0 [iwlmvm]
[   80.446946]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   80.446981]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   80.447015]  drv_add_interface+0x50/0x240 [mac80211]
[   80.447102]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   80.447198]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   80.447301]  ieee80211_open+0xa2/0xb0 [mac80211]
[   80.447392]  __dev_open+0x11b/0x2b0
[   80.447400]  __dev_change_flags+0x1fc/0x240
[   80.447405]  netif_change_flags+0x27/0x70
[   80.447409]  dev_change_flags+0x40/0xb0
[   80.447415]  devinet_ioctl+0x583/0x790
[   80.447423]  inet_ioctl+0x1e9/0x200
[   80.447431]  sock_do_ioctl+0x7a/0x130
[   80.447439]  __x64_sys_ioctl+0x94/0xe0
[   80.447448]  do_syscall_64+0x82/0x2c0
[   80.447458]  ? __x64_sys_ioctl+0x94/0xe0
[   80.447465]  ? do_syscall_64+0x82/0x2c0
[   80.447471]  ? __x64_sys_readlink+0x1e/0x30
[   80.447477]  ? do_syscall_64+0x82/0x2c0
[   80.447484]  ? mntput_no_expire+0x4b/0x290
[   80.447492]  ? do_readlinkat+0x128/0x180
[   80.447497]  ? __x64_sys_readlink+0x1e/0x30
[   80.447502]  ? do_syscall_64+0x82/0x2c0
[   80.447509]  ? __x64_sys_readlink+0x1e/0x30
[   80.447514]  ? do_syscall_64+0x82/0x2c0
[   80.447520]  ? do_syscall_64+0x82/0x2c0
[   80.447525]  ? __x64_sys_sendto+0x24/0x30
[   80.447531]  ? clear_bhb_loop+0x50/0xa0
[   80.447536]  ? clear_bhb_loop+0x50/0xa0
[   80.447540]  ? clear_bhb_loop+0x50/0xa0
[   80.447544]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.447549] RIP: 0033:0x7f22674fdaad
[   80.447553] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   80.447557] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   80.447562] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   80.447564] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   80.447567] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00000000000=
00000
[   80.447569] R10: 0000560087cc4f60 R11: 0000000000000246 R12: 00000000000=
00001
[   80.447571] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   80.447576]  </TASK>
[   80.447577] ---[ end trace 0000000000000000 ]---
[   80.448315] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   80.449434] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   80.449437] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   80.449441] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   80.449444] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   80.449447] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   80.449450] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   80.449452] iwlwifi 0000:00:14.3: 0x004C958E | branchlink2
[   80.449455] iwlwifi 0000:00:14.3: 0x000156BC | interruptlink1
[   80.449457] iwlwifi 0000:00:14.3: 0x000156BC | interruptlink2
[   80.449459] iwlwifi 0000:00:14.3: 0x00014F06 | data1
[   80.449462] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   80.449464] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   80.449466] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   80.449469] iwlwifi 0000:00:14.3: 0x0002A08F | tsf low
[   80.449471] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   80.449473] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   80.449475] iwlwifi 0000:00:14.3: 0x00030125 | time gp2
[   80.449478] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   80.449480] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   80.449482] iwlwifi 0000:00:14.3: 0x864BAA2E | uCode version minor
[   80.449485] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   80.449487] iwlwifi 0000:00:14.3: 0x18489001 | board version
[   80.449489] iwlwifi 0000:00:14.3: 0x00120148 | hcmd
[   80.449492] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   80.449494] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   80.449496] iwlwifi 0000:00:14.3: 0x08F04002 | isr2
[   80.449498] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[   80.449500] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   80.449502] iwlwifi 0000:00:14.3: 0x00120148 | last cmd Id
[   80.449505] iwlwifi 0000:00:14.3: 0x00014F06 | wait_event
[   80.449507] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   80.449509] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   80.449511] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   80.449514] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   80.449516] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   80.449518] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   80.449520] iwlwifi 0000:00:14.3: 0x00001050 | flow_handler
[   80.449961] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   80.449964] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   80.449967] iwlwifi 0000:00:14.3: 0x20103126 | ADVANCED_SYSASSERT
[   80.449970] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   80.449972] iwlwifi 0000:00:14.3: 0x804561F6 | umac branchlink2
[   80.449974] iwlwifi 0000:00:14.3: 0xC008165C | umac interruptlink1
[   80.449977] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   80.449979] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   80.449981] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   80.449983] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   80.449985] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   80.449987] iwlwifi 0000:00:14.3: 0x864BAA2E | umac minor
[   80.449990] iwlwifi 0000:00:14.3: 0x00030120 | frame pointer
[   80.449992] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   80.449994] iwlwifi 0000:00:14.3: 0x00130308 | last host cmd
[   80.449996] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   80.450022] iwlwifi 0000:00:14.3: IML/ROM dump:
[   80.450024] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   80.450124] iwlwifi 0000:00:14.3: 0x00005BAB | IML/ROM data1
[   80.450146] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   80.450182] iwlwifi 0000:00:14.3: Fseq Registers:
[   80.450195] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   80.450230] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   80.450275] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   80.450304] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   80.450344] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   80.450369] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   80.450392] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   80.450409] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   80.450443] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   80.450472] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   80.450503] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   80.450519] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   80.450552] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   80.450582] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   80.450617] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   80.450653] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   80.450749] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x804732b8
[   80.450771] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   80.450906] iwlwifi 0000:00:14.3: FW error in SYNC CMD MAC_CONFIG_CMD
[   80.450915] CPU: 1 UID: 0 PID: 1363 Comm: wpa_supplicant Tainted: G     =
U  W           6.16.0-rc2 #440 PREEMPT(lazy)=20
[   80.450922] Tainted: [U]=3DUSER, [W]=3DWARN
[   80.450923] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   80.450925] Call Trace:
[   80.450927]  <TASK>
[   80.450930]  dump_stack_lvl+0x5d/0x80
[   80.450941]  iwl_trans_pcie_send_hcmd_sync+0x353/0x360 [iwlwifi]
[   80.450990]  ? __pfx_autoremove_wake_function+0x10/0x10
[   80.450998]  iwl_trans_send_cmd+0x4b/0xe0 [iwlwifi]
[   80.451048]  iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
[   80.451097]  iwl_mvm_mld_mac_ctxt_cmd_sta+0x10c/0x1d0 [iwlmvm]
[   80.451145]  iwl_mvm_mld_mac_ctxt_add+0x34/0xd0 [iwlmvm]
[   80.451184]  iwl_mvm_mld_mac_add_interface+0x130/0x3e0 [iwlmvm]
[   80.451218]  drv_add_interface+0x50/0x240 [mac80211]
[   80.451290]  ? ieee80211_del_virtual_monitor+0x33/0xe0 [mac80211]
[   80.451388]  ieee80211_do_open+0x57b/0x720 [mac80211]
[   80.451480]  ieee80211_open+0xa2/0xb0 [mac80211]
[   80.451570]  __dev_open+0x11b/0x2b0
[   80.451575]  __dev_change_flags+0x1fc/0x240
[   80.451579]  netif_change_flags+0x27/0x70
[   80.451582]  dev_change_flags+0x40/0xb0
[   80.451587]  devinet_ioctl+0x583/0x790
[   80.451593]  inet_ioctl+0x1e9/0x200
[   80.451600]  sock_do_ioctl+0x7a/0x130
[   80.451606]  __x64_sys_ioctl+0x94/0xe0
[   80.451612]  do_syscall_64+0x82/0x2c0
[   80.451620]  ? __x64_sys_ioctl+0x94/0xe0
[   80.451625]  ? do_syscall_64+0x82/0x2c0
[   80.451631]  ? __x64_sys_readlink+0x1e/0x30
[   80.451636]  ? do_syscall_64+0x82/0x2c0
[   80.451642]  ? mntput_no_expire+0x4b/0x290
[   80.451649]  ? do_readlinkat+0x128/0x180
[   80.451654]  ? __x64_sys_readlink+0x1e/0x30
[   80.451658]  ? do_syscall_64+0x82/0x2c0
[   80.451664]  ? __x64_sys_readlink+0x1e/0x30
[   80.451669]  ? do_syscall_64+0x82/0x2c0
[   80.451674]  ? do_syscall_64+0x82/0x2c0
[   80.451679]  ? __x64_sys_sendto+0x24/0x30
[   80.451684]  ? clear_bhb_loop+0x50/0xa0
[   80.451688]  ? clear_bhb_loop+0x50/0xa0
[   80.451692]  ? clear_bhb_loop+0x50/0xa0
[   80.451696]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.451699] RIP: 0033:0x7f22674fdaad
[   80.451704] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   80.451707] RSP: 002b:00007ffc322cbaa0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   80.451712] RAX: ffffffffffffffda RBX: 0000560087ccaf58 RCX: 00007f22674=
fdaad
[   80.451714] RDX: 00007ffc322cbb00 RSI: 0000000000008914 RDI: 00000000000=
00009
[   80.451716] RBP: 00007ffc322cbaf0 R08: 0000000000000000 R09: 00000000000=
00000
[   80.451718] R10: 0000560087cc4f60 R11: 0000000000000246 R12: 00000000000=
00001
[   80.451720] R13: 0000000000000000 R14: 0000000000000009 R15: 0000560087c=
caf69
[   80.451725]  </TASK>
[   80.451750] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:=
0): -5
[   80.451781] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   91.060727] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x0, CPU2 Status:=
 0xa30001
[   91.060794] iwlwifi 0000:00:14.3: WFPM_LMAC1_PD_NOTIFICATION: 0xf
[   91.060905] iwlwifi 0000:00:14.3: HPM_SECONDARY_DEVICE_STATE: 0x742
[   91.060928] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_ADDR: 0x0
[   91.061033] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_DATA: 0x0
[   91.061036] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xa05c18
[   91.061039] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xa05c1c
[   91.061043] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 13 f=
ired (delay=3D0ms).
[   91.062373] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   91.062376] iwlwifi 0000:00:14.3: Transport status: 0x00000042, valid: -=
1379803701
[   91.062380] iwlwifi 0000:00:14.3: Loaded firmware version: 77.864baa2e.0=
 QuZ-a0-hr-b0-77.ucode
[   91.062384] iwlwifi 0000:00:14.3: 0x2D4A8C5E | ADVANCED_SYSASSERT       =
  =20
[   91.062388] iwlwifi 0000:00:14.3: 0x5172A05C | trm_hw_status0
[   91.062390] iwlwifi 0000:00:14.3: 0x38D84651 | trm_hw_status1
[   91.062393] iwlwifi 0000:00:14.3: 0x727E1ACC | branchlink2
[   91.062395] iwlwifi 0000:00:14.3: 0x87230EAA | interruptlink1
[   91.062397] iwlwifi 0000:00:14.3: 0x7FF97F16 | interruptlink2
[   91.062400] iwlwifi 0000:00:14.3: 0x9A75320E | data1
[   91.062402] iwlwifi 0000:00:14.3: 0xE83EA8DD | data2
[   91.062404] iwlwifi 0000:00:14.3: 0xA3A6A85D | data3
[   91.062406] iwlwifi 0000:00:14.3: 0xC2BCFF08 | beacon time
[   91.062409] iwlwifi 0000:00:14.3: 0x75A5A979 | tsf low
[   91.062411] iwlwifi 0000:00:14.3: 0x4BF19D1E | tsf hi
[   91.062414] iwlwifi 0000:00:14.3: 0x85DA5E23 | time gp1
[   91.062416] iwlwifi 0000:00:14.3: 0xEDEC6E3E | time gp2
[   91.062418] iwlwifi 0000:00:14.3: 0x27D3E785 | uCode revision type
[   91.062421] iwlwifi 0000:00:14.3: 0xBBE6625F | uCode version major
[   91.062423] iwlwifi 0000:00:14.3: 0xBC070949 | uCode version minor
[   91.062426] iwlwifi 0000:00:14.3: 0x77ACF6FD | hw version
[   91.062428] iwlwifi 0000:00:14.3: 0x731CBCAD | board version
[   91.062430] iwlwifi 0000:00:14.3: 0xEAE4B371 | hcmd
[   91.062433] iwlwifi 0000:00:14.3: 0xF22CC09C | isr0
[   91.062435] iwlwifi 0000:00:14.3: 0x0781E3FA | isr1
[   91.062437] iwlwifi 0000:00:14.3: 0x38EB3DA4 | isr2
[   91.062440] iwlwifi 0000:00:14.3: 0x2B297E2C | isr3
[   91.062442] iwlwifi 0000:00:14.3: 0x877717CF | isr4
[   91.062444] iwlwifi 0000:00:14.3: 0x875097A5 | last cmd Id
[   91.062447] iwlwifi 0000:00:14.3: 0x1DFEFF9A | wait_event
[   91.062449] iwlwifi 0000:00:14.3: 0x5A6AED97 | l2p_control
[   91.062451] iwlwifi 0000:00:14.3: 0xAA6DAF7B | l2p_duration
[   91.062453] iwlwifi 0000:00:14.3: 0x97764497 | l2p_mhvalid
[   91.062456] iwlwifi 0000:00:14.3: 0xE66A77C9 | l2p_addr_match
[   91.062458] iwlwifi 0000:00:14.3: 0x29C7AFDB | lmpm_pmg_sel
[   91.062461] iwlwifi 0000:00:14.3: 0x836B4F7E | timestamp
[   91.062463] iwlwifi 0000:00:14.3: 0xA96264AE | flow_handler
[   91.062947] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
[   91.062950] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   91.062953] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink2
[   91.062955] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
[   91.062957] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   91.062959] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
[   91.062962] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
[   91.062964] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[   91.062966] iwlwifi 0000:00:14.3: 0x00000000 | umac major
[   91.062968] iwlwifi 0000:00:14.3: 0x00000000 | umac minor
[   91.062970] iwlwifi 0000:00:14.3: 0x00000000 | frame pointer
[   91.062973] iwlwifi 0000:00:14.3: 0x00000000 | stack pointer
[   91.062975] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
[   91.062977] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   91.063153] iwlwifi 0000:00:14.3: IML/ROM dump:
[   91.063156] iwlwifi 0000:00:14.3: 0x00A3 | IML/ROM SYSASSERT
[   91.063158] iwlwifi 0000:00:14.3: 0x00A30001 | IML/ROM error/state
[   91.063291] iwlwifi 0000:00:14.3: 0x00000000 | IML/ROM data1
[   91.063314] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   91.063370] iwlwifi 0000:00:14.3: Fseq Registers:
[   91.063407] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   91.063440] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   91.063475] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   91.063511] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   91.063545] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   91.063583] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   91.063620] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   91.063657] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   91.063692] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   91.063731] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   91.063768] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   91.063805] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   91.063843] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   91.063877] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   91.063911] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   91.063945] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSION
[   91.064050] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xc00c0538
[   91.064084] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0x0
[   91.064122] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
[   91.064126] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
[   91.064128] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 13 f=
ired (delay=3D0ms).
[   99.739138] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).

--Gnkklz0/JNFkrAiQ--

