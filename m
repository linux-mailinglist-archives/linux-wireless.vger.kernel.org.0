Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCE728882E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 14:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbgJIMBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 08:01:20 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:45012 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbgJIMBT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 08:01:19 -0400
Received: by mail-il1-f207.google.com with SMTP id a14so6621087iln.11
        for <linux-wireless@vger.kernel.org>; Fri, 09 Oct 2020 05:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MT1UNnyQ3G/TDr93kc/krZOVauok931+REtPlLjk5Aw=;
        b=Fqo5G3q7ncEhsr1r611uOxA+ON7glJUw7R/HAiLZ7R9APu5ud2ZmZrfA7M5W+Q/gV9
         U1Ez/E3n6j7EG8jrpT44t7ovuCogHmjgRwwt1nzqABm48vxcz5aQOulUOcMAsFYk/Krl
         zhuTioMx0oN7O+SIyLOd5rez6Cp/x+/SAKnwBIUaHLvRhKcvO+RZgXaxlOd82BLHnLwa
         bkzqoom0mDbWuMBMMRmiOLjkaUF+n0by95E4qsU6ibF2bA80WBwRxZK/gfOGFS4/oGFu
         XrD+ou+pjdFS3qPDKB4uDUmKy1rbDkkBecWGJWzw01UdgW4qxlDjZeUQN5WrvjWEpkiX
         Y+IA==
X-Gm-Message-State: AOAM531bnmZs0H7NhE70Z8k34mJ0EDetIWB7p6vN4jmqC4I1Pj64jgFX
        L8ZbhExpzKQLDPj8NGYlIKa/wfufjlocDRZV+yP7prnfnaWb
X-Google-Smtp-Source: ABdhPJwL3AwxrovWgZvIqqQA2tpThbkQxSfRcYAXnfAOXQA2xmRsQzgaVzEwVxm7Y1lBF7NA+foIdnegbslynWkt19eE4hoN1GRA
MIME-Version: 1.0
X-Received: by 2002:a92:9fd5:: with SMTP id z82mr10167188ilk.262.1602244878385;
 Fri, 09 Oct 2020 05:01:18 -0700 (PDT)
Date:   Fri, 09 Oct 2020 05:01:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1c63d05b13bb4da@google.com>
Subject: KMSAN: uninit-value in skb_copy_bits
From:   syzbot <syzbot+1194d2235b6b0189a88d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johannes@sipsolutions.net,
        kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5edb1df2 kmsan: drop the _nosanitize string functions
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=155a804f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4991d22eb136035c
dashboard link: https://syzkaller.appspot.com/bug?extid=1194d2235b6b0189a88d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1194d2235b6b0189a88d@syzkaller.appspotmail.com

hrtimer: interrupt took 167180 ns
=====================================================
BUG: KMSAN: uninit-value in skb_copy_bits+0xf86/0x1050 net/core/skbuff.c:2195
CPU: 0 PID: 10409 Comm: syz-executor.1 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:201
 skb_copy_bits+0xf86/0x1050 net/core/skbuff.c:2195
 skb_copy+0x51e/0xb40 net/core/skbuff.c:1525
 mac80211_hwsim_tx_frame_no_nl+0x1f22/0x29e0 drivers/net/wireless/mac80211_hwsim.c:1446
 mac80211_hwsim_tx_frame+0x34d/0x370 drivers/net/wireless/mac80211_hwsim.c:1654
 mac80211_hwsim_beacon_tx+0x778/0xb80 drivers/net/wireless/mac80211_hwsim.c:1694
 __iterate_interfaces net/mac80211/util.c:737 [inline]
 ieee80211_iterate_active_interfaces_atomic+0x40a/0x610 net/mac80211/util.c:773
 mac80211_hwsim_beacon+0x11d/0x2e0 drivers/net/wireless/mac80211_hwsim.c:1717
 __run_hrtimer+0x7cd/0xf00 kernel/time/hrtimer.c:1524
 __hrtimer_run_queues kernel/time/hrtimer.c:1588 [inline]
 hrtimer_run_softirq+0x3bf/0x690 kernel/time/hrtimer.c:1605
 __do_softirq+0x2ea/0x7f5 kernel/softirq.c:299
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:23 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:50 [inline]
 do_softirq_own_stack+0x7c/0xa0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:396 [inline]
 __irq_exit_rcu+0x226/0x270 kernel/softirq.c:426
 irq_exit_rcu+0xe/0x10 kernel/softirq.c:438
 sysvec_apic_timer_interrupt+0x118/0x140 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:599
RIP: 0010:context_struct_compute_av+0x1442/0x34d0 security/selinux/ss/services.c:659
Code: 00 8b 02 89 44 24 30 45 31 e4 45 31 f6 31 c0 48 89 84 24 88 00 00 00 48 83 bc 24 f8 00 00 00 00 75 2b 48 8b bc 24 30 01 00 00 <8b> 1f e8 77 84 f5 fc 8b 00 89 c1 0b 8c 24 90 00 00 00 75 1d 41 39
RSP: 0018:ffff88802a4632a0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000103 RCX: 00000001142a71b8
RDX: ffff8881142a71b8 RSI: 0000000000000440 RDI: ffff8881146827b8
RBP: ffff88802a463630 R08: ffffea000000000f R09: ffff88812fffa000
R10: 0000000000000003 R11: ffff888125af0000 R12: 0000000000000000
R13: 0000000000000103 R14: 0000000000000000 R15: 0000000000000000
 security_compute_av+0xac3/0x2660 security/selinux/ss/services.c:1144
 avc_compute_av+0x18c/0x1110 security/selinux/avc.c:1002
 avc_has_perm_noaudit+0x600/0x8f0 security/selinux/avc.c:1147
 avc_has_perm+0x159/0x4a0 security/selinux/avc.c:1182
 inode_has_perm security/selinux/hooks.c:1637 [inline]
 selinux_mmap_file+0x327/0x5c0 security/selinux/hooks.c:3706
 security_mmap_file+0x2f4/0x500 security/security.c:1521
 vm_mmap_pgoff+0x1a3/0x4a0 mm/util.c:502
 ksys_mmap_pgoff+0x83a/0xad0 mm/mmap.c:1596
 __do_sys_mmap_pgoff mm/mmap.c:1607 [inline]
 __se_sys_mmap_pgoff+0x11e/0x130 mm/mmap.c:1603
 __ia32_sys_mmap_pgoff+0x6e/0x90 mm/mmap.c:1603
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f34549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f552e0cc EFLAGS: 00000296 ORIG_RAX: 00000000000000c0
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 0000000000004000
RDX: 0000000003000004 RSI: 000000000005c831 RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Local variable ----regs@__bpf_prog_run32 created at:
 __bpf_prog_run32+0x84/0x190 kernel/bpf/core.c:1692
 __bpf_prog_run32+0x84/0x190 kernel/bpf/core.c:1692
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
