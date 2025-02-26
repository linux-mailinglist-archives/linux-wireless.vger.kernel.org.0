Return-Path: <linux-wireless+bounces-19490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B414FA465AE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0058B425CDE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78121CC7A;
	Wed, 26 Feb 2025 15:44:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F219ABC3
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584661; cv=none; b=nG+RN9fKalz1jDDPsxnBzzDXaWzHRaW1NuqaAPZU8RA4rIPA1TEWIHRkvW/7uIFtNjBr+uKNxHpDLdUigJba9PCHuD4Tzo9aUDt+FLDVVFKsBZ4QXy//8chWE5IaKhKLaiqgW3HvGefWK3Yi0X/DKgMIREacRh+s7l7K9+o6c/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584661; c=relaxed/simple;
	bh=jQWGtiwUMbK9EpvVC6A07sD50bV3LE9jiqhidCemgEM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pqCTyFCtNNzpVyvtYZU9ifC5SE6UmcKfOZnoGgq0Es+Ld7UBWizTwlGpRvgJ77Cp94UHjbW+H/m1+d868lE2cjSYwAQkrGVH/leTH+sCcz/FZiORWiNzUpBzf9Q4zoj5QpwqGv6ejZUMweO/5mXQMPHbGackVod6Zw0ikXBwDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso57832525ab.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 07:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584659; x=1741189459;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW3c0T4SQd+xntB/X6MFD4fJslBbj6oN4QbWpGD4aAk=;
        b=XWzaa2elAgrFyaL3UkfJD/HKnntlTfNo/KGxIS9B9AVcHTNhB11gegIUkdowqDeVqm
         vdpjKM/Tw+PPzM1jHocwCJFNS92hJcQiXb8AZW0Irry5poIAKL0YDtaJHGg3cLxhE4Km
         kxknF4UWt5/XYKkEyuex1iE+1Eb/k4GH2G2mopN0Mpmknq1fiZiBqYJEgqky62RvkPEQ
         DdSIT9fAaoB7XRckkTB65CWT+G2YINA5b1+JPMRANBWJ7VqqvsFTBykmdtuR0snklHhQ
         c/yHGPDm3AGioqKuYbMW/P1in9OgphZ59pqj7sIXh8uh4jU6YVq7EFpgnaDjVO2yVxK1
         00Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXKfo+hAXcUjDVaX+3NqsqiqpO8yRZflTxSSRr/OtI60zpW+mixTuoVB/4oNaWg6t6s4cvLsaqCyJXKHg5udQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gY4++QJO1OpQDum729yAYreCZIMILePGXvZhW5F21rMlg/QD
	fi//V3sZUPsXOvUoW28tWZoCamNCSzc4m7K4PucjUZBUs9rRRAqvJWHY+rZAdPIDnjdUOMaFB0j
	K254CeB/MkQRHovvJ7ah1B1zdy64TX4SEwCUdHADuLLW1W+OWOjsDmbk=
X-Google-Smtp-Source: AGHT+IFHAPreiTBW/x4aw1EHkJ+xwFEwTp7VKuG/mVJow7Yr8RLePATwqXZ4fsrz1nfOajC8ztz3lRiQ+gIc4ySw3aLXDkSDqeA7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c545:0:b0:3d1:78f8:7490 with SMTP id
 e9e14a558f8ab-3d30487a027mr64643795ab.14.1740584659314; Wed, 26 Feb 2025
 07:44:19 -0800 (PST)
Date: Wed, 26 Feb 2025 07:44:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf36d3.050a0220.38b081.01ff.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_tx_mlme_mgmt
From: syzbot <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff202c5028a1 Merge tag 'soc-fixes-6.14' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d447a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aca5947365998f67
dashboard link: https://syzkaller.appspot.com/bug?extid=5a7b40bcb34dea5ca959
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/788b15dfbf95/disk-ff202c50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48f236cd3e71/vmlinux-ff202c50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b92116dbc946/bzImage-ff202c50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com

 cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace 0000000000000000 ]---
=====================================================
BUG: KMSAN: uninit-value in cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
 cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
 ieee80211_report_disconnect net/mac80211/mlme.c:4238 [inline]
 ieee80211_sta_connection_lost+0xfa/0x150 net/mac80211/mlme.c:7811
 ieee80211_sta_work+0x1dea/0x4ef0
 ieee80211_iface_work+0x1900/0x1970 net/mac80211/iface.c:1684
 cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable frame_buf created at:
 ieee80211_sta_connection_lost+0x43/0x150 net/mac80211/mlme.c:7806
 ieee80211_sta_work+0x1dea/0x4ef0

CPU: 1 UID: 0 PID: 4086 Comm: kworker/u8:16 Tainted: G        W          6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
=====================================================


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

