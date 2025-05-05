Return-Path: <linux-wireless+bounces-22488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E22FAAA073
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92987A7E70
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614E290BD4;
	Mon,  5 May 2025 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaDe1SH3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB427BF7F;
	Mon,  5 May 2025 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483439; cv=none; b=h9UZz3B8JS4YZon1elrvEIe8qAPfX1WS1B19x+Y2/7oQ2dbcATHnjbZjJH4xuAnjUzAq87wY431d4qYYSIlcOim76xXKKA/CvXsGmyAFLQZlIy4Vz8qNrThPyL0//nDi0mn222iT/kPQkCDHesJSvCWL2CHtTtjuWU8YSUhHb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483439; c=relaxed/simple;
	bh=IlqHhMoVNSsEpLs7ZFQ/SXlJ5YBRv0SFN8gZMjZtb+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVTHlb5DpLhafJigCNVWTEE3I61G7WtQAlMTC8kWtr9i9v4Q8CDzCJyMR6KIMUp7+UwN+z4RH7+RENaCE6d60zLG5y5YcJPRZ+kzLOHhhkG7csML8J37eKGW8PtFbq72VD03neTBtGTah5B1Y7jg+Pp0CyKt+BlE/DExx5CjGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaDe1SH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3346C4CEE4;
	Mon,  5 May 2025 22:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483438;
	bh=IlqHhMoVNSsEpLs7ZFQ/SXlJ5YBRv0SFN8gZMjZtb+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaDe1SH32qtYPZmz2C+lLjAaK+uL7t8zpjEKywTXqcd25VisNY8BnnE+edJUAOwOC
	 IgNq6oeGZI21iHDxG3e8la+O9jLMDIzZQeWq7hYOkBU4qttkRIQemVOLJla+kLHi6b
	 lkPv32eCYq/58vlVcqvSy8pVQ+U3xacjs+rGKkaeFgDWegU9EHJWyDMgkWehhOHA+W
	 VZGLabo8iCAnbQdw/LKEMF/32n7PYjXoWN1vNDVR++3cNWFQHVj6xUtxFtbv/72rzK
	 oKa5PLDhthX5sSNFEV0hft/14Scb7/lDWv9MZSBsuRAnfHLl+gh4pZyl7lGWyEw8QI
	 bKKKTDuaGuhtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	quan.zhou@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 080/642] wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
Date: Mon,  5 May 2025 18:04:56 -0400
Message-Id: <20250505221419.2672473-80-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit f2027ef3f733d3f0bb7f27fa3343784058f946ab ]

Read the EEPROM to determine the hardware type and uses this to load the
correct CLC data.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250304113649.867387-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 61 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 +
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b8cd7cd3d832b..a1d6fd5888f54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -631,6 +631,54 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
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
+	} __packed *res;
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
@@ -639,13 +687,20 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt792x_phy *phy = &dev->phy;
 	const struct firmware *fw;
+	u8 *clc_base = NULL, hw_encap = 0;
 	int ret, i, len, offset = 0;
-	u8 *clc_base = NULL;
 
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
@@ -690,6 +745,10 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
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
index cb7b1a49fbd14..073e433069e0e 100644
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
2.39.5


