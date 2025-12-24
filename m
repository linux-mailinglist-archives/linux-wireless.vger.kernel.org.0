Return-Path: <linux-wireless+bounces-30101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF5CDC024
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 11:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 552F33008E8A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1633128BD;
	Wed, 24 Dec 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b="nOO+JReS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.schwarzvogel.de (skade.schwarzvogel.de [157.90.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC02306D3F
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572447; cv=none; b=KihDwU2EiJz7tsg1CvEmMn6qZoR9qIG3v7r7iF9UVUgScdRDN3n4/Q6E16VdKgaDtKZ7XFxVNPRACHirn1tlTL8fJXTqLccbU6ZCTdIabA3GSxjCZmmYftbkzuw6au7jRC7Vs84rlykTe54qMkMYYxebyUKyrIUSH+JmcRbt1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572447; c=relaxed/simple;
	bh=17zf5aDgQQ+aGMV7LAlwmcugsyvGS4MS9lMVzazExfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=clV+XKm10qi2/S44HTJPChggSary4UeSg1F9elDJ5EpzfoHoB2g1TRM62qzMZDmXJANwY4YPggsPyNDM/SwAuXRPMuKMLAtJvnB5horxS7diozDYYOQbrzhOpllK2kPsPUkf4gbZyJyGBNtaiAgfEI3GlWKPpdakm3eMOmuh8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schwarzvogel.de; spf=pass smtp.mailfrom=schwarzvogel.de; dkim=pass (2048-bit key) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b=nOO+JReS; arc=none smtp.client-ip=157.90.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schwarzvogel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schwarzvogel.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=schwarzvogel.de; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:In-Reply-To:References;
	bh=+JCcm7PnONJPV/mvLVTgAEVF587x+4gXT+3gHRovHiA=; b=nOO+JReSVXggrxoWnzMkkh19ay
	QDrWK73OoAVHIXIHmlH4R4vLLr0cOUU7PDLDVJsCw4+YXpDCVy/61iSsuLF51/6AsBVvTiDKBxh5k
	YtKs+IjejOPQMHkIuZebhEgezG7dFucPT+dYUuKP37LHidi4so7XqZqeZXsdONQBASx2GP+09Rw7c
	gVmF6ZLS9Hmw3tYpDKvyXKyIGIBwHi6vg9H8vfV96EXTkRTWFb5NnhdGYnKRk7x5cCzo3HIValIDp
	lDuqt/L4saW3vOjhpSjOQKqambsbDbHnfHA/t33gm8grDQnS4D9IgKLwQo+7MZKGQPYRbrOAVqwYj
	X83ZDotw==;
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.99.1)
	(envelope-from <klausman@schwarzvogel.de>)
	id 1vYLpF-000000004Dy-1Z43;
	Wed, 24 Dec 2025 11:10:37 +0100
Date: Wed, 24 Dec 2025 11:10:37 +0100
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: linux-wireless@vger.kernel.org
Cc: Mario Limonciello <superm1@kernel.org>, Felix Fietkau <nbd@nbd.name>
Subject: Regression: "wifi: mt76: Strip whitespace from build ddate" causes
 "strnlen: detected buffer overflow: 17 byte read of buffer size 16"
Message-ID: <b4b1190f-1326-4aaf-b9b3-ac49ee0ae11e@skade.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The commit in question is f804a5895ebad2b2d4fb8a3688d2115926e993d5

It results (for my hardware) in a kernel warning:

[Dec23 20:51] usb 1-12: new high-speed USB device number 3 using xhci_hcd
[  +0.227037] usb 1-12: New USB device found, idVendor=3574, idProduct=6211, bcdDevice= 1.00
[  +0.000007] usb 1-12: New USB device strings: Mfr=2, Product=3, SerialNumber=4
[  +0.000002] usb 1-12: Product: Wireless_Device
[  +0.000002] usb 1-12: Manufacturer: MediaTek Inc.
[  +0.000002] usb 1-12: SerialNumber: 000000000
[  +0.061674] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  +0.000100] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  +0.000091] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[  +0.000467] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
[  +0.209516] usb 1-12: reset high-speed USB device number 3 using xhci_hcd
[  +0.468251] usbcore: registered new interface driver mt7921u
[  +0.015776] ------------[ cut here ]------------
[  +0.000003] strnlen: detected buffer overflow: 17 byte read of buffer size 16
[  +0.000002] WARNING: lib/string_helpers.c:1035 at __fortify_report+0x41/0x50, CPU#5: kworker/5:0/43
[  +0.000006] Modules linked in: mt7921u mt7921_common mt792x_usb mt76_usb mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_tcpudp nfsv3 nfs netfs xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp llc xt_addrtype nft_compat x_tables nf_tables binfmt_misc nls_ascii nls_cp437 vfat fat ext4 mbcache jbd2 snd_usb_audio snd_hwdep snd_usbmidi_lib snd_rawmidi kvm_amd snd_pcm snd_timer kvm snd soundcore joydev wmi_bmof mc irqbypass k10temp sg evdev button nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc nct6775 nct6775_core i2c_dev msr hwmon_vid efi_pstore configfs nfnetlink efivarfs autofs4 hid_generic usbhid hid dm_crypt dm_mod xhci_pci sd_mod xhci_hcd ghash_clmulni_intel usbcore gpio_amdpt usb_common i2c_piix4 gpio_generic i2c_smbus aesni_intel
[  +0.000072] CPU: 5 UID: 0 PID: 43 Comm: kworker/5:0 Not tainted 6.19.0-rc2 #108 PREEMPT
[  +0.000003] Hardware name: ASUS System Product Name/PRIME X870-P WIFI, BIOS 1087 09/19/2025
[  +0.000001] Workqueue: events mt7921_init_work [mt7921_common]
[  +0.000007] RIP: 0010:__fortify_report+0x44/0x50
[  +0.000003] Code: 14 3e b8 48 39 d0 48 0f 47 c2 83 e7 01 48 8b 34 c5 00 25 c8 b7 48 c7 c0 9e f6 3d b8 48 0f 44 c8 48 8d 3d 0f 69 8f 01 4c 89 ca <67> 48 0f b9 3a e9 cd 96 7e ff 66 90 90 90 90 90 90 90 90 90 90 90
[  +0.000002] RSP: 0018:ffffc15a002e7d10 EFLAGS: 00010246
[  +0.000002] RAX: ffffffffb83df69e RBX: 0000000000000000 RCX: ffffffffb83df69e
[  +0.000002] RDX: 0000000000000011 RSI: ffffffffb83aa156 RDI: ffffffffb8811340
[  +0.000001] RBP: ffff9e365d891e40 R08: 0000000000000010 R09: 0000000000000011
[  +0.000002] R10: ffff9e3649e10000 R11: ffff9e36400cd200 R12: ffff9e365d891e40
[  +0.000001] R13: 0000000000001000 R14: ffffc15a07419000 R15: ffff9e3640078800
[  +0.000001] FS:  0000000000000000(0000) GS:ffff9e45c4c68000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00005618939ca008 CR3: 0000000194a66000 CR4: 0000000000750ef0
[  +0.000001] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000002]  <TASK>
[  +0.000002]  __fortify_panic+0xd/0xf
[  +0.000004]  mt76_connac2_load_patch.cold+0x2b/0xcc1 [mt76_connac_lib]
[  +0.000008]  mt792x_load_firmware+0x34/0x160 [mt792x_lib]
[  +0.000004]  mt7921_run_firmware+0x27/0x4b0 [mt7921_common]
[  +0.000004]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000003]  ? ___mt76u_wr+0x2e/0x40 [mt76_usb]
[  +0.000003]  mt7921u_mcu_init+0x38/0x70 [mt7921u]
[  +0.000003]  mt7921_init_work+0x4d/0x1b0 [mt7921_common]
[  +0.000004]  process_one_work+0x185/0x280
[  +0.000004]  worker_thread+0x244/0x370
[  +0.000003]  ? __pfx_worker_thread+0x10/0x10
[  +0.000002]  kthread+0xe9/0x230
[  +0.000003]  ? __pfx_kthread+0x10/0x10
[  +0.000003]  ? __pfx_kthread+0x10/0x10
[  +0.000003]  ret_from_fork+0x20d/0x260
[  +0.000002]  ? __pfx_kthread+0x10/0x10
[  +0.000003]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork_asm+0x1a/0x30
[  +0.000006]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---
[  +0.000006] ------------[ cut here ]------------

The module probably still works probably, though I have not tested it.

Reverting the commit on top of 19-rc2 makes the warning disappear (and
the extra \n re-appear).

Here's a hexdump of the normal (non-edited) message I get when the
hardware is initialized:

00000000: 5b31 3730 3536 2e30 3236 3430 305d 206d  [17056.026400] m
00000010: 7437 3932 3175 2038 2d31 3a31 2e30 3a20  t7921u 8-1:1.0:
00000020: 4857 2f53 5720 5665 7273 696f 6e3a 2030  HW/SW Version: 0
00000030: 7838 6131 3038 6131 302c 2042 7569 6c64  x8a108a10, Build
00000040: 2054 696d 653a 2032 3032 3530 3632 3531   Time: 202506251
00000050: 3533 3632 3061 0a0a 5b31 3730 3536 2e32  53620a..[17056.2
00000060: 3933 3939 365d 206d 7437 3932 3175 2038  93996] mt7921u 8
00000070: 2d31 3a31 2e30 3a20 574d 2046 6972 6d77  -1:1.0: WM Firmw
00000080: 6172 6520 5665 7273 696f 6e3a 205f 5f5f  are Version: ___
00000090: 5f30 3130 3030 302c 2042 7569 6c64 2054  _010000, Build T
000000a0: 696d 653a 2032 3032 3530 3632 3531 3533  ime: 20250625153
000000b0: 3730 330a                                703.

Note the double 0a at offset 0x56/0x57.

According to the original commit, the message the author sees is:

mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 20250721232852a

mine is:

mt7921u 8-1:1.0: HW/SW Version: 0x8a108a10, Build Time: 20250625153620a

Aside from the bus mentioned, they don't seem to differ in length, so I
am unsure what is going on.

If more info/testing is needed, I am willing to help of course, but I am
not subscribe to linux-wireless, so please CC me on replies. 

Thanks!

Best,
Tobias

