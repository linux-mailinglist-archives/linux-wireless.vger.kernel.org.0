Return-Path: <linux-wireless+bounces-31761-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDabJeKXjWkt5AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31761-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:05:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8360812BB46
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B86903028E46
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09052D6E78;
	Thu, 12 Feb 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JDkjxnHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A93EBF3C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887134; cv=none; b=cZqV0oBv4y6e8nSPjeHFdbI62gawdNzf4jKOggE2k8rLN19/VW3IEoQ4PQqOiu0ZTTEMZaiw96+vj0tjJgqZQZEve2aEbv7OMJB72+FRLDEyJsa3MOsi9sQ5xYBDqzLTxfVAqEyAZkiXWY3Y7XT4yJ+HhF5YrRnyHL0CrBc9HV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887134; c=relaxed/simple;
	bh=zQRMVprq+hhlPiiXPwHXJaLsq3/auCBMd8TtQ+zYueM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIvHeGoCoaL+d5jUXStLp5x4jVNUfvyxS/nJDz+bzTsxnU9XipeMVSPpUdLIj8eMUIA9/8HK+KVWH3lvq1/LJdm20iOwNFg6xw9j48TSC93m3q0xz8M5ZXvQGxPP/kw79yWK4m3jsnegeICU/W67ks564izJfvJEZYNTDrUPF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JDkjxnHh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f7dbb63e07f111f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+lJekS6s5Ztn15eyMG3EZaQrgzdtK7QJJeUMGyzfKT8=;
	b=JDkjxnHhsDhmuD85aQbuUpayj3xa1KZFHzi9Ew0r5wQEvXgcrCeOikl3ZZ3EkOh7CJK3+HdFp97UTWaR/MjhmKaA2ZyU2rVl1NlF5+wdXoXpgbQqqq/X1qqIs5I9lDrjXPklaysEKMZZuBVoqTjt7EeVPFOIGsJt7xFyWASyJ+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:10aac92e-695a-40df-8a1d-bc1d31b9bdbe,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:3b9b9ae9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f7dbb63e07f111f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1338026612; Thu, 12 Feb 2026 17:05:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 17:05:23 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 17:05:23 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Elwin Huang <s09289728096@gmail.com>, Shayne
 Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 1/3] wifi: mt76: add external EEPROM support for mt799x chipsets
Date: Thu, 12 Feb 2026 17:03:08 +0800
Message-ID: <20260212090310.3335392-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31761-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mediatek.com,lists.infradead.org,gmail.com];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: 8360812BB46
X-Rspamd-Action: no action

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

For the MT7992 and MT7990 chipsets, efuse mode is not supported because
there is insufficient space in the efuse to store the calibration data.
Therefore, an additional on-chip EEPROM is added to address this
limitation.

Co-developed-by: Elwin Huang <s09289728096@gmail.com>
Signed-off-by: Elwin Huang <s09289728096@gmail.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../wireless/mediatek/mt76/mt7996/eeprom.c    | 59 +++++++------
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 83 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 43 +++++++++-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 20 ++++-
 6 files changed, 148 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f44977f9093d..e91966cd5efe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1308,6 +1308,7 @@ enum {
 	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
 	MCU_UNI_CMD_ALL_STA_INFO = 0x6e,
 	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
+	MCU_UNI_CMD_EXT_EEPROM_CTRL = 0x74,
 	MCU_UNI_CMD_RADIO_STATUS = 0x80,
 	MCU_UNI_CMD_SDO = 0x88,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 8f60772913b4..00c72be8498f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -153,7 +153,7 @@ mt7996_eeprom_check_or_use_default(struct mt7996_dev *dev, bool use_default)
 
 	dev_warn(dev->mt76.dev, "eeprom load fail, use default bin\n");
 	memcpy(eeprom, fw->data, MT7996_EEPROM_SIZE);
-	dev->flash_mode = true;
+	dev->eeprom_mode = EEPROM_MODE_DEFAULT_BIN;
 
 out:
 	release_firmware(fw);
@@ -163,26 +163,31 @@ mt7996_eeprom_check_or_use_default(struct mt7996_dev *dev, bool use_default)
 
 static int mt7996_eeprom_load(struct mt7996_dev *dev)
 {
+	u32 eeprom_blk_size, block_num;
 	bool use_default = false;
-	int ret;
+	int ret, i;
 
 	ret = mt76_eeprom_init(&dev->mt76, MT7996_EEPROM_SIZE);
 	if (ret < 0)
 		return ret;
 
 	if (ret && !mt7996_check_eeprom(dev)) {
-		dev->flash_mode = true;
+		dev->eeprom_mode = EEPROM_MODE_FLASH;
 		goto out;
 	}
 
-	if (!dev->flash_mode) {
-		u32 eeprom_blk_size = MT7996_EEPROM_BLOCK_SIZE;
-		u32 block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, eeprom_blk_size);
+	memset(dev->mt76.eeprom.data, 0, MT7996_EEPROM_SIZE);
+	if (mt7996_has_ext_eeprom(dev)) {
+		/* external eeprom mode */
+		dev->eeprom_mode = EEPROM_MODE_EXT;
+		eeprom_blk_size = MT7996_EXT_EEPROM_BLOCK_SIZE;
+	} else {
 		u8 free_block_num;
-		int i;
 
-		memset(dev->mt76.eeprom.data, 0, MT7996_EEPROM_SIZE);
-		ret = mt7996_mcu_get_eeprom_free_block(dev, &free_block_num);
+		/* efuse mode */
+		dev->eeprom_mode = EEPROM_MODE_EFUSE;
+		eeprom_blk_size = MT7996_EEPROM_BLOCK_SIZE;
+		ret = mt7996_mcu_get_efuse_free_block(dev, &free_block_num);
 		if (ret < 0)
 			return ret;
 
@@ -191,27 +196,29 @@ static int mt7996_eeprom_load(struct mt7996_dev *dev)
 			use_default = true;
 			goto out;
 		}
+	}
+
+	/* check if eeprom data from fw is valid */
+	if (mt7996_mcu_get_eeprom(dev, 0, NULL, eeprom_blk_size,
+				  dev->eeprom_mode) ||
+	    mt7996_check_eeprom(dev)) {
+		use_default = true;
+		goto out;
+	}
+
+	/* read eeprom data from fw */
+	block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, eeprom_blk_size);
+	for (i = 1; i < block_num; i++) {
+		u32 len = eeprom_blk_size;
 
-		/* check if eeprom data from fw is valid */
-		if (mt7996_mcu_get_eeprom(dev, 0, NULL, 0) ||
-		    mt7996_check_eeprom(dev)) {
+		if (i == block_num - 1)
+			len = MT7996_EEPROM_SIZE % eeprom_blk_size;
+		ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size,
+					    NULL, len, dev->eeprom_mode);
+		if (ret && ret != -EINVAL) {
 			use_default = true;
 			goto out;
 		}
-
-		/* read eeprom data from fw */
-		for (i = 1; i < block_num; i++) {
-			u32 len = eeprom_blk_size;
-
-			if (i == block_num - 1)
-				len = MT7996_EEPROM_SIZE % eeprom_blk_size;
-			ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size,
-						    NULL, len);
-			if (ret && ret != -EINVAL) {
-				use_default = true;
-				goto out;
-			}
-		}
 	}
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 2937e89ad0c9..1fab04909831 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1207,7 +1207,8 @@ static int mt7996_variant_fem_init(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7996_mcu_get_eeprom(dev, MT7976C_EFUSE_OFFSET, buf, sizeof(buf));
+	ret = mt7996_mcu_get_eeprom(dev, MT7976C_EFUSE_OFFSET, buf, sizeof(buf),
+				    EEPROM_MODE_EFUSE);
 	if (ret && ret != -EINVAL)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 9ccf9f97c984..46099486ec09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3950,7 +3950,7 @@ static int mt7996_mcu_set_eeprom_flash(struct mt7996_dev *dev)
 #define MAX_PAGE_IDX_MASK	GENMASK(7, 5)
 #define PAGE_IDX_MASK		GENMASK(4, 2)
 #define PER_PAGE_SIZE		0x400
-	struct mt7996_mcu_eeprom req = {
+	struct mt7996_mcu_eeprom_update req = {
 		.tag = cpu_to_le16(UNI_EFUSE_BUFFER_MODE),
 		.buffer_mode = EE_MODE_BUFFER
 	};
@@ -3992,57 +3992,80 @@ static int mt7996_mcu_set_eeprom_flash(struct mt7996_dev *dev)
 
 int mt7996_mcu_set_eeprom(struct mt7996_dev *dev)
 {
-	struct mt7996_mcu_eeprom req = {
+	struct mt7996_mcu_eeprom_update req = {
 		.tag = cpu_to_le16(UNI_EFUSE_BUFFER_MODE),
 		.len = cpu_to_le16(sizeof(req) - 4),
 		.buffer_mode = EE_MODE_EFUSE,
 		.format = EE_FORMAT_WHOLE
 	};
 
-	if (dev->flash_mode)
+	if (dev->eeprom_mode != EEPROM_MODE_EFUSE)
 		return mt7996_mcu_set_eeprom_flash(dev);
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(EFUSE_CTRL),
 				 &req, sizeof(req), true);
 }
 
-int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len)
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len,
+			  enum mt7996_eeprom_mode mode)
 {
-	struct {
-		u8 _rsv[4];
-
-		__le16 tag;
-		__le16 len;
-		__le32 addr;
-		__le32 valid;
-		u8 data[16];
-	} __packed req = {
-		.tag = cpu_to_le16(UNI_EFUSE_ACCESS),
-		.len = cpu_to_le16(sizeof(req) - 4),
-		.addr = cpu_to_le32(round_down(offset,
-				    MT7996_EEPROM_BLOCK_SIZE)),
+	struct mt7996_mcu_eeprom_access req = {
+		.info.len = cpu_to_le16(sizeof(req) - 4),
 	};
+	struct mt7996_mcu_eeprom_access_event *event;
 	struct sk_buff *skb;
-	bool valid;
-	int ret;
+	int ret, cmd;
+	u32 addr;
+
+	switch (mode) {
+	case EEPROM_MODE_EFUSE:
+		addr = round_down(offset, MT7996_EEPROM_BLOCK_SIZE);
+		cmd = MCU_WM_UNI_CMD_QUERY(EFUSE_CTRL);
+		req.info.tag = cpu_to_le16(UNI_EFUSE_ACCESS);
+		break;
+	case EEPROM_MODE_EXT:
+		addr = round_down(offset, MT7996_EXT_EEPROM_BLOCK_SIZE);
+		cmd = MCU_WM_UNI_CMD_QUERY(EXT_EEPROM_CTRL);
+		req.info.tag = cpu_to_le16(UNI_EXT_EEPROM_ACCESS);
+		req.eeprom.ext_eeprom.data_len = cpu_to_le32(buf_len);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
-					MCU_WM_UNI_CMD_QUERY(EFUSE_CTRL),
-					&req, sizeof(req), true, &skb);
+	req.info.addr = cpu_to_le32(addr);
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, cmd, &req, sizeof(req),
+					true, &skb);
 	if (ret)
 		return ret;
 
-	valid = le32_to_cpu(*(__le32 *)(skb->data + 16));
-	if (valid) {
-		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
+	event = (struct mt7996_mcu_eeprom_access_event *)skb->data;
+	if (event->valid) {
+		u32 ret_len = le32_to_cpu(event->eeprom.ext_eeprom.data_len);
+
+		addr = le32_to_cpu(event->addr);
 
 		if (!buf)
 			buf = (u8 *)dev->mt76.eeprom.data + addr;
-		if (!buf_len || buf_len > MT7996_EEPROM_BLOCK_SIZE)
-			buf_len = MT7996_EEPROM_BLOCK_SIZE;
 
-		skb_pull(skb, 48);
-		memcpy(buf, skb->data, buf_len);
+		switch (mode) {
+		case EEPROM_MODE_EFUSE:
+			if (!buf_len || buf_len > MT7996_EEPROM_BLOCK_SIZE)
+				buf_len = MT7996_EEPROM_BLOCK_SIZE;
+
+			memcpy(buf, event->eeprom.efuse, buf_len);
+			break;
+		case EEPROM_MODE_EXT:
+			if (!buf_len || buf_len > MT7996_EXT_EEPROM_BLOCK_SIZE)
+				buf_len = MT7996_EXT_EEPROM_BLOCK_SIZE;
+
+			memcpy(buf, event->eeprom.ext_eeprom.data,
+			       ret_len < buf_len ? ret_len : buf_len);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 	} else {
 		ret = -EINVAL;
 	}
@@ -4052,7 +4075,7 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_l
 	return ret;
 }
 
-int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num)
+int mt7996_mcu_get_efuse_free_block(struct mt7996_dev *dev, u8 *block_num)
 {
 	struct {
 		u8 _rsv[4];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index d70540982983..39df13679779 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -145,7 +145,7 @@ struct mt7996_mcu_background_chain_ctrl {
 	u8 rsv[2];
 } __packed;
 
-struct mt7996_mcu_eeprom {
+struct mt7996_mcu_eeprom_update {
 	u8 _rsv[4];
 
 	__le16 tag;
@@ -155,6 +155,43 @@ struct mt7996_mcu_eeprom {
 	__le16 buf_len;
 } __packed;
 
+union eeprom_data {
+	struct {
+		__le32 data_len;
+		DECLARE_FLEX_ARRAY(u8, data);
+	} ext_eeprom;
+	DECLARE_FLEX_ARRAY(u8, efuse);
+} __packed;
+
+struct mt7996_mcu_eeprom_info {
+	u8 _rsv[4];
+
+	__le16 tag;
+	__le16 len;
+	__le32 addr;
+	__le32 valid;
+} __packed;
+
+struct mt7996_mcu_eeprom_access {
+	struct mt7996_mcu_eeprom_info info;
+	union eeprom_data eeprom;
+} __packed;
+
+struct mt7996_mcu_eeprom_access_event {
+	u8 _rsv[4];
+
+	__le16 tag;
+	__le16 len;
+	__le32 version;
+	__le32 addr;
+	__le32 valid;
+	__le32 size;
+	__le32 magic_no;
+	__le32 type;
+	__le32 rsv[4];
+	union eeprom_data eeprom;
+} __packed;
+
 struct mt7996_mcu_phy_rx_info {
 	u8 category;
 	u8 rate;
@@ -875,6 +912,10 @@ enum {
 	UNI_EFUSE_BUFFER_RD,
 };
 
+enum {
+	UNI_EXT_EEPROM_ACCESS = 1,
+};
+
 enum {
 	UNI_VOW_DRR_CTRL,
 	UNI_VOW_RX_AT_AIRTIME_EN = 0x0b,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 3ff730e36fa6..ea1f656a9334 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -85,6 +85,7 @@
 
 #define MT7996_EEPROM_SIZE		7680
 #define MT7996_EEPROM_BLOCK_SIZE	16
+#define MT7996_EXT_EEPROM_BLOCK_SIZE	1024
 #define MT7996_TOKEN_SIZE		16384
 #define MT7996_HW_TOKEN_SIZE		8192
 
@@ -169,6 +170,13 @@ enum mt7996_fem_type {
 	MT7996_FEM_MIX,
 };
 
+enum mt7996_eeprom_mode {
+	EEPROM_MODE_DEFAULT_BIN,
+	EEPROM_MODE_EFUSE,
+	EEPROM_MODE_FLASH,
+	EEPROM_MODE_EXT,
+};
+
 enum mt7996_txq_id {
 	MT7996_TXQ_FWDL = 16,
 	MT7996_TXQ_MCU_WM,
@@ -441,7 +449,7 @@ struct mt7996_dev {
 
 	u32 hw_pattern;
 
-	bool flash_mode:1;
+	u8 eeprom_mode;
 	bool has_eht:1;
 
 	struct {
@@ -717,8 +725,9 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct mt7996_sta *msta,
 			       void *data, u8 link_id, u32 field);
 int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
-int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len);
-int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len,
+			  enum mt7996_eeprom_mode mode);
+int mt7996_mcu_get_efuse_free_block(struct mt7996_dev *dev, u8 *block_num);
 int mt7996_mcu_get_chip_config(struct mt7996_dev *dev, u32 *cap);
 int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 set, u8 band);
 int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action);
@@ -816,6 +825,11 @@ static inline bool mt7996_has_wa(struct mt7996_dev *dev)
 	return !is_mt7990(&dev->mt76);
 }
 
+static inline bool mt7996_has_ext_eeprom(struct mt7996_dev *dev)
+{
+	return !is_mt7996(&dev->mt76);
+}
+
 void mt7996_mac_init(struct mt7996_dev *dev);
 u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
-- 
2.51.0


