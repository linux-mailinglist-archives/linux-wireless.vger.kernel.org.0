Return-Path: <linux-wireless+bounces-12694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F29722BB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40B51C2227E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDC318A922;
	Mon,  9 Sep 2024 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="U1CdgNN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DF179202;
	Mon,  9 Sep 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910262; cv=none; b=T6+RIDQ3hzuLm5+2hibwef0T8DH9+1goT+RxR45+2OrwljT3sgpbL0UoPeAUDNILtjktlx1v2rE2SZsl4115unIrvLMFs7DH18L8Frr/Ip5NJ59xHLQ3ymM6LGcJMciz07iIWTbS3T67ywO5zyjtZEj3/nc/sLvdnLCbP63mT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910262; c=relaxed/simple;
	bh=TGsM2nbsgYeN1qvun3GmhvoA72IQJgGmewH4XXBbxTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOWNDAOhEgWxdQQqhpKUApfPVrvkE+n0ApDKpE5Zh1B9igjh0EaP72UvQAMx5OB+o9OKU0ftOZMOQzzVYCJA7mX+BcUdpZrlgvBJDf/+1yO0UM96JU7kwuHYDObuicWUMslRSPwrTOqEoRuVyTj9acQiwwM/QGmWOSEVEuSoxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=U1CdgNN6; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9867C88D08;
	Mon,  9 Sep 2024 21:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725910256;
	bh=LL276++mvlxqbQAS+Owso/jjjlzOFM6kcl7PROOgzQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1CdgNN6LX1zTwbI/fB9d67DEFhxCor9UT586WL+MvF6YC48mOcK0IvDanS6goWlq
	 u0yVeZN4cLAH3yIrHMDOW+BrS53CFGr6dnsJei4td3fSZrTjoUI6wdG49X8sUFRnT2
	 fNQ0q3KT6ApqLOeDIGUDLut2yq6dwCl5/jakXNDQ8wyD2lHRx02rahQBvRMPk0JFs9
	 9TdIQ74L1Sg/yKgnBTHR9A1CuwEOeAYMFJ67cSBsBz+Exa0ZDwkJiDQhDfj05q1b8v
	 bsD3JELumjP8NgzOAOmP1oFq8XPpHjtZb4HJ2EO24X3Dhjr0ndqcfqH8to71fZMgbL
	 gPn/bit5+/uew==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 6/9] wifi: wilc1000: Remove cmd53_buf() allocation
Date: Mon,  9 Sep 2024 21:29:47 +0200
Message-ID: <20240909193035.69823-6-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909193035.69823-1-marex@denx.de>
References: <20240909193035.69823-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The cmd53_buf is a 4 byte buffer, embed it into the struct wilc_sdio.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V5: New patch
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index c26447289b71b..6d01a838ab184 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -31,7 +31,7 @@ struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
 	bool isinit;
-	u8 *cmd53_buf;
+	u8 cmd53_buf[4];
 };
 
 struct sdio_cmd52 {
@@ -149,12 +149,6 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	if (!sdio_priv)
 		return -ENOMEM;
 
-	sdio_priv->cmd53_buf = kzalloc(sizeof(u32), GFP_KERNEL);
-	if (!sdio_priv->cmd53_buf) {
-		ret = -ENOMEM;
-		goto free;
-	}
-
 	ret = wilc_cfg80211_init(&wilc, &func->dev, WILC_HIF_SDIO,
 				 &wilc_hif_sdio);
 	if (ret)
@@ -207,7 +201,6 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
 free:
-	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 	return ret;
 }
@@ -219,7 +212,6 @@ static void wilc_sdio_remove(struct sdio_func *func)
 
 	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
-	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 }
 
-- 
2.45.2


