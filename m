Return-Path: <linux-wireless+bounces-33570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNvQMEcCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC92D70E5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CC2310679B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE937187F;
	Fri, 20 Mar 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvQ9sUF9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CB37D133
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994185; cv=none; b=Hoa7RZZq+YboMXHZSwedD3i8fXyHeNTKIR30AT1BdS99i6E06q8yM2WIGXJzN/lj1heSyyQJLl6+JPpVlavHStszcjs+/Iaik5UvO2uSF+jCFH+8MBVe8B/iLaVt2rUCRv+QU/g01djZcbiVp9Q2U3aUwjYGH3MRj1BqGIo0hNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994185; c=relaxed/simple;
	bh=jXtm2yNUjtI0eLx+/ohaaGjEr0wyrxItmil5BMYJaJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGxKyRdFqG2nZ5tOVly1t+TGItTykZmHNRYFaUOf4fQuCPDeKKhdN1PTfZRH8wXPf6M4ldSruc0HhHHzmk9Gg4mOK9GUMRiHHNVe+rl3hOsOMc4Cyof5UiGEu8LInom16BM0bGb4fRC/IJhSDfWUI8bSNLeI+bQwVnqXES29ZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvQ9sUF9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994184; x=1805530184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXtm2yNUjtI0eLx+/ohaaGjEr0wyrxItmil5BMYJaJE=;
  b=FvQ9sUF9NwUtEojtLRkM1q96PXXxUdPRYK2OvUQKioyvLRIZMjjZsUEb
   /YZOH/pnV5w2JISxpDMp4AS4RDM6C/CRypSLLmVOcd8rNu6MZClLecvkG
   rgjhPF6RqbDF+8aaHV2fbZzKYKPvntGLNVv7LnDKpM0Lwk5lZUiW/Sns1
   qtWIbrIKRk6F8jOjD8av7w9U1hP9jgih+3y0+dHZol47ZTVO2m+RFuCTg
   83bhPtd95AAynysqF+QA5ZFp2UxaxnLGBxchmoiNNVYZfwv9cjIoh5G3f
   jwD2W5ajFeowyrYPsuAuk2LW10OC7UsjCsSGVyJ/jNR/YWf2pIk1GYe5Q
   A==;
X-CSE-ConnectionGUID: nAncQZXOSNqZP0HvMFlKjQ==
X-CSE-MsgGUID: KF/txVJ1Ty6Zgkmgo0xVCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154137"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154137"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:44 -0700
X-CSE-ConnectionGUID: Ti3iaK9TTEmkyzVmdjT1aQ==
X-CSE-MsgGUID: DBQplKZtS42C+sOVtBpgoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692595"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: add CQM event support for per-link RSSI changes
Date: Fri, 20 Mar 2026 10:09:12 +0200
Message-Id: <20260320100746.08697e34bf66.Ic1a68537ef0d37be62c73c138efe9c5cf09bd24c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33570-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6ABC92D70E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

Implement CQM RSSI threshold handling by tracking the last reported RSSI
and issuing CQM low/high events when the RSSI crosses the configured
threshold with the required hysteresis. This provides proper CQM support
and enables userspace to receive per-link RSSI notifications.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  2 ++
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 26 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 9e4da8e4de93..ca691259fc5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -40,6 +40,7 @@ struct iwl_probe_resp_data {
  * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
  * @mon_sta: station used for TX injection in monitor interface.
+ * @last_cqm_rssi_event: rssi of the last cqm rssi event
  * @average_beacon_energy: average beacon energy for beacons received during
  *	client connections
  * @ap_early_keys: The firmware cannot install keys before bcast/mcast STAs,
@@ -66,6 +67,7 @@ struct iwl_mld_link {
 	struct iwl_mld_int_sta bcast_sta;
 	struct iwl_mld_int_sta mcast_sta;
 	struct iwl_mld_int_sta mon_sta;
+	int last_cqm_rssi_event;
 
 	/* we can only have 2 GTK + 2 IGTK + 2 BIGTK active at a time */
 	struct ieee80211_key_conf *ap_early_keys[6];
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 7b8709716324..9b3149b9d2c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -369,15 +369,39 @@ static void iwl_mld_stats_recalc_traffic_load(struct iwl_mld *mld,
 static void iwl_mld_update_link_sig(struct ieee80211_vif *vif, int sig,
 				    struct ieee80211_bss_conf *bss_conf)
 {
+	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	struct iwl_mld *mld = iwl_mld_vif_from_mac80211(vif)->mld;
 	int exit_emlsr_thresh;
+	int last_event;
 
 	if (sig == 0) {
 		IWL_DEBUG_RX(mld, "RSSI is 0 - skip signal based decision\n");
 		return;
 	}
 
-	/* TODO: task=statistics handle CQM notifications */
+	if (WARN_ON(!link))
+		return;
+
+	/* CQM Notification */
+	if (vif->driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI) {
+		int thold = bss_conf->cqm_rssi_thold;
+		int hyst = bss_conf->cqm_rssi_hyst;
+
+		last_event = link->last_cqm_rssi_event;
+		if (thold && sig < thold &&
+		    (last_event == 0 || sig < last_event - hyst)) {
+			link->last_cqm_rssi_event = sig;
+			ieee80211_cqm_rssi_notify(vif,
+						  NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
+						  sig, GFP_KERNEL);
+		} else if (sig > thold &&
+			   (last_event == 0 || sig > last_event + hyst)) {
+			link->last_cqm_rssi_event = sig;
+			ieee80211_cqm_rssi_notify(vif,
+						  NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
+						  sig, GFP_KERNEL);
+		}
+	}
 
 	if (!iwl_mld_emlsr_active(vif)) {
 		/* We're not in EMLSR and our signal is bad,
-- 
2.34.1


