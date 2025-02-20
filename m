Return-Path: <linux-wireless+bounces-19201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E25A3DB2D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253B63B628E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349751F91FE;
	Thu, 20 Feb 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxCdcgcY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022A1F91D6
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057555; cv=none; b=iVHymJqnubhWblQbYzCcjxaWPqJ1L1Q4HEA4Hk8ZQ6oBL3pmtU3ssE26YjRj+Kdu6XXZBLukITmt/gZpJQ2huVMVz/JouMelKZdI0ToeabGiiNG7WV0EbRfqtNcoRrRQJCre/bdDShE4UQZ72oHKmFMlvE7K5UhJeNvWg+IHcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057555; c=relaxed/simple;
	bh=Q55FloXfLGhRafuisEE3Xol2q+krOa8epD0FSmkkY1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzHOvUSam+NZIDVcGSzNuaIY4EXAk0G/DrvCDCtcWZ2t4aG8UMD+xm0veRdxe2dDsfobnhzopjlHEs5LEO8UOdp1LlYDovC87VeTYlEDOv/+AgZUUIpAZok19O4efXnN+NYyHqru+m39vJc4bwpmA+bQ50Ktp8QxGj5nhKjmtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxCdcgcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C777C4CED1;
	Thu, 20 Feb 2025 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057554;
	bh=Q55FloXfLGhRafuisEE3Xol2q+krOa8epD0FSmkkY1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AxCdcgcYMeP3a+Idty9oTp4RAno+ZtY/HpOjnXnNArBiV5QhEyj6Bl+KumXwe9F8e
	 xaUuhvD2+n0ikEESnYOtWMDDkVo/AT6oVUgQJ71TLOnOn+mYdBcikHCurnIoXpCKjd
	 Z407U8Tbbl26/SGuDhUofWjqcs/ktgSbWanuNjWQ53NiwOxNLYUJVYmF1eGFXxNd9L
	 wv+VhODPnW5cEfCkJxWm/5S5eUAzu3Z8dyPHnTGUp0AKxnMq+LR1llvbF8B8/WD6Yt
	 f6L6UoayrQQxVMxMqxN4NFzbBYT7dhJw99feQhwrFpLLCBZGA/cYgljE4FxLxVyG2D
	 ei7HZZHlrBwqA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:47 +0100
Subject: [PATCH 01/14] wifi: mt76: mt7996: Add chage_vif_links stub
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-1-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

chage_vif_links callback is required by mac80211.
This is a preliminary patch to introduce MLO support for MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 69dd565d831900fa344e214042a74b2e5b265741..ae603f1c098e16bd989b7b1579d22e0ad7dfb49b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1622,6 +1622,14 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 
 #endif
 
+static int
+mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			u16 old_links, u16 new_links,
+			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	return 0;
+}
+
 const struct ieee80211_ops mt7996_ops = {
 	.add_chanctx = mt76_add_chanctx,
 	.remove_chanctx = mt76_remove_chanctx,
@@ -1677,4 +1685,5 @@ const struct ieee80211_ops mt7996_ops = {
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
 	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
+	.change_vif_links = mt7996_change_vif_links,
 };

-- 
2.48.1


