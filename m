Return-Path: <linux-wireless+bounces-36336-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cnuMLxeBA2pX6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36336-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:35:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BD528B08
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8723630205DD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5963655CE;
	Tue, 12 May 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrVfGgol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EE35979
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614507; cv=none; b=EBZquRj1QiurohN5k2eQ3fwDsN1OS7BMvu7IdwATiwtMTA7FRQrLud8WcSna8N27EbUZd+GRyiLIDP0h9RJo4WKfLLRnNPYxY74YhZk8VhH8YQZcsATHVwA8LPwHtrARA+mL7I0e7tN8N4xsut8M7pS4jYPcxDy/reVKqYRPfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614507; c=relaxed/simple;
	bh=WyIDgFpU/TB7SeKtJP5qj13i6SFsEqxVb6ywgdzq8p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7gLJPZ+/V/s+k+QB/hx+Tn+G3/Tgumhi0GqL4aNaQXpwLpUtqjSJ489RhWnPY9V4N8dE8iN6dlC3L0j/cTukRVN1vL6gpv+TdwfOEbvjQHRlzNfqJRNcINvLDDPlqdb2RBasHOnjw5ckAa/AbeZ2mBc70jSoQ18hmdB/9xNNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrVfGgol; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614506; x=1810150506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WyIDgFpU/TB7SeKtJP5qj13i6SFsEqxVb6ywgdzq8p4=;
  b=XrVfGgol+P97na9Ph8BJOanHSYJ3oXaW9fxvnVyOTKNRx5ABvT8rGiG6
   pCDS0ykEGqVrrThQVl89HDlNdBhuAsZNLjro8AxmEUGMQa4Umv07DPak0
   WzLsIJSOFxvreCtiQrTCAijn+MkQxNnRZyAHnd0MWIL8DoVgJ8/ttJxlI
   KijhptmKOYF/m+LUULtYbfAh2ws3Q8b6b+emYLuYH1ICunwK3ItPW5q69
   UCAAxaOn0nRKufD0cgt1puKqtiQAC2+SocmiWOEbaV66fHxl9TAwF7Asn
   syTHGUOc8t6lI53QpwpQF8U73vg25xZcuwhmTI0ItpZdIhVP7dVB+52YX
   g==;
X-CSE-ConnectionGUID: GSe2G1pzRVGYqvKWPkGicw==
X-CSE-MsgGUID: cOwGEatkSsW7B0aeMq5ihg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148792"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148792"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:06 -0700
X-CSE-ConnectionGUID: ibQj8bhEQL++C+K0LT550Q==
X-CSE-MsgGUID: QCZ/1hx1RIi20rDZykQyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471785"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: validate aux sta before flush in stop_nan
Date: Tue, 12 May 2026 22:34:35 +0300
Message-Id: <20260512222731.76b3db062a5e.I0567cfeb915c38c517eb6e1829d78c9fa8653c1f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B6BD528B08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36336-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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

From: Daniel Gabay <daniel.gabay@intel.com>

iwl_mld_stop_nan() calls iwl_mld_flush_link_sta_txqs() without checking
that aux_sta.sta_id is valid. The DW end handler correctly guards this
with a WARN_ON check. Add the same defensive check to stop_nan for
consistency and to avoid sending a flush command with an invalid sta_id.

Fixes: 600941464991 ("wifi: iwlwifi: mld: Declare support for NAN capabilities")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index deb72e401e3c..913f0acf172a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -203,7 +203,8 @@ int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 	/* assume that higher layer guarantees that no additional frames are
 	 * added before calling this callback
 	 */
-	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
+	if (!WARN_ON(mld_vif->aux_sta.sta_id == IWL_INVALID_STA))
+		iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
 	iwl_mld_remove_aux_sta(mld, vif);
 
 	/* cancel based on object type being NAN, as the NAN objects do
-- 
2.34.1


