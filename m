Return-Path: <linux-wireless+bounces-11052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE0949DC1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 04:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2851C21EB0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 02:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C518FDAB;
	Wed,  7 Aug 2024 02:28:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16E15D5C1
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722997705; cv=none; b=rg1ZrtSOz5KJGRFfS70XyHMUgRs1R2qIXB1xlb11gfz9ugz+zFS6D8/QjyrErD+96z8P5RpMVNAxjAZii0fAOJ+b7S/ysi+rGzAnuz71adic42swGtxUitOvJxKh8PM8mU9y+pbQDK7vaCgKhoORNBD4iMVEH7uvCK1dld9EM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722997705; c=relaxed/simple;
	bh=EpVgDADjB4ANAZA0IVfz8OYkF0lVVjRdBzBcsG76NCU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RawFgn/D3u3jJwq3Qn6cI4eG283XncAHAVTkUpb7fnoorbkaaLdr1Q4gzzjrrA6ZaWOYU7pGrnXQW1lmJkExlHgo+XgHTgYgoiwf9fwA2xPPV+CAVl/vTEN868adjUUfCyw15GLrJ72533u8DbkB65NzG7NlH462NIYQOaxjiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f81da0972so181905639f.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 19:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722997702; x=1723602502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b63ulpSsTJ/M3oHsfyP9cG1id9lbFxZe5s9TDNIe39I=;
        b=c5pUFATAUZAWd34KJf3Gkmgxe8um8ICg2jSIBkOpvDruJIxQPU9a7ryLjuNIC9C6Qn
         ScDZq3LfP/aDMWiiZPCg1Wcn82A1oSkpQ97FTuQY/1bCqhDs233RXqY8WZEe/LF4CIwG
         Gg6xeNEZDPuOLAcZSLv2nV7ZY/VMKkGFE090lroI2PwLVQ7/AWpo1ZyNkxbUr5y1h3Q/
         IgDjW7GXgUSZO+LAQu/SLZa/IvZRDvu4J6zZfc3QA+1046Oe2PBSWPpqjVSqVQe5B+CN
         vUtMyxaY5yPwzfxk5XUVpsiT/R++jir9iYiFY+aABb2PLEdPdbRO6GSU9OLGps3DfJ8O
         tbVA==
X-Forwarded-Encrypted: i=1; AJvYcCUVYoowSQl5xz9/6plR8UyHk039ul2fEoUhFnzGQc3l9JtkGCKCwqMO3xRQDu95eXM36OPc82uLB9052i3LnxL8N+7g5u9tjLCaXR/yPa0=
X-Gm-Message-State: AOJu0Yy1xxunQJS7jHHlWdOVwXqH6htvIMMOtNkAB2+DYiFvNF8HqHS3
	O+T3oklDPR4/EarpSz7f2SLlQG7S4b6OoXWqhDxy84R28lH1pkbL/ydtwPA/HGIhLdiD84fE+ev
	Sx5btzPC2s8tSZChhMQw9z+Sq9/FxXsoApJhA3iYIn02EgzxJQb8ZOEc=
X-Google-Smtp-Source: AGHT+IF+2n7zn1UfCFOp6DlJf8yHFKu+OeqlDS+oZR+GYXF9k4iHMjrhU+HvfHdld3YLfNtgxmOXqDf/ZpuKeuOtBmhjaBq0/Uup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c8d560a101mr652771173.2.1722997702349; Tue, 06 Aug 2024
 19:28:22 -0700 (PDT)
Date: Tue, 06 Aug 2024 19:28:22 -0700
In-Reply-To: <00000000000007103b061af41e81@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff6cbe061f0ea910@google.com>
Subject: Re: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_handle_queued_frames
From: syzbot <syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb5e56d14912 Merge tag 'platform-drivers-x86-v6.11-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11536623980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1766fe4b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2044b21f4b5/disk-eb5e56d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad2274fd812e/vmlinux-eb5e56d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd82f6220580/bzImage-eb5e56d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 3872 jiffies s: 3369 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5298 Comm: kworker/0:3 Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 89 fb e8 23 00 00 00 48 8b 3d bc 7c 74 0c 48 89 de 5b e9 43 61 58 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 00 d7 03 00 65 8b 15 a0 60
RSP: 0018:ffffc90000005af0 EFLAGS: 00000002
RAX: 0000000000010302 RBX: ffffc90000005b68 RCX: ffffffff91523000
RDX: ffff88802a1f1e00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff814115f8 R09: ffffffff814130bf
R10: 0000000000000003 R11: ffff88802a1f1e00 R12: ffff88802a1f1e00
R13: ffffffff817f1c90 R14: dffffc0000000000 R15: 1ffff92000000b6d
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f729d8d2000 CR3: 000000000e534000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 unwind_get_return_address+0x71/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 dummy_urb_enqueue+0x7d/0x760 drivers/usb/gadget/udc/dummy_hcd.c:1271
 usb_hcd_submit_urb+0x36c/0x1e80 drivers/usb/core/hcd.c:1533
 __usb_hcd_giveback_urb+0x42c/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x830/0x45a0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:_ieee802_11_parse_elems_full+0xbda/0x4a40 net/mac80211/parse.c:346
Code: 24 a0 03 00 00 4c 89 ee 48 8b 54 24 40 e8 9e 7d 84 f9 89 c3 43 0f b6 04 3e 84 c0 0f 85 20 33 00 00 89 9c 24 a0 03 00 00 eb 16 <e8> f1 fc 67 f6 eb 15 e8 ea fc 67 f6 49 bf 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90000006880 EFLAGS: 00000246
RAX: 0000000000000301 RBX: 0000000000000000 RCX: ffff88802a1f1e00
RDX: ffff88802a1f1e00 RSI: 0000000000000003 RDI: 0000000000000040
RBP: ffffc90000006c90 R08: ffffffff8b2b78b7 R09: 1ffff92000000d7c
R10: dffffc0000000000 R11: fffff52000000d7d R12: ffff888056ebf32f
R13: ffff888056ebf32f R14: 0000000000000003 R15: dffffc0000000000
 ieee802_11_parse_elems_full+0xdff/0x2880 net/mac80211/parse.c:984
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2361 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2368 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0xe93/0x2030 net/wireless/scan.c:2335
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
 cfg80211_inform_bss_frame_data+0x3b8/0x720 net/wireless/scan.c:3254
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5462
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5124 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
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
RIP: 0010:check_kcov_mode kernel/kcov.c:175 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x2f/0x90 kernel/kcov.c:311
Code: 8b 04 24 65 48 8b 0c 25 00 d7 03 00 65 8b 05 c0 5b 70 7e a9 00 01 ff 00 74 10 a9 00 01 00 00 74 57 83 b9 1c 16 00 00 00 74 4e <8b> 81 f8 15 00 00 83 f8 03 75 43 48 8b 91 00 16 00 00 44 8b 89 fc
RSP: 0018:ffffc900041660f8 EFLAGS: 00000246
RAX: 0000000000000001 RBX: fffffffffffe6fc8 RCX: ffff88802a1f1e00
RDX: ffff88802a1f1e00 RSI: fffffffffffe6fc8 RDI: 0000000000000001
RBP: ffffc900041662b0 R08: ffffffff81748c01 R09: ffffffff81748a2e
R10: 0000000000000003 R11: ffff88802a1f1e00 R12: dffffc0000000000
R13: 00000000000008f4 R14: 1ffff9200082cc43 R15: 0000000000000002
 desc_read_finalized_seq kernel/printk/printk_ringbuffer.c:1894 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1922 [inline]
 _prb_read_valid+0x461/0xac0 kernel/printk/printk_ringbuffer.c:2113
 prb_read_valid+0xa9/0xf0 kernel/printk/printk_ringbuffer.c:2182
 printk_get_next_message+0x1ee/0xbe0 kernel/printk/printk.c:2895
 console_emit_next_record kernel/printk/printk.c:2950 [inline]
 console_flush_all+0x410/0xfd0 kernel/printk/printk.c:3049
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3118
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2348
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4909
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4920
 _dev_info+0x122/0x170 drivers/base/core.c:4978
 line6_probe+0x997/0xbc0 sound/usb/line6/driver.c:809
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:657
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:799
 driver_probe_device+0x50/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1029
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3679
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
 really_probe+0x2b8/0xad0 drivers/base/dd.c:657
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:799
 driver_probe_device+0x50/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1029
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3679
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

