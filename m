Return-Path: <linux-wireless+bounces-16860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E29FDE2A
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 10:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D54D1882657
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626C78F35;
	Sun, 29 Dec 2024 09:11:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA37083C
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735463481; cv=none; b=fTdy8MpFKWjgCn4AUTw2ClFLqRjHeb9mmyJzVsgX5mLensz904UQp8uJnOCqQC2AYOFlOLHfTbR6qhr+a0YFJplkrUvFcloDifguOJ/E5ifdlTCbDzdsKurPgXl5TR0aqoxXyZW+DZq/V8ZeHA1hXUeewVlc+oxYk5avFKEawKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735463481; c=relaxed/simple;
	bh=bf3Ov7+YwJhN8+acTRCvdtSEBLpfnoDTHLxQMgVtWRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pxFAhHMmXxEYNOp4XaF9IVTZqc3wwStt9vOC4CVVMOM8Y8/wJulBciGsEN9yJzx/S7UoTfTdcAbBI4iQPM9GWQDMnb4/dMwzuLeSezQ69ohHtwuFgxkRaZwEFXNEmXr+7702wn9uew5SpSmK5NLdBdEsLevTmwvjlinZHX0/4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844cfac2578so1400280639f.2
        for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 01:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735463479; x=1736068279;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qn8krfBYhXMOLabcnXH490lsbAGUeZIj+8EHZb1G0n0=;
        b=RBBtPVT31VhFgnp7smQJgr7rix51eFWUtPXwWZbhTDdSIjdoSrQmyf8gQg1O36kSlk
         +lQx31nAJbnM3kHg0YieDjB2jyVL7coR2V7OvK3kY33Bt1UOVsGsMAXS59yr33zqp3yX
         soALoAtbLf+Gxy20jepb2IGNv3YB8ivlzZtQ4Ur+YnxKAwwWEPSkuZedUY07eiYo4jNR
         4fkMeDYVkhy533uQ1U/X9V9247B9teppe7v8ZpxnRUFUPEqc3lT4abz4HdcXHOfXWKAn
         CxMDOHh3A7yqMUO3q+juK+SJ8ApK+OjTTzhUZntNTEYe/whX3qifHvmYRMR02SygYuZT
         XFrw==
X-Forwarded-Encrypted: i=1; AJvYcCWPH+/Hczj3xhggsD2WE98JTlrKX4pAnoB88r+THxc95sqBr3LLmCIgZ3s6BgxtUEGUW+ktW5PpnRwglzfDdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhXabtItSrudn+gMmU7FKpOFfwc0hFX3mF+UYX5NHgRKoKix7
	g3T4CwrNqO+tHH26dMmaVPFE1/yWZQmW+N8ZskD4pGEVbn1xRQR7Gboa7oEYzdGG6avZi00jXq5
	WxGU6oDR0mws7+3dzxmiADoa8dPQ1WdkssjUSIhbo+1TBDUr/mTgyBuI=
X-Google-Smtp-Source: AGHT+IFzpzRr7auEnk9HHt8csPE0+StQIDgkc92LF0hHJEaIsSJ3jNI1Pteb4UB7vxvsH/oTI8FdyzEWvFZJJe4MzA/po0GqvqW+
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:3a7:fede:7113 with SMTP id
 e9e14a558f8ab-3c2d5247c76mr319800925ab.18.1735463479145; Sun, 29 Dec 2024
 01:11:19 -0800 (PST)
Date: Sun, 29 Dec 2024 01:11:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67711237.050a0220.2f3838.04a8.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_unassign_vif_chanctx (2)
From: syzbot <syzbot+25ce0caba1e325c6f224@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12df6adf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=25ce0caba1e325c6f224
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bcb43c77ce7/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef51b0b811d5/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25ce0caba1e325c6f224@syzkaller.appspotmail.com

------------[ cut here ]------------
syzkaller0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 1134 at net/mac80211/driver-ops.c:360 drv_unassign_vif_chanctx+0x247/0x860 net/mac80211/driver-ops.c:360
Modules linked in:
CPU: 0 UID: 0 PID: 1134 Comm: kworker/u32:5 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:drv_unassign_vif_chanctx+0x247/0x860 net/mac80211/driver-ops.c:360
Code: 74 24 10 48 81 c6 20 01 00 00 48 89 74 24 10 e8 0f 4f 0c f7 8b 54 24 04 48 c7 c7 c0 fc 9d 8c 48 8b 74 24 10 e8 3a 15 cd f6 90 <0f> 0b 90 90 e8 f0 4e 0c f7 4c 89 ea 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000677f5d8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88806a928d80 RCX: ffffffff815a1729
RDX: ffff888024f52440 RSI: ffffffff815a1736 RDI: 0000000000000001
RBP: ffff8880710e8e40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000005 R12: ffff88806a92aa28
R13: ffff88806a929728 R14: ffff88806a92a9d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000569e04c0 CR3: 000000000db7e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_assign_link_chanctx+0x158/0xd80 net/mac80211/chan.c:885
 __ieee80211_link_release_channel+0x273/0x4b0 net/mac80211/chan.c:1859
 ieee80211_link_release_channel+0xda/0x1b0 net/mac80211/chan.c:2130
 unregister_netdevice_many_notify+0xf77/0x1e60 net/core/dev.c:11548
 unregister_netdevice_many net/core/dev.c:11590 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11462
 unregister_netdevice include/linux/netdevice.h:3192 [inline]
 _cfg80211_unregister_wdev+0x64b/0x830 net/wireless/core.c:1255
 ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2307
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1671
 mac80211_hwsim_del_radio+0x268/0x370 drivers/net/wireless/virtual/mac80211_hwsim.c:5625
 hwsim_exit_net+0x33f/0x6d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:172
 cleanup_net+0x5b7/0xbd0 net/core/net_namespace.c:648
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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

