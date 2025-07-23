Return-Path: <linux-wireless+bounces-25951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244CFB0F910
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E8B586A73
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A91E8324;
	Wed, 23 Jul 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="283Y2w6T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+Iu6Qlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C42E36ED;
	Wed, 23 Jul 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291933; cv=none; b=RlYg0hFGQOl2hqicP0xfKwhP+O9TV02ZfyKANGDETEiUtpd/8o/xqsvGZ0CwaIo+MVmSOuiJ7HL7HIpvd2lMzi8lshdB+KEbF2Nc7S/O9/eLm4O2qYdT6rAj+SucHOIr/k09tLzk/j7zS/d60vJI7knirJ0yGHwpy2hJ08WYkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291933; c=relaxed/simple;
	bh=6T+yLt42uti7IWOhD7bE/hFNZutVbs/mcKuze5Yxc28=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiGpWyG9SuhaQLookxf0qFOw79645Lc5263e9G87RdBNicn/8XSmU2VYYznMvHjXJGzI17cigOtCq00V1xkTIHaoEaKb8nlrKNTLcytuHaiYexKLnwfv74mUMa9tCXjpgTbuH3GVsaRs0/xQZ56HQypzZjf6JrGqxKk6G+dl1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=283Y2w6T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+Iu6Qlo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753291930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=roEbiwVRN1x+8BoOVphnq8EWb3dguheVx61ciYVirrg=;
	b=283Y2w6TxcXsYJMsjLmDtsGNGYAPa1hoSGLCghmKzvMRq2Hk+OVQGeezDgBxYUVkjSBr/l
	Rwm2ME4b6mTQZ3axOTUextHjzLH0nFxtIz/8uZxy8GCzB8Q5aHI8Jp62j6w+Fd7y0Esw8e
	/NKeZS8tAKA6SoPrZteFbzXHATytsgKfA/essQNG5kKLwszCYHP7dufPcb4LVpMABflMt+
	KGui+VarIKbtEI+DVS2WQiel357uQY44JV571bENzqDwbeq5dv+/rM89c7kAC2+acqYtMr
	U+pKeaRwKyOgpLVTnR8r9Dxue7qp00qZelammIOxLsS7GyYnJxEmCu71lIOHZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753291930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=roEbiwVRN1x+8BoOVphnq8EWb3dguheVx61ciYVirrg=;
	b=v+Iu6QloG86D4EolhQ1vTRHEukeY4Hago3tkmlSFacGEf4sQ86gm4gXeZgJxf+CX3DMPWj
	3clEuM512URInSCg==
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org, will@kernel.org,
 longman@redhat.com, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <874iv2stk3.ffs@tglx>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx>
Date: Wed, 23 Jul 2025 19:32:10 +0200
Message-ID: <87zfcurexx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23 2025 at 19:31, Thomas Gleixner wrote:
> On Wed, Jul 23 2025 at 17:42, Pavel Machek wrote:
>> Did kernel boot on console (w/o X), and got this: not sure if it is
>> related.
>> [  402.125635] ------------[ cut here ]------------
>> [  402.125638] raw_local_irq_restore() called with IRQs enabled
>> [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
>> [  402.125654] Modules linked in:
>> [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S                  6.16.0-rc7+ #303 PREEMPT(voluntary) 
>> [  402.125667] Tainted: [S]=CPU_OUT_OF_SPEC
>> [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
>> [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
>> [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
>> [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
>> [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
>> [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000000000000
>> [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
>> [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000000000001
>> [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000000000001
>> [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000000000000
>> [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) knlGS:0000000000000000
>> [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 00000000000606b0
>> [  402.125713] Call Trace:
>> [  402.125716]  <TASK>
>> [  402.125719]  console_flush_all+0x41e/0x460
>
> Can you please decode this, so we can see which part of that code it is?

And enable lockdep so that we can see where the interrupts were enabled?

Thanks,

         tglx

