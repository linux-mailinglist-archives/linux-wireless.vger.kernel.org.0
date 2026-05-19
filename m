Return-Path: <linux-wireless+bounces-36635-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEzfLl4HDGqBUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36635-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3885784F0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B02309B76D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8539B483;
	Tue, 19 May 2026 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQTRpioP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAE395D8C
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172838; cv=none; b=IgkSRf6x29jeU2UVJxFPhneqCz8h1FEbH7BEdFVg0Z9Lr8m4+MEIdmjuei8ykRUibuQGKqRHYGWyFaIyr3DXps6B3407vp2O+hDSMZeq9FCFmFHeUNRGshEbTOGo1guIVXb0BUtl28LAS/AYkYcCgqxlP496hDsqK5q82MFp+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172838; c=relaxed/simple;
	bh=/UFlEdTdv9m8movZzqORu2aruUQFkDHQHFOV2SVBlfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2//qT2asyN+Cf84KQmHuvXYZ1qgq072AEfwAlKJ1jJWRDvuAPVYy7DXpvfNnl+3hp1wCCSG1o67/5KU0kqWSUlrqTjqc42kXAzq15qpdj7o2CpZJvg2N2ZvzvhPMFR01I1Sdjno4Yd9z1iGPb4i1vdPOrVBPHxIWo6VHFvqtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQTRpioP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172836; x=1810708836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UFlEdTdv9m8movZzqORu2aruUQFkDHQHFOV2SVBlfQ=;
  b=FQTRpioPc4scAYZV07+wS4YpUtIefBl4PBu28BUVfOjtd9TabvlHrYVc
   M/2n6mzZDwQXcQh1+XeNzB41vEG1TnOTZ8h9VmDUTHZutDRtZrLZhNoEA
   UPPt0jeZfCIskpRfA97g3709LaMClrqCeBhUfV99MmnnCKqf4f2Emfv+a
   nbCMBJCo9uJ0a6XAoci5v3dSlCEsmGtjTZt5RjpTP2ATeDpu+wRqmjYFX
   Vl9yJ/vKJ+OPuChKPSXJX/IrHqKrTP3vgbtRWrTWP595jreDuaXqfMpAP
   60pFWRksYR2+nFXkL6vxpYV/mjVT2BhuHODEZoOn85Sm0i2abFVYB+nGw
   Q==;
X-CSE-ConnectionGUID: ayQM22qCS3aUcODQ5FmGUA==
X-CSE-MsgGUID: qLi1uHR0SgqQiqgm2E+M5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605663"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:36 -0700
X-CSE-ConnectionGUID: Gxzx7tAVRoW19D1xLr3eSA==
X-CSE-MsgGUID: NN+e+IPsQZ219TMzQemG1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227306"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 iwlwifi-next 09/15] wifi: iwlwifi: clean up location format/BW encoding
Date: Tue, 19 May 2026 09:40:04 +0300
Message-Id: <20260519064010.549003-10-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36635-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A3885784F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This is all fairly manual, with the shifts etc., and
the documentation has to call out the specific bits
(which also isn't usable for our tracing data). Add
an enum that directly declares the bit masks for it
and then use the more modern u8_encode_bits().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20260517100550.bc09f4f6fd29.I315f15856eb36f0490b8f5008537d3e0ffc215f2@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 100 +++++++++---------
 .../intel/iwlwifi/mld/ftm-initiator.c         |  30 ++++--
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  30 ++++--
 .../intel/iwlwifi/mvm/ftm-responder.c         |  32 ++++--
 4 files changed, 111 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index d3f774ffacde..421ea94ace01 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -88,6 +88,46 @@ enum iwl_location_subcmd_ids {
 	TOF_RANGE_RESPONSE_NOTIF = 0xFF,
 };
 
+/**
+ * enum iwl_location_frame_format - location frame formats
+ * @IWL_LOCATION_FRAME_FORMAT_LEGACY: legacy
+ * @IWL_LOCATION_FRAME_FORMAT_HT: HT
+ * @IWL_LOCATION_FRAME_FORMAT_VHT: VHT
+ * @IWL_LOCATION_FRAME_FORMAT_HE: HE
+ */
+enum iwl_location_frame_format {
+	IWL_LOCATION_FRAME_FORMAT_LEGACY,
+	IWL_LOCATION_FRAME_FORMAT_HT,
+	IWL_LOCATION_FRAME_FORMAT_VHT,
+	IWL_LOCATION_FRAME_FORMAT_HE,
+};
+
+/**
+ * enum iwl_location_bw - location bandwidth selection
+ * @IWL_LOCATION_BW_20MHZ: 20 MHz
+ * @IWL_LOCATION_BW_40MHZ: 40 MHz
+ * @IWL_LOCATION_BW_80MHZ: 80 MHz
+ * @IWL_LOCATION_BW_160MHZ: 160 MHz
+ * @IWL_LOCATION_BW_320MHZ: 320 MHz
+ */
+enum iwl_location_bw {
+	IWL_LOCATION_BW_20MHZ,
+	IWL_LOCATION_BW_40MHZ,
+	IWL_LOCATION_BW_80MHZ,
+	IWL_LOCATION_BW_160MHZ,
+	IWL_LOCATION_BW_320MHZ,
+};
+
+/**
+ * enum iwl_location_format_bw - format/BW encoding
+ * @IWL_LOCATION_FMT_BW_FORMAT: &enum iwl_location_frame_format
+ * @IWL_LOCATION_FMT_BW_BANDWIDTH: &enum iwl_location_bw
+ */
+enum iwl_location_format_bw {
+	IWL_LOCATION_FMT_BW_FORMAT	= 0x0f,
+	IWL_LOCATION_FMT_BW_BANDWIDTH	= 0xf0,
+};
+
 /**
  * struct iwl_tof_config_cmd - ToF configuration
  * @tof_disabled: indicates if ToF is disabled (or not)
@@ -264,8 +304,7 @@ struct iwl_tof_responder_config_cmd_v6 {
  * struct iwl_tof_responder_config_cmd_v7 - ToF AP mode (for debug)
  * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
  * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @rate: current AP rate
  * @channel_num: current AP Channel
  * @ctrl_ch_position: coding of the control channel position relative to
@@ -303,8 +342,7 @@ struct iwl_tof_responder_config_cmd_v7 {
  * struct iwl_tof_responder_config_cmd_v8 - ToF AP mode (for debug)
  * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
  * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @rate: current AP rate
  * @channel_num: current AP Channel
  * @ctrl_ch_position: coding of the control channel position relative to
@@ -349,8 +387,7 @@ struct iwl_tof_responder_config_cmd_v8 {
  * struct iwl_tof_responder_config_cmd_v9 - ToF AP mode (for debug)
  * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
  * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @bss_color: current AP bss_color
  * @channel_num: current AP Channel
  * @ctrl_ch_position: coding of the control channel position relative to
@@ -401,8 +438,7 @@ struct iwl_tof_responder_config_cmd_v9 {
  * struct iwl_tof_responder_config_cmd - ToF AP mode
  * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
  * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @bss_color: current AP bss_color
  * @channel_num: current AP Channel
  * @ctrl_ch_position: coding of the control channel position relative to
@@ -677,44 +713,13 @@ struct iwl_tof_range_req_ap_entry_v3 {
 	__le32 tsf_delta;
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_3 */
 
-/**
- * enum iwl_location_frame_format - location frame formats
- * @IWL_LOCATION_FRAME_FORMAT_LEGACY: legacy
- * @IWL_LOCATION_FRAME_FORMAT_HT: HT
- * @IWL_LOCATION_FRAME_FORMAT_VHT: VHT
- * @IWL_LOCATION_FRAME_FORMAT_HE: HE
- */
-enum iwl_location_frame_format {
-	IWL_LOCATION_FRAME_FORMAT_LEGACY,
-	IWL_LOCATION_FRAME_FORMAT_HT,
-	IWL_LOCATION_FRAME_FORMAT_VHT,
-	IWL_LOCATION_FRAME_FORMAT_HE,
-};
-
-/**
- * enum iwl_location_bw - location bandwidth selection
- * @IWL_LOCATION_BW_20MHZ: 20MHz
- * @IWL_LOCATION_BW_40MHZ: 40MHz
- * @IWL_LOCATION_BW_80MHZ: 80MHz
- * @IWL_LOCATION_BW_160MHZ: 160MHz
- */
-enum iwl_location_bw {
-	IWL_LOCATION_BW_20MHZ,
-	IWL_LOCATION_BW_40MHZ,
-	IWL_LOCATION_BW_80MHZ,
-	IWL_LOCATION_BW_160MHZ,
-};
-
 #define TK_11AZ_LEN	32
 
-#define LOCATION_BW_POS	4
-
 /**
  * struct iwl_tof_range_req_ap_entry_v4 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @ctrl_ch_position: Coding of the control channel position relative to the
  *	center frequency, see iwl_mvm_get_ctrl_pos().
  * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
@@ -764,8 +769,7 @@ enum iwl_location_cipher {
  * struct iwl_tof_range_req_ap_entry_v6 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @ctrl_ch_position: Coding of the control channel position relative to the
  *	center frequency, see iwl_mvm_get_ctrl_pos().
  * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
@@ -811,8 +815,7 @@ struct iwl_tof_range_req_ap_entry_v6 {
  * struct iwl_tof_range_req_ap_entry_v7 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @ctrl_ch_position: Coding of the control channel position relative to the
  *	center frequency, see iwl_mvm_get_ctrl_pos().
  * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
@@ -869,8 +872,7 @@ struct iwl_tof_range_req_ap_entry_v7 {
  * struct iwl_tof_range_req_ap_entry_v8 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @ctrl_ch_position: Coding of the control channel position relative to the
  *	center frequency, see iwl_mvm_get_ctrl_pos().
  * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
@@ -940,8 +942,7 @@ struct iwl_tof_range_req_ap_entry_v8 {
  * struct iwl_tof_range_req_ap_entry_v9 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @ctrl_ch_position: Coding of the control channel position relative to the
  *	center frequency, see iwl_mvm_get_ctrl_pos().
  * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
@@ -1025,8 +1026,7 @@ struct iwl_tof_range_req_ap_entry_v9 {
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @band: 0 for 5.2 GHz, 1 for 2.4 GHz, 2 for 6GHz
  * @channel_num: AP Channel number
- * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
- *             bits 4 - 7: &enum iwl_location_bw.
+ * @format_bw: &enum iwl_location_format_bw
  * @ctrl_ch_position: Coding of the control channel position relative to the
  *	center frequency, see iwl_mvm_get_ctrl_pos().
  * @bssid: AP's BSSID
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
index 3464b3268712..81df3fdfcbf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
@@ -71,24 +71,34 @@ iwl_mld_ftm_set_target_chandef(struct iwl_mld *mld,
 
 	switch (peer->chandef.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		target->format_bw = IWL_LOCATION_FRAME_FORMAT_LEGACY;
-		target->format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		target->format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_LEGACY,
+						   IWL_LOCATION_FMT_BW_FORMAT);
+		target->format_bw |= u8_encode_bits(IWL_LOCATION_BW_20MHZ,
+						    IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_20:
-		target->format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
-		target->format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		target->format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HT,
+						   IWL_LOCATION_FMT_BW_FORMAT);
+		target->format_bw |= u8_encode_bits(IWL_LOCATION_BW_20MHZ,
+						    IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_40:
-		target->format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
-		target->format_bw |= IWL_LOCATION_BW_40MHZ << LOCATION_BW_POS;
+		target->format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HT,
+						   IWL_LOCATION_FMT_BW_FORMAT);
+		target->format_bw |= u8_encode_bits(IWL_LOCATION_BW_40MHZ,
+						    IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_80:
-		target->format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
-		target->format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
+		target->format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_VHT,
+						   IWL_LOCATION_FMT_BW_FORMAT);
+		target->format_bw |= u8_encode_bits(IWL_LOCATION_BW_80MHZ,
+						    IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_160:
-		target->format_bw = IWL_LOCATION_FRAME_FORMAT_HE;
-		target->format_bw |= IWL_LOCATION_BW_160MHZ << LOCATION_BW_POS;
+		target->format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HE,
+						   IWL_LOCATION_FMT_BW_FORMAT);
+		target->format_bw |= u8_encode_bits(IWL_LOCATION_BW_160MHZ,
+						    IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	default:
 		IWL_ERR(mld, "Unsupported BW in FTM request (%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 1b67836b1fac..3a14ca5e512a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -261,20 +261,28 @@ iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
 
 	switch (peer->chandef.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_LEGACY;
-		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_LEGACY,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_20MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_20:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
-		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HT,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_20MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_40:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
-		*format_bw |= IWL_LOCATION_BW_40MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HT,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_40MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_80:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
-		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_VHT,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_80MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
@@ -282,8 +290,10 @@ iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
 						IWL_FW_CMD_VER_UNKNOWN);
 
 		if (cmd_ver >= 13) {
-			*format_bw = IWL_LOCATION_FRAME_FORMAT_HE;
-			*format_bw |= IWL_LOCATION_BW_160MHZ << LOCATION_BW_POS;
+			*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HE,
+						    IWL_LOCATION_FMT_BW_FORMAT);
+			*format_bw |= u8_encode_bits(IWL_LOCATION_BW_160MHZ,
+						     IWL_LOCATION_FMT_BW_BANDWIDTH);
 			break;
 		}
 		fallthrough;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 83f6e508a094..ae7a163c81c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2024, 2026 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
@@ -54,27 +54,37 @@ static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
 {
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_LEGACY;
-		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_LEGACY,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_20MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_20:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
-		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HT,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_20MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		break;
 	case NL80211_CHAN_WIDTH_40:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
-		*format_bw |= IWL_LOCATION_BW_40MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HT,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_40MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
 		break;
 	case NL80211_CHAN_WIDTH_80:
-		*format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
-		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
+		*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_VHT,
+					    IWL_LOCATION_FMT_BW_FORMAT);
+		*format_bw |= u8_encode_bits(IWL_LOCATION_BW_80MHZ,
+					     IWL_LOCATION_FMT_BW_BANDWIDTH);
 		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		if (cmd_ver >= 9) {
-			*format_bw = IWL_LOCATION_FRAME_FORMAT_HE;
-			*format_bw |= IWL_LOCATION_BW_160MHZ << LOCATION_BW_POS;
+			*format_bw = u8_encode_bits(IWL_LOCATION_FRAME_FORMAT_HE,
+						    IWL_LOCATION_FMT_BW_FORMAT);
+			*format_bw |= u8_encode_bits(IWL_LOCATION_BW_160MHZ,
+						     IWL_LOCATION_FMT_BW_BANDWIDTH);
 			*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
 			break;
 		}
-- 
2.34.1


