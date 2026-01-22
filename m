Return-Path: <linux-wireless+bounces-31067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIUjBboDcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 12:02:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9B65A82
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 028BA44C3DF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22440F8CF;
	Thu, 22 Jan 2026 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amwd4FPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03585407577
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078423; cv=none; b=c4RLKyyzg0u9fmbDvndkNsS19eX02F58aJbIfKVv/PNSfLupDj9TGF26MjoVntG4oceUJAtJFx0nDDf4llseXw7zDKVk1m38BAjt+7uZOlaQYWu4zBs1h90MemL/hOilCCUweAwxyqviuqyhnQTfiDGJJSaLNXylBOMuGoKu6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078423; c=relaxed/simple;
	bh=k4O3be26AQ8exg3XD7X+0VLeqF5x3XTiSMtPXrw/nsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjO4z6pkxJJqc1jPqY6FBkgU6bDlZlJFCZGTXTl5Hyi0/Nymq6MFTbVYyUV8lcxximR00WcsJJhnghx5BqQd6lBw/0YR7HVJyoRgfrazA//Ww+Z13dGNVmNKUAajM+zdodAi5sQRufJd9Aod6/kb9hJHhRGzdBXgbcFlNEMYC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amwd4FPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD123C116C6;
	Thu, 22 Jan 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078421;
	bh=k4O3be26AQ8exg3XD7X+0VLeqF5x3XTiSMtPXrw/nsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=amwd4FPgMP2QsKhCn65wTKCfk3Z2WC/o1L/aVIL6ovJF1q0ETqiswZVZ0MCX43Pa1
	 6e5WK2Ic6PX73oyLaoNbAu6qRBJnVZunMlcwbmSUY693zSaTtmixpwWjLPnuTEANUn
	 E5Hi7OwM/HrNTsxvSrPi/tBS3Dey3y1G5pPE9W4p6vdWXiAIdCuUpBUquJ/3ihTXnu
	 KcQgnZHIRkFYLxSviUnR+U+BzgxaT8Xlh13g2y8VCOajZYeMwQ2vOrcNMdRhOqH9dS
	 yyq3noHClzzYWbjUNy/rHbDnVPcalHtPLYM7nD14t7/QLc0cHb31Ry1fQDNAWALnKU
	 JfjxQoixZoYTQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:50 +0100
Subject: [PATCH mt76 v2 06/17] wifi: mt76: mt7996: Add
 mt7992_npu_txrx_offload_init routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-6-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31067-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: EAD9B65A82
X-Rspamd-Action: no action

Introduce mt7992_npu_txrx_offload_init utility routine.
This is a preliminary patch to enable NPU offload for MT7996 (Eagle)
chipset.

Tested-by: Kang Yang <kang.yang@airoha.com>
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


