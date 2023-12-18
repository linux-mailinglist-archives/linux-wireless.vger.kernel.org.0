Return-Path: <linux-wireless+bounces-911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8E8173BD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADD5B22985
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4963787E;
	Mon, 18 Dec 2023 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5rXQle+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weFgCZHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06237860
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+Bxa0fwIKiIt1y3nQfQ/G3TrI/8fdY0+DuJgF4EycM=;
	b=N5rXQle+/hgXoImG8BpWWLpTMdSaffNeqnB6nP4dkKSuCLpTx48us0JCWrVCMUHblOzXoI
	ZDZTlCyQqNv/p8U2MdLcJiFkkeBR+e54UWzf2HYXUIT+xi4LOgC2A1zYoIrp/MWQbsKKen
	RdCMoB+CjDdhJnIaJlywY4qAoskbrbPpnUzkxzO38NOYz3tWpYSADBoYUVIvKiXVxG3oNo
	+UtLHq2s1zvj4AOHdc5+FzsrBCpOSIWK3abaT0AEIUZC8NV9p4PrRaiqQb9zxTyjFtfXBH
	Ljd3UJTIdnudP6/FDNNrldDp7WPoYOzAXlmszfTssw6euL1Q/1cT5O8cziGPrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+Bxa0fwIKiIt1y3nQfQ/G3TrI/8fdY0+DuJgF4EycM=;
	b=weFgCZHzKNqf56qkFJVaEFBdMd+BrydseEukHDPwmElZUjW4XRLzR/a7sKa/GwelwhYEdb
	hVBpbzfjyWIUqtBg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/20] wifi: rtl8xxxu: remove assignment of priv->vif in rtl8xxxu_bss_info_changed()
Date: Mon, 18 Dec 2023 15:36:26 +0100
Message-Id: <20231218143645.433356-2-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
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


