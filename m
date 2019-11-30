Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD73B10DE14
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfK3Pat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:49 -0500
Received: from nbd.name ([46.4.11.11]:56032 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/ye1y4/zUs5/Wij2IDSL8opU4tDHXTALnwjI/pNf8Lo=; b=Tl6JZm2Wohv3kebDU75BGB+II1
        xiPltuQQuk+XebWtWOQqCbnt7WHzBdbRDbaqKUOxIxIs5RtP32Q7pNYPi4Ff0vrYSIJzem4+SEOS5
        0r+/hQKOQCNsH/G7TKt7Xvq6/4DA/aLWixbAXJEjRFRuT5jtHyJcPqQIM/HEnUOi3RHM=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hq-0006hE-Iu
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:46 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 05AD9721EBD4; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 17/29] mt76: move ampdu_ref from mt76_dev to driver struct
Date:   Sat, 30 Nov 2019 16:30:33 +0100
Message-Id: <20191130153045.28105-17-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is only used by the driver

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 1 -
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h       | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   | 6 +++---
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 62e2ded6a84c..ca71b78535b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -502,7 +502,6 @@ struct mt76_dev {
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
-	u32 ampdu_ref;
 
 	struct list_head txwi_cache;
 	struct mt76_sw_queue q_tx[2 * __MT_TXQ_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index ab9ac6e07159..2a384fd0f088 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -531,12 +531,12 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 
 		/* all subframes of an A-MPDU have the same timestamp */
 		if (dev->rx_ampdu_ts != rxd[12]) {
-			if (!++dev->mt76.ampdu_ref)
-				dev->mt76.ampdu_ref++;
+			if (!++dev->ampdu_ref)
+				dev->ampdu_ref++;
 		}
 		dev->rx_ampdu_ts = rxd[12];
 
-		status->ampdu_ref = dev->mt76.ampdu_ref;
+		status->ampdu_ref = dev->ampdu_ref;
 	}
 
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 63ec1fa71aba..12fd2db2df10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -118,6 +118,7 @@ struct mt7603_dev {
 	u32 false_cca_ofdm, false_cca_cck;
 	unsigned long last_cca_adj;
 
+	u32 ampdu_ref;
 	__le32 rx_ampdu_ts;
 	u8 rssi_offset[3];
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 38abb3dab549..bf9c8006eb15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -118,12 +118,12 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 		/* all subframes of an A-MPDU have the same timestamp */
 		if (dev->rx_ampdu_ts != rxd[12]) {
-			if (!++dev->mt76.ampdu_ref)
-				dev->mt76.ampdu_ref++;
+			if (!++dev->ampdu_ref)
+				dev->ampdu_ref++;
 		}
 		dev->rx_ampdu_ts = rxd[12];
 
-		status->ampdu_ref = dev->mt76.ampdu_ref;
+		status->ampdu_ref = dev->ampdu_ref;
 	}
 
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 9c27b355a445..17ec75a2bcfb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -90,6 +90,7 @@ struct mt7615_dev {
 	u32 omac_mask;
 
 	__le32 rx_ampdu_ts;
+	u32 ampdu_ref;
 
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f00a9a6ee670..ba4c14eea22d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -86,6 +86,7 @@ struct mt76x02_dev {
 	DECLARE_KFIFO_PTR(txstatus_fifo, struct mt76x02_tx_status);
 	spinlock_t txstatus_fifo_lock;
 	u32 tx_airtime;
+	u32 ampdu_ref;
 
 	struct sk_buff *rx_head;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 098792b86b73..5b512e4ce6b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -824,7 +824,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 
 	if (rxinfo & MT_RXINFO_AMPDU) {
 		status->flag |= RX_FLAG_AMPDU_DETAILS;
-		status->ampdu_ref = dev->mt76.ampdu_ref;
+		status->ampdu_ref = dev->ampdu_ref;
 
 		/*
 		 * When receiving an A-MPDU subframe and RSSI info is not valid,
@@ -832,8 +832,8 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 		 * are coming. The last one will have valid RSSI info
 		 */
 		if (rxinfo & MT_RXINFO_RSSI) {
-			if (!++dev->mt76.ampdu_ref)
-				dev->mt76.ampdu_ref++;
+			if (!++dev->ampdu_ref)
+				dev->ampdu_ref++;
 		}
 	}
 
-- 
2.24.0

