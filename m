Return-Path: <linux-wireless+bounces-33633-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK3vFZXVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33633-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8612E688B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7D84301BEFB
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD162836BE;
	Sat, 21 Mar 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uk+tzxY3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122A33D6D3
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114183; cv=none; b=EgRBrROnUKGt7ojHusfEGIYn1+cDFPOLXWI9xKbzj9kjRXm0cBtN9FN6PelDfN4p40t+TQ2MQ2BjcnPOdRHm1fC0nVGcjdMGLALU4LhuPlKmyxoaFnzGivAr79o/5cU/exs04zh6gBfdtWYaQUGAWp8KIlZZxRtad4+XMsUvd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114183; c=relaxed/simple;
	bh=XXtw2ZYTRIJYvo6hhMtE7Xs1naKY8d1TmU+hx2q4ofI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGWRwblUNNcWRfCSGgmJf+D0wKovKU6qvajp7cG56zmYqBasUxEe8DMj7gfAQ3FMSj8WuGzinsK7jJI2p/b3mqttF5aOOwew9zB+QOjzVcvFOQshL/Ai2Ct9h089CikE+cT1DdlITHM7mvu/4bgBunK2Jz92cPw1FuokhazcIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uk+tzxY3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114181; x=1805650181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXtw2ZYTRIJYvo6hhMtE7Xs1naKY8d1TmU+hx2q4ofI=;
  b=Uk+tzxY3hl1thSh9O5z4xlIoiqhNkgI4rdJJcP7/se4AS2k3/a8kE+LT
   Z62QZH5MawEnFtcbk3vuEQRrAnQDWv/4baqBNvDE1HGc8U0+RLaVR7xP0
   S81Rk9zLXxVbcjtOcTV0aEJhxvbgzakqWvJl8yDYBkd9S5miN2Bvwh3LC
   KXmJbBc6V6MO5lpFto0HtwHq6G44HDlzmFqn9r7hvP7QxILcz+Sn4WAa0
   7XDU0OiZU18FKLDBzrUw/+Kpt1omTULChrjWJrUorwicDZ2os/aGMgeuA
   /fLvmDdSPjzXIaB/MY87z37yVMPnAKuGPACA0c7bzYxagMQcWkfUdQ0V5
   w==;
X-CSE-ConnectionGUID: e3h0rUgKSfyC9ET+GmHT5Q==
X-CSE-MsgGUID: BrSjLn3VReyQhwEO9mkdMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244590"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:41 -0700
X-CSE-ConnectionGUID: 4i6+iNVaQ/qPCKO40ZTQwA==
X-CSE-MsgGUID: HzEnsZN/QxeHTFaBl0GGhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813589"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: use the dedicated helper to extract a link
Date: Sat, 21 Mar 2026 19:29:13 +0200
Message-Id: <20260321192637.f8da2cd2a873.I7fbd3b4a86a5695206bb5083fdac49de9acc9dca@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33633-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 0F8612E688B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a helper, iwl_mld_fw_id_to_link_conf, that converts a fw link
id into the bss_conf structure. Use it in two more places instead of
retrieving the bss_conf directly from the fw-id-to-bss_conf mapping array.

This required changing the loop bound in iwl_mld_process_per_link_stats()
to ucode_capa.num_links, to avoid hitting a IWL_FW_CHECK for link ids
> ucode_capa.num_links and < ARRAY_SIZE(fw_id_to_bss_conf), but this
change makes sense anyway (there is no reason to iterate links that
cannot be valid).

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c  | 4 +---
 drivers/net/wireless/intel/iwlwifi/mld/stats.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 17e0b13b5ce8..7ed107fb0e8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -2055,9 +2055,7 @@ void iwl_mld_handle_scan_complete_notif(struct iwl_mld *mld,
 		struct ieee80211_bss_conf *link_conf = NULL;
 
 		if (fw_link_id != IWL_MLD_INVALID_FW_ID)
-			link_conf =
-				wiphy_dereference(mld->wiphy,
-						  mld->fw_id_to_bss_conf[fw_link_id]);
+			link_conf = iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
 
 		/* It is possible that by the time the scan is complete the
 		 * link was already removed and is not valid.
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 9b3149b9d2c2..54eb0ead78ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -431,14 +431,13 @@ iwl_mld_process_per_link_stats(struct iwl_mld *mld,
 	u32 total_airtime_usec = 0;
 
 	for (u32 fw_id = 0;
-	     fw_id < ARRAY_SIZE(mld->fw_id_to_bss_conf);
+	     fw_id < mld->fw->ucode_capa.num_links;
 	     fw_id++) {
 		const struct iwl_stats_ntfy_per_link *link_stats;
 		struct ieee80211_bss_conf *bss_conf;
 		int sig;
 
-		bss_conf = wiphy_dereference(mld->wiphy,
-					     mld->fw_id_to_bss_conf[fw_id]);
+		bss_conf = iwl_mld_fw_id_to_link_conf(mld, fw_id);
 		if (!bss_conf || bss_conf->vif->type != NL80211_IFTYPE_STATION)
 			continue;
 
-- 
2.34.1


