Return-Path: <linux-wireless+bounces-33472-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YALTBjrAu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33472-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:22:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D12C8863
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8405F32C40FE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797103BA236;
	Thu, 19 Mar 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug8VDTnd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AD371892
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911395; cv=none; b=mSBwvIbcBmZiAiKcoWZIEej9gc0NE/eYmjHGXDwz8OmRy57637VWGor14onkVWBfamwlfdYmbutjgfjE2VPbkpSWdeFVeZzW0QmR2j/M330xAAtJ/gsmWZFtfrzr6KlGdCwMAtkBcAusopBEFZv2qO/ooPEgLBMe15Ot6H3ahvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911395; c=relaxed/simple;
	bh=S3ef25JEgyt8x+gTBJlcJyYRBHZX3CV14Ew6hfzOcX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DF4MIeIBYod5doD9S0BUPkjHCteUZmGcFOw+58gF7+6lQGCqk+8gHsORx8uk+E5YmpaWar546e7E7i1toiWceCOG7REqaZ0VzaF8XfyhFkbC7FGkFSOE+mGH4SRKIZfH2Kf3g2zznkfWpJXDRPz7essoO7CueNLzoJrnWKbEqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ug8VDTnd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911391; x=1805447391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S3ef25JEgyt8x+gTBJlcJyYRBHZX3CV14Ew6hfzOcX4=;
  b=Ug8VDTndzD/i6cnNy6IRN4eZ2KgZIY7otT79xV1ZkO0P6+O8LcXUW7rM
   wUW7dHxLm7EVEub257TQJ4+MPHo/4uOohahMIVAxdqi+g3Yib5mIyU9Q8
   8RnC/gY3Gd+OXWbMYYg36WuyZ0/OzIb++CDEoVIsu8/V99X97GlPct4pV
   XO7EkYaV81zUPnZg8Gd0v0ZqjNudTnFN0AslPM8PDJe/gkgHYGCO4ErgB
   8UlhUBzrbEE9UbuSZxXBtIyucl3//R0WXCIQgU/y7mz5Ovm6WBwX6cVDT
   ZlEY/GqM27w1DziUwpkmb2zlbuUvVkQXkXuBlQqjlYL+zOPUyzTvOxVJo
   g==;
X-CSE-ConnectionGUID: 7cEIEKWJSraNB50WzE/ikQ==
X-CSE-MsgGUID: tf20/XAkRp6dbMMih/nnCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992720"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992720"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:50 -0700
X-CSE-ConnectionGUID: IbMaU7JGSBWn8K1Nhk8exA==
X-CSE-MsgGUID: mN3D/lNTS2e+dNKAQfsGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387142"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 iwlwifi-next 08/15] wifi: iwlwifi: mld: Introduce scan command version 18
Date: Thu, 19 Mar 2026 11:09:20 +0200
Message-Id: <20260319110722.c995b4e8bbc5.Ie401d9cf02daaa5e6adf2b3c309643589e3ead71@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33472-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 692D12C8863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ilan Peer <ilan.peer@intel.com>

The FW scan logic was extended to support new channels in the
7 GHz band, as such, the scan command was modified to support
scanning more PSC channels.

Introduce scan command version 18 handling, which is different
from scan command version 17 only in the number of supported
channel configurations.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 45 ++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 87 +++++++++++++++----
 2 files changed, 115 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 60f0a4924ddf..c2bb400c834c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -985,6 +985,7 @@ struct iwl_scan_probe_params_v4 {
 } __packed; /* SCAN_PROBE_PARAMS_API_S_VER_4 */
 
 #define SCAN_MAX_NUM_CHANS_V3 67
+#define SCAN_MAX_NUM_CHANS_V4 68
 
 /**
  * struct iwl_scan_channel_params_v4 - channel params
@@ -1027,6 +1028,24 @@ struct iwl_scan_channel_params_v7 {
 	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
 } __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_6 */
 
+/**
+ * struct iwl_scan_channel_params_v8 - channel params
+ * @flags: channel flags &enum iwl_scan_channel_flags
+ * @count: num of channels in scan request
+ * @n_aps_override: override the number of APs the FW uses to calculate dwell
+ *	time when adaptive dwell is used.
+ *	Channel k will use n_aps_override[i] when BIT(20 + i) is set in
+ *	channel_config[k].flags
+ * @channel_config: array of explicit channel configurations
+ *      for 2.4Ghz and 5.2Ghz bands
+ */
+struct iwl_scan_channel_params_v8 {
+	u8 flags;
+	u8 count;
+	u8 n_aps_override[2];
+	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V4];
+} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_8 */
+
 /**
  * struct iwl_scan_general_params_v11 - channel params
  * @flags: &enum iwl_umac_scan_general_flags_v2
@@ -1109,6 +1128,20 @@ struct iwl_scan_req_params_v17 {
 	struct iwl_scan_probe_params_v4 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_17 - 14 */
 
+/**
+ * struct iwl_scan_req_params_v18 - scan request parameters (v18)
+ * @general_params: &struct iwl_scan_general_params_v11
+ * @channel_params: &struct iwl_scan_channel_params_v8
+ * @periodic_params: &struct iwl_scan_periodic_parms_v1
+ * @probe_params: &struct iwl_scan_probe_params_v4
+ */
+struct iwl_scan_req_params_v18 {
+	struct iwl_scan_general_params_v11 general_params;
+	struct iwl_scan_channel_params_v8 channel_params;
+	struct iwl_scan_periodic_parms_v1 periodic_params;
+	struct iwl_scan_probe_params_v4 probe_params;
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_18 */
+
 /**
  * struct iwl_scan_req_umac_v12 - scan request command (v12)
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
@@ -1133,6 +1166,18 @@ struct iwl_scan_req_umac_v17 {
 	struct iwl_scan_req_params_v17 scan_params;
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_17 - 14 */
 
+/**
+ * struct iwl_scan_req_umac_v18 - scan request command (v18)
+ * @uid: scan id, &enum iwl_umac_scan_uid_offsets
+ * @ooc_priority: out of channel priority - &enum iwl_scan_priority
+ * @scan_params: scan parameters
+ */
+struct iwl_scan_req_umac_v18 {
+	__le32 uid;
+	__le32 ooc_priority;
+	struct iwl_scan_req_params_v18 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_18 */
+
 /**
  * struct iwl_umac_scan_abort - scan abort command
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 7f4679134def..96cd970cceb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -118,7 +118,7 @@ struct iwl_mld_scan_params {
 
 struct iwl_scan_req_params_ptrs {
 	struct iwl_scan_general_params_v11 *general_params;
-	struct iwl_scan_channel_params_v7 *channel_params;
+	struct iwl_scan_channel_params_v8 *channel_params;
 	struct iwl_scan_periodic_parms_v1 *periodic_params;
 	struct iwl_scan_probe_params_v4 *probe_params;
 };
@@ -840,7 +840,7 @@ iwl_mld_scan_cmd_set_channels(struct iwl_mld *mld,
 			      int n_channels, u32 flags,
 			      enum nl80211_iftype vif_type)
 {
-	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
+	struct iwl_scan_channel_params_v8 *cp = scan_ptrs->channel_params;
 
 	for (int i = 0; i < n_channels; i++) {
 		enum nl80211_band band = channels[i]->band;
@@ -883,7 +883,7 @@ iwl_mld_scan_cfg_channels_6g(struct iwl_mld *mld,
 			     enum nl80211_iftype vif_type)
 {
 	struct iwl_scan_probe_params_v4 *pp = scan_ptrs->probe_params;
-	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
+	struct iwl_scan_channel_params_v8 *cp = scan_ptrs->channel_params;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
 		params->scan_6ghz_params;
 	u32 i;
@@ -1083,7 +1083,7 @@ iwl_mld_scan_cmd_set_6ghz_chan_params(struct iwl_mld *mld,
 				      struct ieee80211_vif *vif,
 				      struct iwl_scan_req_params_ptrs *scan_ptrs)
 {
-	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
+	struct iwl_scan_channel_params_v8 *cp = scan_ptrs->channel_params;
 
 	/* Explicitly clear the flags since most of them are not
 	 * relevant for 6 GHz scan.
@@ -1111,7 +1111,7 @@ iwl_mld_scan_cmd_set_chan_params(struct iwl_mld *mld,
 				 enum iwl_mld_scan_status scan_status,
 				 u32 channel_cfg_flags)
 {
-	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
+	struct iwl_scan_channel_params_v8 *cp = scan_ptrs->channel_params;
 	struct ieee80211_supported_band *sband =
 		&mld->nvm_data->bands[NL80211_BAND_6GHZ];
 
@@ -1173,39 +1173,89 @@ struct iwl_scan_umac_handler {
 	.handler = iwl_mld_scan_umac_v##_ver,	\
 }
 
-static int iwl_mld_scan_umac_v17(struct iwl_mld *mld, struct ieee80211_vif *vif,
+static int iwl_mld_scan_umac_common(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    struct iwl_mld_scan_params *params,
+				    struct iwl_scan_req_params_ptrs *scan_ptrs,
+				    enum iwl_mld_scan_status scan_status,
+				    bool low_latency)
+{
+	u32 bitmap_ssid = 0;
+	int ret;
+
+	iwl_mld_scan_cmd_set_gen_params(mld, params, vif, scan_ptrs,
+					scan_status);
+
+	ret = iwl_mld_scan_cmd_set_sched_params(params, scan_ptrs);
+	if (ret)
+		return ret;
+
+	iwl_mld_scan_cmd_set_probe_params(params, scan_ptrs, &bitmap_ssid);
+
+	return iwl_mld_scan_cmd_set_chan_params(mld, params, vif, scan_ptrs,
+						low_latency, scan_status,
+						bitmap_ssid);
+}
+
+static int iwl_mld_scan_umac_v18(struct iwl_mld *mld, struct ieee80211_vif *vif,
 				 struct iwl_mld_scan_params *params,
 				 enum iwl_mld_scan_status scan_status,
 				 int uid, u32 ooc_priority, bool low_latency)
 {
-	struct iwl_scan_req_umac_v17 *cmd = mld->scan.cmd;
+	struct iwl_scan_req_umac_v18 *cmd = mld->scan.cmd;
 	struct iwl_scan_req_params_ptrs scan_ptrs = {
 		.general_params = &cmd->scan_params.general_params,
 		.probe_params = &cmd->scan_params.probe_params,
 		.channel_params = &cmd->scan_params.channel_params,
 		.periodic_params = &cmd->scan_params.periodic_params
 	};
-	u32 bitmap_ssid = 0;
 	int ret;
 
-	if (WARN_ON(params->n_channels > SCAN_MAX_NUM_CHANS_V3))
+	if (WARN_ON(params->n_channels > SCAN_MAX_NUM_CHANS_V4))
 		return -EINVAL;
 
 	cmd->uid = cpu_to_le32(uid);
 	cmd->ooc_priority = cpu_to_le32(ooc_priority);
 
-	iwl_mld_scan_cmd_set_gen_params(mld, params, vif, &scan_ptrs,
-					scan_status);
-
-	ret = iwl_mld_scan_cmd_set_sched_params(params, &scan_ptrs);
+	ret = iwl_mld_scan_umac_common(mld, vif, params, &scan_ptrs,
+				       scan_status, low_latency);
 	if (ret)
 		return ret;
 
-	iwl_mld_scan_cmd_set_probe_params(params, &scan_ptrs, &bitmap_ssid);
+	return uid;
+}
+
+static int iwl_mld_scan_umac_v17(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				 struct iwl_mld_scan_params *params,
+				 enum iwl_mld_scan_status scan_status,
+				 int uid, u32 ooc_priority, bool low_latency)
+{
+	struct iwl_scan_req_umac_v17 *cmd = mld->scan.cmd;
+	struct iwl_scan_req_params_ptrs scan_ptrs = {
+		.general_params = &cmd->scan_params.general_params,
+		.probe_params = &cmd->scan_params.probe_params,
+
+		/* struct iwl_scan_channel_params_v8 and struct
+		 * iwl_scan_channel_params_v7 are almost identical. The only
+		 * difference is that the newer version allows configuration of
+		 * more channels. So casting here is ok as long as we ensure
+		 * that we don't exceed the max number of channels supported by
+		 * the older version (see the WARN_ON below).
+		 */
+		.channel_params = (struct iwl_scan_channel_params_v8 *)
+			&cmd->scan_params.channel_params,
+		.periodic_params = &cmd->scan_params.periodic_params
+	};
+	int ret;
+
+	if (WARN_ON(params->n_channels > SCAN_MAX_NUM_CHANS_V3))
+		return -EINVAL;
+
+	cmd->uid = cpu_to_le32(uid);
+	cmd->ooc_priority = cpu_to_le32(ooc_priority);
 
-	ret = iwl_mld_scan_cmd_set_chan_params(mld, params, vif, &scan_ptrs,
-					       low_latency, scan_status,
-					       bitmap_ssid);
+	ret = iwl_mld_scan_umac_common(mld, vif, params, &scan_ptrs,
+				       scan_status, low_latency);
 	if (ret)
 		return ret;
 
@@ -1214,6 +1264,7 @@ static int iwl_mld_scan_umac_v17(struct iwl_mld *mld, struct ieee80211_vif *vif,
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(18),
 	IWL_SCAN_UMAC_HANDLER(17),
 };
 
@@ -2095,6 +2146,8 @@ int iwl_mld_alloc_scan_cmd(struct iwl_mld *mld)
 
 	if (scan_cmd_ver == 17) {
 		scan_cmd_size = sizeof(struct iwl_scan_req_umac_v17);
+	} else if (scan_cmd_ver == 18) {
+		scan_cmd_size = sizeof(struct iwl_scan_req_umac_v18);
 	} else {
 		IWL_ERR(mld, "Unexpected scan cmd version %d\n", scan_cmd_ver);
 		return -EINVAL;
-- 
2.34.1


