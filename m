Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1672DF2BD
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Dec 2020 03:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgLTCYv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Dec 2020 21:24:51 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51534 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgLTCYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Dec 2020 21:24:50 -0500
Received: by mail-il1-f198.google.com with SMTP id 1so6100799ilg.18
        for <linux-wireless@vger.kernel.org>; Sat, 19 Dec 2020 18:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e/+45KsrkxuceWPsi1nn3MJusxIcgpOYQGU/ooaZp5A=;
        b=q3akrYJG47RX1hUcvMjw+mUdEE6v7tbEu2zxMtkl9nY2Bq9yRtj9tBcaBRNBkOf75l
         cxalknAjXUcSgRP/EbJPQEyicCgU9Zim8bZfs3TLhbE+QqUFnyIwRWN6HLdSfeYI5koS
         sh1x5blJk0twqFKezF7+f2EFvVEdEpmg8WuneVuU9TCVVAZ7vH7KGkLIFjpej6LFS6zL
         sUSAB6Y9C9zQkm4NSIE+dvSPwoiYbPZVZeeBm5ESnFQZt3T9SW/+vXMorwKJRvxhm5a7
         A42A1+PP9sLoi2xNUHjGcxgKLI0Zg7qYh9Z1chzwdWnO3wnYGSeOIp70MnWZbB7WrH6A
         Uavw==
X-Gm-Message-State: AOAM531tNa/zVHvBox2KwMH+oZvOHDDhz+MtxI4nwIsmr83UVHZ0vMbx
        11cbnaj0zW31fzuXMBKckDuIAQfHCNpWK7Yfhs0/di+xkvzj
X-Google-Smtp-Source: ABdhPJz5GbqlxCYGWPbFsIbV9s7lX8WQ0OekktVcVTiGZdhCjRGuGHdXr1b48+rZCvw2K0bCVD9o7R8uMD8rJCkg/iiYwVRqDwSz
MIME-Version: 1.0
X-Received: by 2002:a92:ce47:: with SMTP id a7mr11393170ilr.261.1608431049879;
 Sat, 19 Dec 2020 18:24:09 -0800 (PST)
Date:   Sat, 19 Dec 2020 18:24:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fb61b05b6dc095b@google.com>
Subject: WARNING: suspicious RCU usage in wiphy_apply_custom_regulatory
From:   syzbot <syzbot+27771d4abcd9b7a1f5d3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ilan.peer@intel.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        luciano.coelho@intel.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d635a69d Merge tag 'net-next-5.11' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14502c13500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3556e4856b17a95
dashboard link: https://syzkaller.appspot.com/bug?extid=27771d4abcd9b7a1f5d3
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1593f703500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176dc937500000

The issue was bisected to:

commit beee246951571cc5452176f3dbfe9aa5a10ba2b9
Author: Ilan Peer <ilan.peer@intel.com>
Date:   Sun Nov 29 15:30:51 2020 +0000

    cfg80211: Save the regulatory domain when setting custom regulatory

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fcc77f500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11fcc77f500000
console output: https://syzkaller.appspot.com/x/log.txt?x=16fcc77f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27771d4abcd9b7a1f5d3@syzkaller.appspotmail.com
Fixes: beee24695157 ("cfg80211: Save the regulatory domain when setting custom regulatory")

=============================
WARNING: suspicious RCU usage
5.10.0-syzkaller #0 Not tainted
-----------------------------
net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor434/8467:
 #0: ffffffff8cd0bd70 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:810
 #1: ffffffff8cd0bc28 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8cd0bc28 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0xb1/0x1280 net/netlink/genetlink.c:798

stack backtrace:
CPU: 1 PID: 8467 Comm: syz-executor434 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:120
 get_wiphy_regdom net/wireless/reg.c:144 [inline]
 wiphy_apply_custom_regulatory+0x784/0x910 net/wireless/reg.c:2574
 mac80211_hwsim_new_radio+0x1eb3/0x3930 drivers/net/wireless/mac80211_hwsim.c:3247
 hwsim_new_radio_nl+0xb07/0xf60 drivers/net/wireless/mac80211_hwsim.c:3822
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2494
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x780/0x930 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x9a8/0xd40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2336
 ___sys_sendmsg net/socket.c:2390 [inline]
 __sys_sendmsg+0x2bc/0x370 net/socket.c:2423
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440309
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeafb01018 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440309
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000401ba0 R11: 0000000000000246 R12: 0000000000401b10
R13: 0000000000401ba0 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
