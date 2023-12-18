Return-Path: <linux-wireless+bounces-916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E18173C5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEB6B22D4D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFEB3787E;
	Mon, 18 Dec 2023 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vaRcre4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4qMrxg0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094B101DB
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILeYXLyZzn3UARL0UAlnYpv8NwrUpQyxGl9/DdeQ9yY=;
	b=vaRcre4ICpupNl+2bsG7WABrbNLzfqZGr7hZLEIDJyLVXSwBVPMMPBwp4RbjpyILCT3zX3
	9gKA8WPeSXpDuUSKb8pLFRmItffP7cp51kU3DSw26JNbmnHiZLdoWlmhAU2PDNIzU4aIvl
	rb+B2dEJLwGIU1V3bnXC5ITUSP8dKJAh9a+FXnFF7Xhd0Ts6GrqJxjZrtU2P8i2oQKOB51
	5rTAkVoWV1p6/X4WZekWmfT9JrBblkVVM/sZWINeyejGcBbixbcPFBaK9/0m8VoEOIoz+p
	PTQcuBbP20DZFxpqqgbONd4x32nrDWYg/V005QA1Y0urkw+Kra+a5NErJamBGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILeYXLyZzn3UARL0UAlnYpv8NwrUpQyxGl9/DdeQ9yY=;
	b=d4qMrxg0+onBi3d6SpscDSHYpttsNNnFNRbevKfpqLsgRo6fzZtwaaJFvUuNv319EexFjW
	3YaY+WCBGnZXXTBg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/20] wifi: rtl8xxxu: support multiple interfaces in configure_filter()
Date: Mon, 18 Dec 2023 15:36:36 +0100
Message-Id: <20231218143645.433356-12-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we only want to support AP mode/sending beacons on port 0, change
from priv->vif to priv->vifs[0] in the check for AP mode.
Additionally, if we are in AP mode, don't filter RX beacon and probe
response frames to still allow working STATION mode on the other
interface.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6683ff0f4d8c7..f54d7b1647792 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6782,8 +6782,8 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	else
 		rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;
 
-	if (priv->vif && priv->vif->type == NL80211_IFTYPE_AP)
-		rcr &= ~RCR_CHECK_BSSID_MATCH;
+	if (priv->vifs[0] && priv->vifs[0]->type == NL80211_IFTYPE_AP)
+		rcr &= ~(RCR_CHECK_BSSID_MATCH | RCR_CHECK_BSSID_BEACON);
 
 	if (*total_flags & FIF_CONTROL)
 		rcr |= RCR_ACCEPT_CTRL_FRAME;
-- 
2.39.2


