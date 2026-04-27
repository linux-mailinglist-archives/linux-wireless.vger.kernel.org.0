Return-Path: <linux-wireless+bounces-35401-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJY2EOW472kbEQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35401-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:28:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ECB47942A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ED003010EDA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738BA359A6C;
	Mon, 27 Apr 2026 19:28:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2B3A9DB6
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318114; cv=none; b=fQ/00vXv72k0uNBjVfhoWboPv1AdT5MJnkVeiLEzXUQT4VKAK2HUUwKdrHRXuJrSJ6AG2jrirX5SWpiC3wZzGDKX9zJml0cdoWssmhJ2rasu9XA1aIotIUecIKfijCLl/eEiBcUqvHYl7iCi0XZopdTc6xywIDwj8LmSHy4+aRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318114; c=relaxed/simple;
	bh=vDnlNvFsiKfBUAeE3yo2FrQ/z2Fbdaq1YP6FVHqXliQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WWH46po3yGq5Dd0t8weC0G7PJIapKeLKKOBu7gXTeYMeeF1YN+p/Pja6ENdvEeGAesKuyaXI9pU1RlPWC7ARKgFFs5aM6b0eTnADY7rGNojd/mN02S33Bs8Wpf9TVQvSvOs99qkuyUgtX4rhChjXUUlYfLQE/JCB6G42ASoQqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-415e1ea16b4so17056130fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318109; x=1777922909;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/5m4sNbQauXf7WFmroEZt12sAZYc20CnXn6gV9B6iU=;
        b=RBkS15fY1C65Y5Kqd26CYg+Kbv9tGD2VqKa0H2JN1c5A6+7L+JA6nF/tVa2s5ZtHhw
         wRSGR7BJnHzwEGkub95O/YAiy+qsKVb+c/IFV4kboxYAqEep1HLgSDQqc0sl5ilYm+V8
         gmLhIdKqzdFM42AXtHzTH+MUZ2YBKJqNDSK+5UHO2psYdmiMAO+cHnvYfus9cA34HHvb
         2crnhra/Uca46wlsgkohPDsFXJheumczLi1EHh04BNMhZS3giwUoZ6GktPJtk4X407yR
         hZ5IN+E5S9VJnMyragSZWqs2i5P/CnZTv+OYadviuzMLXp2MdbCrUH/sezQfYaXaS4WK
         53SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nhIodmvnLEUQV96Zqpd3GAGNXgMAFKsNH1LTMyhdyhEddqQPMO5RKUwe4p51nfERShhDoyBL15hkFhhzl4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyePYbzRlMakXMrz43u//swB6gZkwJwSN8aUDsI4SQs05LRVqZn
	SjfAikyETqwy0XeYZJAPVdfBcXL17XZLdGmTQo3vHwXJH6Gosgq6Vvx7k96zak+fJCib3nmhCOm
	+1NkJNFFbLmdix5JXKSExlty+zW1/fpz9/rf0OJa7ebTv9mJf63yQnZqc5oM=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3082:b0:68d:804:55d7 with SMTP id
 006d021491bc7-6965b94ced6mr228791eaf.17.1777318109582; Mon, 27 Apr 2026
 12:28:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 12:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69efb8dd.050a0220.18b4f.0006.GAE@google.com>
Subject: [syzbot] [wireless?] divide error in mac80211_hwsim_link_info_changed (3)
From: syzbot <syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A3ECB47942A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35401-lists,linux-wireless=lfdr.de,ca7a2759caaa6cd4e3db];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email,syzkaller.appspot.com:url,goo.gl:url]

Hello,

syzbot found the following issue on:

HEAD commit:    254f49634ee1 Linux 7.1-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b32348580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=ca7a2759caaa6cd4e3db
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd59c3aee25f/disk-254f4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a93e1c819bd/vmlinux-254f4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18c05b34ca3c/bzImage-254f4963.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 193 Comm: kworker/u8:6 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:mac80211_hwsim_link_info_changed+0x476/0xfc0 drivers/net/wireless/virtual/mac80211_hwsim.c:2734
Code: 3c 06 00 49 89 c6 48 8b 7c 24 20 74 0a e8 42 72 26 fb 48 8b 7c 24 20 48 8b 0f 89 ce 4c 89 e0 48 c1 e8 20 74 60 4c 89 e0 31 d2 <48> f7 f6 eb 5d e8 30 37 bb fa 4c 8b 74 24 20 49 8d 7e 10 e8 a2 e4
RSP: 0000:ffffc90002ea7860 EFLAGS: 00010246
RAX: 000650757bb12572 RBX: 0000000000000200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88806fbe7b98
RBP: ffffc90002ea7958 R08: ffffffff903096f7 R09: 1ffffffff20612de
R10: dffffc0000000000 R11: fffffbfff20612df R12: 000650757bb12572
R13: ffff88806fbe7b18 R14: dffffc0000000000 R15: 1ffff920005d4f18
FS:  0000000000000000(0000) GS:ffff888125393000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f540c000 CR3: 0000000064b3a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drv_link_info_changed+0x505/0x880 net/mac80211/driver-ops.c:-1
 ieee80211_offchannel_return+0x375/0x500 net/mac80211/offchannel.c:160
 __ieee80211_scan_completed+0x75a/0xb40 net/mac80211/scan.c:519
 cfg80211_wiphy_work+0x2cf/0x460 net/wireless/core.c:513
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mac80211_hwsim_link_info_changed+0x476/0xfc0 drivers/net/wireless/virtual/mac80211_hwsim.c:2734
Code: 3c 06 00 49 89 c6 48 8b 7c 24 20 74 0a e8 42 72 26 fb 48 8b 7c 24 20 48 8b 0f 89 ce 4c 89 e0 48 c1 e8 20 74 60 4c 89 e0 31 d2 <48> f7 f6 eb 5d e8 30 37 bb fa 4c 8b 74 24 20 49 8d 7e 10 e8 a2 e4
RSP: 0000:ffffc90002ea7860 EFLAGS: 00010246
RAX: 000650757bb12572 RBX: 0000000000000200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88806fbe7b98
RBP: ffffc90002ea7958 R08: ffffffff903096f7 R09: 1ffffffff20612de
R10: dffffc0000000000 R11: fffffbfff20612df R12: 000650757bb12572
R13: ffff88806fbe7b18 R14: dffffc0000000000 R15: 1ffff920005d4f18
FS:  0000000000000000(0000) GS:ffff888125393000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7487a54 CR3: 00000000608c4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	49 89 c6             	mov    %rax,%r14
   3:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
   8:	74 0a                	je     0x14
   a:	e8 42 72 26 fb       	call   0xfb267251
   f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  14:	48 8b 0f             	mov    (%rdi),%rcx
  17:	89 ce                	mov    %ecx,%esi
  19:	4c 89 e0             	mov    %r12,%rax
  1c:	48 c1 e8 20          	shr    $0x20,%rax
  20:	74 60                	je     0x82
  22:	4c 89 e0             	mov    %r12,%rax
  25:	31 d2                	xor    %edx,%edx
* 27:	48 f7 f6             	div    %rsi <-- trapping instruction
  2a:	eb 5d                	jmp    0x89
  2c:	e8 30 37 bb fa       	call   0xfabb3761
  31:	4c 8b 74 24 20       	mov    0x20(%rsp),%r14
  36:	49 8d 7e 10          	lea    0x10(%r14),%rdi
  3a:	e8                   	.byte 0xe8
  3b:	a2                   	.byte 0xa2
  3c:	e4                   	.byte 0xe4


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

