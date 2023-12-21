Return-Path: <linux-wireless+bounces-1155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5981BC3C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD771C21B4E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4AB55E79;
	Thu, 21 Dec 2023 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMSJh7ei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0kO597al"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD258207
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJF8OMXv6zsmzzE/WAkfo8NUsf2ylyf77tp+jhQnMpQ=;
	b=OMSJh7ei6dgx5uN40Dahi7Wp8ygkvzEef1cxp1rWc+GSrc5kMWpO/T4He4jfZEqB78jAm9
	DG/zXp9IXDF4zKN4+wspYWB35UzQU8sLnSd0O28V95AADcVfStMi0cqeJkKF7lzEGfmfSc
	phC0Thpzm7RbCy/lbP+yM62J2L5euLB87YhyIyRHDhpveWxkYSqkEpybb65d+RkpxmUmiO
	uWgWfqQu1j/wjqTxZGwZEZHfzPNNW6s4V3qMI4P/7UHTK5h1uJVGsiKTwoH7lJhJ3OBG4+
	T6gc1HEsemotwWH/x+0q74NnhFYafEMOnTyY3mkAIG5jqPo/Bi0L9mjKIqPLBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJF8OMXv6zsmzzE/WAkfo8NUsf2ylyf77tp+jhQnMpQ=;
	b=0kO597al0KUdFXzcjR1UPd6pB0UpK0PUZbG+MVecIQyPDA2Mmlp48q7xgJ4WlTDEi462R4
	QX7KjBR6jncJ8ADQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 06/21] wifi: rtl8xxxu: extend wifi connected check to both interfaces
Date: Thu, 21 Dec 2023 17:43:38 +0100
Message-Id: <20231221164353.603258-7-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple places in the code where the current connection
status of wifi is checked. The driver will support two interfaces soon
and either one of them (or both) could be connected.

Convert all uses of (vif && vif->cfg.assoc) to a new helper
function rtl8xxxu_is_assoc() which checks both interfaces.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c2ea8e92cd637..fd6b6e2eba038 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6043,18 +6043,20 @@ void rtl8723bu_update_bt_link_info(struct rtl8xxxu_priv *priv, u8 bt_info)
 		btcoex->bt_busy = false;
 }
 
+static inline bool rtl8xxxu_is_assoc(struct rtl8xxxu_priv *priv)
+{
+	return (priv->vifs[0] && priv->vifs[0]->cfg.assoc) ||
+	       (priv->vifs[1] && priv->vifs[1]->cfg.assoc);
+}
+
 static
 void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 {
-	struct ieee80211_vif *vif;
 	struct rtl8xxxu_btcoex *btcoex;
-	bool wifi_connected;
 
-	vif = priv->vif;
 	btcoex = &priv->bt_coex;
-	wifi_connected = (vif && vif->cfg.assoc);
 
-	if (!wifi_connected) {
+	if (!rtl8xxxu_is_assoc(priv)) {
 		rtl8723bu_set_ps_tdma(priv, 0x8, 0x0, 0x0, 0x0, 0x0);
 		rtl8723bu_set_coex_with_type(priv, 0);
 	} else if (btcoex->has_sco || btcoex->has_hid || btcoex->has_a2dp) {
@@ -6072,15 +6074,11 @@ void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 static
 void rtl8723bu_handle_bt_info(struct rtl8xxxu_priv *priv)
 {
-	struct ieee80211_vif *vif;
 	struct rtl8xxxu_btcoex *btcoex;
-	bool wifi_connected;
 
-	vif = priv->vif;
 	btcoex = &priv->bt_coex;
-	wifi_connected = (vif && vif->cfg.assoc);
 
-	if (wifi_connected) {
+	if (rtl8xxxu_is_assoc(priv)) {
 		u32 val32 = 0;
 		u32 high_prio_tx = 0, high_prio_rx = 0;
 
@@ -7103,7 +7101,7 @@ static void rtl8xxxu_track_cfo(struct rtl8xxxu_priv *priv)
 	int cfo_khz_a, cfo_khz_b, cfo_average;
 	int crystal_cap;
 
-	if (!priv->vif || !priv->vif->cfg.assoc) {
+	if (!rtl8xxxu_is_assoc(priv)) {
 		/* Reset */
 		cfo->adjust = true;
 
-- 
2.39.2


