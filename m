Return-Path: <linux-wireless+bounces-27017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02037B442FE
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C4D1C86900
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE02FC86F;
	Thu,  4 Sep 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE2y3pxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E252F8BC1
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003905; cv=none; b=fR8V1CxgBqBsqFiP7cdgSlqmas/vRAttAS40WOGMXAWmwMWUN181zGSAXTHtQ9uL2TFZ02aJ8G+jbENgKU4IsfJpFt3/EuuTufp4bFesGEdbyQISHwRy4Oq6d3d39duik1I/7i6FURU/JD1OpxHYrWRX4N4JHJfhRZp+dgcGa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003905; c=relaxed/simple;
	bh=k1s+njTPjCd5rbLQdcWTH0bKYzRVPZIFCmHz60CudLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgUDc8DKMA3tLefzimAS89JVMzV3jnrjNV3MrVY0VZsZpsLtMKGV/f9yRuSG0R6EYTosMh202Y1SyBI9RQx4IMIKwwK8GBXdKR8TkbuA++0WWyRgXx5i6FFxBVd73vQ2yIWN5EWYq9c9cShpGuxPQdTxBhdeWiWyn0Lu55D/UZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE2y3pxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B760C4CEF0;
	Thu,  4 Sep 2025 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003905;
	bh=k1s+njTPjCd5rbLQdcWTH0bKYzRVPZIFCmHz60CudLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tE2y3pxLdyiuuiBC6jrSdgIToLTDCLT1cr8ckhsK7dTyNH++m4pWCi1xixP6x/pmG
	 Hue2M+cK5XRh6AN7ENX3GA1wr/qpV8jbA7Oaanafpp/jjKTWwJwF9l+mh4dY9aT1YU
	 jWQ30nvFwOMoE9lPkNxDdFn/ksJZs0KCHzx5m2bdgkFlkUUFdQD2r4lyOvt41BEHNI
	 wo1DETpEV8v8W6C+8z13l/Gre7Llim/sf+XASy1Garhy8JZkkySxor2r+7Kk8HsM5x
	 u7WyX6vDUffGYgx0oePyAtGtRIzrp4DuHewIOj2RefqfX0IU+EublchI9vxND6c2kj
	 fu08eXxVu+0+A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 18:37:57 +0200
Subject: [PATCH mt76 v4 03/15] wifi: mt76: Differentiate between RRO data
 and RRO MSDU queues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-rro-rework-v4-3-2cd91e7229d6@kernel.org>
References: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
In-Reply-To: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

This is a preliminary patch to enable WED support for MT7992 Kite
chipset supported by MT7996 driver.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 18c2a2de59897d038392a00ed5fb5a0de188ac95..68b1dd1dbbe0e2b4850e02ee70253b5e248c69bf 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -477,7 +477,7 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	if (!q->queued)
 		return NULL;
 
-	if (mt76_queue_is_wed_rro_data(q))
+	if (mt76_queue_is_wed_rro_data(q) || mt76_queue_is_wed_rro_msdu_pg(q))
 		return NULL;
 
 	if (!mt76_queue_is_wed_rro_ind(q)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 314221fec512c99cc15b942b7ef7ccecfd1d987e..58d8aa213bb7bf7d1bab0926eca23303d8a733a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1785,8 +1785,14 @@ static inline bool mt76_queue_is_wed_rro_ind(struct mt76_queue *q)
 static inline bool mt76_queue_is_wed_rro_data(struct mt76_queue *q)
 {
 	return mt76_queue_is_wed_rro(q) &&
-	       (FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_DATA ||
-		FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_MSDU_PG);
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_DATA;
+}
+
+static inline bool mt76_queue_is_wed_rro_msdu_pg(struct mt76_queue *q)
+{
+	return mt76_queue_is_wed_rro(q) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) ==
+	       MT76_WED_RRO_Q_MSDU_PG;
 }
 
 static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
@@ -1795,7 +1801,8 @@ static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
 		return false;
 
 	return FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX ||
-	       mt76_queue_is_wed_rro_ind(q) || mt76_queue_is_wed_rro_data(q);
+	       mt76_queue_is_wed_rro_ind(q) || mt76_queue_is_wed_rro_data(q) ||
+	       mt76_queue_is_wed_rro_msdu_pg(q);
 
 }
 

-- 
2.50.1


