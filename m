Return-Path: <linux-wireless+bounces-17383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F69A0A7FA
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10641887539
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E028192593;
	Sun, 12 Jan 2025 09:27:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D671922FA
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736674049; cv=none; b=nfj/8Q1HtsPo/oSEViKhhgHOpQugUPKYzGrxTEVzB8m88eYI9ZJd5jcn8oSU1qLtJHVRZ+w1n+pY1G2V/DIAxY7qduMCpFqaLkDIQQxqec7XaZ7MDzxLWLrYAvCCc1HWHvdnLIJfn3+McvMHK2cbIkL1FSW5F3xUvqiZyAYqZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736674049; c=relaxed/simple;
	bh=1tsA+WJU02kx9XWJQx1b0jKkCyhsWG1AJcYkLjWL1HY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dDXgXUrML1CFBQ4vRKiom7sR+SvIo9S0yQLtwxNQcpoTDdtcDfOwzY37AkYX2m9YgOEZxQPVElwbW/+85r57TO6ogimtmE3xtPRhWmxGAEWdbE67WusB2MNaWudPZaAX6FfBTrKLxCvNq1jPi9WZJlCcWUK2A4wU2ph8ZhTMEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844dfe8dad5so559861239f.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736674047; x=1737278847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMmLDaoIPqQOf2zZ+HlQlE4XtrFUMSm5hcpKKRPGPhM=;
        b=QOmCpMXJphaS1+BzMyEI6QOKl4sYKzLyk1EaOq+B5WKpJEi4Rb24JiO+ZeosVH6w2G
         SLU+9Kj0oT+cWN7zbfW22IwJmACtPK+pOZ9L/OomOfugNO4KdY1vV42AcAgt/e16zJpV
         D6tzOFoQPt1apTypkQrAUKA4FMHLfOuCY3BL88lvp4jpndb3SmC9KwR59c2zTlGtaOOE
         kdJtwU1UbwpqhY/LgiQtx9B772CJY8KQxV56I6Dv85V+9steRWvbFGIWqhpl4/0ocs5I
         PcwweP1gh5N1uD0LWoLfQzVYhHJzw7vbIvfWxm47HAOJOipiZaiYYRzG22mUlgwAR25D
         AF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwHIFYHNcfMEj4xQgG7r/CaZ+XqkGEeqejnB9CfVwn3J5UqGqaSZfmp1qx0p3GeuagJ/0d4O/L+pKB1i99Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0EWpXCvvZqDmiARI63XzmK0PN5eW0M+md15SEF5O3ywk2cnbp
	6B4QNqVPjSufdBuOhibwTbEn0w3cNXguHpbDrytIU3kOlUC7PeMBAfvfSdxUd3xXOqFe3u7N5nU
	zjzKp15knJCSPyWhu8LrPTp4X6dsdb2QxnfkxHrvCrYlObwfJBHs05+8=
X-Google-Smtp-Source: AGHT+IG0PQX3CsxACh8zS+AgP5QZm8RMOwqpa+ejuMsF7w76r+XiMgWWKFUNeT/tYtE1pZvY5xJfgDT5RVcsGxQbd+MIpBSBBjyV
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3ce3a8beb7emr128415575ab.19.1736674047482; Sun, 12 Jan 2025
 01:27:27 -0800 (PST)
Date: Sun, 12 Jan 2025 01:27:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67838aff.050a0220.216c54.002d.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_assoc_success
From: syzbot <syzbot+54788d96cbf3199014ac@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09a0fa92e5b4 Merge tag 'selinux-pr-20250107' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143b5b0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=54788d96cbf3199014ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-09a0fa92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71243ce2ee80/vmlinux-09a0fa92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff8be47c15fb/bzImage-09a0fa92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54788d96cbf3199014ac@syzkaller.appspotmail.com

wlan1: authenticated
wlan1: associate with 08:02:11:00:00:00 (try 1/3)
wlan1: RX AssocResp from 08:02:11:00:00:00 (capab=0x4584 status=0 aid=1)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1040 at net/mac80211/mlme.c:5653 ieee80211_assoc_success+0x6878/0x6eb0 net/mac80211/mlme.c:5653
Modules linked in:
CPU: 0 UID: 0 PID: 1040 Comm: kworker/u4:8 Not tainted 6.13.0-rc6-syzkaller-00038-g09a0fa92e5b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_assoc_success+0x6878/0x6eb0 net/mac80211/mlme.c:5653
Code: eb 05 e8 1b cd 4b f6 48 8b 74 24 38 48 81 c6 b8 09 00 00 48 c7 c7 e0 43 28 8d e8 a3 4f b3 f5 e9 e4 e7 ff ff e8 f9 cc 4b f6 90 <0f> 0b 90 e9 e6 e7 ff ff e8 eb cc 4b f6 90 0f 0b 90 e9 a4 fb ff ff
RSP: 0018:ffffc900026f72c0 EFLAGS: 00010283
RAX: ffffffff8b53b727 RBX: 0000000000000001 RCX: 0000000000100000
RDX: ffffc90023007000 RSI: 0000000000000678 RDI: 0000000000000679
RBP: ffffc900026f75d0 R08: ffffffff901981f7 R09: 1ffffffff203303e
R10: dffffc0000000000 R11: fffffbfff203303f R12: dffffc0000000000
R13: ffff88803fe24800 R14: ffff8880440fd000 R15: ffff888040778e40
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005000 CR3: 00000000425b8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_rx_mgmt_assoc_resp net/mac80211/mlme.c:5972 [inline]
 ieee80211_sta_rx_queued_mgmt+0x2b7b/0x4d40 net/mac80211/mlme.c:7577
 ieee80211_iface_process_skb net/mac80211/iface.c:1610 [inline]
 ieee80211_iface_work+0x762/0xf20 net/mac80211/iface.c:1667
 cfg80211_wiphy_work+0x2db/0x480 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

