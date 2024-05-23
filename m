Return-Path: <linux-wireless+bounces-7991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8F8CCE20
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD941F21A32
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4C13C9D4;
	Thu, 23 May 2024 08:22:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318451016
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452547; cv=none; b=VTf6GYxTn5Y2gwI/q4F9Bh10s6fJD3X1qN0NCFVphz7X1HNOYANxfrrWF2Ue8v5sTniDCKCYbtHEeqUULozj9awQZoJUGf0Ic/uDzmTdxBIRGPeo/v0TX4kk6n3gmR+/S9V/2GmHghnKn8/cgMpMm1MSZ0HSvTo6Z+dF2IOtMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452547; c=relaxed/simple;
	bh=qVsCkBHtqJCtLpc7l94wYVTdZ3t3841mh8O3D4E2Og8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVA0HTY8aZhnvKZ4aY2z8/FbJPwd0qtEj6+NDP2toGfkINoBYODb2I08ySLFmaSMi7EdqxXZ8BZBuZ2rc2k6X6/cHqb2jOZaEBWj3JvMMniKwCPrAL3DSgSPdtK0TdNni5NE3yq12cMMGv8BFcC1Bt0HhbG+O5xafTcLAGyuMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44N8MAC50719298, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44N8MAC50719298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 16:22:10 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 16:22:10 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 23 May
 2024 16:22:10 +0800
From: <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: fix NULL dereference at band check in starting tx ba session
Date: Thu, 23 May 2024 16:22:00 +0800
Message-ID: <20240523082200.15544-1-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In MLD connection, link_data/link_conf are dynamically allocated. They
don't point to vif->bss_conf. So, there will be no chanreq assigned to
vif->bss_conf and then the chan will be NULL. To get deflink's chanreq,
we change the code to access vif->link_conf with deflink's link id.

This way should also work in non-MLD connection, because non-MLD deflink
link id should be 0 and non-MLD link_conf[0] will point to vif->bss_conf.

Crash log (with rtw89 version under MLO development):
[ 9890.526087] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 9890.526102] #PF: supervisor read access in kernel mode
[ 9890.526105] #PF: error_code(0x0000) - not-present page
[ 9890.526109] PGD 0 P4D 0
[ 9890.526114] Oops: 0000 [#1] PREEMPT SMP PTI
[ 9890.526119] CPU: 2 PID: 6367 Comm: kworker/u16:2 Kdump: loaded Tainted: G           OE      6.9.0 #1
[ 9890.526123] Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB3WW (2.73 ) 11/28/2018
[ 9890.526126] Workqueue: phy2 rtw89_core_ba_work [rtw89_core]
[ 9890.526203] RIP: 0010:ieee80211_start_tx_ba_session (net/mac80211/agg-tx.c:618 (discriminator 1)) mac80211
[ 9890.526279] Code: f7 e8 d5 93 3e ea 48 83 c4 28 89 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 49 8b 84 24 e0 f1 ff ff 48 8b 80 90 1b 00 00 <83> 38 03 0f 84 37 fe ff ff bb ea ff ff ff eb cc 49 8b 84 24 10 f3
All code
========
   0:	f7 e8                	imul   %eax
   2:	d5                   	(bad)
   3:	93                   	xchg   %eax,%ebx
   4:	3e ea                	ds (bad)
   6:	48 83 c4 28          	add    $0x28,%rsp
   a:	89 d8                	mov    %ebx,%eax
   c:	5b                   	pop    %rbx
   d:	41 5c                	pop    %r12
   f:	41 5d                	pop    %r13
  11:	41 5e                	pop    %r14
  13:	41 5f                	pop    %r15
  15:	5d                   	pop    %rbp
  16:	c3                   	retq
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	49 8b 84 24 e0 f1 ff 	mov    -0xe20(%r12),%rax
  22:	ff
  23:	48 8b 80 90 1b 00 00 	mov    0x1b90(%rax),%rax
  2a:*	83 38 03             	cmpl   $0x3,(%rax)		<-- trapping instruction
  2d:	0f 84 37 fe ff ff    	je     0xfffffffffffffe6a
  33:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
  38:	eb cc                	jmp    0x6
  3a:	49                   	rex.WB
  3b:	8b                   	.byte 0x8b
  3c:	84 24 10             	test   %ah,(%rax,%rdx,1)
  3f:	f3                   	repz

Code starting with the faulting instruction
===========================================
   0:	83 38 03             	cmpl   $0x3,(%rax)
   3:	0f 84 37 fe ff ff    	je     0xfffffffffffffe40
   9:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
   e:	eb cc                	jmp    0xffffffffffffffdc
  10:	49                   	rex.WB
  11:	8b                   	.byte 0x8b
  12:	84 24 10             	test   %ah,(%rax,%rdx,1)
  15:	f3                   	repz
[ 9890.526285] RSP: 0018:ffffb8db09013d68 EFLAGS: 00010246
[ 9890.526291] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9308e0d656c8
[ 9890.526295] RDX: 0000000000000000 RSI: ffffffffab99460b RDI: ffffffffab9a7685
[ 9890.526300] RBP: ffffb8db09013db8 R08: 0000000000000000 R09: 0000000000000873
[ 9890.526304] R10: ffff9308e0d64800 R11: 0000000000000002 R12: ffff9308e5ff6e70
[ 9890.526308] R13: ffff930952500e20 R14: ffff9309192a8c00 R15: 0000000000000000
[ 9890.526313] FS:  0000000000000000(0000) GS:ffff930b4e700000(0000) knlGS:0000000000000000
[ 9890.526316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9890.526318] CR2: 0000000000000000 CR3: 0000000391c58005 CR4: 00000000001706f0
[ 9890.526321] Call Trace:
[ 9890.526324]  <TASK>
[ 9890.526327] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[ 9890.526335] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
[ 9890.526340] ? page_fault_oops (arch/x86/mm/fault.c:713)
[ 9890.526347] ? search_module_extables (kernel/module/main.c:3256 (discriminator 3))
[ 9890.526353] ? ieee80211_start_tx_ba_session (net/mac80211/agg-tx.c:618 (discriminator 1)) mac80211

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 net/mac80211/agg-tx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 21d55dc539f6..41f02d0baed7 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -615,9 +615,21 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		 "Requested to start BA session on reserved tid=%d", tid))
 		return -EINVAL;
 
-	if (!pubsta->deflink.ht_cap.ht_supported &&
-	    sta->sdata->vif.bss_conf.chanreq.oper.chan->band != NL80211_BAND_6GHZ)
-		return -EINVAL;
+	if (!pubsta->deflink.ht_cap.ht_supported) {
+		struct ieee80211_vif *vif = &sta->sdata->vif;
+		struct ieee80211_bss_conf *bss_conf;
+
+		rcu_read_lock();
+
+		bss_conf = rcu_dereference(vif->link_conf[pubsta->deflink.link_id]);
+		if (unlikely(!bss_conf) ||
+		    bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+
+		rcu_read_unlock();
+	}
 
 	if (WARN_ON_ONCE(!local->ops->ampdu_action))
 		return -EINVAL;
-- 
2.39.0


