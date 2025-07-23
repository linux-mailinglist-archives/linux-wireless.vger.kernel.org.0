Return-Path: <linux-wireless+bounces-25950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0006AB0F90A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 19:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581EB1CC1AF3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76001E8324;
	Wed, 23 Jul 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ph4CKk0i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eq1MRkfY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611361E5B63;
	Wed, 23 Jul 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291872; cv=none; b=JkwyzOCit4JHouY8yJ+kNqNh9DZ9Cu6uHoYUrm1m86pL4VVDMQJz7kCt4B+BPIVru1AFT0lXdYedjlk0JTeNpmCFtMZIcTh3hYOVy0FOfBwM04BCxyDjNZcngY9AmQhPrt8vQ0OPV05tHJgNgH7eLPPh332KkGZbzIfr/sUjq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291872; c=relaxed/simple;
	bh=gB6mc02MThDN+ss/j7RTqryh/ThCKpMysHTLjuhCBys=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OE2dXw7fTyVBzLKT3r56UkxcnIG2XySIzFA2DawlP3a8R9fd9/jTlDAIfVjOzcF2mlC9gb4hGJx/RUXvsJhB/5cnYPvZSiwwo3wNkO2I3i597ELXGS6EpDz7wed7/Vu8soczgKCCiot4ldbP0OkNJAGTAgxV6OJC7Om5VKhar1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ph4CKk0i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eq1MRkfY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753291869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5Wlf10EFx9evJWlio2CtIFozzMEXjSectACCukNWh8=;
	b=Ph4CKk0iro2EKHB19X3rR6Kz/sUeRpGO292jKrtnrqv22I+6DtHTezmBTjtyUS0JLEQFH3
	3sDi5fUy5yoYPZX5UR07QzUXyEuZxtkuRkNENLS3Hej2JBexNX08zpSTenBS4DGd9sFZWu
	mdD43UxXmbmtnSjil087bRIWHDIpypWp/6oKozg6bHfihiBXzhMGpnlel07cwpKfgjxxCH
	Nu4j3PbiFYTVYf0oPnvbOTh7xJFfthT2WeL7pGom7D6lkdSdbQKEBSv9/IWpbRm3kQdKx+
	R1UkFyo1H/Y3hy+sj/sKykunuKCyiSTpfTz71MrS8JrlYJCXoZ7E4F3HjgY0Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753291869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5Wlf10EFx9evJWlio2CtIFozzMEXjSectACCukNWh8=;
	b=Eq1MRkfYAXuCB7TwbMwJoy6HJZGEEVh3F6Jc58mNophfdHg/52RhXD1h6yQ7OzCdth4lJk
	1d7lUY+76Isx62Ag==
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org, will@kernel.org,
 longman@redhat.com, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <aIEC4t2EICdgomZV@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
Date: Wed, 23 Jul 2025 19:31:08 +0200
Message-ID: <874iv2stk3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23 2025 at 17:42, Pavel Machek wrote:
> Did kernel boot on console (w/o X), and got this: not sure if it is
> related.
> [  402.125635] ------------[ cut here ]------------
> [  402.125638] raw_local_irq_restore() called with IRQs enabled
> [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
> [  402.125654] Modules linked in:
> [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S                  6.16.0-rc7+ #303 PREEMPT(voluntary) 
> [  402.125667] Tainted: [S]=CPU_OUT_OF_SPEC
> [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
> [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
> [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
> [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000000000000
> [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
> [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000000000001
> [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000000000001
> [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000000000000
> [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) knlGS:0000000000000000
> [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 00000000000606b0
> [  402.125713] Call Trace:
> [  402.125716]  <TASK>
> [  402.125719]  console_flush_all+0x41e/0x460

Can you please decode this, so we can see which part of that code it is?


> [  402.125725]  ? console_flush_all+0x43/0x460
> [  402.125735]  console_unlock+0x55/0x100
> [  402.125741]  vprintk_emit+0x157/0x320
> [  402.125748]  vprintk_default+0x18/0x20
> [  402.125752]  vprintk+0x9/0x10
> [  402.125756]  _printk+0x52/0x70

Thanks,

        tglx

