Return-Path: <linux-wireless+bounces-4539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B6877AEE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD361F214CE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298912B7F;
	Mon, 11 Mar 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udje12b/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17B125C4
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138522; cv=none; b=ngO+fJgb5Il7R3dy043bTmblskbzWnI2HQ87VyF+amWA1vwHjQ4Qy6z66/LNZPzOe32MTHOsbi+SVVnfC4IrilEf42ty/6bEoYeIC/h6gHLD+QtU5r+r7dCeAP1xtApueYVTMfEwkQUCdBzYW1ML4FRusG5b/BopEbLlato2iFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138522; c=relaxed/simple;
	bh=S+FfkztgZzer9BPUi8rHwdb0h0Gd9Qd5J7lhoJnMzcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQzwjOKUvMKnRsDA/cdfo6Sm42bK1nJ6QenUvONM1XxjmD3fZS8UohXUIz4kE+0tcCeYh94XtJ+3ILXHrKz4crnEXCq9yzYP9YhRZTkTwvSU4x8OsjeGflVLEIXOSnMLh+aMmQ8GBsnP6nLfXg2uoiu8QbTTyriPafHxUFQG6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udje12b/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138521; x=1741674521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S+FfkztgZzer9BPUi8rHwdb0h0Gd9Qd5J7lhoJnMzcw=;
  b=Udje12b/clm07MbeX0RBbb9rgzogSEcPiEXVFWyJO1SZ9NrjYH51/umL
   Fv6wy5+3k1m90Y+2YRdN6XyiC+dIDenxFe7PqZq5WzV8UQXS0FShraDfE
   FBSFBHQxwR4DbasVppM8oOktNxayeDkK+boZk4mOyJIBOZ+jaGltxOsXn
   jdExuqijrmBJB71dbkK7zZuSXNXgoHVYY7hJh+ptPk2acaGdi/eEnsBDj
   DZUvsOBhxRIrFrGFkFIP5q51Gquh+UVWySaf2KbzaJRIqp63k+Ajuem/x
   XlCgMYnhDZZmvMf46DePHUCMm2fs048FRd41gWcRAkfSHgzeSrp98fSW+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226766"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226766"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657673"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: stop assuming sta id 0 in d3
Date: Mon, 11 Mar 2024 08:28:07 +0200
Message-Id: <20240311081938.6379619f2987.I83de9d868224df76eee8df8dbcf352636535821a@changeid>
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

In MLO, the station id in d3 can be other than 0.
Do not assume the station id is 0 when waking
up from d3.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d3dda2678cc8..5ee27e268295 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2547,6 +2547,12 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	int i;
 	bool keep = false;
 	struct iwl_mvm_sta *mvm_ap_sta;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
+	struct iwl_mvm_vif_link_info *mvm_link = mvmvif->link[link_id];
+
+	if (WARN_ON(!mvm_link))
+		goto out_unlock;
 
 	if (!status)
 		goto out_unlock;
@@ -2554,8 +2560,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	IWL_DEBUG_WOWLAN(mvm, "wakeup reason 0x%x\n",
 			 status->wakeup_reasons);
 
-	/* still at hard-coded place 0 for D3 image */
-	mvm_ap_sta = iwl_mvm_sta_from_staid_protected(mvm, 0);
+	mvm_ap_sta = iwl_mvm_sta_from_staid_protected(mvm, mvm_link->ap_sta_id);
 	if (!mvm_ap_sta)
 		goto out_unlock;
 
-- 
2.34.1


