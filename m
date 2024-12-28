Return-Path: <linux-wireless+bounces-16845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D59FDC2D
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D81216151F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4578F5B;
	Sat, 28 Dec 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGf2Xv45"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1D198A0D
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418080; cv=none; b=g0A6NdVG3SpxcGn2gWGKR+h2JsEXd6WLBUK1B+YmUYeyDGGHzn/+BCK6uRZKciadTzCIexMRSchagkC75sJEWXr3XmsCqxbh4HlfzWp+BYQRhEggcZhjmKa/hxLIovEB7/Er5nQIRpYVAz+H1cy4+xNhTgFIyxS13bgxL/YzoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418080; c=relaxed/simple;
	bh=dKI7gOaNuFnmLluch8bgiP13d1AyP0C6Af2sRm1ZaDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZE3u4S8r7ATtC9LkuRR+kUpN2HK/AkR3b2upZLTyAVSq+UmfZXMSOOiMpjzhcVuahhuikq15OXFDWcNf7b9UK2zWefYOxtqgw9SnfI8P8fjMOVlLl5FzhhMvzZXgkdZsebTgqpqegZ6jjzXEIEgkRkCxAdTB35WxvGZSrOvk3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGf2Xv45; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418078; x=1766954078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dKI7gOaNuFnmLluch8bgiP13d1AyP0C6Af2sRm1ZaDw=;
  b=ZGf2Xv45Ri97hjhhXfCshIy9O6oyMP5YExUCn24wdgUQ0dfGLUzMI6EJ
   iohufNQ0kfNvfA+FUSCQZQbNO52gasFqTNe+x5mAnbYD0A8paK9I4YUk4
   W0Hf/e1J0FDNgGvoVp+zO1H9I8vlSDP0UlJ+tKD8HvavmQ+2oq3YeOOk3
   frv43CVhPOjh78cEQeU4HxAIMcs4doEAD5xzndRkc1/7D03tBS18d6ioa
   hLbAes6eGhkDfMdXNlP85+azKtoKu1OELA4Iwx5TyX6vqw22fUF3Om4+v
   kfunPq+Anj+8jocybme60bGyfIo8Cj1WT47NDNyJ67CXz/Sxzj35QOgNH
   A==;
X-CSE-ConnectionGUID: pyeUcCrWTqy4zNG5GPM21Q==
X-CSE-MsgGUID: HMct4hCETPmxqVGtadoX7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479754"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479754"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:38 -0800
X-CSE-ConnectionGUID: Qyf49ZOtRMOrzoqjgw3dvA==
X-CSE-MsgGUID: HRhoB17WR4KwobFibcdNHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488363"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: rename bits in config/boot control register
Date: Sat, 28 Dec 2024 22:34:07 +0200
Message-Id: <20241228223206.6f25be160619.I3ffc9601e99dc414a9ae54a0d90c9d20c0253da5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The register 0x000 is now really boot control, and some
of the old bit names were (even for old hardware) not
reflecting the names on the hardware side; rename them
in the driver to align the naming.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c    |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h   | 15 ++++++++-------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c   |  6 +++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c    | 18 +++++++++---------
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 931aa3f5798d..cdc05f7e75a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -676,12 +676,12 @@ static int iwl_eeprom_acquire_semaphore(struct iwl_trans *trans)
 	for (count = 0; count < IWL_EEPROM_SEM_RETRY_LIMIT; count++) {
 		/* Request semaphore */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-			    CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM);
+			    CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM);
 
 		/* See if we got it */
 		ret = iwl_poll_bit(trans, CSR_HW_IF_CONFIG_REG,
-				CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM,
-				CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM,
+				CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM,
+				CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM,
 				IWL_EEPROM_SEM_TIMEOUT);
 		if (ret >= 0) {
 			IWL_DEBUG_EEPROM(trans->dev,
@@ -697,7 +697,7 @@ static int iwl_eeprom_acquire_semaphore(struct iwl_trans *trans)
 static void iwl_eeprom_release_semaphore(struct iwl_trans *trans)
 {
 	iwl_clear_bit(trans, CSR_HW_IF_CONFIG_REG,
-		      CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM);
+		      CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM);
 }
 
 static int iwl_eeprom_verify_signature(struct iwl_trans *trans, bool nvm_is_otp)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 98563757ce2c..c2cd5c24646b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -167,13 +167,14 @@
 #define CSR_HW_IF_CONFIG_REG_POS_PHY_DASH	(12)
 #define CSR_HW_IF_CONFIG_REG_POS_PHY_STEP	(14)
 
-#define CSR_HW_IF_CONFIG_REG_BIT_HAP_WAKE_L1A	(0x00080000)
-#define CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM	(0x00200000)
-#define CSR_HW_IF_CONFIG_REG_BIT_NIC_READY	(0x00400000) /* PCI_OWN_SEM */
-#define CSR_HW_IF_CONFIG_REG_BIT_NIC_PREPARE_DONE (0x02000000) /* ME_OWN */
-#define CSR_HW_IF_CONFIG_REG_PREPARE		  (0x08000000) /* WAKE_ME */
-#define CSR_HW_IF_CONFIG_REG_ENABLE_PME		  (0x10000000)
-#define CSR_HW_IF_CONFIG_REG_PERSIST_MODE	  (0x40000000) /* PERSISTENCE */
+#define CSR_HW_IF_CONFIG_REG_HAP_WAKE			0x00080000
+/* NOTE: EEPROM_OWN_SEM is no longer defined for new HW */
+#define CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM		0x00200000
+#define CSR_HW_IF_CONFIG_REG_PCI_OWN_SET		0x00400000
+#define CSR_HW_IF_CONFIG_REG_ME_OWN			0x02000000
+#define CSR_HW_IF_CONFIG_REG_WAKE_ME			0x08000000
+#define CSR_HW_IF_CONFIG_REG_WAKE_ME_PCIE_OWNER_EN	0x10000000
+#define CSR_HW_IF_CONFIG_REG_PERSISTENCE		0x40000000
 
 #define CSR_MBOX_SET_REG_OS_ALIVE		BIT(5)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 5f6cd60b50b9..3677e0154888 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -43,7 +43,7 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 	 * wake device's PCI Express link L1a -> L0s
 	 */
 	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-		    CSR_HW_IF_CONFIG_REG_BIT_HAP_WAKE_L1A);
+		    CSR_HW_IF_CONFIG_REG_HAP_WAKE);
 
 	iwl_pcie_apm_config(trans);
 
@@ -68,8 +68,8 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 		iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 			    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-			    CSR_HW_IF_CONFIG_REG_PREPARE |
-			    CSR_HW_IF_CONFIG_REG_ENABLE_PME);
+			    CSR_HW_IF_CONFIG_REG_WAKE_ME |
+			    CSR_HW_IF_CONFIG_REG_WAKE_ME_PCIE_OWNER_EN);
 		mdelay(1);
 		iwl_clear_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 			      CSR_RESET_LINK_PWR_MGMT_DISABLED);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 86f1d87a909c..053f0ac756be 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -311,7 +311,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	 * wake device's PCI Express link L1a -> L0s
 	 */
 	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-		    CSR_HW_IF_CONFIG_REG_BIT_HAP_WAKE_L1A);
+		    CSR_HW_IF_CONFIG_REG_HAP_WAKE);
 
 	iwl_pcie_apm_config(trans);
 
@@ -439,7 +439,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	 * SHRD_HW_RST is applied in S3.
 	 */
 	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-		    CSR_HW_IF_CONFIG_REG_PERSIST_MODE);
+		    CSR_HW_IF_CONFIG_REG_PERSISTENCE);
 
 	/*
 	 * Clear "initialization complete" bit to move adapter from
@@ -508,8 +508,8 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 				    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 			iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-				    CSR_HW_IF_CONFIG_REG_PREPARE |
-				    CSR_HW_IF_CONFIG_REG_ENABLE_PME);
+				    CSR_HW_IF_CONFIG_REG_WAKE_ME |
+				    CSR_HW_IF_CONFIG_REG_WAKE_ME_PCIE_OWNER_EN);
 			mdelay(1);
 			iwl_clear_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 				      CSR_RESET_LINK_PWR_MGMT_DISABLED);
@@ -581,12 +581,12 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 	int ret;
 
 	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-		    CSR_HW_IF_CONFIG_REG_BIT_NIC_READY);
+		    CSR_HW_IF_CONFIG_REG_PCI_OWN_SET);
 
 	/* See if we got it */
 	ret = iwl_poll_bit(trans, CSR_HW_IF_CONFIG_REG,
-			   CSR_HW_IF_CONFIG_REG_BIT_NIC_READY,
-			   CSR_HW_IF_CONFIG_REG_BIT_NIC_READY,
+			   CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
+			   CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
 			   HW_READY_TIMEOUT);
 
 	if (ret >= 0)
@@ -620,7 +620,7 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-			    CSR_HW_IF_CONFIG_REG_PREPARE);
+			    CSR_HW_IF_CONFIG_REG_WAKE_ME);
 
 		do {
 			ret = iwl_pcie_set_hw_ready(trans);
@@ -1566,7 +1566,7 @@ int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
 	if (!reset)
 		/* Enable persistence mode to avoid reset */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-			    CSR_HW_IF_CONFIG_REG_PERSIST_MODE);
+			    CSR_HW_IF_CONFIG_REG_PERSISTENCE);
 
 	ret = iwl_pcie_d3_handshake(trans, true);
 	if (ret)
-- 
2.34.1


