Return-Path: <linux-wireless+bounces-11350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123C95035F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C3A1F24431
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484C198A20;
	Tue, 13 Aug 2024 11:12:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491C198E78
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547537; cv=none; b=DycfrtAu0bMILYeGB/S7gLTS7JivQd8hcIp/JJrXZDZLmT9akNIM6RIZ28z8UUVfcu9FbOXUJ/Sdz6RPAFdK6Y0pLm9ida9vS2Lh7OSvaBKADOyt6pgSiWe2iUckOb6LbjO7fSXYgcWkSpnIdOt8eHww3YlPlNMT+mcsBd+1aLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547537; c=relaxed/simple;
	bh=4zXgQ0sSmMdLqoRN+Pp9KL1vMd+ZRt7Dyf40GUJGDww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oK3IiA5XS0IFz4aD/UTz1FA0kawcLip1Ze4N8RLlFfvWzX1uxKFydXVjw0ULVkc9D2WTrBopCK2DjsVSgCQZUB29Lk7V+3zgmGNmt5ugA5sLYfpylZgYeiLLigZPq9KZi171vuHNI+r5fYe5216f2IqMPSULZ3gNKtiyVcEplrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300C597374f90000000000000032B.dip0.t-ipconnect.de [IPv6:2003:c5:9737:4f90::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6D366FA131;
	Tue, 13 Aug 2024 13:12:12 +0200 (CEST)
From: Issam Hamdi <ih@simonwunderlich.de>
To: lkp@intel.com
Cc: ih@simonwunderlich.de,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev,
	mathias.kretschmer@fit.fraunhofer.de,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH] cfg80211: Set the channel definition for the different Wi-Fi modes when starting CAC
Date: Tue, 13 Aug 2024 13:12:10 +0200
Message-Id: <20240813111210.2463951-1-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202408130337.tnSP4Qys-lkp@intel.com>
References: <202408130337.tnSP4Qys-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When starting CAC in a mode other than AP mode, it return a
"WARNING: CPU: 0 PID: 63 at cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]"
caused by the chandef.chan being null at the end of CAC.

Solution: Ensure the channel definition is set for the different modes
when starting CAC to avoid getting a NULL 'chan' at the end of CAC.

 Call Trace:
  ? show_regs.part.0+0x14/0x16
  ? __warn+0x67/0xc0
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? report_bug+0xa7/0x130
  ? exc_overflow+0x30/0x30
  ? handle_bug+0x27/0x50
  ? exc_invalid_op+0x18/0x60
  ? handle_exception+0xf6/0xf6
  ? exc_overflow+0x30/0x30
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? exc_overflow+0x30/0x30
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? regulatory_propagate_dfs_state.cold+0x1b/0x4c [cfg80211]
  ? cfg80211_propagate_cac_done_wk+0x1a/0x30 [cfg80211]
  ? process_one_work+0x165/0x280
  ? worker_thread+0x120/0x3f0
  ? kthread+0xc2/0xf0
  ? process_one_work+0x280/0x280
  ? kthread_complete_and_exit+0x20/0x20
  ? ret_from_fork+0x19/0x24

Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
Signed-off-by: Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>
---
 net/wireless/nl80211.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..36ae2594753e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10143,7 +10143,23 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 	if (!err) {
-		wdev->links[0].ap.chandef = chandef;
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_MESH_POINT:
+			wdev->u.mesh.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_ADHOC:
+			wdev->u.ibss.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_OCB:
+			wdev->u.ocb.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+			wdev->links[0].ap.chandef = chandef;
+			break;
+		default:
+			break;
+		}
 		wdev->cac_started = true;
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;

base-commit: cc32e9fb380d8afdbf3486d7063d5520bfb0f071
-- 
2.39.2


