Return-Path: <linux-wireless+bounces-26022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99DB120C5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19FA3AD162
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3C1A840A;
	Fri, 25 Jul 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZXJqSVU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D66vXu2V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991C1B3935;
	Fri, 25 Jul 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457042; cv=none; b=S6BHMXmzeVlZn66ACDyn8CM1um9G5U5S14+NYOHmJLDnSpuN2Qy3tc9DT+Ht4BnsFGipj4VeHS1BJvPXKvOnluhQ50mr+QzxXYz1DP6hy4kEpwQ8ZRC7mjs8fAsPmYqXCmzdKTlWD+vHtU8+tT/qorW3HUNL791QzBbNsSaua48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457042; c=relaxed/simple;
	bh=cJFU6jOYUc17uE+N/ES9iSQARpEgOPMQRhzgJpU7CT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmS1Yvw9Gs4FZRcuLrnoezLrdyGE2Rccs09OH4+jiW9SvFhoG348Inj4tDKLfj37PAgJ1/TOLwDL6hK/Zm9hbONMC7rX3hf++qOa0XTukak80y+E4k9SeTcOxCCwHU7tb4HU5ILr+wYhkeoqi6bLaMdAZGduTo3RldgLz/NLlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZXJqSVU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D66vXu2V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753457038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4lgC9NmRKNeaBQPMcoCW1/ucdzcGe8uTJ4NlyutYKc=;
	b=vZXJqSVUZfM1pX/rwmeRLGnrktS3wxy0JvFCpRnVFt7Cdu6U6O/Rjo+BwZoksVp9h8Bea9
	bxhVW9EnhK2g4hitBX+CdKmErhbcVZRl0jH200eaFLqpXWD7ZF+eWxljZbBunyqjNiHI9L
	mWFWqRjMYMatfvlQtsVPgQsKbEV953Gf4baRiL7BydhCT/YJStdJWzt0tNTKxCr/X0kV5+
	hqGbEhGoB+EzckhQrRDgUgktxSsz4kg6CycPJMZB/hO9A9fyQqVNjb/eMxmwKpLh0vA8kh
	1Knf4nfhoI6XpiBL1lQle1XIPANcGcvKypEIKCXkUrS/mDkS9ZYb+PADjyUKuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753457038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4lgC9NmRKNeaBQPMcoCW1/ucdzcGe8uTJ4NlyutYKc=;
	b=D66vXu2Vg2czKBIoUludNgY3zG/U9BxGsgTZO1nNa2pvIJDRQ/kNUeSWIRz/1Cey+Gh3J7
	DrIcDUVLtDfMzkDQ==
To: Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tejun Heo
 <tj@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thierry Reding
 <thierry.reding@gmail.com>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <877bzxqo39.ffs@tglx>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <dd50a074-0988-4a4d-a78f-7862e87dbab0@redhat.com> <877bzxqo39.ffs@tglx>
Date: Fri, 25 Jul 2025 17:23:56 +0200
Message-ID: <87v7ngpa43.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 23:24, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 13:55, Waiman Long wrote:
> So lets look at that call chain further
>
>    vt_console_print()
>      hide_cursor()
>       vc->vc_sw->con_cursor(vc, false); --> fbcon_cursor()
>
>       fbcon_cursor()
>         if (vc->vc_cursor_type & CUR_SW)
>            fbcon_del_cursor_work(info)
>              cancel_delayed_work_sync(&ops->cursor_work);
>
> Here we are.

It's actually very simple to reproduce in a VM. No wireless, no
suspend/resume, no special hardware required.

Enable framebuffer and framebuffer console. Add console=tty0 to the
kernel command line.

Log into FB console and do

#  echo -e '\033[?17;0;64c'

which enables the software cursor, which in turn enables the above
conditional invocation of fbcon_del_cursor_work(). Then force a printk

# echo h >/proc/sysrq-trigger

and watch the show.

[ 1406.245343] BUG: sleeping function called from invalid context at kernel/workqueue.c:4359
[ 1406.245345] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1819, name: bash
[ 1406.245346] preempt_count: 2, expected: 0
[ 1406.245347] RCU nest depth: 1, expected: 0
[ 1406.245348] 7 locks held by bash/1819:
[ 1406.245349]  #0: ffff9a730c4ba428 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x73/0xf0
[ 1406.245444]  #1: ffffffffa7ade120 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x3d/0x270
[ 1406.245457]  #2: ffffffffa7adb500 (console_lock){+.+.}-{0:0}, at: _printk+0x63/0x80
[ 1406.245464]  #3: ffffffffa7adb550 (console_srcu){....}-{0:0}, at: console_flush_all+0x3c/0x530
[ 1406.245470]  #4: ffffffffa7a6b140 (console_owner){....}-{0:0}, at: console_lock_spinning_enable+0x42/0x70
[ 1406.245475]  #5: ffffffffa7a6b0c0 (printk_legacy_map-wait-type-override){....}-{4:4}, at: console_flush_all+0x2fe/0x530
[ 1406.245480]  #6: ffffffffa7b8e4d8 (printing_lock){....}-{3:3}, at: vt_console_print+0x5b/0x490
[ 1406.245487] irq event stamp: 92690
[ 1406.245488] hardirqs last  enabled at (92689): [<ffffffffa656edef>] console_flush_all+0x49f/0x530
[ 1406.245491] hardirqs last disabled at (92690): [<ffffffffa656edff>] console_flush_all+0x4af/0x530
[ 1406.245493] softirqs last  enabled at (91822): [<ffffffffa6455166>] __fpu_restore_sig+0x206/0x6a0
[ 1406.245497] softirqs last disabled at (91820): [<ffffffffa6455088>] __fpu_restore_sig+0x128/0x6a0
[ 1406.245499] Preemption disabled at:
[ 1406.245499] [<ffffffffa6570211>] vprintk_emit+0x1f1/0x430
[ 1406.245505] CPU: 46 UID: 0 PID: 1819 Comm: bash Not tainted 6.16.0-rc7+ #446 PREEMPT(voluntary)
[ 1406.245508] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1406.245510] Call Trace:
[ 1406.245514]  <TASK>
[ 1406.245519]  dump_stack_lvl+0x77/0xb0
[ 1406.245526]  __might_resched+0x1b2/0x2d0
[ 1406.245539]  cancel_delayed_work_sync+0x57/0x90
[ 1406.245548]  fbcon_cursor+0xb2/0x140
[ 1406.245558]  hide_cursor+0x24/0xb0
[ 1406.245562]  vt_console_print+0x471/0x490
[ 1406.245565]  ? __pfx_vt_console_print+0x10/0x10
[ 1406.245575]  console_flush_all+0x32b/0x530

As I've enabled CONFIG_DEBUG_ATOMIC_SLEEP I get the splat immediately
even when there is no work queued. (I misread that code yesterday with
my tried brain and thought the might_sleep() would be too late).

And clearly this is invoked with interrupts disabled:

[ 1406.245345] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1819, name: bash

Now if there would be work executed at that moment then the lockdep
splat _AND_ the subsequent 'irqs already enabled' splat would
materialize.

I can't be bothered to figure out how to make the work executed because
the above is already a clear prove of the theory :)

It requires that the software cursor is enabled. That's probably rare,
so that explains why this went unnoticed for so long.

Contrary to all the halluzinations about the printk locking and lockdep
correctness, this is a crystal clear bug in the framebuffer console code
and has absolutely nothing to do with the printk() core code.

The workqueue issue got introduced with commit 3b0fb6ab25dd ("fbcon: Use
delayed work for cursor") in 5.19, but that replaced a del_timer_sync(),
which had a similar problem because del_timer_sync() cannot be invoked
in hard interrupt context, but printk() can ...

That del_timer_sync() was conditional up to 4.2, where it became
unconditional in commit 2a17d7e80f1d ("fbcon: unconditionally initialize
cursor blink interval") just to be "fixed" shortly before 4.2-rc1 by
moving the conditional back in commit a5edce421848 ("fbcon: Avoid
deleting a timer in IRQ context").

That conditional did not fix anything as it just pushed the delete into
the rarely executed path, therefore hiding the bug, which existed from
the very beginning when this cursor blinking muck was introduced with
commit acba9cd01974 ("fbcon: cursor blink control") in 2.6.23.

So this software cursor code path was never tested with printk() and
actually the splat which led to commit a5edce421848 ("fbcon: Avoid
deleting a timer in IRQ context") should have made it crystal clear that
this code path is broken:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 0 at ../kernel/time/timer.c:1098 del_timer_sync+0x4c/0x54()
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.0-rc4-next-20150519 #1
 Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
 [] (warn_slowpath_null) from [] (del_timer_sync+0x4c/0x54)
 [] (del_timer_sync) from [] (fbcon_del_cursor_timer+0x2c/0x40)
 [] (fbcon_del_cursor_timer) from [] (fbcon_cursor+0x9c/0x180)
 [] (fbcon_cursor) from [] (hide_cursor+0x30/0x98)
 [] (hide_cursor) from [] (vt_console_print+0x2a8/0x340)
 [] (vt_console_print) from [] (call_console_drivers.constprop.23+0xc8/0xec)
 [] (call_console_drivers.constprop.23) from [] (console_unlock+0x498/0x4f0)
 [] (console_unlock) from [] (vprintk_emit+0x1f0/0x508)
 [] (vprintk_emit) from [] (vprintk_default+0x24/0x2c)
 [] (vprintk_default) from [] (printk+0x70/0x88)
 
But no, hiding it behind a rarely true conditional without actually
testing it, is way better. Seriously?

The changelog should have been:

    This commit papers over the underlying problem by restoring the
    condition...

I leave it as an exercise to the framebuffer people how to fix this
trainwreck for real.

Thanks,

        tglx

