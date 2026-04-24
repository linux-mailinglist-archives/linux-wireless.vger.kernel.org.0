Return-Path: <linux-wireless+bounces-35256-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Sy1pAC246mmNCwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35256-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 02:24:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 459DA4588F4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 02:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BAF73006391
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 00:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEDA1C5F27;
	Fri, 24 Apr 2026 00:23:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7240DFA3
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776990213; cv=none; b=LfOqVdGbwUk5a6WEUEZJYOIsGIOOQUbyFYDiUvfXvSB0qayaqjTz1kByZhPsv6r5Azgt/679mzi885PbvGFPfVvyKNUew71yj+o5T2sO5HB3UT26cR2BC0bZOBbm1eyQKvXDGeKpiq2LB5pWDt3gostAr+0MFbRN0JuAOKogo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776990213; c=relaxed/simple;
	bh=5m7vaCWCW/Dp50arIK7vZoYoBwVtPNWeTXYDEj46N3U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fkogTw5dpPxIRqoBb/vhr1W0Eo5X5JJqNZl90bYr/6cGKlcPBfekBuLCMeQ9DMBrgnrn7Nid/j5gTonBWmYgRmrTRvsawlVhIcRunzy8IdjCkMRHy0eLM4oTDOhvu7my4dltEstuB2Be6NpkbEkeTARI7R0hEg/r1d9NXwbpTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7dbe76e3abcso17573253a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 17:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776990211; x=1777595011;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IaunhynHfLXlsj+OKWi/KTfUfNlbIvYRUylj6i26Qx8=;
        b=grY/ePdc/hJSyE0tW3+pEdvJfUoXSXXHvI2QmjYVDOLcdni+7fm2jv76bBFd2q+Tzf
         nI1NtVg2IAn/liUqWLNLNabXUnWbY0GO7Sq71sjQxooSMywKCXWZs1+W+cUMYAc+Q4xO
         q01br1aO/eOw7tLRyYj+3Z8Q1gAreyoXUWdMO3FxMdle+Pp2/OY9/j4XgCaO/HIVfnFU
         P3929QumMgDk0dZAw1GHr6Mp2+i5u6Wug3dEuT6s89Mk7lr+96c8m2GjW4hEAB+NamJe
         frYlXxl1nKDOl39nwNF/tIbBfmo5ZT9/EFliUDIzSqyvzDj6kiE4DtOt2ju0G7YmePMw
         5iQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GLxbOsKrj+41tYk9dkpkBuXY/atPIL9l6AonM3LYA/ZlNVOvV17r1O2HjcIrwBaba6tnXvXBPvViaWhGdwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HtM/9EAJJJi8t+EpOMbXlF0JUJsmVbgV4bmOANZK/CEHIA+1
	rCVvWc5OWyoElTu6awDH1E69+iUckeFw/4+X7wMvZJMKDW5gwMp54xsutFQaeZwL6BqOzOcS2yM
	iQoje8T8V8kHE7lIkqNQeRWZC+ULh2E80r9EuQg4FE2/xyRPoSQb4qzPE/zU=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2901:b0:694:9d3d:e040 with SMTP id
 006d021491bc7-6949d3de22cmr7931783eaf.31.1776990210905; Thu, 23 Apr 2026
 17:23:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:23:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eab802.a00a0220.17a17.0049.GAE@google.com>
Subject: [syzbot] [wireless?] [usb?] KASAN: stack-out-of-bounds Write in carl9170_handle_command_response
From: syzbot <syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com>
To: chunkeey@googlemail.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 459DA4588F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=37c3a614a8bc8d27];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35256-lists,linux-wireless=lfdr.de,5c1ca6ccaa1215781cac];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com,vger.kernel.org,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]

Hello,

syzbot found the following issue on:

HEAD commit:    2e6803928193 Merge tag 'tracefs-v7.1-2' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=113342ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c3a614a8bc8d27
dashboard link: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12acb1ba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16acb1ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/592131f484c3/disk-2e680392.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ca791aa3d9c/vmlinux-2e680392.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3aaca7d6d8d9/bzImage-2e680392.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com

usb 4-1: received invalid command response:got 60, instead of 0
usb 4-1: restart device (9)
usb 4-1: received invalid command response:got -2, instead of 0
usb 4-1: received invalid command response:got 60, instead of 4
==================================================================
BUG: KASAN: stack-out-of-bounds in carl9170_cmd_callback drivers/net/wireless/ath/carl9170/rx.c:153 [inline]
BUG: KASAN: stack-out-of-bounds in carl9170_handle_command_response+0x21f/0xc50 drivers/net/wireless/ath/carl9170/rx.c:168
Write of size 60 at addr ffffc900001e7a38 by task swapper/1/0

CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
 carl9170_cmd_callback drivers/net/wireless/ath/carl9170/rx.c:153 [inline]
 carl9170_handle_command_response+0x21f/0xc50 drivers/net/wireless/ath/carl9170/rx.c:168
 carl9170_usb_rx_irq_complete+0xfc/0x1b0 drivers/net/wireless/ath/carl9170/usb.c:307
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xda1/0x36c0 drivers/usb/gadget/udc/dummy_hcd.c:2005
 __run_hrtimer kernel/time/hrtimer.c:1930 [inline]
 __hrtimer_run_queues+0x470/0xa00 kernel/time/hrtimer.c:1994
 hrtimer_run_softirq+0x17d/0x2c0 kernel/time/hrtimer.c:2011
 handle_softirqs+0x1dd/0x9e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x160/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: d4 b4 01 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 63 9d 15 00 fb f4 <e9> 7c f2 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc9000013fe00 EFLAGS: 00000246
RAX: 0000000000046e1b RBX: ffff8881022d9dc0 RCX: ffffffff8770e3f5
RDX: 0000000000000000 RSI: ffffffff890d1d42 RDI: ffffffff87b03fe0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed103eae673d
R10: ffff8881f57339eb R11: 0000000000000000 R12: 0000000000000001
R13: ffffed102045b3b8 R14: 0000000000000001 R15: ffffffff8af1a1d0
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x464/0x590 kernel/sched/idle.c:352
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:451
 start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x148
 </TASK>

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc900001e0000 allocated at kernel_clone+0x12e/0x9c0 kernel/fork.c:2723
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102aa7
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 ffffea00040aa9c8 ffffea00040aa9c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 2543325669, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0xf34/0x3a90 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x273/0x28a0 mm/page_alloc.c:5226
 __alloc_pages_noprof+0xb/0x110 mm/page_alloc.c:5260
 __alloc_pages_node_noprof include/linux/gfp.h:289 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:316 [inline]
 vm_area_alloc_pages mm/vmalloc.c:3655 [inline]
 __vmalloc_area_node mm/vmalloc.c:3878 [inline]
 __vmalloc_node_range_noprof+0xe0c/0x1630 mm/vmalloc.c:4064
 __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:357 [inline]
 dup_task_struct kernel/fork.c:926 [inline]
 copy_process+0x7fb/0x7d20 kernel/fork.c:2088
 kernel_clone+0x12e/0x9c0 kernel/fork.c:2723
 kernel_thread+0xdb/0x120 kernel/fork.c:2784
 create_kthread kernel/kthread.c:459 [inline]
 kthreadd+0x498/0x7a0 kernel/kthread.c:817
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc900001e7900: f1 f1 f1 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00
 ffffc900001e7980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900001e7a00: 00 f1 f1 f1 f1 f1 f1 04 f2 04 f3 f3 f3 00 00 00
                                        ^
 ffffc900001e7a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900001e7b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	b4 01                	mov    $0x1,%ah
   2:	c3                   	ret
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	0f 1f 00             	nopl   (%rax)
   a:	90                   	nop
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
  1a:	f3 0f 1e fa          	endbr64
  1e:	66 90                	xchg   %ax,%ax
  20:	0f 00 2d 63 9d 15 00 	verw   0x159d63(%rip)        # 0x159d8a
  27:	fb                   	sti
  28:	f4                   	hlt
* 29:	e9 7c f2 02 00       	jmp    0x2f2aa <-- trapping instruction
  2e:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  35:	00 00 00
  38:	66 90                	xchg   %ax,%ax
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop


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

