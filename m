Return-Path: <linux-wireless+bounces-19205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D7AA3DB30
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49E23BDB23
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7281F8BC5;
	Thu, 20 Feb 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huKqJ1rp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B01F540C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057565; cv=none; b=g6ZDozhF6Dl6T4575jBBgywgNomJzzQLo3IuYdvH67o0zhLEork2nGd/N35OgwKdVNZJRwANYsyAk1hpshV6/dWoSFPTkgW8Na+bYESvg3FJl8o2ItshJt9FjBhq+R+Oc5Snac4wfrfL80fAwZvK4zXVyVzhOiyucHjJ0oEw5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057565; c=relaxed/simple;
	bh=GiSBRmgb6zQVAG86agX4QFJ5OPcXnhMAnWVW6Hnmz/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORgsA3sNxx1ZU7AU8CBDmcliBI02Eab9/LH9HPXZVi3/SL7U1lrRNyN64KojWypjzSfErnd5yWD/Gjlkba0ApPsjva9eqG+fLbg8UE2JE27Py1WYxftXpv0Liq2eKGsowlwgzWiPbeGEnr0q4EM8Zp2S9YDcLsa3itxUiA4bqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huKqJ1rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13396C4CEDD;
	Thu, 20 Feb 2025 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057565;
	bh=GiSBRmgb6zQVAG86agX4QFJ5OPcXnhMAnWVW6Hnmz/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=huKqJ1rpC5oYFvqoDsDX/r6fQYswVII3C3w6xezm2O62nCfEFXcdOKrdtlRGv14d3
	 NsV/qP+8i/H2u6Bh3VRtC8o05bcVIq4aLBr/K7ghvKgf9nk/oO3I+BxSFBCEdr/J3n
	 i4Mc9DM0yg1BZX/YwVig34ZMGeV62WpkQwK7C1V837hNaVjjEHMdNCj1mEw8slU/j7
	 cYfcv1GvDLM+4LnrCd6zgPYUf0ksTLrhLwDn0JTR2dGc3kBuc9C1ycVBoBr7teXZA/
	 2aWDHIJRSoPnPo4+lZ+rYYpGKyWNLB/S0iwlXoy8UuiPie/uOskqr18KWJq3yxUTCD
	 0i8qq8OgokNSA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:51 +0100
Subject: [PATCH 05/14] wifi: mt76: mt7996: Add link_info_changed callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-5-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Convert bss_info_changed mac80211 callback in link_info_changed one.
This is a preliminary patch to enable MLO support in MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index de7accc5d91d686d76518d580c88e2708dcabfea..06ee426db62dab78b171b097f7bd2ca690b41ac4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -684,10 +684,9 @@ mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_bss_conf *info,
-				    u64 changed)
+static void
+mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt76_vif_link *mvif;
@@ -1691,8 +1690,8 @@ const struct ieee80211_ops mt7996_ops = {
 	.config = mt7996_config,
 	.conf_tx = mt7996_conf_tx,
 	.configure_filter = mt7996_configure_filter,
-	.bss_info_changed = mt7996_bss_info_changed,
 	.vif_cfg_changed = mt7996_vif_cfg_changed,
+	.link_info_changed = mt7996_link_info_changed,
 	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.link_sta_rc_update = mt7996_sta_rc_update,

-- 
2.48.1


