Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804C6F3C40
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 05:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEBDKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 23:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjEBDKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 23:10:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91340FC
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 20:10:16 -0700 (PDT)
X-UUID: d9311bc0e89611ed9cb5633481061a41-20230502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ct8qeOqaCbl07nxC74X68VbEEBx8z8hIwt1tsyJaVB8=;
        b=vG3WUa8IuvZ4r6j3LSziPt6CtDUd2bU6+Nw97Ax+rMm06UNfQEqQS46lgsodU+goamrn638FWpqUQA1Ogwj46qtjossE58QrbrbnfW2Xrjkmt6Dz7QluenXnEmHExhcYCTh78I9+SiEcMVm0i8H6eOjElsfVV1PqPepMuVdazEA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:94c4ac74-0003-4ae2-8a4c-d0b347cb1206,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:14df7230-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d9311bc0e89611ed9cb5633481061a41-20230502
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 40859370; Tue, 02 May 2023 11:10:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 May 2023 11:10:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 May 2023 11:10:09 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 2/2] wifi: mt76: mt7615: enable BSS_CHANGED_MU_GROUPS support
Date:   Tue, 2 May 2023 11:10:06 +0800
Message-ID: <3ca2a7a8154d0a661eef6ef0b172b6ae73735780.1682971025.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <0a7809914a0c480ed4761158142e3c7d2f41ca76.1682971025.git.ryder.lee@mediatek.com>
References: <0a7809914a0c480ed4761158142e3c7d2f41ca76.1682971025.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Group ID Management frame is an Action frame of category VHT.
It is transmitted by the AP to assign or change the user position
of a STA for one or more group IDs.

Also, sniffer can use a given group id to monitor STA that belongs
to that group.

Notify underlying driver of changes via BSS_CHANGED_MU_GROUPS.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  5 +++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 29 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  9 ++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 621e69f07e3c..2dbc17de780f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -395,8 +395,11 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_scan_ssids = 4;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+	if (!is_mt7622(&phy->dev->mt76)) {
+		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
+	}
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ab4c1b4478aa..ea84615d2a9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -553,6 +553,32 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 	mt7615_mutex_release(dev);
 }
 
+static void
+mt7615_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_bss_conf *info)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	u8 i, band = mvif->mt76.band_idx;
+	u32 *mu;
+
+	mu = (u32 *)info->mu_group.membership;
+	for (i = 0; i < WLAN_MEMBERSHIP_LEN / sizeof(*mu); i++) {
+		if (is_mt7663(&dev->mt76))
+			mt76_wr(dev, MT7663_WF_PHY_GID_TAB_VLD(band, i), mu[i]);
+		else
+			mt76_wr(dev, MT_WF_PHY_GID_TAB_VLD(band, i), mu[i]);
+	}
+
+	mu = (u32 *)info->mu_group.position;
+	for (i = 0; i < WLAN_USER_POSITION_LEN / sizeof(*mu); i++) {
+		if (is_mt7663(&dev->mt76))
+			mt76_wr(dev, MT7663_WF_PHY_GID_TAB_POS(band, i), mu[i]);
+		else
+			mt76_wr(dev, MT_WF_PHY_GID_TAB_POS(band, i), mu[i]);
+	}
+}
+
 static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -601,6 +627,9 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC)
 		mt7615_mac_set_beacon_filter(phy, vif, vif->cfg.assoc);
 
+	if (changed & BSS_CHANGED_MU_GROUPS)
+		 mt7615_update_mu_group(hw, vif, info);
+
 	mt7615_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 7cecb22c569e..806b3887c541 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -212,6 +212,15 @@ enum mt7615_reg_base {
 
 #define MT7663_WF_PHY_R0_PHYCTRL_STS5(_phy)	MT_WF_PHY(0x0224 + ((_phy) << 12))
 
+#define MT_WF_PHY_GID_TAB_VLD(_phy, i)		MT_WF_PHY(0x0254 + (i) * 4 + \
+							  ((_phy) << 9))
+#define MT7663_WF_PHY_GID_TAB_VLD(_phy, i)	MT_WF_PHY(0x0254 + (i) * 4 + \
+							  ((_phy) << 12))
+#define MT_WF_PHY_GID_TAB_POS(_phy, i)		MT_WF_PHY(0x025c + (i) * 4 + \
+							  ((_phy) << 9))
+#define MT7663_WF_PHY_GID_TAB_POS(_phy, i)	MT_WF_PHY(0x025c + (i) * 4 + \
+							  ((_phy) << 12))
+
 #define MT_WF_PHY_MIN_PRI_PWR(_phy)	MT_WF_PHY((_phy) ? 0x084 : 0x229c)
 #define MT_WF_PHY_PD_OFDM_MASK(_phy)	((_phy) ? GENMASK(24, 16) : \
 					 GENMASK(28, 20))
-- 
2.18.0

