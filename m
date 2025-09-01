Return-Path: <linux-wireless+bounces-26890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE71B3DB42
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 09:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2F3BE631
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 07:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE826E717;
	Mon,  1 Sep 2025 07:39:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5026280A
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712372; cv=none; b=F4X+NJm6LBx4lRpj76NK3Ynpma85C4iKMEXQ5L9zyEeSzeJEj6S4Dh2b/amljjSZHUTyYAvz0SuyWG+kFnblDSFzy7m+3l/c8f/4fjecHo62ZIveNgkx5d9WhDbr6ZfYY+6XRdpf6H26X7Drq1+wiI1oSvvGgntl22qbfaCy5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712372; c=relaxed/simple;
	bh=XBu790sK0ilYfkotHaZg1XvwC5A/vm71bvwcLgHFIHA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F3+ph/7aw7Gs/29GFJAKloUeupIOl3ApPslxvudmitOUSFt0PxGoS6vAWF6jzwJRbpaBkZjB37aEKUAfqtfeHVMaxIBIWLL6SfFHJeJIi5t/TSG3+kYNFT0bc7vCmXiVP4OG8yFHUFdqgL8tO50PVxA0MzDg+PRTfUsGxQ8fUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-887094bba6bso970334439f.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 00:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712370; x=1757317170;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NI5apfQwrzCscOrcLCa/He6Zn91QYVdhk52tpoNraHQ=;
        b=QRuyKMMERY99UgoECIMH++YrmdmMaGLAkyuOaY1Q+cn2jqakT+qhcgTBumu8EULnXF
         Tn/gOJDPsKOk9wd9T6rq4RNi4eRtC2kSdpbIIKG6RuSoWJCDpqtEqfi9xNaXUqZx0sge
         UD6hmua0hP+joyqtRcxVoViJ2lMJv3QUEzDeqq/cjDHhwpZSLiBB8KOYKUSG1vT4VyQ/
         mnsQPj8UrzL27//Dw+s9UtzIWL0MHmMSRslRIkAaeCP6IwD7wo+tHApjalYjNt3dQbnp
         2hGFivL/Ay+LMnvjbLlceguzBd2e9aKk7txZnfD1Ka7nBAyXoViIDrYmoSyGhwyIoep2
         GuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM4oG5cLc7R5UmuCF5s3rdFtPN9ZXAwKDkB1LOB81NU2YlcokceW/nndy6apKAWgAcXeusapSJrC1uXgxNcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztlnff9Scl0a3u9MJdW5cv1A3V6qo9pMUByhkJZYyAFJBBvps0
	DI1x50B7eIw4YcXy5AfAvkU6zCOpABVm7l5nHrKIhW3j5FzO5uCPPCPwAN0iAbFIDDu05R6bTE7
	N2VJZTWRJCDzKw8Mm2sAUoUfvKkTVbOxB07jUfiAR6Fa+kcmPtaAhB5WGSgM=
X-Google-Smtp-Source: AGHT+IGRvXq0UDliP80MzxsO0UoEe7QkLZQOZyBgwKooCR6/E8CMv9UbP+ueafzb9rnLpkceneAtmbk2FbdTwKLuti3RWMW6pPi/
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:3ec:2c8a:f35 with SMTP id
 e9e14a558f8ab-3f4019f6ae7mr135053725ab.18.1756712369760; Mon, 01 Sep 2025
 00:39:29 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:39:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b54db1.a70a0220.1c57d1.0544.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: ODEBUG bug in cfg80211_update_known_bss
From: syzbot <syzbot+df9509569a0752b1e83e@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c65ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7016efe6aaa498c
dashboard link: https://syzkaller.appspot.com/bug?extid=df9509569a0752b1e83e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fab1beda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07d60c58352f/vmlinux-fab1beda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6d2b98f110e/bzImage-fab1beda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df9509569a0752b1e83e@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff888052041c80 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 15 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 07 d8 52 fd 4d 8b 0f 48 c7 c7 a0 51 e3 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 2a 7a b1 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 57 0c d2 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000041ec50 EFLAGS: 00010296
RAX: f40f5c254b562400 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: ffffc90001021000 RSI: 00000000000009b7 RDI: 00000000000009b8
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: 0000000000000000
R13: ffffffff8be35320 R14: ffff888052041c80 R15: ffffffff8b8bd3a0
FS:  0000000000000000(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0097729f70 CR3: 0000000043d02000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 debug_object_activate+0x26a/0x420 lib/debugobjects.c:842
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 kvfree_call_rcu+0x4f/0x410 mm/slab_common.c:1953
 cfg80211_update_known_bss+0x634/0x1330 net/wireless/scan.c:1936
 __cfg80211_bss_update+0x147/0x2120 net/wireless/scan.c:1983
 cfg80211_inform_single_bss_data+0xba9/0x1ac0 net/wireless/scan.c:2375
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3234
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3325
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x593/0xa20 net/mac80211/scan.c:355
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5186 [inline]
 ieee80211_rx_list+0x201c/0x2a90 net/mac80211/rx.c:5423
 ieee80211_rx_napi+0x1a8/0x3d0 net/mac80211/rx.c:5446
 ieee80211_rx include/net/mac80211.h:5210 [inline]
 ieee80211_handle_queued_frames+0xe8/0x1f0 net/mac80211/main.c:453
 tasklet_action_common+0x369/0x580 kernel/softirq.c:829
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

