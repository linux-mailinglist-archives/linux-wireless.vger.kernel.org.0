Return-Path: <linux-wireless+bounces-4534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D08C877AE9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED0C1C20E95
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64710796;
	Mon, 11 Mar 2024 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4NzQA5g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC67FC1E
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138513; cv=none; b=JcOWPkRhfoBCS3Ugt4riAwWfqAMxNn+27ZOhSDKQxe8+h8g1vkAFYdeNguYGKBgYllObOxVVA2ZEV2fcfX59SeuLEl4/k9Xh3YDJ/amMfltoKwlPIfJQyDOzGMJIO8da79s1GH435COYoEDnH5IT/Ot28xgNYJZmyY0bc9fYfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138513; c=relaxed/simple;
	bh=qV+Bb3uc0msHbKljOUK+x0wYx5ksF6bSx7t2qYc3x/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmEC4yqHkIHCsY4B3HlfGKFBwHG+dMPwqkAEwv0iiUHJ4lV6DD+Fog6SUC7fTBxZoiCidAC1GBMpmV77qrThtPgXltK+0a6t7qVoqSqbJlnUUrYYgx7FXRNabJRV0X+R8byv0pHOrbGBuRppMkOF13qy9zPbWn/B5qph8kr3QPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4NzQA5g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138511; x=1741674511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qV+Bb3uc0msHbKljOUK+x0wYx5ksF6bSx7t2qYc3x/U=;
  b=Z4NzQA5gtDPHiVW1T6EBAoqTa7NAEDI79jpATZxfwSae7T2PefD01RJZ
   COOMk/uGNAIHlU+6LDyYOQUMcqJHlFnL6/LdtEadXypztroBUZklFQNRW
   a3Rbs45DoIkFb52WOFvV5QuHlXO4DKCE/Fkg5gJrn8VWWkiQLCvi4Dtqg
   ZBtRJxLQLobzuGMXBUuey/3MxpD6l5uyA7bisHfsLiZkoI92lYlT8tKip
   O1bQkiU2FKKSvEia9/4tmvaSCaScBmtx52NrYWWk0g3OXpfx1THB5gnTz
   4zPAWir5aFQ2qk7SIqv4XGCojAc7S+KcGO8mECGA6hPM1WGXGdEaIMWct
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226737"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226737"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657611"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: consider having one active link
Date: Mon, 11 Mar 2024 08:28:02 +0200
Message-Id: <20240311081938.6c50061bf69b.I05b0ac7fa7149eabaa5570a6f65b0d9bfb09a6f1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Do not call iwl_mvm_mld_get_primary_link if only one link
is active.
In that case, the sole active link should be used.

iwl_mvm_mld_get_primary_link returns -1 if only one link
is active causing a warnning.

Fixes: 8c9bef26e98b ("wifi: iwlwifi: mvm: d3: implement suspend with MLO")
Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index ca2c6d0b605e..1a235b0c5593 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1260,15 +1260,15 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (IS_ERR_OR_NULL(vif))
 		return 1;
 
-	if (ieee80211_vif_is_mld(vif) && vif->cfg.assoc) {
+	if (hweight16(vif->active_links) > 1) {
 		/*
-		 * Select the 'best' link. May need to revisit, it seems
-		 * better to not optimize for throughput but rather range,
-		 * reliability and power here - and select 2.4 GHz ...
+		 * Select the 'best' link.
+		 * May need to revisit, it seems better to not optimize
+		 * for throughput but rather range, reliability and
+		 * power here - and select 2.4 GHz ...
 		 */
-		primary_link =
-			iwl_mvm_mld_get_primary_link(mvm, vif,
-						     vif->active_links);
+		primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
+							    vif->active_links);
 
 		if (WARN_ONCE(primary_link < 0, "no primary link in 0x%x\n",
 			      vif->active_links))
@@ -1277,6 +1277,8 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		ret = ieee80211_set_active_links(vif, BIT(primary_link));
 		if (ret)
 			return ret;
+	} else if (vif->active_links) {
+		primary_link = __ffs(vif->active_links);
 	} else {
 		primary_link = 0;
 	}
-- 
2.34.1


