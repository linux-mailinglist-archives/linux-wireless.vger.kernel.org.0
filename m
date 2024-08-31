Return-Path: <linux-wireless+bounces-12283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF5966ED7
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 04:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE77E285216
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 02:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F10313635C;
	Sat, 31 Aug 2024 02:06:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6542A83;
	Sat, 31 Aug 2024 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725069969; cv=none; b=WKYlzuNPqIXfZmhfDFqF7v5E6/2EYh895QFLbJUlvOqV42P2e+qtyPQDSIvhxxXjFMG6YgNbT6XmKnf+r7w0yaIpRHCzVpZSji6PmO8IhfCOB+MCc+858jyvISe+ap0T42ehmNMLZ9z85KRqSe8m5F19x4unvWNBrgzJpS2yhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725069969; c=relaxed/simple;
	bh=qiUeV++AVPkQRMdCQEQ/2YySzt8Jirg3OAg3eiNXO6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuptE63A5eaznACc95eK8zMTMwhnTrDySY7gtnP/rJcgFJSJ+uxOvVZo3Jfk8kKci/Oj5GEZNftY6dfFYJKEO9omXhiMt/+I/IVxzhkcccF3vIkMtFosRSqy7Umy0hzIXSA2YYqV/pS3yCaEo1AZAc9XCAiHjii/03rntT8JMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WwdYm3KZ4z1HHk0;
	Sat, 31 Aug 2024 10:02:04 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 20F8A1A016C;
	Sat, 31 Aug 2024 10:05:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 31 Aug
 2024 10:05:25 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <florian.fainelli@broadcom.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <heiko@sntech.de>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wellslutw@gmail.com>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
	<lizetao1@huawei.com>, <u.kleine-koenig@pengutronix.de>,
	<jacky_chou@aspeedtech.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH net-next 09/12] net: ethernet: sunplus: Convert using devm_clk_get_enabled() in spl2sw_probe()
Date: Sat, 31 Aug 2024 10:13:31 +0800
Message-ID: <20240831021334.1907921-10-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831021334.1907921-1-lizetao1@huawei.com>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Use devm_clk_get_enabled() instead of devm_clk_get() +
clk_prepare_enable(), which can make the clk consistent with the device
life cycle and reduce the risk of unreleased clk resources. Since the
device framework has automatically released the clk resource, there is
no need to execute clk_disable_unprepare(clk) on the error path, drop
the out_clk_disable label, and the original error process can return
directly. Some comments have also been adjusted.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 391a1bc7f446..5944b96900b2 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -355,8 +355,8 @@ static int spl2sw_probe(struct platform_device *pdev)
 		return ret;
 	irq = ret;
 
-	/* Get clock controller. */
-	comm->clk = devm_clk_get(&pdev->dev, NULL);
+	/* Get and enable clock controller. */
+	comm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(comm->clk)) {
 		dev_err_probe(&pdev->dev, PTR_ERR(comm->clk),
 			      "Failed to retrieve clock controller!\n");
@@ -371,10 +371,6 @@ static int spl2sw_probe(struct platform_device *pdev)
 		return PTR_ERR(comm->rstc);
 	}
 
-	/* Enable clock. */
-	ret = clk_prepare_enable(comm->clk);
-	if (ret)
-		return ret;
 	udelay(1);
 
 	/* Reset MAC */
@@ -388,7 +384,7 @@ static int spl2sw_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), comm);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq #%d!\n", irq);
-		goto out_clk_disable;
+		return ret;
 	}
 
 	/* Initialize TX and RX descriptors. */
@@ -396,7 +392,7 @@ static int spl2sw_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Fail to initialize mac descriptors!\n");
 		spl2sw_descs_free(comm);
-		goto out_clk_disable;
+		return ret;
 	}
 
 	/* Initialize MAC. */
@@ -406,7 +402,7 @@ static int spl2sw_probe(struct platform_device *pdev)
 	ret = spl2sw_mdio_init(comm);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize mdio bus!\n");
-		goto out_clk_disable;
+		return ret;
 	}
 
 	/* Get child node ethernet-ports. */
@@ -506,8 +502,6 @@ static int spl2sw_probe(struct platform_device *pdev)
 out_free_mdio:
 	spl2sw_mdio_remove(comm);
 
-out_clk_disable:
-	clk_disable_unprepare(comm->clk);
 	return ret;
 }
 
@@ -536,8 +530,6 @@ static void spl2sw_remove(struct platform_device *pdev)
 	netif_napi_del(&comm->tx_napi);
 
 	spl2sw_mdio_remove(comm);
-
-	clk_disable_unprepare(comm->clk);
 }
 
 static const struct of_device_id spl2sw_of_match[] = {
-- 
2.34.1


