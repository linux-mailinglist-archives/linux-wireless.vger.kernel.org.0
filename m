Return-Path: <linux-wireless+bounces-9020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E59099F2
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800D91F21B7E
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4EA5338D;
	Sat, 15 Jun 2024 21:07:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4A2E40E
	for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718485643; cv=none; b=QmZqzybUXUwi0b6JsCefVuXj+YWvFKN6juRkuqiBFMPGA/B6Q16BAdayabCICEq48mTOOJ6eeNiA9JL6RsXql2MdzuxxnqcG9EV6pEKyiCWOjfi6tX77neY4hmDeVcz1M/DJP0X6poqxyJln1ZirfMyLajk2UTpBk0nMNIBEwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718485643; c=relaxed/simple;
	bh=oIUgPiaYSp/NEK0WzoC1xk7bbgSVebyWs99Fz+L6Lvc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YsL5QsDQLS12UnbplnCAc0if8aTL2Vc9vUiNNVnRF+S9dXCYsplvm8RVeS76wXm5PIUzk4Wl7CI+9nQBGj2K+N5zS1rMqdgMkerQGsARZv2UZhib/GZ8GvSRrrpdlnjsZHGaszXl5Ul9wCfcPJz0oq1APFzmbWHkfkVIVIHW3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eafdb25dbbso318291139f.3
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2024 14:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718485638; x=1719090438;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6XzJipWUw7H1rKjAXe6PkGM1ph+69Xy4ABX+ED2WIM=;
        b=DQW4MGpkT0MxXykeC4XHZUMIHMkhGamUzNK/a+JnBgm+dSnRwZ2TF/HQWgkuUNDFuJ
         CVWB6hpqn6g8IxwQtvlzh//vhYRnnutoCzs+AaD35M1BhvLQ3Uj03SU9hL1jvS3IVr+2
         e9fQgm93uX1p4kxd/jrkkGOR017J/ykwYniabM7KBFnr15Et4w3/hPxtrWY7Y0bfo3n9
         +UN8DSNPhepZdy9VqHET6TMY08UoaIrwGB49Q+0yjSQMvCjSX7MWkAJbm9Gj1caw+hAa
         BMaJzCzXRUqUqKGbGJd9qNrapKY7qcfnaj5tauKjVpwAydOSYsOBz5I8CE80hH4Hs1tw
         HvkA==
X-Forwarded-Encrypted: i=1; AJvYcCVoNLyrEYS0Qll47+5t7evBw86PQa++NabE57wq0kvsNgkaoEVGFSQ4e8kpGwVPvEjZZ8l92PFTil6156qiBBkcZiMRIZEDqjrsaP6cjxk=
X-Gm-Message-State: AOJu0YzbR6/rgPV0hZDpy5b+dicwB1YiX+rnYhl8k2tisRAQZtpJNhfZ
	5NkUIcwQMApRo0Vm14+BL+Xym2lHw5Tu5YMI5gcR7bz6F+9v6LE6HBQMHnr8xVtPgJ1P8RRdc5p
	cEW+9swvdFQ5Z2Zh3n2WXxzpiB2h0WKYv+T27T/I0bAQptgHTSOBcyBU=
X-Google-Smtp-Source: AGHT+IGmT4+f19lcvYthU3k3VeCBn+Y9dvsPz86VuL60XCIhGPuAwNrOYXBldM/xalSnI5tpcTE6nICsc2dvEiVriznD5hA1xfd1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:375:d682:bfe3 with SMTP id
 e9e14a558f8ab-375e1023db7mr3005215ab.6.1718485638380; Sat, 15 Jun 2024
 14:07:18 -0700 (PDT)
Date: Sat, 15 Jun 2024 14:07:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007103b061af41e81@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_handle_queued_frames
From: syzbot <syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1435caa2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93525a95fe83/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9b895227ea2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e825248a8e73/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-....
 } 2688 jiffies s: 4485 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
cdc_wdm 2-1:1.0: nonzero urb status received: -71
NMI backtrace for cpu 0
CPU: 0 PID: 5164 Comm: kworker/0:4 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:delay_tsc+0x5c/0xe0 arch/x86/lib/delay.c:79
Code: 90 48 89 d5 48 c1 e5 20 48 09 c5 48 29 dd 4c 39 f5 73 67 bf 01 00 00 00 e8 a1 dc e2 f5 65 8b 05 52 16 81 74 85 c0 74 2f f3 90 <bf> 01 00 00 00 e8 ea da e2 f5 e8 75 f6 03 00 41 39 c7 75 20 0f 01
RSP: 0018:ffffc900000059b8 EFLAGS: 00000002
RAX: 0000000000010304 RBX: 0000005d4514b881 RCX: 0000000000010305
RDX: 000000000000005d RSI: ffffffff8c1ff820 RDI: 0000000000000001
RBP: 0000000000000790 R08: ffffffff853c4fea R09: 1ffff11003efc046
R10: dffffc0000000000 R11: ffffffff8b82be60 R12: dffffc0000000000
R13: 00000000000026fd R14: 0000000000000899 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020079000 CR3: 000000002d058000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2074 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3315 [inline]
 serial8250_console_write+0x104e/0x1770 drivers/tty/serial/8250/8250_port.c:3393
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
RIP: 0010:memset_orig+0x75/0xb0 arch/x86/lib/memset_64.S:90
Code: 89 47 30 48 89 47 38 48 8d 7f 40 75 d8 0f 1f 84 00 00 00 00 00 89 d1 83 e1 38 74 14 c1 e9 03 66 0f 1f 44 00 00 ff c9 48 89 07 <48> 8d 7f 08 75 f5 83 e2 07 74 0a ff ca 88 07 48 8d 7f 01 75 f6 4c
RSP: 0018:ffffc90000006a00 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90000006b18 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffc90000006b38
RBP: ffffc90000006b28 R08: ffffc90000006b3f R09: 0000000000000000
R10: ffffc90000006b30 R11: fffff52000000d68 R12: ffffc9000448efd8
R13: dffffc0000000000 R14: ffffc90000006b30 R15: 1ffff92000000d5c
 unwind_next_frame+0x13ab/0x2a00 arch/x86/kernel/unwind_orc.c:592
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x149/0x360 mm/slub.c:4558
 ieee80211_inform_bss+0xbb2/0x1080 net/mac80211/scan.c:160
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x1121/0x2360 net/wireless/scan.c:2293
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5222 [inline]
 ieee80211_rx_list+0x2b00/0x3780 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:437
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
Code: 2b 00 74 08 4c 89 f7 e8 2a 84 89 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000448ebc0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000891d84 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcacd00 RDI: ffffffff8c1ff840
RBP: ffffc9000448ed20 R08: ffffffff92fab58f R09: 1ffffffff25f56b1
R10: dffffc0000000000 R11: fffffbfff25f56b2 R12: 1ffff92000891d80
R13: dffffc0000000000 R14: ffffc9000448ec20 R15: 0000000000000246
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 kernfs_remove_by_name_ns+0x7a/0x160 fs/kernfs/dir.c:1689
 sysfs_remove_file include/linux/sysfs.h:764 [inline]
 device_remove_file drivers/base/core.c:3103 [inline]
 device_links_driver_bound+0x13c/0xea0 drivers/base/core.c:1334
 driver_bound+0xd8/0x2c0 drivers/base/dd.c:408
 really_probe+0x7f4/0xad0 drivers/base/dd.c:706
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1028
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3721
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
 really_probe+0x2b8/0xad0 drivers/base/dd.c:656
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1028
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3721
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb status received: -71
cdc_wdm 2-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 2-1:1.0: nonzero urb stat

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

