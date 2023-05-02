Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0858D6F3C41
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 05:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjEBDKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 23:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjEBDKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 23:10:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034C40DA
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 20:10:17 -0700 (PDT)
X-UUID: d8cb213ae89611edb20a276fd37b9834-20230502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wQre5lq5KPulOOTISLtbugBiyYNx+lFX9Va3I8xt8is=;
        b=i69ilZ1tYsG8w2GQeXOAeUpV6eZuHtovG3I7lz3egamSkRw/+gFcxi+C9LEAu6dxmVEbrS0xr0822AYmHijR4gB4yFoU06CWnDM46XvZdU/8pZ8N1neIYHPXq0QMBrI+5YCrRiW34eC2UMLS+kcFko+1vM/Bpgf62tl31jekYMM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c542dea0-bf19-4edf-8e5a-82e29dbf4487,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:c542dea0-bf19-4edf-8e5a-82e29dbf4487,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:eede7230-6935-4eab-a959-f84f8da15543,B
        ulkID:230502111010VPEJDT28,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d8cb213ae89611edb20a276fd37b9834-20230502
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2012813520; Tue, 02 May 2023 11:10:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 2 May 2023 11:10:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 May 2023 11:10:08 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 1/2] wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS support
Date:   Tue, 2 May 2023 11:10:05 +0800
Message-ID: <0a7809914a0c480ed4761158142e3c7d2f41ca76.1682971025.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 23 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  | 21 +++++++++++------
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f1b48cdda58f..3569fef20cd9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -183,6 +183,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
 	if (!mdev->dev->of_node ||
 	    !of_property_read_bool(mdev->dev->of_node,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f2d0b2982c6b..cb99932318aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -537,6 +537,26 @@ mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return mvif->basic_rates_idx;
 }
 
+static void
+mt7996_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_bss_conf *info)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	u8 band = mvif->mt76.band_idx;
+	u32 *mu;
+
+	mu = (u32 *)info->mu_group.membership;
+	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_VLD0(band), mu[0]);
+	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_VLD1(band), mu[1]);
+
+	mu = (u32 *)info->mu_group.position;
+	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_POS0(band), mu[0]);
+	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_POS1(band), mu[1]);
+	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_POS2(band), mu[2]);
+	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_POS3(band), mu[3]);
+}
+
 static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -609,6 +629,9 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	    changed & BSS_CHANGED_FILS_DISCOVERY)
 		mt7996_mcu_beacon_inband_discov(dev, vif, changed);
 
+	if (changed & BSS_CHANGED_MU_GROUPS)
+		mt7996_update_mu_group(hw, vif, info);
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index df871361a7e1..43285328ce47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -559,22 +559,29 @@ enum base_rev {
 
 #define MT_PCIE1_MAC_INT_ENABLE			MT_PCIE1_MAC(0x188)
 
+/* PHYRX CSD */
+#define MT_WF_PHYRX_CSD_BASE			0x83000000
+#define MT_WF_PHYRX_CSD(_band, _wf, ofs)	(MT_WF_PHYRX_CSD_BASE + \
+						 ((_band) << 20) + \
+						 ((_wf) << 16) + (ofs))
+#define MT_WF_PHYRX_CSD_IRPI(_band, _wf)	MT_WF_PHYRX_CSD(_band, _wf, 0x1000)
+
 /* PHYRX CTRL */
 #define MT_WF_PHYRX_BAND_BASE			0x83080000
 #define MT_WF_PHYRX_BAND(_band, ofs)		(MT_WF_PHYRX_BAND_BASE + \
 						 ((_band) << 20) + (ofs))
 
+#define MT_WF_PHYRX_BAND_GID_TAB_VLD0(_band)	MT_WF_PHYRX_BAND(_band, 0x1054)
+#define MT_WF_PHYRX_BAND_GID_TAB_VLD1(_band)	MT_WF_PHYRX_BAND(_band, 0x1058)
+#define MT_WF_PHYRX_BAND_GID_TAB_POS0(_band)	MT_WF_PHYRX_BAND(_band, 0x105c)
+#define MT_WF_PHYRX_BAND_GID_TAB_POS1(_band)	MT_WF_PHYRX_BAND(_band, 0x1060)
+#define MT_WF_PHYRX_BAND_GID_TAB_POS2(_band)	MT_WF_PHYRX_BAND(_band, 0x1064)
+#define MT_WF_PHYRX_BAND_GID_TAB_POS3(_band)	MT_WF_PHYRX_BAND(_band, 0x1068)
+
 #define MT_WF_PHYRX_BAND_RX_CTRL1(_band)	MT_WF_PHYRX_BAND(_band, 0x2004)
 #define MT_WF_PHYRX_BAND_RX_CTRL1_IPI_EN	GENMASK(2, 0)
 #define MT_WF_PHYRX_BAND_RX_CTRL1_STSCNT_EN	GENMASK(11, 9)
 
-/* PHYRX CSD */
-#define MT_WF_PHYRX_CSD_BASE			0x83000000
-#define MT_WF_PHYRX_CSD(_band, _wf, ofs)	(MT_WF_PHYRX_CSD_BASE + \
-						 ((_band) << 20) + \
-						 ((_wf) << 16) + (ofs))
-#define MT_WF_PHYRX_CSD_IRPI(_band, _wf)	MT_WF_PHYRX_CSD(_band, _wf, 0x1000)
-
 /* PHYRX CSD BAND */
 #define MT_WF_PHYRX_CSD_BAND_RXTD12(_band)		MT_WF_PHYRX_BAND(_band, 0x8230)
 #define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
-- 
2.18.0

