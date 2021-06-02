Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45608398F78
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhFBQCH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 12:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFBQCH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 12:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EEA361493;
        Wed,  2 Jun 2021 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622649624;
        bh=OJjgoXYbGxjPMZdHDfCibjoF/fk0EWzNZJqfZ9iybtA=;
        h=From:To:Cc:Subject:Date:From;
        b=c9T1WzAsLumY0JAnO2ZalzfFvxImiWHRN3Zg6MmzW6m9IEzEqdeUqQk1KkFdS8/nb
         rHEOXnXRAZz86K+FuvL/ZuKw1M0VHeSt8T5nqOFZ3vWPZcnXgFom3x1be6hOsj46+g
         fhvDDfqQ0y+OaNcyr4iUno726znv5Jpd45h1td+camlt4MLADB107NagUG1pL9PFoE
         1BM2VExl5LTYK85VL3ec9jNdb913j/QMEc4UF7p/+JWoppv/fYMbzq8XFHysq1uwLO
         vsn34qYjlk82SWPxBeflqZGzmXVrknpDd+SDHqdyGncyrXgOBEViGcTDnK5qkVwrwC
         IV4XC9aBh4Kyg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: connac: fix UC entry is being overwritten
Date:   Wed,  2 Jun 2021 18:00:14 +0200
Message-Id: <3d30cb9e40df970e2f4ef09c975f9fd6f7dc02dd.1622649436.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix UC entry is being overwritten by BC entry

Tested-by: Deren Wu <deren.wu@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 10 ++++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  1 +
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fc9cd8da2a11..42d615322477 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1144,12 +1144,14 @@ mt7615_mcu_sta_rx_ba(struct mt7615_dev *dev,
 
 static int
 __mt7615_mcu_add_sta(struct mt76_phy *phy, struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta, bool enable, int cmd)
+		     struct ieee80211_sta *sta, bool enable, int cmd,
+		     bool offload_fw)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt76_sta_cmd_info info = {
 		.sta = sta,
 		.vif = vif,
+		.offload_fw = offload_fw,
 		.enable = enable,
 		.cmd = cmd,
 	};
@@ -1163,7 +1165,7 @@ mt7615_mcu_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta, bool enable)
 {
 	return __mt7615_mcu_add_sta(phy->mt76, vif, sta, enable,
-				    MCU_EXT_CMD_STA_REC_UPDATE);
+				    MCU_EXT_CMD_STA_REC_UPDATE, false);
 }
 
 static int
@@ -1298,7 +1300,7 @@ mt7615_mcu_uni_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable)
 {
 	return __mt7615_mcu_add_sta(phy->mt76, vif, sta, enable,
-				    MCU_UNI_CMD_STA_REC_UPDATE);
+				    MCU_UNI_CMD_STA_REC_UPDATE, true);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 73359defa176..1dfdc90985c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -875,10 +875,12 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable);
-	if (info->enable && info->sta)
-		mt76_connac_mcu_sta_tlv(phy, skb, info->sta, info->vif,
-					info->rcpi);
+	if (info->sta || !info->offload_fw)
+		mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta,
+					      info->enable);
+	if (info->sta && info->enable)
+		mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
+					info->vif, info->rcpi);
 
 	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
 					   sizeof(struct tlv));
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index d64b8058b744..53ea7f21a1f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -908,6 +908,7 @@ struct mt76_sta_cmd_info {
 
 	struct ieee80211_vif *vif;
 
+	bool offload_fw;
 	bool enable;
 	int cmd;
 	u8 rcpi;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ffc83717fd0d..bd94d1244975 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1277,6 +1277,7 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		.vif = vif,
 		.enable = enable,
 		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.offload_fw = true,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt7921_sta *msta;
-- 
2.31.1

