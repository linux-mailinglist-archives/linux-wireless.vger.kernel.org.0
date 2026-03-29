Return-Path: <linux-wireless+bounces-34117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPFhCmOryGldogUAu9opvQ
	(envelope-from <linux-wireless+bounces-34117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 06:32:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72449350A08
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 06:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0216301FD59
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 04:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20E1FA859;
	Sun, 29 Mar 2026 04:32:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506B40DFC1
	for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774758750; cv=none; b=Dq4AVxN69WzuIuhjAj2XjlKXCavjLyv5ldPEoFhlt+AaXOk9BNnZk1ZTdfX0C+yZolEnf/blPRsi0w4NbrO6Ps2SD7xiGdWAyMx2zujVBkBbHOdc3j2AWmOM/YP1Q2FtfemljSoqLsXOW48M+3RnG2W63polXQor/cMNwm+yfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774758750; c=relaxed/simple;
	bh=eRRRb2N3ymTRMe23xvRvuPxbpsHO4mJ2zs/SOfgFzow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f75k1HPdCSAuk7u5lPAYL0soMVWl9A+EQDslREgCBhlyN7kvoMaXEW66hwSLEh0Y8nsJ6i2l15xJE5NMhtZFjutLArBnWN6ujw3brceqZSqgsWgCe2Okov9RE5Y1Jj7uVN5j6XmHInBvn37D8FvbpMkEZnTIhCBNpFfYVrqRIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-467e8aaa943so5134756b6e.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 21:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774758748; x=1775363548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEoAnAURmycMeJhLBjjMu7mW85fSmjHXh//VW9K2psM=;
        b=JhhM2tE6liffEj+C+ENJnuGebZhKHuv9FiA1xIkj3qdwkyKh8o46W4RGIfwSxch2QB
         YY9d8ZBd6bXJXlTy4764rTzAALzfz7OiEmlJSNJ4qAqR54beu7edzGFEDeX5Vamn366r
         Wfqa9whUAPUbKJwg3H0bXj5ygnEfV5JcdNIIsl98rgLoyI+X3aF+tJw1ZaafnPWa7kZ0
         YGQWUuYhFny3f2HoPRpruXQMjoM/I0nl0P4fd4gBJ6dRCA0jNyHWxgFbbZOkPL0YzFKk
         g3WUfLl6DrCvbW2vAvQovlm6jplYhDKmhyZhaWbp0u+jg1n0FIDKqBHCAu6s0Wma7gWE
         uBaA==
X-Forwarded-Encrypted: i=1; AJvYcCURo8eLTITaZPdqhnvhQ1RDlDp+fyarWfYRCR/VMDyX43bbozFoxCj7AenfLm4Ge5TuS9/trtWWRyEcxp8SOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JtYxE/v1KFIClip2j47W6GiBihEf74BE44Rd//WIBi7OJ25Q
	CQAzHfRxY9fhiPzGl/KQXLAcmFIMRlRThpCvLgkxJdp03Vyzd7lrTbKf1+LUrLyGfLkkgUOv1db
	uh0J2n+kgpNZMv2UBGI0Ikml+ueG08UldZYKrY/Muu4qIeQ037TA7dOHxnXQ=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:222a:b0:67d:e5f5:2518 with SMTP id
 006d021491bc7-67e185f48f9mr4419021eaf.14.1774758748580; Sat, 28 Mar 2026
 21:32:28 -0700 (PDT)
Date: Sat, 28 Mar 2026 21:32:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c8ab5c.a70a0220.97f31.002c.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_chandef_dfs_required (2)
From: syzbot <syzbot+02a1a03b8622d3c7d1c9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34117-lists,linux-wireless=lfdr.de,02a1a03b8622d3c7d1c9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72449350A08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    b1c803d5c816 net: airoha: Rework the code flow in airoha_r..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ad21d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9
dashboard link: https://syzkaller.appspot.com/bug?extid=02a1a03b8622d3c7d1c9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09cf620a7914/disk-b1c803d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72906e01e665/vmlinux-b1c803d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1bab2219b98/bzImage-b1c803d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02a1a03b8622d3c7d1c9@syzkaller.appspotmail.com

------------[ cut here ]------------
!cfg80211_chandef_valid(chandef)
WARNING: net/wireless/chan.c:796 at cfg80211_chandef_dfs_required+0xe3e/0xf00 net/wireless/chan.c:796, CPU#0: syz.0.4705/23179
Modules linked in:
CPU: 0 UID: 0 PID: 23179 Comm: syz.0.4705 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:cfg80211_chandef_dfs_required+0xe3e/0xf00 net/wireless/chan.c:796
Code: de e8 26 ed bb f6 48 83 fb 3f 0f 87 aa 00 00 00 e8 d7 e8 bb f6 b8 01 00 00 00 89 d9 48 d3 e0 e9 0a f4 ff ff e8 c3 e8 bb f6 90 <0f> 0b 90 b8 ea ff ff ff e9 f7 f3 ff ff e8 10 d9 a5 00 89 d1 80 e1
RSP: 0018:ffffc900039c7680 EFLAGS: 00010283
RAX: ffffffff8b09b83d RBX: 1ffff92000738f10 RCX: 0000000000080000
RDX: ffffc90005477000 RSI: 00000000000005cf RDI: 00000000000005d0
RBP: ffffc900039c7810 R08: ffffffff822422df R09: ffff8880b863f428
R10: dffffc0000000000 R11: ffffed10165f8539 R12: ffffc900039c7a00
R13: dffffc0000000000 R14: 0000000000000006 R15: 1ffff92000738ee8
FS:  00007f6f79eb16c0(0000) GS:ffff888125461000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6f7904eddd CR3: 0000000054d9e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 _ieee80211_link_use_channel+0x29c/0xd50 net/mac80211/chan.c:2034
 ieee80211_link_use_channel net/mac80211/ieee80211_i.h:2754 [inline]
 ieee80211_set_monitor_channel+0x692/0x8e0 net/mac80211/cfg.c:1084
 rdev_set_monitor_channel net/wireless/rdev-ops.h:453 [inline]
 cfg80211_set_monitor_channel+0x22d/0x650 net/wireless/chan.c:1600
 cfg80211_wext_siwfreq+0x730/0x870 net/wireless/wext-compat.c:792
 ioctl_standard_call+0xcb/0x1b0 net/wireless/wext-core.c:1042
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xee/0x410 net/wireless/wext-core.c:1013
 wext_handle_ioctl+0x10f/0x1d0 net/wireless/wext-core.c:1074
 sock_ioctl+0x159/0x7f0 net/socket.c:1300
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f78f9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6f79eb1028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6f79215fa0 RCX: 00007f6f78f9c799
RDX: 0000200000000040 RSI: 0000000000008b04 RDI: 0000000000000003
RBP: 00007f6f79032c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6f79216038 R14: 00007f6f79215fa0 R15: 00007ffe8253b778
 </TASK>


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

