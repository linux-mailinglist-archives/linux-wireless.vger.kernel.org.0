Return-Path: <linux-wireless+bounces-28039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B5BEBE23
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A5E83525B7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA628D8D9;
	Fri, 17 Oct 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QWxmnxob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE025F984
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739003; cv=none; b=NHH2B7d9h0MUzmtzEYBp63Jt7HB49BoJk+hmEoQkfVVDcaCZDgG7p1sfmVOdklvppHl/5b70Tp/1+04/9DHqp/DIPGHKhTWtWg2WxnRFuhOguKOEA3VBUvZtpU7+wLHCI8zaZUIUyFh+9z1AGUI8XwqPmu/uqQGw4LFeMfm+7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739003; c=relaxed/simple;
	bh=ST6hl0pijhCKMa3ZETzc2qzBu3nJRljUWoe1xFU6RGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xn537PscwHZdi7HJ2YJfUVt4P8dn2ssWhExi5O9dKn89pAuBJA28kkvBjCA7rbVZD0s52ZsZWsIJWiAwD+THZZtdbfdEAN0Kuix52igtTtGpyB29Fn241xQtzJn14li5r6SX329OXAIQVy8mcFhOiXeWBQRwUr/zqdoNmGoa+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QWxmnxob; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760738999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LYJooa3CPyiL/YqvqFJbpYPNVK38FpDeFlhZ7s1lavw=;
	b=QWxmnxob+fxd6kyXR2Yyd0g0hFnFRzfunZcrA+AKQkwUTkBDME5O8A/pj0nE4ZsRt27jKM
	DP8XgrreoLrKjZRe/qPI99FtJ4fCZcCA+gxdKH6t7Uinqykmb2uBcwX5DjLbUelJLvNZgv
	o7Avg4oA0CpZsrCge2SOt7JJ91SHbjM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND wireless-next] wifi: mt76: connac: Replace memcpy + hard-coded size with strscpy
Date: Sat, 18 Oct 2025 00:09:14 +0200
Message-ID: <20251017220913.167923-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() to copy the string into the fixed-size buffer 'req.data'
instead of hardcoding the number of bytes to copy. This improves
maintainability and ensures the buffer is always NUL-terminated.

No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fc3e6728fcfb..8fc3ecfc27a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
+#include <linux/string.h>
 #include "mt76_connac2_mac.h"
 #include "mt76_connac_mcu.h"
 
@@ -1974,7 +1975,7 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 		.resp_type = 0,
 	};
 
-	memcpy(req.data, "assert", 7);
+	strscpy(req.data, "assert");
 
 	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
 				 &req, sizeof(req), false);
-- 
2.51.0


