Return-Path: <linux-wireless+bounces-13215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63754986B46
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 05:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20215283831
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F515539A;
	Thu, 26 Sep 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fou+s5Nx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378B13C3F2
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321174; cv=none; b=Gt8kSGZxVLyKIjKa2wpSr7z454skNqPNilUDXWdghRywEP+h26BsRgCaVp6099F9SlDN3ZL0Jli0XxhPim5jxldIqC9bnUVT/p/HEAUEhCzR/87P5iMmiz/DzZLE7c5yoIm9pwtVX7tKZ3MsBF/sD3DU+BPGENeMc1hltpEinQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321174; c=relaxed/simple;
	bh=w0iM8BN6aPHvdJggKC5hRXPEpEdBJUk+zsSgrh+osEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ajg27lsTzQ3uC0ISuCdgKmGpF6kb68ObqQMoBj5cFNzmJ1Fb0tHY69qXDFAsfrbHdekvsv7+Mu9G0jsXxukff48P2RW0uVm1l/mb6iFCOeltjnIeWiMubq9LUywqFp8LhAAqYgzGdKh7FswZN/A0jKHvlrwDzA0J/ndr0VvlbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fou+s5Nx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 10ecbfb07bb711efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=f5Ww+D3KjJJW2p5PdPMma5bfl6+8GsD3wuro3SWJOSU=;
	b=fou+s5NxvZTuGSv5PzP0cVSKfHZYoQeLqs5iPpPcE9LcepG+iwF8qOA6sJLx2CNOI+GvQCrEcuO9LTmJmVMpY8ff2ID5ndF0Oqzd2zx40iyqImsHjapks54p+lzKPW7CcyD+1dCfjdrsArr+rg1W9XoMg8I35Tv/G35llaC5n4A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:bd1cb58e-258c-48dc-9f50-2a44f3b6375d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:0c42949e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 10ecbfb07bb711efb66947d174671e26-20240926
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 258083995; Thu, 26 Sep 2024 11:26:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 11:26:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 11:26:05 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>,
	Shayne Chen <shayne.chen@mediatek.com>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: mt7996: extend flexibility of mt7996_mcu_get_eeprom()
Date: Thu, 26 Sep 2024 11:24:38 +0800
Message-ID: <20240926032440.15978-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Support passing customized buffer pointer and length to
mt7996_mcu_get_eeprom().

This is the preparation for adding more variants support which needs to
prefetch FEM module from efuse, and also fixes potential OOB issue when
reading the last efuse block.

Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |  9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 14 ++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 4a8237118287..861aba68a725 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -86,8 +86,13 @@ static int mt7996_eeprom_load(struct mt7996_dev *dev)
 		/* read eeprom data from efuse */
 		block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, eeprom_blk_size);
 		for (i = 0; i < block_num; i++) {
-			ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size);
-			if (ret < 0)
+			u32 len = eeprom_blk_size;
+
+			if (i == block_num - 1)
+				len = MT7996_EEPROM_SIZE % eeprom_blk_size;
+			ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size,
+						    NULL, len);
+			if (ret && ret != -EINVAL)
 				return ret;
 		}
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 327337b31279..fa7832f625d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3548,7 +3548,7 @@ int mt7996_mcu_set_eeprom(struct mt7996_dev *dev)
 				 &req, sizeof(req), true);
 }
 
-int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len)
 {
 	struct {
 		u8 _rsv[4];
@@ -3577,15 +3577,21 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
 	valid = le32_to_cpu(*(__le32 *)(skb->data + 16));
 	if (valid) {
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
-		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
+
+		if (!buf)
+			buf = (u8 *)dev->mt76.eeprom.data + addr;
+		if (!buf_len || buf_len > MT7996_EEPROM_BLOCK_SIZE)
+			buf_len = MT7996_EEPROM_BLOCK_SIZE;
 
 		skb_pull(skb, 48);
-		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
+		memcpy(buf, skb->data, buf_len);
+	} else {
+		ret = -EINVAL;
 	}
 
 	dev_kfree_skb(skb);
 
-	return 0;
+	return ret;
 }
 
 int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ab8c9070630b..55aa5f6ab77d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -476,7 +476,7 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta, void *data, u32 field);
 int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
-int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset);
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len);
 int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);
 int mt7996_mcu_get_chip_config(struct mt7996_dev *dev, u32 *cap);
 int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 set, u8 band);
-- 
2.39.2


