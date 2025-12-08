Return-Path: <linux-wireless+bounces-29603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27231CAE07C
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B209300DCB5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3B2D0C9C;
	Mon,  8 Dec 2025 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCFLtg+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFDB2D0C90
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220068; cv=none; b=vCCrPYeRBRtIfb77OLYKJ4wba/Vj0G6VX3Ltp5iMTF544R59BtUuJYAc0YabGm2jkTktXr8qyYl+qA/wgBcKvxo/rZxdjx/UUwXgX06qAbhA6TTpsj2b6KRzFaCWw2Gn19VPboKii6ULHt1cFb+5KcwGsChIxAFXFg/hD6Wb8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220068; c=relaxed/simple;
	bh=+j42bWBM6FxWkedAG9VsQO2lPFNc7TyTq/4KGNmXP3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dbn4yRhY8kVRmw2J6s3I3KoFoPYWqNVDdPZ7BirBblTdk3PCci3ZTGnDaUQLz+WWhh7XzKpQG3vG5P+b7tNFu3UYAjpAaqc5sokZSAvQdjddycP18rg1ISd759WCQTwGpbm9m3Q4D/BC598m3CzdFwnltuNA9ZYOJj4V4Mluzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCFLtg+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B346C4CEF1;
	Mon,  8 Dec 2025 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765220067;
	bh=+j42bWBM6FxWkedAG9VsQO2lPFNc7TyTq/4KGNmXP3A=;
	h=From:Date:Subject:To:Cc:From;
	b=jCFLtg+cx1OBvUAqbzFG6wdHu+kXNLLSbgE7JcKRpLeyBtQbz6x6IMsDPyZi7HKaj
	 bvMbxbBYsj35U9j123agnI4wrpI98aOsyEd6eUQWqv+PQSJ1JUIywKprE/ZWCzYLhN
	 eCyQrTePCAwVUmWiO6GaFuBhFPplZTQLmVRLPM/+I9ufPnRV+LLbcNQWonYtLHmmOC
	 ipsTQK/3Tyznzsdl3wIdBxFpH3sdWbdhrvthFiJSggX9uksPCFR6APsE6MNj5ZUWRH
	 QT7HJmIcT23Lsv9iwjYt19t6+xc5i3DyyIx/VYFMd/ewQW5ZQk9Xy+uoNyOR5Qk2aF
	 oEyZpEi1ktOhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 08 Dec 2025 19:54:08 +0100
Subject: [PATCH mt76] wifi: mt76: Fix memory leak destroying device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-mt76-fix-memory-leak-v1-1-cba813fc62b8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAMBRAf0X32a1tMsuvyMNwx42hTSL5d8vjq
 XPOA5ECU4Q6eyDQyZG3NYHMM+gnu46EPCQGJVQplTDoj0qj4ws9+S3cuJCdUZpCG9FJ65yAlO6
 BkvJvm/Z9PzQeRrpmAAAA
X-Change-ID: 20251208-mt76-fix-memory-leak-183680b1aff0
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

All MT76 rx queues have an associated page_pool even if the queue is not
associated to a NAPI (e.g. WED RRO queues with WED enabled). Destroy the
page_pool running mt76_dma_cleanup routine during module unload.
Moreover returns pages to the page pool if WED is not enabled for WED RRO
queues.

Fixes: 950d0abb5cd94 ("wifi: mt76: mt7996: add wed rx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f240016ed9f0ead27e98e350f4fdb818e1686781..893ac14285cab3c22f70945d490627a64b643efe 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -874,7 +874,12 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!buf)
 			break;
 
-		if (!mt76_queue_is_wed_rro(q))
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    mt76_queue_is_wed_rro(q))
+			continue;
+
+		if (!mt76_queue_is_wed_rro_rxdmad_c(q) &&
+		    !mt76_queue_is_wed_rro_ind(q))
 			mt76_put_page_pool_buf(buf, false);
 	} while (1);
 
@@ -1168,10 +1173,6 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
-		if (mtk_wed_device_active(&dev->mmio.wed) &&
-		    mt76_queue_is_wed_rro(q))
-			continue;
-
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, q);
 

---
base-commit: 53d1548612670aa8b5d89745116cc33d9d172863
change-id: 20251208-mt76-fix-memory-leak-183680b1aff0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


