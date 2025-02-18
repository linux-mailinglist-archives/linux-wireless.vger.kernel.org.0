Return-Path: <linux-wireless+bounces-19091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6BA3913B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 04:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863967A28D1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6B14F9D9;
	Tue, 18 Feb 2025 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WSd066za"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF018E1F;
	Tue, 18 Feb 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848655; cv=none; b=U6Qeit+nQguhA/xA7UqrkzN6AkWEAjOHMmJ5glM8SpcipgVXTfZw8TknU27u6x2egIbNLuPK93QeiBveoFoKvIH1nXWY8Z1O1K6+rHq3uHR1G7AlEVnoCBjUuPerH6QSam6FVzcqeZ/T48NDWIfik1g9Gzim1Wszv1lYK2KGsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848655; c=relaxed/simple;
	bh=aFmUW0d4sp5tr+EdJMGQeGzCRESiHyC5Wx3xPEnRkFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KLDJciqF/u+T+UZCj/awOm2MZhY4wfiEY8RFcSr1Kp5CBi4orHIRKfBmxQFtLBHWBpbWYuZcmL9Lq0TTrpzwIXgEPo4z7EAzdAOqk0WuW/9mzeGAYmhjYw6H8lm8rtMGaPRBkSGVbqFo/mr6techbRpGnfxQa8FB1i0a1AKluDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WSd066za; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51I3GSzlC527690, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739848588; bh=aFmUW0d4sp5tr+EdJMGQeGzCRESiHyC5Wx3xPEnRkFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WSd066zagmC60Sy2MWmKuNHvpLJ7P87c36UZcrcbdOQuHHbm7D6atxLTiUZR4o+pQ
	 YmFaD21usj7RXtjZeQPWlXL2lyYh8RXbwYZK/dSqE16mxAm5ZiBwPQVSKXybaMy1S5
	 3GW6CONsnWpX++VQeaub0qKLLSLYMzWAoUEQYcQaWHtsrq4TLqcV46kEmKBNsb7P+X
	 VAaBBoV8PU3YLFa8cqMtjVFOpYC+yCKFvAsdCsCLlCcqUvrNdP5bk+40PQIFh9q98Q
	 L+Ma/DPWb94uMfp1kR25gnGiRRtdKULWM2jfyruzBZI3jlgqt7c1Kb9lTmEqKssNsc
	 hArhjVH0BLATQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51I3GSzlC527690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 11:16:28 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Feb 2025 11:16:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Feb 2025 11:16:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Tue, 18 Feb 2025 11:16:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Soul.Huang@mediatek.com"
	<Soul.Huang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "robin.chiu@mediatek.com"
	<robin.chiu@mediatek.com>,
        "ch.yeh@mediatek.com" <ch.yeh@mediatek.com>,
        "posh.sun@mediatek.com" <posh.sun@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        Salah Coronya <salah.coronya@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Nick Morrow <usbwifi2024@gmail.com>
Subject: RE: [net-next] wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
Thread-Topic: [net-next] wifi: mt76: mt7921: fix kernel panic due to null
 pointer dereference
Thread-Index: AQHbga+3/7sd6J5DkUS5CwfR13Sq97NMYpvA
Date: Tue, 18 Feb 2025 03:16:27 +0000
Message-ID: <f483e587211b44beb3be4b96135c5c88@realtek.com>
References: <20250218024849.1993192-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20250218024849.1993192-1-mingyen.hsieh@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> This patch addresses a kernel panic caused by a null pointer dereference =
in the

Imperative mood. Just "Address a kernel panic ..."

> `mt792x_rx_get_wcid` function. The issue arises because the `deflink` str=
ucture
> is not properly initialized with the `sta` context. This patch ensures th=
at the
> `deflink` structure is correctly linked to the `sta` context, preventing =
the
> null pointer dereference.
>=20
> [   32.098574] BUG: kernel NULL pointer dereference, address: 00000000000=
00400
> [   32.098620] #PF: supervisor read access in kernel mode
> [   32.098634] #PF: error_code(0x0000) - not-present page
> [   32.098647] PGD 0 P4D 0
> [   32.098665] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   32.098683] CPU: 0 UID: 0 PID: 470 Comm: mt76-usb-rx phy Not tainted 6=
.12.13-gentoo-dist #1
> [   32.098703] Hardware name:  /AMD HUDSON-M1, BIOS 4.6.4 11/15/2011
> [   32.098717] RIP: 0010:mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
> [   32.098776] RSP: 0018:ffffa147c055fd98 EFLAGS: 00010202
> [   32.098792] RAX: 0000000000000000 RBX: ffff8e9ecb652000 RCX: 000000000=
0000000
> [   32.098806] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8e9ec=
b652000
> [   32.098819] RBP: 0000000000000685 R08: ffff8e9ec6570000 R09: 000000000=
0000000
> [   32.098832] R10: ffff8e9ecd2ca000 R11: ffff8e9f22a217c0 R12: 000000003=
8010119
> [   32.098845] R13: 0000000080843801 R14: ffff8e9ec6570000 R15: ffff8e9ec=
b652000
> [   32.098860] FS:  0000000000000000(0000) GS:ffff8e9f22a00000(0000) knlG=
S:0000000000000000
> [   32.098876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.098889] CR2: 0000000000000400 CR3: 000000000d2ea000 CR4: 000000000=
00006f0
> [   32.098903] Call Trace:
> [   32.098918]  <TASK>
> [   32.098932]  ? __die_body.cold+0x19/0x27
> [   32.098955]  ? page_fault_oops+0x15a/0x2f0
> [   32.098975]  ? search_module_extables+0x19/0x60
> [   32.098995]  ? search_bpf_extables+0x5f/0x80
> [   32.099012]  ? exc_page_fault+0x7e/0x180
> [   32.099030]  ? asm_exc_page_fault+0x26/0x30
> [   32.099054]  ? mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
> [   32.099084]  mt7921_queue_rx_skb+0x1c6/0xaa0 [mt7921_common]
> [   32.099114]  mt76u_alloc_queues+0x784/0x810 [mt76_usb]
> [   32.099140]  ? __pfx___mt76_worker_fn+0x10/0x10 [mt76]
> [   32.099172]  __mt76_worker_fn+0x4f/0x80 [mt76]
> [   32.099203]  kthread+0xd2/0x100
> [   32.099221]  ? __pfx_kthread+0x10/0x10
> [   32.099237]  ret_from_fork+0x34/0x50
> [   32.099254]  ? __pfx_kthread+0x10/0x10
> [   32.099269]  ret_from_fork_asm+0x1a/0x30
> [   32.099290]  </TASK>
> [   32.099719] ---[ end trace 0000000000000000 ]---

No need boot time since they are useless to core trace.=20



