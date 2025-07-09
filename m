Return-Path: <linux-wireless+bounces-25110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF7AFF2A1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750965C0723
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3524635E;
	Wed,  9 Jul 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5njODEa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EF242D79
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091568; cv=none; b=Kf0Dt3L6eUQvw22RQYSyClDV9meF7OJ1frOl9hgkvzw4xd+lX9chpMn0KWtGnUqIBneO//8ZNFMAg8D3XpocarECpgY5e0L7rptr/mBctAqCQZctv9QqaAWRH59IxwuKETwU3OPP9JqV84vucVEE5vswYyY6WE4m6mC0sCqueyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091568; c=relaxed/simple;
	bh=MsmdQNvN0gUcNvjzbg/LZxInH4Z4CndcmN8P3R3djRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdfmgFX0yUxK9eNLfgxv2maLoailwjk6f+w07gtWiwBkg8LD2KPVSV6Vb9Aw08t7Uc5PxIRdH+EgsRkhad0fsFBtdr2DcTSPBzSNhboy+aEpeTG8tSsABOMVKf2myZz+C0QAawt5rJilNSjJPKmPYsX4NRWCRGdjCPyVW8v1GPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5njODEa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091566; x=1783627566;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MsmdQNvN0gUcNvjzbg/LZxInH4Z4CndcmN8P3R3djRM=;
  b=Q5njODEahgf0NF2S8r99LpGnr5bboupxctXQbFonF7ELLdc5ZY9ix0d1
   dDT7YMmg0fgydIyhW72C7XY0FvhP6GlWHBbhSb1ahqbFNPIpljSJ0UG7H
   uzxqDOj6j1yPDkUoEVlZzyS5uAg3xtTs1LDUob+br2kOyhIzEvSjoAjYC
   rf9u0smxzXGQpxhWP5Rx2wF6DQRtutrgEMjt6WniYBT1IQ9lYz0uerwsP
   Kqd0rAu0H5GRE0NpB9fpKBAwiV/3l7qNIPNmy6QNpTs2KYzyYxDDP1zJn
   yyYWuKTLzUdQswEanlKvmepREkmW//WQIYDmWIzT1/Kuz6Gx7EL9Z/EyM
   A==;
X-CSE-ConnectionGUID: cFvxyFrjQkan+idxvz7Leg==
X-CSE-MsgGUID: N0JLLJ0USf6HshdgIbg7tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240298"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240298"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:05 -0700
X-CSE-ConnectionGUID: Dp25Di2AS3aAiq8g7nlUpw==
X-CSE-MsgGUID: vJQxOHG9QRWSSTKDgI++Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160125995"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: handle non-overlapping API ranges
Date: Wed,  9 Jul 2025 23:05:29 +0300
Message-Id: <20250709200543.1628666-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The option to set an api_version_min/max also to the RF was added.
In the case that both the MAC and the RF has a range defined, we take
the narrower range of both.

This doesn't work for non-overlapping ranges. In this case, we should
just take the lower range of both.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index f62f7c7ee7f3..2dff87c07512 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -301,13 +301,17 @@ static void iwl_get_ucode_api_versions(struct iwl_trans *trans,
 	const struct iwl_family_base_params *base = trans->mac_cfg->base;
 	const struct iwl_rf_cfg *cfg = trans->cfg;
 
-	if (!base->ucode_api_max) {
+	/* if the MAC doesn't have range or if its range it higher than the RF's */
+	if (!base->ucode_api_max ||
+	    (cfg->ucode_api_max && base->ucode_api_min > cfg->ucode_api_max)) {
 		*api_min = cfg->ucode_api_min;
 		*api_max = cfg->ucode_api_max;
 		return;
 	}
 
-	if (!cfg->ucode_api_max) {
+	/* if the RF doesn't have range or if its range it higher than the MAC's */
+	if (!cfg->ucode_api_max ||
+	    (base->ucode_api_max && cfg->ucode_api_min > base->ucode_api_max)) {
 		*api_min = base->ucode_api_min;
 		*api_max = base->ucode_api_max;
 		return;
-- 
2.34.1


