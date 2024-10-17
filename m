Return-Path: <linux-wireless+bounces-14177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F79A2E72
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BEEB21ED2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FC227366;
	Thu, 17 Oct 2024 20:23:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6484202629
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196622; cv=none; b=TdvGTbMwPInH1nr63z9/xrPRL6Ev2arT++WNuUZgWo24qUfFcynrKgHLk72Uuh8Ge3t8Atk9VXqPeyMw67MjDSrrejBqi5ySav1QcA0NRky/AAkYyyy5dvj12xTjBgGQosaKjD4NeF7HxkD81/JZ6HukXPkTe34iLbVsHxgFS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196622; c=relaxed/simple;
	bh=bo8l9jK+K6SXdujD2QzQ2NmX/YLcQyCI+tR2gj2FHIc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mBn1LqWRh30cjaI7h4sZ60vxFtoT+NSR8yiBt4wAM5jUMp9d0BCdItFtWKXce2Cfw0XnSXjM+zXJsyO9xwN+vTJ5XJRUXtL2RhS40xDCPsCQbFqeI02BzlOFiKdydoFL4Jrbj1uEyVb/5gs34X86dn2tTT0xBMySX8CynpTXvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae775193so16182625ab.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 13:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196617; x=1729801417;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkmIBheTvejxuymwXP9T0lCMzGXKi43b+vMHN+w3DcQ=;
        b=R8eFfmytVu/WIESoQ5mSfLIzZDLgI7EMUR1AenYhf8ocD4ifQrVocJKkrdOl+GDmny
         ZoYxRyG2tAWXo/ZRnlgGmX2B0YD+Bd9MjQWkSGYz6nGvVpTXz+lv8tcCEvaOP3gQW8dw
         E5osMGetv/nHFP4vngSX9+kOhZTNTh1SKwW+Tq7A+Y0d47df+2vyGCS6yvC5PJuO/pTw
         O7kTJor5k/qFdYMKxSGhR7QX1VGiWIbH4qL4cUz+cNmX1974v0HMfHM9oH7jP7oGsRsM
         /iIQvHBuiJVCBllgCl+ud4q3owLJ0BgY06gqF0iFVGaWdPOy8+ebVy6DzHs42Ef3ic1m
         miIg==
X-Forwarded-Encrypted: i=1; AJvYcCW23YKvgXmL6GTe+XCITT7gptRLKzmX/XP8FoVZmKpuDt2bWkd3Ya1ywoakvHeuqg/ooVgAQq85Y5j17D4uGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbHUe2ild2wjiBbG/0bquNfNWnd8EuwKIjCzWlVBc3lDjE4Hu
	IgCvfKTnhdq/JohJBzQoAyb5lPPfzrKEjkoKFTDlfqB6uSuWfrqHca3IfqIY7G6WdH9VtOVUeBZ
	k6npJrSG7pNIMDxPBrHG26CyIacAtPGyjYam/AwDH+NmYGMzAtIt/hAA=
X-Google-Smtp-Source: AGHT+IHBO8Iem+HVTBGX8UopCRd61J5CA8NZRybZ5cUmxoJhdC326po+WOwNsq5hxdd7xmyd1z/ciNiUbN/swxjs2nNE206SXbiQ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a3f4073bcdmr643415ab.14.1729196616853; Thu, 17 Oct 2024
 13:23:36 -0700 (PDT)
Date: Thu, 17 Oct 2024 13:23:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67117248.050a0220.10f4f4.0001.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-use-after-free Write in kvfree_call_rcu
From: syzbot <syzbot+36218cddfd84b5cc263e@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1427e440580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
dashboard link: https://syzkaller.appspot.com/bug?extid=36218cddfd84b5cc263e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-36c25451.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a357f9d2448/vmlinux-36c25451.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fba8311d450b/bzImage-36c25451.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36218cddfd84b5cc263e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in kvfree_call_rcu+0xb99/0xbe0 kernel/rcu/tree.c:3819
Write of size 8 at addr ffff888062198808 by task kworker/u32:11/1199

CPU: 1 UID: 0 PID: 1199 Comm: kworker/u32:11 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 kvfree_call_rcu+0xb99/0xbe0 kernel/rcu/tree.c:3819
 _cfg80211_unregister_wdev+0x38c/0x7f0 net/wireless/core.c:1238
 ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2300
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1669
 mac80211_hwsim_del_radio+0x268/0x370 drivers/net/wireless/virtual/mac80211_hwsim.c:5625
 hwsim_exit_net+0x33f/0x6d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xb40 net/core/net_namespace.c:626
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5898:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x410 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 nl80211_set_cqm_rssi net/wireless/nl80211.c:13107 [inline]
 nl80211_set_cqm+0xa19/0x1780 net/wireless/nl80211.c:13174
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 112:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 kvfree+0x47/0x50 mm/util.c:701
 kvfree_rcu_list+0xf5/0x2c0 kernel/rcu/tree.c:3423
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3563 [inline]
 kfree_rcu_monitor+0x503/0x8b0 kernel/rcu/tree.c:3632
 kfree_rcu_shrink_scan+0x245/0x3a0 kernel/rcu/tree.c:3966
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab+0x32b/0x12a0 mm/shrinker.c:662
 shrink_one+0x47e/0x7b0 mm/vmscan.c:4818
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x2452/0x39d0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat+0xc19/0x18f0 mm/vmscan.c:6957
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7226
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
 _cfg80211_unregister_wdev+0x38c/0x7f0 net/wireless/core.c:1238
 ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2300
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1669
 mac80211_hwsim_del_radio+0x268/0x370 drivers/net/wireless/virtual/mac80211_hwsim.c:5625
 hwsim_exit_net+0x33f/0x6d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xb40 net/core/net_namespace.c:626
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
 _cfg80211_unregister_wdev+0x38c/0x7f0 net/wireless/core.c:1238
 cfg80211_netdev_notifier_call+0xa5c/0x1160 net/wireless/core.c:1494
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 __dev_change_net_namespace+0x44f/0x12a0 net/core/dev.c:11583
 dev_change_net_namespace include/linux/netdevice.h:3932 [inline]
 cfg80211_switch_netns+0x11e/0x690 net/wireless/core.c:169
 nl80211_wiphy_netns+0x134/0x2b0 net/wireless/nl80211.c:12364
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888062198800
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 8 bytes inside of
 freed 64-byte region [ffff888062198800, ffff888062198840)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x62198
anon flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac428c0 ffffea00017aef40 dead000000000005
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5424, tgid 5424 (syz-executor), ts 49927932309, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x379/0x410 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kmalloc_array_noprof include/linux/slab.h:923 [inline]
 security_inode_init_security+0x140/0x390 security/security.c:1825
 shmem_symlink+0x138/0x6a0 mm/shmem.c:3814
 vfs_symlink fs/namei.c:4615 [inline]
 vfs_symlink+0x3e8/0x660 fs/namei.c:4599
 do_symlinkat+0x263/0x310 fs/namei.c:4641
 __do_sys_symlinkat fs/namei.c:4657 [inline]
 __se_sys_symlinkat fs/namei.c:4654 [inline]
 __ia32_sys_symlinkat+0x93/0xc0 fs/namei.c:4654
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888062198700: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888062198780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888062198800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff888062198880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888062198900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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

