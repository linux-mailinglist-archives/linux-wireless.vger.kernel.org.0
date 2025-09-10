Return-Path: <linux-wireless+bounces-27218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F0B51A93
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92E43A6558
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057F329F14;
	Wed, 10 Sep 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNk99NHe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CB329F06
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515229; cv=none; b=ZoTJ4NDLAC3EGYKQvxzCJw1GA2KlKbcMUhUIg2vIWvpJxVmwsDO/0A+d8D+FQoXadRwVeMglSzKhMT4drfPMbqkBELtk52NDn0OmQzq+Ygs+viaqIg7wKkuyhu49Bw3lvWjjU+XCllPnqCmJu3IsgaAoe5hm7HgBq1R4GG7iDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515229; c=relaxed/simple;
	bh=nispLxiM6cEGgLHVw1aVSd/bJeyN0ZNwxKBMpsAbgVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYJIfjq2GD3S+L8uwJwq/7dZC5nKipmeLf8oSiq7uFWQiX695tl71JYVP+cDzG6Jczfye8F14AI/v/AG+1NGGUIK/eR140RQ1znuysrnfsF8ogvgwhIi5DgBu0vxytL7abZMp1HU0NuR65DiG2pR0uEAwa917ZMHvZ5OKO38Itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNk99NHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED791C4CEEB;
	Wed, 10 Sep 2025 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515229;
	bh=nispLxiM6cEGgLHVw1aVSd/bJeyN0ZNwxKBMpsAbgVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HNk99NHeVPSgNoRkdAi2v9pHdI1chypEkI0Le3ZBbnBoHWAgGY5TD9Htrr8+I6u9r
	 4ipBWRwLR0dXR7DlWDkDpkh6pM68af9LCUNAt6dzNLzWLUFlVs4y3knlW9YEqok0ZL
	 O57Q2p4Ygah2dB7+wthCmX8GKzI8OI9jKSUR1I6W+hIH4quPKmx9yYTTwBPktginp9
	 Pf1q73UbbrUmekHa/jKgohhm4NHpzs+fPNhfO8raxyWY2hfzNUxDupVI5gK0SX4bJb
	 4FIJCutvYg02Dd5NcEglXxyU51DT3SPRUhJ71FbHUJDSoOIslJtWBAbWJw7dfBNZ6C
	 R4yOP/R4rig3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Sep 2025 16:40:03 +0200
Subject: [PATCH mt76 2/5] wifi: mt76: Add mt76_dev pointer in mt76_queue
 struct.
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mt76-npu-devel-v1-2-dbde4a37b9c0@kernel.org>
References: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
In-Reply-To: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
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
index f21481d4ed08400141627f91592d4d98789901b0..a285fd0a98369919e5422036b6a88b898ab65b6a 100644
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
index eede0c0fe2b97e4fbc5bf8ab75e3bf214d25e81d..d14baea02c48b6c40cd9fc45178aa4eba3e297f1 100644
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


