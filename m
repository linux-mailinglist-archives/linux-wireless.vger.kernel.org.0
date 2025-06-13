Return-Path: <linux-wireless+bounces-24083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC41AD7F9F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 02:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F22189816B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 00:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E911C3306;
	Fri, 13 Jun 2025 00:25:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5A72625
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749774332; cv=none; b=VddAPCbUQPgZj4gAea9gNueDgthHVDLgK+eZlWbaA2NPz8WrykZmxXKsYTRO+n4o2CoIQp7RzSwfJYprrJX2sZL6MYtrF/j7dkK8xpojx06xIzdFL3COaIW7RldJwcvUXxDMOCMy5vBglcS8gHFXW/LM4ExwDMbPTxrDeuuoUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749774332; c=relaxed/simple;
	bh=xsThK+4PTM6vOmc4EGSJBlxOZiaMMFRj6UYDcfWX3lo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T/We0M3v0BPKpvhskE3o5DaY4F/bc5c1TMovP/nh5fk9i0rsPWE7/Td3LqiDIPmhu96vPJ2SC6cDMgih9J0VFQeCp09m0dM6uRwuMeIleApq14J9hI47cENLyN3zO9H8eQtjOCILHtqi0fr6Pz0tb72ZZgoOZHZeGyrl5qzbf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso34229625ab.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 17:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749774329; x=1750379129;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxZDWbeKDMOeNnhzJHsIrLxC/GXCSgSYjiLc9SOv0iI=;
        b=NWIajEkLF1eXQbzFfz2kMol+egTnSMip6NrMIbFEd7xu6LT5NN1hMr7fwWhvvrjzuB
         z5funF63lgzoupEUURN+HC/rMzQlZrL3E32lG58cRtVUUvNcweyL8lRhiD3tSnJu5qg9
         RIgaKPTrgYO4ERDWs36EtnvK7K7CPiNMIbqdrfVXIiLPPOFEpX/2fGLoM+9iS9TA6O0j
         OSrDzKTXdHzAdi1gffV0I+JIRIgRdlkC8Joun9ui31opCM/c71gF/euxuyD+B1PWSt6k
         bouPZ6hQSYYte9SeQKyXYqYpYittTtkc4W+WVl8JrkmtBWOBXOhzrZ27RTyk5LYVLK2x
         N18w==
X-Forwarded-Encrypted: i=1; AJvYcCWtZWhptkwHOE+JchRhvZic+5aoIi6+gi1GOB2GOg2RiRtbmC3kD8dV2il9T4GSCLyfw9KThcozHgs9HFo5iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/sjoSLtt/KI2PZM98EwHbgk0nLXgVP1BAx3cachYrIR/OPuF
	xWh1o9cUkyg9U+EF851j2mI6CBripE6vE3O/KSbO+QTlwEkq22WBz2HiZcI9SAsFtghM3hzRHam
	1ob9vTvG1e58jSZanbWi+g+PUKueJec8FULVPySih5mP5KzjXvpubYGR++MQ=
X-Google-Smtp-Source: AGHT+IFLTsTAmseREeabop7ZE09K3oPwVpiYMvU6VBnLoMhEkyZFe1mt7WnFgUzuMJNrH36FoWYtACxEoi3gmTFNtnA3z3BRvPLe
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3de00b28732mr13106555ab.1.1749774329644; Thu, 12 Jun 2025
 17:25:29 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:25:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b6ff9.a00a0220.279073.0007.GAE@google.com>
Subject: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in cfg80211_inform_bss_frame_data
From: syzbot <syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9816ec74e6d macsec: MACsec SCI assignment for ES = 0
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f6e682580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=fd222bb38e916df26fa4
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1042460c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1442460c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/245bc00fbf73/disk-d9816ec7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0617f829e6a/vmlinux-d9816ec7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61f77a9d202e/bzImage-d9816ec7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3288:35
index 4 is out of range for type 'u8[0]' (aka 'unsigned char[0]')
CPU: 0 UID: 0 PID: 5880 Comm: syz-executor169 Not tainted 6.15.0-syzkaller-12438-gd9816ec74e6d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 cfg80211_inform_bss_frame_data+0x660/0x7b0 net/wireless/scan.c:3288
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x593/0xa20 net/mac80211/scan.c:355
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5179 [inline]
 ieee80211_rx_list+0x22fc/0x2d80 net/mac80211/rx.c:5416
 ieee80211_rx_napi+0x1a8/0x3d0 net/mac80211/rx.c:5439
 ieee80211_rx include/net/mac80211.h:5185 [inline]
 ieee80211_handle_queued_frames+0xe8/0x1f0 net/mac80211/main.c:441
 tasklet_action_common+0x36c/0x580 kernel/softirq.c:829
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 ieee80211_tx_skb_tid+0x266/0x420 net/mac80211/tx.c:6118
 ieee80211_mgmt_tx+0x1c25/0x21d0 net/mac80211/offchannel.c:1023
 rdev_mgmt_tx net/wireless/rdev-ops.h:762 [inline]
 cfg80211_mlme_mgmt_tx+0x7ef/0x1620 net/wireless/mlme.c:938
 nl80211_tx_mgmt+0x9fd/0xd50 net/wireless/nl80211.c:12918
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca6510a8e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd603df8e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fca6510a8e9
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000019549
R13: 00007ffd603df960 R14: 00007ffd603df91c R15: 00007ffd603df950
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

