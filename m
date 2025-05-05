Return-Path: <linux-wireless+bounces-22482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDAAAA03F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F27AB990
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125328F94F;
	Mon,  5 May 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhdHoIGq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3F428F948;
	Mon,  5 May 2025 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483416; cv=none; b=DU2t1BkTL5N0jw9gy2jez74dK17wxek1um8fOi5iVZCY9A0PMJfgIMpNNQmiWlJiphAi549ke3dq/vj5Q8P6VigJkdU/4lBzvayXBSEGjTvU/zMYur/3RF3jiFeYYFgOxUt1KrCgOeLMInmtreaisuZA5Toq5BUkITMju4kEesY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483416; c=relaxed/simple;
	bh=W2Wxsu7SWKuP/XejYew3Si0a72iY7M15wT4Jt1kxI0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uG1i0FluQXPfJQUIXtLRd291IMFZR42zm/haMoyrTZen2XaNk1A/5pcgXssm94GOw7zNuIcKdTVxHDvREmQitUSTUb41DbOXID+8hP/o9mHeDteWFT+ceEzJ3QW4JXbOT3F2QVlsz6bQGExIL25O6JK+7A5FhfTr8wYpzZw0AzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhdHoIGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434BCC4CEE4;
	Mon,  5 May 2025 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483415;
	bh=W2Wxsu7SWKuP/XejYew3Si0a72iY7M15wT4Jt1kxI0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhdHoIGq5qHfNzOVZz+JjIzws8j76Ed/xBpGhv57DUHRVCJ6Jo67JsgWjbQw+znrH
	 Dz4pMKjYx/Y3evzCU7dCRnyBfk/FJ2DHqb/1YPSlgvGZfTsZ26hLyZj2RvYRbsANXB
	 NXdsNfQ0hasoDxCDtRBNrUEZq9PKeLCo67rWe8F0zpuQdN7WhQeQBGx6aRZK7KzWrY
	 ed0fa2HL7h0YvcvDHexBF2jIL1zUt+eqS/eq3bZX3JIZPd48AnjGJPvK6nY0x1Hv2P
	 p/EPGlPhc+HDyTPY7cIirhhS2IPJFltbSVPWR2ehpUFcdO3HhayTYrBJx60MkNnOhS
	 6nODEl0N5pwMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shayne.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 074/642] wifi: mt76: mt7996: implement driver specific get_txpower function
Date: Mon,  5 May 2025 18:04:50 -0400
Message-Id: <20250505221419.2672473-74-sashal@kernel.org>
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

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 86db2c5d4ed390b97a5b455a97e2cd9c4f3eff2b ]

Fixes reporting tx power for vifs that don't have a channel context
assigned. Report the tx power of a phy that is covered by the vif's
radio mask.

Link: https://patch.msgid.link/20250311103646.43346-7-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 69dd565d83190..980a059b3b38f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -601,6 +601,33 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   unsigned int link_id, int *dbm)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct wireless_dev *wdev;
+	int n_chains, delta, i;
+
+	if (!phy) {
+		wdev = ieee80211_vif_to_wdev(vif);
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			if (wdev->radio_mask & BIT(i))
+				phy = dev->radio_phy[i];
+
+		if (!phy)
+			return -EINVAL;
+	}
+
+	n_chains = hweight16(phy->mt76->chainmask);
+	delta = mt76_tx_power_nss_delta(n_chains);
+	*dbm = DIV_ROUND_UP(phy->mt76->txpower_cur + delta, 2);
+
+	return 0;
+}
+
 static u8
 mt7996_get_rates_table(struct mt7996_phy *phy, struct ieee80211_bss_conf *conf,
 		       bool beacon, bool mcast)
@@ -1650,7 +1677,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.remain_on_channel = mt76_remain_on_channel,
 	.cancel_remain_on_channel = mt76_cancel_remain_on_channel,
 	.release_buffered_frames = mt76_release_buffered_frames,
-	.get_txpower = mt76_get_txpower,
+	.get_txpower = mt7996_get_txpower,
 	.channel_switch_beacon = mt7996_channel_switch_beacon,
 	.get_stats = mt7996_get_stats,
 	.get_et_sset_count = mt7996_get_et_sset_count,
-- 
2.39.5


