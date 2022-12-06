Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF9643AC2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 02:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiLFBbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 20:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLFBb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 20:31:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F181DF18
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 17:31:27 -0800 (PST)
X-UUID: 93b7f41405764a2eb841c651c5b1afd2-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zoVXkwUOmjVgqBFQ8Wiwthi4PPghZRvpSDeFn15tlbI=;
        b=pBi4Qye441nurPvungQPbOxga0ZqDof+uZozM9A0LLt94otHdHPM+XTg/XTEMnNexi48GsqBVJq4eeHDuqxGKnqqy9XAMkx9zqJq4BrzXan/VVyHUnCkehqrOTkYPzoO1bz1/r0SQBZIkfMVO3E7iO/8/+NwOMUVNsNfbuyFF3s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:015334ef-a6a4-4c5d-a72b-371320950ed0,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.14,REQID:015334ef-a6a4-4c5d-a72b-371320950ed0,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:dcaaed0,CLOUDID:8872a016-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:22120609312274RTOEHV,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 93b7f41405764a2eb841c651c5b1afd2-20221206
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 736439031; Tue, 06 Dec 2022 09:31:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 6 Dec 2022 09:31:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 6 Dec 2022 09:31:20 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work
Date:   Tue, 6 Dec 2022 09:29:50 +0800
Message-ID: <20221206012951.10719-3-howard-yh.hsu@mediatek.com>
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

Enable thermal management by default shall not be executed during mcu
init. This causes thermal configuration being reset to the firmware
default settings.

Fixes: c67df0d3130a ("mt76: mt7915e: Enable thermal management by default")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index abeecf15f1c8..8f4561eed5db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -204,8 +204,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	phy->throttle_temp[0] = 110;
 	phy->throttle_temp[1] = 120;
 
-	return mt7915_mcu_set_thermal_throttling(phy,
-						 MT7915_THERMAL_THROTTLE_MAX);
+	return 0;
 }
 
 static void mt7915_led_set_config(struct led_classdev *led_cdev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0511d6a505b0..fc87216e40b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -57,6 +57,11 @@ int mt7915_run(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, phy->mt76->band_idx);
 	}
 
+	ret = mt7915_mcu_set_thermal_throttling(phy, MT7915_THERMAL_THROTTLE_MAX);
+
+	if (ret)
+		goto out;
+
 	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b,
 					     phy->mt76->band_idx);
 	if (ret)
-- 
2.18.0

