Return-Path: <linux-wireless+bounces-15446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BE9D0B41
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B42C1F226B3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBF31922F8;
	Mon, 18 Nov 2024 08:54:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA69187352
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920063; cv=none; b=plKROToetOzuIyp982s3i/QtiovufX0tbVVHbZiciHCKdqpoPaCxTFg5+d4169iWp825h7AchBuVQyS7VWwSj+9WvyQJ2kq6kLSeDthldEgtcrudVRaxYRx2IuyJWr7fM0Y8C8KW/1u0iUyd9pidkBajckhHh2oiO2OZ0cLo9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920063; c=relaxed/simple;
	bh=OLoSIgvibzcqICM5zV38L9wYfZuQ6AFPW9EK6qeHVqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sXfcgm5jWfl3Jb+BTA6pUPRZtL9n7ZCWM9BqHetvi9Jx+AULW13Ct11y44ShsiUF8mVqvMZkwO9s/6jP4TyySicadE7wn50ERyrb/oxrDQv1tk43CIOykIC8WyQZFa6vAg9gOj2XP8O7y9aBFbMN+i485+NLhhppeo9fohIRa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso17820205ab.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 00:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731920060; x=1732524860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MM/AMVgpJsoR0NkR5uLiO7VA9jKn8GQFkweduVpAl7Y=;
        b=XRAWYlBeVH9GIeCXr9GSpB5JUAncDNYAVGV4aFS4I8yWTz8GO4EF01v+MjAZbLNM8C
         GKr2iHBpBQVpMLtGYz339k84J4uQYKUgfNe8bM+3VA6xLJ7tru+83ptTJCYXSWDWMTdR
         y05wNomkTPhlZyKjJihQA8LRA334PfZEdAzzzSO+rxOf11PrPTS/RqH+BR0mkAgQ1jZK
         Dqu419p2KPohH8S/dLOR7zSyEQAqTX+b3FdYISiG3fMuVdGKf3FzYEy3bIUUDra2IHei
         zERkCPvCSX9VKilU1JJiRkaUGHl7voD6O4a3GcDszFHNu9WZspETZ1mHtI2TiAqH8SLA
         5E7g==
X-Forwarded-Encrypted: i=1; AJvYcCWtVb1rhAmBfuFvgorSYYGMv/MN3HmU5zsVgiYYxgLob7HTb8/M7L0dYSkAXgXlbmPkm+fVpGXu+I3OCaJcJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX/blDYaa/n0+svpQFo5ehHaitH+R606XAYeoKMZCDze+9eGn
	439UDPoqM/fLHvV1Vwax5fbTdmiMwiupxXy0IUPHGSFSRfUoE4+Ohi6uAHb4n5kCzBpduuIrEGP
	ZOl9SPnk/IgJez6Iv+OA0Ov6zkSNedLVRBPC/lHOFrK8c57pQvtHiMCA=
X-Google-Smtp-Source: AGHT+IGKtOWEzAwrP5czfnV2ERuGXwbcv0dE1GCO1KEWTlwmVcKNfDfFpcCH6l9GciKEzMaigDs/kta8rjnJu3wq15Bqn34BHXl4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:3a7:1bd9:ec46 with SMTP id
 e9e14a558f8ab-3a747f2c3d1mr99697775ab.0.1731920060357; Mon, 18 Nov 2024
 00:54:20 -0800 (PST)
Date: Mon, 18 Nov 2024 00:54:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b00bc.050a0220.87769.0027.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in cfg80211_wiphy_work (2)
From: syzbot <syzbot+858514d213c2ff9b671e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, johannes@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	marcello.bauer@9elements.com, netdev@vger.kernel.org, rafael@kernel.org, 
	stern@rowland.harvard.edu, sylv@sylv.io, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b785f4c787 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115c6ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=858514d213c2ff9b671e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136594c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1691c130580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2eb65d2a03c1/disk-f1b785f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70c538f32a8e/vmlinux-f1b785f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79fc36f9a44b/bzImage-f1b785f4.xz

The issue was bisected to:

commit a7f3813e589fd8e2834720829a47b5eb914a9afe
Author: Marcello Sylvester Bauer <sylv@sylv.io>
Date:   Thu Apr 11 14:51:28 2024 +0000

    usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a8e1a7980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a8e1a7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15a8e1a7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+858514d213c2ff9b671e@syzkaller.appspotmail.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")

yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10503 jiffies, g=8301, q=11 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10503 (4294968050-4294957547), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10503 jiffies! g8301 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task    
 stack:28416 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6693
 __schedule_loop kernel/sched/core.c:6770 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6785
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2247
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 1335 Comm: kworker/u8:6 Not tainted 6.12.0-rc7-syzkaller-00042-gf1b785f4c787 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events_unbound cfg80211_wiphy_work

RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 66 a2 44 f6 48 89 df e8 7e 1f 45 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 95 28 36 f6 65 8b 05 a6 e1 dd 74 85 c0 74 16 5b
RSP: 0018:ffffc90000007bd0 EFLAGS: 00000246

RAX: 0000000000000002 RBX: ffff888144be4000 RCX: 1ffffffff2dcb1b0
RDX: 0000000000000000 RSI: ffffffff8b6ccfc0 RDI: ffffffff8bd1b3c0
RBP: 0000000000000246 R08: 0000000000000001 R09: fffffbfff2dc5d95
R10: ffffffff96e2ecaf R11: 0000000000000000 R12: ffff888144fa4468
R13: ffff888144fa4470 R14: ffff888144fa4418 R15: 1ffff92000000fad
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe945a6f48 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 dummy_timer+0x1e49/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:2010
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__asan_memset+0x18/0x50 mm/kasan/shadow.c:84
Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 54 41 89 f4 55 48 89 d5 ba 01 00 00 00 53 48 8b 4c 24 18 <48> 89 ee 48 89 fb e8 bd f0 ff ff 84 c0 74 12 48 89 ea 44 89 e6 48
RSP: 0018:ffffc900048ef7c0 EFLAGS: 00000246

RAX: 0000000000000000 RBX: ffff88806de639e8 RCX: ffffffff8a9f8936
RDX: 0000000000000001 RSI: 000000000000007f RDI: ffff88806de639f0
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000002
R10: 0000000000000001 R11: 0000000000000052 R12: 000000000000007f
R13: ffff88806de63800 R14: 0000000000000028 R15: ffff88806e1ef950
 ieee80211_clear_tpe+0x166/0x290 net/mac80211/util.c:4446
 ieee802_11_parse_elems_full+0x205/0x1680 net/mac80211/parse.c:971
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2385 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2392 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1575 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xc4f/0x2f40 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x3d9/0x550 net/wireless/core.c:440
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - usb_submit_urb failed -19
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

