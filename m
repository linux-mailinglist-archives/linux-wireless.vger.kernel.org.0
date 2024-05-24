Return-Path: <linux-wireless+bounces-8050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987DC8CEC53
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67681C20FC5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB085C65;
	Fri, 24 May 2024 22:12:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148280603
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716588744; cv=none; b=s7CzuCc5M06wogzFeSw6PoYvuZlidw/bW2KdbX4q0756HCT0fu+g3BPWdPMcbzmmshkT+H1gcHOn+yY03Iz/rOL6417gGthlVXXYG9S+MKpFnDv4euTENCyyUC3zOygFNQpd0cytMBKCfr+hTzYESlUqBoij+BNbMfqksL+MneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716588744; c=relaxed/simple;
	bh=xAa7PbMZS7GhkvZ3vEJQ2STkd2CTd/i6Glt2Y9Ez61o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IwiAxBctmKTSCQhA1Jy9Woy73w5Bb8rV1fOpmR1dkfcD2z/J2bqDYYmnBX2M1rFtR+uP+8MFfXi8ySEbTbsx9SPm3/kW9NPegHPrDEK0v/dCtHO73TkhhgTLwzL7dw1liVzAjJms3PjS6rLzDzLTHTkITHfSa6CqaDp4OKFgUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3738836578aso6113045ab.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 15:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716588742; x=1717193542;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvWRdWHtYTDN/oJisLuVIUDYQOOsYx8e39LQS8HFUnA=;
        b=Mb1X5mcQhTV5LFxcHe4851dixbKMVzj7w7gjkfChtUltZs6xqVGxMTpaVGuT8CNoZ4
         +MxKTvcvi1PGeTxLexXd0T0Tv/u3Kwi9fxtkCrhCVA1g0e3P2v5dnK8YkzZ3FaaPc3Fs
         tkgBzB1O8dB4EHOpkIxTvFE6zibxXsg4nLTSEwIOkIIJDI2deUpOia3hSZaQ9/v7cAir
         2HCc2JoEkhovHbAISxQbNsqVIKN8DSKLGZXYmvP1KVrinI7/NRc21Aug0o6Gg2YQHTrW
         Dnkko9H1OjXOKNSz6N8Lvw5Wm2DKL3scV9+AG4zR2kQ+07CC6UdwMyiT8Nvax1e86Y4w
         Wt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5DV9D2RuVswv0t5alG5y5KtjuMD+7xTbbb9ZgqEvyYiUxg7mKcqNFoFlcv7pja5MaDZzvdQe8bvDc9cRnR0O2L7fhRxOQoPjRYlOCXLs=
X-Gm-Message-State: AOJu0YzAjGRVqbnVrusPWwsTJpk4qA7q6ue7pnBEV6xqpJW66ZVrziCr
	JeM3//AHi2QFcqOVquQ4Q0Lp/Stgf2EyJtZ4IerUlYnhPTReWuar9fp57LJX51KlVLPElkC7uNC
	Slw7ymf5McQrXe+FOiJVlT2oy5y8bV8iE4xvI1fQ0fLBVVAuQZEt/JRU=
X-Google-Smtp-Source: AGHT+IHSIh6BkZuAlHqX7nLYnQ66nf89+XSr+0huL6yRS7wiJsy/ToHdvXMGpjOAYG3DMoQ8xYOvLKe9gQCQwtWNAYCBcNWhjXro
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:36c:4cc9:5923 with SMTP id
 e9e14a558f8ab-3737b31b087mr2712115ab.2.1716588742091; Fri, 24 May 2024
 15:12:22 -0700 (PDT)
Date: Fri, 24 May 2024 15:12:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032b7b506193a760c@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in crda_timeout_work (7)
From: syzbot <syzbot+ef89ef34c36478f35fab@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111db784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6e600de1a27f120
dashboard link: https://syzkaller.appspot.com/bug?extid=ef89ef34c36478f35fab
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60dc1346b348/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f1699c08d767/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0c1de6d998e/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef89ef34c36478f35fab@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:25792 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:3:51 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D stack:25376 pid:51    tgid:51    ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4193
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.4:5104 blocked for more than 144 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23296 pid:5104  tgid:5104  ppid:1      flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xe60 net/core/rtnetlink.c:6592
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42d8a7ebdc
RSP: 002b:00007ffc82775e50 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f42d96d4620 RCX: 00007f42d8a7ebdc
RDX: 0000000000000040 RSI: 00007f42d96d4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc82775ea4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f42d96d4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.0:5105 blocked for more than 144 seconds.


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

