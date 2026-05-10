Return-Path: <linux-wireless+bounces-36147-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLDLIQfRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36147-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C6505B83
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D2830099A3
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20216315D50;
	Sun, 10 May 2026 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STQOt47Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F326B75B
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438397; cv=none; b=jDlTIEpO7qUkugfh4Tcz9clkRKAI2U5MGz2/W5zmqAlJeiJdYeT8X4aUb6+ob2HJUKxV+WwlajKp/1oD99WQtIkHignceMjQkMZ4fEB4wNUbyKv119dwDnVUVomxVwnxJKUmGrR5INVCbEe2FI13jTZ4Qc/f6eVbAD7AeZdU66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438397; c=relaxed/simple;
	bh=kHMmKfRD4HV8lJyWPj9M3EOPdlLO6K0ulT7wUr6IV2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXL8BrNlyX2h9RotUdTgpcB7cIUuEXbx4RwqTHhkbIAXC69ZdCbJZAwYHrOGUNtqXESy/iTnNTNw8j2A0h3gViAZ7CrLMvMCnSgbUxdzk1bHuzsv4wrP+jy/oNEXtTR1fAgYHHaYN46jgm/elmOr+DuGZHGq4sN9WBUqxcrewvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STQOt47Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438396; x=1809974396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kHMmKfRD4HV8lJyWPj9M3EOPdlLO6K0ulT7wUr6IV2Q=;
  b=STQOt47Zkr2ZRudzh1OyhZMU/VCveLda7El6IyVfXhmit4v1eBFzC9vE
   HwhETIupYoABFqoG+il3qkyIQ7S25d+XJbEK/Jp1+d1XFiGycetxjIxAq
   X8ZxcgGa61onSmn+g+c0tnvBxglVGY3NYMj3UZF2PKunxYqIBBCmoJsrw
   GD6x6tmPDuopazRJpqIgmkvl5Mkg0gg1LbIRo4aTqNGtpu5QQ2nmokRIu
   XesQm+68d0Ugtr4/rTSWzVMrHOZoFgNrawOJo+JRj4Vu1WrKwsCKPt2bK
   JPb4OFub28ewZ1en2jX10CVS9dmaN3EmWdsG+qXIm0a2UGwcM/0AybTuf
   w==;
X-CSE-ConnectionGUID: t9O++y3ZQzGPGamjxk/V+Q==
X-CSE-MsgGUID: PSuMW87dS1yIilSdAENO7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208971"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:56 -0700
X-CSE-ConnectionGUID: nc8UbstnTFGMMVpWOYxEoQ==
X-CSE-MsgGUID: mJdUNISWQ2Cgc6O6aPaOfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626760"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: disable queue hang detection for NAN data
Date: Sun, 10 May 2026 21:39:26 +0300
Message-Id: <20260510213745.695fba8c6207.Ifd879478bc30af25de0eada6143dbc3e6a548068@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
References: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 042C6505B83
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36147-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Since peers on NAN data might just use ULW and/or break the
schedule, disable queue hang detection for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 546d09a38dab..7903ce2b0beb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024 - 2025 Intel Corporation
+ * Copyright (C) 2024 - 2026 Intel Corporation
  */
 #include <net/ip.h>
 
@@ -71,14 +71,19 @@ static int iwl_mld_allocate_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 {
 	u8 tid = txq->tid == IEEE80211_NUM_TIDS ? IWL_MGMT_TID : txq->tid;
 	u32 fw_sta_mask = iwl_mld_fw_sta_id_mask(mld, txq->sta);
-	/* We can't know when the station is asleep or awake, so we
-	 * must disable the queue hang detection.
-	 */
-	unsigned int watchdog_timeout = txq->vif->type == NL80211_IFTYPE_AP ?
-				IWL_WATCHDOG_DISABLED :
-				mld->trans->mac_cfg->base->wd_timeout;
+	unsigned int watchdog_timeout;
 	int queue, size;
 
+	switch (txq->vif->type) {
+	case NL80211_IFTYPE_AP:		/* STA might go to PS */
+	case NL80211_IFTYPE_NAN_DATA:	/* peer might ULW/break schedule */
+		watchdog_timeout = IWL_WATCHDOG_DISABLED;
+		break;
+	default:
+		watchdog_timeout = mld->trans->mac_cfg->base->wd_timeout;
+		break;
+	}
+
 	lockdep_assert_wiphy(mld->wiphy);
 
 	if (tid == IWL_MGMT_TID)
-- 
2.34.1


