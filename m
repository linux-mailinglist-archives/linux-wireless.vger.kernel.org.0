Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D62D388C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 03:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLICDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 21:03:52 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56944 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLICDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 21:03:52 -0500
Received: by mail-io1-f69.google.com with SMTP id e14so101232iow.23
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 18:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E9xG3iyNfrP/GYWZb90Sp2F2EzhvTQUjhkBvmN3+tHQ=;
        b=XvG+Kl9gKPsRhYASiid9e2UfbGNfvI/EDFZJs2myxN8tG59SP8LgTMJfhaGMSIHGsR
         LHM8ydNQjGrU25dNTX7DIWEBcVelAGAKLSBwkB/U9J2LJ8oy2h4VbH72TXpIp3kRBdol
         jvfPahMwl5HEZhVnCLbLLy0Z+DoZwcwZRwrBERjMrgyMoKv2UYUwzmO/nI9t7/0yBsCQ
         2ydQRYJiaHhtyHujREtPqT3HS/HWTjQSHA7kPDqKZWCpRKCDdDyBySfode8MdOqEN4O2
         nBPDvum9Y8IjVPZRlRfWxNmL/XcBgjQXntg2HxLnr2fLX9XWeBsxS6tVd+9DctTf2eA8
         KlHg==
X-Gm-Message-State: AOAM531WlbgquTxgmfgUjV8+fsiM16mkoJqxqTXD3DOxhRkhZjwbrGll
        ZCdDfofrdta/VLEI3IfOOnePOVJaOEDngg2XjSo5czb1SEQh
X-Google-Smtp-Source: ABdhPJy19747t00bDr/yvHnDjwY30zBiNJh90X9rO+k25E5A1LootuscWyCobb3YfQ/0Bd1TTGw741aXKN47A0bE60I/9cIfy63y
MIME-Version: 1.0
X-Received: by 2002:a05:6638:39a:: with SMTP id y26mr313956jap.14.1607479391017;
 Tue, 08 Dec 2020 18:03:11 -0800 (PST)
Date:   Tue, 08 Dec 2020 18:03:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015e0c705b5fe7627@google.com>
Subject: WARNING in ieee80211_start_next_roc
From:   syzbot <syzbot+c3a167b5615df4ccd7fb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e87297fa Merge tag 'drm-fixes-2020-12-04' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d9c9d3500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171f77e3500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1603469b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3a167b5615df4ccd7fb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8533 at net/mac80211/offchannel.c:401 ieee80211_start_next_roc+0x1f4/0x240 net/mac80211/offchannel.c:401
Modules linked in:
CPU: 1 PID: 8533 Comm: kworker/u4:1 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy4 ieee80211_scan_work
RIP: 0010:ieee80211_start_next_roc+0x1f4/0x240 net/mac80211/offchannel.c:401
Code: d0 21 00 00 48 89 ef 48 89 c2 e8 77 7f 0b 00 5b 5d e9 d0 f4 28 f9 e8 cb f4 28 f9 48 89 ef e8 c3 73 ff ff eb 8d e8 bc f4 28 f9 <0f> 0b eb 84 48 c7 c7 9c df ec 8c e8 1c 73 6a f9 e9 2f fe ff ff e8
RSP: 0018:ffffc9000167fb80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff88470edd
RDX: ffff88801f861a40 RSI: ffffffff88470fc4 RDI: 0000000000000001
RBP: ffff8880292c0c80 R08: 0000000000000001 R09: ffffffff8ebaf727
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880292c25b8
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff0e86f950 CR3: 000000001d954000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __ieee80211_scan_completed+0x602/0xed0 net/mac80211/scan.c:477
 ieee80211_scan_work+0x3dd/0x1a90 net/mac80211/scan.c:1119
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
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
