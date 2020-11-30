Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8511D2C894E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgK3QVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 11:21:00 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:36164 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgK3QU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 11:20:59 -0500
Received: by mail-il1-f200.google.com with SMTP id r3so10733165ila.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Nov 2020 08:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C33L09Ngl8k3zC17DaXXjH/m/uESLHGh+7cRNci9HLE=;
        b=rxuCpKM+vNxaZOZCfunmOMCQJ5BPODc97yx/3OzAlGdGO59XW46q+4fQh0wuMWoH9+
         vciPipkvxki2ElyzURrJm6pl7VVplavoVORGTRkb1fbyn+kd1BXgHD7WcAQf9CJdxPeK
         KsPHyntLEIqUUt2Cn4lVGKfbiiGHWHzaH8k/xTaK5hy9JoE71bE8kyl4Jw3oLuhBz5u2
         dpqEprXJocZrFPsaTbm6L6yDkrCTt7Rwd4VtPuZJy3GfBEPPazeDLST+mUiPAAXRZOGt
         cRT/hVwj+geKbgYtKJaJ5zQqK7UOa7Uz8Pbh3IvFdmSYy5zICS1LKLjx0X7c2ZX6Z5v8
         nr2w==
X-Gm-Message-State: AOAM530b1+r+g8lYGx5tU8jbZBAKkljE5Olx9w8fBxF0aT1QM/u1w+ml
        jQkWFKxeOifqLmwRulAug0Ry22dDxwgTluytTz3r+ammcYl+
X-Google-Smtp-Source: ABdhPJxzPxDTZp8ujfJttvjLHOZwW6U4zPHCbQi/fsE21qpMm6s6oTHMhcx2tsrsxUoVADxfENSzCf9PlyX8cpnVGAJFj6GX85DS
MIME-Version: 1.0
X-Received: by 2002:a92:8707:: with SMTP id m7mr18457408ild.217.1606753218317;
 Mon, 30 Nov 2020 08:20:18 -0800 (PST)
Date:   Mon, 30 Nov 2020 08:20:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1d6c605b55562ee@google.com>
Subject: UBSAN: array-index-out-of-bounds in ieee80211_del_key (2)
From:   syzbot <syzbot+49d4cab497c2142ee170@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aae5ab85 Merge tag 'riscv-for-linus-5.10-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1496d353500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb8d1a3819ba4356
dashboard link: https://syzkaller.appspot.com/bug?extid=49d4cab497c2142ee170
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1440c58d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1743351d500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49d4cab497c2142ee170@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in net/mac80211/cfg.c:520:10
index 5 is out of range for type 'ieee80211_key *[4]'
CPU: 0 PID: 8535 Comm: syz-executor933 Not tainted 5.10.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 ieee80211_del_key+0x3f6/0x440 net/mac80211/cfg.c:520
 rdev_del_key net/wireless/rdev-ops.h:107 [inline]
 nl80211_del_key+0x4b0/0x910 net/wireless/nl80211.c:4292
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441ff9
Code: e8 ac 00 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb026c968 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441ff9
RDX: 0000000000000000 RSI: 0000000020000300 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000002100000000 R09: 0000002100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000000000 R14: 000000000000000c R15: 0000000000000004
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
