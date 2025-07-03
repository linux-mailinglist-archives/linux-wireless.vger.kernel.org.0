Return-Path: <linux-wireless+bounces-24799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE435AF804F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D67E3B745E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8872F5C55;
	Thu,  3 Jul 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD0XQ8SI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0A2F2C7B;
	Thu,  3 Jul 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567707; cv=none; b=V9QIHdHJyrs15TnrxUlkALontCOBKpkHUqtMRV+fKyeNhrRBjkznHTkDSlYFqQAXmdfTOSGTzcxGLt/QVg1gsxCRBIHMbZBjpYP3zuRkP1LBK5SC/XJ5OW8ukqeg3Ilm7L8+/2/ErciL8kJDXT6aKFOpGI9YfAVFFps5N7EsLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567707; c=relaxed/simple;
	bh=oQJxz7AsS+vnaXVxBJfrbdUGXV9WZlv60FGu/AgCo/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxI+Rv1UD+x81ffublQDkktCQ19mGcAq92KlWKPReGK1nj/WPB/w5IZjU6CPabwso97JXYdNfmLR3JsLmcCpIRSAJJB9ZR4OxPu6LRyg8Wqs+IcuiMII0yBH964sgaYbaNJdu1RG2HQGApS8RAuCs+mhIOaa3Q/YtCEJ00tKhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD0XQ8SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A11C4CEEB;
	Thu,  3 Jul 2025 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567706;
	bh=oQJxz7AsS+vnaXVxBJfrbdUGXV9WZlv60FGu/AgCo/8=;
	h=From:To:Cc:Subject:Date:From;
	b=CD0XQ8SIrPwDatdyuxIeN97jUm5gWGeYJoxaMC/IQuTCKLCbTRhuwNbO3OUQNqYtJ
	 OjkXulFwfGmXq5/zzJNRxYDLzvFbxkFxEpi+jQuRWaVjCVNrzN9rkgGqemAfVp9tT5
	 yk+Bx8jWkS+efI7OxHif+7pGeUXJw5MTHaQy0dcP/+GFiqcnRrosO79UcvGcuZwVLU
	 Vhig93WWef1H5iPAWNxS0azpS+VLTjMZ3rmQRviiXPdwkA5xbCdnMufvjHzuj1YIjx
	 WukkFz2Zpt4bHXdsHIv9QyNrFaIBx+zVNsoSZxpNKH/xIWmk4iQsdpq6fZsIvC7WvT
	 I0VyNgJ6NBHPQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wireless: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Thu,  3 Jul 2025 13:35:01 -0500
Message-ID: <20250703183502.2074538-1-robh@kernel.org>
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

The error handling is a bit different for ath10k. "memory-region" is
optional, so failed lookup is not an error. But then an error in
of_address_to_resource() is treated as an error. However, that
distinction is not really important. Either the region is available
and usable or it is not. So now, it is just
of_reserved_mem_region_to_resource() which is checked for an error.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c        | 14 +++----------
 drivers/net/wireless/ath/ath11k/ahb.c         | 17 +++------------
 drivers/net/wireless/ath/ath11k/qmi.c         | 17 ++++-----------
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 21 +++++++------------
 4 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b2bf9d72b92f..5c61a3abd33b 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -13,7 +13,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc/qcom_rproc.h>
-#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/iommu.h>
 
 #include "ce.h"
@@ -1557,19 +1557,11 @@ static void ath10k_modem_deinit(struct ath10k *ar)
 static int ath10k_setup_msa_resources(struct ath10k *ar, u32 msa_size)
 {
 	struct device *dev = ar->dev;
-	struct device_node *node;
 	struct resource r;
 	int ret;
 
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (node) {
-		ret = of_address_to_resource(node, 0, &r);
-		of_node_put(node);
-		if (ret) {
-			dev_err(dev, "failed to resolve msa fixed region\n");
-			return ret;
-		}
-
+	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &r);
+	if (!ret) {
 		ar->msa.paddr = r.start;
 		ar->msa.mem_size = resource_size(&r);
 		ar->msa.vaddr = devm_memremap(dev, ar->msa.paddr,
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index fde1ce43c499..2e8a77ceb8bb 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -9,8 +9,8 @@
 #include <linux/property.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/dma-mapping.h>
-#include <linux/of_address.h>
 #include <linux/iommu.h>
 #include "ahb.h"
 #include "debug.h"
@@ -919,16 +919,10 @@ static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 	struct device *dev = ab->dev;
-	struct device_node *node;
 	struct resource r;
 	int ret;
 
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (!node)
-		return -ENOENT;
-
-	ret = of_address_to_resource(node, 0, &r);
-	of_node_put(node);
+	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &r);
 	if (ret) {
 		dev_err(dev, "failed to resolve msa fixed region\n");
 		return ret;
@@ -937,12 +931,7 @@ static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 	ab_ahb->fw.msa_paddr = r.start;
 	ab_ahb->fw.msa_size = resource_size(&r);
 
-	node = of_parse_phandle(dev->of_node, "memory-region", 1);
-	if (!node)
-		return -ENOENT;
-
-	ret = of_address_to_resource(node, 0, &r);
-	of_node_put(node);
+	ret = of_reserved_mem_region_to_resource(dev->of_node, 1, &r);
 	if (ret) {
 		dev_err(dev, "failed to resolve ce fixed region\n");
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 2782f4723e41..fb53efbc5b68 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -11,7 +11,7 @@
 #include "debug.h"
 #include "hif.h"
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/ioport.h>
 #include <linux/firmware.h>
 #include <linux/of_irq.h>
@@ -2038,23 +2038,14 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 {
 	struct device *dev = ab->dev;
-	struct device_node *hremote_node = NULL;
-	struct resource res;
+	struct resource res = {};
 	u32 host_ddr_sz;
 	int i, idx, ret;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
 		case HOST_DDR_REGION_TYPE:
-			hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);
-			if (!hremote_node) {
-				ath11k_dbg(ab, ATH11K_DBG_QMI,
-					   "fail to get hremote_node\n");
-				return -ENODEV;
-			}
-
-			ret = of_address_to_resource(hremote_node, 0, &res);
-			of_node_put(hremote_node);
+			ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
 			if (ret) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
 					   "fail to get reg from hremote\n");
@@ -2093,7 +2084,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_core_coldboot_cal_support(ab)) {
-				if (hremote_node) {
+				if (resource_size(&res)) {
 					ab->qmi.target_mem[idx].paddr =
 							res.start + host_ddr_sz;
 					ab->qmi.target_mem[idx].iaddr =
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


