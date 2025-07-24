Return-Path: <linux-wireless+bounces-26006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1734B1130A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF66F1C273AD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3513D2ECD00;
	Thu, 24 Jul 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NPymv53s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXD2VdYh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECC19CC02;
	Thu, 24 Jul 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392272; cv=none; b=sIjX8pMVJyV0ikCKRy0oHqbeWOOP68ZwD7rUhY0FgTt6ThtATTx5dse96sB+yDnENSxn1UptdyNycuknRf1475TqdveCvhzWQkI53/tWVuna8NsNDnc7a6PHXxVHkLyvJjSHiHrXNiKVCd2Xy+okpaJuEbHDFUQIIxu6h5e72mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392272; c=relaxed/simple;
	bh=KguKvvLK2VzgJB5dRPx+wLpGlNbpY5YaknHMYN6mpz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwH5ijFFwa/06thzYLo8r1laE2SaxNZiMsgEXRDjfmfRiTdnAw9iVSs5o4QlrPPloqipX4xWWW+EzDGqbWh5QcDlWzjFvrGkgTW++uU9C8Rq4XNveosEP7eZFBtG47lYgA18D2jrf0hiDwajXW3M2NVpadSImNzZmR9yZmQaVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NPymv53s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXD2VdYh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753392268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5f3Me3VyZ4SyGfnSQGjSC+YJQXU81TJGWtYBMM6n3tM=;
	b=NPymv53sm20UBxi9o0hICcgZ5JuFkT3/fiCEmUZpClcOMAlmoTBRQGXx/IkLXYjr2bqg/8
	jwSrFHhX2tRZDZ2fmDEOIQbb0whIeiuxLA1gNey1M10I370j0iDxzHAsRRo3bcCwTC1hYq
	fAUbtHkyy98MsjwL1Z9HmSvNORuTtbc+4nWcrXJcIKcJgnJCdeLj9pqVLMwTkmvTSL/9al
	Mdp53nmoNk2EKoRiUhAVwE39a3SqYiNUNci6H41EqqeLjH8fhHefmAsQz9jMFOLrIhcpch
	ffIBeMNIAc3VU1+1Fa7IXWaaH+idOaiZ86Widvuw8Ffbu/UYjryI4skqfBlgIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753392268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5f3Me3VyZ4SyGfnSQGjSC+YJQXU81TJGWtYBMM6n3tM=;
	b=PXD2VdYhuD7b3zeATYRL/i1KswhPkPpzRTiEV+NvHpRuY/BGuj/1ol6VpSXnKv/28rX48R
	S9D2PBfCu5JliZBw==
To: Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>, John
 Ogness <jogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tejun Heo
 <tj@kernel.org>, Simona Vetter <simona@ffwll.ch>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
In-Reply-To: <dd50a074-0988-4a4d-a78f-7862e87dbab0@redhat.com>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <dd50a074-0988-4a4d-a78f-7862e87dbab0@redhat.com>
Date: Thu, 24 Jul 2025 23:24:26 +0200
Message-ID: <877bzxqo39.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24 2025 at 13:55, Waiman Long wrote:
> On 7/24/25 1:51 PM, Waiman Long wrote:
>>> [=C2=A0=C2=A0 54.284095] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [=C2=A0=C2=A0 54.284097] WARNING: inconsistent lock state
>>> [=C2=A0=C2=A0 54.284100] 6.16.0-rc7+ #305 Tainted: G S
>>> [=C2=A0=C2=A0 54.284104] --------------------------------
>>> [=C2=A0=C2=A0 54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} =
usage.
>>> [=C2=A0=C2=A0 54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] ta=
kes:
>>> [=C2=A0=C2=A0 54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, =
at:=20
>>> console_lock_spinning_enable+0x3d/0x60
>>
>> The lockdep warning just means that console_owner_lock is acquired=20
>> both in softirq context and in task context with interrupt enabled.=20
>> That can leads to deadlock. So the remedy is to always take=20
>> console_owner_lock with interrupt disabled, i.e. with=20
>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
>
> I suppose that this lock can also be acquired in hardirq context. So a=20
> similar HARDIRQ warning can be printed if that happens first.

None of this makes any sense whatsoever.

Both invocations of console_lock_spinning_enable() are within a hard
interrupt disabled section.

		printk_safe_enter_irqsave(flags);
		console_lock_spinning_enable();

The lockdep map which is printed here is not console_owner_lock,
it's console_owner, which is a software managed lockdep_map:

static struct lockdep_map console_owner_dep_map =3D {
	.name =3D "console_owner"
};

It's touched in console_lock_spinning_enable(),
console_lock_spinning_disable_and_check() and console_trylock_spinning().

In all cases with interrupts disabled and all sites use
printk_safe_enter_irqsave() which internally uses local_irq_save().

Now lets go back to the initial report, which is further down:

[   54.285777] raw_local_irq_restore() called with IRQs enabled
[   54.285788] WARNING: CPU: 3 PID: 2940 at kernel/locking/irqflag-debug.c:=
10 warn_bogus_irq_restore+0x25/0x30
[   54.285801] Modules linked in:
[   54.285807] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S   =
               6.16.0-rc7+ #305 PREEMPT(voluntary)=20
[   54.285814] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   54.285817] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 )=
 10/12/2016
[   54.285820] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
[   54.285828] Code: 90 90 90 90 90 80 3d c2 5f e3 00 00 74 05 c3 cc cc cc =
cc 55 48 c7 c7 98 2f fa 85 c6 05 ac 5f e3 00 01 48 89 e5 e8 db 23 be fe <0f=
> 0b
5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
[   54.285834] RSP: 0018:ffffc90001acb690 EFLAGS: 00010282
[   54.285839] RAX: 0000000000000000 RBX: ffffffff863ed460 RCX: 00000000000=
00000
[   54.285843] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[   54.285847] RBP: ffffc90001acb690 R08: 0000000000000000 R09: 00000000000=
00000
[   54.285850] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00001
[   54.285853] R13: ffffc90001acb72b R14: 0000000000000200 R15: 00000000000=
00000
[   54.285857] FS:  00007f79e08da1c0(0000) GS:ffff88828fcf5000(0000) knlGS:=
0000000000000000
[   54.285862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.285865] CR2: 000055b73b455000 CR3: 000000010b07e005 CR4: 00000000000=
606b0
[   54.285869] Call Trace:
[   54.285872]  <TASK>
[   54.285874]  console_flush_all+0x47d/0x4d0
[   54.285880]  ? console_flush_all+0x43/0x4d0
[   54.285885]  ? console_flush_all+0x2d2/0x4d0
[   54.285892]  console_unlock+0x55/0x100
[   54.285924]  ieee80211_mgd_auth+0x2a3/0x5e0
[   54.285934]  ? __this_cpu_preempt_check+0x13/0x20
[   54.285940]  ieee80211_auth+0x13/0x20

I asked for decoding that console_flush_all+0x47d/0x4d0 line, but I'm
100% sure now that it is line 3128 in console_emit_next_record() which
is inlined into console_flush_all()

     printk_safe_exit_irqrestore(flags);

Pavel, can you confirm that?

But let's look at the other stack trace in the lockdep splat which is
way more interesting:

	       stack backtrace:
[   54.284433] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S   =
               6.16.0-rc7+ #305 PREEMPT(voluntary)=20
[   54.284441] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   54.284443] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 )=
 10/12/2016
[   54.284446] Call Trace:
[   54.284448]  <TASK>
[   54.284450]  dump_stack_lvl+0x88/0xd0
[   54.284458]  dump_stack+0x10/0x20
[   54.284463]  print_usage_bug.part.0+0x237/0x2d0
[   54.284470]  mark_lock.part.0+0xa9c/0xfb0
[   54.284479]  mark_held_locks+0x4d/0x80
[   54.284486]  lockdep_hardirqs_on_prepare+0xff/0x1c0
[   54.284493]  trace_hardirqs_on+0x5a/0xe0
[   54.284500]  _raw_spin_unlock_irq+0x23/0x60
[   54.284505]  __flush_work+0x3b4/0x550
[   54.284513]  ? __timer_delete+0x2f/0xd0
[   54.284519]  ? timer_delete+0xb/0x20
[   54.284524]  ? try_to_grab_pending+0x12a/0x320
[   54.284534]  cancel_delayed_work_sync+0x65/0x70
[   54.284539]  fbcon_cursor+0xbe/0x160
[   54.284548]  hide_cursor+0x2c/0xc0
[   54.284553]  vt_console_print+0x45e/0x470
[   54.284560]  console_flush_all+0x301/0x4d0
[   54.284565]  ? console_flush_all+0x2d2/0x4d0
[   54.284569]  ? console_flush_all+0x43/0x4d0
[   54.284572]  ? console_flush_all+0x2d2/0x4d0
[   54.284579]  console_unlock+0x55/0x100
[   54.284584]  vprintk_emit+0x15b/0x3a0
[   54.284590]  vprintk_default+0x18/0x20
[   54.284595]  vprintk+0x9/0x10
[   54.284600]  _printk+0x52/0x70
[   54.284608]  ieee80211_mgd_auth+0x2a3/0x5e0
[   54.284619]  ? __this_cpu_preempt_check+0x13/0x20
[   54.284625]  ieee80211_auth+0x13/0x20

That's the same call chain as the above which complains about the
already enabled interrupt.

So the lockdep splat is telling us that the raw_spin_unlock_irq() in the
workqueue code is making console_owner unsafe.

Now let's look where this comes from:

        console_flush_all+0x301/0x4d0

invokes

        vt_console_print+0x45e/0x470

via

        console_emit_next_record()
        ...
           printk_safe_enter_irqsave(flags);
           ...
           con->write(con, outbuf, pmsg.outbuf_len);

Again decoding console_flush_all+0x301/0x4d0 should confirm that.

Now that ends up in cancel_delayed_work_sync() via hide_cursor() ->
fbcon_cursor().

cancel_delayed_work_sync() has a might_sleep() in it _and_
__flush_work() uses raw_spin_[un]lock_irq() as it requires to be invoked
in thread or in some cases in BH context.

vt_console_print() is the write() callback of the VT console driver. As
that is a legacy console, it can't do that.

Only the new NBCON variants are allowed to sleep in their write()
callbacks because they are running in their own printer thread
context. For atomic printouts in case of emergency they can have a
write_atomic() callback. If they don't then printing is not attempted,
but that's not relevant for vt_console_print() obviously.

So lets look at that call chain further

   vt_console_print()
     hide_cursor()
      vc->vc_sw->con_cursor(vc, false); --> fbcon_cursor()

      fbcon_cursor()
        if (vc->vc_cursor_type & CUR_SW)
           fbcon_del_cursor_work(info)
             cancel_delayed_work_sync(&ops->cursor_work);

Here we are.

Now I checked whether this is a recent change, but I have to say it has
been that way for a long time. It's a very interesting question why this
never popped up before.

The only explanation I have so far is that the code path in
cancel_delayed_work_sync() which uses [un]lock_irq() is only reached,
when the works is executed at that point.

Unfortunatly the might_sleep() check in __cancel_work_sync() is after
the point which determines that.

So it's a matter of debug options being enabled and the probability of
hitting a work which is actually executed to trip over this problem.

I have no fix for that, but at least there should be some clues now
where to tackle this.

It's definitely not a printk bug. The culprit was hiding in plain sight
for a long time in the fbcon_console code.

Thanks,

        tglx





=20=20=20=20=20=20=20=20


