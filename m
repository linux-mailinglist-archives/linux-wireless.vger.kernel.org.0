Return-Path: <linux-wireless+bounces-29454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD3C9A9C5
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B57F1345027
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071E9306B00;
	Tue,  2 Dec 2025 08:10:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1F305E31
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663029; cv=none; b=nOTRt3t+I9mazR667UhGXfWwOgtoLWOFTyvNwMGX9k6qCiW/I00wj2R2A+xOTGpbvlNz838/HFbRbcm0AyJhSRlNxpFWy7ykngcyrUs7hB+/C9WmRmmfm3YS1UoEAz1SyZBdF8vlPYKqfA5HtU8FdKThWAtQSR6TMpReCIbRNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663029; c=relaxed/simple;
	bh=11beu77m3XSH99iHZG6sxY2GKAm1g0CiV99okHR8i7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e8a+MW890LOVoKZWH0JzoROlzGk78PcB0auN6rfj3aqcF+tBycxEzhvoVBkyL89EzdoW4E/x+E9UYxaYJOEnGeC/4C87XWcWDmcT0O1Ey0CNKONHkPm1HTi4J1h9OD3diPPiLQE9J3eujhGsDBdS9ZHC3NVlPB/Uypo24GnEGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c766d79592so10855234a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 00:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764663027; x=1765267827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDMKEYnpuLlWaIZRDt0ZS3TJNITU/RQHRs90A4VxKEs=;
        b=uGyyJgZBq6DkTK2jaAUz+6aT3rYRExfRfh8BI5duUDKC4nbUSgJYFCM4zeYMzKzQJB
         fqq8HW4fhHTNLQcq2lDMDtXuUTXmOBG2GdpsC6vCcX8BIO8kiSVTbmhfRGkjWpSJJhlT
         xZNIJWwOnAy1fwRe9iWx36FP9s/yFxoSl3q3swLR3MO//ZjabkUF6MFL9XAeJy85YvEw
         S4RwhXMfOLthnV/SVvUPDOoOqgs6UJhRucWs2+1BtvYVEc6VOd9X9zCQDXrUac9lj2/C
         NHUl/mlO5zTtQUwrHIEirA5U08SqTd2QTol02IiWec0QLFhWHRYlOCbqW7OAmQtvgZfE
         WFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhXcQQWBbDLuiYNYYXg3mfMgJrLGL2Bu5Z3Ql/sM3AN5TCdyA0j9ZJwSvXhSF1f+soIPyKWNVzTCAUG0dkwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTXwoX1/fmOkYdMPJbWmb/TAJRds0DcQbqnyyqAz1Tf0y4mbt
	cM90YC+l40O+/6+F0fwYsQVO7duTk1j9YvQ2kaTaY2R+ZLawn7MWB+WVTgkL17raBWUNFqcwmPu
	gbl2ZesXH43bwa0iZE0EaHbFxVHlF/AUo7o1wQjm0BRick4RPXc5yrdD2BMU=
X-Google-Smtp-Source: AGHT+IFTdChVnoE9bhLekkEqW6e3Rh+Y/V9ODdbtrC1WLVSBuhLzlLfA+1HmjqBcmJ2t5Ow2ZzJSR2fj2CIb1lo5EvLaQTXH/+R3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6684:10b0:453:587c:8362 with SMTP id
 5614622812f47-453587c83demr1925680b6e.11.1764663027383; Tue, 02 Dec 2025
 00:10:27 -0800 (PST)
Date: Tue, 02 Dec 2025 00:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692e9ef3.a70a0220.d98e3.0196.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_determine_chan_mode
From: syzbot <syzbot+639af5aa411f2581ad38@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa7243aaf194 Merge tag 'dma-mapping-6.18-2025-11-27' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1043de92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6824ec1757ea1310
dashboard link: https://syzkaller.appspot.com/bug?extid=639af5aa411f2581ad38
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ee24b4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1443de92580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-aa7243aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/553231cb1529/vmlinux-aa7243aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee81b2a17eb1/bzImage-aa7243aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+639af5aa411f2581ad38@syzkaller.appspotmail.com

wlan1: No basic rates, using min rate instead
------------[ cut here ]------------
WARNING: CPU: 3 PID: 6085 at net/mac80211/mlme.c:1129 ieee80211_determine_chan_mode+0x13a0/0x41b0 net/mac80211/mlme.c:1129
Modules linked in:
CPU: 3 UID: 0 PID: 6085 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_determine_chan_mode+0x13a0/0x41b0 net/mac80211/mlme.c:1129
Code: 4c 24 08 ba 01 00 00 00 8b 41 04 83 f8 00 0f 47 c2 89 41 04 e9 da f6 ff ff 4d 89 e7 4c 8b a4 24 a0 00 00 00 e8 61 00 ce f6 90 <0f> 0b 90 e9 da fc ff ff e8 53 00 ce f6 90 0f 0b 90 e9 45 fa ff ff
RSP: 0018:ffffc9000413e6d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff8aeee63e
RDX: ffff888029858000 RSI: ffffffff8aeee77f RDI: 0000000000000005
RBP: ffffed1009b74af6 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffff888025dc3000 R12: 1ffff92000827cf7
R13: ffffc9000413ea08 R14: ffffc9000413ea10 R15: ffff888025dc3000
FS:  00007f6cc669e6c0(0000) GS:ffff8880d6d05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e663fff CR3: 0000000053ab0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_prep_channel+0x218/0x18c0 net/mac80211/mlme.c:6059
 ieee80211_prep_connection+0x6df/0x1930 net/mac80211/mlme.c:9030
 ieee80211_mgd_auth+0xdd3/0x19d0 net/mac80211/mlme.c:9320
 rdev_auth net/wireless/rdev-ops.h:486 [inline]
 cfg80211_mlme_auth+0x564/0x980 net/wireless/mlme.c:291
 cfg80211_conn_do_work+0x64c/0xfd0 net/wireless/sme.c:182
 cfg80211_sme_connect net/wireless/sme.c:625 [inline]
 cfg80211_connect+0x1365/0x2130 net/wireless/sme.c:1527
 nl80211_connect+0x1560/0x2140 net/wireless/nl80211.c:13298
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
 __sys_sendmsg+0x16d/0x220 net/socket.c:2716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cc578f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6cc669e038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6cc59e5fa0 RCX: 00007f6cc578f7c9
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000003
RBP: 00007f6cc5813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6cc59e6038 R14: 00007f6cc59e5fa0 R15: 00007ffed3637698
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

