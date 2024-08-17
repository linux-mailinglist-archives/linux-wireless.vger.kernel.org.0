Return-Path: <linux-wireless+bounces-11583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E495595A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2024 21:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DF72829BC
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBC715539A;
	Sat, 17 Aug 2024 19:12:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C12770E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Aug 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723921941; cv=none; b=RwdpQqncuptNDEc8RmnumiLLIjlga9bbX+k9xn0HTr6/Ha8tKzlqFt0xagneu57gjyDb4PGTq//40yRjRbXSdkTOhYI9ochf/Hxe2kaaOmDecrSShbtnfPG+epFdZksE7FCiGEW+aqZuGkUEUn79Vi591vbeWZHacYBLglsCTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723921941; c=relaxed/simple;
	bh=2blOF0KfiMK8U6H4ERCzY5ZT5I8lnCEfrvSQMtyIblw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UgIiCnqEOtEUjFiSVUDQAHcnZE1l4nr/AIw3q+jTb5BMI3at1lCTAdnS2KdRjeHeJ8zKEmrjJJXnsCCVAOP0qJzNaijRgjycEpYDzS+x1R97RhoODIYS6var01EKrTo4DwLc5Gt9vDfjx2v3KEWwSG4J9/FVhfVyNaiaSMGa80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824c925d120so290821939f.3
        for <linux-wireless@vger.kernel.org>; Sat, 17 Aug 2024 12:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723921939; x=1724526739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFD6qD3rW7rnczddHSWMIFzVoUEuhzzFjSw0LeSwMMw=;
        b=Bw0QtbPZgCKYFtVhdLZX9b2PlbHi3rHD11AvlHrXTjhBzAb8e3SMMa+iC//qkiSKFC
         Wn0W6k8dB9/oXDRT1Q2l025V4o5kxwd0WN+GFX408GbUmAOT1GAq6dPEZucUQz1uVnk4
         6/wlGWJFtmZcJn7mx3ecpvZ9uu0Xm7ymYJqWoPFRQq93Fu/cCLYjwEaIWNCrjF5W7keO
         v7uPOwOxl7PYYpGfee6QEMpH5yzZBymOkR49wzanKmQ66zcikMC+8HsiIueTRqClhcbr
         Avj/9X2KIGF6VZFD0wvEn1NX5cuOj7HbcVK/V66I3j+qO4LRM75WdgI2Tl2wJNlHD8fy
         7ijA==
X-Forwarded-Encrypted: i=1; AJvYcCUkLzbw6Jy9rKeaS9p5aJI+R8q0cRXHHBpJ7a0AM89bvIvxxV0GhVI4x4ayvoxMk63On7WG+r8snHd+LOXRso3PlZrKGBC+SC0YiLhbI+I=
X-Gm-Message-State: AOJu0YzNAlbfvczkFKCdHjAWIDUX+hHF2uOIANm0tHCOeGVm0aBhktXR
	ZpakdAAKRwebjwV8QFh1Qc5CCfsB42zVgKjJUW1ZK/OjdLoXDrWLFamOewskT7mtD/QXI6v3bC4
	8rRTM16ruhVZgPmD9lDk3KsI0yffWWxJXDXiQ3CCy+hTTWXu0VXRQT3s=
X-Google-Smtp-Source: AGHT+IF0wTvBx1DMrk6Zb/Z59M/+HgGT2o0S3T1WngXZACmjCkagJp73hpLQvL3Bi6CLsFNA74eNSgCwZfZqJFshrZNqrbnkO9S7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2182:b0:4c2:7f96:6f4 with SMTP id
 8926c6da1cb9f-4cce16d0113mr300497173.4.1723921939086; Sat, 17 Aug 2024
 12:12:19 -0700 (PDT)
Date: Sat, 17 Aug 2024 12:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccd0fc061fe5dab8@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in
 cfg80211_wext_freq (2)
From: syzbot <syzbot+ad5a1b5c1c112c61fc6f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=159bd409980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bc88a9f65787e86
dashboard link: https://syzkaller.appspot.com/bug?extid=ad5a1b5c1c112c61fc6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ef30d34e749/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a21c2389ebfb/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9720b12c3f99/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad5a1b5c1c112c61fc6f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in cfg80211_wext_freq+0x170/0x1ac net/wireless/wext-compat.c:238
Read of size 2 at addr ffff0000cbece140 by task syz.3.369/7789

CPU: 1 PID: 7789 Comm: syz.3.369 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load2_noabort+0x20/0x2c mm/kasan/report_generic.c:379
 cfg80211_wext_freq+0x170/0x1ac net/wireless/wext-compat.c:238
 cfg80211_wext_siwscan+0x438/0xef0 net/wireless/scan.c:3447
 ioctl_standard_iw_point+0x7f0/0xdc4 net/wireless/wext-core.c:867
 ioctl_standard_call+0xcc/0x264 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x1b4/0x534 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x1f8/0x3f4 net/wireless/wext-core.c:1077
 sock_ioctl+0x15c/0x838 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 7789:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x2a0/0x494 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ioctl_standard_iw_point+0x3b8/0xdc4 net/wireless/wext-core.c:828
 ioctl_standard_call+0xcc/0x264 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x1b4/0x534 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x1f8/0x3f4 net/wireless/wext-core.c:1077
 sock_ioctl+0x15c/0x838 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000cbece000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 4 bytes to the right of
 allocated 316-byte region [ffff0000cbece000, ffff0000cbece13c)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10becc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 05ffc00000000040 ffff0000c0001c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
head: 05ffc00000000040 ffff0000c0001c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
head: 05ffc00000000002 fffffdffc32fb301 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000cbece000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000cbece080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000cbece100: 00 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc
                                           ^
 ffff0000cbece180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000cbece200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3445:8
index 33 is out of range for type 'struct iw_freq[32]'
CPU: 1 PID: 7789 Comm: syz.3.369 Tainted: G    B   W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf8/0x148 lib/ubsan.c:429
 cfg80211_wext_siwscan+0x4a8/0xef0 net/wireless/scan.c:3445
 ioctl_standard_iw_point+0x7f0/0xdc4 net/wireless/wext-core.c:867
 ioctl_standard_call+0xcc/0x264 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x1b4/0x534 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x1f8/0x3f4 net/wireless/wext-core.c:1077
 sock_ioctl+0x15c/0x838 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
---[ end trace ]---


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

