Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6693BF7E1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfIZRrr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:47 -0400
Received: from nbd.name ([46.4.11.11]:55232 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zMO7NzwhtC1Dc2bzrT5ing9a/hyuCJ3IVCQD2yU2tI8=; b=o7XOozzNze5Lv6WhWr0eg23bN8
        h/6XeaAxJo2TJdmlZz7g0u0pN8bO1ThqgQ+5POzbYBWoRzE7XPtcxl/juCfwBS/Md3Tiy3gWMLLuN
        3JImaEBmQ9YsVuq1At2PtB9HAH+VUJ1xNGQFJbDIeSUDLYe1TxsIaBOkpbAYtJTo494I=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXrZ-0000yY-8R
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:33 +0200
Received: by maeck.local (Postfix, from userid 501)
        id AEEFF69B6A80; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/15] mt76: mt7615: report tx_time, bss_rx and busy time to mac80211
Date:   Thu, 26 Sep 2019 19:47:28 +0200
Message-Id: <20190926174732.42375-11-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Report tx time/rx time and obss time from hw mib counters to fill survey
info requested by mac80211

Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 26 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  3 +++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 12 +++++++++
 7 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5aba8bc0b086..fd64172ca785 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -505,6 +505,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	survey->time = div_u64(state->cc_active, 1000);
 	survey->time_busy = div_u64(state->cc_busy, 1000);
 	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
+	survey->time_rx = div_u64(state->cc_rx, 1000);
 	survey->time_tx = div_u64(state->cc_tx, 1000);
 	spin_unlock_bh(&dev->cc_lock);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 49511bd06fd9..8bcc7f21e83c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -321,6 +321,7 @@ struct mt76_driver_ops {
 struct mt76_channel_state {
 	u64 cc_active;
 	u64 cc_busy;
+	u64 cc_rx;
 	u64 cc_bss_rx;
 	u64 cc_tx;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index ad94a7ce2e10..05a9e1154dd5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -96,6 +96,8 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	      FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_MCAST, 2);
 	mt76_rmw(dev, MT_DMA_BN0RCFR0, mask, set);
 	mt76_rmw(dev, MT_DMA_BN1RCFR0, mask, set);
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_EN);
 }
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 271f36f4acb3..9b113037c4f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -49,6 +49,14 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 		mt76_rr(dev, MT_TX_AGG_CNT(i));
 
 	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
+
+	/* TODO: add DBDC support */
+
+	/* reset airtime counters */
+	mt76_rr(dev, MT_MIB_SDR16(0));
+	mt76_rr(dev, MT_MIB_SDR36(0));
+	mt76_rr(dev, MT_MIB_SDR37(0));
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
@@ -1263,11 +1271,25 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt76_channel_state *state;
+	u64 busy_time, tx_time, rx_time, obss_time;
 
 	/* TODO: add DBDC support */
+	busy_time = mt76_get_field(dev, MT_MIB_SDR16(0), MT_MIB_BUSY_MASK);
+	tx_time = mt76_get_field(dev, MT_MIB_SDR36(0),
+				 MT_MIB_SDR36_TXTIME_MASK);
+	rx_time = mt76_get_field(dev, MT_MIB_SDR37(0),
+				 MT_MIB_SDR37_RXTIME_MASK);
+	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_TIME5,
+				   MT_MIB_OBSSTIME_MASK);
+
 	state = mdev->chan_state;
-	state->cc_busy += mt76_get_field(dev, MT_MIB_SDR16(0),
-					 MT_MIB_BUSY_MASK);
+	state->cc_busy += busy_time;
+	state->cc_tx += tx_time;
+	state->cc_rx += rx_time + obss_time;
+	state->cc_bss_rx += rx_time;
+
+	/* reset obss airtime */
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
 void mt7615_mac_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 61df2988ca10..9707fa8b5485 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -153,8 +153,8 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	ret = mt7615_dfs_init_radar_detector(dev);
 	mt7615_mac_cca_stats_reset(dev);
 	dev->mt76.survey_time = ktime_get_boottime();
-	/* TODO: add DBDC support */
-	mt76_rr(dev, MT_MIB_SDR16(0));
+
+	mt7615_mac_reset_counters(dev);
 
 out:
 	clear_bit(MT76_RESET, &dev->mt76.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 73744563a573..1eb1eb659c3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -73,6 +73,9 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp),
 		.drv_flags = MT_DRV_TXWI_NO_FREE,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
 		.tx_prepare_skb = mt7615_tx_prepare_skb,
 		.tx_complete_skb = mt7615_tx_complete_skb,
 		.rx_skb = mt7615_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 643b8bd17850..9a2ff1f3a68c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -198,6 +198,13 @@
 #define MT_WF_RFCR1_DROP_CFEND		BIT(7)
 #define MT_WF_RFCR1_DROP_CFACK		BIT(8)
 
+#define MT_WF_RMAC_MIB_TIME0		MT_WF_RMAC(0x03c4)
+#define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
+#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
+
+#define MT_WF_RMAC_MIB_TIME5		MT_WF_RMAC(0x03d8)
+#define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
+
 #define MT_WF_DMA_BASE			0x21800
 #define MT_WF_DMA(ofs)			(MT_WF_DMA_BASE + (ofs))
 
@@ -289,6 +296,11 @@
 #define MT_MIB_SDR16(n)			MT_WF_MIB(0x48 + ((n) << 9))
 #define MT_MIB_BUSY_MASK		GENMASK(23, 0)
 
+#define MT_MIB_SDR36(n)			MT_WF_MIB(0x098 + ((n) << 9))
+#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR37(n)			MT_WF_MIB(0x09c + ((n) << 9))
+#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
+
 #define MT_TX_AGG_CNT(n)		MT_WF_MIB(0xa8 + ((n) << 2))
 
 #define MT_EFUSE_BASE			0x81070000
-- 
2.17.0

