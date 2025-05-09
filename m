Return-Path: <linux-wireless+bounces-22777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2FAAB1105
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0DE4C3B79
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C30428ECE2;
	Fri,  9 May 2025 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aB/6dPVX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AB28F525
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787522; cv=none; b=tdSniTOTMUwH6m1VH2Mvexr4xnHHsNJHB2jyKczCL6pZmJFldD2CMs18+hFxJCXdjQ/EmE+gFKwyWJBXaS3LO4Z3EkGutz+HsVV+8UnrBvpb7lcVf50+1F8QpZrt2WloRSdwdb6UsoaAQoIif0UCTq3lg+QyH2lRJ+6Cug3/7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787522; c=relaxed/simple;
	bh=BnNr+fweS66UWB2bqY4GZBhfJa4/OC5kh/LI8y9osMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjMOdvchwi64FCLVtXFQcOxqdy6BVahupMZYoZv90bfRDr7aAqgnFOUQDegEWAOiSHaH8gMbWZQY+6Zpf0c2Kx5xcBymvCix8/dIRFrIEmwfZdbcYywcH6XqsIspkralPyWkVQLxQYl47xz7RILnbHvkUFXcRqHiPUzoHhoy/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aB/6dPVX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787520; x=1778323520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnNr+fweS66UWB2bqY4GZBhfJa4/OC5kh/LI8y9osMA=;
  b=aB/6dPVXRLFmJbgsc9mgoHiriRwQm/LsBk6poBXF10G4kOgNgY09DqjT
   Ll5grQBEzW7++w6o0dE990UI9ENMbaj1j5zg5CIhhX6gbEfivlo+uVx2l
   LtLtgkhOQNUUroU03oDXfwz/aY65IJz9BG0UswTcCtUvLu9ne3m+PH6YV
   3b9pzC6WfGDcq9E+v1lensHuShf+v8WlzhvX05HLlncJfrds9RajD/vAF
   VaPJOqHsMx6tNvmHIiuZ6hfbVt8cMk/q/Vb3InkSr4u2sTpW5VKEPNNBc
   eloHK832QR3IAhzpOz6ZzTJ8VQM8NJ9zKf2WxVFM+6V2y3hwr+tQdtaaa
   A==;
X-CSE-ConnectionGUID: dp8+L1DgTNqm7TjZD6uxSw==
X-CSE-MsgGUID: m4JD4/g7S+ezos/qziF99Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239900"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239900"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:20 -0700
X-CSE-ConnectionGUID: E5vuZOnJT52JkE54Ez7L+w==
X-CSE-MsgGUID: wmPzRtTPR96IZqOIKEMsZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537041"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: Correct comments for cleanup functions
Date: Fri,  9 May 2025 13:44:48 +0300
Message-Id: <20250509104454.2582160-10-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Update comments to accurately reflect the purpose of the
iwl_mld_cleanup_link and iwl_cleanup_mld functions.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Message-Id: <20250509134302.a8fc74198c52.Idf31a48eceda63fc95e3e1466d27c03adcb67bff@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 40492f0974e2..86ca5b9286f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -91,7 +91,7 @@ struct iwl_mld_link {
 	struct iwl_probe_resp_data __rcu *probe_resp_data;
 };
 
-/* Cleanup function for struct iwl_mld_phy, will be called in restart */
+/* Cleanup function for struct iwl_mld_link, will be called in restart */
 static inline void
 iwl_mld_cleanup_link(struct iwl_mld *mld, struct iwl_mld_link *link)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 3eab1774cb89..1a2c44f44eff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -295,7 +295,7 @@ struct iwl_mld {
 	memset((void *)&(_ptr)->zeroed_on_hw_restart, 0, \
 	       sizeof((_ptr)->zeroed_on_hw_restart))
 
-/* Cleanup function for struct iwl_mld_vif, will be called in restart */
+/* Cleanup function for struct iwl_mld, will be called in restart */
 static inline void
 iwl_cleanup_mld(struct iwl_mld *mld)
 {
-- 
2.34.1


