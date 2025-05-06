Return-Path: <linux-wireless+bounces-22676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F85AACE2F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B91C26829
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EE20ADC9;
	Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUjo6WuP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98081F4C97
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560481; cv=none; b=Hfl1caUfrD5Fir6PV9es06vRoS0D/oZx+VZop2GFcJETGGp7FTCvadZhHvdB1CT430cECRNYP/UqH0M48PlBfupl4WPqZxh8wljPge9LTvvmIyhWZSR9Yk7lQ8lBS58cZcTsczbMa+ZtQBeff5n1LlVgJEOxbklSOvGyrtHlkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560481; c=relaxed/simple;
	bh=irtKMEaTq2lRzonXfTz44Jg1ZTDOeRWMq362IbDoD2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxiXM4pEd6LWwURG/Yy2rG6ktxXzKD+MzL5z/VtQLBn49+IGom069TR8xvoRE5j92OBXEewSUQ9/fAxjqqCG9Lcrrctf2myZCcZR9eYNZ5c67mG6TbCUbqNmoR4gqFRs8sciicdJC2wXIxj5FbBiHFbf4qRs5d/ANF9Cr6eMujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUjo6WuP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560480; x=1778096480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=irtKMEaTq2lRzonXfTz44Jg1ZTDOeRWMq362IbDoD2U=;
  b=FUjo6WuPne7//IfSFurvv38VLFB9LBBoipZvNbGK+LYNimWupXAwQEhW
   9c2GKD7YG/PBeije69Vp6BQcacR+xj3k0v+seliffDnOS17WWp5RAZ6oJ
   C6dzTr4pa8a8f2Jh2BtTsm2bvx6kJv/A4jQT6DooEgxPDv4k8OSWXI0uK
   vx40CBwLOWbcnCrkpRuRyC/CFqZLx2PfeV/4JmCOWDpINyjAuONyawzwH
   Zrtp/JorMWTzflvHw/tZcWEVT0GR+oeaAZeE6ppWq/Ta9ZTz7rUFQ/I3g
   iWlpH/ZAigXO8vD9044Tnu6DdgBSwnnHOG0qgVfRdzEZAWW6Bu6gn+041
   w==;
X-CSE-ConnectionGUID: NHJfQIGoQuCNWRKNTwhdhw==
X-CSE-MsgGUID: AKKqBAYxSeKk0bsBJKlWfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961618"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961618"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:20 -0700
X-CSE-ConnectionGUID: j5cgNSclQLSkymZ0W00WRw==
X-CSE-MsgGUID: SFCl5EKvQGakoXrjHIxIPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465407"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: add range response version 10 support
Date: Tue,  6 May 2025 22:40:49 +0300
Message-Id: <20250506194102.3407967-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Range response version 10 removes the rx and tx rates fields.
These fields aren't used by the driver anyway, so no change is
needed to support it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Message-Id: <20250506223834.032e2cda4740.Iee313cddcdfa504800c0ff77bdc11ab1856bc9cd@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 84 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index e1952fc6d149..c1b4a38a93de 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -1609,7 +1609,7 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v5 {
 } __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_5 */
 
 /**
- * struct iwl_tof_range_rsp_ap_entry_ntfy - AP parameters (response)
+ * struct iwl_tof_range_rsp_ap_entry_ntfy_v7 - AP parameters (response)
  * @bssid: BSSID of the AP
  * @measure_status: current APs measurement status, one of
  *	&enum iwl_tof_entry_status.
@@ -1645,7 +1645,7 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v5 {
  * @tx_pn: the last PN used for this responder Tx in case PMF is configured in
  *	LE byte order.
  */
-struct iwl_tof_range_rsp_ap_entry_ntfy {
+struct iwl_tof_range_rsp_ap_entry_ntfy_v7 {
 	u8 bssid[ETH_ALEN];
 	u8 measure_status;
 	u8 measure_bw;
@@ -1672,6 +1672,65 @@ struct iwl_tof_range_rsp_ap_entry_ntfy {
 } __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_6,
 	       LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_7 */
 
+/**
+ * struct iwl_tof_range_rsp_ap_entry_ntfy - AP parameters (response)
+ * @bssid: BSSID of the AP
+ * @measure_status: current APs measurement status, one of
+ *	&enum iwl_tof_entry_status.
+ * @measure_bw: Current AP Bandwidth: 0  20MHz, 1  40MHz, 2  80MHz
+ * @rtt: The Round Trip Time that took for the last measurement for
+ *	current AP [pSec]
+ * @rtt_variance: The Variance of the RTT values measured for current AP
+ * @rtt_spread: The Difference between the maximum and the minimum RTT
+ *	values measured for current AP in the current session [pSec]
+ * @rssi: RSSI as uploaded in the Channel Estimation notification
+ * @rssi_spread: The Difference between the maximum and the minimum RSSI values
+ *	measured for current AP in the current session
+ * @last_burst: 1 if no more FTM sessions are scheduled for this responder
+ * @refusal_period: refusal period in case of
+ *	@IWL_TOF_ENTRY_RESPONDER_CANNOT_COLABORATE [sec]
+ * @timestamp: The GP2 Clock [usec] where Channel Estimation notification was
+ *	uploaded by the LMAC
+ * @start_tsf: measurement start time in TSF of the mac specified in the range
+ *	request
+ * @reserved1: reserved, for backwards compatibility
+ * @t2t3_initiator: as calculated from the algo in the initiator
+ * @t1t4_responder: as calculated from the algo in the responder
+ * @common_calib: Calib val that was used in for this AP measurement
+ * @specific_calib: val that was used in for this AP measurement
+ * @papd_calib_output: The result of the tof papd calibration that was injected
+ *	into the algorithm.
+ * @rttConfidence: a value between 0 - 31 that represents the rtt accuracy.
+ * @reserved: for alignment
+ * @rx_pn: the last PN used for this responder Rx in case PMF is configured in
+ *	LE byte order.
+ * @tx_pn: the last PN used for this responder Tx in case PMF is configured in
+ *	LE byte order.
+ */
+struct iwl_tof_range_rsp_ap_entry_ntfy {
+	u8 bssid[ETH_ALEN];
+	u8 measure_status;
+	u8 measure_bw;
+	__le32 rtt;
+	__le32 rtt_variance;
+	__le32 rtt_spread;
+	s8 rssi;
+	u8 rssi_spread;
+	u8 last_burst;
+	u8 refusal_period;
+	__le32 timestamp;
+	__le32 start_tsf;
+	__le32 reserved1[2];
+	__le32 t2t3_initiator;
+	__le32 t1t4_responder;
+	__le16 common_calib;
+	__le16 specific_calib;
+	__le32 papd_calib_output;
+	u8 rttConfidence;
+	u8 reserved[3];
+	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
+} __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_8 */
 
 /**
  * enum iwl_tof_response_status - tof response status
@@ -1738,6 +1797,24 @@ struct iwl_tof_range_rsp_ntfy_v7 {
 	struct iwl_tof_range_rsp_ap_entry_ntfy_v5 ap[IWL_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_7 */
 
+/**
+ * struct iwl_tof_range_rsp_ntfy_v9 - ranging response notification
+ * @request_id: A Token ID of the corresponding Range request
+ * @num_of_aps: Number of APs results
+ * @last_report: 1 if no more FTM sessions are scheduled, 0 otherwise.
+ * @reserved: reserved
+ * @ap: per-AP data
+ */
+struct iwl_tof_range_rsp_ntfy_v9 {
+	u8 request_id;
+	u8 num_of_aps;
+	u8 last_report;
+	u8 reserved;
+	struct iwl_tof_range_rsp_ap_entry_ntfy_v7 ap[IWL_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_8,
+	     * LOCATION_RANGE_RSP_NTFY_API_S_VER_9
+	     */
+
 /**
  * struct iwl_tof_range_rsp_ntfy - ranging response notification
  * @request_id: A Token ID of the corresponding Range request
@@ -1752,8 +1829,7 @@ struct iwl_tof_range_rsp_ntfy {
 	u8 last_report;
 	u8 reserved;
 	struct iwl_tof_range_rsp_ap_entry_ntfy ap[IWL_TOF_MAX_APS];
-} __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_8,
-	       LOCATION_RANGE_RSP_NTFY_API_S_VER_9 */
+} __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_10 */
 
 #define IWL_MVM_TOF_MCSI_BUF_SIZE  (245)
 /**
-- 
2.34.1


