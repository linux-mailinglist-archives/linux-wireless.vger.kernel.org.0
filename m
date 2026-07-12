Return-Path: <linux-wireless+bounces-38915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iHKcOTEIVGrBhAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 23:33:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAF0746060
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 23:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38915-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38915-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7AE3006B36
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E4376BD5;
	Sun, 12 Jul 2026 21:33:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B035376481
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 21:33:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892015; cv=none; b=fztu2PNgLxWw+T4OYGIJctoQZ4RG57LxiLPtdsC2VbhCbwCy7czmf/7MQq/F1TII7L626AQEKm6Xddm2aZdNWXM6HJOwf2O4hg3J0/frfZh+nyeo58t96NefMIPz+nccG16RjEY7Rph32+pZ9SgW0zEcFCjCgsibkFNo2xgNf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892015; c=relaxed/simple;
	bh=ABPQvh8Ml3ofcAdy+/1roKPMeQ/1mR7OcWX60LuK5Nc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lpu5VbTSXRuy93CSVV4tf9ChvcNuplv2Yf9XdhxhmMfGe2T7KN68u/FkVnM6rS61iwEh+PHvvk34bxfqeX4H4frU+Uv6HD1LlVQ0S6sjIfdjydTCxGxex8dfwPzt4oeUDmee5DOvTA950lhQTP1jNJA9CAVkCVLSROgw+IF9g2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-487059fb570so4140562b6e.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 14:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892012; x=1784496812;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+hfomJ6472gj6Pfby6eQmV5ua2lA/ah/e0u7s2LKHs=;
        b=qEb9JD6WDp0MCSgKsfnPKeGXNjwz2emR3528cjsUHrCRg6eZ4Ulp/fcOrBp/IAqC+5
         4GqKm6IG4K9iyhfiP7We+/NDjA7FvaD07SmuD1yWtsLhei7g2df/7t83IP8OpUxR/f4N
         CPYH4p2RSjYY9gbw23PdC7g/cOAA8umK1/53TSJ9lWMDCFnLxunIYIwV8u/V5vvEJoAA
         wRcTcYAgnA2OeNerLdFwTgC+jFCHm0nPROHFq748CihJBJzhaKnYWwWtRC4XIHC8JqS5
         b0GBwmUr07bc14Ssp3d89v3q8waPlTEPcTFH9wish94bME2RRYioNJPgCb1b2Zzn/yJP
         DMAw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZNhoy+H7pcRsjIlJjNLEQecMO1+DKKx36cUYmWh4tB/92LmhvAZTfnKMTCHl8kJ1nuEXEj7ygKus9BVKYsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ye1mcLhm8M6PGUNC08oNB1VTn01zEMYwsaWaGY0of8HvZCzN
	hyYhjhu3Hz3ST6OkovMh0XqGA+P5O0q2mTvjaq5c2LXixkzZNFAnyak81lF6hM7gbXm8Yyuu8Xc
	6NzhibE0u4Hs8y8qOrWp0x8Dd37tIBKwHhCG1Na6V1MvndXKIo8HrSlp+oGc=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3442:b0:49b:c387:36e0 with SMTP id
 5614622812f47-4a42af5ff6dmr4119582b6e.23.1783892012717; Sun, 12 Jul 2026
 14:33:32 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:33:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a54082c.574492cf.19a3b.0015.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_encrypt_tx_skb
From: syzbot <syzbot+b6ce23950fd636e6efb6@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=20c9876b0f77b546];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38915-lists,linux-wireless=lfdr.de,b6ce23950fd636e6efb6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EAF0746060

Hello,

syzbot found the following issue on:

HEAD commit:    61c03dfde854 Merge tag 'ntfs-for-7.2-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116470b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c9876b0f77b546
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ce23950fd636e6efb6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b85432580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162e20b9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-61c03dfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e06f2aec094f/vmlinux-61c03dfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a85168c67732/bzImage-61c03dfd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ce23950fd636e6efb6@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fb87e825fac R14: 00007fb87e825fa0 R15: 00007fb87e825fa0
 </TASK>
------------[ cut here ]------------
res != TX_CONTINUE
WARNING: net/mac80211/tx.c:5460 at ieee80211_encrypt_tx_skb+0x3e4/0x3f0 net/mac80211/tx.c:5460, CPU#0: syz.0.17/5534
Modules linked in:
CPU: 0 UID: 0 PID: 5534 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ieee80211_encrypt_tx_skb+0x3e4/0x3f0 net/mac80211/tx.c:5460
Code: ff ff ff e8 9e 1a 7a f6 90 0f 0b 90 e9 0b ff ff ff e8 90 1a 7a f6 90 0f 0b 90 bb ea ff ff ff e9 20 ff ff ff e8 7d 1a 7a f6 90 <0f> 0b 90 eb eb e8 d2 bb 84 00 66 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003526a20 EFLAGS: 00010293
RAX: ffffffff8b4c6813 RBX: 0000000000000000 RCX: ffff88803a6f0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003526b90 R08: ffff8880129723cf R09: 0000000000000000
R10: ffff8880129723c0 R11: ffffed100252e47a R12: ffffc90003526a68
R13: 1ffff920006a4d48 R14: dffffc0000000000 R15: 0000000000000001
FS:  00005555940ec500(0000) GS:ffff88808c54d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003700 CR3: 0000000012968000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mac80211_hwsim_tx+0x1de/0x2500 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2116
 ieee80211_hwsim_wake_tx_queue+0xd4/0x150 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2291
 drv_wake_tx_queue net/mac80211/driver-ops.h:1394 [inline]
 schedule_and_wake_txq net/mac80211/driver-ops.h:1401 [inline]
 ieee80211_queue_skb+0x1923/0x22c0 net/mac80211/tx.c:1674
 __ieee80211_xmit_fast+0x8ea/0x2160 net/mac80211/tx.c:3785
 ieee80211_xmit_fast net/mac80211/tx.c:3853 [inline]
 __ieee80211_subif_start_xmit+0x12af/0x1690 net/mac80211/tx.c:4367
 ieee80211_tx_control_port+0xaba/0xcd0 net/mac80211/tx.c:6592
 rdev_tx_control_port net/wireless/rdev-ops.h:783 [inline]
 nl80211_tx_control_port+0x604/0x990 net/wireless/nl80211.c:18403
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb87e59de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca021cc48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb87e825fa0 RCX: 00007fb87e59de59
RDX: 0000000000000800 RSI: 0000200000003700 RDI: 0000000000000003
RBP: 00007ffca021ccb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fb87e825fac R14: 00007fb87e825fa0 R15: 00007fb87e825fa0
 </TASK>


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

