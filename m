Return-Path: <linux-wireless+bounces-38614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F7DQETmeSGryrwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 07:46:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C603706B43
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 07:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38614-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38614-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24141301A1E2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 05:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAB305668;
	Sat,  4 Jul 2026 05:46:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFDA27A47F
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 05:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783143988; cv=none; b=pdJyTo0Q0gpn8AqtJku0vjMip66Z4i5Agxf+g2Igtp6JHYjIgh+IQiCpxCWL1KWRuk1nPtPHERGRWBirpJbDqM6wy0xqfqX2NMAoVZPv/lY3pY6BR3RUBKm9jxZSDL8yfYMPpjvOlh/smsrD2O3iFuVegAccG1wBEHaZlk3xafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783143988; c=relaxed/simple;
	bh=0ri+rowBsuVRd7CmY/EhESOItOnZmOR+KG5jtsNKqLs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XJWlyWswLJegcqr7/Io71TnRCtCtPuMbZight6rjygI5DhglatXArN5Cq0N0DkWRJaLI995GH5w/enk1rg2Jq074P24YQmpa7/g4lNBMeIG2guG5eFgok2yohd1JuBR4jRCM5oArbYpTdXbVIUU6EXD04kGFGSuDhQuLPiujtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4909b046dabso1841863b6e.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 22:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783143985; x=1783748785;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5D6qQPtf4IgRIFQ0tZG2NJ5fIoyh7VlwEwJvfwLdf4=;
        b=Tg3Lz95LXpTg326JwYHTRo4SyXACXpY9t//M2S62HQNxm0xcs1dFw5DN9/DhwQ3f6f
         pabROBySkSjc0khLcrKhw8hVoMjvVv4i6QQWhlR1WP46HZdq7Gbe6/BLXoX8MKCzr8+q
         woOJaf1BZluQq84zcrrPGZXK4ARHRm4eeRipH+odJNCHPE66Jfmd4AVo/p76aDDTnlKD
         Fcnsrh0L/XiT/yGeGLInB06EEJmuQ9Muc86zaeJ0/Ox5FDMKZQyQ0ydRT3UYrwGQvsWm
         2wGXLPF1ghSwJBzVj+bkZiZb3WZOyqQmM6FTT7vD0/55t2kKtpz8Hu0e+awwBMoBCUpr
         5PLA==
X-Forwarded-Encrypted: i=1; AFNElJ9qenkMewmGbJe8+PB7QY4Oy4lt9XotDOYsPr9Rzk5FLjQesqkHDzBOedXTAwv0dXhjN4vlZYSY0OHJC9CRlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/y6epcwRJ9Y8gNoUaU+yCo1r3UI/eBOOZ7l6A7LPxvB+BFAN
	f15EQEhHK+u9WgFVQrjt9oXaBqxtPCVp7zH+7uhNGVrLdllMyg88Ev1dxbQALMcATfhjP7p0EnV
	5iuGEzA/MchmyvrKdou5Auts7MRz6TWE1yGcZEck/wTXAJfCzXqJntbr/An4=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1903:b0:496:dfe1:6d91 with SMTP id
 5614622812f47-499bc606a8dmr1167270b6e.42.1783143985519; Fri, 03 Jul 2026
 22:46:25 -0700 (PDT)
Date: Fri, 03 Jul 2026 22:46:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a489e31.b42ede87.8bd1.0009.GAE@google.com>
Subject: [syzbot] [wireless?] [usb?] WARNING in __carl9170_tx_process_status
From: syzbot <syzbot+381102a7292a374fe8a7@syzkaller.appspotmail.com>
To: chunkeey@googlemail.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6ec4d592e55f7960];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38614-lists,linux-wireless=lfdr.de,381102a7292a374fe8a7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[googlemail.com,vger.kernel.org,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C603706B43

Hello,

syzbot found the following issue on:

HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1792f9fe580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ec4d592e55f7960
dashboard link: https://syzkaller.appspot.com/bug?extid=381102a7292a374fe8a7
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125c289580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17049e89580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8540695a33d7/disk-dc59e4fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e144bb9cdc33/vmlinux-dc59e4fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3051bf9301/bzImage-dc59e4fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+381102a7292a374fe8a7@syzkaller.appspotmail.com

------------[ cut here ]------------
__lockdep_enabled && !this_cpu_read(hardirqs_enabled)
WARNING: kernel/softirq.c:430 at __local_bh_enable_ip+0xbd/0x120 kernel/softirq.c:430, CPU#0: swapper/0/0
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:__local_bh_enable_ip+0xbd/0x120 kernel/softirq.c:430
Code: 00 e8 a7 d1 0b 00 e8 62 10 45 00 fb 65 8b 05 7a c3 86 0b 85 c0 74 50 5b 5d c3 cc cc cc cc 65 8b 05 04 03 87 0b 85 c0 75 a0 90 <0f> 0b 90 eb 9a e8 59 12 45 00 eb 9b 48 89 ef e8 0f 0b 19 00 eb a4
RSP: 0018:ffffc90000007aa8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff15e7114
RDX: 0000000000000001 RSI: 0000000000000201 RDI: ffffffff8446537b
RBP: ffffffff8446537b R08: 0000000000000000 R09: ffffed1023c03a8b
R10: ffff88811e01d45b R11: 0000000000000000 R12: ffff88811c516705
R13: dffffc0000000000 R14: ffff88811e01b220 R15: ffff88811e01d440
FS:  0000000000000000(0000) GS:ffff888268640000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdd9de6dc4 CR3: 00000001197ae000 CR4: 00000000003506f0
Call Trace:
 <IRQ>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 carl9170_get_queued_skb drivers/net/wireless/ath/carl9170/tx.c:531 [inline]
 __carl9170_tx_process_status+0x13b/0x620 drivers/net/wireless/ath/carl9170/tx.c:668
 carl9170_tx_process_status+0xf6/0x230 drivers/net/wireless/ath/carl9170/tx.c:701
 carl9170_handle_command_response+0x3c8/0xc50 drivers/net/wireless/ath/carl9170/rx.c:219
 carl9170_usb_rx_irq_complete+0xfc/0x1b0 drivers/net/wireless/ath/carl9170/usb.c:307
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xda1/0x36c0 drivers/usb/gadget/udc/dummy_hcd.c:2005
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x17d/0x2c0 kernel/time/hrtimer.c:2113
 handle_softirqs+0x1dd/0x990 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x160/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 90 ac 01 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 03 8f 0b 00 fb f4 <e9> 3c f6 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff89407e20 EFLAGS: 00000242
RAX: 0000000000096967 RBX: ffffffff8942c8c0 RCX: ffffffff877af8e5
RDX: 0000000000000000 RSI: ffffffff890edf5a RDI: ffffffff87b15200
RBP: fffffbfff1285918 R08: 0000000000000001 R09: ffffed103eac670d
R10: ffff8881f563386b R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffffffff1280fc8 R15: dffffc0000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:768
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x3a7/0x5b0 kernel/sched/idle.c:355
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:454
 rest_init+0x251/0x260 init/main.c:717
 start_kernel+0x489/0x490 init/main.c:1175
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x158
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	ac                   	lods   %ds:(%rsi),%al
   2:	01 c3                	add    %eax,%ebx
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	0f 1f 00             	nopl   (%rax)
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d 03 8f 0b 00 	verw   0xb8f03(%rip)        # 0xb8f2b
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	e9 3c f6 02 00       	jmp    0x2f66b <-- trapping instruction
  2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  36:	00 00 00
  39:	66 90                	xchg   %ax,%ax
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

