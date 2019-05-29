Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391FE2DCAE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfE2MZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726964AbfE2MZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeN-0007wy-Ko; Wed, 29 May 2019 15:25:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 05/10] cfg80211: Add a function to iterate all BSS entries
Date:   Wed, 29 May 2019 15:25:32 +0300
Message-Id: <20190529122537.8564-6-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add a function that iterates over the BSS entries associated with a
given wiphy and calls a callback for each iterated BSS. This can be
used by drivers in various ways, e.g., to evaluate some property for
all the BSSs in the medium.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 20 ++++++++++++++++++++
 net/wireless/scan.c    | 21 +++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c19687833493..d5c1cfef443a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5721,6 +5721,26 @@ void cfg80211_put_bss(struct wiphy *wiphy, struct cfg80211_bss *bss);
  */
 void cfg80211_unlink_bss(struct wiphy *wiphy, struct cfg80211_bss *bss);
 
+/**
+ * cfg80211_bss_iter - iterate all BSS entries
+ *
+ * This function iterates over the BSS entries associated with the given wiphy
+ * and calls the callback for the iterated BSS. The iterator function is not
+ * allowed to call functions that might modify the internal state of the BSS DB.
+ *
+ * @wiphy: the wiphy
+ * @chandef: if given, the iterator function will be called only if the channel
+ *     of the currently iterated BSS is a subset of the given channel.
+ * @iter: the iterator function to call
+ * @iter_data: an argument to the iterator function
+ */
+void cfg80211_bss_iter(struct wiphy *wiphy,
+		       struct cfg80211_chan_def *chandef,
+		       void (*iter)(struct wiphy *wiphy,
+				    struct cfg80211_bss *bss,
+				    void *data),
+		       void *iter_data);
+
 static inline enum nl80211_bss_scan_width
 cfg80211_chandef_to_scan_width(const struct cfg80211_chan_def *chandef)
 {
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2ea268ef1c43..d66e6d4b7555 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1974,6 +1974,27 @@ void cfg80211_unlink_bss(struct wiphy *wiphy, struct cfg80211_bss *pub)
 }
 EXPORT_SYMBOL(cfg80211_unlink_bss);
 
+void cfg80211_bss_iter(struct wiphy *wiphy,
+		       struct cfg80211_chan_def *chandef,
+		       void (*iter)(struct wiphy *wiphy,
+				    struct cfg80211_bss *bss,
+				    void *data),
+		       void *iter_data)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct cfg80211_internal_bss *bss;
+
+	spin_lock_bh(&rdev->bss_lock);
+
+	list_for_each_entry(bss, &rdev->bss_list, list) {
+		if (!chandef || cfg80211_is_sub_chan(chandef, bss->pub.channel))
+			iter(wiphy, &bss->pub, iter_data);
+	}
+
+	spin_unlock_bh(&rdev->bss_lock);
+}
+EXPORT_SYMBOL(cfg80211_bss_iter);
+
 #ifdef CONFIG_CFG80211_WEXT
 static struct cfg80211_registered_device *
 cfg80211_get_dev_from_ifindex(struct net *net, int ifindex)
-- 
2.20.1

