Return-Path: <linux-wireless+bounces-11541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E974954637
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C391C226AD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1247D16C6A7;
	Fri, 16 Aug 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="noBzAuOf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE285C5E
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801860; cv=none; b=NW2yZZrPJLrWx+WOGFrYH263wtqs4B0URBFoXValU/PRWwRbr3LYXz18tGLBhXiAeulMCGvyOSU6jdrDUAI4CenpbE1+RHvaZdHsvOHtnlRi1Xb/7Gg/dglo6KtS8UO+TD6bM+D04HmrTQd9yn8NdNXlJ70OvDAs0+mtEgCbd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801860; c=relaxed/simple;
	bh=ylIZcJ/aD/T6CaW/VihPZrczhzZ+VOa9bpKs/xSFOT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kj6aY1f/tFoiJWC1fJ0VWYr4DsdNWLbvV4ylNw/JSFHHkd614ujFwW4F4gcZqk6N5h5ZEK56qcVK35YIPzmaJGd+2ZslYTSRLP/euLo6KixeR7FVUuSZ1v8IDFCiN+pJc6NZ9Ko9BX4G5iWuM8vITrmXlgtn1SW0guEd+HBAc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=noBzAuOf; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 04cd27d25bb511ef8b96093e013ec31c-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HH6jHr2JVqMHxGoTt7vsZl9FwpJQ7+Cm1WeHQQ2hlRE=;
	b=noBzAuOfvKWkYt5cShUD8JULQlPUZA8fnipayemNEBbQDsLDAJN8oQEByIhobPPc9bUUeW7FgA27dwy8gqK/mU/2L36JpY3y8pM0lGcpUqnUKn/Wz5c/Q9I5l0QSjKAEzuOVYuxn+WTdKCD22rOFCnHyuwQQ+6UX2j/q54lh1cw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:000deee2-ebf2-4ca0-aed2-3a18e9d89623,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:3ac8b6c1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 04cd27d25bb511ef8b96093e013ec31c-20240816
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1810029333; Fri, 16 Aug 2024 17:50:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:50:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:50 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>,
	"Peter Chiu" <chui-hao.chiu@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>
Subject: [PATCH 04/12] wifi: mt76: connac: fix checksum offload fields of connac3 RXD
Date: Fri, 16 Aug 2024 17:50:40 +0800
Message-ID: <20240816095040.2574-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.936500-8.000000
X-TMASE-MatchedRID: O3Wzr5fP2PYVAKRaMHqjDpdc7I2df+msSoCG4sefl8QRkR4WWjIJ6Qqu
	sGnv+h2ZXuAgXl+qfJ3QcZJBnH5UfEfSQhRXazGFdrnuu4cCcfFKPIx+MJF9o99RlPzeVuQQhne
	qPICXFZPafWtC8SgpvKnj4t9QwMZkITpz0liE0noWny127IX6IKI0K26z6c86CqIJhrrDy29DT3
	UDhPI2mmHHaMKYeRA+OdqdlfcF699iC22Ch2XoOeEbUg4xvs+wy3fMd7pCml6piV7/wDZ6aKPFj
	JEFr+olwXCBO/GKkVr3FLeZXNZS4IzHo47z5Aa+dewKmL9gkKSU4XNMpM/dEgY/vFCtojgWXybD
	gzSJcVpTXVe0FRtsCZP6uq5XGycD/NKeQtSUk2S3y8aF9AYwm2rEhaFiyBlneZUpm6wun3ba/06
	NhYDa4wyzCDjlUx89p2y3mIB+it9WXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.936500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4CD056189CDCEC77DD067318BF1BCB932F3DC7FC097ED8804A88E913559DA2482000:8
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Fix incorrect RXD offset and bitfield related to RX checksum offload.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Fixes: 4e9011fcdfc4 ("wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h")
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c       | 5 ++---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 353e66069840..ef003d1620a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -28,8 +28,6 @@ enum {
 #define MT_RXD0_MESH			BIT(18)
 #define MT_RXD0_MHCP			BIT(19)
 #define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
 
 #define MT_RXD0_SW_PKT_TYPE_MASK	GENMASK(31, 16)
 #define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
@@ -80,6 +78,8 @@ enum {
 #define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
 #define MT_RXD3_NORMAL_CO_ANT		BIT(22)
 #define MT_RXD3_NORMAL_FCS_ERR		BIT(24)
+#define MT_RXD3_NORMAL_IP_SUM		BIT(26)
+#define MT_RXD3_NORMAL_UDP_TCP_SUM	BIT(27)
 #define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
 
 /* RXD DW4 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index cf36750cf709..634c42bbf23f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -352,7 +352,7 @@ mt7925_mac_fill_rx_rate(struct mt792x_dev *dev,
 static int
 mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 {
-	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_mask = MT_RXD3_NORMAL_IP_SUM | MT_RXD3_NORMAL_UDP_TCP_SUM;
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	bool hdr_trans, unicast, insert_ccmp_hdr = false;
 	u8 chfreq, qos_ctl = 0, remove_pad, amsdu_info;
@@ -362,7 +362,6 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	struct mt792x_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
 	u32 csum_status = *(u32 *)skb->cb;
-	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
@@ -420,7 +419,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	if (!sband->channels)
 		return -EINVAL;
 
-	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
+	if (mt76_is_mmio(&dev->mt76) && (rxd3 & csum_mask) == csum_mask &&
 	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index bc7111a71f98..fd5fe96c32e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -435,7 +435,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
-	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_mask = MT_RXD3_NORMAL_IP_SUM | MT_RXD3_NORMAL_UDP_TCP_SUM;
 	u32 csum_status = *(u32 *)skb->cb;
 	u32 mesh_mask = MT_RXD0_MESH | MT_RXD0_MHCP;
 	bool is_mesh = (rxd0 & mesh_mask) == mesh_mask;
@@ -497,7 +497,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 	if (!sband->channels)
 		return -EINVAL;
 
-	if ((rxd0 & csum_mask) == csum_mask &&
+	if ((rxd3 & csum_mask) == csum_mask &&
 	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-- 
2.39.2


