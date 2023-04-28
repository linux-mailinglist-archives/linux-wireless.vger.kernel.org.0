Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6552B6F1FA7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbjD1UuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 16:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbjD1UuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 16:50:10 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292426AF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 13:50:09 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 70E253C006D
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:50:07 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C683A13C2B1;
        Fri, 28 Apr 2023 13:50:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C683A13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682715006;
        bh=okpTzhGyjXSE0viv7hybvNEp4Hs5VVeEAUGSd7oVDiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EewEXS8RDCvXPnmipoH+37yUJjMTXZ64bM3UCQFvDq+IRZBPn573fwpz/JmEH4RvO
         eoQbEidz8P7aU6n1v1cIZckxdn1lXyC5eshO1aPU2/c2EkktAtcwK9BdvMUh7TpZPz
         za4k8kWuTcxRhS6+W0B4wzQDw4jWh7AOUWA+mGFc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/6] wifi: mt76: mt7915: Move rxfilter logic into central location.
Date:   Fri, 28 Apr 2023 13:49:56 -0700
Message-Id: <20230428205000.2647945-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428205000.2647945-1-greearb@candelatech.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1682715008-WpvlsfnULbd3
X-MDID-O: us5;at1;1682715008;WpvlsfnULbd3;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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

And ensure monitor mode is taken into account when calculating the
filter.

Enable RMAC_TOP_TF_SNIFFER when in promisc mode.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 51 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  3 ++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 7566db0cf523..7ec9f45cfa15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -8,6 +8,11 @@
 #include "mt7915.h"
 #include "mcu.h"
 
+static void __mt7915_configure_filter(struct ieee80211_hw *hw,
+				      unsigned int changed_flags,
+				      unsigned int *total_flags,
+				      u64 multicast);
+
 static bool mt7915_dev_running(struct mt7915_dev *dev)
 {
 	struct mt7915_phy *phy;
@@ -481,16 +486,15 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 		bool band = phy->mt76->band_idx;
+		u32 total_flags = phy->mac80211_rxfilter_flags;
+		u64 multicast = 0; /* not used by this driver currently. */
 
-		if (!enabled)
-			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
-		else
-			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+		phy->monitor_enabled = enabled;
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
 			       enabled);
 		mt76_testmode_reset(phy->mt76, true);
-		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+		__mt7915_configure_filter(hw, 0, &total_flags, multicast);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -512,10 +516,10 @@ mt7915_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static void mt7915_configure_filter(struct ieee80211_hw *hw,
-				    unsigned int changed_flags,
-				    unsigned int *total_flags,
-				    u64 multicast)
+static void __mt7915_configure_filter(struct ieee80211_hw *hw,
+				      unsigned int changed_flags,
+				      unsigned int *total_flags,
+				      u64 multicast)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
@@ -526,6 +530,8 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 			MT_WF_RFCR1_DROP_CFEND |
 			MT_WF_RFCR1_DROP_CFACK;
 	u32 flags = 0;
+	bool is_promisc = *total_flags & FIF_CONTROL || phy->monitor_vif ||
+		phy->monitor_enabled;
 
 #define MT76_FILTER(_flag, _hw) do {					\
 		flags |= *total_flags & FIF_##_flag;			\
@@ -533,7 +539,7 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
 	} while (0)
 
-	mutex_lock(&dev->mt76.mutex);
+	phy->mac80211_rxfilter_flags = *total_flags; /* save requested flags for later */
 
 	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
 			   MT_WF_RFCR_DROP_OTHER_BEACON |
@@ -547,6 +553,8 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 			   MT_WF_RFCR_DROP_UNWANTED_CTL |
 			   MT_WF_RFCR_DROP_STBC_MULTI);
 
+	phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+
 	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
 			       MT_WF_RFCR_DROP_A3_MAC |
 			       MT_WF_RFCR_DROP_A3_BSSID);
@@ -557,14 +565,33 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_RTS |
 			     MT_WF_RFCR_DROP_CTL_RSV |
 			     MT_WF_RFCR_DROP_NDPA);
+	if (is_promisc)
+		phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
 	*total_flags = flags;
 	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 
-	if (*total_flags & FIF_CONTROL)
+	if (is_promisc) {
 		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
-	else
+		mt76_set(dev, MT_WF_RMAC_TOP_TF_PARSER(band),
+			 MT_WF_RMAC_TOP_TF_SNIFFER);
+	} else {
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
+		mt76_clear(dev, MT_WF_RMAC_TOP_TF_PARSER(band),
+			   MT_WF_RMAC_TOP_TF_SNIFFER);
+	}
+}
+
+static void mt7915_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	__mt7915_configure_filter(hw, changed_flags, total_flags, multicast);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b3ead3530740..06f98e5cd95e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -244,6 +244,8 @@ struct mt7915_phy {
 	struct ieee80211_vif *monitor_vif;
 
 	struct thermal_cooling_device *cdev;
+	u32 mac80211_rxfilter_flags;
+	u8 monitor_enabled;
 	u8 cdev_state;
 	u8 throttle_state;
 	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 5e057cce5c9f..0118fdaa96b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -566,6 +566,9 @@ enum offs_rev {
 #define MT_WF_RMAC_MIB_AIRTIME4(_band)	MT_WF_RMAC(_band, 0x0390)
 #define MT_WF_RMAC_MIB_QOS23_BACKOFF	GENMASK(31, 0)
 
+#define MT_WF_RMAC_TOP_TF_PARSER(_band) MT_WF_RMAC(_band, 0x0604)
+#define MT_WF_RMAC_TOP_TF_SNIFFER       (BIT(10) | BIT(12))
+
 /* WFDMA0 */
 #define MT_WFDMA0_BASE			__REG(WFDMA0_ADDR)
 #define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
-- 
2.40.0

