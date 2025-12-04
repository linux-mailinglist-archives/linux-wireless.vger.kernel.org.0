Return-Path: <linux-wireless+bounces-29494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE4CA2C45
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A18A3040A4B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545E28488D;
	Thu,  4 Dec 2025 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8RyOxUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08A2D321B
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835900; cv=none; b=HvecjcXUSfmGoFqbR1EtBdtwHfsQkXSfEaNL4NWJiNOC7W50F/RekRAuwtXY4SSAYUtgj0lNrfDE5Dt6W8QzxACc/Bee5bmio2W5QxqJMi7oGdQaghZdWzRpCih5LZnf41lkEIOazz+TsSGHHKoSXI5HDBR8DAOuL2rrd5qb1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835900; c=relaxed/simple;
	bh=OocQtT0h+CyI1Z65tcvGSFoTrkMRGEEFmUqKOabT3iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbDs2rQ8nw9MFZQBLzQmqHmXp09MsiP6yBzk6OoDxvYnC0ZojuIOflTX4GkSxIqdRQnz0tN7rvPUs7fiAtlbvxmhGhAEZyEp2Ok/noPkItEmJVH1R9IEE6Vc11FMuLg+fT3BzdDR7Gv+vstuSHHhXt4NIglnNMvYc9mgQc0alVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8RyOxUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28836C4CEFB;
	Thu,  4 Dec 2025 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835899;
	bh=OocQtT0h+CyI1Z65tcvGSFoTrkMRGEEFmUqKOabT3iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j8RyOxUlsBfydZXwZuxZ14U5LvRVLszmVoNI0lS9PdoqqazNxNdY+5mk+NfOmhIt1
	 YidZwli1JdnV2zJ23PTavyyHFiZgLl70azFFMrzJBaDur+Ehc38ROp9O6/IrYEgeeN
	 2wx3j7kcWPt4ek9ehq2kAT94ZFReSwpZ5u/5dqzDdkmjQ722qI95xZ77XjNuHYx6an
	 YkbYoSnywqgDCbCeSInkQdDIZ/qZa7efAUUSRDR9I8i+6akwnnnxwEenePQeqC/Fzo
	 Q/xYrhT0NHY9tQB2KpQbcopRS3kO1DZvcZSaGlzj/J795neRHzyoFiLH0i4eseq3wW
	 Gd5xjEdOlXEJw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:48 +0100
Subject: [PATCH mt76 06/11] wifi: mt76: mt7996: Add
 mt7992_npu_txrx_offload_init routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-6-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Introduce mt7992_npu_txrx_offload_init utility routine.
This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c | 63 +++++++++++++++----------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index 067ef647e404073173833aad3a2800d6591a5188..d79f8dfbd7faa7695ea54b632ac86063fa8ffe3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -8,34 +8,14 @@
 
 #include "mt7996.h"
 
-static int mt7996_npu_offload_init(struct mt7996_dev *dev,
-				   struct airoha_npu *npu)
+static int mt7992_npu_txrx_offload_init(struct mt7996_dev *dev,
+					struct airoha_npu *npu)
 {
+	u32 hif1_ofs = dev->hif2 ? MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0) : 0;
 	phys_addr_t phy_addr = dev->mt76.mmio.phy_addr;
-	u32 val, hif1_ofs = 0, dma_addr;
+	u32 dma_addr;
 	int i, err;
 
-	err = mt76_npu_get_msg(npu, 0, WLAN_FUNC_GET_WAIT_NPU_VERSION,
-			       &val, GFP_KERNEL);
-	if (err) {
-		dev_warn(dev->mt76.dev, "failed getting NPU fw version\n");
-		return err;
-	}
-
-	dev_info(dev->mt76.dev, "NPU version: %0d.%d\n",
-		 (val >> 16) & 0xffff, val & 0xffff);
-
-	err = mt76_npu_send_msg(npu, 0, WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
-				dev->mt76.mmio.npu_type, GFP_KERNEL);
-	if (err) {
-		dev_warn(dev->mt76.dev,
-			 "failed setting NPU wlan PCIe port type\n");
-		return err;
-	}
-
-	if (dev->hif2)
-		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
-
 	for (i = MT_BAND0; i < MT_BAND2; i++) {
 		dma_addr = phy_addr;
 		if (i)
@@ -56,7 +36,7 @@ static int mt7996_npu_offload_init(struct mt7996_dev *dev,
 					MT7996_RX_RING_SIZE, GFP_KERNEL);
 		if (err) {
 			dev_warn(dev->mt76.dev,
-				 "failed setting NPU wlan PCIe desc size\n");
+				 "failed setting NPU wlan rx desc size\n");
 			return err;
 		}
 
@@ -97,10 +77,41 @@ static int mt7996_npu_offload_init(struct mt7996_dev *dev,
 				phy_addr + MT_RRO_ACK_SN_CTRL, GFP_KERNEL);
 	if (err) {
 		dev_warn(dev->mt76.dev,
-			 "failed setting NPU wlan rro_ack_sn desc addr\n");
+			 "failed setting NPU wlan tx desc addr\n");
 		return err;
 	}
 
+	return 0;
+}
+
+static int mt7996_npu_offload_init(struct mt7996_dev *dev,
+				   struct airoha_npu *npu)
+{
+	u32 val;
+	int err;
+
+	err = mt76_npu_get_msg(npu, 0, WLAN_FUNC_GET_WAIT_NPU_VERSION,
+			       &val, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev, "failed getting NPU fw version\n");
+		return err;
+	}
+
+	dev_info(dev->mt76.dev, "NPU version: %0d.%d\n",
+		 (val >> 16) & 0xffff, val & 0xffff);
+
+	err = mt76_npu_send_msg(npu, 0, WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
+				dev->mt76.mmio.npu_type, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan PCIe port type\n");
+		return err;
+	}
+
+	err = mt7992_npu_txrx_offload_init(dev, npu);
+	if (err)
+		return err;
+
 	err = mt76_npu_send_msg(npu, 0, WLAN_FUNC_SET_WAIT_TOKEN_ID_SIZE,
 				MT7996_HW_TOKEN_SIZE, GFP_KERNEL);
 	if (err)

-- 
2.52.0


