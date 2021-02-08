Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE09D31310E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhBHLjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:39:03 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33464 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhBHLfN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:35:13 -0500
Received: by mail-wr1-f52.google.com with SMTP id 7so16712547wrz.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Feb 2021 03:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5HOs1VEp49ZwzwxKS/goUryGVcnC7u3NhbGLS4IJrI=;
        b=RVbSKIO2Q/nqpdVi6qhv4J/k1WnCWFL/9DfiZRyrcFEpCAHK3QbYB3tgZS81AhIaqE
         oeAshmti9m5DPW6UK4Nxn+vsNU0nHQe7s5kteXDprzxNmi/dUz3D30VeJ+7ukB0TaRci
         USff9Hh7sShZ+y2/MDBvKcO8V9Loseh8Q9m2PfoLPhbS57p9uf9AviOiXx6GGpLL0QYl
         vhdJ89iC0UyfdOMZENRS+IvsxlAL161mSfAzAYgiML0N1dJl9gFNLv+wtxRaGZauFjY3
         +Q0S+30L3yZ7FrZBVXhTEjY/dd1+JRRqRKcud41+Xk0SyvYiPRTpGRNcSiOfsc0hNfq6
         Z0Kw==
X-Gm-Message-State: AOAM532y8Dh92oPRqChuumx11ByNjMmejZZNo87GQLtCV6zJOnLJiH0f
        gsfATbZFM2h3Nazk8h63gbw=
X-Google-Smtp-Source: ABdhPJxzmv6YhBOrp0lBgNe3Lh/2Y+Xtcx6L6i2IlVMgUSYfyhwjethMBxkeOHE3rHL1AZEJwqQ9nw==
X-Received: by 2002:adf:9031:: with SMTP id h46mr19517422wrh.19.1612784051569;
        Mon, 08 Feb 2021 03:34:11 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-2-36-203-239.cust.vodafonedsl.it. [2.36.203.239])
        by smtp.gmail.com with ESMTPSA id r1sm28007995wrl.95.2021.02.08.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:34:10 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH RESEND mac80211-next] cfg80211: remove unused callback
Date:   Mon,  8 Feb 2021 12:33:56 +0100
Message-Id: <20210208113356.4105-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The ieee80211 class registers a callback which actually does nothing.
Given that the callback is optional, and all its accesses are protected
by a NULL check, remove it entirely.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
Resend using proper mac80211-next tag

 net/wireless/sysfs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 3ac1f48195d2..41cb4d565149 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -81,12 +81,6 @@ static void wiphy_dev_release(struct device *dev)
 	cfg80211_dev_free(rdev);
 }
 
-static int wiphy_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	/* TODO, we probably need stuff here */
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static void cfg80211_leave_all(struct cfg80211_registered_device *rdev)
 {
@@ -157,7 +151,6 @@ struct class ieee80211_class = {
 	.owner = THIS_MODULE,
 	.dev_release = wiphy_dev_release,
 	.dev_groups = ieee80211_groups,
-	.dev_uevent = wiphy_uevent,
 	.pm = WIPHY_PM_OPS,
 	.ns_type = &net_ns_type_operations,
 	.namespace = wiphy_namespace,
-- 
2.29.2

