Return-Path: <linux-wireless+bounces-32276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP34D148oWnsrQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 07:40:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D22221B356F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 07:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3448303AAAA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C423603C5;
	Fri, 27 Feb 2026 06:40:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069D36215F
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174427; cv=none; b=C5cfSiw+cHXiGkrwx+CD6+0xxl/GSf+pSLC8/+XKU+sdX5af2EYZhMDZ0LIphNQtykiXm2PAZtOWp7br4AIZts23dq/duX+jIlnBU4XeQQ2vMHjgGth2Dg+mzQONi/v+5wQuRe5LaHFjqO3V0lDga5Qp6KYWsMo7Z6VtfnNXBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174427; c=relaxed/simple;
	bh=KHpV5XnveDHMB9aDeTn9wHnix7sIYMgCQ4A+9Ud+8ko=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=keGzgAIgNr9oUCzYkUuPEChVyqiEPee475aeqi3y4T6Hx8jMiEE3Xd/L94KiGqWPmpOnkK4ZEjH5cEc2eZ8EOhsntEWL+OtQHiKzWG1tZzhGz4joyJtu0LYdVrhPAnA521wTtz5hyVGBZnTo8L8nmX3RC0+hhodSqsxfhDJinx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c448d15cso16106358eaf.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 22:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772174425; x=1772779225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/m3ThhOi9BghI3jEmSvcKXHlRO+J/KF0TB2yPf2e8A=;
        b=gbwlBXO4Jwy3+RKYko34f0eV/aFU43oGb2V93L3UWIZ5cF/mxA11qJ8pMahE8gpkuZ
         ziCAPz3/MfPiTpI18IopPg/GFbbn8a1Noy4n4QLMwEWuSteKx9LaLP1vz/GOb9lFohEY
         6jvAszrtNCgXQ6LpHd/XIOqlVfZfxeLhL5dQPI/fwqRcuGJUM25GaesB+2xGyrqkNu4j
         Y3j0xYBqYbJpl57wxJ4Pakg7kIebYOjIzVCtoEmc7uIjTQj5c5+7fKB1VlVSpVpJFXr+
         WImZRQ0wzEbxW4Ouhm+neHeaR2QeNarSGxVdRTd2xA2WXlF+dGENDPToRHRj3YLjZ40I
         W+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX/VDWwA6LpSc6VaMJkVZ7EsgIGHnoj+JbwCk61z2XjsrMEeBsy7H3/5duiLQNPQ1cd5dk8TQ/G9LmdyJ6lgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1ue654upfrJPUNzgrKCP9UDIWoUji6mFgex53WdN2daoI2WN
	7k3WvhEEz3q45vqu/s6p6e0hGHDUnz9YLpEGVLJZel8m9Hi7maigHC4Wm0PVqe1SieoEF1xrJEx
	s3P0JH1xx8LeNSNDcNk4ByxI+Wki+9nRt2OPk1Xt9ZRSvLbsHUwOUMlxyt1A=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81d0:b0:679:975b:f224 with SMTP id
 006d021491bc7-679fae0ac83mr1456374eaf.18.1772174425275; Thu, 26 Feb 2026
 22:40:25 -0800 (PST)
Date: Thu, 26 Feb 2026 22:40:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a13c59.050a0220.3a55be.0015.GAE@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (4)
From: syzbot <syzbot+1b20ba3b6d47543a7742@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32276-lists,linux-wireless=lfdr.de,1b20ba3b6d47543a7742];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: D22221B356F
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    d4f687fbbce4 ovpn: tcp - fix packet extraction from stream
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1763544a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=1b20ba3b6d47543a7742
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee42a61b2ee7/disk-d4f687fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5470ff18ff8/vmlinux-d4f687fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d50957aaabf2/bzImage-d4f687fb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b20ba3b6d47543a7742@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.4107/21056 is trying to acquire lock:
ffff888055af0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6441 [inline]
ffff888055af0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_change_mac+0xb5/0x1410 net/mac80211/iface.c:324

but task is already holding lock:
ffffffff8fbc12b0 (dev_addr_sem){++++}-{4:4}, at: do_setlink+0x806/0x4590 net/core/rtnetlink.c:3105

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (dev_addr_sem){++++}-{4:4}:
       down_read+0x47/0x2e0 kernel/locking/rwsem.c:1537
       address_show+0x25/0x250 net/core/net-sysfs.c:266
       dev_attr_show+0x58/0xc0 drivers/base/core.c:2421
       sysfs_kf_seq_show+0x310/0x490 fs/sysfs/file.c:65
       seq_read_iter+0x4ef/0xe10 fs/seq_file.c:231
       new_sync_read fs/read_write.c:493 [inline]
       vfs_read+0x582/0xa70 fs/read_write.c:574
       ksys_read+0x150/0x270 fs/read_write.c:717
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (kn->active#13){++++}-{0:0}:
       kernfs_drain+0x284/0x600 fs/kernfs/dir.c:511
       __kernfs_remove+0x3cf/0x660 fs/kernfs/dir.c:1513
       kernfs_remove_by_name_ns+0xaf/0x130 fs/kernfs/dir.c:1722
       kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
       remove_files fs/sysfs/group.c:28 [inline]
       sysfs_remove_group+0xfc/0x2e0 fs/sysfs/group.c:328
       sysfs_remove_groups+0x54/0xb0 fs/sysfs/group.c:352
       device_remove_groups drivers/base/core.c:2843 [inline]
       device_remove_attrs+0x229/0x280 drivers/base/core.c:2979
       device_del+0x51f/0x8f0 drivers/base/core.c:3877
       unregister_netdevice_many_notify+0x1e0e/0x2370 net/core/dev.c:12438
       unregister_netdevice_many net/core/dev.c:12466 [inline]
       unregister_netdevice_queue+0x31f/0x360 net/core/dev.c:12280
       unregister_netdevice include/linux/netdevice.h:3408 [inline]
       _cfg80211_unregister_wdev+0x155/0x570 net/wireless/core.c:1297
       ieee80211_remove_interfaces+0x49c/0x6d0 net/mac80211/iface.c:2440
       ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1691
       mac80211_hwsim_del_radio+0x28a/0x490 drivers/net/wireless/virtual/mac80211_hwsim.c:5916
       remove_user_radios drivers/net/wireless/virtual/mac80211_hwsim.c:6727 [inline]
       mac80211_hwsim_netlink_notify+0xfae/0x1310 drivers/net/wireless/virtual/mac80211_hwsim.c:6741
       notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
       blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
       netlink_release+0x123b/0x1ad0 net/netlink/af_netlink.c:761
       __sock_release net/socket.c:662 [inline]
       sock_close+0xc3/0x240 net/socket.c:1455
       __fput+0x44f/0xa70 fs/file_table.c:469
       task_work_run+0x1d9/0x270 kernel/task_work.c:233
       get_signal+0x11eb/0x1330 kernel/signal.c:2807
       arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
       __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
       exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
       do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       class_wiphy_constructor include/net/cfg80211.h:6441 [inline]
       ieee80211_change_mac+0xb5/0x1410 net/mac80211/iface.c:324
       netif_set_mac_address+0x317/0x4e0 net/core/dev.c:9989
       do_setlink+0x9b1/0x4590 net/core/rtnetlink.c:3110
       rtnl_changelink net/core/rtnetlink.c:3776 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
       rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
       rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
       __sys_sendmsg net/socket.c:2678 [inline]
       __do_sys_sendmsg net/socket.c:2683 [inline]
       __se_sys_sendmsg net/socket.c:2681 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &rdev->wiphy.mtx --> kn->active#13 --> dev_addr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(dev_addr_sem);
                               lock(kn->active#13);
                               lock(dev_addr_sem);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

2 locks held by syz.0.4107/21056:
 #0: ffffffff8fbcb808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fbcb808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fbcb808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8a1/0x1be0 net/core/rtnetlink.c:4071
 #1: ffffffff8fbc12b0 (dev_addr_sem){++++}-{4:4}, at: do_setlink+0x806/0x4590 net/core/rtnetlink.c:3105

stack backtrace:
CPU: 0 UID: 0 PID: 21056 Comm: syz.0.4107 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
 class_wiphy_constructor include/net/cfg80211.h:6441 [inline]
 ieee80211_change_mac+0xb5/0x1410 net/mac80211/iface.c:324
 netif_set_mac_address+0x317/0x4e0 net/core/dev.c:9989
 do_setlink+0x9b1/0x4590 net/core/rtnetlink.c:3110
 rtnl_changelink net/core/rtnetlink.c:3776 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
 rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f909439c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f90951b3028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9094616090 RCX: 00007f909439c629
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00007f9094432b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9094616128 R14: 00007f9094616090 R15: 00007fff601b4778
 </TASK>
netlink: 8 bytes leftover after parsing attributes in process `syz.0.4107'.
netlink: 'syz.0.4107': attribute type 5 has an invalid length.
netlink: 20 bytes leftover after parsing attributes in process `syz.0.4107'.
geneve2: entered promiscuous mode
geneve2: entered allmulticast mode


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

