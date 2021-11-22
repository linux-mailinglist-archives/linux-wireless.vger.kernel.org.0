Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2D458CCD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhKVK7m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 05:59:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42748 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232171AbhKVK7l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 05:59:41 -0500
X-UUID: b4d983ca8dac42cf9686a1c5902d361a-20211122
X-UUID: b4d983ca8dac42cf9686a1c5902d361a-20211122
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 845642086; Mon, 22 Nov 2021 18:56:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 22 Nov 2021 18:56:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 18:56:29 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix the wrong SMPS mode
Date:   Mon, 22 Nov 2021 18:56:26 +0800
Message-ID: <20211122105626.6275-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

Without this change, it sends the wrong SMPS mode to firmware
when a station sends an action frame with disabled SMPS.

Fixes: 427b09cd6bfa ("mt76: mt7915: fix SMPS operation fail")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c | 17 ++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h |  7 +++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ceeb5e3f..f922265f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2022,6 +2022,21 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
 }
 
+static enum mcu_mmps_mode
+mt7915_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
+{
+	switch (smps) {
+	case IEEE80211_SMPS_OFF:
+		return MCU_MMPS_DISABLE;
+	case IEEE80211_SMPS_STATIC:
+		return MCU_MMPS_STATIC;
+	case IEEE80211_SMPS_DYNAMIC:
+		return MCU_MMPS_DYNAMIC;
+	default:
+		return MCU_MMPS_DISABLE;
+	}
+}
+
 int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -2053,7 +2068,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 			ra->phy = *phy;
 		break;
 	case RATE_PARAM_MMPS_UPDATE:
-		ra->mmps_mode = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
+		ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->smps_mode);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 1beaba38..53fa0f01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -365,6 +365,13 @@ enum {
 	MCU_PHY_STATE_OFDMLQ_CNINFO,
 };
 
+enum mcu_mmps_mode {
+	MCU_MMPS_STATIC,
+	MCU_MMPS_DYNAMIC,
+	MCU_MMPS_RSV,
+	MCU_MMPS_DISABLE,
+};
+
 #define STA_TYPE_STA			BIT(0)
 #define STA_TYPE_AP			BIT(1)
 #define STA_TYPE_ADHOC			BIT(2)
-- 
2.29.2

