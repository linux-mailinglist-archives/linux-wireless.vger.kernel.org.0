Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12964C242
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 03:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiLNC23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 21:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLNC22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 21:28:28 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39051F9F3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 18:28:26 -0800 (PST)
X-UUID: 780db7423c9241df8a7a46b1d8390124-20221214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yD6+0YV8kKAnRu4TQIn+792RhOgKml45yCstoapdfk8=;
        b=G8kKMDgabndTLl7IntQ04oIUa6StSUEihXCrAfzKWQS+YqTW8PEsViI2/VzjCBKsgml75H5AnKh8FwW07We+EfrksWc3a0V86u7TN5K7/HXGGE36hBwtu5sSCjlbdKbJB3LQr4TQHO7TrJAMaRFeNW0Fi9SHkL1OgCfZ4NZ1Gqc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:d7de28a7-d068-4bab-b57f-55799c1d4cf9,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:c5077117-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 780db7423c9241df8a7a46b1d8390124-20221214
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 625535547; Wed, 14 Dec 2022 10:28:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 14 Dec 2022 10:28:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 14 Dec 2022 10:28:18 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v3 2/4] wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling
Date:   Wed, 14 Dec 2022 10:28:07 +0800
Message-ID: <20221214022809.32087-3-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
References: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch includes 2 changes:
1. Firmware expects to disable thermal protect first before
reconfiguring.
2. Separate setting thermal_protect and setting thermal_tx_duty into
different functions. These two firmware commands do not need to send
together.

Fixes: 34b877d972be ("mt76: mt7915: add thermal cooling device support")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 --
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 54 +++++++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 4 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 11407e18e56a..be435ae56bbf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -134,9 +134,6 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
 	if (state > MT7915_CDEV_THROTTLE_MAX)
 		return -EINVAL;
 
-	if (phy->throttle_temp[0] > phy->throttle_temp[1])
-		return 0;
-
 	if (state == phy->cdev_state)
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 98af032eba09..7589af4b3dab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -60,6 +60,11 @@ int mt7915_run(struct ieee80211_hw *hw)
 	ret = mt7915_mcu_set_thermal_throttling(phy,
 						MT7915_THERMAL_THROTTLE_MAX);
 
+	if (ret)
+		goto out;
+
+	ret = mt7915_mcu_set_thermal_protect(phy);
+
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 37a3c1f082d9..04d1da170fac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3077,6 +3077,29 @@ int mt7915_mcu_get_temperature(struct mt7915_phy *phy)
 }
 
 int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_mcu_thermal_ctrl req = {
+		.band_idx = phy->mt76->band_idx,
+		.ctrl_id = THERMAL_PROTECT_DUTY_CONFIG,
+	};
+	int level, ret;
+
+	/* set duty cycle and level */
+	for (level = 0; level < 4; level++) {
+		req.duty.duty_level = level;
+		req.duty.duty_cycle = state;
+		state /= 2;
+
+		ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
+					&req, sizeof(req), false);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+int mt7915_mcu_set_thermal_protect(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct {
@@ -3089,29 +3112,18 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 	} __packed req = {
 		.ctrl = {
 			.band_idx = phy->mt76->band_idx,
+			.type.protect_type = 1,
+			.type.trigger_type = 1,
 		},
 	};
-	int level;
-
-	if (!state) {
-		req.ctrl.ctrl_id = THERMAL_PROTECT_DISABLE;
-		goto out;
-	}
-
-	/* set duty cycle and level */
-	for (level = 0; level < 4; level++) {
-		int ret;
+	int ret;
 
-		req.ctrl.ctrl_id = THERMAL_PROTECT_DUTY_CONFIG;
-		req.ctrl.duty.duty_level = level;
-		req.ctrl.duty.duty_cycle = state;
-		state /= 2;
+	req.ctrl.ctrl_id = THERMAL_PROTECT_DISABLE;
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
+				&req, sizeof(req.ctrl), false);
 
-		ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
-					&req, sizeof(req.ctrl), false);
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	/* set high-temperature trigger threshold */
 	req.ctrl.ctrl_id = THERMAL_PROTECT_ENABLE;
@@ -3120,10 +3132,6 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 	req.trigger_temp = cpu_to_le32(phy->throttle_temp[1]);
 	req.sustain_time = cpu_to_le16(10);
 
-out:
-	req.ctrl.type.protect_type = 1;
-	req.ctrl.type.trigger_type = 1;
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
 				 &req, sizeof(req), false);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6351feba6bdf..855779f86bde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -543,6 +543,7 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
 int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch);
 int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
 int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state);
+int mt7915_mcu_set_thermal_protect(struct mt7915_phy *phy);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
-- 
2.18.0

