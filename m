Return-Path: <linux-wireless+bounces-29419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535AC92667
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 16:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9463A3A1A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B84329C7F;
	Fri, 28 Nov 2025 15:04:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC533074AC
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342275; cv=none; b=gDN+F8GgCyI7Q8q284NwyYpnitz4wJNehR2Agtch7suCpEZgiZad6NcjMzqZiyv95YHNhPbY+nmke1HyW1kA9K1BUOVgpenSdJIpnYcD5OHukU34wA24PqAyJNQ8QB+qqoJ8w1L/BUet6F/rCQnLaTDedq+3eU56J+MBPvx3Qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342275; c=relaxed/simple;
	bh=OLObPakDDTVI8UTS0eZajCJnsEm2Cr2Ffa0+0Sz2GNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CRv5AwxxhDSE5DGfPty1yGcZWUhsQ55wZ6vAJl4i9Hc+MDUGvWf7fRChLte7jZh0/mZXRXKEZ228ymS6J417Fgy/SUwYVsf5Us1uOY9diLX70y04lC74aDWM9Rl7bMzexv5aeR5AZeHaJTgY+4OdF9jl4xgykPcr1q4Mx+olg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43376637642so14048575ab.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 07:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764342273; x=1764947073;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMAlQjYN2X3VZjLm5if0vBNtB+6RCQ8SvO2T6L9TZj0=;
        b=sX+X5HIxYDSS5l9M/JSoxtnrDvHiZkadSBwt6zNpltqpGx4kGZSB0v3b8+rptjBG9W
         xkfH4/FfM5KvT1ogZ3hoN2qbHKxf4nVWIsIGl2thc60FVPjx4gvUz4DgmV8KPWYp+F4J
         9RHubqQ3auoLaztn9tzmCWtN3YpgYBHqJo0IkWcFvj2mkzAgXsUSfEL051daKP3R5LB7
         jrze9K7DyqOiI5TckWFJ/q7FeO/e7t1t+WYeKO6nLo8eJNCEq50VGNEtCHQbL+lEIAhG
         DgMdcyLIOZkMU8hKPWBVlG/QmxV8BQSxPFTXYOTZBR8fww3wlABKKjZEd+td+LxPWyId
         nTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnSlCKt+/VmaqCHcXh/l4RmI0/4fV/GskGEWQdYdffHSIYmFNk2Kr+sgenlzOWmFDa76H0yokjEW4k9f8q1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPn/3nkG6mcqhWgbBMdiFt9tcIqj/BVdkAqySkNX9WA3XJxFNZ
	DBxqRUQq+T4gOn2wW8wMvwFBLYOsCu6HRlbHjOcTzUJO8bRtA6eGyaI9JP1PLaHKa6weFcl8bA7
	vlyuhBaSWoBSdzQpq4A/shqGmNvOslMg1NUc/jxkcOeApkzrXbNpAGK0nM40=
X-Google-Smtp-Source: AGHT+IH3WCB3Chj8ZTnaCjGo9mAKra91R/lNSu6AvlsYLHXvMWBMaKBhN51UzzJSa8cU6TPD9IzOt1x6HjDhrdzmW6vNlGVdtg1k
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:433:305c:179d with SMTP id
 e9e14a558f8ab-435b98d6d62mr259941225ab.28.1764342272846; Fri, 28 Nov 2025
 07:04:32 -0800 (PST)
Date: Fri, 28 Nov 2025 07:04:32 -0800
In-Reply-To: <69198244.a70a0220.3124cb.0074.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6929ba00.a70a0220.d98e3.0142.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in ieee80211_add_virtual_monitor
From: syzbot <syzbot+bc1aabf52d0a31e91f96@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1448fe12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec890b8333fce099
dashboard link: https://syzkaller.appspot.com/bug?extid=bc1aabf52d0a31e91f96
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102b9f42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142e3e92580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bcc6eb60940/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/895bc1bfae48/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48f15e4679f3/bzImage-7d31f578.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc1aabf52d0a31e91f96@syzkaller.appspotmail.com

mac80211_hwsim hwsim5 syzkaller0: entered promiscuous mode
mac80211_hwsim hwsim5 syzkaller0: entered allmulticast mode
==================================================================
BUG: KASAN: slab-out-of-bounds in ieee80211_add_virtual_monitor+0xa42/0xce0 net/mac80211/iface.c:1255
Read of size 1 at addr ffff8880753b7d90 by task syz.0.17/6029

CPU: 0 UID: 0 PID: 6029 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ieee80211_add_virtual_monitor+0xa42/0xce0 net/mac80211/iface.c:1255
 ieee80211_do_stop+0x1786/0x1f70 net/mac80211/iface.c:746
 ieee80211_stop+0x1b1/0x240 net/mac80211/iface.c:828
 __dev_close_many+0x344/0x6b0 net/core/dev.c:1756
 __dev_close net/core/dev.c:1768 [inline]
 __dev_change_flags+0x2be/0x680 net/core/dev.c:9733
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9798
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 dev_ioctl+0x7b4/0x1150 net/core/dev_ioctl.c:842
 sock_do_ioctl+0x22c/0x300 net/socket.c:1274
 sock_ioctl+0x576/0x790 net/socket.c:1381
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5875f8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc52c16018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f58761e5fa0 RCX: 00007f5875f8f749
RDX: 0000200000000000 RSI: 0000000000008914 RDI: 0000000000000006
RBP: 00007f5876013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f58761e5fa0 R14: 00007f58761e5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880753b5d40 pfn:0x753b4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888026064282
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f8(unknown)
raw: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
raw: ffff8880753b5d40 0000000000000000 00000000f8000000 ffff888026064282
head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
head: ffff8880753b5d40 0000000000000000 00000000f8000000 ffff888026064282
head: 00fff00000000002 ffffea0001d4ed01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 6029, tgid 6029 (syz.0.17), ts 111996806551, free_ts 111081173010
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 ___kmalloc_large_node+0x4e/0x150 mm/slub.c:5593
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5624
 __do_kmalloc_node mm/slub.c:5640 [inline]
 __kvmalloc_node_noprof+0x6e/0x920 mm/slub.c:7129
 alloc_netdev_mqs+0xa8/0x1200 net/core/dev.c:12011
 ieee80211_if_add+0x45c/0x1370 net/mac80211/iface.c:2227
 ieee80211_add_iface+0xb5/0x5a0 net/mac80211/cfg.c:217
 rdev_add_virtual_intf net/wireless/rdev-ops.h:50 [inline]
 _nl80211_new_interface net/wireless/nl80211.c:4706 [inline]
 nl80211_new_interface+0x883/0x1130 net/wireless/nl80211.c:4764
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
page last free pid 6006 tgid 6006 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 __slab_free+0x21b/0x2a0 mm/slub.c:5999
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4948 [inline]
 slab_alloc_node mm/slub.c:5258 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5265
 vm_area_dup+0x2b/0x680 mm/vma_init.c:123
 __split_vma+0x1a9/0xa00 mm/vma.c:508
 split_vma mm/vma.c:591 [inline]
 vma_modify+0x952/0x1a70 mm/vma.c:1634
 vma_modify_flags+0x208/0x2e0 mm/vma.c:1654
 mprotect_fixup+0x43c/0xa30 mm/mprotect.c:756
 do_mprotect_pkey+0x8c5/0xcd0 mm/mprotect.c:930
 __do_sys_mprotect mm/mprotect.c:951 [inline]
 __se_sys_mprotect mm/mprotect.c:948 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:948
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880753b7c80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff8880753b7d00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff8880753b7d80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                         ^
 ffff8880753b7e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff8880753b7e80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

