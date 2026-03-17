Return-Path: <linux-wireless+bounces-33355-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLiILnSTuWk5KQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33355-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 18:46:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F82B01CB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 18:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726FD3006B2F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD037B40E;
	Tue, 17 Mar 2026 17:43:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF613346A0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769412; cv=none; b=CJBmw8a62zbqMZHmfr2HNI9My9SLxAmNa9g66YtYTWraPt6UGLQNwiT3MHMig2aFKlPEBERu7Vl2oIO0hzp5obpkXboUuSW87E4aUpi6ad8BccWAccc7xTdVvdqpaGoCMX3opTL8/WZxFHSyPRSRL+1OiXv65xPc5wrWwpXqcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769412; c=relaxed/simple;
	bh=+SXVrqZI0qMsIBsgCyQfCxi3fESHXlzzXdpTBR29ovk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GqgwqzJNZq6Sgi2zjLRbvLZocJGyzHmNZUfMbv6e2/kXSFf0UDTVMHCrkHWF7U7bZYQ0rEFtdt/s8EAIFTPvwSh/jPBXtUWZdlZk5ia1fJUp7zqeYkWjaoUC54fXDe+WZvkOt5KmAGC26yJip3B3Ti1p+AiaxIoXJm61wpXTwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-67bb5dbf5bbso36932884eaf.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 10:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773769410; x=1774374210;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FNF9bTbNaLSfoRgrdQVVr2etTEHLQhXtfiXec0IJH8=;
        b=X4fcjeCOPJJOWcSXmtRvFyq82hsM2mTiwY7+PrpS9zF5ZqUoxZqn12q6YGhwDqb+kK
         OQMEsEBa7OogWKTN1fesDTvAkwx/nUhU9d4ZxHPu78Kk5/gegtrRyZWSodc+PPEOrNpB
         3o/IMKPF4moMKjts/Tbk4oUMJ9qXkvnjnyNA2RF6/IKcgiqZsZOw82+l3Fu2K2eXjT8b
         nnMivpRMkz3fHnPa/XdqlHsFypfuOOY6ior84JyqiNiPc6zH9uFDgN0sFD135D1JMmFj
         t+yG1S6eGg1Wf+K/AhcdN4hY7EC6TtJ+c0mtiiZYXCSpv+mfglMeL6YXs/xGmiK/W8E9
         GB7g==
X-Forwarded-Encrypted: i=1; AJvYcCUrXUOTKXlzBLim6FXvdrIV0AJdxUUvH76qXlY5lp/9Ft7arfe2ojzBdoFNO/v/8JOPwrJN2q3xxVb5/821kw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FY6o0EXJs4XeEfFFwBX4fqwXQ1aRTGKZuj6DdDcdGRkYsuEs
	IAH6u+7OvJ9Zukrmk0okJud4O7+1REK89bVTzJRN5kSGXji4X1xGrV+hUhpIhWC5t2qz1euJR8U
	pe9CmZMytysfHkcn7Ug+lBbToUqndHBU8VjRyppjDH0cfcV1+HY1h8styw0M=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:20b:b0:67b:f24a:a53f with SMTP id
 006d021491bc7-67c0dabe1e5mr119000eaf.24.1773769410643; Tue, 17 Mar 2026
 10:43:30 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:43:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b992c2.050a0220.248e02.0132.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_chandef_create
From: syzbot <syzbot+d9f5fabbbcf4b377d01f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e7280ad1f68b2dce];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33355-lists,linux-wireless=lfdr.de,d9f5fabbbcf4b377d01f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 2A9F82B01CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    b84a0ebe421c Add linux-next specific files for 20260313
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11308216580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7280ad1f68b2dce
dashboard link: https://syzkaller.appspot.com/bug?extid=d9f5fabbbcf4b377d01f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1090c8da580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179338da580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09145161a8a9/disk-b84a0ebe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b64c254e474c/vmlinux-b84a0ebe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7c33f5f7f45/bzImage-b84a0ebe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9f5fabbbcf4b377d01f@syzkaller.appspotmail.com

------------[ cut here ]------------
chan->band == NL80211_BAND_60GHZ || chan->band == NL80211_BAND_S1GHZ
WARNING: net/wireless/chan.c:35 at cfg80211_chandef_create+0x99/0x3d0 net/wireless/chan.c:34, CPU#1: syz.0.17/6021
Modules linked in:
CPU: 1 UID: 0 PID: 6021 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:cfg80211_chandef_create+0x99/0x3d0 net/wireless/chan.c:34
Code: 8b 26 4c 89 e7 48 c7 c6 20 78 26 90 e8 60 be ad f6 49 83 fc 04 74 0d 41 83 fc 02 75 12 e8 cf b8 ad f6 eb 05 e8 c8 b8 ad f6 90 <0f> 0b 90 eb 05 e8 bd b8 ad f6 89 ef 48 c7 c6 40 78 26 90 e8 2f be
RSP: 0018:ffffc90003986f30 EFLAGS: 00010293
RAX: ffffffff8b193a38 RBX: ffffc900039870a0 RCX: ffff888032143d00
RDX: 0000000000000000 RSI: ffffffff90267820 RDI: 0000000000000004
RBP: 0000000000000002 R08: ffff888032143d00 R09: 0000000000000002
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
R13: dffffc0000000000 R14: ffff888012a762f8 R15: ffffc900039870a8
FS:  0000555592955500(0000) GS:ffff888124ee0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbf5f187600 CR3: 0000000077436000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 _nl80211_parse_chandef+0x437/0x1300 net/wireless/nl80211.c:3637
 __nl80211_set_channel+0x248/0x880 net/wireless/nl80211.c:3761
 nl80211_set_wiphy+0x116b/0x2fa0 net/wireless/nl80211.c:-1
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec+0x112/0x150 net/socket.c:796
 __sock_sendmsg net/socket.c:811 [inline]
 ____sys_sendmsg+0x589/0x8c0 net/socket.c:2668
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2722
 __sys_sendmsg net/socket.c:2754 [inline]
 __do_sys_sendmsg net/socket.c:2759 [inline]
 __se_sys_sendmsg net/socket.c:2757 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2757
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf5f19c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1eb2d0b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbf5f415fa0 RCX: 00007fbf5f19c799
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007fbf5f232c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbf5f415fac R14: 00007fbf5f415fa0 R15: 00007fbf5f415fa0
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

