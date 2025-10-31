Return-Path: <linux-wireless+bounces-28450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00DC267DF
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 18:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322FD3B3FC3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3634F485;
	Fri, 31 Oct 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5dciGPa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725D305967;
	Fri, 31 Oct 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933095; cv=none; b=kT0cIqgS+C7vtnKtMM+SkRtYuB6QpNg+AvvttJuyb/QlHP6nHthozYpYLtBujQXQ2BNqsD2VQhuxuMXaK0Cya/vXUzccWJ2JHrLCrCOq9u5cAGkBSayBPrkKRim0hX2W0dtFxicepjFm1Hkn52GPOTll7DO6kQKq/N3xAlgczuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933095; c=relaxed/simple;
	bh=Oc8WhF7ccShNgMMuI8D6E02WNn6uXdB2mVghS7oTLmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lI9Gu3txibgC3nvuhCT8bfjP7+mj0dXQVIOZ6z0wooo+zrmYV6ankq7OTHJ5Nmy99B1ZjNqcDxTSTuRSqYK18Crh6Ox+A6/bUgzKUMzOZq1FsqH8W1rE9gF9OdNsDqKeGGxxz4TpXsrGByT0C68nK4WyCRpIERmUY3KE5IeOMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5dciGPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6620C4CEE7;
	Fri, 31 Oct 2025 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761933095;
	bh=Oc8WhF7ccShNgMMuI8D6E02WNn6uXdB2mVghS7oTLmc=;
	h=From:To:Cc:Subject:Date:From;
	b=k5dciGPayWcRVQlheoN2gtv/wtcAwmqZsYMDZeD+cvAynks3odVwWiZb4yo9l9/Yf
	 qLgabX86wDFKbpyb3407McD24G99HFd20zWgFmoh0sUIkcmof8r8k5dJY0fMENkTDL
	 VZmkwuuoPd0gBmmMY4Q4pPkEr+Pp3zYkjP7HDLhMB9Do7cGmxrE9mlMfCpNNDnQKCy
	 k4fKYW8CwPKSXCabz0rk+wzKp+Smx99plN2Zh+fzUno4ASt0/fAv0NDQTEVLNJDAWa
	 wa1vQIKYjwcPydg5lbkUSrnmxLYA0d2gHLk9jE1IPJ/j/Ju3+5CDt4TiQmPeRCqVv+
	 m/UtT9KKe+Qzg==
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
Subject: [PATCH v4] wifi: mt76: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Fri, 31 Oct 2025 12:51:13 -0500
Message-ID: <20251031175113.1453100-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
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
v4:
 - Rebase on v6.18-rc1
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
2.51.0


