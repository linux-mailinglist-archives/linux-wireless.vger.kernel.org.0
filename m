Return-Path: <linux-wireless+bounces-20189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87825A5CC96
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458F2189D04C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B267262D2C;
	Tue, 11 Mar 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYDikKAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B1263C71
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715140; cv=none; b=ZBW3ykCWpljmyIVTrul41tuYeZ+Xr8UN+2g2RvDzguVRj3vCr0S8mlbO+8XsWqNVVxCBHMW1WISWrm/pw6FGp9BEp/JW3xwH1y+Jr9x2jfkmInADa9Xi2O/1l/aqZcC8ca7hj57PKpV9nK+3JBUfpMaSX53iLveTDGbuDBRmSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715140; c=relaxed/simple;
	bh=R6gtg/TQgZku/lKJqB18xCV0J8UOG6HPluWCjQVyBro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uE9U2clOlQhO1ZEf681mTsdGcEh0gZ/Xvtf40bZTAPZvo1rrHfzizUv7RZqHfRVOsOmRTlOgZKE1MNzp/BNxWKRhWdv86IR/siL3+sS0qa9EAYYeci8BNk8V8f/Tq4RNU5umn2923Sz7m8z0bxiQf1sFbfpEz5bbSA+B7qTPY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYDikKAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5247C4CEE9;
	Tue, 11 Mar 2025 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715140;
	bh=R6gtg/TQgZku/lKJqB18xCV0J8UOG6HPluWCjQVyBro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mYDikKAR2jNfzHfGL/PSDYSCJCpSiliCotsLvB91EjDjDgVVftrJYUUh8mg2FPJLf
	 ZxSaNXjYYJzwLaRxIXd8w3ckJQ2EsWiG1pt1X2qKk9tA4HmCzaBq9WKX/YrGqRgeuN
	 DXerEjDgu1mMLsQ3sJJJfRo+UHrvK0T6iCNYpFFOx9kzuRdp/3NdINXAMu7Dl7FiF3
	 7bM5v0LU76iRzQaBQHj2mbXRItScgXpLd0QDUIJyj9eXT7JuTlgWiVlIArb/mW3jNy
	 NuGZPfb52r5t47qaATo0rcM2MKSqZvFdhIKywqjhvI8fJTtVwWTopte6e8JKlDWkMf
	 G0spAbPJNSVTg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:08 +0100
Subject: [PATCH v2 09/13] wifi: mt76: mt7996: Support MLO in
 mt7996_mac_sta_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-9-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

Similar to mt7996_mac_sta_add() adn mt7996_mac_sta_remove(), update
mt7996_mac_sta_event routine to take into account MLO support.
Please note mcu routines does not support MLO yet.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 69 ++++++++++++++----------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 307c68c6b0cd7c3acdbfd7be78a007a66d3183bf..6d323b5e4e8076ca963e585c12dc656dc5ec3fdb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1001,41 +1001,52 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_vif_link *link = &mvif->deflink;
-	int i, ret;
-
-	switch (ev) {
-	case MT76_STA_EVENT_ASSOC:
-		ret = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-					 CONN_STATE_CONNECT, true);
-		if (ret)
-			return ret;
-
-		ret = mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
-		if (ret)
-			return ret;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
-		msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-		msta_link->wcid.sta = 1;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt7996_sta_link *msta_link;
+		struct mt7996_vif_link *link;
+		int i, err;
 
-		return 0;
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
 
-	case MT76_STA_EVENT_AUTHORIZE:
-		return mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-					  CONN_STATE_PORT_SECURE, false);
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		if (!msta_link)
+			continue;
 
-	case MT76_STA_EVENT_DISASSOC:
-		for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
-			mt7996_mac_twt_teardown_flow(dev, msta, i);
+		switch (ev) {
+		case MT76_STA_EVENT_ASSOC:
+			err = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+						 CONN_STATE_CONNECT, true);
+			if (err)
+				return err;
 
-		mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-				   CONN_STATE_DISCONNECT, false);
-		msta_link->wcid.sta_disabled = 1;
-		msta_link->wcid.sta = 0;
+			err = mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
+			if (err)
+				return err;
 
-		return 0;
+			msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+			msta_link->wcid.sta = 1;
+			break;
+		case MT76_STA_EVENT_AUTHORIZE:
+			err = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+						 CONN_STATE_PORT_SECURE, false);
+			if (err)
+				return err;
+			break;
+		case MT76_STA_EVENT_DISASSOC:
+			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
+				mt7996_mac_twt_teardown_flow(dev, msta, i);
+
+			mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+					   CONN_STATE_DISCONNECT, false);
+			msta_link->wcid.sta_disabled = 1;
+			msta_link->wcid.sta = 0;
+			break;
+		}
 	}
 
 	return 0;

-- 
2.48.1


