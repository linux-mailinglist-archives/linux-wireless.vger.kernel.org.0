Return-Path: <linux-wireless+bounces-20184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41EEA5CC8F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C759189E5FC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697282638AE;
	Tue, 11 Mar 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh7ARPgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5F2638AD
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715127; cv=none; b=RMv5NIEcrQkHRsEqI0se2NcM5LTk2/MhuOmkwvng2SVNGqljJXbL9B8oVz6bHq0Snp92SzN9sToY7qkvSuYkOROLuiKN1o8kP5mHomfD57GberrrVzjx86/bOtH+qlqGfn1gNMxJaM2lvnINWAv9IWD8936N3tjpqG4kSv9E6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715127; c=relaxed/simple;
	bh=aHLPl/dBaOFAsE6VXcW0EJsceJVpUH2lwy+xqRiq47w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZr+pxOlP1m/5N2hiAG6fay5RBH1qomCUVc5mFl76z6La1bOlbh3w24w3Sc2pw8ONSQbOj0qy62kfCcz5ypOkBveWcayxY4E/+XChEV3sKEvP20t4apSlhaylsZGS9jIm0ZM/ve1fL39Tmpj0b6XAfaClkK8BRw6/Ers1YcfEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh7ARPgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD865C4CEEA;
	Tue, 11 Mar 2025 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715127;
	bh=aHLPl/dBaOFAsE6VXcW0EJsceJVpUH2lwy+xqRiq47w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rh7ARPgRO7AJ9HDLjEhnsPcplj+WfjMYSTIhPia46Acr7sRPPEksZWJUDVAWf2+1Z
	 RDmTE+6jTLsyNubyKEDAPLBm7kzFuHep7Wgizu6/Lp5oB8TqlQPkrdGARO+wv9j/JT
	 U2s2MGi4fUY9QSk0vFEaWWg6yX0U6qadWq5X/aCeRheG+f8uogDAgjvsz4ccrtkrKC
	 IUV6WxbuUdzIJ1hkPFYxbi7iomUmla8Q1MUDrxfpTqyNRluhNNZ7CwRRfLNBpKFuOz
	 PjN+9czZXXTr/P/CMS1LuceUMTMGmXxQQABH9XoLuO8bJW9bmO5hx7ZO5m79vhnQb3
	 Fan8xTrdWtUVQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:03 +0100
Subject: [PATCH v2 04/13] wifi: mt76: mt7996: Add vif_cfg_changed callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-4-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

Introduce vif_cfg_changed mac80211 callback as preliminary patch to
enable MLO support in MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 35 +++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 34f984387c00714fbe72af5220ec067760510bb8..59a1e5e52450accc5b01fbe0c3af7e84bcc87df6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -679,6 +679,39 @@ mt7996_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt76_wr(dev, MT_WF_PHYRX_BAND_GID_TAB_POS3(band), mu[3]);
 }
 
+static void
+mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       u64 changed)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if ((changed & BSS_CHANGED_ASSOC) && vif->cfg.assoc) {
+		struct ieee80211_bss_conf *link_conf;
+		unsigned long link_id;
+
+		for_each_vif_active_link(vif, link_conf, link_id) {
+			struct mt7996_vif_link *link;
+
+			link = mt7996_vif_link(dev, vif, link_id);
+			if (!link)
+				continue;
+
+			if (!link->phy)
+				continue;
+
+			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
+						&link->mt76, true);
+			mt7996_mcu_add_sta(dev, vif, &link->mt76, NULL,
+					   CONN_STATE_PORT_SECURE,
+					   !!(changed & BSS_CHANGED_BSSID));
+		}
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
 static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -705,7 +738,6 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	 * and then peer references bss_info_rfch to set bandwidth cap.
 	 */
 	if ((changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid)) ||
-	    (changed & BSS_CHANGED_ASSOC && vif->cfg.assoc) ||
 	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
 		mt7996_mcu_add_bss_info(phy, vif, info, mvif, true);
 		mt7996_mcu_add_sta(dev, vif, mvif, NULL, CONN_STATE_PORT_SECURE,
@@ -1688,6 +1720,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.conf_tx = mt7996_conf_tx,
 	.configure_filter = mt7996_configure_filter,
 	.bss_info_changed = mt7996_bss_info_changed,
+	.vif_cfg_changed = mt7996_vif_cfg_changed,
 	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.link_sta_rc_update = mt7996_sta_rc_update,

-- 
2.48.1


