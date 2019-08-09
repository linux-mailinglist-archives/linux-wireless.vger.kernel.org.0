Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE64874A1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406010AbfHIIyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 04:54:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405785AbfHIIyI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 04:54:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4523D7AD945B9D40BD57;
        Fri,  9 Aug 2019 16:54:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:53:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zajec5@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] bcma: remove two unused variables
Date:   Fri, 9 Aug 2019 16:53:08 +0800
Message-ID: <20190809085308.69748-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

drivers/bcma/driver_mips.c:70:18: warning:
 ipsflag_irq_shift defined but not used [-Wunused-const-variable=]
drivers/bcma/driver_mips.c:62:18: warning:
 ipsflag_irq_mask defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/bcma/driver_mips.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 27e9686..87760aa 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -59,22 +59,6 @@ static inline void mips_write32(struct bcma_drv_mips *mcore,
 	bcma_write32(mcore->core, offset, value);
 }
 
-static const u32 ipsflag_irq_mask[] = {
-	0,
-	BCMA_MIPS_IPSFLAG_IRQ1,
-	BCMA_MIPS_IPSFLAG_IRQ2,
-	BCMA_MIPS_IPSFLAG_IRQ3,
-	BCMA_MIPS_IPSFLAG_IRQ4,
-};
-
-static const u32 ipsflag_irq_shift[] = {
-	0,
-	BCMA_MIPS_IPSFLAG_IRQ1_SHIFT,
-	BCMA_MIPS_IPSFLAG_IRQ2_SHIFT,
-	BCMA_MIPS_IPSFLAG_IRQ3_SHIFT,
-	BCMA_MIPS_IPSFLAG_IRQ4_SHIFT,
-};
-
 static u32 bcma_core_mips_irqflag(struct bcma_device *dev)
 {
 	u32 flag;
-- 
2.7.4


