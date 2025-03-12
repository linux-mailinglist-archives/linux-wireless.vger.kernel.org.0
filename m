Return-Path: <linux-wireless+bounces-20240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4ABA5DB33
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F421892D5E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37823ED58;
	Wed, 12 Mar 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhFMW9Sb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CE22E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778077; cv=none; b=eXEopMxF8BldW+UA9vWVbPPjGoG/S5j3Y8ro4nkUij0jMOMoLzjArj9z5vcwV77HdcUu4GJN59xePxI7J/8ATuDWHArCEvbSL0zykU3dGRRpwCMR24BisB5xxBaA96eRq5kaAX7KE+XfHFYmNP3ldWxKdSG3YBEeSkqq3ONakdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778077; c=relaxed/simple;
	bh=kwXliEF7AmGk0jiRQYGQr6F0UQPeJBEZNlQxd/jy6rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJkhvGe/4ZCfEzA7Hr/lT25rWfLGeZmA3bBqogvE0Yx7pbrqq+U28ZvBbgwj9TZj4m4LmM6mvVTUk/wskeyE1pi9bBgr7DcaPJ1EEVfXhTO8qF3dQ9s25DVhYAcwvaUpJb6Uew5lmwVALJ/8YEOtRjun2Z6uRb+8gxYzulNbOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhFMW9Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92E4C4CEE3;
	Wed, 12 Mar 2025 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778077;
	bh=kwXliEF7AmGk0jiRQYGQr6F0UQPeJBEZNlQxd/jy6rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DhFMW9SbohuLzSWVyBtbitguDpab1BJKi0mFG7GhUwo4M3NNsFq32ebGKVZdGL4hR
	 7aZH+V4sC1uB9DAvSOerRXtH1jMo7J+lYBqlShySL95ZE7Q+m7BwEtb7Yh0/SsNgeI
	 LlKWdKKgC+VgGK82DZkbF3qAO7CsDbxTUJiuq9EUMkjiBmxUPviM9om0LoYgs2t214
	 MGDguHZ19fGPdQt9NBlrfGHw2cid79g7Yd8ZpIplIXBShbeS67RKyz88qGzi4uVIjU
	 SYTDnZkRhGXsCrNxZVMREeL1fnozAfKQvJ4+Uz8Q7vVlsstTXz2yOZcttJyAFFYdFb
	 raHD5hJz5/xKA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:58 +0100
Subject: [PATCH 14/21] wifi: mt76: mt7996: rework mt7996_update_mu_group to
 support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-14-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rework mt7996_update_mu_group routine in order to support multi-link
setup.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 4d3098e47dbbc25ced2a4b40c6b92423c451899e..2bf6453975ae584b2ab7cc9a46cc80ad7d73d05d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -700,12 +700,11 @@ mt7996_get_rates_table(struct mt7996_phy *phy, struct ieee80211_bss_conf *conf,
 }
 
 static void
-mt7996_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+mt7996_update_mu_group(struct ieee80211_hw *hw, struct mt7996_vif_link *link,
 		       struct ieee80211_bss_conf *info)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	u8 band = mvif->deflink.mt76.band_idx;
+	u8 band = link->mt76.band_idx;
 	u32 *mu;
 
 	mu = (u32 *)info->mu_group.membership;
@@ -831,7 +830,7 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7996_mcu_beacon_inband_discov(dev, vif, changed);
 
 	if (changed & BSS_CHANGED_MU_GROUPS)
-		mt7996_update_mu_group(hw, vif, info);
+		mt7996_update_mu_group(hw, link, info);
 
 	if (changed & BSS_CHANGED_TXPOWER &&
 	    info->txpower != phy->txpower) {

-- 
2.48.1


