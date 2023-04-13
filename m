Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00D56E144C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDMSlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDMSlo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66927D85
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411301; x=1712947301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//N+n092veTaW5uEQ3myizP6/wrglOD0V1BaK99qZRQ=;
  b=J+uPVvErJ3FZL30ZoGPyYb2JTXA7X0li70EctX7RJoo74j48/oGQfBe6
   V16D5YQbpf5EePq9tXRov1gzzIw9gZ8cmk3ooriuv8IU4ttai7xA98mR0
   HKq2XrsEewF38NG6UR67TcgmPGFByHYEis3nn2+/p48VEvGr11fImgk4V
   KUD1zq95lFLWL7XSfok29S1WcvvJkss7ePZIjJbqqiDKGTiHaGRDQCU7y
   /fMFy7c0Yky6R7gZonoi+uRRV58SPcZGzP6Pc9toXUp3kkYF633ozqGb7
   zncNlr2q/fT4ZoiUAcbB+VrkcLSG/JrKaXBxc35LblZSYox2q1b2S7JNX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127067"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127067"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984373"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984373"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: pcie: work around ROM bug on AX210 integrated
Date:   Thu, 13 Apr 2023 21:40:30 +0300
Message-Id: <20230413213309.aaa0a4339984.If08da23e960b6236f8c05c06fc8b26041ac89f1e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On 22000 and AX210 devices, there's a ROM bug that causes it to
set invalid LTR settings. On 22000 and AX210 non-integrated we
can fix up these settings from the driver (as done in the code
here), but on AX210 integrated these registers are not available
to the driver.

Attempt to work around the issue by spinning while the IML is
being loaded, the IML will then reprogram the LTR values itself
after it's loaded, so only the brief IML load (which the ROM is
doing) is affected.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  2 +
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 72 +++++++++++++++++--
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index bece76b1a514..52479516c76b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -102,6 +102,8 @@
 #define CSR_LTR_LONG_VAL_AD_SNOOP_VAL		0x000003ff
 #define CSR_LTR_LONG_VAL_AD_SCALE_USEC		2
 
+#define CSR_LTR_LAST_MSG			(CSR_BASE + 0x0DC)
+
 /* GIO Chicken Bits (PCI Express bus link power management) */
 #define CSR_GIO_CHICKEN_BITS    (CSR_BASE+0x100)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 1e263154e9eb..45b63e3f5df3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -350,7 +350,7 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	mutex_unlock(&trans_pcie->mutex);
 }
 
-static void iwl_pcie_set_ltr(struct iwl_trans *trans)
+static bool iwl_pcie_set_ltr(struct iwl_trans *trans)
 {
 	u32 ltr_val = CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ |
 		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
@@ -371,18 +371,77 @@ static void iwl_pcie_set_ltr(struct iwl_trans *trans)
 	     trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) &&
 	    !trans->trans_cfg->integrated) {
 		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, ltr_val);
-	} else if (trans->trans_cfg->integrated &&
-		   trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
+		return true;
+	}
+
+	if (trans->trans_cfg->integrated &&
+	    trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
 		iwl_write_prph(trans, HPM_MAC_LTR_CSR, HPM_MAC_LRT_ENABLE_ALL);
 		iwl_write_prph(trans, HPM_UMAC_LTR, ltr_val);
+		return true;
+	}
+
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+		/* First clear the interrupt, just in case */
+		iwl_write32(trans, CSR_MSIX_HW_INT_CAUSES_AD,
+			    MSIX_HW_INT_CAUSES_REG_IML);
+		/* In this case, unfortunately the same ROM bug exists in the
+		 * device (not setting LTR correctly), but we don't have control
+		 * over the settings from the host due to some hardware security
+		 * features. The only workaround we've been able to come up with
+		 * so far is to try to keep the CPU and device busy by polling
+		 * it and the IML (image loader) completed interrupt.
+		 */
+		return false;
+	}
+
+	/* nothing needs to be done on other devices */
+	return true;
+}
+
+static void iwl_pcie_spin_for_iml(struct iwl_trans *trans)
+{
+/* in practice, this seems to complete in around 20-30ms at most, wait 100 */
+#define IML_WAIT_TIMEOUT	(HZ / 10)
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	unsigned long end_time = jiffies + IML_WAIT_TIMEOUT;
+	u32 value, loops = 0;
+	bool irq = false;
+
+	if (WARN_ON(!trans_pcie->iml))
+		return;
+
+	value = iwl_read32(trans, CSR_LTR_LAST_MSG);
+	IWL_DEBUG_INFO(trans, "Polling for IML load - CSR_LTR_LAST_MSG=0x%x\n",
+		       value);
+
+	while (time_before(jiffies, end_time)) {
+		if (iwl_read32(trans, CSR_MSIX_HW_INT_CAUSES_AD) &
+				MSIX_HW_INT_CAUSES_REG_IML) {
+			irq = true;
+			break;
+		}
+		/* Keep the CPU and device busy. */
+		value = iwl_read32(trans, CSR_LTR_LAST_MSG);
+		loops++;
 	}
+
+	IWL_DEBUG_INFO(trans,
+		       "Polled for IML load: irq=%d, loops=%d, CSR_LTR_LAST_MSG=0x%x\n",
+		       irq, loops, value);
+
+	/* We don't fail here even if we timed out - maybe we get lucky and the
+	 * interrupt comes in later (and we get alive from firmware) and then
+	 * we're all happy - but if not we'll fail on alive timeout or get some
+	 * other error out.
+	 */
 }
 
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 				 const struct fw_img *fw, bool run_in_rfkill)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	bool hw_rfkill;
+	bool hw_rfkill, keep_ram_busy;
 	int ret;
 
 	/* This may fail if AMT took ownership of the device */
@@ -443,7 +502,7 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	if (ret)
 		goto out;
 
-	iwl_pcie_set_ltr(trans);
+	keep_ram_busy = !iwl_pcie_set_ltr(trans);
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_write32(trans, CSR_FUNC_SCRATCH, CSR_FUNC_SCRATCH_INIT_VALUE);
@@ -455,6 +514,9 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 		iwl_write_prph(trans, UREG_CPU_INIT_RUN, 1);
 	}
 
+	if (keep_ram_busy)
+		iwl_pcie_spin_for_iml(trans);
+
 	/* re-check RF-Kill state since we may have missed the interrupt */
 	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
 	if (hw_rfkill && !run_in_rfkill)
-- 
2.38.1

