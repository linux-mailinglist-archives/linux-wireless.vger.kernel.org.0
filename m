Return-Path: <linux-wireless+bounces-1166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880C81BC47
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C822854DE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3B59917;
	Thu, 21 Dec 2023 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="455Vm1n6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MDMWuEsb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C262801
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jHTvxVWYVqs7UgIAu5tbDmX7ebM7K8TmtEFb+QkjwQ=;
	b=455Vm1n6jJi5SMq59duUDrfzSeKGhdagp18dHUMXxT8M0/rZvRA5eDxq8id4VK10NsM9zD
	yJxnKSBt5BjP8XYVnWYuSJImImKymXGgWiowC1C+8usUwvK8txRCj1kw3X4ty6BPYeCt77
	q95ldt8tQ/ECufnUK+Tum2DiNoWjSSUe5ZFYQuZrsAVMu5rBu1NE6ldbbq+z5+zuz06t5n
	GvJ9kx7dYX+DD1FNrAUJT/c1WZTy0X+zN/8RuiUw8jBRlb1X2hX4JzJ2sFOWUQKB24u/77
	HWTD/cZJdcroeCVzdmJqpY1Xhi/noq17mv5uKMBdFZWeDF1kj2XizpADOtrfkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jHTvxVWYVqs7UgIAu5tbDmX7ebM7K8TmtEFb+QkjwQ=;
	b=MDMWuEsbFI7q22uyoSoJqgBkeazuxvWvrO30XQiO5KhfP6ccULZagEfyBLRCIxHr7L+V8T
	I7RKHnYyvTEOgKDg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 18/21] wifi: rtl8xxxu: remove obsolete priv->vif
Date: Thu, 21 Dec 2023 17:43:50 +0100
Message-Id: <20231221164353.603258-19-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
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
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 5 -----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 6a58897446f4c..c5e6d8f7d26bd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1893,11 +1893,6 @@ struct rtl8xxxu_priv {
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
index 0b6eac14f60e5..ecf54eb8dba61 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6666,7 +6666,6 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 	}
 
 	priv->vifs[port_num] = vif;
-	priv->vif = vif;
 	rtlvif->port_num = port_num;
 
 	rtl8xxxu_set_linktype(priv, vif->type, port_num);
@@ -6684,7 +6683,6 @@ static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
 
 	dev_dbg(&priv->udev->dev, "%s\n", __func__);
 
-	priv->vif = NULL;
 	priv->vifs[rtlvif->port_num] = NULL;
 }
 
-- 
2.39.2


