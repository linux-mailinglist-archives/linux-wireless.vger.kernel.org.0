Return-Path: <linux-wireless+bounces-29744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46581CBCA6D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 07:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABDD63003DA0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F62F0C7A;
	Mon, 15 Dec 2025 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lYs1a5n2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3430BB83
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780691; cv=none; b=kEk/CffxiX33Vbu3R19Ob7rAOTLB3KIopXztV2ontHnjIPOXsMx59BZO9VTMKbUMiG/5PK6501iVIS+1EOHKcaJ4enlzWZuBxfnpQaVm35KDQsulMl1jNh9ZNK2rtw0bWEswUNr/emGvadepDsjCzSbMdrsiYaGsqW2E7lPSGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780691; c=relaxed/simple;
	bh=cNmAHWJq+CZkUSDKCTAy3CVWcj16qPZmYpwPvewNG3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elTYvjf51gaXB6x0zDh2j2cOFh1XUJX7iriP3nkmlunNQj18GXvQ16MRAowlKiIs9XfzImIKpRSE7gllxRdDaPVa2CfQ/9ic4HNrSFKIizepLeXuBeD+3VDDJvKtFWT4U2abSuByyVvVnsT0r3LD4YVNK59FjJ4gSoy8ighwTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lYs1a5n2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9a0e2a72d98011f0b33aeb1e7f16c2b6-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/0QW/WOwixG7uNjSISZhXX/ISVNhYuKWIj8yZSaimMg=;
	b=lYs1a5n2dd5x3LLIzGJOVR7Gu21cVrqPmhmZJmjUg/SdBABf6Lp4BNbNVJHDzHqLEubEX9C8b3xlrsnNiOiCUKE8Uh2oIAFoJJA6NpbsWPXDyNseWmzukzOH61nma5/rNDthtnRDNJ4bTP7Z8aDrdGPOPdRRuHqpMv+ALs6jVig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:80d48889-aec6-40a7-bf0c-8a5a1e69caff,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:709d32aa-6421-45b1-b8b8-e73e3dc9a90f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9a0e2a72d98011f0b33aeb1e7f16c2b6-20251215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2097850238; Mon, 15 Dec 2025 14:38:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 14:38:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 14:37:59 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 6/7] wifi: mt76: mt7996: add duplicated WTBL command
Date: Mon, 15 Dec 2025 14:37:27 +0800
Message-ID: <20251215063728.3013365-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251215063728.3013365-1-shayne.chen@mediatek.com>
References: <20251215063728.3013365-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This is a firmware mechanism to improve packet loss issues for mt7996 and
mt7992 chipsets.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  3 +++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 25 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  5 ++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 00a8286bd136..7e8bd3b142e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -756,6 +756,9 @@ static void mt7996_init_work(struct work_struct *work)
 	mt7996_mcu_set_eeprom(dev);
 	mt7996_mac_init(dev);
 	mt7996_txbf_init(dev);
+
+	if (!is_mt7990(&dev->mt76))
+		mt7996_mcu_set_dup_wtbl(dev);
 }
 
 void mt7996_wfsys_reset(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 73c3741b532e..97b8d6dfd602 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4031,7 +4031,6 @@ int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num)
 
 int mt7996_mcu_get_chip_config(struct mt7996_dev *dev, u32 *cap)
 {
-#define NIC_CAP	3
 #define UNI_EVENT_CHIP_CONFIG_EFUSE_VERSION	0x21
 	struct {
 		u8 _rsv[4];
@@ -4039,7 +4038,7 @@ int mt7996_mcu_get_chip_config(struct mt7996_dev *dev, u32 *cap)
 		__le16 tag;
 		__le16 len;
 	} __packed req = {
-		.tag = cpu_to_le16(NIC_CAP),
+		.tag = cpu_to_le16(UNI_CHIP_CONFIG_NIC_CAPA),
 		.len = cpu_to_le16(sizeof(req) - 4),
 	};
 	struct sk_buff *skb;
@@ -5046,3 +5045,25 @@ int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_EXT_CMD(CP_SUPPORT),
 				 &cp_mode, sizeof(cp_mode), true);
 }
+
+int mt7996_mcu_set_dup_wtbl(struct mt7996_dev *dev)
+{
+#define DUP_WTBL_NUM	80
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		__le16 base;
+		__le16 num;
+		u8 _rsv2[4];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_CHIP_CONFIG_DUP_WTBL),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.base = cpu_to_le16(MT7996_WTBL_STA - DUP_WTBL_NUM + 1),
+		.num = cpu_to_le16(DUP_WTBL_NUM),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(CHIP_CONFIG), &req,
+				 sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 1283beb0dc19..de14394bec22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -798,6 +798,11 @@ enum {
 	UNI_CHANNEL_RX_PATH,
 };
 
+enum {
+	UNI_CHIP_CONFIG_NIC_CAPA = 3,
+	UNI_CHIP_CONFIG_DUP_WTBL = 4,
+};
+
 #define MT7996_BSS_UPDATE_MAX_SIZE	(sizeof(struct bss_req_hdr) +		\
 					 sizeof(struct mt76_connac_bss_basic_tlv) +	\
 					 sizeof(struct bss_rlm_tlv) +		\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 8f1043159f58..f850be874b1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -748,6 +748,7 @@ void mt7996_mcu_exit(struct mt7996_dev *dev);
 int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled);
+int mt7996_mcu_set_dup_wtbl(struct mt7996_dev *dev);
 
 static inline bool mt7996_has_hwrro(struct mt7996_dev *dev)
 {
-- 
2.51.0


