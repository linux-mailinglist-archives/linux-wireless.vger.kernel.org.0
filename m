Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E031BF048
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 08:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3G3U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 02:29:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:25173 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgD3G3U (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 02:29:20 -0400
IronPort-SDR: xLOt+9/8epBFdLnHNdY1ndA6eD5rAQqKHaDitJDQvEP3F9LKUJCY+pQ0m9ybB8lfkVtwsS5rUd
 sjxS/34YL9WA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:29:20 -0700
IronPort-SDR: I7K1TkccSnlXnj2XU381CfWXGH4whQ968NBWcCrH9BOge+PJGtP5GtPpT3bX9JjjEKoemRqzeQ
 vYgk5qkmkqTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="282751674"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 23:29:18 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        rui.zhang@intel.com
Subject: [PATCH 5/6] thermal: core: introduce tz_disabled() helper function
Date:   Thu, 30 Apr 2020 14:32:28 +0800
Message-Id: <20200430063229.6182-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430063229.6182-1-rui.zhang@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename should_stop_polling() to tz_disabled(), and make it global.
Because there are platform thermal drivers which also need this.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 17 ++++++++---------
 include/linux/thermal.h        |  2 ++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5f7a867..1cd5d5d0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -305,16 +305,9 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 		cancel_delayed_work(&tz->poll_queue);
 }
 
-static inline bool should_stop_polling(struct thermal_zone_device *tz)
-{
-	return thermal_zone_device_get_mode(tz) == THERMAL_DEVICE_DISABLED;
-}
-
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	bool stop;
-
-	stop = should_stop_polling(tz);
+	bool stop = tz_disabled(tz);
 
 	mutex_lock(&tz->lock);
 
@@ -502,12 +495,18 @@ int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_set_mode);
 
+bool tz_disabled(struct thermal_zone_device *tz)
+{
+	return thermal_zone_device_get_mode(tz) == THERMAL_DEVICE_DISABLED;
+}
+EXPORT_SYMBOL(tz_disabled);
+
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	int count;
 
-	if (should_stop_polling(tz))
+	if (tz_disabled(tz))
 		goto update_polling;
 
 	if (atomic_read(&in_suspend))
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a87fbaf..0bc62ee 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -479,4 +479,6 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 	return thermal_zone_device_set_mode(tz, THERMAL_DEVICE_DISABLED);
 }
 
+bool tz_disabled(struct thermal_zone_device *tz);
+
 #endif /* __THERMAL_H__ */
-- 
2.7.4

