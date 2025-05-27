Return-Path: <linux-wireless+bounces-23444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95BDAC4F75
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB33189E7D0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9FA26A08C;
	Tue, 27 May 2025 13:16:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17025487B
	for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351801; cv=none; b=oGt7J6utKm3YlIKj8P37onv6tEGtF2prlXp5cLop8ziNr5HEiikqPV6hySRgmuLGsVhswvEdtfUUsCDs+xqD7P+Hiewb08J9KQc2wCu/ThKZy3897wu9qH/5qfemRVdBGLQNoboYhtQVMu2w/aJ05H4l8c5zXfVQ+Iy8UXigGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351801; c=relaxed/simple;
	bh=toUL8kVmIYUpj+yHbWybTCF9PrGAGvHavC8vMENX1Lc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c3c6SL86w2f3q4ntmqKunf3Eb/fClzYVFw5qI/2GASk8FaTd/8FRz6XyIKR7u/cb0VI1PRLv4dVLaIBIDGzxWMpsd6Mxo04uOPkw6/+T9nwee1WV8ChKqGJjaOgZ0g06U0XoKqNB9CO6QF40u7gXu7/NQ1EHoatL8L35SiAWeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b3b781313so639721639f.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 06:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748351799; x=1748956599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fs5dnMU+gfL+8rHwXU1x0X13W7OhQWWELJjNHVdrCg=;
        b=poskDHlt+doZeJeZtvcFilaSx6MKR227VAuJDaQvhs9GDtuXi+Zzwt9X04+9df+Mc2
         Z9slWdKwPglebxeVjuEQEWhKKT4lNSM44Y6RmgZmM6aOSCxgaP2fIn3vZmTkzeeQrtv/
         HHHOiYDeiwDqvPjmOOwgRtRMXDwIG978FSRLTcAB4WJz5hMSskMsI9VFUyQGp4xi5QKw
         LMwSqQwP4EZ0aE6vCkYDAY9pqcYKiQ4BzJyV7tSo1XCeZFoHN0GCXWUuu4XHgY+4k7Tp
         CCEBopTqsbI0tYbAQ8+LVL8AEjMhSPfMrva/wFk3V5+4sBoBPFJU48dSiI7rvYAaq7TB
         1n7A==
X-Forwarded-Encrypted: i=1; AJvYcCX57zxfX41rAYgl5DxolATWrqpbMN7HbF1YqgI2HPlGu9qIDhRy4Bf85DZkXwRSLaXQvtedXz1egBykYF2mRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7To7ul3dhNf2aoH4wZARlLOL6c+/2BnYFOH2nygb0XUYm5dxk
	d5IKpgWYxTiVgwoRxqVuB2LDumU7B+6rc9VZW1+8S0cZBr07NjvNUlEkKoP51Z3zDwFbjTRYTI1
	KLsci4+yD+5MRn2WY3Nap9nzyjVNgJuU3We7ByhE+HUMPAjLXhYOzEcoGxdI=
X-Google-Smtp-Source: AGHT+IHGRO3kfgMQ7ar84SSI3p4GXHmcWFk1okctqv4PnTzlS/IVJ68utuAAcATo9JvhtFOp2pFWI5TrCwJ/6xpePsNeqY2hvqL1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7211:b0:864:a1e9:f07 with SMTP id
 ca18e2360f4ac-86cbb80a7ecmr1620366539f.8.1748351799241; Tue, 27 May 2025
 06:16:39 -0700 (PDT)
Date: Tue, 27 May 2025 06:16:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6835bb37.a70a0220.253bc2.00b4.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_amsdu_to_8023s (2)
From: syzbot <syzbot+3d9e2c65bdd43a254924@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94305e83eccb Merge tag 'pmdomain-v6.15-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c9c170580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a423536a47898618
dashboard link: https://syzkaller.appspot.com/bug?extid=3d9e2c65bdd43a254924
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82a518437203/disk-94305e83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1b8b32ab132/vmlinux-94305e83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1743502cacb0/bzImage-94305e83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d9e2c65bdd43a254924@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_get_8023_tunnel_proto net/wireless/util.c:543 [inline]
BUG: KMSAN: uninit-value in ieee80211_amsdu_to_8023s+0x2226/0x2a40 net/wireless/util.c:897
 ieee80211_get_8023_tunnel_proto net/wireless/util.c:543 [inline]
 ieee80211_amsdu_to_8023s+0x2226/0x2a40 net/wireless/util.c:897
 __ieee80211_rx_h_amsdu+0x902/0x1400 net/mac80211/rx.c:3078
 ieee80211_rx_h_amsdu net/mac80211/rx.c:3164 [inline]
 ieee80211_rx_handlers+0x5b21/0x12440 net/mac80211/rx.c:4146
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4190 [inline]
 ieee80211_prepare_and_rx_handle+0x4c39/0x9ce0 net/mac80211/rx.c:5040
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5245 [inline]
 ieee80211_rx_list+0x5f20/0x6120 net/mac80211/rx.c:5416
 ieee80211_rx_napi+0x84/0x400 net/mac80211/rx.c:5439
 ieee80211_rx include/net/mac80211.h:5179 [inline]
 ieee80211_handle_queued_frames+0x14f/0x350 net/mac80211/main.c:441
 ieee80211_tasklet_handler+0x25/0x30 net/mac80211/main.c:460
 tasklet_action_common+0x362/0xd70 kernel/softirq.c:829
 tasklet_action+0x2d/0x40 kernel/softirq.c:855
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:579
 __do_softirq+0x14/0x1b kernel/softirq.c:613
 do_softirq+0x99/0x100 kernel/softirq.c:480
 __local_bh_enable_ip+0xa1/0xb0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
 __dev_queue_xmit+0x2e5d/0x5e20 net/core/dev.c:4656
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
 __netlink_deliver_tap+0x93b/0xdd0 net/netlink/af_netlink.c:325
 netlink_deliver_tap net/netlink/af_netlink.c:338 [inline]
 __netlink_sendskb net/netlink/af_netlink.c:1256 [inline]
 netlink_sendskb+0x224/0x270 net/netlink/af_netlink.c:1265
 netlink_unicast+0x746/0x1290 net/netlink/af_netlink.c:1354
 nlmsg_unicast include/net/netlink.h:1162 [inline]
 netlink_ack+0xacc/0xf80 net/netlink/af_netlink.c:2496
 netlink_rcv_skb+0x3f9/0x680 net/netlink/af_netlink.c:2540
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0xed8/0x1290 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 __sys_sendto+0x590/0x710 net/socket.c:2180
 __do_compat_sys_socketcall net/compat.c:-1 [inline]
 __se_compat_sys_socketcall net/compat.c:423 [inline]
 __ia32_compat_sys_socketcall+0xa89/0x1af0 net/compat.c:423
 ia32_sys_call+0x41be/0x42c0 arch/x86/include/generated/asm/syscalls_32.h:103
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4153 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4248
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:577
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:668
 __netdev_alloc_skb+0x124/0x6a0 net/core/skbuff.c:732
 netdev_alloc_skb include/linux/skbuff.h:3413 [inline]
 dev_alloc_skb include/linux/skbuff.h:3426 [inline]
 __ieee80211_amsdu_copy net/wireless/util.c:757 [inline]
 ieee80211_amsdu_to_8023s+0xcfa/0x2a40 net/wireless/util.c:885
 __ieee80211_rx_h_amsdu+0x902/0x1400 net/mac80211/rx.c:3078
 ieee80211_rx_h_amsdu net/mac80211/rx.c:3164 [inline]
 ieee80211_rx_handlers+0x5b21/0x12440 net/mac80211/rx.c:4146
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4190 [inline]
 ieee80211_prepare_and_rx_handle+0x4c39/0x9ce0 net/mac80211/rx.c:5040
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5245 [inline]
 ieee80211_rx_list+0x5f20/0x6120 net/mac80211/rx.c:5416
 ieee80211_rx_napi+0x84/0x400 net/mac80211/rx.c:5439
 ieee80211_rx include/net/mac80211.h:5179 [inline]
 ieee80211_handle_queued_frames+0x14f/0x350 net/mac80211/main.c:441
 ieee80211_tasklet_handler+0x25/0x30 net/mac80211/main.c:460
 tasklet_action_common+0x362/0xd70 kernel/softirq.c:829
 tasklet_action+0x2d/0x40 kernel/softirq.c:855
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:579
 __do_softirq+0x14/0x1b kernel/softirq.c:613

CPU: 1 UID: 0 PID: 20119 Comm: syz.6.1299 Tainted: G        W           6.15.0-rc7-syzkaller-00099-g94305e83eccb #0 PREEMPT(undef) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
=====================================================


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

