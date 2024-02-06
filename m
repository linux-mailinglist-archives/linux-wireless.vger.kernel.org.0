Return-Path: <linux-wireless+bounces-3235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C9684BA85
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E128E80C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04513474A;
	Tue,  6 Feb 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qtcjh/1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F1134CEB
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235355; cv=none; b=ky9vpvPXs+Kv2h9hl+oGVWAXT/snI3gy4ysEmsOERN8Yk9Nh7UvB10NbEavI6F20eqHbk40C9obZMgz4cLMyHbz2bgYvDx1v73u9Ub5g30fa4o831Bd6ffy1E1yu94ni5LfmVJEg911/mJk1r5GvXzjUzrvN0cIVZaObKpd/02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235355; c=relaxed/simple;
	bh=kKfgfmzfnl77cRk4pYzIwbHdKBT/BVMxYylXDp7Vhgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shsaUHrN6myuoLMm/CNeW2hq/3DMO5P3vNbiW7pDyMkFuC1+/qAyiQfC8T1pOGOJUanUNOKWVlbG2VUs5FCNoitEdFkgZiUKKIIvoNo9+fUBQYrkE7C+Yd7YFe/vIGfQcSr/M7idQj0yeO6c003alfAKduA0rATF10myFlTnr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qtcjh/1F; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235355; x=1738771355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kKfgfmzfnl77cRk4pYzIwbHdKBT/BVMxYylXDp7Vhgw=;
  b=Qtcjh/1Fd0mnm6U+Z3lLu5exLy62mOszYGYysXbRRftU0mgSJkh7m8w5
   E4vPJs2dFYpVkUAa5eRxin77AhsWRIFWCWPeizLTT+m41D6Cvfwoz0KaZ
   sP1S8JLPYm8GchG+cg3INOYBi6nAB2a87EkM8niIn32/Oyic8rMdKqyFn
   GDfc2e5Eq6iu4ovKdHWO2uB3hLVrPoOZ0mPVrKq1tcmiwGeuRoplSWutZ
   bU199jWwdwrfx5gtpo8HlGUq5SsM0/CtWH0Qv0dGJVTjCYdb+1rv6D8an
   mbxL5O2HszS56FDPJWuCzDhjHzTVfW2MkpxQTvJEc7g4T/lTsEiekd/lN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252318"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252318"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349827"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/11] wifi: iwlwifi: mvm: don't send the smart fifo command if not needed
Date: Tue,  6 Feb 2024 18:02:07 +0200
Message-Id: <20240206175739.527595995aa0.I0381bef1dc815945f2ec194fecc657e5c75bb2ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Newer firmware versions no longer needs this command. Don't send it if
the firmware advertises it does not need it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c  | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b7ef0882dbad..08d9aeaedd99 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2008-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2008-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -247,6 +247,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	logic.
  * @IWL_UCODE_TLV_API_INT_DBG_BUF_CLEAR: Firmware supports clearing the debug
  *	internal buffer
+ * @IWL_UCODE_TLV_API_SMART_FIFO_OFFLOAD: Firmware doesn't need the host to
+ *	configure the smart fifo
  *
  * @NUM_IWL_UCODE_TLV_API: number of bits used
  */
@@ -287,6 +289,7 @@ enum iwl_ucode_tlv_api {
 	/* API Set 2 */
 	IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX	= (__force iwl_ucode_tlv_api_t)66,
 	IWL_UCODE_TLV_API_INT_DBG_BUF_CLEAR     = (__force iwl_ucode_tlv_api_t)67,
+	IWL_UCODE_TLV_API_SMART_FIFO_OFFLOAD    = (__force iwl_ucode_tlv_api_t)68,
 
 	NUM_IWL_UCODE_TLV_API
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
index 30d4233595e8..16285ae7cae9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2013-2014, 2018-2019, 2022-2023 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2019, 2022-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #include "mvm.h"
@@ -232,6 +232,9 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 	};
 	struct ieee80211_sta *sta = NULL;
 
+	if (fw_has_api(&mvm->fw->ucode_capa,
+		       IWL_UCODE_TLV_API_SMART_FIFO_OFFLOAD))
+		return 0;
 	/*
 	 * Ignore the call if we are in HW Restart flow, or if the handled
 	 * vif is a p2p device.
-- 
2.34.1


