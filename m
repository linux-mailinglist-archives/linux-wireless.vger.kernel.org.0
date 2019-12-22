Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98691128E9F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLVPHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 10:07:20 -0500
Received: from nbd.name ([46.4.11.11]:47416 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfLVPHT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 10:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pKmVTL+U65pxt5V/CqFj7ZqbjoX8fSXosEnGCSBiVnw=; b=Wa49EoEvYm+Rv+ey/0YLGwxeQb
        YuPfTw61c3GlxDceadwt2taW8ii/iZdvQMfB4DxlrTwRmDyjqidlFnPNRgmztmR3PLAp2WTls7eXu
        akHaaEL71WIWIMDGQNz/xB9PY6fVLxj5ZQnqh6TS7Hw7aRLxUHW8V7j/lxlk+gMKPdeY=;
Received: from [81.95.5.44] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ij2pC-00030V-02
        for linux-wireless@vger.kernel.org; Sun, 22 Dec 2019 16:07:18 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 4B25D742EAF9; Sun, 22 Dec 2019 16:07:17 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: mt7603: fix input validation issues for powersave-filtered frames
Date:   Sun, 22 Dec 2019 16:07:16 +0100
Message-Id: <20191222150717.51379-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191222150717.51379-1-nbd@nbd.name>
References: <20191222150717.51379-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before extracting the tid out of the packet, check if it was qos-data.
Only accept tid values 0-7
Also, avoid accepting the hardware queue as skb queue mapping, it could
lead to an overrun. Instead, derive the hardware queue from the tid number,
in order to avoid issues with packets being filtered multiple times.
This also fixes a mismatch between hardware and software queue indexes.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index a6ab73060aad..57428467fe96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -30,6 +30,16 @@ mt7603_init_tx_queue(struct mt7603_dev *dev, struct mt76_sw_queue *q,
 static void
 mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 {
+	static const u8 tid_to_ac[8] = {
+		IEEE80211_AC_BE,
+		IEEE80211_AC_BK,
+		IEEE80211_AC_BK,
+		IEEE80211_AC_BE,
+		IEEE80211_AC_VI,
+		IEEE80211_AC_VI,
+		IEEE80211_AC_VO,
+		IEEE80211_AC_VO
+	};
 	__le32 *txd = (__le32 *)skb->data;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_sta *sta;
@@ -38,7 +48,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	void *priv;
 	int idx;
 	u32 val;
-	u8 tid;
+	u8 tid = 0;
 
 	if (skb->len < MT_TXD_SIZE + sizeof(struct ieee80211_hdr))
 		goto free;
@@ -56,15 +66,16 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 
 	priv = msta = container_of(wcid, struct mt7603_sta, wcid);
 	val = le32_to_cpu(txd[0]);
-	skb_set_queue_mapping(skb, FIELD_GET(MT_TXD0_Q_IDX, val));
-
 	val &= ~(MT_TXD0_P_IDX | MT_TXD0_Q_IDX);
 	val |= FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_HW_QUEUE_MGMT);
 	txd[0] = cpu_to_le32(val);
 
 	sta = container_of(priv, struct ieee80211_sta, drv_priv);
 	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
-	tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	if (ieee80211_is_data_qos(hdr->frame_control))
+		tid = *ieee80211_get_qos_ctl(hdr) &
+		      IEEE80211_QOS_CTL_TAG1D_MASK;
+	skb_set_queue_mapping(skb, tid_to_ac[tid]);
 	ieee80211_sta_set_buffered(sta, tid, true);
 
 	spin_lock_bh(&dev->ps_lock);
-- 
2.24.0

