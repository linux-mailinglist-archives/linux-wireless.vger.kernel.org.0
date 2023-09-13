Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB979E751
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjIML51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIML50 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85971999
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606242; x=1726142242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcLODU6y+VVZEJ14WsoDqe731/9t9g2n8h/TtUqETUM=;
  b=hvbNUaUajKIBsS3ox4LD5hRWrDJDLYL2eKK9NI8jr7Vg/hgV0tjktFgN
   w8tQZENlGImHSmbcgwELHJxB/td8UQN5Ek6No8iBotM9hUDzeHZ9Fdoz4
   WqwiYZYtvKVECXXrmJxfw8pYc79ZOVdj6GEKCzK8U/SwAYRwHskc057JZ
   7SFkYLViCCEzF962stjsJN92P6wQe2tuyd/T2qPx1JNdSI2C3RwfJ/A5L
   Ah5ogQmfFD1u+1Bo4YRzkhcaVIkWM5v+G6DGjKrX4hynWF/X9t+qzeLln
   fTp28PL8EOx+VolU8XvJnlVE5C3KtktFmq19tQri1opnLA9/8rxvn5FDx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903025"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470931"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470931"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: pcie: enable TOP fatal error interrupt
Date:   Wed, 13 Sep 2023 14:56:39 +0300
Message-Id: <20230913145231.127d914a4d0d.I41ea409df63474554ef727c49382d0b5bf15939e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Enable the TOP (HW part) fatal error interrupt and add a
print when it happens. Currently FW always adds also the
SW error interrupt, but for >= Bz we'll need to do PLDR
in case this is asserted, so leave a TODO item already.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h    | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 587368a0ad4a..3653a9fd9d8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -618,6 +618,7 @@ enum msix_hw_int_causes {
 	MSIX_HW_INT_CAUSES_REG_WAKEUP		= BIT(1),
 	MSIX_HW_INT_CAUSES_REG_IML              = BIT(1),
 	MSIX_HW_INT_CAUSES_REG_RESET_DONE	= BIT(2),
+	MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR	= BIT(3),
 	MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ	= BIT(5),
 	MSIX_HW_INT_CAUSES_REG_CT_KILL		= BIT(6),
 	MSIX_HW_INT_CAUSES_REG_RF_KILL		= BIT(7),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 607c180d1eb3..23b5a0adcbd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2291,6 +2291,12 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	else
 		sw_err = inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR;
 
+	if (inta_hw & MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR) {
+		IWL_ERR(trans, "TOP Fatal error detected, inta_hw=0x%x.\n",
+			inta_hw);
+		/* TODO: PLDR flow required here for >= Bz */
+	}
+
 	/* Error detected by uCode */
 	if ((inta_fh & MSIX_FH_INT_CAUSES_FH_ERR) || sw_err) {
 		IWL_ERR(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 93e10d7d12fb..849ea1851508 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1111,6 +1111,7 @@ static const struct iwl_causes_list causes_list_common[] = {
 	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_ALIVE),
 	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_WAKEUP),
 	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RESET_DONE),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR),
 	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_CT_KILL),
 	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RF_KILL),
 	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_PERIODIC),
-- 
2.38.1

