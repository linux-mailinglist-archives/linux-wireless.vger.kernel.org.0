Return-Path: <linux-wireless+bounces-217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599577FD670
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B01C208FB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8221D55B;
	Wed, 29 Nov 2023 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cOH9FW2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13395D48;
	Wed, 29 Nov 2023 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701260270; bh=u/kJJE/vqyJTMGmEfzpylHMc8Ysza3g9cZpru6QlCt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOH9FW2KbVieeZs21foehTn2sQypjF/MeBlr4OFAgzMZv7rmtvt0K+yT6Fc1XcmFN
	 gF99K9qDst7ccSZCEH0/BvF1ASdzIqjxXOdmVgOjvCLnUuxM3rLGLb7o+178bvhVgi
	 4a270iyQQ7XWEhkbrUZw7buNgjQxezbot0l1aClo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 46E1989A; Wed, 29 Nov 2023 20:17:46 +0800
X-QQ-mid: xmsmtpt1701260266tji7ldykr
Message-ID: <tencent_DE67FF86DB92ED465489A36ECD2EDDCC8C06@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIew+Fm4chwnma/C0iyoMaFP3nfP6kENcQxQTB+XEQKuQqDbnMI5h
	 fWSDST1Rcuh/BFu5Bi62sqczUSoUm3S9Gw65b1jUnKHdYzePvQjvgUJ2nS7mm4kV5nN1IwKWNtP/
	 rHRLoaxT8jsVbFyDBdKfLVyQd80W6zhcVcxeNayuyQLyB0djcZxTgDs3FOx6xFgLNnRIo4WWCRj8
	 G6k+KiAK3qn+6Tr6NxDUu3J4kq08p0GzgTvBAEEkbNDVgSoJ7yLMZR5jjtUuPO4NRQOa/2kkY53k
	 n1KNRW9JZOZtXNyEfZ3QydGnoTviZrsMARqE5stH7R2+G5JRDuVPpAkXBKGsWr/YFlfGsALYY5lM
	 OLQMOiVmQ7I/1Q/7ULlwZtZpBKT3z8yvr6Yme8UewWHneSi1I0CqTFfYZCXnaJixKR60rwL7dzR2
	 ERPXoknDOMu4AcCg5RAgSS/sKVcJlntBb1+okNN9np3xwkXZ2avgLxfILzDV9FLEPP+d4mDd1pKa
	 NyWxpq4jFHuwRHMBN9nLTXdXCjZI3rtxc8h3of2kgvepGl1D0qR5ecfAGnhNk/PJu8StwGfl28lQ
	 soYaU1+pHV9AFA/BUhq9kelxTelXi3NlKU8qcmw1soldrk3UKzFkHtiWpFZrL0mwV07XwPYoLJCn
	 Urj4ZdU3ohNsHsW39wSzPCdOoD82xCF2xTUTrRmiyyDdx457znILnYYD38mlNgl1ULAZKo6wxTSl
	 Z5YBUGamT79LsIWS1zFyPuoQOVWDrePyMQ9KP1CYisSsxekw88m6XmVXHf4+oIqpFw+NFBIEL2Gs
	 5J8daFDZNfxiu0cg3wPTS3rbXS5He/3JPPT1L6jSELKW0VA2D/GAFEQ60WeBD0lNmu/Hc5kG5pBX
	 FZiuEkjNTs6tt5PYBe8GFtHwEC5rurSJDRQXfSvNgh3vlL7JreqE20i+1GMc7pStkP2QHvlkBjOx
	 bLOSRYowIkkWmsiZPZWxOFAjr1aUEGzgEKgSGDdhGJvnh/9GAF2SogXPh6AdyO
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: johannes@sipsolutions.net
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	trix@redhat.com
Subject: [PATCH V2] wifi: mac80211: check if the existing link config remains unchanged
Date: Wed, 29 Nov 2023 20:17:47 +0800
X-OQ-MSGID: <20231129121746.4051185-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <52e6ba0affb1648edd3ffd25fb6d8199a39a2f51.camel@sipsolutions.net>
References: <52e6ba0affb1648edd3ffd25fb6d8199a39a2f51.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
It is inappropriate to make a link configuration change judgment on an 
non-existent and non new link.

[Fix]
Quickly exit when there is a existent link and the link configuration has not 
changed.

Fixes: b303835dabe0 ("wifi: mac80211: accept STA changes without link changes")
Reported-and-tested-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..d0b5a5dd7410 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1788,10 +1788,10 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					  lockdep_is_held(&local->hw.wiphy->mtx));
 
 	/*
-	 * If there are no changes, then accept a link that doesn't exist,
+	 * If there are no changes, then accept a link that exist,
 	 * unless it's a new link.
 	 */
-	if (params->link_id < 0 && !new_link &&
+	if (params->link_id >= 0 && !new_link &&
 	    !params->link_mac && !params->txpwr_set &&
 	    !params->supported_rates_len &&
 	    !params->ht_capa && !params->vht_capa &&
-- 
2.43.0


