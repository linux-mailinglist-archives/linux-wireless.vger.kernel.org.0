Return-Path: <linux-wireless+bounces-28017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19048BE74B7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A10A563A68
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676E2BDC0E;
	Fri, 17 Oct 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thvp07TU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F729E0F8
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691054; cv=none; b=T9Sm77Pg0bDeZ0VZWT8+e/TrzoM2TgACxjSk+wfrJupCWKIgQvr273B1YH147krc+y106UqxaqMsXY4MBsLJecYHKAWdnrk/zROBQwoGUAYMEJYa/1XnOexNBewMC6zL4tAlaDfBALQQyciBTHuK1LuB+9JgdMFrRv7O2UTmOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691054; c=relaxed/simple;
	bh=Zf/nIk+iUAo/BAfFoE/0vV4q8iCldWAQKzmHLBHVEjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oyo5FcyI4zLqvcZHfsEw6kCjL2dp245zlJypBl8vKl1mTDkwJHdGjqkBdi168mRhzUMYt4leYNScXl2YEQf1LmILKjBSluRztFKN/FVcmD33O8knmxs8HXplmybrNNHGjWmfyziw+2RSnOB1tDf/NXWjUcmpP4J4spm/pCd+YMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thvp07TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2615C116C6;
	Fri, 17 Oct 2025 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691054;
	bh=Zf/nIk+iUAo/BAfFoE/0vV4q8iCldWAQKzmHLBHVEjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Thvp07TU6xBQ4lRjy9k+r46Gi8yfehBAieNKr+XqdSPrZ6ZBMkx28u4U1LQGU7AW1
	 nQNi4tVbUuQ5Jt0kxPaJsu9MD22JfJsOxvMVK0dNPU9JXrQK2W52ONZg02oLiiSMb+
	 S4clkXffMQlvB8uSaFDB1zE/TjxIr/Fa/4KoFUFLJFpkHJc62zxC57xf0hcKDdmii6
	 lWD0B6k/xnLB7LY1VmsV++Rg7t9yMJYQNj799EkHXgOZa5hV7qpKqf0alRkLRmOPwo
	 4/+CVh7iIAI5Efd811TNk8mTNI30yz7a/2EneE1i68+eGmu8/AuaZcjn+11PTFM+eG
	 gDofUK4igRTnQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 10:50:29 +0200
Subject: [PATCH mt76 v2 1/5] wifi: mt76: Move Q_READ/Q_WRITE definitions in
 dma.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mt76-npu-devel-v2-1-ddaa90901723@kernel.org>
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

This is a preliminary patch to enable traffic forward offloading between
the MT76 NIC and the Airoha ethernet one via the Airoha NPU module
available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 31 -------------------------------
 drivers/net/wireless/mediatek/mt76/dma.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 27aa591ff2ea20b7bef717414f811fdf06e6cba3..2dd3bd990fbaf6b98f619be45ef4be0d5465293e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -7,37 +7,6 @@
 #include "mt76.h"
 #include "dma.h"
 
-#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
-
-#define Q_READ(_q, _field) ({						\
-	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
-	u32 _val;							\
-	if ((_q)->flags & MT_QFLAG_WED)					\
-		_val = mtk_wed_device_reg_read((_q)->wed,		\
-					       ((_q)->wed_regs +	\
-					        _offset));		\
-	else								\
-		_val = readl(&(_q)->regs->_field);			\
-	_val;								\
-})
-
-#define Q_WRITE(_q, _field, _val)	do {				\
-	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
-	if ((_q)->flags & MT_QFLAG_WED)					\
-		mtk_wed_device_reg_write((_q)->wed,			\
-					 ((_q)->wed_regs + _offset),	\
-					 _val);				\
-	else								\
-		writel(_val, &(_q)->regs->_field);			\
-} while (0)
-
-#else
-
-#define Q_READ(_q, _field)		readl(&(_q)->regs->_field)
-#define Q_WRITE(_q, _field, _val)	writel(_val, &(_q)->regs->_field)
-
-#endif
-
 static struct mt76_txwi_cache *
 mt76_alloc_txwi(struct mt76_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index d41f978d4d7d3618bf4675b18245986d62fbd711..19bc768913fff30b221b2da4827dbc6aff5c9f3a 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -46,6 +46,37 @@
 #define MT_FCE_INFO_LEN			4
 #define MT_RX_RXWI_LEN			32
 
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
+
+#define Q_READ(_q, _field) ({						\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	u32 _val;							\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		_val = mtk_wed_device_reg_read((_q)->wed,		\
+					       ((_q)->wed_regs +	\
+						_offset));		\
+	else								\
+		_val = readl(&(_q)->regs->_field);			\
+	_val;								\
+})
+
+#define Q_WRITE(_q, _field, _val)	do {				\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		mtk_wed_device_reg_write((_q)->wed,			\
+					 ((_q)->wed_regs + _offset),	\
+					 _val);				\
+	else								\
+		writel(_val, &(_q)->regs->_field);			\
+} while (0)
+
+#else
+
+#define Q_READ(_q, _field)		readl(&(_q)->regs->_field)
+#define Q_WRITE(_q, _field, _val)	writel(_val, &(_q)->regs->_field)
+
+#endif
+
 struct mt76_desc {
 	__le32 buf0;
 	__le32 ctrl;

-- 
2.51.0


