Return-Path: <linux-wireless+bounces-27217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D612B51A74
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2356718950DA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B5329F04;
	Wed, 10 Sep 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESIpZWl8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912F329F06
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515228; cv=none; b=FlnR+org8FDUQ4BG5FMUDg4k5ieRGt4PgAK6lB2M0l6duP43NnHab7Eq48BZz5q1WF8l5FXCHfDWr74ROeRCEA0fFSPEPzBgAAIwcz/HLzkkykrd9vb47EhmTfMbzUj9EFqiEgoR43a6roU9DIvII3oDN3a2+GsGKnG+1cdXRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515228; c=relaxed/simple;
	bh=hiZmNsKJku7KYOk4LCGhbTUNof/90RwRaS7S147L3Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dT6Nl5LAD4p7NNDvMYh8J9lpgDtymiHTv613fegn3Qo9N5dYB5SJ7Xca//AY9ivRHrTaDm0TC9u0R47DHsdCyEyBRaVSmsiOrKGkoT5SpRV0EHzAdljlX/nuSwGikLpZIc7Jtw2AsCP+3EoPARA970Gc8nOb+Hh8snI4wAofQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESIpZWl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6679EC4CEEB;
	Wed, 10 Sep 2025 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515226;
	bh=hiZmNsKJku7KYOk4LCGhbTUNof/90RwRaS7S147L3Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ESIpZWl8mRPyHxt2y99ZESdTPjLkpd7TociEjddoGBq4Rw494O5cCuS9y7ZmJErvR
	 onWyZGI3xkObbVms6Bl+K4ccx0QDpsp2tCouk53WQ40ox+OX/lqWHAljhaXn5aIZt/
	 UMyhxUORAxNZm2apVW3UHHojxCZwgmOwnz3i5b0rJZJLxx5/ubkrGLZRu/anG+UkmP
	 0M6DmVU+3wNvD70CxV+2BEDR4ZOPmLJwHZUu4+e9IUjCpjDkzGBcZ0zVoVZAfaWoCJ
	 fiXJ+T9mCpwXIAJf3mF3pdy1jeVkw2iphYh3+zQPS+Mo7JM3u7vbRhqJV4TsC5tLtv
	 VcRECNvBLk/zQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Sep 2025 16:40:02 +0200
Subject: [PATCH mt76 1/5] wifi: mt76: Move Q_READ/Q_WRITE definitions in
 dma.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mt76-npu-devel-v1-1-dbde4a37b9c0@kernel.org>
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

This is a preliminary patch to enable traffic forward offloading between
the MT76 NIC and the Airoha ethernet one via the Airoha NPU module
available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 31 -------------------------------
 drivers/net/wireless/mediatek/mt76/dma.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 1fa7de1d2c45e16598f7bec05bab3e1e9e0f6d46..f21481d4ed08400141627f91592d4d98789901b0 100644
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
index 17a80e1757fcc3a9358f1cc4f3cafe4b6d87ec65..56bd53bf97bd3159cd536f6d10fec584727f4c0c 100644
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


