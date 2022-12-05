Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E536424B8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiLEIgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLEIgf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:35 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122DF5A7
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229393; x=1701765393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgiI1sMlwsbegKtJH3IQBGyu9M2xjjUyGzQtqTdggXM=;
  b=VX2O+ziXHuj3FfzPpUqQDjs0+Qtzb0jn7Rzhc9gvtlxChfEijOVdvccy
   mLexnOMUeFHTpr9hE10IJFhCQF1NLpxYY3523fQJxSM1G90kw339pS76m
   WD5wClyA/+TnL4+7JOxWcvfhtAsBP3GTFVrqyqIA/vNf7GhzRllYcqR+t
   euPcSBnVlrokMlkFS5IX+VNW56obwMtAl+w2Cur7VRnO+M5Do8ZQuAFkA
   MpDWaPpF1DD6D4cxQgcTtJwPpj6ORHPxRGtYg/ulQDeo8DrB8CXW6hU5x
   QRgRzwXzEzL1jM/0EpkSsf75elrrCwCqfMgdJLstnkm3HKefcSut6Gq3+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323124"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323124"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100402"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100402"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:26 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: pcie: Add reading and storing of crf and cdb id.
Date:   Mon,  5 Dec 2022 10:35:43 +0200
Message-Id: <20221205102808.888b30780128.Ic8c4c088a75a0d7092d6301ef3760a118a06d819@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Read and store crf and cdb id details to make it
available during driver's lifetime

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 33 +++++++++++++------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 32bd7f19f1d5..479a518c89a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -976,6 +976,8 @@ struct iwl_trans_txqs {
  * @max_skb_frags: maximum number of fragments an SKB can have when transmitted.
  *	0 indicates that frag SKBs (NETIF_F_SG) aren't supported.
  * @hw_rf_id a u32 with the device RF ID
+ * @hw_crf_id a u32 with the device CRF ID
+ * @hw_cdb_id a u32 with the device CDB ID
  * @hw_id: a u32 with the ID of the device / sub-device.
  *	Set during transport allocation.
  * @hw_id_str: a string with info about HW ID. Set during transport allocation.
@@ -1015,6 +1017,8 @@ struct iwl_trans {
 	u32 hw_rev;
 	u32 hw_rev_step;
 	u32 hw_rf_id;
+	u32 hw_crf_id;
+	u32 hw_cdb_id;
 	u32 hw_id;
 	char hw_id_str[52];
 	u32 sku_id[3];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4f699862e7f7..99768d6a6032 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1350,15 +1350,13 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 };
 
 /*
- * In case that there is no OTP on the NIC, get the rf id and cdb info
- * from the prph registers.
+ * Read rf id and cdb info from prph register and store it
  */
 static int get_crf_id(struct iwl_trans *iwl_trans)
 {
 	int ret = 0;
 	u32 sd_reg_ver_addr;
-	u32 cdb = 0;
-	u32 val;
+	u32 val = 0;
 
 	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		sd_reg_ver_addr = SD_REG_VER_GEN2;
@@ -1377,10 +1375,26 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
 
 	/* Read crf info */
-	val = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
+	iwl_trans->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
 
 	/* Read cdb info (also contains the jacket info if needed in the future */
-	cdb = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+	iwl_trans->hw_cdb_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+
+	iwl_trans_release_nic_access(iwl_trans);
+
+out:
+	return ret;
+}
+
+/*
+ * In case that there is no OTP on the NIC, map the rf id and cdb info
+ * from the prph registers.
+ */
+static int map_crf_id(struct iwl_trans *iwl_trans)
+{
+	int ret = 0;
+	u32 val = iwl_trans->hw_crf_id;
+	u32 cdb = iwl_trans->hw_cdb_id;
 
 	/* Map between crf id to rf id */
 	switch (REG_CRF_ID_TYPE(val)) {
@@ -1410,7 +1424,7 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 		IWL_ERR(iwl_trans,
 			"Can find a correct rfid for crf id 0x%x\n",
 			REG_CRF_ID_TYPE(val));
-		goto out_release;
+		goto out;
 
 	}
 
@@ -1423,8 +1437,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	IWL_INFO(iwl_trans, "Detected RF 0x%x from crf id 0x%x\n",
 		 iwl_trans->hw_rf_id, REG_CRF_ID_TYPE(val));
 
-out_release:
-	iwl_trans_release_nic_access(iwl_trans);
 
 out:
 	return ret;
@@ -1544,6 +1556,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
+	get_crf_id(iwl_trans);
 
 	/*
 	 * The RF_ID is set to zero in blank OTP so read version to
@@ -1552,7 +1565,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (iwl_trans->trans_cfg->rf_id &&
 	    iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
-	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && get_crf_id(iwl_trans)) {
+	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && map_crf_id(iwl_trans)) {
 		ret = -EINVAL;
 		goto out_free_trans;
 	}
-- 
2.35.3

