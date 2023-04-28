Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085A6F1FA9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbjD1UuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbjD1UuL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 16:50:11 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43938422C
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 13:50:10 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 95D2B10006E
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:50:07 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2663413C2B4;
        Fri, 28 Apr 2023 13:50:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2663413C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682715007;
        bh=FHmGUQZAyB2eVrcYTkl622ztuQ6UFsn9zy3AvPM4VtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1Qu8B7PTv9o6pTPCVZFcZ2wCdRNZ6rB8J4bDIl+VX1VqmFikZe4xHHlckh4hElqb
         ZG+i3IjC9GrE51i1sGJ63hv2BNoW7ie+XwluwfGsz/M6U0cc3WV+dWWvmNjUZ9Lg5A
         D5NQjyTnQXJgmtFmMpkBR7+G0B1ruYzjxcq2coLc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 4/6] wifi: mt76: mt7915: Adjust MDP_RCFR1 in monitor mode.
Date:   Fri, 28 Apr 2023 13:49:58 -0700
Message-Id: <20230428205000.2647945-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428205000.2647945-1-greearb@candelatech.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1682715008-gL8F3DMtOtOl
X-MDID-O: us5;ut7;1682715008;gL8F3DMtOtOl;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
index fec30cf26855..64c14fc303a2 100644
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

