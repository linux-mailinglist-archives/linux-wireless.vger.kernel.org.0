Return-Path: <linux-wireless+bounces-37713-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /CbtFjm7K2ofDgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37713-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 736AE6777AA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=XuvCjx97;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37713-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37713-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19EF0300F26D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5CB397329;
	Fri, 12 Jun 2026 07:53:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917E3D75BE
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:53:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250810; cv=none; b=XuVp3xgINvhV7DczP3unOxAOytBuEYG9QOkwcRdc7qGuZ2Y4dncqhwOp8GDMgJWPkEwzB1jQwG6LJKNXfyCSUkMbaSal0auSMrNmN9wdTTjvVhor4nnmAKA8gFQTC0V5Pct2aWAE7d/1/z5MCmn8Aojqg4jJPFNK++K/BiI5Gb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250810; c=relaxed/simple;
	bh=Lny6ritX9BtixZUh2Blfg6B3ozatOm7eImTIWnKvi8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnDeFyaqDO+/wqu0nHcEGWqXAT38NQKEe/088cylmcOojrjzLrn0/Ip1/SrTuwFMuQxV70jw+9+EdTAJ9nyiWn6/JTKZZlw0QT54USHFrSBLOwfbfWWuQkfhtw9UEXXswxPVjR45T6UE5i5XqdCMhGlJNNuLFzVI3Y5pYvUNHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XuvCjx97; arc=none smtp.client-ip=60.244.123.138
X-UUID: c7850850663311f1b1788b6acf885367-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=286SVq4heW7/YoWgz0MeHBzk0H0PK8ohQa96EYwQVTQ=;
	b=XuvCjx97GMMDxb3r8cTme0dQ+53yejRt1cRbiBcblSHOjIE4/wh5BcbmNg5+nXc87ltSDRMVVsumDUqhVy04KI1Ir3ywQXcR5Esd2ngtZBot0/cm+067FRS7me34uM2jefo6QrTo0ZLASNIefLkhV791YBzVg17jkTfLsc7i8Do=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:cdb99902-db69-4c28-a6bf-6b444a370b2f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:32d97654-902f-47df-afe3-f34f8d753c22,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7850850663311f1b1788b6acf885367-20260612
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 907035794; Fri, 12 Jun 2026 15:53:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:53:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:53:18 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>, FC Wei <fc.wei@mediatek.com>, Xiong
	<xiong.huang@mediatek.com>
Subject: [PATCH 15/20] wifi: mt76: mt7925: add MT7928 DMA configuration
Date: Fri, 12 Jun 2026 15:53:13 +0800
Message-ID: <20260612075313.2578154-5-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260612075313.2578154-1-jb.tsai@mediatek.com>
References: <20260612075313.2578154-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-37713-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,m:fc.wei@mediatek.com,m:xiong.huang@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 736AE6777AA

From: Emery Hsin <emery.hsin@mediatek.com>

Add MT7928 DMA queue layout, DMASHDL configuration, prefetch ring
setup, and WFDMA interrupt priority initialization. Select the
MT7928-specific layout and GLO_CFG path in mt7925_dma_init().

Signed-off-by: FC Wei <fc.wei@mediatek.com>
Signed-off-by: Xiong <xiong.huang@mediatek.com>
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 21 +++++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  8 ++
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 91 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/regs.h  | 21 +++++
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 94 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt792x_regs.h  | 19 +++-
 6 files changed, 233 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 293f173b23dd..1613c4765186 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -175,6 +175,27 @@ enum connac3_mcu_cipher_type {
 	CONNAC3_CIPHER_GCMP_256 = 12,
 };
 
+enum DMASHDL_GROUP_IDX {
+	DMASHDL_GROUP_0 = 0,
+	DMASHDL_GROUP_1,
+	DMASHDL_GROUP_2,
+	DMASHDL_GROUP_3,
+	DMASHDL_GROUP_4,
+	DMASHDL_GROUP_5,
+	DMASHDL_GROUP_6,
+	DMASHDL_GROUP_7,
+	DMASHDL_GROUP_8,
+	DMASHDL_GROUP_9,
+	DMASHDL_GROUP_10,
+	DMASHDL_GROUP_11,
+	DMASHDL_GROUP_12,
+	DMASHDL_GROUP_13,
+	DMASHDL_GROUP_14,
+	DMASHDL_GROUP_15,
+	DMASHDL_GROUP_NUM,
+	DMASHDL_LITE_GROUP_NUM = 64
+};
+
 struct mt7925_mcu_scan_chinfo_event {
 	u8 nr_chan;
 	u8 alpha2[3];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 4cc259418afc..a5414fa2736f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -15,6 +15,7 @@
 
 #define MT7925_RX_RING_SIZE		1536
 #define MT7925_RX_MCU_RING_SIZE		512
+#define MT7928_RX_MCU_WA_RING_SIZE	512
 
 #define MT7925_EEPROM_SIZE		3584
 #define MT7925_TOKEN_SIZE		8192
@@ -139,6 +140,13 @@ enum mt7927_rxq_id {
 	MT7927_RXQ_DATA2 = 7,
 };
 
+enum mt7928_rxq_id {
+	MT7928_RXQ_BAND0,
+	MT7928_RXQ_BAND1 = 2,
+	MT7928_RXQ_MCU_WM = 3,
+	MT7928_RXQ_MCU_WM2 = 1, /* for tx done */
+};
+
 enum {
 	MODE_OPEN = 0,
 	MODE_SHARED = 1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 6a65c630f85a..f79d4143e38b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -252,6 +252,27 @@ static const struct mt792x_dma_layout mt7927_dma_layout = {
 				   MT_RX_DATA_RING_BASE),
 };
 
+static const struct mt792x_dma_layout mt7928_dma_layout = {
+	.tx_data0 = mt792x_dma_ring(MT7925_TXQ_BAND0,
+				    MT7925_TX_RING_SIZE,
+				    MT_TX_RING_BASE),
+	.tx_mcu = mt792x_dma_ring(MT7925_TXQ_MCU_WM,
+				  MT7925_TX_MCU_RING_SIZE,
+				  MT_TX_RING_BASE),
+	.tx_fwdl = mt792x_dma_ring(MT7925_TXQ_FWDL,
+				   MT7925_TX_FWDL_RING_SIZE,
+				   MT_TX_RING_BASE),
+	.tx_done = mt792x_dma_ring(MT7928_RXQ_MCU_WM2,
+				   MT7928_RX_MCU_WA_RING_SIZE,
+				   MT_RX_EVENT_RING_BASE),
+	.rx_mcu = mt792x_dma_ring(MT7928_RXQ_MCU_WM,
+				  MT7925_RX_MCU_RING_SIZE,
+				  MT_RX_EVENT_RING_BASE),
+	.rx_data = mt792x_dma_ring(MT7928_RXQ_BAND0,
+				   MT7925_RX_RING_SIZE,
+				   MT_RX_DATA_RING_BASE),
+};
+
 static int mt7927_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
@@ -279,11 +300,62 @@ static int mt7927_dma_init(struct mt792x_dev *dev)
 	return mt792x_dma_enable(dev);
 }
 
+static void mt7928_dma_shdl_lite_init(struct mt792x_dev *dev)
+{
+	u32 addr, idx, grp1_5_quota, grp15_quota;
+	u32 q2group[8] = {
+		0x04000000, /* AC00->G0,..., AC03->G4 */
+		0x04010101, /* AC10->G1,..., AC13->G4 */
+		0x04020202, /* AC20->G2,..., AC23->G4 */
+		0x04030303, /* AC30->G3,..., AC33->G4 */
+		0x00000005, /* ALTX->G5,BMC->G0,BCN->G0 */
+		0x00000005, /* TGID=1 ALTX->G5 */
+		0x00000000, /* NAF/NBCN/FIXFID -> G0 */
+		0x00000005, /* TGID=2 ALTX->G5 */
+	};
+
+	/* RST */
+	mt76_wr(dev, MT_DMASHDL_LITE_MAIN_CONTROL, MT_DMASHDL_LITE_MAIN_CONTROL_SW_RST);
+	/* pse page size 0x10, ple page size 0x7e0 */
+	mt76_wr(dev, MT_DMASHDL_LITE_PAGE_SIZE,
+		FIELD_PREP(MT_DMASHDL_LITE_PSE_PAGE_SIZE_MASK, 0x10) |
+		FIELD_PREP(MT_DMASHDL_LITE_PLE_PAGE_SIZE_MASK, 0x7e0));
+	/* pse max page 8, ple max page 1 */
+	mt76_wr(dev, MT_DMASHDL_LITE_PKT_MAX_SIZE,
+		FIELD_PREP(MT_DMASHDL_LITE_PSE_PKT_MAX_SIZE_MASK, 8) |
+		FIELD_PREP(MT_DMASHDL_LITE_PLE_PKT_MAX_SIZE_MASK, 1));
+	/* SN/UDF check */
+	mt76_wr(dev, MT_DMASHDL_LITE_GROUP_SN_CHK0, 0xffffffff);
+	mt76_wr(dev, MT_DMASHDL_LITE_GROUP_SN_CHK1, 0xffffffff);
+	mt76_wr(dev, MT_DMASHDL_LITE_GROUP_UDF_CHK0, 0xffffffff);
+	mt76_wr(dev, MT_DMASHDL_LITE_GROUP_UDF_CHK1, 0xffffffff);
+	/* q mapping */
+	for (addr = MT_DMASHDL_LITE_Q_MAPPING0, idx = 0;
+	     idx < ARRAY_SIZE(q2group);
+	     idx++, addr += 4)
+		mt76_wr(dev, addr, q2group[idx]);
+	/* refill, set 0 to enable group 0,1,2,3,4,5 & 15 */
+	mt76_wr(dev, MT_DMASHDL_LITE_GROUP_DISABLE0, 0xffff7fc0);
+	mt76_wr(dev, MT_DMASHDL_LITE_GROUP_DISABLE1, 0xffffffff);
+	/* max/min quota */
+	grp1_5_quota = FIELD_PREP(MT_DMASHDL_LITE_GROUP_MAX_QUOTA_MASK, 0x3f0) |
+		       FIELD_PREP(MT_DMASHDL_LITE_GROUP_MIN_QUOTA_MASK, 0x10);
+	grp15_quota = FIELD_PREP(MT_DMASHDL_LITE_GROUP_MAX_QUOTA_MASK, 0x30);
+
+	for (addr = MT_DMASHDL_LITE_GROUP0_QUOTA, idx = 0;
+	     idx < DMASHDL_LITE_GROUP_NUM;
+	     idx++, addr += 4)
+		mt76_wr(dev, addr, (idx <= 5) ? grp1_5_quota :
+			((idx == 15) ? grp15_quota : 0));
+}
+
 static int mt7925_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
+	const struct mt792x_dma_layout *layout =
+		is_mt7928(&dev->mt76) ? &mt7928_dma_layout : &mt7925_dma_layout;
 
-	ret = mt792x_dma_alloc_queues(dev, &mt7925_dma_layout);
+	ret = mt792x_dma_alloc_queues(dev, layout);
 	if (ret)
 		return ret;
 
@@ -291,6 +363,9 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	if (ret < 0)
 		return ret;
 
+	if (is_mt7928(&dev->mt76))
+		mt7928_dma_shdl_lite_init(dev);
+
 	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt792x_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
@@ -402,14 +477,18 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret < 0)
 		return ret;
 
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto err_free_pci_vec;
-
 	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927 ||
 			pdev->device == 0x0738);
 	is_mt7928_hw = (pdev->device == 0x7928 || pdev->device == 0x7935);
 
+	if (is_mt7928_hw)
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(34));
+	else
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+
+	if (ret)
+		goto err_free_pci_vec;
+
 	/* MT7927: ASPM L1 causes unreliable WFDMA register access */
 	if (mt7925_disable_aspm || is_mt7927_hw)
 		mt76_pci_disable_aspm(pdev);
@@ -499,7 +578,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	if (is_mt7927(&dev->mt76))
 		ret = mt7927_dma_init(dev);
-	else if (is_mt7925(&dev->mt76))
+	else if (is_mt7925(&dev->mt76) || is_mt7928(&dev->mt76))
 		ret = mt7925_dma_init(dev);
 	else
 		ret = -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 855a53c0748a..253ba72310ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -108,4 +108,25 @@
 #define MT7925_PCIE_MAC_INT_ENABLE	MT7925_PCIE_MAC(0x188)
 #define MT7925_PCIE_MAC_PM		MT7925_PCIE_MAC(0x194)
 
+#define MT_DMASHDL_LITE_BASE			0x20026200
+#define MT_DMASHDL_LITE(ofs)			(MT_DMASHDL_LITE_BASE + (ofs))
+#define MT_DMASHDL_LITE_MAIN_CONTROL		MT_DMASHDL_LITE(0x004)
+#define MT_DMASHDL_LITE_MAIN_CONTROL_SW_RST		BIT(18)
+#define MT_DMASHDL_LITE_PAGE_SIZE		MT_DMASHDL_LITE(0x008)
+#define MT_DMASHDL_LITE_PLE_PAGE_SIZE_MASK		GENMASK(12, 0)
+#define MT_DMASHDL_LITE_PSE_PAGE_SIZE_MASK		GENMASK(28, 16)
+#define MT_DMASHDL_LITE_PKT_MAX_SIZE		MT_DMASHDL_LITE(0x00c)
+#define MT_DMASHDL_LITE_PLE_PKT_MAX_SIZE_MASK		GENMASK(12, 0)
+#define MT_DMASHDL_LITE_PSE_PKT_MAX_SIZE_MASK		GENMASK(28, 16)
+#define MT_DMASHDL_LITE_GROUP_DISABLE0		MT_DMASHDL_LITE(0x010)
+#define MT_DMASHDL_LITE_GROUP_DISABLE1		MT_DMASHDL_LITE(0x014)
+#define MT_DMASHDL_LITE_GROUP_SN_CHK0		MT_DMASHDL_LITE(0x018)
+#define MT_DMASHDL_LITE_GROUP_SN_CHK1		MT_DMASHDL_LITE(0x01c)
+#define MT_DMASHDL_LITE_GROUP_UDF_CHK0		MT_DMASHDL_LITE(0x020)
+#define MT_DMASHDL_LITE_GROUP_UDF_CHK1		MT_DMASHDL_LITE(0x024)
+#define MT_DMASHDL_LITE_Q_MAPPING0		MT_DMASHDL_LITE(0x028)
+#define MT_DMASHDL_LITE_GROUP0_QUOTA		MT_DMASHDL_LITE(0x100)
+#define MT_DMASHDL_LITE_GROUP_MIN_QUOTA_MASK		GENMASK(12, 0)
+#define MT_DMASHDL_LITE_GROUP_MAX_QUOTA_MASK		GENMASK(28, 16)
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 4d4c62bb0a77..8ad94fa58340 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -206,9 +206,38 @@ static void mt7927_wfdma_setup(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
 }
 
+static void mt7928_dma_prefetch_setup(struct mt792x_dev *dev)
+{
+	/* rx ring */
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x8));
+	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x0080, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x00c0, 0x8));
+	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x0140, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0x0180, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING5_EXT_CTRL, PREFETCH(0x01c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING6_EXT_CTRL, PREFETCH(0x0200, 0x4));
+	/* tx ring */
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0240, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x0340, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x0440, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x0540, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING4_EXT_CTRL, PREFETCH(0x0640, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING5_EXT_CTRL, PREFETCH(0x0740, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0840, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0880, 0x4));
+}
+
+static void mt7928_wfdma_setup(struct mt792x_dev *dev)
+{
+	mt76_wr(dev, MT_WFDMA0_INT_RX_PRI, 0);
+	mt76_wr(dev, MT_WFDMA0_INT_TX_PRI, 0);
+}
+
 static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 {
-	if (is_mt7927(&dev->mt76)) {
+	if (is_mt7928(&dev->mt76)) {
+		mt7928_dma_prefetch_setup(dev);
+	} else if (is_mt7927(&dev->mt76)) {
 		mt7927_dma_prefetch_setup(dev);
 	} else if (is_mt7925(&dev->mt76)) {
 		mt7925_dma_prefetch_setup(dev);
@@ -250,32 +279,69 @@ static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 
 int mt792x_dma_enable(struct mt792x_dev *dev)
 {
-	/* configure perfetch settings */
+	u32 addr;
+
+	/* configure prefetch settings */
 	mt792x_dma_prefetch(dev);
 
 	/* reset dma idx */
 	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
-	if (is_mt7925(&dev->mt76))
+	if (is_mt7925(&dev->mt76) || is_mt7928(&dev->mt76))
 		mt76_wr(dev, MT_WFDMA0_RST_DRX_PTR, ~0);
 
 	/* configure delay interrupt */
 	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
 
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
-		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
-		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
-		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		 FIELD_PREP(MT_WFDMA0_GLO_CFG_DMA_SIZE, 3) |
-		 MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK |
-		 MT_WFDMA0_GLO_CFG_RX_WB_DDONE |
-		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+	if (is_mt7928(&dev->mt76)) {
+		mt76_wr(dev, MT_WFDMA0_GLO_CFG,
+			MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
+			MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
+			MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
+			MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			FIELD_PREP(MT_WFDMA0_GLO_CFG_DMA_SIZE, 1) |
+			MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK |
+			MT_WFDMA0_GLO_CFG_RX_WB_DDONE |
+			MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+			MT_WFDMA0_GLO_CFG_ADDR_EXT_EN |
+			MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN);
+		/* set rxq threshold to 2 */
+		for (addr = MT_WFDMA0_WPDMA_PAUSE_RXQ_TH10;
+		     addr <= MT_WFDMA0_WPDMA_PAUSE_RXQ_TH76;
+		     addr += 4) {
+			mt76_wr(dev, addr,
+				FIELD_PREP(MT_WFDMA0_WPDMA_PAUSE_RXQ_THXX_L_TH_MASK, 2) |
+				FIELD_PREP(MT_WFDMA0_WPDMA_PAUSE_RXQ_THXX_H_TH_MASK, 2));
+		}
+		mt76_wr(dev, MT_WFDMA0_GLO_CFG_EXT0,
+			MT_WFDMA0_GLO_CFG_EXT0_CSR_MEM_ARB_LOCK_EN |
+			MT_WFDMA0_GLO_CFG_EXT0_CSR_TX_DMASHDL_LITE_EN |
+			MT_WFDMA0_GLO_CFG_EXT0_CSR_RX_WB_KEEP_RSVD |
+			MT_WFDMA0_GLO_CFG_EXT0_CSR_BID_CHECK_BYPASS_EN |
+			MT_WFDMA0_GLO_CFG_EXT0_CSR_RX_INFO_WB_EN |
+			MT_WFDMA0_GLO_CFG_EXT0_CSR_AXI_AWUSER_LOCK_EN |
+			FIELD_PREP(MT_WFDMA0_GLO_CFG_EXT0_CSR_MAX_PREFETCH_CNT_MASK, 3) |
+			FIELD_PREP(MT_WFDMA0_GLO_CFG_EXT0_CSR_MEM_BST_SIZE_MASK, 3) |
+			FIELD_PREP(MT_WFDMA0_GLO_CFG_EXT0_CSR_AXI_AW_OUTSTANDING_NUM_MASK,
+				   8));
+	} else {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG,
+			 MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
+			 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
+			 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
+			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			 FIELD_PREP(MT_WFDMA0_GLO_CFG_DMA_SIZE, 3) |
+			 MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK |
+			 MT_WFDMA0_GLO_CFG_RX_WB_DDONE |
+			 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+	}
 
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	if (is_mt7927(&dev->mt76))
+	if (is_mt7928(&dev->mt76))
+		mt7928_wfdma_setup(dev);
+	else if (is_mt7927(&dev->mt76))
 		mt7927_wfdma_setup(dev);
 	else if (is_mt7925(&dev->mt76))
 		mt7925_wfdma_setup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 0e297fd9468a..3587f61e098a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -331,11 +331,29 @@
 #define MT_INT_MCU_CMD			MCU2HOST_SW_INT_ENA
 
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
+#define MT_WFDMA0_WPDMA_PAUSE_RXQ_TH10	MT_WFDMA0(0x260)
+#define MT_WFDMA0_WPDMA_PAUSE_RXQ_TH32	MT_WFDMA0(0x264)
+#define MT_WFDMA0_WPDMA_PAUSE_RXQ_TH54	MT_WFDMA0(0x268)
+#define MT_WFDMA0_WPDMA_PAUSE_RXQ_TH76	MT_WFDMA0(0x26c)
+#define MT_WFDMA0_WPDMA_PAUSE_RXQ_THXX_L_TH_MASK		GENMASK(11, 0)
+#define MT_WFDMA0_WPDMA_PAUSE_RXQ_THXX_H_TH_MASK		GENMASK(27, 16)
+
 #define MT_WFDMA0_RST_DRX_PTR		MT_WFDMA0(0x280)
 #define MT_WFDMA0_INT_RX_PRI		MT_WFDMA0(0x298)
 #define MT_WFDMA0_INT_TX_PRI		MT_WFDMA0(0x29c)
 #define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_MEM_ARB_LOCK_EN		BIT(4)
 #define MT_WFDMA0_GLO_CFG_EXT0_CSR_TX_DMASHDL_EN		BIT(6)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_TX_DMASHDL_LITE_EN		BIT(7)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_RX_WB_KEEP_RSVD		BIT(10)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_BID_CHECK_BYPASS_EN		BIT(22)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_RX_INFO_WB_EN		BIT(23)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_AXI_AWUSER_LOCK_EN		BIT(29)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_MAX_PREFETCH_CNT_MASK	GENMASK(1, 0)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_MEM_BST_SIZE_MASK		GENMASK(3, 2)
+#define MT_WFDMA0_GLO_CFG_EXT0_CSR_AXI_AW_OUTSTANDING_NUM_MASK	GENMASK(27, 24)
+
+#define MT_WFDMA0_GLO_CFG_EXT1		MT_WFDMA0(0x2b4)
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
 
 #define MT_WFDMA0_TX_RING0_EXT_CTRL	MT_WFDMA0(0x600)
@@ -375,7 +393,6 @@
 #define MT_WFDMA_PREFETCH_CFG1		MT_WFDMA_EXT_CSR(0xf4)
 #define MT_WFDMA_PREFETCH_CFG2		MT_WFDMA_EXT_CSR(0xf8)
 #define MT_WFDMA_PREFETCH_CFG3		MT_WFDMA_EXT_CSR(0xfc)
-#define MT_WFDMA0_GLO_CFG_EXT1		MT_WFDMA0(0x2b4)
 
 #define MT_SWDEF_BASE			0x41f200
 #define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
-- 
2.45.2


