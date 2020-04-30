Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659A31BF044
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 08:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgD3G3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 02:29:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:25173 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgD3G3M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 02:29:12 -0400
IronPort-SDR: k+tvPD/Goz5oDj1HNmqISglCXRSdJv59qSit0lFpRVkPO0izxtv5eossUpTZzWK3ezEg0Wlg7e
 Ok/qPOcuuHHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:29:12 -0700
IronPort-SDR: /w7bQ4FpjCNO8fbnM+vD3pMN7d6DOItzX+qaeYekxqCZLPCwIA3pShhJUt7BmW7FruTi2LKbrg
 1Icl50AWdWfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="282751640"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 23:29:11 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        rui.zhang@intel.com
Subject: [PATCH 3/6] thermal: core: update polling after all trips handled
Date:   Thu, 30 Apr 2020 14:32:26 +0800
Message-Id: <20200430063229.6182-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430063229.6182-1-rui.zhang@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move monitor_thermal_zone() from handle_thermal_trip() to
thermal_zone_device_update() because updating the polling timers after all
trips handled is sufficient.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ac70545..04a16a9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -430,11 +430,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_critical_trips(tz, trip, type);
 	else
 		handle_non_critical_trips(tz, trip);
-	/*
-	 * Alright, we handled this trip successfully.
-	 * So, start monitoring again.
-	 */
-	monitor_thermal_zone(tz);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
@@ -529,6 +524,12 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
+
+	/*
+	 * Alright, we handled all the trips successfully.
+	 * So, start monitoring again.
+	 */
+	monitor_thermal_zone(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-- 
2.7.4

