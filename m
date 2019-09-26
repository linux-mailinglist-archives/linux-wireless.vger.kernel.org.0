Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D7BEE03
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfIZJFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 05:05:32 -0400
Received: from nbd.name ([46.4.11.11]:53300 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbfIZJFb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=acYqFrqs5bpv1Gj+18Ykq4i/QhVyjgyygDs92tW9ikg=; b=CI4EPV06UxTcHIyclfncSIydGl
        m8EH6HOUNEOBfLnH6JzuA4o3rT3V9i6qijY9cexMv4zeltz97yKYTC8yCbvUBqfCwuuttsk7JgSPE
        UXHVBZrtkJZgANEZnE7m6d4F1H6zXmJXs4Kq1N5noWkB7GeLPZmSY9CTZr8CG/66KZNQ=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDPiL-0008So-NV
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 11:05:29 +0200
Received: by maeck.local (Postfix, from userid 501)
        id A673B6997D7E; Thu, 26 Sep 2019 11:05:23 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: mt7615: fix control frame rx in monitor mode
Date:   Thu, 26 Sep 2019 11:05:21 +0200
Message-Id: <20190926090523.68392-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adjust filters and ensure frames don't get sent to MCU instead of host

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 13 ++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 1104e4c8aaa6..5de04f6e6046 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -20,7 +20,7 @@ static void mt7615_phy_init(struct mt7615_dev *dev)
 
 static void mt7615_mac_init(struct mt7615_dev *dev)
 {
-	u32 val;
+	u32 val, mask, set;
 
 	/* enable band 0/1 clk */
 	mt76_set(dev, MT_CFG_CCR,
@@ -85,6 +85,17 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_AGG_ARCR_RATE_DOWN_RATIO_EN |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4)));
+
+	mask = MT_DMA_RCFR0_MCU_RX_MGMT |
+	       MT_DMA_RCFR0_MCU_RX_CTL_NON_BAR |
+	       MT_DMA_RCFR0_MCU_RX_CTL_BAR |
+	       MT_DMA_RCFR0_MCU_RX_BYPASS |
+	       MT_DMA_RCFR0_RX_DROPPED_UCAST |
+	       MT_DMA_RCFR0_RX_DROPPED_MCAST;
+	set = FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_UCAST, 2) |
+	      FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_MCAST, 2);
+	mt76_rmw(dev, MT_DMA_BN0RCFR0, mask, set);
+	mt76_rmw(dev, MT_DMA_BN1RCFR0, mask, set);
 }
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 87c748715b5d..be8130735a1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -263,6 +263,11 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 				    u64 multicast)
 {
 	struct mt7615_dev *dev = hw->priv;
+	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
+			MT_WF_RFCR1_DROP_BF_POLL |
+			MT_WF_RFCR1_DROP_BA |
+			MT_WF_RFCR1_DROP_CFEND |
+			MT_WF_RFCR1_DROP_CFACK;
 	u32 flags = 0;
 
 #define MT76_FILTER(_flag, _hw) do { \
@@ -296,6 +301,11 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 
 	*total_flags = flags;
 	mt76_wr(dev, MT_WF_RFCR, dev->mt76.rxfilter);
+
+	if (*total_flags & FIF_CONTROL)
+		mt76_clear(dev, MT_WF_RFCR1, ctl_flags);
+	else
+		mt76_set(dev, MT_WF_RFCR1, ctl_flags);
 }
 
 static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index b193814d5cf8..8ecefcb19354 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -176,6 +176,13 @@
 #define MT_WF_RFCR_DROP_NDPA		BIT(20)
 #define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
 
+#define MT_WF_RFCR1			MT_WF_RMAC(0x004)
+#define MT_WF_RFCR1_DROP_ACK		BIT(4)
+#define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
+#define MT_WF_RFCR1_DROP_BA		BIT(6)
+#define MT_WF_RFCR1_DROP_CFEND		BIT(7)
+#define MT_WF_RFCR1_DROP_CFACK		BIT(8)
+
 #define MT_WF_DMA_BASE			0x21800
 #define MT_WF_DMA(ofs)			(MT_WF_DMA_BASE + (ofs))
 
@@ -183,6 +190,15 @@
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 2)
 #define MT_DMA_DCR0_RX_VEC_DROP		BIT(17)
 
+#define MT_DMA_BN0RCFR0			MT_WF_DMA(0x070)
+#define MT_DMA_BN1RCFR0			MT_WF_DMA(0x0b0)
+#define MT_DMA_RCFR0_MCU_RX_MGMT	BIT(2)
+#define MT_DMA_RCFR0_MCU_RX_CTL_NON_BAR	BIT(3)
+#define MT_DMA_RCFR0_MCU_RX_CTL_BAR	BIT(4)
+#define MT_DMA_RCFR0_MCU_RX_BYPASS	BIT(21)
+#define MT_DMA_RCFR0_RX_DROPPED_UCAST	GENMASK(25, 24)
+#define MT_DMA_RCFR0_RX_DROPPED_MCAST	GENMASK(27, 26)
+
 #define MT_WTBL_BASE			0x30000
 #define MT_WTBL_ENTRY_SIZE		256
 
-- 
2.17.0

