Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4C364134
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 14:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhDSMDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 08:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhDSMDg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 08:03:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB4E060FE8;
        Mon, 19 Apr 2021 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618833786;
        bh=14wML8ATLwZuYQp2NayNRNshuChryKfNo2f3cm4JCXY=;
        h=From:To:Cc:Subject:Date:From;
        b=GV9kJsNUsiY/Q+qLkcIuiel5nUloTZK4ZarDmjicdtyxyFAgT0rS+PpEzqyt9qx05
         i6fJO5FngC0tO7xd4CguUhmv1uvsW5xMCYoQoWkEdPWpJqEnAsboBlf6HlGJZN8qg7
         haACXVmigM4icl+VNKp9uJfWUiS+wSzFOFOa9K7sN4Fa75Vrw18xGSS710cdU6Qy5O
         nydpQoexlzmVBMupPBbJEAtquvrazqauPkoDzNro4fQS0r/6cWmrHEraYRRPerRa5b
         46/NLkNjMOG91MK+QgAuMsYeDxmf9IXdBaDOonuTBhLtXJeAgXRYDUuEe5PZpGpw/b
         aR+HSixh2E8ew==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: introduce mt7921_mcu_sta_add routine
Date:   Mon, 19 Apr 2021 14:03:00 +0200
Message-Id: <6fb96181ef9342298aee5e4e0830845a43649ac8.1618833719.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921_mcu_sta_add will be used to add and remove wtbl entries.
Create broadcast wtbl entry after AP association

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 24 ++++---------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 20 ++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 255a931675bb..80630f70b7b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -622,8 +622,10 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_PS)
 		mt7921_mcu_uni_bss_ps(dev, vif);
 
-	if (changed & BSS_CHANGED_ASSOC)
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7921_mcu_sta_add(dev, NULL, vif, true);
 		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
+	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
@@ -641,15 +643,6 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	int rssi = -ewma_rssi_read(&mvif->rssi);
-	struct mt76_sta_cmd_info info = {
-		.sta = sta,
-		.vif = vif,
-		.enable = true,
-		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
-		.wcid = &msta->wcid,
-		.rcpi = to_rcpi(rssi),
-	};
 	int ret, idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
@@ -676,7 +669,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ret = mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
+	ret = mt7921_mcu_sta_add(dev, sta, vif, true);
 	if (ret)
 		return ret;
 
@@ -690,18 +683,11 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
-	struct mt76_sta_cmd_info info = {
-		.sta = sta,
-		.vif = vif,
-		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
-		.wcid = &msta->wcid,
-	};
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
-
+	mt7921_mcu_sta_add(dev, sta, vif, false);
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c00295b63ba8..5bdb9914ead8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1264,6 +1264,26 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				 sizeof(req), false);
 }
 
+int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+		       struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int rssi = -ewma_rssi_read(&mvif->rssi);
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.enable = enable,
+		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.rcpi = to_rcpi(rssi),
+	};
+	struct mt7921_sta *msta;
+
+	msta = sta ? (struct mt7921_sta *)sta->drv_priv : NULL;
+	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
+
+	return mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
+}
+
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c9687c57cbe7..d29af18d0205 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -261,6 +261,8 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
 int mt7921_set_channel(struct mt7921_phy *phy);
+int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+		       struct ieee80211_vif *vif, bool enable);
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
-- 
2.30.2

