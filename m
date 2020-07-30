Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA62335B6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgG3Pka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 11:40:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:21008 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3Pka (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 11:40:30 -0400
IronPort-SDR: ipj2XoO92/dbvYqjsPu02dtpjhUB1nBazjfQ+yBPeQG/xwFrxHdpq3QXJKgxpT6WXxwx1JoxfF
 JRpTeCKAjLsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149454853"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="149454853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 08:40:29 -0700
IronPort-SDR: jX7rwOJC7GsCLMqwtH90eSpWyDRb8IF4T2pAy5o0xQYboSIZdTMzol3ajJiaQbreZfYk6cs//m
 a/EEjjUTNpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="491168652"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2020 08:40:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 041FE119; Thu, 30 Jul 2020 18:40:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] rtlwifi: btcoex: use %*ph to print small buffer
Date:   Thu, 30 Jul 2020 18:40:26 +0300
Message-Id: <20200730154026.39901-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c   | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index a4940a3842de..0850c5ddad14 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -894,11 +894,9 @@ static void halbtc_display_wifi_status(struct btc_coexist *btcoexist,
 		   (low_power ? ", 32k" : ""));
 
 	seq_printf(m,
-		   "\n %-35s = %02x %02x %02x %02x %02x %02x (0x%x/0x%x)",
+		   "\n %-35s = %6ph (0x%x/0x%x)",
 		   "Power mode cmd(lps/rpwm)",
-		   btcoexist->pwr_mode_val[0], btcoexist->pwr_mode_val[1],
-		   btcoexist->pwr_mode_val[2], btcoexist->pwr_mode_val[3],
-		   btcoexist->pwr_mode_val[4], btcoexist->pwr_mode_val[5],
+		   btcoexist->pwr_mode_val,
 		   btcoexist->bt_info.lps_val,
 		   btcoexist->bt_info.rpwm_val);
 }
-- 
2.27.0

