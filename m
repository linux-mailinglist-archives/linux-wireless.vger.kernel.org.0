Return-Path: <linux-wireless+bounces-36487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D8cA3oTB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:37:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D054FAF3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C79C6319A9DF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A647A0D1;
	Fri, 15 May 2026 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4P4t3LA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92447DF81
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847319; cv=none; b=II7ffyUY8pVTmNG6PRzk1gecY370om2BCmW4sgxPrqCkoCVngWPk4Mwk/HIz0ktxBn9IEyb+IBRSsUDFL2afLLQXCF0oFTWwYUhdbYPUcQy/UsMEI/PSEXHnXV5tQb2I3YkaF0nzSR6+fr0UpPfUDQoesQIu+hqPVPzzmrXutIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847319; c=relaxed/simple;
	bh=3nQFhqfw5msYCi0zLZcW6IUcGnlJ2J/jXMXR1lIb0yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oxfshu0iq68JXZlYKJhha7hWH6DxSqysu3YFfzK/m2zUfO4st5II1lHQRu4QAgADFCwSml4zRd9PhJhYq1UsCM5Yiaxo2mINQjQGDnqsrfl2tY46m5QFZy1P+auhZI+Cvcr19I4VVeN4bXSHJ9ZNaEYwEioe+nAUom4HPEGbLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4P4t3LA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847316; x=1810383316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3nQFhqfw5msYCi0zLZcW6IUcGnlJ2J/jXMXR1lIb0yk=;
  b=I4P4t3LA6AoERGFrXmjcc4eLlVIAhnQ2XN4D24LcAgqSAaiqrcK4rttP
   WMuF6CMEdlxL01DqIIgxeNXIDKMVAN4D9+Cj0AXoqnRxdyeUmGkW+l+3e
   EUX+SlXlRCM7KYgK9QPba7aMLNOkbVadLPrhUkCXpzznUqs9UO/bgfVLk
   /x1mqy+J6fmhmnMKreGDVVLJvk4NI8l5aSpuRa8tkYJzr4NhvPau58N0z
   IWVmPr7Zpjm13v+An2O5GC+VMF0v9m/eaUCX5Xl10j9Kh9uSjoFlQjQJk
   X8bSz/9F5KyLBpJCAqvmE+KZF5GY3uIOC/gABuE6VZIvleKswZNVTA3KF
   A==;
X-CSE-ConnectionGUID: 4YRdDTiYRQ68DChn4w6fvQ==
X-CSE-MsgGUID: Nj3hhNkKRyumnE/Zm1hQ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79657842"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79657842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:16 -0700
X-CSE-ConnectionGUID: w9PvsBdLR2qRrfiUlhxAZw==
X-CSE-MsgGUID: FENkcJqkSOK6YP1ZiRTIMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262201044"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 1/5] wifi: iwlwifi: mld: don't dereference a pointer before NULL checking it
Date: Fri, 15 May 2026 15:14:56 +0300
Message-Id: <20260515151351.371f40fc6711.I6a82cfe9655564e9c5731af91c36493b26b1208e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
References: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE9D054FAF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36487-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

In iwl_mld_remove_link, the link->fw_id is saved at the beginning of the
function so we have it after we freed the link.

But the link pointer can be NULL, and is not checked when the fw_id is
stored.

Fix it by simply freeing the link at the end of the function.

fFixes: 0e66a39f4f0e ("wifi: iwlwifi: fix potential use after free in iwl_mld_remove_link()")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index b66e84d2365f..be2cdf43c72e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include "constants.h"
@@ -504,7 +504,6 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
 	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	bool is_deflink = link == &mld_vif->deflink;
-	u8 fw_id = link->fw_id;
 
 	if (WARN_ON(!link || link->active))
 		return;
@@ -512,15 +511,15 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 	iwl_mld_rm_link_from_fw(mld, bss_conf);
 	/* Continue cleanup on failure */
 
-	if (!is_deflink)
-		kfree_rcu(link, rcu_head);
-
 	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 
-	if (WARN_ON(fw_id >= mld->fw->ucode_capa.num_links))
+	if (WARN_ON(link->fw_id >= mld->fw->ucode_capa.num_links))
 		return;
 
-	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
+
+	if (!is_deflink)
+		kfree_rcu(link, rcu_head);
 }
 
 void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
-- 
2.34.1


