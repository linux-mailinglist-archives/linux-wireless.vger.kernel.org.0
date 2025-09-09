Return-Path: <linux-wireless+bounces-27122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E25B49FF1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AF94E080B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5601A08A3;
	Tue,  9 Sep 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQJSqGsI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72426FDA5
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388122; cv=none; b=vBRn73B29dzGOQAuL9Sgo3Pywh95OtZEKIDP3X22GyDMuZeMkax2QD59gEfp+e5v+boU93WHjPfLzoaxqcnYRpoDLJkFu87X+j3GrenPM5c4hR7fJeFCDa4jLLqpCad8vsNZJPyCm22ux8lbFORwturul+bCyXUcTROlhmrKPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388122; c=relaxed/simple;
	bh=8rXW4t9BQGhqcnPdpwoD05X8ItVcOm9AQwXYfCcanQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFwF7DQBu1kgpCHUNm5qNYdTDtl291P1mHVHn9lqpFcTTosAMikUop2ammwR17cgXqpSZdBA89Czk4RIViQxoVGHGXK2rcXE/m/HAFVLCAi0ra31E6kKhlWFvaXaaDHbo4AlGckumPPGXQJphQBaGfYSRzOUx7DxlyAxa1Dghdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQJSqGsI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388120; x=1788924120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rXW4t9BQGhqcnPdpwoD05X8ItVcOm9AQwXYfCcanQo=;
  b=WQJSqGsI60MGZodDygQ9H00tNTCxkhNuH7Hw1wWirOnkMb4v3gC5HNb5
   tATkXCp9PN9UD5SDGxdEC/i8JHsV8+CUMaDenX+fCMO4k7kDz8hubamP8
   +TJJLyoNjzzyym5AdgE/AbwpJxVIbqdnlBCGmg3n2CMFNsI6zlapY5kEM
   oebcMcYGKX26wzx/z6A7rlzhFR8Li/kD4JjizBrTjSKu5SwON65biL/x9
   af9ovyMocF346d/PV2qFG6H9KWVs8lbfVZNxdF+rMHmdyFfEx3CTgNlMS
   tin47VztSojOlmGut9h2s3oL7KMrfI8wIhoQPVGQB9xd24VZcwwj4GNtM
   Q==;
X-CSE-ConnectionGUID: AffuNZQJQl6b2CvZmVroJA==
X-CSE-MsgGUID: FdE/iQNiSzS4/IwLevkqhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281054"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281054"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:00 -0700
X-CSE-ConnectionGUID: uF+3uE5TQUqqOCmei5t5Gg==
X-CSE-MsgGUID: zKt1jX9/SpSFe86xVIAPBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950303"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 03/15] wifi: iwlwifi: rename iwl_finish_nic_init
Date: Tue,  9 Sep 2025 06:21:16 +0300
Message-Id: <20250909061931.a1de688e574b.Ibd41b0c8f7fbae77026e76dbbc085df3eecec538@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The function is called so because for older devices it sets a bit called
"init_done". But for the latest devices it sets a different bit,
"mac_init". Since this name is not clear anyway, rename it such that it
indicates the logic of the newer devices.
Also add the 'trans' prefix so iw will be clear from the name that this
is a transport API.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c          |  6 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-io.h          |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c        |  2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h    |  2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c  |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c   | 12 ++++++------
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 9f8cdb027839..d337ab543eb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -766,7 +766,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index a39c038db08e..ddd714cff2f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -178,7 +178,7 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 		if (err)
 			return;
 
-		err = iwl_finish_nic_init(trans);
+		err = iwl_trans_activate_nic(trans);
 		if (err)
 			return;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index fb645dafea38..b1944584c693 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -396,11 +396,11 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
-int iwl_finish_nic_init(struct iwl_trans *trans)
+int iwl_trans_activate_nic(struct iwl_trans *trans)
 {
-	return iwl_pcie_gen1_2_finish_nic_init(trans);
+	return iwl_pcie_gen1_2_activate_nic(trans);
 }
-IWL_EXPORT_SYMBOL(iwl_finish_nic_init);
+IWL_EXPORT_SYMBOL(iwl_trans_activate_nic);
 
 void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 731cda1a4e66..5bcec239ffc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -57,7 +57,7 @@ void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 void iwl_clear_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
 void iwl_force_nmi(struct iwl_trans *trans);
 
-int iwl_finish_nic_init(struct iwl_trans *trans);
+int iwl_trans_activate_nic(struct iwl_trans *trans);
 
 /* Error handling */
 int iwl_dump_fh(struct iwl_trans *trans, char **buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5cb0b519e762..e68dce21df64 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1243,7 +1243,7 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 		 * won't really know how to recover.
 		 */
 		iwl_pcie_prepare_card_hw(trans);
-		iwl_finish_nic_init(trans);
+		iwl_trans_activate_nic(trans);
 		iwl_op_mode_device_powered_off(trans->op_mode);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 79893e2d2701..36fe5863f735 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1131,7 +1131,7 @@ int iwl_pcie_alloc_dma_ptr(struct iwl_trans *trans,
 			   struct iwl_dma_ptr *ptr, size_t size);
 void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr);
 void iwl_pcie_apply_destination(struct iwl_trans *trans);
-int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans);
+int iwl_pcie_gen1_2_activate_nic(struct iwl_trans *trans);
 
 /* transport gen 2 exported functions */
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 1951be3a30b7..b15c5d486527 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -47,7 +47,7 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index f281d91475b4..922397408138 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -267,7 +267,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	if (trans->mac_cfg->base->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret)
 		return ret;
 
@@ -340,7 +340,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	ret = iwl_trans_pcie_sw_reset(trans, true);
 
 	if (!ret)
-		ret = iwl_finish_nic_init(trans);
+		ret = iwl_trans_activate_nic(trans);
 
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
@@ -1542,7 +1542,7 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret) {
 		IWL_ERR(trans, "Failed to init nic upon resume. err = %d\n",
 			ret);
@@ -1766,7 +1766,7 @@ static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_trans_activate_nic(trans);
 	if (ret < 0)
 		return ret;
 
@@ -4188,7 +4188,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	 */
 	ret = iwl_pcie_prepare_card_hw(iwl_trans);
 	if (!ret) {
-		ret = iwl_finish_nic_init(iwl_trans);
+		ret = iwl_trans_activate_nic(iwl_trans);
 		if (ret)
 			goto out_free_trans;
 		if (iwl_trans_grab_nic_access(iwl_trans)) {
@@ -4308,7 +4308,7 @@ void iwl_pcie_gen1_2_remove(struct iwl_trans *trans)
 	iwl_trans_pcie_free(trans);
 }
 
-int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans)
+int iwl_pcie_gen1_2_activate_nic(struct iwl_trans *trans)
 {
 	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
 	u32 poll_ready;
-- 
2.34.1


