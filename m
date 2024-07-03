Return-Path: <linux-wireless+bounces-9900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC8925781
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343211C24FCC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A451422CC;
	Wed,  3 Jul 2024 09:56:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAF1422B1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000586; cv=none; b=kScJ/XIxKlyxJ7ob6RZ8+UstaQ/i0u0MCgAflRn8Zk0yvvlGuvRqtYObh5b9HSZOP1BnFP+zfU8Ri3oo+V7eljJiX8O+4uBn4ET9Se+qEn0x0TZcKK4z4QKDY2Pyzlu8Re0IQd8pX0yTm7RQO251JbE4FSyqs8RRONrz2Eo4JFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000586; c=relaxed/simple;
	bh=/kiTWOs4ltQzwUEBThYjor7icgAsHIheHT3MRkr+wmY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hJgfFKkNDz00yGVeJZcR4eSf3B2IoXA24nanMsW0v6YSZLULx2S8aJ+1uuGDYPgzmXDZuVGGO75Q0u5x5YEf8/BMm0GCgR4uAIwJ+l00fTTRpngO5a2oOSKLGBB78SokgCUv5Bl7/UhhtMAANqNNI99exJGB8WMK0uyo8uq9WoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f4cff1d3d5so492047839f.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 02:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000584; x=1720605384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FY5C03KxkZrYdyjjPHGtHnHuVOgNSkiictHfwHQSyLI=;
        b=Q0rAUoY5bI0WoRvFTfZ3L69yuGLbJZNzbinDyEWGUSUwN6QKPH/pmQAA49gNO1NrQ+
         1gMygTflTMs2k6DhfdZ41VBFQoaqMq7618EU7DA8xhgeC0HDeZwBDHGfmMMSiW1ASWWt
         vMha8/5gGHQ2FRIlq1hujF9nIk/TrBoiM1X/nnSYtTnhylPFs2ibzVouMRG5lJHiLZm7
         iere1j1VTzOUukuOmi04VRIIjzKwDw85Tx+cVkjzTykIaIz+yzS4R6M7e1nnnGnFlyh8
         GqeENV6K5Qb6P4HtWiFiXmapb+2qcd9mMeQ8K1HWcayws7KLFDZ2RZUunzA7Lm1RCuYi
         CqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUHIRZ22xru6pBlhQ65yCYQmFg7yvHgZJSwStvEmrAYHh9Y89bafclVr4HQfjRsoVRtsgKflqaoTKKGSRnE6aqFk2/yUlSScxRZx1GKRyg=
X-Gm-Message-State: AOJu0YxjVNNOi2jQa555Z3/6/aNzBMVqJp3XQNB74t8+H/72rVMySE9W
	c5kSZ2X+SSlemh54Ho0ffVGBSnUxUIseuKwCbm9/8xQZwQQY0ycMvHVkc6MAWlkceOqdG4reLGx
	oohAKqo2285MmmliENpahcfFd996Sg0bUMuLCjwsIoIxvG+2JOTKoAgk=
X-Google-Smtp-Source: AGHT+IGa3IckrEyHM8si8aqAN/oiN06/0GFt5X7rAvzSMUGPPPEb5J4ZmA62eQGvL+rX2i+Afd19hUdk85VJc7AT8qdtbVN3hWrS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cb:b0:7f6:2e72:e818 with SMTP id
 ca18e2360f4ac-7f62ee1602amr54881339f.1.1720000583702; Wed, 03 Jul 2024
 02:56:23 -0700 (PDT)
Date: Wed, 03 Jul 2024 02:56:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce42b9061c54d76a@google.com>
Subject: [syzbot] [wireless?] WARNING in rate_control_rate_init (3)
From: syzbot <syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac26327635d6 Merge branch 'fixes-for-stm32-dwmac-driver-fa..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b17ab9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/192a90a6425b/disk-ac263276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/233fc7270a4e/vmlinux-ac263276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/585e26cc8536/bzImage-ac263276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8730 at net/mac80211/rate.c:48 rate_control_rate_init+0x588/0x5f0 net/mac80211/rate.c:48
Modules linked in:
CPU: 1 PID: 8730 Comm: syz.0.1096 Not tainted 6.10.0-rc5-syzkaller-01193-gac26327635d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:rate_control_rate_init+0x588/0x5f0 net/mac80211/rate.c:48
Code: 00 00 00 e8 4a 75 01 f7 f0 41 80 8d 82 01 00 00 20 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 69 ad 9b f6 90 <0f> 0b 90 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d eb 65 89 e9 80
RSP: 0018:ffffc90004717058 EFLAGS: 00010283
RAX: ffffffff8afa79b7 RBX: ffff88802deceb98 RCX: 0000000000040000
RDX: ffffc90009d89000 RSI: 0000000000001518 RDI: 0000000000001519
RBP: 0000000000000001 R08: ffffffff8afa7622 R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: ffff88802e488e20
R13: ffff88802a9c8000 R14: 1ffff1100553900a R15: 0000000000000000
FS:  00007f7083c2e6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7082d5b420 CR3: 000000002df6e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sta_apply_auth_flags+0x1b6/0x410 net/mac80211/cfg.c:1711
 sta_apply_parameters+0xe23/0x1550 net/mac80211/cfg.c:2061
 ieee80211_add_station+0x3da/0x630 net/mac80211/cfg.c:2127
 rdev_add_station+0x11b/0x2b0 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1d53/0x2550 net/wireless/nl80211.c:7683
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7082d75b99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7083c2e048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7082f03f60 RCX: 00007f7082d75b99
RDX: 0000000000000000 RSI: 0000000020001080 RDI: 0000000000000003
RBP: 00007f7082de4a7a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7082f03f60 R15: 00007fff740d84f8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

