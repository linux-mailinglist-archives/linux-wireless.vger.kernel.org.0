Return-Path: <linux-wireless+bounces-14301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC09A9DF6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532A51F2729F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0787193427;
	Tue, 22 Oct 2024 09:09:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBA186E3A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588183; cv=none; b=dG++7vSEDJ1dKs4XN2Rws0HXZEV5i/KhJI1MyCtN6q/93afEossdBh8Fq2UFVX/GqqKAKM5mfObjP96nnAsZC5jmoPiqC7z7gqxu4UV6m3VA0KlsG66yTMRUtoek+GJ0LOMwKfHgxKcD0CcvgyRp6E5gjXEX+PETY1Gt4eNn4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588183; c=relaxed/simple;
	bh=rzz/fnSqoJjiJAXwqdvLtiuC9+JDqvdJvwk9E3erKHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XW7RQGm0DGR+SmnNCrQOznMLRDXI9pGPI7y13tSTgbm4nvG5Gw9RnjLB5ElikEOpK9cjNK0jACC3K/tL3dD8xCqL49KvIi0lmAnhDuA1k1MSemkNT7sZJVACbchpPTT/g+/Khya5H7iQ78EKhTMrtl5Mnm0gPw4rUObwXG8HqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XXmYV3hckz1SD7T;
	Tue, 22 Oct 2024 17:08:14 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E33C31400CB;
	Tue, 22 Oct 2024 17:09:36 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 17:09:36 +0800
From: Yuan Can <yuancan@huawei.com>
To: <jerome.pouiller@silabs.com>, <kvalo@kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH] wifi: wfx: Fix error handling in wfx_core_init()
Date: Tue, 22 Oct 2024 17:04:53 +0800
Message-ID: <20241022090453.84679-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)

The wfx_core_init() returns without checking the retval from
sdio_register_driver().
If the sdio_register_driver() failed, the module failed to install,
leaving the wfx_spi_driver not unregistered.

Fixes: a7a91ca5a23d ("staging: wfx: add infrastructure for new driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/net/wireless/silabs/wfx/main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index e7198520bdff..64441c8bc460 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -480,10 +480,23 @@ static int __init wfx_core_init(void)
 {
 	int ret = 0;
 
-	if (IS_ENABLED(CONFIG_SPI))
+	if (IS_ENABLED(CONFIG_SPI)) {
 		ret = spi_register_driver(&wfx_spi_driver);
-	if (IS_ENABLED(CONFIG_MMC) && !ret)
+		if (ret)
+			goto out;
+	}
+	if (IS_ENABLED(CONFIG_MMC)) {
 		ret = sdio_register_driver(&wfx_sdio_driver);
+		if (ret)
+			goto unregister_spi;
+	}
+
+	return 0;
+
+unregister_spi:
+	if (IS_ENABLED(CONFIG_SPI))
+		spi_unregister_driver(&wfx_spi_driver);
+out:
 	return ret;
 }
 module_init(wfx_core_init);
-- 
2.17.1


