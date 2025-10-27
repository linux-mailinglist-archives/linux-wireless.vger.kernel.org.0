Return-Path: <linux-wireless+bounces-28320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F3C0F9C0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38700463505
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA03168E0;
	Mon, 27 Oct 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="urmwCXI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710153161BD;
	Mon, 27 Oct 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585500; cv=none; b=jBgVlaoiTeTkdu/e3nxThaWGup8XBhNb4zieMHHuHh8kCMDh7r/5zfO42SH/TRxFG9+CDgxgsfbLDu6dupMyM03PUNiehg0BBqRoDrfjNfrqlgCtMR4yoNyKhERBvFy2TD7z3XPotBv5vPyaNCJWBrFFtkSXt+QNIl/o/lQO3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585500; c=relaxed/simple;
	bh=q3+UUee6NjTzNjSLDHwWJbhFuDGP/50LJwD0evnMWfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvB0n8lGkzdmxgVFF3aKzdYIP+uQwz4SLD0a7DLm+zQtt1WJQuD/QcL+bIQNrQZSZctbyxtJ0A687bkLw0i5DkLEgDWRA1S/Ai0f8dWnWMOIFLVDKMzUOG/87qWMiIVFvZ7IFtggb5XbN2g1YwMPpOG6Se6LHw+ExZy1bLgT4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=urmwCXI+; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30E3F9550E9;
	Mon, 27 Oct 2025 18:18:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1761585495; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5v858IqBCKzHdFBFJSrUXXRl+m6ZWDsQE2+Wy791NHk=;
	b=urmwCXI+p6sTAzM1plgPvyAbITmXVecUPt/MUVnrt3yVBRIzQ5O89xXzvoMReMtJ1zpFpg
	3MatFg0stEc/zmY2tiRDvV15O0s32oEkCZokP5LsQpdKQUWHg3PRZolErNZO3j7kDHbILp
	np45K7feborSAdT7f67w88TI3zpTuWMmB64j0wtWb29fJYPr7S2PzBcCSOf0odx0XBKREs
	1/GSeZmiHgj1n+myAew/mamlotbALtmKZg1lAqlRTmNoVdlxzN+wHrC2k5X+7Q1zSN7ZjG
	IhUTdGkF1nErt8tvGGeXdcmoOls+ZX7egl/qxhdpXkQlOpvpY/F63nJL6uiVXQ==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: nbd@nbd.name,
	lorenzo@kernel.org
Cc: ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
Date: Mon, 27 Oct 2025 17:17:59 +0000
Message-Id: <20251027171759.1484844-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When on a Big Endian machine, PCI swaps words to/from LE when
reading/writing them. This presents a problem when we're trying
to copy an opaque byte array such as firmware or encryption key.

Byte-swapping during copy results in two swaps, but solves the
problem.

Fixes:
mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
mt76x2e 0000:02:00.0: Build: 1
mt76x2e 0000:02:00.0: Build Time: 201607111443____
mt76x2e 0000:02:00.0: Firmware failed to start
mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index cd2e9737c3bf..776dbaacc8a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
 	return val;
 }
 
+static void mt76_mmio_write_copy_portable(void __iomem *dst,
+					  const u8 *src, int len)
+{
+	__le32 val;
+	int i = 0;
+
+	for (i = 0; i < ALIGN(len, 4); i += 4) {
+		memcpy(&val, src + i, sizeof(val));
+		writel(cpu_to_le32(val), dst + i);
+	}
+}
+
 static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
 				 const void *data, int len)
 {
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
+		mt76_mmio_write_copy_portable(dev->mmio.regs + offset, data,
+					      len);
+		return;
+	}
 	__iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
 }
 
+static void mt76_mmio_read_copy_portable(u8 *dst,
+					 const void __iomem *src, int len)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < ALIGN(len, 4); i += 4) {
+		val = le32_to_cpu(readl(src + i));
+		memcpy(dst + i, &val, sizeof(val));
+	}
+}
+
 static void mt76_mmio_read_copy(struct mt76_dev *dev, u32 offset,
 				void *data, int len)
 {
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
+		mt76_mmio_read_copy_portable(data, dev->mmio.regs + offset,
+					     len);
+		return;
+	}
 	__ioread32_copy(data, dev->mmio.regs + offset, DIV_ROUND_UP(len, 4));
 }
 
-- 
2.39.5


