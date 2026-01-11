Return-Path: <linux-wireless+bounces-30635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7315D0E0CF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 04:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E77A30069A0
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 03:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A571DF755;
	Sun, 11 Jan 2026 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeDk6tgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FB194098
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768101236; cv=none; b=lv/Y7srUxL6la9RBGwsKcaHJ14QtXhqdGeY8uCAp81w4XCE90VKKzuKeq/09i8Bixc2hpkgUjJOKYrDAidzboLYVTHQixYdeU2/qW7K7WKp/ldoFGbL/03jcp3hQhYyGYDiRl28BJDODazlzp1Xb+rRVevcLv5xAPqwq2w7Wk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768101236; c=relaxed/simple;
	bh=9yun2Jzq5S7EQ2e92BBOg7OeQu/iKrB4hWBei4RNsEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Srf8+BLmkYIluVTurFpOUGK/mHunDB9nuEMK8SdNgFbTkFKV+A5KP0nhWeDLZf5IYMaXJQFf+dbu25kg2aRK2KcLKho1RFEeqS1IwiGde4YwuUjEOeYrn5KR8H66/+3yEjP/i8kAYW8zM12aIdSR5EHGGq5qFxuUW9PKp+FLXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeDk6tgn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1010212966b.3
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 19:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768101233; x=1768706033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URTqGBs2J/bsEyV8Z9V9m0gmilOIfXua7VFji2to30k=;
        b=TeDk6tgn13V0CuylDi2NhUfRu0tCUH+PwUWB1SWeEyzfO25vPeKKQ92v0kZnlVPEvz
         OdJ4fevm7fc4PRh6lBQFg2UEBCI+tVVyu5LR8E1OKmTub6yIdP8lOoHIxNsz4dOHKMc0
         p6qmIui1q7GJ78ICg0bjc8URPC2i1AmsLsqWesKNcpUacBVR152TQlcml7s+J2MT4SJf
         aMZNndzNmQDVIggJ03qgGVefO8gZLGSFFG77c3+ogbFRyMx3aqCqRjPvXkRCGHzIlU6O
         Dr8YwQTVNSocQ/3CcxjlYAAfIEjfPWveyvUAEJGMNq71Qhngaifd1Fc1RXN3FYMITtp6
         FCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768101233; x=1768706033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URTqGBs2J/bsEyV8Z9V9m0gmilOIfXua7VFji2to30k=;
        b=Wpaz1hL29SO3Iwh1AXw/bwfYyDad2SoMJ3jdl6ScFDKApVKiIlnny+CPifPdA5BHco
         2jPf171o9qJLnLtJIpDaxmh3PXWlAqisxMFEzBqiU3O81fugZzbfJ6zJSYnUeCzLV72L
         O0jxdEB3/Lb470dyyL3mLaIPoKPWMNiojd/FK9ljywni7cWSpwycsPC+qr9RbzX1ENWR
         c+vPoZFc3jY0ZYD+IzdctrpJNPNn5nJboOQyszZqw3+FpStBIhpkYO/tztmbpR646bvU
         bNNDy2etaM2TeKH934ofY4HE8NJNjx0UG83sFqGMt2WjKN8EiGi9690Llhxhtjj+qYRe
         VGeA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGJl+29ftnjIo0wCwS86QTw+ztLfRP6hElOR8s2RNq4dJikxY4Lc0kRZwQQ0RLn1pQchskUldHDNmSwykPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHNYyglf39mY/+JXLDbnxN+OkpnRnn+jHnLzrIlexYbB7QBXM
	NMq7wcrWaUr+zrPOWcO1TOtox5AegCDi+JoL/gJpeIRIIZ+QqNf7p4y3BjovDdChAK+w5UaIA/t
	yNbriEw7NjbvCzH6lfNPC0O1JncKRh+g=
X-Gm-Gg: AY/fxX7vJf9ScnsXjBA6h4nhh0vHzsEFtllO2OCJ+9qXSLJlASFOIvgSrvaagY9+/aI
	klm+q4TRNOjzIOzIoM0gD3V48QFJLN0QnXdKEc0xJ5IeSVfIhqPBVR64bq931hnFwCVOhvonxEr
	VZORmd3OVH4cQIvSeHdp014D3+xAdNCNUoPGvgrhjWoY1cBlMdkBROuRLPh1XUd99XCSNzqSXp5
	UavI2BuXd58gkv7HuG04mSqsqq9ZVe0P917BnMX2RLp0tXMr+3WQhyTAQyuEi0bmxGH/sQCMCCm
	lc0PRoQMQ5sSdJtkSxMWf7H0rhmZ11A2Dp09BaEhQQl09Or1SkBZaFhUFQ==
X-Google-Smtp-Source: AGHT+IFboOgVfYKZx/tIQGrm7mDZxFPhl6MsN9SdKhDjzy0fNaRKv3TIFm9Y7NKeJLf85+6B8DUzS3tqdAT0hlUfyow=
X-Received: by 2002:a17:907:948e:b0:b73:8f33:eed3 with SMTP id
 a640c23a62f3a-b844521983fmr1380024766b.26.1768101232665; Sat, 10 Jan 2026
 19:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102200524.290779-1-zbowling@gmail.com> <20260105002638.668723-1-zbowling@gmail.com>
 <20260105002638.668723-18-zbowling@gmail.com>
In-Reply-To: <20260105002638.668723-18-zbowling@gmail.com>
From: Zac Bowling <zbowling@gmail.com>
Date: Sat, 10 Jan 2026 19:13:41 -0800
X-Gm-Features: AZwV_QgDUbR5M3y2clEVnmxycnbvXlL7ZtwRrL1D2-5NQcqQ6YDCrwGWMqHd5Gg
Message-ID: <CAOFcj8Tf5FhnQVPZg=v5bB3AWR67R+OafYD7b8s1S2e9JfhHrg@mail.gmail.com>
Subject: Re: [PATCH 17/17] wifi: mt76: mt7925: add NULL checks in link station
 and TX queue setup
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

Any chance you had time to review? I got a new laptop courtesy the folks at
Framework to keep debugging this that also has this same wifi chip, and it
didn't take long to reproduce this issue on an unpatched kernel that these
patches would fix.

Not even 5 minutes after boot this new laptop with a fresh arch install, an=
d it
crashed.

Patch 1 is the direct fix. Patch 2 prevents the underlying race
condition in this
specific crash.

Dump from this machine. My second patch in this series would stop this
particular race and null deref during MLO roaming.

Jan 10 18:38:57 zcache kernel: wlan0: RX ReassocResp from
d8:b3:70:f8:9e:7b (capab=3D0x1111 status=3D30 aid=3D0)
Jan 10 18:38:57 zcache kernel: wlan0: d8:b3:70:f8:9e:7b rejected
association temporarily; comeback duration 895 TU (916 ms)
Jan 10 18:38:57 zcache kernel: wlan0: RX ReassocResp from
d8:b3:70:f8:9e:7b (capab=3D0x1111 status=3D30 aid=3D0)
Jan 10 18:38:57 zcache kernel: wlan0: d8:b3:70:f8:9e:7b rejected
association temporarily; comeback duration 794 TU (813 ms)
Jan 10 18:38:57 zcache kernel: wlan0: association with
d8:b3:70:f8:9e:7b timed out
Jan 10 18:39:01 zcache kernel: mt7925e 0000:bf:00.0: Message 00020002
(seq 11) timeout
Jan 10 18:39:07 zcache kernel: mt7925e 0000:bf:00.0: Message 00020003
(seq 12) timeout
Jan 10 18:39:10 zcache kernel: mt7925e 0000:bf:00.0: Message 00020002
(seq 13) timeout
Jan 10 18:39:13 zcache kernel: mt7925e 0000:bf:00.0: Message 00020002
(seq 14) timeout
Jan 10 18:39:16 zcache kernel: mt7925e 0000:bf:00.0: Message 00020001
(seq 15) timeout
Jan 10 18:39:16 zcache kernel: mt7925e 0000:bf:00.0: HW/SW Version:
0x8a108a10, Build Time: 20251015212927a
Jan 10 18:39:16 zcache kernel: mt7925e 0000:bf:00.0: WM Firmware
Version: ____000000, Build Time: 20251015213023
Jan 10 18:39:17 zcache kernel: BUG: kernel NULL pointer dereference,
address: 0000000000000000
Jan 10 18:39:17 zcache kernel: #PF: supervisor read access in kernel mode
Jan 10 18:39:17 zcache kernel: #PF: error_code(0x0000) - not-present page
Jan 10 18:39:17 zcache kernel: PGD 0 P4D 0
Jan 10 18:39:17 zcache kernel: Oops: Oops: 0000 [#1] SMP NOPTI
Jan 10 18:39:17 zcache kernel: CPU: 0 UID: 0 PID: 42446 Comm:
kworker/u96:0 Tainted: G           O        6.18.4-2-cachyos #1
PREEMPT(full)  b0274bd1b2c7bedbf3a9a6159178cc392f0fdb5c
Jan 10 18:39:17 zcache kernel: Tainted: [O]=3DOOT_MODULE
Jan 10 18:39:17 zcache kernel: Hardware name: Framework Laptop 16 (AMD
Ryzen AI 300 Series)/FRANMHCP09, BIOS 03.04 11/06/2025
Jan 10 18:39:17 zcache kernel: Workqueue: mt76 mt7925_mac_reset_work
[mt7925_common]
Jan 10 18:39:17 zcache kernel: RIP:
0010:mt76_connac_mcu_uni_add_dev+0xf1/0x210 [mt76_connac_lib]
Jan 10 18:39:17 zcache kernel: Code: 0f b7 89 b8 00 00 00 66 89 4c 24
1c c7 44 24 1e 00 00 00 00 66 89 4c 24 22 66 c7 44 24 24 00 00 c6 44
24 26 00 44 88 4c 24 27 <48> 8b 0e 8b 09 83 f9 05 7f 11 83 f9 01 74 2f
83 f9 02 74 3c 83 f9
Jan 10 18:39:17 zcache kernel: RSP: 0018:ffffccb5e1d17cb0 EFLAGS: 00010282
Jan 10 18:39:17 zcache kernel: RAX: ffffccb5e1d17ce2 RBX:
ffff8a0f37682060 RCX: 0000000000000013
Jan 10 18:39:17 zcache kernel: RDX: ffff8a0f0cd12588 RSI:
0000000000000000 RDI: 0000000000000000
Jan 10 18:39:17 zcache kernel: RBP: 0000000000000001 R08:
0000000000000000 R09: 0000000000000000
Jan 10 18:39:17 zcache kernel: R10: 0000000000000000 R11:
ffffffff999362b0 R12: 0000000000000001
Jan 10 18:39:17 zcache kernel: R13: 0000000000000000 R14:
ffff8a0f37682060 R15: ffff8a0f0cd12588
Jan 10 18:39:17 zcache kernel: FS:  0000000000000000(0000)
GS:ffff8a12b18fe000(0000) knlGS:0000000000000000
Jan 10 18:39:17 zcache kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Jan 10 18:39:17 zcache kernel: CR2: 0000000000000000 CR3:
00000003f0a12000 CR4: 0000000000f50ef0
Jan 10 18:39:17 zcache kernel: PKRU: 55555554
Jan 10 18:39:17 zcache kernel: Call Trace:
Jan 10 18:39:17 zcache kernel:  <TASK>
Jan 10 18:39:17 zcache kernel:  mt7925_vif_connect_iter+0x95/0x190
[mt7925_common dc0066c6b1da3a3d20cb990f664250b31cf0a3c5]
Jan 10 18:39:17 zcache kernel:  __iterate_interfaces+0x55/0x130
[mac80211 9bef1c01c9f6e23856cab5358ede5658fefb3669]
Jan 10 18:39:17 zcache kernel:  ?
__pfx_mt7925_vif_connect_iter+0x10/0x10 [mt7925_common
dc0066c6b1da3a3d20cb990f664250b31cf0a3c5]
Jan 10 18:39:17 zcache kernel:  ?
__pfx_mt7925_vif_connect_iter+0x10/0x10 [mt7925_common
dc0066c6b1da3a3d20cb990f664250b31cf0a3c5]
Jan 10 18:39:17 zcache kernel:  ieee80211_iterate_interfaces+0x3b/0x50
[mac80211 9bef1c01c9f6e23856cab5358ede5658fefb3669]
Jan 10 18:39:17 zcache kernel:  mt7925_mac_reset_work+0x2a3/0x360
[mt7925_common dc0066c6b1da3a3d20cb990f664250b31cf0a3c5]
Jan 10 18:39:17 zcache kernel:  ? enable_work+0x2b/0xd0
Jan 10 18:39:17 zcache kernel:  process_scheduled_works+0x24b/0x5a0
Jan 10 18:39:17 zcache kernel:  worker_thread+0x188/0x360
Jan 10 18:39:17 zcache kernel:  ? __pfx_worker_thread+0x10/0x10
Jan 10 18:39:17 zcache kernel:  kthread+0x217/0x250
Jan 10 18:39:17 zcache kernel:  ? __pfx_kthread+0x10/0x10
Jan 10 18:39:17 zcache kernel:  ret_from_fork+0xf1/0x1f0
Jan 10 18:39:17 zcache kernel:  ? __pfx_kthread+0x10/0x10
Jan 10 18:39:17 zcache kernel:  ret_from_fork_asm+0x1a/0x30
Jan 10 18:39:17 zcache kernel:  </TASK>
Jan 10 18:39:17 zcache kernel: Modules linked in: overlay tcp_diag
inet_diag ccm snd_seq_dummy snd_hrtimer rfcomm snd_seq snd_seq_device
tun cmac algif_hash algif_skcipher af_alg bnep snd_ctl_led vfat fat
snd_acp_legacy_mach snd_acp_mach snd_soc_nau8821 snd_acp3x_rn
snd_acp70 snd_acp_pdm snd_acp_i2s snd_soc_dmic snd_acp_pcm
snd_sof_amd_acp70 snd_sof_amd_acp63 snd_sof_amd_vangogh
snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_pci_ps
snd_soc_acpi_amd_match soundwire_amd soundwire_generic_allocation
snd_amd_sdw_acpi snd_hda_codec_alc269 soundwire_bus intel_rapl_msr
amd_atl snd_hda_scodec_component snd_soc_sdca intel_rapl_common
snd_hda_codec_realtek_lib mt7925e snd_soc_core snd_hda_codec_generic
mt7925_common snd_hda_codec_atihdmi ac97_bus snd_hda_codec_nvhdmi
mt792x_lib snd_pcm_dmaengine snd_hda_codec_hdmi snd_compress
mt76_connac_lib snd_rpl_pci_acp6x mt76 hid_sensor_als snd_acp_pci
hid_sensor_trigger snd_hda_intel snd_amd_acpi_mach
industrialio_triggered_buffer uvcvideo
Jan 10 18:39:17 zcache kernel:  uvc mac80211 snd_acp_legacy_common
kfifo_buf videobuf2_vmalloc mousedev snd_hda_codec kvm_amd
hid_sensor_iio_common snd_pci_acp6x leds_cros_ec videobuf2_memops
btusb btmtk ucsi_acpi snd_pci_acp5x snd_hda_core videobuf2_v4l2
industrialio cros_ec_sysfs cros_charge_control cros_ec_debugfs
gpio_cros_ec led_class_multicolor videobuf2_common cros_ec_chardev
cros_ec_hwmon typec_ucsi snd_rn_pci_acp3x amd_pmf btbcm
snd_intel_dspcfg kvm cfg80211 snd_intel_sdw_acpi ip6t_REJECT typec
amdtee snd_acp_config btintel snd_hwdep spd5118 videodev
nf_reject_ipv6 hid_sensor_hub amd_sfh cros_ec_dev hid_multitouch
irqbypass btrtl snd_soc_acpi roles snd_pcm polyval_clmulni
platform_profile cros_ec_lpcs mc ccp snd_pci_acp3x snd_timer bluetooth
ghash_clmulni_intel joydev xt_hl aesni_intel snd cros_ec i2c_piix4
thunderbolt rfkill i2c_hid_acpi ip6t_rt tee 8250_dw amd_pmc soundcore
cros_ec_proto amdxdna wmi_bmof pcspkr k10temp nvidia_wmi_ec_backlight
rapl i2c_smbus libarc4 i2c_hid mac_hid ipt_REJECT nf_reject_ipv4
xt_LOG
Jan 10 18:39:17 zcache kernel:  nf_log_syslog nft_limit xt_limit
xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nft_compat x_tables nf_tables dm_mod pkcs8_key_parser
crypto_user ntsync i2c_dev nfnetlink zram 842_compress 842_decompress
lz4hc_compress lz4_compress nvidia_uvm(O) amdgpu nvidia_drm(O)
nvidia_modeset(O) drm_panel_backlight_quirks drm_buddy
drm_suballoc_helper drm_exec nvme i2c_algo_bit gpu_sched nvme_core
amdxcp nvme_keyring drm_display_helper nvme_auth cec hkdf nvidia(O)
drm_ttm_helper video ttm wmi
Jan 10 18:39:17 zcache kernel: CR2: 0000000000000000
Jan 10 18:39:17 zcache kernel: ---[ end trace 0000000000000000 ]---
Jan 10 18:39:17 zcache kernel: RIP:
0010:mt76_connac_mcu_uni_add_dev+0xf1/0x210 [mt76_connac_lib]
Jan 10 18:39:17 zcache kernel: Code: 0f b7 89 b8 00 00 00 66 89 4c 24
1c c7 44 24 1e 00 00 00 00 66 89 4c 24 22 66 c7 44 24 24 00 00 c6 44
24 26 00 44 88 4c 24 27 <48> 8b 0e 8b 09 83 f9 05 7f 11 83 f9 01 74 2f
83 f9 02 74 3c 83 f9
Jan 10 18:39:17 zcache kernel: RSP: 0018:ffffccb5e1d17cb0 EFLAGS: 00010282
Jan 10 18:39:17 zcache kernel: RAX: ffffccb5e1d17ce2 RBX:
ffff8a0f37682060 RCX: 0000000000000013
Jan 10 18:39:17 zcache kernel: RDX: ffff8a0f0cd12588 RSI:
0000000000000000 RDI: 0000000000000000
Jan 10 18:39:17 zcache kernel: RBP: 0000000000000001 R08:
0000000000000000 R09: 0000000000000000
Jan 10 18:39:17 zcache kernel: R10: 0000000000000000 R11:
ffffffff999362b0 R12: 0000000000000001
Jan 10 18:39:17 zcache kernel: R13: 0000000000000000 R14:
ffff8a0f37682060 R15: ffff8a0f0cd12588
Jan 10 18:39:17 zcache kernel: FS:  0000000000000000(0000)
GS:ffff8a12b18fe000(0000) knlGS:0000000000000000
Jan 10 18:39:17 zcache kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033

Zac Bowling

On Sun, Jan 4, 2026 at 4:27=E2=80=AFPM Zac Bowling <zbowling@gmail.com> wro=
te:
>
> Add NULL pointer checks for mt792x_sta_to_link() and mt792x_vif_to_link()
> results in critical paths to prevent kernel crashes during MLO operations=
.
>
> Functions fixed:
> - mt7925_mac_link_sta_add(): Check mlink and mconf before dereferencing
> - mt7925_conf_tx(): Check mconf before accessing queue_params
>
> These can be NULL during MLO link setup/teardown when mac80211 state
> may not be fully synchronized with driver state.
>
> Found through static analysis and pattern matching.
>
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for =
mt7925 chips")
> Signed-off-by: Zac Bowling <zac@zacbowling.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index 7cf6faa1f6f4..81373e479abd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -871,12 +871,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev =
*mdev,
>
>         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
>         mlink =3D mt792x_sta_to_link(msta, link_id);
> +       if (!mlink)
> +               return -EINVAL;
>
>         idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1)=
;
>         if (idx < 0)
>                 return -ENOSPC;
>
>         mconf =3D mt792x_vif_to_link(mvif, link_id);
> +       if (!mconf)
> +               return -EINVAL;
> +
>         mt76_wcid_init(&mlink->wcid, 0);
>         mlink->wcid.sta =3D 1;
>         mlink->wcid.idx =3D idx;
> @@ -1735,6 +1740,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
>                     [IEEE80211_AC_BK] =3D 1,
>         };
>
> +       if (!mconf)
> +               return -EINVAL;
> +
>         /* firmware uses access class index */
>         mconf->queue_params[mq_to_aci[queue]] =3D *params;
>
> --
> 2.51.0
>

