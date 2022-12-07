Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD264536C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 06:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLGFZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 00:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGFZq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 00:25:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8AF55C8D
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 21:25:45 -0800 (PST)
X-UUID: 1c927766c5724238a023611741b63057-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Jsfib5T7wSVjC6QbFl/gYrFKUGPmdooacuNRC3W5K6k=;
        b=b50//Sthinsa4tAoIu6SgH2itSAhbCtxUVtXdUtEFVJ0seStS5Lm8TCS6/Vtjpv27BI06lzPn88u7l6kn3Vc+hd4DpygxEYGrz2AeyG0alwOTMFU0vxyLLRewzM/tw/CEuDZYpDMALi0z6OUtY1yRHPY7a10WazZnA3yNGUWEiw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:70032062-a711-436d-a52d-4f81fb5ec6a5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:2150dfd1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1c927766c5724238a023611741b63057-20221207
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1124115990; Wed, 07 Dec 2022 13:25:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:25:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 13:25:40 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v2 3/3] wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling()
Date:   Wed, 7 Dec 2022 13:25:00 +0800
Message-ID: <20221207052500.10855-4-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221207052500.10855-1-howard-yh.hsu@mediatek.com>
References: <20221207052500.10855-1-howard-yh.hsu@mediatek.com>
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

Firmware expects to disable thermal protect first before reconfiguring.

Fixes: 34b877d972be ("mt76: mt7915: add thermal cooling device support")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b2652de082ba..176d293eb32a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3070,19 +3070,22 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 	} __packed req = {
 		.ctrl = {
 			.band_idx = phy->mt76->band_idx,
+			.type.protect_type = 1,
+			.type.trigger_type = 1,
 		},
 	};
-	int level;
+	int level, ret;
 
-	if (!state) {
-		req.ctrl.ctrl_id = THERMAL_PROTECT_DISABLE;
-		goto out;
-	}
+	req.ctrl.ctrl_id = THERMAL_PROTECT_DISABLE;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
+				&req, sizeof(req.ctrl), false);
+
+	if (ret || !state)
+		return ret;
 
 	/* set duty cycle and level */
 	for (level = 0; level < 4; level++) {
-		int ret;
-
 		req.ctrl.ctrl_id = THERMAL_PROTECT_DUTY_CONFIG;
 		req.ctrl.duty.duty_level = level;
 		req.ctrl.duty.duty_cycle = state;
@@ -3100,8 +3103,6 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 	req.restore_temp = cpu_to_le32(phy->throttle_temp[0] - 10);
 	req.trigger_temp = cpu_to_le32(phy->throttle_temp[1]);
 	req.sustain_time = cpu_to_le16(10);
-
-out:
 	req.ctrl.type.protect_type = 1;
 	req.ctrl.type.trigger_type = 1;
 
-- 
2.18.0

