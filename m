Return-Path: <linux-wireless+bounces-17354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3CAA0A6CC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4403B7A1693
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC4322B;
	Sun, 12 Jan 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XND07NMU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314E3FF1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736644792; cv=none; b=ZC/1iPbsplPmZf7AHpwRU8yCiyfwuJw9VzZBJ7X9SCum20Xwn2xDtmvWbBQiTV+YtxHp0AkbVeVzbbv8LwoH9/gGIkni0rcLMMrGiYe22cZ1y466s1Le4DqcFZO8pJ97ATe6WQ/dGz3uHXrxeu2nVmMVfJVpWwMDdEn8rirYuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736644792; c=relaxed/simple;
	bh=aG0RQ3eq3MllEKSBJp7M7DnKtRWt4VcAPVtnZEy1eCA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=udwwKDwNY9f8pUuozdotxJwpHJEAD2gczcUOFYMFO+l0jZ++0C+TDSvaZtbb6KM+EXj7UppiYTpGNPNuXs5fVeR0p5+RLVGgAz24KsSBQpnmM49KnsD9L1hGodj9+jPsT/RIML/h39stvJOFk9UQ26+Z0CAIsI2WYfuVswKu1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XND07NMU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1JiOC21559360, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736644784; bh=aG0RQ3eq3MllEKSBJp7M7DnKtRWt4VcAPVtnZEy1eCA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=XND07NMUGUsCz+X9txFOlEssKhahn58KzOyfthXqYkllV5NZHajoy0H42O0WCu6Ek
	 O4Yb58NBKwViDnKHA5iZXZe86duy0ErbjNT5Qm23PqtfEJQRZVSVQFh/fI4SC/C5w6
	 9ETq293la64OQO3H1mwpY56gt48HQx50VNeTzGGalulEcAPzu9RSor+u/uYyHT+Rjq
	 LeFC+Vz11brAtooVSEBMQKCR4QJysqA5JciGz66Apy6pYiESwSgHXLAQEFZ6Es2gqK
	 cPmsxnwLVoaB9MwvYlXKZpEOctdUtqUtOskSHcTcCHotAYKYbDOlg/OUwLvc7qi/U+
	 3G0boTz6cw1Rg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1JiOC21559360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 09:19:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:19:45 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:19:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/3] wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
In-Reply-To: <20241231004811.8646-2-pkshih@realtek.com>
References: <20241231004811.8646-1-pkshih@realtek.com> <20241231004811.8646-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9a27d527-8415-43af-b0d7-8df9b64fae3b@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:19:44 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> When starting/proceeding MCC, it will abort an ongoing hw scan process.
> In the proceeding cases, it unexpectedly tries to abort a non-exist hw
> scan process. Then, a trace shown at the bottom will happen. This problem
> is caused by a previous commit which changed some call sequence inside
> rtw89_hw_scan_complete() to fix some coex problems. These changes lead
> to our scanning flag was not cleared when proceeding MCC. To keep the
> fixes on coex, and resolve the problem here, re-consider the related
> call sequence.
> 
> The known sequence requirements are listed below.
> 
> * the old sequence:
> 	A. notify coex
> 	B. clear scanning flag
> 	C. proceed chanctx
> 		C-1. set channel
> 		C-2. proceed MCC
> (the problem: A needs to be after C-1)
> 
> * the current sequence:
> 	C. proceed chanctx
> 		C-1. set channel
> 		C-2. proceed MCC
> 	A. notify coex
> 	B. clear scanning flag
> (the problem: C-2 needs to be after B)
> 
> So, now let hw scan caller pass a callback to proceed chanctx if needed.
> Then, the new sequence will be like the below.
> 	C-1. set channel
> 	A. notify coex
> 	B. clear scanning flag
> 	C-2. proceed MCC
> 
> The following is the kernel log for the problem in current sequence.
> 
> rtw89_8852be 0000:04:00.0: rtw89_hw_scan_offload failed ret -110
> ------------[ cut here ]------------
> [...]
> CPU: 2 PID: 3991 Comm: kworker/u16:0 Tainted: G           OE      6.6.17 #3
> Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB3WW (2.73 ) 11/28/2018
> Workqueue: events_unbound wiphy_work_cancel [cfg80211]
> RIP: 0010:ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
> Code: 9c 24 d0 11 00 00 49 39 dd 0f 85 46 ff ff ff 4c 89 e7 e8 09 2d
> RSP: 0018:ffffb27783643d48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8a2280964bc0 RSI: 0000000000000000 RDI: ffff8a23df580900
> RBP: ffffb27783643d88 R08: 0000000000000001 R09: 0000000000000400
> R10: 0000000000000000 R11: 0000000000008268 R12: ffff8a23df580900
> R13: ffff8a23df581b00 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8a258e680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f26a0654000 CR3: 000000002ea2e002 CR4: 00000000001706e0
> Call Trace:
>  <TASK>
>  ? show_regs+0x68/0x70
>  ? ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
>  ? __warn+0x8f/0x150
>  ? ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
>  ? report_bug+0x1f5/0x200
>  ? handle_bug+0x46/0x80
>  ? exc_invalid_op+0x19/0x70
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
>  ieee80211_scan_work+0x14a/0x650 [mac80211]
>  ? __queue_work+0x10f/0x410
>  wiphy_work_cancel+0x2fb/0x310 [cfg80211]
>  process_scheduled_works+0x9d/0x390
>  ? __pfx_worker_thread+0x10/0x10
>  worker_thread+0x15b/0x2d0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x108/0x140
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x3c/0x60
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: f16c40acd319 ("wifi: rtw89: Fix TX fail with A2DP after scanning")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

e47f0a589854 wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
e4790b3e314a wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
b2658bf4d7f2 wifi: rtw89: correct header conversion rule for MLO only

---
https://github.com/pkshih/rtw.git


