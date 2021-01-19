Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08A2FC4FF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 00:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbhASXhr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 18:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394541AbhASOJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 09:09:16 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7FC061798
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 06:05:47 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 22so21867974qkf.9
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M04lwPBiKAp4mMR41FNkA1iddXx0RaVuGp7LGXqlLnc=;
        b=vRZx1zk5ZzkqnOGAk1YZbw/HJOKDieZ5fUjU36V8D48viBYKcOXQmzrUdtKmVB69iy
         I3ii4aCSQPTvyuVIYyuKa5DpOAjjKxjXrxNfFh44a8xHOmvJOBrj6k+6qtgntxla8hvv
         /c1hNOgCVTgdW61wMxlUeDpNApd/sKqJi2ZavLhRnppGBfZ/VEh262Okoih1nOixTvZe
         nmJE4CJjWRfCOUub6dU35mgULHEbg4EFu4cEKSfkjC3+6NAbY7NxCV+M6xkJLYlsZthA
         A+JeCw81ZHCprriiqORv/1TgbUSa6rr/jYGo7+B9+QK6Eg63wTY/+BUiLLN7iV63K8mg
         uk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M04lwPBiKAp4mMR41FNkA1iddXx0RaVuGp7LGXqlLnc=;
        b=YyphDFkFLtNds+KE2PvKDbl7FmVKFBMkDaiATiAPLFQjHNPhZJpz+0Kgo0wcq7iCpv
         QRvibVyt6KqtWVxgMrIhQBb2YUdYOvbMToHLCn6tAPd/a/mBRDMoO/cGcMlPS5ckFpJ5
         r+Ys3/nKxKn/RmeSS9yM/E9yGtr4RYHnw7YCIHApsxHx4jkrzLJyN+ecG65MP2RtRYa9
         k+CPyrrOWYyUUNVgjFsnbJY1vjlAywKlhpCOuxxu+Td/j60RIdv28lJqzx25rmdCh3MU
         XbBzVtHK1EZrExX4rhXLEg0zOGqQfYbSu+jcP4DOHAhD61c4QD8ijXcAiP7VppcxvH2S
         6nuA==
X-Gm-Message-State: AOAM531xciZy5+ImzkOiH4W8e5x2/huiwHOFyv1HXJ3kdBnmJgWe53tH
        d63Z4tN6bNQ6H6OI1OwYwwDEEg==
X-Google-Smtp-Source: ABdhPJxkMgNsxv/FnUpr31IFztG5mZka9Hx6TS03QKovH9wucBXpiFBodKgyA+hws8NjwupZRAz+UQ==
X-Received: by 2002:a37:3d1:: with SMTP id 200mr4456095qkd.30.1611065146305;
        Tue, 19 Jan 2021 06:05:46 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id f134sm12910308qke.85.2021.01.19.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:05:45 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: [PATCH 2/2] drivers: thermal: Remove thermal_notify_framework
Date:   Tue, 19 Jan 2021 09:05:41 -0500
Message-Id: <20210119140541.2453490-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119140541.2453490-1-thara.gopinath@linaro.org>
References: <20210119140541.2453490-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

thermal_notify_framework just updates for a single trip point where as
thermal_zone_device_update does other bookkeeping like updating the
temperature of the thermal zone and setting the next trip point. The only
driver that was using thermal_notify_framework was updated in the previous
patch to use thermal_zone_device_update instead. Since there are no users
for thermal_notify_framework remove it.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 18 ------------------
 include/linux/thermal.h        |  4 ----
 2 files changed, 22 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4a291d205d5c..04f7581b70c5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -575,24 +575,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-/**
- * thermal_notify_framework - Sensor drivers use this API to notify framework
- * @tz:		thermal zone device
- * @trip:	indicates which trip point has been crossed
- *
- * This function handles the trip events from sensor drivers. It starts
- * throttling the cooling devices according to the policy configured.
- * For CRITICAL and HOT trip points, this notifies the respective drivers,
- * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
- * The throttling policy is based on the configured platform data; if no
- * platform data is provided, this uses the step_wise throttling policy.
- */
-void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
-{
-	handle_thermal_trip(tz, trip);
-}
-EXPORT_SYMBOL_GPL(thermal_notify_framework);
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 31b84404f047..77a0b8d060a5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -398,7 +398,6 @@ int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
 void thermal_cdev_update(struct thermal_cooling_device *);
-void thermal_notify_framework(struct thermal_zone_device *, int);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
@@ -446,9 +445,6 @@ static inline int thermal_zone_get_offset(
 
 static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
 { }
-static inline void thermal_notify_framework(struct thermal_zone_device *tz,
-	int trip)
-{ }
 
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
-- 
2.25.1

