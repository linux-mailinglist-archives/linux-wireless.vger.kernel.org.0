Return-Path: <linux-wireless+bounces-13263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E298895E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 18:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB834B20DA6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA61C1745;
	Fri, 27 Sep 2024 16:53:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329B1C1740
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456010; cv=none; b=JlON7C8UQ7LAQb7RUu7dbzmcgOVDRv2ky75tIhoTNp0PV0EmTQX9QHABdGcY/h74t/vJgljKVnoGcqiNJvcWlYOLSJvTK8V8vfoystFp1x7GFbmXUAFsodwEf8NkIXMy6k5PG4stbrFD2lYn+tJkwnb8VQH/zmhIJRxmLLud6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456010; c=relaxed/simple;
	bh=HbNSFkbC/4y/P9Ba5K39AMbcnzlPTdiRQBsZeQhkrv8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mnr/fJ+oBUAbgmnvFDYCxVt3HtiYfNdU2yvhe7z26OgwTBjuNEhLU5pGG20AYaQUp1dqRG8fZ+a2wbyfxW4Bn2tbTY8KFndvfhcBKlv981GYx5IU3LhzMTzXo8zGMfw4Rpqe69KSU9/BFQ8aHu6KNnhDWxzIJudZB+eSUuZs814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a343c444afso18574395ab.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 09:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727456007; x=1728060807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgG/ygLGocIzopMcfdOssCN03xQrocYaesipZFj2uiI=;
        b=Md0kHRLz92gg9xk0Er5CKENCWqiuDLAC+5e2ptNs+EkrrxflDaBkWumuMQvUGWCRI/
         Af7++TKfVwCT6Z7fKz0m/uhoSAiZF2PPaTEfu2S3Lw8qW+LM43sQn1ohbLRJIJZ/VIqH
         2/ON96EtUtqifCKTOZ5l4feZwn3F2hMQBNjjKq54PsSzdO2Ixxt+XsE5n1dKjx7+e/Fc
         7WMBaxyqkS8H+n7O85ytNtD97cFH8z/gsSmRZCuK7QzVCJzfVWnnre3+dL7Nx6S7ovtJ
         NB7ye4lSq8iBdQ/VuzGmoN5D7H7lT3a82X/SrmVbezcEbI+eej8KuKOEdupgPoWc0tj5
         rYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCULEP1QxSY7zlk0iiwQFGcSdn5KWHDw4UcmVOrgD4KEr0cbKP89Ock3ZbxAXX4Ml6iKZwm/fv9rgl3CL5INzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMJ2I7wB+ALwrbMBqyZKGglpYdiD6AUWgiZepDtOlB9DHi9un
	5u2FTdKkiE/AYKCKgexV6IPVtA5VwvwB6VpiLDKDv78bPU2gVEpFsJPyInPii4fDypLmRjPGsvB
	vXHf09WxEU0un4uuFBW8dv45sgznihVX9xpfehLtfpYbLmvAfUekVgug=
X-Google-Smtp-Source: AGHT+IFLcsTwZkkrPecbB6b2x8xxn5b3sGmUMzGQ4h9C3xp8xEdNTP44IfHSYDBkGxlYjVO1w+LHh/ffAG4Kc/WUsfbl8O1dYX6n
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a0:9d2b:2420 with SMTP id
 e9e14a558f8ab-3a3452d1fa0mr30894455ab.25.1727456007561; Fri, 27 Sep 2024
 09:53:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:53:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6e307.050a0220.38ace9.002c.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in crda_timeout_work (8)
From: syzbot <syzbot+d41f74db64598e0b5016@syzkaller.appspotmail.com>
To: bristot@kernel.org, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, juri.lelli@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, vineeth@bitbyteword.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa486552a110 Merge tag 'memblock-v6.12-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae0507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c71bad3e6ab6955
dashboard link: https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170c659f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a7caa9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6beec63de3/disk-aa486552.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa35efb3dd39/vmlinux-aa486552.xz
kernel image: https://storage.googleapis.com/syzbot-assets/537d8ff45d85/bzImage-aa486552.xz

The issue was bisected to:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15684507980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17684507980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13684507980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d41f74db64598e0b5016@syzkaller.appspotmail.com
Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")

INFO: task kworker/1:1:46 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24304 pid:46    tgid:46    ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/25:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

