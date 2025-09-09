Return-Path: <linux-wireless+bounces-27169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC313B4A8D3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDAA1885557
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F282D0C97;
	Tue,  9 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmYn9oaw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402492BF01E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411153; cv=none; b=o3Of+7hRRisHHCzZ+e6QFwDSv3bQMo67PV6zGhbEPIl6orsh0OgQjvkFvaWcYlzFE6svFO6MmI3QkHloPR9f8U/cwWutEmHdNhHzzZRkQ0JGkd5TrwLvHJheKJVrTC2xZ/qrb41eBiE9zoJ1IzXAnRfkbjK2ftxziiGdmPVPtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411153; c=relaxed/simple;
	bh=1Vav5//DSHKxmGTaOnbQqVFRjxjXuYDhPgQlOA2KQrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyECrbKvr187/L9N1XwFskMRIZtI9KhSUDaSAgT2yNJRqWIzsO/jZ+85/K13N+/oLTPCUjHxh6K2X8Mxcbg9YGBGSS85W+w7MJMjsrnNJvh5Gde1Sum1cnpmeBRRzexS7KdpbSmvn9MhkVaORWOMs+uWxHl+CljE8+2eTeyYiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmYn9oaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5084C4CEF5;
	Tue,  9 Sep 2025 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411153;
	bh=1Vav5//DSHKxmGTaOnbQqVFRjxjXuYDhPgQlOA2KQrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fmYn9oaw1haf/I1D6dB5JgOqe1RvR052o+vz9sTVcZadbeEO2BDoWRB323tN3Q0vO
	 AZUkcPWvxA6Fqf95DTlCMLKR+Ic9CqS2QTKkiDnaBBBTPhvNp6au8B4n1nko2pyk2J
	 +mGnnVN8wRYqnqf7ZzEz1zA53AxN6OHFxfNJSG76wydZophoDtC/K2u+oflzQt/TLD
	 pG5cAjynO2SR/nXaYbfMX8TQj1Kvx7DRz8Q2IMT/EM1lGNX96NoXZ5X5urbtwfwfJD
	 b01KI27Ezss6KeZJI0+YHwra+Cc8Gs2s5Jqjpb9vUJ2jDCZiNqhW4p2Pnqvd3A0Jv9
	 uLHLRcfiCQC1w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:19 +0200
Subject: [PATCH mt76 v5 11/16] wifi: mt76: mt7996: Convert
 mt7996_wed_rro_addr to LE
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-11-7d66f6eb7795@kernel.org>
References: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
In-Reply-To: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Do not use bitmask in mt7996_wed_rro_addr DMA descriptor in order to not
break endianness

Fixes: 950d0abb5cd94 ("wifi: mt76: mt7996: add wed rx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 11 +++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 0104b50ce3f6d52d762dc2f87e5caa5d36ce69b8..f70e24d989cbd0454fa4f9273c87057258ded0f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -852,6 +852,7 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	u32 val = FIELD_PREP(WED_RRO_ADDR_SIGNATURE_MASK, 0xff);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct mt7996_wed_rro_addr *addr;
 	void *ptr;
@@ -890,7 +891,7 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 
 		addr = dev->wed_rro.addr_elem[i].ptr;
 		for (j = 0; j < MT7996_RRO_WINDOW_MAX_SIZE; j++) {
-			addr->signature = 0xff;
+			addr->data = cpu_to_le32(val);
 			addr++;
 		}
 
@@ -922,7 +923,7 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 	dev->wed_rro.session.ptr = ptr;
 	addr = dev->wed_rro.session.ptr;
 	for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
-		addr->signature = 0xff;
+		addr->data = cpu_to_le32(val);
 		addr++;
 	}
 
@@ -990,6 +991,7 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 static void mt7996_wed_rro_work(struct work_struct *work)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	u32 val = FIELD_PREP(WED_RRO_ADDR_SIGNATURE_MASK, 0xff);
 	struct mt7996_dev *dev;
 	LIST_HEAD(list);
 
@@ -1026,7 +1028,7 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 				MT7996_RRO_WINDOW_MAX_LEN;
 reset:
 			elem = ptr + elem_id * sizeof(*elem);
-			elem->signature = 0xff;
+			elem->data |= cpu_to_le32(val);
 		}
 		mt7996_mcu_wed_rro_reset_sessions(dev, e->id);
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index f6dfd36a44c0bf587d3ac85a5a9d38e24deb14d4..313f6923d071a71152cadceaaf09dfd80b005287 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -285,13 +285,12 @@ struct mt7996_hif {
 	enum pcie_link_width width;
 };
 
+#define WED_RRO_ADDR_SIGNATURE_MASK	GENMASK(31, 24)
+#define WED_RRO_ADDR_COUNT_MASK		GENMASK(14, 4)
+#define WED_RRO_ADDR_HEAD_HIGH_MASK	GENMASK(3, 0)
 struct mt7996_wed_rro_addr {
-	u32 head_low;
-	u32 head_high : 4;
-	u32 count: 11;
-	u32 oor: 1;
-	u32 rsv : 8;
-	u32 signature : 8;
+	__le32 head_low;
+	__le32 data;
 };
 
 struct mt7996_wed_rro_session_id {

-- 
2.51.0


