Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB13D1E07
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhGVFbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 01:31:42 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49794 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGVFbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 01:31:42 -0400
Received: by mail-il1-f198.google.com with SMTP id f13-20020a056e0204cdb02902087dbca2b6so2942827ils.16
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 23:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zd5EMJMxH832+tT0bxAQpl6QF9px5miSg1moPe7RgLE=;
        b=r45kVX7lWgdj8QpWsMl5hqjD0h7qaIZPAt7ovh6GwsbYbzb1SggRdYHza5lX+vSZjX
         cEfWxI9kEfGaBsdPZgiQqoU88qztxbOBerhH1HqEHl2Cvzl10VSOfpq8mogZEbfl8ITi
         0sytvHU4uYJZpdgoK3hQ8rlOcqeripV338WIaqNbOjnVk2PTZO44533kGJjbR4Lv/QIZ
         PNKQPzciTKXtNs+CHltLrYJTdDxcOE2kUZBVq+ZVfGjzGpzDO3bKkCvjT4PGf7kKCOuR
         yZVpyjgCk8zvS5R+w26p7zYNtbYPjhkhumuJ50l1ilbYKG2a1a7SnPA0vp/Pk7x8O0yM
         1xlw==
X-Gm-Message-State: AOAM532S7oZtfuxyZ9T/cqPr3vPldxBwU07CZRyAEy7/95n1Eev7n0y9
        sqwdUV1lUVMQBsF+Rb1oIz3mgtZyGZ6pzZLmh7+DbDxSry87
X-Google-Smtp-Source: ABdhPJyGq6K9u578UAGsM/2tYh+oYIElzFL2Rxc/VlZ+OAEzwe6DyBiTQuGigt+er0qLWf3U9vIzzQrSgfu1B4WNNDFqS7plRJ+X
MIME-Version: 1.0
X-Received: by 2002:a92:1942:: with SMTP id e2mr27746119ilm.4.1626934337416;
 Wed, 21 Jul 2021 23:12:17 -0700 (PDT)
Date:   Wed, 21 Jul 2021 23:12:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041351c05c7b02b15@google.com>
Subject: [syzbot] memory leak in reg_copy_regd
From:   syzbot <syzbot+1638e7c770eef6b6c0d0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d980cc0620ae Merge tag 'devicetree-fixes-for-5.14-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142c634a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7280943fd0476e5a
dashboard link: https://syzkaller.appspot.com/bug?extid=1638e7c770eef6b6c0d0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131de45a300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118cea5c300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1638e7c770eef6b6c0d0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111969200 (size 512):
  comm "syz-executor817", pid 8828, jiffies 4294955311 (age 19.340s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    05 00 00 00 39 39 00 00 00 00 00 00 d0 a6 24 00  ....99........$.
  backtrace:
    [<ffffffff83e971f0>] kmalloc include/linux/slab.h:596 [inline]
    [<ffffffff83e971f0>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff83e971f0>] reg_copy_regd+0x30/0x120 net/wireless/reg.c:444
    [<ffffffff83e98e21>] wiphy_apply_custom_regulatory+0x101/0x1a0 net/wireless/reg.c:2582
    [<ffffffff82b31e27>] mac80211_hwsim_new_radio+0x897/0x1300 drivers/net/wireless/mac80211_hwsim.c:3344
    [<ffffffff82b32cb5>] hwsim_new_radio_nl+0x425/0x5f0 drivers/net/wireless/mac80211_hwsim.c:3924
    [<ffffffff83867aa3>] genl_family_rcv_msg_doit+0x113/0x180 net/netlink/genetlink.c:739
    [<ffffffff83868184>] genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
    [<ffffffff83868184>] genl_rcv_msg+0x174/0x2c0 net/netlink/genetlink.c:800
    [<ffffffff83866857>] netlink_rcv_skb+0x87/0x1d0 net/netlink/af_netlink.c:2504
    [<ffffffff83867164>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
    [<ffffffff83865a42>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
    [<ffffffff83865a42>] netlink_unicast+0x392/0x4c0 net/netlink/af_netlink.c:1340
    [<ffffffff83865edb>] netlink_sendmsg+0x36b/0x6b0 net/netlink/af_netlink.c:1929
    [<ffffffff836cf446>] sock_sendmsg_nosec net/socket.c:703 [inline]
    [<ffffffff836cf446>] sock_sendmsg+0x56/0x80 net/socket.c:723
    [<ffffffff836cf9ac>] ____sys_sendmsg+0x36c/0x390 net/socket.c:2392
    [<ffffffff836d39fb>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2446
    [<ffffffff836d3af8>] __sys_sendmsg+0x88/0x100 net/socket.c:2475
    [<ffffffff843af915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843af915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
