Return-Path: <linux-wireless+bounces-29490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B35CA2C2D
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4830F3040A57
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814D314B62;
	Thu,  4 Dec 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHlnlNK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F912E7631
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835889; cv=none; b=KxqUeYN6S9zAPJy6TMn4y23gVHIhU7FBC/lfiF2Uo7LGncxYco5ElMWRaYwAXkYcxCFhJLFb19fvI+eK7qmsm0mZK1TkWR7tMpz37xnS5NrWQGP/Pjv5zZEFXnWVTw6QuLXg4F9Fc5Iu+k0sEXjNYWXHBpKo3bJjIxUP4duNnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835889; c=relaxed/simple;
	bh=RIU6GkpCLhhyvpG/pii7imXnivFO6h+OFuTntfyksk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfK0pFJeU0kmZdK/KDm9QBAGx2241Aj4D1pwN+p7VlbmcApPpND/13MiGmnU+Y6GbVESjwImJWRSMGCNg01gh3qzfo0Z6icroWbzYnx/RTSqTzCS0Sep2ehy5/7bFjpPWVwgTnLxyJbIdPNbxfF1IdKWlxUgIC6xdV6IhsW3iFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHlnlNK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA859C4CEFB;
	Thu,  4 Dec 2025 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835889;
	bh=RIU6GkpCLhhyvpG/pii7imXnivFO6h+OFuTntfyksk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GHlnlNK+/AjvnPai1eCAvyd7kjq5CyI7lV/hMgNTpWgx46Ip+iAZASjqaWf3eBnAL
	 yUNUVEXBvvH+XBLGFdB7bkrbrvC7iYXlb2H1oppbHDbrrGthsDU4iriGWazGZMO81L
	 5mjdRRbg6lxBSdpFHw9+yW0W5cRMNOjM3Tr6XVj7K2L0HrKJswgdPffoX2D0z9kJMT
	 q/srkHsuCjDX/To4JMKpUhidy85K0PdOAv/wbM7He6ivNGfDh0aijKGEYS5YhnUH1s
	 sU1mTTiIgLvq3xXSfyEUmMpV8/u5EB3G1qpUwh4vsi4B1PgNSeocj0h7/nfszJWfu2
	 9YjN2uG3ezZqg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:44 +0100
Subject: [PATCH mt76 02/11] wifi: mt76: npu: Add missing rx_token_size
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-2-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Add missing rx_token_size initialization for NPU offloading.

Tested-by: Hui Ma <hui.ma@airoha.com>
Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/npu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index ec36975f6dc946f5dbc5ab6029b0574fbc602615..9679237f739842bd44497e0b1022a868cb3a0d6c 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -457,6 +457,7 @@ int mt76_npu_init(struct mt76_dev *dev, phys_addr_t phy_addr, int type)
 	dev->mmio.npu_type = type;
 	/* NPU offloading requires HW-RRO for RX packet reordering. */
 	dev->hwrro_mode = MT76_HWRRO_V3_1;
+	dev->rx_token_size = 32768;
 
 	rcu_assign_pointer(dev->mmio.npu, npu);
 	rcu_assign_pointer(dev->mmio.ppe_dev, ppe_dev);

-- 
2.52.0


