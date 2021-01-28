Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11D307B95
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhA1Q7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 11:59:15 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38211 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhA1Q7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 11:59:03 -0500
Received: by mail-il1-f197.google.com with SMTP id p14so5221612ilb.5
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jan 2021 08:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mxBo7GSpl9KGb7h1SJntq4kG1RLVxg1nNLCFse4vDP4=;
        b=ZpIsHK4g0WLkrvUAOXP9mw6nQLHgb5aq/x6TtcLO7zhqZxoJA9UV/fK9AKJzUCoAIK
         /7+VeryyvDNgvZHppqG1y6dRk+LJw/lmro4UJQEjpzPQcDomQM2Q1kv6yNVQ0mw63nF7
         tWp4R1fliVdOuzg6Q+JEbxhCuaaddxQcFEJJ6j7qhQ+OBGtWTr09e8QefycvLFHdWlwv
         pBG0Ep6ISS7w1uo0jFbXQKSHAULVIh1iDq4GO4n9s9k0kw0YPEbeI90rA8gSbsIz5alV
         6dzjU6gNWWuCReT9Sz5P0uokfXWFdR8Z+nuiE/ZsxEof9XKeRrNgCy1iNZ4NOF6dQ2oE
         ZfXQ==
X-Gm-Message-State: AOAM533+w5Nw+86gsWMIaYDnTJCI7/GrHE986naSTrWE5unOzY91dqQu
        3t8VLA9R91DjsV1fEWiXFGGopibYeOTsax8dyxQAxdOolWJB
X-Google-Smtp-Source: ABdhPJw1v3CbPN8Ay3+heriub4wPORYfoysyzxXxA2IhuUoQrlvFOP6ncJj8X09PfaWaSt9m1f8VK6HJ9Z7SMRVxsN4Sh3rMu4Pm
MIME-Version: 1.0
X-Received: by 2002:a6b:f406:: with SMTP id i6mr460379iog.121.1611853103020;
 Thu, 28 Jan 2021 08:58:23 -0800 (PST)
Date:   Thu, 28 Jan 2021 08:58:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2beb205b9f8cb96@google.com>
Subject: WARNING in _cfg80211_unregister_wdev
From:   syzbot <syzbot+4305e814f9b267131776@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d1f3bdd4 net: dsa: rtl8366rb: standardize init jam tables
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12460f2cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5f48fca2e44a9a2
dashboard link: https://syzkaller.appspot.com/bug?extid=4305e814f9b267131776
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c306bf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e0311b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4305e814f9b267131776@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 19 at net/wireless/core.c:1113 _cfg80211_unregister_wdev+0x453/0x740 net/wireless/core.c:1113
Modules linked in:
CPU: 1 PID: 19 Comm: kworker/1:0 Not tainted 5.11.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events cfg80211_destroy_iface_wk
RIP: 0010:_cfg80211_unregister_wdev+0x453/0x740 net/wireless/core.c:1113
Code: 3e f9 48 8d 7d 68 be ff ff ff ff e8 f7 c1 c6 00 31 ff 41 89 c6 89 c6 e8 fb 7f 3e f9 45 85 f6 0f 85 65 fc ff ff e8 6d 78 3e f9 <0f> 0b e9 59 fc ff ff e8 61 78 3e f9 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffffc90000d97c40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801c8ccbd0 RCX: 0000000000000000
RDX: ffff888010df5340 RSI: ffffffff88345363 RDI: 0000000000000003
RBP: ffff888014b08580 R08: 0000000000000000 R09: ffffffff8ca5a267
R10: ffffffff88345355 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888014b08000 R14: 0000000000000000 R15: ffff888014b08580
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004aeb50 CR3: 000000000b08e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ieee80211_if_remove+0x1df/0x300 net/mac80211/iface.c:2014
 ieee80211_del_iface+0x12/0x20 net/mac80211/cfg.c:144
 rdev_del_virtual_intf net/wireless/rdev-ops.h:57 [inline]
 cfg80211_destroy_ifaces+0x1d9/0x6e0 net/wireless/core.c:340
 cfg80211_destroy_iface_wk+0x1a/0x20 net/wireless/core.c:352
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
