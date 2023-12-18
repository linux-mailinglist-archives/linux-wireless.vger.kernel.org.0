Return-Path: <linux-wireless+bounces-920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D4D8173C8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D670B23B69
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80B4236C;
	Mon, 18 Dec 2023 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldB+zI2d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zkHukrBE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A933A1CB
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
	bh=m3+lBLBbdwOKc1aYpKwkjz/fN2qw4r3wPL0fqULIU9k=;
	b=ldB+zI2dTXjTMq7hcdfcyViO1UMOFtPwCJb9rNXVB8Z78Ddi+HJ3lU68UcAHWUbMI2HqS1
	YjTEileufjMpCFs5NE0J67YcjajyIVHkwLeXN29GaWFIldtdZtpuVOw4Onpl03QO7RDtrF
	4rsJDIJ3yPUUrDqChtwtF+UWngFb/A496SiicgOsbos7aa8vdjZHvRS6l0vZGadQALC4+b
	ejVxHf6rN2NlDsigFBukt3SaFv1UDA+AXWGpErQ0i9sMy5mxd45p5wpgHdzjQQfJPxo+1L
	Yl4rC/mhtyW/Lb72f74EC+eBJh5fwZWv7mVbUZY96GKn+zIcgrspdC4/8AT2SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3+lBLBbdwOKc1aYpKwkjz/fN2qw4r3wPL0fqULIU9k=;
	b=zkHukrBE8WW+ZzucRKRPFMY0vSFHWNM75rGsfD7KfJpc2w4FLrgnA8a7p4ITEDUrrezwOe
	2IoI59V3uiV9qXAA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/20] wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
Date: Mon, 18 Dec 2023 15:36:37 +0100
Message-Id: <20231218143645.433356-13-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check first whether priv->vifs[0] exists and is of type STATION, otherwise
go to priv->vifs[1].

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index f54d7b1647792..0d171f61ac8e8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7190,7 +7190,9 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 	struct rtl8xxxu_priv *priv;
 
 	priv = container_of(work, struct rtl8xxxu_priv, ra_watchdog.work);
-	vif = priv->vif;
+	vif = priv->vifs[0];
+	if (vif && vif->type != NL80211_IFTYPE_STATION)
+		vif = priv->vifs[1];
 
 	if (vif && vif->type == NL80211_IFTYPE_STATION) {
 		int signal;
-- 
2.39.2


