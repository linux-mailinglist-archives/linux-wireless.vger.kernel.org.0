Return-Path: <linux-wireless+bounces-31076-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFwwA1QBcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31076-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:52:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9246465883
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A118A34B3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B33F076C;
	Thu, 22 Jan 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myDhehn6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8133E9F83
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078444; cv=none; b=h1MgQG4Qa2ZBIBP6W9NtVfyTd6VV6HTGlbOwyFbCVdsWGMt+XPL08cynO6X2sGCipbeaPEyZClreaonVZR4Ni7y7G3jg0UQuy/FcNWJ7M1rxEV13llCLas5EbPjpjzvVwkXqPjO6V+Xyhu4BjxpV5KXwRYkFAa5eMdi/MkY0zSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078444; c=relaxed/simple;
	bh=6RG/0E+e7ypwdL1JqZ0zGng7cYN5PEFOPEDzMeJF3D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrRZbCxkXfbmwHd0wY1hlblQYvFxoBeVOZLigQ9CpCtl37iNGii1AfmGdfWGXr6dk3OcK/r1ygBHj4LLz4+jq4g8mpMl4rlqDzkp8qtossLMaUKb85b2k6o0VvcPgCmfV5KKaKKOa2YEARr5pvjJ9F9jupwTn8yaO4fp2p7S6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myDhehn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E069C116C6;
	Thu, 22 Jan 2026 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078443;
	bh=6RG/0E+e7ypwdL1JqZ0zGng7cYN5PEFOPEDzMeJF3D0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=myDhehn6XWyqg2YOYOJB/E3akVEXbNvMBZbpDkAWDz4e60fDxQNE3EH2ANkYet+73
	 Q4G9IeSIWXhZAyL6oxBelvSF2mf5Fds3cR7xhfm3faaV5+/W22NJWac/D3GzLkuxtQ
	 vL2aiI2H06lFn3Fw8mxWVJHythHblyIr/rEEEPsiLuztsH5Zd9fzOfkOnEWnoGx7MI
	 055UaEJyuBgpSXGz0yZMiGZVV13ZQgqqu4CDva536Ni0W4F7bf56cnTtVvQ7S5FdCd
	 Knh4CiM3W3urzvz5JG5dSwQiKZbLHqcGEaTFOgcKh8EJPLE37+pftYay+UHUSIK0uW
	 Z4u94QtIjGzOw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:59 +0100
Subject: [PATCH mt76 v2 15/17] wifi: mt76: mt7996: Do not schedule RRO and
 TxFree queues during reset for NPU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-15-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31076-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 9246465883
X-Rspamd-Action: no action

This is a preliminary patch to properly manage reset procedure when NPU
offloading is enabled.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h       | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c |  5 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 14 ++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f5c6bb94ccbbda6afe03b24cf245b30c797e855d..2d133ace7c33ac5492e287a53510ee4b6a6b7403 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -881,6 +881,10 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 		    mt76_queue_is_wed_rro(q))
 			continue;
 
+		if (mt76_npu_device_active(dev) &&
+		    mt76_queue_is_wed_rro(q))
+			continue;
+
 		if (!mt76_queue_is_wed_rro_rxdmad_c(q) &&
 		    !mt76_queue_is_wed_rro_ind(q))
 			mt76_put_page_pool_buf(buf, false);
@@ -923,6 +927,13 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	    mt76_queue_is_wed_rro(q))
 		return;
 
+	if (mt76_npu_device_active(dev) &&
+	    mt76_queue_is_wed_rro(q))
+		return;
+
+	if (mt76_queue_is_npu_txfree(q))
+		return;
+
 	mt76_dma_sync_idx(dev, q);
 	if (mt76_queue_is_npu(q))
 		mt76_npu_fill_rx_queue(dev, q);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index eefc3f555f8afea2af67517683d522b657e20b7b..5e68efc367fce63bcc60a8792e6f9d118283e3ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -55,6 +55,8 @@
 				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
 #define MT_NPU_Q_TX(_n)		__MT_NPU_Q(MT76_WED_Q_TX, _n)
 #define MT_NPU_Q_RX(_n)		__MT_NPU_Q(MT76_WED_Q_RX, _n)
+#define MT_NPU_Q_TXFREE(_n)	(FIELD_PREP(MT_QFLAG_WED_TYPE, MT76_WED_Q_TXFREE) | \
+				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
 
 struct mt76_dev;
 struct mt76_phy;
@@ -2003,6 +2005,14 @@ static inline bool mt76_queue_is_npu_rx(struct mt76_queue *q)
 	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX;
 }
 
+static inline bool mt76_queue_is_npu_txfree(struct mt76_queue *q)
+{
+	if (q->flags & MT_QFLAG_WED)
+		return false;
+
+	return FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_TXFREE;
+}
+
 struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
 int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 1a4f5f5b2a8435933070bb7d8feab26a0c174922..8f5d297dafce23dcb3c1e53678f8d67dab9e8987 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -756,6 +756,9 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	     (is_mt7992(&dev->mt76)))) {
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].wed = wed;
+	} else if (is_mt7992(&dev->mt76) &&
+		   mt76_npu_device_active(&dev->mt76)) {
+		dev->mt76.q_rx[MT_RXQ_MAIN_WA].flags = MT_NPU_Q_TXFREE(0);
 	}
 
 	if (mt7996_has_wa(dev)) {
@@ -888,6 +891,8 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 				/* tx free notify event from WA for band0 */
 				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
 				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
+			} else if (mt76_npu_device_active(&dev->mt76)) {
+				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_NPU_Q_TXFREE(0);
 			}
 
 			ret = mt76_queue_alloc(dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ebce6b080886896be746c37690ef38713fe2cbc2..c88a97dbab8d529e71c8bcbb146e7e319c32e6e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2563,6 +2563,13 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
 			continue;
 
+		if (mt76_npu_device_active(&dev->mt76) &&
+		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
+			continue;
+
+		if (mt76_queue_is_npu_txfree(&dev->mt76.q_rx[i]))
+			continue;
+
 		napi_disable(&dev->mt76.napi[i]);
 	}
 	napi_disable(&dev->mt76.tx_napi);
@@ -2618,6 +2625,13 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
 			continue;
 
+		if (mt76_npu_device_active(&dev->mt76) &&
+		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
+			continue;
+
+		if (mt76_queue_is_npu_txfree(&dev->mt76.q_rx[i]))
+			continue;
+
 		napi_enable(&dev->mt76.napi[i]);
 		local_bh_disable();
 		napi_schedule(&dev->mt76.napi[i]);

-- 
2.52.0


