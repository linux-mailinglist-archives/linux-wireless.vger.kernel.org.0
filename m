Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F5209D59
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404201AbgFYLPa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 07:15:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:27499 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404195AbgFYLP3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 07:15:29 -0400
IronPort-SDR: HJsnwG4a0RJkd6jaQFgceoOBF7CzJG4oCGySP/u4V1yBQLM9vg751Uu70QCnEQDOMFIwkUDYaZ
 iR+O9MKY2Qww==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143082221"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="143082221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 04:15:29 -0700
IronPort-SDR: of9TehtZ1pMxuW6CMNd0rcyc3eskj7i5VSr6hoYfmZBavnqc1Cb5G8pczyHU4Ij0z8VVnyFeQp
 RAJQ97UdSBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="423703718"
Received: from kbergman-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.ger.corp.intel.com) ([10.249.94.147])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2020 04:15:27 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] cfg80211: allow the low level driver to flush the BSS table
Date:   Thu, 25 Jun 2020 14:15:24 +0300
Message-Id: <20200625111524.3992-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The low level driver adds its own opaque information
in the BSS table in the cfg80211_bss structure.

The low level driver may need to signal that this information
is no longer relevant and needs to be recreated.
Add an API to allow the low level driver to do that.

iwlwifi needs this because it keeps there an information about
the firmware's internal clock. This is kept in mac80211's
struct ieee80211_bss::sync_device_ts.
This information is populated while we scan, we add the
internal firmware's clock to each beacon which allows us to
program the firmware correctly after association so that
it'll know when (in terms of its internal clock) the DTIM
and TBTT will happen.

When the firmware is reset this internal clock is reset as
well and ieee80211_bss::sync_device_ts is no longer accurate.

iwlwifi will call this new API any time the firmware is started.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
v2: do not flush the BSS table upon suspend, and rewrite the commit
message
---
 include/net/cfg80211.h |  6 ++++++
 net/wireless/scan.c    | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..03a72b5b1986 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7882,4 +7882,10 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 				    struct cfg80211_update_owe_info *owe_info,
 				    gfp_t gfp);
 
+/**
+ * cfg80211_bss_flush - resets all the scan entries
+ * @wiphy: the wiphy
+ */
+void cfg80211_bss_flush(struct wiphy *wiphy);
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 74ea4cfb39fb..e67a74488bbe 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -712,6 +712,16 @@ void cfg80211_bss_expire(struct cfg80211_registered_device *rdev)
 	__cfg80211_bss_expire(rdev, jiffies - IEEE80211_SCAN_RESULT_EXPIRE);
 }
 
+void cfg80211_bss_flush(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	spin_lock_bh(&rdev->bss_lock);
+	__cfg80211_bss_expire(rdev, jiffies);
+	spin_unlock_bh(&rdev->bss_lock);
+}
+EXPORT_SYMBOL(cfg80211_bss_flush);
+
 const struct element *
 cfg80211_find_elem_match(u8 eid, const u8 *ies, unsigned int len,
 			 const u8 *match, unsigned int match_len,
-- 
2.17.1

