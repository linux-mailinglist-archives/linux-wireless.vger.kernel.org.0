Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0692FFA71
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 03:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbhAVCfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 21:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbhAVCfa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 21:35:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C04C061793
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 18:34:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z9so3167940qtv.6
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 18:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M04lwPBiKAp4mMR41FNkA1iddXx0RaVuGp7LGXqlLnc=;
        b=bDB4nKPMr3JI0ap5q38vZVSJ14wExCJz9SNH/X+2DxUUBiCQEphMXiQ/+Q5plfN/a/
         BRqdsQNq3x8M64V6i2po521+I5U2uhPnwxIA14D8Z9kWj7XEk1tbVJifdUuO8RLbvflp
         o3Pz2Fm0U9M2HEqmMmBvdg9ONnoo5ziEoBP5Lanb1ekXKQ/xQVINycVeTPnCfPuJCWKT
         Dgsp/peAdSQv/r5JXAYMieVOABbnwzJNEk8d485y2cgRzOBiZNwpDqs56DmIfMgsczMD
         2Lm2Y+YnEVnLbscnaDdVLuR6VDgOolfejiH5jlzLtmnLUH/IKOUYBfUo+DPfVqpn89Go
         moyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M04lwPBiKAp4mMR41FNkA1iddXx0RaVuGp7LGXqlLnc=;
        b=e4bu0kgwrkLG81hCSiFPAws7jvn1uvnv0CPV+333ZabjLq7kE72AiJ7kEqklLi8GZu
         hw+7b8nBYc1cdPTGs3T+TEtv1EQxoSBhfwsPrhJzaPVZ0qNMLSCNC7z4O/IDvTxoRFOY
         OdjReO8bvY06cPrQo/6S5XIDjWuG1ixGfbixSZs96f4hAFRG8RZnTLyufHPHHx98s5vp
         0dn3536PoJLCa1R9lNO2nR1HWaIE5zbxSp9IR9oDyYnZhUZJwifyHHZnwBB/X8qDxpnF
         ghprz38+kXOkPH39WI36Mtpf3CTpkuWKZV3revjwx15WGr3Kc1af+Mb/G13wII0ma9g+
         O/CA==
X-Gm-Message-State: AOAM5328HTSYuxBl8ghS6QxIzWRFJKWYfwbn58n0RXGGTa+FzNeWH2hh
        tAcruzbcJriFtiEoS5OeJskTHA==
X-Google-Smtp-Source: ABdhPJyGMTyNlhw1AYJj2GnqfJcwESqKAcxUKfadap3XkrefLmIB5Hn1fXt0ZWtqcVM+1emGU08xSw==
X-Received: by 2002:ac8:5385:: with SMTP id x5mr2565373qtp.321.1611282850525;
        Thu, 21 Jan 2021 18:34:10 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id m13sm4846025qtu.93.2021.01.21.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 18:34:09 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        davem@davemloft.net, kuba@kernel.org, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: [PATCH v2 2/3] drivers: thermal: Remove thermal_notify_framework
Date:   Thu, 21 Jan 2021 21:34:05 -0500
Message-Id: <20210122023406.3500424-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122023406.3500424-1-thara.gopinath@linaro.org>
References: <20210122023406.3500424-1-thara.gopinath@linaro.org>
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

