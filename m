Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB7421445B
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2020 08:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGDGlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jul 2020 02:41:17 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48154 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgGDGlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jul 2020 02:41:17 -0400
Received: by mail-io1-f69.google.com with SMTP id r9so3792982ioa.15
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2020 23:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dbAGA2EOQ/ON2OekN9vX84E1a2gFJIKvdksnE+aJIXg=;
        b=rLvvZUmIL7kZiMiznWSnHBJLeA091H0SbWmwmUzWzlqtpawVngHypY4E+lO8cGI3vn
         0qM8ujHGxXnfnuNqhiqAJ/KGiHfwOTIIPpL1HI4gPg6Ik8hykPcaURXfQI2e0XzPvTqx
         QKLQxzrvcGP669tKtEk0IWptvpBCVclQRBX72+bnWtVbXMSFGuLpkI4mUvtDuztGeejy
         OqCYbemBcEvugmvXzp+4hviEb3bDKYo4WQxHOftA0nhl+8WxgczHdizozFM/9PBWNw8j
         HbaUFWamOJsU7ID8Bl9bi1bMuB5RoXYk/dZ9nqXIrknKe1ZDXRvocsIvnOtYt+qjFiNO
         moBg==
X-Gm-Message-State: AOAM532MMmEu2hbVaNRvYYAKmey7H5mPmdzw+Hm6HqZQrdic9cn2ioCo
        nnKqWVCGRByuB15WcBwF9nQJRo8hLIGJVIh+XRxyDPFHlP2m
X-Google-Smtp-Source: ABdhPJwFvjbKbYwlvfSZJcJi+xsZs+I4CZcLu/Jdbz7IYY/TzLenHi+O2ZGUUc6HP06Sr+WSEo2Pu4ZfjcFBLKS/XdlA67SulQ82
MIME-Version: 1.0
X-Received: by 2002:a92:cecd:: with SMTP id z13mr20924386ilq.76.1593844875910;
 Fri, 03 Jul 2020 23:41:15 -0700 (PDT)
Date:   Fri, 03 Jul 2020 23:41:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7e38a05a997edb2@google.com>
Subject: WARNING in __cfg80211_connect_result
From:   syzbot <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    23212a70 Merge branch 'mptcp-add-receive-buffer-auto-tuning'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=155842d5100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
dashboard link: https://syzkaller.appspot.com/bug?extid=cc4c0f394e2611edba66
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com

ip6_tunnel: syzkaller1 xmit: Local address not yet configured!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9155 at net/wireless/sme.c:757 __cfg80211_connect_result+0xf71/0x13a0 net/wireless/sme.c:757
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9155 Comm: kworker/u4:17 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: cfg80211 cfg80211_event_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 exc_invalid_op+0x24d/0x400 arch/x86/kernel/traps.c:235
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:__cfg80211_connect_result+0xf71/0x13a0 net/wireless/sme.c:757
Code: 89 be ac 02 00 00 48 c7 c7 00 2d 16 89 c6 05 ba ce 34 03 01 e8 35 58 e5 f9 e9 4f f6 ff ff e8 36 ad fe f9 0f 0b e8 2f ad fe f9 <0f> 0b e9 0c f2 ff ff e8 23 ad fe f9 e8 ee 51 71 00 31 ff 89 c3 89
RSP: 0018:ffffc90001ab7bb8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888091d10000 RCX: ffffffff87749792
RDX: ffff888059f5c4c0 RSI: ffffffff8774a321 RDI: 0000000000000005
RBP: ffff888040f72618 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888040f72628 R14: ffff888091d10200 R15: ffff888040f72620
 cfg80211_process_wdev_events+0x2c6/0x5b0 net/wireless/util.c:885
 cfg80211_process_rdev_events+0x6e/0x100 net/wireless/util.c:926
 cfg80211_event_work+0x1a/0x20 net/wireless/core.c:320
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
