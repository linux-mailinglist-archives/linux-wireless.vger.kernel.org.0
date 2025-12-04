Return-Path: <linux-wireless+bounces-29498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD9CA2C36
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C42803006FDB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F132570A;
	Thu,  4 Dec 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahFW7BVM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D963254AD
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835910; cv=none; b=j17TlGM2MrjS3gMDoNFjnz9kvfdLYWC+U/dTrXVF8fRbQaxBP3Z//jiHV3z5lfjYt9j9EZAuL2lswLnL5wl8UJGdFxOCQMMiCQcGDrZvtgnvzaboQBV54sFhPn0cO7y/Rg0HKtC3nC7sS6debWtyiF9+oNLO4DezE02A+x8fcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835910; c=relaxed/simple;
	bh=kykoTyEvweJTm16xpQdKbqME0mmSqg6UDONuyX5nazg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JvV6k9u71/k7F2OtBXEG14XWX2iIFl59tJiLyKgfbzYYoYE/6vb+8b8D8empx9LT8u5VWO7zW40bgZOc9JLYrm+d1VK8/xy+cGSVcKXXPyHJ1OZ1td3OzHMt8xObdSAS380FR/P0Rt6He3wJ7aJp28QVoUFagC8c5Z+NQzMm1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahFW7BVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8309CC113D0;
	Thu,  4 Dec 2025 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835909;
	bh=kykoTyEvweJTm16xpQdKbqME0mmSqg6UDONuyX5nazg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ahFW7BVM67pBxrrVtQu3UpmLsaKRyo08zPS8Xa6A7IIraQO1nEb3DsJ0OrGMgkLEk
	 Ef9NgLw4B41lejEPnATK1BIPXXZNcU5LPYNDWvtLJHQ3/1/LDbd2n8qJqySADnpBnT
	 K+lUwEv3i8otpESo1sz2dyOsH2efsWS96OLJK7jPmK8dOUXP4uziciyXRjd4nK6Um5
	 uFFU/glImcSxxHsopwsNr2Aoc91KG8eMQhpbhtJNjcorNfas+Edrlpz6FFEFNi8XYl
	 qgpQ2czS7L+D0zOu1SYeT3ls7xAK7F4WMZKSpVt3RcbIYbMeUq2RGzMUH1UrwJWfh+
	 MAyGAllfo3kVg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:52 +0100
Subject: [PATCH mt76 10/11] wifi: mt76: mt7996: Integrate MT7996 init
 configuration for NPU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-10-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Add NPU integration in MT7996 init codebase for MT7996 chipset.
This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 03c1ccb49ef02ebe9c2ae91db836593e680ee2c0..526a2cb298fd7f9dc8d0fcdd8de0e4071c07338f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -592,7 +592,7 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 void mt7996_mac_init(struct mt7996_dev *dev)
 {
 #define HIF_TXD_V2_1	0x21
-	int i;
+	int i, rx_path_type;
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
 
@@ -606,11 +606,16 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 	}
 
 	/* rro module init */
-	if (dev->hif2)
+	if (dev->hif2) {
+		if (mt76_npu_device_active(&dev->mt76))
+			rx_path_type = is_mt7996(&dev->mt76) ? 6 : 8;
+		else
+			rx_path_type = is_mt7996(&dev->mt76) ? 2 : 7;
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE,
-				   is_mt7996(&dev->mt76) ? 2 : 7);
-	else
+				   rx_path_type);
+	} else {
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 0);
+	}
 
 	if (mt7996_has_hwrro(dev)) {
 		u16 timeout;

-- 
2.52.0


