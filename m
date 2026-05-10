Return-Path: <linux-wireless+bounces-36179-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOfnJVX/AGolPgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36179-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 23:57:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 067795069A9
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 23:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C8F930073CA
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ADC34CFBA;
	Sun, 10 May 2026 21:57:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074033EAEC
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778450256; cv=none; b=nIJgxXcOv0mxgmgFnYHgx0noJJO+G0miSep4iBDAV3pGRI61KARRAIsth0fpMgmEEBmMMHvkOjpK5t4XOX4gRGrn3Ed+YQsyiwx/z2F1/7WjVreFN53s19gnWEl4LwDc/v8nhyNwUb0POd8BXew/GTfxsYpbCCHPVvXqMG6Z3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778450256; c=relaxed/simple;
	bh=TRo/27K1NjP2wNlz7gI3GKSwraU84oOs4e6O3VxvVXI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O5b9VG9H5WENFUU+h6XuaY/LlvZ8lbJAq1tnUjKS6ubg/D/MJdFL6l1XPjf5LA5dq183fou8O8DWGF4fmls3XVgP99Xm/YuShwTgdDxbQtI/33O6CotJpIBHlhDpHfyUwwwTBdVtoUTzs2jcudvtRgDOerClZSnKRV0fa7USr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7deb9de359bso6011612a34.3
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 14:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778450254; x=1779055054;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5zz8JJ6yN1hwedf89sUkMHjvnyxInLqXs9nvE/Ihto=;
        b=pSxDkE4jJm+4gIHKU29jezCxzxcnSBUf4Wzg+QFCR64uRVSxhoVKryhkeqn+aVKaVo
         iD61qsYHB3CWvaAZPZLUFub/ZHJj70J4w6hPcSviSOIxALCp7fpYqUj1F0P0Cyd2My1+
         cLnNE9ZjZf3b+gKp41P0gpPrs7AKK++bIGxZIznU5golGpdbwrC879rnniaZ3QU8tKSB
         U7Fr0kll+pEVQPQ6rarYgemz4k5itrpdco+UCWDAlMk3sRRMQXdQHYOpkxtwSri7Ru4T
         mlvg9B7ZFP/rvjmUkNE5wjHpwYSt5GEZwMyk2JuY84IjsFt0Kja2S7fmGMhbtA8UO6pa
         yong==
X-Forwarded-Encrypted: i=1; AFNElJ8ndJOHHEkdsIOxcLJyZgIJDmvZWObyNhp9LGIHflV69vbRblXaWn62TUrxs/6nSmRauIVa6VbCF1IPBCtovw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/SA3F28S7cHMLW0BTbdb38jWdzcGSPZDS+AhQ8l67gT0Nz1B
	Yibav2zhcf6Z9Q+mX8TfXRue/QsxOQQdX94MgiyNrTLxSz0Xfn2zpgoIEaVzF4pU+NbheyGtMQB
	REA28EEs2Ty9P36HbNVLq2H8o7Krwi3KUyxx3Jpm7vJIcEHhFp/ZgaK5K0t8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:883:b0:696:8ccc:5588 with SMTP id
 006d021491bc7-69998d4534bmr12723017eaf.42.1778450254413; Sun, 10 May 2026
 14:57:34 -0700 (PDT)
Date: Sun, 10 May 2026 14:57:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a00ff4e.170a0220.1c0296.021e.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_sta_current_bw
From: syzbot <syzbot+e2a0da81361722f4df3b@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 067795069A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36179-lists,linux-wireless=lfdr.de,e2a0da81361722f4df3b];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url,storage.googleapis.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2281958e6007 Merge tag 'wireless-next-2026-05-06' of https..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1513e696580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=e2a0da81361722f4df3b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4df17f60254b/disk-2281958e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e93157edd25/vmlinux-2281958e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60dbf6a0a81c/bzImage-2281958e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2a0da81361722f4df3b@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: ./include/net/mac80211.h:8114 at ieee80211_chan_width_to_rx_bw include/net/mac80211.h:8114 [inline], CPU#1: syz.4.4769/22510
WARNING: ./include/net/mac80211.h:8114 at ieee80211_sta_current_bw_tx_to_sta net/mac80211/sta_info.c:3719 [inline], CPU#1: syz.4.4769/22510
WARNING: ./include/net/mac80211.h:8114 at ieee80211_sta_current_bw+0x36d/0x510 net/mac80211/sta_info.c:3745, CPU#1: syz.4.4769/22510
Modules linked in:
CPU: 1 UID: 0 PID: 22510 Comm: syz.4.4769 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:ieee80211_chan_width_to_rx_bw include/net/mac80211.h:8114 [inline]
RIP: 0010:ieee80211_sta_current_bw_tx_to_sta net/mac80211/sta_info.c:3719 [inline]
RIP: 0010:ieee80211_sta_current_bw+0x36d/0x510 net/mac80211/sta_info.c:3745
Code: 00 00 00 eb 49 41 83 fe 05 74 30 41 83 fe 0d 75 13 e8 47 8f af f6 b8 04 00 00 00 eb 31 e8 3b 8f af f6 eb 28 e8 34 8f af f6 90 <0f> 0b 90 eb 1d e8 29 8f af f6 b8 02 00 00 00 eb 13 e8 1d 8f af f6
RSP: 0018:ffffc90006f4eed8 EFLAGS: 00010283
RAX: ffffffff8b161cfc RBX: 1ffff1100d1da030 RCX: 0000000000080000
RDX: ffffc9000e5d2000 RSI: 0000000000000e31 RDI: 0000000000000e32
RBP: 0000000000000004 R08: ffff888054ad5c40 R09: 0000000000000007
R10: 000000000000000d R11: 0000000000000002 R12: ffff888068ed0180
R13: dffffc0000000000 R14: 0000000000000007 R15: 0000000000000000
FS:  00007fe58f5f66c0(0000) GS:ffff888125389000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2c8823 CR3: 0000000038486000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_chan_bw_change+0x459/0x740 net/mac80211/chan.c:719
 _ieee80211_recalc_chanctx_min_def net/mac80211/chan.c:758 [inline]
 ieee80211_recalc_chanctx_min_def+0x36/0x70 net/mac80211/chan.c:770
 ieee80211_recalc_min_chandef+0x491/0x580 net/mac80211/util.c:2501
 sta_info_insert_finish net/mac80211/sta_info.c:946 [inline]
 sta_info_insert_rcu+0x15da/0x26b0 net/mac80211/sta_info.c:1029
 sta_info_insert+0x16/0xc0 net/mac80211/sta_info.c:1034
 ieee80211_add_station+0x4c7/0x710 net/mac80211/cfg.c:2666
 rdev_add_station+0xfc/0x290 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1cab/0x2130 net/wireless/nl80211.c:9490
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe59139cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe58f5f6028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe591616090 RCX: 00007fe59139cdd9
RDX: 0000000000000000 RSI: 0000200000001080 RDI: 0000000000000006
RBP: 00007fe591432d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe591616128 R14: 00007fe591616090 R15: 00007fff2b0f3978
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

