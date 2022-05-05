Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953651B87B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbiEEHMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245699AbiEEHMb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 03:12:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3E946B3F
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 00:08:48 -0700 (PDT)
X-UUID: b7962827cec8498da237b009b0f53705-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5bf26b9a-361a-4828-b750-00cb63f7b775,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:5bf26b9a-361a-4828-b750-00cb63f7b775,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:8c59a6b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:07161d55507e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: b7962827cec8498da237b009b0f53705-20220505
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1234211795; Thu, 05 May 2022 15:08:42 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 15:08:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 May 2022 15:08:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 5 May 2022 15:08:41 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7915: introduce mt7915_mac_severe_check()
Date:   Thu, 5 May 2022 15:08:35 +0800
Message-ID: <84227dadf436ac1bef9cdfe5edff1f251ef4647e.1651722608.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <40f31a4550ff357468798a5950a62ceec396cbeb.1651722608.git.ryder.lee@mediatek.com>
References: <40f31a4550ff357468798a5950a62ceec396cbeb.1651722608.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In rare cases, TRB pointers might be out of sync leads to RMAC stopping
Rx that requires minimal recovery, so add this helper to periodically
check TRB status.

Tested-by: Chad Monroe <chad.monroe@smartrg.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 27 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  8 ++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 803e5e05a40a..de317e871577 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2307,6 +2307,32 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	}
 }
 
+static void mt7915_mac_severe_check(struct mt7915_phy *phy)
+{
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	u32 trb;
+
+	if (!phy->omac_mask)
+		return;
+
+	/* In rare cases, TRB pointers might be out of sync leads to RMAC
+	 * stopping Rx, so check status periodically to see if TRB hardware
+	 * requires minimal recovery.
+	 */
+	trb = mt76_rr(dev, MT_TRB_RXPSR0(phy->band_idx));
+
+	if ((FIELD_GET(MT_TRB_RXPSR0_RX_RMAC_PTR, trb) !=
+	     FIELD_GET(MT_TRB_RXPSR0_RX_WTBL_PTR, trb)) &&
+	    (FIELD_GET(MT_TRB_RXPSR0_RX_RMAC_PTR, phy->trb_ts) !=
+	     FIELD_GET(MT_TRB_RXPSR0_RX_WTBL_PTR, phy->trb_ts)) &&
+	    trb == phy->trb_ts)
+		mt7915_mcu_set_ser(dev, SER_RECOVER, SER_SET_RECOVER_L3_RX_ABORT,
+				   ext_phy);
+
+	phy->trb_ts = trb;
+}
+
 void mt7915_mac_sta_rc_work(struct work_struct *work)
 {
 	struct mt7915_dev *dev = container_of(work, struct mt7915_dev, rc_work);
@@ -2359,6 +2385,7 @@ void mt7915_mac_work(struct work_struct *work)
 		mphy->mac_work_count = 0;
 
 		mt7915_mac_update_stats(phy);
+		mt7915_mac_severe_check(phy);
 	}
 
 	mutex_unlock(&mphy->dev->mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 419ff08176b4..42e195dded01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -247,6 +247,8 @@ struct mt7915_phy {
 
 	u8 rdd_state;
 
+	u32 trb_ts;
+
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 1a7f95223be1..7415118f6399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -173,6 +173,14 @@ enum offs_rev {
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
 
+/* TRB: band 0(0x820e1000), band 1(0x820f1000) */
+#define MT_WF_TRB_BASE(_band)		((_band) ? 0x820f1000 : 0x820e1000)
+#define MT_WF_TRB(_band, ofs)		(MT_WF_TRB_BASE(_band) + (ofs))
+
+#define MT_TRB_RXPSR0(_band)		MT_WF_TRB(_band, 0x03c)
+#define MT_TRB_RXPSR0_RX_WTBL_PTR	GENMASK(25, 16)
+#define MT_TRB_RXPSR0_RX_RMAC_PTR	GENMASK(9, 0)
+
 /* TMAC: band 0(0x820e4000), band 1(0x820f4000) */
 #define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
 #define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
-- 
2.29.2

