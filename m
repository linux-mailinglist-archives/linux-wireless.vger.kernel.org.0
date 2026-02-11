Return-Path: <linux-wireless+bounces-31736-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHtfLLZtjGlmngAAu9opvQ
	(envelope-from <linux-wireless+bounces-31736-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 12:53:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE08123FCC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 112CB3005995
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74F314D36;
	Wed, 11 Feb 2026 11:53:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162631354F
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810801; cv=none; b=S+fA+k6W+4uik/tfcWg2kzQSnPeLLJO61Qg4Bvog2RI1jRjVD2xHA2WjfYicQoKNWNH4VCL7pPcoJtG50HbJiWclZgRS57pPvP6PHr846My+xTxkpb05ShmRYJXn9KLNd+rABxVjzvGYVpBkG4uPGBPmD6k+N+tFSN1vloFPWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810801; c=relaxed/simple;
	bh=tMNsr1dpJkNpTIFJfoGaV6091yw716H1iXF4v1SVXHc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FalKCv59z51w7zxtENqNEakPxwDuEBvQHON9XwQLjseRqXXHid6ygU4xSJxTKN+FFuFfB7XyKIJqa5rWb2epY1casnSLF9MJQ88rU4VTQhH4zd4GiYOvRLW03eYZ7L1SRH56k6PEtGyOO7A2gGBQcG6jZxIdLVhEOj5lGkFytFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7cfd107ef0eso37529714a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 03:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770810799; x=1771415599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crPJ7u27eyTZrNH+CpyScad4mngQ7dr0a0kUGrBeEeY=;
        b=rXYE6p3rp9unqK+3oFcDruy8Eyn5dK9Vpz6erWlYeFOVYiMhUUMTK1uNkJy2DIZvn+
         SbsCtA5KJDEHUj9oQ4D508H2/NnwaWALsBHfILdlfMkX3ZZiVltfdIL0g3HJj34bawgS
         gcL6djYhek5KQauCrhCn74Tnc3jm2msxwux95uM/HO2gwxAiTL+wZ9Pf7SmueMIdUL6M
         JAk1kVPi0RZnxfXnmt11MDZEhe4l6H3xVOqiXTC7L/WQTJJV5TcjjsrdCkwFmntrYDze
         UrD7Ok/yaGcEwxszIpqJc2IB4lrqTHJothCuzJhvpKUcO/pVAJvbmV3ZVEHxcuooK9jv
         9W9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSb9l1l+UC1wWnneE4p/yCgjHSa95I2bI/rzv/SJGg2S1WEolngPcAfabIJFhfr3gWQSB0lX30yoAj/AC/Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhTYoCGpwSB83UJIjh8uxfGbDiud92VQ0XjUtasdxEJsteyUE
	4I5Wfwltzf7qt7CvUy70q1TzEcdoQChyfJt8kmrsHfVoSkBlTACWEBMowrK4w71SY+ksQZ1zpUr
	9h7RpE1dL8fPwLfedARwpndQZTI8RJQvMJKqRGSISrRwwo/B8vt3fjv8h4T8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80c9:b0:664:85db:66bd with SMTP id
 006d021491bc7-6747ee9a813mr764755eaf.7.1770810799497; Wed, 11 Feb 2026
 03:53:19 -0800 (PST)
Date: Wed, 11 Feb 2026 03:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698c6daf.050a0220.2eeac1.0098.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in
 ieee80211_ie_split_ric (2)
From: syzbot <syzbot+1d7461ceeccc7e92d309@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31736-lists,linux-wireless=lfdr.de,1d7461ceeccc7e92d309];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 3EE08123FCC
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    5d41f95f5d0b dpll: zl3073x: Fix output pin phase adjustmen..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16b43d3a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=1d7461ceeccc7e92d309
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/182b4bb52a10/disk-5d41f95f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a86438e761e/vmlinux-5d41f95f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29465cf28ab1/bzImage-5d41f95f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d7461ceeccc7e92d309@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in skip_ie net/wireless/util.c:1967 [inline]
BUG: KASAN: slab-out-of-bounds in ieee80211_ie_split_ric+0x8fa/0x950 net/wireless/util.c:-1
Read of size 1 at addr ffff88802946afa1 by task syz.3.11380/15499

CPU: 0 UID: 0 PID: 15499 Comm: syz.3.11380 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 skip_ie net/wireless/util.c:1967 [inline]
 ieee80211_ie_split_ric+0x8fa/0x950 net/wireless/util.c:-1
 ieee80211_ie_split include/net/cfg80211.h:9693 [inline]
 cfg80211_sme_get_conn_ies net/wireless/sme.c:529 [inline]
 cfg80211_sme_connect net/wireless/sme.c:586 [inline]
 cfg80211_connect+0x11f8/0x2140 net/wireless/sme.c:1527
 cfg80211_mgd_wext_connect+0x4a0/0x5f0 net/wireless/wext-sme.c:57
 cfg80211_wext_siwessid+0xc4/0x160 net/wireless/wext-compat.c:1412
 ioctl_standard_iw_point+0x6cd/0xd90 net/wireless/wext-core.c:865
 ioctl_standard_call+0xaf/0x1b0 net/wireless/wext-core.c:1050
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xee/0x410 net/wireless/wext-core.c:1014
 wext_handle_ioctl+0x10f/0x1d0 net/wireless/wext-core.c:1075
 sock_ioctl+0x159/0x7f0 net/socket.c:1307
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2c219aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2c307b028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa2c2415fa0 RCX: 00007fa2c219aeb9
RDX: 0000200000000040 RSI: 0000000000008b1a RDI: 0000000000000005
RBP: 00007fa2c2208c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa2c2416038 R14: 00007fa2c2415fa0 R15: 00007ffd00308408
 </TASK>

Allocated by task 5139:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_node_track_caller_noprof+0x558/0x7f0 mm/slub.c:5768
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:765 [inline]
 cfg80211_wext_siwgenie+0x1ad/0x320 net/wireless/wext-sme.c:322
 ioctl_standard_iw_point+0x6cd/0xd90 net/wireless/wext-core.c:865
 ioctl_standard_call+0xaf/0x1b0 net/wireless/wext-core.c:1050
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xee/0x410 net/wireless/wext-core.c:1014
 wext_handle_ioctl+0x10f/0x1d0 net/wireless/wext-core.c:1075
 sock_ioctl+0x159/0x7f0 net/socket.c:1307
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802946afa0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff88802946afa0, ffff88802946afa1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802946a1c0 pfn:0x2946a
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88813fe26500 ffffea00015f0210 ffffea0002018250
raw: ffff88802946a1c0 0000000000800079 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4276, tgid 4272 (syz.2.8413), ts 893909570156, free_ts 893627728021
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3a0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xd82/0x1760 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_node_track_caller_noprof+0x5b7/0x7f0 mm/slub.c:5768
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 __kernfs_new_node+0xa9/0x8e0 fs/kernfs/dir.c:633
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 __kernfs_create_file+0x4b/0x2e0 fs/kernfs/file.c:1057
 sysfs_add_file_mode_ns+0x238/0x300 fs/sysfs/file.c:313
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x673/0x1180 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:229 [inline]
 sysfs_create_groups+0x59/0x120 fs/sysfs/group.c:255
 setup_port drivers/infiniband/core/sysfs.c:1247 [inline]
 ib_setup_port_attrs+0xe1b/0x2140 drivers/infiniband/core/sysfs.c:1433
page last free pid 23 tgid 23 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xbf8/0xd70 mm/page_alloc.c:2973
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff88802946ae80: fa fc fc fc 04 fc fc fc 04 fc fc fc fa fc fc fc
 ffff88802946af00: 04 fc fc fc 04 fc fc fc 04 fc fc fc 04 fc fc fc
>ffff88802946af80: 04 fc fc fc 01 fc fc fc 04 fc fc fc 04 fc fc fc
                               ^
 ffff88802946b000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88802946b080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

