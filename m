Return-Path: <linux-wireless+bounces-188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05ED7FCEB2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 07:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AAB216AB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15279FC;
	Wed, 29 Nov 2023 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P3TZsc+V"
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 822 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 22:02:31 PST
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717671BD1
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 22:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701237749; bh=iigzMruFL8JB1VSN2SQ5QO5Wt23JSaxW1OQ0ZKCxjpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P3TZsc+VQLTJQ76xUjRJPwa0xzlRMsJ9medijdFuMq0fGRLWVUtV2+R5Q85ZnFKTW
	 uM6WyuR2igXV4UPiQZuxDpLkNmpiHeqMRFZmATN7CMZ0xzfONDzsUmbgBdan0xDeQy
	 yNzo8dIENITWh9vENkXJl2/5B2vvLOQMWnVX2Gis=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id C29B8472; Wed, 29 Nov 2023 13:48:41 +0800
X-QQ-mid: xmsmtpt1701236921tggzxy8lx
Message-ID: <tencent_0CCA1979CFA30DC8A5CF8DDC92365DCE5D07@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVc62/Ykxy0RdPm2juQUBTa86Xj+xj1qNuZ76xh3F/p/MSevvDhP
	 A8JnwBm2hsne7La7kMP7a+OGGCLikSh8mp1Jl94aIRzSAp5WnSZtGLgF4CP/G+Lx1egZk0+eAyx+
	 3GOI5rGFieBuRjhU7nGdJKTq8l+BQknTgJBIeoW+4jAxM7HhQapRKZGJRe3FQZEWn9YtEfyRBg5M
	 uPytvG1tuRJ3Qe3HZ8/ZuK7ITf3qtwkAW41+HP2k1EYvaCrORWjRbF0wG0Dp21sWGhO+cJTCl9Bb
	 t+iE9YZc0hj5a4QBBwBvQpetONnaMbyiHNf3LHS1hRcLx1yDznUf8HNafyrY6FLQHMFgYbdBCYkX
	 SCemkTWEU1BKNz+9lYbVndNBUhZ9NoKExk/jl+zPI2HOEh3T5/kJJkwgwGM+IZrgLu9vay3SyZbn
	 cxacRlJBfKvVLNS7leRioTDWuetPa6lZBrsKOKVULA9QJ5Nw6YMbo6rdSQKy2JTTWW971bN/dLMs
	 WnQr4ckIxKT4TMSXsxJHuaSeru7pO76T+oSvtCIJMEIT5vKtFwL9232Q8FOYzg2JvhS9wvS3+hYS
	 grJZanJYUSMHj3g29+U6Y5NQ/VQv6yLZZ5CNuSTJhI0/QbFefivTCiACOiL8XBEkgNOtpslYddF+
	 M7tHv66lpOK1O9oh1K6FbOsqAyQD8r1MtzzZTXjThw2fyILtl7/DaGHGCcf7D2FS+SV+6QGoOAhR
	 4KODXmpMD8zDyYiozBULm+X2Hue/hrmdf54FeRpVjiVwrvFO7RYblVsvTnTpsm3m0X7aj1Gsme8q
	 vLFzNfEN8ZAqXmAlmG9lVfU6tRGQAYQeEisDVwzoEbM+6u3pwV5gtL5j9ENafJ0sIV6Wn8d23ASV
	 k/zRhCYYGdS4fgyfpPyKs7k0kVLNy4XO5jB4W1HCkiKa2ip0iX++ja9xl4+92m6WoCDnPVRjgA
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	trix@redhat.com
Subject: [PATCH] wifi: mac80211: sband's null check should precede params
Date: Wed, 29 Nov 2023 13:48:42 +0800
X-OQ-MSGID: <20231129054841.3686944-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
References: <000000000000efc64705ff8286a1@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

[Syz report]
WARNING: CPU: 1 PID: 5067 at net/mac80211/rate.c:48 rate_control_rate_init+0x540/0x690 net/mac80211/rate.c:48
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor413 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:rate_control_rate_init+0x540/0x690 net/mac80211/rate.c:48
Code: 48 c7 c2 00 46 0c 8c be 08 03 00 00 48 c7 c7 c0 45 0c 8c c6 05 70 79 0b 05 01 e8 1b a0 6f f7 e9 e0 fd ff ff e8 61 b3 8f f7 90 <0f> 0b 90 e9 36 ff ff ff e8 53 b3 8f f7 e8 5e 0b 78 f7 31 ff 89 c3
RSP: 0018:ffffc90003c57248 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888016bc4000 RCX: ffffffff89f7d519
RDX: ffff888076d43b80 RSI: ffffffff89f7d6df RDI: 0000000000000005
RBP: ffff88801daaae20 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888020030e20 R15: ffff888078f08000
FS:  0000555556b94380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000076d22000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sta_apply_auth_flags.constprop.0+0x4b7/0x510 net/mac80211/cfg.c:1674
 sta_apply_parameters+0xaf1/0x16c0 net/mac80211/cfg.c:2002
 ieee80211_add_station+0x3fa/0x6c0 net/mac80211/cfg.c:2068
 rdev_add_station net/wireless/rdev-ops.h:201 [inline]
 nl80211_new_station+0x13ba/0x1a70 net/wireless/nl80211.c:7603
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

[Analysis]
When ieee80211_get_link_sband() fails to find a valid sband and first checks 
for params in sta_link_apply_parameters(), it will return 0 due to new_link 
being 0, which will lead to an incorrect process after sta_apply_parameters().

[Fix]
First obtain sband and perform a non null check before checking the params.

Fixes: b303835dabe0 ("wifi: mac80211: accept STA changes without link changes")
Reported-and-tested-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/mac80211/cfg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..8012dcdbcb5f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1787,6 +1787,13 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		rcu_dereference_protected(sta->link[link_id],
 					  lockdep_is_held(&local->hw.wiphy->mtx));
 
+	if (!link || !link_sta)
+		return -EINVAL;
+
+	sband = ieee80211_get_link_sband(link);
+	if (!sband)
+		return -EINVAL;
+
 	/*
 	 * If there are no changes, then accept a link that doesn't exist,
 	 * unless it's a new link.
@@ -1799,13 +1806,6 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	    !params->opmode_notif_used)
 		return 0;
 
-	if (!link || !link_sta)
-		return -EINVAL;
-
-	sband = ieee80211_get_link_sband(link);
-	if (!sband)
-		return -EINVAL;
-
 	if (params->link_mac) {
 		if (new_link) {
 			memcpy(link_sta->addr, params->link_mac, ETH_ALEN);
-- 
2.43.0


