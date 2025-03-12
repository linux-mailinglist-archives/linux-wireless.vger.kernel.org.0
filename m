Return-Path: <linux-wireless+bounces-20246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9BA5DB39
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2213C178262
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF40E241678;
	Wed, 12 Mar 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2iLvNyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A024166E
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778092; cv=none; b=SqPjNTtcQBu9wayvB4SaUEsN0MVBmy4ow4Sr58olJ0t0pTotRo3Unkp96uxzu4cDy38Czgt+/pMyWAzpSkWDvhR+o1kgCR+FaQgLtZvZZzdPw34K/hopvUz/61NIeB8RZjGJcw0QWLPIXnTz9suI52aTErsCD4eqS9WEjZDEH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778092; c=relaxed/simple;
	bh=tk6PkdxP+zQXfHPFeg5FWZF1EZ75Tf6fIjYcvX8+F+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4kMfP204TqH6zBjfmU43Qj1l8EA0o98JX4/kdDp4wnTjPyQle2b9/L9+WUDE9Q345Da7Gfgc1mBfIwpW82tBbgBkkCwrbQ6iB2yWMbHlLWg0oPtypHsQ0vLHJX1Tidkb1UzQFGJiuVTttuTwyuQLkjPmIYJs4nwn/SOIFjHn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2iLvNyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2358EC4CEEC;
	Wed, 12 Mar 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778092;
	bh=tk6PkdxP+zQXfHPFeg5FWZF1EZ75Tf6fIjYcvX8+F+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a2iLvNySFPfeoYMhbQXGsJkCyN8mRrnH00UNhHRQhL+Ct5r/iHuyjC4e3YrnTJrbm
	 CIHPasd8n0om2ENg3BW4mFnuHzLxr+9TVggxetKSlo4DVTW5KzXoB0uVmXoIcaDzd0
	 qC+45iP+QWVlg1LwIZ+DEtOs2kSbaFrXoXCavFEnqtpTyHHF8Tm7LxgXIdHGzMAt9C
	 IFRc7Al3IO6syyT2cz2MkzrkQ6FenXFEuh7ZjWwAiZKD+0LNmN6U8NXgxkeA+EE/Wq
	 h2cvrkN5ZbMa9lvcG+hAKK/nijyRZWCEChohSjmOcu8KFzSDfO8h8EjrvHWfCLdT3j
	 sLcqEFOaj5BTA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:14:04 +0100
Subject: [PATCH 20/21] wifi: mt76: mt7996: rework mt7996_ampdu_action to
 support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-20-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Active/de-active TX/RX BA sessssion for each active links running
mt7996_ampdu_action routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 89 ++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 16 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  5 +-
 3 files changed, 64 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8bcb4b8e3ef58c23294c16c10d38384bfba87e30..adeb267b2801894590f90d02e902ebec602de98a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1259,12 +1259,13 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct ieee80211_sta *sta = params->sta;
-	struct ieee80211_txq *txq = sta->txq[params->tid];
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct ieee80211_link_sta *link_sta;
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
 	struct mt76_txq *mtxq;
+	unsigned int link_id;
 	int ret = 0;
 
 	if (!txq)
@@ -1274,38 +1275,60 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	switch (action) {
-	case IEEE80211_AMPDU_RX_START:
-		mt76_rx_aggr_start(&dev->mt76, &msta_link->wcid, tid, ssn,
-				   params->buf_size);
-		ret = mt7996_mcu_add_rx_ba(dev, params, true);
-		break;
-	case IEEE80211_AMPDU_RX_STOP:
-		mt76_rx_aggr_stop(&dev->mt76, &msta_link->wcid, tid);
-		ret = mt7996_mcu_add_rx_ba(dev, params, false);
-		break;
-	case IEEE80211_AMPDU_TX_OPERATIONAL:
-		mtxq->aggr = true;
-		mtxq->send_bar = false;
-		ret = mt7996_mcu_add_tx_ba(dev, params, true);
-		break;
-	case IEEE80211_AMPDU_TX_STOP_FLUSH:
-	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-		mtxq->aggr = false;
-		clear_bit(tid, &msta_link->wcid.ampdu_state);
-		ret = mt7996_mcu_add_tx_ba(dev, params, false);
-		break;
-	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta_link->wcid.ampdu_state);
-		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
-		break;
-	case IEEE80211_AMPDU_TX_STOP_CONT:
-		mtxq->aggr = false;
-		clear_bit(tid, &msta_link->wcid.ampdu_state);
-		ret = mt7996_mcu_add_tx_ba(dev, params, false);
-		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt7996_sta_link *msta_link;
+		struct mt7996_vif_link *link;
+
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		if (!msta_link)
+			continue;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		switch (action) {
+		case IEEE80211_AMPDU_RX_START:
+			mt76_rx_aggr_start(&dev->mt76, &msta_link->wcid, tid,
+					   ssn, params->buf_size);
+			ret = mt7996_mcu_add_rx_ba(dev, params, link, true);
+			break;
+		case IEEE80211_AMPDU_RX_STOP:
+			mt76_rx_aggr_stop(&dev->mt76, &msta_link->wcid, tid);
+			ret = mt7996_mcu_add_rx_ba(dev, params, link, false);
+			break;
+		case IEEE80211_AMPDU_TX_OPERATIONAL:
+			mtxq->aggr = true;
+			mtxq->send_bar = false;
+			ret = mt7996_mcu_add_tx_ba(dev, params, link,
+						   msta_link, true);
+			break;
+		case IEEE80211_AMPDU_TX_STOP_FLUSH:
+		case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+			mtxq->aggr = false;
+			clear_bit(tid, &msta_link->wcid.ampdu_state);
+			ret = mt7996_mcu_add_tx_ba(dev, params, link,
+						   msta_link, false);
+			break;
+		case IEEE80211_AMPDU_TX_START:
+			set_bit(tid, &msta_link->wcid.ampdu_state);
+			ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+			break;
+		case IEEE80211_AMPDU_TX_STOP_CONT:
+			mtxq->aggr = false;
+			clear_bit(tid, &msta_link->wcid.ampdu_state);
+			ret = mt7996_mcu_add_tx_ba(dev, params, link,
+						   msta_link, false);
+			break;
+		}
+
+		if (ret)
+			break;
 	}
+
+	if (action == IEEE80211_AMPDU_TX_STOP_CONT)
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 85602a8594e0c9ab3a0055e04cf1ca836d62b6b9..89e4f0e8858322b636650a27d9ab0872987b7011 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1160,26 +1160,20 @@ mt7996_mcu_sta_ba(struct mt7996_dev *dev, struct mt76_vif_link *mvif,
 /** starec & wtbl **/
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool enable)
+			 struct mt7996_vif_link *link,
+			 struct mt7996_sta_link *msta_link, bool enable)
 {
-	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
-	struct mt7996_vif *mvif = msta->vif;
-
 	if (enable && !params->amsdu)
 		msta_link->wcid.amsdu = false;
 
-	return mt7996_mcu_sta_ba(dev, &mvif->deflink.mt76, params, enable, true);
+	return mt7996_mcu_sta_ba(dev, &link->mt76, params, enable, true);
 }
 
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool enable)
+			 struct mt7996_vif_link *link, bool enable)
 {
-	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
-	struct mt7996_vif *mvif = msta->vif;
-
-	return mt7996_mcu_sta_ba(dev, &mvif->deflink.mt76, params, enable, false);
+	return mt7996_mcu_sta_ba(dev, &link->mt76, params, enable, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 815a3c68b8723469e32e74b85979eaf75c1b176a..43e646ed6094cb7fb78d201fc3ee8446ad2a16a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -584,10 +584,11 @@ int mt7996_mcu_teardown_mld_sta(struct mt7996_dev *dev,
 				struct mt7996_sta_link *msta_link);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool add);
+			 struct mt7996_vif_link *link,
+			 struct mt7996_sta_link *msta_link, bool enable);
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 bool add);
+			 struct mt7996_vif_link *link, bool enable);
 int mt7996_mcu_update_bss_color(struct mt7996_dev *dev,
 				struct mt76_vif_link *mlink,
 				struct cfg80211_he_bss_color *he_bss_color);

-- 
2.48.1


