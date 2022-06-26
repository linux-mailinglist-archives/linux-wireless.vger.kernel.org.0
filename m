Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42455B30C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jun 2022 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiFZRHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jun 2022 13:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiFZRHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jun 2022 13:07:24 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4ACD116
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jun 2022 10:07:22 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id s15-20020a056e02216f00b002d3d5e41565so4446388ilv.10
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jun 2022 10:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ghv9V02UI3cW9mMu3tiqyhBVgPq8Zyt/WmlW6q0s4go=;
        b=03Gu2t+szHZYV41sgra8HyGKLPXzHy706N8RUfb6OjNVntyZbbIffoZsroRTO+LFI3
         uYjgq43eWN/t+GAnPBvIkZ90AzwKukrUICU/Usk8ACFVQ0jU1k5bogGYbNRMeA2T3MF4
         JqHL4dRS7v0Gou8Xc+DcfTPLBcyudt/nYliZRFLqrKIzKH5U12IX4To1fRGmJLxRaTB7
         UUH2YHWWO8njEUFWEDuW/Z1ENvMdJS+0Gyr6ve6XrmID9WxuNveJXYNCSTu9peH9keuY
         JIxjGMOKWadjEo7t/BPO8RNisHQyV11FtcCPGS3CzlxxdEgvJnQsZDYI0MPZoIIFJlpf
         Ma7w==
X-Gm-Message-State: AJIora+5CaJ0/EJODjCsESxBBBU/OQbKtHfcAY8ZXCmv37HMs2/iLlcG
        W1bGBjDx4xK4O3TrizgLGXmW5Mq9P3c1AogS7YYV4X6wah7q
X-Google-Smtp-Source: AGRyM1sN7APmK99jnDwy7jPNCtNe+i/wJHImHJsgrv2H6BiEeLMHDzp3yBxbp3fkQkC3JrIulVDmTqMiQr/kj/lNvHCDE5HF+vuq
MIME-Version: 1.0
X-Received: by 2002:a92:cc4a:0:b0:2d8:f505:a44f with SMTP id
 t10-20020a92cc4a000000b002d8f505a44fmr5273827ilq.207.1656263241776; Sun, 26
 Jun 2022 10:07:21 -0700 (PDT)
Date:   Sun, 26 Jun 2022 10:07:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e465b05e25cd60c@google.com>
Subject: [syzbot] WARNING in ieee80211_link_info_change_notify
From:   syzbot <syzbot+bce2ca140cc00578ed07@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac0ba5454ca8 Add linux-next specific files for 20220622
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d4f08ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12809dacb9e7c5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=bce2ca140cc00578ed07
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1502ddf8080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e8c0a8080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158ee238080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=178ee238080000
console output: https://syzkaller.appspot.com/x/log.txt?x=138ee238080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bce2ca140cc00578ed07@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x4
WARNING: CPU: 1 PID: 3613 at net/mac80211/driver-ops.h:189 drv_link_info_changed net/mac80211/driver-ops.h:189 [inline]
WARNING: CPU: 1 PID: 3613 at net/mac80211/driver-ops.h:189 ieee80211_link_info_change_notify+0x63a/0x730 net/mac80211/main.c:284
Modules linked in:
CPU: 1 PID: 3613 Comm: syz-executor275 Not tainted 5.19.0-rc3-next-20220622-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:drv_link_info_changed net/mac80211/driver-ops.h:189 [inline]
RIP: 0010:ieee80211_link_info_change_notify+0x63a/0x730 net/mac80211/main.c:284
Code: ab e8 08 00 00 48 85 ed 0f 84 a3 00 00 00 e8 2d ac b8 f8 e8 28 ac b8 f8 8b 14 24 48 89 ee 48 c7 c7 60 e8 f3 8a e8 2a db 74 00 <0f> 0b e9 30 fb ff ff e8 0a ac b8 f8 e8 c5 e3 b9 00 31 ff 41 89 c6
RSP: 0018:ffffc90002f2f520 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88807cc94c80 RCX: 0000000000000000
RDX: ffff88801e921d40 RSI: ffffffff81610778 RDI: fffff520005e5e96
RBP: ffff88807cc94000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000002000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88807c4e0de0
FS:  00005555556e0300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000640940 CR3: 000000007c22d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_set_mcast_rate+0x39/0x40 net/mac80211/cfg.c:2716
 rdev_set_mcast_rate net/wireless/rdev-ops.h:1222 [inline]
 nl80211_set_mcast_rate+0x317/0x610 net/wireless/nl80211.c:11044
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2489
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2543
 __sys_sendmsg net/socket.c:2572 [inline]
 __do_sys_sendmsg net/socket.c:2581 [inline]
 __se_sys_sendmsg net/socket.c:2579 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2579
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f98d742d269
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff75c2ca58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f98d742d269
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000c00000000 R09: 0000000c00000000
R10: 0000000c00000000 R11: 0000000000000246 R12: 0000000000000031
R13: 00007fff75c2cac0 R14: 00007fff75c2cab0 R15: 00007f98d74a6410
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
