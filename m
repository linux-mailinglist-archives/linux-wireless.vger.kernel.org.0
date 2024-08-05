Return-Path: <linux-wireless+bounces-10944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DC947767
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6DFB20BA5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F455149DF0;
	Mon,  5 Aug 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P1Y3RjiD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pqV+9Hl0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B713D882;
	Mon,  5 Aug 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847014; cv=none; b=Xpz9XMoJgbHyuXQKO0wdVARyMv02LTbWJhd1TJ09hQdFVmuLanIgyvKUOZ6NcYFkpDH7gqmQHkD/CZ8zoE7xUx7ITRttrRERBke8iIT7ACVuCYhfqr3HUHeK68xfH6qSkYHjN6yl8otP7+H2CErhqocM2mT0En7WTbsfmyeWn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847014; c=relaxed/simple;
	bh=PjtUfg2dBkrxwoYebMLa4QJFsaKgxx/xvAKUDYqI72k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqP/FdU7St4irOn5uCrEFCz2iVWVGYhZXFksaEzhEpU3s4IE3orT1gd3KP2b6Dt+RsBJBX59Rs3K4ziCeTZGQoflHx6AsbsZqlhFc/p0T/rgNq0mO+0bIKVXlhTZhRQpjqNzlgy2BZvmk4cnDHuCm9K3yV3Ei6bcx+p2BqJ2G9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P1Y3RjiD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pqV+9Hl0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722847010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCsHJr1SeKMqzqkT0AejdrkUq3Lrh5QDrzPRJxr0exw=;
	b=P1Y3RjiDmTGcQmSQQSM0W4znmGk/TCQCPnBQ2rnJqCyEd9NJYv6YQVAq1nZh5m8kru3laR
	PNw4QQnbpuI2iI6MLvuDKCiAyBy8uSMcM//UM5D8wXXXQ/vZc3B1mJhqsZzSLe6saI7sZz
	8oAuYEPtwizF+X3zGCW+nLJjExy+fmBoPTfUhbG+UL7yFLNPeClaIh3Ia7zwaic2DAAuWP
	U8v0SWrugVSerc1SDFOGzTCK8SIdWgYAdhbKJex1enhxiV8r+2+Ufn1zXyLF+3ZqlVPUBP
	AN25nlXKUC5QfZrlk7OKPeJoVAucipy4TXR35vAVKhbNvIRh6d2vKpbYO12O3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722847010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCsHJr1SeKMqzqkT0AejdrkUq3Lrh5QDrzPRJxr0exw=;
	b=pqV+9Hl0F6DWyoS2cDiBSEc2UWx8wdnbmtCzvRPcBe/wtKMCg8KJf5Dvywkt94TF+1U5Tf
	P4Nyg+Tm/2f4e5Cw==
To: syzbot <syzbot+41e4341f493f1155aa3d@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Cc: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo
 <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (3)
In-Reply-To: <000000000000331d30061eeaf927@google.com>
References: <000000000000331d30061eeaf927@google.com>
Date: Mon, 05 Aug 2024 10:36:49 +0200
Message-ID: <87plqn5psu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024 at 00:53, syzbot wrote:

Cc+ wireless folks.

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3d650ab5e7d9 selftests/bpf: Fix a btf_dump selftest failure
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e154d3980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
> dashboard link: https://syzkaller.appspot.com/bug?extid=41e4341f493f1155aa3d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/630e210de8d9/disk-3d650ab5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3576ca35748a/vmlinux-3d650ab5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5b33f099abfa/bzImage-3d650ab5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+41e4341f493f1155aa3d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 11474 at kernel/time/hrtimer.c:1048 hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1048

That tries to forward a hrtimer which is currently enqueued.

> Modules linked in:
> CPU: 0 UID: 0 PID: 11474 Comm: syz.2.2194 Not tainted 6.10.0-syzkaller-12666-g3d650ab5e7d9 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> RIP: 0010:hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1048
> Code: 00 49 89 1e 48 8b 04 24 eb 07 e8 bb e7 12 00 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 a1 e7 12 00 90 <0f> 0b 90 eb e0 4c 89 f0 31 d2 49 f7 f4 48 89 04 24 49 89 c6 4d 0f
> RSP: 0018:ffffc90000007bf8 EFLAGS: 00010246
> RAX: ffffffff81809d7f RBX: 0000000000000001 RCX: ffff888026059e00
> RDX: 0000000000000101 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 00000042facd7bc5 R08: ffffffff81809c13 R09: 1ffffffff26e4d1f
> R10: dffffc0000000000 R11: ffffffff81358260 R12: 00000000061a8000
> R13: ffff88807db07080 R14: 000000000044e132 R15: 1ffff1100fb60e0c
> FS:  00007fa65d4636c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f478b2356c0 CR3: 000000005beac000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Call Trace:
>  <IRQ>
>  hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
>  mac80211_hwsim_beacon+0x192/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2354

This is the timer callback. So something has re-started the timer before
the soft interrupt was able to run ....

>  __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
>  __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1753
>  hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1770
>  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

mac80211_hwsim_link_info_changed() and mac80211_hwsim_config() can
re-start the timer concurrently to a running softirq callback. I can't
see any serialization there.

The check for hrtimer_queued() is not cutting it as that's a lockless
check and becomes true when the timer is dequeued for expiry.

So the following can happen:

CPU0                            CPU1

hrtimer_softirq()
    lock_base();
    dequeue_timer(t);
    base->running = t;
    unlock_base(t);
                                if (!hrtimer_queued(t))
    t->fn(t)				hrtimer_start(t);
      ....
      hrtimer_forward(t);       <- FAIL

Replacing hrtimer_queued() with hrtimer_active() should solve the
hrtimer race, but I wonder whether the concurrency between the soft
interrupt and the config/info changes has other side effects.

Thanks,

        tglx

