Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A578E6AD
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 08:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbjHaGjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjHaGjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 02:39:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E55A8
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 23:39:29 -0700 (PDT)
X-UUID: e1235ae847c611ee9cb5633481061a41-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2BQ5k0c1fa9EX4Jc4eN7bzgTA+y3p2TeMgFCyb5KV3M=;
        b=AQVBIi+e3t7XPfiD9udJL9ZMplidNMIaRCahvRL26FJfZHZUFjSCL0ruRfxG2w02D+Kd0IZNoCBAyo5FIOUQ4twlZjDAm4S/RWcmmSAGpAIQMM6aIcUorCHdkeApE7YVMO1KdDAw5Y4Xwl58TC1uCsUfUz9LzCrPIq2PuYDEl8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:54e2f8d3-73ae-4ec8-bbae-f31460bf422a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:71797ac2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e1235ae847c611ee9cb5633481061a41-20230831
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 273159705; Thu, 31 Aug 2023 14:23:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:23:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:23:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 6/9] wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison
Date:   Thu, 31 Aug 2023 14:22:18 +0800
Message-ID: <20230831062221.20027-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230831062221.20027-1-shayne.chen@mediatek.com>
References: <20230831062221.20027-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the correct ieee80211_conf of each band for IEEE80211_CONF_MONITOR
comparison.

Fixes: 24e69f6bc3ca ("mt76: fix monitor rx FCS error in DFS channel")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8d745c9730c7..955974a82180 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2147,7 +2147,7 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 	};
 
 	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
-	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	    phy->mt76->hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
 	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 94a091dd155e..a203f90367f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2742,7 +2742,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	if (mt76_connac_spe_idx(phy->mt76->antenna_mask))
 		req.tx_path_num = fls(phy->mt76->antenna_mask);
 
-	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
 	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
 		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ebd0a9a6310e..27250e7a077d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3182,7 +3182,7 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
 		.channel_band = ch_band[chandef->chan->band],
 	};
 
-	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
 	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
 		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
-- 
2.39.2

