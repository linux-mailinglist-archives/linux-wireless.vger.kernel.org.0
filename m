Return-Path: <linux-wireless+bounces-25021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8EAFDE80
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8C01C402B4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AA219A97;
	Wed,  9 Jul 2025 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxqI7ryk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893F214801
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032642; cv=none; b=ZrrjtMk02ARTYD4dNO+kktAbd9f1VxO+Jg4CA/PQW+Vk2YpOEILFxplEbFo3zI2EgfVCtLaKDOmZr6VPAgArtoNb6CMv6yv+Zn/JSxQwgJ441Cf6GBHPKn7HvWiLefOrW1wJ93pconxPaphJ/T7NVWoZEIZ2GRobJcn+nyOXj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032642; c=relaxed/simple;
	bh=rB69ARNrc11Q3qtTtsINnE8HHZT1vJ/TSsRZs89l7VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBQaOC2kmRSk2VlTdyfFdEHXAJUXe1y2FqKhMY3Cqnd73ZEmignR3eMkIiLwkZ1CETnik1GjJeKVU753bofFftvVtQTgK6IcsprQ7CahVw8L0oPuK9FwZBnmpPMCfXTjaGPCZ2tjJX+fa6PnVbq37q16tBU/6hBcgsZFiMBYPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxqI7ryk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032640; x=1783568640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rB69ARNrc11Q3qtTtsINnE8HHZT1vJ/TSsRZs89l7VI=;
  b=VxqI7ryk7h1bteuemd2DpGjkhrYx1CTJ+kXvuF7W4fOdkpNWY1yPbOA/
   myTtlLGFztkgRW0QsUovkymPGSUtgLrGzaJnDropQxHb16laMXSjwA3eg
   aGvJlyurSoVXyLGKBk53suE1rP0ddIOn58Ob3FPhx6MUU4eeL2m8kypz4
   Y9gd/9XbK3qbgQ3CaY/3KIH9UFdypKVvgxYRgPcIo6UlP9cVEbozrWWJA
   YaR18SMScGmuz858CUpNGMUR2nZWs/FwNf8Z08jm4n7GXkjBGLpTgzcN3
   QmvHSBIAZizhEWXd6h66mnzbdE1+E3ZsOZe4HcjEbmBp3GCQNaYpQrYKR
   Q==;
X-CSE-ConnectionGUID: LipsL7prTmCZU9mReCgzwg==
X-CSE-MsgGUID: +VJ/Y1iaTHGNGU7u9xTD+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720617"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720617"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:00 -0700
X-CSE-ConnectionGUID: aiZdtSQGQdacCDgbOGkfew==
X-CSE-MsgGUID: JnAR1sbsQGOTI7Cbrr85Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390533"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:43:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next v2 01/15] wifi: iwlwifi: Add an helper function for polling bits
Date: Wed,  9 Jul 2025 06:43:25 +0300
Message-Id: <20250709063858.6bbc4bccc597.Ic7a10a7f8a9a32a9a9feecaf6e3a48fa37479f2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Add iwl_poll_bits helper to simplify calls to iwl_poll_bit
for the case when the bits and mask arguments are equal.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   | 21 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  8 +++----
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |  9 ++++++--
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 21 ++++++++-----------
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |  2 +-
 5 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 2423125e5284..8087aee03d1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -676,10 +676,9 @@ static int iwl_eeprom_acquire_semaphore(struct iwl_trans *trans)
 			    CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM);
 
 		/* See if we got it */
-		ret = iwl_poll_bit(trans, CSR_HW_IF_CONFIG_REG,
-				CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM,
-				CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM,
-				IWL_EEPROM_SEM_TIMEOUT);
+		ret = iwl_poll_bits(trans, CSR_HW_IF_CONFIG_REG,
+				    CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM,
+				    IWL_EEPROM_SEM_TIMEOUT);
 		if (ret >= 0) {
 			IWL_DEBUG_EEPROM(trans->dev,
 					 "Acquired semaphore after %d tries.\n",
@@ -797,10 +796,9 @@ static int iwl_read_otp_word(struct iwl_trans *trans, u16 addr,
 
 	iwl_write32(trans, CSR_EEPROM_REG,
 		    CSR_EEPROM_REG_MSK_ADDR & (addr << 1));
-	ret = iwl_poll_bit(trans, CSR_EEPROM_REG,
-				 CSR_EEPROM_REG_READ_VALID_MSK,
-				 CSR_EEPROM_REG_READ_VALID_MSK,
-				 IWL_EEPROM_ACCESS_TIMEOUT);
+	ret = iwl_poll_bits(trans, CSR_EEPROM_REG,
+			    CSR_EEPROM_REG_READ_VALID_MSK,
+			    IWL_EEPROM_ACCESS_TIMEOUT);
 	if (ret < 0) {
 		IWL_ERR(trans, "Time out reading OTP[%d]\n", addr);
 		return ret;
@@ -993,10 +991,9 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 			iwl_write32(trans, CSR_EEPROM_REG,
 				    CSR_EEPROM_REG_MSK_ADDR & (addr << 1));
 
-			ret = iwl_poll_bit(trans, CSR_EEPROM_REG,
-					   CSR_EEPROM_REG_READ_VALID_MSK,
-					   CSR_EEPROM_REG_READ_VALID_MSK,
-					   IWL_EEPROM_ACCESS_TIMEOUT);
+			ret = iwl_poll_bits(trans, CSR_EEPROM_REG,
+					    CSR_EEPROM_REG_READ_VALID_MSK,
+					    IWL_EEPROM_ACCESS_TIMEOUT);
 			if (ret < 0) {
 				IWL_ERR(trans,
 					"Time out reading EEPROM[%d]\n", addr);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 80591809164e..47ad447b6226 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -47,8 +47,8 @@ IWL_EXPORT_SYMBOL(iwl_read32);
 
 #define IWL_POLL_INTERVAL 10	/* microseconds */
 
-int iwl_poll_bit(struct iwl_trans *trans, u32 addr,
-		 u32 bits, u32 mask, int timeout)
+int iwl_poll_bits_mask(struct iwl_trans *trans, u32 addr,
+		       u32 bits, u32 mask, int timeout)
 {
 	int t = 0;
 
@@ -61,7 +61,7 @@ int iwl_poll_bit(struct iwl_trans *trans, u32 addr,
 
 	return -ETIMEDOUT;
 }
-IWL_EXPORT_SYMBOL(iwl_poll_bit);
+IWL_EXPORT_SYMBOL(iwl_poll_bits_mask);
 
 u32 iwl_read_direct32(struct iwl_trans *trans, u32 reg)
 {
@@ -477,7 +477,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 	 * device-internal resources is supported, e.g. iwl_write_prph()
 	 * and accesses to uCode SRAM.
 	 */
-	err = iwl_poll_bit(trans, CSR_GP_CNTRL, poll_ready, poll_ready, 25000);
+	err = iwl_poll_bits(trans, CSR_GP_CNTRL, poll_ready, 25000);
 	if (err < 0) {
 		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index f4833c5fe86e..731cda1a4e66 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -23,8 +23,13 @@ static inline void iwl_clear_bit(struct iwl_trans *trans, u32 reg, u32 mask)
 	iwl_trans_set_bits_mask(trans, reg, mask, 0);
 }
 
-int iwl_poll_bit(struct iwl_trans *trans, u32 addr,
-		 u32 bits, u32 mask, int timeout);
+int iwl_poll_bits_mask(struct iwl_trans *trans, u32 addr,
+		       u32 bits, u32 mask, int timeout);
+static inline int iwl_poll_bits(struct iwl_trans *trans, u32 addr, u32 bits,
+				int timeout)
+{
+	return iwl_poll_bits_mask(trans, addr, bits, bits, timeout);
+}
 int iwl_poll_direct_bit(struct iwl_trans *trans, u32 addr, u32 mask,
 			int timeout);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 97e90cbeb6cd..4b063c2e7356 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -380,17 +380,15 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ);
 
-		ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
-				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
-				   100);
+		ret = iwl_poll_bits(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
+				    100);
 		usleep_range(10000, 20000);
 	} else {
 		iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
 
-		ret = iwl_poll_bit(trans, CSR_RESET,
-				   CSR_RESET_REG_FLAG_MASTER_DISABLED,
-				   CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
+		ret = iwl_poll_bits(trans, CSR_RESET,
+				    CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
 	}
 
 	if (ret < 0)
@@ -492,10 +490,9 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 		    CSR_HW_IF_CONFIG_REG_PCI_OWN_SET);
 
 	/* See if we got it */
-	ret = iwl_poll_bit(trans, CSR_HW_IF_CONFIG_REG,
-			   CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
-			   CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
-			   HW_READY_TIMEOUT);
+	ret = iwl_poll_bits(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
+			    HW_READY_TIMEOUT);
 
 	if (ret >= 0)
 		iwl_set_bit(trans, CSR_MBOX_SET_REG, CSR_MBOX_SET_REG_OS_ALIVE);
@@ -2354,7 +2351,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 	 * 5000 series and later (including 1000 series) have non-volatile SRAM,
 	 * and do not save/restore SRAM when power cycling.
 	 */
-	ret = iwl_poll_bit(trans, CSR_GP_CNTRL, poll, mask, 15000);
+	ret = iwl_poll_bits_mask(trans, CSR_GP_CNTRL, poll, mask, 15000);
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 8676726d789b..3af6e3b3640d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -590,7 +590,7 @@ static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
 	}
 
 	/* Wait for DMA channels to be idle */
-	ret = iwl_poll_bit(trans, FH_TSSR_TX_STATUS_REG, mask, mask, 5000);
+	ret = iwl_poll_bits(trans, FH_TSSR_TX_STATUS_REG, mask, 5000);
 	if (ret < 0)
 		IWL_ERR(trans,
 			"Failing on timeout while stopping DMA channel %d [0x%08x]\n",
-- 
2.34.1


