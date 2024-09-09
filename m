Return-Path: <linux-wireless+bounces-12670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13778971AD5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86BFCB20BB9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B61BA87D;
	Mon,  9 Sep 2024 13:21:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5B1B86E6;
	Mon,  9 Sep 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888105; cv=none; b=V5Wn0Pwunj2v3Sb6zy0JMI8D84eGk971jc+bt2iNZ6cXf+LvubpC4LvuHRS8DUCZFkpqhwrM7thcq1xPKogcstEV0zdeCBplEsomlYqwibnbhL2PByln2frZW+6cId6QAZWJWQFAwJyELb0wuMDJ3ZKpCR5QXkaU529OsyPKo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888105; c=relaxed/simple;
	bh=14G2yxnR16Xq95zsXhnuAQ+zX26+M91rNzW+wVNNaKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWwdwqbOoABZQhYlsxJEugwUQ7OYjRwggEo7WWPONy9NM59Gm+UeNXV40v8erFEPEilSpUVMhov0R2lVKipEW/Xm3IF4AZtVdcbqLhATmSJk2cLGnLVEk6vp8jOcjh/m51Rwgk4Im9PMCKvw+h/nIBEUJYqjv+9gxPA+uqTwFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X2SCh0JQtz69Ns;
	Mon,  9 Sep 2024 21:21:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2490B1402CF;
	Mon,  9 Sep 2024 21:21:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:21:39 +0800
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
Subject: [PATCH 2/7] net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Mon, 9 Sep 2024 21:30:29 +0800
Message-ID: <20240909133034.1296930-3-ruanjinjie@huawei.com>
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

Fixes: bbb96dc7fa1a ("enetc: Factor out the traffic start/stop procedures")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5c45f42232d3..f04f42ea60c0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2305,12 +2305,11 @@ static int enetc_setup_irqs(struct enetc_ndev_priv *priv)
 
 		snprintf(v->name, sizeof(v->name), "%s-rxtx%d",
 			 priv->ndev->name, i);
-		err = request_irq(irq, enetc_msix, 0, v->name, v);
+		err = request_irq(irq, enetc_msix, IRQF_NO_AUTOEN, v->name, v);
 		if (err) {
 			dev_err(priv->dev, "request_irq() failed!\n");
 			goto irq_err;
 		}
-		disable_irq(irq);
 
 		v->tbier_base = hw->reg + ENETC_BDR(TX, 0, ENETC_TBIER);
 		v->rbier = hw->reg + ENETC_BDR(RX, i, ENETC_RBIER);
-- 
2.34.1


