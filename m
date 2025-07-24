Return-Path: <linux-wireless+bounces-25984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37DB10508
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEEF5A4132
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B6B289E07;
	Thu, 24 Jul 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLaA8ZM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usWzCmUh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A02750E7;
	Thu, 24 Jul 2025 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347026; cv=none; b=Uly8p/cI7leb8BG7zll29PYxDZGanWyEvojGZWLVyf08irDLdyCOGbFIFiRiQ1t48CK/Mj4HL8l2NQYBrreeMtsf7JQwypFR4lLUHPSp+9gjGrBrgqtZiyr4D3FJppkgp8/UX1RI5SUfWNtwlwjaBTCsVjdMvskUcgtgJlV5iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347026; c=relaxed/simple;
	bh=rMCiDWZlZhzp4vH7m5lKEGnxv3jAJDZnNG7omR5jJG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UrSGd4FwMX7QOJn1exyMusZE+/ShaJPDfEvcvgzRIBz7o8P6PETjOpAtmmXIsb7ItjQV+0SvaHo8/hgWlCfpGx7CODtXh+NHzMzIjY0lJ+v9fH1frpuXUk5wzHBAs1eGRDoeAsRkS+MuuiXYl0BrLx4ER/rnogdQDwYoEFghAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLaA8ZM/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usWzCmUh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753347022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+E1TDUgu9PLKNREhzAxCjOD+hjF8nfiUP9ZkQD82Fo=;
	b=yLaA8ZM/l9Ah6R0ZMpNw4oFx63KoU/8IxvOwatJeQG7qXk/RGMzYVrVRl0tbvhmvekN1dQ
	udjIqL6iBVo5UvxeLbUHLIS1eEP47x1uyyyHK0uV98F7a291+Vn9GU9XktnEfGOVe+/37O
	T/jVTBjMNdyXvd+ddLr+e26Z77oYsSdx/tYQs1fH7O6jEIjZ3EEPKe6ueNuEBZPwI2oQ8y
	vJnEQ0oG+jT8irw2TzzDUSYdtgjpx4hNqlqQ9nxNOOXftvSKzgcuatzIMtniOON+tVMGpy
	AQnmQ2NyvYGm5WZ0ZTfyevoZ5Dy0GdNP4lRWDWh3k9eTza78GZ5KUK4tAQr49g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753347022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+E1TDUgu9PLKNREhzAxCjOD+hjF8nfiUP9ZkQD82Fo=;
	b=usWzCmUh1opW43mgXkThDgLDYbgkMk7Tx2WrVdQXeTxpB0lLEu3FZ2c02FrEL2hcl8+6vE
	r4Ffhs7Miq5wFLAg==
To: Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org, will@kernel.org,
 longman@redhat.com, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
 senozhatsky@chromium.org
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <aIFH9I6b/tebYcEL@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
 <c5c06a93845f72b40c6df82fcbc89d3163a01d8b.camel@sipsolutions.net>
 <aIFH9I6b/tebYcEL@duo.ucw.cz>
Date: Thu, 24 Jul 2025 10:56:22 +0206
Message-ID: <84h5z2vupd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-23, Pavel Machek <pavel@ucw.cz> wrote:
>> On Wed, 2025-07-23 at 17:42 +0200, Pavel Machek wrote:
>> > [  402.125635] ------------[ cut here ]------------
>> > [  402.125638] raw_local_irq_restore() called with IRQs enabled
>> > [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
>> > [  402.125654] Modules linked in:
>> > [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S                  6.16.0-rc7+ #303 PREEMPT(voluntary) 
>> > [  402.125667] Tainted: [S]=CPU_OUT_OF_SPEC
>> > [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
>> > [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
>> > [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
>> > [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
>> > [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
>> > [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000000000000
>> > [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
>> > [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000000000001
>> > [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000000000001
>> > [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000000000000
>> > [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) knlGS:0000000000000000
>> > [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 00000000000606b0
>> > [  402.125713] Call Trace:
>> > [  402.125716]  <TASK>
>> > [  402.125719]  console_flush_all+0x41e/0x460
>> > [  402.125725]  ? console_flush_all+0x43/0x460
>> > [  402.125735]  console_unlock+0x55/0x100
>> > [  402.125741]  vprintk_emit+0x157/0x320
>> > [  402.125748]  vprintk_default+0x18/0x20
>> > [  402.125752]  vprintk+0x9/0x10
>> > [  402.125756]  _printk+0x52/0x70
>> > [  402.125766]  ieee80211_sta_rx_queued_mgmt+0x4c8/0xd30
>> > [  402.125775]  ? __this_cpu_preempt_check+0x13/0x20
>> > [  402.125784]  ieee80211_iface_work+0x3ad/0x500
>> 
>> That's not great, but I don't see how the driver or wifi subsystem is
>> involved ... ieee80211_sta_rx_queued_mgmt() doesn't even use spinlocks
>> let alone disable IRQs or use raw_ APIs, and it's in the middle of
>> printk anyway.

printk() does perform local_irq_save()/_restore(). I rechecked all the
sites and they are properly balanced in all paths.

It looks like you may have found other issues related to corruption, so
I will assume printk is not the culprit. But please keep us CC or ping
us again if printk comes under suspicion again.

John Ogness

