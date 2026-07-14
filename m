Return-Path: <linux-wireless+bounces-39075-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fG5+LvxCVmqh2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39075-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E162B7558A4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BnaUrGD0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39075-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39075-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59243320AC16
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E447DD42;
	Tue, 14 Jul 2026 14:03:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8510047D927
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:03:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037805; cv=none; b=KnBR5MHUy1tEch+aHyDIqGgsKi7MZ6YGjtQYO48DuXv4GKS7acR6DNc45BkYr12mwul+M/nS2b2h8VWjzQUCaulOk0RswmPJbMnTnY0oHiNUi2OjCqnlnh7ISeEP/PX3JzPb4d+bH+yjEws6wdTrmGCY7eztaKzqMrGRHh6+bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037805; c=relaxed/simple;
	bh=Rn5WoE9aqjgy/fQcTFSuQUYdNpb3qzLFOIilqo9QWZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poorflS8czb/m4SA0c35g19jIqukEpR0sW94x0tGHJ64RniCY6faUtlGgUiWUWuiBf7wJttJbDHrmBV6w01D+z5Ccyv0WabVGUjBFN4CxbYH8DpnfRjlh8BlkGkg71dsQPiTn65oBMFFUedrFoaYd8kzLMyfTh/nslHgjqiqbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnaUrGD0; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037802; x=1815573802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rn5WoE9aqjgy/fQcTFSuQUYdNpb3qzLFOIilqo9QWZA=;
  b=BnaUrGD0UhfefTHaSpkdgmZeMXZn/GaCzTe8nF4XIXfH3KsN6G8adfGA
   +yys+ZiScPAzkPjcrxe9892I+nToqfMTbOi+nbNZ5RKP/y1pvY2xnpTjU
   PeIZsbYTr0pXxNywVj038lNatm9nhs7XJO4A0d259VuUZaf3ejxP1w/dO
   /Vbq+gssAVE7fhcsZdegZzYpz7TP3FdGyCQsCmehVSPkTj9Sv6gh8BmPO
   ix6usHpG5e0r79k6fbu6Lb7faAR8+apcf8N/37h2bXaP0J7Av25dc3VFh
   BX7xSW3POPx6aD6+L1KwbQoqZEF7dTvncFjPAEbxbAQVL1gK4A/VrSF9x
   g==;
X-CSE-ConnectionGUID: O8dIx/t5SVyxUcF077TGzg==
X-CSE-MsgGUID: zwQmoDnZRGyXyfBGJGuPDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855172"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855172"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:03:05 -0700
X-CSE-ConnectionGUID: IvbL5QA6RDyiEw7ECzPU5w==
X-CSE-MsgGUID: yESkIQTZTk2O1k4G05QcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254738000"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:03:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 15/15] wifi: iwlwifi: mld: reset the driver state upon firmware recovery
Date: Tue, 14 Jul 2026 17:02:18 +0300
Message-Id: <20260714165826.ff1c9e05e0a9.I8df8d4a0384065fd2a32cf258339be77084c55bd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39075-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E162B7558A4

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Just like we did in iwlmvm, we also need to clear the mld state when the
firmware was killed because of the device being powered off during
suspend.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c      | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 17286b3341c0..4065d8e4fa8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -543,8 +543,7 @@ iwl_mld_mac80211_tx(struct ieee80211_hw *hw,
 	iwl_mld_tx_skb(mld, skb, NULL);
 }
 
-static void
-iwl_mld_restart_cleanup(struct iwl_mld *mld)
+void iwl_mld_restart_cleanup(struct iwl_mld *mld)
 {
 	iwl_cleanup_mld(mld);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.h b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.h
index aad04d7b2617..f3302997b28f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2026 Intel Corporation
  */
 #ifndef __iwl_mld_mac80211_h__
 #define __iwl_mld_mac80211_h__
@@ -9,5 +10,6 @@
 
 int iwl_mld_register_hw(struct iwl_mld *mld);
 void iwl_mld_recalc_multicast_filter(struct iwl_mld *mld);
+void iwl_mld_restart_cleanup(struct iwl_mld *mld);
 
 #endif /* __iwl_mld_mac80211_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 99506f354bfa..093bdc130704 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -748,6 +748,7 @@ static void iwl_mld_device_powered_off(struct iwl_op_mode *op_mode)
 
 	wiphy_lock(mld->wiphy);
 	iwl_mld_stop_fw(mld);
+	iwl_mld_restart_cleanup(mld);
 	mld->fw_status.in_d3 = false;
 	wiphy_unlock(mld->wiphy);
 }
-- 
2.34.1


