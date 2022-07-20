Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5AD57AA0D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiGSWwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jul 2022 18:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiGSWwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jul 2022 18:52:23 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DEF4E618
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 15:52:22 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9-20020a056e020b2900b002dc6c27849cso10159596ilu.8
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 15:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Cw/83ZRguJMt0yiilk+Lb82H2QSEAUnRgoZjDw4ouAE=;
        b=pXE8tCWVWpWl2Nv/gJTItNU2xwGUeEECT/rCXXr/jVufOLhhYswSswyJD/oi4JyruB
         4j+i1lNkvtHq6orXd6VUzhQkChQG3OmksvLP18cn+dcsD/Y5SNttI8OZCeY2saH6Rs0t
         NtVhomqL+QhKqhKByyie7Z0CCIjF1808o/L/BI1uEeQPwFi2AGbk6bCaelSozmNMQbzI
         OQC3PitIjR53TgWztD+m9p9qiMc15nkEwCeTZKin7juPwXYbz3NtN6RiRGEt/n6rbnGY
         L/Mh4tIOZ8GlmqEgg5KhrrxMMzb759bP+ku8R6CB5e/8pYwuwmHeD0JPoNIDUQ4S1YXp
         /xQw==
X-Gm-Message-State: AJIora/CWSmrZSKwFUIakUxPYOMn8AvBm97CbtqXi1Gq5hJftjq9yqkV
        8xjFKs8We/8TnjoJQf/T8JqfNjlNWyXSvNFIHdr6xQNVy0jt
X-Google-Smtp-Source: AGRyM1tCMNaxi+/GelASO+/vvssVObVcBa3Px2G+G8riojy54xxV/FHcaXdo3XqEfLE6HpWCvrJWxKaeNv/3mlTYN3DOK+43ysXG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:2dc:7f32:793b with SMTP id
 w9-20020a056e021c8900b002dc7f32793bmr18131888ill.189.1658271141511; Tue, 19
 Jul 2022 15:52:21 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:52:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054c80705e4305617@google.com>
Subject: [syzbot] WARNING in ieee80211_do_stop
From:   syzbot <syzbot+947c6f69525f513f8f14@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1369f77c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=947c6f69525f513f8f14
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+947c6f69525f513f8f14@syzkaller.appspotmail.com

netdevsim netdevsim5 netdevsim1: unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim5 netdevsim2: unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim5 netdevsim3: unset [1, 0] type 2 family 0 port 6081 - 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 581 at net/mac80211/iface.c:428 ieee80211_do_stop+0x23e/0x2090 net/mac80211/iface.c:428
Modules linked in:
CPU: 0 PID: 581 Comm: syz-executor.5 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:ieee80211_do_stop+0x23e/0x2090 net/mac80211/iface.c:428
Code: 00 89 ee e8 44 56 b4 f8 83 fd 04 0f 84 34 0b 00 00 e8 66 59 b4 f8 31 ff 44 89 e6 e8 2c 56 b4 f8 45 85 e4 7e 07 e8 52 59 b4 f8 <0f> 0b e8 4b 59 b4 f8 48 8b 44 24 10 48 8d b8 f8 08 00 00 48 b8 00
RSP: 0018:ffffc900148e6ef8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff888063179568 RCX: ffffc90003944000
RDX: 0000000000040000 RSI: ffffffff88c65dbe RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888063178c80 R14: ffff888063178c80 R15: ffff888063178268
FS:  00007ff2e381d700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f18f9f6d058 CR3: 000000006e168000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_stop+0xc5/0x600 net/mac80211/iface.c:686
 __dev_close_many+0x1b6/0x2e0 net/core/dev.c:1516
 __dev_close net/core/dev.c:1528 [inline]
 __dev_change_flags+0x2ca/0x750 net/core/dev.c:8549
 dev_change_flags+0x93/0x170 net/core/dev.c:8622
 do_setlink+0x961/0x3bb0 net/core/rtnetlink.c:2780
 rtnl_group_changelink net/core/rtnetlink.c:3302 [inline]
 __rtnl_newlink+0xb96/0x17e0 net/core/rtnetlink.c:3556
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
 rtnetlink_rcv_msg+0x43a/0xc90 net/core/rtnetlink.c:6089
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2485
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2539
 __sys_sendmsg net/socket.c:2568 [inline]
 __do_sys_sendmsg net/socket.c:2577 [inline]
 __se_sys_sendmsg net/socket.c:2575 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2575
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7ff2e2689199
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff2e381d168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff2e279bf60 RCX: 00007ff2e2689199
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000006
RBP: 00007ff2e26e313b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee21e618f R14: 00007ff2e381d300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
