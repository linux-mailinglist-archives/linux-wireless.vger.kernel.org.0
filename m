Return-Path: <linux-wireless+bounces-1238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75781C801
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A11C213B9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8C199B7;
	Fri, 22 Dec 2023 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uiXEEye/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P0ToC2JI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02818647
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jHTvxVWYVqs7UgIAu5tbDmX7ebM7K8TmtEFb+QkjwQ=;
	b=uiXEEye/chuff9SS8bsbQLvWoYluY70rH8q/GUsTE5G+fJRL3hE8sYBF7IBEf39Gw08NHs
	SPZovRW8pNyS92LquMpWni8hmsAosBFpYEFl4N3ETKUMte+iMpoUld0XYUyvh4fdpAzfe5
	FwJEyPgiCh9n16VUVNzP5HSvQDw2wJ/P88MiqP0hJosm3ySZRbiWIbR3nigawSRXvpCefu
	n+W4iBxm7DHa9JRa+M7rzIlKShIhRUr2VjncJWnRO+bZDvUTdLtaG2AcWGiqlkFzcEAGMf
	MAxnzJ64ZWJ9gSUKJddWyJgo8ktwzT/hzJZvzJjxFYl8lei+0GuSWL2PqlSphQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jHTvxVWYVqs7UgIAu5tbDmX7ebM7K8TmtEFb+QkjwQ=;
	b=P0ToC2JInwlWMliP/n0WO9o8hPVZvqYKNzyIco4SQ4Z4ZdLnwAciBfYTD0RG2Oc4hbIqW0
	b/WSkC5l+Es5afCw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 18/21] wifi: rtl8xxxu: remove obsolete priv->vif
Date: Fri, 22 Dec 2023 11:14:39 +0100
Message-Id: <20231222101442.626837-19-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
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


