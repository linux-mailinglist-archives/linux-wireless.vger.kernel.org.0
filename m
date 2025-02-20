Return-Path: <linux-wireless+bounces-19204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1040A3DB26
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CCA189BFCB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F4B1F8BC9;
	Thu, 20 Feb 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5rEVBDT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5E1F8BC5
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057562; cv=none; b=QanwhGRa1Ovf2qbdjaovjZuMjZ/aTZy+wqQ6bNbHOUEikQxM+Bd27qzwX7wDJmdzaRbSjGDWP62Z8TSPR9yYRa0bOtvKxTxduhKY1arjkJDn4iC32ayeut6NglGUYz1sIKk+EPBgFBpXjIFrSqDwe3s6XwAQPKsMepsVCrwzASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057562; c=relaxed/simple;
	bh=XF1+CPJcSxRtrFfbh8j8RuFGJUKubbov9FFdIk1eby8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8eEfUc1Q25JfH1nXSV7DdO0wG+MRHsnx1LjAHrPf6fXw7CvK3QKTjjQTVuQjcY+UBI4of9qpgXzrfv67unIChGZZM5+Gk7kR0XlMrm+l7L6tokZTWaR9Mm289nQD+j/tsL8zmWD2m3SPyz1CxpfB80KyvnAIc10ASTLb13+k0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5rEVBDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63253C4CED1;
	Thu, 20 Feb 2025 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057562;
	bh=XF1+CPJcSxRtrFfbh8j8RuFGJUKubbov9FFdIk1eby8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B5rEVBDTHNaC782uQwMROV3wux5uH6XZ3eBP+e0WRSSTjSbYbWey8Ql/tObeUEB+A
	 VQFUV2r/qauRvoDdh+L6aeHvTrkbt16G4N5SZdZPbzGIDltSVd4SLjfyBqk71XX3XN
	 q6yqL0LbCvosq0E1O7U+jg1p833lVBUcnVEOtuqAZMS2rBxdMrSqNlgpWP3uZBN2gg
	 nZj5JS8VoLGy0xmmGjXEyr0W2E/Mz1HiMEOeJUq6qUqUiXlhtX6kBVdGcjAwiJinEa
	 gQWFk9YUdHwFfh1Yf13V1NDAT1+0IDnvYWe1RFC8PfIJ6Da/8YZAC3FNmPfcJWZ8eZ
	 toJ9QP1G3Puvw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:50 +0100
Subject: [PATCH 04/14] wifi: mt76: mt7996: Add vif_cfg_changed callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-4-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
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
index e4ea5a37296167400a39e8d80f1fe2c3b0f1af5c..de7accc5d91d686d76518d580c88e2708dcabfea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -651,6 +651,39 @@ mt7996_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -677,7 +710,6 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	 * and then peer references bss_info_rfch to set bandwidth cap.
 	 */
 	if ((changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid)) ||
-	    (changed & BSS_CHANGED_ASSOC && vif->cfg.assoc) ||
 	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
 		mt7996_mcu_add_bss_info(phy, vif, info, mvif, true);
 		mt7996_mcu_add_sta(dev, vif, mvif, NULL, CONN_STATE_PORT_SECURE,
@@ -1660,6 +1692,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.conf_tx = mt7996_conf_tx,
 	.configure_filter = mt7996_configure_filter,
 	.bss_info_changed = mt7996_bss_info_changed,
+	.vif_cfg_changed = mt7996_vif_cfg_changed,
 	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.link_sta_rc_update = mt7996_sta_rc_update,

-- 
2.48.1


