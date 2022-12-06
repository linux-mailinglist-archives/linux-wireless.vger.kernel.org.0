Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D450643AC0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 02:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiLFBb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 20:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiLFBb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 20:31:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B681E3EE
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 17:31:26 -0800 (PST)
X-UUID: b38e1c255f674f4b9744ef1a3bee7825-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rf2xlHbnDoi+Wpwgi2HpILhMqC3GA1rq9G2fhy9H4X4=;
        b=tkQ8Jtd662x3QmtmTYhDzSZ6cK6SHT92ApiHeYOlCfr+UT0kQa/ZDgoF4jYEgYERRi+QDKVPaT2UhAjfl+OpgRUbU6lm6PaiX9f9jADuQtZYjCjbh3qJx8mDnjX3cMzD3L+B2D2eXnOWU6fp3wIC2ANQe0lGNMpDVGPtKJL5AcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:8e1cd9cf-8a27-44d4-b60a-767b99c1e6b4,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:8e1cd9cf-8a27-44d4-b60a-767b99c1e6b4,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:e472a016-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:221206093125MAWOBAQD,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b38e1c255f674f4b9744ef1a3bee7825-20221206
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 846715754; Tue, 06 Dec 2022 09:31:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 6 Dec 2022 09:31:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 6 Dec 2022 09:31:22 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling()
Date:   Tue, 6 Dec 2022 09:29:51 +0800
Message-ID: <20221206012951.10719-4-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221206012951.10719-1-howard-yh.hsu@mediatek.com>
References: <20221206012951.10719-1-howard-yh.hsu@mediatek.com>
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

Fixes: afab0e8202ff ("mt76: mt7915: add thermal cooling device support")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b2652de082ba..e1b6d644cc14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3070,18 +3070,22 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
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
 
 		req.ctrl.ctrl_id = THERMAL_PROTECT_DUTY_CONFIG;
 		req.ctrl.duty.duty_level = level;
@@ -3101,7 +3105,6 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 	req.trigger_temp = cpu_to_le32(phy->throttle_temp[1]);
 	req.sustain_time = cpu_to_le16(10);
 
-out:
 	req.ctrl.type.protect_type = 1;
 	req.ctrl.type.trigger_type = 1;
 
-- 
2.18.0

