Return-Path: <linux-wireless+bounces-7651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D485B8C590F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1199A1C21550
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087D17F370;
	Tue, 14 May 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QHKfaRwJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DB17EBA5;
	Tue, 14 May 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701892; cv=none; b=oFqTTuzecUgV8/URWzbSbBSSz3wWjtSiUsW/NuIAVMkTzuTmWzEoUdru2GsKg2ZyoW1yc7iJZjIZq7WBgl54sc5Ks1V/cUuGeC5ADmu8JugUvIECxGIQMp5TBkUfxtGhn3wQlr45PAGeRHVSbP5eGNpmcSQzNAC5Qcu8rChxNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701892; c=relaxed/simple;
	bh=XoA0b3u13bVRZxpHWJ41pkwszN/m5KwjeFNwYKuSfP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQeoYkkPut3rmZMzA9ZgiY2GKwXyhfsqepe0CU1mQ0KuXsvsT1V7HS5M4jmSsdNDtmqQVnXJjI+yrfyYljvkvnundnRJexQNjFloppUxo3KOfsbDdntgyzo9WtHEufGWFfoi0OoMT7FbD7sg8geT4SIGhDjLrip3AoY6STOjKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QHKfaRwJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B17E11C0006;
	Tue, 14 May 2024 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/q1zVDoqEbRtn4br8zecJV6ThTUPNCtWDfIqMVXyJZQ=;
	b=QHKfaRwJsSXr4ytLxa3lq+qbaeXezirBmiMbFh9mcu1vWutVz8C52TDQD//FAYAuBrgizA
	ugbclEjEOS72WV1ibmYdwwCzA+CYpGHuF8AcJoLjO+fZmEQv7dRqRNiHCgK02Uaz+zKJ/9
	xxa+8hp0q4E4xLyHi/DFl578dMxg00gqtbOJWX7oeHVku03G/j1Ya+KN8kDRWQtxN+j31Q
	PGuv+JcVmmkn79ulHyxEX3nXUNaZhT38C4KxCrZfrTjgEQGhRn/okFJouU5rMAzDnm5uRo
	8nLGC6Y01vgwp8haTzRIdQEqPBJkIPlnSesB1LSFV2jPCCz/aKDvH/KCcxVobA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 May 2024 17:51:21 +0200
Subject: [PATCH v2 3/6] wifi: wilc1000: set wilc_set_mac_address parameter
 as const
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-mac_addr_at_probe-v2-3-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
In-Reply-To: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Any attempt to provide a const mac address to wilc_set_mac_address results
in the following warning:

warning: passing argument 2 of 'wilc_set_mac_address' discards 'const'
qualifier from pointer target type [-Wdiscarded-qualifiers]
[...]
drivers/net/wireless/microchip/wilc1000/hif.h:170:52: note: expected 'u8 *'
{aka 'unsigned char *'} but argument is of type 'const unsigned char *'a
int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr);

Instead of using an explicit cast each time we need provide a MAC address,
set the function parameter as const

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c    | 4 ++--
 drivers/net/wireless/microchip/wilc1000/hif.h    | 2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 919de6ffb821..c6892b7e190f 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1293,7 +1293,7 @@ int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr)
 	return result;
 }
 
-int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr)
+int wilc_set_mac_address(struct wilc_vif *vif, const u8 *mac_addr)
 {
 	struct wid wid;
 	int result;
@@ -1301,7 +1301,7 @@ int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr)
 	wid.id = WID_MAC_ADDR;
 	wid.type = WID_STR;
 	wid.size = ETH_ALEN;
-	wid.val = mac_addr;
+	wid.val = (u8 *)mac_addr;
 
 	result = wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
 	if (result)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index 0d380586b1d9..96eeaf31d237 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -167,7 +167,7 @@ int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len,
 		    u8 cipher_mode);
 int wilc_set_pmkid_info(struct wilc_vif *vif, struct wilc_pmkid_attr *pmkid);
 int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr);
-int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr);
+int wilc_set_mac_address(struct wilc_vif *vif, const u8 *mac_addr);
 int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
 		      size_t ies_len);
 int wilc_disconnect(struct wilc_vif *vif);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 166165ee7712..2ee3d9827826 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -678,7 +678,7 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	}
 	rcu_read_unlock();
 
-	result = wilc_set_mac_address(vif, (u8 *)addr->sa_data);
+	result = wilc_set_mac_address(vif, addr->sa_data);
 	if (result)
 		return result;
 

-- 
2.44.0


