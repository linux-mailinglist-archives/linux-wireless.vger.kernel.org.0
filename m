Return-Path: <linux-wireless+bounces-29239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B3C7921A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 14:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B50322D8A5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3F2F6939;
	Fri, 21 Nov 2025 13:06:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1C81AA8
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730390; cv=none; b=LX9IPGTodOvxfyFmopSrHby9ntxI8fyCnXal8AWRDS0NkPkDk4w8IlQ0kt6sTF0/6SwXHjSWacHS/yJzh4UotZEmIdX7j4jFp+2ZK2FaZJ7YKais1C+5lr084EWPjcjsen7bNzTgmNsatdSX2Ly4EooUyRghoz7MQdHHdJpPDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730390; c=relaxed/simple;
	bh=OTKf8dL3P15Qi40FCccyZSrliLjE4AY0nKRoT0GxW1w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qSEK+w82M7dBfqqpke49WEhAeuBl+AbpFK4p7G/uoLJPLR9zn/zUxVAlbBQisYQuqBw7Il2LcnesrboupMM/xeC2pCuDSBtFwIaC9W2WJlOR6ZTM7jxGtTrBug+EQAFf365VOfsRqTka0jSh/jNv/dV3FJKrMawxsclu24jRSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4347bc50df4so22528725ab.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730387; x=1764335187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FT1x2HB2uGxQ7NpNysTtVgySUetV2+o/si07hLXCZdM=;
        b=SAnC5lV4AciBz+skfE+D4B78RWBndwH9T2hEbp3LIDSgo5ZSBXvZfhUXeYqpXG2arT
         QzWYa0UhAfpk70FBBkNNf3TB9b+MUZlyD8fzPbMnfI7StiG/ZEADYOce0MdaA8gmgvLN
         tPDjjXluuUaP0gkC+tJicUIgnV+XuuG/HPD/S4OBurJAKPF2C2NPwwpTGe6hNbLkzHzC
         EvdTGJQM8Qh1uSzSec2KlsalHCCMZPHVY+ljd4KECUxsfWU7fiyiESGuIOY+YD00Aw//
         Px47Qu2vQKttLpTQhe3FnYnI61bmNCu/chotj4/wQH/NT+ozmmYOLgJYJPKhfF9cIbTY
         04NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVLobJ28KtrVknewo+I7lX2XfUFP+qIQgPRSGxrcTrCNXFIYDxHoy+k9l14BWzkeUr71XLALFHj/I52+3Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3sArQF53Bt02W3hNyI7pG3XeRlI/vFifPItEEOYh2tDukvNb
	1H13gZ3DzGh/lwf9p+MEnO07eBosjrxxbZLU0GxDfqOeOT3ECW1YKrmyDw4otY1eUmgCqXHt6Ys
	SCq/6AzCO1gzJbr6N/Aj20uJWomg49eaVTVkfURWU6XttDyRjQAWeyy7wDDU=
X-Google-Smtp-Source: AGHT+IFdvkkAjDlGedlOhE0xH6WOBWW95IC9KULa6N3zK1KL6ESS11Yk7FY67ydGwhnV6abpG5FhAg5AHPjOWKWpBorCl7tqe/ez
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2145:b0:433:7929:e7a8 with SMTP id
 e9e14a558f8ab-435aa8d0f3amr45844025ab.12.1763730387638; Fri, 21 Nov 2025
 05:06:27 -0800 (PST)
Date: Fri, 21 Nov 2025 05:06:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692063d3.a70a0220.d98e3.0045.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tx_monitor (3)
From: syzbot <syzbot+b28badf07224eef8281c@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    db9030a787e3 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17156212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdc83aa8a8b9d1ae
dashboard link: https://syzkaller.appspot.com/bug?extid=b28badf07224eef8281c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8932d8648ef5/disk-db9030a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8446b6e4ef5c/vmlinux-db9030a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b17118b94e44/Image-db9030a7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b28badf07224eef8281c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8882 at net/mac80211/status.c:925 ieee80211_tx_monitor+0x129c/0x1d74 net/mac80211/status.c:926
Modules linked in:
CPU: 0 UID: 0 PID: 8882 Comm: syz.1.494 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ieee80211_tx_monitor+0x129c/0x1d74 net/mac80211/status.c:926
lr : ieee80211_tx_monitor+0x1294/0x1d74 net/mac80211/status.c:925
sp : ffff800097927b60
x29: ffff800097927bb0 x28: dfff800000000000 x27: 0000000000000000
x26: 1fffe0001fceb492 x25: 1fffe0001fceb493 x24: ffff0000fe75a490
x23: 000000000000000d x22: ffff0000fe75a498 x21: 0000000000000000
x20: ffff800097927d00 x19: ffff0000fe75a3c0 x18: 00000000ffffffff
x17: ffff800093304000 x16: ffff80008052abc8 x15: 0000000000000001
x14: 1fffe0001a97c5be x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001a97c5bf x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c4bd0000 x7 : ffff800080acef64 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800097927d00
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff80008db39a80
Call trace:
 ieee80211_tx_monitor+0x129c/0x1d74 net/mac80211/status.c:926 (P)
 __ieee80211_tx_status net/mac80211/status.c:1110 [inline]
 ieee80211_tx_status_ext+0x15e4/0x1f70 net/mac80211/status.c:1235
 ieee80211_tx_status_skb+0x184/0x264 net/mac80211/status.c:1133
 ieee80211_handle_queued_frames+0x10c/0x17c net/mac80211/main.c:457
 ieee80211_tasklet_handler+0x20/0x30 net/mac80211/main.c:472
 tasklet_action_common+0x2fc/0x3ec kernel/softirq.c:925
 tasklet_action+0x68/0x8c kernel/softirq.c:953
 handle_softirqs+0x328/0xc88 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
 do_softirq+0x90/0xf8 kernel/softirq.c:523
 __local_bh_enable_ip+0x240/0x35c kernel/softirq.c:450
 local_bh_enable+0x28/0x34 include/linux/bottom_half.h:33
 __neigh_event_send+0x84/0x13fc net/core/neighbour.c:1274
 neigh_event_send_probe include/net/neighbour.h:471 [inline]
 neigh_event_send include/net/neighbour.h:477 [inline]
 neigh_resolve_output+0x180/0x654 net/core/neighbour.c:1579
 neigh_output include/net/neighbour.h:547 [inline]
 ip_finish_output2+0xdc4/0x1240 net/ipv4/ip_output.c:237
 __ip_finish_output+0x1b0/0x44c net/ipv4/ip_output.c:-1
 ip_finish_output+0x44/0x304 net/ipv4/ip_output.c:325
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x284/0x3f8 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:464 [inline]
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 __ip_queue_xmit+0x8b8/0x1794 net/ipv4/ip_output.c:534
 ip_queue_xmit+0x5c/0x7c net/ipv4/ip_output.c:548
 l2tp_ip_sendmsg+0x57c/0x1280 net/l2tp/l2tp_ip.c:518
 inet_sendmsg+0x154/0x284 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2630
 ___sys_sendmsg+0x204/0x278 net/socket.c:2684
 __sys_sendmmsg+0x1f4/0x548 net/socket.c:2773
 __do_sys_sendmmsg net/socket.c:2800 [inline]
 __se_sys_sendmmsg net/socket.c:2797 [inline]
 __arm64_sys_sendmmsg+0xa0/0xbc net/socket.c:2797
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 177697
hardirqs last  enabled at (177696): [<ffff8000803d7ea8>] __local_bh_enable_ip+0x1ec/0x35c kernel/softirq.c:455
hardirqs last disabled at (177697): [<ffff80008adf1d38>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:412
softirqs last  enabled at (177396): [<ffff800089103e74>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (177397): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
ieee80211_tx_status: headroom too small


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

