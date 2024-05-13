Return-Path: <linux-wireless+bounces-7586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450398C3EE0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D181C22976
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93B14A61B;
	Mon, 13 May 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJhhCN8b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41614A0A6
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596049; cv=none; b=aE16wsQr8PdTeGKDgXrknH1oCNXCAY9ezbCi1djd6mlDbIhREO32NBp90qOza68QF/DIhQk+sTkj77vQD7TD/0MKQY7ZCMH1Eawg9Qu8sUbBcARIdXNspj4qEKA4Ajt4FfbUl9XHQgfe0CHI9bS4fXl2iNANFaOyfAJXSCcwcPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596049; c=relaxed/simple;
	bh=RKKWcwljq5xkvx8k3QVlHrC1gZJe/YGB0AlWBmV5/Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g111XZ8QVaOxE5/5VqIiTBtzd1dfJ8koA1834hkzP3bc43R3ZrnT0CfmzGXQF4/HO4ovqPE924yRFF24G+KyzCkHASPRfTaupG4cknYJoN4r189R8Dlc2TP6a+K/eHBPMLYvFMZNCLrNIYuVqD4v5AaQ7PlwITTG8bJYkgF3udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJhhCN8b; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596049; x=1747132049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKKWcwljq5xkvx8k3QVlHrC1gZJe/YGB0AlWBmV5/Pw=;
  b=cJhhCN8br9sRgwT3tbpunNnr7JqU/uUupFMMgCKeit2kTdFsHYJFhj2c
   tl8eiWzW+oqZuSotm4lZtxPZAv82kNp1CDkF9tuoV2kfbqMz8ToQMglZJ
   FGLGUFGz05WvL1fBjfbIZ1hXfPfkdLDqHSHttTJdcTW930Fh0lSXtsCt3
   oH47WrbCtBtna05mIJ7u+EsRWJnXc+ohFb5c8qeOmFC5JAhvhZeCn+IMt
   uIBJ66TkiIMHlR2RNH7bKeaM596Zeoc3qrwjvCIP/wzL4XuFzzdeBB+5F
   q13Ym+KxS/xqPKKJ6QxlPls/2jxePa3ra4bfwZue3ATAORh1fzaSy2ujr
   w==;
X-CSE-ConnectionGUID: dtEqSW34QPmlhwP1v95hQg==
X-CSE-MsgGUID: RF/88QhkSniIxzvpONx03A==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928665"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928665"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:28 -0700
X-CSE-ConnectionGUID: XTV8vse9S7evLT3LIFBx0A==
X-CSE-MsgGUID: Z5U6lY62TN2LpMQiihkmhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516416"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/7] wifi: iwlwifi: mvm: check n_ssids before accessing the ssids
Date: Mon, 13 May 2024 13:27:12 +0300
Message-Id: <20240513132416.6e4d1762bf0d.I5a0e6cc8f02050a766db704d15594c61fe583d45@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
References: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In some versions of cfg80211, the ssids poinet might be a valid one even
though n_ssids is 0. Accessing the pointer in this case will cuase an
out-of-bound access. Fix this by checking n_ssids first.

Fixes: c1a7515393e4 ("iwlwifi: mvm: add adaptive dwell support")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 85d8cbe6d248..bed2cd81f8b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1303,7 +1303,7 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		if (IWL_MVM_ADWELL_MAX_BUDGET)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-		else if (params->ssids && params->ssids[0].ssid_len)
+		else if (params->n_ssids && params->ssids[0].ssid_len)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 		else
@@ -1405,7 +1405,7 @@ iwl_mvm_scan_umac_dwell_v11(struct iwl_mvm *mvm,
 	if (IWL_MVM_ADWELL_MAX_BUDGET)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-	else if (params->ssids && params->ssids[0].ssid_len)
+	else if (params->n_ssids && params->ssids[0].ssid_len)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 	else
-- 
2.34.1


