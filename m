Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE12CEB0B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 10:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgLDJiB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 04:38:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54808 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726986AbgLDJh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 04:37:58 -0500
X-UUID: f05a887e5ade4e24b087576f3c91cb82-20201204
X-UUID: f05a887e5ade4e24b087576f3c91cb82-20201204
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1690865228; Fri, 04 Dec 2020 17:37:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 17:37:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 17:37:08 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/5] mt76: mt7915: add partial add_bss_info command on testmode init
Date:   Fri, 4 Dec 2020 17:36:55 +0800
Message-ID: <20201204093659.20384-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch for DBDC and ipg config support
in testmode.

The wmm_idx of band1 should be configured by this command to
make band1 Tx work normally. Also, for setting ipg, FW needs a
non-empty bss_info structure to do edca parameters update.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6097653abda4..623b7b6d9e83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -674,6 +674,7 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MONITOR:
 		break;
 	case NL80211_IFTYPE_STATION:
 		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
@@ -702,16 +703,21 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	}
 
 	bss = (struct bss_info_basic *)tlv;
-	memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
-	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 	bss->network_type = cpu_to_le32(type);
-	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->bmc_wcid_lo = to_wcid_lo(wlan_idx);
 	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
-	bss->phy_mode = mt7915_get_phy_mode(phy->dev, vif, band, NULL);
 	bss->wmm_idx = mvif->wmm_idx;
 	bss->active = enable;
 
+	if (vif->type != NL80211_IFTYPE_MONITOR) {
+		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
+		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+		bss->dtim_period = vif->bss_conf.dtim_period;
+		bss->phy_mode = mt7915_get_phy_mode(phy->dev, vif, band, NULL);
+	} else {
+		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
+	}
+
 	return 0;
 }
 
@@ -727,6 +733,7 @@ mt7915_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
 
 	switch (vif->type) {
+	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
 		type = CONNECTION_INFRA_AP;
@@ -996,6 +1003,9 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 
 	mt7915_mcu_bss_basic_tlv(skb, vif, phy, enable);
 
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		goto out;
+
 	if (enable) {
 		mt7915_mcu_bss_rfch_tlv(skb, vif, phy);
 		mt7915_mcu_bss_bmc_tlv(skb, phy);
@@ -1009,7 +1019,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 		    mvif->omac_idx < REPEATER_BSSID_START)
 			mt7915_mcu_bss_ext_tlv(skb, mvif);
 	}
-
+out:
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, skb,
 				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 9ee82e2d262c..fe56ab18e974 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -192,6 +192,8 @@ mt7915_tm_init(struct mt7915_dev *dev)
 	mt7915_tm_mode_ctrl(dev, en);
 	mt7915_tm_reg_backup_restore(dev, &dev->phy);
 	mt7915_tm_set_trx(dev, &dev->phy, TM_MAC_TXRX, !en);
+
+	mt7915_mcu_add_bss_info(&dev->phy, dev->phy.monitor_vif, en);
 }
 
 static void
-- 
2.17.1

