Return-Path: <linux-wireless+bounces-36527-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM/AJcrPCGqA6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36527-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D7255DA3C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C322A3010166
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32B2BDC23;
	Sat, 16 May 2026 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N70t/sBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC835DA69
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962328; cv=none; b=JqEi59QSBLuAQhjYF/C7shjXLcFudM0kR68x+394KghNnHbjmKjfmd0Ll7aU21lO/kMoT9Y3W3YPGdKTA6MvnrNRmR4+ruDCEr+RBgiXC0YBnHKnfC4yZv9xGPSD3BkRBJpsIsvlA/82iN2rJ7QiwUTD8fKj474z1A3gfPA7XYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962328; c=relaxed/simple;
	bh=bmMrd4Pi3nl5dEnM1zd66RWUEeWZF21tMkim5HZieac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A672Vilukxx4LfhfF+rsJv+vfrfs6r/ar9RgYkmMjt6u1XZk4rG+tKvpeGFRQHzBmo46eh3eia9U/7SS86ODs6tp2hkcP/e9RTJspLNP+m23SkYc/L6ciFqmrEmNhWka5U9eo6knj3bwC+8+ozj4Noa9DjPFMlpMPre89MnrazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N70t/sBh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962326; x=1810498326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bmMrd4Pi3nl5dEnM1zd66RWUEeWZF21tMkim5HZieac=;
  b=N70t/sBhiVsHta1J7N1XA81i8IZOOTXnl96RwRrmoZhc7MwtlBYt3pzC
   C4a1OURVAOebxZvW+PAYvMbvG2EKWXsQKuelVVpCdVY+gav7un114C7Yg
   CzdY++/xghUGn+28Stf4TIgkufAOHDzAhqaM6BTljavqzzPrjZUwTJ5Xd
   YdVvzkJmipurgMXLs7YYgKc47tYNwteaO7PMyjkRXmvcGs/noU6F0M/r5
   t7BgJ4n0tVqPBM9zcgfy2F/HhD7cCpW3loRGoBNOnSPPc+BY/eKhHb0RI
   l2A6iLA22yGR3FDn9FKaLTviL9YOg0i1OXUDEsWp1zBRHUzOaDF1XmbWw
   g==;
X-CSE-ConnectionGUID: kfeht0BrQG6yn5fr54p11A==
X-CSE-MsgGUID: cOAwM2RjQNqwSXzUOuuh9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845730"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845730"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:06 -0700
X-CSE-ConnectionGUID: UvbZ7Dl0SJWUj4DoFKODYA==
X-CSE-MsgGUID: 2b3oZ0RnQf+Qe0POr4q2bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130912"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 09/15] wifi: iwlwifi: clean up location format/BW encoding
Date: Sat, 16 May 2026 23:11:31 +0300
Message-Id: <20260516230843.bc09f4f6fd29.I315f15856eb36f0490b8f5008537d3e0ffc215f2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03D7255DA3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36527-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

This is all fairly manual, with the shifts etc., and
the documentation has to call out the specific bits
(which also isn't usable for our tracing data). Add
an enum that directly declares the bit masks for it
and then use the more modern u8_encode_bits().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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


