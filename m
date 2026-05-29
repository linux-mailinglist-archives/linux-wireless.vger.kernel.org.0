Return-Path: <linux-wireless+bounces-37086-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOOVIB3vGGo/pAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37086-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 03:42:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95915FC12A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 03:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2073C307AE67
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952035F61F;
	Fri, 29 May 2026 01:41:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B635F18B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018888; cv=none; b=joOVlSCsEG6GYSTvOInSPHicoALoq90jnXf3ELwc1ksbRQcxM6k9lChp1w9AWpWx3PMurOb3EENgMDKbjxCwOad6jOKCaXV/jXreJx2IDth3yzPNgBpoXneHm+rtrUM38u0FbywsbnXW+Jy+/nJCfb0casxZvckdy1oQIjXRRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018888; c=relaxed/simple;
	bh=120bVSQLdPnl7gzjI00muoHs/i0ZIQoj5jR62It2T+0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gZ30Y31ZgLrWE/IIURk1IS3Xw+WunIDfYYWlOhWX2cSfakbI65GD8n8NpctsUKiZXigKK1DLNEKaNKujLkuv22cB/3bqUMJGr3QK/HPScStT1AujK0P9FobRov/98P25xIYmWB+NnnwZB44qhehMkcN7kxPrOaCkr3MUr54s1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69d874805edso8791079eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 18:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780018885; x=1780623685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBCnZ43C3H+9ncA/RoRecjFYPKsKHr1k7V623+sXjgo=;
        b=CRpO+n2YRlZyEM42Nhr7hDXCxyZZomFkMAyxn4M+FIReDUgZ6LdF39FWIYW1RTnrYr
         tQRZwG2TMG9xQhazGLOTHBaAaoh9x5pWejWCLfT4QjI1liF+FemuoUQcE+mMMHKAm07p
         f/hPl8tqzBVWi7/dFUbvMQNl1G5J9S6VllZBg04pei5eBh3Ihslv1KjrkxIi5QaV6A3y
         9VOYlSmgM4h6luubcAh/p55xmp+iXtREV7N0dtxneYMgqTx599mmtRN5lUqI++dNIywm
         HnjW//PM4ygnHdG/NTRR7bz/5VmyVfBK6EEd9d58iaJUmjAwWuVhf1GRIbgXRu+k8aXQ
         eMlw==
X-Forwarded-Encrypted: i=1; AFNElJ/JwrkaPdenKoXA+ORgYSSlXbIg2QxKfc2HoprRWyG2KXOl91w3Vn6QYWuMewh4iGdmLmlNkurESvLo9TORaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB93Wb1u3ecwsHVD1FBOyAzGJuLKaV+nUU6Z1EeGa3AIghWa3V
	QasTsxsu5ZoSVoSpYs6cb8W8xbewEee9PBa1zqfoWevssJfPDdc812vt6L4PK28Z/f3i6yWjOhz
	d5u3ojUgC1l5LUUkTV/uIlJYUzYp7pi7pEe05/YOos6ow2RrwHZIkgAqI6h8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168d:b0:69d:9e9d:b000 with SMTP id
 006d021491bc7-69e03ef9ad8mr519546eaf.23.1780018885631; Thu, 28 May 2026
 18:41:25 -0700 (PDT)
Date: Thu, 28 May 2026 18:41:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a18eec5.9a649fcc.180209.0002.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_link_info_changed (3)
From: syzbot <syzbot+c4686c3eb8b64032618f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e327ee9a867dd6b9];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37086-lists,linux-wireless=lfdr.de,c4686c3eb8b64032618f];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url]
X-Rspamd-Queue-Id: E95915FC12A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    4cbfe4502e3d Merge tag 'v7.1-rc5-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bb6d96580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e327ee9a867dd6b9
dashboard link: https://syzkaller.appspot.com/bug?extid=c4686c3eb8b64032618f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4cbfe450.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae30bc5ef3ba/vmlinux-4cbfe450.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2547601acb10/bzImage-4cbfe450.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4686c3eb8b64032618f@syzkaller.appspotmail.com

------------[ cut here ]------------
changed & (BSS_CHANGED_BEACON | BSS_CHANGED_BEACON_ENABLED) && sdata->vif.type != NL80211_IFTYPE_AP && sdata->vif.type != NL80211_IFTYPE_ADHOC && sdata->vif.type != NL80211_IFTYPE_MESH_POINT && sdata->vif.type != NL80211_IFTYPE_OCB
WARNING: net/mac80211/driver-ops.c:468 at drv_link_info_changed+0x583/0x880 net/mac80211/driver-ops.c:468, CPU#3: syz.5.1844/11254
Modules linked in:
CPU: 3 UID: 0 PID: 11254 Comm: syz.5.1844 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:drv_link_info_changed+0x583/0x880 net/mac80211/driver-ops.c:468
Code: 00 48 89 74 24 10 e8 3c 3d 0f f7 48 8d 3d 75 29 ef 05 48 8b 74 24 10 44 89 f2 67 48 0f b9 3a e9 ae fc ff ff e8 1e 3d 0f f7 90 <0f> 0b 90 e9 bf fe ff ff e8 10 3d 0f f7 90 0f 0b 90 e9 b1 fe ff ff
RSP: 0018:ffffc900065bee48 EFLAGS: 00010287
RAX: 000000000000096f RBX: ffff8880277d4e40 RCX: ffffc90007392000
RDX: 0000000000080000 RSI: ffffffff8af974c2 RDI: ffff88802aa42500
RBP: 0000000000000200 R08: 0000000000000005 R09: 000000000000000b
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88805f010f20 R14: 0000000000000200 R15: ffff8880277d6b78
FS:  00007fae699f66c0(0000) GS:ffff8880d666a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000044d79000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_link_info_change_notify+0x24b/0x3c0 net/mac80211/main.c:427
 ieee80211_offchannel_stop_vifs+0x328/0x5c0 net/mac80211/offchannel.c:122
 ieee80211_start_sw_scan net/mac80211/scan.c:583 [inline]
 __ieee80211_start_scan+0xfb6/0x1af0 net/mac80211/scan.c:882
 ieee80211_scan+0x4f8/0x6e0 net/mac80211/cfg.c:3343
 rdev_scan+0x148/0x370 net/wireless/rdev-ops.h:467
 cfg80211_scan+0x4dd/0x5d0 net/wireless/scan.c:1077
 cfg80211_conn_scan+0x70e/0xfc0 net/wireless/sme.c:134
 cfg80211_sme_connect net/wireless/sme.c:629 [inline]
 cfg80211_connect+0x17fe/0x1fe0 net/wireless/sme.c:1527
 nl80211_connect+0x17d3/0x2260 net/wireless/nl80211.c:13745
 genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae6b79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae699f6028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fae6ba15fa0 RCX: 00007fae6b79ce59
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fae6b832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae6ba16038 R14: 00007fae6ba15fa0 R15: 00007ffc87f56808
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

