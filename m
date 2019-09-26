Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55FDBF7DD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfIZRrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:43 -0400
Received: from nbd.name ([46.4.11.11]:55260 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OB+Vy3vEhvW36jRxtXRU6NATCe8KjqN4H0pHRhUyd68=; b=BkpAkDEHVXy6I3e+SCQHN65KPu
        97BENbW4pPnmovS/Ouo4R9QTZVae+I1MM/zpclQx0U36wQ/gXIuU0K3jSCZ0HODNkBtP7rD0J2nyu
        9yG+Ssyfg8LIMcVnU3a6i8CDqrUqInxMojlG1lu9xW+jnkNuT0CWE7ep+O+fZoZRSFhs=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXrb-0000z3-3B
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:35 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B6CE269B6A89; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/15] mt76: report rx a-mpdu subframe status
Date:   Thu, 26 Sep 2019 19:47:19 +0200
Message-Id: <20190926174732.42375-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This can be used in monitor mode to figure out which subframes were sent as
part of which A-MPDU

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h         |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c   | 14 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7603/mt7603.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 14 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c  | 15 +++++++++++++++
 7 files changed, 50 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 1a2c143b34d0..cc301216e527 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -502,6 +502,7 @@ static struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 	status->band = mstat.band;
 	status->signal = mstat.signal;
 	status->chains = mstat.chains;
+	status->ampdu_reference = mstat.ampdu_ref;
 
 	BUILD_BUG_ON(sizeof(mstat) > sizeof(skb->cb));
 	BUILD_BUG_ON(sizeof(status->chain_signal) !=
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 331de7c44b6c..173d158d7018 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -437,6 +437,7 @@ struct mt76_dev {
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
+	u32 ampdu_ref;
 
 	struct list_head txwi_cache;
 	struct mt76_sw_queue q_tx[__MT_TXQ_MAX];
@@ -513,6 +514,8 @@ struct mt76_rx_status {
 
 	unsigned long reorder_time;
 
+	u32 ampdu_ref;
+
 	u8 iv[6];
 
 	u8 aggr:1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index c52c4bf5597e..44d093943588 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -445,6 +445,20 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
 	}
 
+	if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
+		      MT_RXD2_NORMAL_NON_AMPDU))) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+		/* all subframes of an A-MPDU have the same timestamp */
+		if (dev->rx_ampdu_ts != rxd[12]) {
+			if (!++dev->mt76.ampdu_ref)
+				dev->mt76.ampdu_ref++;
+		}
+		dev->rx_ampdu_ts = rxd[12];
+
+		status->ampdu_ref = dev->mt76.ampdu_ref;
+	}
+
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
 
 	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 17176de4fb23..01b933538c25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -109,6 +109,7 @@ struct mt7603_dev {
 	u32 false_cca_ofdm, false_cca_cck;
 	unsigned long last_cca_adj;
 
+	__le32 rx_ampdu_ts;
 	u8 rssi_offset[3];
 
 	u8 slottime;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 237d15521e18..88271524fb83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -93,6 +93,20 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
 	}
 
+	if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
+		      MT_RXD2_NORMAL_NON_AMPDU))) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+		/* all subframes of an A-MPDU have the same timestamp */
+		if (dev->rx_ampdu_ts != rxd[12]) {
+			if (!++dev->mt76.ampdu_ref)
+				dev->mt76.ampdu_ref++;
+		}
+		dev->rx_ampdu_ts = rxd[12];
+
+		status->ampdu_ref = dev->mt76.ampdu_ref;
+	}
+
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
 
 	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 8a6142637bfd..fe084555754b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -81,6 +81,8 @@ struct mt7615_dev {
 	u32 vif_mask;
 	u32 omac_mask;
 
+	__le32 rx_ampdu_ts;
+
 	struct {
 		u8 n_pulses;
 		u32 period;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 0d000906b2e1..9d2795c1e943 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -789,6 +789,21 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 	if ((rxinfo & MT_RXINFO_BA) && !(rxinfo & MT_RXINFO_NULL))
 		status->aggr = true;
 
+	if (rxinfo & MT_RXINFO_AMPDU) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+		status->ampdu_ref = dev->mt76.ampdu_ref;
+
+		/*
+		 * When receiving an A-MPDU subframe and RSSI info is not valid,
+		 * we can assume that more subframes belonging to the same A-MPDU
+		 * are coming. The last one will have valid RSSI info
+		 */
+		if (!(rxinfo & MT_RXINFO_RSSI)) {
+			if (!++dev->mt76.ampdu_ref)
+				dev->mt76.ampdu_ref++;
+		}
+	}
+
 	if (WARN_ON_ONCE(len > skb->len))
 		return -EINVAL;
 
-- 
2.17.0

