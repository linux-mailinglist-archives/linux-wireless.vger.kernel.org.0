Return-Path: <linux-wireless+bounces-2735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C684134B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787EB1F21EED
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FF6F098;
	Mon, 29 Jan 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5g2rVXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1676023
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556176; cv=none; b=DwCb4Y8olTEEfT7JIWZI7jXqqYnSKyrdWkkwhHrH3uI1Yomif5bsrLUSsnvd14QdAZbi2Ui4POuxwEfFwp/WNPA9KqDmzf5HTttL30Yjb/t7+txnVGjuJ1pfIPhYVAD/u8PhvC0960A9VHYGez4cH9W2H+YmtYGI8xsgul9ddoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556176; c=relaxed/simple;
	bh=O70zkGez4tfHwLZX6elerUerujlIi78znAbDouzjcY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hc6xywncYKPxU2ueLFBqJldDHYiYbbP+9oXK7As605O5V4v2TebCyXz0hxQSKduRHFZ6nQB8UbwuT5nY4SvOEP8cJeqnWk04LkVg6YD7qGjQoNUnE1PJVuUhdDWoCHwSroV8GKryLGYKtC41IeIhYa/GvzNw8pRqL5CWGPnvK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5g2rVXT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556176; x=1738092176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O70zkGez4tfHwLZX6elerUerujlIi78znAbDouzjcY4=;
  b=R5g2rVXTUYL7of3Wp9i54l3InbmslwanbZwblEULRZ4nT02kTNOtcCnA
   iTxeGS8H8J/qkVJbRkmV65Mc8vPKmC0Fn7a+QHAv4TWFR72vqMevxGMOO
   ZU/y/UPB1wEKhp8T4V3hZGdRNS4jGT5kHCWgFijCNW7olHdiBp7bzXrvh
   1/EDnCLMvbuYhw9TJ1Te7WIy92Y+YYy+4Fxrx5YXr7Y9nfN51yEniY8ve
   0bSC58VzOre42v+6bRJyUhL37b1gUE5fefA5AhL8/8vOP8SOCJWw7ng5F
   BhJ+KPdDH7WOQ7WMXLv4h/6mDWnW4J6PN40fDHLKb8Ter3IwNwGWg8bWG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943071"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459173"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: log dropped packets due to MIC error
Date: Mon, 29 Jan 2024 21:22:02 +0200
Message-Id: <20240129211905.41b0abbf1fd2.Ib6ec6a48ec7bebe769d1e1c1df96380a758a0975@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

When we drop frames due to MIC error we want to have something
printed in the logger (this won't be printed by default).

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 451af501c7a1..67062fe40152 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -401,8 +401,11 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	case IWL_RX_MPDU_STATUS_SEC_GCM:
 		BUILD_BUG_ON(IEEE80211_CCMP_PN_LEN != IEEE80211_GCMP_PN_LEN);
 		/* alg is CCM: check MIC only */
-		if (!(status & IWL_RX_MPDU_STATUS_MIC_OK))
+		if (!(status & IWL_RX_MPDU_STATUS_MIC_OK)) {
+			IWL_DEBUG_DROP(mvm,
+				       "Dropping packet, bad MIC (CCM/GCM)\n");
 			return -1;
+		}
 
 		stats->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MIC_STRIPPED;
 		*crypt_len = IEEE80211_CCMP_HDR_LEN;
-- 
2.34.1


