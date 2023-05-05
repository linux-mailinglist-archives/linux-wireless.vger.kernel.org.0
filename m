Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C86F79E8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 02:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjEEAFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEEAFw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 20:05:52 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74661328E
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 17:05:50 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A7D332C006D
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 00:05:48 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0E72E13C2B1;
        Thu,  4 May 2023 17:05:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0E72E13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683245148;
        bh=GlVY/8c4st0SiE3f2bmiBFYFcI7e8NsyUZkCnGO/TLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZv9AyxyYh2GLaTbK/6Vrdkk5Aoq+DZazsX2qInG+X6Q/X5/xTuSDviyiYQeM3Mz3
         FSt+yyODZJ3qBrskLHOUpDcemn3bjlBqRks5Xd8kqD6CpZozfjww7S3hcv9D8izTM+
         cEQVW9QtYf45G64tlkbwgw+K6RWDfdP7S6kCc6wA=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 4/6] wifi: mt76: mt7915: Adjust MDP_RCFR1 in monitor mode.
Date:   Thu,  4 May 2023 17:05:41 -0700
Message-Id: <20230505000543.693532-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505000543.693532-1-greearb@candelatech.com>
References: <20230505000543.693532-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1683245149-vC-wnvsAW6Dx
X-MDID-O: us5;at1;1683245149;vC-wnvsAW6Dx;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Request to pass some otherwise dropped frames to host when in
monitor mode.  Change initialization logic to use a better name
(but values actually set in the register during init does not change)

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 6 ++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index bea75615872f..cd98a1e1e63c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -469,8 +469,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	       MT_MDP_RCFR1_RX_DROPPED_UCAST |
 	       MT_MDP_RCFR1_RX_DROPPED_MCAST;
 	set = FIELD_PREP(MT_MDP_RCFR1_MCU_RX_BYPASS, MT_MDP_TO_HIF) |
-	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_UCAST, MT_MDP_TO_HIF) |
-	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_TO_HIF);
+	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_UCAST, MT_MDP_PFD_DROP) |
+	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_PFD_DROP);
 	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 0x680);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f38e4cb4504c..4344fd91e9f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -566,6 +566,9 @@ static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 	u32 flags = 0;
 	bool is_promisc = *total_flags & FIF_CONTROL || phy->monitor_vif ||
 		phy->monitor_enabled;
+	u32 mdp_rcfr1_mask = MT_MDP_RCFR1_RX_DROPPED_UCAST |
+		MT_MDP_RCFR1_RX_DROPPED_MCAST;
+	u32 mdp_rcfr1_set;
 
 #define MT76_FILTER(_flag, _hw) do {					\
 		flags |= *total_flags & FIF_##_flag;			\
@@ -610,11 +613,17 @@ static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 		mt76_set(dev, MT_WF_RMAC_TOP_TF_PARSER(band),
 			 MT_WF_RMAC_TOP_TF_SNIFFER);
 		mt7915_check_apply_monitor_config(phy);
+
+		mdp_rcfr1_set = FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_UCAST, MT_MDP_PFD_TO_HIF) |
+			FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_PFD_TO_HIF);
 	} else {
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
 		mt76_clear(dev, MT_WF_RMAC_TOP_TF_PARSER(band),
 			   MT_WF_RMAC_TOP_TF_SNIFFER);
+		mdp_rcfr1_set = FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_UCAST, MT_MDP_PFD_DROP) |
+			FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_PFD_DROP);
 	}
+	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mdp_rcfr1_mask, mdp_rcfr1_set);
 }
 
 static void mt7915_configure_filter(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 252e5f1405cf..db81c9902832 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -189,6 +189,12 @@ enum offs_rev {
 #define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
+/* For UCDP2MH, BMCDP2MH in RCFR1 */
+#define MT_MDP_PFD_DROP			0
+#define MT_MDP_PFD_TO_MCU		1
+#define MT_MDP_PFD_TO_HIF		2
+#define MT_MDP_PFD_TO_HIF2		3
+
 
 /* TRB: band 0(0x820e1000), band 1(0x820f1000) */
 #define MT_WF_TRB_BASE(_band)		((_band) ? 0x820f1000 : 0x820e1000)
-- 
2.40.0

