Return-Path: <linux-wireless+bounces-16285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D79EDE96
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00158283425
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 04:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E1C16BE3A;
	Thu, 12 Dec 2024 04:41:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D29165F01
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978486; cv=none; b=ceGibxCLHuFUdhsJD6yT8adLkgYcra2cWam/osMj2ofG7q19X9MexqrSUBjIKSGC53q1Ec0x00zI1vJDYlSkuPbpGpJRthCgACX6BdaugmE+pQaLuIMVNYyGpuJ/LuNWdR9b+RqPJLLdNFqCTe18VoeZuWuLYpnezEzD8PKKMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978486; c=relaxed/simple;
	bh=mRUP88o1vYUkBTOYZZUrYwZIPtL1QkuhuFKt1jdzph4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ROsbnXZsLswcnSdsdxvSniIRe7ZTQybU5gK2Ej8y7WihfQG0ug6U4ueSOjenE5U4eTh3ecGn5lt75bqByjS/ejLAiucCE8aXsqDcGZL03h7KtOlV+dm8OB3fg+sorAkD7UEDAPjWK7oNzLltEDkM1BVNsOlDeZ1ACwAm5B8F1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so4481425ab.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 20:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733978483; x=1734583283;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6i+UFR5QAg/htQWbJqPb5ENw5otoHq5vhy8B41aRmTk=;
        b=V4/nA8RdKtpaQ6RkMz2CaCm6qQEt49jMX/A/Q88GZsP9ESkYyQRd/Q47vC3fV+wa0g
         /6DSyJadAocn6yxpvimIGKJgXg88ZD9HusQGMHnaR+6YHrEO9KsqmojbV+kNsXQ62SJe
         zbaKLP5YPWeybXcfAYOaXffTl214L+GpaJb0CwHRRfqM9hHfU7h/ws84nWfhQbB66g8g
         MKw5Et/MC/8cczgpwSdDAp8mQjC+WyeS2juEl5TgdspH9tMzmxK6Fy6yarcZGs+vYGy9
         9pMYxhgysjH6wmfkQD0sv7XfOds/jqWnlkhVuRaCRtffbwnILv8Rd3QzelY+xK/4oFgA
         GUmA==
X-Forwarded-Encrypted: i=1; AJvYcCVoBdNA3afW/eIvIpABC+tVFDRBBYrmAqvvLCOGAU0Plps/5eZU1azqKqZDpD6uucCkcvsMZVFsxTQbNq5cgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiqt4m9d2PqoRr9CuiKfFgMEbuDDoboCVkfrNKSm3yPYsgCvh
	0BlBocPGptf2FkugwbFLRXBipvZA4gYvHbS/C/ECbgqWfarLJKAF6ZMOEn35fTJ6Fv4j5uZrNJN
	mt/4E7o4qncD7RRQn2G5ZZ2eaaWn3JleqY837ZRYc3rU9PMuq88w1BiQ=
X-Google-Smtp-Source: AGHT+IF7hZOGQsYnWyD1jmnUwVNk6byVH4UmYE20sGt2xhakUPRENmuUv35XY2FYWd8tXd4KVyiTVLHau2gQeV+IScDc0mqeyy9j
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3ac48d9eb3dmr23195855ab.12.1733978483669; Wed, 11 Dec 2024
 20:41:23 -0800 (PST)
Date: Wed, 11 Dec 2024 20:41:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a6973.050a0220.17f54a.0050.GAE@google.com>
Subject: [syzbot] [wireless?] BUG: sleeping function called from invalid
 context in wext_netdev_notifier_call
From: syzbot <syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4c49f38e20a5 net: stmmac: fix TSO DMA API usage causing oops
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11614820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=3647b9259b77c1bb8e94
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09256902989e/disk-4c49f38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b41c0f5233f/vmlinux-4c49f38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7bb9fdcd5331/bzImage-4c49f38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1523
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 12894, name: kworker/u8:18
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 12894 Comm: kworker/u8:18 Not tainted 6.13.0-rc1-syzkaller-00183-g4c49f38e20a5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
 down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
 wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
 wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:182
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state


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

