Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF506359976
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhDIJku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44254 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232762AbhDIJkt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncv-000ELR-Ri; Fri, 09 Apr 2021 12:40:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:19 +0300
Message-Id: <iwlwifi.20210409123755.6078d3517095.I1907a45f267a62dab052bcc44428aa7a2005ffc9@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/15] mac80211: make ieee80211_vif_to_wdev work when the vif isn't in the driver
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will allow the low level driver to get the wdev during
the add_interface flow.
In order to do that, remove a few checks from there and do
not return NULL for vifs that were not yet added to the
driver. Note that all the current callers of this helper
function assume that the vif already exists:
 - The callers from the drivers already have a vif pointer.
 Before this change, ieee80211_vif_to_wdev would return NULL
 in some cases, but those callers don't even check they
 get a non-NULL pointer from ieee80211_vif_to_wdev.
 - The callers from net/mac80211/cfg.c assume the vif is
 already added to the driver as well.

So, this change has no impact on existing callers of this
helper function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h |  5 +----
 net/mac80211/util.c    | 10 +---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2d1d629e5d14..d28f5087c8fa 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1768,10 +1768,7 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
  *
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
- *
- * Note that this function may return %NULL if the given wdev isn't
- * associated with a vif that the driver knows about (e.g. monitor
- * or AP_VLAN interfaces.)
+ * This can also be useful to get the netdev associated to a vif.
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f080fcf60e45..7e36b7363564 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -888,18 +888,10 @@ EXPORT_SYMBOL_GPL(wdev_to_ieee80211_vif);
 
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif)
 {
-	struct ieee80211_sub_if_data *sdata;
-
 	if (!vif)
 		return NULL;
 
-	sdata = vif_to_sdata(vif);
-
-	if (!ieee80211_sdata_running(sdata) ||
-	    !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
-		return NULL;
-
-	return &sdata->wdev;
+	return &vif_to_sdata(vif)->wdev;
 }
 EXPORT_SYMBOL_GPL(ieee80211_vif_to_wdev);
 
-- 
2.31.0

