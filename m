Return-Path: <linux-wireless+bounces-16961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF179FF2DC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3809F7A1416
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EE179A3;
	Wed,  1 Jan 2025 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnIUrnzN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C712175AB
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707970; cv=none; b=QzGym2a6rNXmv1oLCwmOZOxRxx0i4Tmwi1hoMhjuYeB47l3vNEInPXRG2wjUS9C5chp6Vubpbmg4s0Tj84a78QbZDCWJAGpjOXkgPW7bEPeXxCq06e7SKnXQarGlL93aIuZ7fUmjZWR00jCcup57kDlYszZxDnC6gvEzYarZmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707970; c=relaxed/simple;
	bh=BwFP6kTpvcv578EG05r+DaqCUzTD1xGS651NL3z4I7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+u/KB8stnDDcwBHEj4IwoXCbmy5gv/oIY1UCQNt0KKipMY2X7kr519YROam9I5iWxmk9d8iqSzLq2lzMushcSkCjD4Rj0ygaIR8skxmBJi+/3GSUJi+3RLJss5MiKo8UPNFMbM3R3zGtNtu/C/FHJughpDdUfgxah6baCwTRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnIUrnzN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707969; x=1767243969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwFP6kTpvcv578EG05r+DaqCUzTD1xGS651NL3z4I7Y=;
  b=PnIUrnzN1IvsaeQ8GAIK/EVsVG4yIvkXhQKRfgJi2e4tPwS6yQav/XGI
   O1lDiJSec5O4SIj87bQV76fgMlYbQxEZuMq1/vlbVQvVEUoVTdowumJiw
   EWMTy+WZm6CL9dFAFGhkXcMdBUxa/1qmCxPcY2/zf1UMyjyiSBPi1u/PS
   5TKwCZ+oPK56G5W9/EXzlb1s/GAsd3fSQ0szmkvMoLI6r9m3ecBrUin5K
   SHj3J1X0K8mEqCYkDUI8IzyqAEr0XN8Zffv8o/ATLfEhoFqXMjz4zgR5g
   HK1io3MT7GBF9wsofczMHhEmvihMkPPg3qroU8PjmVK9K1BsVrODNzghr
   A==;
X-CSE-ConnectionGUID: /fYINpsPRfWfXBap1AF1/Q==
X-CSE-MsgGUID: g0j562CHQa2XxF3Lgb0IkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194428"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194428"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:09 -0800
X-CSE-ConnectionGUID: 7AkMvFK0Q1W1p/T8ZLHhAA==
X-CSE-MsgGUID: 8GcOpLHXRSSHHPH0KNUSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618921"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/19] wifi: mac80211: log link information in ieee80211_determine_chan_mode
Date: Wed,  1 Jan 2025 07:05:31 +0200
Message-Id: <20250101070249.d400da710fc4.I64775ec914603d3c7b0c6ea14b507c0370c11622@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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
index 2d4beb02114a..2547e0c9e77f 100644
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
+			     "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
+			     mcs_80_map_tx, mcs_80_map_rx);
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


