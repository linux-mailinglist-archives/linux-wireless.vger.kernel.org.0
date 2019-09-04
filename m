Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB9A8DEB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfIDRx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 13:53:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:33658 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDRx1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 13:53:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="173659092"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2019 10:53:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4EDB8D0; Wed,  4 Sep 2019 20:53:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] zd1211rw: use %*ph to print small buffer
Date:   Wed,  4 Sep 2019 20:53:23 +0300
Message-Id: <20190904175323.77984-1-andriy.shevchenko@linux.intel.com>
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
 drivers/net/wireless/zydas/zd1211rw/zd_chip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
index 40c0a86dbfc7..0af4b1986e48 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
@@ -41,8 +41,7 @@ void zd_chip_clear(struct zd_chip *chip)
 static int scnprint_mac_oui(struct zd_chip *chip, char *buffer, size_t size)
 {
 	u8 *addr = zd_mac_get_perm_addr(zd_chip_to_mac(chip));
-	return scnprintf(buffer, size, "%02x-%02x-%02x",
-		         addr[0], addr[1], addr[2]);
+	return scnprintf(buffer, size, "%3phD", addr);
 }
 
 /* Prints an identifier line, which will support debugging. */
-- 
2.23.0.rc1

