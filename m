Return-Path: <linux-wireless+bounces-8063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8EC8CF1DE
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 00:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483151F212B6
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70C1292CC;
	Sat, 25 May 2024 22:11:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF37127E2A
	for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716675089; cv=none; b=pk+/sHUmUdkzTG3KW0GoS1kc/tg3ratAO9mZ0POtySCbyarUccqYqvb0JCKR5vYFweq3LWl/s4Vnv+xVbeRe6Rq1eC924WFh1oxV7ABDifsLe52e61WULHyquozKGCWldgGc92+3RLRIv1SlMMNZHrS6f36FiVgkmxxJqCQNsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716675089; c=relaxed/simple;
	bh=Ur6Dqeq0an0sbxzY2FE9RISeaqM2GD8B9pxEVjBqYzA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SQThmaVT3dqdNhCz0HXUlbptnugBIgKhZILZ1I8KGLBTob5FixA7pP/SEfAH0JdOJq72iNe1wOBtC2oLWrQbHoG4NcG67OafeqB2xepR9jmJpeqxndfG99tpMv6A5zEYaWdxfqKCZkcCwAsFaNzb0AAZvHF+jOcKakFxlJO7Q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e8dc9db8deso125558039f.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 15:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716675087; x=1717279887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/zSiWmUCwwFtr8N3mtKOP5EhN+bLIF0RlbPBoqAQQA=;
        b=xRJu+FmZzQyJt62E248jKBRvWS+nTmEfWBHj5K5KJOca90wZY1mwfh8qgjzdMZtTsh
         etkowd2LTtWkuVaq0aRos1mJBgkHSfeWOvHJHSskK1MoWfWuE3iqQso9FASp0gzNykSk
         kGQZH9S0Ls3R0BAUfQ72+M7dxR3/NEW9WfsInptLPkuBJ+B7l+9fvzDRsj+Jp3wgwqLZ
         ZqVPk+mx5HQyVIO2s80dOVt6bb9Ms3N9TF9sSppF1PHEvBNfHa8xptkVPZfhsTyfCObv
         HeOfH9Mgyw7O2JvzvwfS0Lk6MRtGVz985UzN04H2H3CkG/dEOgw3N26h78pQYubWz88w
         biKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAzoAxqZ8rX5wx9gb3Inxcm9vqxwh1Z0AUqpD3pLtoMN7yFLSeNcGV5kPd/vql/Ib5U9uByYv8bw3XaxA3edafZ2K+CN1A0xECr5S+S1c=
X-Gm-Message-State: AOJu0Yx7S8/bOLeLYEW/P+ovjbHTTcHYwoy+QezPYi/uaVBkZ+dV/pHp
	mSYuV32J7h8qmdFE4Okm8rVovJ7akQFVCnjG4JGNqMhzxi/CUSps88EKMFTZTRxp1fLfCdW6UUm
	R5noYnSS5qUdnq8uveCLAWowM9rOxAPLkI1L89TDgANn7Lf2gdplUS34=
X-Google-Smtp-Source: AGHT+IEs8z+X+07dgO7E18/9FA03B9oURp12kahDawJ3tMw3IPK4ANvdQyKYYgpMe3KhoPrxjuF6P004tsJ6KfQ1vL1r/dCnXjcS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:9f13:0:b0:488:9e3e:56af with SMTP id
 8926c6da1cb9f-4b03a7f0153mr219154173.1.1716675087366; Sat, 25 May 2024
 15:11:27 -0700 (PDT)
Date: Sat, 25 May 2024 15:11:27 -0700
In-Reply-To: <000000000000fdef8706191a3f7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c70ce206194e906b@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
From: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16624572980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f181c8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz-executor.2'.
------------[ cut here ]------------
no supported rates for sta 08:02:11:00:00:01 (0xf, band 0) in rate_mask 0xfff with flags 0x10
WARNING: CPU: 1 PID: 5269 at net/mac80211/rate.c:385 __rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Modules linked in:
CPU: 1 PID: 5269 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-12071-g66ad4829ddd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Code: 8b 14 24 0f 85 de 01 00 00 8b 0a 48 c7 c7 20 90 e1 8c 48 8b 74 24 10 44 89 f2 44 8b 44 24 1c 44 8b 4c 24 0c e8 b8 9e 60 f6 90 <0f> 0b 90 90 e9 71 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c db
RSP: 0018:ffffc9000334eb00 EFLAGS: 00010246
RAX: 50bad2e5ba5ebe00 RBX: ffff88807bf10f44 RCX: ffff88807c4e1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802cd2f2a8 R08: ffffffff815847a2 R09: fffffbfff1c3996c
R10: dffffc0000000000 R11: fffffbfff1c3996c R12: 0000000000000000
R13: 000000000000000c R14: 000000000000000f R15: dffffc0000000000
FS:  00007f8c6eddf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c6edddf78 CR3: 000000007ce9e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rate_control_send_low+0xf9/0x770 net/mac80211/rate.c:405
 rate_control_get_rate+0x20e/0x5e0 net/mac80211/rate.c:921
 ieee80211_tx_h_rate_ctrl+0xc88/0x1a10 net/mac80211/tx.c:763
 invoke_tx_handlers_late+0xb3/0x18e0 net/mac80211/tx.c:1848
 ieee80211_tx+0x2e3/0x470 net/mac80211/tx.c:1969
 __ieee80211_tx_skb_tid_band+0x4e2/0x610 net/mac80211/tx.c:6103
 ieee80211_tx_skb_tid+0x264/0x420 net/mac80211/tx.c:6131
 ieee80211_mgmt_tx+0x1b46/0x2170 net/mac80211/offchannel.c:989
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0x950/0x16a0 net/wireless/mlme.c:937
 nl80211_tx_mgmt+0xb0d/0x1190 net/wireless/nl80211.c:12651
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8c6e07cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c6eddf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8c6e1abf80 RCX: 00007f8c6e07cee9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f8c6e0c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8c6e1abf80 R15: 00007ffccd0b27a8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

