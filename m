Return-Path: <linux-wireless+bounces-38401-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CPfJFRIaRGoqogoAu9opvQ
	(envelope-from <linux-wireless+bounces-38401-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:33:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB56E79AA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38401-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38401-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9C06300F268
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E63C1F5B;
	Tue, 30 Jun 2026 19:33:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08534389D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 19:33:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848006; cv=none; b=l++BPmOXyD9TNJ4GO/T6K8EWeuoUJHqnZcz9GM2Tl4u20Dvb54eZC3whaZ1cm2awWPVI0MM6EeVT/560D09DvwVfiEA6XhIEvMs7TLCFKIeiwpiF0pnbKUQDfUJDSNOrRWFwP4aapngW2o4ZjSb7jJeKV3iAy7rc2wtlGec7QOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848006; c=relaxed/simple;
	bh=TJg+PTJkYd9/0ku8b/CRQqtSDTsx14fZLzROWdCDbYE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=duqtARDXTzGNGZxrtlEK66VGGlJN9/N1O6Nxo1pp2OksqrR49IA3jeBbcIxo61sQ4n7UV6LqBlUxxPwwuvxzyL/5uusoNgf3TQIgqguYBinRjDsy4o4bhyNUJu/nff8Zb4CcTetg3/2Qd9FKRyM30k5erX1YGC6SzjIQhEZ+kMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-49601a1b80cso209634b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782848004; x=1783452804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+rWZ8k73TMV9DNYwCNJH7ZdxXY5ZdbASYCz+2kmGPs=;
        b=ljoWePHQU7kyfkEvlLAtWCSIGnSKxlz1TvVTiVXIHNQXXhihKukF73Gg+1I7aVPsJC
         +VUHvaEh0dT+EpXWZCa62woHHzEZaHCd1zvT3oSfrp9XgwyZxluN5wtxiG7HG3OiJXZC
         u1Sc6hkea54ErEIqj2p0j8lxzR0ncHjGafa8Qm2Dzy04Y28Nb5J5E1irbc5ogXQmaIwC
         6sUOHdb0lTOayUW6unlhFhLQ3YHkkjicBW+PbcvKNPVoTocUjDT6XCaX3H3wPD67jZQq
         y0t+AIf9maKuhOoe8SpFUFgajKihjYc2VlKyNvynfd26h+DRw6ZBbUKFsXOVImqvNrWw
         alIw==
X-Forwarded-Encrypted: i=1; AFNElJ85EHioLkAptpWsaJHc2KIycqDwaYgmoyiOBY0hMIkuRFZBTzYuWsAbmcxT0AMmSzPNSbrWRj+jE/amNlFfbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIruWwcvGapT+Vqp36btrTqO3Tg5QIVT9tnI3J5updLikAHcAI
	19qyc+wKe6lzUiDJA2/3DtO16rP2KKSKkUwGSG5qvigBkEj2lAg+NzLbOKxGf/HdylClLgqLwg8
	+KxnA5tIAO20WApT/HZNW+zEOx/FbSLetq3yie6uLdMqepiaACEJlDjNz7tc=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:87d1:b0:485:5f3f:bd1b with SMTP id
 5614622812f47-495fd49fef3mr1320558b6e.3.1782848003808; Tue, 30 Jun 2026
 12:33:23 -0700 (PDT)
Date: Tue, 30 Jun 2026 12:33:23 -0700
In-Reply-To: <6a00f268.170a0220.1c0296.021c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a441a03.b42ede87.8e801.0009.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in mac80211_hwsim_tx (2)
From: syzbot <syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38401-lists,linux-wireless=lfdr.de,435fdb053cf98bfa5778];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email,storage.googleapis.com:url];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58CB56E79AA

syzbot has found a reproducer for the following issue on:

HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f58032580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a
dashboard link: https://syzkaller.appspot.com/bug?extid=435fdb053cf98bfa5778
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a73289580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135db61e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dc59e4fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ee1f0ea24f2/vmlinux-dc59e4fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/729e963a1370/bzImage-dc59e4fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com

mac80211_hwsim hwsim5 wlan1: entered allmulticast mode
------------[ cut here ]------------
hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(confbw)
WARNING: drivers/net/wireless/virtual/mac80211_hwsim_main.c:2248 at mac80211_hwsim_tx+0x1ab4/0x2500 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2248, CPU#0: syz.0.17/5510
Modules linked in:
CPU: 0 UID: 0 PID: 5510 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mac80211_hwsim_tx+0x1ab4/0x2500 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2248
Code: c6 05 da 65 07 09 01 48 c7 c7 e0 74 7a 8c be 6b 08 00 00 48 c7 c2 20 76 7a 8c e8 a7 d6 8c fa e9 ff ee ff ff e8 7d eb b0 fa 90 <0f> 0b 90 49 bc 00 00 00 00 00 fc ff df e9 dd fe ff ff e8 65 eb b0
RSP: 0018:ffffc9000278efe0 EFLAGS: 00010293
RAX: ffffffff87158693 RBX: 0000000000000000 RCX: ffff888000ad8000
RDX: 0000000000000000 RSI: 0000000000000014 RDI: 00000000000000a0
RBP: ffffc9000278f170 R08: ffff888000ad8000 R09: 000000000000000e
R10: 000000000000000d R11: 0000000000000000 R12: 0000000000000014
R13: ffff8880120b3cb0 R14: 00000000000000a0 R15: 0000000000000030
FS:  000055559073c500(0000) GS:ffff88808c815000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005562391e0138 CR3: 0000000012ea1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drv_tx net/mac80211/driver-ops.h:38 [inline]
 ieee80211_tx_frags+0x3df/0x890 net/mac80211/tx.c:1746
 __ieee80211_tx+0x267/0x580 net/mac80211/tx.c:1801
 ieee80211_tx+0x312/0x4b0 net/mac80211/tx.c:1984
 ieee80211_monitor_start_xmit+0xb33/0x1280 net/mac80211/tx.c:2479
 __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
 netdev_start_xmit include/linux/netdevice.h:5409 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3905
 __dev_queue_xmit+0x1435/0x37f0 net/core/dev.c:4872
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3d95/0x5040 net/packet/af_packet.c:3114
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc04219ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb766be38 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc042415fa0 RCX: 00007fc04219ce59
RDX: 0000000000000030 RSI: 0000200000000640 RDI: 0000000000000008
RBP: 00007fc042232e6f R08: 0000200000000380 R09: 0000000000000014
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc042415fac R14: 00007fc042415fa0 R15: 00007fc042415fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

