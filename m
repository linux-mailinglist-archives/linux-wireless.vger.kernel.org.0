Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB830193F74
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCZNJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:09:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44310 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgCZNJ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:09:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGg-00044K-3T; Thu, 26 Mar 2020 15:09:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:32 +0200
Message-Id: <iwlwifi.20200326150855.098483728cfa.I4e8c25d3288441759c2793247197229f0696a37d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326130943.623208-1-luca@coelho.fi>
References: <20200326130943.623208-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 01/12] mac80211: implement Operating Mode Notification extended NSS support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Somehow we missed this for a long time, but similar to the extended
NSS support in VHT capabilities, we need to have this in Operating
Mode notification.

Implement it by
 * parsing the 160/80+80 bit there and setting the bandwidth
   appropriately
 * having callers of ieee80211_get_vht_max_nss() pass in the current
   max NSS value as received in the operating mode notification in
   order to modify it appropriately depending on the extended NSS
   bits.

This updates all drivers that use it, i.e. only iwlwifi/mvm.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c |  6 ++---
 include/linux/ieee80211.h                   | 12 +++++++---
 net/mac80211/vht.c                          | 10 ++++++--
 net/wireless/util.c                         | 26 +++++++++++----------
 4 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 1a990ed9c3ca..af1baebe11a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -1430,7 +1429,8 @@ static u32 rs_bw_from_sta_bw(struct ieee80211_sta *sta)
 		 */
 		if (ieee80211_get_vht_max_nss(&vht_cap,
 					      IEEE80211_VHT_CHANWIDTH_160MHZ,
-					      0, true) < sta->rx_nss)
+					      0, true,
+					      sta->rx_nss) < sta->rx_nss)
 			return RATE_MCS_CHAN_WIDTH_80;
 		return RATE_MCS_CHAN_WIDTH_160;
 	case IEEE80211_STA_RX_BW_80:
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 33d907eec0b6..bdcc3165c440 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2019 Intel Corporation
+ * Copyright (c) 2018 - 2020 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -859,6 +859,7 @@ enum ieee80211_ht_chanwidth_values {
  * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ: 40 MHz channel width
  * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ: 80 MHz channel width
  * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ: 160 MHz or 80+80 MHz channel width
+ * @IEEE80211_OPMODE_NOTIF_BW_160_80P80: 160 / 80+80 MHz indicator flag
  * @IEEE80211_OPMODE_NOTIF_RX_NSS_MASK: number of spatial streams mask
  *	(the NSS value is the value of this field + 1)
  * @IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT: number of spatial streams shift
@@ -866,11 +867,12 @@ enum ieee80211_ht_chanwidth_values {
  *	using a beamforming steering matrix
  */
 enum ieee80211_vht_opmode_bits {
-	IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK	= 3,
+	IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK	= 0x03,
 	IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ	= 0,
 	IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ	= 1,
 	IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ	= 2,
 	IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ	= 3,
+	IEEE80211_OPMODE_NOTIF_BW_160_80P80	= 0x04,
 	IEEE80211_OPMODE_NOTIF_RX_NSS_MASK	= 0x70,
 	IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT	= 4,
 	IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF	= 0x80,
@@ -1731,6 +1733,9 @@ struct ieee80211_mu_edca_param_set {
  * @ext_nss_bw_capable: indicates whether or not the local transmitter
  *	(rate scaling algorithm) can deal with the new logic
  *	(dot11VHTExtendedNSSBWCapable)
+ * @max_vht_nss: current maximum NSS as advertised by the STA in
+ *	operating mode notification, can be 0 in which case the
+ *	capability data will be used to derive this (from MCS support)
  *
  * Due to the VHT Extended NSS Bandwidth Support, the maximum NSS can
  * vary for a given BW/MCS. This function parses the data.
@@ -1739,7 +1744,8 @@ struct ieee80211_mu_edca_param_set {
  */
 int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 			      enum ieee80211_vht_chanwidth bw,
-			      int mcs, bool ext_nss_bw_capable);
+			      int mcs, bool ext_nss_bw_capable,
+			      unsigned int max_vht_nss);
 
 /* 802.11ax HE MAC capabilities */
 #define IEEE80211_HE_MAC_CAP0_HTC_HE				0x01
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 632f07401850..9c6045f9c24d 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -575,15 +575,21 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ:
+		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
 		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ:
+		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
 		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ:
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+		if (opmode & IEEE80211_OPMODE_NOTIF_BW_160_80P80)
+			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		else
+			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ:
+		/* legacy only, no longer used by newer spec */
 		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	}
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 6590efbbcbb9..123d6ce79b8e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -2030,10 +2030,10 @@ EXPORT_SYMBOL(cfg80211_send_layer2_update);
 
 int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 			      enum ieee80211_vht_chanwidth bw,
-			      int mcs, bool ext_nss_bw_capable)
+			      int mcs, bool ext_nss_bw_capable,
+			      unsigned int max_vht_nss)
 {
 	u16 map = le16_to_cpu(cap->supp_mcs.rx_mcs_map);
-	int max_vht_nss = 0;
 	int ext_nss_bw;
 	int supp_width;
 	int i, mcs_encoding;
@@ -2041,7 +2041,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 	if (map == 0xffff)
 		return 0;
 
-	if (WARN_ON(mcs > 9))
+	if (WARN_ON(mcs > 9 || max_vht_nss > 8))
 		return 0;
 	if (mcs <= 7)
 		mcs_encoding = 0;
@@ -2050,16 +2050,18 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 	else
 		mcs_encoding = 2;
 
-	/* find max_vht_nss for the given MCS */
-	for (i = 7; i >= 0; i--) {
-		int supp = (map >> (2 * i)) & 3;
+	if (!max_vht_nss) {
+		/* find max_vht_nss for the given MCS */
+		for (i = 7; i >= 0; i--) {
+			int supp = (map >> (2 * i)) & 3;
 
-		if (supp == 3)
-			continue;
+			if (supp == 3)
+				continue;
 
-		if (supp >= mcs_encoding) {
-			max_vht_nss = i + 1;
-			break;
+			if (supp >= mcs_encoding) {
+				max_vht_nss = i + 1;
+				break;
+			}
 		}
 	}
 
-- 
2.25.1

