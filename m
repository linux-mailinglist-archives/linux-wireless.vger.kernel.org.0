Return-Path: <linux-wireless+bounces-36370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCGjDukPBGouDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A738B52DB11
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0C5030AFA2C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6D3A48E0;
	Wed, 13 May 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAQU+HWZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD83A718A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651074; cv=none; b=Acg6hqVbQP6jgucFpU0rDUSIN8D6QquE6138cQXvG1deSBeeYSyHNU093x3e9vr60mru9gWWiAAswP+JzY0QuzHJHBqRb6iM9t9wfLpK8vOmUP7ezBjwAxzp9cnSX6YSTZCwWTxA8XwN+uLs+njhMq96KG33Q28xzbdIOI2SPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651074; c=relaxed/simple;
	bh=yO6SR1NZ6Nq+hoaFVfvN87Gg/Ob6dCa2c5qMivMb674=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckrVhF4vm6Aza3Q75W0FzSk78hiUAsZTr6rhgaSe8G9kjMu0/m/0aG5/WCWe90GgPawETdv/x3VNCu3GVGQr3q655l25Fh6zqoDc7NUCwAk6kKnI063ZMhP0X0s41Uv45mxpNQzii+RFVyYgr2Mi9inoXANIDNmj4n7kFyKsY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAQU+HWZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651073; x=1810187073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yO6SR1NZ6Nq+hoaFVfvN87Gg/Ob6dCa2c5qMivMb674=;
  b=VAQU+HWZTcweEruRq6b6TC6T0gwdBuGg05wnwlvvEfq10bE9Uu8vZKA8
   vzDAdCXo2dnSuYHnmc7npQL9M+aFYT8b5qulLrf3fkX0VKlGQkMDiPdfI
   NTExsjfR55cHL4f6iJ2S4MGkjhIF/NiU8gLRSdIpMSR2Ksd2u4Vg8eBi0
   eq+YRk21NJyYrLRRjtWKK9sjYwjjFnp130yhbEV4+YK6yzUkUySb/EabP
   KgunsqOm5AqHjBUn0SxgK/Rjlbew46HcKu7EHyyZDh4rIlfIwfGHkS/sp
   d0QrPGumwHZynQ4jIJDYoeQE2bfrQvQCuzqs1O4DDpa678xsQLYvncjPE
   g==;
X-CSE-ConnectionGUID: CRy3f6pzQYq3GBFKJf6xgQ==
X-CSE-MsgGUID: APjhHkhvTHe9hud0A+Vvqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552847"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:33 -0700
X-CSE-ConnectionGUID: zemGeGDGQ0212S+7S1xqSA==
X-CSE-MsgGUID: he+765BmT5GJuzzxCL22NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077947"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: Replace static declarations of IWL_MLD_ALLOC_FN
Date: Wed, 13 May 2026 08:44:00 +0300
Message-Id: <20260513084215.861e4554157d.Id07d4037c75f3ebc8a57ac95b14286369fb3467b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A738B52DB11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36370-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,tor.lore.kernel.org:server fail];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

Replace static declarations of IWL_MLD_ALLOC_FN with a new macro
IWL_MLD_ALLOC_FN_STATIC that declares the static.

This is needed to resolve issues with spatch, which fails to handle
functions after "static IWL_MLD_ALLOC_FN".

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h         | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/sta.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c | 6 +++---
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 2a270d689de8..f7a0a8efe374 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -499,7 +499,7 @@ static void iwl_mld_mlo_scan_start_wk(struct wiphy *wiphy,
 	iwl_mld_int_mlo_scan(mld, iwl_mld_vif_to_mac80211(mld_vif));
 }
 
-static IWL_MLD_ALLOC_FN(vif, vif)
+IWL_MLD_ALLOC_FN_STATIC(vif, vif)
 
 /* Constructor function for struct iwl_mld_vif */
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 1a59b3e4014d..922aa3dbff54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -552,6 +552,9 @@ iwl_mld_allocate_##_type##_fw_id(struct iwl_mld *mld,					\
 	return -ENOSPC;									\
 }
 
+#define IWL_MLD_ALLOC_FN_STATIC(_type, _mac80211_type) \
+static IWL_MLD_ALLOC_FN(_type, _mac80211_type)
+
 static inline struct ieee80211_bss_conf *
 iwl_mld_fw_id_to_link_conf(struct iwl_mld *mld, u8 fw_link_id)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 1fae5a6ba8d4..4c168ad53b0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -577,7 +577,7 @@ int iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 	return iwl_mld_send_sta_cmd(mld, &cmd);
 }
 
-static IWL_MLD_ALLOC_FN(link_sta, link_sta)
+IWL_MLD_ALLOC_FN_STATIC(link_sta, link_sta)
 
 static int
 iwl_mld_add_link_sta(struct iwl_mld *mld, struct ieee80211_link_sta *link_sta)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index 0cdbbb86dbd9..cb1968b07452 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
@@ -92,7 +92,7 @@ static void iwlmld_kunit_init_link(struct ieee80211_vif *vif,
 	rcu_assign_pointer(vif->link_conf[link_id], link);
 }
 
-static IWL_MLD_ALLOC_FN(vif, vif)
+IWL_MLD_ALLOC_FN_STATIC(vif, vif)
 
 /* Helper function to add and initialize a VIF for KUnit tests */
 struct ieee80211_vif *iwlmld_kunit_add_vif(bool mlo, enum nl80211_iftype type)
@@ -197,7 +197,7 @@ void iwlmld_kunit_assign_chanctx_to_link(struct ieee80211_vif *vif,
 		vif->active_links |= BIT(link->link_id);
 }
 
-static IWL_MLD_ALLOC_FN(link_sta, link_sta)
+IWL_MLD_ALLOC_FN_STATIC(link_sta, link_sta)
 
 static void iwlmld_kunit_add_link_sta(struct ieee80211_sta *sta,
 				      struct ieee80211_link_sta *link_sta,
-- 
2.34.1


