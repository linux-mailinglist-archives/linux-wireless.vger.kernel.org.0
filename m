Return-Path: <linux-wireless+bounces-26200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F8B1D4DD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED0F188E467
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E025D218;
	Thu,  7 Aug 2025 09:34:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3B25C6F1
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559274; cv=none; b=CzQFzwaBxy4opKXNZpPI+ZUUSRrO/uAewlV4gUP6zn+u0nxfpGfyN6HDXVJxRbhNi+5+YukStiX+A2E+bfE21MbA98QTIToF7DPZhBsa378Kdlfw3VwxkR/sHn9MabudkBx6kzye7QyQtLD3yUpw2sZvKuU95TuHz0+3eX7ad3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559274; c=relaxed/simple;
	bh=gELV5DYZDqSPBZtY1LBmOo1nEqecEpnLJxkPRWpmJ38=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SIhxtGvPpsNiH9dwVYBAoZ0ASdGjGi2nWODwkblBY5m1mRJDaHgJ1t+MqQ2vCW2fszgY/IRZkbihrlgdGUpQEsdFe2BmC0z3hjvEY9ST2BzrjfyokEZQYQs81kJHUQWMrp00pXWgXe3rnD8J/lNlvnD+6FuoywiGA4BvpuMw+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88178b5ce3aso71081439f.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559271; x=1755164071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjyqg8duMD58S8gtCQt8SefX/SjwKnwP2yTVcNnSrno=;
        b=YL8fdV6esQERgOnBPF/M4ZRzhjXbVwwhmpZ7DiiwJvUcErdVazfhHIQEpz6wcnQlIR
         Qf1teJDK4SJ5L3DPRZax8wpnWXYF4E4cfWo/qCXn2fH6IUBBuKUCjrp8q/e5ag+87sz3
         kZ2IqEcveA9hm+BB+f/C6K2+GfTswrLurBbhuo338QfB9EY/A8CJVPGrjbVQvSmAkmto
         UVIzUbYs9NBy3JzNbNYW3J9jF5Q19RZVyc7TMEXfZHrxCve8PcTNcUQQb1SawJIQIIDb
         y/9uI1GxeCrTS8MRWhgptDPz3lfJJXyTYT8P9boOXsmavqzCxRaQDxLTYzXyzEKMxXLq
         AUpw==
X-Forwarded-Encrypted: i=1; AJvYcCX/DYdMxMsNrRNBOshz0+R2OWESbviejoYRRkHifYrkJdleRGgVCdkJvybFlpnsQdnu6hmB1K+aSA+5oNQjnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwit9iJ6INvSPaJ+YcjvZ2GY0jB7PFOpudt3bYDXAQ3yfLrvco
	lFKaeDtsTEYPr+QRfFpJjy0rL+4VsI29w+blNa8tJ4ZIN2Ls+QVL9CjxtFi8fKnTx36OCFdPHuA
	BSFA07hfERohS/CzxLnBuc4eMyrpCi21eV/CPR0iiItqpKa/utTX2919aMIw=
X-Google-Smtp-Source: AGHT+IGUmKSJT+d2iFTfH8WysDJUk7tflpCz4aox3079lXYwbRbYkW5oei9UVRZ+1Qti6tt3sRTcpTmEZrUR7RII+gdYo6AsG1N+
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:580d:0:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-8819f0b93b9mr978115239f.6.1754559271215; Thu, 07 Aug 2025
 02:34:31 -0700 (PDT)
Date: Thu, 07 Aug 2025 02:34:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68947327.050a0220.7f033.0042.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_recalc_chanctx_chantype
From: syzbot <syzbot+3e1ddd8aa744da8bec01@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1489c434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62d04834ef6637ed
dashboard link: https://syzkaller.appspot.com/bug?extid=3e1ddd8aa744da8bec01
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e5f109fb8fc/disk-7e161a99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/051cd2ea2369/vmlinux-7e161a99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4d2819ae9d5/bzImage-7e161a99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e1ddd8aa744da8bec01@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6016 at net/mac80211/chan.c:844 ieee80211_recalc_chanctx_chantype+0x7a7/0xae0 net/mac80211/chan.c:844
Modules linked in:
CPU: 1 UID: 0 PID: 6016 Comm: kworker/u8:3 Not tainted 6.16.0-syzkaller-11699-g7e161a991ea7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:ieee80211_recalc_chanctx_chantype+0x7a7/0xae0 net/mac80211/chan.c:844
Code: 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 84 6f f9 ff ff 4c 89 ff e8 14 60 0c f7 e9 62 f9 ff ff e8 8a 08 a7 f6 90 <0f> 0b 90 e9 18 fc ff ff e8 7c 08 a7 f6 49 8d bd a0 09 00 00 48 b8
RSP: 0018:ffffc900047c7098 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000000f RCX: ffffffff8b1484e2
RDX: ffff888030da5a00 RSI: ffffffff8b1489d6 RDI: 0000000000000005
RBP: dffffc0000000000 R08: 0000000000000005 R09: 000000000000000f
R10: 000000000000000f R11: 0000000000000000 R12: 1ffff920008f8e1c
R13: 0000000000000000 R14: ffff88805288a8c0 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff8881247c7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000008000 CR3: 000000000e380000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ieee80211_assign_link_chanctx+0xb90/0xf00 net/mac80211/chan.c:944
 __ieee80211_link_release_channel+0x273/0x4b0 net/mac80211/chan.c:1890
 ieee80211_link_release_channel+0x128/0x200 net/mac80211/chan.c:2165
 ieee80211_leave_mesh+0x71/0x150 net/mac80211/cfg.c:2842
 rdev_leave_mesh net/wireless/rdev-ops.h:372 [inline]
 cfg80211_leave_mesh+0x23e/0x900 net/wireless/mesh.c:277
 cfg80211_leave+0x26a/0x3f0 net/wireless/core.c:1383
 cfg80211_netdev_notifier_call+0x2c1/0x1120 net/wireless/core.c:1567
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2229
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_close_many+0xff/0x770 net/core/dev.c:1726
 netif_close_many+0x233/0x630 net/core/dev.c:1780
 netif_close net/core/dev.c:1797 [inline]
 netif_close+0x17f/0x230 net/core/dev.c:1791
 dev_close+0xaa/0x240 net/core/dev_api.c:220
 cfg80211_shutdown_all_interfaces+0x9a/0x220 net/wireless/core.c:277
 ieee80211_remove_interfaces+0xc3/0x740 net/mac80211/iface.c:2364
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1664
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5674 [inline]
 hwsim_exit_net+0x3ac/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6554
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:251
 cleanup_net+0x408/0x890 net/core/net_namespace.c:682
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

