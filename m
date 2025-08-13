Return-Path: <linux-wireless+bounces-26373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A5B255DE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A945A26D0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185021638A;
	Wed, 13 Aug 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkqPyIyj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3572E54D8;
	Wed, 13 Aug 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121744; cv=none; b=Igxlzaq9WV1foa7Uek1HbzE5EoBKr/T3zJlV7wN7jh2+th3142hFl55E+k+kg18vsKCleREUWC3b8Tj12L2RCWlSrW7rcOwsPOQuI8WNawgHEh0T6KOkOEYJk0aPtzWHEIwjVHAufQkjzGOjTdPDr4vVHR0dTsyeAOHq470acw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121744; c=relaxed/simple;
	bh=NAKVChDx7eHSjPyS9MwFrZDTgCpBq7ZuI5Zr92sTTO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IR5o7phWfXYYQk7dgxLVxT6/fhYmNqNR21ZEcVGF8SdGJinNP/IbC9SKl5KCsHVTPacQfyiXtbksGtyF9qZC6k9hZR4rmTACPA6JLA5d7YnVuxxbGwFwdNAqp7NtH76JPKJOO5HmYW7AfbJy/FFrlJ6UCHDTiJFYXF61fWPGNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkqPyIyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC24C4CEEB;
	Wed, 13 Aug 2025 21:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755121743;
	bh=NAKVChDx7eHSjPyS9MwFrZDTgCpBq7ZuI5Zr92sTTO8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZkqPyIyjciE+xpPSXPAk3QJ3hSJ2VJGyKdF6L0cUNNgg2gkWivy5IVz4eSB5/PrZt
	 DmQqTzGd/fFU71i6wqapoVhSubcxISY+31bPEek6Jn8y4Ihh/aHhosH6tT73VxwkOy
	 ch8Ov92Jk9QVBmHa8AD7A8JDkmfjQ+sx8yaM/m78Vtoc5W6U0dTazp/D9x6zdj04wR
	 53Tm2bk2dfXBHjHVsfc509yHAOiXa0sFKGRo12mRBzGpH5CUWr4WBQxm5piPVYKUIF
	 tgVTjmXGXb70psPWaKpzsJ5qMcFHZBOLDmdfn8ife0/tnN97J31Kot922XdrAs3qwW
	 2g+N/5HUCgKwA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] wifi: mt76: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Wed, 13 Aug 2025 16:48:58 -0500
Message-ID: <20250813214859.896704-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added of_reserved_mem_region_to_resource() function to
handle "memory-region" properties.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Rebase on v6.17-rc1

v2:
  - Split to separate patch
---
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index c823a7554a3a..5f19b506cc50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -284,20 +284,15 @@ static int mt798x_wmac_coninfra_check(struct mt7915_dev *dev)
 static int mt798x_wmac_coninfra_setup(struct mt7915_dev *dev)
 {
 	struct device *pdev = dev->mt76.dev;
-	struct reserved_mem *rmem;
-	struct device_node *np;
+	struct resource res;
 	u32 val;
+	int ret;
 
-	np = of_parse_phandle(pdev->of_node, "memory-region", 0);
-	if (!np)
-		return -EINVAL;
-
-	rmem = of_reserved_mem_lookup(np);
-	of_node_put(np);
-	if (!rmem)
-		return -EINVAL;
+	ret = of_reserved_mem_region_to_resource(pdev->of_node, 0, &res);
+	if (ret)
+		return ret;
 
-	val = (rmem->base >> 16) & MT_TOP_MCU_EMI_BASE_MASK;
+	val = (res.start >> 16) & MT_TOP_MCU_EMI_BASE_MASK;
 
 	if (is_mt7986(&dev->mt76)) {
 		/* Set conninfra subsys PLL check */
@@ -318,8 +313,8 @@ static int mt798x_wmac_coninfra_setup(struct mt7915_dev *dev)
 			       MT_TOP_EFUSE_BASE_MASK, 0x11f20000 >> 16);
 	}
 
-	mt76_wr(dev, MT_INFRA_BUS_EMI_START, rmem->base);
-	mt76_wr(dev, MT_INFRA_BUS_EMI_END, rmem->size);
+	mt76_wr(dev, MT_INFRA_BUS_EMI_START, res.start);
+	mt76_wr(dev, MT_INFRA_BUS_EMI_END, resource_size(&res));
 
 	mt76_rr(dev, MT_CONN_INFRA_EFUSE);
 
-- 
2.47.2


