Return-Path: <linux-wireless+bounces-12762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9248973773
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1FD1C24E7A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31291917FF;
	Tue, 10 Sep 2024 12:34:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E39191466;
	Tue, 10 Sep 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971661; cv=none; b=al0ZJL+MddDKGjdF/OKcfcKw79hZL3R57q6MHuQnL5t/gCAAjJcdNOEJT1xg10X1t3MzITPB4UxAnmGH2Vj/+D6tSvjXQCSXzo9pVlDmFCuS1pgqXRKpMFTquypWd1AleqJca1mTxqytE77EL2uPCYDuTvLNk+6MxrbS4odWYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971661; c=relaxed/simple;
	bh=Hicim2PjBxHs6NGlSn2TxDuRxPKJVveWprA70zcV8q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sT624tEp/MS9rsucm/xSfB1ZiyBgyBiyvA6Up4YC2gpryVjMJP2AYaI1SKscORptMnZ5CmbBNtcOrLGw69Er0yG5BaRJ9p4j7fAIdjDoKBITLl1MIioKtu9iKQa1d3WHpOu1EG5rhTND0dSViofYQH6dnBFOY9mxMJ73iARlUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X334G6726zpVVP;
	Tue, 10 Sep 2024 20:32:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B0390140158;
	Tue, 10 Sep 2024 20:34:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Sep
 2024 20:34:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chunkeey@googlemail.com>, <kvalo@kernel.org>, <briannorris@chromium.org>,
	<francesco@dolcini.it>, <krzysztof.kozlowski@linaro.org>,
	<leitao@debian.org>, <linville@tuxdriver.com>, <rajatja@google.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH wireless v2 1/3] wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Tue, 10 Sep 2024 20:43:12 +0800
Message-ID: <20240910124314.698896-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910124314.698896-1-ruanjinjie@huawei.com>
References: <20240910124314.698896-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: cd8d3d321285 ("p54spi: p54spi driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add fix tag.
- Wireless patches go to wireless-next, submit them in a separate patchset.
---
 drivers/net/wireless/intersil/p54/p54spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index d33a994906a7..27f44a9f0bc1 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -624,7 +624,7 @@ static int p54spi_probe(struct spi_device *spi)
 	gpio_direction_input(p54spi_gpio_irq);
 
 	ret = request_irq(gpio_to_irq(p54spi_gpio_irq),
-			  p54spi_interrupt, 0, "p54spi",
+			  p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi",
 			  priv->spi);
 	if (ret < 0) {
 		dev_err(&priv->spi->dev, "request_irq() failed");
@@ -633,8 +633,6 @@ static int p54spi_probe(struct spi_device *spi)
 
 	irq_set_irq_type(gpio_to_irq(p54spi_gpio_irq), IRQ_TYPE_EDGE_RISING);
 
-	disable_irq(gpio_to_irq(p54spi_gpio_irq));
-
 	INIT_WORK(&priv->work, p54spi_work);
 	init_completion(&priv->fw_comp);
 	INIT_LIST_HEAD(&priv->tx_pending);
-- 
2.34.1


