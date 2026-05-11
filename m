Return-Path: <linux-wireless+bounces-36245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPMONMYaAmocoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA7E514128
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6415231DDE9B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197404534A7;
	Mon, 11 May 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWMwD2z6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD743DA43
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521017; cv=none; b=oMc5en/8F2purOGCyBI+OkIAKe+ecU03Zoi3sO/nMfaydTmCa37PcuTZOWKqyeDQ3W7MMXuYzzgXFpqt7bbRpYzlJt1lyFMRkC1LysD9efw6w12zfPmsBcvoHbbFJcK8lQzOd0zOA5q0w7H8ChqrXTXoAwkpDUuN+GN9z+M8lCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521017; c=relaxed/simple;
	bh=LMSbHNlnEEYL5B9EO4cKwQAKkyGLB5SMXGn5qQ02rAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6kBzXdCUISDRORAw+AHyujBovPXYMG4gdj7M53RZSHtpx2tBmDx5OGI+oJIhU9ehR/ckhw/Me9zI1wKA4U9A+R9Sct/qwQxV+iT+rsCc+LkOLMJUwKv27KGofGyaC+oRTneTG6+FUYwYarsoXo2yMH9CmQEbQ8Wm/5kQFQBoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWMwD2z6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521016; x=1810057016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LMSbHNlnEEYL5B9EO4cKwQAKkyGLB5SMXGn5qQ02rAw=;
  b=XWMwD2z6kTcuyhZK89jGSeLNPgKlo2wy+xzSztvoAP/5NtoWGzQFJH39
   BvqU6f2LqPSah9+I5lxHgz+lDxzvX7B7xL7+KLCvTHcUMSKWMHslNfPIT
   n6kdZXtbxKYCd7+VW7Yu8onV6poZI1olGMQ2ZQHoFMEfOZHgFvbvcbQR/
   NRzlbFMuntts+9dyBkgTbsvFZ1dSui6srCETjnMOYG4oPn9SVcceHgPDe
   TXjA4qxFejvjdz9F8K1PeHw+KnFzz/nbQpR0FKpYRtL3tv+D78GoXClgh
   wbfCM+QqT7lmP/gcBhEsLj1D4tjyhAhxfyyEcwOxTmdCJ0Flay237Enpk
   Q==;
X-CSE-ConnectionGUID: 0aTX3YyuTACCAY3uBKfYSQ==
X-CSE-MsgGUID: fOcNQ3L6RbaetstrotpuIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314780"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314780"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:54 -0700
X-CSE-ConnectionGUID: BX44+S+BQ9S4583JoO66hA==
X-CSE-MsgGUID: W3e4aLMkQweTNMT+BrV4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004680"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED
Date: Mon, 11 May 2026 20:36:20 +0300
Message-Id: <20260511203428.cf10e5754171.I8022517c6c5aedb4b56fba30a5545de8f62dddbe@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CA7E514128
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
	TAGGED_FROM(0.00)[bounces-36245-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We should stick to mac80211's flow to start / stop beaconing. This
allows to stop beaconing before we remove the BIGTK.

Note that the start and stop beaconing flows are not exactly symmetric.
When we start beaconing, we just update the beacon template. We assume
that mac80211 won't update the beacons, if we're not supposed to be
sending it.

Also note that we now send the beacon template after the broadcast
station was added to the firmware: the broadcast station is added in
the start_ap() flow, while the beacon template is now added in the
link_changed() flow which happens later. This is not what we did
before this patch, but this sequence is supported by the firmware as
well.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   | 25 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/ap.h   |  6 ++++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  8 +++++-
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
index 5c59acc8c4c5..c29e4a77be05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024, 2026 Intel Corporation
  */
 #include <linux/crc32.h>
 
@@ -239,6 +239,25 @@ int iwl_mld_store_ap_early_key(struct iwl_mld *mld,
 	return -ENOSPC;
 }
 
+void iwl_mld_stop_beacon(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	struct iwl_mac_beacon_cmd cmd = {};
+	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, BEACON_TEMPLATE_CMD, 14);
+
+	if (WARN_ON(!mld_link))
+		return;
+
+	if (cmd_ver < 15)
+		return;
+
+	/* leave byte_cnt 0 */
+	cmd.link_id = cpu_to_le32(mld_link->fw_id);
+
+	iwl_mld_send_cmd_pdu(mld, BEACON_TEMPLATE_CMD, &cmd);
+}
+
 static int iwl_mld_send_ap_early_keys(struct iwl_mld *mld,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_bss_conf *link)
@@ -276,10 +295,6 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mld_send_ap_tx_power_constraint_cmd(mld, vif, link);
 
-	ret = iwl_mld_update_beacon_template(mld, vif, link);
-	if (ret)
-		return ret;
-
 	/* the link should be already activated when assigning chan context,
 	 * and LINK_CONTEXT_MODIFY_EHT_PARAMS is deprecated
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.h b/drivers/net/wireless/intel/iwlwifi/mld/ap.h
index 4a6f52b9552d..a3b6bed814ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024, 2026 Intel Corporation
  */
 #ifndef __iwl_ap_h__
 #define __iwl_ap_h__
@@ -14,6 +14,10 @@ int iwl_mld_update_beacon_template(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link_conf);
 
+void iwl_mld_stop_beacon(struct iwl_mld *mld,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link_conf);
+
 int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 1106ad651cfe..403bc38ac2bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1258,8 +1258,14 @@ iwl_mld_link_info_changed_ap_ibss(struct iwl_mld *mld,
 	if (link_changes)
 		iwl_mld_change_link_in_fw(mld, link, link_changes);
 
-	if (changes & BSS_CHANGED_BEACON)
+	if (changes & BSS_CHANGED_BEACON) {
+		WARN_ON(!link->enable_beacon);
 		iwl_mld_update_beacon_template(mld, vif, link);
+	}
+
+	/* Enabling beacons was already covered above */
+	if ((changes & BSS_CHANGED_BEACON_ENABLED) && !link->enable_beacon)
+		iwl_mld_stop_beacon(mld, vif, link);
 }
 
 static
-- 
2.34.1


