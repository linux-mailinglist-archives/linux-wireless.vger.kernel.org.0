Return-Path: <linux-wireless+bounces-12385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97C969AFD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235971C23EB3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37C1B12DB;
	Tue,  3 Sep 2024 10:53:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B31B12C2
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360817; cv=none; b=SomdVJvXctt447SO1R3pJbMP8RF7/PSpxz+GBHu4fBtj+XSR9xY8VRN4ZN9oiHhS0uojLOM/rXuHb0MYqCqJHNyOFtUHToJcP3QDYhIW96speKVq3m3/T+k81mLneYLjmMqGEu4wlUzMZg9vAKD8fgcr6oqjyG5fA/0vwHckRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360817; c=relaxed/simple;
	bh=Q1SNNG9W7ef1hqVdI0Qsork16INSEJRnz5CvBADlNwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZspPKP72nyoO4sXK9PhQkcuThXVzMVfrNyQv54JAkRrQRyDV03ZbgFYuhWQ0MP9d0L7mzj0V55WOFt/tcl2xmZUtIE2Q+CDsfPH9+u3XyhclbA1y9NKWqjv4K1ybq9hE/e4cYBJEWh0jAe0lGDT0vGqnUzQ4q+2sQSahygjGz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wyj9T6Cf1zpVKJ;
	Tue,  3 Sep 2024 18:51:41 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 046B01400CA;
	Tue,  3 Sep 2024 18:53:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 18:53:32 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<kvalo@kernel.org>
CC: <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH wireless-next 2/2] wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_bus_probe()
Date: Tue, 3 Sep 2024 19:02:05 +0800
Message-ID: <20240903110205.4127706-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903110205.4127706-1-lizetao1@huawei.com>
References: <20240903110205.4127706-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
clk_prepare_enable(), which can make the clk consistent with the device
life cycle and reduce the risk of unreleased clk resources. Since the
device framework has automatically released the clk resource, there is
no need to execute clk_disable_unprepare(clk) on the error path.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 5ff940c53ad9..05b577b1068e 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -228,12 +228,11 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto netdev_cleanup;
 
-	wilc->rtc_clk = devm_clk_get_optional(&spi->dev, "rtc");
+	wilc->rtc_clk = devm_clk_get_optional_enabled(&spi->dev, "rtc");
 	if (IS_ERR(wilc->rtc_clk)) {
 		ret = PTR_ERR(wilc->rtc_clk);
 		goto netdev_cleanup;
 	}
-	clk_prepare_enable(wilc->rtc_clk);
 
 	dev_info(&spi->dev, "Selected CRC config: crc7=%s, crc16=%s\n",
 		 enable_crc7 ? "on" : "off", enable_crc16 ? "on" : "off");
@@ -266,7 +265,6 @@ static int wilc_bus_probe(struct spi_device *spi)
 	return 0;
 
 power_down:
-	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_wlan_power(wilc, false);
 netdev_cleanup:
 	wilc_netdev_cleanup(wilc);
@@ -280,7 +278,6 @@ static void wilc_bus_remove(struct spi_device *spi)
 	struct wilc *wilc = spi_get_drvdata(spi);
 	struct wilc_spi *spi_priv = wilc->bus_data;
 
-	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
 	kfree(spi_priv);
 }
-- 
2.34.1


