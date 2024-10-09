Return-Path: <linux-wireless+bounces-13813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AED996CA2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33875B21A7D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293C199396;
	Wed,  9 Oct 2024 13:48:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE72199E9F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481709; cv=none; b=VUeYP8/OA/2PROZOp9HesbP4IB/KNOMxwFMJHdOIeSQmkJfoC3cYVuP/jsU9DeUmBKhZzQi0WadlHOXBw4SLwDjBznGJZYHLRo6ffHIrjsL5uRZCjkRWUqNWG5bM6g/A/cWMMbJBOFgajGBXCLCbw/mrPnDW2GGQp/bGw/S/xtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481709; c=relaxed/simple;
	bh=sqyEKgaEIHBixzMZSz6UpRg/Re7a8fMiFsRaftKTxRc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HJIuZ3RFDNT7ICNPTzU5qpinfCmu/8+Da48itrC2Po5K+TyzgLqDI+QMdjHc4N2q7hLagEByw2C2dnBLPWb6TEPtj1lNLBk9T1hUevXqWMhPB5MlC58gL1LTpbQJzxpKjs7APAOfWP8I/pYoju9MWleX5hz9syiTOXTQWwWLbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83542775244so37008139f.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 06:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481705; x=1729086505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBH+agA01deK2EnfnEgoMg09FaDLd24PoeelaCAABlk=;
        b=WBUHPlbkx2X0mqUz53lHlFP28xyPFJCgtL6yi1MZcQDkS1hD5GLf9w1gV6+5BlWJBk
         oZdwHPqZHny9kV9a4h5TusZ6xsUG+SDPeSYuM9RGtKTlDW+4SFsLiNrDpKVTSW2tRjGL
         Qtbvxjywp/B6d1AN6eglhzTZ3aE2gW4sgEJcO6iYN3MliyeFbp4cPW0qT+YE6pQBH554
         O3AjUPovJn78JXZ0ijAt/7SjTrE0WxklsYg9cIJ2VX/Yza2o/4taXIP0KQExaG/zkOCP
         RvkN2Pq62FqO1K7VnTMe5byecrbx2IQyB+qZNSESIofYLmFzl5XnZg8yy8JNhzC4NM3O
         c2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrTpkJoGpdNvv96t6vuZ8Eje6kQDVXv08ffyeg0BfO9DVVCYyFiMqFSKTy1UuX44jd2IrzBNF7AgnnQYzCqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aznCiQkQrwStZ53cLl8yTY/bLjiPt31ruGmkmWlHKzOH44dm
	m3T7VxSorSdSQjtz8wO+GFra46tPho9CFlT7dC0XRkXiPYp5w38axRvr3M7cGIPR3toPUYshPIj
	rDcsBoQQwVGB35Zfom1IVBkSDWR6SA97y6qFkMOo/1WojCt2U1ajxMv8=
X-Google-Smtp-Source: AGHT+IHnMe5lc2Q03NLolZQmZ+SxAAXJagk4vihG3rU3/wbu5RXvNTAzmQuKlUs/gwZxmfyCClVkU8aNs0eqlhPt59da4so5AqSR
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a397546271mr23260295ab.12.1728481705316; Wed, 09 Oct 2024
 06:48:25 -0700 (PDT)
Date: Wed, 09 Oct 2024 06:48:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670689a9.050a0220.67064.0047.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tx_monitor
From: syzbot <syzbot+26bc0430f38b1093a293@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dd3b80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=26bc0430f38b1093a293
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-87d6aab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a670c730bf1/vmlinux-87d6aab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/069744babdba/bzImage-87d6aab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26bc0430f38b1093a293@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1113 at net/mac80211/status.c:909 ieee80211_tx_monitor+0x202a/0x2520 net/mac80211/status.c:909
Modules linked in:
CPU: 0 UID: 0 PID: 1113 Comm: kworker/u32:9 Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound macvlan_process_broadcast
RIP: 0010:ieee80211_tx_monitor+0x202a/0x2520 net/mac80211/status.c:909
Code: 0f 9e c2 84 c0 0f 95 c0 84 c2 0f 84 a0 eb ff ff 48 8b 7c 24 18 be 02 00 00 00 e8 51 50 66 f7 e9 8c eb ff ff e8 d7 d9 04 f7 90 <0f> 0b 90 48 c7 c7 00 cf be 8c e8 97 8c e4 f6 4c 89 ff e8 1f 8c 6b
RSP: 0018:ffffc90000007c70 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000000d RCX: ffffffff8a8893e0
RDX: ffff888026828000 RSI: ffffffff8a88a779 RDI: 0000000000000004
RBP: ffffc90000007e00 R08: 0000000000000004 R09: 0000000000000000
R10: 000000000000000d R11: 0000000000000000 R12: 000000000000000d
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88804f976140
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e219ff8 CR3: 000000004f2e2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __ieee80211_tx_status net/mac80211/status.c:1111 [inline]
 ieee80211_tx_status_ext+0x1b13/0x2ca0 net/mac80211/status.c:1233
 ieee80211_tx_status_skb+0x133/0x2d0 net/mac80211/status.c:1131
 ieee80211_handle_queued_frames+0xf1/0x130 net/mac80211/main.c:443
 tasklet_action_common+0x24c/0x3e0 kernel/softirq.c:784
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx net/core/dev.c:5251 [inline]
 netif_rx+0x93/0xb0 net/core/dev.c:5240
 macvlan_broadcast+0x37d/0x680 drivers/net/macvlan.c:290
 macvlan_multicast_rx drivers/net/macvlan.c:302 [inline]
 macvlan_multicast_rx+0xd6/0x100 drivers/net/macvlan.c:296
 macvlan_process_broadcast+0x225/0x690 drivers/net/macvlan.c:338
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

