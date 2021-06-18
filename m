Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF83AC90D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhFRKoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48176 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233147AbhFRKoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwu-001YXx-Va; Fri, 18 Jun 2021 13:42:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:35 +0300
Message-Id: <iwlwifi.20210618133832.f7c105237541.I50b302044e2b35e5ed4d3fb8bc7bd3d8bb89b1e1@changeid>
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
Subject: [PATCH 10/31] mac80211: add to bss_conf if broadcast TWT is supported
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add to struct ieee80211_bss_conf a twt_broadcast field.
Set it to true if both STA and AP support broadcast TWT.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h |  4 +++-
 net/mac80211/mlme.c    | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c6eb7e..c575240b02c8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2020 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -526,6 +526,7 @@ struct ieee80211_fils_discovery {
  * @twt_responder: does this BSS support TWT requester (relevant for managed
  *	mode only, set if the AP advertises TWT responder role)
  * @twt_protected: does this BSS support protected TWT frames
+ * @twt_broadcast: does this BSS support broadcast TWT
  * @assoc: association status
  * @ibss_joined: indicates whether this station is part of an IBSS
  *	or not
@@ -642,6 +643,7 @@ struct ieee80211_bss_conf {
 	bool twt_requester;
 	bool twt_responder;
 	bool twt_protected;
+	bool twt_broadcast;
 	/* association related data */
 	bool assoc, ibss_joined;
 	bool ibss_creator;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cc9bb4b9f8dc..6457415e4797 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3227,6 +3227,21 @@ static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static bool ieee80211_twt_bcast_support(struct ieee80211_bss_conf *bss_conf,
+					struct ieee80211_supported_band *sband,
+					struct sta_info *sta)
+{
+	const struct ieee80211_sta_he_cap *own_he_cap =
+		ieee80211_get_he_sta_cap(sband);
+
+	return bss_conf->he_support &&
+		(sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
+			IEEE80211_HE_MAC_CAP2_BCAST_TWT) &&
+		own_he_cap &&
+		(own_he_cap->he_cap_elem.mac_cap_info[2] &
+			IEEE80211_HE_MAC_CAP2_BCAST_TWT);
+}
+
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_bss *cbss,
 				    struct ieee80211_mgmt *mgmt, size_t len,
@@ -3442,6 +3457,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		bss_conf->twt_protected = false;
 	}
 
+	bss_conf->twt_broadcast =
+		ieee80211_twt_bcast_support(bss_conf, sband, sta);
+
 	if (bss_conf->he_support) {
 		bss_conf->he_bss_color.color =
 			le32_get_bits(elems->he_operation->he_oper_params,
-- 
2.32.0

