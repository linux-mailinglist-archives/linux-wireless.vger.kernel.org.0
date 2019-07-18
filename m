Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A540C6C4BF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 03:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfGRB5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jul 2019 21:57:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46090 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfGRB5X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jul 2019 21:57:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so11777082pfb.13
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2019 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVMzX+vsHuStuXaelci6e/V6r4higaqJwBgjES1yZJs=;
        b=SDNHXyVkkAwhxSkPK65qPTWbMNM4TndzBwUOUkakAZWE/jJViKmTdArw3r09OyDsnq
         pDgWMW7kepF4PbbHeA11o/mf8u0jZ4RdqEyYhKXb+zZMF2wWtVaG04JJsug5rXp7pYzE
         iZ8QGoow3wEM/OqI1FJgYCGtzLfxbjDvfBEcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVMzX+vsHuStuXaelci6e/V6r4higaqJwBgjES1yZJs=;
        b=it3nCOhr/mhi2N/mJ3F4E5HwKozhYxOQ2+xjv6EarHBFyv76aOdjJiyRhiRLXbnBl9
         Mm/yZQJbBvffdATf3b0Lthxi3aOFG5/dz8/buf+bNM26I8STYyDwMqTU+wko8klFLt0j
         2YDaQBTGxH0fhLgQTt/dJjprsJsi5EnJNZE6zNcwcF3pVZJkEHkrImddp0gIvj6yjwmS
         fnvgPpia4zELY0g1ulAh+2t/l5P7gnIuyiBwH1CKAkFQAAkwkVKSuxSWLDsau9lDX6mU
         Xu2/JGoBrv9PO/TUH/hDDgLUmn1CQWPf9m0EAseV02wqzHzU6tZOdH5jRVINFBWf+ig0
         EUJg==
X-Gm-Message-State: APjAAAU2IVatkVXFf8wArzNHMaCT097fzrashzjWjdfcXimouNOO8Qcm
        lh5xvp5d4DqTK3bN6SSlIvfPsQ==
X-Google-Smtp-Source: APXvYqwc7UJEgdpZQiNBgmlKXN2kufpgxys9Fp1+ejJCyREocHIkqInPZ/SFoloPxpn1Z+ccN0FcNw==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr46150975pju.110.1563415042447;
        Wed, 17 Jul 2019 18:57:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id n17sm27568488pfq.182.2019.07.17.18.57.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 18:57:21 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mac80211: don't warn about CW params when not using them
Date:   Wed, 17 Jul 2019 18:57:12 -0700
Message-Id: <20190718015712.197499-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_set_wmm_default() normally sets up the initial CW min/max for
each queue, except that it skips doing this if the driver doesn't
support ->conf_tx. We still end up calling drv_conf_tx() in some cases
(e.g., ieee80211_reconfig()), which also still won't do anything
useful...except it complains here about the invalid CW parameters.

Let's just skip the WARN if we weren't going to do anything useful with
the parameters.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Noticed because rtw88 does not currently implement .conf_tx()

I think there are several ways to slice this one. I picked one fix,
which may not be the best one.

 net/mac80211/driver-ops.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index acd4afb4944b..c9a8a2433e8a 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -187,11 +187,16 @@ int drv_conf_tx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	if (WARN_ONCE(params->cw_min == 0 ||
-		      params->cw_min > params->cw_max,
-		      "%s: invalid CW_min/CW_max: %d/%d\n",
-		      sdata->name, params->cw_min, params->cw_max))
+	if (params->cw_min == 0 || params->cw_min > params->cw_max) {
+		/*
+		 * If we can't configure hardware anyway, don't warn. We may
+		 * never have initialized the CW parameters.
+		 */
+		WARN_ONCE(local->ops->conf_tx,
+			  "%s: invalid CW_min/CW_max: %d/%d\n",
+			  sdata->name, params->cw_min, params->cw_max);
 		return -EINVAL;
+	}
 
 	trace_drv_conf_tx(local, sdata, ac, params);
 	if (local->ops->conf_tx)
-- 
2.22.0.510.g264f2c817a-goog

