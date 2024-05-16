Return-Path: <linux-wireless+bounces-7740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31A8C765A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5A1C21288
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49514EC49;
	Thu, 16 May 2024 12:27:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3F14E2EF
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862459; cv=none; b=nn59sUDWTjfU//HE+uR3Kqu+zeZh/tW5HFjxBUuLHYe3dxnvTUIJJ2eI62lmHoYCHStvsfmUEr30rAG3lbarZvwqKJrWn0K3Nj8yn3MynEB6SB+Kg8SvgDtdAHPWkUiEWoKcwbXwR+Sybd8EXGNZzEgvYIAfnPotrUJ2VAoyUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862459; c=relaxed/simple;
	bh=a4HubPexOTBOqbFMjHqVttve8ojXFdRbRT9rOe5bw2Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eQG+ocACTU5a2nKFpIfP3GOdnrT7UEd2b76SnIVV9sP66BFiVfZML28Z+n8E5cImOCVKmG/caJPsvn/9CNIgKcDHK4EEUGke2pxQeNHjpomFxJnaH7Ln75q/23AeyBgYp58yB5Mt1vHgj6F4b7mpY9HTv2MRpz90BS9GsejbVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ddf0219685so969055939f.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 05:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862455; x=1716467255;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hollIzfuvyY4mzuoRV6pA/0nn2FNKogAjQlQHvAQ2zA=;
        b=mQtCIimUOdNkX46Eog7wCQ56l+AsJst2ZuXfCYTXa6Dz6SaKZzccPu42Q9Ir7vtFPu
         5bVYcdLd68/WPNIUhy6dtMpo/a8AGzcQfIqDaRHOPh7IX8AXdMKlSJ+5LZfKjEqtJtoI
         dNZeFv3YlCAQxYj9gRHERbfZRt3qsqznwnPSRIAVqqToalRioKYeE33NDSuqnNbm8GGp
         GQZ1+z8LnzwddVS/ktaFRhj/RtEBIOvPoDGrRm7kkoQW7Pem57h8aCoohhsq2bxW/ARR
         nuWbb7ycRU/SDvASfiLACmkEb9r/RRGnKcxrGXwZLZe3SO0ps1uOoAou475UN31sMEme
         2Qjw==
X-Forwarded-Encrypted: i=1; AJvYcCXaf9aOp7JoT4MU8ofMPsvQLZU0epCy2b/6f+VulHTewss0SwFwxSXBfdBsFr7YN5Gn7k49Uk0LKk7xqwQKPMoxdsaN5h5C/fsjkC39b9o=
X-Gm-Message-State: AOJu0YwQxkMNtKjkBwNO9hgMjZUX4cNTvCF6tK/5GAHijHNaPbqIO8Je
	W686Qv4GnytGfrfw0UyOt72uBhcHvoS7GPflEz64qWTS5BXdnZeNxD3xTuP4ZiNG+ylOvU44GUF
	MAwrXIUAFXur5FmpdHzngnaWfzwOObbkQE3jRL2u7QI9Ygl3RMWAcJ9I=
X-Google-Smtp-Source: AGHT+IHTfTz8QuyTQX7AzjPGGD3sBmj2REv0b/feTJDcBc2ptKk1obRrvd21I04L+bWRI+NoyuJ02mxcQ1rriPStXxFNEYytKk+T
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1351:b0:7cc:2522:f5fd with SMTP id
 ca18e2360f4ac-7e1b51a9835mr114865139f.1.1715862455007; Thu, 16 May 2024
 05:27:35 -0700 (PDT)
Date: Thu, 16 May 2024 05:27:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d522c0618915ca3@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_tasklet_handler
 (2)
From: syzbot <syzbot+f05226202eb082367495@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75fa778d74b7 Add linux-next specific files for 20240510
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16dd4878980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=f05226202eb082367495
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b9e878980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149b705c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad9391835bcf/disk-75fa778d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d827b3da9a26/vmlinux-75fa778d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f32f0182388/bzImage-75fa778d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f05226202eb082367495@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2680 jiffies s: 1265 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
NMI backtrace for cpu 0
CPU: 0 PID: 932 Comm: kworker/0:3 Not tainted 6.9.0-rc7-next-20240510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events kfree_rcu_monitor
RIP: 0010:io_serial_out+0x7e/0xc0 drivers/tty/serial/8250/8250_port.c:413
Code: fc 89 e9 41 d3 e7 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 bc 16 bd fc 44 03 3b 44 89 f0 44 89 fa ee <5b> 41 5c 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c a7
RSP: 0018:ffffc90000005af0 EFLAGS: 00000002
RAX: 0000000000000037 RBX: ffffffff94ad81a0 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff853ebe3b R09: 1ffff11003f5b046
R10: dffffc0000000000 R11: ffffffff853ebdf0 R12: dffffc0000000000
R13: 0000000000000037 R14: 0000000000000037 R15: 00000000000003f8
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fca86df9120 CR3: 000000002a724000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial8250_console_write+0x1212/0x1770 drivers/tty/serial/8250/8250_port.c:3393
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
 __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2f/0x70 kernel/kcov.c:207
Code: 8b 04 24 65 48 8b 0c 25 00 d5 03 00 65 8b 15 70 b8 6d 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 1c 16 00 00 00 <74> 2c 8b 91 f8 15 00 00 83 fa 02 75 21 48 8b 91 00 16 00 00 48 8b
RSP: 0018:ffffc90000006b40 EFLAGS: 00000246
RAX: ffffffff8140e4ae RBX: ffffffff901f8b3c RCX: ffff888020eb5a00
RDX: 0000000000000102 RSI: ffffffff8ada315b RDI: ffffffff8ada3157
RBP: ffffffff8ada3157 R08: ffffffff8140e470 R09: ffffc90000006d10
R10: 0000000000000003 R11: ffffffff8181ea60 R12: ffffffff901f8b3c
R13: ffffffff901f8b40 R14: ffffffff8ada315b R15: ffffffff901f8b3c
 __orc_find arch/x86/kernel/unwind_orc.c:99 [inline]
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x54e/0x2a00 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x200/0x410 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 cfg80211_inform_single_bss_data+0xc8c/0x2330 net/wireless/scan.c:2249
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3101
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3191
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5222 [inline]
 ieee80211_rx_list+0x2b00/0x3780 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_tasklet_handler+0xeb/0x1f0 net/mac80211/main.c:438
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 6e 7a 66 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c3 3a d0 f5 65 8b 05 34 7a 6e 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000470f860 EFLAGS: 00000206
RAX: f29e92db5ec05e00 RBX: 1ffff920008e1f10 RCX: ffffffff8172dd7a
RDX: dffffc0000000000 RSI: ffffffff8bcab500 RDI: 0000000000000001
RBP: ffffc9000470f8f0 R08: ffffffff92fb25e7 R09: 1ffffffff25f64bc
R10: dffffc0000000000 R11: fffffbfff25f64bd R12: dffffc0000000000
R13: 1ffff920008e1f0c R14: ffffc9000470f880 R15: 0000000000000246
 debug_object_active_state+0x239/0x360 lib/debugobjects.c:945
 debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:3287 [inline]
 kvfree_rcu_bulk+0xc5/0x4e0 kernel/rcu/tree.c:3364
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3545 [inline]
 kfree_rcu_monitor+0x8a4/0x1020 kernel/rcu/tree.c:3563
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 6.222 msecs
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 5-1:1.0: nonzero urb status received: -71
cdc_wdm 5-1:1.0

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

