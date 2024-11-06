Return-Path: <linux-wireless+bounces-14963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8799BDF05
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A228B2349D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691B1922D9;
	Wed,  6 Nov 2024 06:52:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA21922F9
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875945; cv=none; b=GBqc4eA8GvJMNW1N0XJoIzmrO2Vq7yoLpVNsVY3RpspGyoinY3HA50B/WhOeWY1RsxDvA03FHyhlLr9GjL/mq9fEpfc/VMYnC6Q2kUX4dHBAp/VEaGdR0VaFf3Tczq/K6jYuHZyYsed3bOo9KjwG5RG54SbxX4RRcOstN/Z16AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875945; c=relaxed/simple;
	bh=c8wDQUjdvG2sqYrB9QE0P2TodiAtQlmbBFLA97WJrIA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OCsMRaPWtFzgLCpHwAYnaIakiGqYQRMKri3pVKpQyrPXL1lHtqUF7jxnWJoV4R2sJyE/pdy8E8/l3RBcjYjwkBkYVTm4AvGTXYDarfHc6OaKHK/3im90yK8AzoRvQ4bHJDPOKA1Sifs3wEnK8O5B/KvQsGGpkcRbKyDQYCbXemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so49466485ab.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2024 22:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730875943; x=1731480743;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IT6exZ/GN3jFcE8DkmEFeDjzbFdHy4iBdvg7NIR3+k=;
        b=fHVVxl1wSxLvl+sCWe9nHckzdgnVT0l4EGoRFtrX8gYA44lUn4nefBTGwrrUR+xPa7
         2RwOfQJEHMl3vjOGsUH6nqviiJ0fYob7IoKKTL7yzkgoLOqHDFQJYJnIZKKxtIpOZTO0
         C9v7fWLlGBU7uj131KLyDOc/b9zX1o7mAgqOFYswYIviQYgAVdhwbI4AqNHhkILLRffU
         BupX3M0tUb7DcwrO4nRffeBW/xivhF4bJMdoSgJWxU3MhL4OkvIoXc0EieVb07Tu2tbi
         Z6LbCWf3oaFzEvHLm3SamPdv15vn9i2Zom29/Wext09hFBBDHjGZvGAVsanlMBg939MG
         YoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV24a6g95Z4qtKR+ooIWArf+3cIAmPyn+gQ2ddb3bmllr33as6DC+yn/UzdR8EvWmf2OhorJqWvZ2b+rkJmkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDrX3o63NTTql2yoj52wbK9ckfKsaHsoW6K0iw7X7afBAe1JQ
	rlWWm1zuW1xxJ0mZ/81gy8fP/At5yC6pWBrSIpQqM+YVVsPiHzjOUrMaSksHcqbldAUkaT5eAoV
	I2Zj7yJepHDn7Vot3gB4eFkIG3Q+tHfemVaGjIQRtHQYXruUm0TaPsQI=
X-Google-Smtp-Source: AGHT+IF7a24gCwxQg3G5iwyhFgO+EbzDRmjm30aG1lRKDZZRv3j2gOiFEPBVQIbo1GGiju+05fG6xJb9zyP6jfq4ae83Hsqi0IFt
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2401:b0:3a6:c24d:c2d4 with SMTP id
 e9e14a558f8ab-3a6c24dc619mr142579475ab.20.1730875943011; Tue, 05 Nov 2024
 22:52:23 -0800 (PST)
Date: Tue, 05 Nov 2024 22:52:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b1226.050a0220.2a847.1b9f.GAE@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_unregister_hw
From: syzbot <syzbot+ec6009b644ee5b5c28c8@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05b92660cdfe Merge tag 'pci-v6.12-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ceb55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=728f7ffd25400452
dashboard link: https://syzkaller.appspot.com/bug?extid=ec6009b644ee5b5c28c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-05b92660.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/240ba8a2a878/vmlinux-05b92660.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fed8acdd322e/bzImage-05b92660.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec6009b644ee5b5c28c8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-syzkaller-00291-g05b92660cdfe #0 Not tainted
------------------------------------------------------
kworker/u32:4/77 is trying to acquire lock:
but task is already holding lock:

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:
-> #1 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       wiphy_lock include/net/cfg80211.h:6014 [inline]
       ieee80211_open+0x12f/0x260 net/mac80211/iface.c:449
       do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2730
       __rtnl_newlink+0xc35/0x1920 net/core/rtnetlink.c:3725
       rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (team->team_lock_key#4){+.+.}-{3:3}:
       notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
       unregister_netdevice include/linux/netdevice.h:3118 [inline]
       _cfg80211_unregister_wdev+0x64b/0x830 net/wireless/core.c:1211
       ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2300
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       kthread+0x2c1/0x3a0 kernel/kthread.c:389

other info that might help us debug this:


       CPU0                    CPU1
  lock(&rdev->wiphy.mtx);
                               lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

 #3: ffffffff8fee34a8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x4d/0x3a0 net/mac80211/main.c:1664
stack backtrace:
CPU: 2 UID: 0 PID: 77 Comm: kworker/u32:4 Not tainted 6.12.0-rc5-syzkaller-00291-g05b92660cdfe #0
Call Trace:
 <TASK>
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 team_del_slave+0x31/0x1b0 drivers/net/team/team_core.c:1990
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 unregister_netdevice_many_notify+0x8d5/0x1e50 net/core/dev.c:11407
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1671
 cleanup_net+0x5b7/0xb40 net/core/net_namespace.c:626
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147


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

