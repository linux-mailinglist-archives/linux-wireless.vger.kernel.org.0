Return-Path: <linux-wireless+bounces-5052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B3D881911
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BA2B21F40
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609485C44;
	Wed, 20 Mar 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSGuqPRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92386241
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970030; cv=none; b=upYCzyD8bi616o5iuDfYwWsK2ttN5k/bPKVfJcYSEXNW6e3vS8JQiHwy1pOxpdAQ7XkDfvR1FemhFNyUIf8KV5cuKz47E0PhP34Irn6WrjEWEF/YdcVkJY3l8kjg5zjAg8sFr8YwA9v4PKWdaattkvO3zhC4ovUieYnt8Mt3oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970030; c=relaxed/simple;
	bh=g8FiyGY3evOGr5ieM0nJ3hgSbzAAhxNrCKtkQG7gUJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBPs7heAmwIA7ygJ+rAeZQfsUhfYcFfkmQwOngmGrZTR4dNUHc3IvblVRRI8jbS5ovch4Fgs6vDgM+Wnp5QKfXALDpJIIMwtVkyzIYkQ5D1COUKzWeYGrVdM0Jxl1iNdVRboO19vo1zBjx5xndHDLYbzFlivQNdsBlIt603LsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSGuqPRX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970029; x=1742506029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8FiyGY3evOGr5ieM0nJ3hgSbzAAhxNrCKtkQG7gUJE=;
  b=HSGuqPRXpu6/gfyEZP3Btkjmbs6qmhxpCg1Dz6I3b7zlJC1N5NiXixpG
   ia+fQFzdsIlxI1L2YY/ryJKCp4xb/v+vb3GP3vlrv7DNTlGJ4I/lzWwOQ
   Ycec5MqllexBS9SDEuq0+4GD1hQchk/8GfYFfgQb0hkVnIJ3YTHuKHkW+
   FLy/X4ML6+rMp+3aAgezvvXqtx29GP2LMM63YQe6OG8UUZxmZQwLubtNY
   ta9qRZRf15X7FgJXnjAhKO5uVyEHRvCA11iNsVAKWHAlWsspA/qO3+JG8
   pdhf4szFRjkjBj/soW91/JthjENmOpScoRH2ya6hON+b9nfIa2iaYiUEQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698087"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698087"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184169"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/17] wifi: iwlwifi: add support for BZ_W
Date: Wed, 20 Mar 2024 23:26:30 +0200
Message-Id: <20240320232419.40c315d51b22.I6b2b2083f8d5b4ec4119aa5b51c21b8428d96060@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

BZ_W is another member of the BZ family.
Just like BZ_U, we also need to override the STEP.
While at it, add a few missing CNVi Chip ID values.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h   |  3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 16 +++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a931277169a7..732889f96ca2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -422,6 +422,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_SC		0x48
 #define IWL_CFG_MAC_TYPE_SC2		0x49
 #define IWL_CFG_MAC_TYPE_SC2F		0x4A
+#define IWL_CFG_MAC_TYPE_BZ_W		0x4B
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 05b4001c8224..898e22e0d1ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -371,7 +371,10 @@ enum {
 #define CNVI_AUX_MISC_CHIP			0xA200B0
 #define CNVI_AUX_MISC_CHIP_MAC_STEP(_val)	(((_val) & 0xf000000) >> 24)
 #define CNVI_AUX_MISC_CHIP_PROD_TYPE(_val)	((_val) & 0xfff)
+#define CNVI_AUX_MISC_CHIP_PROD_TYPE_GL		0x910
 #define CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U	0x930
+#define CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_I	0x900
+#define CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_W	0x901
 
 #define CNVR_AUX_MISC_CHIP				0xA2B800
 #define CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM		0xA29890
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index a687c394cf07..cd2183ccbdbd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1004,6 +1004,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_fm_name),
 
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_fm_name),
+
 /* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
@@ -1128,6 +1134,7 @@ static void get_crf_id(struct iwl_trans *iwl_trans)
 {
 	u32 sd_reg_ver_addr;
 	u32 val = 0;
+	u8 step;
 
 	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		sd_reg_ver_addr = SD_REG_VER_GEN2;
@@ -1146,16 +1153,23 @@ static void get_crf_id(struct iwl_trans *iwl_trans)
 	iwl_trans->hw_cnv_id =
 		iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
 
+	/* For BZ-W, take B step also when A step is indicated */
+	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W)
+		step = SILICON_B_STEP;
+
 	/* In BZ, the MAC step must be read from the CNVI aux register */
 	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
-		u8 step = CNVI_AUX_MISC_CHIP_MAC_STEP(iwl_trans->hw_cnv_id);
+		step = CNVI_AUX_MISC_CHIP_MAC_STEP(iwl_trans->hw_cnv_id);
 
 		/* For BZ-U, take B step also when A step is indicated */
 		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(iwl_trans->hw_cnv_id) ==
 		    CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U) &&
 		    step == SILICON_A_STEP)
 			step = SILICON_B_STEP;
+	}
 
+	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ ||
+	    CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W) {
 		iwl_trans->hw_rev_step = step;
 		iwl_trans->hw_rev |= step;
 	}
-- 
2.34.1


