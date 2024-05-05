Return-Path: <linux-wireless+bounces-7190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9B8BBF78
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940871F2172B
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50B566A;
	Sun,  5 May 2024 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4ryzrMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4363AE
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890036; cv=none; b=ZsU63s8A/TsUaRdSs000G5/09b8qhnmPewbOmGas0ysrDamunjLFPHf5yYTRHYepcGeDbrczrgNXaHVkbL+trWY8dJmy4DXLl5HpYqHgNmGSm2ogTuNXbMMcaJrBbnWKtbN3fNRVMSST6bZWQGxiroai/+MH4gOKRN9dCyiouKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890036; c=relaxed/simple;
	bh=8sWmMgvTp3Zi0vM4UfAfJKbFLP3qbMa4TyRo+uIGO7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RibJr0Wo3G+0CSANej6x+3IFV4ZXxXULbjujsWDdDJqiTI3hqUBBZaqlMUhsR4lZHI9jGntR0ZsU5rkhLjQP05cwtddGUAhTCC7zk3A5fZ7+DUZNc3xVvzY+iiV/T8P1pHmkLCuCPOyD01VjXXPGV5TPhf9BS2/Kca+tIwf+y5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4ryzrMm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890035; x=1746426035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sWmMgvTp3Zi0vM4UfAfJKbFLP3qbMa4TyRo+uIGO7E=;
  b=c4ryzrMmBj9WS+Mx1ye99FE7X61vsbE2wgS1DH5FlmszLoww+ICAQ2G1
   HxLLrPFnqoau2vsvvnUQ8HvYz4JBqdYqByauXkPtQidc7ZTsyQ5uIAku9
   HE0yPqXVdPWnxgIiCHGb9tXSehyod+4VfuGV4OyGBqho/ViVy9213fwYr
   6TmeTUc0tuEeouJp/EKTNt20tUT5UD/XXYHF1sEpklKfjIrLdi198e+qF
   Zrsp2CvaJVhg4nNpjQBGydBueCpvKRyWV3CrInOIGekgbo/yy31cc3APy
   eavQ6eZwkO2TAVPjV0X9l2jWmtHiLvVLVjYWKvK81LFr6rPWpzsy5hoCS
   w==;
X-CSE-ConnectionGUID: yToUh6KbTzSg7XIJdoItsw==
X-CSE-MsgGUID: L1mvl4XzQGScEYJfsFim0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461830"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461830"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:35 -0700
X-CSE-ConnectionGUID: zftUl2oaQ1GcsSTWYffSZg==
X-CSE-MsgGUID: Hh9KNrRiSz+nrI99FQNaqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903627"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: fix typo in debug print
Date: Sun,  5 May 2024 09:19:56 +0300
Message-Id: <20240505091420.db629302bfdc.I135e28b89fab3b614ad8758c0305834934f8c0af@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Change EMSLR to EMLSR

Fixes: 6cf7df9f013f ("wifi: iwlwifi: mvm: Add helper functions to update EMLSR status")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index db2d3f63f4e3..7db4a834569c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -916,7 +916,7 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return;
 
 	if (!(mvmvif->esr_disable_reason & reason))
-		IWL_DEBUG_INFO(mvm, "Blocking EMSLR mode. reason = 0x%x\n",
+		IWL_DEBUG_INFO(mvm, "Blocking EMLSR mode. reason = 0x%x\n",
 			       reason);
 
 	mvmvif->esr_disable_reason |= reason;
@@ -976,7 +976,7 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!(mvmvif->esr_disable_reason & reason))
 		return;
 
-	IWL_DEBUG_INFO(mvm, "Unblocking EMSLR mode. reason = 0x%x\n", reason);
+	IWL_DEBUG_INFO(mvm, "Unblocking EMLSR mode. reason = 0x%x\n", reason);
 
 	mvmvif->esr_disable_reason &= ~reason;
 
-- 
2.34.1


