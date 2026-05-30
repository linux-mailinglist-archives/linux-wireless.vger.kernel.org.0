Return-Path: <linux-wireless+bounces-37179-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IC7JKNQG2r1AgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37179-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 23:03:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC89613694
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 904DB308551B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD46357CE0;
	Sat, 30 May 2026 20:57:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3C35677D
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174647; cv=none; b=fXyvgcM4QYf8GL5Q9AEJ7Ir+CcSZVriuDDVTTRBcD9qSLg5xGDiLsLBRSnRiZfl+VDMU/xoqXWA0xnLDaHFe30zcrP1XTtLt8+UXO3sOe69bV8y/BVixuS09hieBmXUbck25+vVLti8KcOpUHj8Law9M4+o4Cdda0uOjJi09bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174647; c=relaxed/simple;
	bh=x9XptYzkS0OkjDLmo3HFzDKjn6JaQFGBGCp0SsokgMg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DMIcQtZB213VQjwNNR0AbDb61Y/hSgQZ01ASQmcxYz2o0864aUBzHELiusDh0UofQfcxA4Nu73dfeOQdDNMty1hHauggqTEDR5QlhK4xsXxRJuXwLbL290QBvdsG2dhMk/MCo82tl7M18ZVii4buDvyhXHQcy6rOuIQMV3GG/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e6b5fe5484so169419a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 13:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174643; x=1780779443;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFO42tYpiiCLtgSoeyOHL39wBhqoRauG4K/xR+OLdpI=;
        b=Ghvg8CZTOSLgRurd7F3jN/S0u06l6i+VGUOfLYYf0MRy3yt0OWjJzLmay0YMKpXG4/
         8itPtfHOzipy/CVTZbLKhLfVdXV2+fu3G/cOemkahSPg8Fq3NOaO16xbGSQZnFF5F3yA
         bj/O0kDo2JlsprW1wk5QBQ0PR/X9pyjnrlyaUpV+CRGybN7BF/LBwt+gA2y6Wd4iInPY
         tdtANSfoxBIxOoBVE5bd42Ei8sqvJzJ+u3RhKhAasbXilL3/rRVvrgWwCZ8dt1hZWlrH
         cloR85UGrqAeEOgY2RYN6QNxv8KVduQosMcLA4VJWeamirUZl0OCn3OWF3DEff/Lit5q
         HhwA==
X-Forwarded-Encrypted: i=1; AFNElJ8FGkG9ZCwXedov8rUSAyEnbYIsrlaVKwAFMYyEufutjYkmSJJ7eiAYw2UAPmqruo/NvGRzkAumCsIykzmijQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxxecW7wHxVS5mdEz3FJzgPElDeiJ8+oSMbA9GTMSYUajOHwI
	R0TV3Sr40uHBpllxGPiMWnn9LOT2YZlsco4COCPIqPw89UQlcfIVWFzRKMMfkPhGpYIZubd15pv
	BYh5GQ5dT0Ido/i3xpfY8RRxACer3ViwRIu4ClPkjciRhuFOBnAoApAbG8cQ=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1627:b0:69d:8bac:f57d with SMTP id
 006d021491bc7-69e04389831mr3099699eaf.26.1780174643472; Sat, 30 May 2026
 13:57:23 -0700 (PDT)
Date: Sat, 30 May 2026 13:57:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1b4f33.fbc46276.d3ed.0459.GAE@google.com>
Subject: [syzbot] [wireless?] UBSAN: shift-out-of-bounds in ieee80211_parse_tx_radiotap
From: syzbot <syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bdcbd6339981e22b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37179-lists,linux-wireless=lfdr.de,8e0622f6d9446420271f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: ECC89613694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    3e48a11675c5 Merge tag 'f2fs-for-7.0-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126256e6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bdcbd6339981e22b
dashboard link: https://syzkaller.appspot.com/bug?extid=8e0622f6d9446420271f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fd6c02580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1026fe5a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3e48a116.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0749cae3d374/vmlinux-3e48a116.xz
kernel image: https://storage.googleapis.com/syzbot-assets/425b8d5bc900/bzImage-3e48a116.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in net/mac80211/tx.c:2174:30
shift exponent 235 is too large for 64-bit type 'unsigned long'
CPU: 0 UID: 0 PID: 5454 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x385/0x410 lib/ubsan.c:494
 ieee80211_parse_tx_radiotap+0xadb/0x1950 net/mac80211/tx.c:2174
 ieee80211_monitor_start_xmit+0xb1f/0x1250 net/mac80211/tx.c:2451
 __netdev_start_xmit include/linux/netdevice.h:5275 [inline]
 netdev_start_xmit include/linux/netdevice.h:5284 [inline]
 xmit_one net/core/dev.c:3864 [inline]
 dev_hard_start_xmit+0x2d8/0x870 net/core/dev.c:3880
 __dev_queue_xmit+0x168f/0x38a0 net/core/dev.c:4829
 packet_snd net/packet/af_packet.c:3077 [inline]
 packet_sendmsg+0x3eb6/0x50f0 net/packet/af_packet.c:3109
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x709/0x7a0 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f251db9bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff388b1f78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f251de15fa0 RCX: 00007f251db9bf79
RDX: 0000000000000038 RSI: 0000200000000640 RDI: 0000000000000007
RBP: 00007f251dc327e0 R08: 0000200000000380 R09: 0000000000000014
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f251de15fac R14: 00007f251de15fa0 R15: 00007f251de15fa0
 </TASK>
---[ end trace ]---


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

