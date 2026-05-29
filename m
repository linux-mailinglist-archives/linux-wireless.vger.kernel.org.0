Return-Path: <linux-wireless+bounces-37092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMAiDJopGWp/rQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:52:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6C5FDA2C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3546631B548A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130983A452E;
	Fri, 29 May 2026 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPkIL901"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2F3A16A0
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033612; cv=none; b=M67/JPqOgj/fo/0CuyW2tLPmuQgvpj1wY5AF4HXBPfewVWk8NChhVnLGeBsOQg6PL/2P5A4rX0FgFK6Gv7PzWvy6UbqcY2A1DXI7jcSdAXZGl9aNkYm8A4jhZEu4iuT+BEfzdxN16oataz+N/+qsHdTNCM2WDNtmvAk3kKhl9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033612; c=relaxed/simple;
	bh=fPENtGYU+cNYSrhOtC+FXFOTCLGvgWtbxevxkMyA8Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qx4bj80CSAVbUt1SUYKhMthiLx1csmTFLw2IQOZ0JrX5EjxZIsSTxP3gemBcRUjsT7FzJvsZsFRG5nHkHB1xO7iZ9HYmJjM+bFyxni17AkJ+K0IOimk79e+FcAxC/sMTEnV3KR+OsLPY4V8wGkgZjzaGst4yZDANgE9pdOykxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPkIL901; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780033610; x=1811569610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPENtGYU+cNYSrhOtC+FXFOTCLGvgWtbxevxkMyA8Uw=;
  b=BPkIL901s7kCJGCdby3ackjSLtJIitv+nIbcOu2VzgrXEFQcFHNMl3bK
   Y1YOIG7tA0IUugsSDnwT10fYmFzhxpYSFqpnq7ewnXHZ0EwGzKFaN+67S
   tFipMzl0bF1ISHro6koeAMTf0vx0chIzluFNHlUyFZ2ijzAlJyKhUhEGd
   fZ/e5hdsE9Ql07WxjQW7s2jbMEIl+ivlXQvG5pktq7hCNGBMDypeUFMCN
   Rq1qpwJvWmwpWDp8ToMnsE1omtKhjmyQ/yjdHn+ZXdyGO/kILByJkIQ1I
   8Nr6W897N+VYY779L17+4FOpt0mCaGWtroxlEVrCg5hFuiGZYFKdbK6X7
   A==;
X-CSE-ConnectionGUID: 5l1zyqG4TeWQP/vZ0lyuKg==
X-CSE-MsgGUID: QmxTJbHkTseYfP4kRWGrkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91453709"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91453709"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:50 -0700
X-CSE-ConnectionGUID: U6dIn/YsRbqE4h5vGY8TbA==
X-CSE-MsgGUID: TMfATLNdS2SC818kc5DbQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247043584"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-fixes 2/3] wifi: iwlwifi: mld: send tx power constraints before link activation
Date: Fri, 29 May 2026 08:46:30 +0300
Message-Id: <20260529084540.06c94b01efd2.Id43bdfe5eb030061c23348779687ba71b5f58182@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
References: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37092-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 86C6C5FDA2C
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


