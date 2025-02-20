Return-Path: <linux-wireless+bounces-19188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6DBA3D73A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 11:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7033019C1FB8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BA1F3D21;
	Thu, 20 Feb 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="tz868a27"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587B1F3B8A
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048284; cv=none; b=FlFugpex8232lDEN33nMVYtoS8Ebs/phIm9QpLpguS3jXhE6GN+mHvcxzC/cAPPifA+/egsVJObSfOaYV6ns9YX/xBiKJKw8UmmPOumD6ZJh78RfMT6/kgCAvWccu6El7bUER5GotpeAgvha4EvhczLIhdeDkPgqulEUT14GZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048284; c=relaxed/simple;
	bh=nrlMihG98ezkLx2B4JeFZ+tmQHrn+JW2RWVV428K4nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRYTR0lTqQOi7h0yQzweEmy90UAK5gBnIZ4sgGQ8gmPVBuyNALyI/l4zS2R+ncmApHhj70Orx4fxVzlhh/MFFm/dtxMHtCsrUQG/dgKlSv9otQFEQKy/ucjhrf3CeNdQqiC2xzpIAxh2iWGrpZnso/ceX4kJ58TSqVyc9fJPokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=tz868a27; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740048280;
	bh=nrlMihG98ezkLx2B4JeFZ+tmQHrn+JW2RWVV428K4nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tz868a27bhTJ1YOraLMrVS2pp3JX35T8BlgmYECCfv0/d9u4MRaRHivLcAhKgPCiO
	 8kx97Au2sbRRN1fgi4TL5LETiwKMzgc/7eQ5VXRxqnTHWPJVUVaLz6LJQzj2IT19qI
	 wf/oBfeTecSuMZtu/9Q67N1vLjFbNddeSyh0wKJs=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v3 02/10] wifi: mac80211: Always provide the MMPDU TXQ
Date: Thu, 20 Feb 2025 11:44:18 +0100
Message-ID: <20250220104426.82011-3-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220104426.82011-1-Alexander@wetzel-home.de>
References: <20250220104426.82011-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Wetzel <alexander@wetzel-home.de>

Always providing and use the MMPDU TX queue to prepare to move all TX
into TXQs.

For drivers not supporting the MMPDU TXQ, mac80211 will handle it
internally.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 net/mac80211/driver-ops.h | 12 ++++++++++++
 net/mac80211/sta_info.c   |  1 -
 net/mac80211/tx.c         | 19 ++-----------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a003..992fa2957621 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1364,6 +1364,18 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
 		return;
 
 	trace_drv_wake_tx_queue(local, sdata, txq);
+
+	/* Driver support for MPDU TXQ support is optional */
+	if (unlikely(txq->txq.tid == IEEE80211_NUM_TIDS &&
+		     ((sdata->vif.type == NL80211_IFTYPE_STATION &&
+		       !ieee80211_hw_check(&sdata->local->hw, STA_MMPDU_TXQ)) ||
+		      (sdata->vif.type != NL80211_IFTYPE_STATION &&
+		       !ieee80211_hw_check(&sdata->local->hw,
+					   BUFF_MMPDU_TXQ))))) {
+		ieee80211_handle_wake_tx_queue(&local->hw, &txq->txq);
+		return;
+	}
+
 	local->ops->wake_tx_queue(&local->hw, &txq->txq);
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f83268fa9f92..3ba03b6142cc 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -638,7 +638,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 		struct txq_info *txq = txq_data + i * size;
 
-		/* might not do anything for the (bufferable) MMPDU TXQ */
 		ieee80211_txq_init(sdata, sta, txq, i);
 	}
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20179db88c4a..914fba53d7f1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1311,10 +1311,6 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 		     ieee80211_is_bufferable_mmpdu(skb) ||
 		     vif->type == NL80211_IFTYPE_STATION) &&
 		    sta && sta->uploaded) {
-			/*
-			 * This will be NULL if the driver didn't set the
-			 * opt-in hardware flag.
-			 */
 			txq = sta->sta.txq[IEEE80211_NUM_TIDS];
 		}
 	} else if (sta) {
@@ -1521,21 +1517,10 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (tid == IEEE80211_NUM_TIDS) {
-		if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-			/* Drivers need to opt in to the management MPDU TXQ */
-			if (!ieee80211_hw_check(&sdata->local->hw,
-						STA_MMPDU_TXQ))
-				return;
-		} else if (!ieee80211_hw_check(&sdata->local->hw,
-					       BUFF_MMPDU_TXQ)) {
-			/* Drivers need to opt in to the bufferable MMPDU TXQ */
-			return;
-		}
+	if (tid == IEEE80211_NUM_TIDS)
 		txqi->txq.ac = IEEE80211_AC_VO;
-	} else {
+	else
 		txqi->txq.ac = ieee80211_ac_from_tid(tid);
-	}
 
 	txqi->txq.sta = &sta->sta;
 	txqi->txq.tid = tid;
-- 
2.48.1


