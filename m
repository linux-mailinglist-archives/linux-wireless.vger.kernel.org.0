Return-Path: <linux-wireless+bounces-27191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF8B501C2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B8B7A6741
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE61A294;
	Tue,  9 Sep 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAkL1shp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9432571C5
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432242; cv=none; b=H7CgYn1ynxCMtp9ZrFdYeWWF3ud7UjjIBImHRvwwSAMZGRC6WzaiHGK1Gjvh6BRdcawJr9ViQ4yK2c4M7xwRupzfsyU3TpRubXfDlTV5Sl7VDnnE30t0GhWA7iVNK4Gj23qS0bga3XPqgtH02g38DnQofCxHbHUqbh2PFp7Aj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432242; c=relaxed/simple;
	bh=vL/J10oKnTlXYI5PfdNKE9ajgEubHM/URGlubzfC7hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cSxkLBFa8i10PqQiuEW3ccLnNt0k6rLTQkSy18uZwuZWBdKcEVtG43ZiPHdWyeq6VQ5QSFm/lLR+p7ujNr4HVfKhm9hWB6Gmad7qDSDIaMckLLn2D3xAr6yRqKsxG2mWOoEOUks2JdWLp/QQl8Td9jpbF4G0YAoze811UpbJ/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAkL1shp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D59C4CEF4;
	Tue,  9 Sep 2025 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432240;
	bh=vL/J10oKnTlXYI5PfdNKE9ajgEubHM/URGlubzfC7hI=;
	h=From:Date:Subject:To:Cc:From;
	b=aAkL1shpFxDQJL4yKhLLjF5ueSGa7SoONAl/2lVLQ3nIOkt0xnKUphuRt9uXu99q5
	 bifMeKd5Wi+aIfMBXSpoE+RW3rh8JX40cxtXoPetVxD+3E1FE5LmPBaRYeEV7OxWyL
	 KtXNoEbuJNDrFVKgS4YGpe7hPJb/OFanvnuv5V/ahdAvMGz4Img1rODxhHs88pBr+5
	 PPSj+0FP1xN4NyIUFnqf1psy9qpLg9mHVWOxkJgb4kBC7i+TA+GdQQj4JxFrSN5QCh
	 b1yYjaC2Wtr1vTXL0TCH1j6kvcm9eD540ojl+i84Y8hTS/BAnxx0sFMXZligj47Q69
	 MuWGf02K199ag==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 17:37:12 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Add missing DMA sync for EAPOL
 frames
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-mlo-eapol-missing-dma-sync-v1-1-623924fdb875@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKdJwGgC/x3NTQqEMAxA4atI1gZqxZ94FZlF0agB20ojwwzi3
 S0uv817FygnYYWhuCDxV1RiyKjKAqbNhZVR5mywxjaGDKE/O6IW/R6R3RF39KIqYcXZO9R/mJB
 cVS9tY/uaCHLnSLzI732Mn/t+AP4Dvm5zAAAA
X-Change-ID: 20250909-mt7996-mlo-eapol-missing-dma-sync-9a13f6528399
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Add missing DMA sync before updating EAPOL frames 802.11 addresses.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 588f4aed31eda30aa48eeb06cfcbf36a0e147682..14c4c575a99895f6888a7bdb1353e05e84c8a3c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1067,6 +1067,9 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		if (!link_sta)
 			return -EINVAL;
 
+		dma_sync_single_for_cpu(mdev->dma_dev, tx_info->buf[1].addr,
+					tx_info->buf[1].len, DMA_TO_DEVICE);
+
 		memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
 		memcpy(hdr->addr2, link_conf->addr, ETH_ALEN);
 		if (ieee80211_has_a4(hdr->frame_control)) {
@@ -1077,6 +1080,9 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		} else if (ieee80211_has_fromds(hdr->frame_control)) {
 			memcpy(hdr->addr3, vif->addr, ETH_ALEN);
 		}
+
+		dma_sync_single_for_device(mdev->dma_dev, tx_info->buf[1].addr,
+					   tx_info->buf[1].len, DMA_TO_DEVICE);
 	}
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);

---
base-commit: b054061870ecbed6305c0f559ae90f459f17637d
change-id: 20250909-mt7996-mlo-eapol-missing-dma-sync-9a13f6528399

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


