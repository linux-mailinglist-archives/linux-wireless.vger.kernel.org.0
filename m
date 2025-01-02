Return-Path: <linux-wireless+bounces-16979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03359FFA59
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5227A1FF0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2721B3949;
	Thu,  2 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzXqDjnG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57C1A23BE
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827626; cv=none; b=oa0pPHmKpi0V6QFa5haCfcGYzsedkJihCtXdkZPugKj5gHoPdyCQwFNd498CLsX/CvGvdrZEH5uQYr2LhbUMJWDoqLXiT1ul0W8phRKx82jO4FhuHqE3gJCqw1tvTHqTu1X+YBYg444QA1sS480A0DBbacHwGgKSCQP/VIb2JJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827626; c=relaxed/simple;
	bh=2+0Nq3nGeAQG20gDLc3yjxYcjfORvE827GE5HMEzluM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOpBHoFU92XiZjwDAWOmL4vyrl7GTkNXzfj9reKY8iPwL9eZqlq9++OT6sK5iGOJNtkg3Kwh84cbvtlF+70wEOX4qgYHU7HgpcPT7EPHjy82VulqNbtoa/sfcnrwzvnQ5VM2O6BdYkQDu/c9vm22dn3tnRvPgTzptU0cFWmjYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzXqDjnG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827625; x=1767363625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+0Nq3nGeAQG20gDLc3yjxYcjfORvE827GE5HMEzluM=;
  b=SzXqDjnGjvNIPUDwycUyDLa8Efu5ndDuRO7eqMNDSiqYzUPfI2Fsyk8G
   BbuVFKz1kq6JDGlzvxHYV8htGl1THrIm0v1d4IFCVvuxUUnVLr979h6ZF
   FMIziwgb/H0pMITnIHHaG8YZL2TnSNDLIpwvrLWNmW/Nph4jED8YoAobe
   6v89IXgP24dCNM8BPcgheO3LrRbR/OUTMIdhQm41A3Dgb4bocOt0cmhGG
   xaOtiZtUNsQ45aeUmCYyRcvm1lucgsjMMAjq/fa7iA9ippmFI7XKgv+6G
   OvbEaYruBocfJjEQmlYWVpq+5X1V3skC7yu7PRFgNxZS9YDIofjWM6iCL
   Q==;
X-CSE-ConnectionGUID: QiwIOeb1Q8uOQEHle2pxiw==
X-CSE-MsgGUID: G5r1gZCUQ1m4eAEJngGxuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735090"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735090"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:24 -0800
X-CSE-ConnectionGUID: ko9bbqZOQz2pN1iSngPAjw==
X-CSE-MsgGUID: +waI7OSyTYm8R001Y+IXyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357355"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 01/17] wifi: ieee80211: Add some missing MLO related definitions
Date: Thu,  2 Jan 2025 16:19:53 +0200
Message-Id: <20250102161730.4970ca10ebfd.Ibe7f6108cd0e04b8c739a8e35a4f485f664a17e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

As a preparation to support ML reconfiguration request and
response, add additional ML reconfiguration definitions
required to support the flow. See Section 9.4.2.321.4 in
Draft P802.11be_D6.0.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 745c3b125d97..ee6bebfd041d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3885,6 +3885,16 @@ enum ieee80211_protected_eht_actioncode {
 	WLAN_PROTECTED_EHT_ACTION_TTLM_REQ = 0,
 	WLAN_PROTECTED_EHT_ACTION_TTLM_RES = 1,
 	WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN = 2,
+	WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_REQ = 3,
+	WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP = 4,
+	WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN = 5,
+	WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF = 6,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECOMMEND = 7,
+	WLAN_PROTECTED_EHT_ACTION_ML_OP_UPDATE_REQ = 8,
+	WLAN_PROTECTED_EHT_ACTION_ML_OP_UPDATE_RESP = 9,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_NOTIF = 10,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_REQ = 11,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP = 12,
 };
 
 /* Security key length */
@@ -5021,6 +5031,8 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_DIFF	3
 #define IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND		0x0f80
 #define IEEE80211_MLD_CAP_OP_AAR_SUPPORT		0x1000
+#define IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT	0x2000
+#define IEEE80211_MLD_CAP_OP_ALIGNED_TWT_SUPPORT	0x4000
 
 struct ieee80211_mle_basic_common_info {
 	u8 len;
@@ -5036,6 +5048,9 @@ struct ieee80211_mle_preq_common_info {
 } __packed;
 
 #define IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR		0x0010
+#define IEEE80211_MLC_RECONF_PRES_EML_CAPA		0x0020
+#define IEEE80211_MLC_RECONF_PRES_MLD_CAPA_OP		0x0040
+#define IEEE80211_MLC_RECONF_PRES_EXT_MLD_CAPA_OP	0x0080
 
 /* no fixed fields in RECONF */
 
@@ -5354,6 +5369,12 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
+		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
+			common += 2;
+		if (control & IEEE80211_MLC_RECONF_PRES_MLD_CAPA_OP)
+			common += 2;
+		if (control & IEEE80211_MLC_RECONF_PRES_EXT_MLD_CAPA_OP)
+			common += 2;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 		common += sizeof(struct ieee80211_mle_tdls_common_info);
@@ -5504,8 +5525,13 @@ ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(const struct ieee80211_mle_per_sta
 #define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
 #define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
 #define IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT		0x0040
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_UPDATE_TYPE		0x0780
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT	0x0800
+#define	IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE                 0x0780
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_AP_REM          0
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_OP_PARAM_UPDATE 1
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_ADD_LINK        2
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_DEL_LINK        3
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_NSTR_STATUS     4
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT       0x0800
 
 /**
  * ieee80211_mle_reconf_sta_prof_size_ok - validate reconfiguration multi-link
-- 
2.34.1


