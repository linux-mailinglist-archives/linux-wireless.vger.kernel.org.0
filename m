Return-Path: <linux-wireless+bounces-27621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F95B97974
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 23:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2011B2318B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3B2741C9;
	Tue, 23 Sep 2025 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFFn5IiO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55324503B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663569; cv=none; b=ut74QGpDsUGJbENCy0KcvfzUJ8RbuayMCfJIGIr7NoFbsPH98AvhTgLCMCZTR720UQ1B4vYqTxHnEt3DlIkQx1JfMaYD9KBM8FNfV5CIu/3+C8ZIxMg2y4b5Qp/1AX+Q7tO0r0By1GgcYjd/6456d7YgOO5g4nq+gVRxgp2XiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663569; c=relaxed/simple;
	bh=UZ7PJMX1htlpR+MYR8K2xz3tFEuVnrOW3tya3Yffdqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt25fL9zlGs78g7Pm9VJ6t/EC2bDaRtTQG/PG7WOxZgXG1w2jo6DVhml4+CzPBznECLp9QUFWGHr50w5m5I7IxwbI8GEUR77ZFYdmszlcsA4LQ8lC4/ohHLtPU3r6HKEW+l5yA9LiU+xAp4Zrv4NVtaBMbYlrlKyjfkuU2Pwx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFFn5IiO; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758663564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p+GFxQErCvWj4PbtQGhJ+tJMGMSzlUWRYZ+DV6Ypzug=;
	b=IFFn5IiOy9Uc88PgON7sTpVx0lyqFk8K50yLPv3yQe2AojM4EmCPbgBoK2OUeOuIZoGZXz
	ZOIRBsXpTG9djL6zo3e4j2apoX5CNKoMOrNCzkh0OM2TFSsaP4q4S+EVZD7OfM1JuU5VVb
	4LMpPBMuVcUDyhknP9EEGvu1GgufzMM=
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
Subject: [PATCH wireless-next] wifi: mt76: connac: Replace memcpy + hard-coded size with strscpy
Date: Tue, 23 Sep 2025 23:38:31 +0200
Message-ID: <20250923213831.1896823-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memcpy() and the hard-coded string length with strscpy() to
safely copy the string and improve mt76_connac_mcu_chip_config().

No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 16db0f2082d1..0ccd39149663 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1949,7 +1949,7 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 		.resp_type = 0,
 	};
 
-	memcpy(req.data, "assert", 7);
+	strscpy(req.data, "assert");
 
 	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
 				 &req, sizeof(req), false);
-- 
2.51.0


