Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485564C321
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 05:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiLNEUO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 23:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiLNEUM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 23:20:12 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600E26D9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 20:20:07 -0800 (PST)
X-UUID: 3bc3e67eef7647bab818e84cf62c54e2-20221214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gjgWf+nNweGdAjzb9i9IUL2kpUv96rq6qUQ5X2JeHOA=;
        b=clUUy7FpfF8rZYcMgwpxdWNB72omvPVQmgPCyXf1rAHEQZA/LQxsva7o57so2iLniK6yFMFwjaDdACvxaUI2jjIQw4uO0IDzYGKcckunAHA6RTgkpOhIgH5liHkum6Sd/Tx8WY5zDpvqi/bT/OWJ3VjFkKPFlfmkpQ2hh4Tobdw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:5aa9340c-a688-48a0-9b28-94f685c9b351,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:5aa9340c-a688-48a0-9b28-94f685c9b351,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:f8938ed2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:2212141028171DVSOJSK,BulkQuantity:7,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 3bc3e67eef7647bab818e84cf62c54e2-20221214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2104895415; Wed, 14 Dec 2022 12:20:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Wed, 14 Dec 2022 04:20:00 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 14 Dec 2022 10:28:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 14 Dec 2022 10:28:14 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v3 1/4] wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work
Date:   Wed, 14 Dec 2022 10:28:06 +0800
Message-ID: <20221214022809.32087-2-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
References: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable thermal management by default shall not be executed during mcu
init. This causes thermal configuration being reset to the firmware
default settings.

Fixes: 0063b86c9120 ("mt76: mt7915e: Enable thermal management by default")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 571c94835942..11407e18e56a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -201,8 +201,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	phy->throttle_temp[0] = 110;
 	phy->throttle_temp[1] = 120;
 
-	return mt7915_mcu_set_thermal_throttling(phy,
-						 MT7915_THERMAL_THROTTLE_MAX);
+	return 0;
 }
 
 static void mt7915_led_set_config(struct led_classdev *led_cdev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0511d6a505b0..98af032eba09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -57,6 +57,12 @@ int mt7915_run(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, phy->mt76->band_idx);
 	}
 
+	ret = mt7915_mcu_set_thermal_throttling(phy,
+						MT7915_THERMAL_THROTTLE_MAX);
+
+	if (ret)
+		goto out;
+
 	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b,
 					     phy->mt76->band_idx);
 	if (ret)
-- 
2.18.0

