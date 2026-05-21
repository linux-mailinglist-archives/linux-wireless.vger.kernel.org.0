Return-Path: <linux-wireless+bounces-36764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPaCAQg5D2rUHwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 18:55:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A025A9B02
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 18:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BBF03192F17
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C834AB03;
	Thu, 21 May 2026 15:27:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB034A3C4
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377261; cv=none; b=fpfiZ1cSvoy1ov9w2VzV7IoMS+z/dCbcdL/ruEkek+GF3rWcm7ce041t1Sm0CUxQcY//Gwuhc3gwG+CdAN9ojOLqPzZkRdf/nxgNkIRW20yc1KeEVPhybtcvm1NFs0AD7Gu/5r/CX2uH18pQ6dkCHNY0zxTjFc4VGD6UA82+ApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377261; c=relaxed/simple;
	bh=YMyWGhnn82d8s1VoNMYdEELPpWZHkibRtHoYKpx5irw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qi2+faSYRZF3bgoRcfvhTtYq4yPY14lxKx3CmE0FN6EevXU8xGRxgMZi2upIjca5ej+oZKJNjqn4Pm6ksjuc9Q0aKpSZXXvsKhDXcZl8FozHsA9Nep2+TJeMZkcfli9KpwZGVQmOhaeSaMG2SYXUM2MQvwmtWpygGRWMWrVGork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dcde7bf859so17553378a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779377259; x=1779982059;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7+Keg766WhyWy3D295hfJ9yyxOp545yG2+nUaggzYc=;
        b=qWvkArsf8qjmmf6OsEw6uCQirjrT3y2xqZQuESAp0u9Bn6qoz4bNL6Lhk+GXBJ5CtZ
         i921TJPwuS7e7rXgLU2pzk/RQFEPEPRxYPGORrvqLw7bNnO9wquXNRQXhyJmIUE0hLci
         B7+MrlndJiSkuw2OwN7KYv+ZzC01fynFBJ41WfNHVJSdbtWuKj711qvR6g/nIb3lctu/
         lLlKxg/Pvz5tq/V+XDgw9If4p6K2bZ42DNBNFE2PBg6mun9Gj+Qj3NjYvkFvaJo4X87h
         DTJq6e52ZhnJpJdVJbHccLVBse7pW1CxP1188jNGvQDV4pR0oQP1465SINpY3KCT4vNf
         Mfvw==
X-Forwarded-Encrypted: i=1; AFNElJ8pUM4v5npYVQ4s+YZV+O/NAlxi0ikH28Ni826a+RWrKQnUMX+NBpEsYYmM+WtazbBFQFmQio1+W+y4EKGr8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxp7T0Oftrlc7qsWA1lbIAyX1vTVTSLAAnOTZA9Q0LzfchAukJ
	arOcz0tTsqRmYCtdCnrt09SVddb3bzCq+zL33puGP+b4L+xr8naNUea8wIhJJMfm5EnhwPh3DPb
	+gfrxPMiKAW7HZSM/hlwS9QGegc5YkUWKYQlZGJMqlvMTE5B2sPtr1+bHQKo=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b0f:b0:695:b571:e574 with SMTP id
 006d021491bc7-69d6ef88c3amr1658944eaf.59.1779377259512; Thu, 21 May 2026
 08:27:39 -0700 (PDT)
Date: Thu, 21 May 2026 08:27:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0f246b.170a0220.303405.4ce3.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_get_tsf (3)
From: syzbot <syzbot+1c8c45017f784e646b47@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36764-lists,linux-wireless=lfdr.de,1c8c45017f784e646b47];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73A025A9B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    6916d5703ddf Merge tag 'drm-fixes-2026-05-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dd2536580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
dashboard link: https://syzkaller.appspot.com/bug?extid=1c8c45017f784e646b47
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1efefe7c73e1/disk-6916d570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1dcf16f12a0f/vmlinux-6916d570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7bc2e1f3e5cd/bzImage-6916d570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c8c45017f784e646b47@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: net/mac80211/driver-ops.c:255 at drv_get_tsf+0x33f/0x770 net/mac80211/driver-ops.c:255, CPU#0: kworker/u8:17/7122
Modules linked in:
CPU: 0 UID: 0 PID: 7122 Comm: kworker/u8:17 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_get_tsf+0x345/0x770 net/mac80211/driver-ops.c:255
Code: 0a 00 00 4d 85 ed 0f 84 45 03 00 00 e8 34 92 11 f7 49 81 c5 20 01 00 00 e8 28 92 11 f7 48 8d 3d c1 57 f2 05 44 89 f2 4c 89 ee <67> 48 0f b9 3a e9 a6 fd ff ff e8 0c 92 11 f7 65 44 8b 25 78 47 14
RSP: 0018:ffffc90003797b70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88805c850e40 RCX: ffffffff8af67847
RDX: 0000000000000000 RSI: ffff88805c850120 RDI: ffffffff90e8d060
RBP: ffff88805c830f20 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88805c851878
R13: ffff88805c850120 R14: 0000000000000000 R15: ffff88805c8306c0
FS:  0000000000000000(0000) GS:ffff888124374000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f619fa17e9c CR3: 000000005f5f6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_if_fmt_tsf+0x42/0x70 net/mac80211/debugfs_netdev.c:660
 wiphy_locked_debugfs_read_work+0xe6/0x1c0 net/wireless/debugfs.c:168
 cfg80211_wiphy_work+0x410/0x570 net/wireless/core.c:513
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	0a 00                	or     (%rax),%al
   2:	00 4d 85             	add    %cl,-0x7b(%rbp)
   5:	ed                   	in     (%dx),%eax
   6:	0f 84 45 03 00 00    	je     0x351
   c:	e8 34 92 11 f7       	call   0xf7119245
  11:	49 81 c5 20 01 00 00 	add    $0x120,%r13
  18:	e8 28 92 11 f7       	call   0xf7119245
  1d:	48 8d 3d c1 57 f2 05 	lea    0x5f257c1(%rip),%rdi        # 0x5f257e5
  24:	44 89 f2             	mov    %r14d,%edx
  27:	4c 89 ee             	mov    %r13,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 a6 fd ff ff       	jmp    0xfffffdda
  34:	e8 0c 92 11 f7       	call   0xf7119245
  39:	65                   	gs
  3a:	44                   	rex.R
  3b:	8b                   	.byte 0x8b
  3c:	25                   	.byte 0x25
  3d:	78 47                	js     0x86
  3f:	14                   	.byte 0x14


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

