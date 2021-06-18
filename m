Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E096B3AC94A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhFRLCC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:02:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48256 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhFRLCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:02:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwy-001YXx-7E; Fri, 18 Jun 2021 13:42:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:39 +0300
Message-Id: <iwlwifi.20210618133832.2b613addaa85.Idaf8b859089490537878a7de5c7453a873a3f638@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 14/31] cfg80211: add cfg80211_any_usable_channels()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This helper function checks if there are any usable channels on
any of the given bands with the given properties (as expressed
by disallowed channel flags).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/chan.c    | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6a54caa6fa16..5a0c4fd2ec5a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -905,6 +905,17 @@ ieee80211_chandef_max_power(struct cfg80211_chan_def *chandef)
 	return chandef->chan->max_power;
 }
 
+/**
+ * cfg80211_any_usable_channels - check for usable channels
+ * @wiphy: the wiphy to check for
+ * @band_mask: which bands to check on
+ * @prohibited_flags: which channels to not consider usable,
+ *	%IEEE80211_CHAN_DISABLED is always taken into account
+ */
+bool cfg80211_any_usable_channels(struct wiphy *wiphy,
+				  unsigned long band_mask,
+				  u32 prohibited_flags);
+
 /**
  * enum survey_info_flags - survey information flags
  *
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 285b8076054b..0c349c7819dc 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018-2020	Intel Corporation
+ * Copyright 2018-2021	Intel Corporation
  */
 
 #include <linux/export.h>
@@ -1335,3 +1335,34 @@ cfg80211_get_chan_state(struct wireless_dev *wdev,
 		WARN_ON(1);
 	}
 }
+
+bool cfg80211_any_usable_channels(struct wiphy *wiphy,
+				  unsigned long sband_mask,
+				  u32 prohibited_flags)
+{
+	int idx;
+
+	prohibited_flags |= IEEE80211_CHAN_DISABLED;
+
+	for_each_set_bit(idx, &sband_mask, NUM_NL80211_BANDS) {
+		struct ieee80211_supported_band *sband = wiphy->bands[idx];
+		int chanidx;
+
+		if (!sband)
+			continue;
+
+		for (chanidx = 0; chanidx < sband->n_channels; chanidx++) {
+			struct ieee80211_channel *chan;
+
+			chan = &sband->channels[chanidx];
+
+			if (chan->flags & prohibited_flags)
+				continue;
+
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_any_usable_channels);
-- 
2.32.0

