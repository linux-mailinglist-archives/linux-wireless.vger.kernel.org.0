Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F429782E84
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjHUQhF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjHUQhA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:37:00 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1F100
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:36:57 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5659b9bc3deso3782532a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635817; x=1693240617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DscXzbPNxTBR1mFGaAB02zyy+OW3MXcEY6WXJZDd5nU=;
        b=PNo/LL3K8YShupCQMxQsWCEiZ6xBWVstldz/vQaLy/0+WWga/QsIB9OVLz4dI4NuTC
         IQc2jQHwEMtuAvY90j+yL7sfOGQeJzBS0MaHPCw05DoIiZvRJsRq1k7nC+u7MbOBi7WF
         NAOSVaKcs+J4I5qJto3ydv/pxwg276/jvsD3/LGkjpJr8ob/uFv3WtyrcFoXDforiqnY
         Wf/YYIjDSYDxhUB3C23/WskkNvWGsM8pbyPEFYQErA65z5IuuKPF0249qPhHQr3y+QMk
         D/Oxqza+MuEA5NM1ft2JM3ZAx9jHqdbuPpk8Kclm1RylPfl5dm+1ICQfSgwv/r9/jxOT
         EHig==
X-Gm-Message-State: AOJu0YxXi35iVfLVYUR7arn5mjLoNJ3AGeZyRqAHwGFHasxV32v7GlTc
        2R+855zBGOMnPppq+mZBvlSsLQYACjcSuamIu9PC8LL+eMfv
X-Google-Smtp-Source: AGHT+IEQDWXwjb92oMzfXVoJdYwEHSi8DF11A7NLabTRacYoPPK2B/zbPpb4aoA/KqQaIFuvq1P2bXDHwug+ycWqbGfLzVMcjuKK
MIME-Version: 1.0
X-Received: by 2002:a63:a319:0:b0:565:e467:ef5e with SMTP id
 s25-20020a63a319000000b00565e467ef5emr1099865pge.5.1692635817459; Mon, 21 Aug
 2023 09:36:57 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:36:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a249880603717c15@google.com>
Subject: [syzbot] [net?] [wireless?] INFO: task hung in reg_process_self_managed_hints
From:   syzbot <syzbot+1f16507d9ec05f64210a@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kerneljasonxing@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d4ddefee5160 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1653bc65a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e59507a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cd6137a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6187f26c7496/disk-d4ddefee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8bb63089fdb5/vmlinux-d4ddefee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1579fb12e27b/bzImage-d4ddefee.xz

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115fece3a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=135fece3a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=155fece3a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f16507d9ec05f64210a@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

INFO: task syz-executor296:5042 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-00200-gd4ddefee5160 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor296 state:D stack:24336 pid:5042  ppid:5038   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
 wiphy_lock include/net/cfg80211.h:5776 [inline]
 reg_process_self_managed_hints+0x78/0x170 net/wireless/reg.c:3181


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
