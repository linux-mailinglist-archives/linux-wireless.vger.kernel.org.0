Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740A614EB9E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAaLUJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:20:09 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55888 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLUJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:20:09 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEj-0002GC-11; Fri, 31 Jan 2020 13:13:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:53 +0200
Message-Id: <20200131111300.891737-17-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 16/23] mac80211: Handle SMPS mode changes only in AP mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

According to IEEE802.11 specifications the SM power save field
in the HT capability IE and the HE extended capability IE is valid
only in (re)association frames and should be ignored otherwise.
Remove code paths that handled this also for non AP modes.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/he.c |  2 +-
 net/mac80211/ht.c | 42 ++++++++++++++++++++++++------------------
 net/mac80211/rx.c |  6 +++++-
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 5245c19f39bf..1087f715338b 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  */
 
 #include "ieee80211_i.h"
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index a2e4d6b8fd98..a8e144fd02f1 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,6 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
+ * Copyright(c) 2020 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -144,7 +145,6 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	int i, max_tx_streams;
 	bool changed;
 	enum ieee80211_sta_rx_bandwidth bw;
-	enum ieee80211_smps_mode smps_mode;
 
 	memset(&ht_cap, 0, sizeof(ht_cap));
 
@@ -270,24 +270,30 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 
-	switch ((ht_cap.cap & IEEE80211_HT_CAP_SM_PS)
-			>> IEEE80211_HT_CAP_SM_PS_SHIFT) {
-	case WLAN_HT_CAP_SM_PS_INVALID:
-	case WLAN_HT_CAP_SM_PS_STATIC:
-		smps_mode = IEEE80211_SMPS_STATIC;
-		break;
-	case WLAN_HT_CAP_SM_PS_DYNAMIC:
-		smps_mode = IEEE80211_SMPS_DYNAMIC;
-		break;
-	case WLAN_HT_CAP_SM_PS_DISABLED:
-		smps_mode = IEEE80211_SMPS_OFF;
-		break;
-	}
-
-	if (smps_mode != sta->sta.smps_mode)
-		changed = true;
-	sta->sta.smps_mode = smps_mode;
+	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		enum ieee80211_smps_mode smps_mode;
+
+		switch ((ht_cap.cap & IEEE80211_HT_CAP_SM_PS)
+				>> IEEE80211_HT_CAP_SM_PS_SHIFT) {
+		case WLAN_HT_CAP_SM_PS_INVALID:
+		case WLAN_HT_CAP_SM_PS_STATIC:
+			smps_mode = IEEE80211_SMPS_STATIC;
+			break;
+		case WLAN_HT_CAP_SM_PS_DYNAMIC:
+			smps_mode = IEEE80211_SMPS_DYNAMIC;
+			break;
+		case WLAN_HT_CAP_SM_PS_DISABLED:
+			smps_mode = IEEE80211_SMPS_OFF;
+			break;
+		}
 
+		if (smps_mode != sta->sta.smps_mode)
+			changed = true;
+		sta->sta.smps_mode = smps_mode;
+	} else {
+		sta->sta.smps_mode = IEEE80211_SMPS_OFF;
+	}
 	return changed;
 }
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 619c223f1cde..ec3a04a1db20 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -3082,6 +3082,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			enum ieee80211_smps_mode smps_mode;
 			struct sta_opmode_info sta_opmode = {};
 
+			if (sdata->vif.type != NL80211_IFTYPE_AP &&
+			    sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+				goto handled;
+
 			/* convert to HT capability */
 			switch (mgmt->u.action.u.ht_smps.smps_control) {
 			case WLAN_HT_SMPS_CONTROL_DISABLED:
-- 
2.24.1

