Return-Path: <linux-wireless+bounces-33107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM/vMvvMsmmPPwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:26:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA47A27350F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8524E3004D0B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36884368275;
	Thu, 12 Mar 2026 14:25:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DEA356A0D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325534; cv=none; b=Bx/014qOHafX8cRjzVKXNpPeLgAFVUz/0IBUGZ0hw7alHAAdfevz0A+na9eKd3YWlmEbGEYx8xCy/FFaKrWvPKLlf/Y8+OJUG6UC2EUcldFPcfCT+B7mDaa2WOqRsXiAE0GtIdADfbIoHzL++V/G1OGkNMMRpeWRSP7bZEkw9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325534; c=relaxed/simple;
	bh=wEEX32HNF4eC6ZqK+UZyrhwFbD3xj9KBmKHoZcAA3Tg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dLaqbTYf0iBl09lLw9tkeAhou8E7jGePsHZ8nRsSfgQVr3oM+/Baa+a7jS5ilfWh855vIKzlNDG/TADrSxo2lbeKogq4F2/6tiiJfo7KjHQei3XE5h1u/2sfncr16LqG+upJ9fogtKjYcsSN52sI8QeyTWvO3xKH67Je+6MMgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bb4c04306so8784285eaf.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325531; x=1773930331;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvi6o3jTpKg6DoplUul6SzeK3oqTYdsvs/NFs0n1/0I=;
        b=AZF4rpmO6xm4Rubq7KllfQjbJfpijeFQEhQmBbZmi80K4SWz/EkySr2YvMjbzD34LE
         w5NQ2psHZpH+HB5wdRnfJm1o5EOAN0xOSzmtlz541dprcpK0ytOgrAtXbOoPMDGjn0e+
         87xQudJRTlWYvKu+UaKhadKmlnL5o++coVHhrXUysOVqtFtvwaUImCnrT4dLIazGAOB7
         jU5twlq4rNOfPx52YUOFgpjL1zBHTt6PWUyiWIS4kg41QZonCsp97jTc/031U/f5BgJK
         dvmVJn4XAv1Je+rjpM4w/AhVaDRnthhb59grLWsaFeBu0scXEXcn2HyhUygvRYDj0rT1
         cUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH+KsAss+doGmoMmLB3GlOiSxdQuh45aA4A+qDkK/PuhB7EjW2+vesjv6r92NJ8TT/cvG7GVWesn1SEFqMbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KmpAIhjKhtpIZ84gMmQsoCiSY3BabyeU6J78JFkhR8HzFp5y
	WwMhyjAvjwF8xnziR5OvUIm16bXDB3k4MApTPxB6zpBiRT5VUxWjaFG7vyNnp+e1Cw/aNediPTz
	UYV8fc+T30XYv5oxc4VzunAjV0YG7eCzFbOdy/3VjHPjDxcirR+ruMiYAXBM=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:174c:b0:679:e732:7bda with SMTP id
 006d021491bc7-67bc8892accmr3800871eaf.13.1773325531682; Thu, 12 Mar 2026
 07:25:31 -0700 (PDT)
Date: Thu, 12 Mar 2026 07:25:31 -0700
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b2ccdb.a00a0220.707e5.0016.GAE@google.com>
Subject: [syzbot ci] Re: iwlwifi + mac80211 stability
From: syzbot ci <syzbot+cibf86f11719f1261d@syzkaller.appspotmail.com>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlegroups.com:email,syzbot.org:url];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33107-lists,linux-wireless=lfdr.de,cibf86f11719f1261d];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: EA47A27350F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v1] iwlwifi + mac80211 stability
https://lore.kernel.org/all/20260311230730.163348-1-greearb@candelatech.com
* [PATCH wireless-next 01/28] wifi: iwlwifi: mld:  Check for NULL before lookup.
* [PATCH wireless-next 02/28] wifi: iwlwifi: mld: Fix un-set return value in error case.
* [PATCH wireless-next 03/28] wifi: iwlwifi: mld: Add check for null vif in stats callback.
* [PATCH wireless-next 04/28] wifi: mac80211:  Check debugfs creation return values.
* [PATCH wireless-next 05/28] wifi: mac80211: do not fail taking sta to lower state.
* [PATCH wireless-next 06/28] wifi: mac80211: Mark sta as uploaded if single transition succeeds.
* [PATCH wireless-next 07/28] wifi: mac80211:  Fix use-after-free of debugfs inodes.
* [PATCH wireless-next 08/28] wifi: mac80211: Debugfs safety checks.
* [PATCH wireless-next 09/28] wifi: mac80211: Use warn-on-once in drv_remove_chanctxt
* [PATCH wireless-next 10/28] wifi: mac80211: Ensure sta debugfs is not double-freed.
* [PATCH wireless-next 11/28] wifi: iwlwifi: mld: Fix stale reference in fw_id_to_link_sta
* [PATCH wireless-next 12/28] wifi: iwlwifi: mld:  Improve logging in error cases.
* [PATCH wireless-next 13/28] wifi: iwlwifi: mld: Remove warning about BAID.
* [PATCH wireless-next 14/28] wifi: mac80211: Add dmesg log regarding warn-on in drv-stop.
* [PATCH wireless-next 15/28] wifi: iwlwifi: mld: Fix use-after-free of bss_conf
* [PATCH wireless-next 16/28] wifi: iwlwifi: mld: Check for null in iwl_mld_wait_sta_txqs_empty
* [PATCH wireless-next 17/28] wifi: iwlwifi: mld: use warn-on-once in error path.
* [PATCH wireless-next 18/28] wifi: iwlwifi: mld: Use warn-on-once in emlsr exit logic.
* [PATCH wireless-next 19/28] wifi: iwlwifi: mld: Improve error message in rx path.
* [PATCH wireless-next 20/28] wifi: iwlwifi: mld: Improve logging message.
* [PATCH wireless-next 21/28] wifi: iwlwifi: mld: Protect from null mld_sta
* [PATCH wireless-next 22/28] wifi: mac80211: Add force-cleanup call to driver.
* [PATCH wireless-next 23/28] wifi: iwlwifi: mld: Support force-cleanup op
* [PATCH wireless-next 24/28] wifi: iwlwifi: mld: Fix NPE in flush logic.
* [PATCH wireless-next 25/28] wifi: iwlwifi: mld: Fix bad return address in tx code.
* [PATCH wireless-next 26/28] wifi: mac80211: Ensure link work-items are only initialized once.
* [PATCH wireless-next 27/28] wifi: iwlwifi: mld: Convert to WARN_ONCE in link removal path.
* [PATCH wireless-next 28/28] wifi: mac80211: Decrease WARN spam.

and found the following issue:
WARNING in drv_add_interface

Full report is available here:
https://ci.syzbot.org/series/d3986751-1907-410b-b80c-976f38583b8c

***

WARNING in drv_add_interface

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      97492c019da4b62df83255e968b23b81c0315530
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/acf234a5-5041-402a-ace9-5766b71cadb4/config
C repro:   https://ci.syzbot.org/findings/1533841d-c00d-4811-84c1-419f7bccc86a/c_repro
syz repro: https://ci.syzbot.org/findings/1533841d-c00d-4811-84c1-419f7bccc86a/syz_repro

------------[ cut here ]------------
!sdata->vif.debugfs_dir
WARNING: net/mac80211/driver-ops.h:510 at drv_vif_add_debugfs net/mac80211/driver-ops.h:510 [inline], CPU#1: dhcpcd/5553
WARNING: net/mac80211/driver-ops.h:510 at drv_add_interface+0x5e5/0x910 net/mac80211/driver-ops.c:84, CPU#1: dhcpcd/5553
Modules linked in:
CPU: 1 UID: 0 PID: 5553 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:drv_vif_add_debugfs net/mac80211/driver-ops.h:510 [inline]
RIP: 0010:drv_add_interface+0x5e5/0x910 net/mac80211/driver-ops.c:84
Code: f3 fa ff ff e8 9c 22 ae f6 48 8d 3d 85 f2 0a 05 67 48 0f b9 3a e9 c1 fc ff ff e8 86 22 ae f6 e9 19 fb ff ff e8 7c 22 ae f6 90 <0f> 0b 90 eb 94 e8 71 22 ae f6 4c 8d 35 7a f2 0a 05 49 8d bf 28 0a
RSP: 0018:ffffc90003b57678 EFLAGS: 00010293
RAX: ffffffff8b1776f4 RBX: ffff888172594dc0 RCX: ffff8881165657c0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000006
RBP: 0000000000000000 R08: ffffffff901146b7 R09: 1ffffffff20228d6
R10: dffffc0000000000 R11: fffffbfff20228d7 R12: dffffc0000000000
R13: ffff888172597028 R14: ffff8881725957f8 R15: 0000000000000002
FS:  00007ff45a6f6740(0000) GS:ffff8882a9465000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d00b0c3161 CR3: 000000010017c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ieee80211_do_open+0x929/0x2490 net/mac80211/iface.c:1466
 ieee80211_open+0x15b/0x200 net/mac80211/iface.c:472
 __dev_open+0x44d/0x830 net/core/dev.c:1702
 __dev_change_flags+0x1f7/0x690 net/core/dev.c:9778
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9841
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0x9f2/0x1b30 net/ipv4/devinet.c:1199
 inet_ioctl+0x42a/0x560 net/ipv4/af_inet.c:1004
 sock_do_ioctl+0x101/0x320 net/socket.c:1253
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1374
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff45a7c4d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffff8603cd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff45a6f66c0 RCX: 00007ff45a7c4d49
RDX: 00007ffff8613ec8 RSI: 0000000000008914 RDI: 0000000000000011
RBP: 00007ffff8624088 R08: 00007ffff8613e88 R09: 00007ffff8613e38
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffff8613ec8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

