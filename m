Return-Path: <linux-wireless+bounces-26374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B1B255E2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A7C5A3B9E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B4286D45;
	Wed, 13 Aug 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGc/Qnuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B111474CC;
	Wed, 13 Aug 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121762; cv=none; b=BUxcOziPEyZR3CUZcloIi61Q8H1zXmlC11/bmhYZsy9ZuEa8Twf3NqMkXRCYcvaYmIQVLsLnTk0zlyxvogL9XRUKFW/ieFj2tZRZlVT1q3AIZV7qgj3o3SwJorVyC/RqYWyro2AfO1/J4vrMOxWpyWkqulaED1czkcrwNRA0F50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121762; c=relaxed/simple;
	bh=NAKVChDx7eHSjPyS9MwFrZDTgCpBq7ZuI5Zr92sTTO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoSSY3rcyk5E6lUl+9nu8/hYo0ASuVr/HNRw3XvvYN1xTPNIX49DUHzxYf6bJcROHTVuBS4NmevfWpvEfaVXN8m+qxWGlnjnh4Em+imotCk9+ELMmWMKJvVVwb8C0VFk3JTPUQ9QZ527ko+tIkFFjuCrIG4gHpskPeWJuzPQA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGc/Qnuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E86C4CEEB;
	Wed, 13 Aug 2025 21:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755121762;
	bh=NAKVChDx7eHSjPyS9MwFrZDTgCpBq7ZuI5Zr92sTTO8=;
	h=From:To:Cc:Subject:Date:From;
	b=aGc/QnujCD9uIgZSKrwSkf0iKw/C5GI82Lb9ZYTkZ4gg/Mz/ZX5vikZEsa5CHp/PG
	 +vBXy2DI+CGC3CzFRDroBbXu+II/zZ9rxO6b1jwkMc6e4VPv2afCKNNqd8zVJLiDO+
	 TjepeY7kzSwFUZCy2iJuae2kjYiaNGMCD++xvsRgeG9QBj+knuPMyh9SZAuxTMsMtS
	 mUodmlszGUa+1ABTY1KOrl5nC5azPGNTX4kt+U3mKpdpYv1WcRN/w6FAhVM+wTjtBC
	 FL8CHRpXAtQNVR8qhYPTXo0XVh1DKJBBt/Efz85XyLbNRB9j+63O8pc/VINmeiL5gO
	 LCOkMcU9Tuo9Q==
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
Subject: [PATCH v3] wifi: mt76: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Wed, 13 Aug 2025 16:49:16 -0500
Message-ID: <20250813214917.897113-1-robh@kernel.org>
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


