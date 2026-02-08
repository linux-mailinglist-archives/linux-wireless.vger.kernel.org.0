Return-Path: <linux-wireless+bounces-31640-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMvdC0DaiGmtxQQAu9opvQ
	(envelope-from <linux-wireless+bounces-31640-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 19:47:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D383109EC1
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84F4E3001F95
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Feb 2026 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAC2FBDFF;
	Sun,  8 Feb 2026 18:47:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4D1FBEB0
	for <linux-wireless@vger.kernel.org>; Sun,  8 Feb 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576442; cv=none; b=k416hqOUN8NfuuUaLFLIItZi16NQ0K8U/E4ilICHVhDlFnv3DiLi6ylVyzS7v8jqy+uNVQ40fwgJJyI5LsAUh1BueeVrAjeRzWqpzceFKQbZimGi5WMQ2xDaCzh8XD5qwI44J9ttvNXtoQ/HMbxOxUkxQ6Gvrts8uzeQiHrt4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576442; c=relaxed/simple;
	bh=i0hXCxDM0ZZzYm55vptHbJdhQQnz0RWd8Z9DEWw0XuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oth9n8zTyk4EqbNmykoqtn3PxYNSm4LPNjuPpU+i3zejB7TrhCZP+lyowosp1I1SgRnWGyy3UegKwEmnNfyYwrdsV0AIZUt8Sde5sPpRUtYBm0KWND7D6kvLOZNEp3y6aCTWNPeb1XGOGgSZzkj1NtsMH25/yDy1WeBQb4Z59Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-4040b9ea153so5666063fac.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 10:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770576441; x=1771181241;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5G3y5YH8dzGduQQxVWZ1rXvYw3XyBB3w1u0iBvrwc0=;
        b=oIkzwbvPQlYNnXPnU10HGYyWt9V5kJcm+265CfN8dWFLVURTqSViBMw+GaCshnD3dv
         ZxpVfRgeusvUEhjzovWwmqmFaiozwEd6Ub3kNoudb/Y8s1ztLv/opRZXKD9Xp76wCm1g
         bShLFLodRem0JgShGgFSxhVL5ugCZ0AkVpJ7ZargYOfW2UkrkA863zBVotF68b2VRV/B
         99I6psR8oS5FYRsViRNnDCoIbbl5XchJSN8hzoQzKH5f2RK+5osW0+KKrII3xdiyYmJ+
         oUsC63tLKr3RqaN/v3LEMDZkRsuAMzmr/rezpx7DrZPbryFSgdD7EP/w+uSKUZPzrljp
         PX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjj9DCJ2Ckd3rVEcaomzi8rQiaw6mH2IRuSLUVnw0PlN4SDDHLxpspE8LZB+HeIsqwERn5NuD0rNIJ9X/4OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdQMxWYWnrwAENSawlwgfPPB2zYY3ZG9cdnNU+Acx9V7UlXrH
	8Mc+bQLPdZVwISRKs7KPL2gEIrEej6nUqMLtREMJS9Oq8aEXtH5dRTK0cuRfVMLod6igy89HBy7
	lUVyBjRg/ThvYTtDAXo2ghaid8hupgfLe4tROBrYz078RDhtmKvX5V2D0MhM=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2205:b0:659:890b:3f9 with SMTP id
 006d021491bc7-66d09abd01bmr4393922eaf.4.1770576440705; Sun, 08 Feb 2026
 10:47:20 -0800 (PST)
Date: Sun, 08 Feb 2026 10:47:20 -0800
In-Reply-To: <68385415.a70a0220.29d4a0.082e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6988da38.050a0220.1ad825.0005.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tx_h_rate_ctrl
From: syzbot <syzbot+0d516b33238bd97ee864@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31640-lists,linux-wireless=lfdr.de,0d516b33238bd97ee864];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 3D383109EC1
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    6d2f142b1e4b net: hns3: fix double free issue for tx spare..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13ade7fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178a965a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141bb65a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efb336297393/disk-6d2f142b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c21fa89166f7/vmlinux-6d2f142b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9404edc5fcc0/bzImage-6d2f142b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d516b33238bd97ee864@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Dropped data frame as no usable bitrate found while scanning and associated. Target station: 08:02:11:00:00:00 on 5 GHz band
WARNING: net/mac80211/tx.c:758 at ieee80211_tx_h_rate_ctrl+0xd82/0x1760 net/mac80211/tx.c:751, CPU#1: kworker/u8:8/3000
Modules linked in:
CPU: 1 UID: 0 PID: 3000 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_tx_h_rate_ctrl+0xded/0x1760 net/mac80211/tx.c:751
Code: 1c 08 00 00 48 8b 44 24 38 8b 30 45 31 ed 83 e6 07 41 0f 95 c5 31 ff e8 01 3c b2 f6 43 8d 4c 6d 02 48 89 df 4c 89 f6 4c 89 fa <67> 48 0f b9 3a 41 bd 01 00 00 00 e9 73 01 00 00 e8 9e 37 b2 f6 e9
RSP: 0018:ffffc9000b7173c0 EFLAGS: 00010293
RAX: ffffffff8b123f8f RBX: ffffffff900054b0 RCX: 0000000000000005
RDX: ffff88805e97c384 RSI: ffff8880783817c8 RDI: ffffffff900054b0
RBP: ffffc9000b717528 R08: ffff88807cad29c7 R09: 1ffff1100f95a538
R10: dffffc0000000000 R11: ffffed100f95a539 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff8880783817c8 R15: ffff88805e97c384
FS:  0000000000000000(0000) GS:ffff8881257f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf034708c0 CR3: 0000000079e3a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 invoke_tx_handlers_late+0xba/0x18a0 net/mac80211/tx.c:1849
 ieee80211_tx+0x2d7/0x4b0 net/mac80211/tx.c:1971
 __ieee80211_tx_skb_tid_band+0x50f/0x680 net/mac80211/tx.c:6288
 ieee80211_tx_skb_tid_band net/mac80211/ieee80211_i.h:2405 [inline]
 ieee80211_send_scan_probe_req net/mac80211/scan.c:685 [inline]
 ieee80211_scan_state_send_probe+0x594/0xa00 net/mac80211/scan.c:713
 ieee80211_scan_work+0x65f/0x1c50 net/mac80211/scan.c:1174
 cfg80211_wiphy_work+0x2ab/0x450 net/wireless/core.c:438
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess):
   0:	1c 08                	sbb    $0x8,%al
   2:	00 00                	add    %al,(%rax)
   4:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
   9:	8b 30                	mov    (%rax),%esi
   b:	45 31 ed             	xor    %r13d,%r13d
   e:	83 e6 07             	and    $0x7,%esi
  11:	41 0f 95 c5          	setne  %r13b
  15:	31 ff                	xor    %edi,%edi
  17:	e8 01 3c b2 f6       	call   0xf6b23c1d
  1c:	43 8d 4c 6d 02       	lea    0x2(%r13,%r13,2),%ecx
  21:	48 89 df             	mov    %rbx,%rdi
  24:	4c 89 f6             	mov    %r14,%rsi
  27:	4c 89 fa             	mov    %r15,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  35:	e9 73 01 00 00       	jmp    0x1ad
  3a:	e8 9e 37 b2 f6       	call   0xf6b237dd
  3f:	e9                   	.byte 0xe9


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

