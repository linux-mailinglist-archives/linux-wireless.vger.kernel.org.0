Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD541CE394
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgEKTIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 15:08:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:35704 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTIQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 15:08:16 -0400
IronPort-SDR: Gbddt0ex8mVFRhDsXukSlD+c6tYQFPiGuHyZhSN+ARajjqzohCcCG0BfIB2dvqWvRjmWxF8TyG
 ycitYvJaFo7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:08:16 -0700
IronPort-SDR: JC17SZh/t3uPLVqIKK/zybhZY0kbgofzroJkLt9pAe4ZWS27veMQ6TAm68/+I2OMeQpOpGiOyq
 or6E8prTPXnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="251239728"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 May 2020 12:08:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jYDmf-000AQX-Su; Tue, 12 May 2020 03:08:13 +0800
Date:   Tue, 12 May 2020 03:07:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, bigeasy@linutronix.de
Subject: [RFC PATCH] rtw88: 8723d: rtw8723d_pwr_track() can be static
Message-ID: <20200511190731.GA8959@75ebaf9685ab>
References: <20200507042151.15634-10-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507042151.15634-10-yhchuang@realtek.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rtw8723d.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 400364aec393f..b517af417e0e4 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1896,7 +1896,7 @@ static void rtw8723d_phy_pwrtrack(struct rtw_dev *rtwdev)
 		rtw8723d_phy_calibration(rtwdev);
 }
 
-void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
+static void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
