Return-Path: <linux-wireless+bounces-26735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8996FB396DD
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455AC3A85E1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA052E22AF;
	Thu, 28 Aug 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWYVkJbT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2482E0910
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369606; cv=none; b=kEbUFaItTERJXvLS60prlqrTtTbvdXvQhnK9Cx1cSZbWMEKzWxrdOe4KkhgaxnCwN9p60wJe7fgpG0vHdu8pHYsIYiwHdYd9NxRpU8/1/gnnrCONo1mrtxn8Uu6NKDTx5YZyQAy7eApd55TPc2QzRkC6qQSNi97wf9Bjo5Pckg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369606; c=relaxed/simple;
	bh=BeRHRFbbj+YzeBDZntv5n6CeP3Lq+xnk2vYfFa+v4Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cx6Tl5pOp4F825S+5PmZrIkQIeRcVlScOliZLEWtaT7YWgrtX/prwrhckuBIo1rYNXOiDKyrpheiJ/pC0+uL1Xp9hcGdzxYDf5RN0veTz31BsbJtBW2054gnY/H61em/Fwl6SN9saj40F354JSJjfhDoPnXJTG5spjv6xM0G39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWYVkJbT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369605; x=1787905605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BeRHRFbbj+YzeBDZntv5n6CeP3Lq+xnk2vYfFa+v4Pw=;
  b=WWYVkJbTd9L+OOQ4YOs0E5UtcNm7i9caSPJ7w+zp5vHGpFPpqcbmacgo
   oasdNYoi7dw1jwYh8vUSI2W8+sah+xX1/5eW5RhUlIkvH89HGGcxgh2BR
   96QamYeyzNdKstt+F0ZGUx3CWZj0NJgBEW61nXp2uLrU5QG0Bp7ypKJQo
   WCSP+Uz4QVqg+IrXRSXz+hEtpIq7NYN8EPGzTNh5NvuSDbKt7mpXbCqqD
   A8WJ4FJrhoT2aZ9mKy2N7pwH+1fXyTwJwB1UXmKIS46zvJU4sjzFjkFcw
   0Q9a+eusSBWFHUdDlx8pI5w49gfruYUxf3H92IRxvSARibzYj6Gh8idHM
   Q==;
X-CSE-ConnectionGUID: z1mZ2WEKSQeSznJKz2hJDw==
X-CSE-MsgGUID: Jr4KnIZ5RPiWasn8Ba/0Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003323"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003323"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:34 -0700
X-CSE-ConnectionGUID: N591TpCISmKzTnmxGxYBcw==
X-CSE-MsgGUID: awfTPDpEQOO8THCCNU71rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224480"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: uefi: remove runtime check of constant values
Date: Thu, 28 Aug 2025 11:25:47 +0300
Message-Id: <20250828111032.cc3c17327ea2.I99c7175be1f72f29b154454fc24978daafad476f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to check an ARRAY_SIZE() at runtime, it's
already determined at build time, so could be a BUILD_BUG_ON.
However it's not that useful here since the array is defined
using UEFI_MAX_DSM_FUNCS, check DSM_FUNC_NUM_FUNCS instead to
ensure the array cannot be accessed out-of-band, i.e. ensure
the range check there is always good enough.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 48126ec6b94b..44c7c565d1c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -727,6 +727,8 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 	struct uefi_cnv_var_general_cfg *data;
 	int ret = -EINVAL;
 
+	BUILD_BUG_ON(ARRAY_SIZE(data->functions) < DSM_FUNC_NUM_FUNCS);
+
 	/* Not supported function index */
 	if (func >= DSM_FUNC_NUM_FUNCS || func == 5)
 		return -EOPNOTSUPP;
@@ -742,11 +744,6 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		goto out;
 	}
 
-	if (ARRAY_SIZE(data->functions) != UEFI_MAX_DSM_FUNCS) {
-		IWL_DEBUG_RADIO(fwrt, "Invalid size of DSM functions array\n");
-		goto out;
-	}
-
 	*value = data->functions[func];
 
 	IWL_DEBUG_RADIO(fwrt,
-- 
2.34.1


