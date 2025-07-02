Return-Path: <linux-wireless+bounces-24771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7EAF5D97
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687C47B4214
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C98E2E7BD5;
	Wed,  2 Jul 2025 15:41:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB2F2E7BB6
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470888; cv=none; b=ByS13kejfsbM+y7v0PSJ0uKwpmhSWtno6e9eiW31zKJtO6e6naV1H2iKt4vZpT7CL2HKdBKVOPkJHDMNBdBQ1c1TUGnBXehv8E+EFSwZKl6kNpNiaTnjax7qcayxTquzenzPjPMIdQPnwqGI/+FiE24Y8sHtxcXgE36+HYzAB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470888; c=relaxed/simple;
	bh=Px5bEQZgFgkVAb052BZxE6OW7H8bzp1MIWtOvyE4H7E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pq32JT3CAce/nx6Xa/2m9dpe+wea9U3P+VvdGTvkmd5C/iLdoBJCCTjKa+txPh4yoolmW0gBWU2IZAXZoBRhEHVimd+UFMaxKmKPRa0rIeTAMB+QXuPp/2jEsvfJ+kJJC5qz/jFIIlx4jmU37ryg/rNZmHAtWZuvAObnnd4woak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3de0dc57859so54013205ab.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 08:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470885; x=1752075685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72mVkO5MDdXMS2aL3VRSg/LH4qW3PHNHrah72R41C1k=;
        b=GdVAgMT7wb6vWUMo3qHzNwayNH9obbPoRu3nstRhG7Qp4TMX6h4UJ64m2RuSGTdCdB
         JKtG3SbvJ5ZtNTYzCfx4BxOge39bElTBqy3hWh1hNLC9OeBqo1Lhb9DhKdv3v36VwWlE
         1vqfATOtcK5NDdbdmZaw3d9zm3Y+RjNI1fv88WnEwy81VaT39RxRfOkEWtsE6Xe00ycX
         zh7ljmqVfP44jH5y+CcapaHpDci9Yu+W0Yf5AGeQv8Zh0p9upE7J4VsdVG/ResiyjK0T
         XAfOYOMRrnCwsIpwjXcJH4MzwRshd6zlIxxuT2JcutQ/SCIwX303vB8Bo0aO5EPqXXWu
         +5VA==
X-Forwarded-Encrypted: i=1; AJvYcCVwgb4mtgKOgj+7hGjRtsH+31JVlfvxTRLJtNFpsMxnF0jmR39d9M1L8dpnFdSIoZ1VbVIjiY8xfR/y/KphVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhn5SSMCbm3BsmZewub3cxE+5vSfzlNur19M3x9/zfc1X6faMi
	N2cXuoe7wSf4+sgWu0ocXmw+UdSCYABvErpFrCajTNBpQavgvJZGFH9BPzVfYeOcD/Il4dLyZRb
	9n7gxP0sGXIacw/7gKygWuruXcTDH3BgM2ogXF5TktHFnx20mXNQuWuSoWJY=
X-Google-Smtp-Source: AGHT+IF+pqsWuQGUtNEO3IE0O6RTRaigauRSmV59U9RJGfovuFBdDbl6DNypX0KfDoIzmyMf9hzwqQ8+Steyci39P1nQbmqn2GCd
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3193:b0:3e0:546c:bdc3 with SMTP id
 e9e14a558f8ab-3e05c31aec8mr127815ab.11.1751470885444; Wed, 02 Jul 2025
 08:41:25 -0700 (PDT)
Date: Wed, 02 Jul 2025 08:41:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68655325.a70a0220.5d25f.0316.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: invalid-free in nl80211_dump_station
From: syzbot <syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f240030794c Merge branch 'clean-up-usage-of-ffi-types'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10935770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3d09e57855d9399
dashboard link: https://syzkaller.appspot.com/bug?extid=4ba6272678aa468132c8
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d93d947f1b7/disk-8f240030.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6a98bb735e5/vmlinux-8f240030.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96712e0562b0/bzImage-8f240030.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in cfg80211_sinfo_release_content include/net/cfg80211.h:8614 [inline]
BUG: KASAN: double-free in nl80211_dump_station+0x690/0x7f0 net/wireless/nl80211.c:7505
Free of addr ffff88802fb00000 by task syz.1.594/8263

CPU: 1 UID: 0 PID: 8263 Comm: syz.1.594 Not tainted 6.16.0-rc3-syzkaller-00922-g8f240030794c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:596
 check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
 kasan_slab_pre_free include/linux/kasan.h:198 [inline]
 slab_free_hook mm/slub.c:2326 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x13f/0x440 mm/slub.c:4842
 cfg80211_sinfo_release_content include/net/cfg80211.h:8614 [inline]
 nl80211_dump_station+0x690/0x7f0 net/wireless/nl80211.c:7505
 genl_dumpit+0x10b/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x62d/0xe20 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2424
 genl_family_rcv_msg_dumpit+0x1e7/0x2c0 net/netlink/genetlink.c:1076
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x5da/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26b098e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26b181b038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f26b0bb6160 RCX: 00007f26b098e929
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000003
RBP: 00007f26b0a10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f26b0bb6160 R15: 00007fffd6219578
 </TASK>

Allocated by task 8263:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 cfg80211_sinfo_alloc_tid_stats+0x77/0x100 net/wireless/util.c:2667
 sta_set_sinfo+0x1d6a/0x6990 net/mac80211/sta_info.c:3138
 ieee80211_dump_station+0x111/0x1d0 net/mac80211/cfg.c:888
 rdev_dump_station net/wireless/rdev-ops.h:245 [inline]
 nl80211_dump_station+0x3a7/0x7f0 net/wireless/nl80211.c:7481
 genl_dumpit+0x10b/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x62d/0xe20 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2424
 genl_family_rcv_msg_dumpit+0x1e7/0x2c0 net/netlink/genetlink.c:1076
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x5da/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8263:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 cfg80211_sinfo_release_content include/net/cfg80211.h:8614 [inline]
 nl80211_send_station+0xb2c/0x3d00 net/wireless/nl80211.c:7250
 nl80211_dump_station+0x4bc/0x7f0 net/wireless/nl80211.c:7491
 genl_dumpit+0x10b/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x62d/0xe20 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2424
 genl_family_rcv_msg_dumpit+0x1e7/0x2c0 net/netlink/genetlink.c:1076
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x5da/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802fb00000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 2048-byte region [ffff88802fb00000, ffff88802fb00800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2fb00
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a442000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a442000 dead000000000100 dead000000000122
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000bec001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5187, tgid 5187 (klogd), ts 99757282377, free_ts 99694923865
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 syslog_print+0xd2/0x590 kernel/printk/printk.c:1607
 do_syslog+0x544/0x760 kernel/printk/printk.c:1785
 __do_sys_syslog kernel/printk/printk.c:1877 [inline]
 __se_sys_syslog kernel/printk/printk.c:1875 [inline]
 __x64_sys_syslog+0x7c/0x90 kernel/printk/printk.c:1875
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5198 tgid 5198 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3186
 put_cpu_partial+0x17c/0x250 mm/slub.c:3261
 __slab_free+0x2f7/0x400 mm/slub.c:4513
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2907 [inline]
 __do_sys_unlink fs/namei.c:4705 [inline]
 __se_sys_unlink fs/namei.c:4703 [inline]
 __x64_sys_unlink+0x3a/0x50 fs/namei.c:4703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802fafff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802fafff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802fb00000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802fb00080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fb00100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

