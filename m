Return-Path: <linux-wireless+bounces-18806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F5A31E18
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC47E3A8329
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5331F8F04;
	Wed, 12 Feb 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkkI1H0Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F921F8AC5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339032; cv=none; b=CIDe+/TB66KBUZXBcgDejFEosno5HbbGLx9gNAkrL6aXsn8z0m1gWB+daDpxrMlJ6IHItEqzwg1qC6SA8bcYMOppA3kkGmWhQohHvkw4H/DqhaubX1G2p05IlE5rj5XA8BcIgK+oV5hgElK68iNbLwh7tdzBNu9wtCQG71a/wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339032; c=relaxed/simple;
	bh=GJF9M2usNcO1uBB48jXrnghNM/I7eKHaUvSChtFo2Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rk98XA+YnD4y2/b07IIDY/ZR/phNMC0QkPhKFE+RodjiNA4IBTMB3DfeT5nt0p2WfbEO/mXClcO7/RnbZgmpZJP7lecI7A32ilLbWdV9a36z47uEFymxpTeS1uHE5+py2YUH1fQt5cS+KnjXRFRwE4ul7X2ucvX+TTTOjlCP/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkkI1H0Y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339030; x=1770875030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJF9M2usNcO1uBB48jXrnghNM/I7eKHaUvSChtFo2Hs=;
  b=UkkI1H0YRHeUiycSEThhFnm10Y4GSU9ryV+aDi1nCLzQDOk4KVeqtKkE
   8nCY3V/KCjyaRoedoQbmJ9jMDBPVhfVyUccOcUAPJ9a0oLKC3ZwvgL8hW
   DFcaLmwX3hbU16JVcfyJHKSV3n4RM277id9WmYEpcaXBY2H4Z0VDCsBvl
   +EIJbze99Fotw+mlMpV7jOw2oTCvUesofaV7OoqJgIZarEtVmasj2+UDZ
   EFAQdkG6GWn3tmre4vZX3H2kv9IN+BeW425MB6nuIZWkITNm+spqZKEY1
   fioGFWB99ezCzx22vjtwcG389Sm45mdxLJrJqQTrhMXJHWiK4aXGkJQ0J
   g==;
X-CSE-ConnectionGUID: /7LEwg6RRwqmQVPEK75kdA==
X-CSE-MsgGUID: 8QDITuYDRpaUmkDrNFPV9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172204"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172204"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:49 -0800
X-CSE-ConnectionGUID: cZgVLSKCRl2UUkbbqT5kqw==
X-CSE-MsgGUID: wgSMvlaFRWufUPKXjCYzyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893831"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 01/12] wifi: iwlwifi: location api cleanup
Date: Wed, 12 Feb 2025 07:43:22 +0200
Message-Id: <20250212073923.294b7109e0be.I229ceef5933e825815d84c33855cadd62687ee04@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Remove the version suffix from the latest version of the range
request command structs and the range response notification structs.
In addition, don't use MVM in the API file as it is not MVM specific.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 66 +++++++++----------
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 18 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index b8dff139aa05..e1952fc6d149 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  * Copyright (C) 2018-2022 Intel Corporation
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #ifndef __iwl_fw_api_location_h__
 #define __iwl_fw_api_location_h__
@@ -1015,7 +1015,7 @@ struct iwl_tof_range_req_ap_entry_v9 {
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_9 */
 
 /**
- * struct iwl_tof_range_req_ap_entry_v10 - AP configuration parameters
+ * struct iwl_tof_range_req_ap_entry - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @band: 0 for 5.2 GHz, 1 for 2.4 GHz, 2 for 6GHz
  * @channel_num: AP Channel number
@@ -1063,7 +1063,7 @@ struct iwl_tof_range_req_ap_entry_v9 {
  * @min_time_between_msr: For non trigger based NDP ranging, the minimum time
  *	between measurements in units of milliseconds
  */
-struct iwl_tof_range_req_ap_entry_v10 {
+struct iwl_tof_range_req_ap_entry {
 	__le32 initiator_ap_flags;
 	u8 band;
 	u8 channel_num;
@@ -1134,7 +1134,7 @@ enum iwl_tof_initiator_flags {
 	IWL_TOF_INITIATOR_FLAGS_NON_ASAP_SUPPORT = BIT(20),
 }; /* LOCATION_RANGE_REQ_CMD_API_S_VER_5 */
 
-#define IWL_MVM_TOF_MAX_APS 5
+#define IWL_TOF_MAX_APS 5
 #define IWL_MVM_TOF_MAX_TWO_SIDED_APS 5
 
 /**
@@ -1153,7 +1153,7 @@ enum iwl_tof_initiator_flags {
  *		   when the session is done (successfully / partially).
  *		   one of iwl_tof_response_mode.
  * @reserved0: reserved
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @macaddr_random: '0' Use default source MAC address (i.e. p2_p),
  *	            '1' Use MAC Address randomization according to the below
  * @range_req_bssid: ranging request BSSID
@@ -1183,7 +1183,7 @@ struct iwl_tof_range_req_cmd_v5 {
 	u8 ftm_tx_chains;
 	__le16 common_calib;
 	__le16 specific_calib;
-	struct iwl_tof_range_req_ap_entry_v2 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v2 ap[IWL_TOF_MAX_APS];
 } __packed;
 /* LOCATION_RANGE_REQ_CMD_API_S_VER_5 */
 
@@ -1192,7 +1192,7 @@ struct iwl_tof_range_req_cmd_v5 {
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1216,7 +1216,7 @@ struct iwl_tof_range_req_cmd_v7 {
 	__le32 tsf_mac_id;
 	__le16 common_calib;
 	__le16 specific_calib;
-	struct iwl_tof_range_req_ap_entry_v3 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v3 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_7 */
 
 /**
@@ -1224,7 +1224,7 @@ struct iwl_tof_range_req_cmd_v7 {
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1248,7 +1248,7 @@ struct iwl_tof_range_req_cmd_v8 {
 	__le32 tsf_mac_id;
 	__le16 common_calib;
 	__le16 specific_calib;
-	struct iwl_tof_range_req_ap_entry_v4 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v4 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_8 */
 
 /**
@@ -1256,7 +1256,7 @@ struct iwl_tof_range_req_cmd_v8 {
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1276,7 +1276,7 @@ struct iwl_tof_range_req_cmd_v9 {
 	u8 macaddr_template[ETH_ALEN];
 	__le32 req_timeout_ms;
 	__le32 tsf_mac_id;
-	struct iwl_tof_range_req_ap_entry_v6 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v6 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_9 */
 
 /**
@@ -1284,7 +1284,7 @@ struct iwl_tof_range_req_cmd_v9 {
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1304,7 +1304,7 @@ struct iwl_tof_range_req_cmd_v11 {
 	u8 macaddr_template[ETH_ALEN];
 	__le32 req_timeout_ms;
 	__le32 tsf_mac_id;
-	struct iwl_tof_range_req_ap_entry_v7 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v7 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_11 */
 
 /**
@@ -1312,7 +1312,7 @@ struct iwl_tof_range_req_cmd_v11 {
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1332,7 +1332,7 @@ struct iwl_tof_range_req_cmd_v12 {
 	u8 macaddr_template[ETH_ALEN];
 	__le32 req_timeout_ms;
 	__le32 tsf_mac_id;
-	struct iwl_tof_range_req_ap_entry_v8 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v8 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_12 */
 
 /**
@@ -1340,7 +1340,7 @@ struct iwl_tof_range_req_cmd_v12 {
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1360,15 +1360,15 @@ struct iwl_tof_range_req_cmd_v13 {
 	u8 macaddr_template[ETH_ALEN];
 	__le32 req_timeout_ms;
 	__le32 tsf_mac_id;
-	struct iwl_tof_range_req_ap_entry_v9 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v9 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_13 */
 
 /**
- * struct iwl_tof_range_req_cmd_v14 - start measurement cmd
+ * struct iwl_tof_range_req_cmd - start measurement cmd
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
- * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_ap: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @range_req_bssid: ranging request BSSID
  * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
  *		  Bits set to 1 shall be randomized by the UMAC
@@ -1377,9 +1377,9 @@ struct iwl_tof_range_req_cmd_v13 {
  *	This is the session time for completing the measurement.
  * @tsf_mac_id: report the measurement start time for each ap in terms of the
  *	TSF of this mac id. 0xff to disable TSF reporting.
- * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v10.
+ * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry.
  */
-struct iwl_tof_range_req_cmd_v14 {
+struct iwl_tof_range_req_cmd {
 	__le32 initiator_flags;
 	u8 request_id;
 	u8 num_of_ap;
@@ -1388,8 +1388,8 @@ struct iwl_tof_range_req_cmd_v14 {
 	u8 macaddr_template[ETH_ALEN];
 	__le32 req_timeout_ms;
 	__le32 tsf_mac_id;
-	struct iwl_tof_range_req_ap_entry_v10 ap[IWL_MVM_TOF_MAX_APS];
-} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_13 */
+	struct iwl_tof_range_req_ap_entry ap[IWL_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_15 */
 
 /*
  * enum iwl_tof_range_request_status - status of the sent request
@@ -1609,7 +1609,7 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v5 {
 } __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_5 */
 
 /**
- * struct iwl_tof_range_rsp_ap_entry_ntfy_v6 - AP parameters (response)
+ * struct iwl_tof_range_rsp_ap_entry_ntfy - AP parameters (response)
  * @bssid: BSSID of the AP
  * @measure_status: current APs measurement status, one of
  *	&enum iwl_tof_entry_status.
@@ -1645,7 +1645,7 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v5 {
  * @tx_pn: the last PN used for this responder Tx in case PMF is configured in
  *	LE byte order.
  */
-struct iwl_tof_range_rsp_ap_entry_ntfy_v6 {
+struct iwl_tof_range_rsp_ap_entry_ntfy {
 	u8 bssid[ETH_ALEN];
 	u8 measure_status;
 	u8 measure_bw;
@@ -1695,7 +1695,7 @@ enum iwl_tof_response_status {
  * @request_status: status of current measurement session, one of
  *	&enum iwl_tof_response_status.
  * @last_in_batch: reprot policy (when not all responses are uploaded at once)
- * @num_of_aps: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @num_of_aps: Number of APs to measure (error if > IWL_TOF_MAX_APS)
  * @ap: per-AP data
  */
 struct iwl_tof_range_rsp_ntfy_v5 {
@@ -1703,7 +1703,7 @@ struct iwl_tof_range_rsp_ntfy_v5 {
 	u8 request_status;
 	u8 last_in_batch;
 	u8 num_of_aps;
-	struct iwl_tof_range_rsp_ap_entry_ntfy_v3 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_rsp_ap_entry_ntfy_v3 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_5 */
 
 /**
@@ -1719,7 +1719,7 @@ struct iwl_tof_range_rsp_ntfy_v6 {
 	u8 num_of_aps;
 	u8 last_report;
 	u8 reserved;
-	struct iwl_tof_range_rsp_ap_entry_ntfy_v4 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_rsp_ap_entry_ntfy_v4 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_6 */
 
 /**
@@ -1735,23 +1735,23 @@ struct iwl_tof_range_rsp_ntfy_v7 {
 	u8 num_of_aps;
 	u8 last_report;
 	u8 reserved;
-	struct iwl_tof_range_rsp_ap_entry_ntfy_v5 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_rsp_ap_entry_ntfy_v5 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_7 */
 
 /**
- * struct iwl_tof_range_rsp_ntfy_v8 - ranging response notification
+ * struct iwl_tof_range_rsp_ntfy - ranging response notification
  * @request_id: A Token ID of the corresponding Range request
  * @num_of_aps: Number of APs results
  * @last_report: 1 if no more FTM sessions are scheduled, 0 otherwise.
  * @reserved: reserved
  * @ap: per-AP data
  */
-struct iwl_tof_range_rsp_ntfy_v8 {
+struct iwl_tof_range_rsp_ntfy {
 	u8 request_id;
 	u8 num_of_aps;
 	u8 last_report;
 	u8 reserved;
-	struct iwl_tof_range_rsp_ap_entry_ntfy_v6 ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_rsp_ap_entry_ntfy ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_8,
 	       LOCATION_RANGE_RSP_NTFY_API_S_VER_9 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index f7034fa40c26..dfb25b964f0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include <linux/math64.h>
@@ -848,7 +848,7 @@ static int iwl_mvm_ftm_start_v13(struct iwl_mvm *mvm,
 static int
 iwl_mvm_ftm_put_target_v10(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct cfg80211_pmsr_request_peer *peer,
-			   struct iwl_tof_range_req_ap_entry_v10 *target)
+			   struct iwl_tof_range_req_ap_entry *target)
 {
 	u32 i2r_max_sts, flags;
 	int ret;
@@ -920,7 +920,7 @@ static int iwl_mvm_ftm_start_v14(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct cfg80211_pmsr_request *req)
 {
-	struct iwl_tof_range_req_cmd_v14 cmd;
+	struct iwl_tof_range_req_cmd cmd;
 	struct iwl_host_cmd hcmd = {
 		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
@@ -934,7 +934,7 @@ static int iwl_mvm_ftm_start_v14(struct iwl_mvm *mvm,
 
 	for (i = 0; i < cmd.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
-		struct iwl_tof_range_req_ap_entry_v10 *target = &cmd.ap[i];
+		struct iwl_tof_range_req_ap_entry *target = &cmd.ap[i];
 
 		err = iwl_mvm_ftm_put_target_v10(mvm, vif, peer, target);
 		if (err)
@@ -1200,7 +1200,7 @@ static void iwl_mvm_debug_range_resp(struct iwl_mvm *mvm, u8 index,
 
 static void
 iwl_mvm_ftm_pasn_update_pn(struct iwl_mvm *mvm,
-			   struct iwl_tof_range_rsp_ap_entry_ntfy_v6 *fw_ap)
+			   struct iwl_tof_range_rsp_ap_entry_ntfy *fw_ap)
 {
 	struct iwl_mvm_ftm_pasn_entry *entry;
 
@@ -1238,7 +1238,7 @@ static bool iwl_mvm_ftm_resp_size_validation(u8 ver, unsigned int pkt_len)
 	switch (ver) {
 	case 9:
 	case 8:
-		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v8);
+		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy);
 	case 7:
 		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v7);
 	case 6:
@@ -1258,7 +1258,7 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	struct iwl_tof_range_rsp_ntfy_v5 *fw_resp_v5 = (void *)pkt->data;
 	struct iwl_tof_range_rsp_ntfy_v6 *fw_resp_v6 = (void *)pkt->data;
 	struct iwl_tof_range_rsp_ntfy_v7 *fw_resp_v7 = (void *)pkt->data;
-	struct iwl_tof_range_rsp_ntfy_v8 *fw_resp_v8 = (void *)pkt->data;
+	struct iwl_tof_range_rsp_ntfy *fw_resp_v8 = (void *)pkt->data;
 	int i;
 	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
 				  IWL_UCODE_TLV_API_FTM_NEW_RANGE_REQ);
@@ -1294,9 +1294,9 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	IWL_DEBUG_INFO(mvm, "request id: %lld, num of entries: %u\n",
 		       mvm->ftm_initiator.req->cookie, num_of_aps);
 
-	for (i = 0; i < num_of_aps && i < IWL_MVM_TOF_MAX_APS; i++) {
+	for (i = 0; i < num_of_aps && i < IWL_TOF_MAX_APS; i++) {
 		struct cfg80211_pmsr_result result = {};
-		struct iwl_tof_range_rsp_ap_entry_ntfy_v6 *fw_ap;
+		struct iwl_tof_range_rsp_ap_entry_ntfy *fw_ap;
 		int peer_idx;
 
 		if (new_api) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 014777c9cc5d..20aaef913e3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -70,7 +70,7 @@ static const struct ieee80211_iface_combination iwl_mvm_iface_combinations[] = {
 };
 
 static const struct cfg80211_pmsr_capabilities iwl_mvm_pmsr_capa = {
-	.max_peers = IWL_MVM_TOF_MAX_APS,
+	.max_peers = IWL_TOF_MAX_APS,
 	.report_ap_tsf = 1,
 	.randomize_mac_addr = 1,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d17592d3f6c8..b6e0b63cbd3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1310,7 +1310,7 @@ struct iwl_mvm {
 		struct cfg80211_pmsr_request *req;
 		struct wireless_dev *req_wdev;
 		struct list_head loc_list;
-		int responses[IWL_MVM_TOF_MAX_APS];
+		int responses[IWL_TOF_MAX_APS];
 		struct {
 			struct list_head resp;
 		} smooth;
-- 
2.34.1


