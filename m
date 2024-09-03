Return-Path: <linux-wireless+bounces-12386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA90969AFE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422921F24BBC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A461B12D5;
	Tue,  3 Sep 2024 10:53:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8961B12C1
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360817; cv=none; b=Biefn2G6g7dg1eI4AhuSlIhAdl8tLjfZGzlcmb6gnmpgbEQdj7/AVaMKXu2P6cgoJGNOsEaHR+0B9wMQ2x0I3rL1Jw/zTrQNzJrUGuf6O8YKeOw3qyFbIzViZ/IdCuBAAhFQmlskQsYC0roQJ9kJFFeAU7dL7yWsx3Vjnz01JEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360817; c=relaxed/simple;
	bh=XXaSyRz4jVXQCNfUM/WwpnTW0LR/5eni4LuVbJ82wgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdbtoyPH7sFkreBOBc9RAQrUPQd1r60IB5Eobd54E8qcG7xTcitBGaT7cxM/BTlLwtAumRe2T3f+Vcd1ll4/KKAP+HAJkV+s0zh6neOibEsUoJxus6T78yKkRgId6lzpEX9DbhoQF7870OsjCTsFezei9nU3Q63SpyVB3WEJl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WyjBv5cbBzyRRf;
	Tue,  3 Sep 2024 18:52:55 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B67021800A7;
	Tue,  3 Sep 2024 18:53:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 18:53:32 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<kvalo@kernel.org>
CC: <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH wireless-next 1/2] wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_sdio_probe()
Date: Tue, 3 Sep 2024 19:02:04 +0800
Message-ID: <20240903110205.4127706-2-lizetao1@huawei.com>
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
no need to execute clk_disable_unprepare(clk) on the error path, drop
the clk_disable_unprepare label, and the original error process can change
to dispose_irq.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 0043f7a0fdf9..a09ea24074e2 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -174,19 +174,18 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	wilc->bus_data = sdio_priv;
 	wilc->dev = &func->dev;
 
-	wilc->rtc_clk = devm_clk_get_optional(&func->card->dev, "rtc");
+	wilc->rtc_clk = devm_clk_get_optional_enabled(&func->card->dev, "rtc");
 	if (IS_ERR(wilc->rtc_clk)) {
 		ret = PTR_ERR(wilc->rtc_clk);
 		goto dispose_irq;
 	}
-	clk_prepare_enable(wilc->rtc_clk);
 
 	wilc_sdio_init(wilc, false);
 
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
-		goto clk_disable_unprepare;
+		goto dispose_irq;
 	}
 
 	wilc_sdio_deinit(wilc);
@@ -195,14 +194,12 @@ static int wilc_sdio_probe(struct sdio_func *func,
 				   NL80211_IFTYPE_STATION, false);
 	if (IS_ERR(vif)) {
 		ret = PTR_ERR(vif);
-		goto clk_disable_unprepare;
+		goto dispose_irq;
 	}
 
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
 
-clk_disable_unprepare:
-	clk_disable_unprepare(wilc->rtc_clk);
 dispose_irq:
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
@@ -217,7 +214,6 @@ static void wilc_sdio_remove(struct sdio_func *func)
 	struct wilc *wilc = sdio_get_drvdata(func);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
 
-	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
 	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
-- 
2.34.1


