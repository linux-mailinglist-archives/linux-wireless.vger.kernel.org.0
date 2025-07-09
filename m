Return-Path: <linux-wireless+bounces-25117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF837AFF2A8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB43E1C82C61
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A92641F3;
	Wed,  9 Jul 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCvrYQHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAE2512C3
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091575; cv=none; b=J0MlnpEvEL0IihwXKJys0nyFPGZIJBllzZddTiC3BrrdnILP9+3c/d6oKpfpKMT2pSrE+Rt2pLtEE3y/p2szNFyTubr4nv8TKKHGPBbrhICgp/YTIjpOqkW/NUGg48jgWnfQ66maMwBKEe2KXn0XLFB2zl4KqGh9fHarY3tMmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091575; c=relaxed/simple;
	bh=Vu/z1OC6dHMWY0Ze20WBfBzt4GqR50DgNCF9Yq/uI2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRTUS7+57YEysGEm9Ht2hq4RNw508plU+UdN0sb0fwIcKDwKdQ8FmYNX7Bs/2v1aMPVbdu7AyLDfa3KVYMvVx8jNf1iK2Z9bGLb45CdQaVbD6mT2xMmbbuxd32d1peoEbsukGTuC+HDHYGtMRp3sEjNtpYnKpLRxvsu06Xs+vYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCvrYQHA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091573; x=1783627573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vu/z1OC6dHMWY0Ze20WBfBzt4GqR50DgNCF9Yq/uI2Y=;
  b=nCvrYQHAWnZe7fa62ZgKrwcsE8eTESRryiI8d9u82vuLyeIMTvUyrlVm
   ZsQLq47MnzEyWFZZEX6r/Z6DcdjahnU+PXb/DtuKlPQ6cWFvZ5CwXYuR7
   qZnG/w64OWJ4ovd/OAHdIcHTYnQTadmSNXsB/AVwIp/o8hzhzUNHQD4G/
   77WixeZCI0DGYqQS+E6AyJNWig62Dh2c7BTA2z68RgtMqtIiWIyVIVaHw
   tpDayeodWA8zqDR6a/bxP0kfqjlL1KYogLX/n7uz/Q/6JX1CkvGxWbcHk
   tQ+eJecMzADQd8HaV5MnWIfuRuRcvBv7Lo2h0sY4stWjOB/N8JWywS5F/
   A==;
X-CSE-ConnectionGUID: OFg7RInvQWybXEsVeZuHDQ==
X-CSE-MsgGUID: B8m6n1CARHyudC/k5UUMcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240309"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240309"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:13 -0700
X-CSE-ConnectionGUID: 3feAKjEiSXO5v8KTz8R1cw==
X-CSE-MsgGUID: Y6poqN3QRBuAO6sCoEPV9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126054"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: simplify iwl_poll_bits_mask return value
Date: Wed,  9 Jul 2025 23:05:36 +0300
Message-Id: <20250709230308.f77b9f484a78.Iae8ef99a94e25c23044e2c36244cda2b55328447@changeid>
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

From: Itamar Shalev <itamar.shalev@intel.com>

Update iwl_poll_bits_mask to return 0 on success or an error code.
Remove timing information from the return value, as it is unused.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c      | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/iwl-io.c          |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c   | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c  |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 8087aee03d1c..9f8cdb027839 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -679,11 +679,11 @@ static int iwl_eeprom_acquire_semaphore(struct iwl_trans *trans)
 		ret = iwl_poll_bits(trans, CSR_HW_IF_CONFIG_REG,
 				    CSR_HW_IF_CONFIG_REG_EEPROM_OWN_SEM,
 				    IWL_EEPROM_SEM_TIMEOUT);
-		if (ret >= 0) {
+		if (!ret) {
 			IWL_DEBUG_EEPROM(trans->dev,
 					 "Acquired semaphore after %d tries.\n",
 					 count+1);
-			return ret;
+			return 0;
 		}
 	}
 
@@ -799,7 +799,7 @@ static int iwl_read_otp_word(struct iwl_trans *trans, u16 addr,
 	ret = iwl_poll_bits(trans, CSR_EEPROM_REG,
 			    CSR_EEPROM_REG_READ_VALID_MSK,
 			    IWL_EEPROM_ACCESS_TIMEOUT);
-	if (ret < 0) {
+	if (ret) {
 		IWL_ERR(trans, "Time out reading OTP[%d]\n", addr);
 		return ret;
 	}
@@ -941,14 +941,14 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 		return -ENOMEM;
 
 	ret = iwl_eeprom_verify_signature(trans, nvm_is_otp);
-	if (ret < 0) {
+	if (ret) {
 		IWL_ERR(trans, "EEPROM not found, EEPROM_GP=0x%08x\n", gp);
 		goto err_free;
 	}
 
 	/* Make sure driver (instead of uCode) is allowed to read EEPROM */
 	ret = iwl_eeprom_acquire_semaphore(trans);
-	if (ret < 0) {
+	if (ret) {
 		IWL_ERR(trans, "Failed to acquire EEPROM semaphore.\n");
 		goto err_free;
 	}
@@ -994,7 +994,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 			ret = iwl_poll_bits(trans, CSR_EEPROM_REG,
 					    CSR_EEPROM_REG_READ_VALID_MSK,
 					    IWL_EEPROM_ACCESS_TIMEOUT);
-			if (ret < 0) {
+			if (ret) {
 				IWL_ERR(trans,
 					"Time out reading EEPROM[%d]\n", addr);
 				goto err_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 47ad447b6226..ad857a05d3c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -54,7 +54,7 @@ int iwl_poll_bits_mask(struct iwl_trans *trans, u32 addr,
 
 	do {
 		if ((iwl_read32(trans, addr) & mask) == (bits & mask))
-			return t;
+			return 0;
 		udelay(IWL_POLL_INTERVAL);
 		t += IWL_POLL_INTERVAL;
 	} while (t < timeout);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 585d845b53fa..327366bf87de 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -392,7 +392,7 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 				    CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
 	}
 
-	if (ret < 0)
+	if (ret)
 		IWL_WARN(trans, "Master Disable Timed Out, 100 usec\n");
 
 	IWL_DEBUG_INFO(trans, "stop master\n");
@@ -495,10 +495,10 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 			    CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
 			    HW_READY_TIMEOUT);
 
-	if (ret >= 0)
+	if (!ret)
 		iwl_set_bit(trans, CSR_MBOX_SET_REG, CSR_MBOX_SET_REG_OS_ALIVE);
 
-	IWL_DEBUG_INFO(trans, "hardware%s ready\n", ret < 0 ? " not" : "");
+	IWL_DEBUG_INFO(trans, "hardware%s ready\n", ret ? " not" : "");
 	return ret;
 }
 
@@ -512,7 +512,7 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 
 	ret = iwl_pcie_set_hw_ready(trans);
 	/* If the card is ready, exit 0 */
-	if (ret >= 0) {
+	if (!ret) {
 		trans->csme_own = false;
 		return 0;
 	}
@@ -530,7 +530,7 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 
 		do {
 			ret = iwl_pcie_set_hw_ready(trans);
-			if (ret >= 0) {
+			if (!ret) {
 				trans->csme_own = false;
 				return 0;
 			}
@@ -2353,7 +2353,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 	 * and do not save/restore SRAM when power cycling.
 	 */
 	ret = iwl_poll_bits_mask(trans, CSR_GP_CNTRL, poll, mask, 15000);
-	if (unlikely(ret < 0)) {
+	if (unlikely(ret)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
 
 		if (silent) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 3af6e3b3640d..224f4a68c7a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -591,7 +591,7 @@ static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
 
 	/* Wait for DMA channels to be idle */
 	ret = iwl_poll_bits(trans, FH_TSSR_TX_STATUS_REG, mask, 5000);
-	if (ret < 0)
+	if (ret)
 		IWL_ERR(trans,
 			"Failing on timeout while stopping DMA channel %d [0x%08x]\n",
 			ch, iwl_read32(trans, FH_TSSR_TX_STATUS_REG));
-- 
2.34.1


