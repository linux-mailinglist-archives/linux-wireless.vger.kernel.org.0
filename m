Return-Path: <linux-wireless+bounces-26023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830CB123C1
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 20:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669BC1CE15AD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14862243367;
	Fri, 25 Jul 2025 18:28:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9F24729F
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468117; cv=none; b=gL+Crd4wINHWJsXfjhJ5E+RLRyMn7ZPWLJ21Y+JYeStg/SLrNef58BQ92BhZbtQd6fMgSjovBoW1BUR/TaBHGUmC6KJPp8En6wVRR1HwSrHxZZdOlYcTc+UcZj+0azzJMGfvALwBYf4Ki31zIaumWGz+VCFl8gsYOzgmBTVJNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468117; c=relaxed/simple;
	bh=ouzsgk+19QmaRO9pKjJbgZ+UqbuwEfzKidBzOU/dHWo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rrPEnK9tTVbPp3tJNyMCMqQG4cHEVF5Nd0DM1e0fRDZMMmLcLqJclHrcrzM1BY/62sAi+6J6M3sRMvpXz3PhNQvr2PUvr/WLTLUKNKNp2wyjWHyL0yZiIEW3caHhyW9uVmn67AjcI3ATn202B6L5NUPOeX0O+5Ks4Z5iLkJaEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c24b196cbso251827539f.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 11:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468114; x=1754072914;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pipXtIEWEhRvtnHJ7xlpV/XMoRV9BNZ+hdAoR8pES7Y=;
        b=cUp1Bw+DfOt6LeintrPDtDp60o70DHR00pEDVvXSQds7t8ergk41G9HMGpiysEPOGg
         PUHkYHFRHWy6/dP0QNkxfwtWRFnVVmYh9rmQnSlN8LwWJH5LrkxNem13yKWV2Swwq5+V
         giOX7kSgMK4dshVFwJHXsHCpvzbdfox8jK1wd6Hp3//zylj7CPPw4aL6zNp82L7xtUtm
         r/DF1bCVb2Phbe8Rha4+RIQHWU1j5Po3oeCJ0/jXHkj546lngNqw9ywudttlCT12aVgN
         pBbqTURUoqABp0N04bLHUtpLWTqaY54UvV+vwU9zdY/FDZSLbIe+X9ywBtVEJDRgIwqU
         pbKw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6E6DGyK80L0Z9mUCpVcB2AzYGpdoVJGKFUWGFhJFrCWuODa/oMRhtNlCzEWtbCwFR0ALQ5iq3JSmDIwmoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ckvv3hMLJivnoUtf0egoKwlsjU6b9dPITVTWHnCE1R1HKtaG
	Y9rL6jLv05Ko/mKk3UVl74BFFvg0kQ1qpzoKORQjnvUT9qOiw8Ybuz2B+AACmAPDyKxcHkImNHS
	hZbnQVUD2x3J7P6+dIZ6l+VJnlMCJohps1T9T+cweB3wYQw1wDbg/kJaAQlo=
X-Google-Smtp-Source: AGHT+IH0x+8018duqbyYiMeiRij8Fur/WaLqmHTXNy2m65q2EWKw8XSHg002KZNgmzWMNe02inHWp8hIfNTBxg3rmRMJeyJQfyKK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1494:b0:87c:538b:2a3c with SMTP id
 ca18e2360f4ac-880229b13d5mr427236839f.14.1753468114452; Fri, 25 Jul 2025
 11:28:34 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:28:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6883ccd2.a00a0220.2f88df.0056.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_ocb_rx_no_sta
From: syzbot <syzbot+a06b95a67a174af018cf@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17798fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=a06b95a67a174af018cf
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34b3f6e5e365/disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55356b071589/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5daf2522b291/bzImage-89be9a83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a06b95a67a174af018cf@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9078 at net/mac80211/ocb.c:63 ieee80211_ocb_rx_no_sta+0x583/0x710 net/mac80211/ocb.c:63
Modules linked in:
CPU: 0 UID: 0 PID: 9078 Comm: syz.1.959 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ieee80211_ocb_rx_no_sta+0x583/0x710 net/mac80211/ocb.c:63
Code: 48 c7 c2 80 c5 08 8d be 65 03 00 00 48 c7 c7 a0 c4 08 8d c6 05 4b b5 78 05 01 e8 c8 63 7f f6 e9 0b fc ff ff e8 ce 12 a3 f6 90 <0f> 0b 90 e8 25 ac 6d 00 31 ff 89 c3 89 c6 e8 fa 0d a3 f6 85 db 75
RSP: 0018:ffffc90000007a08 EFLAGS: 00010283
RAX: 000000000000022a RBX: ffff888056a7cd80 RCX: ffffc90002181000
RDX: 0000000000040000 RSI: ffffffff8b18d5a2 RDI: 0000000000000005
RBP: ffff888025e9e40a R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888030e40e40
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888033a44500
FS:  00007f8e60a7d6c0(0000) GS:ffff888124720000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3a8d5a CR3: 00000000343fa000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 ieee80211_accept_frame net/mac80211/rx.c:4445 [inline]
 ieee80211_prepare_and_rx_handle+0x55a1/0x77a0 net/mac80211/rx.c:4999
 ieee80211_rx_for_interface+0x10a/0x1f0 net/mac80211/rx.c:5129
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5285 [inline]
 ieee80211_rx_list+0x10d7/0x2980 net/mac80211/rx.c:5420
 ieee80211_rx_napi+0xdc/0x410 net/mac80211/rx.c:5443
 ieee80211_rx include/net/mac80211.h:5185 [inline]
 ieee80211_handle_queued_frames+0xd5/0x130 net/mac80211/main.c:441
 tasklet_action_common+0x281/0x400 kernel/softirq.c:829
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 do_softirq kernel/softirq.c:480 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:467
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:407
 ieee80211_tx_skb_tid+0x176/0x4f0 net/mac80211/tx.c:6131
 ieee80211_mgmt_tx+0x14d2/0x2310 net/mac80211/offchannel.c:1023
 rdev_mgmt_tx net/wireless/rdev-ops.h:762 [inline]
 cfg80211_mlme_mgmt_tx+0x7d5/0x1660 net/wireless/mlme.c:938
 nl80211_tx_mgmt+0x9f9/0xd60 net/wireless/nl80211.c:12921
 genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x58d/0x850 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8e5fb8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8e60a7d038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8e5fdb5fa0 RCX: 00007f8e5fb8e9a9
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f8e5fc10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8e5fdb5fa0 R15: 00007ffd54948378
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

