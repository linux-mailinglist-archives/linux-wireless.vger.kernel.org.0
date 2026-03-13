Return-Path: <linux-wireless+bounces-33197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILEmK6TOs2n2awAAu9opvQ
	(envelope-from <linux-wireless+bounces-33197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:45:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230127FE93
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76D8C301FB92
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F0386C08;
	Fri, 13 Mar 2026 08:45:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C53386575
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391521; cv=none; b=dzGa2Z4KYDMPhDa0D8LMjTBnkUrGDseTS8r3iNz0rwqQbogosnuDNZLGXmad1a3SigsS+d/8jXTqmNe3RDmcttZAV8V3ZjhhZNv+qAuvSCKzMrbUcKpC89f7iU1pEe6dYcHFotVz8JFY4z9z+GTqcLBA1kXmRsuzuK3jDBK+N90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391521; c=relaxed/simple;
	bh=q/2arKQRvxe5l8bdQLLgTnns1HiKUCDfcCll5Cm23SM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=aKLe2A7VmoaHHLKnWF4uy7zGwwFiit1CJf+74Q6MKOYXdsu7iUdHfb8kQjmu/04s46W7ovr6Q0xJQ3/KBLI92I0i/B1pB/d+nhQGcdjzhStFKQWUzZUhmeGCVedrB1Zfn194fN8a9+Xm7HQPslzCrZphSjCanVasj8eiUXWJc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66308f16ea1so22531077eaf.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 01:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773391518; x=1773996318;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MHG008xP8OEekEobxOFfSIkDz9YZx5/0f2eRnYeoWw=;
        b=ojSQLvKmsjsnM482dvKl2Fra5J67WXrBjCw+70GM8D7sk0NAHrLHAdg0OqXGlFcdqX
         KCRVVUjyGvNq7OxTSt2cDdNChutypTvID1NKz8dg5wLM2sJBlxJ4wpy1LmoyGHj9aWit
         7z4Rrk3Fx+k8tqrvtgyGcxCOyKAuT1iLY7qURlbAnAmD1oaH26TolBA5oS8vlhkAQ0N8
         EpqSY5rh3fJpAYdjkpEWtX3B9S3a7YTqsBmk6vwppcnzacxeqAMoBK8BqX0FjbyasDy1
         Wv1zeNCZniS12/zHoWiI8IklH5k+NoOfOBrcNrTY5+n5BX7FSyip7szfcQS5aHks/B3v
         0cBA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2l3GFvnG/mViuPlsXGYrIsZQgWTmE2kWUZpBqLwjzS7C8C5xIM9rzFinZ+fMY9qa6XFefdtX0Qjd6hkGRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPp8VaEa6RHcnT2zK/V20mkyulsmF1hPqvyxSuv/Sw0FURtHZ/
	84sOexH5BZMPGLJoQQzvmrHalzT/wo5EMyZl7b45NccZVKCcT1IG/+apoQgXKe2qhLuqEXKX8M5
	YOVI0ebbo60y38AoyDjZQ0VdgobQNTTK8rJsnT1J5Rf4dKHyTlDHwZvStpCE=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:207:b0:67b:aa33:4086 with SMTP id
 006d021491bc7-67bda9bf9d2mr1684336eaf.18.1773391517898; Fri, 13 Mar 2026
 01:45:17 -0700 (PDT)
Date: Fri, 13 Mar 2026 01:45:17 -0700
In-Reply-To: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b3ce9d.050a0220.12d28.010d.GAE@google.com>
Subject: [syzbot ci] Re: misc chandef cleanups
From: syzbot ci <syzbot+ci0f91523e1d0ef709@syzkaller.appspotmail.com>
To: arien.judge@morsemicro.com, johannes@sipsolutions.net, 
	lachlan.hodges@morsemicro.com, linux-wireless@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlesource.com:url,syzbot.org:url,googlegroups.com:email];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33197-lists,linux-wireless=lfdr.de,ci0f91523e1d0ef709];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 1230127FE93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v3] misc chandef cleanups
https://lore.kernel.org/all/20260312045804.362974-1-lachlan.hodges@morsemicro.com
* [PATCH wireless-next v3 1/3] wifi: mac80211: don't use cfg80211_chandef_create() for default chandef
* [PATCH wireless-next v3 2/3] wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based bands
* [PATCH wireless-next v3 3/3] wifi: cfg80211: check non-S1G width with S1G chandef

and found the following issue:
WARNING in cfg80211_chandef_create

Full report is available here:
https://ci.syzbot.org/series/ce6fc7d6-d8d4-4d00-a746-db78cba13e47

***

WARNING in cfg80211_chandef_create

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      80234b5ab240f52fa45d201e899e207b9265ef91
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0a18d006-45de-4bb2-a6e2-2cbb788bd2f5/config
C repro:   https://ci.syzbot.org/findings/c279480a-56a9-4a59-b533-0033d65eca62/c_repro
syz repro: https://ci.syzbot.org/findings/c279480a-56a9-4a59-b533-0033d65eca62/syz_repro

netlink: 8 bytes leftover after parsing attributes in process `syz.0.17'.
------------[ cut here ]------------
chan->band == NL80211_BAND_60GHZ || chan->band == NL80211_BAND_S1GHZ
WARNING: net/wireless/chan.c:35 at cfg80211_chandef_create+0x99/0x3d0 net/wireless/chan.c:34, CPU#1: syz.0.17/5951
Modules linked in:
CPU: 1 UID: 0 PID: 5951 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:cfg80211_chandef_create+0x99/0x3d0 net/wireless/chan.c:34
Code: 8b 26 4c 89 e7 48 c7 c6 40 d6 e3 8f e8 a0 7d bd f6 49 83 fc 04 74 0d 41 83 fc 02 75 12 e8 0f 78 bd f6 eb 05 e8 08 78 bd f6 90 <0f> 0b 90 eb 05 e8 fd 77 bd f6 89 ef 48 c7 c6 60 d6 e3 8f e8 6f 7d
RSP: 0018:ffffc900054fef78 EFLAGS: 00010293
RAX: ffffffff8b0825a8 RBX: ffffc900054ff0e0 RCX: ffff888112b5ba80
RDX: 0000000000000000 RSI: ffffffff8fe3d640 RDI: 0000000000000004
RBP: 0000000000000002 R08: ffff888112b5ba80 R09: 0000000000000002
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
R13: dffffc0000000000 R14: ffff888111c65998 R15: ffffc900054ff0e8
FS:  000055558dcaa500(0000) GS:ffff8882a9463000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14d1588095 CR3: 000000010668a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 _nl80211_parse_chandef+0x438/0x1160 net/wireless/nl80211.c:3616
 __nl80211_set_channel+0x1fe/0x850 net/wireless/nl80211.c:3736
 nl80211_set_wiphy+0x116b/0x2fa0 net/wireless/nl80211.c:-1
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ea239c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe7ad20a38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0ea2615fa0 RCX: 00007f0ea239c799
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007f0ea2432bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0ea2615fac R14: 00007f0ea2615fa0 R15: 00007f0ea2615fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

