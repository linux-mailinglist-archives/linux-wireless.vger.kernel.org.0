Return-Path: <linux-wireless+bounces-29553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44055CAA34E
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 10:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6211D30D8115
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C162DF707;
	Sat,  6 Dec 2025 09:12:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD923E25B
	for <linux-wireless@vger.kernel.org>; Sat,  6 Dec 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765012345; cv=none; b=ag1TccNhUMvweJCg5NN7foYR03B2HO0x7Q1Q+eQlas5GO8ey+GEmBvzCcjmBARtxYJ7ZVqkKLAuuy9AzvUx780q4DcpZT9LNVrUMBQN6vyZYJWlQ92Fma84bm0uMQY76vFpBp7N2INIyg42PB5/0GlFFrIQzAH1PnkmO+G9tTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765012345; c=relaxed/simple;
	bh=1ejLsKcsfZGQzZwlR1bIL/zMBH9XWVg8VfOImLm9acA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LseSdyI8jBxK+1EcDBhTkHDoVrE+GtV9WC1BKx+AQZBdItXXP/KWR4EvEFp9IYimATjrYM16gCN3TBwEdZeuYG9PFdoNNLEvaKHfbDFadOQyfZX+UmPiftWVt1LF5zx0Q4rVseT140cqIeWRGInd0wpjyzARwmrgcox7pZRIcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c79200d1a4so6764955a34.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Dec 2025 01:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765012342; x=1765617142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/LVS9k18L2FkXaCDOM0Zk2vdrA1YNdhVcdFbxui8ZI=;
        b=FZEX+kd9zjIyWRUSbjHd9bmejY4GYxp4wqnIEKcoARn6luNV0d1jqbWGx2vgjsaWsp
         43uiH3AemgEG7kCYxTArqVY6cCAoP+RJIKABE3EBy7kCXDahmdXa1wp8shBwZL8S0WOs
         0UvdJpmMXtx0QBaKgYMwYpegJ9wsYX91T2rgwJlaljrh4edZV0X4x58cOIzj5cG+ayma
         vYEDV7LTJ1ujx+KKgf/d3MVlxxi7ktL+dQ44NnCTgy4KMew9Unx3sDQbqB9QNnxsoelf
         CJ/5pnWfcj6KbXHCrdIdgZXl4xWZrYuEGHNJgOg8ygtrosZiH4r8roSNMnDcN6HPfBgk
         O90A==
X-Forwarded-Encrypted: i=1; AJvYcCWkVYP7QQrdh0uDPdFzmhTu+PyS1wkXcEtBXRaiihN1hOZjCI8uhKg1ZkGccUS25n5Q/W/LJ11OkOJBDqPoXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcaxDi2CHCceHR41cYkV5RMmU+9LyO/UKgfKgSqF+Qu5nqytw
	p4IGmCOXbAv1OFyGkEOuOXpdVz0gzoZMCxrlBD/iyxHOx8XkWa1o/jY+nktRdcBUnFM5//JHS21
	b2btUTFcf0+I92fkejihhpmQw1faHH5/ywqWvEncO3n+eGtrVTduWuTd745w=
X-Google-Smtp-Source: AGHT+IGdTTHnpabMUiM/Z6j0+k/XLLraXh9jAlM31yL7Tm+d00HG7ufxAtm9NiZhF6c9RHseDFpI7AeTg4VtrdZEKTBx5QwD6T0Q
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:471a:b0:659:9a49:8e19 with SMTP id
 006d021491bc7-6599a499c33mr771475eaf.11.1765012342157; Sat, 06 Dec 2025
 01:12:22 -0800 (PST)
Date: Sat, 06 Dec 2025 01:12:22 -0800
In-Reply-To: <68a246ad.050a0220.e29e5.0077.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6933f376.a70a0220.38f243.001d.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tx_skb_tid
From: syzbot <syzbot+8bd4574e8c52c48c2595@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d1d36025a617 Merge tag 'probes-v6.19' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b44992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eaa3e2adda258a7
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd4574e8c52c48c2595
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ad46c2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d0bc1a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d1d36025.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8198d2c1f670/vmlinux-d1d36025.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51df1359897b/bzImage-d1d36025.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bd4574e8c52c48c2595@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/mac80211/tx.c:6303 at ieee80211_tx_skb_tid+0x3b4/0x470 net/mac80211/tx.c:6303, CPU#0: syz.0.18/5530
Modules linked in:
CPU: 0 UID: 0 PID: 5530 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_tx_skb_tid+0x3b4/0x470 net/mac80211/tx.c:6303
Code: f6 ce f6 e9 b1 fe ff ff e8 b9 da f1 f6 90 0f 0b 90 e9 e2 fe ff ff e8 ab da f1 f6 90 0f 0b 90 e9 2a fe ff ff e8 9d da f1 f6 90 <0f> 0b 90 e8 c4 e1 fd ff 31 ff 48 8b 34 24 ba 02 00 00 00 48 83 c4
RSP: 0018:ffffc90002a7f458 EFLAGS: 00010293
RAX: ffffffff8acf8083 RBX: ffffffff8acf7cff RCX: ffff888000f54980
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff8acf7cff R09: ffffffff8df41cc0
R10: dffffc0000000000 R11: ffffed10092eb486 R12: ffff88801c1b8d80
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  00005555853f1500(0000) GS:ffff88808d683000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564770e69950 CR3: 0000000032ccf000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_tx_skb net/mac80211/ieee80211_i.h:2418 [inline]
 mesh_plink_frame_tx+0x734/0xc10 net/mac80211/mesh_plink.c:354
 mesh_plink_deactivate+0x18e/0x2f0 net/mac80211/mesh_plink.c:410
 mesh_sta_cleanup+0x42/0x150 net/mac80211/mesh.c:171
 __cleanup_single_sta net/mac80211/sta_info.c:167 [inline]
 cleanup_single_sta+0x40f/0x660 net/mac80211/sta_info.c:192
 __sta_info_flush+0x5e4/0x710 net/mac80211/sta_info.c:1683
 sta_info_flush net/mac80211/sta_info.h:970 [inline]
 ieee80211_do_stop+0x397/0x1f70 net/mac80211/iface.c:526
 ieee80211_stop+0x1b1/0x240 net/mac80211/iface.c:828
 __dev_close_many+0x344/0x6b0 net/core/dev.c:1756
 __dev_close net/core/dev.c:1768 [inline]
 __dev_change_flags+0x2be/0x680 net/core/dev.c:9732
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9797
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 dev_ioctl+0x7b4/0x1150 net/core/dev_ioctl.c:842
 sock_do_ioctl+0x22c/0x300 net/socket.c:1259
 sock_ioctl+0x576/0x790 net/socket.c:1366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba6778f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8aa47b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fba679e5fa0 RCX: 00007fba6778f7c9
RDX: 0000200000000000 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 00007fba67813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fba679e5fa0 R14: 00007fba679e5fa0 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

