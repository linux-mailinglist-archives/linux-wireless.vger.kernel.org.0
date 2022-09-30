Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D915F0E89
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiI3PNz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiI3PNx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:13:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2368F129359
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:13:51 -0700 (PDT)
X-UUID: 75cee69c97574b7d8be39a444fbcc310-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VAcWbFOXDxoISljdIrQLvVsaajg+seadsVMOrc7A3+U=;
        b=pDvIHLCcfGOPExLXETcM6kAHYt9cqptGcAOvywl2iu05COg6dHUE0IMr2lpVTsDDIhYvql78lQx4hz2EnALPZmCl4DBaaG0zyYVF7vLye5t6H341RqifeNGwPDNBZrtWfFjL6ppFxuMk1vxxeYNX1k08UgYNA+yI5ffR+gTduQ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:51f1ede6-edee-49d4-a66b-e5a4c61d6c9a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:f34fcde4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 75cee69c97574b7d8be39a444fbcc310-20220930
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1149450764; Fri, 30 Sep 2022 23:13:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 23:13:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 23:13:45 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 6/6] wifi: mt76: mt7915: set correct antenna for radar detection on MT7915D
Date:   Fri, 30 Sep 2022 23:13:15 +0800
Message-ID: <20220930151315.19012-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220930151315.19012-1-shayne.chen@mediatek.com>
References: <20220930151315.19012-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For MT7915D, correct antenna index should be set to let DFS radar
detection work on the 5 GHz band.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c   | 15 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index be97dede2634..43a7a639cc88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1814,6 +1814,13 @@ static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
 	if (err < 0)
 		return err;
 
+	if (is_mt7915(&dev->mt76)) {
+		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_SET_WF_ANT, chain,
+					      0, dev->dbdc_support ? 2 : 0);
+		if (err < 0)
+			return err;
+	}
+
 	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_DET_MODE, chain,
 				       MT_RX_SEL0, 1);
 }
@@ -1934,6 +1941,14 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	if (err < 0)
 		return err;
 
+	if (is_mt7915(&dev->mt76)) {
+		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_SET_WF_ANT,
+					      phy->band_idx, 0,
+					      dev->dbdc_support ? 2 : 0);
+		if (err < 0)
+			return err;
+	}
+
 	mt7915_dfs_stop_radar_detector(phy);
 	phy->mt76->dfs_state = MT_DFS_STATE_DISABLED;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1eb11617a625..c90a148d6239 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -357,6 +357,7 @@ enum mt7915_rdd_cmd {
 	RDD_DET_MODE,
 	RDD_RADAR_EMULATE,
 	RDD_START_TXQ = 20,
+	RDD_SET_WF_ANT = 30,
 	RDD_CAC_START = 50,
 	RDD_CAC_END,
 	RDD_NORMAL_START,
-- 
2.25.1

