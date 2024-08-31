Return-Path: <linux-wireless+bounces-12275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DA966EC3
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 04:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10E2284E2D
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81B78676;
	Sat, 31 Aug 2024 02:05:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF4200DB;
	Sat, 31 Aug 2024 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725069927; cv=none; b=m848ZUHYEr3nmSCWua+a4eUQ6ZZMUWbCsOiZtQs8H3JViXPxUbn4gxB/52gssEcjN0ox0C+OFXcPffxjiDUV+UvTfp6/ARW3fK6y3785CD4EzXDojL5eYsoWUlFUhM6etGKYXWyaZ5aZBl7ykHMIspQDM9ERPGjnWPNZeDnUiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725069927; c=relaxed/simple;
	bh=5BDWnM4sgy4jnp0LYJb8l500HINoqAkfyPYVsAiszFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0Jf4Ova6H5PqPCgWDZ0nXG5NYMs9mhlQ4KAKrq4yPL2jy5v7v3T519cDHOICGBB4mQ7+OBq2/k70bqBvrOLI5YPtHOw23h8LkQgJtasF/3fRTESICt6DT9Sf+ggiHdqK0S1PSqL/rWT7S+H65AicFBAIx1s9LioyprBNDOJsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwdWy5b4Sz20nGk;
	Sat, 31 Aug 2024 10:00:30 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BFFB140109;
	Sat, 31 Aug 2024 10:05:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 31 Aug
 2024 10:05:21 +0800
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
Subject: [PATCH net-next 05/12] net: ftgmac100: Convert using devm_clk_get_enabled() in ftgmac100_setup_clk()
Date: Sat, 31 Aug 2024 10:13:27 +0800
Message-ID: <20240831021334.1907921-6-lizetao1@huawei.com>
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
the cleanup_clk label, and the original error process can return directly.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 27 ++++++------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 4c546c3aef0f..eb57c822c5ac 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1752,13 +1752,10 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	struct clk *clk;
 	int rc;
 
-	clk = devm_clk_get(priv->dev, NULL /* MACCLK */);
+	clk = devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	priv->clk = clk;
-	rc = clk_prepare_enable(priv->clk);
-	if (rc)
-		return rc;
 
 	/* Aspeed specifies a 100MHz clock is required for up to
 	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
@@ -1767,21 +1764,17 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
 			  FTGMAC_100MHZ);
 	if (rc)
-		goto cleanup_clk;
+		return rc;
 
 	/* RCLK is for RMII, typically used for NCSI. Optional because it's not
 	 * necessary if it's the AST2400 MAC, or the MAC is configured for
 	 * RGMII, or the controller is not an ASPEED-based controller.
 	 */
-	priv->rclk = devm_clk_get_optional(priv->dev, "RCLK");
-	rc = clk_prepare_enable(priv->rclk);
-	if (!rc)
-		return 0;
+	priv->rclk = devm_clk_get_optional_enabled(priv->dev, "RCLK");
+	if (IS_ERR(priv->rclk))
+		return PTR_ERR(priv->rclk);
 
-cleanup_clk:
-	clk_disable_unprepare(priv->clk);
-
-	return rc;
+	return 0;
 }
 
 static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
@@ -1996,16 +1989,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register netdev\n");
-		goto err_register_netdev;
+		goto err_phy_connect;
 	}
 
 	netdev_info(netdev, "irq %d, mapped at %p\n", netdev->irq, priv->base);
 
 	return 0;
 
-err_register_netdev:
-	clk_disable_unprepare(priv->rclk);
-	clk_disable_unprepare(priv->clk);
 err_phy_connect:
 	ftgmac100_phy_disconnect(netdev);
 err_ncsi_dev:
@@ -2034,9 +2024,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 		ncsi_unregister_dev(priv->ndev);
 	unregister_netdev(netdev);
 
-	clk_disable_unprepare(priv->rclk);
-	clk_disable_unprepare(priv->clk);
-
 	/* There's a small chance the reset task will have been re-queued,
 	 * during stop, make sure it's gone before we free the structure.
 	 */
-- 
2.34.1


