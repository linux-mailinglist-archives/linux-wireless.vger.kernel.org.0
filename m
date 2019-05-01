Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7174A10810
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEAMzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 08:55:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAMzp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 08:55:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so8560346pfm.11
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2019 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ztr+lm+w1vKwvmd9OCos0r4TpayaTlwKubRQibiS3/A=;
        b=uxM6YV0/WtZsXLH9c7mICF+sMe+VfRJljr6bbLibkT0mzaxt1rinJvsUR4FGvfn51s
         /b4ciq3mTI8YXDaIgNqK4iz5hxPopKQnG/Vv+5PTNUI5Jgf+OBdSJDEmT917ubsMh/qc
         d7bh0Ule0rwYDoRtoRY1wvhq5C9N8Sm2QPzB+09USmTGBaA3IlFTfrk6PXTm0HRut+q/
         aEBOGKZq3SghEvdFtBGKXkdb1rbYQ1yLrCw9x9EZ2Pmm4eCqJLdkr0uaux44N2pQfOB0
         wto3EXILMd5VjZMUdaugF87l+zRpGXi1Izlg9mWgMEWicG22pUKaDINTf2wzpjY/UnZm
         GssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ztr+lm+w1vKwvmd9OCos0r4TpayaTlwKubRQibiS3/A=;
        b=ALUVUiUbtuNEDALSfAm4AyetudPq8fQK2qSMxgB4i2U7+KMvGmgbbXbxF60Ud+Ezec
         +HBlVwm4pgbpqzyeEqgBLZBjIfiWwOHkuiQ83qN+Ve088k5PfdP6govK2XXlSv35yS2e
         YUJnIBWCN+b9WDdoQyhickgKqdXHYJJArrhQ+ODEjCkfmRl2bYkCrBvJ7dXgKpwR/kOS
         ZzZVUIQU2PFXRMM6G7qtfw/MLc14OSyepX47HIT+oVv8tObxlAuXo/N5CZmfcSDTMc7X
         BTJlvTDdMpOhUSnZnDZqy0KiGIUk8RGbvS1ycd9wEeC5KV93vbIgtywlk6bjl3D7eqae
         l8wQ==
X-Gm-Message-State: APjAAAX484FogkigEuoCPv0EQdghdFxQmN5x5sentMc/GtOrsY0hQGpl
        oktgIGVBKjiwN5DO5bmfR9LYGlUt2GzMJQ==
X-Google-Smtp-Source: APXvYqzYPbsiDHgZTAUDBARvsCQg8NBI8nxKLbBiyjcI/73GBxRKqkyzcRyitUom+43Z8Dmeih15rQ==
X-Received: by 2002:aa7:8dc7:: with SMTP id j7mr13343374pfr.82.1556715343318;
        Wed, 01 May 2019 05:55:43 -0700 (PDT)
Received: from BWT-FWA-0475.bluwirelesstechnology.com ([183.83.169.104])
        by smtp.gmail.com with ESMTPSA id s198sm34788404pfs.34.2019.05.01.05.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:55:42 -0700 (PDT)
From:   chaitanya.mgit@gmail.com
To:     linux-wireless@vger.kernel.org
Cc:     Chaitanya Tata <chaitanya.tata@bluwireless.co.uk>
Subject: [PATCH v2] cfg80211: Handle bss expiry during connection
Date:   Wed,  1 May 2019 18:25:24 +0530
Message-Id: <20190501125524.19961-1-chaitanya.mgit@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chaitanya Tata <chaitanya.tata@bluwireless.co.uk>

If the BSS is expired during connection, the connect result will
trigger a kernel warning. Ideally cfg80211 should hold the BSS
before the connection is attempted, but as the BSSID is not known
in case of auth/assoc MLME offload (connect op) it doesn't.

For those drivers without the connect op cfg80211 holds down the
reference so it wil not be removed from list.

Fix this by removing the warning and silently adding the BSS back to
the bss list which is return by the driver (with proper BSSID set) or
in case the BSS is already added use that.

The requirements for drivers are documented in the API's.

Signed-off-by: Chaitanya Tata <chaitanya.tata@bluwireless.co.uk>
---
Tested this using the below hack in cfg80211_connect_done():
        cfg80211_bss_age(rdev, get_seconds() - 30);
        cfg80211_bss_expire(rdev);
v2:
 - Modified to check for BSS to avoid overwriting fresh information with
 stale. The TS is still updated but IMHO shouldn't matter (avoids having
a additional flag to avoid that).
- Fixed BSS ref leak

---
 include/net/cfg80211.h | 15 +++++++++++----
 net/wireless/core.h    |  4 ++++
 net/wireless/scan.c    |  2 +-
 net/wireless/sme.c     | 29 ++++++++++++++++++++++++++---
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index bb307a11ee63..4f6c2c598618 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6137,8 +6137,11 @@ struct cfg80211_fils_resp_params {
  *	case.
  * @bssid: The BSSID of the AP (may be %NULL)
  * @bss: Entry of bss to which STA got connected to, can be obtained through
- *	cfg80211_get_bss() (may be %NULL). Only one parameter among @bssid and
- *	@bss needs to be specified.
+ *	cfg80211_get_bss() (may be %NULL). But it is recommended to store the
+ *      bss from the connect_request and hold a reference to it and return
+ *      through this param to avoid a warning if the bss is expired during the
+ *      connection, esp. for those drivers implementing connect op.
+ *	Only one parameter among @bssid and @bss needs to be specified.
  * @req_ie: Association request IEs (may be %NULL)
  * @req_ie_len: Association request IEs length
  * @resp_ie: Association response IEs (may be %NULL)
@@ -6186,8 +6189,12 @@ void cfg80211_connect_done(struct net_device *dev,
  *
  * @dev: network device
  * @bssid: the BSSID of the AP
- * @bss: entry of bss to which STA got connected to, can be obtained
- *	through cfg80211_get_bss (may be %NULL)
+ * @bss: Entry of bss to which STA got connected to, can be obtained through
+ *	cfg80211_get_bss() (may be %NULL). But it is recommended to store the
+ *      bss from the connect_request and hold a reference to it and return
+ *      through this param to avoid a warning if the bss is expired during the
+ *      connection, esp. for those drivers implementing connect op.
+ *	Only one parameter among @bssid and @bss needs to be specified.
  * @req_ie: association request IEs (maybe be %NULL)
  * @req_ie_len: association request IEs length
  * @resp_ie: association response IEs (may be %NULL)
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 84d36ca7a7ab..238478341100 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -531,6 +531,10 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
 
+struct cfg80211_internal_bss *
+cfg80211_bss_update(struct cfg80211_registered_device *rdev,
+		    struct cfg80211_internal_bss *tmp,
+		    bool signal_valid);
 #ifdef CONFIG_CFG80211_DEVELOPER_WARNINGS
 #define CFG80211_DEV_WARN_ON(cond)	WARN_ON(cond)
 #else
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 287518c6caa4..0f5ae54c7644 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1035,7 +1035,7 @@ struct cfg80211_non_tx_bss {
 };
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
-static struct cfg80211_internal_bss *
+struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		    struct cfg80211_internal_bss *tmp,
 		    bool signal_valid)
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7d34cb884840..35cbfdd56bf0 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -799,9 +799,32 @@ void cfg80211_connect_done(struct net_device *dev,
 		/* Make sure the bss entry provided by the driver is valid. */
 		struct cfg80211_internal_bss *ibss = bss_from_pub(params->bss);
 
-		if (WARN_ON(list_empty(&ibss->list))) {
-			cfg80211_put_bss(wdev->wiphy, params->bss);
-			return;
+		if ((list_empty(&ibss->list))) {
+			struct cfg80211_bss *found = NULL, *tmp = params->bss;
+
+			found = cfg80211_get_bss(wdev->wiphy, NULL,
+						 params->bss->bssid,
+						 wdev->ssid, wdev->ssid_len,
+						 wdev->conn_bss_type,
+						 IEEE80211_PRIVACY_ANY);
+			if (found)
+				/* The same BSS is already updated so use it
+				 * instead, as it has latest info.
+				 */
+				params->bss = found;
+			else
+				/* Update with BSS provided by driver, it will
+				 * be freshly added and ref cnted, we can free
+				 * the old one.
+				 *
+				 * signal_valid can be false, as we are not
+				 * expecting the BSS to be found.
+				 */
+				cfg80211_bss_update(rdev, ibss, false);
+			/* Put down the old BSS we don't need it
+			 * anymore.
+			 */
+			cfg80211_put_bss(wdev->wiphy, tmp);
 		}
 	}
 
-- 
2.17.1

