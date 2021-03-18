Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B233FCFF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCRCB5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Mar 2021 22:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCRCBh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Mar 2021 22:01:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5DC06174A
        for <linux-wireless@vger.kernel.org>; Wed, 17 Mar 2021 19:01:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id l11so4550347qtk.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Mar 2021 19:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+UcgvFQcz7bzdmHaCkGqxDfp91gn2PcF3h4jni/C+fs=;
        b=kNtaBLJTYFvgTlVVaoA04VJ6ywOzWQuO2muRupaZcvTW4I1hI7xN/px+EP5rNWViL7
         nCL7w3k4zc446ZDvKTJMUx82ggdSWYv/UXRFBe7hSHxhbuh9W0IWYOgMmPAnCzPZfoiL
         cZC007huGqWaH9MtViemlBaPmkcgnQJDmXXGoeSz9Z/cgQkw7wWTXJ1BbE3lK8KGphsJ
         lXu6NPQd6+jCsoSGhGFKQQ7Gd73BILfNMzB1k/z7gU66gZXRP+foN2oi8GUZ1va1qA22
         +Y29mOZiUh74Ch+FaIrK1qRctuIgfa2caz15G1np/I+Ux1VDPq7hZcdpzM1DussDvDFx
         3kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+UcgvFQcz7bzdmHaCkGqxDfp91gn2PcF3h4jni/C+fs=;
        b=GOKMh9fOEZGmYKB0J2g97sijZHTvODJPKh9B24ahtRInVEmKmRFjZ5G2HX/D7SO58D
         t5lT0MP6/LRxEsjxXqhPgiUZGOpViVd1g8SoVV6QV8WPxye4ib8+WWF1qqfS9btiv8Is
         DXSnNliQCXzcazbQPEBmP92fGqijhn3LVpBIRctK8lUpBmt1lUDl17s5MQh2/2gAlVci
         Zz/qxNMPmg2uO3fOWCU43qMc7A2aRmY0sIYnUC7QmLF/nEmwHXqZBstDSFkGXVQrKRyQ
         m5A7+ZdRd3UUrSFBjSncbkiUiHFfHXld2QfkAmowcEdxFfIE8oSLOSlQxUo4MJ9B7f2t
         zv+w==
X-Gm-Message-State: AOAM530vUkR3iViZ2pm0s8x2Y2tytgxLLjuZvjCrwqrkty/1Obz7X/ir
        USfBPEtD5sK3PjVwq0DEyvUbbanYzn8IwAI2
X-Google-Smtp-Source: ABdhPJxWWYR/FLCWVHR+lEvCbYG5F4OUwXVAr8mkfj4cbykFxkGkL28cV/KGajZxpyCcrFTnxJ+7LdT/w7CHSEPh
X-Received: from schuffelen.mtv.corp.google.com ([2620:15c:211:200:49b9:40b4:cada:e298])
 (user=schuffelen job=sendgmr) by 2002:a0c:a0c6:: with SMTP id
 c64mr2196205qva.57.1616032896291; Wed, 17 Mar 2021 19:01:36 -0700 (PDT)
Date:   Wed, 17 Mar 2021 19:01:10 -0700
Message-Id: <20210318020110.778352-1-schuffelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] virt_wifi: Return micros for BSS TSF values
From:   "A. Cody Schuffelen" <schuffelen@google.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "A. Cody Schuffelen" <schuffelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211_inform_bss expects to receive a TSF value, but is given the
time since boot in nanoseconds. TSF values are expected to be at
microsecond scale rather than nanosecond scale.

Signed-off-by: A. Cody Schuffelen <schuffelen@google.com>
---
 drivers/net/wireless/virt_wifi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index c878097f0dda..07cefd0a86be 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -172,7 +172,7 @@ static void virt_wifi_scan_result(struct work_struct *work)
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
 					   fake_router_bssid,
-					   ktime_get_boottime_ns(),
+					   ktime_get_boottime_ns() / 1000,
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
-- 
2.31.0.rc2.261.g7f71774620-goog

