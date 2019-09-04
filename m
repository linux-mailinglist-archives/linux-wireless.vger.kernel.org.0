Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B3A8DCE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfIDRnZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 13:43:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:49539 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDRnY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 13:43:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="334289063"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2019 10:43:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4DE6DD0; Wed,  4 Sep 2019 20:43:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] hostap: use %*ph to print small buffer
Date:   Wed,  4 Sep 2019 20:43:21 +0300
Message-Id: <20190904174321.76826-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/wireless/intersil/hostap/hostap_download.c | 6 ++----
 drivers/net/wireless/intersil/hostap/hostap_plx.c      | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
index 4507614a7c5a..8722000b6c27 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_download.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
@@ -407,10 +407,8 @@ static int prism2_enable_genesis(local_info_t *local, int hcr)
 		       hcr);
 		return 0;
 	} else {
-		printk(KERN_DEBUG "Readback test failed, HCR 0x%02x "
-		       "write %02x %02x %02x %02x read %02x %02x %02x %02x\n",
-		       hcr, initseq[0], initseq[1], initseq[2], initseq[3],
-		       readbuf[0], readbuf[1], readbuf[2], readbuf[3]);
+		printk(KERN_DEBUG "Readback test failed, HCR 0x%02x write %4ph read %4ph\n",
+		       hcr, initseq, readbuf);
 		return 1;
 	}
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_plx.c b/drivers/net/wireless/intersil/hostap/hostap_plx.c
index 943070d39b1e..841cfc68ce84 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_plx.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_plx.c
@@ -352,8 +352,7 @@ static int prism2_plx_check_cis(void __iomem *attr_mem, int attr_len,
 	/* read CIS; it is in even offsets in the beginning of attr_mem */
 	for (i = 0; i < CIS_MAX_LEN; i++)
 		cis[i] = readb(attr_mem + 2 * i);
-	printk(KERN_DEBUG "%s: CIS: %02x %02x %02x %02x %02x %02x ...\n",
-	       dev_info, cis[0], cis[1], cis[2], cis[3], cis[4], cis[5]);
+	printk(KERN_DEBUG "%s: CIS: %6ph ...\n", dev_info, cis);
 
 	/* set reasonable defaults for Prism2 cards just in case CIS parsing
 	 * fails */
-- 
2.23.0.rc1

