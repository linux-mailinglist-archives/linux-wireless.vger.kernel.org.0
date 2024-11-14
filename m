Return-Path: <linux-wireless+bounces-15290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E29C84BD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 09:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4681F23F2F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F821EF0A1;
	Thu, 14 Nov 2024 08:18:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89A1F666B
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572304; cv=none; b=KpUDdfB/Pip12+nHm/H6MCES5XBYXcn7hbljzd2IQ0tKQua2bVKiJTNnQja9qgOGSJAF5LFbnEL+DDE1asfyJVuwEHy3vaPNy9WMN1TD0QvrqDxOc6Yfy1PnZtzxpqRnBXB7g2xv3aJ7hBoabmT+ir9R1Jp2hf58ZCP4km6QksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572304; c=relaxed/simple;
	bh=ioK6KaOnY/kKp6zlZL6nSlLZ8+Der15x4S6yT4zktUU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O7VB7MFWgOEgqmLwseGB9IXrZQLbpGbjHbcb5NfYpGIVdebXKaWg35W6DlSnDc8mZn9IRiDaa54WsS0ryOF6Tt7J5U0Y5sPU5zLG+Ft57GVoKk0WEt6mSIb78x87DI7Vi0Frw1zgqCBF758JiAMRc/fVAVbhWxkNhgmKA6PGJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e5f2dab4a8so309555b6e.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 00:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731572302; x=1732177102;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1k/pADWH4N58GkitNkHI+Lxtaxcw+5PSfP7NtQHIH78=;
        b=lYN356obHX8qYlb9FK3ZngZ/S7lxy4UZlLNYogro68s+DoamEofVfNeDCv277zjC1g
         +mPEIi5JMfTqzvOsyxqYsnRxuEiygeQ12VW/AZ34EhhuNg5dPnMrvTJjjUhLYzSzvoKD
         RhvgcJeCMi/Z6zbXhP6KY6dfZTedH4eIxjAYbjVbeCQBrjysBmUzLNIa7T0mPZN8jviv
         kIqcQQuJxEOK+RsZtGKxGiQzC+ZRIzGsixkCw0wT6PKMjHV59XgSqbYqDoCWUSxDfpGa
         pCBn3g/wu1QoUln3/XB2QBJzhK1j7kXSFZPovMbdXk6ut3N49S4OgQwip1uhJn0cOSUk
         +NXw==
X-Forwarded-Encrypted: i=1; AJvYcCXvDwdP+nX0AIR6G2WT5uCAQ2HzopQW6d73DqBY7q2GEGqzWMpqrkNGQXglSqqwZLzwQKDhXaDNqPyjTGLawg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEWRGM57Nu7EpYu3gnsSAu5Zzh4xFp/OfC13XRIWCGe+5MeKL
	y4T/6DmCjIQSHAHI5Vo+V5tTp/SDqIr1qLDQ7AUc9C66EesszItCh91kTJaT3w8PLdLwHTgy0vW
	IxsHvaOU9elY4DPnIz0WhdsEK8Z5apQDPNSDQaBipDo0o9Vble+NpZQs=
X-Google-Smtp-Source: AGHT+IHVGL7yUFzmPuWKnuVV1tPXjozDQ7vZObmOsv4LWWNg3+JsBZngo2+3k0IwJ7/JnA7Bfi1sZupKs3TL318tmdNJQY0SAfK0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:188b:b0:3e7:6199:3caa with SMTP id
 5614622812f47-3e794686797mr23259287b6e.2.1731572302049; Thu, 14 Nov 2024
 00:18:22 -0800 (PST)
Date: Thu, 14 Nov 2024 00:18:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735b24e.050a0220.2a2fcc.0063.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in nl80211_pre_doit (3)
From: syzbot <syzbot+da14e8c0ada830335981@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de2f378f2b77 Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a245f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=da14e8c0ada830335981
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e635f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-de2f378f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ee61f45ffb8/vmlinux-de2f378f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3b0e20d8f05/bzImage-de2f378f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da14e8c0ada830335981@syzkaller.appspotmail.com

INFO: task syz-executor:5427 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20096 pid:5427  tgid:5427  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16580
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1110 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xaaa/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f024ad805ac
RSP: 002b:00007ffd15eb6070 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f024ba64620 RCX: 00007f024ad805ac
RDX: 0000000000000040 RSI: 00007f024ba64670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd15eb60c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f024ba64670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5435 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20656 pid:5435  tgid:5435  ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7facdd1805ac
RSP: 002b:00007ffc7ba5d850 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007facdde64620 RCX: 00007facdd1805ac
RDX: 0000000000000040 RSI: 00007facdde64670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc7ba5d8a4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007facdde64670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:0/8:
3 locks held by kworker/u4:0/11:
2 locks held by kworker/u4:1/12:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720


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

