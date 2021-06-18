Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEC3AC92C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhFRKxn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:53:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48236 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230437AbhFRKxh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:53:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx0-001YXx-NS; Fri, 18 Jun 2021 13:42:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:42 +0300
Message-Id: <iwlwifi.20210618133832.25ee4a54a7d0.I8cebd799c85524c8123a11941a104dbdefc03762@changeid>
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
Subject: [PATCH 17/31] mac80211: always include HE 6GHz capability in probe request
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If HE/6GHz is available (thus we consider dot11HE6GOptionImplemented
to be true), then always include the corresponding capability in the
probe request as required by the spec.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/he.c   |  5 +++--
 net/mac80211/mlme.c |  3 ++-
 net/mac80211/util.c | 17 +++++++++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 0c0b970835ce..94d85b3f295b 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2020 Intel Corporation
+ * Copyright(c) 2019 - 2021 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -117,10 +117,11 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	u8 mcs_nss_size;
 	u8 he_total_size;
 	bool own_160, peer_160, own_80p80, peer_80p80;
+	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
 
 	memset(he_cap, 0, sizeof(*he_cap));
 
-	if (!he_cap_ie || !ieee80211_get_he_sta_cap(sband))
+	if (!he_cap_ie || !ieee80211_get_he_iftype_cap(sband, iftype))
 		return;
 
 	/* Make sure size is OK */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6457415e4797..5c58eae7ef4b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4954,7 +4954,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-	if (!ieee80211_get_he_sta_cap(sband))
+	if (!ieee80211_get_he_iftype_cap(sband,
+					 ieee80211_vif_type_p2p(&sdata->vif)))
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 
 	rcu_read_lock();
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 22cab76a9c2f..fb3b7bbfb1dc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1776,6 +1776,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	int shift;
 	u32 rate_flags;
 	bool have_80mhz = false;
+	enum nl80211_iftype iftype;
 
 	*offset = 0;
 
@@ -1937,17 +1938,25 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		*offset = noffset;
 	}
 
-	he_cap = ieee80211_get_he_sta_cap(sband);
+	iftype = ieee80211_vif_type_p2p(&sdata->vif);
+	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
 	if (he_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
 		pos = ieee80211_ie_build_he_cap(pos, he_cap, end);
 		if (!pos)
 			goto out_err;
+	}
+
+	if (cfg80211_any_usable_channels(local->hw.wiphy,
+					 BIT(NL80211_BAND_6GHZ),
+					 IEEE80211_CHAN_NO_HE)) {
+		struct ieee80211_supported_band *sband6;
+
+		sband6 = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
+		he_cap = ieee80211_get_he_iftype_cap(sband6, iftype);
 
-		if (sband->band == NL80211_BAND_6GHZ) {
-			enum nl80211_iftype iftype =
-				ieee80211_vif_type_p2p(&sdata->vif);
+		if (he_cap) {
 			__le16 cap = ieee80211_get_he_6ghz_capa(sband, iftype);
 
 			pos = ieee80211_write_he_6ghz_cap(pos, cap, end);
-- 
2.32.0

