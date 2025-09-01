Return-Path: <linux-wireless+bounces-26901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95648B3F02A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 22:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500FA484538
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C0274B2A;
	Mon,  1 Sep 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So8XhW/R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14E1DDA0E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760310; cv=none; b=SsFoBypnU4PmdQnV2sLNSxuPbF1SE3yBDDq2ETy4g7UXWqEfBuzvg6lY6kJYoI9A66+Dvud8zlQeLPkquRZ80mZYBgoLTbtuMZEykUDhW3/oVXR791z1F4Iz7cBnrgnZfFBcNUD2DofxFLZ0aprCyKRMZGbwdlCO6i9TSEtm4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760310; c=relaxed/simple;
	bh=k1s+njTPjCd5rbLQdcWTH0bKYzRVPZIFCmHz60CudLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dR+dzzLXPm5YBIyU9UVorWsKojTDvFNj4K+BHWt3JAgCZjdzHxjweq98pRyS9dX1cGeRYKPkDltwt7JZHKEvYO0tEMx6pEwFd3GyTAksKqDS3DwByNYLjvMvXd403IxdWHcMU7wOlIMY2BduNYfouQGti2Mnfk7AHI82NpUslXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So8XhW/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100A3C4CEF0;
	Mon,  1 Sep 2025 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760310;
	bh=k1s+njTPjCd5rbLQdcWTH0bKYzRVPZIFCmHz60CudLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=So8XhW/Rc6Xklwtfiulwwb5rbdts4T7m5/cj59AN4ht43JtPH7938fphx9AJ/TcCy
	 mLQ79XKuRv3eDsK6Sws7jF/3Qi45Fvn3GXB1a6vgWpU+QC5NxBPuvurT90k9GtezSL
	 qlbjhFNlTE0lAYzlCuYD9Chvufc2LU03wjk7q2M5r225HZi3Y/q+pbuymz5/3+y7Cs
	 pQeHWHZxxasv6ts3t5DAeQHAOM9V+lC6Y/zlp/RcvqkMxaDByjf0EeEomcbdBcv6j9
	 X8brXLEEe7xQWFRbyxi9TMLvumt69A4lCHycENM1Kq29BJ2R4Az7fvb6vHpCIJ43Zo
	 6EJ9MkkxNNLtQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 22:57:59 +0200
Subject: [PATCH mt76 v2 03/14] wifi: mt76: Differentiate between RRO data
 and RRO MSDU queues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-rro-rework-v2-3-1f95086b51d1@kernel.org>
References: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
In-Reply-To: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
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


