Return-Path: <linux-wireless+bounces-29493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F8CA2C42
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D37A306B14D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236F279DC0;
	Thu,  4 Dec 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZwzHcYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E010308F05
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835897; cv=none; b=NRvoyNptErT9iybsZdvRjAhD0JWopeaTFar1wqjsWb7a79TSl3oTKCxv22OzhgNfPvrmLP8/vBQ0OuOfDHl+3n+wx05AVao7dOIdNaV5udLfHg56Fpk+JxBb2yE+NbraDxJueI+QsAdpvBRFzHwDlZ3LuD6yqyKI5rIKfCUaZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835897; c=relaxed/simple;
	bh=jKQob5kGhPU6k1EDWVJHsm1KE/0se8/FjngsbWMsNWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dsb1w/UloOTynnKrOumAEQemWRVu0HxnzkVkLTY/sOFzn6nF4N+fHIUbe2XcOXHcmu5gKbm85EvP/OgTK4k4SoheWEb3mkRnprvB2H0zznvc9RHi5G0HvhpgvB0xRsBNu2Z3XcyB6NzB5hfpyfP6nw36hC1IP4EOhkLbKSqdewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZwzHcYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92391C4CEFB;
	Thu,  4 Dec 2025 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835896;
	bh=jKQob5kGhPU6k1EDWVJHsm1KE/0se8/FjngsbWMsNWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BZwzHcYqEX41azFTRd4HvbwGo/xKXk1ke2SjahvGzvsnx0BMnsBMIGOMqo1aZOV0Q
	 U2dzV0+Hul1P4wYy09270wopWqh/KWLpUm1v7b2fgmFTaESC6VN+PaeB7AftXPgX3B
	 GwyHCmw0AG2UCeLOn/DFYmIfp7JcAtnvDJnq3GbF1pMxnArZAhfZDk4UecQw8IYQfg
	 X5bm5S9r/QLWrrq8n2Ycgiz7PcVGLwMYwp3Iov7900usv2CndM+dOd+R9hVONC6Yvv
	 qpVIh41Mbe70ZWeqcX5GdAf4dneqlULcMFAoukX9i7j3ZwQ+5T0jCmpwM86zaSphc0
	 84Tw1NSR1+f3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:47 +0100
Subject: [PATCH mt76 05/11] wifi: mt76: mt7996: Fix wdma_idx for MT7996
 device if NPU is enabled
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-5-7819c52c0893@kernel.org>
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

This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index beed795edb24c67e1b7b44fe87fd5de125a21d94..d9df3a72f4ef8170722cca626538ea526c04781b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2204,6 +2204,10 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 		path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	else
 #endif
+	if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76) &&
+	    msta_link->wcid.phy_idx == MT_BAND2)
+		path->mtk_wdma.wdma_idx = 1;
+	else
 		path->mtk_wdma.wdma_idx = link->mt76.band_idx;
 	path->mtk_wdma.bss = link->mt76.idx;
 	path->mtk_wdma.queue = 0;

-- 
2.52.0


