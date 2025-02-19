Return-Path: <linux-wireless+bounces-19152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159BA3CDBB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 00:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1275818885D7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA63214805;
	Wed, 19 Feb 2025 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziglang.org header.i=@ziglang.org header.b="DWWLbQtP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ziglang.org (mail.ziglang.org [108.61.23.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBD13DBB1;
	Wed, 19 Feb 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.23.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008612; cv=none; b=BkdJVaxGfqfxfj0xqcdjJZDLqlJ50iWgIZ4cAaxs2/hEu1Du6zjeEIJj7vjOg8t8FDTQvw6q1FbpbM5K/CaOa6a4QsZUfcjCHVm/GXUliFx2fCmZUMqHS2e9i1DG1Sx9x63UQGI4rS0HHkEgZHZPP2vVYO0/sqEB8f94bCWgF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008612; c=relaxed/simple;
	bh=d1tbpeoy8+Gm6Hz6x4yI39deQEWqQLj4fDXrtRO6fn4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CfmJl3zAKgulxv/Hi9z5Ug6U6K7jP5avWap8Kc8JtI79FpcavUshe/Gi9QODSOYUPFzOUrQUcBZvobnyF3XjYfvRG2BpHMVKTx6u0vnOLGUL8nTHt8zM/BHqJnjKMtQDMBmGv+XQapwYzXIyrjS65DYh7w/uVLQhkki7a1PAxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ziglang.org; spf=pass smtp.mailfrom=ziglang.org; dkim=pass (1024-bit key) header.d=ziglang.org header.i=@ziglang.org header.b=DWWLbQtP; arc=none smtp.client-ip=108.61.23.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ziglang.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziglang.org
Message-ID: <7ee53910-0be5-4e8f-9816-de92973eb35d@ziglang.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziglang.org; s=mail;
	t=1740008287; bh=d1tbpeoy8+Gm6Hz6x4yI39deQEWqQLj4fDXrtRO6fn4=;
	h=Date:To:From:Subject;
	b=DWWLbQtPFB4R8Q43zOJnIGdosIw0wyJkBUfu26UrU+V8/2kysAGj36J3LOIJmw/7c
	 bYpl8Iksx6jDbR4BVUeCTGaeaUU0yGFT1lqKaj+k4fz0UPCqv0lo+2GO7N2PYAtQ1m
	 PuAl2wps9X1Ko2yDvzcjFDcyCT12q2quJghz8SBQ=
Date: Wed, 19 Feb 2025 15:37:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Kees Cook <kees@kernel.org>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Breno Leitao <leitao@debian.org>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrew Kelley <andrew@ziglang.org>
Subject: bug report: iwlwifi crash on ROG STRIX X670E-E GAMING WIFI
Autocrypt: addr=andrew@ziglang.org; keydata=
 xsFNBFv8SrUBEADCku6WktTc1g+iyE9ZCtMv4kWqSHyQxFaEV8V5J2EAkjAzgr6wNLmHGmNm
 Xm8EzCWnwn/KfHJCeXTcgma/FtIF7hJfWB0xktA7WENUVc3qtT0cY9z39jh6J3TW3m9hcN7s
 zSyEqGvPMVCvd5pERZXfof9OaRqtNak3GBOcklHYrVJ0KCtAquR0t9NYrdOQikmBy4c9GaDs
 q/6H39LPuuj/vm7M+MHrw5dlKh+HPeUP9jMbFoXUohz97RSy8T2lUQDQx1EisAJNvdpU3mzA
 lWy2pEH+pKCBs5L0vPV/tvH1J5Pd489s7VcdM9AolIuHvV0qCDAG7fcWujV5R5w48vznvfi6
 R3DN8O2iVrYdOWn2Bm60HdGmXxGQswb6/MfThpFzQUNQpvnXxdbt2vefUTmM4suid6ki/jLf
 siY1rqcNdEcriYFxJ6ma4SvZOB7OB2DG9bjWSItDIa2HqW37o//FYoFHJO0L+v5qjemYx5Qr
 pL2wCpnYUgJEII5UoagGwr0igtnjyT4fw5Xt7en3ukMoBRxrn8HoMXE4oh28tYfJfOABVrOt
 wpD7UpsWK0rmSFZDPa8yLRgqfS6ac2AmR0LcbK+3EYmFcCErh4IdY6Q5T0EYBnijwFqoFuRv
 cnQFJ6Q3oUTKOqB8OGg0v2E26qQZtkRHjmccPwNg9wftvrgjwQARAQABzSJBbmRyZXcgS2Vs
 bGV5IDxhbmRyZXdAemlnbGFuZy5vcmc+wsGOBBMBCAA4FiEEl8v20Nl/A6duouJgfF9Uj3KF
 AakFAlv8SrUCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQfF9Uj3KFAanVlg//VWPd
 qLcWx6mVWnSlpkXpGxp/V+zZaZlOuvDRMMk53V6zUpXrBDXDRiihx5Gwn3n0Ma9KBP7mcr35
 2iNdurbFqtU494NG17lPCSyHf4ot/ohkvqYedoC3u+mRm0FRL4rjXkS7OH8U9UuolyIbYNPr
 3B9X+F74uV1C+NH+AaHydhVwlEKeY82k1ingK8dojiCTyueErdp3/0pM5B4S86uSDZmXVqdp
 mCMXhicp0ZxaPWyDQYy1Ds+34GB5Nzq2cT/J6+aNpQ2IBDMSRKSWh/nymiwBcQcWNzg28LFi
 34T9bf33lvVFordLEk45ygNDBNFa3/VH6ascKqtZ1LaS6JaCPWR/sYr+8l3JV7qvkINLDdA+
 sUEtMpT97uPBcUjpHRqWlMc4esBSqN23sl9uguip6dmEiLiUdPtDisjiNb0M4fZTCWOF99ns
 NY0J7Cr/88iggtPaxyoEknTJMAdNnuz/QheIHSibvTT36r/+KIObzsCroxCqXCfKDoNhPBSg
 Qyrf7fYFVeGKr4/HJiONejRjAFw1/WqBzShOALiXhiZHJVeWk6PCk9ow2wGmlpji+U2MCaJb
 /bvrIJbFjuOK/N1U/zLDLQ5fsfCWcuf0QtPD/qBSlWMBDSPAjvo/Oq5lhXgvbiN3Q5PGt6RE
 Dw0C2BgF1MedBr484N12A+LQavdA9STOwU0EW/xKtQEQAN+OKUfbpeU82h38RYkdkUzL/Ppt
 wjEmZ5Gubfho0CyydrMNyY92LbRFwPSGB8sVwFhpNQprHoipdqqBDaUB/+yiztKr6W+HSoDj
 RyTFBfiTZhpKgqPzTh8ZE2tDsmaT00Fp/zIHVyuCxupPvDqytMzA+Gw+si9hTDDLIl3WYFhJ
 i9QN6hXLstDArExIkOzWF8H9CzP+gTizhZDDchrdTakKZHR0n52/FxAsVLfYC0gEt6h5dL+7
 pZZaR3g+Wv9mQEm97z9stPiI/KfKX9SkRMgZ5KtoT+RO53ujpuzNGejYP5Vb2gw9wRa6oLIQ
 f0Lqqem7acaHwoBITMihn/2H9MaLl77iGTZVYNUTRF89/X5cP5Zy76gnV+m/oNHyXSaSMZV+
 fQa8wTTAKhJAdy6FrhbpzfwDEZXyfpQidk5OgnQjGtXmN2fO5CXdFdmbXV9BXdtQcblC1DpJ
 ihBqv868+ffDPuAdZ+TWnsMwLLbcAMtSnTwR1LO8UnnRCBGmuffhSiKB4ZHQvX1jg5pO+AZu
 Flr+/sb3AKnXUaiBi6m4Cr9B+NfS+Tm3vPsjUvCctOD8DVucpkNOqSXBP9KWWcJ26yCIxeQN
 9Fn6R0ryTYPVvshg7aHKbh8lZyTES1VQknWPCoL0Kfy9UH6Mp+GOVhQNbl/0/cXC/4ZasRep
 ArGUx/3BABEBAAHCwXYEGAEIACAWIQSXy/bQ2X8Dp26i4mB8X1SPcoUBqQUCW/xKtQIbDAAK
 CRB8X1SPcoUBqamXD/0auson+G862fAAqd0I2+cXis2AKpTqUTiNYiExsR6Zfh3UpCaJrElf
 lWU7xmjIoZKlZ3m4amAvSfdJ1i3qn1TkKn1uZ7K8GSQKjMebv/OkMUdOxAwvqmxvYE/buQr5
 R5Y+jdOhGSih3DJh1toR5rlWbkagPzIFlEHCJzpG2SagZ+I39DQwxsme5pdz1zxFsODs0z/a
 rFdh8yRTtJXRzDGbS5kAh5/9ApUGpSbPZ5chBKmxmVVCmThlkNuwAzeiiM9Qum6Kzx54ZyXg
 KWw2GMZjTDjL0jQWZuGz4hySqDRO29nWo8D3t+DK82NNPjzBYMve7qeLn/4+WaBfRobSUplh
 4vyVJdzEf1wK0pE8HR4Dfild1cmYDSklsAa6lFYelKnonQFucIZBVSdhyEWKwqYcDMOBdlL3
 yf1P0AEq/XzxnqEUDx7kmc+JYpsEeFdcrAvcW/rtDLF+peugFPnehS14Ji+K4m3WWIM1OsdF
 R1y/UTNaYvfPiBs9hIVNWx9jX4GiPFYrYXRhIuKkvD9lSzp2GzaUriCZ2sgT42OuCE3crCRV
 LeDLemTLHmFjZqIZ0c1rG1HAbFw3pi1OdpPOOvDdrjCJszub9gQJdq4jG73LsHj3N3cx86m3
 7A2Lmr7CVXzwFaNDB4z6Qvz6vD6Rc0BpuVCC+vCFipdCD3PPBOwHbQ==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've observed this bug on the following Linux versions:

linux-6.10.7
linux-6.11.2
linux-6.12.3
linux-6.13
linux-6.13.2

I don't have reliable steps to reproduce unfortunately, but I can tell 
you that it happens about every 1-2 days.

When it happens the system becomes unusable, some CPUs seem locked in a 
busywait in the kernel, and depending on CPU roulette, I have to hold 
the power button down for 10 seconds in order to reboot.

dmesg output follows:

[454898.246627] iwlwifi 0000:0b:00.0: Error sending 
SYSTEM_STATISTICS_CMD: time out after 2000ms.
[454898.246634] iwlwifi 0000:0b:00.0: Current CMD queue read_ptr 40081 
write_ptr 40082
[454902.599603] iwlwifi 0000:0b:00.0: Queue 3 is stuck 22051 22277
[454919.254583] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[454919.254589] rcu:    18-....: (97 ticks this GP) 
idle=a71c/1/0x4000000000000000 softirq=3597262/3597262 fqs=4759
[454919.254593] rcu:    (detected by 14, t=21002 jiffies, g=44790117, 
q=28374 ncpus=32)
[454919.254596] Sending NMI from CPU 14 to CPUs 18:
[454919.427060] NMI backtrace for cpu 18
[454919.427063] CPU: 18 UID: 0 PID: 1487 Comm: NetworkManager Not 
tainted 6.13.2 #1-NixOS
[454919.427066] Hardware name: ASUS System Product Name/ROG STRIX 
X670E-E GAMING WIFI, BIOS 1905 02/05/2024
[454919.427067] RIP: 0010:iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454919.427082] Code: e9 5c 6f a9 c8 90 90 90 90 90 90 90 90 90 90 90 90 
90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 89 f6 48 03 b7 f8 1b 00 00 8b 
06 <31> f6 31 ff e9 2e 6f a9 c8 0f 1f 00 90 90 90 90 90 90 90 90 90 90
[454919.427083] RSP: 0018:ffffa941c2f9b410 EFLAGS: 00000286
[454919.427085] RAX: 00000000ffffffff RBX: ffff894e1f604028 RCX: 
0000000000000000
[454919.427086] RDX: 0000000000000000 RSI: ffffa941c1f5c024 RDI: 
ffff894e1f604028
[454919.427087] RBP: 0000000000000011 R08: 0000000000003a98 R09: 
0000000000000000
[454919.427087] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000024
[454919.427088] R13: 0000000000000024 R14: ffff894e1f604028 R15: 
0000000000003a98
[454919.427089] FS:  00007f1fc24a8500(0000) GS:ffff895d1e100000(0000) 
knlGS:0000000000000000
[454919.427090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[454919.427090] CR2: 00001c2c021f2000 CR3: 000000010ca94000 CR4: 
0000000000f50ef0
[454919.427091] PKRU: 55555554
[454919.427092] Call Trace:
[454919.427094]  <NMI>
[454919.427097]  ? nmi_cpu_backtrace+0x9f/0x120
[454919.427101]  ? nmi_cpu_backtrace_handler+0x11/0x20
[454919.427103]  ? nmi_handle+0x5e/0x160
[454919.427106]  ? default_do_nmi+0x43/0x100
[454919.427109]  ? exc_nmi+0x138/0x1d0
[454919.427110]  ? end_repeat_nmi+0xf/0x53
[454919.427115]  ? iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454919.427122]  ? iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454919.427129]  ? iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454919.427135]  </NMI>
[454919.427136]  <TASK>
[454919.427136]  iwl_read32+0x18/0x80 [iwlwifi]
[454919.427143]  iwl_poll_bit+0x42/0x90 [iwlwifi]
[454919.427150]  __iwl_trans_pcie_grab_nic_access+0xcb/0x170 [iwlwifi]
[454919.427158]  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
[454919.427165]  iwl_force_nmi+0xa3/0xc0 [iwlwifi]
[454919.427172]  iwl_trans_sync_nmi_with_addr+0xf9/0x130 [iwlwifi]
[454919.427178]  ? srso_alias_return_thunk+0x5/0xfbef5
[454919.427181]  iwl_trans_pcie_send_hcmd+0x429/0x470 [iwlwifi]
[454919.427188]  ? __pfx_autoremove_wake_function+0x10/0x10
[454919.427191]  iwl_trans_send_cmd+0x57/0x100 [iwlwifi]
[454919.427200]  iwl_mvm_request_system_statistics+0xcd/0x1c0 [iwlmvm]
[454919.427212]  iwl_mvm_request_statistics+0x9c/0x250 [iwlmvm]
[454919.427221]  iwl_mvm_mac_sta_statistics+0x19d/0x3d0 [iwlmvm]
[454919.427228]  sta_set_sinfo+0xde/0xc60 [mac80211]
[454919.427250]  ieee80211_dump_station+0x47/0x70 [mac80211]
[454919.427270]  nl80211_dump_station+0x13f/0x2a0 [cfg80211]
[454919.427295]  genl_dumpit+0x36/0x90
[454919.427299]  netlink_dump+0x138/0x370
[454919.427304]  __netlink_dump_start+0x1e7/0x2b0
[454919.427307]  genl_family_rcv_msg_dumpit+0x9c/0x110
[454919.427309]  ? srso_alias_return_thunk+0x5/0xfbef5
[454919.427310]  ? free_unref_page+0x4d8/0x5d0
[454919.427313]  ? __pfx_genl_start+0x10/0x10
[454919.427314]  ? __pfx_genl_dumpit+0x10/0x10
[454919.427315]  ? __pfx_genl_done+0x10/0x10
[454919.427316]  genl_rcv_msg+0x146/0x2d0
[454919.427318]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[454919.427333]  ? __pfx_genl_rcv_msg+0x10/0x10
[454919.427334]  netlink_rcv_skb+0x58/0x110
[454919.427337]  genl_rcv+0x28/0x40
[454919.427339]  netlink_unicast+0x1a3/0x290
[454919.427340]  netlink_sendmsg+0x222/0x4b0
[454919.427342]  ____sys_sendmsg+0x3ab/0x3e0
[454919.427345]  ? copy_msghdr_from_user+0x7d/0xc0
[454919.427348]  ___sys_sendmsg+0x9a/0xf0
[454919.427352]  __sys_sendmsg+0x87/0xf0
[454919.427355]  do_syscall_64+0xb7/0x210
[454919.427357]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[454919.427360] RIP: 0033:0x7f1fc3519d6d
[454919.427379] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 0a 9e 
f7 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 53 44 89 c7 48 89 44 24 08 e8 5e 9e f7 ff 48
[454919.427380] RSP: 002b:00007ffdc96ed020 EFLAGS: 00000246 ORIG_RAX: 
000000000000002e
[454919.427381] RAX: ffffffffffffffda RBX: 000000003d644d20 RCX: 
00007f1fc3519d6d
[454919.427382] RDX: 0000000000000000 RSI: 00007ffdc96ed070 RDI: 
000000000000000a
[454919.427382] RBP: 00007ffdc96ed070 R08: 0000000000000000 R09: 
0000000000000000
[454919.427383] R10: 0000000000000000 R11: 0000000000000246 R12: 
000000003d65e890
[454919.427383] R13: 000000003d64f4f0 R14: 00007ffdc96ed380 R15: 
000000003d62fea0
[454919.427386]  </TASK>
[454921.031584] iwlwifi 0000:0b:00.0: Queue 2 is stuck 528 530
[454924.490417] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! 
[swapper/1:0]
[454924.490419] Modules linked in: btusb xpad ff_memless uinput ccm qrtr 
rfcomm snd_seq_dummy snd_hrtimer snd_seq af_packet cmac algif_hash 
algif_skcipher af_alg bnep nls_iso8859_1 nls_cp437 vfat fat amdgpu 
iwlmvm mac80211 libarc4 iwlwifi btrtl btintel amdxcp drm_exec btbcm 
gpu_sched btmtk drm_buddy drm_ttm_helper cfg80211 bluetooth ttm 
drm_suballoc_helper drm_display_helper asus_nb_wmi eeepc_wmi asus_wmi 
platform_profile battery cec i8042 i2c_algo_bit sparse_keymap 
snd_hda_codec_hdmi edac_mce_amd edac_core snd_hda_intel uvcvideo amd_atl 
snd_usb_audio intel_rapl_msr snd_intel_dspcfg snd_intel_sdw_acpi 
intel_rapl_common videobuf2_vmalloc crct10dif_pclmul spd5118 
crc32_pclmul snd_hda_codec uvc polyval_clmulni videobuf2_memops 
polyval_generic snd_usbmidi_lib videobuf2_v4l2 ghash_clmulni_intel 
sp5100_tco snd_ump snd_hda_core sha512_ssse3 videobuf2_common watchdog 
snd_rawmidi sha256_ssse3 videodev sha1_ssse3 snd_hwdep snd_seq_device 
sd_mod aesni_intel snd_pcm gf128mul i2c_piix4 crypto_simd cryptd 
snd_timer mc rapl uas igc
[454924.490460]  k10temp i2c_smbus wmi_bmof sch_fq_codel video ptp 
mousedev onboard_usb_dev snd rfkill pps_core wacom input_leds soundcore 
joydev evdev led_class mac_hid atkbd wmi libps2 backlight serio 
vivaldi_fmap tpm_crb tiny_power_button tpm_tis gpio_amdpt tpm_tis_core 
gpio_generic button loop tun tap macvlan bridge stp llc kvm_amd ccp kvm 
fuse efi_pstore configfs nfnetlink efivarfs tpm libaescfb ecdh_generic 
ecc rng_core dmi_sysfs ip_tables autofs4 ext4 crc32c_generic crc16 
mbcache jbd2 hid_generic usbhid hid usb_storage ahci libahci xhci_pci 
libata nvme xhci_hcd scsi_mod nvme_core crc32c_intel scsi_common 
nvme_auth rtc_cmos dm_mod dax [last unloaded: btusb]
[454924.490493] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.13.2 
#1-NixOS
[454924.490495] Hardware name: ASUS System Product Name/ROG STRIX 
X670E-E GAMING WIFI, BIOS 1905 02/05/2024
[454924.490495] RIP: 0010:native_queued_spin_lock_slowpath+0x79/0x2c0
[454924.490500] Code: 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 
09 d0 3d ff 00 00 00 77 64 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 0f b6 
03 <84> c0 75 f7 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 5d 31 c0 31 d2
[454924.490501] RSP: 0018:ffffa941c02f4e18 EFLAGS: 00000202
[454924.490502] RAX: 0000000000000001 RBX: ffff894e1f605c94 RCX: 
0000000000000000
[454924.490503] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffff894e1f605c94
[454924.490503] RBP: 0000000000d05c04 R08: 0000000000000000 R09: 
0000000000000000
[454924.490504] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffffffffc1266020
[454924.490505] R13: ffffffffc1266020 R14: ffff894e1f605c94 R15: 
ffff894e7b279d30
[454924.490505] FS:  0000000000000000(0000) GS:ffff895d1d880000(0000) 
knlGS:0000000000000000
[454924.490506] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[454924.490507] CR2: 00001c2c20a58000 CR3: 000000080ac22000 CR4: 
0000000000f50ef0
[454924.490508] PKRU: 55555554
[454924.490508] Call Trace:
[454924.490509]  <IRQ>
[454924.490510]  ? watchdog_timer_fn+0x235/0x2b0
[454924.490513]  ? __pfx_watchdog_timer_fn+0x10/0x10
[454924.490515]  ? __hrtimer_run_queues+0x10f/0x2b0
[454924.490518]  ? hrtimer_interrupt+0xff/0x260
[454924.490520]  ? __sysvec_apic_timer_interrupt+0x52/0x120
[454924.490523]  ? sysvec_apic_timer_interrupt+0x39/0x80
[454924.490525]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[454924.490528]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454924.490538]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454924.490546]  ? native_queued_spin_lock_slowpath+0x79/0x2c0
[454924.490548]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454924.490554]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454924.490561]  _raw_spin_lock+0x3f/0x60
[454924.490562]  __iwl_trans_pcie_grab_nic_access+0x3d/0x170 [iwlwifi]
[454924.490570]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454924.490578]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454924.490588]  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
[454924.490598]  iwl_force_nmi+0xa3/0xc0 [iwlwifi]
[454924.490608]  call_timer_fn+0x27/0x130
[454924.490611]  __run_timer_base.part.0+0x20c/0x290
[454924.490615]  run_timer_softirq+0x73/0xc0
[454924.490617]  handle_softirqs+0xe1/0x2f0
[454924.490620]  __irq_exit_rcu+0xd6/0x100
[454924.490621]  sysvec_apic_timer_interrupt+0x73/0x80
[454924.490623]  </IRQ>
[454924.490624]  <TASK>
[454924.490624]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[454924.490626] RIP: 0010:cpuidle_enter_state+0xcd/0x440
[454924.490627] Code: b9 72 3e ff e8 14 ed ff ff 8b 53 04 49 89 c5 0f 1f 
44 00 00 31 ff e8 02 ed 3c ff 45 84 ff 0f 85 4e 02 00 00 fb 0f 1f 44 00 
00 <45> 85 f6 0f 88 90 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[454924.490628] RSP: 0018:ffffa941c01c7e90 EFLAGS: 00000246
[454924.490629] RAX: 0000000000000000 RBX: ffff894e010ce400 RCX: 
0000000000000000
[454924.490630] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
0000000000000000
[454924.490630] RBP: 0000000000000002 R08: 0000000000000000 R09: 
0000000000000000
[454924.490631] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffffffff8add1560
[454924.490631] R13: 00019dbb43db41cc R14: 0000000000000002 R15: 
0000000000000000
[454924.490635]  cpuidle_enter+0x2d/0x50
[454924.490638]  do_idle+0x1b1/0x210
[454924.490641]  cpu_startup_entry+0x29/0x30
[454924.490643]  start_secondary+0x11e/0x140
[454924.490644]  common_startup_64+0x13e/0x141
[454924.490648]  </TASK>
[454932.295575] rcu: INFO: rcu_preempt detected expedited stalls on 
CPUs/tasks: { 1-.... 18-.... } 21253 jiffies s: 31717 root: 0x3/.
[454932.295584] rcu: blocking rcu_node structures (internal RCU debug): 
l=1:0-15:0x2/. l=1:16-31:0x4/.
[454932.295588] Sending NMI from CPU 22 to CPUs 1:
[454932.295592] NMI backtrace for cpu 1
[454932.295595] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G 
    L     6.13.2 #1-NixOS
[454932.295597] Tainted: [L]=SOFTLOCKUP
[454932.295597] Hardware name: ASUS System Product Name/ROG STRIX 
X670E-E GAMING WIFI, BIOS 1905 02/05/2024
[454932.295598] RIP: 0010:native_queued_spin_lock_slowpath+0x79/0x2c0
[454932.295603] Code: 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 
09 d0 3d ff 00 00 00 77 64 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 0f b6 
03 <84> c0 75 f7 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 5d 31 c0 31 d2
[454932.295604] RSP: 0018:ffffa941c02f4e18 EFLAGS: 00000202
[454932.295606] RAX: 0000000000000001 RBX: ffff894e1f605c94 RCX: 
0000000000000000
[454932.295607] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffff894e1f605c94
[454932.295607] RBP: 0000000000d05c04 R08: 0000000000000000 R09: 
0000000000000000
[454932.295608] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffffffffc1266020
[454932.295609] R13: ffffffffc1266020 R14: ffff894e1f605c94 R15: 
ffff894e7b279d30
[454932.295609] FS:  0000000000000000(0000) GS:ffff895d1d880000(0000) 
knlGS:0000000000000000
[454932.295610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[454932.295611] CR2: 00001c2c20a58000 CR3: 000000080ac22000 CR4: 
0000000000f50ef0
[454932.295612] PKRU: 55555554
[454932.295612] Call Trace:
[454932.295614]  <NMI>
[454932.295617]  ? nmi_cpu_backtrace+0x9f/0x120
[454932.295620]  ? nmi_cpu_backtrace_handler+0x11/0x20
[454932.295623]  ? nmi_handle+0x5e/0x160
[454932.295625]  ? default_do_nmi+0x43/0x100
[454932.295627]  ? exc_nmi+0x138/0x1d0
[454932.295629]  ? end_repeat_nmi+0xf/0x53
[454932.295634]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454932.295643]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454932.295651]  ? native_queued_spin_lock_slowpath+0x79/0x2c0
[454932.295653]  ? native_queued_spin_lock_slowpath+0x79/0x2c0
[454932.295654]  ? native_queued_spin_lock_slowpath+0x79/0x2c0
[454932.295655]  </NMI>
[454932.295656]  <IRQ>
[454932.295656]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454932.295663]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454932.295669]  _raw_spin_lock+0x3f/0x60
[454932.295670]  __iwl_trans_pcie_grab_nic_access+0x3d/0x170 [iwlwifi]
[454932.295678]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454932.295685]  ? __pfx_iwl_txq_stuck_timer+0x10/0x10 [iwlwifi]
[454932.295691]  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
[454932.295698]  iwl_force_nmi+0xa3/0xc0 [iwlwifi]
[454932.295705]  call_timer_fn+0x27/0x130
[454932.295708]  __run_timer_base.part.0+0x20c/0x290
[454932.295711]  run_timer_softirq+0x73/0xc0
[454932.295713]  handle_softirqs+0xe1/0x2f0
[454932.295716]  __irq_exit_rcu+0xd6/0x100
[454932.295717]  sysvec_apic_timer_interrupt+0x73/0x80
[454932.295720]  </IRQ>
[454932.295720]  <TASK>
[454932.295721]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[454932.295722] RIP: 0010:cpuidle_enter_state+0xcd/0x440
[454932.295724] Code: b9 72 3e ff e8 14 ed ff ff 8b 53 04 49 89 c5 0f 1f 
44 00 00 31 ff e8 02 ed 3c ff 45 84 ff 0f 85 4e 02 00 00 fb 0f 1f 44 00 
00 <45> 85 f6 0f 88 90 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[454932.295725] RSP: 0018:ffffa941c01c7e90 EFLAGS: 00000246
[454932.295726] RAX: 0000000000000000 RBX: ffff894e010ce400 RCX: 
0000000000000000
[454932.295726] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
0000000000000000
[454932.295727] RBP: 0000000000000002 R08: 0000000000000000 R09: 
0000000000000000
[454932.295727] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffffffff8add1560
[454932.295728] R13: 00019dbb43db41cc R14: 0000000000000002 R15: 
0000000000000000
[454932.295731]  cpuidle_enter+0x2d/0x50
[454932.295735]  do_idle+0x1b1/0x210
[454932.295737]  cpu_startup_entry+0x29/0x30
[454932.295739]  start_secondary+0x11e/0x140
[454932.295741]  common_startup_64+0x13e/0x141
[454932.295745]  </TASK>
[454932.296590] Sending NMI from CPU 22 to CPUs 18:
[454932.444521] NMI backtrace for cpu 18
[454932.444523] CPU: 18 UID: 0 PID: 1487 Comm: NetworkManager Tainted: G 
             L     6.13.2 #1-NixOS
[454932.444525] Tainted: [L]=SOFTLOCKUP
[454932.444526] Hardware name: ASUS System Product Name/ROG STRIX 
X670E-E GAMING WIFI, BIOS 1905 02/05/2024
[454932.444526] RIP: 0010:iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454932.444541] Code: e9 5c 6f a9 c8 90 90 90 90 90 90 90 90 90 90 90 90 
90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 89 f6 48 03 b7 f8 1b 00 00 8b 
06 <31> f6 31 ff e9 2e 6f a9 c8 0f 1f 00 90 90 90 90 90 90 90 90 90 90
[454932.444542] RSP: 0018:ffffa941c2f9b410 EFLAGS: 00000286
[454932.444544] RAX: 00000000ffffffff RBX: ffff894e1f604028 RCX: 
0000000000000000
[454932.444545] RDX: 0000000000000000 RSI: ffffa941c1f5c024 RDI: 
ffff894e1f604028
[454932.444545] RBP: 0000000000000011 R08: 0000000000003a98 R09: 
0000000000000000
[454932.444546] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000024
[454932.444547] R13: 0000000000000024 R14: ffff894e1f604028 R15: 
0000000000003a98
[454932.444548] FS:  00007f1fc24a8500(0000) GS:ffff895d1e100000(0000) 
knlGS:0000000000000000
[454932.444549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[454932.444550] CR2: 00001c2c021f2000 CR3: 000000010ca94000 CR4: 
0000000000f50ef0
[454932.444551] PKRU: 55555554
[454932.444551] Call Trace:
[454932.444553]  <NMI>
[454932.444554]  ? nmi_cpu_backtrace+0x9f/0x120
[454932.444557]  ? nmi_cpu_backtrace_handler+0x11/0x20
[454932.444559]  ? nmi_handle+0x5e/0x160
[454932.444562]  ? default_do_nmi+0x43/0x100
[454932.444564]  ? exc_nmi+0x138/0x1d0
[454932.444566]  ? end_repeat_nmi+0xf/0x53
[454932.444570]  ? iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454932.444582]  ? iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454932.444593]  ? iwl_trans_pcie_read32+0x14/0x20 [iwlwifi]
[454932.444600]  </NMI>
[454932.444600]  <TASK>
[454932.444601]  iwl_read32+0x18/0x80 [iwlwifi]
[454932.444608]  iwl_poll_bit+0x42/0x90 [iwlwifi]
[454932.444615]  __iwl_trans_pcie_grab_nic_access+0xcb/0x170 [iwlwifi]
[454932.444623]  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
[454932.444629]  iwl_force_nmi+0xa3/0xc0 [iwlwifi]
[454932.444636]  iwl_trans_sync_nmi_with_addr+0xf9/0x130 [iwlwifi]
[454932.444643]  ? srso_alias_return_thunk+0x5/0xfbef5
[454932.444645]  iwl_trans_pcie_send_hcmd+0x429/0x470 [iwlwifi]
[454932.444653]  ? __pfx_autoremove_wake_function+0x10/0x10
[454932.444656]  iwl_trans_send_cmd+0x57/0x100 [iwlwifi]
[454932.444664]  iwl_mvm_request_system_statistics+0xcd/0x1c0 [iwlmvm]
[454932.444676]  iwl_mvm_request_statistics+0x9c/0x250 [iwlmvm]
[454932.444684]  iwl_mvm_mac_sta_statistics+0x19d/0x3d0 [iwlmvm]
[454932.444692]  sta_set_sinfo+0xde/0xc60 [mac80211]
[454932.444714]  ieee80211_dump_station+0x47/0x70 [mac80211]
[454932.444734]  nl80211_dump_station+0x13f/0x2a0 [cfg80211]
[454932.444759]  genl_dumpit+0x36/0x90
[454932.444762]  netlink_dump+0x138/0x370
[454932.444766]  __netlink_dump_start+0x1e7/0x2b0
[454932.444770]  genl_family_rcv_msg_dumpit+0x9c/0x110
[454932.444771]  ? srso_alias_return_thunk+0x5/0xfbef5
[454932.444772]  ? free_unref_page+0x4d8/0x5d0
[454932.444775]  ? __pfx_genl_start+0x10/0x10
[454932.444776]  ? __pfx_genl_dumpit+0x10/0x10
[454932.444777]  ? __pfx_genl_done+0x10/0x10
[454932.444778]  genl_rcv_msg+0x146/0x2d0
[454932.444780]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[454932.444795]  ? __pfx_genl_rcv_msg+0x10/0x10
[454932.444796]  netlink_rcv_skb+0x58/0x110
[454932.444799]  genl_rcv+0x28/0x40
[454932.444800]  netlink_unicast+0x1a3/0x290
[454932.444802]  netlink_sendmsg+0x222/0x4b0
[454932.444804]  ____sys_sendmsg+0x3ab/0x3e0
[454932.444807]  ? copy_msghdr_from_user+0x7d/0xc0
[454932.444809]  ___sys_sendmsg+0x9a/0xf0
[454932.444814]  __sys_sendmsg+0x87/0xf0
[454932.444817]  do_syscall_64+0xb7/0x210
[454932.444819]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[454932.444821] RIP: 0033:0x7f1fc3519d6d
[454932.444839] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 0a 9e 
f7 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 53 44 89 c7 48 89 44 24 08 e8 5e 9e f7 ff 48
[454932.444839] RSP: 002b:00007ffdc96ed020 EFLAGS: 00000246 ORIG_RAX: 
000000000000002e
[454932.444841] RAX: ffffffffffffffda RBX: 000000003d644d20 RCX: 
00007f1fc3519d6d
[454932.444841] RDX: 0000000000000000 RSI: 00007ffdc96ed070 RDI: 
000000000000000a
[454932.444842] RBP: 00007ffdc96ed070 R08: 0000000000000000 R09: 
0000000000000000
[454932.444843] R10: 0000000000000000 R11: 0000000000000246 R12: 
000000003d65e890
[454932.444843] R13: 000000003d64f4f0 R14: 00007ffdc96ed380 R15: 
000000003d62fea0
[454932.444846]  </TASK>


