Return-Path: <linux-wireless+bounces-8133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3878D085D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857CBB2BE18
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DB16B731;
	Mon, 27 May 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YusfDqz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37C16B727
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826013; cv=none; b=ZOCr3R7sJXAsloBnmjAjYe0mZU6PR5SViYqWOouuWE/N9YUg/U5mJRxjteQFuvzlVuBiII/mbAC6kDnIY7mr7UncLszDDh91soU0kvUJKeoRvh+Eu7BerOMpeWo6GbcVJab3DN5e/80SQ53+R/XhB+xb/RCy1Vng7qQtM2Z+hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826013; c=relaxed/simple;
	bh=VYlpb+ivOvVn1+IXaKIeNqkqT/zhRp+RvXuzt/zNjxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miMmK9Fmq0JR87LwDDMR1ToGgY3YZHIX0nwiF46PgwDZuAMeGe1AcKmpfXGyVIfpM5+JvWoaKRss8Ul5vlnT6JDJvkdXoyBI3kPgEe9Eh6K8CNReURHBZrBzkryNvyhAXRDfKQyvWUecBl5zYGD/EQ3u/asDnSLIdpYZVTZTvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YusfDqz+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826012; x=1748362012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYlpb+ivOvVn1+IXaKIeNqkqT/zhRp+RvXuzt/zNjxI=;
  b=YusfDqz+SHDgdy39q1Q5Wo27cixeebZU2tUgknLv6lNNsnVnfF9fgJzs
   30UeYvQXqcmIA/X6RBSrW8Qcip41t8h6/Ssv5hRc4j8UESWF2Xc6KbZmj
   Lj3Vgc6z13F9DtqG5KKuWeSgZK9OsvJWwgdcy53dTn5G4AlPFqOknT9ML
   X9PUEWszaDEdp5tLToZBdUMtmK4iXpc9J+AfOIoezqvisUhUDxkLW9kf9
   /R2+cEPKtdzu2IVMENF0HlUg9oQqR+c7vj3HwZVFr+no1JJtc+74Fp0wT
   hHdQrHQ6NGBN/hAePeSe1pboO3RprfH4Qufzjm+gjqfTbMNrtUboJ5Kmi
   g==;
X-CSE-ConnectionGUID: 3gc2mR7FRqeNKN1ajzhx+w==
X-CSE-MsgGUID: m5+rlaYfSeODPRNmElDbxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002124"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002124"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:52 -0700
X-CSE-ConnectionGUID: zcVdLBvtTFeaU+hksGz6mw==
X-CSE-MsgGUID: 4KUFG3iNSIerSQTMfildOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407147"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/20] wifi: iwlwifi: move amsdu_size parsing to iwlwifi
Date: Mon, 27 May 2024 19:06:14 +0300
Message-Id: <20240527190228.a3430d32923d.Iab3c22ef0df685f72f22dafc47021f0dc7bd6fa5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The code that is parsing the amsdu_size module parameter and mapping it
to the corresponding Rx buffer size is common to all opmodes.
Move it into a function in iwlwifi, as preparation to a new op mode we
are working on.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-modparams.h    | 21 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 19 +----------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index 1cf26ab4f488..21eabfc3ffc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022, 2024 Intel Corporation
  */
 #ifndef __iwl_modparams_h__
 #define __iwl_modparams_h__
@@ -106,4 +106,23 @@ static inline bool iwl_enable_tx_ampdu(void)
 	return true;
 }
 
+/* Verify amsdu_size module parameter and convert it to a rxb size */
+static inline enum iwl_amsdu_size
+iwl_amsdu_size_to_rxb_size(void)
+{
+	switch (iwlwifi_mod_params.amsdu_size) {
+	case IWL_AMSDU_8K:
+		return IWL_AMSDU_8K;
+	case IWL_AMSDU_12K:
+		return IWL_AMSDU_12K;
+	default:
+		pr_err("%s: Unsupported amsdu_size: %d\n", KBUILD_MODNAME,
+		       iwlwifi_mod_params.amsdu_size);
+		fallthrough;
+	case IWL_AMSDU_DEF:
+	case IWL_AMSDU_4K:
+		return IWL_AMSDU_4K;
+	}
+}
+
 #endif /* #__iwl_modparams_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ed9487062093..85178fe1b7ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1373,24 +1373,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
 	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
-	switch (iwlwifi_mod_params.amsdu_size) {
-	case IWL_AMSDU_DEF:
-		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
-		break;
-	case IWL_AMSDU_4K:
-		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
-		break;
-	case IWL_AMSDU_8K:
-		trans_cfg.rx_buf_size = IWL_AMSDU_8K;
-		break;
-	case IWL_AMSDU_12K:
-		trans_cfg.rx_buf_size = IWL_AMSDU_12K;
-		break;
-	default:
-		pr_err("%s: Unsupported amsdu_size: %d\n", KBUILD_MODNAME,
-		       iwlwifi_mod_params.amsdu_size);
-		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
-	}
+	trans_cfg.rx_buf_size = iwl_amsdu_size_to_rxb_size();
 
 	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
-- 
2.34.1


