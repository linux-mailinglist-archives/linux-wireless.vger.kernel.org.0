Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3BE1BA190
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgD0Kmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 06:42:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbgD0Kmv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 06:42:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FBBC812F8071EDB3218;
        Mon, 27 Apr 2020 18:42:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 18:42:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] ath11k: remove redundant dev_err call in ath11k_ahb_probe()
Date:   Mon, 27 Apr 2020 10:44:03 +0000
Message-ID: <20200427104403.14598-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index e7e3e64c07aa..7d3d1cc6f39f 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -897,10 +897,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	}
 
 	mem = devm_ioremap_resource(&pdev->dev, mem_res);
-	if (IS_ERR(mem)) {
-		dev_err(&pdev->dev, "ioremap error\n");
+	if (IS_ERR(mem))
 		return PTR_ERR(mem);
-	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {



