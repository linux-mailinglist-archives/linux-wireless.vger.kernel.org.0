Return-Path: <linux-wireless+bounces-1240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA1081C803
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED831C22085
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA019BD3;
	Fri, 22 Dec 2023 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/p6UU3f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6cAnJdXD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A518C20
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
	bh=Vm1o2HILfB97WRmJbwt9PEqUOiIwfdeFIsy8DmCIJpI=;
	b=K/p6UU3fvfUsEJNWk4IfUmmXswb3YdJQzn9BAv3HNUiJO4tI6pUEHafLTY7grSVdNFr87S
	HG86QYJMGb5/nwmNBjB3sUMnUSJ+MbIhiDXKmkLnx+uxiX/D1aW16NbznBss7ME81Bz45D
	0BF8RXB+C7fV458T8J27yyJYXDK+p5jyZp0stbP5Abi3MJSCZ1hkueC7YpBJjqzVWBX2t8
	zLtKZUhQ+QVGQG/wDP7tb/OaJVzUnWdzXDdCHcvXm8Ty2/NzkBDBDAHmehq38k7+T1aDJ6
	MMucE76a8hrE/iXupjcYRGLImotyUvbCTTJpL6XqWmnI9j6YDx/H9AAHDVNlOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm1o2HILfB97WRmJbwt9PEqUOiIwfdeFIsy8DmCIJpI=;
	b=6cAnJdXDDKTIZJzP7n1/cj41X7KGoO/4i8V8Zn2ROzPTm98/1QeZqkKODyvKYIeTCDEZzf
	CZj7wh/2hAElsfBg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 21/21] wifi: rtl8xxxu: declare concurrent mode support for 8188f
Date: Fri, 22 Dec 2023 11:14:42 +0100
Message-Id: <20231222101442.626837-22-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everything is in place now for concurrent mode, we can tell the system
that we support it.
We will allow a maximum of 2 virtual interfaces, one of them can be in
AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 62e6318bc0924..803c76b3209c4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1992,6 +1992,7 @@ struct rtl8xxxu_fileops {
 	u8 init_reg_rxfltmap:1;
 	u8 init_reg_pkt_life_time:1;
 	u8 init_reg_hmtfr:1;
+	u8 supports_concurrent:1;
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
 	u16 max_aggr_num;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 574a5fe951543..464216d007ce8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1752,6 +1752,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.supports_ap = 1,
 	.max_macid_num = 16,
 	.max_sec_cam_num = 16,
+	.supports_concurrent = 1,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 0178b441dce53..5fddbd6594a24 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7665,6 +7665,20 @@ static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
 	led_classdev_unregister(led);
 }
 
+struct ieee80211_iface_limit rtl8xxxu_limits[] = {
+	{ .max = 2, .types = BIT(NL80211_IFTYPE_STATION), },
+	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+};
+
+struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
+	{
+		.limits = rtl8xxxu_limits,
+		.n_limits = ARRAY_SIZE(rtl8xxxu_limits),
+		.max_interfaces = 2,
+		.num_different_channels = 1,
+	},
+};
+
 static int rtl8xxxu_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
@@ -7811,6 +7825,11 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
+	if (priv->fops->supports_concurrent) {
+		hw->wiphy->iface_combinations = rtl8xxxu_combinations;
+		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtl8xxxu_combinations);
+	}
+
 	sband = &rtl8xxxu_supported_band;
 	sband->ht_cap.ht_supported = true;
 	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
-- 
2.39.2


