Return-Path: <linux-wireless+bounces-3116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CE849104
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ED21F227E9
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6241C83;
	Sun,  4 Feb 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1dbYzBw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA941C75
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084427; cv=none; b=IjZIBmpsn2f3mdFrfGRnvLi1uDffl/nh74QGNw2frw8APzA5l8rkwtDif/2XNedJmoRmnKQYcuyOM9p0dEiDBoKJfs4j5mWFPz0g7Se8wYcHZ2tNa0usMS4hLHYJvcg3B/YkCHRfeAuJ6TJnKCqBdN52sED0JoHSK9WKT/GT1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084427; c=relaxed/simple;
	bh=23njImPAdDE9Ow9CwFa8YkPwrodEIW/Bx/Oo44bHgVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=he5Z/nF0l35YI/hlSnxozas6y9/3/qV/oRwc/GkDlp70DRCZJZPOyHZ2Ax4CZWzZGqRbUHuMVNpNpcDp0CEXqlngfgiqsd5lJpqQhw5J6p4U38WjMLk+zDIkQX+kA/w5LjWc8ILGCykHIZ6/S1T/MPqqdgk0HuOSPRsFjbDh/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1dbYzBw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084426; x=1738620426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23njImPAdDE9Ow9CwFa8YkPwrodEIW/Bx/Oo44bHgVs=;
  b=S1dbYzBwwctRUcchoAi84AQs8TjwoUTdTGyvY/xSgVuhma3TNdwoAncN
   8XQTNIC8SN1AhHk56kUTKyj96Py8hD34wK7eoEoWIZ/B4dsIC//bK3T+F
   Omvcs8dAs5+Gb5QfY+kfH+nwp3zXwyFBxrrUIehnyFGmO2U0HTX+jv0u0
   Qgd8Becdl3uVAJs4j4xqKV5an0azB+LHynFctNgWF+PFS/hihnlk4iKjs
   TaGQSN0Iy6HlabkVZIz7srKfhhogzREDWWuKpFgd7sc9nJIfWRlwTptDM
   zybFNxoj1S8UJCtarBShxdHBXJSznayQVXtTFe+trsOiwF21D7HUdTLkB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869402"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815962"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:07:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Grumbach@web.codeaurora.org,
	Emmanuel <emmanuel.grumbach@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: remove one queue sync on BA session stop
Date: Mon,  5 Feb 2024 00:06:17 +0200
Message-Id: <20240204235836.0a09ab337b54.I0dfe239dc30577a2ff23f910b10e9957364ccc78@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As documented in the comment, this queue sync was here to
ensure that an async IWL_MVM_RXQ_NSSN_SYNC queue sync won't
race with setting up a new BA session with the same BAID.
However, we no longer do IWL_MVM_RXQ_NSSN_SYNC queue sync,
so we can remove this as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Grumbach, Emmanuel <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 8ffbb8efda73..82db9018b384 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2015, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2015, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -2989,16 +2989,6 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		RCU_INIT_POINTER(mvm->baid_map[baid], NULL);
 		kfree_rcu(baid_data, rcu_head);
 		IWL_DEBUG_HT(mvm, "BAID %d is free\n", baid);
-
-		/*
-		 * After we've deleted it, do another queue sync
-		 * so if an IWL_MVM_RXQ_NSSN_SYNC was concurrently
-		 * running it won't find a new session in the old
-		 * BAID. It can find the NULL pointer for the BAID,
-		 * but we must not have it find a different session.
-		 */
-		iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_EMPTY,
-						true, NULL, 0);
 	}
 	return 0;
 
-- 
2.34.1


