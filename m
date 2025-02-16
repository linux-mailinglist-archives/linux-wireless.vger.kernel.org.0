Return-Path: <linux-wireless+bounces-19018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC11A37511
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E3188F911
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182519992C;
	Sun, 16 Feb 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="FwqIMaFM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A036F31E
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719951; cv=none; b=AY7kjIUkGaSmGf++3fXG9HT3nZPwRteVM1Q5VN5OyQmJj6HYglf/Lhm/hXrkDV68LBKi0lDwPOC/dfElSfAvPO8NrQLxNqSDMtM+nxDvT3ZOHAc0mUAL4ZJH5LD/QF0omu2fvxe6DdSNRbsJorCKUZw3ggTdnjQFPYUpAIAA5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719951; c=relaxed/simple;
	bh=mHG1jcGsnHxpVhUmqlrjvpTwGAfewc3RoXtPdzdOqV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxLYOEsKq/97X3hnaqlO2QXJKZQWVfinEYU/TQKCycPqDsqzvyNA+VihTvjULJmWjpQxcmy1eXLemyjW023nIDkxcDqELh2oZ7luz+fXMVNzMkyIr08QLAIH/roAt/Nkmeb6nxBbZtD5oMnz54mo+csLxc02UD48Bc1UTjD53ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=FwqIMaFM; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739719938;
	bh=mHG1jcGsnHxpVhUmqlrjvpTwGAfewc3RoXtPdzdOqV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FwqIMaFMQbKZlEQT3HEOiKEqDX/1Cg8q4F6b2y1967kveX6zEiGz4RnzPXVcT4joF
	 Rle8T/hloJNL6c11Uq2x2rQwDBlC83LO87sxKD6zCVVvf38nXljkMsXc8Hq+XzMqht
	 djVpBVReeNMW3iiW3ej2A7J7fxHrbDfJs6bjH/ew=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH 07/10] wifi: mac80211: Rename IEEE80211_TX_INTFL_OFFCHAN_TX_OK
Date: Sun, 16 Feb 2025 16:31:57 +0100
Message-ID: <20250216153200.1318604-8-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216153200.1318604-1-Alexander@wetzel-home.de>
References: <20250216153200.1318604-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make it clear that IEEE80211_TX_INTFL_OFFCHAN_TX_OK is now selecting
the alternate TX path in mac80211 - which immediately sends the frame -
the flag is renamed to IEEE80211_TX_INTFL_NOQUEUE_TX.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 include/net/mac80211.h    | 8 ++++----
 net/mac80211/mlme.c       | 2 +-
 net/mac80211/offchannel.c | 2 +-
 net/mac80211/rx.c         | 2 +-
 net/mac80211/scan.c       | 2 +-
 net/mac80211/tx.c         | 6 +++---
 net/mac80211/util.c       | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 320082546b29..ceea27e58cd9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -898,9 +898,9 @@ struct ieee80211_bss_conf {
  * @IEEE80211_TX_CTL_RATE_CTRL_PROBE: internal to mac80211, can be
  *	set by rate control algorithms to indicate probe rate, will
  *	be cleared for fragmented frames (except on the last fragment)
- * @IEEE80211_TX_INTFL_OFFCHAN_TX_OK: Internal to mac80211. Used to indicate
- *	that a frame can be transmitted while the queues are stopped for
- *	off-channel operation.
+ * @IEEE80211_TX_INTFL_NOQUEUE_TX: Internal to mac80211. Indicates that a frame
+ *	can't be queued and must be transmitted immediately. Frames with this
+ *	flag ignore offchannel queue stops and bypass wake_tx_queue().
  * @IEEE80211_TX_CTL_HW_80211_ENCAP: This frame uses hardware encapsulation
  *	(header conversion)
  * @IEEE80211_TX_INTFL_RETRIED: completely internal to mac80211,
@@ -970,7 +970,7 @@ enum mac80211_tx_info_flags {
 	IEEE80211_TX_STAT_AMPDU			= BIT(10),
 	IEEE80211_TX_STAT_AMPDU_NO_BACK		= BIT(11),
 	IEEE80211_TX_CTL_RATE_CTRL_PROBE	= BIT(12),
-	IEEE80211_TX_INTFL_OFFCHAN_TX_OK	= BIT(13),
+	IEEE80211_TX_INTFL_NOQUEUE_TX		= BIT(13),
 	IEEE80211_TX_CTL_HW_80211_ENCAP		= BIT(14),
 	IEEE80211_TX_INTFL_RETRIED		= BIT(15),
 	IEEE80211_TX_INTFL_DONT_ENCRYPT		= BIT(16),
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4e8f0a5f6251..87a3ff6fa286 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2295,7 +2295,7 @@ void ieee80211_send_nullfunc(struct ieee80211_local *local,
 		nullfunc->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
-					IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
+					IEEE80211_TX_INTFL_NOQUEUE_TX;
 
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 29fab7ae47b4..85c27df0f423 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -1026,7 +1026,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	}
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_TX_OFFCHAN |
-					IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
+					IEEE80211_TX_INTFL_NOQUEUE_TX;
 	if (ieee80211_hw_check(&local->hw, QUEUE_CONTROL))
 		IEEE80211_SKB_CB(skb)->hw_queue =
 			local->hw.offchannel_tx_hw_queue;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f40e2ea1b09a..042e12f08842 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3998,7 +3998,7 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(nskb);
 
 			info->flags = IEEE80211_TX_CTL_TX_OFFCHAN |
-				      IEEE80211_TX_INTFL_OFFCHAN_TX_OK |
+				      IEEE80211_TX_INTFL_NOQUEUE_TX |
 				      IEEE80211_TX_CTL_NO_CCK_RATE;
 			if (ieee80211_hw_check(&local->hw, QUEUE_CONTROL))
 				info->hw_queue =
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index cb7079071885..00d37260f292 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -668,7 +668,7 @@ static void ieee80211_scan_state_send_probe(struct ieee80211_local *local,
 	scan_req = rcu_dereference_protected(local->scan_req,
 					     lockdep_is_held(&local->hw.wiphy->mtx));
 
-	tx_flags = IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
+	tx_flags = IEEE80211_TX_INTFL_NOQUEUE_TX;
 	if (scan_req->no_cck)
 		tx_flags |= IEEE80211_TX_CTL_NO_CCK_RATE;
 	if (scan_req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e99d6bc02c0..800e02bad7f6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -230,7 +230,7 @@ ieee80211_tx_h_dynamic_ps(struct ieee80211_tx_data *tx)
 	if (tx->sdata->vif.type != NL80211_IFTYPE_STATION)
 		return TX_CONTINUE;
 
-	if (unlikely(info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK))
+	if (unlikely(info->flags & IEEE80211_TX_INTFL_NOQUEUE_TX))
 		return TX_CONTINUE;
 
 	ifmgd = &tx->sdata->u.mgd;
@@ -1301,7 +1301,7 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_txq *txq = NULL;
 
-	if (unlikely(info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK)) {
+	if (unlikely(info->flags & IEEE80211_TX_INTFL_NOQUEUE_TX)) {
 		if (sta)
 			txq = sta->sta.txq[IEEE80211_TID_NOQUEUE];
 		else
@@ -1819,7 +1819,7 @@ static void ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tx_data tx;
 	ieee80211_tx_result res_prepare;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool noqueue = info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
+	bool noqueue = info->flags & IEEE80211_TX_INTFL_NOQUEUE_TX;
 	struct ieee80211_tx_control control;
 	struct txq_info *txqi;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7df94e1c8c7c..6e95393ea5bc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1197,7 +1197,7 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 			 */
 			IEEE80211_SKB_CB(skb)->flags |=
 				IEEE80211_TX_INTFL_DONT_ENCRYPT |
-				IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
+				IEEE80211_TX_INTFL_NOQUEUE_TX;
 
 		ieee80211_tx_skb(sdata, skb);
 	}
-- 
2.48.1


