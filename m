Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB737DEF74
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjKBKD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346100AbjKBKD5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 06:03:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B09189
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 03:03:50 -0700 (PDT)
X-UUID: 1c40ed9e796711eea33bb35ae8d461a2-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AVuruGKExHh3HSXR06X4IT5K2QylDkjTAn3G6LSOgl0=;
        b=L3TfnpJmrJ20WDBxfKaTXavvYP4LJaowcnY9OthgW99FIEEGbTngiz0d6OoBqnVU5C9pRAw7AxjzxkdONPrML3lUkHrY9BYxoHT/ffWxLzudjO9LoSOJOxOEPby5aeqLzQVJz+X5JdV+c+jqIURMB5ZADEY6ScL+RTjaPxuQdao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:f5310135-3dbf-4bdd-9f94-5f4e1567d1d2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:f157ef94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1c40ed9e796711eea33bb35ae8d461a2-20231102
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1599193577; Thu, 02 Nov 2023 18:03:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 18:03:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 18:03:44 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Allen Ye <allen.ye@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/8] wifi: mt76: use chainmask for power delta calculation
Date:   Thu, 2 Nov 2023 18:02:57 +0800
Message-ID: <20231102100302.22160-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231102100302.22160-1-shayne.chen@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Allen Ye <allen.ye@mediatek.com>

The power gain value is related to total TX path, so change the
calculation to use per-phy chainmask.

Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 7725dd6763ef..53f5ef4120ca 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -379,7 +379,7 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	if (!np)
 		return target_power;
 
-	txs_delta = mt76_get_txs_delta(np, hweight8(phy->antenna_mask));
+	txs_delta = mt76_get_txs_delta(np, hweight16(phy->chainmask));
 
 	val = mt76_get_of_array(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
 	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6ee7be6eaab8..c15074bb24c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1537,7 +1537,7 @@ int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm)
 {
 	struct mt76_phy *phy = hw->priv;
-	int n_chains = hweight8(phy->antenna_mask);
+	int n_chains = hweight16(phy->chainmask);
 	int delta = mt76_tx_power_nss_delta(n_chains);
 
 	*dbm = DIV_ROUND_UP(phy->txpower_cur + delta, 2);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 1592b5d6751a..b41ac4aaced7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -519,7 +519,7 @@ static inline s8
 mt7915_get_power_bound(struct mt7915_phy *phy, s8 txpower)
 {
 	struct mt76_phy *mphy = phy->mt76;
-	int n_chains = hweight8(mphy->antenna_mask);
+	int n_chains = hweight16(mphy->chainmask);
 
 	txpower = mt76_get_sar_power(mphy, mphy->chandef.chan, txpower * 2);
 	txpower -= mt76_tx_power_nss_delta(n_chains);
-- 
2.39.2

