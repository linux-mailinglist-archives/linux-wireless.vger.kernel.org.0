Return-Path: <linux-wireless+bounces-12667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443B5971AC9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050902826BB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37E1B86FE;
	Mon,  9 Sep 2024 13:21:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A91B86F3;
	Mon,  9 Sep 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888102; cv=none; b=ZwjMo8yAk6eSo2LQva4OgcqUVJi5ZOnNW3Kktxcf2kKjUjNkdJk1NGt3qnfa/H8y23POsb3Uk6ZRKhQUq/FMSa/M2NL4mjd1ExvqlYpB/vULZWkFsTCNuD0bMl7Wfg+kQVUYKIJvVU1h1WaXbH7KWuYVi2WtQIwGUtyFY2aNaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888102; c=relaxed/simple;
	bh=aTSi26tKgP7Y9F7SzLX3HsXGP6KJBJZDLW+4YRlPO/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmS8toNuPRel6mBD7HzyOKuWe/csVbceNV7DyHMwjSsyWMhY2WYqxokHvQKIxECI0ZKiRDkAXWSadUKE+TySHlwzJZVL0WkuAT0JvT4OUYUB+uwNrsPCfwcmOx2RkbIZ1ADUiPGDpmYakIDqcYAZo3gPNH3YySglH1v6cX20l50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X2SCh66wKz1xx9s;
	Mon,  9 Sep 2024 21:21:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 718CD1A0188;
	Mon,  9 Sep 2024 21:21:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:21:37 +0800
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
Subject: [PATCH 0/7] net: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Mon, 9 Sep 2024 21:30:27 +0800
Message-ID: <20240909133034.1296930-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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
said, reqeust_irq() and then disable_irq() is unsafe.

And the code below is subobtimal:
	 irq_set_status_flags(irq, IRQ_NOAUTOEN);
	 request_irq(dev, irq...);

IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
the automatic enabling of the requested interrupt in the same safe way.
With that the usage can be simplified and corrected.

Only compile-tested.

Jinjie Ruan (7):
  net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
  net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
  nfp: Use IRQF_NO_AUTOEN flag in request_irq()
  net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
  wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
  wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
  wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()

 drivers/net/ethernet/apple/bmac.c                   | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.c        | 3 +--
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 ++---
 drivers/net/ieee802154/mcr20a.c                     | 5 +----
 drivers/net/wireless/intersil/p54/p54spi.c          | 4 +---
 drivers/net/wireless/marvell/mwifiex/main.c         | 4 ++--
 drivers/net/wireless/ti/wl1251/sdio.c               | 4 ++--
 7 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.34.1


