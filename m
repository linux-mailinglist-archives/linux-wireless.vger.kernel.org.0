Return-Path: <linux-wireless+bounces-1222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64881C7F1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9771F248DE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81F11727;
	Fri, 22 Dec 2023 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WlBw8UWq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDKieVel"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFD11704
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBjnri6AZCB9qnZ+s0Qx/+UZlNhNhNClIZcD5tvNtFQ=;
	b=WlBw8UWqXqYiuZC4B5s7wCbnxde3htVouYBo/DBUPE5GVXGNEQ0RoVRwKXBhguX4A/D0Yo
	+ca9URKFOezkB1qQ01kuiSqqkVhsC7OSOyaf7Yl+hpHUgBoU2RB8vMWBfiLIcjbi5n5jj/
	faQ5hmOJjSq96TDq0vGwgGXs/baBP9Kf2Ofy/fbrlemiC7FU/ptOodblQmXNU0kNovgMg2
	PAUzS1F6Yoy76qFUckJUH7gG4M+I+hXVsjEbpbSjSqdejS6+VidH4OAN4vZyt19B+XTZGS
	vLiQIzkB+SIXK2DASYTvuaC3eNlXK7vLHzRNSqnuJvjc3vd8wLCEzpdqwe8f8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBjnri6AZCB9qnZ+s0Qx/+UZlNhNhNClIZcD5tvNtFQ=;
	b=XDKieVelI5Cocf2Wdywdd0zZuJv7pd5q78VnB/ucTcZHPgRpQrH2NIrxBgkVSdO3rFn3EC
	Ybm9Eg4v9TLyPXCw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 01/21] wifi: rtl8xxxu: remove assignment of priv->vif in rtl8xxxu_bss_info_changed()
Date: Fri, 22 Dec 2023 11:14:22 +0100
Message-Id: <20231222101442.626837-2-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

priv->vif gets already set in rtl8xxxu_add_interface, there is no need
to set it also in rtl8xxxu_bss_info_changed().

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e1..2dbed43ef22a5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5004,7 +5004,6 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 			rtl8xxxu_update_ra_report(rarpt, highest_rate, sgi, bw);
 
-			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
 			priv->fops->update_rate_mask(priv, ramask, 0, sgi,
-- 
2.39.2


