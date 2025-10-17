Return-Path: <linux-wireless+bounces-28018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB2BE7496
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B3E188339E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EC2C21E8;
	Fri, 17 Oct 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ampTKbWX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85D2C029D
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691056; cv=none; b=hqwfZe5Pt7rboyjPQ0MD90FHRtdlsKJgAP6hCXA+lyGXsTX5vgTAIA3NbzAZaUnKELFgyC46PAqE0BcWduo0lLhMTtTXb4ibSzAyzBgz2f2xIcmLHObu4N/97/Gd5zMKsqeL3gouHTmNFavMpjWt4+myLmXIz+bvzoWj8rTBMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691056; c=relaxed/simple;
	bh=DQkSsVMaYGDVVkEmwMPKfQjlm454VZVR4XhcU5KYZws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKDl6S631NeQtlttWSCsvzkwCUzzVjUPXEcU7XKei6Wom/Mt8X/khj49m71H0HzNHCMJAZeTJS5Xoa77FMq3qPf/M+RuWmODbH1WN4xtj6L0/2r2YwMCKHpIAiBApzl8pY1NvBJewKHaqUY0mXEl5jJYs971tPYitet0bSfdtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ampTKbWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0BBC4CEF9;
	Fri, 17 Oct 2025 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691056;
	bh=DQkSsVMaYGDVVkEmwMPKfQjlm454VZVR4XhcU5KYZws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ampTKbWXfehp3hE+N6k+pgBN+Yx9wX0S4UbMCmQjhOYqmt6y0I17yBMkT/ygIqQ3/
	 +4Y+xVbYcLogjmdP97tFVbzLJwH7IeK1ptuyFkZ5y4jLQvQCRaWFoTrk1D9QXzcw7T
	 17KbYmEueM4aSjEAL9fmzjH+nmLuuC/PVOqqS6ttxyk0C93QiNQw4O0HmPeowU9TPY
	 fKpOPbosc7RR7JNUMb/axerIHY8Aph9/Bd3KBD2V6SeF7wSr0xy0n4HaxwCJXohjcZ
	 W4tv3hETiv4qHHVRTcWwe5O8Bl/5jBc/b9s+0H9jFMPneusyhkr6k1b7tOZSqDQ10+
	 naMyTFlRgLagQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 10:50:30 +0200
Subject: [PATCH mt76 v2 2/5] wifi: mt76: Add mt76_dev pointer in mt76_queue
 struct.
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mt76-npu-devel-v2-2-ddaa90901723@kernel.org>
References: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
In-Reply-To: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary patch to enable traffic forward offloading via the
Airoha NPU module available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2dd3bd990fbaf6b98f619be45ef4be0d5465293e..a4c1b6c66488386805c4bb21fbd11d7857f69e4d 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -794,6 +794,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->ndesc = n_desc;
 	q->buf_size = bufsize;
 	q->hw_idx = idx;
+	q->dev = dev;
 
 	size = mt76_queue_is_wed_rro_ind(q) ? sizeof(struct mt76_wed_rro_desc)
 					    : sizeof(struct mt76_desc);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e7a00669fe017e39b11cd38b603d4026f74f95b0..b0ff65427088128a6a83557b195f0e98aa012b32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -247,6 +247,7 @@ struct mt76_queue {
 	__le16 *emi_cpu_idx;
 
 	struct mtk_wed_device *wed;
+	struct mt76_dev *dev;
 	u32 wed_regs;
 
 	dma_addr_t desc_dma;

-- 
2.51.0


