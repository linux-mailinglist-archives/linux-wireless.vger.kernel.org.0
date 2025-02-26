Return-Path: <linux-wireless+bounces-19465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B6A45779
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888EC189D6AE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7226BDBF;
	Wed, 26 Feb 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bWSigLfT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701A224249
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556325; cv=none; b=jhOSiYNNKLKDi1/Zmt6JATn3RzNFPksWbR5Nv+cBPZxXRzeq/IQ4vLlLdR0G5myiVnLODtuBh5FMkeFD6yAigHCxHQ0d3n5BajLYgBdkRcI1AcEDUuZw0Hy+zTJXzXUeWIfuf04IkpXnuPQHmZu4iVssew0wH2Aj+ANrquLHhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556325; c=relaxed/simple;
	bh=xRXqiQDJklc+7jg51sQpl2x1LSfx5o2xVWZGIotR3Po=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jq0f3nv1mjQ6EUnaolidqTxEVG009NbMWppLXYv14EYpjBdDDasl3f1i+AlTLnduKMueZ/HkKpjMZBGzedJ8iEGkx068aJI42mDYITRaHeMop8PBbdewPx8B5XZ12vWpomd1nZD+ZdyhU1WXp/4BhbWKDisJSRFXP7EYeTRzsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bWSigLfT; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 89df0770f41611ef8eb9c36241bbb6fb-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rfdgvcpdboKYz/2cMopVgvIsRvqrtSjrhLqC3Be+JUA=;
	b=bWSigLfTZq9W8ThQ/vbbiXHpwDnQk6MpHiQdH08gZB6J7GwmzHOwiSF3aG60bAI7U/14e7cKlfoWJvN2Zbm+DrJaiEDUXMo+hyniiBfqkZkszR7ePGdhspbGZGoCzVM49x0bQ7bJJYOhaOL6uEv9u+vNRbdPP8EBO4Mia1siQ+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:177ccc64-3967-411d-86f2-72f6a663afed,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:e3ae93a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 89df0770f41611ef8eb9c36241bbb6fb-20250226
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 328109791; Wed, 26 Feb 2025 15:51:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 15:51:49 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 15:51:49 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 1/6] wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
Date: Wed, 26 Feb 2025 15:51:18 +0800
Message-ID: <20250226075123.3981253-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Read the EEPROM to determine the hardware type and uses this to load the
correct CLC data.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 61 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 +
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d4fac7c2d0e6..505a6467f147 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -800,6 +800,54 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 				 enable, false);
 }
 
+static int mt7925_mcu_read_eeprom(struct mt792x_dev *dev, u32 offset, u8 *val)
+{
+	struct {
+		u8 rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		__le32 addr;
+		__le32 valid;
+		u8 data[MT7925_EEPROM_BLOCK_SIZE];
+	} __packed req = {
+		.tag = cpu_to_le16(1),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7925_EEPROM_BLOCK_SIZE)),
+	};
+	struct evt {
+		u8 rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		__le32 ver;
+		__le32 addr;
+		__le32 valid;
+		__le32 size;
+		__le32 magic_num;
+		__le32 type;
+		__le32 rsv1[4];
+		u8 data[32];
+	} __packed * res;
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WM_UNI_CMD_QUERY(EFUSE_CTRL),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct evt *)skb->data;
+	*val = res->data[offset % MT7925_EEPROM_BLOCK_SIZE];
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -809,12 +857,19 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	struct mt792x_phy *phy = &dev->phy;
 	const struct firmware *fw;
 	int ret, i, len, offset = 0;
-	u8 *clc_base = NULL;
+	u8 *clc_base = NULL, hw_encap = 0;
 
 	if (mt7925_disable_clc ||
 	    mt76_is_usb(&dev->mt76))
 		return 0;
 
+	if (mt76_is_mmio(&dev->mt76)) {
+		ret = mt7925_mcu_read_eeprom(dev, MT_EE_HW_TYPE, &hw_encap);
+		if (ret)
+			return ret;
+		hw_encap = u8_get_bits(hw_encap, MT_EE_HW_TYPE_ENCAP);
+	}
+
 	ret = request_firmware(&fw, fw_name, mdev->dev);
 	if (ret)
 		return ret;
@@ -859,6 +914,10 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 		if (phy->clc[clc->idx])
 			continue;
 
+		/* header content sanity */
+		if (u8_get_bits(clc->type, MT_EE_HW_TYPE_ENCAP) != hw_encap)
+			continue;
+
 		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
 						  le32_to_cpu(clc->len),
 						  GFP_KERNEL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 3f7187309513..abecaf897159 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -167,9 +167,12 @@ enum mt7925_eeprom_field {
 	MT_EE_CHIP_ID =		0x000,
 	MT_EE_VERSION =		0x002,
 	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_HW_TYPE =		0xa71,
 	__MT_EE_MAX =		0x9ff
 };
 
+#define MT_EE_HW_TYPE_ENCAP     GENMASK(1, 0)
+
 enum {
 	TXPWR_USER,
 	TXPWR_EEPROM,
-- 
2.34.1


