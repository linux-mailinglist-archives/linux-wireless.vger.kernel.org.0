Return-Path: <linux-wireless+bounces-7660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413AE8C5F03
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 03:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5AE281CA6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82E18635;
	Wed, 15 May 2024 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J7nUaJL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C29182DA
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737925; cv=none; b=iiPWqwl+w3G7UIfmP3ZZDTzenyuNVovXl8ODMQ5FZeFKvqV7cVkUTyhuq+5sO7I/RbDBnu0pUjzTKF6HEZrN731U6XdHs/v3ttYtLvu3NiaTwwk5/A1ejTOta7BTNAcoGtEXBb6hwzaJu/pJ9N1nBAqGNlQsjlCBQ29b2vS6+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737925; c=relaxed/simple;
	bh=C1hJMDeF1AnALarVIMssBMSPUM+VqvZu9M3X9Ln4sr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxmktmHrhLSxVNS/jAzXpCQDTHQ1ZjN/DMHFO5qFLrauU+Xzp0yyGYRSPDZdJtvFjhh6DpWFr816uSQ95kvaRjQwSptBJvZSjWS2eWRN+YiLGncMxvYm+TFL8W5j57RwIc2uiHnzc3chU49x8Mq2avSP+vh7lZ+V6z/bSPncWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J7nUaJL1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b74d0234125d11ef8065b7b53f7091ad-20240515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rbyWPwZsJd0LcGp8L2yOkHr8OYQvfB61pXQHi/tv948=;
	b=J7nUaJL1kOPOSDUvJMs8IeGaeu1fvI9iyZmqJGs0a7gWFM653TODKiXszJy3LqHlzv2Y/11W2ac+GdaYrVI5V2Ni+g166CjOdNVt6yXWrxwnHlzYP9TbumlhiYuz5py2xLH1PYiZuwReNnANMAw5dO476KZUzXDzMiX1bqWTgq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:665825d0-e336-463f-af18-6f620359c2b7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:bdbe5c87-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b74d0234125d11ef8065b7b53f7091ad-20240515
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 453240668; Wed, 15 May 2024 09:51:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 15 May 2024 09:51:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 15 May 2024 09:51:57 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt792x: fix scheduler interference in drv own process
Date: Wed, 15 May 2024 09:51:55 +0800
Message-ID: <20240515015155.24931-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Michael Lo <michael.lo@mediatek.com>

Add some time to wait for LP engine to complete its operation
before polling pmctrl register.

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 3 +++
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 1 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 6 ++++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f768e9389ac6..0f7d5a92f3d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -339,6 +339,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	bus_ops->rmw = mt7921_rmw;
 	dev->mt76.bus = bus_ops;
 
+	if (mt7921_disable_aspm)
+		dev->disable_aspm = true;
+
 	ret = mt792xe_mcu_fw_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 07b74d492ce1..e7039e312538 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -373,6 +373,9 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	bus_ops->rmw = mt7925_rmw;
 	dev->mt76.bus = bus_ops;
 
+	if (mt7925_disable_aspm)
+		dev->disable_aspm = true;
+
 	ret = __mt792x_mcu_fw_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 20578497a405..8f913336a668 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -190,6 +190,7 @@ struct mt792x_dev {
 	bool fw_assert:1;
 	bool has_eht:1;
 	bool regd_in_progress:1;
+	bool disable_aspm:1;
 	wait_queue_head_t wait;
 
 	struct work_struct init_work;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a405af8d9052..a11e5438a36e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -766,6 +766,12 @@ int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev)
 
 	for (i = 0; i < MT792x_DRV_OWN_RETRY_COUNT; i++) {
 		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
+
+		if (!dev->disable_aspm) {
+			/* wait for LP engine to complete its operation */
+			usleep_range(2000, 3000);
+		}
+
 		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
 					PCIE_LPCR_HOST_OWN_SYNC, 0, 50, 1))
 			break;
-- 
2.25.1


