Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE606FA1C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGVHPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 03:15:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfGVHPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 03:15:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5497861836; Mon, 22 Jul 2019 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563779701;
        bh=rXOdUU9KwFgURfRh7k6IsX4UFobBslPtavuIn9XQzFw=;
        h=From:To:Cc:Subject:Date:From;
        b=QGIhqHyfdkIzPaEx6hnGngusZgo/Co/1ypTLOVEWg3GfC73VsfCG/yQkjDPsGoCHx
         Aojvul4ThU0Af9P8Fts+6o2MnnksNx/TMy6y8ZNjQ+P0koGY3bkCV5Gbjq108JSs3/
         bLhWgGdJNs3DQ28cvKFo7plhhsgw+/Fu30krna50=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5672A61795;
        Mon, 22 Jul 2019 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563779699;
        bh=rXOdUU9KwFgURfRh7k6IsX4UFobBslPtavuIn9XQzFw=;
        h=From:To:Cc:Subject:Date:From;
        b=b9jZaUdQQFqVeUo+51tIpFiWssHA7Of5324VPLnlwcJ3AdFPcStG7hwlqZEZVhYMn
         zNG4sa4AG4ZIwxcr++7+UByQER66gszPI8LFRLzx5nhYjcMfY4Ebe+kRtsep479Fqu
         4Rur9oJ/sOhNp6LCZ185zvNUmjSWbFEj3YG89QOo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5672A61795
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH] {nl,mac}80211: fix interface combinations on crypto controlled devices
Date:   Mon, 22 Jul 2019 12:44:50 +0530
Message-Id: <1563779690-9716-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 33d915d9e8ce ("{nl,mac}80211: allow 4addr AP operation on
crypto controlled devices") has introduced a change which allows
4addr operation on crypto controlled devices (ex: ath10k). This
change has inadvertently impacted the interface combinations logic
on such devices.

General rule is that software interfaces like AP/VLAN should not be
listed under supported interface combinations and should not be
considered during validation of these combinations; because of the
aforementioned change, AP/VLAN interfaces(if present) will be checked
against interfaces supported by the device and blocks valid interface
combinations.

Consider a case where an AP and AP/VLAN are up and running; when a
second AP device is brought up on the same physical device, this AP
will be checked against the AP/VLAN interface (which will not be
part of supported interface combinations of the device) and blocks
second AP to come up.

Adding a new API cfg80211_iftype_allowed() to fix the problem, this
API works for all devices with/without SW crypto control.

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Fixes: 33d915d9e8ce ("{nl,mac}80211: allow 4addr AP operation on crypto controlled devices")
---
 include/net/cfg80211.h | 15 +++++++++++++++
 net/mac80211/util.c    |  7 +++----
 net/wireless/core.c    |  6 ++----
 net/wireless/nl80211.c |  4 +---
 net/wireless/util.c    | 27 +++++++++++++++++++++++++--
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 21c3e34..f312c2b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7320,6 +7320,21 @@ void cfg80211_pmsr_complete(struct wireless_dev *wdev,
 			    struct cfg80211_pmsr_request *req,
 			    gfp_t gfp);
 
+/**
+ * cfg80211_iftype_allowed - check whether the interface can be allowed
+ * @wiphy: the wiphy
+ * @iftype: interface type
+ * @is_4addr: use_4addr flag, must be '0' when check_swif is '1'
+ * @check_swif: check iftype against software interfaces
+ *
+ * Check whether the interface is allowed to operate; additionally, this API
+ * can be used to check iftype against the software interfaces when
+ * check_swif is '1'.
+ */
+bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
+			     bool is_4addr, u8 check_swif);
+
+
 /* Logging, debugging and troubleshooting/diagnostic helpers. */
 
 /* wiphy_printk helpers, similar to dev_printk */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1b224fa..ad1e581 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3796,9 +3796,7 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* Always allow software iftypes */
-	if (local->hw.wiphy->software_iftypes & BIT(iftype) ||
-	    (iftype == NL80211_IFTYPE_AP_VLAN &&
-	     local->hw.wiphy->flags & WIPHY_FLAG_4ADDR_AP)) {
+	if (cfg80211_iftype_allowed(local->hw.wiphy, iftype, 0, 1)) {
 		if (radar_detect)
 			return -EINVAL;
 		return 0;
@@ -3833,7 +3831,8 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 
 		if (sdata_iter == sdata ||
 		    !ieee80211_sdata_running(sdata_iter) ||
-		    local->hw.wiphy->software_iftypes & BIT(wdev_iter->iftype))
+		    cfg80211_iftype_allowed(local->hw.wiphy,
+					    wdev_iter->iftype, 0, 1))
 			continue;
 
 		params.iftype_num[wdev_iter->iftype]++;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 45d9afc..32b3c71 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1410,10 +1410,8 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 		break;
 	case NETDEV_PRE_UP:
-		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)) &&
-		    !(wdev->iftype == NL80211_IFTYPE_AP_VLAN &&
-		      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP &&
-		      wdev->use_4addr))
+		if (!cfg80211_iftype_allowed(wdev->wiphy, wdev->iftype,
+					     wdev->use_4addr, 0))
 			return notifier_from_errno(-EOPNOTSUPP);
 
 		if (rfkill_blocked(rdev->rfkill))
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fc83dd1..fd05ae1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3484,9 +3484,7 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
-	if (!(rdev->wiphy.interface_modes & (1 << type)) &&
-	    !(type == NL80211_IFTYPE_AP_VLAN && params.use_4addr &&
-	      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP))
+	if (!cfg80211_iftype_allowed(&rdev->wiphy, type, params.use_4addr, 0))
 		return -EOPNOTSUPP;
 
 	err = nl80211_parse_mon_options(rdev, type, info, &params);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1c39d6a..d0e35b7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1697,7 +1697,7 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
 		num_interfaces += params->iftype_num[iftype];
 		if (params->iftype_num[iftype] > 0 &&
-		    !(wiphy->software_iftypes & BIT(iftype)))
+		    !cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
 			used_iftypes |= BIT(iftype);
 	}
 
@@ -1719,7 +1719,7 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 			return -ENOMEM;
 
 		for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
-			if (wiphy->software_iftypes & BIT(iftype))
+			if (cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
 				continue;
 			for (j = 0; j < c->n_limits; j++) {
 				all_iftypes |= limits[j].types;
@@ -2072,3 +2072,26 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 	return max_vht_nss;
 }
 EXPORT_SYMBOL(ieee80211_get_vht_max_nss);
+
+bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
+			     bool is_4addr, u8 check_swif)
+
+{
+	bool is_vlan = iftype == NL80211_IFTYPE_AP_VLAN;
+
+	switch (check_swif) {
+	case 0:
+		if (is_vlan && is_4addr)
+			return wiphy->flags & WIPHY_FLAG_4ADDR_AP;
+		return wiphy->interface_modes & BIT(iftype);
+	case 1:
+		if (!(wiphy->software_iftypes & BIT(iftype)) && is_vlan)
+			return wiphy->flags & WIPHY_FLAG_4ADDR_AP;
+		return wiphy->software_iftypes & BIT(iftype);
+	default:
+		break;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_iftype_allowed);
-- 
2.7.4

