Return-Path: <linux-wireless+bounces-12764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3347973777
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116C21C243BA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B95192B62;
	Tue, 10 Sep 2024 12:34:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481F190676;
	Tue, 10 Sep 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971662; cv=none; b=IrUmni2AY3Hh8vniAl+hsbwosIg/Ku5YDKTC4fRyrNdGF7Kwc8q/lmryoyTS+VluAVfQ/R/9Ra1uRQnUZLIKi80Qs340RHRgo0IFuSPlodfYjda4fO8Xa+Ez1UQ8iLdlMIBJzR+MDSPbblB98vh9xC4hiD369D8z7pgX/wyQy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971662; c=relaxed/simple;
	bh=5qAplfjO5BTwpTFUSvjsNZB/HBHHyjg9WiC9zF4R/aI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqNroHU1csFLvUaiLwSKK8whJI/PVqZtKI0OHOmzC4gOovAJMH5HiapTRvPpWzd7di65tt8mF6QnoYjgFyAyCmP8LsHMgpvYN8x2HQ/T3TsxQvQoosdQjjA2iv9fCymgLDWAsolLeQqSmCfyH1hdu7JP0+5p+hli2Q6dHx7pUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X332W3Y2Cz1HJWj;
	Tue, 10 Sep 2024 20:30:43 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E5931A0188;
	Tue, 10 Sep 2024 20:34:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Sep
 2024 20:34:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chunkeey@googlemail.com>, <kvalo@kernel.org>, <briannorris@chromium.org>,
	<francesco@dolcini.it>, <krzysztof.kozlowski@linaro.org>,
	<leitao@debian.org>, <linville@tuxdriver.com>, <rajatja@google.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH wireless v2 3/3] wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Tue, 10 Sep 2024 20:43:14 +0800
Message-ID: <20240910124314.698896-4-ruanjinjie@huawei.com>
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


