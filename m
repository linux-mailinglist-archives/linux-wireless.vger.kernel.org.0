Return-Path: <linux-wireless+bounces-29278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78BBC7F507
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 09:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3853A40E7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379672E7624;
	Mon, 24 Nov 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNTMyHnP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6E25A2DE
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971351; cv=none; b=TXIUuA5Ho4/jdisO949gJYyAM0b6v8yLEGuIw2eq/zYFnz7555ft5jCOj31rLCQEU21n39F/uwgPYRpYGaoomRuJBs6XhTmHa7/l4+1MGWkjPSkOSAWHP3jn965bwDgPu1qDOxOkNbkoqC/OPPXnYkZkGEcOoZZ7Mxiv09zdMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971351; c=relaxed/simple;
	bh=ZirOhPq6X4T11TYzYtKyahzJ7rkDRye4bCDLxQ5czCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1iPUHsB0RdQ7S8g4z8JaqUqIr9X/zSh3hocohFlBt4mdiGmWU9Z5tpBDIpEN8Ad9ohM8hkhHEaEgMVuSR6TwK5xBGmOPR1IjpB28WSAj+2A8LssoHItMtmeLCGvQ0KAQ6popqtW7Ns2JpX2gQTWhbJDSOSBe3XXqzxhDsNk3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNTMyHnP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so4887456b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 00:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971348; x=1764576148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00qi1FEOIrf897q/uhDkR1qMedHCkOHt+DvZlFHxag0=;
        b=FNTMyHnPy2UBYpolyNSvVknbdO5+uwYSI1LZvMAWVanEAT3Z9BWEpGbKh4HGVKIhUZ
         93uqhB1xAyElFj5PkT9TDMOL08iqRFazXUqYFrwLzO7qm7Z2UbxJhPuQRqZLrW3z4skS
         HUADR9zK/6a5hiXEJ+FzJbBJfmIvory0af1Yjzf6i6+iD7si0IfQkGEKCxPWvgcvOD8P
         tGxKT0jROmY+d8ry8d3lbKCt/vMxhLBcRQe/pIy8rAL41To/ph+BkbXtQ4uOuYzdVv8V
         lzp0mwbaFEk90FN6YolTVa0wBj9GXZwfCJAbFSupuvYQisK2LTC4cyfHj03/hp2XSmk2
         Z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971348; x=1764576148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00qi1FEOIrf897q/uhDkR1qMedHCkOHt+DvZlFHxag0=;
        b=rHjVpIy6M/VkgvHsc736/4XZzut3crV0XgNdrE4S4AjQFP1d7chjN2sNOgWPe8ELgm
         3KHeF3GbJB+f1xfUNVVvOjilP8wIr1rkmtx4zhZWTuG71v/DuIBvNUsY/efuWn5NKIpF
         gNIkFXz9mc4Ys9TK+VlFPpqepFUmjYYPnEW9Gu87dUaecgW5pG71drDGZ0Oz5JAFX3ri
         ALzxYYA5NVkeguVHh0cCF2q2Dtu3tDRRKWzEak3FWR1K16a0zFzvLPe+rMk5GYO6S30D
         i4eM19RW0pUa0hXS27si9YqHk/DPaMbilR7vWUkPomWNclNzLwZx6JnjX7HSFGOC4/t4
         L/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUD+w9uf33lwJLJ6Wh4GLnF0optN51LYQAYu2dMg7G9Gjy7wbPcea4bsiE1an9gxoBhhfsiHvcIiOLNcUyosQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylsggna+DqT8b3nucuTLgbflyX15kLhgLB1ft+kbBz+ur/RJU7
	dpZm5yffam9MA28jGDXDh78XW9CEUvUvjc1RRHx0vGWUQxOwzVQTfMeb
X-Gm-Gg: ASbGncuIhlLsTNNgWyGiVgYFFAed0BnmAjOsNKCWo2FLbcBheHfWlT/Nl1Tunl1RiTV
	Pq4fFiRa20+TyI7rFN1Lf+6Am7+rGayihypU46+o+btlZ7hDvZ03PyF8o28TDiI2xTSUpLCDNJc
	6y0RXR7CnOrba2j+y6WRhnRJN0NjW3aqPJRJ2s/my5S6atHK7XikVKm81uI1lTsdkEbWL1a5+my
	osHMiklfHuq4l4H72tEr4UJhd9PgBNsesP8AK/hdmg7zEOQXBMXQnqxVi8Z8O2NDjwMsg+HDKrO
	rPOv8u4WA7fNw5NVJ3SW8HnWcffGpixyQ1rCJLLej90OHV9NEjrfnaW3H4U9FNHIEvKz586babn
	emSqHg7IcuIDchIc9/KDToJLd997pzhMLYUzV4rL+eWhqDPdtmJ77brkLfxHcQ7p/FwQBvgNOg6
	vAI0pAk8dhmAEsVrFAvuDzEGMWJzfrd7FtttEjFxdlSg==
X-Google-Smtp-Source: AGHT+IFIkTk6yTrXkagOGrQLlMkbmbuQoypAfw3EYD9P2SUAw7zDWYydhB/qdKdDu0wxFwVCzHL8lw==
X-Received: by 2002:a05:6a20:12c3:b0:34f:c83b:b3fa with SMTP id adf61e73a8af0-3614edf1698mr12032419637.41.1763971347955;
        Mon, 24 Nov 2025 00:02:27 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bd75dfed99esm12360701a12.1.2025.11.24.00.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:02:27 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: Jes.Sorensen@gmail.com,
	gustavo@embeddedor.com,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH][next] wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end warnings
Date: Mon, 24 Nov 2025 16:02:22 +0800
Message-ID: <20251124080222.6881-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2823a19f73ef45a0919e48ef42ce636f@realtek.com>
References: <2823a19f73ef45a0919e48ef42ce636f@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ping-Ke,

Thank you for your attention on this issue.

Just split the patch into A and B.

Patch A:
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e..3a98bc9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1942,9 +1942,9 @@ struct rtl8xxxu_vif {
 };
 
 struct rtl8xxxu_rx_urb {
-	struct urb urb;
 	struct ieee80211_hw *hw;
 	struct list_head list;
+	struct urb urb;
 };
 
 struct rtl8xxxu_tx_urb {
--

Patch B:
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e59..23be5079a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1948,9 +1948,9 @@ struct rtl8xxxu_rx_urb {
 };
 
 struct rtl8xxxu_tx_urb {
-	struct urb urb;
 	struct ieee80211_hw *hw;
 	struct list_head list;
+	struct urb urb;
 };
 
 struct rtl8xxxu_fileops {
--

When only patch A is applied, the system freezes right after the rtl8xxxu driver is loaded.

kernel log:
Nov 24 15:28:06 BM5220 kernel: usb 2-2: new high-speed USB device number 5 using ehci-pci
Nov 24 15:28:06 BM5220 kernel: usb 2-2: New USB device found, idVendor=0bda, idProduct=818b, bcdDevice= 2.00
Nov 24 15:28:06 BM5220 kernel: usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 24 15:28:06 BM5220 kernel: usb 2-2: Product: 802.11n NIC 
Nov 24 15:28:06 BM5220 kernel: usb 2-2: Manufacturer: Realtek 
Nov 24 15:28:06 BM5220 kernel: usb 2-2: SerialNumber: 00e04c000001
Nov 24 15:28:06 BM5220 kernel: rtl8xxxu: loading out-of-tree module taints kernel.
Nov 24 15:28:06 BM5220 kernel: rtl8xxxu: module verification failed: signature and/or required key missing - tainting kernel
Nov 24 15:28:07 BM5220 kernel: usb 2-2: RTL8192EU rev B (SMIC) romver 0, 2T2R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
Nov 24 15:28:07 BM5220 kernel: usb 2-2: RTL8192EU MAC: 00:eb:d8:76:23:92
Nov 24 15:28:07 BM5220 kernel: usb 2-2: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
Nov 24 15:28:07 BM5220 kernel: usb 2-2: Firmware revision 35.7 (signature 0x92e1)
Nov 24 15:28:08 BM5220 kernel: usbcore: registered new interface driver rtl8xxxu
Nov 24 15:28:08 BM5220 kernel: rtl8xxxu 2-2:1.0 wlp0s19f2u2: renamed from wlan0
Nov 24 15:28:16 BM5220 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
Nov 24 15:28:16 BM5220 kernel: #PF: supervisor read access in kernel mode
Nov 24 15:28:16 BM5220 kernel: #PF: error_code(0x0000) - not-present page
Nov 24 15:28:16 BM5220 kernel: PGD 0 P4D 0 
Nov 24 15:28:16 BM5220 kernel: Oops: Oops: 0000 [#1] SMP NOPTI
Nov 24 15:28:16 BM5220 kernel: CPU: 2 UID: 0 PID: 429 Comm: Xorg Tainted: G           OE       6.17.8-arch1-1 #1 PREEMPT(full)  b229cb54977b6624cce826e2cbd0d8e703fe3921
Nov 24 15:28:16 BM5220 kernel: Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Nov 24 15:28:16 BM5220 kernel: Hardware name: System manufacturer System Product Name/F2A85-M, BIOS 6508 07/11/2014
Nov 24 15:28:16 BM5220 kernel: RIP: 0010:rm_hole+0x1a/0x300
Nov 24 15:28:16 BM5220 kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 48 83 c7 30 48 83 ec 08 48 8b 43 38 48 8b 53 30 <48> 3b 38 0f 85 f7 a5 3f ff 48 3b 7a 08 0f 85 ed a5 3f ff 48 89 42
Nov 24 15:28:16 BM5220 kernel: RSP: 0018:ffffca8641a2f858 EFLAGS: 00010292
Nov 24 15:28:16 BM5220 kernel: RAX: 0000000000000000 RBX: ffff8a3097551870 RCX: ffff8a300478d568
Nov 24 15:28:16 BM5220 kernel: RDX: 0000000000000000 RSI: ffff8a30013cca80 RDI: ffff8a30975518a0
Nov 24 15:28:16 BM5220 kernel: RBP: ffff8a3097551870 R08: ffffffffa4463040 R09: ffff8a300d665110
Nov 24 15:28:16 BM5220 kernel: R10: ffff8a3006d7d980 R11: ffffeeba441b5f40 R12: ffff8a309745c878
Nov 24 15:28:16 BM5220 kernel: R13: ffff8a300478d568 R14: 0000000000000000 R15: 000000000000006e
Nov 24 15:28:16 BM5220 kernel: FS:  00007f816781cec0(0000) GS:ffff8a3180a09000(0000) knlGS:0000000000000000
Nov 24 15:28:16 BM5220 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 24 15:28:16 BM5220 kernel: CR2: 0000000000000000 CR3: 000000010c853000 CR4: 00000000000406f0
Nov 24 15:28:16 BM5220 kernel: Call Trace:
Nov 24 15:28:16 BM5220 kernel:  <TASK>
Nov 24 15:28:16 BM5220 kernel:  drm_mm_remove_node+0x23f/0x380
Nov 24 15:28:16 BM5220 kernel:  ? add_hole+0x129/0x1b0
Nov 24 15:28:16 BM5220 kernel:  ttm_range_man_free+0x28/0x50 [ttm 72fe901885ecf0b0a82d347d12ea8263752178b1]
Nov 24 15:28:16 BM5220 kernel:  ttm_resource_free+0x7d/0xc0 [ttm 72fe901885ecf0b0a82d347d12ea8263752178b1]
Nov 24 15:28:16 BM5220 kernel:  ttm_bo_release+0x14e/0x2e0 [ttm 72fe901885ecf0b0a82d347d12ea8263752178b1]
Nov 24 15:28:16 BM5220 kernel:  ? radeon_vm_bo_rmv+0x107/0x140 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:28:16 BM5220 kernel:  ? __pfx_drm_gem_close_ioctl+0x10/0x10
Nov 24 15:28:16 BM5220 kernel:  drm_gem_object_release_handle+0x59/0xb0
Nov 24 15:28:16 BM5220 kernel:  drm_gem_handle_delete+0x58/0xa0
Nov 24 15:28:16 BM5220 kernel:  ? __pfx_drm_gem_close_ioctl+0x10/0x10
Nov 24 15:28:16 BM5220 kernel:  drm_ioctl_kernel+0xae/0x100
Nov 24 15:28:16 BM5220 kernel:  drm_ioctl+0x29b/0x550
Nov 24 15:28:16 BM5220 kernel:  ? __pfx_drm_gem_close_ioctl+0x10/0x10
Nov 24 15:28:16 BM5220 kernel:  radeon_drm_ioctl+0x4f/0xa0 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:28:16 BM5220 kernel:  __x64_sys_ioctl+0x97/0xe0
Nov 24 15:28:16 BM5220 kernel:  do_syscall_64+0x81/0x970
Nov 24 15:28:16 BM5220 kernel:  ? __sys_recvmsg+0xca/0xe0
Nov 24 15:28:16 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:28:16 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:28:16 BM5220 kernel:  ? switch_fpu_return+0x4e/0xd0
Nov 24 15:28:16 BM5220 kernel:  ? do_syscall_64+0x229/0x970
Nov 24 15:28:16 BM5220 kernel:  ? get_nohz_timer_target+0x2f/0x150
Nov 24 15:28:16 BM5220 kernel:  ? timerqueue_add+0x73/0xd0
Nov 24 15:28:16 BM5220 kernel:  ? hrtimer_start_range_ns+0x23b/0x450
Nov 24 15:28:16 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:28:16 BM5220 kernel:  ? do_setitimer+0x153/0x210
Nov 24 15:28:16 BM5220 kernel:  ? __x64_sys_setitimer+0x162/0x180
Nov 24 15:28:16 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:28:16 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:28:16 BM5220 kernel:  ? __irq_exit_rcu+0x4c/0xf0
Nov 24 15:28:16 BM5220 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 24 15:28:16 BM5220 kernel: RIP: 0033:0x7f816731670d
Nov 24 15:28:16 BM5220 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
Nov 24 15:28:16 BM5220 kernel: RSP: 002b:00007ffea3b8f390 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov 24 15:28:16 BM5220 kernel: RAX: ffffffffffffffda RBX: 000055b26d0e3850 RCX: 00007f816731670d
Nov 24 15:28:16 BM5220 kernel: RDX: 00007ffea3b8f438 RSI: 0000000040086409 RDI: 0000000000000012
Nov 24 15:28:16 BM5220 kernel: RBP: 00007ffea3b8f3e0 R08: 0ba82047bbda5700 R09: 000000000000001a
Nov 24 15:28:16 BM5220 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffea3b8f438
Nov 24 15:28:16 BM5220 kernel: R13: 0000000040086409 R14: 0000000000000012 R15: 0000000000000000
Nov 24 15:28:16 BM5220 kernel:  </TASK>
Nov 24 15:28:16 BM5220 kernel: Modules linked in: rtl8xxxu(OE) cmac ccm mac80211 libarc4 cfg80211 kvm_amd ccp vfat fat snd_hda_codec_atihdmi kvm snd_hda_codec_hdmi snd_hda_intel eeepc_wmi at24 asus_wmi snd_hda_codec irqbypass platform_profile sp5100_tco polyval_clmulni sparse_keymap snd_hda_core snd_intel_dspcfg rfkill wmi_bmof ghash_clmulni_intel snd_intel_sdw_acpi aesni_intel i2c_piix4 pcspkr acpi_cpufreq snd_hwdep k10temp i2c_smbus snd_pcm snd_timer snd joydev soundcore mousedev mac_hid it87 hwmon_vid i2c_dev sg crypto_user dm_mod loop nfnetlink ip_tables x_tables radeon drm_ttm_helper ttm video drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper wmi cec [last unloaded: mt7601u]
Nov 24 15:28:16 BM5220 kernel: CR2: 0000000000000000
Nov 24 15:28:16 BM5220 kernel: ---[ end trace 0000000000000000 ]---
Nov 24 15:28:16 BM5220 kernel: RIP: 0010:rm_hole+0x1a/0x300
Nov 24 15:28:16 BM5220 kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 48 83 c7 30 48 83 ec 08 48 8b 43 38 48 8b 53 30 <48> 3b 38 0f 85 f7 a5 3f ff 48 3b 7a 08 0f 85 ed a5 3f ff 48 89 42
Nov 24 15:28:16 BM5220 kernel: RSP: 0018:ffffca8641a2f858 EFLAGS: 00010292
Nov 24 15:28:16 BM5220 kernel: RAX: 0000000000000000 RBX: ffff8a3097551870 RCX: ffff8a300478d568
Nov 24 15:28:16 BM5220 kernel: RDX: 0000000000000000 RSI: ffff8a30013cca80 RDI: ffff8a30975518a0
Nov 24 15:28:16 BM5220 kernel: RBP: ffff8a3097551870 R08: ffffffffa4463040 R09: ffff8a300d665110
Nov 24 15:28:16 BM5220 kernel: R10: ffff8a3006d7d980 R11: ffffeeba441b5f40 R12: ffff8a309745c878
Nov 24 15:28:16 BM5220 kernel: R13: ffff8a300478d568 R14: 0000000000000000 R15: 000000000000006e
Nov 24 15:28:16 BM5220 kernel: FS:  00007f816781cec0(0000) GS:ffff8a3180a09000(0000) knlGS:0000000000000000
Nov 24 15:28:16 BM5220 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 24 15:28:16 BM5220 kernel: CR2: 0000000000000000 CR3: 000000010c853000 CR4: 00000000000406f0
Nov 24 15:28:16 BM5220 kernel: note: Xorg[429] exited with irqs disabled
Nov 24 15:28:16 BM5220 kernel: note: Xorg[429] exited with preempt_count 1



When only patch B is applied, the result is the same but the error messages are different.

kernel log:
Nov 24 15:35:09 BM5220 kernel: usb 2-2: new high-speed USB device number 5 using ehci-pci
Nov 24 15:35:09 BM5220 kernel: usb 2-2: New USB device found, idVendor=0bda, idProduct=818b, bcdDevice= 2.00
Nov 24 15:35:09 BM5220 kernel: usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 24 15:35:09 BM5220 kernel: usb 2-2: Product: 802.11n NIC 
Nov 24 15:35:09 BM5220 kernel: usb 2-2: Manufacturer: Realtek 
Nov 24 15:35:09 BM5220 kernel: usb 2-2: SerialNumber: 00e04c000001
Nov 24 15:35:09 BM5220 kernel: rtl8xxxu: loading out-of-tree module taints kernel.
Nov 24 15:35:09 BM5220 kernel: rtl8xxxu: module verification failed: signature and/or required key missing - tainting kernel
Nov 24 15:35:09 BM5220 kernel: usb 2-2: RTL8192EU rev B (SMIC) romver 0, 2T2R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
Nov 24 15:35:09 BM5220 kernel: usb 2-2: RTL8192EU MAC: 00:eb:d8:76:23:92
Nov 24 15:35:09 BM5220 kernel: usb 2-2: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
Nov 24 15:35:09 BM5220 kernel: usb 2-2: Firmware revision 35.7 (signature 0x92e1)
Nov 24 15:35:10 BM5220 kernel: usbcore: registered new interface driver rtl8xxxu
Nov 24 15:35:10 BM5220 kernel: rtl8xxxu 2-2:1.0 wlp0s19f2u2: renamed from wlan0
Nov 24 15:35:40 BM5220 kernel: usercopy: Kernel memory overwrite attempt detected to SLUB object 'kmalloc-256' (offset 24, size 240)!
Nov 24 15:35:40 BM5220 kernel: ------------[ cut here ]------------
Nov 24 15:35:40 BM5220 kernel: kernel BUG at mm/usercopy.c:102!
Nov 24 15:35:40 BM5220 kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
Nov 24 15:35:40 BM5220 kernel: CPU: 2 UID: 0 PID: 461 Comm: Xorg:rcs0 Tainted: G           OE       6.17.8-arch1-1 #1 PREEMPT(full)  b229cb54977b6624cce826e2cbd0d8e703fe3921
Nov 24 15:35:40 BM5220 kernel: Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Nov 24 15:35:40 BM5220 kernel: Hardware name: System manufacturer System Product Name/F2A85-M, BIOS 6508 07/11/2014
Nov 24 15:35:40 BM5220 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 24 15:35:40 BM5220 kernel: Code: 48 c7 c6 4f 60 a4 b0 eb 0e 48 c7 c7 8d e3 a6 b0 48 c7 c6 2e 97 a3 b0 52 48 89 fa 48 c7 c7 60 ae 98 b0 50 41 52 e8 56 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c7 c7 92 33 a4
Nov 24 15:35:40 BM5220 kernel: RSP: 0018:ffffd30e01913828 EFLAGS: 00010246
Nov 24 15:35:40 BM5220 kernel: RAX: 0000000000000066 RBX: ffff8d5aa3381f18 RCX: 0000000000000000
Nov 24 15:35:40 BM5220 kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d5b2711cfc0
Nov 24 15:35:40 BM5220 kernel: RBP: 00000000000000f0 R08: 0000000000000000 R09: 00000000ffffefff
Nov 24 15:35:40 BM5220 kernel: R10: ffffffffb1260c00 R11: ffffd30e019136c8 R12: ffff8d5aa3382008
Nov 24 15:35:40 BM5220 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000558a4ab8cc90
Nov 24 15:35:40 BM5220 kernel: FS:  00007fae0ddff6c0(0000) GS:ffff8d5b75209000(0000) knlGS:0000000000000000
Nov 24 15:35:40 BM5220 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 24 15:35:40 BM5220 kernel: CR2: 00007fae0c04f000 CR3: 0000000102006000 CR4: 00000000000406f0
Nov 24 15:35:40 BM5220 kernel: Call Trace:
Nov 24 15:35:40 BM5220 kernel:  <TASK>
Nov 24 15:35:40 BM5220 kernel:  __check_heap_object+0xea/0x120
Nov 24 15:35:40 BM5220 kernel:  __check_object_size+0x1d2/0x1f0
Nov 24 15:35:40 BM5220 kernel:  radeon_cs_parser_init+0x20c/0x480 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:35:40 BM5220 kernel:  radeon_cs_ioctl+0xa8/0x860 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:35:40 BM5220 kernel:  ? __pfx_radeon_cs_ioctl+0x10/0x10 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:35:40 BM5220 kernel:  drm_ioctl_kernel+0xae/0x100
Nov 24 15:35:40 BM5220 kernel:  drm_ioctl+0x29b/0x550
Nov 24 15:35:40 BM5220 kernel:  ? __pfx_radeon_cs_ioctl+0x10/0x10 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:35:40 BM5220 kernel:  radeon_drm_ioctl+0x4f/0xa0 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:35:40 BM5220 kernel:  __x64_sys_ioctl+0x97/0xe0
Nov 24 15:35:40 BM5220 kernel:  do_syscall_64+0x81/0x970
Nov 24 15:35:40 BM5220 kernel:  ? do_futex+0x11f/0x190
Nov 24 15:35:40 BM5220 kernel:  ? __x64_sys_futex+0x12d/0x210
Nov 24 15:35:40 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:35:40 BM5220 kernel:  ? radeon_drm_ioctl+0x81/0xa0 [radeon 318f5942ad0f10fa6d610159e6717f7bd011ffbc]
Nov 24 15:35:40 BM5220 kernel:  ? __x64_sys_ioctl+0xb1/0xe0
Nov 24 15:35:40 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:35:40 BM5220 kernel:  ? switch_fpu_return+0x4e/0xd0
Nov 24 15:35:40 BM5220 kernel:  ? do_syscall_64+0x229/0x970
Nov 24 15:35:40 BM5220 kernel:  ? do_syscall_64+0x229/0x970
Nov 24 15:35:40 BM5220 kernel:  ? do_syscall_64+0x81/0x970
Nov 24 15:35:40 BM5220 kernel:  ? __irq_exit_rcu+0x4c/0xf0
Nov 24 15:35:40 BM5220 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 24 15:35:40 BM5220 kernel: RIP: 0033:0x7fae1d71670d
Nov 24 15:35:40 BM5220 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
Nov 24 15:35:40 BM5220 kernel: RSP: 002b:00007fae0ddfe9b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov 24 15:35:40 BM5220 kernel: RAX: ffffffffffffffda RBX: 00007fae104b90c0 RCX: 00007fae1d71670d
Nov 24 15:35:40 BM5220 kernel: RDX: 00007fae104c90c8 RSI: 00000000c0206466 RDI: 0000000000000012
Nov 24 15:35:40 BM5220 kernel: RBP: 00007fae0ddfea00 R08: 0000000000000000 R09: 0000000000000000
Nov 24 15:35:40 BM5220 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fae104c90c8
Nov 24 15:35:40 BM5220 kernel: R13: 00000000c0206466 R14: 0000000000000012 R15: 0000558a49883770
Nov 24 15:35:40 BM5220 kernel:  </TASK>
Nov 24 15:35:40 BM5220 kernel: Modules linked in: rtl8xxxu(OE) cmac ccm mac80211 libarc4 cfg80211 vfat kvm_amd snd_hda_codec_atihdmi fat snd_hda_codec_hdmi ccp snd_hda_intel snd_hda_codec kvm snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi at24 eeepc_wmi snd_hwdep irqbypass snd_pcm polyval_clmulni asus_wmi ghash_clmulni_intel sp5100_tco snd_timer platform_profile sparse_keymap aesni_intel wmi_bmof snd rfkill acpi_cpufreq i2c_piix4 pcspkr i2c_smbus k10temp soundcore joydev mousedev mac_hid it87 hwmon_vid i2c_dev sg loop crypto_user dm_mod nfnetlink ip_tables x_tables radeon drm_ttm_helper ttm video drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper cec wmi [last unloaded: mt7601u]
Nov 24 15:35:40 BM5220 kernel: ---[ end trace 0000000000000000 ]---
Nov 24 15:35:40 BM5220 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 24 15:35:40 BM5220 kernel: Code: 48 c7 c6 4f 60 a4 b0 eb 0e 48 c7 c7 8d e3 a6 b0 48 c7 c6 2e 97 a3 b0 52 48 89 fa 48 c7 c7 60 ae 98 b0 50 41 52 e8 56 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c7 c7 92 33 a4
Nov 24 15:35:40 BM5220 kernel: RSP: 0018:ffffd30e01913828 EFLAGS: 00010246
Nov 24 15:35:40 BM5220 kernel: RAX: 0000000000000066 RBX: ffff8d5aa3381f18 RCX: 0000000000000000
Nov 24 15:35:40 BM5220 kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d5b2711cfc0
Nov 24 15:35:40 BM5220 kernel: RBP: 00000000000000f0 R08: 0000000000000000 R09: 00000000ffffefff
Nov 24 15:35:40 BM5220 kernel: R10: ffffffffb1260c00 R11: ffffd30e019136c8 R12: ffff8d5aa3382008
Nov 24 15:35:40 BM5220 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000558a4ab8cc90
Nov 24 15:35:40 BM5220 kernel: FS:  00007fae0ddff6c0(0000) GS:ffff8d5b75209000(0000) knlGS:0000000000000000
Nov 24 15:35:40 BM5220 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 24 15:35:40 BM5220 kernel: CR2: 00007fae0c04f000 CR3: 0000000102006000 CR4: 00000000000406f0

Hopefully these logs are helpful, thank you again!

