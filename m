Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10A22558B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 03:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGTBnv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jul 2020 21:43:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTBnv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jul 2020 21:43:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 442BA402F41282D15FAA
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jul 2020 09:43:48 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 09:43:40 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zajec5@gmail.com>, <linux-wireless@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH] drivers: bcma: remove set but not used variable `addrh` and `sizeh`
Date:   Mon, 20 Jul 2020 09:44:41 +0800
Message-ID: <20200720014441.21893-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/bcma/scan.c: In function 'bcma_erom_get_addr_desc':
drivers/bcma/scan.c:219 warning:
variable `addrh` and `sizeh` set but not used [-Wunused-but-set-variable]

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/bcma/scan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 1a942f734188..d49e7c0de2b6 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -219,7 +219,7 @@ static s32 bcma_erom_get_mst_port(struct bcma_bus *bus, u32 __iomem **eromptr)
 static u32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 __iomem **eromptr,
 				  u32 type, u8 port)
 {
-	u32 addrl, addrh, sizeh = 0;
+	u32 addrl;
 	u32 size;
 
 	u32 ent = bcma_erom_get_ent(bus, eromptr);
@@ -233,14 +233,12 @@ static u32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 __iomem **eromptr,
 
 	addrl = ent & SCAN_ADDR_ADDR;
 	if (ent & SCAN_ADDR_AG32)
-		addrh = bcma_erom_get_ent(bus, eromptr);
-	else
-		addrh = 0;
+		bcma_erom_get_ent(bus, eromptr);
 
 	if ((ent & SCAN_ADDR_SZ) == SCAN_ADDR_SZ_SZD) {
 		size = bcma_erom_get_ent(bus, eromptr);
 		if (size & SCAN_SIZE_SG32)
-			sizeh = bcma_erom_get_ent(bus, eromptr);
+			bcma_erom_get_ent(bus, eromptr);
 	}
 
 	return addrl;
-- 
2.17.1

