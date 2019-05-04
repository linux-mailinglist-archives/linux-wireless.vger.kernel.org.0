Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9013AEA
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEDP3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDP3c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:32 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9C42086A;
        Sat,  4 May 2019 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983771;
        bh=+8OzOkz7NOd2uM3rGXGzDoyiqmDZ6hDI3w8LZtYOAWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4WiJi6zOLih7Ec1YajNrLgUN8rLblCaxXTWDUgt/hTTQNLoU8KpWU8kXCifMS9bD
         MNWD5c4EHFdW5OCLwh4kAIqA/EWValdF0sIoKSd+Ve7x/Gfdwvn8o94QlJyWCISiS0
         WCOnV/onL5midEv7Lv0OJtmJ8h2C650HGEYswwUM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 03/17] mt7615: mcu: remove bss_info_convert_vif_type routine
Date:   Sat,  4 May 2019 17:28:55 +0200
Message-Id: <46123e402e7e324e832c2c710c89e7c27bff473c.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove bss_info_convert_vif_type routine since it is run just in
mt7615_mcu_set_bss_info and the switch over vif->type is already there.
Simplify mt7615_mcu_set_bss_info routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 73 +++++++------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2a632c0debe9..2a73ac8b0d90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -842,39 +842,28 @@ static int __mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 				   MCU_Q_SET, MCU_S2D_H2N, NULL);
 }
 
-static void bss_info_convert_vif_type(enum nl80211_iftype type,
-				      u32 *network_type, u32 *conn_type)
-{
-	switch (type) {
-	case NL80211_IFTYPE_AP:
-		if (network_type)
-			*network_type = NETWORK_INFRA;
-		if (conn_type)
-			*conn_type = CONNECTION_INFRA_AP;
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (network_type)
-			*network_type = NETWORK_INFRA;
-		if (conn_type)
-			*conn_type = CONNECTION_INFRA_STA;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	};
-}
-
-int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			    int en)
+int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
+			    struct ieee80211_vif *vif, int en)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct bss_info bss_info = {0};
-	u8 bmc_tx_wlan_idx = 0;
-	u32 network_type = 0, conn_type = 0;
+	struct bss_info bss_info = {
+		.bss_idx = mvif->idx,
+		.omac_idx = mvif->omac_idx,
+		.band_idx = mvif->band_idx,
+		.bcn_interval = vif->bss_conf.beacon_int,
+		.dtim_period = vif->bss_conf.dtim_period,
+		.enable = en,
+		.feature = BIT(BSS_INFO_BASIC),
+		.wmm_idx = mvif->wmm_idx,
+	};
 
-	if (vif->type == NL80211_IFTYPE_AP) {
-		bmc_tx_wlan_idx = mvif->sta.wcid.idx;
-	} else if (vif->type == NL80211_IFTYPE_STATION) {
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+		bss_info.bmc_tx_wlan_idx = mvif->sta.wcid.idx;
+		bss_info.network_type = NETWORK_INFRA;
+		bss_info.conn_type = CONNECTION_INFRA_AP;
+		break;
+	case NL80211_IFTYPE_STATION: {
 		/* find the unicast entry for sta mode bmc tx */
 		struct ieee80211_sta *ap_sta;
 		struct mt7615_sta *msta;
@@ -888,27 +877,19 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		}
 
 		msta = (struct mt7615_sta *)ap_sta->drv_priv;
-		bmc_tx_wlan_idx = msta->wcid.idx;
+		bss_info.bmc_tx_wlan_idx = msta->wcid.idx;
+		bss_info.network_type = NETWORK_INFRA;
+		bss_info.conn_type = CONNECTION_INFRA_STA;
 
 		rcu_read_unlock();
-	} else {
+		break;
+	}
+	default:
 		WARN_ON(1);
+		break;
 	}
-
-	bss_info_convert_vif_type(vif->type, &network_type, &conn_type);
-
-	bss_info.bss_idx = mvif->idx;
 	memcpy(bss_info.bssid, vif->bss_conf.bssid, ETH_ALEN);
-	bss_info.omac_idx = mvif->omac_idx;
-	bss_info.band_idx = mvif->band_idx;
-	bss_info.bmc_tx_wlan_idx = bmc_tx_wlan_idx;
-	bss_info.wmm_idx = mvif->wmm_idx;
-	bss_info.network_type = network_type;
-	bss_info.conn_type = conn_type;
-	bss_info.bcn_interval = vif->bss_conf.beacon_int;
-	bss_info.dtim_period = vif->bss_conf.dtim_period;
-	bss_info.enable = en;
-	bss_info.feature = BIT(BSS_INFO_BASIC);
+
 	if (en) {
 		bss_info.feature |= BIT(BSS_INFO_OMAC);
 		if (mvif->omac_idx > EXT_BSSID_START)
-- 
2.20.1

