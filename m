Return-Path: <linux-wireless+bounces-926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B58173D0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D851F24325
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C23A1CB;
	Mon, 18 Dec 2023 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KeRB5YF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxh5cbeY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C442368
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptqs0ZJ3rYpPy4Q6TEj8asN+2XXFzbqaYPKnRdE81BI=;
	b=KeRB5YF6zaCgRCWVwZk9a7jCKJQ3/ebFSbevvX0iBu+wxYVA5S8qFDHqXBv8lnJT9psuqI
	1K6b4MsIZVmMSwuUmG13uG/7qBDI5RxLPO3ZGP+p7BPQC6kBzi34IvxnkwWhoepNDM2vqf
	p8VGk11MhRm2OJz7W+CA+WNGMrLCYtFioDbPy43xfIKhHtnov9J9zO1BHbqedH7FiKt2yx
	aBffbXMrYVveL5eZSOhFmSWRC7jhidoWxM4zfzKmGyZDDQvGAcYfZVys8KNk6LaAcQUKzy
	tPZuLa6/x0SCf+HFzXHNIe1YNaSgFyso3fMhWzfWI0VO0DymYM9X3r2gGkY12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptqs0ZJ3rYpPy4Q6TEj8asN+2XXFzbqaYPKnRdE81BI=;
	b=cxh5cbeY1IUmpdz0+B7r6/o2TeugC/Ja+Rcna6yGL/6bwMTZeQZRbc1aGbG7S6A0+jsMa3
	3S1QhnDlasNGp2DA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/20] wifi: rtl8xxxu: remove obsolete priv->vif
Date: Mon, 18 Dec 2023 15:36:42 +0100
Message-Id: <20231218143645.433356-18-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all uses of priv->vif have been converted to priv->vifs[]
remove the old attribute.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 5 -----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9d272da373a3c..889ef7217f142 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1892,11 +1892,6 @@ struct rtl8xxxu_priv {
 	u8 rssi_level;
 	DECLARE_BITMAP(tx_aggr_started, IEEE80211_NUM_TIDS);
 	DECLARE_BITMAP(tid_tx_operational, IEEE80211_NUM_TIDS);
-	/*
-	 * Only one virtual interface permitted because only STA mode
-	 * is supported and no iface_combinations are provided.
-	 */
-	struct ieee80211_vif *vif;
 
 	struct ieee80211_vif *vifs[2];
 	struct delayed_work ra_watchdog;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index ad76cddef81b2..c2a577ebd061e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6655,7 +6655,6 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 	}
 
 	priv->vifs[port_num] = vif;
-	priv->vif = vif;
 	rtlvif->port_num = port_num;
 
 	rtl8xxxu_set_linktype(priv, vif->type, port_num);
@@ -6673,7 +6672,6 @@ static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
 
 	dev_dbg(&priv->udev->dev, "%s\n", __func__);
 
-	priv->vif = NULL;
 	priv->vifs[rtlvif->port_num] = NULL;
 }
 
-- 
2.39.2


