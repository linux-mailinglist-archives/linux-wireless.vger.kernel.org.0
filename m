Return-Path: <linux-wireless+bounces-32154-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAD/Idv0nWlaSwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32154-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:58:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC98718B9FA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B433304C942
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE022DCF61;
	Tue, 24 Feb 2026 18:56:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3872D8376
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959385; cv=none; b=VWrtf6rDPYNVF2aim6yjgEUrPbAj7uU8PLb0943RPQfQ8brB20+07LDXaDp9chmqRcEmFzuE5dYqiLQGs6WSEwOz3UQlcA4knh8y3cdq59PUAVrkwyF0zOr9IB3dUcjr0WUJCmgl9bVMOoJVtTmKaE+GQEcj9FFLODYczVeLbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959385; c=relaxed/simple;
	bh=DbEJwjUi3L0+TBnyskY3UJbNMcGnrrkVyuhh5wowIsk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YHYvR28nEItZXEnis7ZLBXAT+MXY8javXC72d+oadLjREpEN/OR7f0DEQxsRpWQGb4ay876VZEFVrWrSmztc+Oog3kBEWmjRj1w13HzkccoY89fnN4yV+b30CLV9ZaqwVlADqcTaHzozFUQcYGhYDaADAMnR7CEtaQk47Klyj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c448d15cso57522799eaf.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 10:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959383; x=1772564183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isqBevF2Bn9fTBMvsgOHkEQMKMiomLm1PyvIuY/3gDU=;
        b=Sy5ZdgqySVp3gLojPpBSzms31cajKiRg/3E3cDWA7cdan16muUO9BiUMUWa9rxPjnW
         aU/nVlHEHvLOQgvhlmpaogQybuMl4+MFr03mZwSgqcR6SaFaxnjqKCQ7nGmZZAxog+G1
         iNGfNQP0O4wPzhASB7EKoFrdOAtTT2vdWUrV1t446tp/I0+7h8HjRQ+uACRG5ju6KSAK
         I8/fPrThsBwX0TRbccWfzO+QlzCJpejz3Mn+H+Riwy36WCtIfHTMCioaTEvC1KwpUBeU
         M6kv33tMtrcN5IwhhDsq1nuH0v2yYli062rntlhGiqepUBZlOlPAqrzto+u4MBH95/Vr
         sYQw==
X-Forwarded-Encrypted: i=1; AJvYcCVSCdiy5UtHVqO0LVkDe3umZvMWCSnL1eDNzC/3oGyLQ8LzC1UM/YTZSI0xthdhB0s/tuof3JAckQuNyd8idw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywds0m7HNVudCA6omM0B6ZagLoWtMyfz0GTHEq7Htod+oHgDg6Z
	W6VYvfcUTIPFDLaRYTSnN+25tt+iFesRSt/uPEsi1+j030J1xIfXbN7xDYpUj+6IuR2zMIUT2qA
	qkk8hQe841JpU8Or2QaDiNjTNAUUpPgG1U4nvVHyHurPDVbzH0ZKCa89727o=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2108:b0:674:c966:fb27 with SMTP id
 006d021491bc7-679c44ead62mr6864775eaf.52.1771959383480; Tue, 24 Feb 2026
 10:56:23 -0800 (PST)
Date: Tue, 24 Feb 2026 10:56:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699df457.050a0220.131eeb.0009.GAE@google.com>
Subject: [syzbot] [usb?] BUG: sleeping function called from invalid context in usb_tx_block
From: syzbot <syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com>
To: libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1ff39736314a9939];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32154-lists,linux-wireless=lfdr.de,74afbb6355826ffc2239];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,appspotmail.com:email,googlegroups.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: DC98718B9FA
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    8bf22c33e7a1 Merge tag 'net-7.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=127b9722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ff39736314a9939
dashboard link: https://syzkaller.appspot.com/bug?extid=74afbb6355826ffc2239
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1561fffa580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1031795a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e19c10e1a0e/disk-8bf22c33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f3209ea7fd5/vmlinux-8bf22c33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9be7f93d0a22/bzImage-8bf22c33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com

usb8xxx: URB in failure status: -2
BUG: sleeping function called from invalid context at drivers/usb/core/urb.c:706
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
no locks held by swapper/1/0.
irq event stamp: 328389
hardirqs last  enabled at (328388): [<ffffffff876b10b2>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
hardirqs last  enabled at (328388): [<ffffffff876b10b2>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (328389): [<ffffffff876b0dc2>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:130 [inline]
hardirqs last disabled at (328389): [<ffffffff876b0dc2>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (328372): [<ffffffff8176f0bd>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (328372): [<ffffffff8176f0bd>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (328372): [<ffffffff8176f0bd>] __irq_exit_rcu+0xed/0x150 kernel/softirq.c:723
softirqs last disabled at (328385): [<ffffffff8176f0bd>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (328385): [<ffffffff8176f0bd>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (328385): [<ffffffff8176f0bd>] __irq_exit_rcu+0xed/0x150 kernel/softirq.c:723
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:8884
 usb_kill_urb+0x8e/0x320 drivers/usb/core/urb.c:706
 usb_tx_block+0x91/0x320 drivers/net/wireless/marvell/libertas/if_usb.c:429
 if_usb_send_fw_pkt.isra.0+0x2e4/0x550 drivers/net/wireless/marvell/libertas/if_usb.c:366
 if_usb_receive_fwload+0x5d3/0x780 drivers/net/wireless/marvell/libertas/if_usb.c:592
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xd85/0x3670 drivers/usb/gadget/udc/dummy_hcd.c:1995
 __run_hrtimer kernel/time/hrtimer.c:1785 [inline]
 __hrtimer_run_queues+0x50e/0xa70 kernel/time/hrtimer.c:1849
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1866
 handle_softirqs+0x1de/0x9d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xed/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: be b1 01 e9 13 e8 02 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 f1 1d 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc9000013fe00 EFLAGS: 00000242
RAX: 00000000000502bf RBX: ffff8881022a1d00 RCX: ffffffff876888d5
RDX: 0000000000000000 RSI: ffffffff8901d71b RDI: ffffffff87afa420
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed103eae6725
R10: ffff8881f573392b R11: 0000000000000000 R12: ffffed10204543a0
R13: 0000000000000001 R14: ffffffff8aefe2d0 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:73 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x35b/0x4b0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x148
 </TASK>
BUG: scheduling while atomic: swapper/1/0/0x00000102
no locks held by swapper/1/0.
Modules linked in:
irq event stamp: 328389
hardirqs last  enabled at (328388): [<ffffffff876b10b2>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
hardirqs last  enabled at (328388): [<ffffffff876b10b2>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (328389): [<ffffffff876b0dc2>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:130 [inline]
hardirqs last disabled at (328389): [<ffffffff876b0dc2>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (328372): [<ffffffff8176f0bd>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (328372): [<ffffffff8176f0bd>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (328372): [<ffffffff8176f0bd>] __irq_exit_rcu+0xed/0x150 kernel/softirq.c:723
softirqs last disabled at (328385): [<ffffffff8176f0bd>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (328385): [<ffffffff8176f0bd>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (328385): [<ffffffff8176f0bd>] __irq_exit_rcu+0xed/0x150 kernel/softirq.c:723
Preemption disabled at:
[<0000000000000000>] 0x0
----------------
Code disassembly (best guess):
   0:	be b1 01 e9 13       	mov    $0x13e901b1,%esi
   5:	e8 02 00 0f 1f       	call   0x1f0f000c
   a:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
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
  21:	0f 00 2d d3 f1 1d 00 	verw   0x1df1d3(%rip)        # 0x1df1fb
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
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

