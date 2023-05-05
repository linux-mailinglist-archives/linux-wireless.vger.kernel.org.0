Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76E6F79E7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjEEAFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 20:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjEEAFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 20:05:51 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879311328B
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 17:05:50 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC0CA50006A
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 00:05:48 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6445F13C2B4;
        Thu,  4 May 2023 17:05:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6445F13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683245148;
        bh=sCTd6bOygGYB8gzPm3MTEnYTDiUKoRQz10uHtfzqRrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQSXEU+SA598P0RiVQXg3bgT1AAD+EXvhDAhUBWx/LVQmrWPdLWh1qckk9s4zRtZQ
         6vZvyXAKRPKCQk9ApyfIwwRZZxJ6GnkMr2g0irrGzFnRcIuww2lh+uD8BBiCgjJxOJ
         9FSq02lumvpwx6oZSCWGp7ssHWrB+vrKKF0qggmo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 6/6] wifi: mt76: mt7915: Improve monitor-mode flags settings.
Date:   Thu,  4 May 2023 17:05:43 -0700
Message-Id: <20230505000543.693532-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505000543.693532-1-greearb@candelatech.com>
References: <20230505000543.693532-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1683245149-rUD6J9ulOzjO
X-MDID-O: us5;ut7;1683245149;rUD6J9ulOzjO;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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

I am not sure this is needed, but it at least does not appear to
hurt anything, and based on my understanding of the register definitions,
it may allow the radio to capture more frames than without these changes.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 16 ++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 7e20b2e9368c..ea61f05e2bcd 100644
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

