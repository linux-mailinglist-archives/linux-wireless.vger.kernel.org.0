Return-Path: <linux-wireless+bounces-37029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO2uIK1OF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1C5E9E56
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541EF30182BD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50A73B637F;
	Wed, 27 May 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy/oOxoU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428C3B19D0
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912334; cv=none; b=jKL8DGG8Phjopv9vMd6eY1Z8roE5AxiCq5UNbhPg2/ZqhNHNssSXBkY6es76BhnHAj1/TuWrVdO0+s6dtK3+RU6yrln7nFO/Cm4f+dpw+ZscO9TSESRKshSUzVRsEV3zOrpG4em50DM2E3EArkHiHJaqwl1kST/mWRcRrp4hmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912334; c=relaxed/simple;
	bh=1RJWoWBs8h23R4whuVJ5rNTuw6vLTyad49veAk+GReg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LP5T5D9HPKB5mOpLQ/xEt7vzpJEo0yCSD24c7q8FtE343i1fUsR1BOSYzHbtiYIFDH17i2rV/D+xvuOyRNLvs6uyA4m6mEndTu6N2ssLSMrpwgWgaeJ4XEBs8CxYPefNkbnF0ZpsRW5kTGJsa4+rvAeOcNCJk1ukdb6/fvNE/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy/oOxoU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912334; x=1811448334;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1RJWoWBs8h23R4whuVJ5rNTuw6vLTyad49veAk+GReg=;
  b=Qy/oOxoUILSA1gLOnbRcCD4/ylo8aZpHKCmrfmPyfCexzZIXy1bTnq0l
   mVjRsqlYV5nFt4ADfFrDpFpshJGrqIClqSmkOZwEBdCptXbtft1+o1qS+
   6ixPswxMOYXI/NvHYUYIVvNNk49ADvgHGEvgYslsTYna/MjVQHqFMktrv
   EQrTOtfwADzdSeqN7f2Mujq8X6i/ogds6erk6Y02EGbWuHxICLb+MW1FF
   unbB6d32SsMTFEl0vLC/hDpBVG5D0UByrvHABMaLaBE2FxsRAs0l4o4mH
   CWelcvgxIHEG+g2Y1AsvqAJCyEBaOs2GrEjywiqTMt/j19+aEx/+h9hvx
   w==;
X-CSE-ConnectionGUID: 1XXQlHmjRfaXA1NwRs7XJw==
X-CSE-MsgGUID: TKt4ug3dSN+qyHDQXsdLBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940859"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940859"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:33 -0700
X-CSE-ConnectionGUID: 9rgOsbsnTo6oxrPJ6H0iYg==
X-CSE-MsgGUID: kJec5zBZQkCTrTzi6yX8jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286952"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: fix smatch warning
Date: Wed, 27 May 2026 23:05:01 +0300
Message-Id: <20260527200512.506707-2-miriam.rachel.korenblit@intel.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37029-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 18A1C5E9E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We dereference the mld_sta pointer before checking for NULL.
But we do check the sta pointer, and sta != NULL means mld_sta != NULL,
so there is no real issue.
Fix it anyway to silence the warning.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 1e8716cbb4ce..2185dade95f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -563,7 +563,8 @@ iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
 	 * - when no sta is given.
 	 * - frames that are sent to an NMI sta, which is only used for management.
 	 */
-	if (unlikely(!sta || mld_sta->vif->type == NL80211_IFTYPE_NAN ||
+	if (unlikely(!sta ||
+		     (mld_sta && mld_sta->vif->type == NL80211_IFTYPE_NAN) ||
 		     info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
 		flags |= IWL_TX_FLAGS_CMD_RATE;
 		rate_n_flags = iwl_mld_get_tx_rate_n_flags(mld, info, sta,
-- 
2.34.1


