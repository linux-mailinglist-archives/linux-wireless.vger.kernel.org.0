Return-Path: <linux-wireless+bounces-29002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97618C61184
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 08:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429594E2F6F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B952641CA;
	Sun, 16 Nov 2025 07:50:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E921C3314
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763279431; cv=none; b=O9M6FQ/ZIZXmGsfkPRD+CjM/fhB95+AaiZ1qF8B9pL4V9D7i0bT2R9ksz1+ZXJ/+mZzKqt1uiVGB7DzV+rJuQy3r5T45ivRLGrk9xRVUAdp2bZK2DhZkhMVeGal1/enpnY4wYaA1b05Qip2u8iKsof8giENYV1U9oIUm2b8YzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763279431; c=relaxed/simple;
	bh=1ScHlRguvyLpssPcQoqoRtHj0dx8Rb7SW1QqzYtM17A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GeN9cugc5pip9e0wWs7zoRwTw2+nEtkdQOfx+BJsTNwdFwGOYq47Jt95Fe8NpCe/7K8l6X4cIBQ8SYhSSEnR/MMJQ2zSDRi6PmQe5wjBF7LJ5uucO1urUfJvkhvTZFwYW73gVGBeNj3BfQd/+tdYe/71LF0sPIZRO3P/Wjkv/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-433689014feso40421845ab.1
        for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 23:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763279428; x=1763884228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSE7tbnyT8yHLKZelbvCvqJRwe/XWgTAjkYpbvaaXvI=;
        b=uqlo7Fl5NV+UUXQGc3lfkWvX9dpPDgTLEhvkEWNSvyySKD68AiluL5f/vQsb1nJXO+
         /r2Pz7rXwx6Z2pRJxadqKDFbq5BJNP+/lNCc6liz9IihWiEancYVNW7u0c5ZZia4y2j2
         kdCa76Byc05DleRJi+xsem3P/DRa/lbUzK/8n4tNLbJ3yOR9NkxybAyKXOTJdFaplIIZ
         oaFomDNNaBYpyyZ++Hj29uh5WLZi+eScMk1j+HYT8GOa08mC/vKMlRPgKe7GkmvjR6i5
         gFHt3LCgSHolZ+TZ8SBcVlv+1mhRTJZpRx8niIfzOvAWEqBF/VwKfNiV02POcnL5z375
         Bppg==
X-Forwarded-Encrypted: i=1; AJvYcCVJQxYlto0JucnqchRfZIveN1x5La50BaO6X8We3vQUYmnw/Fg51vCGdD3Waq5NVt+VUEDIjL/i7BaNH2hARA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV77HC2lQQkDCwtB0TiCYddQ+YiWm0KU4h5DDFBGrWiFPHvlkq
	OApahBUOU3OhOcP/7mnX+mU1zrmuKT33GB0VW4CGt88ICB1GYjomnZz1igXvsAUHcBRchmRVqZM
	pDhQH1yF4mfnwcT8MSZ22nsLJwGPOmIVVAp4P/MeSWIi7HYsbu/Kyi+NZZAU=
X-Google-Smtp-Source: AGHT+IFVzDZwUP3HOsGuAQa5qm+yx1mBmZkTDB1dUcZSsHKog6LyGnrhiCQPYoSrI5AAoq722QKU46EUn4zIraH2L2JkKgeg2MD3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3388:b0:432:10f9:5e0a with SMTP id
 e9e14a558f8ab-4348c93b625mr104669375ab.19.1763279428565; Sat, 15 Nov 2025
 23:50:28 -0800 (PST)
Date: Sat, 15 Nov 2025 23:50:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69198244.a70a0220.3124cb.0074.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in ieee80211_add_virtual_monitor
From: syzbot <syzbot+bc1aabf52d0a31e91f96@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    04ca7a69a35b net: bnx2x: convert to use get_rx_ring_count
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1330a914580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4dda49799a90cd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=bc1aabf52d0a31e91f96
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe2c1ac0be7e/disk-04ca7a69.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6c6a173a173/vmlinux-04ca7a69.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a163d4feba0/bzImage-04ca7a69.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc1aabf52d0a31e91f96@syzkaller.appspotmail.com

tipc: Resetting bearer <eth:syzkaller0>
==================================================================
BUG: KASAN: slab-out-of-bounds in ieee80211_add_virtual_monitor+0xa52/0xd00 net/mac80211/iface.c:1255
Read of size 1 at addr ffff888047b63d50 by task syz.3.4250/20835

CPU: 0 UID: 0 PID: 20835 Comm: syz.3.4250 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ieee80211_add_virtual_monitor+0xa52/0xd00 net/mac80211/iface.c:1255
 ieee80211_do_stop+0x1786/0x1f60 net/mac80211/iface.c:746
 ieee80211_stop+0x1b1/0x240 net/mac80211/iface.c:828
 __dev_close_many+0x364/0x6f0 net/core/dev.c:1756
 netif_close_many+0x225/0x410 net/core/dev.c:1781
 netif_close+0x158/0x210 net/core/dev.c:1798
 dev_close+0x10a/0x220 net/core/dev_api.c:220
 cfg80211_shutdown_all_interfaces+0xd4/0x220 net/wireless/core.c:280
 cfg80211_rfkill_set_block+0x2d/0x50 net/wireless/core.c:310
 rfkill_set_block+0x1d2/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x44b/0x570 net/rfkill/core.c:1301
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbbceb8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbbcfa30038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbbcede5fa0 RCX: 00007fbbceb8f6c9
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000008
RBP: 00007fbbcec11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbbcede6038 R14: 00007fbbcede5fa0 R15: 00007ffd05a68698
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888047b63a80 pfn:0x47b60
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f8(unknown)
raw: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
raw: ffff888047b63a80 0000000000000000 00000000f8000000 0000000000000000
head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
head: ffff888047b63a80 0000000000000000 00000000f8000000 0000000000000000
head: 00fff00000000002 ffffea00011ed801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 12532, tgid 12532 (syz-executor), ts 337218700996, free_ts 297447370395
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:5591
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5622
 __do_kmalloc_node mm/slub.c:5638 [inline]
 __kvmalloc_node_noprof+0x6e/0x910 mm/slub.c:7108
 alloc_netdev_mqs+0xa6/0x11b0 net/core/dev.c:11989
 ieee80211_if_add+0x46c/0x1390 net/mac80211/iface.c:2227
 ieee80211_register_hw+0x35a5/0x40d0 net/mac80211/main.c:1607
 mac80211_hwsim_new_radio+0x2f9a/0x5260 drivers/net/wireless/virtual/mac80211_hwsim.c:5810
 hwsim_new_radio_nl+0xf5b/0x1bd0 drivers/net/wireless/virtual/mac80211_hwsim.c:6504
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
page last free pid 5833 tgid 5833 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 discard_slab mm/slub.c:3330 [inline]
 __put_partials+0x146/0x170 mm/slub.c:3876
 put_cpu_partial+0x1f2/0x2e0 mm/slub.c:3951
 __slab_free+0x2b9/0x390 mm/slub.c:5929
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 __do_kmalloc_node mm/slub.c:5649 [inline]
 __kvmalloc_node_noprof+0x577/0x910 mm/slub.c:7108
 xt_jumpstack_alloc net/netfilter/x_tables.c:1356 [inline]
 xt_replace_table+0x18a/0x790 net/netfilter/x_tables.c:1395
 __do_replace+0x163/0xaa0 net/ipv4/netfilter/arp_tables.c:912
 do_replace net/ipv4/netfilter/arp_tables.c:989 [inline]
 do_arpt_set_ctl+0xa2a/0xf10 net/ipv4/netfilter/arp_tables.c:1429
 nf_setsockopt+0x26f/0x290 net/netfilter/nf_sockopt.c:101
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
 __sys_setsockopt net/socket.c:2385 [inline]
 __do_sys_setsockopt net/socket.c:2391 [inline]
 __se_sys_setsockopt net/socket.c:2388 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888047b63c00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff888047b63c80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff888047b63d00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                                 ^
 ffff888047b63d80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff888047b63e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
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

