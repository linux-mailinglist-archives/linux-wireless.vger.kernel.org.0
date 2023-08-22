Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28813783AFB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjHVHdk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjHVHdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:33:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BC3137
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689614; x=1724225614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nj80eqtbKncMDoHksdcuuok0wmml/klBStx34qP+ujI=;
  b=UKVmmEHkqOLnzecscIj4HlYj0U15g3ClX9IkePSn7cu2R+MuK4kyoLCl
   4r83gSCKiyXK1/BKagKb8uhJNpM6jZ8uEc2SBh/W5vUL5SaHF7bHYuDc8
   MKxjs5V2kKO3vN50TEUOnwXdHPDT3qHDYOuUqM/5QUyYqfqIzeJzGB8Ee
   QSv7/0iQX+8HC3PCyC42bX1Pv4EU0h9hUKALqg55/mvl9l0ZDf0NVBVDj
   PP/Lv58t8Ai6Ff6XJgUDUIDqqCKjy8SWfXFmMTawVKL57fGDAAyDFT1Iu
   xPCofpfUdVF04/jvy731AtpvdSTuOBSNaPMlXsynpPcJJoRi5Ff+6iCM5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363968728"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="363968728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826229598"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826229598"
Received: from msharshe-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.209.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/5] wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
Date:   Tue, 22 Aug 2023 10:33:15 +0300
Message-Id: <20230822103048.9b026fa7b97e.I12bea7e6eef54eeeaf916b68d71583e92ff310fd@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822073319.466640-1-gregory.greenman@intel.com>
References: <20230822073319.466640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

In case CSME holds the NIC and SAP connection is already established,
iwl_pcie_prepare_card_hw() during iwl_pci_probe() will fail
(which is fine since CSME will release the nic later when asked with
a SAP message). In this case tring to grab nic access to read the
crf ids will fail with a warning.
Avoid the warning by only trying to read the crf ids in case prepare
card succeeded.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 73c1fb3c0c5e..bc83d2ba55c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1132,12 +1132,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	else
 		sd_reg_ver_addr = SD_REG_VER;
 
-	if (!iwl_trans_grab_nic_access(iwl_trans)) {
-		IWL_ERR(iwl_trans, "Failed to grab nic access before reading crf id\n");
-		ret = -EIO;
-		goto out;
-	}
-
 	/* Enable access to peripheral registers */
 	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
 	val |= ENABLE_WFPM;
@@ -1157,9 +1151,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
 		 iwl_trans->hw_wfpm_id);
 
-	iwl_trans_release_nic_access(iwl_trans);
-
-out:
 	return ret;
 }
 
@@ -1351,6 +1342,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ret)
 			goto out_free_trans;
 		if (iwl_trans_grab_nic_access(iwl_trans)) {
+			get_crf_id(iwl_trans);
 			/* all good */
 			iwl_trans_release_nic_access(iwl_trans);
 		} else {
@@ -1360,7 +1352,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
-	get_crf_id(iwl_trans);
 
 	/*
 	 * The RF_ID is set to zero in blank OTP so read version to
-- 
2.38.1

