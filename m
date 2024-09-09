Return-Path: <linux-wireless+bounces-12696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597CC9722C0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127FD28497B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226F18B498;
	Mon,  9 Sep 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="s032QFgC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44018B464;
	Mon,  9 Sep 2024 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910266; cv=none; b=TC0Ep7yBBMHRv+TOpDadY7DlX8TRxYb3AdvYPGyqcftKpKJou5klE2QqHxJMGQ8LnGj0Mi6yoUvXVGlqS/Hp8XKp5wGwehegLiKCYitIQPePlbQNR+6rFd1oQkdqgnA0ugY2pMFnqXk5YqKQZDtu+gMRQwkcYtyi7digMS/7oHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910266; c=relaxed/simple;
	bh=4SUjgUsSqVlCSPxgNF5C5NVcSQ9+yh0Tz4qS1izmwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNM3vtX2OP/+UzbwzHZxo80hyTHLHswWoHugRmQu2F5s2nK/oVeGYlzRP2WWC7SEsPtTsj9cs6LsVjNgFYd5mHVT+l2cj42i+qJDfF53WgAwkzbN0gMdL9j6eVj1H5LbBq9gbajmGr+OIX+x7zB6GolMTjdOGUZyWwwnETFNeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=s032QFgC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 13AE888E24;
	Mon,  9 Sep 2024 21:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725910256;
	bh=aRska+e6IEuhBaEApyn0DJC2F90zGOrhaYd8JxEYKzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s032QFgCKTN7au98hkPANvYTPXNdEoy+jsVGL0LjdCR8dpVKyX70qE7joHIKeTsfY
	 vEokwJx1v0lmvslVqiurZtSIXgHwgDcw4Bz3Xl7MuKrbldeZOQUatFsCUC7b12Sth7
	 TaLox5dm7dXdToiiolkgf1XNd7xcj9RySvtUwhesT6M5RU2j+RQ2wJbPdYINZxci/j
	 x51efOeXCRIp7Ql0iajOyyexEiFpjKIRBMT9E7eJARkh0mZlhQwXRYK+T56EBBeZF0
	 UL5LEPMgpBzvPT8iN7q6zH/+MXD6OP5k5v3HSPjfAN6gxZt5cFRn3FuEJi2C25VwwR
	 /8CQRpFMNTq0Q==
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
Subject: [PATCH v5 7/9] wifi: wilc1000: Get chipid early
Date: Mon,  9 Sep 2024 21:29:48 +0200
Message-ID: <20240909193035.69823-7-marex@denx.de>
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

Export wilc_get_chipid() again and call it in driver probe to get
wilc->chipid assigned early on. This is necessary to discern WILC
1000 from 3000 to disable WPA3/SAE on the later.

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
 drivers/net/wireless/microchip/wilc1000/sdio.c | 4 ++++
 drivers/net/wireless/microchip/wilc1000/spi.c  | 2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 6d01a838ab184..01a96d0f562a6 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -177,6 +177,10 @@ static int wilc_sdio_probe(struct sdio_func *func,
 
 	wilc_sdio_init(wilc, false);
 
+	ret = wilc_get_chipid(wilc);
+	if (ret)
+		goto clk_disable_unprepare;
+
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 5ff940c53ad9c..1b60a13df6cfa 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -246,7 +246,7 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (ret)
 		goto power_down;
 
-	ret = wilc_validate_chipid(wilc);
+	ret = wilc_get_chipid(wilc);
 	if (ret)
 		goto power_down;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 01476f8ecc36f..1aab8eca58169 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1456,7 +1456,7 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 	return ret;
 }
 
-static int wilc_get_chipid(struct wilc *wilc)
+int wilc_get_chipid(struct wilc *wilc)
 {
 	u32 chipid = 0;
 	u32 rfrevid = 0;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index 4e2b0c4ac1e21..552590823e444 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -441,5 +441,6 @@ int host_sleep_notify(struct wilc *wilc);
 int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
+int wilc_get_chipid(struct wilc *wilc);
 int wilc_load_mac_from_nv(struct wilc *wilc);
 #endif
-- 
2.45.2


