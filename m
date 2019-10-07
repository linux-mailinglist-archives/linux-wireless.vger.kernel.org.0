Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC37CEF41
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfJGWtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 18:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfJGWtR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 18:49:17 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D4A20867;
        Mon,  7 Oct 2019 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570488556;
        bh=13Cj4K3wyADipQKddS/ofndW6q+ScDvBCE8fyaHL16U=;
        h=From:To:Cc:Subject:Date:From;
        b=PcC+7SffsLMbX1+M4VQqcxpMfn68K/W1XIQZgEAkVn+Ha2rLvUloE2+eCvX9JOYc2
         G2HfHyeZoWYOKZUljs+SojsaUqm8orc+qcHmkzjNRaoYzLy7ROeZFiqcWeFBRI0L0+
         uL9qX+ZHax5FYDaKatZ0uyhj25N3NrY2Ogr49/CQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: add ibss support
Date:   Tue,  8 Oct 2019 00:49:00 +0200
Message-Id: <393a42e4bdca877e904a7edaef74fbd98f1f5ecb.1570488150.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable IFTYPE_ADHOC support on 7615 devices. The feature has been tested
using a mt76x2 device as wireless peer.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 1e7723aceee2..4f56b4a4a015 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -177,6 +177,9 @@ static struct ieee80211_rate mt7615_rates[] = {
 
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_ADHOC)
+	}, {
 		.max = MT7615_MAX_INTERFACES,
 		.types = BIT(NL80211_IFTYPE_AP) |
 #ifdef CONFIG_MAC80211_MESH
@@ -289,6 +292,8 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	wiphy->reg_notifier = mt7615_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
@@ -304,6 +309,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	dev->dfs_state = -1;
 
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				 BIT(NL80211_IFTYPE_ADHOC) |
 #ifdef CONFIG_MAC80211_MESH
 				 BIT(NL80211_IFTYPE_MESH_POINT) |
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d9f4d425424c..0a3cdc7ae5c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -41,6 +41,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
 	switch (type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
 		/* ap use hw bssid 0 and ext bssid */
 		if (~mask & BIT(HW_BSSID_0))
 			return HW_BSSID_0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 275d5eaed3b7..76403b0b8040 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -851,6 +851,11 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 		conn_type = CONNECTION_INFRA_STA;
 		break;
 	}
+	case NL80211_IFTYPE_ADHOC:
+		conn_type = CONNECTION_IBSS_ADHOC;
+		tx_wlan_idx = mvif->sta.wcid.idx;
+		net_type = NETWORK_IBSS;
+		break;
 	default:
 		WARN_ON(1);
 		break;
@@ -1076,6 +1081,9 @@ int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	case NL80211_IFTYPE_STATION:
 		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
 		break;
+	case NL80211_IFTYPE_ADHOC:
+		req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
 	default:
 		WARN_ON(1);
 		break;
-- 
2.21.0

