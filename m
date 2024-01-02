Return-Path: <linux-wireless+bounces-1399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C082221F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D693F1C2293A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DB16406;
	Tue,  2 Jan 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpwDQEZs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85315E9B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224178; x=1735760178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jj7VNyCE5lzz7sULXYHx9MxAnA1rtHUD/13IAJ59E60=;
  b=gpwDQEZsHWTdyJYrFIHcJApODRVPMN08k2VroNsON89rtdV1u/NDETDK
   /w6T2qbO87uEpx3BnUQKsX2Ble8kodtL/APABKIGwhBZULZbH/fL3wX6x
   0rL9y52KNbMghgrmYRrARyRmPHUXc+d5cTcv2mvhyzAMwZUaAQ8g6+lBh
   scn4RyYzu1KqOE4sNcLkGAcCUbABC3WbvzwInWgONpu24CvmCedGQ/gdy
   jqWaLKObFP7h/aKGqHzuApQnoxIKozxXy/rB/Lb47RqWYmkifrP3UEjfQ
   zZJL2jUcaghUlyLoZANyacFmzZfCConHreSs07iAipyp8f5myvi9Gilte
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314303"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314303"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624480"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624480"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: ieee80211: add definitions for negotiated TID to Link map
Date: Tue,  2 Jan 2024 21:35:33 +0200
Message-Id: <20240102213313.9ef2b866c8c7.Ieaf7dadea9961e0edc55d19c99f0f9fbae591de6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

Add the relevant definitions and structures for TID to Link mapping
negotiation request/response/teardown according to P802.11be_D4.0.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2f5554482047..c311b5812df5 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1454,6 +1454,20 @@ struct ieee80211_mgmt {
 					u8 max_tod_error;
 					u8 max_toa_error;
 				} __packed wnm_timing_msr;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 variable[];
+				} __packed ttlm_req;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 status_code;
+					u8 variable[];
+				} __packed ttlm_res;
+				struct {
+					u8 action_code;
+				} __packed ttlm_tear_down;
 			} u;
 		} __packed action;
 		DECLARE_FLEX_ARRAY(u8, body); /* Generic frame body */
@@ -3357,6 +3371,8 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 109,
 	WLAN_STATUS_SAE_HASH_TO_ELEMENT = 126,
 	WLAN_STATUS_SAE_PK = 127,
+	WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING = 133,
+	WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED = 134,
 };
 
 
@@ -3682,6 +3698,7 @@ enum ieee80211_category {
 	WLAN_CATEGORY_UNPROT_DMG = 20,
 	WLAN_CATEGORY_VHT = 21,
 	WLAN_CATEGORY_S1G = 22,
+	WLAN_CATEGORY_PROTECTED_EHT = 37,
 	WLAN_CATEGORY_VENDOR_SPECIFIC_PROTECTED = 126,
 	WLAN_CATEGORY_VENDOR_SPECIFIC = 127,
 };
@@ -3745,6 +3762,13 @@ enum ieee80211_unprotected_wnm_actioncode {
 	WLAN_UNPROTECTED_WNM_ACTION_TIMING_MEASUREMENT_RESPONSE = 1,
 };
 
+/* Protected EHT action codes */
+enum ieee80211_protected_eht_actioncode {
+	WLAN_PROTECTED_EHT_ACTION_TTLM_REQ = 0,
+	WLAN_PROTECTED_EHT_ACTION_TTLM_RES = 1,
+	WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN = 2,
+};
+
 /* Security key length */
 enum ieee80211_key_len {
 	WLAN_KEY_LEN_WEP40 = 5,
@@ -4844,6 +4868,10 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS		0x000f
 #define IEEE80211_MLD_CAP_OP_SRS_SUPPORT		0x0010
 #define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP	0x0060
+#define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_NO_SUPP	0
+#define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME	1
+#define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_RESERVED	2
+#define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_DIFF	3
 #define IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND		0x0f80
 #define IEEE80211_MLD_CAP_OP_AAR_SUPPORT		0x1000
 
-- 
2.34.1


