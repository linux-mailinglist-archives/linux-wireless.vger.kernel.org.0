Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB046424B9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiLEIgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiLEIgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE612619
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229396; x=1701765396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HRhj69euONFGNqoaLnBvXn4ZaXrSwIQ5awf5csKVeUc=;
  b=I4JHbG5TXxrScjyeRODCxnQ4DpVB3yDUyPcIA4nPQvlaxazqINh4fwpJ
   DvePGBJ2mRr+iaiZw7w3ud+UyGJ1T5MoLeZEJcscbp+uKedZrw2go+d33
   pCVs+I9Dzh04iTiE4WGzyH2NHz7iO9gfSfzDMaNKk6xNcE+2X1dlWRex6
   4gDE+7tlnTpsmkz73yHWRHGny/8gBAdNCjvFANZ/Qx+0EpSZHxrt+vw4p
   U1HOHBWGQPQioLG3ROxGt1otDy6xC7sOkM3bUFVnI1FfKPe9PG+ixIM5T
   y81m13qFT4jmioy5u7XZgaSqy9OMUSXU41/yR1SlZ0+NcELEBEBwFjUWk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323157"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100424"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100424"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:28 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: mvm: Don't use deprecated register
Date:   Mon,  5 Dec 2022 10:35:44 +0200
Message-Id: <20221205102808.8e91eb10dc7d.I3882a2452785ef8b455d99af235e4477917bf46d@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The CSR_HW_IF_CONFIG_REG register is no longer in use from
IWL_DEVICE_FAMILY_AX210 and on.
This register uses now for CSR_CTXT_INFO_BOOT_CTRL
which has a different meaning and a different format.
Currently we're writing to the register according to
CSR_HW_IF_CONFIG_REGs format, regardless to the device family.
This causes to miss-interpretation of the register value, as it is
parsed according to CSR_CTXT_INFO_BOOT_CTRLs format for devices
families >= IWL_DEVICE_FAMILY_AX210.
Fix this by writing to the register according to the old format
only for the relevant hardware.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e78f5beaa2d0..ebe6d9c4ccaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -92,6 +92,12 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	radio_cfg_dash = (phy_config & FW_PHY_CFG_RADIO_DASH) >>
 			 FW_PHY_CFG_RADIO_DASH_POS;
 
+	IWL_DEBUG_INFO(mvm, "Radio type=0x%x-0x%x-0x%x\n", radio_cfg_type,
+		       radio_cfg_step, radio_cfg_dash);
+
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return;
+
 	/* SKU control */
 	reg_val = CSR_HW_REV_STEP_DASH(mvm->trans->hw_rev);
 
@@ -127,9 +133,6 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 				CSR_HW_IF_CONFIG_REG_D3_DEBUG,
 				reg_val);
 
-	IWL_DEBUG_INFO(mvm, "Radio type=0x%x-0x%x-0x%x\n", radio_cfg_type,
-		       radio_cfg_step, radio_cfg_dash);
-
 	/*
 	 * W/A : NIC is stuck in a reset state after Early PCIe power off
 	 * (PCIe power is lost before PERST# is asserted), causing ME FW
-- 
2.35.3

