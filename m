Return-Path: <linux-wireless+bounces-1231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4080481C7FA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46171F258A6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB3B1803A;
	Fri, 22 Dec 2023 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PlPf1vk9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jaWtOnXZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE94171CE
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6s7kkvQAOBUfRax1TIdYRfxEwtEdowAwFlbuI48dos=;
	b=PlPf1vk9anJPe5UrhDkuWvC0gezZI5cjc2bPKZyaCq+6QMNarXWBpXRMvkTMnIKQfFblRk
	p6SqH/QVLs3WTwPWn8vyr6qMCrcdohEiFlnOXOqGZEafxODUOeW9zeJE6yQBzDQx6VpGpP
	4dqRdizq+L256WBTUC+ZGqZH3eeV8eG5nCaFmBasjv5OKd1bsUfQSK5cTLXsV4BpbiI+R3
	27NsZ8X6cJ1H8EW72slrbWeBHbfbcJK8WnafrJKY60YDgndVaAT9Xx67qkk5x2dSxIMKN5
	BBMERMECHsxqG3hPxNFet12YCPXLqCKuXYY/q6wzbwACs4ZAWKBOQeRQubsjhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6s7kkvQAOBUfRax1TIdYRfxEwtEdowAwFlbuI48dos=;
	b=jaWtOnXZhxg60GyRbbmuXDKdJjDQqSASaWzuppvleAvojZLpzyOwF94kOUlVNINs9AE8/5
	bM6bZE7IM8WQUDAQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 12/21] wifi: rtl8xxxu: support multiple interfaces in configure_filter()
Date: Fri, 22 Dec 2023 11:14:33 +0100
Message-Id: <20231222101442.626837-13-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
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
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 680dffb9657e1..c5b71892369c9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6794,8 +6794,8 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
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


