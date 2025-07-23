Return-Path: <linux-wireless+bounces-25948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95584B0F8BB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B427A8151
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC9212FB6;
	Wed, 23 Jul 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fo874kS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED01214A93;
	Wed, 23 Jul 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290824; cv=none; b=JDtcktm2WVrNN4myF24D4jzxErdr/lJc3syuQWxbJfdp2Qxp0wVPIYLgyvFi2qgT0BW17Bx8tUhH0fhx2+xDwxqwou3lpK0bQir2eXbYWX9PjpEme5Bp0CyfpTn/VevaKPS8YJ24VSIEG+Ta89OGtfG8i+RvPQY1ZXwcrMKtkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290824; c=relaxed/simple;
	bh=chBgQlbgRlbf+l6/ZMhS44Rv+J3P4E+2V49hJ5EHnfY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rqu0vV3OGiqnTFMmoBZqZdjKGyHQHZiIAvAf3Uk6UaAr71SzPsehlfqbtxpfTQHxlshdgpV9N645Gwbsde+WbtwEz0Zr1f0vYeNkN95ua9xW7nCa9k1JcfpJAqDv2Wg+evoczdwOmnwrDjRMZ5lT05aJIHa1trvR8lRiLFZDpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fo874kS6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q9OxbFP13nk1EYSIsUhyE6jGeMGkBWSQrOlnHroMkbM=;
	t=1753290823; x=1754500423; b=fo874kS6FJT0NmQYTbdaitsDHHgQZPvomLX+3kGKcLfZV7P
	YZreLI45fHDE0hWbouRlVcH9A3IVuxUtCtiTxnFDjaPULn3QBxJfiKgj464kUOr5OqYVmjh//dF7s
	RimPQy/kjwws23aTQkt0urp5MMp2i+qAebadkmQygZrOXWhfxCnwd13QGCVaL8LXD0afG4PsPjuPJ
	SC4QCONVretNcA+VwzcFlJLLFGVJOakLvtMG67XNgM/GssDb4ObKTCRutHodgCXztaPm+zf237Cws
	MVLeGaWEil0DaQs7AUA09P6XDP8fXtA/tLUdPLONkCab1Goya7JjdBRkLHZpTNwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ued1w-000000044Zp-3V63;
	Wed, 23 Jul 2025 19:13:25 +0200
Message-ID: <c5c06a93845f72b40c6df82fcbc89d3163a01d8b.camel@sipsolutions.net>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
 	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, 	x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, 	longman@redhat.com,
 miriam.rachel.korenblit@intel.com, 	linux-wireless@vger.kernel.org
Date: Wed, 23 Jul 2025 19:13:23 +0200
In-Reply-To: <aIEC4t2EICdgomZV@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
	 <aIEC4t2EICdgomZV@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2025-07-23 at 17:42 +0200, Pavel Machek wrote:
> [  402.125635] ------------[ cut here ]------------
> [  402.125638] raw_local_irq_restore() called with IRQs enabled
> [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug.c=
:10 warn_bogus_irq_restore+0x25/0x30
> [  402.125654] Modules linked in:
> [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S   =
               6.16.0-rc7+ #303 PREEMPT(voluntary)=20
> [  402.125667] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43=
 ) 10/12/2016
> [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
> [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc c=
c cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe <=
0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
> [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 000000000=
0000000
> [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000f=
fffffff
> [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 000000000=
0000001
> [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 000000000=
0000001
> [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 000000000=
0000000
> [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) knlG=
S:0000000000000000
> [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 000000000=
00606b0
> [  402.125713] Call Trace:
> [  402.125716]  <TASK>
> [  402.125719]  console_flush_all+0x41e/0x460
> [  402.125725]  ? console_flush_all+0x43/0x460
> [  402.125735]  console_unlock+0x55/0x100
> [  402.125741]  vprintk_emit+0x157/0x320
> [  402.125748]  vprintk_default+0x18/0x20
> [  402.125752]  vprintk+0x9/0x10
> [  402.125756]  _printk+0x52/0x70
> [  402.125766]  ieee80211_sta_rx_queued_mgmt+0x4c8/0xd30
> [  402.125775]  ? __this_cpu_preempt_check+0x13/0x20
> [  402.125784]  ieee80211_iface_work+0x3ad/0x500

That's not great, but I don't see how the driver or wifi subsystem is
involved ... ieee80211_sta_rx_queued_mgmt() doesn't even use spinlocks
let alone disable IRQs or use raw_ APIs, and it's in the middle of
printk anyway.

No idea what might be going on here, sorry.

johannes

