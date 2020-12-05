Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4032D2CF8F7
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 03:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgLEC2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 21:28:49 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:42395 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbgLEC2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 21:28:49 -0500
Received: by mail-il1-f198.google.com with SMTP id j18so7223916ilc.9
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 18:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w4/9O/+L4JuRl8+48xslFll28CVphFIEJatbgOnAzZI=;
        b=knHp9YADAyp1t9DUI+UWIhBuV0SKT1vMDVCfn1g6TscrOTtSFZInMTMwrRETQiP6W1
         Ax88sowQ2VP78Zi6Ni5RLn4Zev9l/E+4QFogR3a/bq4LdzQbj848R5DgDqvHZrpERCSV
         inzNLL7bWR0Ky4f0tG/Wn7BASmPsx+PZQ1FNpAx6K9DAnsGgvFwOsheCQa486ITkeN7i
         PJU+TtyortsY46nVCht03KDR1SLSqa2GJmWmP7e5qSK2HrucYcJ+DXIvC5kDAdy5Vb2+
         YbP67Tqdb2stgkQ3KX/aLQY8G3+qB+diHYS4e72f/FOfYKL+cWDxxGxvTKKsGHUSihHR
         0/sg==
X-Gm-Message-State: AOAM532bvPhfahEN+5EB3n0meLdIpi1Hh+ZeKeiqxwH4DMqOdcxQC2A5
        l1wozYfBn2nZetKHUHk8H6DloW7WmyVab5rokcDTJVktY4fW
X-Google-Smtp-Source: ABdhPJzcGLJLoUdiDVeD9UBE3qPB8XHF7kE7pmtvZPMXeIVEBsxOE4/2MZpsIziEw2y5nBceTjNX6ui6XvQOLtlEJT7iWqaZVQwy
MIME-Version: 1.0
X-Received: by 2002:a92:b61a:: with SMTP id s26mr9561675ili.239.1607135288665;
 Fri, 04 Dec 2020 18:28:08 -0800 (PST)
Date:   Fri, 04 Dec 2020 18:28:08 -0800
In-Reply-To: <0000000000008c848805b123f174@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcafca05b5ae5739@google.com>
Subject: Re: WARNING in ieee80211_ibss_csa_beacon
From:   syzbot <syzbot+b6c9fe29aefe68e4ad34@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e87297fa Merge tag 'drm-fixes-2020-12-04' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1412f617500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=b6c9fe29aefe68e4ad34
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15131837500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14550ecf500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6c9fe29aefe68e4ad34@syzkaller.appspotmail.com

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
------------[ cut here ]------------
WARNING: CPU: 0 PID: 21 at net/mac80211/ibss.c:504 ieee80211_ibss_csa_beacon+0x5ec/0x730 net/mac80211/ibss.c:504
Modules linked in:
CPU: 0 PID: 21 Comm: kworker/u4:1 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy10 ieee80211_csa_finalize_work
RIP: 0010:ieee80211_ibss_csa_beacon+0x5ec/0x730 net/mac80211/ibss.c:504
Code: ff e8 a8 b7 9c 00 31 ff 89 c5 89 c6 e8 9d 2c 27 f9 85 ed 0f 85 84 fa ff ff e8 40 34 27 f9 0f 0b e9 78 fa ff ff e8 34 34 27 f9 <0f> 0b 41 bd ea ff ff ff e9 e1 fd ff ff e8 72 b2 68 f9 e9 8f fa ff
RSP: 0018:ffffc90000dbfc50 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801c070c00 RCX: ffffffff8155a937
RDX: ffff888010e1b480 RSI: ffffffff8848d04c RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffffff8ebaf727
R10: fffffbfff1d75ee4 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801c0718f0 R14: ffff888022400c80 R15: ffff88801c071248
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdcb7060000 CR3: 0000000012b2b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ieee80211_set_after_csa_beacon net/mac80211/cfg.c:3133 [inline]
 __ieee80211_csa_finalize+0x504/0xbf0 net/mac80211/cfg.c:3189
 ieee80211_csa_finalize net/mac80211/cfg.c:3212 [inline]
 ieee80211_csa_finalize_work+0x131/0x170 net/mac80211/cfg.c:3237
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

