Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B943473C9
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhCXIiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 04:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhCXIht (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 04:37:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D629D619F7;
        Wed, 24 Mar 2021 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616575069;
        bh=FoJ3JASuevSvihHq1cLghUlt7ByTsHn1gQE43yyrkuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SapSjUApcFk1J+OMGfApXhu33gd275l0Qq5yDu3f8WPz8iBsLMRGdYUMe7dzeQ0wf
         kK0ESUivQ9c69DbdaiGVkX8k9JR9niIDv3/lg+22XoiO7P6u3v1YAo5cUEbg3x7Dcg
         Pxuc6equORVZua13Si4JECdWtMonLOUS4NqjBDLSF2pL3ro575qGwd0yYILBGJMWKK
         RfNqxvaI+rdAE3ny9kVS44DZPQDBrpePPHcjgukswqPW610pLr2o3wrK6mTPnIMOCj
         /70KVxZwYUYcnezrRorVakp6aYph+F/GYm9RtmDxLXrvvHwmyQeX6GdaswtxFK6n+Y
         CJopt4YfFJHYg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Jayden.Kuo@mediatek.com
Subject: [PATCH 2/2] mt76: mt7921: properly configure rcpi adding a sta to the fw
Date:   Wed, 24 Mar 2021 09:37:37 +0100
Message-Id: <7d0dc013d0597ea4ae3c9bf03d16e732083a2d95.1616574803.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616574803.git.lorenzo@kernel.org>
References: <cover.1616574803.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly configure rcpi based on association process rssi. rcpi is used
by rate controller embedded into the fw to initialize amsdu size.

Tested-by: Jayden.Kuo <jayden.kuo@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 35 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 12 +++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  7 ++++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 067cfa6dd8fb..3c755a90820f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -9,8 +9,6 @@
 #include "mac.h"
 #include "mcu.h"
 
-#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
-
 #define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
@@ -285,6 +283,37 @@ mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
 	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
 }
 
+static void
+mt7921_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = priv;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+	if (status->signal > 0)
+		return;
+
+	if (!ether_addr_equal(vif->addr, hdr->addr1))
+		return;
+
+	ewma_rssi_add(&mvif->rssi, -status->signal);
+}
+
+static void
+mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+	if (!ieee80211_is_assoc_resp(hdr->frame_control) &&
+	    !ieee80211_is_auth(hdr->frame_control))
+		return;
+
+	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt7921_mac_rssi_iter, skb);
+}
+
 int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -522,6 +551,8 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt76_insert_ccmp_hdr(skb, key_id);
 	}
 
+	mt7921_mac_assoc_rssi(dev, skb);
+
 	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE)
 		mt7921_mac_decode_he_radiotap(skb, status, rxv, mode);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 9db2442fa11f..92775f98a80c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -328,6 +328,8 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
+	ewma_rssi_init(&mvif->rssi);
+
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
@@ -634,12 +636,14 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int rssi = -ewma_rssi_read(&mvif->rssi);
 	struct mt76_sta_cmd_info info = {
 		.sta = sta,
 		.vif = vif,
 		.enable = true,
 		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
 		.wcid = &msta->wcid,
+		.rcpi = to_rcpi(rssi),
 	};
 	int ret, idx;
 
@@ -696,11 +700,13 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 
-		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    false);
+		ewma_rssi_init(&mvif->rssi);
+		if (!sta->tdls)
+			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
+						    &mvif->sta.wcid, false);
 	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 943053355f6d..ed6f9a786b4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -46,6 +46,9 @@
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
 
+#define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
+#define to_rcpi(rssi)			(2 * (rssi) + 220)
+
 struct mt7921_vif;
 struct mt7921_sta;
 
@@ -92,12 +95,16 @@ struct mt7921_sta {
 	struct mt7921_sta_key_conf bip;
 };
 
+DECLARE_EWMA(rssi, 10, 8);
+
 struct mt7921_vif {
 	struct mt76_vif mt76; /* must be first */
 
 	struct mt7921_sta sta;
 	struct mt7921_phy *phy;
 
+	struct ewma_rssi rssi;
+
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 };
 
-- 
2.30.2

