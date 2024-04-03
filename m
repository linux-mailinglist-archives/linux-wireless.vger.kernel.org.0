Return-Path: <linux-wireless+bounces-5804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA873896D61
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C61C21FDA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B443AB4;
	Wed,  3 Apr 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ekZsdoym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42B1411FC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141733; cv=none; b=dd0ZtjhPy9Q3wPLrAYg4rjG5zPsIVAcY5myJUBnA/8KVs35pDrkYSNsXJy5tfSIHtxVIcKlcGPFgT88HWZ1oHYVO6Q2dTWj3vY1BYC27ZJfEr5A8WmjgQZ+vJNwjB3TuPrqCQSb+P2b2Qj2o4CvVxDb2OBSX+D0SS74KKkvuFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141733; c=relaxed/simple;
	bh=OXnLBvhO+pTjhmhUpWBHMfulniUgx1opC9NtdV5oSH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5U7bmvlK//q8rMHw9CATH4nsjVnNVxxAPdjhLvr2wiZfm+lBpf46V4kS5Dj0hKWtbeIxtYFsGHJkHK9CBISzPF4PImMtix6VQe9FACEzCjGKMoxuyiMtFFI83JJ8cu4p8uDsmBQSJjiZ/Mh30koQEe38ADhJl/CpHq3+fOsK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ekZsdoym; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5lP0IBnIIK8zvGHDHh/xa0kI4gpiW5jjRsW8EHqgMBA=; b=ekZsdoymf2hKAHUVHFQvMB/Whs
	NQicgMeeAzebLENpcMMa1oRjbS+t+cmSrVqq1Zx2kldjXYEuvytHIpe7yo8leWTLwuPikMa38DW0e
	sO5GpJuY+s5hdN1LO0Zri1aMy8XrPmtXYBSQAMjAi1fRBRtbVWMlRC//f3C1r/VIQQsc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt4-00CgfA-NH
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:34 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 12/13] wifi: mt76: mt7603: fix tx queue of loopback packets
Date: Wed,  3 Apr 2024 12:30:31 +0200
Message-ID: <20240403103032.54823-12-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct WMM AC queue instead of the MGMT one to fix potential issues
with aggregation sequence number tracking. Drop non-bufferable packets.

Fixes: fca9615f1a43 ("mt76: mt7603: fix up hardware queue index for PS filtered packets")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 7a2f5d38562b..14304b063715 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -4,6 +4,13 @@
 #include "mac.h"
 #include "../dma.h"
 
+static const u8 wmm_queue_map[] = {
+	[IEEE80211_AC_BK] = 0,
+	[IEEE80211_AC_BE] = 1,
+	[IEEE80211_AC_VI] = 2,
+	[IEEE80211_AC_VO] = 3,
+};
+
 static void
 mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 {
@@ -22,10 +29,10 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct mt7603_sta *msta;
 	struct mt76_wcid *wcid;
+	u8 tid = 0, hwq = 0;
 	void *priv;
 	int idx;
 	u32 val;
-	u8 tid = 0;
 
 	if (skb->len < MT_TXD_SIZE + sizeof(struct ieee80211_hdr))
 		goto free;
@@ -42,19 +49,36 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 		goto free;
 
 	priv = msta = container_of(wcid, struct mt7603_sta, wcid);
-	val = le32_to_cpu(txd[0]);
-	val &= ~(MT_TXD0_P_IDX | MT_TXD0_Q_IDX);
-	val |= FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_HW_QUEUE_MGMT);
-	txd[0] = cpu_to_le32(val);
 
 	sta = container_of(priv, struct ieee80211_sta, drv_priv);
 	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
-	if (ieee80211_is_data_qos(hdr->frame_control))
+
+	hwq = wmm_queue_map[IEEE80211_AC_BE];
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tid = *ieee80211_get_qos_ctl(hdr) &
-		      IEEE80211_QOS_CTL_TAG1D_MASK;
-	skb_set_queue_mapping(skb, tid_to_ac[tid]);
+			 IEEE80211_QOS_CTL_TAG1D_MASK;
+		u8 qid = tid_to_ac[tid];
+		hwq = wmm_queue_map[qid];
+		skb_set_queue_mapping(skb, qid);
+	} else if (ieee80211_is_data(hdr->frame_control)) {
+		skb_set_queue_mapping(skb, IEEE80211_AC_BE);
+		hwq = wmm_queue_map[IEEE80211_AC_BE];
+	} else {
+		skb_pull(skb, MT_TXD_SIZE);
+		if (!ieee80211_is_bufferable_mmpdu(skb))
+			goto free;
+		skb_push(skb, MT_TXD_SIZE);
+		skb_set_queue_mapping(skb, MT_TXQ_PSD);
+		hwq = MT_TX_HW_QUEUE_MGMT;
+	}
+
 	ieee80211_sta_set_buffered(sta, tid, true);
 
+	val = le32_to_cpu(txd[0]);
+	val &= ~(MT_TXD0_P_IDX | MT_TXD0_Q_IDX);
+	val |= FIELD_PREP(MT_TXD0_Q_IDX, hwq);
+	txd[0] = cpu_to_le32(val);
+
 	spin_lock_bh(&dev->ps_lock);
 	__skb_queue_tail(&msta->psq, skb);
 	if (skb_queue_len(&msta->psq) >= 64) {
@@ -151,12 +175,6 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 
 int mt7603_dma_init(struct mt7603_dev *dev)
 {
-	static const u8 wmm_queue_map[] = {
-		[IEEE80211_AC_BK] = 0,
-		[IEEE80211_AC_BE] = 1,
-		[IEEE80211_AC_VI] = 2,
-		[IEEE80211_AC_VO] = 3,
-	};
 	int ret;
 	int i;
 
-- 
2.43.0


