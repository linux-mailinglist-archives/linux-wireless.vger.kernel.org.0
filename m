Return-Path: <linux-wireless+bounces-17017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09739FFBE2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB3B1883D23
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2748B1885B8;
	Thu,  2 Jan 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="b/HHPDAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B6156871
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835728; cv=none; b=H09fF9SR/M2XdE/wzq9LOs+1HLD291tBNvznMBT4RkdrTDvfhGJoGpF4oVE701B+Pr9uG6PvLrPLqZbIveayLMMiYP5pmWGebI4ksmzvjkk+Olxj7Pil8Bt6Y8GWVP97RQX4Q5c4dyUCr9AH3hGDic8nQzkKNAjhUeqLG7BvnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835728; c=relaxed/simple;
	bh=npjGYnwq0uauaZA79oUzWtiBCZN99pbdUMQ76J5lCDY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnPNfxjqxHvYw7VHa+N5WaseChSqub79V1onoQ+ntpuATxjkyWpiS4YX3JnP/sV0NxC0LqDKgV2NfNUzA8mPKcLabMOi67vDjIWJpLmSfINuVHQhM0f2LMKexuopXGG4D6V030MfvDTJQgTRejvFtNcK18eIiiKc6E7VlzpQBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=b/HHPDAp; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Gn0yd5+RWV9Gir2JbbevuO/zfhQQ6hWV5IpRcmguMNc=; b=b/HHPDAptaRtjW6PtGqdp5oa2b
	1OoUkWUXRsUKLKQmXjNWH5dyESuwqezV0oclJ9ElGshFwQESywMNYt6ZdRZU8DTigqlet0qIpm8yZ
	d0Zbjlu9/dhD+Y7RVvtD1N7LvCEVLbGIOQpaLqQvbQDJgpVrDdyh4PoNtd9jRFW4HStg=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAC-0008GS-2n
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:12 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 09/24] wifi: mt76: add multi-radio support to a few core hw ops
Date: Thu,  2 Jan 2025 17:34:53 +0100
Message-ID: <20250102163508.52945-9-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterate over all phys if multi-radio is supported by the driver

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 85 ++++++++++++++-----
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9173438f963e..1d5abe40b0c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -815,6 +815,22 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
+static struct mt76_phy *
+mt76_vif_phy(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_chanctx *ctx;
+
+	if (!hw->wiphy->n_radio)
+		return hw->priv;
+
+	if (!mlink->ctx)
+		return NULL;
+
+	ctx = (struct mt76_chanctx *)mlink->ctx->drv_priv;
+	return ctx->phy;
+}
+
 static void mt76_rx_release_amsdu(struct mt76_phy *phy, enum mt76_rxq_id q)
 {
 	struct sk_buff *skb = phy->rx_amsdu[q].head;
@@ -1023,33 +1039,52 @@ int mt76_update_channel(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_update_channel);
 
+static struct mt76_sband *
+mt76_get_survey_sband(struct mt76_phy *phy, int *idx)
+{
+	if (idx == 0 && phy->dev->drv->update_survey)
+		mt76_update_survey(phy);
+
+	if (*idx < phy->sband_2g.sband.n_channels)
+		return &phy->sband_2g;
+
+	*idx -= phy->sband_2g.sband.n_channels;
+	if (*idx < phy->sband_5g.sband.n_channels)
+		return &phy->sband_5g;
+
+	*idx -= phy->sband_5g.sband.n_channels;
+	if (*idx < phy->sband_6g.sband.n_channels)
+		return &phy->sband_6g;
+
+	*idx -= phy->sband_6g.sband.n_channels;
+	return NULL;
+}
+
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey)
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_sband *sband;
+	struct mt76_sband *sband = NULL;
 	struct ieee80211_channel *chan;
 	struct mt76_channel_state *state;
+	int phy_idx = 0;
 	int ret = 0;
 
 	mutex_lock(&dev->mutex);
-	if (idx == 0 && dev->drv->update_survey)
-		mt76_update_survey(phy);
 
-	if (idx >= phy->sband_2g.sband.n_channels +
-		   phy->sband_5g.sband.n_channels) {
-		idx -= (phy->sband_2g.sband.n_channels +
-			phy->sband_5g.sband.n_channels);
-		sband = &phy->sband_6g;
-	} else if (idx >= phy->sband_2g.sband.n_channels) {
-		idx -= phy->sband_2g.sband.n_channels;
-		sband = &phy->sband_5g;
-	} else {
-		sband = &phy->sband_2g;
+	for (phy_idx = 0; phy_idx < ARRAY_SIZE(dev->phys); phy_idx++) {
+		sband = NULL;
+		phy = dev->phys[phy_idx];
+		if (!phy || phy->hw != hw)
+			continue;
+
+		sband = mt76_get_survey_sband(phy, &idx);
+		if (sband || !hw->wiphy->n_radio)
+			break;
 	}
 
-	if (idx >= sband->sband.n_channels) {
+	if (!sband) {
 		ret = -ENOENT;
 		goto out;
 	}
@@ -1555,6 +1590,10 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_dev *dev = phy->dev;
 	enum mt76_sta_event ev;
 
+	phy = mt76_vif_phy(hw, vif);
+	if (!phy)
+		return -EINVAL;
+
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE)
 		return mt76_sta_add(phy, vif, sta);
@@ -1659,10 +1698,14 @@ EXPORT_SYMBOL_GPL(mt76_wcid_add_poll);
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     unsigned int link_id, int *dbm)
 {
-	struct mt76_phy *phy = hw->priv;
-	int n_chains = hweight16(phy->chainmask);
-	int delta = mt76_tx_power_nss_delta(n_chains);
+	struct mt76_phy *phy = mt76_vif_phy(hw, vif);
+	int n_chains, delta;
 
+	if (!phy)
+		return -EINVAL;
+
+	n_chains = hweight16(phy->chainmask);
+	delta = mt76_tx_power_nss_delta(n_chains);
 	*dbm = DIV_ROUND_UP(phy->txpower_cur + delta, 2);
 
 	return 0;
@@ -1837,10 +1880,14 @@ int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
+	int i;
 
 	mutex_lock(&dev->mutex);
-	*tx_ant = phy->antenna_mask;
-	*rx_ant = phy->antenna_mask;
+	*tx_ant = 0;
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++)
+		if (dev->phys[i] && dev->phys[i]->hw == hw)
+			*tx_ant |= dev->phys[i]->chainmask;
+	*rx_ant = *tx_ant;
 	mutex_unlock(&dev->mutex);
 
 	return 0;
-- 
2.47.1


