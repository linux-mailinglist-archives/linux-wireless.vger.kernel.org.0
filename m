Return-Path: <linux-wireless+bounces-33639-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGEfLKnVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33639-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF452E68B1
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 646BC301A432
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E88933B6D4;
	Sat, 21 Mar 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMVgETSG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E01334C33
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114190; cv=none; b=PgrQIGKrl58oaLtw5h6v0A3EtmBEPYHWwPsFzmTYxJ07/X6kEOK58n/s4M1OMIYFrAJgNVcUvn8g95a2azPDUOpjIyCrKNN6SazJsaVzcrTXmVxSMkLUKXvYpOCF7cYpZlsJC3hIqVP9dRI0eb5b/ed6kg9YT0qB9iF4+vbCdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114190; c=relaxed/simple;
	bh=wXg4j1loxnRT9x76q58HxdBk4YFvH+xkwKt71tYU6bE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMxOuEyFt39aWgBcCX2BArx/uDRaCopHVMZ6/+YM+IBQWf45EGME8/+0g4f4k9xjp7JRTCpWGpjvsK3LjWZ1Ha33KLB2yTm7jJOOGN0b8/9QHYiI9FUFKx1ZstiEkv9ZPUfzyjGDCuIO4OZlLysa1t94mnlbLIH90PgFv2Oy6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMVgETSG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114189; x=1805650189;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=wXg4j1loxnRT9x76q58HxdBk4YFvH+xkwKt71tYU6bE=;
  b=cMVgETSG9zEV0Cp3oAWpwrl+txBAa1hv12JtM43JrBeRrJ53NXLyHtCc
   XKf2Sk970hk4JNLhMYfpH0WnnJD8rYV9M0oYe6dqOQyVBLsFU4bee0v5q
   va76KETOWp+rjjcWkyY9VbO6aoz9iJ2P5IY0Ndzu3nWU0cJyrwj9KjlaK
   eg5RCDUqK2NpIrUm0oQmtYFnV5fDPpn0nWd5Bvt51HbP0JqApEH0BQGjS
   Y9yA8TkHhCVT4ihMueHfG3XdMqkqltonke8OxWYkp6ZaHDXIBseBUfgzg
   Q4fO4JtJrrLst1WuMLa/jQDKX5zguygW7paN3Ma0qDk4nqaDSisUnyQQh
   g==;
X-CSE-ConnectionGUID: IlK8rrOHTe6/8oZ9moWuDQ==
X-CSE-MsgGUID: QA7DZKWCQf6wTTawd9OB6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244596"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244596"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:48 -0700
X-CSE-ConnectionGUID: vlSQUf6ATlavp6mNAw8pIg==
X-CSE-MsgGUID: 030TlIrLTYOendQ3oqMsDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813605"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: introduce iwl_mld_vif_fw_id_valid
Date: Sat, 21 Mar 2026 19:29:19 +0200
Message-Id: <20260321192637.b68d43db2ddc.I11b2b98e115da9eec8f603c5a01a0a9bcd040884@changeid>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33639-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 6CF452E68B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a helper function that checks if a vif fw id is valid, and warns
if it isn't.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.h      | 11 ++++++++++-
 .../net/wireless/intel/iwlwifi/mld/low_latency.c    | 13 +++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 0857ae28be8e..8dfc79fed253 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_mld_iface_h__
 #define __iwl_mld_iface_h__
@@ -203,6 +203,15 @@ iwl_mld_vif_to_mac80211(struct iwl_mld_vif *mld_vif)
 	return container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
 }
 
+/* Call only for interfaces that were added to the driver! */
+static inline bool iwl_mld_vif_fw_id_valid(struct iwl_mld_vif *mld_vif)
+{
+	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld_vif->mld->fw_id_to_vif)))
+		return false;
+
+	return true;
+}
+
 #define iwl_mld_link_dereference_check(mld_vif, link_id)		\
 	rcu_dereference_check((mld_vif)->link[link_id],			\
 			      lockdep_is_held(&mld_vif->mld->wiphy->mtx))
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
index d39dd36b08e3..a4ddc32e2860 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include "mld.h"
 #include "iface.h"
@@ -77,9 +77,12 @@ static void iwl_mld_low_latency_iter(void *_data, u8 *mac,
 	bool prev = mld_vif->low_latency_causes & LOW_LATENCY_TRAFFIC;
 	bool low_latency;
 
-	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->low_latency.result)))
+	if (!iwl_mld_vif_fw_id_valid(mld_vif))
 		return;
 
+	BUILD_BUG_ON(ARRAY_SIZE(mld->fw_id_to_vif) !=
+		     ARRAY_SIZE(mld->low_latency.result));
+
 	low_latency = mld->low_latency.result[mld_vif->fw_id];
 
 	if (prev != low_latency)
@@ -272,8 +275,10 @@ void iwl_mld_low_latency_update_counters(struct iwl_mld *mld,
 	if (WARN_ON_ONCE(!mld->low_latency.pkts_counters))
 		return;
 
-	if (WARN_ON_ONCE(fw_id >= ARRAY_SIZE(counters->vo_vi) ||
-			 queue >= mld->trans->info.num_rxqs))
+	if (!iwl_mld_vif_fw_id_valid(mld_vif))
+		return;
+
+	if (WARN_ON_ONCE(queue >= mld->trans->info.num_rxqs))
 		return;
 
 	if (mld->low_latency.stopped)
-- 
2.34.1


