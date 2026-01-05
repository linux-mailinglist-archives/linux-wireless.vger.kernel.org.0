Return-Path: <linux-wireless+bounces-30361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F201BCF4004
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F68D3176DC1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936C26FA77;
	Mon,  5 Jan 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GveqiL4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F252609FD;
	Mon,  5 Jan 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620677; cv=none; b=qwtYaU7TBAUxnLwj+kibrlc9QzGFkG0s7Z9wjL7szTnNKBpb4NhTSMxtCROopTb/9Lk7z2regMdFa1UzLs+OdKosH/UscsKYSksg2tl+khZ5SSDamWljG2NLWgHfn/D7yDmQ5XnAskjYtmT5vCzaDQW+JuZlZVD0lfjB/7ikD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620677; c=relaxed/simple;
	bh=/qLSH2nVdxybCzMA+7yHnK9i/q0BrWC5/kEpVTCA5f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7tkZWIlKK7Fbx3Jnf3hFY/HJzr8nT9ELBDMGyVDUs9q2FlUsfZuzI1OEee+/oKCr8ZJ6PIod8yQlL6Lg4oU9p84hAeI1Gi/dIPsePdEkDyghOMufHeaz/2KrTI8J3WEoft+4fysrlij7WWBXOldP9P+dprLBl3fLnR6lam8B+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GveqiL4i; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nCGKWrqTbf+V7zMbQXTrS8bdrbfkz6WTW7AhYSNd6N8=; t=1767620675;
	x=1768052675; b=GveqiL4iVWhh+Uyy/9iyig1rpkIXaSzgNLZLO2LKgNqQvTDSqAlH/8tTJmcKl
	OkJKvlm99Njtpxyyg3agGpW5WRilCB/4sg4koDYJOAJsTwlwCHVk1BzmiZlAB49iYEInUWgQTNeM4
	9tygOHdnnxim121HMGgwalo+vYdTZ1R9eZUG3R76SvLTwXXLTunBvtpxl5jeGjM4wgMwpzWN1jD6s
	FUBvPma9uClNCu3r6gdwnDbCjuoXgE+MX7IxEP3qzrFKFvcOSesJWYTqbwJU/zNor2NUrDId9cmpu
	YUUVYD+vLvAjjvAjOfYoHIBgeAP6Ay7Gvk4ZqvYiAUnV4Up+NQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vcksn-001d5i-0y;
	Mon, 05 Jan 2026 14:44:29 +0100
Message-ID: <6beab0bb-ed51-491a-bd64-15f3455ea628@leemhuis.info>
Date: Mon, 5 Jan 2026 14:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strnlen buffer overflow in mt76_connac2_load_patch - 6.19-rc2
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
Cc: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, regressions@lists.linux.dev
References: <aVBCFKub6vCFsFVB@mail-itl>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <aVBCFKub6vCFsFVB@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1767620675;641de9d2;
X-HE-SMSGID: 1vcksn-001d5i-0y

On 12/27/25 21:31, Marek Marczykowski-Górecki wrote:
> Hi,
> 
> After updating to 6.19-rc2 I'm hitting the following panic on boot. It
> worked in 6.18.2. It is a Xen HVM domU with PCI device attached, this
> one specifically:
> 
> 02:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz [14c3:0608]
>
> And the crash is:

This looks somewhat similar to a report from Shuah Khan and likely was
fixed with af7809f037e6e5 ("Revert "wifi: mt76: Strip whitespace from
build ddate"") in v6.19-rc4. Please let us known if that is not the case.

Ciao, Thorsten

>     ------------[ cut here ]------------
>     strnlen: detected buffer overflow: 17 byte read of buffer size 16
>     WARNING: lib/string_helpers.c:1035 at __fortify_report+0x4f/0x90, CPU#1: kworker/1:1/51
>     Modules linked in: mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 intel_rapl_msr intel_rapl_common mac80211 ghash_clmulni_intel cfg80211 rfkill ehci_pci libarc4 pcspkr ehci_hcd igc ata_generic i2c_piix4 pata_acpi i2c_smbus serio_raw xen_scsiback target_core_mod xen_netback xen_privcmd xen_gntdev xen_gntalloc xen_blkback xen_evtchn i2c_dev fuse loop nfnetlink overlay xen_blkfront
>     CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.19.0-0.rc2.1.qubes.1001.fc41.x86_64 #1 PREEMPT(full) 
>     Hardware name: Xen HVM domU, BIOS 4.19.4 12/21/2025
>     Workqueue: events mt7921_init_work [mt7921_common]
>     RIP: 0010:__fortify_report+0x4f/0x90
>     Code: 48 83 fb 11 73 34 40 84 ed 48 c7 c0 02 62 d4 86 48 c7 c1 0c 62 d4 86 48 8b 34 dd 40 3d 54 86 48 0f 44 c8 48 8d 3d e1 af a5 01 <67> 48 0f b9 3a 48 83 c4 10 5b 5d e9 1c fb 4d ff 48 89 34 24 48 c7
>     RSP: 0018:ffffd1b3801bbd38 EFLAGS: 00010246
>     RAX: ffffffff86d46202 RBX: 0000000000000001 RCX: ffffffff86d46202
>     RDX: 0000000000000011 RSI: ffffffff86d15c86 RDI: ffffffff8747f5c0
>     RBP: 0000000000000000 R08: 0000000000000010 R09: ffffd1b380389000
>     R10: ffffd1b3801bbc40 R11: 00000000ffffffff R12: 0000000000000000
>     R13: ffffd1b380389000 R14: 0000000000001000 R15: 0000000000000000
>     FS:  0000000000000000(0000) GS:ffff8d0ac8c52000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000076de8e89f001 CR3: 000000000f4bb000 CR4: 0000000000750ef0
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      ? request_firmware+0x3e/0x50
>      __fortify_panic+0xd/0xf
>      mt76_connac2_load_patch.cold+0x2b/0xe4 [mt76_connac_lib]
>      mt792x_load_firmware+0x36/0x150 [mt792x_lib]
>      mt7921_run_firmware+0x23/0xd0 [mt7921_common]
>      mt7921e_mcu_init+0x4c/0x7a [mt7921e]
>      mt7921_init_work+0x51/0x190 [mt7921_common]
>      process_one_work+0x18d/0x340
>      worker_thread+0x256/0x3a0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xfc/0x240
>      ? __pfx_kthread+0x10/0x10
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x126/0x190
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     ---[ end trace 0000000000000000 ]---
>     ------------[ cut here ]------------
>     kernel BUG at lib/string_helpers.c:1043!
>     Oops: invalid opcode: 0000 [#1] SMP NOPTI
>     CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Tainted: G        W           6.19.0-0.rc2.1.qubes.1001.fc41.x86_64 #1 PREEMPT(full) 
>     Tainted: [W]=WARN
>     Hardware name: Xen HVM domU, BIOS 4.19.4 12/21/2025
>     Workqueue: events mt7921_init_work [mt7921_common]
>     RIP: 0010:__fortify_panic+0xd/0xf
>     Code: 44 8b 14 24 e9 12 dc 9c 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 e3 f3 9c 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 16 5d d1 86
>     RSP: 0018:ffffd1b3801bbd60 EFLAGS: 00010286
>     RAX: ffffffff86d46202 RBX: 0000000000000000 RCX: ffffffff86d46202
>     RDX: 0000000000000011 RSI: ffffffff86d15c86 RDI: ffffffff8747f5c0
>     RBP: ffff8d0a4b752060 R08: 0000000000000010 R09: ffffd1b380389000
>     R10: ffffd1b3801bbc40 R11: 00000000ffffffff R12: 0000000000000000
>     R13: ffffd1b380389000 R14: 0000000000001000 R15: 0000000000000000
>     FS:  0000000000000000(0000) GS:ffff8d0ac8c52000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000076de8e89f001 CR3: 000000000f4bb000 CR4: 0000000000750ef0
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      mt76_connac2_load_patch.cold+0x2b/0xe4 [mt76_connac_lib]
>      mt792x_load_firmware+0x36/0x150 [mt792x_lib]
>      mt7921_run_firmware+0x23/0xd0 [mt7921_common]
>      mt7921e_mcu_init+0x4c/0x7a [mt7921e]
>      mt7921_init_work+0x51/0x190 [mt7921_common]
>      process_one_work+0x18d/0x340
>      worker_thread+0x256/0x3a0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xfc/0x240
>      ? __pfx_kthread+0x10/0x10
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x126/0x190
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     Modules linked in: mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 intel_rapl_msr intel_rapl_common mac80211 ghash_clmulni_intel cfg80211 rfkill ehci_pci libarc4 pcspkr ehci_hcd igc ata_generic i2c_piix4 pata_acpi i2c_smbus serio_raw xen_scsiback target_core_mod xen_netback xen_privcmd xen_gntdev xen_gntalloc xen_blkback xen_evtchn i2c_dev fuse loop nfnetlink overlay xen_blkfront
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:__fortify_panic+0xd/0xf
>     Code: 44 8b 14 24 e9 12 dc 9c 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 e3 f3 9c 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 16 5d d1 86
>     RSP: 0018:ffffd1b3801bbd60 EFLAGS: 00010286
>     RAX: ffffffff86d46202 RBX: 0000000000000000 RCX: ffffffff86d46202
>     RDX: 0000000000000011 RSI: ffffffff86d15c86 RDI: ffffffff8747f5c0
>     RBP: ffff8d0a4b752060 R08: 0000000000000010 R09: ffffd1b380389000
>     R10: ffffd1b3801bbc40 R11: 00000000ffffffff R12: 0000000000000000
>     R13: ffffd1b380389000 R14: 0000000000001000 R15: 0000000000000000
>     FS:  0000000000000000(0000) GS:ffff8d0ac8c52000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00006225eb492548 CR3: 000000000e1b3000 CR4: 0000000000750ef0
>     PKRU: 55555554
>     Kernel panic - not syncing: Fatal exception
>     Kernel Offset: 0x4c00000 from 0xffffffff80200000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 


