Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A794878E679
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 08:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbjHaG0K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbjHaG0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 02:26:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B473CED
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 23:25:31 -0700 (PDT)
X-UUID: da6b7e1a47c611ee9cb5633481061a41-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kLrbqG6BBu1LhAM6dju01q/E6vYdtfR/xx5c9sX3XpU=;
        b=LN77+YsM6JwW0fablGNh7wLbNjOOj+qRY9b59IXE+iqxCaHOVPAsCkft0Hd8wQJHcnRXHWn1D4vLhpIWaq4AdOYw/znxpMYc/3OpxszrC7QdgWy1W5pCf+PjfdpUnpEf9RsHkvNPPWKJl56OVgcTR3huisxqIVOUqnjjfsYAVws=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:bc1c96da-b74a-48c3-9029-7eaebf74246a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:aee2f31f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: da6b7e1a47c611ee9cb5633481061a41-20230831
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1951032283; Thu, 31 Aug 2023 14:23:08 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:23:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:23:07 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>
Subject: [PATCH 4/9] wifi: mt76: fix potential memory leak of beacon commands
Date:   Thu, 31 Aug 2023 14:22:16 +0800
Message-ID: <20230831062221.20027-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230831062221.20027-1-shayne.chen@mediatek.com>
References: <20230831062221.20027-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Fix potential memory leak when setting beacon and inband discovery
commands.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 ++++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8350f84c7644..f18dc777edcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1927,8 +1927,10 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
 	}
 
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	info = IEEE80211_SKB_CB(skb);
 	info->control.vif = vif;
@@ -1940,6 +1942,7 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	if (skb->len > MT7915_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1996,11 +1999,14 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	if (skb->len > MT7915_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index b26396b2f87b..4de0c4a97fc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2252,11 +2252,14 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 		return PTR_ERR(rskb);
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	if (skb->len > MT7996_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2316,11 +2319,14 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
 	}
 
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	if (skb->len > MT7996_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
-- 
2.39.2

