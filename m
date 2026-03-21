Return-Path: <linux-wireless+bounces-33629-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAf8KonVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33629-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAEE2E686F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0894B30091CD
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30F33AD85;
	Sat, 21 Mar 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQUwinGM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096133B951
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114178; cv=none; b=kYt8xZ1HpRPnVTBjMu1YXEDFQpo8epaqZL6ez2M99Dy/7mAlhR6MxhT6C496j/1U6vNVUYE947tvXr+J8kq2vV/K/ssOW6esDhTeSJd11Uo9m+AdpXgdqnyyc0WcCTqcD5oVJq0efdV0+VN5Bp7aWtePcb9eaER3aaHskvZKem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114178; c=relaxed/simple;
	bh=flJC87StxtRhRJ7tmjIE/dsvmBrcoSQ74/8RBAYqpfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGaPsR8Of32aI4SinJPxtpF4NdbV+CnD7qw0f+BrrBYEjateO4EZMDD+PVI0fvJHZpp/LHQ1es8fRULGrJuZtbUXeXIb1YuwgMY+muLiXGkeVylIkaxI3oi9SZoEor1BOvMA1yO+c6muJuyrMTchLWYR3/doDnP1yhX0kQ+k6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQUwinGM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114176; x=1805650176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flJC87StxtRhRJ7tmjIE/dsvmBrcoSQ74/8RBAYqpfI=;
  b=QQUwinGMZ0UNEKyHHoVreOrWSjv55EbZdsSovjUVc9odn8/8Ipb1r2az
   gpHn0dwlZOvfG3JgKCD3zy/QOWcF1An4huKItQ83xdzWuODoZt4pCHBjl
   SLC/uS+Kpq4PzP9czsWvtQLb+e51b4yowhyhRhDJBdQZ4lCSrnbzDs/z+
   CmKHkC+VxB2gUW6tek58MnIOrU24T5pQyCH9T8nU4AAULKgdCQKnN4j+G
   mLiw7Acq0/h2LBEHKBpsn0fW9Lk70eZLnxJA/R1iiOOpOFgej1U6Okoob
   e6tlXEnHsOOu65yrUFkeZAOMjkKbYQJe0K0Rckc4O5GVCFKMZqTvUaqQW
   g==;
X-CSE-ConnectionGUID: 962C85GYRZ6JGh0xX4ZwUw==
X-CSE-MsgGUID: GE6sbPz4TYCGxVnhTyQpSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244586"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244586"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:36 -0700
X-CSE-ConnectionGUID: bKExkPR7QzW78LvFtNxUyg==
X-CSE-MsgGUID: SolcbC2gQ/+eGKHIQwkVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813567"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: make alloc functions not forced static
Date: Sat, 21 Mar 2026 19:29:09 +0200
Message-Id: <20260321192637.cbfd202c255f.I4dd4d4416d30bed35bc7b7caa3de50071906830a@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33629-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: BAAEE2E686F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

In preparation for NAN needing the link ID allocation, have
the macro not automatically make the ID allocation functions
static so we can remove that later from the link allocation
function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h         | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/sta.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 472592aa97fd..4d8052e65f93 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -427,7 +427,7 @@ static void iwl_mld_mlo_scan_start_wk(struct wiphy *wiphy,
 	iwl_mld_int_mlo_scan(mld, iwl_mld_vif_to_mac80211(mld_vif));
 }
 
-IWL_MLD_ALLOC_FN(vif, vif)
+static IWL_MLD_ALLOC_FN(vif, vif)
 
 /* Constructor function for struct iwl_mld_vif */
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index b5430e8a73d6..b66e84d2365f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -437,7 +437,7 @@ iwl_mld_rm_link_from_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link)
 	iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
 }
 
-IWL_MLD_ALLOC_FN(link, bss_conf)
+static IWL_MLD_ALLOC_FN(link, bss_conf)
 
 /* Constructor function for struct iwl_mld_link */
 static int
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 66c7a7d31409..ea3d1fab6f46 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -530,9 +530,9 @@ void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
 #define IWL_MLD_INVALID_FW_ID 0xff
 
 #define IWL_MLD_ALLOC_FN(_type, _mac80211_type)						\
-static int										\
+int											\
 iwl_mld_allocate_##_type##_fw_id(struct iwl_mld *mld,					\
-				 u8 *fw_id,				\
+				 u8 *fw_id,						\
 				 struct ieee80211_##_mac80211_type *mac80211_ptr)	\
 {											\
 	u8 rand = IWL_MLD_DIS_RANDOM_FW_ID ? 0 : get_random_u8();			\
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 619f302076ad..eda2cbbb3b30 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -528,7 +528,7 @@ iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 	return iwl_mld_send_sta_cmd(mld, &cmd);
 }
 
-IWL_MLD_ALLOC_FN(link_sta, link_sta)
+static IWL_MLD_ALLOC_FN(link_sta, link_sta)
 
 static int
 iwl_mld_add_link_sta(struct iwl_mld *mld, struct ieee80211_link_sta *link_sta)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index 26cf27be762d..176dbbf4c643 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -68,7 +68,7 @@ int iwlmld_kunit_test_init(struct kunit *test)
 	return 0;
 }
 
-IWL_MLD_ALLOC_FN(link, bss_conf)
+static IWL_MLD_ALLOC_FN(link, bss_conf)
 
 static void iwlmld_kunit_init_link(struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link,
@@ -94,7 +94,7 @@ static void iwlmld_kunit_init_link(struct ieee80211_vif *vif,
 	rcu_assign_pointer(vif->link_conf[link_id], link);
 }
 
-IWL_MLD_ALLOC_FN(vif, vif)
+static IWL_MLD_ALLOC_FN(vif, vif)
 
 /* Helper function to add and initialize a VIF for KUnit tests */
 struct ieee80211_vif *iwlmld_kunit_add_vif(bool mlo, enum nl80211_iftype type)
@@ -199,7 +199,7 @@ void iwlmld_kunit_assign_chanctx_to_link(struct ieee80211_vif *vif,
 		vif->active_links |= BIT(link->link_id);
 }
 
-IWL_MLD_ALLOC_FN(link_sta, link_sta)
+static IWL_MLD_ALLOC_FN(link_sta, link_sta)
 
 static void iwlmld_kunit_add_link_sta(struct ieee80211_sta *sta,
 				      struct ieee80211_link_sta *link_sta,
-- 
2.34.1


