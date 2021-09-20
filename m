Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8D4114C9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhITMq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 08:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234491AbhITMq6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 08:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBCFD60F43;
        Mon, 20 Sep 2021 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632141931;
        bh=C8I1JpKtvZaMK3X7BqL3ei8ypqOYKGvwikWlyiLYs/E=;
        h=From:To:Cc:Subject:Date:From;
        b=W1ZR5PVNcoMYdiaITwiCzRbsAgMuiSYXSp/3aNBb6LiXM2xLYzeaR2CRqVf6L63my
         k2JYxs20FEakmfLf5KbJq7X0420iruybxZXEq0p57L+PRvNtc1kn3bOaJA7R3M5q1d
         2gdGoDKM4Sjrl1eV6CeHaZJ5DfY3o12hTO72YjQ5/9Bj+Q7F5Cu/UBkHSBNUWFZd3L
         238DyDPPYkrzhSmZqMIrMNav0Q5BSs4rFCGqm/wnqgDuIEKBfPg3p/ZhF2aSXnQFNp
         CQSkkZbGXeBjmd8uXIxPhNzZwdbrNW8U0nntdq9mENiphLC/llPM/GK8jDI0ZFZsco
         2OSQtmCHZFyWQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        arend.vanspriel@broadcom.com
Subject: [PATCH v2 mac80211] mac80211: limit injected vht mcs/nss in ieee80211_parse_tx_radiotap
Date:   Mon, 20 Sep 2021 14:45:22 +0200
Message-Id: <c26c3f02dcb38ab63b2f2534cb463d95ee81bb13.1632141760.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Limit max values for vht mcs and nss in ieee80211_parse_tx_radiotap
routine in order to fix the following warning reported by syzbot:

WARNING: CPU: 0 PID: 10717 at include/net/mac80211.h:989 ieee80211_rate_set_vht include/net/mac80211.h:989 [inline]
WARNING: CPU: 0 PID: 10717 at include/net/mac80211.h:989 ieee80211_parse_tx_radiotap+0x101e/0x12d0 net/mac80211/tx.c:2244
Modules linked in:
CPU: 0 PID: 10717 Comm: syz-executor.5 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ieee80211_rate_set_vht include/net/mac80211.h:989 [inline]
RIP: 0010:ieee80211_parse_tx_radiotap+0x101e/0x12d0 net/mac80211/tx.c:2244
RSP: 0018:ffffc9000186f3e8 EFLAGS: 00010216
RAX: 0000000000000618 RBX: ffff88804ef76500 RCX: ffffc900143a5000
RDX: 0000000000040000 RSI: ffffffff888f478e RDI: 0000000000000003
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000100
R10: ffffffff888f46f9 R11: 0000000000000000 R12: 00000000fffffff8
R13: ffff88804ef7653c R14: 0000000000000001 R15: 0000000000000004
FS:  00007fbf5718f700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2de23000 CR3: 000000006a671000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 ieee80211_monitor_select_queue+0xa6/0x250 net/mac80211/iface.c:740
 netdev_core_pick_tx+0x169/0x2e0 net/core/dev.c:4089
 __dev_queue_xmit+0x6f9/0x3710 net/core/dev.c:4165
 __bpf_tx_skb net/core/filter.c:2114 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2139 [inline]
 __bpf_redirect+0x5ba/0xd20 net/core/filter.c:2162
 ____bpf_clone_redirect net/core/filter.c:2429 [inline]
 bpf_clone_redirect+0x2ae/0x420 net/core/filter.c:2401
 bpf_prog_eeb6f53a69e5c6a2+0x59/0x234
 bpf_dispatcher_nop_func include/linux/bpf.h:717 [inline]
 __bpf_prog_run include/linux/filter.h:624 [inline]
 bpf_prog_run include/linux/filter.h:631 [inline]
 bpf_test_run+0x381/0xa30 net/bpf/test_run.c:119
 bpf_prog_test_run_skb+0xb84/0x1ee0 net/bpf/test_run.c:663
 bpf_prog_test_run kernel/bpf/syscall.c:3307 [inline]
 __sys_bpf+0x2137/0x5df0 kernel/bpf/syscall.c:4605
 __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4689
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9

Reported-by: syzbot+0196ac871673f0c20f68@syzkaller.appspotmail.com
Fixes: 646e76bb5daf4 ("mac80211: parse VHT info in injected frames")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- set 11 max allowed mcs
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2d1193ed3eb5..5bbd81c034f5 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2209,7 +2209,11 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 			}
 
 			vht_mcs = iterator.this_arg[4] >> 4;
+			if (vht_mcs > 11)
+				vht_mcs = 0;
 			vht_nss = iterator.this_arg[4] & 0xF;
+			if (!vht_nss || vht_nss > 8)
+				vht_nss = 1;
 			break;
 
 		/*
-- 
2.31.1

