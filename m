Return-Path: <linux-wireless+bounces-16894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0DB9FE284
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9588161B8A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49117E8E2;
	Mon, 30 Dec 2024 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHNpPlGi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E34178CC8
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534587; cv=none; b=kwyhmNvqj6IkHdQe5r7YR7vNBM4AV9F4yqrnZOV9o/c/oG4JqcvX0RdI9sTVFaJIoI1qav0FhWN4a6bYffwzSBJLCrgIJP2qhLsl0G6AnFPM+4Mz7Jbl7ZEVQHW7PO7BDLyaX0v/qzRNDVbNlg6dPgr0wdhMCbnApiMBSQeSW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534587; c=relaxed/simple;
	bh=Qsg9vM4ymsImzciVqV5K9rGDCjX2b74e9OC9o120ep4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vfb/WNSJmGGhuZ4yFbrCjnFgmC4i8hrz6XU28us9z2eObzsTGWggGJAhyDDvBZ+aEz0gqFu1a2KdBuvHRXwFsxKiyei47O4HveTGlNmz2j9Vg7Lzn2nv3KMx6tbwR2oOzc8OSZBRucNZF45pyAQOP0Mc3mBbio3Vk9PGdn0hP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHNpPlGi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534586; x=1767070586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qsg9vM4ymsImzciVqV5K9rGDCjX2b74e9OC9o120ep4=;
  b=hHNpPlGi6jVAvSFziLTky25lukoE1jlYQ546AmkHXXPHCVd9YHC8HcPg
   aEd+z1vjEAElZHFKztcnQQeyfmJlxlQD6LC1iLZ204NJInk/Njo0iMH/G
   y1cs9QKsrL/Fr7SCbx4GMaFZv/gHuUDDVN9nYIzsabz3LiO0F6gw8uwWx
   1fD2Kt52d/VLjx01NLISTi2iBtcVl1owUI2XbvHVEEt9/O9gVjNZZHEbF
   ApbhpS9zEUPvxZAZBscjWvoexA3UMo6vDhM/UJyZoStKSqG+QFtpwDBdz
   eYoJKp0PVUpQkHfm7IrS//JPVawEALzVF45U6at1fxJqlK2nF+gVn2x3d
   w==;
X-CSE-ConnectionGUID: kGJZlspUTIWxcTXVww5fwQ==
X-CSE-MsgGUID: OYjLf2LYQTCLQWq5TOsacw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405027"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:25 -0800
X-CSE-ConnectionGUID: THkTvBIgRKGq2Alc6QOtbg==
X-CSE-MsgGUID: KuPXlWPvRYK80z4FAe0ekA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758915"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: mac80211: log link information in ieee80211_determine_chan_mode
Date: Mon, 30 Dec 2024 06:55:50 +0200
Message-Id: <20241230065327.032bdd71e001.I64775ec914603d3c7b0c6ea14b507c0370c11622@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

ieee80211_determine_chan_mode is called for each link and if there is a
downgrade, then it is interesting to know on which link it happened.
Pass through the link_id where relevant and use the new link_id_info
macro instead of sdata_info so that the link ID is printed when
relevant.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/debug.h | 10 +++++++++-
 net/mac80211/mlme.c  | 30 +++++++++++++++++-------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index 35a8ba25fa57..5b81998cb0c9 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions
- * Copyright (C) 2022 - 2023 Intel Corporation
+ * Copyright (C) 2022 - 2024 Intel Corporation
  */
 #ifndef __MAC80211_DEBUG_H
 #define __MAC80211_DEBUG_H
@@ -152,6 +152,14 @@ do {									\
 		else							\
 			_sdata_err((link)->sdata, fmt, ##__VA_ARGS__);	\
 	} while (0)
+#define link_id_info(sdata, link_id, fmt, ...)				\
+	do {								\
+		if (ieee80211_vif_is_mld(&sdata->vif))			\
+			_sdata_info(sdata, "[link %d] " fmt, link_id,	\
+				    ##__VA_ARGS__);			\
+		else							\
+			_sdata_info(sdata, fmt, ##__VA_ARGS__);		\
+	} while (0)
 #define _link_id_dbg(print, sdata, link_id, fmt, ...)			\
 	do {								\
 		if (ieee80211_vif_is_mld(&(sdata)->vif))		\
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d4beb02114a..07ddedc7d349 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -344,6 +344,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 
 static bool
 ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     int link_id,
 				     const struct ieee80211_he_cap_elem *he_cap,
 				     const struct ieee80211_he_operation *he_op)
 {
@@ -371,9 +372,9 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 */
 	if ((mcs_80_map_tx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED ||
 	    (mcs_80_map_rx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED) {
-		sdata_info(sdata,
-			   "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
-			   mcs_80_map_tx, mcs_80_map_rx);
+		link_id_info(sdata, link_id,
+			    "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
+			    mcs_80_map_tx, mcs_80_map_rx);
 		return false;
 	}
 
@@ -417,9 +418,9 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 		if (ap_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
 		    ap_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
 		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
-			sdata_info(sdata,
-				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
-				   nss, ap_rx_val, ap_tx_val, ap_op_val);
+			link_id_info(sdata, link_id,
+				     "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
+				     nss, ap_rx_val, ap_tx_val, ap_op_val);
 			return false;
 		}
 	}
@@ -870,8 +871,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		return elems;
 	case NL80211_BAND_6GHZ:
 		if (ap_mode < IEEE80211_CONN_MODE_HE) {
-			sdata_info(sdata,
-				   "Rejecting non-HE 6/7 GHz connection");
+			link_id_info(sdata, link_id,
+				     "Rejecting non-HE 6/7 GHz connection");
 			ret = -EINVAL;
 			goto free;
 		}
@@ -942,16 +943,18 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (chanreq->oper.width != ap_chandef->width || ap_mode != conn->mode)
-		sdata_info(sdata,
-			   "regulatory prevented using AP config, downgraded\n");
+		link_id_info(sdata, link_id,
+			     "regulatory prevented using AP config, downgraded\n");
 
 	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
-	    (!ieee80211_verify_peer_he_mcs_support(sdata, (void *)elems->he_cap,
+	    (!ieee80211_verify_peer_he_mcs_support(sdata, link_id,
+						   (void *)elems->he_cap,
 						   elems->he_operation) ||
 	     !ieee80211_verify_sta_he_mcs_support(sdata, sband,
 						  elems->he_operation))) {
 		conn->mode = IEEE80211_CONN_MODE_VHT;
-		sdata_info(sdata, "required MCSes not supported, disabling HE\n");
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling HE\n");
 	}
 
 	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
@@ -961,7 +964,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
 				       conn->bw_limit,
 				       IEEE80211_CONN_BW_LIMIT_160);
-		sdata_info(sdata, "required MCSes not supported, disabling EHT\n");
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling EHT\n");
 	}
 
 	/* the mode can only decrease, so this must terminate */
-- 
2.34.1


