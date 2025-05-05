Return-Path: <linux-wireless+bounces-22489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E5AAA07D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273BF1A83461
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32F2918D3;
	Mon,  5 May 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr2Lmw5V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC022918CE;
	Mon,  5 May 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483441; cv=none; b=m6dT85m/SYwFf8IGquHghnAkKPqs15pZ//C897/BWodFJT3nVAXmwchauCz/ehx1BfB162BX8bl3mREkCkhj10eVfpnyMfNN3LPUOtsap8SEShNT3Yv4ls/Cc0vlYzHjrJR+j+y4sacMfREzwIF3o6BSiyDUAWOsKEFtKwu98Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483441; c=relaxed/simple;
	bh=8/CPWEEQk1DitVDeq0Z4n2Umc68X/nb607AcPQgPx9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SN7HS29TJbhWsgcCWYvXyXFgUk7GUdGaaPPqunhg+U4n5SyA9tQgGJqEs2TF/M7xeedrceV3a3Sbpa5NG2JRc2YzbIIh4H6UlyjUlfWJ29vIEq2mJNOEQLJ7dWo8NePvEG8O2021KrWSXCUcLyTorJfmd1ZwSZ/ohXndOZOEUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr2Lmw5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7B5C4CEE4;
	Mon,  5 May 2025 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483441;
	bh=8/CPWEEQk1DitVDeq0Z4n2Umc68X/nb607AcPQgPx9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr2Lmw5Vq5w5jI+oEruAoy08NZ7MnfHILl75THT68ioxweck1DVBWYwfF5t1jXCCb
	 ctn8yJz8YpqPOkvhZPZ8C4zWnOvYM2DB63lR36NjWgjWbaT+dd2gNYJSBFpcBw2G37
	 sc7kaiI4w22QKdNpxo/xfro/rlpsVB9/a96y1WlsAhfRymGbAocG+QFaFvtKlxbm0s
	 6NpSTxQmP8W3mj6s+LYmz/KuhiUZi2vk9P1Ss0X9onAM22z0BwIH5OgiDcBiKufJD2
	 hp8wBXAXwjY69f1R/dkjP6mzHjvB9qlf9MySC7FWpi5NlqzO6LMW/UUC22LNvSvpP5
	 5jaipAPdSu1XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Zhou <quan.zhou@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sean.wang@mediatek.com,
	mingyen.hsieh@mediatek.com,
	deren.wu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 081/642] wifi: mt76: mt7925: Simplify HIF suspend handling to avoid suspend fail
Date: Mon,  5 May 2025 18:04:57 -0400
Message-Id: <20250505221419.2672473-81-sashal@kernel.org>
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

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit bf39813599b0375a3eebbbc6837f728554b3883a ]

System suspend failures may occur due to inappropriate
handling of traffic not idle event by the WiFi driver.
The WiFi firmware's traffic not idle indication does
not need to be tied to suspend. Fix the flow to ensuring
the system can suspend properly.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Link: https://patch.msgid.link/34208c7280325f57a651363d339399eb1744d3b7.1740400998.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a1d6fd5888f54..e6d053c0cdbd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -348,14 +348,10 @@ mt7925_mcu_handle_hif_ctrl_basic(struct mt792x_dev *dev, struct tlv *tlv)
 	basic = (struct mt7925_mcu_hif_ctrl_basic_tlv *)tlv;
 
 	if (basic->hifsuspend) {
-		if (basic->hif_tx_traffic_status == HIF_TRAFFIC_IDLE &&
-		    basic->hif_rx_traffic_status == HIF_TRAFFIC_IDLE)
-			/* success */
-			dev->hif_idle = true;
-		else
-			/* busy */
-			/* invalid */
-			dev->hif_idle = false;
+		dev->hif_idle = true;
+		if (!(basic->hif_tx_traffic_status == HIF_TRAFFIC_IDLE &&
+		      basic->hif_rx_traffic_status == HIF_TRAFFIC_IDLE))
+			dev_info(dev->mt76.dev, "Hif traffic not idle.\n");
 	} else {
 		dev->hif_resumed = true;
 	}
-- 
2.39.5


