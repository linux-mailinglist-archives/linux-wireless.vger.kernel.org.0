Return-Path: <linux-wireless+bounces-8375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3F8D704B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558761F229F5
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEC152160;
	Sat,  1 Jun 2024 13:51:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075114267
	for <linux-wireless@vger.kernel.org>; Sat,  1 Jun 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249893; cv=none; b=TKRBmdnBzTigratckFEh1XGMLUI4PYNrS7XLKfbgLkDzH+Yp5bz81XAU5vcEtEEca4NG8QzQtneemQieud//WQ8gmnpeW+wLlG6cQnd3Dc75GFZrtETHKlIwnoR+pn1TRr1OkMmJ88fpTMaRfI1czTSg4bx9IctAb6kobzNkGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249893; c=relaxed/simple;
	bh=6rzelTnojdUWBHANqNNkUMfMvnuXyX4eHZblSph5lOA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GuU8FshJ8ufS8qTgjICgaLYMnz9H0joc1R5/n63iJ+vsjhh2WQ3eqaGUEZ7pKi5pcYyETyPPPMZr5VcLtztdC5m7v0WuAmtM3LNiIaHSwvJ6lLtv5b//iuPghCVCamLlBYeKakwhfmfhluev2IfrX30Ht2trd7yrF2ACVGr6FVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eacf25a50aso241842939f.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jun 2024 06:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249890; x=1717854690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58LmhbjmlKz43ioeIWw26dVSkRrj8dvo0ADJLoLddgo=;
        b=TQ+a0kYH/4HcgPQlecqH8U+7V/8izsk52wodhmD+575EPKjAt6kMCFnoEUahc90J1V
         eNfVNdtWAidrdFhPeBXNvI0XCq/P784UCcgiVOYp4ACwoBviY4Aa2joq6UMwy6D6BmNX
         5D86Z07lwUuG5rEIVrFAqKy58e/XColhfDYZ8sGqhbCZPtiaSDsxCDllSqYdtHE0QECV
         JD4aHoJR7ycLDpfptebwWvGvgxKlsic31wJQSKalYIqYGiJccTmf9r6zUOeCw/aU49Q7
         //SmofMygFjyJb/K2m895Zmm8CJHq8rtJnHyEBtm+ioCIHDaqoOIxT0FNdV5CGv4Zc+B
         7uCg==
X-Forwarded-Encrypted: i=1; AJvYcCWH87hEoN+i7zhlwmbU1uaRbzUv+nzYnVyUnfZw1r7TFRmCTCza2ugdlCT8mhRy/3+0bxnetrMxFHRtIZJIO0Qtsemp6KiOhJHCC0sBKKY=
X-Gm-Message-State: AOJu0YzehPcpw8xqo5PZuxByFosYORMBE3wsHEkTrx1GhCSUmMwcz8r0
	QFLjmJE6hTeDji14T+W/HpPWSbNwbJ1IixEXfneL/FSjd9GnwJBI261jRb2hq8+5Sem1zhUDwZJ
	bKFBhNy81ND0SJ/XDxJ2Su4YvhIhUKV3JKPejL/V8uwk7lKZ3kzFJGR4=
X-Google-Smtp-Source: AGHT+IGD27X1x3UEw9D5evcs90stWvdSZNXx1jyIBHaI5ZdbJ/E7PLBlyauQ5Lhe4mSIoPv1tCVh/YqT9SD3RtCqR8bAXUW37IZ+
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:7de:d6a0:d48b with SMTP id
 ca18e2360f4ac-7eafff21485mr19353039f.3.1717249890250; Sat, 01 Jun 2024
 06:51:30 -0700 (PDT)
Date: Sat, 01 Jun 2024 06:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b302650619d465cf@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in addrconf_rs_timer (6)
From: syzbot <syzbot+fecf8bd19c1f78edb255@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d8ec19857b09 Merge tag 'net-6.10-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c6b664980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/282b760bd233/disk-d8ec1985.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14997a2bb8f8/vmlinux-d8ec1985.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2a32d63e10a/bzImage-d8ec1985.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fecf8bd19c1f78edb255@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-....
 } 3899 jiffies s: 61477 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
NMI backtrace for cpu 0
CPU: 0 PID: 5161 Comm: kworker/0:6 Not tainted 6.10.0-rc1-syzkaller-00104-gd8ec19857b09 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events linkwatch_event
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:406
Code: 20 cc 59 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 01 8c bf fc 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c
RSP: 0018:ffffc90000006218 EFLAGS: 00000002
RAX: 1ffffffff2959c00 RBX: ffffffff94ace200 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 000000000003bd16 RDI: 000000000003bd17
RBP: 0000000000000000 R08: ffffffff853c4a56 R09: 1ffff11003ed1046
R10: dffffc0000000000 R11: ffffffff853c4a10 R12: dffffc0000000000
R13: 00000000000026b0 R14: 00000000000003fd R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ec30000 CR3: 00000000544c0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:117 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2068 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3315 [inline]
 serial8250_console_write+0x1099/0x1770 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:2928 [inline]
 console_flush_all+0x865/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_err+0x122/0x170 drivers/base/core.c:5017
 wdm_int_callback+0x41f/0xac0 drivers/usb/class/cdc-wdm.c:269
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x1019/0x2a00
Code: 1a 8e e8 aa 2c 55 00 83 fb 04 0f 84 e6 00 00 00 83 fb 03 0f 84 92 01 00 00 83 fb 02 0f 85 34 02 00 00 48 89 ac 24 80 00 00 00 <48> 8b 04 24 48 8d 58 08 49 89 de 49 c1 ee 03 43 80 3c 2e 00 74 08
RSP: 0018:ffffc90000007268 EFLAGS: 00000246
RAX: 0000000000000102 RBX: 0000000000000002 RCX: ffff8880254f0000
RDX: 0000000000000003 RSI: ffffffff8e1a1390 RDI: 0000000000000002
RBP: ffffffff90b9a375 R08: 0000000000000005 R09: ffffffff8140ef56
R10: 0000000000000003 R11: ffff8880254f0000 R12: ffffffff90b9a374
R13: dffffc0000000000 R14: ffffc90000007390 R15: 1ffff92000000e68
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2c0 mm/slub.c:4152
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ref_tracker_alloc+0x14b/0x490 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4038 [inline]
 netdev_hold include/linux/netdevice.h:4067 [inline]
 dst_init+0xee/0x490 net/core/dst.c:52
 dst_alloc+0x14f/0x190 net/core/dst.c:93
 ip6_dst_alloc net/ipv6/route.c:344 [inline]
 icmp6_dst_alloc+0x77/0x420 net/ipv6/route.c:3274
 ndisc_send_skb+0x32a/0x1380 net/ipv6/ndisc.c:489
 addrconf_rs_timer+0x36e/0x660 net/ipv6/addrconf.c:4039
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 br_device_event+0x5f0/0x970 net/bridge/br.c:89
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1374
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 __linkwatch_run_queue+0x44f/0x6c0 net/core/link_watch.c:234
 linkwatch_event+0x4c/0x60 net/core/link_watch.c:277
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (6455 ticks this GP) idle=6294/1/0x4000000000000000 softirq=58089/58092 fqs=2976
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:       24          2            0
rcu: 	cputime:    32494         22        20022   ==> 52490(ms)
rcu: 	(t=10500 jiffies g=67085 q=605 ncpus=2)
CPU: 0 PID: 5161 Comm: kworker/0:6 Not tainted 6.10.0-rc1-syzkaller-00104-gd8ec19857b09 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events linkwatch_event
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 89 fb e8 23 00 00 00 48 8b 3d 4c 9c 45 0c 48 89 de 5b e9 23 4c 5a 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 00 d5 03 00 65 8b 15 70 be
RSP: 0018:ffffc90000006788 EFLAGS: 00000286
RAX: 1ffff11002ae9832 RBX: ffff88801574c188 RCX: dffffc0000000000
RDX: ffffc90000006880 RSI: ffff888065a458c0 RDI: 0000000000000000
RBP: ffffffff8a0e6fb0 R08: ffffffff899dd35f R09: 1ffffffff25f50b0
R10: dffffc0000000000 R11: ffffffff8a0e6fb0 R12: ffffc90000006880
R13: dffffc0000000000 R14: ffff88801574c190 R15: ffff888065a458c0
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ec30000 CR3: 00000000544c0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ipv4_conntrack_defrag+0x29/0x5a0 net/ipv4/netfilter/nf_defrag_ipv4.c:65
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook+0x2c4/0x450 include/linux/netfilter.h:269
 __ip_local_out+0x3d9/0x4e0 net/ipv4/ip_output.c:118
 ip_local_out net/ipv4/ip_output.c:127 [inline]
 __ip_queue_xmit+0x1162/0x1b70 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2557/0x3b80 net/ipv4/tcp_output.c:1466
 tcp_ack_snd_check net/ipv4/tcp_input.c:5740 [inline]
 tcp_rcv_established+0x107e/0x2020 net/ipv4/tcp_input.c:6180
 tcp_v4_do_rcv+0x965/0xc60 net/ipv4/tcp_ipv4.c:1909
 tcp_v4_rcv+0x2d90/0x37b0 net/ipv4/tcp_ipv4.c:2345
 ip_protocol_deliver_rcu+0x225/0x430 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x33f/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 ip_local_deliver net/ipv4/ip_input.c:254 [inline]
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish+0x3be/0x4f0 net/ipv4/ip_input.c:580
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x75d/0xab0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5667 [inline]
 __netif_receive_skb_list_core+0x95a/0x980 net/core/dev.c:5715
 __netif_receive_skb_list net/core/dev.c:5767 [inline]
 netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5859
 gro_normal_list include/net/gro.h:515 [inline]
 gro_normal_one include/net/gro.h:528 [inline]
 napi_skb_finish net/core/gro.c:609 [inline]
 napi_gro_receive+0x5aa/0xc90 net/core/gro.c:639
 receive_buf+0x1d0a/0x3830 drivers/net/virtio_net.c:1985
 virtnet_receive drivers/net/virtio_net.c:2259 [inline]
 virtnet_poll+0x7f8/0x18c0 drivers/net/virtio_net.c:2362
 __napi_poll+0xcb/0x490 net/core/dev.c:6721
 napi_poll net/core/dev.c:6790 [inline]
 net_rx_action+0x7bb/0x10a0 net/core/dev.c:6906
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 br_device_event+0x5f0/0x970 net/bridge/br.c:89
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1374
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 __linkwatch_run_queue+0x44f/0x6c0 net/core/link_watch.c:234
 linkwatch_event+0x4c/0x60 net/core/link_watch.c:277
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes



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

