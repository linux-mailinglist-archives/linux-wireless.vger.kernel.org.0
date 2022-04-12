Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666674FEB78
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 01:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiDLXb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiDLXbd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D1715DA95
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 15:27:33 -0700 (PDT)
X-UUID: c7a571377cef4cfba451bf3e60a72cb5-20220413
X-UUID: c7a571377cef4cfba451bf3e60a72cb5-20220413
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1296710448; Wed, 13 Apr 2022 06:27:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 13 Apr 2022 06:27:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Apr 2022 06:27:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: remove SCS feature
Date:   Wed, 13 Apr 2022 06:27:24 +0800
Message-ID: <aa178b016b404139700618aca64222a8cec0ca8d.1649802160.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SCS is obsoleted and no longer used, so remove it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h |  1 -
 drivers/net/wireless/mediatek/mt76/mt7915/main.c |  8 --------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 16 ----------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h  | 10 ----------
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h   |  1 -
 5 files changed, 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c3c93338d56a..561fb0368708 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -974,7 +974,6 @@ enum {
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
 	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
-	MCU_EXT_CMD_SCS_CTRL = 0x82,
 	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_OFFCH_SCAN_CTRL = 0x9a,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 9b8defb15b4e..5177b19f9154 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -42,10 +42,6 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		if (ret)
 			goto out;
 
-		ret = mt7915_mcu_set_scs(dev, 0, true);
-		if (ret)
-			goto out;
-
 		mt7915_mac_enable_nf(dev, 0);
 	}
 
@@ -58,10 +54,6 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		if (ret)
 			goto out;
 
-		ret = mt7915_mcu_set_scs(dev, 1, true);
-		if (ret)
-			goto out;
-
 		mt7915_mac_enable_nf(dev, 1);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 736c9c342baa..4bceba87fd8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2589,22 +2589,6 @@ int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band,
 				 &req_mac, sizeof(req_mac), true);
 }
 
-int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable)
-{
-	struct {
-		__le32 cmd;
-		u8 band;
-		u8 enable;
-	} __packed req = {
-		.cmd = cpu_to_le32(SCS_ENABLE),
-		.band = band,
-		.enable = enable + 1,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SCS_CTRL), &req,
-				 sizeof(req), false);
-}
-
 int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *param)
 {
 	struct mt7915_mcu_tx *req = (struct mt7915_mcu_tx *)param;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 960072a44222..064d33e33738 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -304,16 +304,6 @@ enum mcu_mmps_mode {
 	MCU_MMPS_DISABLE,
 };
 
-enum {
-	SCS_SEND_DATA,
-	SCS_SET_MANUAL_PD_TH,
-	SCS_CONFIG,
-	SCS_ENABLE,
-	SCS_SHOW_INFO,
-	SCS_GET_GLO_ADDR,
-	SCS_GET_GLO_ADDR_EVENT,
-};
-
 struct bss_info_bmc_rate {
 	__le16 tag;
 	__le16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ca129e5e380e..419ff08176b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -486,7 +486,6 @@ int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 		       bool hdr_trans);
 int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 			      u8 en);
-int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable);
 int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
-- 
2.29.2

