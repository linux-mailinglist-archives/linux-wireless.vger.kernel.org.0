Return-Path: <linux-wireless+bounces-29725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A5CCBB0BD
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 16:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D812D301B83F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C9156CA;
	Sat, 13 Dec 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRsmWwv6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64262253958
	for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765638928; cv=none; b=sSnbnvgIOArexiXM78ZoX3N98l9p82UNqsI1dhHbNJNTAs6WW+mJawC6jenKFjT5bzRS6Fcd2UrKWviF8viYWP56eEgk12BTNBPofMzeWlfWFvCEeN7DUM0OgxIy8EM1ksQ8qVA1fE1JkUTFauliFQJNeIPNwCSes69ZjM17SGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765638928; c=relaxed/simple;
	bh=+JoscYnjmaOVpcwDx5/o+exRfaL7BLEdid4v4YXJ58I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ObiBwSaGZ2VAeOG0az6dxM2pbI89HLzuF3QWQCpq+CafNIgksMK93y2amMoQOIxfQwjX2D2XPxmPYg3zAcByjbrSJRfvMhnUzoRTobnAhvz8+W7bSNtHQ3rN1QRKp6Cy5h4bVYUSaKQpliDJypf9vXHzJV/H/meLgUYxoX/gvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRsmWwv6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso9539585e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765638924; x=1766243724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqTnIGZsNP302a02e6KO/MY6lLnS9+h0KLEwbbDvoyc=;
        b=lRsmWwv68xAeQzooyyJ0CnvJkT1WDvjba4hRwHo8kuTZ9naCPJU7rTrVShmO3CBQBI
         afqTrjQzRynaj8aAehPp+ZR7NRgRXNkKZqEoQ9IkKZr6gEAWKMgA/slMBKJWnfo9WaJ/
         lqbKAXtGdNGveSKBQm7JxIVdTpdMTCFQzyNlHbfv88trwlQ6GhKrqqF3ke31TzCdZUG2
         xodEcjTKvjXYO7iFPGztzvftrAF8Pm2SVOn8MG/jQUnHYggAeVzqH2d4RY24QdBqNyUt
         54BfhZZSI6Cfld4QyvXC7M6d7EE74Gwqr6ysJ7GJoUaEjfIRcdX3qRhLlNH4Cf9+QQIA
         6TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765638924; x=1766243724;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqTnIGZsNP302a02e6KO/MY6lLnS9+h0KLEwbbDvoyc=;
        b=MvY74IU3Sbar/OsmjLUY3qWKfU/9CPnxZcMCOFsIilkWMc6LTRDEFfdhwhtDmI53gT
         RzOlW71fec8Og4dJaHS9y6Sisy9jI1W/LUSOwGHo1EDDTSaM3+yinUDy8vHH77vf9XrW
         sMrR9Do3Cok9CVtmpPXOrxQ5PYC6k1RQO8F0SesVIvFdIHeKNTFFTi+mPNE9WUK7Abd6
         21NAL39NzXd7eb3kKTtkUxP+SYFVb1PDtB4RIMA4d+Di6uF5oJFtUemiY5Y2HjLk/rCJ
         isECgx5C7OomqjfrBcZeNyeA38EcnCi6rekkzv+KAGAAy3879BLK5+HO0iAYpKV570XK
         MKoA==
X-Gm-Message-State: AOJu0YznAXIZLu92qsrUHs9Q1vEhXLkytnzqK7GZ/X8+JEL79oxg4dXE
	OhiI29mklZ290W+vbz1q5sbj+EeAx/vP+rWY1Al17Moz1DliKpdIoM0Mgt1fwBxcCNjYoA==
X-Gm-Gg: AY/fxX403w8h53Sz2wHlPrPkT+My9vE8dClgkf2Rl/UZOK6Wz2yPyX83YV8iHGw8SQP
	hzJioUPxja3LUfN6hn6SjHLM4hETBMRorrs2F5lje4TkKeYfjTa3YO6ozPo6JY43qDtd7i1LAf0
	PbI1t5Ntjvn3PvBbEIbcqsh3zIt6W5Mgte9KUeQ/vIIrvg6zsf0TQ8fx+B/JFpcENyT1TkULi8E
	wvJ+n8G1+B13EV7xusyGjWj2sCoWVyEYMng0oANEmrTggpuZwisxtTsrv62eidceDnxZ70k50bz
	0+qMTPwd9bDXbS1Ty7OyYKp/AjxHdMpuke/ayhd6gQ6w4osd6/nCuM77eoPonHZJYnLRik9spvT
	JgIzW/0JgShkGIzETeEJilX+ONUVmOXHyaEkBMTcwAwPaCv9sVamhhSPMhpuFccdeNtVvplEQWw
	ePYDL3o1V3Cqafsa49spO185U=
X-Google-Smtp-Source: AGHT+IHLnAAtltk9sOZU5Ea6Tf3qNxbAJLKdhU9YCBRT/PgXVmBe5hucUrNXPxFR4vh6IHW9fHdzxg==
X-Received: by 2002:a05:600c:4f84:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47a8f8a7f7amr61022675e9.6.1765638924079;
        Sat, 13 Dec 2025 07:15:24 -0800 (PST)
Received: from debian.local ([2a0a:ef40:e94:5d01:d764:93db:53c4:a92b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a957de489sm53477545e9.5.2025.12.13.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 07:15:23 -0800 (PST)
Date: Sat, 13 Dec 2025 15:15:21 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
	Avraham Stern <avraham.stern@intel.com>
Subject: iwlwifi: WARNING at iwl_mvm_ptp_init / ptp_clock_register
Message-ID: <aT2DCbFNfTWXYXvi@debian.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A new warning has recently appeared due to commit:

commit dfb073d32cac28cdb597d16d1e0589b25c841661
Author: Tim Hostetler <thostet@google.com>
Date:   Tue Nov 4 14:59:15 2025 -0800

    ptp: Return -EINVAL on ptp_clock_register if required ops are NULL

    ptp_clock should never be registered unless it stubs one of gettimex64()
    or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
    of function pointers is null.

    For consistency, n_alarm validation is also folded into the
    WARN_ON_ONCE.


Log:

[   18.420114] ------------[ cut here ]------------
[   18.420121] WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0=
x129/0x7f0, CPU#14: NetworkManager/1568
[   18.420127] Modules linked in: qrtr rfcomm cmac algif_hash algif_skciphe=
r af_alg bnep binfmt_misc ext4 mbcache jbd2 nls_ascii nls_cp437 vfat fat iw=
lmvm snd_hda_codec_generic snd_hda_codec_hdmi intel_rapl_msr amd_atl mac802=
11 intel_rapl_common snd_hda_intel libarc4 btusb uvcvideo snd_hda_codec btr=
tl videobuf2_vmalloc btintel snd_intel_dspcfg videobuf2_memops btbcm snd_hw=
dep kvm_amd uvc btmtk videobuf2_v4l2 iwlwifi snd_hda_core snd_hda_scodec_cs=
35l41_i2c bluetooth videodev snd_pcm kvm snd_hda_scodec_cs35l41 cfg80211 sn=
d_soc_cs_amp_lib videobuf2_common snd_timer cs_dsp ideapad_laptop irqbypass=
 ecdh_generic ecc sparse_keymap rapl mc wmi_bmof platform_profile ee1004 sn=
d_soc_cs35l41_lib pcspkr snd k10temp ccp battery rfkill sg soundcore cm3218=
1 industrialio serial_multi_instantiate ac joydev evdev msr parport_pc ppde=
v lp parport nvme_fabrics fuse efi_pstore configfs nfnetlink efivarfs autof=
s4 crc32c_cryptoapi btrfs blake2b libblake2b xor raid6_pq dm_crypt sd_mod u=
as usbhid usb_storage amdgpu nouveau drm_gpuvm mxm_wmi
[   18.420214]  drm_client_lib i2c_algo_bit sp5100_tco dm_mod drm_suballoc_=
helper drm_ttm_helper drm_buddy ahci i2c_piix4 ttm drm_panel_backlight_quir=
ks drm_exec libahci gpu_sched amdxcp r8169 ucsi_acpi libata hid_multitouch =
drm_display_helper typec_ucsi realtek hid_generic scsi_mod drm_kms_helper r=
oles xhci_pci wdat_wdt mdio_devres xhci_hcd typec video nvme ghash_clmulni_=
intel cec serio_raw scsi_common watchdog i2c_hid_acpi crc16 i2c_smbus libph=
y usbcore thunderbolt mdio_bus nvme_core rc_core i2c_hid usb_common hid wmi=
 drm button aesni_intel
[   18.420260] CPU: 14 UID: 0 PID: 1568 Comm: NetworkManager Not tainted 6.=
18.0-12692-gcb015814f8b6 #224 PREEMPT(voluntary)
[   18.420262] Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/16/=
2024
[   18.420264] RIP: 0010:ptp_clock_register+0x129/0x7f0
[   18.420267] Code: c7 40 76 a8 87 41 89 c4 e8 e4 ff 32 00 45 85 e4 74 4c =
49 63 ec 4c 89 ff e8 a4 88 a2 ff eb 14 48 83 7f 78 00 0f 85 41 ff ff ff <0f=
> 0b 48 c7 c5 ea ff ff ff 48 8b 84 24 88 00 00 00 65 48 2b 05 4e
[   18.420268] RSP: 0018:ffffb84b805473f0 EFLAGS: 00010246
[   18.420271] RAX: 0000000000000000 RBX: ffff9e8e49625de8 RCX: ffffb84b805=
47404
[   18.420272] RDX: 0000000000000003 RSI: ffff9e8e42cc30c8 RDI: ffff9e8e496=
25de8
[   18.420273] RBP: ffff9e8e42cc30c8 R08: 0000000000000001 R09: ffffffff878=
0d200
[   18.420274] R10: 000000000000092c R11: 0000000000000003 R12: ffff9e8e496=
230e8
[   18.420276] R13: 000000000f700000 R14: ffff9e8e496230e8 R15: ffff9e8e496=
23118
[   18.420277] FS:  00007f7cfe3d3580(0000) GS:ffff9e94c9e82000(0000) knlGS:=
0000000000000000
[   18.420278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.420280] CR2: 00000000169d40c8 CR3: 000000010f5e1000 CR4: 00000000007=
50ef0
[   18.420281] PKRU: 55555554
[   18.420282] Call Trace:
[   18.420284]  <TASK>
[   18.420285]  ? lock_release+0x17b/0x2a0
[   18.420291]  ? queue_work_node+0x150/0x150
[   18.420294]  ? is_module_address+0x6a/0xf0
[   18.420297]  ? static_obj+0x67/0x90
[   18.420299]  ? lockdep_init_map_type+0x58/0x240
[   18.420304]  iwl_mvm_ptp_init+0x102/0x150 [iwlmvm]
[   18.420315]  iwl_mvm_up+0x874/0x910 [iwlmvm]
[   18.420323]  ? __mutex_lock+0x288/0x1090
[   18.420329]  ? lock_is_held_type+0xd5/0x130
[   18.420333]  __iwl_mvm_mac_start+0x82/0x2c0 [iwlmvm]
[   18.420341]  iwl_mvm_mac_start+0x4b/0xe0 [iwlmvm]
[   18.420348]  drv_start+0x6f/0x1a0 [mac80211]
[   18.420378]  ieee80211_do_open+0x2d3/0x920 [mac80211]
[   18.420403]  ieee80211_open+0x8a/0x90 [mac80211]
[   18.420422]  __dev_open+0x118/0x270
[   18.420427]  __dev_change_flags+0x21a/0x250
[   18.420432]  netif_change_flags+0x22/0x60
[   18.420435]  do_setlink.isra.0+0x34f/0x1190
[   18.420438]  ? lock_acquire+0xe1/0x2d0
[   18.420443]  ? rcu_is_watching+0xd/0x40
[   18.420446]  ? __mutex_lock+0x288/0x1090
[   18.420447]  ? __nla_validate_parse+0x5e/0xb60
[   18.420451]  ? rtnl_newlink+0x381/0xb90
[   18.420458]  rtnl_newlink+0x853/0xb90
[   18.420463]  ? __lock_acquire+0x459/0x2170
[   18.420470]  ? find_held_lock+0x2b/0x80
[   18.420472]  ? rtnetlink_rcv_msg+0x3e6/0x660
[   18.420474]  ? rtnetlink_rcv_msg+0x3e6/0x660
[   18.420477]  ? lock_release+0x17b/0x2a0
[   18.420479]  ? do_setlink.isra.0+0x1190/0x1190
[   18.420482]  rtnetlink_rcv_msg+0x405/0x660
[   18.420488]  ? rtnl_fdb_dump+0x230/0x230
[   18.420491]  netlink_rcv_skb+0x4b/0xf0
[   18.420499]  netlink_unicast+0x1f5/0x2d0
[   18.420501]  ? __virt_addr_valid+0x112/0x2e0
[   18.420506]  netlink_sendmsg+0x216/0x450
[   18.420511]  __sock_sendmsg+0x38/0x70
[   18.420515]  ____sys_sendmsg+0x23f/0x290
[   18.420517]  ? import_iovec+0x2b/0x30
[   18.420522]  ___sys_sendmsg+0x99/0xe0
[   18.420534]  ? __fget_files+0xc3/0x180
[   18.420538]  __sys_sendmsg+0x84/0xe0
[   18.420546]  do_syscall_64+0x95/0x7d0
[   18.420548]  ? do_syscall_64+0x1dc/0x7d0
[   18.420550]  ? fput+0x3b/0x90
[   18.420553]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   18.420555]  ? lockdep_hardirqs_on+0x78/0x100
[   18.420558]  ? do_syscall_64+0x1dc/0x7d0
[   18.420560]  ? lockdep_hardirqs_on_prepare+0xce/0x190
[   18.420562]  ? irqentry_exit+0xec/0x660
[   18.420566]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   18.420567] RIP: 0033:0x7f7cff6a49ee
[   18.420570] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[   18.420571] RSP: 002b:00007ffc0321c9b8 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   18.420574] RAX: ffffffffffffffda RBX: 00007f7cfe3d3580 RCX: 00007f7cff6=
a49ee
[   18.420575] RDX: 0000000000000000 RSI: 00007ffc0321ca40 RDI: 00000000000=
0000d
[   18.420576] RBP: 00007ffc0321ca40 R08: 0000000000000000 R09: 00000000000=
00000
[   18.420577] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
0001a
[   18.420578] R13: 00007ffc0321cc38 R14: 00007ffc0321cc2c R15: 00000000000=
00000
[   18.420586]  </TASK>
[   18.420587] irq event stamp: 112525
[   18.420588] hardirqs last  enabled at (112531): [<ffffffff8659c93e>] __u=
p_console_sem+0x5e/0x70
[   18.420591] hardirqs last disabled at (112536): [<ffffffff8659c923>] __u=
p_console_sem+0x43/0x70
[   18.420593] softirqs last  enabled at (111048): [<ffffffff86e5abba>] __a=
lloc_skb+0x18a/0x1f0
[   18.420595] softirqs last disabled at (111046): [<ffffffff86e5abba>] __a=
lloc_skb+0x18a/0x1f0
[   18.420597] ---[ end trace 0000000000000000 ]---

