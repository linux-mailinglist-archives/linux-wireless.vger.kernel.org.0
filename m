Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3C2B025D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 10:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgKLJ5c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 04:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbgKLJ5X (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:23 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D69D22210;
        Thu, 12 Nov 2020 09:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605175043;
        bh=qsMza11Xyby0VYJCucWrAwkCAYw2riT3zCIpOSD66Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecO1ZDucy5F5PHRMt3M3hqtmeEYrUMPtct/wunif4HbvlWFwVNc4fvafOWUqPq3Gs
         +f2jOvGNufZP+qtspUYRXW2JK0p5d0spZ8O6QG6OXq5u+4VBb8YEabobNcmaW6jQcX
         aHSqlO3qh9qPpvr+iFo2BHmGsdmGo2bYVWBwS+T0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH 2/6] mt76: rely on mt76_phy in mt76_init_sband_2g and mt76_init_sband_5g
Date:   Thu, 12 Nov 2020 10:56:57 +0100
Message-Id: <a3fd6fa213f94b6455faa6a34aa1a18161126176.1605173301.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605173301.git.lorenzo@kernel.org>
References: <cover.1605173301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move properly support mt7915 dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 28c247c0e0cb..043f1198ffad 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -167,13 +167,14 @@ void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
 
 static int
-mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
+mt76_init_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 		const struct ieee80211_channel *chan, int n_chan,
 		struct ieee80211_rate *rates, int n_rates, bool vht)
 {
 	struct ieee80211_supported_band *sband = &msband->sband;
-	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct mt76_dev *dev = phy->dev;
 	void *chanlist;
 	int size;
 
@@ -203,7 +204,7 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 
-	mt76_init_stream_cap(&dev->phy, sband, vht);
+	mt76_init_stream_cap(phy, sband, vht);
 
 	if (!vht)
 		return 0;
@@ -221,27 +222,25 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 }
 
 static int
-mt76_init_sband_2g(struct mt76_dev *dev, struct ieee80211_rate *rates,
+mt76_init_sband_2g(struct mt76_phy *phy, struct ieee80211_rate *rates,
 		   int n_rates)
 {
-	dev->hw->wiphy->bands[NL80211_BAND_2GHZ] = &dev->phy.sband_2g.sband;
+	phy->hw->wiphy->bands[NL80211_BAND_2GHZ] = &phy->sband_2g.sband;
 
-	return mt76_init_sband(dev, &dev->phy.sband_2g,
-			       mt76_channels_2ghz,
-			       ARRAY_SIZE(mt76_channels_2ghz),
-			       rates, n_rates, false);
+	return mt76_init_sband(phy, &phy->sband_2g, mt76_channels_2ghz,
+			       ARRAY_SIZE(mt76_channels_2ghz), rates,
+			       n_rates, false);
 }
 
 static int
-mt76_init_sband_5g(struct mt76_dev *dev, struct ieee80211_rate *rates,
+mt76_init_sband_5g(struct mt76_phy *phy, struct ieee80211_rate *rates,
 		   int n_rates, bool vht)
 {
-	dev->hw->wiphy->bands[NL80211_BAND_5GHZ] = &dev->phy.sband_5g.sband;
+	phy->hw->wiphy->bands[NL80211_BAND_5GHZ] = &phy->sband_5g.sband;
 
-	return mt76_init_sband(dev, &dev->phy.sband_5g,
-			       mt76_channels_5ghz,
-			       ARRAY_SIZE(mt76_channels_5ghz),
-			       rates, n_rates, vht);
+	return mt76_init_sband(phy, &phy->sband_5g, mt76_channels_5ghz,
+			       ARRAY_SIZE(mt76_channels_5ghz), rates,
+			       n_rates, vht);
 }
 
 static void
@@ -462,13 +461,13 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	mt76_phy_init(dev, hw);
 
 	if (phy->cap.has_2ghz) {
-		ret = mt76_init_sband_2g(dev, rates, n_rates);
+		ret = mt76_init_sband_2g(phy, rates, n_rates);
 		if (ret)
 			return ret;
 	}
 
 	if (phy->cap.has_5ghz) {
-		ret = mt76_init_sband_5g(dev, rates + 4, n_rates - 4, vht);
+		ret = mt76_init_sband_5g(phy, rates + 4, n_rates - 4, vht);
 		if (ret)
 			return ret;
 	}
-- 
2.26.2

