Return-Path: <linux-wireless+bounces-12674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC1971AE8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448C0B24BFD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3231BC09A;
	Mon,  9 Sep 2024 13:21:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C61BB6AD;
	Mon,  9 Sep 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888108; cv=none; b=t5LBE5ya5OyLvcoyiNEHyp0HCKNf5DC9DpSnHejQBtaKlCC5KK4q0uVc0k3aUhDhnzFA2MRragOxvjfvZqGLH9r7twARbjs1dG0RvjEUszZ7GSD3j1+GrnNxjI+bCTh+Z9TW1jW2hWOlq+5gWvVhB0/K87iIl5QSJoQdGpXiMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888108; c=relaxed/simple;
	bh=5qAplfjO5BTwpTFUSvjsNZB/HBHHyjg9WiC9zF4R/aI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfkED0MP0gkn2nmbA2Fl5m5RYpakwKOLLTyC4RQMpQ7sHJgDR9CDUUaNMTPUubDatAvYnKuqxAv5aayhpqBjZ3ao5QoWkj3trba3ajiRlHSlxNJ0YJpKsZO43xLhyl7gjTS9lepC1u7wEceoMAltB1iBJQA7InqbKKqMsykCwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2SCK2mZ9z2Dc1B;
	Mon,  9 Sep 2024 21:21:17 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 43029180041;
	Mon,  9 Sep 2024 21:21:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:21:43 +0800
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
Subject: [PATCH 7/7] wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Mon, 9 Sep 2024 21:30:34 +0800
Message-ID: <20240909133034.1296930-8-ruanjinjie@huawei.com>
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

As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
said, the code below is subobtimal. IRQF_NO_AUTOEN flag can be used by
drivers to request_irq(). It prevents the automatic enabling of the
requested interrupt in the same safe way. With that the usage can be
simplified and corrected.

	irq_set_status_flags(irq, IRQ_NOAUTOEN);
	request_irq(dev, irq...);

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/wireless/ti/wl1251/sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index c705081249d6..b45050243129 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -233,8 +233,8 @@ static int wl1251_sdio_probe(struct sdio_func *func,
 	}
 
 	if (wl->irq) {
-		irq_set_status_flags(wl->irq, IRQ_NOAUTOEN);
-		ret = request_irq(wl->irq, wl1251_line_irq, 0, "wl1251", wl);
+		ret = request_irq(wl->irq, wl1251_line_irq, IRQF_NO_AUTOEN,
+				  "wl1251", wl);
 		if (ret < 0) {
 			wl1251_error("request_irq() failed: %d", ret);
 			goto disable;
-- 
2.34.1


