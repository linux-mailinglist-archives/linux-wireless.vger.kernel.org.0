Return-Path: <linux-wireless+bounces-14575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33599B187C
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724C6283749
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779D1D514B;
	Sat, 26 Oct 2024 13:25:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB54524B0
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729949134; cv=none; b=TKYr69J1DRHssCYxHpfV+ByFKgcax8d9LvV+XDh2KrM5DHYpRkbvA+AmCp67l8c4U1R5qgyBxl7AAZ9mb05Inb89h0842f6DH9HZtbOuBvM69NNtwT5V4L4U1iTr2aPKXLe0KKt/X1eIGcLmNruyvDnoOHOcoiEIvn78otKPB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729949134; c=relaxed/simple;
	bh=GhmHdJ+4pNLy7iWgN9j7zY+dW5m1eVU+K6+zPu/Z2uM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r6RR6pujK2a3T+Nu9IYyz323tADCU8On9ap8cg1ypsMIOUeKG0OHZEJaZjVZSx2Pwh3jotXecqXUJ4guCFtyn0JGpgybtgxaVQvLApal6BVl7QJxIsxeGd0o7YcUcgU/0q06BsRRj8dPOf5h+7tTWwDokADUYYiNvsZiTn9A6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so27041225ab.2
        for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 06:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729949131; x=1730553931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfkXRKLJ4HbA5RgynTiFyTurAHiLPqLUDl0xh+O0VSM=;
        b=l5TRFhkGOJ+XpKr9HnFGUsL98ViG8UdpypKW+0o6rR3OtGW8Mqtighwxx+PE6m1OA9
         ukg5w7CE2oKifi9e35CxlmEZPQnFurxfSfmK52ry0mPlXPIahgI1HWFbT3Q/vPYv3sY2
         AN93cL7qZA93eJr7/x9Vwrt+GNIhYpr5jtq1XPUIYr+bwjqS2d7uSZqQq5dixo9ZFcul
         6cFGoEQoPdvSWvMiFTTCVPqa+z9PnJCQ/vTEeK9BCe2Ez6z7+Zldzs1eL9SWj+3Iu6RB
         9pnwxZf/R3+hmrbZvNb0GimA+y9a0gjbL+NRCLg/6CUNYwHfMWel3EBTCPn3l4fUXcur
         pxQw==
X-Forwarded-Encrypted: i=1; AJvYcCWz1q5W9QHHID3YWGeZtk1F4mNp2DNbeWnQOCCHxk6m+4MHp8CA+2eNYgiIzl8SE0CpG29hlS9dv3nkAwsAFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rOk10HheCzftCnaoHlJ4vPsmm8zhKpoUR2fPUlVdIYc5i1Yl
	ZtYjIfFXtrdbl8MVmrvEx8hHHMpqVGAA91Mkz2Ogk4GQedVyjvMqa7IzbS/KPckIZrF9HX/Ezpf
	lVEe8eejvriqdyxcE/lPzThSnxH+00YUhRplqfpIX5sG34L+hnIpkOlQ=
X-Google-Smtp-Source: AGHT+IF+RKtdQ7niw+Z1kmuGVHe2opA1h0sf+5gDW54roTrFeMk3ovms8Gb0nKg3yXg9Ihx/atUsyiHaTrvJ6t/NDBFfXeX3Kd17
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:3a3:b527:e809 with SMTP id
 e9e14a558f8ab-3a4ed2b380emr19494565ab.14.1729949131445; Sat, 26 Oct 2024
 06:25:31 -0700 (PDT)
Date: Sat, 26 Oct 2024 06:25:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671cedcb.050a0220.2b8c0f.01b1.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in __rate_control_send_low (3)
From: syzbot <syzbot+34463a129786910405dd@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b423f5a9a61f Merge tag 'acpi-6.12-rc5' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13307287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd919c0fc1af4272
dashboard link: https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49d1d501eff9/disk-b423f5a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f973ba06cb5d/vmlinux-b423f5a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a97302c30f3f/bzImage-b423f5a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34463a129786910405dd@syzkaller.appspotmail.com

------------[ cut here ]------------
no supported rates for sta (null) (0xffffffff, band 0) in rate_mask 0xfff with flags 0x40
WARNING: CPU: 1 PID: 8687 at net/mac80211/rate.c:385 __rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Modules linked in:
CPU: 1 UID: 0 PID: 8687 Comm: syz-executor Not tainted 6.12.0-rc4-syzkaller-00245-gb423f5a9a61f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Code: 8b 14 24 0f 85 de 01 00 00 8b 0a 48 c7 c7 60 a2 29 8d 48 8b 74 24 10 44 89 f2 44 8b 44 24 1c 44 8b 4c 24 0c e8 08 3a 27 f6 90 <0f> 0b 90 90 e9 71 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c db
RSP: 0018:ffffc90000a18760 EFLAGS: 00010246
RAX: aaade33c9e18e500 RBX: 000000000000000c RCX: ffff88802e721e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807ff708e8 R08: ffffffff8155e372 R09: fffffbfff1cf9fe0
R10: dffffc0000000000 R11: fffffbfff1cf9fe0 R12: 0000000000000800
R13: 000000000000000c R14: 00000000ffffffff R15: dffffc0000000000
FS:  000055556cf87500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fda1a8656c0 CR3: 000000004651a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rate_control_send_low+0x1a8/0x770 net/mac80211/rate.c:405
 rate_control_get_rate+0x20e/0x5e0 net/mac80211/rate.c:921
 ieee80211_beacon_get_finish+0x49e/0x870 net/mac80211/tx.c:5253
 __ieee80211_beacon_get+0xf7e/0x15c0
 ieee80211_beacon_get_tim+0xb4/0x320 net/mac80211/tx.c:5594
 ieee80211_beacon_get include/net/mac80211.h:5607 [inline]
 mac80211_hwsim_beacon_tx+0x39d/0x850 drivers/net/wireless/virtual/mac80211_hwsim.c:2311
 __iterate_interfaces+0x222/0x510 net/mac80211/util.c:774
 ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:810
 mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1772
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 da 2a 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90003a97060 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000752e18 RCX: aaade33c9e18e500
RDX: dffffc0000000000 RSI: ffffffff8c0adcc0 RDI: ffffffff8c602f60
RBP: ffffc90003a971b0 R08: ffffffff94297807 R09: 1ffffffff2852f00
R10: dffffc0000000000 R11: fffffbfff2852f01 R12: 1ffff92000752e14
R13: dffffc0000000000 R14: ffffc90003a970c0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:941 [inline]
 pfn_valid+0x113/0x450 include/linux/mmzone.h:2043
 page_table_check_set+0x22/0x540 mm/page_table_check.c:110
 __page_table_check_ptes_set+0x30f/0x410 mm/page_table_check.c:225
 page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
 set_ptes include/linux/pgtable.h:267 [inline]
 __copy_present_ptes mm/memory.c:969 [inline]
 copy_present_ptes mm/memory.c:1052 [inline]
 copy_pte_range mm/memory.c:1167 [inline]
 copy_pmd_range+0x4773/0x85f0 mm/memory.c:1255
 copy_pud_range mm/memory.c:1292 [inline]
 copy_p4d_range mm/memory.c:1316 [inline]
 copy_page_range+0x99f/0xe90 mm/memory.c:1414
 dup_mmap kernel/fork.c:750 [inline]
 dup_mm kernel/fork.c:1674 [inline]
 copy_mm+0x11fb/0x1f40 kernel/fork.c:1723
 copy_process+0x1845/0x3d50 kernel/fork.c:2372
 kernel_clone+0x223/0x880 kernel/fork.c:2784
 __do_sys_clone kernel/fork.c:2927 [inline]
 __se_sys_clone kernel/fork.c:2911 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2911
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda19b74f93
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffd5c989de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fda19b74f93
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 000055556cf877d0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000074fbe R14: 0000000000074f90 R15: 00007ffd5c989f70
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 da 2a 8b 00       	call   0x8b2ae6
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

