Return-Path: <linux-wireless+bounces-12673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8B971AE5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A36AB23E88
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75941BBBFB;
	Mon,  9 Sep 2024 13:21:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60621BAEF5;
	Mon,  9 Sep 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888107; cv=none; b=IKAjw9FoXC+tqEVfIldZ0C1suTRIzI5x6Wbep00V9LuWRdJ6aDqITj4vjdcUYO5Bt/D7yzNDvFznXnTeKKHW2lCGFPzEAQ6+JTqbeke4BrVzJYk/gcTElWEk0z4qGJKp/3xYvU6sDQ6+V/H/xpBVErMF8rEGsePSto7xpDRLRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888107; c=relaxed/simple;
	bh=OjOBMtyXfkSW3qj3O90yZ4kigGKcUZxmqVj8CQ/3fsg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVmujVOSxmReYubsaBMrthw9OtCmlU0tvHxd62DxLY6RBCByreTFBXqNjRRJTiSr8U/FReehzcALGK9hp9QD2YEJ/8hORVHTcypvOOfsswpPAkIuzyXpRTcABlZIegTvWVzNP786VERd8zvv3bKk5VQFAf6CVtuK532JRoxZIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X2SCn5w3nz1xxBY;
	Mon,  9 Sep 2024 21:21:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BC7E1400DC;
	Mon,  9 Sep 2024 21:21:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:21:42 +0800
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
Subject: [PATCH 6/7] wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Mon, 9 Sep 2024 21:30:33 +0800
Message-ID: <20240909133034.1296930-7-ruanjinjie@huawei.com>
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

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index d99127dc466e..6c60a4c21a31 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1633,7 +1633,8 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
 	}
 
 	ret = devm_request_irq(dev, adapter->irq_wakeup,
-			       mwifiex_irq_wakeup_handler, IRQF_TRIGGER_LOW,
+			       mwifiex_irq_wakeup_handler,
+			       IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN,
 			       "wifi_wake", adapter);
 	if (ret) {
 		dev_err(dev, "Failed to request irq_wakeup %d (%d)\n",
@@ -1641,7 +1642,6 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
 		goto err_exit;
 	}
 
-	disable_irq(adapter->irq_wakeup);
 	if (device_init_wakeup(dev, true)) {
 		dev_err(dev, "fail to init wakeup for mwifiex\n");
 		goto err_exit;
-- 
2.34.1


