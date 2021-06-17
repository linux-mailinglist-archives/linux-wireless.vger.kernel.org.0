Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B105B3ABD9C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhFQUlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 16:41:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33029 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231225AbhFQUlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 16:41:21 -0400
X-UUID: 9285e23c43814fc2a218dc6cb9cc6d1c-20210618
X-UUID: 9285e23c43814fc2a218dc6cb9cc6d1c-20210618
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2048731016; Fri, 18 Jun 2021 04:39:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 04:39:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 04:39:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/3] mt76: use IEEE80211_OFFLOAD_ENCAP_ENABLED instead of MT_DRV_AMSDU_OFFLOAD
Date:   Fri, 18 Jun 2021 04:39:00 +0800
Message-ID: <663aa26553da45eeb15c59721447db4ed7fc18ef.1623961575.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <177785418cf407808bf3a44760302d0647076990.1623961575.git.ryder.lee@mediatek.com>
References: <177785418cf407808bf3a44760302d0647076990.1623961575.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop MT_DRV_AMSDU_OFFLOAD after introducing IEEE80211_OFFLOAD_ENCAP_ENABLED
flag in mac80211. Driver now checks vif->offload_flags to know encap offload
status of each interface.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2: squash patch 2/4 and 3/4 from v1
---
 drivers/net/wireless/mediatek/mt76/mac80211.c        |  8 ++------
 drivers/net/wireless/mediatek/mt76/mt76.h            |  1 -
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 10 ++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  3 +--
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ebd59d7e5837..89d09187655b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -322,12 +322,8 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-
-	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
-		ieee80211_hw_set(hw, TX_AMSDU);
-		ieee80211_hw_set(hw, TX_FRAG_LIST);
-	}
-
+	ieee80211_hw_set(hw, TX_AMSDU);
+	ieee80211_hw_set(hw, TX_FRAG_LIST);
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c7085d6cdcc4..6ee29b684f24 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -343,7 +343,6 @@ struct mt76_hw_cap {
 #define MT_DRV_SW_RX_AIRTIME		BIT(2)
 #define MT_DRV_RX_DMA_HDR		BIT(3)
 #define MT_DRV_HW_MGMT_TXQ		BIT(4)
-#define MT_DRV_AMSDU_OFFLOAD		BIT(5)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index b155e7b8d89d..e56713425860 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -406,10 +406,12 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 	htr = (struct wtbl_hdr_trans *)tlv;
 	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		htr->to_ds = true;
-	else
-		htr->from_ds = true;
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			htr->to_ds = true;
+		else
+			htr->from_ds = true;
+	}
 
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
 		htr->to_ds = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 340b364da5f0..e5a3f0ddaec3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -222,8 +222,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7915_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
-			     MT_DRV_AMSDU_OFFLOAD,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 13263f50dc00..0aed1d061316 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -94,8 +94,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7921_txp_common),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
-			     MT_DRV_AMSDU_OFFLOAD,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
-- 
2.18.0

