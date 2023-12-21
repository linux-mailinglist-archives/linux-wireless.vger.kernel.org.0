Return-Path: <linux-wireless+bounces-1167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF281BC48
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE168B26125
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A13634F6;
	Thu, 21 Dec 2023 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPm08bxy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5waxjo/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B996280B
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0yo6wUPMjlWISpPYo4osApNu94NIJzCy0g+vJ50WnU=;
	b=GPm08bxyWhQI9QLBkcKCI6F0IU6FZMjgptBBF/UxOk5VieLzQ1CldHt0jdBLw6rWz+gRJt
	QpX2HNszgVJ2Mc+oWA/pWmEzsKjg1QDV93TykC8fsDd/0It830VnuuNGipXHfXQme+XdCu
	cV1LNfm+IMYgAfAK8gZbBXw+EDvukDj/iRZRchoac0cL2Ea4cV+RoT8g5HcZ1G8IwDeiZ6
	vl/t5aLMTb8FlRC+LF4oW9yEHKzBG+IN00+G7uSqe9owSElKBUFv0tkc6zC46DKTpQ72x6
	ELKYrxw0VaCUxZL1IEal7oSa3u3qBdD0TF2FCvQ/kEJ7HLAuuJD4FK/ANdgg2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0yo6wUPMjlWISpPYo4osApNu94NIJzCy0g+vJ50WnU=;
	b=E5waxjo/wuwgI6W4shjcjC9+VYzH9W0U635pgdVN3wEGezDf0V/XzBZxP8NnkrXpLENKzC
	DZnzNhwd8MMOY4DQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 15/21] wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
Date: Thu, 21 Dec 2023 17:43:47 +0100
Message-Id: <20231221164353.603258-16-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call set_linktype and set_bssid now with correct port_num. Call
stop_tx_beacon only for port 0, as we don't support beacons on port 1.
Explicit changes to BEACON will only happen for AP type interfaces, so
we don't need an additional check there.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 4090db8abba7b..aa88e66c64d67 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4983,6 +4983,7 @@ static void
 rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *bss_conf, u64 changed)
 {
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	struct ieee80211_sta *sta;
@@ -4995,7 +4996,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (changed & BSS_CHANGED_ASSOC) {
 		dev_dbg(dev, "Changed ASSOC: %i!\n", vif->cfg.assoc);
 
-		rtl8xxxu_set_linktype(priv, vif->type, 0);
+		rtl8xxxu_set_linktype(priv, vif->type, rtlvif->port_num);
 
 		if (vif->cfg.assoc) {
 			u32 ramask;
@@ -5042,7 +5043,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
 
-			rtl8xxxu_stop_tx_beacon(priv);
+			if (rtlvif->port_num == 0)
+				rtl8xxxu_stop_tx_beacon(priv);
 
 			/* joinbss sequence */
 			rtl8xxxu_write16(priv, REG_BCN_PSR_RPT,
@@ -5084,7 +5086,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (changed & BSS_CHANGED_BSSID) {
 		dev_dbg(dev, "Changed BSSID!\n");
-		rtl8xxxu_set_bssid(priv, bss_conf->bssid, 0);
+		rtl8xxxu_set_bssid(priv, bss_conf->bssid, rtlvif->port_num);
 	}
 
 	if (changed & BSS_CHANGED_BASIC_RATES) {
-- 
2.39.2


