Return-Path: <linux-wireless+bounces-36340-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOX2NY+BA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36340-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:37:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C00528BC7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2FF31050C9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2723368D77;
	Tue, 12 May 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWyojz7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E243368D7C
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614511; cv=none; b=NYd1kB1G5nzdbNFfXojOp0iZs02HAyyc5YRJIli4cWQTBwIYFS9XfhFhJkOzO9MA68WMgC5j+zvWZvEQ23IDvsB16h3jiPomps28eABim4Ss0WiXwkGSbRmNboDeIahRVLLM9FvIYE/85kGhXPkrPmssK5qQcgU0zUiknoBfVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614511; c=relaxed/simple;
	bh=2ZxkvpAQzH2ZNZ7tLAn36TTrQPpxbHxFq4dbpQIz7zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsgtpifzoRFeARL9fudzQQ1BY2q9m3T8fhHILUiIFjXfLDzZa41zz7locA8g8LDjiaNP9ASulAGrYaSunJJg+c5GyPFYS/eKASXByqjuGxbyU7ERh71OcLm+pF1gqdMdilunoKIsnsbxSVIEC+svCCgpAFKhasKO39zy0cqqyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWyojz7C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614510; x=1810150510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZxkvpAQzH2ZNZ7tLAn36TTrQPpxbHxFq4dbpQIz7zc=;
  b=MWyojz7CGAU4CuSB7V0D9+1CpxxuuIY5Yks17pTvkDj9S1W1pFarSAF6
   aoKV70HSuXzRo0nfLfE+qOK8MJH7b0KMAbg0PHj8Opawzf84naPAmFYGX
   Bf9O6egcMwvEy2QUufSocxEIr0lZh2dqUg6zdxc8o+Qvcrr1N51hk8DfA
   E5NkZIb4becszjRGB793AFWygwqpfgrswNGPFHYCCdEqg7P6DLwPhJ/qp
   wwzDz91mZ8+QVK41x/UA7d+Z0d08ky+DgTe45ihT4UULHRS8j+EvdWY4W
   XvqsnMRf2zuoBgN330HtF9tvvDD6zFEX6Ert/jt5jrwzH6nXkDN1aBCIF
   Q==;
X-CSE-ConnectionGUID: YEUEDkNHQeaRtdkuurxzRg==
X-CSE-MsgGUID: X3kkO1M+RV2Hc9eIO8BLig==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148802"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148802"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:10 -0700
X-CSE-ConnectionGUID: z++Cdlt3QOqY8biRrlnlYw==
X-CSE-MsgGUID: En3F+ZGCRMijaIaGg8qSuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471819"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: add support for nan schedule config command version 2
Date: Tue, 12 May 2026 22:34:39 +0300
Message-Id: <20260512222731.422e4bc47f84.I04b7dec6f3e48cfd950e7ff6f13484d0881d832e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55C00528BC7
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36340-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avraham Stern <avraham.stern@intel.com>

Version 2 of the NAN schedule config command adds support for deferred
schedule update and passing the availability attribute blob to
firmware.
Add support for the new command version. Currently the new
functionality is not supported.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 40 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 22 ++++++++--
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 75b477319096..dd850aeebdec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1253,6 +1253,27 @@ struct iwl_nan_config_cmd {
 	u8 beacon_data[];
 } __packed; /*  NAN_CONFIG_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_nan_schedule_cmd_v1 - NAN schedule command
+ * @channels: per channel information
+ * @channels.availability_map: bitmap of slots this channel is advertising
+ *	availability on, will be ULW'ed out if no link/inactive link is
+ *	referenced by the link ID below
+ * @channels.channel_entry: NAN channel entry descriptor
+ * @channels.link_id: FW link ID, or %0xFF for unset
+ * @channels.reserved: (reserved)
+ */
+struct iwl_nan_schedule_cmd_v1 {
+	struct {
+		__le32 availability_map;
+		u8 channel_entry[6];
+		u8 link_id;
+		u8 reserved;
+	} __packed channels[NUM_PHY_CTX];
+} __packed; /* NAN_SCHEDULE_CMD_API_S_VER_1 */
+
+#define IWL_MAX_AVAILABILITY_ATTR_LEN 54
+
 /**
  * struct iwl_nan_schedule_cmd - NAN schedule command
  * @channels: per channel information
@@ -1262,6 +1283,14 @@ struct iwl_nan_config_cmd {
  * @channels.channel_entry: NAN channel entry descriptor
  * @channels.link_id: FW link ID, or %0xFF for unset
  * @channels.reserved: (reserved)
+ * @avail_attr: NAN availability attribute information
+ * @avail_attr.attr_len: length of the availability attribute
+ * @avail_attr.reserved: reserved
+ * @avail_attr.attr: the availability attribute including the attribute header
+ * @deferred: true if the firmware should defer applying the schedule until
+ *	notifying all peers. For a deferred schedule update, the firmware should
+ *	send a notification to the driver after the new schedule is applied.
+ * @reserved: reserved
  */
 struct iwl_nan_schedule_cmd {
 	struct {
@@ -1270,7 +1299,16 @@ struct iwl_nan_schedule_cmd {
 		u8 link_id;
 		u8 reserved;
 	} __packed channels[NUM_PHY_CTX];
-} __packed; /* NAN_SCHEDULE_CMD_API_S_VER_1 */
+
+	struct {
+		u8 attr_len;
+		u8 reserved;
+		u8 attr[IWL_MAX_AVAILABILITY_ATTR_LEN];
+	} __packed avail_attr;
+
+	u8 deferred;
+	u8 reserved[3];
+} __packed; /* NAN_SCHEDULE_CMD_API_S_VER_2 */
 
 /**
  * struct iwl_nan_peer_cmd - NAN peer command
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 913f0acf172a..53a0c3b9bb33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -546,11 +546,27 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	bool added_links = false;
 	bool empty_schedule = true;
 	int ret, i;
+	u16 cmd_size;
+	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, NAN_SCHEDULE_CMD);
+	u8 version = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
 
 	if (!(changes & BSS_CHANGED_NAN_LOCAL_SCHED))
 		return;
 
-	for (i = 0; i <  ARRAY_SIZE(sched_cfg->channels); i++) {
+	switch (version) {
+	case 1:
+		cmd_size = sizeof(struct iwl_nan_schedule_cmd_v1);
+		break;
+	case 2:
+		cmd_size = sizeof(struct iwl_nan_schedule_cmd);
+		break;
+	default:
+		IWL_ERR(mld, "NAN: unsupported NAN schedule cmd version %d\n",
+			version);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
 		if (!sched_cfg->channels[i].chanreq.oper.chan)
 			continue;
 		empty_schedule = false;
@@ -647,9 +663,7 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 		cmd.channels[chan_idx].availability_map |= cpu_to_le32(BIT(i));
 	}
 
-	ret = iwl_mld_send_cmd_pdu(mld,
-				   WIDE_ID(MAC_CONF_GROUP, NAN_SCHEDULE_CMD),
-				   &cmd);
+	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, cmd_size);
 	if (ret)
 		IWL_ERR(mld, "NAN: failed to update schedule (%d)\n", ret);
 
-- 
2.34.1


