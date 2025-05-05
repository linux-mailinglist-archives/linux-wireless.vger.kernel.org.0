Return-Path: <linux-wireless+bounces-22554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC0AAA8EA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66286188DEEA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2D355692;
	Mon,  5 May 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqV/T6pR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B95298986;
	Mon,  5 May 2025 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484891; cv=none; b=Q1vCKFTPxCI0V+U7nfXb1CzPb3gA1iQugZH1SsUmiLDKSfSW83QuIQAGXjQWG14u9vhGiLeqgc7qkEKEdww0vGbCL5YQ9U8CKQHMohnzP2NfvRmSix0p7H8EtT+yZY4rlTpIYUSarFwnFF8ey4BS/qKvsQ3LdbTOY2VwFE2fkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484891; c=relaxed/simple;
	bh=9DeJg9CppQMj+NGnrndh5RZJDAv4UH82hI7v1FLmCac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sib4dFxpAEBets2x+Dp/MO034bHXPTJYniUJyab53UyZUPETFVRDrsJHHSb2IyEPHwZ+z28El0qsAIybvY/O1xZijkM3Q9M+owd8sG753maP3b22CjdTjYc6RPMeOqQJQjsxh0qe9CDPzS+gL9cvt03iOwfvgrSpLpmMH3GhxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqV/T6pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B83C4CEE4;
	Mon,  5 May 2025 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484891;
	bh=9DeJg9CppQMj+NGnrndh5RZJDAv4UH82hI7v1FLmCac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqV/T6pRfqrStCuS4N5ul6i2vzb4EyWP5zF+FJSwNhU9KDJovsWJMOWPhVHnCw/8f
	 bRABLfAVNWxkeS7c7VGYWdf1T6l9Lf5Vp9HDfmOI7hZgan0RWfR2S1jgS6+qyKKyvn
	 rWHyVXfU8t9Qfj2oYnpgEF6s8JcscxU6kBqSbB2Y/Ymd0kekeVNhk93BWB0gF+C/Yr
	 8OAG9Y+PidUdrrzATXVN8gjVTYW/vWHErwtIAjOZC+rWwWfPxjOazYJ4e2m07aPDeT
	 C87TKK547ebLZaTMd3toBdx9cbt90MnWcm6vcDpaMqVAcjZ0+t6LkNoWUdcfUpNYpz
	 ovCqEGFVafcrg==
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
Subject: [PATCH AUTOSEL 6.12 063/486] wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
Date: Mon,  5 May 2025 18:32:19 -0400
Message-Id: <20250505223922.2682012-63-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 8476f9caa98db..5b14bf434df36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -616,6 +616,54 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 	return ret;
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
@@ -624,13 +672,20 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
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
@@ -675,6 +730,10 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
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
index df3c705d1cb3f..4ad779329b8f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -147,9 +147,12 @@ enum mt7925_eeprom_field {
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


