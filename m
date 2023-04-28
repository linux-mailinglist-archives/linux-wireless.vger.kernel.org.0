Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191B16F1FA5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346741AbjD1UuM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 16:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346529AbjD1UuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 16:50:10 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950863C1E
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 13:50:09 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B77E1A80063
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:50:07 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 51B2313C2B5;
        Fri, 28 Apr 2023 13:50:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 51B2313C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682715007;
        bh=RqE1AIEdNgbVYLScyDN2gV1E2BYcfXU21jinsV4Uz4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmdQ+i2Lb9Vmkf9NjCh0u5ytSAhpknVaKbtaBVzfZWk5TPg9jLXxX15QH4B/K1mUA
         QHl1rwE4mrpzdRd4A663iK+su4I+/iCQhfrmRAzkKdIjmg6mDcBO1CuyAB86s+b9H9
         QVr9hRGncwh7qa8ZQ9I6bePVrlVsAzZBM2PcesYU=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 5/6] wifi: mt76: mt7915: Improve monitor-mode flags settings.
Date:   Fri, 28 Apr 2023 13:49:59 -0700
Message-Id: <20230428205000.2647945-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428205000.2647945-1-greearb@candelatech.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1682715008-pC02MzYU_i3C
X-MDID-O: us5;ut7;1682715008;pC02MzYU_i3C;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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

This enables capturing more frames, and now when the rx5 group
option is also enabled for rx-status, wireshark shows HE-TRIG
as well as HE-MU frames.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 16 ++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 64c14fc303a2..55aed3c6d3be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -562,6 +562,12 @@ static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
 			MT_WF_RFCR1_DROP_CFEND |
+			MT_WF_RFCR1_DROP_PS_BFRPOL |
+			MT_WF_RFCR1_DROP_PS_NDPA |
+			MT_WF_RFCR1_DROP_NO2ME_TF |
+			MT_WF_RFCR1_DROP_NON_MUBAR_TF |
+			MT_WF_RFCR1_DROP_RXS_BRP |
+			MT_WF_RFCR1_DROP_TF_BFRP |
 			MT_WF_RFCR1_DROP_CFACK;
 	u32 flags = 0;
 	bool is_promisc = *total_flags & FIF_CONTROL || phy->monitor_vif ||
@@ -587,7 +593,9 @@ static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 			   MT_WF_RFCR_DROP_BCAST |
 			   MT_WF_RFCR_DROP_DUPLICATE |
 			   MT_WF_RFCR_DROP_A2_BSSID |
-			   MT_WF_RFCR_DROP_UNWANTED_CTL |
+			   MT_WF_RFCR_DROP_UNWANTED_CTL | /* 0 means drop */
+			   MT_WF_RFCR_IND_FILTER_EN_OF_31_23_BIT |
+			   MT_WF_RFCR_DROP_DIFFBSSIDMGT_CTRL |
 			   MT_WF_RFCR_DROP_STBC_MULTI);
 
 	phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
@@ -602,8 +610,22 @@ static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_RTS |
 			     MT_WF_RFCR_DROP_CTL_RSV |
 			     MT_WF_RFCR_DROP_NDPA);
-	if (is_promisc)
+	if (is_promisc) {
 		phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+		phy->rxfilter |= MT_WF_RFCR_IND_FILTER_EN_OF_31_23_BIT;
+		if (flags & FIF_CONTROL) {
+			phy->rxfilter |= MT_WF_RFCR_DROP_UNWANTED_CTL; /* 1 means receive */
+			phy->rxfilter |= MT_WF_RFCR_SECOND_BCN_EN;
+			phy->rxfilter |= MT_WF_RFCR_RX_MGMT_FRAME_CTRL;
+			phy->rxfilter |= MT_WF_RFCR_RX_SAMEBSSIDPRORESP_CTRL;
+			phy->rxfilter |= MT_WF_RFCR_RX_DIFFBSSIDPRORESP_CTRL;
+			phy->rxfilter |= MT_WF_RFCR_RX_SAMEBSSIDBCN_CTRL;
+			phy->rxfilter |= MT_WF_RFCR_RX_SAMEBSSIDNULL_CTRL;
+			phy->rxfilter |= MT_WF_RFCR_RX_DIFFBSSIDNULL_CTRL;
+			phy->rxfilter &= ~(MT_WF_RFCR_DROP_DIFFBSSIDMGT_CTRL);
+		}
+		phy->rxfilter |= MT_WF_RFCR_RX_DATA_FRAME_CTRL;
+	}
 
 	*total_flags = flags;
 	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index db81c9902832..db52334204ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -547,6 +547,16 @@ enum offs_rev {
 #define MT_WF_RFCR_DROP_OTHER_TIM	BIT(19)
 #define MT_WF_RFCR_DROP_NDPA		BIT(20)
 #define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
+#define MT_WF_RFCR_IND_FILTER_EN_OF_31_23_BIT      BIT(22)
+#define MT_WF_RFCR_SECOND_BCN_EN                   BIT(23)
+#define MT_WF_RFCR_RX_MGMT_FRAME_CTRL              BIT(24)
+#define MT_WF_RFCR_RX_DATA_FRAME_CTRL              BIT(25)
+#define MT_WF_RFCR_RX_SAMEBSSIDPRORESP_CTRL        BIT(26)
+#define MT_WF_RFCR_RX_DIFFBSSIDPRORESP_CTRL        BIT(27)
+#define MT_WF_RFCR_RX_SAMEBSSIDBCN_CTRL            BIT(28)
+#define MT_WF_RFCR_RX_SAMEBSSIDNULL_CTRL           BIT(29)
+#define MT_WF_RFCR_RX_DIFFBSSIDNULL_CTRL           BIT(30)
+#define MT_WF_RFCR_DROP_DIFFBSSIDMGT_CTRL          BIT(31)
 
 #define MT_WF_RFCR1(_band)		MT_WF_RMAC(_band, 0x004)
 #define MT_WF_RFCR1_DROP_ACK		BIT(4)
@@ -554,6 +564,12 @@ enum offs_rev {
 #define MT_WF_RFCR1_DROP_BA		BIT(6)
 #define MT_WF_RFCR1_DROP_CFEND		BIT(7)
 #define MT_WF_RFCR1_DROP_CFACK		BIT(8)
+#define MT_WF_RFCR1_DROP_PS_BFRPOL	BIT(11)
+#define MT_WF_RFCR1_DROP_PS_NDPA	BIT(12)
+#define MT_WF_RFCR1_DROP_NO2ME_TF	BIT(22)
+#define MT_WF_RFCR1_DROP_NON_MUBAR_TF	BIT(23)
+#define MT_WF_RFCR1_DROP_RXS_BRP	BIT(25)
+#define MT_WF_RFCR1_DROP_TF_BFRP	BIT(30)
 
 #define MT_WF_RMAC_RSVD0(_band)	MT_WF_RMAC(_band, 0x02e0)
 #define MT_WF_RMAC_RSVD0_EIFS_CLR	BIT(21)
-- 
2.40.0

