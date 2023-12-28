Return-Path: <linux-wireless+bounces-1299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327C81F636
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00369282C88
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5706FDF;
	Thu, 28 Dec 2023 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DPy0/3Hc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59736FA4
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95b4bcd0a56011eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IGGC5pOBDPEDthaV7kHlRmsE6IFZQlw9U1xCEMj9Inw=;
	b=DPy0/3HcRfOus4u90ig+n5/9pQryfDaPZrZPSxlnGKIgLaFtgms8i5H3hzASwaIH80l3l/w2QhgkIPgM/em9tnXim1AubQwo5DeUxOVCMPNRBtYNkEnzShHBiNUY51nNpXVX0C4um0MF05hSBECEmFoCjuduKbJxE1z1pSjFcpk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:93a7521d-c7f1-42f9-962f-d183b193e270,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:b691c27e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 95b4bcd0a56011eea2298b7352fd921d-20231228
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1804866303; Thu, 28 Dec 2023 17:07:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 17:07:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 17:07:52 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH 08/10] wifi: mt76: mt7925: add flow to avoid chip bt function fail
Date: Thu, 28 Dec 2023 17:07:47 +0800
Message-ID: <20231228090749.15191-9-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
References: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.224500-8.000000
X-TMASE-MatchedRID: uyqRcNBN+ubpRzKqh62z7I4V8tCoXo/SjzwigoyOACRTCQL4BWtbpGDb
	UAcMOUZ0MbcpjNXxwebhihMBM8ipLFilxHYfa34UH5YQyOg71ZZMkOX0UoduuQqiCYa6w8tvIub
	j9bOa7Mt5lXU337u2SOWYSIzA/m69DPIzF4wRfrAURSScn+QSXt0H8LFZNFG7doMssNsUwYVpHR
	SnbupUBB1x/By+gvnhaTKhO+lvTeQvZkbHd6W91e0kc/JNjS08EgywJelLOq9HqzOtgqvuRwy2w
	bvlZJdK7IZlhIDgeCWAhOcaQrQ0U1GyRcoeF18qmKP0zzpTAeGwod8xOMKmvA1Aka/KIp/p
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.224500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 885097603E7D3F69A8F074DFBFE3E1751C2D6947E9D55F37778F3FF25909AD542000:8

From: Quan Zhou <quan.zhou@mediatek.com>

A sub-process of Wifi L0.5 reset will make chip common partition
enter low power, and have chance lead to Bluetooth host-to-chip
command timeout, modify the software flow according to the chip's
design to solve the problem.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 734f31ee40d3..7661098a02b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -386,6 +386,8 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
+
 	ret = mt792x_wfsys_reset(dev);
 	if (ret)
 		goto err_free_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index a99af23e4b56..d7f9b24cd665 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -389,6 +389,9 @@
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
 
+#define MT_HW_EMI_CTL			0x18011100
+#define MT_HW_EMI_CTL_SLPPROT_EN	BIT(1)
+
 #define MT_PCIE_MAC_BASE		0x10000
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
 #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
-- 
2.18.0


