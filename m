Return-Path: <linux-wireless+bounces-33470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCvBNfrBu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886B2C8AC7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ECE332C20FE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF03B38B9;
	Thu, 19 Mar 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZyyEzz5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88013B47D1
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911394; cv=none; b=WzdskeOOUJGeiRHTzo0NSx4BmCqBU5tHXf3oo+OGaDDa0katLdplU7nIcOJiMlfJoFNRFSCLOKlHvW7nYFVkCpditXlpVWOp7Z2eWQZvNMoRWG9lvTQ+/Tx0QIadWlVnxcxmVdZjcJrpsNRMSZ1s5whzWbpLfH3VawLiLVQurkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911394; c=relaxed/simple;
	bh=682icWfmaI85i/YmZIbdBHdgZ+kEdxnEWkDiS3uyuAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iklZhBIonAL9xUPBlTnN/9YsuvABRoCGgX1K2PowN8RM0zkQyWoexCZ8s7DV+aQInC+SX3Te9Nqe0WvnufHa4fAjBzkWt+iqWJbY1v0/kw2rmEFWbX2kOqkpX1RMbVcJRl82GCXn7nY1Au9QXjmu+7aKVM9J+wqmnPC1WqI4xPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZyyEzz5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911389; x=1805447389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=682icWfmaI85i/YmZIbdBHdgZ+kEdxnEWkDiS3uyuAY=;
  b=WZyyEzz5dYtvT0FnricmQZzBI8Sb+aOPRax/oRKnPPhaw/iuBXyaJV6h
   RpNez7YnXgUZiT5JcR7ZwoB9BpwXnx3w7GjG1QZfna9aDGxR+KZZ91dQz
   oRDLNhzYZN814MTi+YijQ2a8OZD+l15Jb7q+Xz7ts8AwcRHyN5j77sMWo
   teNZDaOa6L+5ORmMUTk1TPTXrUrTVjKCdmw7x6pX/Vs60umyuXOdwE/04
   t0k3VAgB8vh6PmPTOywrHM48RELMnqMB8yNrWYDgTIyUHwjhnFQE8SrUa
   Pe4FDI+mBRayihNAyzy7h3oa3k8PObzx3jyxwBF5N/+MzrpMxLIEP0YkP
   g==;
X-CSE-ConnectionGUID: tZxp8u/pQiG3j7wQq2Gd5g==
X-CSE-MsgGUID: EXmm0YegSqK7kWa+nb1RAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992715"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992715"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:49 -0700
X-CSE-ConnectionGUID: 6/DZmBcJTuetJtY39OVBTw==
X-CSE-MsgGUID: M/808NeYTC6skWIlL4pMGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387139"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: mld: Refactor scan command handling
Date: Thu, 19 Mar 2026 11:09:19 +0200
Message-Id: <20260319110722.a3e9589769f0.If458023e234ed79db7474107d98f0b6e28e565e5@changeid>
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
	TAGGED_FROM(0.00)[bounces-33470-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3886B2C8AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ilan Peer <ilan.peer@intel.com>

As a preparation for a new scan command version, refactor
the scan command building such that it would allow introducing
new scan command structures in a simpler way.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 159 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |   2 +
 2 files changed, 114 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index a1a4cf3ab3d3..7f4679134def 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -116,6 +116,13 @@ struct iwl_mld_scan_params {
 	u8 bssid[ETH_ALEN] __aligned(2);
 };
 
+struct iwl_scan_req_params_ptrs {
+	struct iwl_scan_general_params_v11 *general_params;
+	struct iwl_scan_channel_params_v7 *channel_params;
+	struct iwl_scan_periodic_parms_v1 *periodic_params;
+	struct iwl_scan_probe_params_v4 *probe_params;
+};
+
 struct iwl_mld_scan_respect_p2p_go_iter_data {
 	struct ieee80211_vif *current_vif;
 	bool p2p_go;
@@ -512,9 +519,10 @@ iwl_mld_scan_get_cmd_gen_flags2(struct iwl_mld *mld,
 
 static void
 iwl_mld_scan_cmd_set_dwell(struct iwl_mld *mld,
-			   struct iwl_scan_general_params_v11 *gp,
-			   struct iwl_mld_scan_params *params)
+			   struct iwl_mld_scan_params *params,
+			   struct iwl_scan_req_params_ptrs *scan_ptrs)
 {
+	struct iwl_scan_general_params_v11 *gp = scan_ptrs->general_params;
 	const struct iwl_mld_scan_timing_params *timing =
 		&scan_timing[params->type];
 
@@ -551,9 +559,10 @@ static void
 iwl_mld_scan_cmd_set_gen_params(struct iwl_mld *mld,
 				struct iwl_mld_scan_params *params,
 				struct ieee80211_vif *vif,
-				struct iwl_scan_general_params_v11 *gp,
+				struct iwl_scan_req_params_ptrs *scan_ptrs,
 				enum iwl_mld_scan_status scan_status)
 {
+	struct iwl_scan_general_params_v11 *gp = scan_ptrs->general_params;
 	u16 gen_flags = iwl_mld_scan_get_cmd_gen_flags(mld, params, vif,
 						       scan_status);
 	u8 gen_flags2 = iwl_mld_scan_get_cmd_gen_flags2(mld, params, vif,
@@ -566,7 +575,7 @@ iwl_mld_scan_cmd_set_gen_params(struct iwl_mld *mld,
 	gp->flags = cpu_to_le16(gen_flags);
 	gp->flags2 = gen_flags2;
 
-	iwl_mld_scan_cmd_set_dwell(mld, gp, params);
+	iwl_mld_scan_cmd_set_dwell(mld, params, scan_ptrs);
 
 	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1)
 		gp->num_of_fragments[SCAN_LB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
@@ -577,9 +586,12 @@ iwl_mld_scan_cmd_set_gen_params(struct iwl_mld *mld,
 
 static int
 iwl_mld_scan_cmd_set_sched_params(struct iwl_mld_scan_params *params,
-				  struct iwl_scan_umac_schedule *schedule,
-				  __le16 *delay)
+				  struct iwl_scan_req_params_ptrs *scan_ptrs)
 {
+	struct iwl_scan_umac_schedule *schedule =
+		scan_ptrs->periodic_params->schedule;
+	__le16 *delay = &scan_ptrs->periodic_params->delay;
+
 	if (WARN_ON(!params->n_scan_plans ||
 		    params->n_scan_plans > IWL_MAX_SCHED_SCAN_PLANS))
 		return -EINVAL;
@@ -657,11 +669,12 @@ iwl_mld_scan_cmd_build_ssids(struct iwl_mld_scan_params *params,
 
 static void
 iwl_mld_scan_fill_6g_chan_list(struct iwl_mld_scan_params *params,
-			       struct iwl_scan_probe_params_v4 *pp)
+			       struct iwl_scan_req_params_ptrs *scan_ptrs)
 {
 	int j, idex_s = 0, idex_b = 0;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
 		params->scan_6ghz_params;
+	struct iwl_scan_probe_params_v4 *pp = scan_ptrs->probe_params;
 
 	for (j = 0;
 	     j < params->n_ssids && idex_s < SCAN_SHORT_SSID_MAX_SIZE;
@@ -725,13 +738,15 @@ iwl_mld_scan_fill_6g_chan_list(struct iwl_mld_scan_params *params,
 
 static void
 iwl_mld_scan_cmd_set_probe_params(struct iwl_mld_scan_params *params,
-				  struct iwl_scan_probe_params_v4 *pp,
+				  struct iwl_scan_req_params_ptrs *scan_ptrs,
 				  u32 *bitmap_ssid)
 {
+	struct iwl_scan_probe_params_v4 *pp = scan_ptrs->probe_params;
+
 	pp->preq = params->preq;
 
 	if (params->scan_6ghz) {
-		iwl_mld_scan_fill_6g_chan_list(params, pp);
+		iwl_mld_scan_fill_6g_chan_list(params, scan_ptrs);
 		return;
 	}
 
@@ -821,10 +836,12 @@ static u32 iwl_mld_scan_ch_n_aps_flag(enum nl80211_iftype vif_type, u8 ch_id)
 static void
 iwl_mld_scan_cmd_set_channels(struct iwl_mld *mld,
 			      struct ieee80211_channel **channels,
-			      struct iwl_scan_channel_params_v7 *cp,
+			      struct iwl_scan_req_params_ptrs *scan_ptrs,
 			      int n_channels, u32 flags,
 			      enum nl80211_iftype vif_type)
 {
+	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
+
 	for (int i = 0; i < n_channels; i++) {
 		enum nl80211_band band = channels[i]->band;
 		struct iwl_scan_channel_cfg_umac *cfg = &cp->channel_config[i];
@@ -862,10 +879,11 @@ static u8
 iwl_mld_scan_cfg_channels_6g(struct iwl_mld *mld,
 			     struct iwl_mld_scan_params *params,
 			     u32 n_channels,
-			     struct iwl_scan_probe_params_v4 *pp,
-			     struct iwl_scan_channel_params_v7 *cp,
+			     struct iwl_scan_req_params_ptrs *scan_ptrs,
 			     enum nl80211_iftype vif_type)
 {
+	struct iwl_scan_probe_params_v4 *pp = scan_ptrs->probe_params;
+	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
 		params->scan_6ghz_params;
 	u32 i;
@@ -1063,25 +1081,23 @@ static int
 iwl_mld_scan_cmd_set_6ghz_chan_params(struct iwl_mld *mld,
 				      struct iwl_mld_scan_params *params,
 				      struct ieee80211_vif *vif,
-				      struct iwl_scan_req_params_v17 *scan_p)
+				      struct iwl_scan_req_params_ptrs *scan_ptrs)
 {
-	struct iwl_scan_channel_params_v7 *chan_p = &scan_p->channel_params;
-	struct iwl_scan_probe_params_v4 *probe_p = &scan_p->probe_params;
+	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
 
 	/* Explicitly clear the flags since most of them are not
 	 * relevant for 6 GHz scan.
 	 */
-	chan_p->flags = 0;
-	chan_p->count = iwl_mld_scan_cfg_channels_6g(mld, params,
-						     params->n_channels,
-						     probe_p, chan_p,
-						     vif->type);
-	if (!chan_p->count)
+	cp->flags = 0;
+	cp->count = iwl_mld_scan_cfg_channels_6g(mld, params,
+						 params->n_channels,
+						 scan_ptrs, vif->type);
+	if (!cp->count)
 		return -EINVAL;
 
 	if (!params->n_ssids ||
 	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
-		chan_p->flags |= IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER;
+		cp->flags |= IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER;
 
 	return 0;
 }
@@ -1090,12 +1106,12 @@ static int
 iwl_mld_scan_cmd_set_chan_params(struct iwl_mld *mld,
 				 struct iwl_mld_scan_params *params,
 				 struct ieee80211_vif *vif,
-				 struct iwl_scan_req_params_v17 *scan_p,
+				 struct iwl_scan_req_params_ptrs *scan_ptrs,
 				 bool low_latency,
 				 enum iwl_mld_scan_status scan_status,
 				 u32 channel_cfg_flags)
 {
-	struct iwl_scan_channel_params_v7 *cp = &scan_p->channel_params;
+	struct iwl_scan_channel_params_v7 *cp = scan_ptrs->channel_params;
 	struct ieee80211_supported_band *sband =
 		&mld->nvm_data->bands[NL80211_BAND_6GHZ];
 
@@ -1107,14 +1123,14 @@ iwl_mld_scan_cmd_set_chan_params(struct iwl_mld *mld,
 
 	if (params->scan_6ghz)
 		return iwl_mld_scan_cmd_set_6ghz_chan_params(mld, params,
-							     vif, scan_p);
+							     vif, scan_ptrs);
 
 	/* relevant only for 2.4 GHz/5 GHz scan */
 	cp->flags = iwl_mld_scan_cmd_set_chan_flags(mld, params, vif,
 						    low_latency);
 	cp->count = params->n_channels;
 
-	iwl_mld_scan_cmd_set_channels(mld, params->channels, cp,
+	iwl_mld_scan_cmd_set_channels(mld, params->channels, scan_ptrs,
 				      params->n_channels, channel_cfg_flags,
 				      vif->type);
 
@@ -1144,41 +1160,50 @@ iwl_mld_scan_cmd_set_chan_params(struct iwl_mld *mld,
 	return 0;
 }
 
-static int
-iwl_mld_scan_build_cmd(struct iwl_mld *mld, struct ieee80211_vif *vif,
+struct iwl_scan_umac_handler {
+	u8 version;
+	int (*handler)(struct iwl_mld *mld, struct ieee80211_vif *vif,
 		       struct iwl_mld_scan_params *params,
 		       enum iwl_mld_scan_status scan_status,
-		       bool low_latency)
+		       int uid, u32 ooc_priority, bool low_latency);
+};
+
+#define IWL_SCAN_UMAC_HANDLER(_ver) {		\
+	.version = _ver,			\
+	.handler = iwl_mld_scan_umac_v##_ver,	\
+}
+
+static int iwl_mld_scan_umac_v17(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				 struct iwl_mld_scan_params *params,
+				 enum iwl_mld_scan_status scan_status,
+				 int uid, u32 ooc_priority, bool low_latency)
 {
 	struct iwl_scan_req_umac_v17 *cmd = mld->scan.cmd;
-	struct iwl_scan_req_params_v17 *scan_p = &cmd->scan_params;
+	struct iwl_scan_req_params_ptrs scan_ptrs = {
+		.general_params = &cmd->scan_params.general_params,
+		.probe_params = &cmd->scan_params.probe_params,
+		.channel_params = &cmd->scan_params.channel_params,
+		.periodic_params = &cmd->scan_params.periodic_params
+	};
 	u32 bitmap_ssid = 0;
-	int uid, ret;
-
-	memset(mld->scan.cmd, 0, mld->scan.cmd_size);
+	int ret;
 
-	/* find a free UID entry */
-	uid = iwl_mld_scan_uid_by_status(mld, IWL_MLD_SCAN_NONE);
-	if (uid < 0)
-		return uid;
+	if (WARN_ON(params->n_channels > SCAN_MAX_NUM_CHANS_V3))
+		return -EINVAL;
 
 	cmd->uid = cpu_to_le32(uid);
-	cmd->ooc_priority =
-		cpu_to_le32(iwl_mld_scan_ooc_priority(scan_status));
+	cmd->ooc_priority = cpu_to_le32(ooc_priority);
 
-	iwl_mld_scan_cmd_set_gen_params(mld, params, vif,
-					&scan_p->general_params, scan_status);
+	iwl_mld_scan_cmd_set_gen_params(mld, params, vif, &scan_ptrs,
+					scan_status);
 
-	ret = iwl_mld_scan_cmd_set_sched_params(params,
-						scan_p->periodic_params.schedule,
-						&scan_p->periodic_params.delay);
+	ret = iwl_mld_scan_cmd_set_sched_params(params, &scan_ptrs);
 	if (ret)
 		return ret;
 
-	iwl_mld_scan_cmd_set_probe_params(params, &scan_p->probe_params,
-					  &bitmap_ssid);
+	iwl_mld_scan_cmd_set_probe_params(params, &scan_ptrs, &bitmap_ssid);
 
-	ret = iwl_mld_scan_cmd_set_chan_params(mld, params, vif, scan_p,
+	ret = iwl_mld_scan_cmd_set_chan_params(mld, params, vif, &scan_ptrs,
 					       low_latency, scan_status,
 					       bitmap_ssid);
 	if (ret)
@@ -1187,6 +1212,45 @@ iwl_mld_scan_build_cmd(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	return uid;
 }
 
+static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
+	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(17),
+};
+
+static int
+iwl_mld_scan_build_cmd(struct iwl_mld *mld, struct ieee80211_vif *vif,
+		       struct iwl_mld_scan_params *params,
+		       enum iwl_mld_scan_status scan_status,
+		       bool low_latency)
+{
+	int uid, err;
+	u32 ooc_priority;
+
+	memset(mld->scan.cmd, 0, mld->scan.cmd_size);
+	uid = iwl_mld_scan_uid_by_status(mld, IWL_MLD_SCAN_NONE);
+	if (uid < 0)
+		return uid;
+
+	ooc_priority = iwl_mld_scan_ooc_priority(scan_status);
+
+	for (size_t i = 0; i < ARRAY_SIZE(iwl_scan_umac_handlers); i++) {
+		const struct iwl_scan_umac_handler *ver_handler =
+			&iwl_scan_umac_handlers[i];
+
+		if (ver_handler->version != mld->scan.cmd_ver)
+			continue;
+
+		err = ver_handler->handler(mld, vif, params, scan_status,
+					   uid, ooc_priority, low_latency);
+		return err ? : uid;
+	}
+
+	IWL_ERR(mld, "No handler for UMAC scan cmd version %d\n",
+		mld->scan.cmd_ver);
+
+	return -EINVAL;
+}
+
 static bool
 iwl_mld_scan_pass_all(struct iwl_mld *mld,
 		      struct cfg80211_sched_scan_request *req)
@@ -2041,6 +2105,7 @@ int iwl_mld_alloc_scan_cmd(struct iwl_mld *mld)
 		return -ENOMEM;
 
 	mld->scan.cmd_size = scan_cmd_size;
+	mld->scan.cmd_ver = scan_cmd_ver;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.h b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
index 69110f0cfc8e..772b3a02c4c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
@@ -109,6 +109,7 @@ enum iwl_mld_traffic_load {
  * @traffic_load.status: The current traffic load status, see
  *	&enum iwl_mld_traffic_load
  * @cmd_size: size of %cmd.
+ * @cmd_ver: version of the scan command format.
  * @cmd: pointer to scan cmd buffer (allocated once in op mode start).
  * @last_6ghz_passive_jiffies: stores the last 6GHz passive scan time
  *	in jiffies.
@@ -134,6 +135,7 @@ struct iwl_mld_scan {
 	/* And here fields that survive a fw restart */
 	size_t cmd_size;
 	void *cmd;
+	u8 cmd_ver;
 	unsigned long last_6ghz_passive_jiffies;
 	unsigned long last_start_time_jiffies;
 	u64 last_mlo_scan_time;
-- 
2.34.1


