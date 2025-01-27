Return-Path: <linux-wireless+bounces-18037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2A9A1DAAF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FA2161779
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553655887;
	Mon, 27 Jan 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="xEIE/D6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054415FA7B
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995872; cv=none; b=NxdRHgV8IjVQTR+VGB2lxKlSYD0xOBxRs17jkyYqarDImW+z/++V2HS8b5OITvI7QZfRCl+KJrRBkVifAVM1HB+kzfHJXVMadLHSHreAQo3Y3uO1Kt+wLcZ8GNoEiHX+1csd4ZwlpcuX2H4JJ+P8QBU/FCKorGmPtq7ljCuygVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995872; c=relaxed/simple;
	bh=T1hzmvPCM5kU+Z7q52lL9TudExGd+NMTCbjTYl/puxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzOqSL56PhRXLutkIlvjciQfYlI9wMNwoqW1aP2BNCCiSVkOtHXSF2xWl3a+7GhJjYpf5lhTzph6yfzIvt0Mm/joZpeO7STkIsuS6Hshbmwb+mJyElFVo6sLMRl4h4ZbckInGaz2Syrv3BNNfgHMxiuR6KnvBbLHVJ122JD75uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=xEIE/D6t; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995297;
	bh=T1hzmvPCM5kU+Z7q52lL9TudExGd+NMTCbjTYl/puxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xEIE/D6tc1q9GSZukjnvl4bzx3JBZYk5gwz1CmajcUZjNSvBRhjF0nc08l767GDXu
	 tsswWXLyS6upbMNNAKiOVDdZRUB3FJT/C6KceP6txUHkrO0c+hCYqWOZnKCPkPE9GJ
	 r/B1Qo/rahiGV+ve6yx1jpt5mbWT9RjRFv7KBLZA=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: [RFC PATCH 04/13] wifi: mac80211: Always provide the MMPDU TXQ
Date: Mon, 27 Jan 2025 17:26:16 +0100
Message-ID: <20250127162625.20747-5-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
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
index c64531e0a60e..bf3393340fb9 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1360,6 +1360,18 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
 		return;
 
 	trace_drv_wake_tx_queue(local, sdata, txq);
+
+	/* Driver support for MPDU txqi support is optional */
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
index aa22f09e6d14..ef5e466c5a3d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -620,7 +620,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 		struct txq_info *txq = txq_data + i * size;
 
-		/* might not do anything for the (bufferable) MMPDU TXQ */
 		ieee80211_txq_init(sdata, sta, txq, i);
 	}
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..7b6ae03e421f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1310,10 +1310,6 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
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
@@ -1520,21 +1516,10 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
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


