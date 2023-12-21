Return-Path: <linux-wireless+bounces-1164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B981BC45
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FA81F24FFF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E06634F0;
	Thu, 21 Dec 2023 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBQkv/u5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2kNyYHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFC55E73
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
	bh=YYFdViIjlESDzhteIs2oPwA/vKJ2vfKkn8h4MvsolD4=;
	b=GBQkv/u5Fn7wo7K49zrWlYeqMTwbju4qSr+Pezfb/Rig+DgJN4u4EQx++vlmZ7//W2NejX
	Rg8ZCj3/StfDZ4CeacER01B2xqap9Zpa4ysZ1fVmRlWsU1SLND5T18LHrIIEd5uN53M+CX
	1Pb1FDr9FbFEqtWrymDp7aKMW9nvC8ugJe439+iL5IcuklzeP7xGKpjwD55hEP00L+Jvo6
	4PqhF4PaH1cxBzUAovA8S63NHDXJIPiNZG6Cfg6SoJH/r7FHh7bjpv0lo5c/owEC5PGs32
	dyFQO4wHcc511J34zd40kjzSwlZVab6ODHCWQAWdlMzduyKUTr+NPfNZwQKp9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYFdViIjlESDzhteIs2oPwA/vKJ2vfKkn8h4MvsolD4=;
	b=+2kNyYHNEd74iWBlT/dJcYyiSbOJtXAhTQuCa416R3zqBw54P6Vbjf6u02xXcEhXn9Pgzi
	naVZX/GpZVnkDaAg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 11/21] wifi: rtl8xxxu: support multiple interfaces in update_beacon_work_callback()
Date: Thu, 21 Dec 2023 17:43:43 +0100
Message-Id: <20231221164353.603258-12-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we only want to support AP mode/sending beacons on port 0, it is
enough to replace priv->vif with priv->vifs[0].

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 99fe567e0f75b..680dffb9657e1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5712,7 +5712,7 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 	struct rtl8xxxu_priv *priv =
 		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
 	struct ieee80211_hw *hw = priv->hw;
-	struct ieee80211_vif *vif = priv->vif;
+	struct ieee80211_vif *vif = priv->vifs[0];
 
 	if (!vif) {
 		WARN_ONCE(true, "no vif to update beacon\n");
-- 
2.39.2


