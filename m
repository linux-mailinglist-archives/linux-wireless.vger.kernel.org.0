Return-Path: <linux-wireless+bounces-9276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30590FF63
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E762858B9
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBCE19EEBC;
	Thu, 20 Jun 2024 08:47:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691E19DFB4
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873247; cv=none; b=sNHl+J5831R2b8D9VO3e0M4jZn01zNuODOcW5r5fuSbfuhN2xJEsCquYO8JXwqWO62Hn+Dwx1CSyHa2i9/SSog50ZMy075fhhQL5hnkBY9ynHJXE7T3psHVz1r56WM57B2JLuYq/MXmWnJSr5/lelLb36GzrYWxZir+v9HD4dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873247; c=relaxed/simple;
	bh=4ajyZXdaNZf5EZcN3QttERkpTghR9wLhMoW6fjeTTLE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sWu893We5UIHALz2qye5ibCxzmioMjPUkjSjTZrSaeI+RYB9bUgRxbus85gUIe5ADF22Scmv7hDUhhT2f0ojykBKdVZchg7T/0ICJ3xefq8jye52LvbMEcn1h0dW5tdJZSdiheR8LSnHQAPUri+g2+uCMnUTldA6LD8NQqE3JhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3762b8b440cso674195ab.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 01:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873245; x=1719478045;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95se0OHnag9kJGTphSgvBACh2aH/NzEMdmcamMkWJW0=;
        b=fib2J6Nd1YE/H5gyTPeD1GQ+u/v/IW0QZoLMaoKoSf9vysXyqtdT6t0Ec3o84QeAUt
         H/bcEv0tKw7eLI4XhI8+iW0SdZpxmsByzrCL9UYJA66ihgL0eKWFAUfVPwDiyMkuR/ve
         6doi8Pjc3aOqX3IKDZL8uuMiq2YsuZrUYE/vahqkn7Qg6RX6QAEUXyKN+xavcFXLgmdh
         wDQxnABED586bmxZSgl1UChK+UA1+KfHdyHvWijXnCoX19lkq1huyFvdVYEYEz4A5F0S
         Ln7dv1OcP9Qfx5mqWqRccjfbw1Q+pT5Img+clAVystZMcuYSuf3JI1fiRYN3BMxFPbMr
         +3yA==
X-Forwarded-Encrypted: i=1; AJvYcCXXjpSPtk0NL1CQ/xWx3dsS6YKFIegWa2dROkpbE1AanM7P2s8nMs+M7V912tvZ7ujTav9KFHht+wC6pwYO2Jg1VRUi0YPSKFNyVAL9icg=
X-Gm-Message-State: AOJu0YzEP4VLESON6a1JOUpGuc6bFkW5VQ3/NfQKXF3P4H+o11Yk09Db
	/oC4o68zUQEw0iTMPs3ISnPCPblYcy8ruSewlJAv/T+QTx7fqcdfFMC0OZ1ED6LZysMBfRL+cSY
	Nidy0QqEFXp+8verWPKDvp1nia3cNNWGX1edNgB9O4JAZvvOyh2Sbz1k=
X-Google-Smtp-Source: AGHT+IHhn7wtUM2trPcm2DW8Mf8U9tvwkndqInLjrjTlkXvxpjQaZZ07systtO9nwxLdfJGeUmCI+eqdqe8Q4D/7zXVPQtr3AGe6
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c563:0:b0:376:24b1:1746 with SMTP id
 e9e14a558f8ab-37624b11ac6mr1791235ab.3.1718873245203; Thu, 20 Jun 2024
 01:47:25 -0700 (PDT)
Date: Thu, 20 Jun 2024 01:47:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031ce3a061b4e5d79@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in cfg80211_dfs_channels_update_work
 (7)
From: syzbot <syzbot+4f955b33340810d6c105@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16519dde980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=4f955b33340810d6c105
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f955b33340810d6c105@syzkaller.appspotmail.com

INFO: task kworker/u8:4:61 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:4    state:D stack:21872 pid:61    tgid:61    ppid:2      flags:0x00004000
Workqueue: cfg80211 cfg80211_dfs_channels_update_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.3:7040 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:25456 pid:7040  tgid:7035  ppid:5121   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 netlink_dump+0x5d3/0xe50 net/netlink/af_netlink.c:2336
 __netlink_dump_start+0x59d/0x780 net/netlink/af_netlink.c:2454
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6524 [inline]
 rtnetlink_rcv_msg+0xda2/0x1180 net/core/rtnetlink.c:6591
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585


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

