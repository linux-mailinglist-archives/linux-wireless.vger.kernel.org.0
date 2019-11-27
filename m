Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87B310AF7F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 13:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0MX0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 07:23:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfK0MX0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 07:23:26 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 04670F25B047DEF24081;
        Wed, 27 Nov 2019 20:23:22 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 20:23:13 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <zajec5@gmail.com>, <linville@tuxdriver.com>,
        <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] bcma: remove set but not used variable 'sizel'
Date:   Wed, 27 Nov 2019 20:44:33 +0800
Message-ID: <20191127124433.34301-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/bcma/scan.c: In function ‘bcma_erom_get_addr_desc’:

drivers/bcma/scan.c:222:20: warning: variable ‘sizel’ set but
not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Fixes: 8369ae33b705 ("bcma: add Broadcom specific AMBA bus driver")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/bcma/scan.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 4a2d1b235fb5..1f2de714b401 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -219,7 +219,7 @@ static s32 bcma_erom_get_mst_port(struct bcma_bus *bus, u32 __iomem **eromptr)
 static u32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 __iomem **eromptr,
 				  u32 type, u8 port)
 {
-	u32 addrl, addrh, sizel, sizeh = 0;
+	u32 addrl, addrh, sizeh = 0;
 	u32 size;
 
 	u32 ent = bcma_erom_get_ent(bus, eromptr);
@@ -239,12 +239,9 @@ static u32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 __iomem **eromptr,
 
 	if ((ent & SCAN_ADDR_SZ) == SCAN_ADDR_SZ_SZD) {
 		size = bcma_erom_get_ent(bus, eromptr);
-		sizel = size & SCAN_SIZE_SZ;
 		if (size & SCAN_SIZE_SG32)
 			sizeh = bcma_erom_get_ent(bus, eromptr);
-	} else
-		sizel = SCAN_ADDR_SZ_BASE <<
-				((ent & SCAN_ADDR_SZ) >> SCAN_ADDR_SZ_SHIFT);
+	}
 
 	return addrl;
 }
-- 
2.17.2

