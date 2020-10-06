Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E1284820
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJFIIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 04:08:35 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:50241 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgJFII0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 04:08:26 -0400
Received: by mail-io1-f77.google.com with SMTP id z18so1259588ioi.17
        for <linux-wireless@vger.kernel.org>; Tue, 06 Oct 2020 01:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=evtElNGqHX5N518w23DxEdOLqquM8mOgio/iHrWwqt4=;
        b=lsir0WUB8ZRulR284BUAy8eAeKPobdEeL31g4YEnQalZr++TCUxQlaGHIZmnSGKQ44
         Cmt1Og0MIKXWRNB+pTJDKTEdJQ5KLACd9UCIOJ/jYIlr3/z5d8HYklUa3oipxoFD4AV3
         2TwkyWRFrSXcG7lxmQDbC4J8BrUtDbbjIimYR8jva9CKVtCtG4krcEnJWJnl8Yf22bWs
         NHJwaKyEn0n0KBZgx3Q4Y+JtvSNyCms/7S4gRNvhiJKj/X5DCfkNhw9n7A1zU2gRmSGV
         nsWfl+KXRfTo5CFWr5iqLOzvXdAT1xFek3sAtD/pI+rUM+uan6seZUZv7DA0kZO0lCOK
         5MzQ==
X-Gm-Message-State: AOAM530Y+7IqIqAsl+a9nhIhbiDq7/IXJH78DseOhd6OdLXrfSdArSwf
        V2Y7LlLObCFa1hjF1cmX7EIUYWc0yoja1HvGYHpL3A70YF8L
X-Google-Smtp-Source: ABdhPJyYejaxvp6kprhFYjYKXBDzF+uADGsrF1Ql+wakuviBPIa48x8Am8vcJEhIILtI6PreVCZCpv4fxg/oXitpeMmCw32XBs32
MIME-Version: 1.0
X-Received: by 2002:a6b:3f88:: with SMTP id m130mr154540ioa.78.1601971704014;
 Tue, 06 Oct 2020 01:08:24 -0700 (PDT)
Date:   Tue, 06 Oct 2020 01:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bac7a05b0fc1ad1@google.com>
Subject: WARNING in ieee80211_probe_client
From:   syzbot <syzbot+999fac712d84878a7379@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c2568c8c Merge branch 'net-Constify-struct-genl_small_ops'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14051a2b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6c5266df853ae
dashboard link: https://syzkaller.appspot.com/bug?extid=999fac712d84878a7379
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1776330b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171f17ff900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+999fac712d84878a7379@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6910 at net/mac80211/cfg.c:3620 ieee80211_probe_client+0x6ed/0x7f0 net/mac80211/cfg.c:3620
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6910 Comm: syz-executor290 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:ieee80211_probe_client+0x6ed/0x7f0 net/mac80211/cfg.c:3620
Code: f9 48 c7 c2 20 77 61 89 be 7b 02 00 00 48 c7 c7 80 77 61 89 c6 05 4c 44 80 03 01 e8 82 1a 85 f9 e9 e3 f9 ff ff e8 13 25 9f f9 <0f> 0b 41 bc ea ff ff ff e9 51 fe ff ff e8 91 e8 e0 f9 e9 de fc ff
RSP: 0018:ffffc900056e74f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888093710000 RCX: ffffffff87d761d8
RDX: ffff888092e18280 RSI: ffffffff87d7629d RDI: 0000000000000005
RBP: ffff88809a47e020 R08: 0000000000000001 R09: ffffffff8d10d9e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888089750c80
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rdev_probe_client net/wireless/rdev-ops.h:929 [inline]
 nl80211_probe_client+0x3b7/0xc80 net/wireless/nl80211.c:12734
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2489
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
RIP: 0033:0x442169
Code: e8 ac 00 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff7f75b898 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442169
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 000000306e616c77 R08: 0000002000000000 R09: 0000002000000000
R10: 0000002000000000 R11: 0000000000000246 R12: 000000000000ee9b
R13: 0000000000000000 R14: 000000000000000c R15: 0000000000000004
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
