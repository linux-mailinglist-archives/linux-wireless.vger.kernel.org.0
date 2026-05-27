Return-Path: <linux-wireless+bounces-37039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPA9NqlOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BC5E9E4F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D1EC3038863
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9D363C73;
	Wed, 27 May 2026 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SK598u8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B83B775E
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912348; cv=none; b=a5CShp+U9KVuuXLK+cuovXP8Zvcmy9C06jcQ97W8hWuwVPHNahDyet9Kcrpf3S9UKslIZU9XgANN8PK6M4YoOHGr7LlkaYW68MTJgH1PFeOCch57XMMjQSYxFSmnve3WaEKCevGFuQuupfeJlnjwwqncWmDFlMrHYIO/2IBqXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912348; c=relaxed/simple;
	bh=ccL1NLP9FHZdA3MdOy7d0OBbHk5nWjL22Ekt5q6DwdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mC71P1RUad/l/DG4JpT2JQkRYrNo6qohXbQsalj2BlcdJc2e3ISegYnWctb8y1KueKRBBHHPu/RLJqoWVHSjvScd8zY06AKJ9O/o5NzvDJdjUIAHNOLxIVrVGVOdYicQT5DhGUgOQ2jJW5azNlCeHkKrTQBVd10sxFY4hRxK/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SK598u8I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912347; x=1811448347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccL1NLP9FHZdA3MdOy7d0OBbHk5nWjL22Ekt5q6DwdY=;
  b=SK598u8IDRFjxS4gMAcxaLS1yuDbkQ9/toTl/BKMFecS9vMMHSNC1Hyp
   dn1dtfWyyMNNTc2s8dJgnNaw6qVHMY1irdqRaT5pKcpyWqJd5r99I3UdX
   96sJR8nexUvWhVbRvmGTDMGNMYhqoXEaV4me+2dug+mfAFucLKasjTTrm
   hBUcqeIo3NnoZWcpVnJZkC+hCOwrKWBTY6zC7fiNtFGsPmWAIh5UQbHgT
   kkLhsvvC+538qiI0RcdwnMhfvb1g07AXFswMrIG0eXkUO3g2CormJOjVA
   Xw0dkDBBMsIN4uT4op6sV0iotKWxe4No8+YWiyTetlGdGj7t5PWOAp6iA
   Q==;
X-CSE-ConnectionGUID: DTOP0LALTjqYrXMbMMr1Aw==
X-CSE-MsgGUID: 5wWykdmnSSKn5y5Obny/AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940880"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940880"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:47 -0700
X-CSE-ConnectionGUID: Oya9Ww5TR5u0nLKtSMyr9g==
X-CSE-MsgGUID: htd/jIdKQmevi7GBKLBWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286990"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mvm: fix P2P-Device binding handling
Date: Wed, 27 May 2026 23:05:11 +0300
Message-Id: <20260527230313.07f94335ae06.I384238b0859343c4a9a9dda20682be1aad89cc9d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37039-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 787BC5E9E4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Our binding handling for P2P-Device can run into the following
scenario, as observed by our testing:

 - a station interface is connected on some channel
 - the P2P-Device does a remain-on-channel (ROC) on that channel
 - the ROC ends, and the P2P-Device is removed from the binding,
   but the phy_ctxt pointer is left around as a PHY cache so we
   don't need to recalibrate to the channel again and again in
   case it's not shared
 - a binding update by the station interface, even a removal,
   will re-add the P2P-Device to the binding
 - the P2P-Device is removed, which removes the PHY context, but
   it's still in the binding so the firmware crashes

Since the P2P device is removed from the binding and only re-
added by unrelated code, but we want to keep the phy_ctxt around
as a cache for future ROC usage, fix it by adding a boolean that
indicates whether or not the P2P-Device should be added to the
binding, and handle that in the binding iterator. That way, the
station interface cannot re-add the P2P-Device to the binding
when that isn't active.

Assisted-by: Github Copilot:claude-opus-4-6
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c    |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   | 12 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c |  3 ++-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
index 58e9a940024d..0812522edea0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2012-2014, 2020 Intel Corporation
  * Copyright (C) 2016 Intel Deutschland GmbH
- * Copyright (C) 2022, 2024 Intel Corporation
+ * Copyright (C) 2022, 2024, 2026 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "fw-api.h"
@@ -76,6 +76,9 @@ static void iwl_mvm_iface_iterator(void *_data, u8 *mac,
 	if (vif == data->ignore_vif)
 		return;
 
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE && !mvmvif->p2p_in_binding)
+		return;
+
 	if (mvmvif->deflink.phy_ctxt != data->phyctxt)
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c256cbc6602e..74bd4038fd56 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1104,6 +1104,7 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	spin_unlock_bh(&mvm->time_event_lock);
 
 	mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
+	mvmvif->p2p_in_binding = false;
 
 	mvmvif->bf_enabled = false;
 	mvmvif->ba_enabled = false;
@@ -4634,6 +4635,7 @@ static int iwl_mvm_add_aux_sta_for_hs20(struct iwl_mvm *mvm, u32 lmac_id)
 
 static int iwl_mvm_roc_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -4642,10 +4644,18 @@ static int iwl_mvm_roc_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (WARN(ret, "Failed binding P2P_DEVICE\n"))
 		return ret;
 
+	mvmvif->p2p_in_binding = true;
+
 	/* The station and queue allocation must be done only after the binding
 	 * is done, as otherwise the FW might incorrectly configure its state.
 	 */
-	return iwl_mvm_add_p2p_bcast_sta(mvm, vif);
+	ret = iwl_mvm_add_p2p_bcast_sta(mvm, vif);
+	if (ret) {
+		iwl_mvm_binding_remove_vif(mvm, vif);
+		mvmvif->p2p_in_binding = false;
+	}
+
+	return ret;
 }
 
 static int iwl_mvm_roc(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e09b63516230..6bf71092faa1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -383,6 +383,8 @@ struct iwl_mvm_vif_link_info {
  * @pm_enabled: indicates powersave is enabled
  * @roc_activity: currently running ROC activity for this vif (or
  *	ROC_NUM_ACTIVITIES if no activity is running).
+ * @p2p_in_binding: indicates that this P2P-Device interface should be
+ *	added to the binding, i.e. is running ROC right now
  * @session_prot_connection_loss: the connection was lost due to session
  *	protection ending without receiving a beacon, so we need to now
  *	protect the deauth separately
@@ -492,6 +494,7 @@ struct iwl_mvm_vif {
 	struct iwl_mvm_time_event_data time_event_data;
 	struct iwl_mvm_time_event_data hs_time_event_data;
 	enum iwl_roc_activity roc_activity;
+	bool p2p_in_binding;
 
 	/* TCP Checksum Offload */
 	netdev_features_t features;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 2b52a4f3bff9..1692b6e75f57 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -88,6 +88,7 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 			} else {
 				iwl_mvm_rm_p2p_bcast_sta(mvm, vif);
 				iwl_mvm_binding_remove_vif(mvm, vif);
+				mvmvif->p2p_in_binding = false;
 			}
 
 			/* Do not remove the PHY context as removing and adding
-- 
2.34.1


