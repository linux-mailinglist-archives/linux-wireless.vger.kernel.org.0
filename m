Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0186D1C9964
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEGSeo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 14:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGSen (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 14:34:43 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8435208E4;
        Thu,  7 May 2020 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588876483;
        bh=3SC5W/DS9xdMVSxaOxekzN7vcDdtHgz+8monE4FBn5k=;
        h=Date:From:To:Cc:Subject:From;
        b=TIux4fwoDb9uwopErmbP9RT5patBuiE/xSW5D8ARUAr0+g78M45DYZAgw0fu1W3JR
         Dr0Z5qOJPFF0ZD79Z7wlP2FekczbVV8B8RK+ZqhzpkeEEvYDJs1nlzlR35bq4VlGOR
         uVe0k8xwUp2JzNkJwheufKhcxMYn7nQXtjWD2EDA=
Date:   Thu, 7 May 2020 13:39:09 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cfg80211: Replace zero-length array with flexible-array
Message-ID: <20200507183909.GA12993@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/ieee80211.h |    6 +++---
 include/net/cfg80211.h    |    8 ++++----
 net/wireless/core.h       |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16268ef1cbcc..e7d937871189 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -716,7 +716,7 @@ struct ieee80211_msrment_ie {
 	u8 token;
 	u8 mode;
 	u8 type;
-	u8 request[0];
+	u8 request[];
 } __packed;
 
 /**
@@ -1641,7 +1641,7 @@ struct ieee80211_he_operation {
 	__le32 he_oper_params;
 	__le16 he_mcs_nss_set;
 	/* Optional 0,1,3,4,5,7 or 8 bytes: depends on @he_oper_params */
-	u8 optional[0];
+	u8 optional[];
 } __packed;
 
 /**
@@ -1653,7 +1653,7 @@ struct ieee80211_he_operation {
 struct ieee80211_he_spr {
 	u8 he_sr_control;
 	/* Optional 0 to 19 bytes: depends on @he_sr_control */
-	u8 optional[0];
+	u8 optional[];
 } __packed;
 
 /**
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 70e48f66dac8..5eb776f0069d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2029,7 +2029,7 @@ struct cfg80211_scan_request {
 	bool no_cck;
 
 	/* keep last */
-	struct ieee80211_channel *channels[0];
+	struct ieee80211_channel *channels[];
 };
 
 static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
@@ -2175,7 +2175,7 @@ struct cfg80211_sched_scan_request {
 	struct list_head list;
 
 	/* keep last */
-	struct ieee80211_channel *channels[0];
+	struct ieee80211_channel *channels[];
 };
 
 /**
@@ -2297,7 +2297,7 @@ struct cfg80211_bss {
 	u8 bssid_index;
 	u8 max_bssid_indicator;
 
-	u8 priv[0] __aligned(sizeof(void *));
+	u8 priv[] __aligned(sizeof(void *));
 };
 
 /**
@@ -4829,7 +4829,7 @@ struct wiphy {
 
 	u8 max_data_retry_count;
 
-	char priv[0] __aligned(NETDEV_ALIGN);
+	char priv[] __aligned(NETDEV_ALIGN);
 };
 
 static inline struct net *wiphy_net(struct wiphy *wiphy)
diff --git a/net/wireless/core.h b/net/wireless/core.h
index bb897a803ffe..151609b81096 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -290,7 +290,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	int n_rssi_thresholds;
-	s32 rssi_thresholds[0];
+	s32 rssi_thresholds[];
 };
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);

