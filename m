Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658B876D72E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjHBSu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHBSuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 14:50:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6ED2102
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:50:17 -0700 (PDT)
X-UUID: 5a579122316511ee9cb5633481061a41-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jCiKWJVauQRsyD1Zkeszjicqclds7bkaHbOE0OtFJR0=;
        b=CJhwSJbrIGJvEIPWlHdaJmMdgH4OIH5E36rjnS1SewjIYP/lqDJPp2K1rQtARe9q5raI3S5otEIPRnQ6fIZeBR8DQdso4H7AEsX9dVm48wukLVcjZD3tHKOI35ioBsHMjg2t/LEyXd/1/Fyzsnm+ZMifWNWP8FeypA/3bMfDNq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:0b0a7a35-e575-47f2-a924-bde42b73d40e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:0b0a7a35-e575-47f2-a924-bde42b73d40e,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:86ccd2a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230803024949LKQZZM0P,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 5a579122316511ee9cb5633481061a41-20230803
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 929066951; Thu, 03 Aug 2023 02:49:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 02:49:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 02:49:46 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: enable BSS_CHANGED_MU_GROUPS support
Date:   Thu, 3 Aug 2023 02:49:44 +0800
Message-ID: <ff63866d7d62d088edd4a9f7587320f8f59a361f.1690999957.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Change-Id: I3d2f5508a2b6eb7c929c3997c31a9285713c8bea
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 31 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 12 +++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ee976657bfc3..794469fdedac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -370,6 +370,7 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
 	if (!is_mt7915(&dev->mt76))
 		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f8d6323bd42d..102cbc4da2f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -593,6 +593,34 @@ mt7915_update_bss_color(struct ieee80211_hw *hw,
 	}
 }
 
+static void
+mt7915_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_bss_conf *info)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	u8 i, band = phy->mt76->band_idx;
+	u32 *mu;
+
+	mu = (u32 *)info->mu_group.membership;
+	for (i = 0; i < WLAN_MEMBERSHIP_LEN / sizeof(*mu); i++) {
+		if (is_mt7916(&dev->mt76))
+			mt76_wr(dev, MT_WF_PHY_RX_GID_TAB_VLD_MT7916(band, i),
+				mu[i]);
+		else
+			mt76_wr(dev, MT_WF_PHY_RX_GID_TAB_VLD(band, i), mu[i]);
+	}
+
+	mu = (u32 *)info->mu_group.position;
+	for (i = 0; i < WLAN_USER_POSITION_LEN / sizeof(*mu); i++) {
+		if (is_mt7916(&dev->mt76))
+			mt76_wr(dev, MT_WF_PHY_RX_GID_TAB_POS_MT7916(band, i),
+				mu[i]);
+		else
+			mt76_wr(dev, MT_WF_PHY_RX_GID_TAB_POS(band, i), mu[i]);
+	}
+}
+
 static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -646,6 +674,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		       BSS_CHANGED_FILS_DISCOVERY))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon, changed);
 
+	if (changed & BSS_CHANGED_MU_GROUPS)
+		mt7915_update_mu_group(hw, vif, info);
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 588cd87e24e9..534e039e0deb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1197,13 +1197,21 @@ enum offs_rev {
 #define MT_WF_PHY_BASE			0x83080000
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
+#define MT_WF_PHY_RX_GID_TAB_VLD(_n, i)		MT_WF_PHY(0x1054 + (i) * 4 + \
+							  ((_n) << 16))
+#define MT_WF_PHY_RX_GID_TAB_VLD_MT7916(_n, i)	MT_WF_PHY(0x1054 + (i) * 4 + \
+							  ((_n) << 20))
+#define MT_WF_PHY_RX_GID_TAB_POS(_n, i)		MT_WF_PHY(0x105c + (i) * 4 + \
+							  ((_n) << 16))
+#define MT_WF_PHY_RX_GID_TAB_POS_MT7916(_n, i)	MT_WF_PHY(0x105c + (i) * 4 + \
+							  ((_n) << 20))
 #define MT_WF_PHY_RX_CTRL1(_phy)	MT_WF_PHY(0x2004 + ((_phy) << 16))
 #define MT_WF_PHY_RX_CTRL1_MT7916(_phy)	MT_WF_PHY(0x2004 + ((_phy) << 20))
 #define MT_WF_PHY_RX_CTRL1_IPI_EN	GENMASK(2, 0)
 #define MT_WF_PHY_RX_CTRL1_STSCNT_EN	GENMASK(11, 9)
 
-#define MT_WF_PHY_RXTD12(_phy)		MT_WF_PHY(0x8230 + ((_phy) << 16))
-#define MT_WF_PHY_RXTD12_MT7916(_phy)	MT_WF_PHY(0x8230 + ((_phy) << 20))
+#define MT_WF_PHY_RXTD12(_phy)			MT_WF_PHY(0x8230 + ((_phy) << 16))
+#define MT_WF_PHY_RXTD12_MT7916(_phy)		MT_WF_PHY(0x8230 + ((_phy) << 20))
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR		BIT(29)
 
-- 
2.18.0

