Return-Path: <linux-wireless+bounces-12669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16F971AD1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA551C22F27
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073AB1BA870;
	Mon,  9 Sep 2024 13:21:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3D1B9859;
	Mon,  9 Sep 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888104; cv=none; b=FSY98avxKyrI8A7QhljQIGmn0iX5185TNkf5YyiS8n6UnlXx3wP+qD4eetaYhR/OwOc2f26MOGiU1WNxkBJb87sC2nx69brURh56YmGy+2/FZUQ3WKQ1hb2ueogbwfmQeQ9HhYKUNkpzT202clP0zR2hDCE4HJWodUVCCSJ1FP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888104; c=relaxed/simple;
	bh=0b4C/Vuwv4I8ylfIxQnqvclm7T7YhfibBjMkZOyYo4k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lR5RwsvJN73I7f+bFO54zbXrnCBtV1qfJQL9by0kSOtfKY3JLmjbeTxzcfZqhbuEMffLe0u7rsHJyclCbr+351jtXM6uNPcVQrpjyFbn1wHqTVz80Y6ike3gk0kO9rgGpxabNp3f1HU9aNaMROZx2Klh7iJzeNFTP51W3lOO8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2SCD4Gpzz1j8Mb;
	Mon,  9 Sep 2024 21:21:12 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C19A140361;
	Mon,  9 Sep 2024 21:21:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:21:38 +0800
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
Subject: [PATCH 1/7] net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Mon, 9 Sep 2024 21:30:28 +0800
Message-ID: <20240909133034.1296930-2-ruanjinjie@huawei.com>
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
 drivers/net/ethernet/apple/bmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 292b1f9cd9e7..785f4b4ff758 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -1317,7 +1317,7 @@ static int bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 
 	timer_setup(&bp->tx_timeout, bmac_tx_timeout, 0);
 
-	ret = request_irq(dev->irq, bmac_misc_intr, 0, "BMAC-misc", dev);
+	ret = request_irq(dev->irq, bmac_misc_intr, IRQF_NO_AUTOEN, "BMAC-misc", dev);
 	if (ret) {
 		printk(KERN_ERR "BMAC: can't get irq %d\n", dev->irq);
 		goto err_out_iounmap_rx;
@@ -1336,7 +1336,6 @@ static int bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 	/* Mask chip interrupts and disable chip, will be
 	 * re-enabled on open()
 	 */
-	disable_irq(dev->irq);
 	pmac_call_feature(PMAC_FTR_BMAC_ENABLE, macio_get_of_node(bp->mdev), 0, 0);
 
 	if (register_netdev(dev) != 0) {
-- 
2.34.1


