Return-Path: <linux-wireless+bounces-14840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017609B9E6F
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 10:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F0A1C20DA2
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6C16A92C;
	Sat,  2 Nov 2024 09:52:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB2154BFF
	for <linux-wireless@vger.kernel.org>; Sat,  2 Nov 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730541142; cv=none; b=JLwuka2PTSx4ixQfUHQ67G9//SQ/O4aYwfy4hQxPPxv0F+anXSg9h8n3yP2DowQJNIWqoHBKdhZ4veT0GRM6Tg0VWocTRgX7qab4FlnJt0C9C8kVI31d+wbmQmlFIvC6TK3+3QCIYef4Sg9JdrkVIZe6N9ByGjps32Grs5+qwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730541142; c=relaxed/simple;
	bh=GxrjJnXGW6sCjILVBpRuGw7tXtuPIvPHnn0g5HYWMi4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GXtcP8p+eqq9f6IMKrv5+Pth4r6RUDOzFeIP68MYzPHV7DpSsAKLb9j65W3UziPLrcmr1lDXufIqY5IfowezdJfhFkjhmA5HLsFgO4vuXqkyUCCVkpYTg2I0IhQbF6Bt5F9EQ6XeLRz4dJmB08PaKHpV+GSkZ7wdgG6TVexd1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so29397075ab.0
        for <linux-wireless@vger.kernel.org>; Sat, 02 Nov 2024 02:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730541140; x=1731145940;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nf4dj4k5c/58PSLQgpPF9A/XJV10m35XQHJdZxnCHw=;
        b=VvjGawZ9a80zVX7OOl3xp5DtevHMyLxS6P/myKBdiHalbBU/yiO9Noid72Mj5BZYFZ
         wJZwzVDZwBTlpSysUXiCA4BYuD4CNXUV0ILH1KGHk8csotc6zD0bf67blRiApxWgHI9+
         /8+aeuSAc68Fz+Ow3ayGq4trzlPTrhfDgyCPzx7VButOslwI53jL5fga2Y3kDfb1fQ1K
         Ygx1UNuYhX7P8jkvf/bj9c5HYNPTv1bzOJssZllasWWqqR1uckWAcTjjLaKqfjoiP6Y9
         52XD/E49eKtV9VqMEPtoOVpTJQVTnIsPpN52d3IXVPZlYGkzImEmSWupVoFREP8gfFI1
         rVtw==
X-Forwarded-Encrypted: i=1; AJvYcCXUI4F8/sJvXxY5HfoStOnAQrVuQJGTdmkzn5aX8Y1EAAbTjUM5swRXFuJ8RbpTxnqQM6XnLIhxJ4E/a7bL4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg39C28SPyerk2H0WjbGdmFiLTsVUm7XbMB34qcVOTfogUVc/9
	BuNa60VYUm4BTfLYD57Kysu1vxRc+7ZsE+85kQciBxDTWKff4/PvOdmmtNB1D750uDl2xjQsvt/
	PJbHp6cJxsInB6N/iTvcEfq6YwxQc2ykH6NQNX9U+aqAZZg+mc8XWqk4=
X-Google-Smtp-Source: AGHT+IHb0ZMHQqWAdWsXgk64U3xn3mks4qVwYd1/yAxUKlN/pmKz/xZviD0D6HvX92YpJ1nyhV/+NCPl6bWb/3uGVmKx9mVyYW0J
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:3a6:b1b0:6799 with SMTP id
 e9e14a558f8ab-3a6b1b067ecmr58208075ab.10.1730541140267; Sat, 02 Nov 2024
 02:52:20 -0700 (PDT)
Date: Sat, 02 Nov 2024 02:52:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725f654.050a0220.529b6.0297.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_mgd_probe_ap_send (2)
From: syzbot <syzbot+ab9bce876a60d87abeb0@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94c11e852955 usb: add support for new USB device ID 0x17EF..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11f6eca7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=ab9bce876a60d87abeb0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86f5604d3b74/disk-94c11e85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8be1f807098d/vmlinux-94c11e85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c343d3004f40/bzImage-94c11e85.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab9bce876a60d87abeb0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at net/mac80211/mlme.c:3843 ieee80211_mgd_probe_ap_send+0x4e3/0x5c0 net/mac80211/mlme.c:3843
Modules linked in:
CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc4-syzkaller-00174-g94c11e852955 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_mgd_probe_ap_send+0x4e3/0x5c0 net/mac80211/mlme.c:3843
Code: 5d 41 5e 41 5f 5d e9 bc 79 33 f6 e8 37 d3 46 f6 90 0f 0b 90 eb b6 e8 2c d3 46 f6 90 0f 0b 90 e9 fc fb ff ff e8 1e d3 46 f6 90 <0f> 0b 90 e9 bf fc ff ff e8 10 d3 46 f6 90 0f 0b 90 e9 30 ff ff ff
RSP: 0018:ffffc90000107b20 EFLAGS: 00010293
RAX: ffffffff8b4e04a2 RBX: 0000000000000001 RCX: ffff88801ce83c00
RDX: 0000000000000000 RSI: ffffffff8c0adcc0 RDI: ffffffff8c6102e0
RBP: 1ffff11005239377 R08: ffffffff901d002f R09: 1ffffffff203a005
R10: dffffc0000000000 R11: fffffbfff203a006 R12: ffff8880291ca972
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff8880291c8cc0
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555565f7b5c8 CR3: 0000000033890000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
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

