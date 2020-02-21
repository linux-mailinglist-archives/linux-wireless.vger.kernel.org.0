Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D6166B53
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 01:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgBUAIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 19:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbgBUAIT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 19:08:19 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F44E2071E;
        Fri, 21 Feb 2020 00:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582243698;
        bh=yPjQWKKEmwSRkHni04jZO/dnsyHMaJaeCV45jMEsGic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYRwiHQotlg7Y3Dduq4u5/ReGqnrPOsk8/kBf+rrKuAklbdRH3nAETZOWx37DyEk4
         2yk9OGAhYVDuXIYqEpMA28WttC5CkudS6UhsrMWZr2qYSDZiTCCP/HtszHKGv0TjkM
         Yqf7yjOWU2q+qIHf9gUUdl6vZiqwkSTlSyv8eDG0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 7/8] mt76: mt7615: introduce mt7615_init_mac_chain routine
Date:   Fri, 21 Feb 2020 01:07:34 +0100
Message-Id: <a7562c1e8e95e463e7c4cfde148aeab9a658be9f.1582243031.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582243031.git.lorenzo@kernel.org>
References: <cover.1582243031.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_init_mac_chain routine to configure per band mac
register since new devices (e.g. mt7663e) do not support dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 118 +++++++++---------
 1 file changed, 62 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 889eb72ad6bd..cbb9c63737aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -18,27 +18,66 @@ static void mt7615_phy_init(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(1), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
 }
 
-static void mt7615_mac_init(struct mt7615_dev *dev)
+static void
+mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
 {
 	u32 val, mask, set;
-	int i;
+
+	if (!chain)
+		val = MT_CFG_CCR_MAC_D0_1X_GC_EN | MT_CFG_CCR_MAC_D0_2X_GC_EN;
+	else
+		val = MT_CFG_CCR_MAC_D1_1X_GC_EN | MT_CFG_CCR_MAC_D1_2X_GC_EN;
 
 	/* enable band 0/1 clk */
-	mt76_set(dev, MT_CFG_CCR,
-		 MT_CFG_CCR_MAC_D0_1X_GC_EN | MT_CFG_CCR_MAC_D0_2X_GC_EN |
-		 MT_CFG_CCR_MAC_D1_1X_GC_EN | MT_CFG_CCR_MAC_D1_2X_GC_EN);
-
-	val = mt76_rmw(dev, MT_TMAC_TRCR(0),
-		       MT_TMAC_TRCR_CCA_SEL | MT_TMAC_TRCR_SEC_CCA_SEL,
-		       FIELD_PREP(MT_TMAC_TRCR_CCA_SEL, 2) |
-		       FIELD_PREP(MT_TMAC_TRCR_SEC_CCA_SEL, 0));
-	mt76_wr(dev, MT_TMAC_TRCR(1), val);
-
-	val = MT_AGG_ACR_PKT_TIME_EN | MT_AGG_ACR_NO_BA_AR_RULE |
-	      FIELD_PREP(MT_AGG_ACR_CFEND_RATE, MT7615_CFEND_RATE_DEFAULT) |
-	      FIELD_PREP(MT_AGG_ACR_BAR_RATE, MT7615_BAR_RATE_DEFAULT);
-	mt76_wr(dev, MT_AGG_ACR(0), val);
-	mt76_wr(dev, MT_AGG_ACR(1), val);
+	mt76_set(dev, MT_CFG_CCR, val);
+
+	mt76_rmw(dev, MT_TMAC_TRCR(chain),
+		 MT_TMAC_TRCR_CCA_SEL | MT_TMAC_TRCR_SEC_CCA_SEL,
+		 FIELD_PREP(MT_TMAC_TRCR_CCA_SEL, 2) |
+		 FIELD_PREP(MT_TMAC_TRCR_SEC_CCA_SEL, 0));
+
+	mt76_wr(dev, MT_AGG_ACR(chain),
+		MT_AGG_ACR_PKT_TIME_EN | MT_AGG_ACR_NO_BA_AR_RULE |
+		FIELD_PREP(MT_AGG_ACR_CFEND_RATE, MT7615_CFEND_RATE_DEFAULT) |
+		FIELD_PREP(MT_AGG_ACR_BAR_RATE, MT7615_BAR_RATE_DEFAULT));
+
+	mt76_wr(dev, MT_AGG_ARUCR(chain),
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(5), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), 1));
+
+	mt76_wr(dev, MT_AGG_ARDCR(chain),
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(5), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), MT7615_RATE_RETRY - 1));
+
+	mask = MT_DMA_RCFR0_MCU_RX_MGMT |
+	       MT_DMA_RCFR0_MCU_RX_CTL_NON_BAR |
+	       MT_DMA_RCFR0_MCU_RX_CTL_BAR |
+	       MT_DMA_RCFR0_MCU_RX_BYPASS |
+	       MT_DMA_RCFR0_RX_DROPPED_UCAST |
+	       MT_DMA_RCFR0_RX_DROPPED_MCAST;
+	set = FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_UCAST, 2) |
+	      FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_MCAST, 2);
+	mt76_rmw(dev, MT_DMA_RCFR0(chain), mask, set);
+}
+
+static void mt7615_mac_init(struct mt7615_dev *dev)
+{
+	int i;
+
+	mt7615_init_mac_chain(dev, 0);
+	mt7615_init_mac_chain(dev, 1);
 
 	mt76_rmw_field(dev, MT_TMAC_CTCR0,
 		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
@@ -56,47 +95,14 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
 		 MT_AGG_SCR_NLNAV_MID_PTEC_DIS);
 
-	mt76_wr(dev, MT_DMA_DCR0, MT_DMA_DCR0_RX_VEC_DROP |
-		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072));
-
-	val = FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), 2) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), 2) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), 2) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(5), 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), 1);
-	mt76_wr(dev, MT_AGG_ARUCR(0), val);
-	mt76_wr(dev, MT_AGG_ARUCR(1), val);
-
-	val = FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(5), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), MT7615_RATE_RETRY - 1) |
-	      FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), MT7615_RATE_RETRY - 1);
-	mt76_wr(dev, MT_AGG_ARDCR(0), val);
-	mt76_wr(dev, MT_AGG_ARDCR(1), val);
-
 	mt76_wr(dev, MT_AGG_ARCR,
-		(FIELD_PREP(MT_AGG_ARCR_RTS_RATE_THR, 2) |
-		 MT_AGG_ARCR_RATE_DOWN_RATIO_EN |
-		 FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
-		 FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4)));
+		FIELD_PREP(MT_AGG_ARCR_RTS_RATE_THR, 2) |
+		MT_AGG_ARCR_RATE_DOWN_RATIO_EN |
+		FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
+		FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4));
 
-	mask = MT_DMA_RCFR0_MCU_RX_MGMT |
-	       MT_DMA_RCFR0_MCU_RX_CTL_NON_BAR |
-	       MT_DMA_RCFR0_MCU_RX_CTL_BAR |
-	       MT_DMA_RCFR0_MCU_RX_BYPASS |
-	       MT_DMA_RCFR0_RX_DROPPED_UCAST |
-	       MT_DMA_RCFR0_RX_DROPPED_MCAST;
-	set = FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_UCAST, 2) |
-	      FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_MCAST, 2);
-	mt76_rmw(dev, MT_DMA_RCFR0(0), mask, set);
-	mt76_rmw(dev, MT_DMA_RCFR0(1), mask, set);
+	mt76_wr(dev, MT_DMA_DCR0, MT_DMA_DCR0_RX_VEC_DROP |
+		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072));
 
 	for (i = 0; i < MT7615_WTBL_SIZE; i++)
 		mt7615_mac_wtbl_update(dev, i,
-- 
2.24.1

