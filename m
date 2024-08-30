Return-Path: <linux-wireless+bounces-12218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9889653FE
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 02:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B2C281773
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4B23B1;
	Fri, 30 Aug 2024 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmUXbOxW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0A20EB
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977682; cv=none; b=BTRoMZiwdsZu2FAf2n6a/2QdnXLshqMv7oKOSsl9fetAC7MCNMAbl3cGEzBVJYMjTTV9R5tDrNE4mHF9jVBtuTDmuh3dYH4DE6ssCgHCBI5fhtNY162hGurXdvqyKuLJFUh5TbdAckabh4muqJr3To1E6qlr4MaEWyKYDs9l9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977682; c=relaxed/simple;
	bh=W/txdxv5IWcTfsxdhSsvFoLpEP/+jw+O07hDWJfovgc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QowZTA9wzi4B27DpiWVyOFW3EAe9XzqKkCIVTAREZMSeMwqrTVfVpEBm8XJyXXNzGRt8Ky+p6tqBmE+BlZN8DN/EunuV7ulU7KbvGZOhVzn8Qbzs+jI4RuuMTKPJCrEp6sS7sq6B9N3dgkxtr+S2C+hLEAldLQZ5qGCs8q8wI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmUXbOxW; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-273c8514254so809190fac.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724977678; x=1725582478; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naohoP2fswB4ceg0sWGOPzWhX0JJdXQLEWTldBkSPys=;
        b=CmUXbOxWG1mungwzJsAy3zCf9QaiSMoOH70EYNKAc/95o0/tgPR3/5uaGMMP7lKqda
         54U7FCCwwDy8GHX1nCmMSHY1nrPsl00nHRrGhGPSO+dmnX37a84LYPJFvs6iVEL/b6G1
         ELkJpR36gUMQkxVDP4GM8J4bnD8ejOZFpRGwH361E9XluAq9+8iuZ0A0bvBXXxvc8w1K
         iJHWQoKC8IwbnCgWfBKvjdlhTNNg7Wz+rS6bhHxOEZdH2IiWgBnh/wll/G6nRbC1t63e
         8jLYhkQWv2+XPxWH62D83LIrfVSYMfofQOqm6P14DAZ1Txj7t5IvXIixqFGGE1qI2wBl
         Ktyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724977678; x=1725582478;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naohoP2fswB4ceg0sWGOPzWhX0JJdXQLEWTldBkSPys=;
        b=jJRsK489v2bWoIUyoeBOrF654Vs6QaxHqGQBTVean9Ve026egi2rnzPuAV7BrfcM/k
         bQpN+iZJxd2fVA+OqsibKo4kxiat9mebvXGA5jEwyVf0Wo6xjNBBlSItkgtSfiqj5rWP
         14A7ZArE7WQD0wLxs1rKNwVel8CCigFOC4uIzpL0W+mWMX9SV/2W5tU6b7QLoJDTAGet
         GH/+v1CUSzz0TMjhusFx2Dj+vU+hpey6VKrcv5sikyws8+RMgA6wXAadiqawWkkaFPEl
         WMJV6DYnQuEnvamWXA8QnrTUWn0jq+lyP5QjmfmE7PfdbzH6BpoRaFZIqHk4hMZq3vLN
         JlbA==
X-Gm-Message-State: AOJu0YzlGFryZn54pK54Pnna4Uncd38XTaNHmsrING8LxbeCozkQ9I80
	WDwOILWtUQppsdDM7LgSLvLgWYMB6pBV+5epFAs7Vjh7g7yLdW90PrB3yu2ak1P6lUEFhsqUrTT
	b56KdZh3I2rBzsBrQh3dwDug0blCVyKC2
X-Google-Smtp-Source: AGHT+IGCvPAhcUnLyI80qHyNdYEA+rhWt4NY0R8ToUbqktTummneaTb9/FFRC27IuvpGRTzMfLJifxMaSgC9LsOXQxA=
X-Received: by 2002:a05:6870:4f09:b0:254:a811:6c75 with SMTP id
 586e51a60fabf-2779008e031mr5206863fac.7.1724977678300; Thu, 29 Aug 2024
 17:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: linasvepstas@gmail.com
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Thu, 29 Aug 2024 19:27:47 -0500
Message-ID: <CAHrUA36mW-M-5jaqnFguM+3_kc9Uki1b++v4nQOeQ11iba84yQ@mail.gmail.com>
Subject: rtw88_8821ce (sometimes) fails to wake from sleep
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rtw_8821ce driver fails to wake after a suspend to disk. I've had
this problem for years; it seems to afflict all 6.x kernels (and 5.x,
too). Newer kernels are better-behaved, but the problem continues.
From what I can tell, the problem happens only when there is network
activity during the suspend, e.g. if firefox is running during the
suspend. If the network is idle, suspend and wake appear to work fine.

The laptop is off-brand Chinese.  Partial lspci:

00:00.0 Host bridge: Intel Corporation Gemini Lake Host Bridge (rev 06)
00:00.1 Signal processing controller: Intel Corporation
Celeron/Pentium Silver Processor Dynamic Platform and Thermal
Framework Processor Participant (rev 06)
00:13.0 PCI bridge: Intel Corporation Gemini Lake PCI Express Root Port (rev f6)
01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE
802.11ac PCIe Wireless Network Adapter

Stack traces below. Note that two different stack traces are reported
in rapid succession. I've included some surrounding cruft for context.

I'm an experienced kernel developer; I can do a lot of debugging, but
would appreciate some help getting started and hints about tools to
use, things to look at. Let me know how to proceed?

Here's the kernel log for torvald's 6.11-rc5 (today's kernel)

[  363.987297] ACPI: PM: Low-level resume complete
[  363.987363] ACPI: EC: EC started
[  363.987364] ACPI: PM: Restoring platform NVS memory
[  363.988361] Enabling non-boot CPUs ...
[  363.988428] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  363.990145] CPU1 is up
[  363.990189] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  363.991968] CPU2 is up
[  363.992015] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  363.993862] CPU3 is up
[  363.994109] ACPI: PM: Waking up from system sleep state S3
[  364.000153] ACPI: EC: interrupt unblocked
[  364.001579] rtw_8821ce 0000:01:00.0: Unable to change power state
from D3hot to D0, device inaccessible
[  364.067364] ACPI: EC: event unblocked
[  366.070045] mei_me 0000:00:0f.0: wait hw ready failed
[  366.070080] mei_me 0000:00:0f.0: hw_start failed ret = -62 fw
status = 80000255 30850000 30800600 00080000 00000000 00000000
[  366.696358] rtw_8821ce 0000:01:00.0: failed to poll offset=0x5
mask=0x2 value=0x0
[  366.696418] rtw_8821ce 0000:01:00.0: mac power on failed
[  366.696421] rtw_8821ce 0000:01:00.0: failed to power on mac
[  366.696424] ------------[ cut here ]------------
[  366.696425] Hardware became unavailable upon resume. This could be
a software issue prior to suspend or a hardware issue.
[  366.696486] WARNING: CPU: 1 PID: 2023 at net/mac80211/util.c:1826
ieee80211_reconfig+0x9b/0x1580 [mac80211]
[  366.696638] Modules linked in: ccm snd_seq_dummy snd_hrtimer
snd_seq rfcomm snd_seq_device qrtr cmac algif_hash algif_skcipher
af_alg bnep snd_soc_sof_es8336 binfmt_misc snd_sof_probes
snd_soc_intel_hda_dsp_common x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel nls_ascii snd_soc_dmic snd_hda_codec_hdmi nls_cp437
vfat fat snd_sof_pci_intel_apl kvm snd_sof_intel_hda_generic
soundwire_intel soundwire_generic_allocation soundwire_cadence
crct10dif_pclmul snd_sof_intel_hda_common snd_sof_intel_hda_mlink
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp ghash_clmulni_intel
snd_sof sha512_ssse3 sha256_ssse3 sha1_ssse3 snd_sof_utils
soundwire_bus snd_soc_skl rtw88_8821ce snd_soc_hdac_hda rtw88_8821c
rtw88_pci snd_hda_ext_core rtw88_core aesni_intel snd_soc_sst_ipc
snd_soc_sst_dsp snd_soc_acpi_intel_match intel_rapl_msr mei_hdcp
uvcvideo snd_soc_acpi gf128mul videobuf2_vmalloc btusb crypto_simd
processor_thermal_device_pci_legacy mac80211 cryptd btrtl uvc
videobuf2_memops btintel snd_hda_intel videobuf2_v4l2
[  366.696717]  processor_thermal_device btbcm snd_intel_dspcfg
processor_thermal_wt_hint videodev processor_thermal_rfim wdat_wdt
snd_intel_sdw_acpi btmtk rapl videobuf2_common libarc4
processor_thermal_rapl snd_hda_codec snd_soc_es8316 intel_cstate
bluetooth watchdog pcspkr mc snd_soc_core cfg80211 joydev
intel_rapl_common snd_hda_core processor_thermal_wt_req snd_hwdep
processor_thermal_power_floor snd_compress snd_pcm
processor_thermal_mbox mei_me rfkill mei snd_timer intel_soc_dts_iosf
snd soundcore ac soc_button_array intel_pmc_core int3403_thermal
int3400_thermal intel_hid intel_vsec int340x_thermal_zone
acpi_thermal_rel pmt_telemetry pmt_class sparse_keymap hid_multitouch
evdev serio_raw sg msr fuse loop dm_mod efi_pstore configfs efivarfs
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2
sd_mod i915 cec ahci rc_core libahci drm_buddy i2c_algo_bit libata
drm_display_helper hid_generic spi_pxa2xx_platform dw_dmac
dw_dmac_core xhci_pci spi_pxa2xx_core xhci_hcd ttm i2c_hid_acpi
crc32_pclmul
[  366.696817]  crc32c_intel sdhci_pci i2c_hid i2c_i801 cqhci hid
drm_kms_helper sdhci scsi_mod i2c_smbus usbcore mmc_core
intel_lpss_pci drm usb_common intel_lpss idma64 scsi_common fan button
video battery wmi
[  366.696845] CPU: 1 UID: 0 PID: 2023 Comm: kworker/u16:14 Not
tainted 6.11.0-rc5 #1
[  366.696850] Hardware name: IPASON MaxBook P1X/G142R, BIOS
BIOS-P1XJ407 10/09/2021
[  366.696853] Workqueue: async async_run_entry_fn
[  366.696864] RIP: 0010:ieee80211_reconfig+0x9b/0x1580 [mac80211]
[  366.696987] Code: c6 87 ad 05 00 00 00 4c 89 ff e8 d0 87 fb ff 41
89 c0 85 c0 0f 84 21 03 00 00 48 c7 c7 e0 61 8b c1 44 89 04 24 e8 e5
8e cd c0 <0f> 0b 44 8b 04 24 eb 35 84 c0 0f 85 a9 01 00 00 c6 87 ad 05
00 00
[  366.696991] RSP: 0000:ffffb8b9c28abce0 EFLAGS: 00010286
[  366.696993] RAX: 0000000000000000 RBX: ffff99e449fc0538 RCX: 0000000000000000
[  366.696996] RDX: 0000000000000002 RSI: ffffffff838d410a RDI: 00000000ffffffff
[  366.696998] RBP: ffff99e449fc03c0 R08: 0000000000000000 R09: 0000000000000003
[  366.697000] R10: ffffb8b9c28abaa8 R11: ffffffff840b7e60 R12: 0000000000000001
[  366.697002] R13: 0000000000000000 R14: ffffffff8392cc5f R15: ffff99e449fc0900
[  366.697004] FS:  0000000000000000(0000) GS:ffff99e6b3c80000(0000)
knlGS:0000000000000000
[  366.697007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  366.697009] CR2: 0000000000000000 CR3: 00000001e5822000 CR4: 0000000000350ef0
[  366.697012] Call Trace:
[  366.697017]  <TASK>
[  366.697022]  ? __warn+0x7c/0x120
[  366.697029]  ? ieee80211_reconfig+0x9b/0x1580 [mac80211]
[  366.697147]  ? report_bug+0x18d/0x1c0
[  366.697154]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[  366.697161]  ? console_unlock+0xc7/0x120
[  366.697166]  ? handle_bug+0x41/0x70
[  366.697170]  ? exc_invalid_op+0x13/0x60
[  366.697173]  ? asm_exc_invalid_op+0x16/0x20
[  366.697181]  ? ieee80211_reconfig+0x9b/0x1580 [mac80211]
[  366.697297]  ? select_task_rq_fair+0x1a9/0x1660
[  366.697303]  ? preempt_count_add+0x69/0xa0
[  366.697309]  ? _raw_spin_lock_irq+0x19/0x40
[  366.697313]  ? _raw_spin_unlock_irq+0x1b/0x40
[  366.697317]  ? __wait_for_common+0x194/0x1c0
[  366.697322]  ? __pfx_schedule_timeout+0x10/0x10
[  366.697326]  ? preempt_count_add+0x69/0xa0
[  366.697332]  wiphy_resume+0x7e/0x1a0 [cfg80211]
[  366.697468]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211]
[  366.697577]  dpm_run_callback+0x88/0x1e0
[  366.697586]  device_resume+0xa5/0x220
[  366.697590]  async_resume+0x19/0x30
[  366.697593]  async_run_entry_fn+0x2d/0x130
[  366.697598]  process_one_work+0x179/0x390
[  366.697604]  worker_thread+0x245/0x350
[  366.697608]  ? __pfx_worker_thread+0x10/0x10
[  366.697611]  kthread+0xda/0x110
[  366.697616]  ? __pfx_kthread+0x10/0x10
[  366.697620]  ret_from_fork+0x2d/0x50
[  366.697625]  ? __pfx_kthread+0x10/0x10
[  366.697629]  ret_from_fork_asm+0x1a/0x30
[  366.697637]  </TASK>
[  366.697638] ---[ end trace 0000000000000000 ]---
[  366.697711] mei_me 0000:00:0f.0: unexpected reset: dev_state =
RESETTING fw status = 80000255 30850000 30800600 00080000 00000000
00000000
[  366.697724] mei_me 0000:00:0f.0: H_RST is set = 0x80000031
[  366.698155] ------------[ cut here ]------------
[  366.698158] WARNING: CPU: 3 PID: 2023 at
net/mac80211/driver-ops.c:41 drv_stop+0xf9/0x110 [mac80211]
[  366.698267] Modules linked in: ccm snd_seq_dummy snd_hrtimer
snd_seq rfcomm snd_seq_device qrtr cmac algif_hash algif_skcipher
af_alg bnep snd_soc_sof_es8336 binfmt_misc snd_sof_probes
snd_soc_intel_hda_dsp_common x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel nls_ascii snd_soc_dmic snd_hda_codec_hdmi nls_cp437
vfat fat snd_sof_pci_intel_apl kvm snd_sof_intel_hda_generic
soundwire_intel soundwire_generic_allocation soundwire_cadence
crct10dif_pclmul snd_sof_intel_hda_common snd_sof_intel_hda_mlink
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp ghash_clmulni_intel
snd_sof sha512_ssse3 sha256_ssse3 sha1_ssse3 snd_sof_utils
soundwire_bus snd_soc_skl rtw88_8821ce snd_soc_hdac_hda rtw88_8821c
rtw88_pci snd_hda_ext_core rtw88_core aesni_intel snd_soc_sst_ipc
snd_soc_sst_dsp snd_soc_acpi_intel_match intel_rapl_msr mei_hdcp
uvcvideo snd_soc_acpi gf128mul videobuf2_vmalloc btusb crypto_simd
processor_thermal_device_pci_legacy mac80211 cryptd btrtl uvc
videobuf2_memops btintel snd_hda_intel videobuf2_v4l2
[  366.698323]  processor_thermal_device btbcm snd_intel_dspcfg
processor_thermal_wt_hint videodev processor_thermal_rfim wdat_wdt
snd_intel_sdw_acpi btmtk rapl videobuf2_common libarc4
processor_thermal_rapl snd_hda_codec snd_soc_es8316 intel_cstate
bluetooth watchdog pcspkr mc snd_soc_core cfg80211 joydev
intel_rapl_common snd_hda_core processor_thermal_wt_req snd_hwdep
processor_thermal_power_floor snd_compress snd_pcm
processor_thermal_mbox mei_me rfkill mei snd_timer intel_soc_dts_iosf
snd soundcore ac soc_button_array intel_pmc_core int3403_thermal
int3400_thermal intel_hid intel_vsec int340x_thermal_zone
acpi_thermal_rel pmt_telemetry pmt_class sparse_keymap hid_multitouch
evdev serio_raw sg msr fuse loop dm_mod efi_pstore configfs efivarfs
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2
sd_mod i915 cec ahci rc_core libahci drm_buddy i2c_algo_bit libata
drm_display_helper hid_generic spi_pxa2xx_platform dw_dmac
dw_dmac_core xhci_pci spi_pxa2xx_core xhci_hcd ttm i2c_hid_acpi
crc32_pclmul
[  366.698390]  crc32c_intel sdhci_pci i2c_hid i2c_i801 cqhci hid
drm_kms_helper sdhci scsi_mod i2c_smbus usbcore mmc_core
intel_lpss_pci drm usb_common intel_lpss idma64 scsi_common fan button
video battery wmi
[  366.698408] CPU: 3 UID: 0 PID: 2023 Comm: kworker/u16:14 Tainted: G
       W          6.11.0-rc5 #1
[  366.698413] Tainted: [W]=WARN
[  366.698414] Hardware name: IPASON MaxBook P1X/G142R, BIOS
BIOS-P1XJ407 10/09/2021
[  366.698416] Workqueue: async async_run_entry_fn
[  366.698420] RIP: 0010:drv_stop+0xf9/0x110 [mac80211]
[  366.698525] Code: 48 85 c0 74 0e 48 8b 78 08 89 ea 48 89 de e8 2e
30 05 00 65 ff 0d 4f 40 89 3e 0f 85 38 ff ff ff 0f 1f 44 00 00 e9 2e
ff ff ff <0f> 0b 5b 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f
[  366.698527] RSP: 0000:ffffb8b9c28abc28 EFLAGS: 00010246
[  366.698530] RAX: 0000000000000000 RBX: ffff99e449fc0900 RCX: 0000000000000000
[  366.698532] RDX: 0000000080000000 RSI: 0000000000000000 RDI: ffff99e449fc0900
[  366.698534] RBP: 0000000000000000 R08: ffffffff840ce688 R09: 0000000000000000
[  366.698536] R10: ffff99e4440821b0 R11: 0000000000000000 R12: ffff99e449fc11f8
[  366.698538] R13: ffff99e449fc0e10 R14: 0000000000000000 R15: ffff99e444081d20
[  366.698540] FS:  0000000000000000(0000) GS:ffff99e6b3d80000(0000)
knlGS:0000000000000000
[  366.698542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  366.698544] CR2: 0000000000000000 CR3: 00000001e5822000 CR4: 0000000000350ef0
[  366.698547] Call Trace:
[  366.698549]  <TASK>
[  366.698551]  ? __warn+0x7c/0x120
[  366.698556]  ? drv_stop+0xf9/0x110 [mac80211]
[  366.698660]  ? report_bug+0x18d/0x1c0
[  366.698665]  ? handle_bug+0x41/0x70
[  366.698668]  ? exc_invalid_op+0x13/0x60
[  366.698671]  ? asm_exc_invalid_op+0x16/0x20
[  366.698676]  ? drv_stop+0xf9/0x110 [mac80211]
[  366.698780]  ? drv_stop+0x11/0x110 [mac80211]
[  366.698884]  ieee80211_do_stop+0x647/0x850 [mac80211]
[  366.699000]  ieee80211_stop+0x54/0x190 [mac80211]
[  366.699112]  __dev_close_many+0xa7/0x120
[  366.699119]  dev_close_many+0xa5/0x180
[  366.699123]  ? kick_pool+0x6c/0x160
[  366.699128]  dev_close+0x88/0xb0
[  366.699133]  cfg80211_shutdown_all_interfaces+0x49/0xf0 [cfg80211]
[  366.699245]  wiphy_resume+0xba/0x1a0 [cfg80211]
[  366.699357]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211]
[  366.699466]  dpm_run_callback+0x88/0x1e0
[  366.699470]  device_resume+0xa5/0x220
[  366.699474]  async_resume+0x19/0x30
[  366.699477]  async_run_entry_fn+0x2d/0x130
[  366.699481]  process_one_work+0x179/0x390
[  366.699485]  worker_thread+0x245/0x350
[  366.699488]  ? __pfx_worker_thread+0x10/0x10
[  366.699491]  kthread+0xda/0x110
[  366.699495]  ? __pfx_kthread+0x10/0x10
[  366.699499]  ret_from_fork+0x2d/0x50
[  366.699502]  ? __pfx_kthread+0x10/0x10
[  366.699506]  ret_from_fork_asm+0x1a/0x30
[  366.699511]  </TASK>
[  366.699512] ---[ end trace 0000000000000000 ]---
[  366.699584] ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume
[cfg80211] returns -114
[  366.699701] ieee80211 phy0: PM: failed to resume async: error -114
[  366.702350] OOM killer enabled.
[  366.702352] Restarting tasks ...
[  366.704491] mei_hdcp
0000:00:0f.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
(ops i915_hdcp_ops [i915])
[  366.756869] PM: suspend exit


-- Linas
-- 
Patrick: Are they laughing at us?
Sponge Bob: No, Patrick, they are laughing next to us.

