Return-Path: <linux-wireless+bounces-32741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHcfFrhjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:07:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB384234166
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E70663006145
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96052355803;
	Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Fy0N0uYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5A350A1F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036466; cv=none; b=Hn47HX9PWhrPt46NfGDvtEPqo6P1pQROL/tXG03yZT1cQQRtN1me6B4Oy1SxBLF1FIIlEYw+7X76MD2v9XFh75Lhh4PY5928OPctRVBl/6JoNu24t/7euM2vI+aEnUtM9MHsUJ6Tw8MJLqwJ/zoqh8Ml4w268dSdRTv35XjLUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036466; c=relaxed/simple;
	bh=yufl/3J9JCN7V1vl9weGeB5JVvG2s99PgRNMrhkZX/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBU7bblsrFFgZtZU1JiSv56Ok7M5OYYZm0LX6VyhCVlkcQdMnoq5JYQm+4S9lgoGczpTo1dWVqd066uuMb3Wo3SKErOIN54FDdiPm7iepf2ZKw8Csn2cmOclHbCk+djYhmhFxsuTH9HD/w01gTWq8vgeCwMRzxRJ8oKNU1IIj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Fy0N0uYy; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Rcg0JbdLePtCDvhXZEByTNpLCxIxrbIAXOHUZscSDyw=; b=Fy0N0uYyUauwZFb+3dVYS24P1C
	PfU9wHGpPA9Kua8YkuZGP9kvboMbup+UWwgEI/yGoSxfHFUbq6n2d4Zao94Kga5kht3MenzpawVn3
	mb5QiOO1DmXut02x41ykeWWxKolII0NOuwGj1iMLbQ6UriDupvK9bUtrqMyWIpTfKgJ4=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmE-00GH43-0B
	for linux-wireless@vger.kernel.org;
	Mon, 09 Mar 2026 07:07:38 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 10/11] wifi: mt76: wait for firmware TX completion of mgmt frames before channel switch
Date: Mon,  9 Mar 2026 06:07:29 +0000
Message-ID: <20260309060730.87840-10-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309060730.87840-1-nbd@nbd.name>
References: <20260309060730.87840-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB384234166
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32741-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.570];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

After flushing software-pending frames to DMA, mt76_has_tx_pending()
only checks DMA ring q->queued. For token-based drivers, q->queued is
decremented at DMA consumption, but firmware may not have transmitted
the frame yet. Waiting for all tokens is not feasible because data
frames may be stuck in firmware powersave/aggregation queues.

Track PSD queue tokens (firmware ALTX) per phy using an atomic counter.
These frames are sent by firmware immediately without PS buffering, so
the counter reliably reaches zero after transmission.

Increment the counter in mt76_token_consume() and decrement it in
mt76_token_release(), only for PSD queue tokens. Include the counter
in mt76_has_tx_pending() so channel switch waits for firmware TX
completion of management and nullfunc frames.

mt7615 (uses mt76_token_get/put) and non-token drivers are unaffected
as they never call mt76_token_consume/release.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c           |  2 ++
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  3 +++
 drivers/net/wireless/mediatek/mt76/mt76.h          |  3 +++
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  6 ++++++
 drivers/net/wireless/mediatek/mt76/tx.c            | 14 +++++++++++++-
 6 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2d133ace7c33..f8c2fe5f2f58 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -666,6 +666,8 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	if (!t)
 		goto free_skb;
 
+	t->phy_idx = phy->band_idx;
+	t->qid = qid;
 	txwi = mt76_get_txwi_ptr(dev, t);
 
 	skb->prev = skb->next = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 51fe696c9825..38b2088e8c19 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -971,6 +971,9 @@ bool mt76_has_tx_pending(struct mt76_phy *phy)
 			return true;
 	}
 
+	if (atomic_read(&phy->mgmt_tx_pending))
+		return true;
+
 	return false;
 }
 EXPORT_SYMBOL_GPL(mt76_has_tx_pending);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fe4f30ea71da..0e6be1d0dffa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -453,6 +453,7 @@ struct mt76_txwi_cache {
 	};
 
 	u8 qid;
+	u8 phy_idx;
 };
 
 struct mt76_rx_tid {
@@ -863,6 +864,8 @@ struct mt76_phy {
 	struct list_head tx_list;
 	struct mt76_queue *q_tx[__MT_TXQ_MAX];
 
+	atomic_t mgmt_tx_pending;
+
 	struct cfg80211_chan_def chandef;
 	struct cfg80211_chan_def main_chandef;
 	bool offchannel;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 15d8a6da0c92..ad539b22585e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1209,5 +1209,11 @@ void mt76_connac2_tx_token_put(struct mt76_dev *dev)
 	}
 	spin_unlock_bh(&dev->token_lock);
 	idr_destroy(&dev->token);
+
+	for (id = 0; id < __MT_MAX_BAND; id++) {
+		struct mt76_phy *phy = dev->phys[id];
+		if (phy)
+			atomic_set(&phy->mgmt_tx_pending, 0);
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_tx_token_put);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ed9ada53f8e5..ae7ce19a4d9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2215,6 +2215,12 @@ void mt7996_tx_token_put(struct mt7996_dev *dev)
 	}
 	spin_unlock_bh(&dev->mt76.token_lock);
 	idr_destroy(&dev->mt76.token);
+
+	for (id = 0; id < __MT_MAX_BAND; id++) {
+		struct mt76_phy *phy = dev->mt76.phys[id];
+		if (phy)
+			atomic_set(&phy->mgmt_tx_pending, 0);
+	}
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 7b0fae694f12..22f9690634c9 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -866,9 +866,15 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 	token = idr_alloc(&dev->token, *ptxwi, dev->token_start,
 			  dev->token_start + dev->token_size,
 			  GFP_ATOMIC);
-	if (token >= dev->token_start)
+	if (token >= dev->token_start) {
 		dev->token_count++;
 
+		if ((*ptxwi)->qid == MT_TXQ_PSD) {
+			struct mt76_phy *mphy = mt76_dev_phy(dev, (*ptxwi)->phy_idx);
+			atomic_inc(&mphy->mgmt_tx_pending);
+		}
+	}
+
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	if (mtk_wed_device_active(&dev->mmio.wed) &&
 	    token >= dev->mmio.wed.wlan.token_start)
@@ -913,6 +919,12 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
 	if (txwi) {
 		dev->token_count--;
 
+		if (txwi->qid == MT_TXQ_PSD) {
+			struct mt76_phy *mphy = mt76_dev_phy(dev, txwi->phy_idx);
+			if (atomic_dec_and_test(&mphy->mgmt_tx_pending))
+				wake_up(&dev->tx_wait);
+		}
+
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 		if (mtk_wed_device_active(&dev->mmio.wed) &&
 		    token >= dev->mmio.wed.wlan.token_start &&
-- 
2.51.0


