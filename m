Return-Path: <linux-wireless+bounces-1159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608681BC40
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871051C216D4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886A627F2;
	Thu, 21 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYwblMev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y3mPF7xD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3B55E77
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6s7kkvQAOBUfRax1TIdYRfxEwtEdowAwFlbuI48dos=;
	b=OYwblMevBJEW8WoG/04VuZlgdUj6/eaphEU03z9Rg19FahZAyxIBsBjVHSmBV1uD0UeQCk
	BgT8QMqIjxhZJiSDHXVBF4Br+/tnLNTYcnLJj2ckx8UHek0jQIvYpUk+jGoGgkJ7C6eMfe
	4ThPbZNMPl0C4c8w4oy7EYc5k9rA/W8uMRM7eZAIOStIcNBSmF6synLoqdI9ST5te3IGNl
	nGIl7BoIZrEZV/KYHilMCzfOYWPO0dm6NL8x93jDOC4RXiaYJfspTt82OxI16rz2Ohhnln
	up96lEzbspf9YWwVpgD+Xx9eIFiq/cpQ8FEeBmFm81d6P23T0Jy+GryhrVUPPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6s7kkvQAOBUfRax1TIdYRfxEwtEdowAwFlbuI48dos=;
	b=Y3mPF7xD+Gsn1dKKakAkjnRbAcxsi3d906J12HmDrBozaRe3TJG6Vif1g49XUvMnbvquw1
	CkRV+UrDLnXKdzCA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 12/21] wifi: rtl8xxxu: support multiple interfaces in configure_filter()
Date: Thu, 21 Dec 2023 17:43:44 +0100
Message-Id: <20231221164353.603258-13-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
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


