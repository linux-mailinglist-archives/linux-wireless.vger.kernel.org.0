Return-Path: <linux-wireless+bounces-18811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B27A31E1D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E12160C85
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A341F9A83;
	Wed, 12 Feb 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBIDQH13"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BE271837
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339038; cv=none; b=JiEcQaZgNZB6r/Z7qngjJp/NWUeYxuhqF9R1OQGwbcPBBFpI02nHrtzVagmyq4j/k72O0sIHoppqjm77/LDSa9g1A3AdunOqG7Unl66aijGarttTl79/CvDxOUAcA36oPyV40GxJSRGAiIFtY3mncM3ooyUOJmhf36CDXbf+1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339038; c=relaxed/simple;
	bh=uuOU/w9Q8URBc95BHsJPKzYZhPuVbKZHyo6EOpexuLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMNAJuVW4Iwo8dHhXNSio/L/xqbhg/R9t4EjBnLl7KCKuRDgfeQSUmuRYXmDXdnHGHK4CbWIbApCqawWzqTdr1ESvPmfqmvHF98sdeTB/V+egSenI2gdJoO9Gh33OPGAbED6V3VxvuYDA4nRV5gaf1DKN7SBCgUoxZvNSiEEJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBIDQH13; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339037; x=1770875037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uuOU/w9Q8URBc95BHsJPKzYZhPuVbKZHyo6EOpexuLg=;
  b=GBIDQH132jb4xpRo+z3lbpe2FbMjHb63nOqiMcoX7rfK6qNiM95qQjxt
   Bz4gchQe5HwPUcfUbGbNMFkrvhqX6MoSgW8GrxAa+zjlXDQ1REELVdEKP
   8m5IYPmGH6G5LCG1lrVFI1hI1/H+RC3N/QR1nWVdAa8o161P6nrZIJRrQ
   nn7YJRMaoaITQlkMVRhXNCGGjrvOe9qBI4FIsHLVITyYKonuI+Kv9IaeL
   6zXwvoMayrQKKm+EFdoZ1GWubbBS7lJktxbqwakt2foNBR9jhBbD+Y/Xq
   mwXJJhRrcEhWy0Iw5xJ3+SZVClcZWXqBdbm5Y6VfDEKRHARMJYYavM5hX
   A==;
X-CSE-ConnectionGUID: Lpm64w4lRO2u0WCeu+3YGA==
X-CSE-MsgGUID: glL6XMNTQYuQ6gd2sy+heQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172217"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172217"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:56 -0800
X-CSE-ConnectionGUID: /pRQYPgcSR2HhzTowMF1pw==
X-CSE-MsgGUID: OvvH0Y3gTa2aYflUciX7Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893873"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/12] wifi: iwlwifi: add support for external 32 KHz clock
Date: Wed, 12 Feb 2025 07:43:27 +0200
Message-Id: <20250212073923.9aae3f74fee0.I25ae45ef02b9ea387b512f974c1f3e5367a537e5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In case the BIOS allows it, instruct the firmware to use the external 32
KHz clock.
The op mode specific implementation (i.e. reading the BIOS table) will
come in a later patch.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-context-info-gen3.h    | 8 +++++---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h            | 3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c  | 5 ++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index cd25a1b9f2ff..20563a32a21a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018, 2020-2024 Intel Corporation
+ * Copyright (C) 2018, 2020-2025 Intel Corporation
  */
 #ifndef __iwl_context_info_file_gen3_h__
 #define __iwl_context_info_file_gen3_h__
@@ -80,10 +80,12 @@ enum iwl_prph_scratch_flags {
  * enum iwl_prph_scratch_ext_flags - PRPH scratch control ext flags
  * @IWL_PRPH_SCRATCH_EXT_URM_FW: switch to URM mode based on fw setting
  * @IWL_PRPH_SCRATCH_EXT_URM_PERM: switch to permanent URM mode
+ * @IWL_PRPH_SCRATCH_EXT_32KHZ_CLK_VALID: use external 32 KHz clock
  */
 enum iwl_prph_scratch_ext_flags {
-	IWL_PRPH_SCRATCH_EXT_URM_FW	= BIT(4),
-	IWL_PRPH_SCRATCH_EXT_URM_PERM	= BIT(5),
+	IWL_PRPH_SCRATCH_EXT_URM_FW		= BIT(4),
+	IWL_PRPH_SCRATCH_EXT_URM_PERM		= BIT(5),
+	IWL_PRPH_SCRATCH_EXT_32KHZ_CLK_VALID	= BIT(8),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 021691513a57..25fb4c50e38b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -888,6 +888,7 @@ struct iwl_txq {
  * @trans_specific: data for the specific transport this is allocated for/with
  * @dsbr_urm_fw_dependent: switch to URM based on fw settings
  * @dsbr_urm_permanent: switch to URM permanently
+ * @ext_32khz_clock_valid: if true, the external 32 KHz clock can be used
  */
 struct iwl_trans {
 	bool csme_own;
@@ -916,6 +917,8 @@ struct iwl_trans {
 	u8 dsbr_urm_fw_dependent:1,
 	   dsbr_urm_permanent:1;
 
+	bool ext_32khz_clock_valid;
+
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
 	bool pm_support;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 838c426db7f0..8aa7c455bdee 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/dmi.h>
 #include "iwl-trans.h"
@@ -137,6 +137,9 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	if (trans->dsbr_urm_permanent)
 		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_URM_PERM;
 
+	if (trans->ext_32khz_clock_valid)
+		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_32KHZ_CLK_VALID;
+
 	/* Allocate prph scratch */
 	prph_scratch = dma_alloc_coherent(trans->dev, sizeof(*prph_scratch),
 					  &trans_pcie->prph_scratch_dma_addr,
-- 
2.34.1


