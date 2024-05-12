Return-Path: <linux-wireless+bounces-7543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DF8C367B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39445281012
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F1381DA;
	Sun, 12 May 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4YosLmB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1E2E85A
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516729; cv=none; b=TO21uuRA7muHq30H2atZe8Ym8GfVSe0yEjPny+aGWyVO5H8WniI/ffnU5fNKDPG5js3vgTDIGlSFMhNF8h8NE7YQynpQfeGb3aKQ9bTpDUk/xAXWW3bGGQMHYZAvySX8/LA0yS2ZUCx4qE+FJkcrW8ysxaUl6tAPuyYtFqBLFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516729; c=relaxed/simple;
	bh=wUZ6FIYCOXAu91qm9QLqM/LXYIMYjd9gnvXcyCKLCcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCDOZ6hxs5BEImGb60zT4xZ+JpCSBivwA5QKk+E+dqoV29qNOGQw+vM4OsF/MVGIM+wc6yR/f2VghQTVy6r84YG19+MxoeCyOVmhrDFJBmVl7/0wE+yRUQhhOHCz2CbTKrHYKJVhMGo0Ep+mSd21IeXnzyjlgc2hfFXL26shUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4YosLmB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516727; x=1747052727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUZ6FIYCOXAu91qm9QLqM/LXYIMYjd9gnvXcyCKLCcs=;
  b=e4YosLmBv7YnpCXdg0SNScE0zQZKuQMNk88A9SxlInpgaDdWQdg5t02/
   JYQs/E/bSq+WpFOtJvgFtdYOGek3AERW2Yuc/SyU4c7DyTww/I7zSTxB8
   LAdTHIYHuQjPRWGEeIaFKm0meDhXlY1W65ZUICMpgYvA3Br+xKiyEmzKZ
   K/WEXexRQuhXHixSi/cqtKpsUy3Cj1dKltEUdz2d7hdTJ6bhJT1S+2vfB
   AasTfapshQcS9r95EcXxICsUbP+eSzDnWzp/GoFW51EfnsxWHPBoiYJD0
   Lec/iRE+xyN5cM5V0bKAF+fkLKSsMmwnlqVjAFPmBafEGOFLHEwvISC79
   Q==;
X-CSE-ConnectionGUID: x+RkkgQQRKuczQwesrVmtw==
X-CSE-MsgGUID: BRlguBJ7Rm6rvSbTjPeT2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397207"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397207"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:27 -0700
X-CSE-ConnectionGUID: oh7MXoQuSAKIqVGgSUdqKA==
X-CSE-MsgGUID: D+ESURsPQiaihdaRStzbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761330"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: mvm: check n_ssids before accessing the ssids
Date: Sun, 12 May 2024 15:25:01 +0300
Message-Id: <20240512152312.9b2ae544edc9.I5a0e6cc8f02050a766db704d15594c61fe583d45@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
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
index f81a9b7099be..9be812a40fd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1313,7 +1313,7 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		if (IWL_MVM_ADWELL_MAX_BUDGET)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-		else if (params->ssids && params->ssids[0].ssid_len)
+		else if (params->n_ssids && params->ssids[0].ssid_len)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 		else
@@ -1418,7 +1418,7 @@ iwl_mvm_scan_umac_dwell_v11(struct iwl_mvm *mvm,
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


