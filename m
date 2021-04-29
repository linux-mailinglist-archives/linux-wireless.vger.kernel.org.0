Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D536E905
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 12:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbhD2KsD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 06:48:03 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56116 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240486AbhD2KsC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 06:48:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UX9hZFR_1619693232;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UX9hZFR_1619693232)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 18:47:13 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     m@bues.ch
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ssb: Remove redundant assignment to err
Date:   Thu, 29 Apr 2021 18:47:10 +0800
Message-Id: <1619693230-108804-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Variable 'err' is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

drivers/ssb/main.c:1306:3: warning: Value stored to 'err' is never read
[clang-analyzer-deadcode.DeadStores]
drivers/ssb/main.c:1312:3: warning: Value stored to 'err' is never read
[clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ssb/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984..ab23554 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -1303,13 +1303,11 @@ static int __init ssb_modinit(void)
 	if (err) {
 		pr_err("Broadcom 43xx PCI-SSB-bridge initialization failed\n");
 		/* don't fail SSB init because of this */
-		err = 0;
 	}
 	err = ssb_host_pcmcia_init();
 	if (err) {
 		pr_err("PCMCIA host initialization failed\n");
 		/* don't fail SSB init because of this */
-		err = 0;
 	}
 	err = ssb_gige_init();
 	if (err) {
-- 
1.8.3.1

