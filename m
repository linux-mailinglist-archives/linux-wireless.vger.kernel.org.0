Return-Path: <linux-wireless+bounces-26375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CEB255E9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22383882A66
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 21:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A82EFDAC;
	Wed, 13 Aug 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMKXxF1h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858212ED15A;
	Wed, 13 Aug 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121780; cv=none; b=DUZOWz+aOWi9wp/3SWrX32D/0BjSbjCNma+peH1ZifXhKW7He1V3nXB79dxh9BQwbTRKDYJgeeg20LVUFvVfIyEUwV3iClhRVdnBXsg5s8GseMfmFitzHW+fFfQtLXI5TWkmDvFKN/7SiiuVbk4j21Al44OE1Ht8jgeMP/ik4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121780; c=relaxed/simple;
	bh=NclLB94FEads0s4wh/ojsqj8Dq8b0xrIiaxPQNruk1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMeYElZbGTVgs0ArVIrBSfZxRXsNT1MhnursEb8dkTCPuiZVXTlcKw/Mtkb8Lh7IxTfmHzic9XtwywU2nKoszjdaCjNjAWXv5EWZwKVGGdEoSgcD/K01AVpSpAoFsNu4geYjZNRRJauHYusBORaeUFM8/tRJwwzmp18aiWVKR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMKXxF1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38AEC4CEED;
	Wed, 13 Aug 2025 21:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755121780;
	bh=NclLB94FEads0s4wh/ojsqj8Dq8b0xrIiaxPQNruk1g=;
	h=From:To:Cc:Subject:Date:From;
	b=bMKXxF1hFhVnUL6Dcj0fqhs2g+ajhAFtv9QdVA4QyOQaRp+Q+ilC/aDYYFyj6zj3a
	 m9elP7www1VkNZunGrBSI8TXMHp0KJWBGH3PjFpa6P7IOZgq5DixpGJQSz8Bx0SOx/
	 3VnYXfDdXUQVtCNL5oVplDxlBogjQ2Rcn444E/dmXvlwkyVgTodNP6rSHLMNjJqfFR
	 zvoPVymioIggCrdawoBz6BWbM5rCzfb6lFR53tPHXUV8PlHCFB+5QUgZ7JInhLiFEg
	 vKKzRO1rD6uhlsdHsH+Auztfj30L+CsMAD5PTx1DNfMdt9vCmJPz8Nd6+0N8Ca633O
	 GtUiiwv2M5RsA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH v3] wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Wed, 13 Aug 2025 16:49:32 -0500
Message-ID: <20250813214933.897486-1-robh@kernel.org>
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
v3:
 - Rebase on v6.17-rc1

v2:
  - Split to separate patch
---
 drivers/net/wireless/ath/ath10k/snoc.c | 14 +++-----------
 drivers/net/wireless/ath/ath11k/ahb.c  | 17 +++--------------
 drivers/net/wireless/ath/ath11k/qmi.c  | 17 ++++-------------
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index f0713bd36173..b3f6424c17d3 100644
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
@@ -1559,19 +1559,11 @@ static void ath10k_modem_deinit(struct ath10k *ar)
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
index 50809cc1dad4..8dfe9b40c126 100644
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
index 378ac96b861b..2b547b26ed20 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -13,7 +13,7 @@
 #include "debug.h"
 #include "hif.h"
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/ioport.h>
 #include <linux/firmware.h>
 #include <linux/of_irq.h>
@@ -2040,23 +2040,14 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
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
@@ -2095,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_core_coldboot_cal_support(ab)) {
-				if (hremote_node) {
+				if (resource_size(&res)) {
 					ab->qmi.target_mem[idx].paddr =
 							res.start + host_ddr_sz;
 					ab->qmi.target_mem[idx].iaddr =
-- 
2.47.2


