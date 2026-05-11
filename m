Return-Path: <linux-wireless+bounces-36248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLYpD8UTAmrangEAu9opvQ
	(envelope-from <linux-wireless+bounces-36248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:37:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0172513993
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E90113015709
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A354657FA;
	Mon, 11 May 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q86zRJUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4C3FF8BF
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521019; cv=none; b=sMhiZeEoFIe5cNDeVI/y5MaZR+LqDKv4x3gG69EkVcejIVRGGjb59Z8dTVQD2e1lon5cz0b4XkM3Ug7Z4AGxFa0PdmaYUQo3hz/N09cPmyPs+iExpoLxBOKP/jrBsNEbV0oI/zXNpf1M1Pj+ZxcQAPFfFIwqTVIndeLWc/LyRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521019; c=relaxed/simple;
	bh=kFqZ62owYNYXGRiDCqobz1kHLVNrA5CbU0IMaTlmurM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbwHlD+3Hfnq2mejZk+zncB3xWzWzO7dwPUNdO8xFBz9GVcxYcghNs0ONkQplvVgs75sexLUTqWBIre3YO0bnF4/bRLXCNBeeRYAmBVGLtzHkXW581JfnbC3pK+guF15lxypbXFVrRwFVGOE+h5RkN8+qMQPOF7FVfGygP9a0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q86zRJUB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521019; x=1810057019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFqZ62owYNYXGRiDCqobz1kHLVNrA5CbU0IMaTlmurM=;
  b=Q86zRJUBV/Gdl+mookxAw7NTBnni3HnK0UJA3iMzM6MYcB5DLpL+fg2K
   /or3Tp1vAOuJxe0VXxPWOg2yH8GsjQh8m7NTk4pB36iZ11dwl1zuRykUJ
   x0MygGjkkEgnTr6RWQn+C4ygmmeS78F17XhxR8J7eyF7pxmFk6G1uYXyw
   zwon9+gOm980B+GIivPOTGAzGOA4xro0Ai5i8UFUfSkbJ1ZExkyEo7wLQ
   s3uZrWUYJYF5TN3Ce/dk1TMWRu2pkSXbXjinJqV1eI83ZY6S7Y9B8ra/a
   18cfIzq4x+7xIUC8mUfttMHwiusTcW3jK8b4keEMXFAy8UzV2Vo5zqqAn
   Q==;
X-CSE-ConnectionGUID: f2UQQRC7Q+uimSA4sndO9A==
X-CSE-MsgGUID: zobdj/7SQBqYJRgbxl3vZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314811"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:57 -0700
X-CSE-ConnectionGUID: cuXsnDP9RqCg/ZPTl+lU1g==
X-CSE-MsgGUID: 3OM0L6iEQO+YOiYB+WuFJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004745"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: clean up station handling in key APIs
Date: Mon, 11 May 2026 20:36:23 +0300
Message-Id: <20260511203428.0efcbac3e96e.I5b78af51df283d452fc4f1366b04b4769f60f24e@changeid>
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
X-Rspamd-Queue-Id: F0172513993
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36248-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The internal key APIs, when called with group keys where mac80211
doesn't pass the (AP) station pointer, are still sometimes called
with the AP station pointer on internal calls. This is confusing.
Clean it up and always call them with the AP STA when it exists,
even when coming in from mac80211, by looking it up immediately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/key.c      | 12 ++----------
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index 04192c5f07ff..2cb312ebd7a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024, 2026 Intel Corporation
  */
 #include "key.h"
 #include "iface.h"
@@ -12,7 +12,6 @@ static u32 iwl_mld_get_key_flags(struct iwl_mld *mld,
 				 struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
 {
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	bool pairwise = key->flags & IEEE80211_KEY_FLAG_PAIRWISE;
 	bool igtk = key->keyidx == 4 || key->keyidx == 5;
 	u32 flags = 0;
@@ -38,9 +37,6 @@ static u32 iwl_mld_get_key_flags(struct iwl_mld *mld,
 		break;
 	}
 
-	if (!sta && vif->type == NL80211_IFTYPE_STATION)
-		sta = mld_vif->ap_sta;
-
 	/* If we are installing an iGTK (in AP or STA mode), we need to tell
 	 * the firmware this key will en/decrypt MGMT frames.
 	 * Same goes if we are installing a pairwise key for an MFP station.
@@ -92,11 +88,7 @@ static u32 iwl_mld_get_key_sta_mask(struct iwl_mld *mld,
 		return BIT(link->mcast_sta.sta_id);
 	}
 
-	/* for client mode use the AP STA also for group keys */
-	if (!sta && vif->type == NL80211_IFTYPE_STATION)
-		sta = mld_vif->ap_sta;
-
-	/* STA should be non-NULL now */
+	/* STA should be non-NULL */
 	if (WARN_ON(!sta))
 		return 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index c02994e63b14..4b5f50ff2b05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2282,9 +2282,20 @@ static int iwl_mld_mac80211_set_key(struct ieee80211_hw *hw,
 				    struct ieee80211_sta *sta,
 				    struct ieee80211_key_conf *key)
 {
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	int ret;
 
+	/*
+	 * FW always needs the AP STA for client mode.
+	 * Note that during removal this could already
+	 * be NULL (mac80211 removes keys after STAs)
+	 * but then we'll already have removed the key
+	 * and set hw_key_idx = STA_KEY_IDX_INVALID.
+	 */
+	if (!sta && vif->type == NL80211_IFTYPE_STATION)
+		sta = mld_vif->ap_sta;
+
 	switch (cmd) {
 	case SET_KEY:
 		ret = iwl_mld_set_key_add(mld, vif, sta, key);
-- 
2.34.1


