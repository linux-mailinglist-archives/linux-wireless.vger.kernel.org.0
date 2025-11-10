Return-Path: <linux-wireless+bounces-28757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED093C466ED
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 018944EA3A0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A830ACFB;
	Mon, 10 Nov 2025 12:01:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282F27056B;
	Mon, 10 Nov 2025 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776082; cv=none; b=RsgC8MthMdFh7TnHtcLE9vAnruzsGjp3UJcqkSUUcy+i3Mfj3e191UfUNqsZLv3CLUPh3uwhP9Lr8b2OoS5CqlGOZu1aunIyso3hwJzRGYohfaMihq/EFoMRq9QnlTfDcRW4MhtDX5zxNwAUH2iu3Kl8v1b8t/6ATU0Gos/Bn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776082; c=relaxed/simple;
	bh=FtqQ9PoEsnxNG1pIgE6oZF7+S7DXEbSxJ/tvldCRVSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCmDgmPRLtCo5vbQlWqhrws2CiTSvWmODk0IZHQfV7elpGYHOJSgX32iVm7SfuJCSrCp5VjOfNB3ofR8mNwrU/zv6lZTMA7oZZkAZ59ZbRNg51m0CiMSEgyKwSYyCtDyEcyhYlnvs8n5fUB6UM8GZPIwHMd849DTyRVPhSvx8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 290ba10ea;
	Mon, 10 Nov 2025 20:01:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Felix Fietkau <nbd@nbd.name>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] wifi: mt76: mt7996: fix mixed FEM check of mt7996 chipset
Date: Mon, 10 Nov 2025 20:01:10 +0800
Message-Id: <20251110120110.193562-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6da4493d03a2kunm0d50f1f77dd9f9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh5NVkodT0lNHkNPSkpLTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

To support the following varaint of the mt7996 chipset:
- tri-band: band0 iFEM and band1/band2 eFEM

We should read band1 for the determination, using band0
will incorrectly identify it as iFEM.
This is also the judgment logic of the mt7992 chipset.

This fixes the load error on the Quantum Fiber W1701K:
mt7996e 0000:01:00.0: eeprom load fail, use default bin
mt7996e 0000:01:00.0: Message 0012002d (seq 5) timeout

Fixes: e8cb33ad546a ("wifi: mt76: mt7996: add support for more variants")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5e95a36b42d1..143400541746 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1137,7 +1137,7 @@ static int mt7996_variant_fem_init(struct mt7996_dev *dev)
 		adie_idx = (val & MT_PAD_GPIO_ADIE_SINGLE) ? 0 : 1;
 		adie_comb = u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB_7992);
 	} else {
-		adie_idx = 0;
+		adie_idx = 1;
 		adie_comb = u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB);
 	}
 
-- 
2.25.1


