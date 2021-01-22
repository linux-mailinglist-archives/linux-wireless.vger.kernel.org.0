Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724CB2FFA8B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 03:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAVCio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 21:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAVCfc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 21:35:32 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D9C0617AA
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 18:34:12 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l23so686649qtq.13
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 18:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kDimXzA9M9PWHfsqDnWeDFT1MG/Xxfjg/ovLBDA4+c=;
        b=qAj/VV4Lrl8K+W4pjf254aWoi5EfYLj0YKA6oao5JlTjig5hlRgAI2cGjPgWmqZgFY
         LFeSMCW+sd90dt/vsqN8J++wdLKvW7dEkBPw6mQmxoUPBHQNIVZAn6Fw27r4t4yIxQNe
         RSjZfk5rT+Aj3cKCsYQbizUo9e46Hti2LqTGvOq9Ua91pCCzkPZ/llHTwO37yEaUWuNF
         RBKzqmWDC1Nz1J5r/ma2c3wleiy1wQUFC/DE4c6NXiBW+5G2xw8/o/XoX2GssNUW/Hz8
         DdAHRUUCb1Hwin50B48SQnzhiABzUG+RCKgxf8KCugYYs3d+uJMZKLNzBlaGaSju+SRR
         sX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kDimXzA9M9PWHfsqDnWeDFT1MG/Xxfjg/ovLBDA4+c=;
        b=gOetbBogaYpnkPJvuD4JEF/SBrDjYU0KMfaxALDXw0C5ySMeWRg03eMKqVELT+ygTd
         gauQsbxy9rPLSp5Gv0uZlptL2X0l4wpzA+GYHi3eb4Qw7FVMyrjFMTKcIHAF9FpcdDbz
         KQAdlUXNKkP2XQCCOxnEDSdERsXWKUP6lfTZCzxGavq1YQKu/6IbwYuXR7obs3nfpDKI
         EjX0HVdjmzJ0+KCUqXXjZmRAl64cLfe9rObBRZuDEZXt6URzIjs3ALEkky0y6OHhV6ql
         tyxgaQwp/mL118WL9PYramps+u59O9YfuVKFtVFGpOXX1W5xQcV9Pf+1qPYdpkV4Apbp
         GCTA==
X-Gm-Message-State: AOAM5314YSPcW79qKs3jkkMS2uWYEnAA9OgN4MNdO9QsCHTO728680Jv
        QmzE02726jcOuNWAzIsmkD8eiQ==
X-Google-Smtp-Source: ABdhPJwYZGOnnyliQde+cwXundXxy/2FHbW2RABsQKlFRqW5EKcyGzrypdbPAT/yTsLipBiZRuL1Cg==
X-Received: by 2002:aed:32a7:: with SMTP id z36mr2577143qtd.251.1611282851670;
        Thu, 21 Jan 2021 18:34:11 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id m13sm4846025qtu.93.2021.01.21.18.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 18:34:11 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        davem@davemloft.net, kuba@kernel.org, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: [PATCH v2 3/3] Documentation: driver-api: thermal: Remove thermal_notify_framework from documentation
Date:   Thu, 21 Jan 2021 21:34:06 -0500
Message-Id: <20210122023406.3500424-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122023406.3500424-1-thara.gopinath@linaro.org>
References: <20210122023406.3500424-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since thermal_notify_framework is no longer supported/implemented
remove the entry from sysfs-api.rst.
---
 Documentation/driver-api/thermal/sysfs-api.rst | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index e7520cb439ac..d5b6ca812873 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -743,17 +743,7 @@ This function returns the thermal_instance corresponding to a given
 {thermal_zone, cooling_device, trip_point} combination. Returns NULL
 if such an instance does not exist.
 
-4.3. thermal_notify_framework
------------------------------
-
-This function handles the trip events from sensor drivers. It starts
-throttling the cooling devices according to the policy configured.
-For CRITICAL and HOT trip points, this notifies the respective drivers,
-and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
-The throttling policy is based on the configured platform data; if no
-platform data is provided, this uses the step_wise throttling policy.
-
-4.4. thermal_cdev_update
+4.3. thermal_cdev_update
 ------------------------
 
 This function serves as an arbitrator to set the state of a cooling
-- 
2.25.1

