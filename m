Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C423340EC6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhCRUEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhCRUEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 16:04:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A894C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 13:04:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c1so32500462qke.8
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sy0ok4NDvEEWcKa8gZVauE+I24CZBWOlbwpSDaAczD4=;
        b=OYvbaHL4Cw/2tEMKIpXymUrOdPxlDLE16i0tNA1k6PToqW2gxs01/TDyDN3xUy08IP
         v0KqdzfxqSFwp+GFzYMiEoYQDVYtGNUeOvyucbUEsZUgzypqBTyUxk7p84IQoaWHHu7O
         1SLxkNx03DABkLuTtoKDnvVMI94og1t00o+/DQ8QpPfcKq3kY2lXVfF3IKSM1Bu7hZ29
         eLjJneJj+eKVLvf9uE+j+jEGEti8bhfZ1QSVaSA+OeenV3XoL9CSGVkt/HNDnhoTzXcW
         ir0fo6+jjZ7Eyl1F5KaL7En9r523E3mw7LKatSL1ctsWuFKU6qYclSWa23US36YEww4x
         rL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sy0ok4NDvEEWcKa8gZVauE+I24CZBWOlbwpSDaAczD4=;
        b=dI9gKTDI3tXkDEjq2foB0eNvSEe7L1buu1oUkIiFeO4wpl1m7WnVcum0UIuPazOwmP
         LrYHW9C9FOgBz169Lnd/e1LGpTd/57A+piJiKHRSBSwngNjpVmES97k0mkmLg5YgnbnE
         K2mEEeO0QF7h/6AfMVn0xZKiv8h4eEzbeQn+HhYle46Ds3UYrDeHyNOoZitiu//HpQF6
         L+egkzxZ6OPHTsn93chrFPAnv+YmsZUZQpaDGQVUFfTgjLcHeOenr2Kcwrh4Rr0QSy18
         gqktSWHV8J+Edv0ySuMgHl5YPZfBvI8Sq21WqwT0x2dLZQ7gBwVBV9vgQGLnmnpIbwAN
         FF+A==
X-Gm-Message-State: AOAM531sfk7h7TNwXhuZoVosfWtcD8/mNRpYDad/atcaqHABM0u79dd/
        d9qe+qX6eES1xVO17PmtqMxSCs2wSuVnZ0mr
X-Google-Smtp-Source: ABdhPJyQ78BMLMSkt/5hyJHt/m7uMl6vx5Xf4POCD7cNtWcNhm+B+Nmifj71WzlahW0x8X0CpISeWd9uPTkm4V6u
X-Received: from schuffelen.mtv.corp.google.com ([2620:15c:211:200:49b9:40b4:cada:e298])
 (user=schuffelen job=sendgmr) by 2002:a05:6214:13b3:: with SMTP id
 h19mr6166044qvz.31.1616097871522; Thu, 18 Mar 2021 13:04:31 -0700 (PDT)
Date:   Thu, 18 Mar 2021 13:04:19 -0700
Message-Id: <20210318200419.1421034-1-schuffelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] virt_wifi: Return micros for BSS TSF values
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
 drivers/net/wireless/virt_wifi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index c878097f0dda..1df959532c7d 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -12,6 +12,7 @@
 #include <net/cfg80211.h>
 #include <net/rtnetlink.h>
 #include <linux/etherdevice.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 
 static struct wiphy *common_wiphy;
@@ -168,11 +169,11 @@ static void virt_wifi_scan_result(struct work_struct *work)
 			     scan_result.work);
 	struct wiphy *wiphy = priv_to_wiphy(priv);
 	struct cfg80211_scan_info scan_info = { .aborted = false };
+	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
-					   fake_router_bssid,
-					   ktime_get_boottime_ns(),
+					   fake_router_bssid, tsf,
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
-- 
2.31.0.rc2.261.g7f71774620-goog

