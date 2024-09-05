Return-Path: <linux-wireless+bounces-12560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8796E3B9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 22:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AE51F21E5B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE218FDBB;
	Thu,  5 Sep 2024 20:10:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EA18D64B
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567030; cv=none; b=LFKiUDlo485+RvHViXhxbQaWz3+EeBPP9T3zkCKq5FbLknmsmRH2B47huYeZ+xci8SWNVhFUj+tttHEnJiudmovlOAoJu8Gr6araaPuYeKXz6YN/wJGh2qP8gUjtqBMbrceMR/ipA0Z4zgV+So25d/z5CtZGQs08XBIflkdba1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567030; c=relaxed/simple;
	bh=pivsRGJp8NKBwxppttHmzAWJCGdoSIRe71JGCEgDemI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BYqsC6hCS/GG3qvfnu1uhmT5KQvYGlpJurXA1bs+ZkC0cRnakb+dD8AEo57I3GsGptSn+PwCqfwcNzqzVzXuDuYxE4xtHKdS3H2p9xjwoM1y7CYzylHEBGmynRkZ0A1mntZNcGpP95Ee+dyFQPf9vHfh5fgGvYRPq49xMO8ZOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0459a8a46so34147365ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 13:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567028; x=1726171828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XiCTBlmXz66mBJxcne8N9WTdQpBfvB23eK91fk59/Tg=;
        b=WoJxCQtVyj5dBp3RBLqTEx78eCI1ZScUNuWqDfFHULRxkSvoAvpJ3USdXJ5PC+7O3q
         2cVc6IHfOCZvDMR2QTnrWxW8IMZL2eGOjHdpJyHLUAdHEFbkIoq5AGLz2GmbeZ9HQrwA
         2aLsHQ3qY1+BhTZw3MTTfme0kaLw8lfbfL3hrSDT5TNVAoNsCY+vCQID1SVFguGDdIME
         oPCDKGhCwClA6ayQjJhJxGvMx0GqK0lUeBZ59CSlLVVJSJOSy459t5r4N6Y4zcCdjmwb
         m0oc0xW8Zc5/DrZ29De6cGwKIt6CwRD0lW8lA73Ak295xdyXgSP5rkf+UpnlcO6vcvHh
         LPmw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbwILeHZethh7z1OhI+odMoMRK2HAdrp5gp2hzwhy2xyaUhB0azJiJTQKwszEsKSh5fGaGEe7O/2xsKedMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcnaiBBwqcUgNZZQ3V1vvRiq8toe673BLAkFEch4ftYEi+3zG
	yYauci8QY0vfVWaQF+nEOZbFS4U/C7a7Y/GZ67z/ACbHDzjG3meY099KrzZLP4tY7vup3iw8dPT
	n+os5ueIjUNu3U6rDQSZSDcjsq+mixmNYvUZWoSq8Yd+rsrCd9Tee7nI=
X-Google-Smtp-Source: AGHT+IGfch4QU4MPs73g55BhStEJMfxAbGwRgv9k7ov46PkNs5HaMGp/B40y2AJ6GYdRdXbU1SEWR9EAfA1f3IG2+Q0kmKa4q3b2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:39f:bac6:c31c with SMTP id
 e9e14a558f8ab-3a04f068709mr36355ab.1.1725567028271; Thu, 05 Sep 2024 13:10:28
 -0700 (PDT)
Date: Thu, 05 Sep 2024 13:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1ae9e062164e101@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_remove_interfaces
From: syzbot <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144a43db980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=931962fa28089080
dashboard link: https://syzkaller.appspot.com/bug?extid=5b9196ecf74447172a9a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-431c1646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01c0dadd39ff/vmlinux-431c1646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e2259e440f7/bzImage-431c1646.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u32:7/1108 is trying to acquire lock:
but task is already holding lock:
ffff888055278768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
ffff888055278768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0xfe/0x760 net/mac80211/iface.c:2262

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:
-> #1 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       dev_open net/core/dev.c:1510 [inline]
       dev_open+0xf4/0x160 net/core/dev.c:1503
       do_setlink+0xd24/0x4190 net/core/rtnetlink.c:2907
       __rtnl_newlink+0xc35/0x1920 net/core/rtnetlink.c:3696
       rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
       rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (team->team_lock_key#10){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       team_del_slave+0x31/0x1b0 drivers/net/team/team_core.c:1990
       team_device_event+0xd0/0x770 drivers/net/team/team_core.c:2984
       notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
       call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
       call_netdevice_notifiers net/core/dev.c:2046 [inline]
       unregister_netdevice_many_notify+0x8bb/0x1e40 net/core/dev.c:11352
       mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5625 [inline]
       hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
       ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
       cleanup_net+0x5b7/0xbb0 net/core/net_namespace.c:640
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
other info that might help us debug this:


       ----                    ----
                               lock(&rdev->wiphy.mtx);
  lock(team->team_lock_key#10);

 *** DEADLOCK ***

5 locks held by kworker/u32:7/1108:
 #0: ffff88801baf4948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
stack backtrace:
CPU: 2 UID: 0 PID: 1108 Comm: kworker/u32:7 Not tainted 6.11.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 unregister_netdevice_many_notify+0x8bb/0x1e40 net/core/dev.c:11352
 unregister_netdevice_many net/core/dev.c:11414 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11289
 unregister_netdevice include/linux/netdevice.h:3129 [inline]
 _cfg80211_unregister_wdev+0x624/0x7f0 net/wireless/core.c:1211
 ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2287
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1669
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5625 [inline]
 hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

