Return-Path: <linux-wireless+bounces-25046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C19AFDEFA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32290584063
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54D269D16;
	Wed,  9 Jul 2025 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3qN/w/E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D6269AF3
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037354; cv=none; b=VUoLPar09Ak+AyjzZUNJBAwwn3NY0XzzfGS9VasVKSvQJJFE56FfqLWJLOy9LopUtvw+hDlVh8sgD22k9Z21KT54XHxfZ7B8oehTdNDLeGebryRxfIm8vL1wXVoULxZ6VwS4wFKUqJ9ZL27hEW8kZqwNHufUGY6VACzfbQrJHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037354; c=relaxed/simple;
	bh=SSCRS27UTKiqKiO5C+dM3vwP1aAlZh5qGMI8w2MW9HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzue6jA1OjAGgcZ05v7Hn85nPyIezajPXgAqHnZ/XMacm1+nAAbc2VIq8jVPQl6dT0lbMtc8IMmH5LkPyb+eIWBaha7Koe7e4XEgaC14Luw+tN11uaZXpCl1cF3OnHazese4EiMRHLR9NTNPd5PHmkAsP7PsioU7qVt4gM1y9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3qN/w/E; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037352; x=1783573352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SSCRS27UTKiqKiO5C+dM3vwP1aAlZh5qGMI8w2MW9HY=;
  b=W3qN/w/ER0Jmx+FNzVQiGTrek6haG8Zj04cKh+sfGBEmOctrlCSwyl6/
   Vz6gxY6h+qxMpOazMeh67XOmzKWZyyL2zQOhRbhuMp1l5rnwN1+dFa8yD
   tpsXzF1EWbem8y0htcrwq3QRH0wKBEvIMfhbee6PvPBKTsIkbtGpf7Lal
   ZGzR3QXf6a2TtzKxdlMok6QA4EzsyxhWj0pr6rVq8BeHftZ+GNbfY3ung
   mdS1/S248vzBMX6egdWWRlFPUU+zdIINifuUGicBCNCj7uf525CZyJGn7
   Sv03rMimYq+m6X9UdOvDdArOB+Vyk+ceMzWcrRV3P+yIXJoj1Amyb3Xm0
   g==;
X-CSE-ConnectionGUID: R6xKVLCyRVmTuwx+j9Ne+w==
X-CSE-MsgGUID: xTKyvVBuRzy04YTIxXiyOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501467"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:32 -0700
X-CSE-ConnectionGUID: vp9LpD7MQZ6TmfeDYVsCpg==
X-CSE-MsgGUID: 5XADPXeGSMmNWmVA1+y12w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859251"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: simplify iwl_poll_bits_mask return value
Date: Wed,  9 Jul 2025 08:01:52 +0300
Message-Id: <20250709075928.916b15b8a2f8.Iae8ef99a94e25c23044e2c36244cda2b55328447@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
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
index b2c95cca875f..a098b7a41c77 100644
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


