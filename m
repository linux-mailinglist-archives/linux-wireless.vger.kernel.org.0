Return-Path: <linux-wireless+bounces-29575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3883FCABBC7
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 02:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 947EF3004D27
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676E86323;
	Mon,  8 Dec 2025 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZj1W4uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCF3B8D4A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765158171; cv=none; b=qnXxipNQXF3pzFYG6TV2qDTDZbNiwvnBwI/yaQJnK3z1owXw05x3SmWgypi7QOlLPrSa0Jr4DSh7yNYkx3pQaawGvKSU7bTwr5uAsj3tSV7GA52oTN4lm/MDfw01KBoeTdmMIUz09MuIynB7hmTYhAGH+IcvYS0CcLxtzxk3+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765158171; c=relaxed/simple;
	bh=9LqmiNEAA+WQwwdn2ZC+5+Z/QgaHLad9UmyijGUyZys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaRnFoAxeufRDMrq0jZXH9p5LOVHq+9NfZXefToLc7ZweSH6ODrwisWRI8epq04dhMpGB9eDXgRD+vcqYg1fNpD1I3HQKCL6LPbOtPWLDQJbHbRwuDOggsWK4irUKyEM7XaIxSb2pnw0paBxApUbHZ+TA3CMYhkW3/rALzdbcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZj1W4uu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297ec50477aso15003505ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 17:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765158169; x=1765762969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcRDqDO7YH+kCOaoRBwP0YrG3zu3eYr4TOpj3L+ph68=;
        b=UZj1W4uuw7owVrak671absV0UAahhoRG1YNN+g8dCUqEAKsw2ywNP/FQ4kHnWDfXzn
         qXEpE09x0w3RqZOkNpNEda7WI1RJ9a8h1kJHAtIb+5SY/l9uV1Q/WdAY5LbMuhbBEhvN
         DBI/t/3AD0QcxeQ4Likh0X6fPIPAkMvTectf3aarnIjh4dt1NO98MoIwsEV4eSeDRE/R
         dk7/TPF/FLmxwhiYRs2OE32QIF3CK7GGAuTnwYEabCpJ7dYwETb3mwO+zjOTOskQftWE
         Zwyp1APjIhJutZrq6uLNMW05HrL6N43ziaMr2m+3IClf5xNF8v/Ji4EOGQbzEG/Uvsdr
         qxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765158169; x=1765762969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcRDqDO7YH+kCOaoRBwP0YrG3zu3eYr4TOpj3L+ph68=;
        b=hv7YZWyjo6PfZL6Mdt6BKbccoKPOb4hNeJ+137+JDBM9t7VLjkGl7N9oITz/56ftI+
         oFs1cDeqGT5dhxqWYmosll6yvgAHgp/3VmWyzYdHN0JCLxXh0WGjw9wmbylWDDJARLz4
         OsUopHDV+zUclj8o1SNi+LQWZhMyvGyN3eMap836zaDlWZcrLgd5JsoJcWNcvhu629Fj
         CV/fcOBbm3MboVoop602Tk3sCNVqsg2b4S2PpZyhPDdwpid+hCUjFSgkvTJkqkIgAVor
         gLyttLjwyqLpl/TYiwaxe/wd9GVjneX5isZgkOd5KVlhWAmsTqP4YY4j42dElgG5Dy+z
         byAg==
X-Gm-Message-State: AOJu0Yzwbj2KoGLuv3niqLcud/rctJUujSE/Hg6KTPrcxu1YIiGZqk90
	RF+LuUQfteY3bZmOKBlkZdaomNPFXFVEmkjYgK6zqUugatkc8ql8j604I6dPNLDT
X-Gm-Gg: ASbGncvrN1H/fBaFggDHFOg7TQmMi+jLHmpVUCbgcGyZU+uELZXG3B4MuTCOGGb+C6j
	V8xeZn1ZY6F3cvAN3rjAe3d0Q/wBcFr5u+g1DDY/JoOTau5HmdR2hvu3MvHd9Kh0ViXh3Dlc+0E
	FFEXWC/GRKPATRsuszEo+slkM03uXrUytpilM9ZQqZtgf0LNuS48o0WYltKSV3jzDuo4uiVPv/Z
	18i3w35CpO/uNs7QaZTEbPaXAPu4CNs+h3l10+kXhSTIvKBTiqAlY09tP4m3OW0X7zFcFPBPErV
	C9OG23uEWsA8tMYybXDbE+R3LEofYFdQryAyECxIN4R7OauaGgcsAtTBhrsbMsnVPW7XoUBzDCj
	wdB6qIgJbJhYW0O0sv0b62ZUnmRdJ5qDsRVEoI+LCHt7X31aJepxSli5GjImV2tJD21eUMMc7DF
	aEQvPwyI2XaetQ31BcDyw3aTMng8LQxT/36wNBGivmcw==
X-Google-Smtp-Source: AGHT+IFwf/jbZUb06TMoV3vzef5GrCPvneRZZU7obtCvqE6gBrHfb+XYlrO16roTQ/AJv5PJirHFXg==
X-Received: by 2002:a17:903:2f8e:b0:262:f975:fcba with SMTP id d9443c01a7336-29df3727697mr53301635ad.9.1765158169133;
        Sun, 07 Dec 2025 17:42:49 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29daeaaba2dsm109005435ad.69.2025.12.07.17.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 17:42:48 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	marco.crivellari@suse.com,
	rtl8821cerfe2@gmail.com
Subject: RE: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"
Date: Mon,  8 Dec 2025 09:42:43 +0800
Message-ID: <20251208014243.3512-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
References: <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, 

Last weekend I tried applying the v1 [1] to the kernel 6.17.9, but that one didn't work, either.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/20251113160605.381777-3-marco.crivellari@suse.com/

[  306.035759] usb 3-2: new high-speed USB device number 5 using ehci-pci
[  306.162258] usb 3-2: New USB device found, idVendor=0bda, idProduct=b82c, bcdDevice= 2.10
[  306.162272] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  306.162278] usb 3-2: Product: 802.11ac NIC
[  306.162282] usb 3-2: Manufacturer: Realtek
[  306.162286] usb 3-2: SerialNumber: 123456
[  306.239143] ------------[ cut here ]------------
[  306.239148] WARNING: CPU: 3 PID: 2886 at kernel/workqueue.c:5667 alloc_workqueue_noprof+0x676/0x770
[  306.239157] Modules linked in: rtw88_8822bu(OE+) rtw88_8822b(OE) rtw88_usb(OE) rtw88_core(OE) cmac ccm vfat fat rtw89_8852ce_git(OE) rtw89_8852c_git(OE) snd_hda_codec_atihdmi rtw89_pci_git(OE) snd_hda_codec_hdmi snd_hda_intel kvm_amd rtw89_core_git(OE) snd_hda_codec ccp mac80211 snd_hda_core kvm at24 snd_intel_dspcfg eeepc_wmi asus_wmi libarc4 snd_intel_sdw_acpi snd_hwdep sp5100_tco irqbypass platform_profile cfg80211 polyval_clmulni sparse_keymap wmi_bmof ghash_clmulni_intel snd_pcm aesni_intel i2c_piix4 snd_timer rfkill pcspkr acpi_cpufreq k10temp i2c_smbus snd soundcore joydev mousedev mac_hid it87 hwmon_vid i2c_dev sg crypto_user loop dm_mod nfnetlink ip_tables x_tables radeon drm_ttm_helper ttm video drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper wmi cec
[  306.239242] CPU: 3 UID: 0 PID: 2886 Comm: (udev-worker) Tainted: G           OE       6.17.9-arch1-1 #1 PREEMPT(full)  71adf6020e7d04ea315feaf360c679be0fb5cb04
[  306.239247] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  306.239248] Hardware name: System manufacturer System Product Name/F2A85-M, BIOS 6508 07/11/2014
[  306.239250] RIP: 0010:alloc_workqueue_noprof+0x676/0x770
[  306.239254] Code: e7 e8 fe d6 ff ff 48 89 c3 48 3d 00 f0 ff ff 0f 87 64 ff ff ff 48 89 c7 e8 e7 7b ff ff 48 89 df e8 5f 8c ff ff e9 cf fd ff ff <0f> 0b eb 95 49 3b 44 24 08 0f 85 22 ff ff ff e9 bb fd ff ff 48 8b
[  306.239256] RSP: 0018:ffffcf870411fa28 EFLAGS: 00010206
[  306.239258] RAX: 0000000000000001 RBX: 0000000000000100 RCX: 0000000000000000
[  306.239260] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffffffffc0cfaa7c
[  306.239262] RBP: ffffcf870411fab8 R08: ffff8b6f0b785e03 R09: 0000000000000002
[  306.239263] R10: ffff8b6f00055f90 R11: fffff607441a2bc0 R12: ffff8b6f3d650920
[  306.239264] R13: ffff8b6f3d65a050 R14: 0000000000000101 R15: 0000000000000000
[  306.239266] FS:  00007fdc08077880(0000) GS:ffff8b7089889000(0000) knlGS:0000000000000000
[  306.239268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  306.239269] CR2: 000055621dbd5668 CR3: 0000000104db9000 CR4: 00000000000406f0
[  306.239271] Call Trace:
[  306.239274]  <TASK>
[  306.239280]  ? rtw_usb_probe+0x30e/0xa5c [rtw88_usb 05dbc23485d8043e256d7ec95726de5e78824a02]
[  306.239287]  rtw_usb_probe+0x3eb/0xa5c [rtw88_usb 05dbc23485d8043e256d7ec95726de5e78824a02]
[  306.239293]  usb_probe_interface+0xe0/0x2c0
[  306.239298]  really_probe+0xde/0x340
[  306.239302]  ? pm_runtime_barrier+0x55/0x90
[  306.239306]  __driver_probe_device+0x78/0x140
[  306.239309]  driver_probe_device+0x1f/0xa0
[  306.239312]  ? __pfx___driver_attach+0x10/0x10
[  306.239314]  __driver_attach+0xcb/0x1e0
[  306.239317]  bus_for_each_dev+0x85/0xd0
[  306.239321]  bus_add_driver+0x10b/0x1f0
[  306.239323]  ? __pfx_rtw_8822bu_driver_init+0x10/0x10 [rtw88_8822bu f384b25320fa8a4c609f2ed21a5d2e35524ff4d6]
[  306.239328]  driver_register+0x75/0xe0
[  306.239331]  usb_register_driver+0x99/0x150
[  306.239335]  do_one_initcall+0x5b/0x300
[  306.239340]  do_init_module+0x62/0x250
[  306.239343]  ? init_module_from_file+0x8a/0xe0
[  306.239345]  init_module_from_file+0x8a/0xe0
[  306.239349]  idempotent_init_module+0x114/0x310
[  306.239352]  __x64_sys_finit_module+0x6d/0xd0
[  306.239354]  ? syscall_trace_enter+0x8d/0x1d0
[  306.239357]  do_syscall_64+0x81/0x970
[  306.239361]  ? do_syscall_64+0x81/0x970
[  306.239363]  ? do_user_addr_fault+0x21a/0x690
[  306.239367]  ? exc_page_fault+0x7e/0x1a0
[  306.239370]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  306.239373] RIP: 0033:0x7fdc0771872d
[  306.239385] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 f5 0e 00 f7 d8 64 89 01 48
[  306.239387] RSP: 002b:00007ffc626c36c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  306.239389] RAX: ffffffffffffffda RBX: 000055621dd98420 RCX: 00007fdc0771872d
[  306.239391] RDX: 0000000000000000 RSI: 00007fdc080912f2 RDI: 000000000000001c
[  306.239392] RBP: 00007ffc626c3760 R08: 0000000000000000 R09: 000055621de19b00
[  306.239393] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdc080912f2
[  306.239395] R13: 0000000000020000 R14: 000055621dbd1030 R15: 000055621dd98420
[  306.239397]  </TASK>
[  306.239399] ---[ end trace 0000000000000000 ]---
[  306.239419] rtw88_8822bu 3-2:1.2: failed to create RX work queue
[  306.239421] rtw88_8822bu 3-2:1.2: failed to init USB RX
[  306.245240] rtw88_8822bu 3-2:1.2: Firmware version 30.20.0, H2C version 14
[  306.245284] rtw88_8822bu 3-2:1.2: probe with driver rtw88_8822bu failed with error -12
[  306.245323] usbcore: registered new interface driver rtw88_8822bu

