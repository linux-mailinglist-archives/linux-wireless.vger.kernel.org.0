Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7838D553
	for <lists+linux-wireless@lfdr.de>; Sat, 22 May 2021 12:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhEVKzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 May 2021 06:55:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5739 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhEVKzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 May 2021 06:55:20 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnKxn3bhPzqV32;
        Sat, 22 May 2021 18:50:21 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:53:54 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 22 May
 2021 18:53:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
CC:     <kvalo@codeaurora.org>
Subject: [PATCH -next 1/2] ath10k: go to path err_unsupported when chip id is not supported
Date:   Sat, 22 May 2021 18:58:21 +0800
Message-ID: <20210522105822.1091848-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210522105822.1091848-1-yangyingliang@huawei.com>
References: <20210522105822.1091848-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When chip id is not supported, it go to path err_unsupported
to print the error message.

Fixes: f8914a14623a ("ath10k: restore QCA9880-AR1A (v1) detection")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/wireless/ath/ath10k/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index e7fde635e0ee..463cf3f8f8a5 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3701,7 +3701,7 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
 		goto err_unsupported;
 
 	if (!ath10k_pci_chip_is_supported(pdev->device, bus_params.chip_id))
-		goto err_free_irq;
+		goto err_unsupported;
 
 	ret = ath10k_core_register(ar, &bus_params);
 	if (ret) {
-- 
2.25.1

