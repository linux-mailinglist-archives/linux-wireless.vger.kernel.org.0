Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256C6F1FA4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346740AbjD1UuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346736AbjD1UuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 16:50:10 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F71730
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 13:50:08 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2F1D4C0067
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:50:07 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 8D4FA13C2B0;
        Fri, 28 Apr 2023 13:50:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8D4FA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682715006;
        bh=t6ImqsfTV0cMv4AI8GnWlbCmtnwkJ2Vy3J0TH2gq6Ps=;
        h=From:To:Cc:Subject:Date:From;
        b=WyDReiEIwLpVvhn6j/yV0lEwjKIPJYX8qQLiTwPQ7Y120cidyA/XiKmeL8abfZRsm
         nuBKTGDmb9taBMIakAGmJWepOJBWRvtlLbay+dq2XGyMMJe26wdkl2f8voGzcU9pxB
         BunYAShtCO8Ol/SjoIOssOVaPv9k6l7DUhAaBnmE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/6] wifi: mt76: mt7915: Support vht mu-mimo sniffer feature.
Date:   Fri, 28 Apr 2023 13:49:55 -0700
Message-Id: <20230428205000.2647945-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1682715007-7SVzZyX8NQMt
X-MDID-O: us5;ut7;1682715007;7SVzZyX8NQMt;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This feature allows mac80211 to update the driver with mu-mimo
group to allow the monitor port to capture MU-MIMO (VHT) frames.

The mt7915 driver implementation will only enable this feature
when there is only a monitor vdev.  I was afraid that it would mess
up a sta + monitor vdev combination, for instance.

Original code from Ryder

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 41 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 10 +++++
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..d4ae53d80d07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -945,6 +945,11 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 	return dev->rev & 0xffff;
 }
 
+static inline int mt76_vif_count(struct mt76_dev *dev)
+{
+	return hweight_long(dev->vif_mask);
+}
+
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
 #define mt76xx_rev(dev) mt76_rev(&((dev)->mt76))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ac2049f49bb3..bea75615872f 100644
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
index 1b361199c061..7566db0cf523 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -592,6 +592,34 @@ mt7915_update_bss_color(struct ieee80211_hw *hw,
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
@@ -650,6 +678,19 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		       BSS_CHANGED_FILS_DISCOVERY))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon, changed);
 
+	if (changed & BSS_CHANGED_MU_GROUPS) {
+		/* Assumption is that in case of non-monitor VDEV existing, then
+		 * that device should control the mu-group directly.
+		 */
+		int vif_count = mt76_vif_count(&dev->mt76);
+		int max_ok = 0;
+
+		if (phy->monitor_vif)
+			max_ok = 1;
+		if (vif_count <= max_ok)
+			mt7915_update_mu_group(hw, vif, info);
+	}
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index c8e478a55081..5e057cce5c9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1183,6 +1183,16 @@ enum offs_rev {
 #define MT_WF_PHY_BASE			0x83080000
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
+#define MT_WF_PHY_RX_GID_TAB_VLD(_phy, i)		MT_WF_PHY(0x1054 + \
+								  (i) * 4 + ((_phy) << 16))
+#define MT_WF_PHY_RX_GID_TAB_VLD_MT7916(_phy, i)	MT_WF_PHY(0x1054 + \
+								  (i) * 4 + ((_phy) << 20))
+
+#define MT_WF_PHY_RX_GID_TAB_POS(_phy, i)		MT_WF_PHY(0x105c + \
+								  (i) * 4 + ((_phy) << 16))
+#define MT_WF_PHY_RX_GID_TAB_POS_MT7916(_phy, i)	MT_WF_PHY(0x105c + \
+								  (i) * 4 + ((_phy) << 20))
+
 #define MT_WF_PHY_RX_CTRL1(_phy)	MT_WF_PHY(0x2004 + ((_phy) << 16))
 #define MT_WF_PHY_RX_CTRL1_MT7916(_phy)	MT_WF_PHY(0x2004 + ((_phy) << 20))
 #define MT_WF_PHY_RX_CTRL1_IPI_EN	GENMASK(2, 0)
-- 
2.40.0

