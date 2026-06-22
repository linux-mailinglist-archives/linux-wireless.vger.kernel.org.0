Return-Path: <linux-wireless+bounces-37974-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OL6IFuMnOWpQngcAu9opvQ
	(envelope-from <linux-wireless+bounces-37974-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 14:17:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D56AF5E8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 14:17:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37974-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37974-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641D43045485
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1F28C5CB;
	Mon, 22 Jun 2026 12:15:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF94086A
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 12:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130526; cv=none; b=YM++aSj3iA+xNuq0sKZFbSsT8ERKwfLmgIAI9KR/NmS60tbZsdGCLR7hoX741B0k4TnIGY5fhA3bQaJLfuIYBrv8KmvvgEGhFk2s4XKyQMFOvDiN5WGohUSVUMEEn558vYpP1TFcNHkF2/kFv43/7nVq8f5V+MozgAZyXpeb9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130526; c=relaxed/simple;
	bh=WKpGS9JSJbK0ZzMQsOn+ipFHr1d2DVPDrp1OyoJaLwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C3an4KfJ+Xq7wkHs18K3BpxwBQ2u508ouFtExB0FR9FmcMeiMz0vIz7SMiNSqVdByNhbrbWF2hMduRCm8zxlv5Qik3UoEPcH1o5arGpeZJst8d3Hnyn5eb9aPldI3v1zjm5LnFjLQM6UDKfRjSrMZbHZD602MmCS/owp8Is6ylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-48b60638021so4340844b6e.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 05:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782130524; x=1782735324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNgP9SBR5rvPWzeZce32iGMVrc3C61O1viJd6KKeyOs=;
        b=Ubd1MeiV/OphS7W1AYNpYMoUcJ+YmeWELSl8DGtJmKj9AnAha2s9C4+wBIhm3s7PvT
         Ke0414oaQ9E+bnJHwQuUwp++57p41Sx9rvlA8VadBKBpjDNqspspzN2wNZW4UP20Q4aE
         NFa1jMu5mOY1M3LcDA+Lb7H2x/QXjuWF8oLoCTfwWyKG0WgGAjYEnUqEF8rbXbYtU/Yo
         SrSFvLSRNbRjpl9nMYd+JQLh8M7dzK6ZnGYBJS1XZ5rM9eOCIA0LDIepju8S1EQx6yB/
         R0bAiwLZaCSmnkGJBp3j7CdQvIeSaTJwkAZTanoluB4377l7/sZOsMNHAJjvv1UGYlBg
         ROrA==
X-Forwarded-Encrypted: i=1; AFNElJ/YUwCj7ONTSZ1uDCHiz0XkcXrqhTayl6DNzGCANjPshBf+qWkvLGh9yh1CasRKtFRxKWP3QWT1hSgLyU266w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4u8pgLqWY4mdHrUvyN0UtKmeVTf5F/FveGEGYk7Y4FhzgQwn
	j7hhGKZDIRthGgen30qJUiBQ/u3fuWTPDCKLwLxjUMQ7FYcN9DL12sVmPiy6UZQ63q4327ktNQi
	MZMVwZMpLwWDejCLdx3Rwg/I5mHy2x7E8N2U7dngYjb1o+kk/NVYd9eyzqT8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bd3:b0:487:4d3f:7364 with SMTP id
 5614622812f47-4896a79e01dmr12059027b6e.0.1782130523702; Mon, 22 Jun 2026
 05:15:23 -0700 (PDT)
Date: Mon, 22 Jun 2026 05:15:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a39275b.5031c61f.34f2da.0002.GAE@google.com>
Subject: [syzbot] [wireless?] divide error in mac80211_hwsim_write_tsf
From: syzbot <syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8deb4438448ed47a];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37974-lists,linux-wireless=lfdr.de,21629c14aa749636db9d];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email,goo.gl:url];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A48D56AF5E8

Hello,

syzbot found the following issue on:

HEAD commit:    83f1454877cc Merge tag 'ext4_for_linus-7.2-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17956aae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8deb4438448ed47a
dashboard link: https://syzkaller.appspot.com/bug?extid=21629c14aa749636db9d
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-83f14548.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06b66919e887/vmlinux-83f14548.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3dedd791b7cd/bzImage-83f14548.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mac80211_hwsim_write_tsf+0x3a3/0x590 drivers/net/wireless/virtual/mac80211_hwsim_main.c:1628
Code: 81 c4 e8 49 00 00 4c 89 e0 48 c1 e8 03 42 80 3c 30 00 74 08 4c 89 e7 e8 1b bb 22 fb 48 8b 34 24 41 03 34 24 66 b8 20 03 31 d2 <66> f7 f5 0f b7 d8 4d 8d 65 0a 49 83 c5 0d 4c 89 e0 48 c1 e8 03 42
RSP: 0018:ffffc900037aedf0 EFLAGS: 00010246
RAX: 1ffff110080a0320 RBX: 000000000000001c RCX: 0000000000100000
RDX: 0000000000000000 RSI: 0000000005e6b00c RDI: 0000000000000230
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006f5dac R12: ffff888040547c08
R13: ffff88803d7fadda R14: dffffc0000000000 R15: 0000000000000020
FS:  00007f2f6aff66c0(0000) GS:ffff88808c852000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002280 CR3: 0000000013282000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mac80211_hwsim_tx_frame_no_nl+0x16b/0x1760 drivers/net/wireless/virtual/mac80211_hwsim_main.c:1902
 mac80211_hwsim_tx+0x1784/0x2500 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2261
 drv_tx net/mac80211/driver-ops.h:38 [inline]
 ieee80211_tx_frags+0x3df/0x890 net/mac80211/tx.c:1746
 __ieee80211_tx+0x267/0x580 net/mac80211/tx.c:1801
 ieee80211_tx+0x312/0x4b0 net/mac80211/tx.c:1984
 ieee80211_monitor_start_xmit+0xb33/0x1280 net/mac80211/tx.c:2479
 __netdev_start_xmit include/linux/netdevice.h:5387 [inline]
 netdev_start_xmit include/linux/netdevice.h:5396 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3905
 __dev_queue_xmit+0x1435/0x37f0 net/core/dev.c:4872
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3d95/0x5040 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 __sys_sendto+0x626/0x6c0 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f6a19ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f6aff5fe8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2f6a415fa0 RCX: 00007f2f6a19ce59
RDX: 0000000000000026 RSI: 0000200000000640 RDI: 0000000000000007
RBP: 00007f2f6a232e6f R08: 0000200000000380 R09: 0000000000000014
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f6a416038 R14: 00007f2f6a415fa0 R15: 00007ffff9cddab8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mac80211_hwsim_write_tsf+0x3a3/0x590 drivers/net/wireless/virtual/mac80211_hwsim_main.c:1628
Code: 81 c4 e8 49 00 00 4c 89 e0 48 c1 e8 03 42 80 3c 30 00 74 08 4c 89 e7 e8 1b bb 22 fb 48 8b 34 24 41 03 34 24 66 b8 20 03 31 d2 <66> f7 f5 0f b7 d8 4d 8d 65 0a 49 83 c5 0d 4c 89 e0 48 c1 e8 03 42
RSP: 0018:ffffc900037aedf0 EFLAGS: 00010246
RAX: 1ffff110080a0320 RBX: 000000000000001c RCX: 0000000000100000
RDX: 0000000000000000 RSI: 0000000005e6b00c RDI: 0000000000000230
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006f5dac R12: ffff888040547c08
R13: ffff88803d7fadda R14: dffffc0000000000 R15: 0000000000000020
FS:  00007f2f6aff66c0(0000) GS:ffff88808c852000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002280 CR3: 0000000013282000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	81 c4 e8 49 00 00    	add    $0x49e8,%esp
   6:	4c 89 e0             	mov    %r12,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  12:	74 08                	je     0x1c
  14:	4c 89 e7             	mov    %r12,%rdi
  17:	e8 1b bb 22 fb       	call   0xfb22bb37
  1c:	48 8b 34 24          	mov    (%rsp),%rsi
  20:	41 03 34 24          	add    (%r12),%esi
  24:	66 b8 20 03          	mov    $0x320,%ax
  28:	31 d2                	xor    %edx,%edx
* 2a:	66 f7 f5             	div    %bp <-- trapping instruction
  2d:	0f b7 d8             	movzwl %ax,%ebx
  30:	4d 8d 65 0a          	lea    0xa(%r13),%r12
  34:	49 83 c5 0d          	add    $0xd,%r13
  38:	4c 89 e0             	mov    %r12,%rax
  3b:	48 c1 e8 03          	shr    $0x3,%rax
  3f:	42                   	rex.X


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

