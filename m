Return-Path: <linux-wireless+bounces-12672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00400971ADF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8811F247F4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E151BBBD3;
	Mon,  9 Sep 2024 13:21:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D321BA87C;
	Mon,  9 Sep 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888107; cv=none; b=tq945BcLKp/C7VyjvLWRWNUNto03PeEb37UMLxKOKZOZnAHt1I5GoHbn6IjrH4GE/6uFbp/CqTzxndtv2MCkVSQzU5/UhU8h40Vh103lkhtotDiDLhfKFBxyV0sKkQJ2tucTRXTfWPoHbbVwnpKqS2pKXcmU2c6v/YxcxTq6AMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888107; c=relaxed/simple;
	bh=jze/WDkvjOSczCrEalYRiDBCA1pjpN8d8RLq5RpAp5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIEFsrJZUHMsKTtfEWNRaoBpAF2AXyyIa6omgFNFOyln+1N6/EfRlleV/0vzWD5MMYfEAPrYOOSTIJ8dj8gPj50ilM/zRdk7UaxjqmN2wb2zfWNaTArx8G/HC6kmNBl4VkqxlWQMGr29w8wfaVPakkJQIktLAAw5qzrUseHL+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X2S9V1nn4zpVbQ;
	Mon,  9 Sep 2024 21:19:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A6BD180AE7;
	Mon,  9 Sep 2024 21:21:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:21:41 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<louis.peens@corigine.com>, <stefan@datenfreihafen.org>,
	<alex.aring@gmail.com>, <miquel.raynal@bootlin.com>,
	<chunkeey@googlemail.com>, <kvalo@kernel.org>, <briannorris@chromium.org>,
	<francesco@dolcini.it>, <set_pte_at@outlook.com>,
	<damien.lemoal@opensource.wdc.com>, <ruanjinjie@huawei.com>,
	<mpe@ellerman.id.au>, <horms@kernel.org>, <yinjun.zhang@corigine.com>,
	<fei.qin@corigine.com>, <johannes.berg@intel.com>, <ryno.swart@corigine.com>,
	<krzysztof.kozlowski@linaro.org>, <leitao@debian.org>,
	<liuxuenetmail@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>,
	<linux-wpan@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Mon, 9 Sep 2024 21:30:32 +0800
Message-ID: <20240909133034.1296930-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909133034.1296930-1-ruanjinjie@huawei.com>
References: <20240909133034.1296930-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes:
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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


