Return-Path: <linux-wireless+bounces-29100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8FC6937D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 12:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B88372AB6D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E9347BA3;
	Tue, 18 Nov 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JUlaBIxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6ED2F6592
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466912; cv=none; b=tpAMkwINRZwJVRccuR+ua37QfoiH1CRa7X4nbTDpNnmLzzGiMTN9fryHRiEZLISd1GQi5rf4XitF2NfhZMhtWwLZE0Rn2pLm87FC13Dnew7DHIrYNm/fED4OBb+fyayWq2p4Wsnj9q8GyPvnuCdrSGb7c/TG/2Z6vTXBMyBJ0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466912; c=relaxed/simple;
	bh=OaBpZIluaqgb69QxvVA9nk32I9RYWWiCxwNE7bgOiHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxWpgPsXnLJZ3JrO0V6wLsCWdcP0PDtU3BUt1rWwFE6cjvdtlvbAvq09W6rXXqkHaeIQ7BPKiCd+p5bOR1t2auatDR1JgSwXEGXSVmRF/WeVEAOQfMiTLiedJvDv9xzDaTi0wTtwB40+dblLEd2wAHPxHBvPxMQa/t0lory4FbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JUlaBIxR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6b513d34c47511f0b33aeb1e7f16c2b6-20251118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jgsEvn33Uu1PnkDUHpeJtS0g8aJZZYVzC3RyBEw/MuQ=;
	b=JUlaBIxRghm49wkIq48AcVOEZU20JfrDBWrr8UyUQ+rlHYydh3wYqLvo9DLqMXVi0HqQF/zso5G2VNBXWRxxA0MrpjeUxphlFcB8smHaYtIWSmdsoGUaUox/1iiOMTcvFMnYpoX4pyA6rmMLfwiF+f+V+CBGOzhmV1z9fSMLLfU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:acd8cd07-573b-4c0f-84a3-a88302b90282,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:b18aeeba-0c02-41a0-92a3-94dc7dc7eeca,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b513d34c47511f0b33aeb1e7f16c2b6-20251118
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1280277785; Tue, 18 Nov 2025 19:55:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 18 Nov 2025 19:55:02 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 18 Nov 2025 19:55:01 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Shengxi Xu
	<shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>
Subject: [patch] wifi: mt76: fix wifi init fail by setting MCU_RUNNING state after CLC load
Date: Tue, 18 Nov 2025 19:54:54 +0800
Message-ID: <19ec8e4465142e774f17801025accd0ae2214092.1763465933.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Set the MT76_STATE_MCU_RUNNING bit only after mt7921_load_clc()
has successfully completed. Previously, the MCU_RUNNING state
was set before loading CLC, which could cause conflict between
chip mcu_init retry and mac_reset flow, result in chip init fail
and chip abnormal status. By moving the state set after CLC load,
firmware initialization becomes robust and resolves init fail issue.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8c5e6bdc0fc9..833d0ab64230 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -646,10 +646,10 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
 	if (err)
 		return err;
 
-	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	err = mt7921_load_clc(dev, mt792x_ram_name(dev));
 	if (err)
 		return err;
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	return mt7921_mcu_fw_log_2_host(dev, 1);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d8f5ecebf5dc..cf0fdea45cf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1054,10 +1054,10 @@ int mt7925_run_firmware(struct mt792x_dev *dev)
 	if (err)
 		return err;
 
-	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	err = mt7925_load_clc(dev, mt792x_ram_name(dev));
 	if (err)
 		return err;
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	return mt7925_mcu_fw_log_2_host(dev, 1);
 }
-- 
2.45.2


