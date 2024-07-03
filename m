Return-Path: <linux-wireless+bounces-9904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F092578D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B71C259C5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F01422DE;
	Wed,  3 Jul 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lERIb7Ki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262F1428E4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000759; cv=none; b=jhDKHVYkDSZmM36yeWF0ZW3xHHxpEIv6IOZI8x/m/Vr/edNCYoVkPeJxbE8jAf1ObExtIyy4MrT1XklUQ6MbCwqJy6gZMM89usMFTiKBSq7lvLcfTui0XRZGP3TwMZrXHBeeDc4VuHGaHiRHfqRe8S2dCo2b23+2xooUrplYtGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000759; c=relaxed/simple;
	bh=r7BtfqVkyE0G40/SqdqGd68sqY+w3QY4mRO6fHHi6nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHRZ0IrEaQoZQhMakW2DMlzufZUQT/gqzQwDv1OirgBnBIJtFBXBCpC9XpJ49ohkZpRvw48RoHj9qJgZHgFFDlb3HTkoMj7u3o/RNZHm3ALtpWbLgLVe1BceQTlFvRxQ0s0KlxFHpCBUOfKT3RktZi9d05pXHB3mWVSlMMrwRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lERIb7Ki; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000758; x=1751536758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r7BtfqVkyE0G40/SqdqGd68sqY+w3QY4mRO6fHHi6nc=;
  b=lERIb7KiR/mizQ6rWLVoUsOOog8wYzvUpUh8szQj6PICMjcG30UhpTN6
   P13SQRNqZ9wKpO9kC6I0aNzeQLkwq9EGoP7c6ZUdghpMFUmYGKlALMIPq
   Oguf5bmK0Af+13K0zCRlQ5B0ACLg3Q3xJiLkT8xmftLTQu9S0s+gVk1k+
   lm/lQRYmV+2araMh3L/gaqesSFxKzpLtsEY3dppQB8FprRfLbaDBeL2MR
   5jau2jTrOTz1wscAUea5riVS6SmzFZS4Kp70Qvlt4eoLNUhafYriex2kU
   x5WX96aVC4SrS/LVtwJuE29sXAbbwe1h2wPfJD2Mtof/QQtf31qzJSCn7
   w==;
X-CSE-ConnectionGUID: SMqnEMEXSc2kh4kyB9m+eA==
X-CSE-MsgGUID: OM6bMH2FQ02IlU2JQ7lSyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837512"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837512"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:18 -0700
X-CSE-ConnectionGUID: q/GKnXAQQ+u5rI0LpQdiQQ==
X-CSE-MsgGUID: 3n6Sym2LTdG2nW87Xgr23A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987727"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/18] wifi: iwlwifi: mvm: simplify EMLSR blocking
Date: Wed,  3 Jul 2024 12:58:51 +0300
Message-Id: <20240703125541.6995464f0bac.Iac9fe3546ca0a0d6bc6666c822a667ab257419a9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If EMLSR is already blocked for the same reason that
it's blocked for again, there's no need to actually
do any work, so exit early from the function. Also,
print the state after modifying it, so it's clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 73527781f89a..4e702e7a4b82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1033,15 +1033,17 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
 		return;
 
-	if (!(mvmvif->esr_disable_reason & reason)) {
-		IWL_DEBUG_INFO(mvm,
-			       "Blocking EMLSR mode. reason = %s (0x%x)\n",
-			       iwl_get_esr_state_string(reason), reason);
-		iwl_mvm_print_esr_state(mvm, mvmvif->esr_disable_reason);
-	}
+	if (mvmvif->esr_disable_reason & reason)
+		return;
+
+	IWL_DEBUG_INFO(mvm,
+		       "Blocking EMLSR mode. reason = %s (0x%x)\n",
+		       iwl_get_esr_state_string(reason), reason);
 
 	mvmvif->esr_disable_reason |= reason;
 
+	iwl_mvm_print_esr_state(mvm, mvmvif->esr_disable_reason);
+
 	iwl_mvm_exit_esr(mvm, vif, reason, link_to_keep);
 }
 
-- 
2.34.1


