Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55471BF046
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 08:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD3G3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 02:29:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:25173 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgD3G3R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 02:29:17 -0400
IronPort-SDR: ImxQP1EXWC1F7IPeT+1R0+ViOYItEY9Rq5OzmMS4QkIDErLO2X6MkZD0cr/QS3mttSFFP7C09+
 eDCTSeHY0afA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:29:17 -0700
IronPort-SDR: wzMJDO1b/btSHr77ZofDNCBAXUMeubVWXwUmu4Fri9L1ngPDyrTw7zy8ljrLmA/R8+yPQTgyyA
 WOFXvnYo6v+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="282751654"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 23:29:14 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        rui.zhang@intel.com
Subject: [PATCH 4/6] thermal: core: stop polling timer for disabled thermal zone
Date:   Thu, 30 Apr 2020 14:32:27 +0800
Message-Id: <20200430063229.6182-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430063229.6182-1-rui.zhang@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For a disabled thermal zone, thermal_zone_device_update() should do
nothing but cancelling the polling timer.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 04a16a9..5f7a867 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -508,7 +508,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	int count;
 
 	if (should_stop_polling(tz))
-		return;
+		goto update_polling;
 
 	if (atomic_read(&in_suspend))
 		return;
@@ -525,6 +525,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 
+update_polling:
 	/*
 	 * Alright, we handled all the trips successfully.
 	 * So, start monitoring again.
-- 
2.7.4

