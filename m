Return-Path: <linux-wireless+bounces-14600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EFB9B2F68
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF78D282279
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD31D61A4;
	Mon, 28 Oct 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ7asAxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832041DA10E
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116538; cv=none; b=Wzt6544Z+Id4f5qqurnXftnLX/0cbXKk5JQV+PPfADvCFxaxyh/EEIFNLUKXAJWU74YgsIuJE5KnrikCd2RcN22HXQZ1+fi26nGCNWPPFxMRu2OgAfYWxrcUUkpSJULyES4XPV7uCPZzKfBQAUYAy+z1CTaVk3T9L8llIxiZUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116538; c=relaxed/simple;
	bh=CMbbOAmthbmXMn1749ddLBBDFumfh095jiL9J8wy3dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lg8FfvGmQx5DfZmHtt4DT2QNUImzXIZSTE6/jaqC+0phbXnS/NStfOgd92qRimJuKeIxZjrR5oLzfOUL9H93GhNiqx1jUd0U1BBH4168EBG/nafq91P44IBpvv26+i9FFzNFaPY6rk7AaYqIoehMrbUi7NNgIZIPyw5rKsBPFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZ7asAxt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116537; x=1761652537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMbbOAmthbmXMn1749ddLBBDFumfh095jiL9J8wy3dE=;
  b=VZ7asAxtnkEZtq8z50UTfAx34admEjWNXnav8qBSEeEdFGabZNP20pta
   unkjZuUemK2ykzSE7NAqOgYdGMTl6VVhD+MDBW/O6mKWLqgil2/SYyF8O
   wlmZqgSfd8qFq214brTKsRblnSYbAG87u7TFCdiGkK9kKJZo+daoKOF1j
   brpQc2rJ2BHMrNuPMUMj6wWG7vTJMRWGg6k6EEkDgdAlUkOhJRT2Kbdks
   7oBlXfSWa7RwxUFkoWkBefoFsaQ9VnI2/v3wjm+yjdeA6kFiCfXv/1hs/
   K54wOKKKlTomkzIbXPXYyt49CmPKZfG2I/RPusL66qDDpnZNJIXGiLWbk
   Q==;
X-CSE-ConnectionGUID: 6BLeYXyIQdegiaRsO2y5cg==
X-CSE-MsgGUID: g6alG3VbSiWEjTRfu3T0eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813925"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813925"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:37 -0700
X-CSE-ConnectionGUID: hqYMKuweTwimlM4HrhsOLQ==
X-CSE-MsgGUID: IMJUhK+QQIe+L/py3BehkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432642"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: don't call power_update_mac in fast suspend
Date: Mon, 28 Oct 2024 13:54:59 +0200
Message-Id: <20241028135215.2636b358c870.I36717b4cff98eaa79182e0f3b5404f71aeeaf2f9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We don't have any interface anyway.
Trying to send a command after the D3_CONFIG command is also a really
bad idea.
No harm done since this function wouldn't send anything to the firmware
anyway.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 16a9738dcdc9..84c2c87b017f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3682,8 +3682,6 @@ void iwl_mvm_fast_suspend(struct iwl_mvm *mvm)
 		IWL_ERR(mvm,
 			"fast suspend: couldn't send D3_CONFIG_CMD %d\n", ret);
 
-	WARN_ON(iwl_mvm_power_update_mac(mvm));
-
 	ret = iwl_trans_d3_suspend(mvm->trans, false, false);
 	if (ret)
 		IWL_ERR(mvm, "fast suspend: trans_d3_suspend failed %d\n", ret);
-- 
2.34.1


