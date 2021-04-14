Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEA35ED45
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhDNGjs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 02:39:48 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56008 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231917AbhDNGjr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 02:39:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UVWtqZM_1618382358;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWtqZM_1618382358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:39:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     zajec5@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] bcma: remove unused function
Date:   Wed, 14 Apr 2021 14:39:14 +0800
Message-Id: <1618382354-866-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following clang warning:

drivers/bcma/driver_mips.c:55:20: warning: unused function
'mips_write32' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/bcma/driver_mips.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 87760aa..12aca34 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -52,13 +52,6 @@ static inline u32 mips_read32(struct bcma_drv_mips *mcore,
 	return bcma_read32(mcore->core, offset);
 }
 
-static inline void mips_write32(struct bcma_drv_mips *mcore,
-				u16 offset,
-				u32 value)
-{
-	bcma_write32(mcore->core, offset, value);
-}
-
 static u32 bcma_core_mips_irqflag(struct bcma_device *dev)
 {
 	u32 flag;
-- 
1.8.3.1

