Return-Path: <linux-wireless+bounces-23810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C737AD0773
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 19:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A274A189DA6E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295128A3F8;
	Fri,  6 Jun 2025 17:24:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477628A1FA
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230676; cv=none; b=pl47M2OePNIs4Um/IaKv9Au8mghV5bWlEq2dlgNZy14SBYxKduHdJOipAgEYEbW/ozNBcm6tph5QajmuYVc9VQjX0moMM64tk/t7FDNnoNuEQI2lxtRfjETJ5vuch6dm06ifEfOFv3ZlocDoSe1SJx+UUt16a/mL66I7+Hxdm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230676; c=relaxed/simple;
	bh=OfmI4hYuk7S0k7xDrzF8qpyHJ4ezPJC4LnnM2RV3zJg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JutDasS4vGJhFv8d+Ydj2kaR4cubJnrmGM61Csw4BK7wezDk5+skIrnq6awoVawi82VN5LpuhhUd/Ozcu+do2EwFN6RRkpA5ZHF50sVMpgXKLT83mH55kRO7aS7eV4tOK7RryI7qPG7KQY8Z2RZgFFBvC36KEesZJHqo9Z98l/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8649be94fa1so374489939f.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 10:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749230674; x=1749835474;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAVXPMJdCcVOsE8gmQnKvDRTVEWIXrEwrI1rszWDhOs=;
        b=m8BPDMtd95FEX4QOFtYKRB4lgrm0OZvtpA6XiTe2RV2ZNLKtiok3+QKFTNFMDPRt6m
         SEmZPlBrRYKO8yWt97L8i1KF6mSTiEZsLtRRSCO7XBEv4n1IV+rjQebgzfgt7QWl8Vnw
         LA53y8mOvVUHY0H5ZBVlQL4ddlRALDrRGHTxki/sdYNp7DFYJBgM6pxEjPfImq0Z4aNs
         6C7F/jeJQODdh9Vs5SoWiEQxF25cET7hRIsXzlVgrYP4Oy28Tbz3g5xco+9jaNNdeQBR
         itpUqARYiHNkHa46F/uLLnlBvUfSdZ5CCF91tv0w0yCphop8bZvG4ZcCvcvaJTjohoyW
         iVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSIFkj4k8VspngrMXjmPHhoYh7HX7X8SS/yRe45YFrx4GUXDTi3fPAlZbgKTBF7wgQf5mj/ZR/BbwRAkMhxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQdd8b1OoTnfPTJtHhaTSKPgT4rNGFA82Owbbe5gPcKRwAS0m
	wJkH0AFlU3rWC/mtZY3AVP/BKrmrsKYWSrSFkD+1r48Ae7Ftph5WiqBM/MlClvj9gjo8hsKM5Hy
	KB94cRq/wCOrBbpcKBRTYcIwD3W14VZ/6xmqJI6MF67IJFqwDASAnzxzIQVs=
X-Google-Smtp-Source: AGHT+IEzZYA8JWRsTTDM8ueo2eOwGEnueuWH/zYo7Cnlm+sskH68rYp7JXKFweqIhiROqV2jx3fypQGQof10pSlhgpQtqBb0vAvD
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250d:b0:3dc:7a9a:44d5 with SMTP id
 e9e14a558f8ab-3ddce530818mr58573735ab.22.1749230673994; Fri, 06 Jun 2025
 10:24:33 -0700 (PDT)
Date: Fri, 06 Jun 2025 10:24:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68432451.a00a0220.29ac89.0047.GAE@google.com>
Subject: [syzbot] [wireless?] general protection fault in carl9170_usb_rx_complete
From: syzbot <syzbot+0d8afba53e8fb2633217@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    882826f58b2c ALSA: usb-audio: qcom: fix USB_XHCI dependency
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=113fc1d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc73a376913a3005
dashboard link: https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba180c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a9d80c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/211f4b32c93c/disk-882826f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b1eeb82b8a1/vmlinux-882826f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4696fbe4f76/bzImage-882826f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d8afba53e8fb2633217@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 38 Comm: kworker/1:1 Not tainted 6.15.0-rc6-syzkaller-00177-g882826f58b2c #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:__queue_work+0x9d/0x10f0 kernel/workqueue.c:2256
Code: 85 db 0f 84 ae 04 00 00 e8 b0 da 33 00 49 8d 86 c0 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e8 0c 00 00 41 8b 9e c0 01 00
RSP: 0018:ffffc900001a8a48 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8148954e
RDX: 0000000000000038 RSI: ffffffff81489090 RDI: 0000000000000005
RBP: ffff88810ff73bd0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000000 R14: 0000000000000000 R15: 0100000000000004
FS:  0000000000000000(0000) GS:ffff8882692c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd9d9eca0c8 CR3: 0000000124b4e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 queue_work_on+0x15f/0x1f0 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:662 [inline]
 ieee80211_queue_work net/mac80211/util.c:906 [inline]
 ieee80211_queue_work+0x113/0x180 net/mac80211/util.c:899
 carl9170_usb_rx_complete+0x275/0x2b0 drivers/net/wireless/ath/carl9170/usb.c:448
 __usb_hcd_giveback_urb+0x38a/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x39b/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x180e/0x3a20 drivers/usb/gadget/udc/dummy_hcd.c:1994
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x1ff/0xad0 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1842
 handle_softirqs+0x205/0x8d0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfa/0x160 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x9a2/0xc60 kernel/printk/printk.c:3227
Code: 00 e8 72 c5 27 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 e0 08 20 00 48 85 db 0f 85 55 01 00 00 e8 62 0d 20 00 fb 4c 89 e0 <48> c1 e8 03 42 80 3c 38 00 0f 84 11 ff ff ff 4c 89 e7 e8 17 d3 7b
RSP: 0018:ffffc90000287438 EFLAGS: 00000293
RAX: ffffffff895ba678 RBX: 0000000000000000 RCX: ffffffff815c5dd0
RDX: ffff8881062b0000 RSI: ffffffff815c5dde RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff895ba678
R13: ffffffff895ba620 R14: ffffc900002874c8 R15: dffffc0000000000
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 dev_vprintk_emit drivers/base/core.c:4917 [inline]
 dev_printk_emit+0xfa/0x140 drivers/base/core.c:4928
 __dev_printk+0xf5/0x270 drivers/base/core.c:4940
 _dev_info+0xe4/0x120 drivers/base/core.c:4986
 show_string drivers/usb/core/hub.c:2369 [inline]
 show_string drivers/usb/core/hub.c:2365 [inline]
 announce_device drivers/usb/core/hub.c:2388 [inline]
 usb_new_device+0x94c/0x1a20 drivers/usb/core/hub.c:2644
 hub_port_connect drivers/usb/core/hub.c:5535 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5675 [inline]
 port_event drivers/usb/core/hub.c:5835 [inline]
 hub_event+0x2f85/0x5030 drivers/usb/core/hub.c:5917
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0x9d/0x10f0 kernel/workqueue.c:2256
Code: 85 db 0f 84 ae 04 00 00 e8 b0 da 33 00 49 8d 86 c0 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e8 0c 00 00 41 8b 9e c0 01 00
RSP: 0018:ffffc900001a8a48 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8148954e
RDX: 0000000000000038 RSI: ffffffff81489090 RDI: 0000000000000005
RBP: ffff88810ff73bd0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000000 R14: 0000000000000000 R15: 0100000000000004
FS:  0000000000000000(0000) GS:ffff8882692c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd9d9eca0c8 CR3: 0000000124b4e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 db                	test   %ebx,%ebx
   2:	0f 84 ae 04 00 00    	je     0x4b6
   8:	e8 b0 da 33 00       	call   0x33dabd
   d:	49 8d 86 c0 01 00 00 	lea    0x1c0(%r14),%rax
  14:	48 89 c2             	mov    %rax,%rdx
  17:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e e8 0c 00 00    	jle    0xd22
  3a:	41                   	rex.B
  3b:	8b                   	.byte 0x8b
  3c:	9e                   	sahf
  3d:	c0 01 00             	rolb   $0x0,(%rcx)


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

