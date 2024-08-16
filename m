Return-Path: <linux-wireless+bounces-11542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A5954672
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51AC1F22630
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F8170A38;
	Fri, 16 Aug 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p8vY1Irh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1316C6A7
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802618; cv=none; b=obgqJ1aQ593Q5mJJltq4uzkA4wCUYLJ6zwR1HNWj5C88pALUga4lWnZPWFfwQG77G5dDf/q51LHfHHJUDE3u0EcE7QhcjzYBMp6Pqcq9gm+61He2+LJrBbd9ojG75D3gZFLfz3FFuKaX2khlVLMzCiZD9taMqbCQv3NuAwh9oTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802618; c=relaxed/simple;
	bh=eWQsbuRXWAzlvnnlT1UQQi/8ux2tQF2eKmbfVbzAM+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHTTsXuIqvovtTOeu6Egvv1xjS9cscV7KY1sC8pfGy/0Fz2F/ihFW5D6k3w56Sv2dSyaEDd4sybweb7SpfXaVrQl5XiVA9VbwKN9lZGGy9SuZWqNxkFbMSbTRUnS1otdUjDsY+APNKo4Rw/KvngFiqnSHNFoWdp/2FY2D1OFfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=p8vY1Irh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aad44c385bb411ef8b96093e013ec31c-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zaAas9QhOPswdEwX29L981sav0R3IkIAazBDWezta+g=;
	b=p8vY1IrhcbMc4vSBkiuXLAaLdm+exomUiIgTifTEik4UFC6NsmRVcsvPGK6i+H71a/CnfN+8bHB4CtodJYJA6MJZF3whFF9RtJdvU6i1f62j0ylCqRV1m83qAiXiEV1Vi3gMNRLvLyaBp5sDmEsZt/+IAoVcepnMDfldAi+phpQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ad8a3fb5-c046-4b77-9d85-c96b7d352199,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:31c0b6c1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aad44c385bb411ef8b96093e013ec31c-20240816
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1687346882; Fri, 16 Aug 2024 17:48:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 02:48:19 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:48:19 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 01/12] wifi: mt76: mt7996: use hweight16 to get correct tx antenna
Date: Fri, 16 Aug 2024 17:46:25 +0800
Message-ID: <20240816094635.2391-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

The chainmask is u16 so using hweight8 cannot get correct tx_ant.
Without this patch, the tx_ant of band 2 would be -1 and lead to the
following issue:
BUG: KASAN: stack-out-of-bounds in mt7996_mcu_add_sta+0x12e0/0x16e0 [mt7996e]

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2e4fa9f48dfb..e68724e54013 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1653,7 +1653,7 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mvif->phy;
-	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
+	int tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
 	static const u8 matrix[4][4] = {
-- 
2.39.2


