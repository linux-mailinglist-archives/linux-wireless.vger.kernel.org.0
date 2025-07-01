Return-Path: <linux-wireless+bounces-24740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE1AF01AB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D016188049F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3C19644B;
	Tue,  1 Jul 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1HH44/8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE351DD529
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390140; cv=none; b=PHyOEtalfz3yDfX4elz0oUdXdCZmAVrchZnvnEJfINWi+GKXGrKdq/KmoOur6fJmIbaxCFhaRi2cPzHC0yKQOQ5hMxHqiWV20H3MmJF+sdKCXsDhM2mcofTNxvn6HUUTc4tVj5UvZjuyc+XPFs6w07sUPuK5nyXaVkFVOcsxRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390140; c=relaxed/simple;
	bh=8Q0Ny3NtQrE4ubdfyrtuU5L7rqhGxW/N4XvRHvSQ350=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XaFzu3PYdJly2gs6TMDeD07T2N1qogIfLvhSXipOIAa9OmykmtwKlK49k3Y1A+T+LtjDlr2y7GxlrtCYuQiD4bf2J5VnWESURASPxD5cGneMvT/AScCQydRI5nHKd7MpttF9UykDZJAhDkshlIjymhI3FffGbsCh5vieS2g78LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1HH44/8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4537deebb01so18668915e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751390137; x=1751994937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PZ0MvLcvlv6cXMfiRORnjjV6KSf1C4T73C/jZOCGwQ=;
        b=G1HH44/84544CgHsoyyZI3miwvX3dO7xV7YVZOSTXO727TVkIDngVrMhiu8qw9mstb
         VojcfSct0HMHl0w5TTlePILHux+8R2Wg6QHHOIz7y4CSxZLFxLuORipioefr8QBAaGvr
         HX0IfuGwkxMUOaBSzYTgqgP660TXBNb1nnSIL+4y0UwVY1G4N3HFQvG/2oBpqqkNZyc4
         AXTBCDXHYUvbhnmX03JeatJzoNPtxKaC4Bq4wIP/l61rvGdvDjlwWHAnIQW87pXj4lRi
         L0Zh+slexTfl8+hbGYZoJKUqNu3fgQDojwQQWft1qd8q1e0KkWT/9iMoZKAZsaNb8tuT
         /NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751390137; x=1751994937;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PZ0MvLcvlv6cXMfiRORnjjV6KSf1C4T73C/jZOCGwQ=;
        b=VX4wAIRHhha1HFgwHVJhooJsAepyiC4x+YcMFN4KclWfomY0+sQ0hDtqdBV8bz5tBZ
         jbcPPfEAa5ANAOLVYU3q0IKYuPkf1WUk2FHwzn6Lu30uZc7o7phMmtd90oLRoVZgaa4l
         vCzXt6AWe+84aoux92umU+juXdQfEXK7xTv2x/qChWuObLi1RzPX92GEWqzJlqiYrom6
         AuBY2dosrEnf07HJLUcCVnocJRRXksW6cotC3L5C7vI7JUkOOBqvogrBFlLuffVSOYOd
         kMf+8rBazoZu/CPLGHjSzt0X9kOH39XHxgWweyGfhRiHF7t4DZ72dQYZt4cKar7AmqJy
         QIIw==
X-Gm-Message-State: AOJu0YzXwJlTAfJKVU0Qf10XPWLbZQtMP/u0IIuEcczyYX4GA+7xZmqF
	s5GZKnQsGbipoAbdgt+n44/CXDg0YpwhynqmXdmz9GA4u7fdLv++wY0zTr4kEw==
X-Gm-Gg: ASbGncth9KGi/pfgJavy6BJbe/ram33bXI0t8sRD7PTXMjKFOxrJb1+dkuXX03eYIGX
	KILadPEWDn96PnDvLnPIrfsanyjFCfImLjk9bybRxSLoCiXl5emWuePtuN+w5NSldDPi9Z1+SBU
	ZPi2enFmD3j+nndjIreKxAE8GnG6xaEkoGt5LxNuClIi4KBoHsMSY8Zw33kUvqsB/zC6EPrb9ZM
	huTvNitOqDGTPadvUYOjvPI3PpokogCCkDGIwznRuBV5Pja0vwTVzwh4L9BcKjsRefjONbuP9uS
	O6KK+gCJtdiuwgmiyxo5Udv3Eg6tpGyS/gnTLn2VYD5XdcNUINaAm+o4XYXe+ImXNsbPSA==
X-Google-Smtp-Source: AGHT+IEuQFy8LtKuHgvXtloUoKO3fZRyowuJhNMnoJKBsUcNuhGh3zHOmK720hsIPRfgHsAc/1vy7g==
X-Received: by 2002:a05:600c:8b06:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-4538ee3b85amr227917685e9.10.1751390136526;
        Tue, 01 Jul 2025 10:15:36 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe592sm167906785e9.21.2025.07.01.10.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 10:15:35 -0700 (PDT)
Message-ID: <0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com>
Date: Tue, 1 Jul 2025 20:15:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: rtw89: Firmware bug related to the hardware scan channel list
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

A few users with RTL8851BU who did not install wireless-regdb reported this:

kernel: rtw89_8851bu 1-2:1.2: Firmware version 0.29.41.3 (65cefb31), cmd version 0, type 3
...
kernel: rtw89_8851bu 1-2:1.2: rtw89_hw_scan_offload failed ret -110
kernel: rtw89_8851bu 1-2:1.2: c2h reg timeout
kernel: rtw89_8851bu 1-2:1.2: FW does not process h2c registers
kernel: rtw89_8851bu 1-2:1.2: HW scan failed: -110

The AP can't be pinged anymore, but the driver is still receiving beacons.

It's the same with RTL8832BU.

It can also be reproduced with RTL8852BE (PCI). The output is different:

[  628.015012] rtw89_8852be_git 0000:02:00.0: Firmware version 0.29.29.8 (39dbf50f), cmd version 0, type 3
...
[  698.619819] rtw89_8852be_git 0000:02:00.0: FW status = 0x67001220
[  698.619830] rtw89_8852be_git 0000:02:00.0: FW BADADDR = 0x0
[  698.619835] rtw89_8852be_git 0000:02:00.0: FW EPC/RA = 0xb89bacd3
[  698.619841] rtw89_8852be_git 0000:02:00.0: FW MISC = 0xb8900635
[  698.619845] rtw89_8852be_git 0000:02:00.0: R_AX_HALT_C2H = 0x30000008
[  698.619850] rtw89_8852be_git 0000:02:00.0: R_AX_SER_DBG_INFO = 0x0
[  698.619858] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8987df9
[  698.619873] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb89784e7
[  698.619888] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8935ea7
[  698.619903] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8920565
[  698.619917] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8935e9f
[  698.619932] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8935ed1
[  698.619947] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb890cd1f
[  698.619961] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893035c
[  698.619976] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934333
[  698.619990] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934345
[  698.620005] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8935f1f
[  698.620019] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb89bac9d
[  698.620034] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb89afeb3
[  698.620048] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8935e1b
[  698.620063] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb89bac2b
[  698.620076] rtw89_8852be_git 0000:02:00.0: SER catches error: 0x4000
[  698.620139] rtw89_8852be_git 0000:02:00.0: FW status = 0x68001220
[  698.620144] rtw89_8852be_git 0000:02:00.0: FW BADADDR = 0x0
[  698.620150] rtw89_8852be_git 0000:02:00.0: FW EPC/RA = 0xb89bacd3
[  698.620156] rtw89_8852be_git 0000:02:00.0: FW MISC = 0xb8900635
[  698.620161] rtw89_8852be_git 0000:02:00.0: R_AX_HALT_C2H = 0x30000008
[  698.620167] rtw89_8852be_git 0000:02:00.0: R_AX_SER_DBG_INFO = 0x0
[  698.620177] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893037c
[  698.620214] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8935df9
[  698.620231] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934345
[  698.620246] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893435b
[  698.620261] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893435b
[  698.620276] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893435b
[  698.620291] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934379
[  698.620306] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934377
[  698.620321] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893437f
[  698.620336] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934315
[  698.620351] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb89333b5
[  698.620366] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893432d
[  698.620381] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893432f
[  698.620396] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb893432f
[  698.620412] rtw89_8852be_git 0000:02:00.0: [ERR]fw PC = 0xb8934349
[  698.620424] rtw89_8852be_git 0000:02:00.0: SER catches error: 0x4000
[  698.621158] rtw89_8852be_git 0000:02:00.0: FW backtrace invalid size: 0x0
[  698.625076] ieee80211 phy1: Hardware restart was requested
[  698.625098] ------------[ cut here ]------------
[  698.625100] ieee80211_restart_work called with hardware scan in progress
[  698.625172] WARNING: CPU: 2 PID: 61 at net/mac80211/main.c:354 ieee80211_restart_work+0x13d/0x150 [mac80211]
[  698.625313] Modules linked in: rtw89_8852be_git(OE) rtw89_8852b_git(OE) rtw89_8852b_common_git(OE) rtw89_pci_git(OE) rtw89_core_git(OE) cmac ccm vfat edac_mce_amd fat kvm_amd ccp kvm mac80211 irqbypass crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic gf128mul eeepc_wmi snd_hda_codec_hdmi libarc4 ghash_clmulni_intel asus_wmi sha512_ssse3 ledtrig_audio snd_hda_intel sha256_ssse3 cfg80211 sparse_keymap snd_intel_dspcfg sha1_ssse3 platform_profile snd_intel_sdw_acpi aesni_intel i8042 serio snd_hda_codec crypto_simd rfkill acpi_cpufreq pcspkr wmi_bmof snd_hda_core cryptd k10temp sp5100_tco i2c_piix4 snd_hwdep snd_pcm snd_timer joydev snd soundcore mousedev mac_hid it87 hwmon_vid sg crypto_user dm_mod fuse loop nfnetlink bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid radeon drm_ttm_helper ttm video i2c_algo_bit crc32c_intel drm_suballoc_helper drm_display_helper xhci_pci cec xhci_pci_renesas wmi
[  698.625424] Unloaded tainted modules: rtw89_core_git(OE):1 rtw89_pci_git(OE):1 rtw89_8852b_common_git(OE):1 rtw89_8852b_git(OE):1 rtw89_8852be_git(OE):1 [last unloaded: rtw89_core_git(OE)]
[  698.625439] CPU: 2 PID: 61 Comm: kworker/2:1 Tainted: G           OE      6.6.88-1-lts66 #1 29602267a9340ebc551d246a9d0d242da9be9d82
[  698.625445] Hardware name: System manufacturer System Product Name/F2A85-M, BIOS 6508 07/11/2014
[  698.625448] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  698.625551] RIP: 0010:ieee80211_restart_work+0x13d/0x150 [mac80211]
[  698.625656] Code: bd f0 e9 ff ff e8 73 b6 da ff 5b 5d 41 5c 41 5d 41 5e e9 76 17 ff c1 48 c7 c6 50 ea cc c0 48 c7 c7 a8 d0 cd c0 e8 53 3d 51 c1 <0f> 0b e9 03 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90
[  698.625660] RSP: 0018:ffffc900002b7e40 EFLAGS: 00010282
[  698.625664] RAX: 0000000000000000 RBX: ffff88810129a900 RCX: 0000000000000027
[  698.625667] RDX: ffff888227521748 RSI: 0000000000000001 RDI: ffff888227521740
[  698.625669] RBP: ffff888192781f50 R08: 0000000000000000 R09: ffffc900002b7cb0
[  698.625672] R10: ffffffff840b26c8 R11: 0000000000000003 R12: ffff88810007ac00
[  698.625674] R13: ffff888192780900 R14: ffff88810007ac05 R15: 0000000000000000
[  698.625677] FS:  0000000000000000(0000) GS:ffff888227500000(0000) knlGS:0000000000000000
[  698.625680] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  698.625683] CR2: 00005eb01aafb000 CR3: 0000000108b16000 CR4: 00000000000406e0
[  698.625686] Call Trace:
[  698.625690]  <TASK>
[  698.625695]  process_one_work+0x190/0x3a0
[  698.625705]  worker_thread+0x318/0x460
[  698.625711]  ? __pfx_worker_thread+0x10/0x10
[  698.625716]  kthread+0xe8/0x120
[  698.625719]  ? __pfx_kthread+0x10/0x10
[  698.625723]  ret_from_fork+0x34/0x50
[  698.625729]  ? __pfx_kthread+0x10/0x10
[  698.625732]  ret_from_fork_asm+0x1b/0x30
[  698.625739]  </TASK>
[  698.625740] ---[ end trace 0000000000000000 ]---
[  698.625750] rtw89_8852be_git 0000:02:00.0: rtw89_hw_scan_offload failed ret 1

I guess that's a firmware crash.

Interestingly, this test firmware with version 1.29.29.9 works fine for
RTL8852BE and RTL8832BU:

https://lore.kernel.org/linux-wireless/42783d9a032143bfb67ea969ee0b805d@realtek.com/

As far as I can tell, this problem happens when the hardware scan channel
list is too long to fit in a single H2C message (see
"if (list_len == RTW89_SCAN_LIST_LIMIT_AX)" in
rtw89_hw_scan_add_chan_list_ax()) and the last channel in the first H2C
message happens to be the operating channel (RTW89_CHAN_OPERATE).

To reproduce this condition in a reliable way, pretend that every channel is
a DFS channel:

diff --git a/fw.c b/fw.c
index 48575e4..bf5df41 100644
--- a/fw.c
+++ b/fw.c
@@ -7121,6 +7121,7 @@ int rtw89_hw_scan_prep_chan_list_ax(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_DFS;
 		else
 			type = RTW89_CHAN_ACTIVE;
+		type = RTW89_CHAN_DFS;
 		rtw89_hw_scan_add_chan_ax(rtwdev, type, req->n_ssids, ch_info);
 
 		if (scan_info->connected &&

Then the driver will add RTW89_CHAN_OPERATE before every single channel and
the list of channels will be longer than RTW89_SCAN_LIST_LIMIT_AX.

One workaround is to not let the operating channel be the last one in the
split list:

diff --git a/fw.c b/fw.c
index 27d84464347b..ef036e1585f3 100644
--- a/fw.c
+++ b/fw.c
@@ -7381,6 +7381,13 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 	INIT_LIST_HEAD(&list);
 
 	list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
+		/* The operating channel (tx_null == true) should
+		 * not be last in the list, to avoid breaking
+		 * RTL8851BU and RTL8832BU.
+		 */
+		if (list_len + 1 == RTW89_SCAN_LIST_LIMIT_AX && ch_info->tx_null)
+			break;
+
 		list_move_tail(&ch_info->list, &list);
 
 		list_len++;

Another way is to keep tx_null false, then it doesn't matter how the list of
channels is split:

diff --git a/fw.c b/fw.c
index 48575e4..420a665 100644
--- a/fw.c
+++ b/fw.c
@@ -6906,7 +6906,7 @@ static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
 		ch_info->pri_ch = op->primary_channel;
 		ch_info->ch_band = op->band_type;
 		ch_info->bw = op->band_width;
-		ch_info->tx_null = true;
+		// ch_info->tx_null = true;
 		ch_info->num_pkt = 0;
 		break;
 	case RTW89_CHAN_DFS:

Hopefully this can help you find the problem in the firmware.

