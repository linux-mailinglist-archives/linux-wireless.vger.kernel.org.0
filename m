Return-Path: <linux-wireless+bounces-26514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F3B2FA2D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF601CE6D61
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF13277B9;
	Thu, 21 Aug 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSYpyWCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C532A3CD
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782197; cv=none; b=c1SB9TJN+JZbBwWB9syMjptACJDh0DZttVfm5SP61I97yXehN6Wy6zRg7pBG6HNYWKQapOI0ypdJ86ij/cNpfC+uG5Tmz6pwLroUdBED3f0CXnBkBViq1msPyeqd5MJmKwDtyva38usRurju1NeydeUmUvw9bC4PlPuwousZpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782197; c=relaxed/simple;
	bh=K13ohjIyRb1/j+MoFegf2ZlyiYy2YvWO06fWzpip130=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9U9a1GYtM2W+yScv0pPt2S6gcZKlQg0lwk6ju1GZpZMlC8De2J9Pveb+kCze6QvTanzgXy5bu1mR2gfxeQ1OCj+qNkWCSdOd+NXfcrI2IiOxTzn40MU8NiRtcnKuTJuu9QkCdGRshWuJoVLIMtr0UkCX7UfpK4hzKnx2ymElkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSYpyWCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF85C4CEEB;
	Thu, 21 Aug 2025 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782197;
	bh=K13ohjIyRb1/j+MoFegf2ZlyiYy2YvWO06fWzpip130=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GSYpyWCT3D0cjTppQWiB6wNdzM9/P/TXJ9zK8gdE/GbuUdrvs5u6EUnuqX4wYRUCg
	 ta+skb5t6JVTJ1pbmqDiKZsKHiAfa+O1h1QVH7ubmvJoW491ztv/E3iBwKDzBSWvEd
	 m0RLzbvY7qnOyvDBQjar7rF2wQEPP3gOl+Ous/tPFNV0unryjBw21dyQ4l9VI9InLq
	 gjic35iy8XjQGotuWAaJGqO3Ds46IJnzTtrFVMrB4KS8ej+KfPySUhVKz9xY7Ophlj
	 W6F8dYrZwp0HjywIZXMYfBZkXF71rF76t5Ubzwp+fQfIAdeH9Q+457kuwQABFkivjp
	 tiEwpEN39ELaw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:14:55 +0200
Subject: [PATCH mt76 03/14] wifi: mt76: Differentiate between RRO data and
 RRO MSDU queues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-3-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>, Benjamin Lin <benjamin-jw.lin@mediatek.com>
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
index 623a33803dac08a578df2730ef8731fbafc6f84f..4559ff608df02c5b482a901923a6a43493cd37b3 100644
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


