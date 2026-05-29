Return-Path: <linux-wireless+bounces-37096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMAhCs0qGWrCrggAu9opvQ
	(envelope-from <linux-wireless+bounces-37096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:57:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB65FDA85
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDA10300C7FF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F23A7843;
	Fri, 29 May 2026 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLVr0wpF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4683A4538
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034247; cv=none; b=PdB0XiPOyBkegrXMPsi5mac0g8gFRadqd3i+1kXi42i7DnmltqIIuMoM7b8ZRQUThHfKpUplmMBeuKu2w5tRwaEtRNudQvByasU2COAyJc0eeue3ye+uptAFgVNmOKhDO0RM/zVdgqKbq5B8Oh+1H+bRReQUsyy6pAs9FltqJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034247; c=relaxed/simple;
	bh=fPENtGYU+cNYSrhOtC+FXFOTCLGvgWtbxevxkMyA8Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTgSxFPWS3ff1i0vG9nAhOiuk8KgUznI74m1+ELyA0F+QioXMzLpocf8qgzqj1vGE5bpJvNyHEHje4R3kvYenC4cZPq5fimihvmzm7XPMFfHI3sf6LETeXL4OwfQSCaVXJhAi4Ly9h0UqubBzBMov6btTXG8+n05oHAL8DD8MRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLVr0wpF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780034245; x=1811570245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPENtGYU+cNYSrhOtC+FXFOTCLGvgWtbxevxkMyA8Uw=;
  b=dLVr0wpFw6gw/RhbldkCiAWWg2VrYHwMJo36EgNi03yrkZmeejFlirrN
   Mki7h6Q4dlwc0gtoRdpUgLdQtBtBYQQnkWAz+il4YXQmJKYq43iljtVRQ
   KPP6b4WsLsG1L0QBOgwegZIxzVxIPb3wKaSbmvpzXmcCfgEVvuKi1eP7p
   M7s7LB0WLQBHSHaPmwJPuSHNE9o1B6eI/vWJ3by76IzrwBAywMCk5S5E7
   K9C8FRmxoYGhNjGidNvzdPP+ATfzgAwVySFWCXRJAuCo1y96/T5++0M7H
   7CrK1lVsYcUa8PBip3eohgqKVxxCM+0VS3VPyFzsD/O5PsrKxfG0LZDk3
   A==;
X-CSE-ConnectionGUID: gQVQi45QQYKd3z3znXdA8w==
X-CSE-MsgGUID: jmUclTSEQZeyLV5XB2UQkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84741132"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84741132"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:57:25 -0700
X-CSE-ConnectionGUID: uIaTmJcRQHaAziHzTWg+5w==
X-CSE-MsgGUID: cNCELUrdRyO+D9EhFUYTLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="238572735"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:57:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 wireless-fixes 2/3] wifi: iwlwifi: mld: send tx power constraints before link activation
Date: Fri, 29 May 2026 08:57:06 +0300
Message-Id: <20260529085453.06c94b01efd2.Id43bdfe5eb030061c23348779687ba71b5f58182@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529055707.24862-1-miriam.rachel.korenblit@intel.com>
References: <20260529055707.24862-1-miriam.rachel.korenblit@intel.com>
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
	TAGGED_FROM(0.00)[bounces-37096-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 19EB65FDA85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

TX power constraints must be sent to the firmware before link
activation. If not, the firmware will use default power values.

Fix this by moving the iwl_mld_send_ap_tx_power_constraint_cmd()
call from iwl_mld_start_ap_ibss() to iwl_mld_assign_vif_chanctx(),
before iwl_mld_activate_link() for AP interfaces. Also update
the guard in the function to allow it to run before link activation
for AP interfaces.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c       | 4 ----
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mld/power.c    | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
index 5c59acc8c4c5..6598d9333333 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -9,7 +9,6 @@
 #include "ap.h"
 #include "hcmd.h"
 #include "tx.h"
-#include "power.h"
 #include "key.h"
 #include "phy.h"
 #include "iwl-utils.h"
@@ -273,9 +272,6 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	struct ieee80211_chanctx_conf *ctx;
 	int ret;
 
-	if (vif->type == NL80211_IFTYPE_AP)
-		iwl_mld_send_ap_tx_power_constraint_cmd(mld, vif, link);
-
 	ret = iwl_mld_update_beacon_template(mld, vif, link);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index da6fd7471568..3c8daddc0bcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1150,6 +1150,13 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (iwl_mld_can_activate_link(mld, vif, link)) {
 		iwl_mld_tlc_update_phy(mld, vif, link);
 
+		/* FW requires AP_TX_POWER_CONSTRAINTS_CMD before link
+		 * activation for AP and after link activation for STA,
+		 * for an unknown reason.
+		 */
+		if (vif->type == NL80211_IFTYPE_AP)
+			iwl_mld_send_ap_tx_power_constraint_cmd(mld, vif, link);
+
 		ret = iwl_mld_activate_link(mld, link);
 		if (ret)
 			goto err;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index 49b0d9f8f865..266fe16bb95d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -366,7 +366,7 @@ iwl_mld_send_ap_tx_power_constraint_cmd(struct iwl_mld *mld,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	if (!mld_link->active)
+	if (!mld_link->active && vif->type != NL80211_IFTYPE_AP)
 		return;
 
 	if (link->chanreq.oper.chan->band != NL80211_BAND_6GHZ)
-- 
2.34.1


