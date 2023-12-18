Return-Path: <linux-wireless+bounces-927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA928173D1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDBD1F24374
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F31D157;
	Mon, 18 Dec 2023 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmKDN7Xt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xIzDYuqs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659C3D568
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
	bh=p8RuRhMrs3kLb0LdYS9LLCJzvgc4hFqIDQ54H2oKUFk=;
	b=ZmKDN7XttL6GUIUlbdK6Yn6FYw9m1LMXrw00MkwniYZ1kQRB0X/HjuQaHqa4E0bK/0XYCA
	nIdZM56qiUYKJ7rPsXVZUOWJYuLxiJy9Z492T2nVCr1pKObXB0d9Bmo3iuRjjosLH0oeNt
	h4G7fOXTzS3i6qNlRNijU2WGOxrIzq8waD/F0K5xxWlg3mZuvl8An/dsjc3gudLa0mn9CN
	haoAYLvbM9rb7j+cT6F8W1AqXJhPc3SAimhO/hcS5iqrGJV+lySh4gPOmly0/t06pmYGD0
	UhaP6aBJ3WypwmfLkqyiau2EDlQdL8engqgvIhn0oIymuqbiJQcinN2zLKwIRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8RuRhMrs3kLb0LdYS9LLCJzvgc4hFqIDQ54H2oKUFk=;
	b=xIzDYuqs45+Dxv1aoEvtgUA3dSJpr8L7MrrDimSNZvmly7Gh4IrfX1Z62dRc26pKv3NqSl
	NADipIM1F7IOgFCg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 16/20] wifi: rtl8xxxu: support multiple interfaces in get_macid()
Date: Mon, 18 Dec 2023 15:36:41 +0100
Message-Id: <20231218143645.433356-17-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As sta_info->macid does not get set in station mode, we can simplify
this function by directly returning 0 if sta itself or sta_info is not
set.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3851fc90339e0..ad76cddef81b2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4053,10 +4053,13 @@ static inline u8 rtl8xxxu_get_macid(struct rtl8xxxu_priv *priv,
 {
 	struct rtl8xxxu_sta_info *sta_info;
 
-	if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION || !sta)
+	if (!sta)
 		return 0;
 
 	sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	if (!sta_info)
+		return 0;
+
 	return sta_info->macid;
 }
 
-- 
2.39.2


