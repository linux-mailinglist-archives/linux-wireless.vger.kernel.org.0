Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF34529D75
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiEQJGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245120AbiEQJGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:06:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBE13D69
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778384; x=1684314384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8jRbqIHiHeBiztgMpidCFiYoDSGB6hVCWljyXRFrVpc=;
  b=Eq+mjsPsOzub/tQ4tlzT/H2asiHlXx362RBdEIyxXDzaV4mN07q5pxnG
   gTni6ztbhA8sEN/MoE7ORn3PTGAPf6mXhhPo6QeRG5PChyasQiICwpr8L
   hTks3VaL2K4y9H/Rp9mIvgiEmdB0EvRXhlaUy3gEC4ePUJ3futQwUDyHx
   FTi/w7OB4AR1VaxrnbxSdxrdp3q8ls+elfukvr0KzaiIwdT9iFFrviVxB
   QwuMsDPvkk1aTGJ6FMLzjLNCQnEu9lkcxMRAv1TmR3MVue0fdecVqSRg/
   6ceG7isNuWMl/xFezOZZArzi67K3zJNhvnJc0V852yoVpD6dpyCleOf91
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251014092"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="251014092"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679635"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:05 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/10] iwlwifi: pcie: simplify MSI-X cause mapping
Date:   Tue, 17 May 2022 12:05:05 +0300
Message-Id: <20220517120044.19abe9a4d171.I934356911277f9b2a955808763f317986f69a461@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We're currently manually encoding a calculation here since the HW
just maps all the bits of specific registers to specific offsets,
which led to the bug fixed here previously with the Bz SW_ERROR
interrupt.

Clean up the code to only know about the mapping offset (-16 or
16 depending on the register) to avoid such issues in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8be3c3c8c68b..6fc69c42f36e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1085,34 +1085,44 @@ bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans)
 }
 
 struct iwl_causes_list {
-	u32 cause_num;
-	u32 mask_reg;
+	u16 mask_reg;
+	u8 bit;
 	u8 addr;
 };
 
+#define CAUSE(reg, mask)						\
+	{								\
+		.mask_reg = reg,					\
+		.bit = ilog2(mask),					\
+		.addr = ilog2(mask) +					\
+			((reg) == CSR_MSIX_FH_INT_MASK_AD ? -16 :	\
+			 (reg) == CSR_MSIX_HW_INT_MASK_AD ? 16 :	\
+			 0xffff),	/* causes overflow warning */	\
+	}
+
 static const struct iwl_causes_list causes_list_common[] = {
-	{MSIX_FH_INT_CAUSES_D2S_CH0_NUM,	CSR_MSIX_FH_INT_MASK_AD, 0},
-	{MSIX_FH_INT_CAUSES_D2S_CH1_NUM,	CSR_MSIX_FH_INT_MASK_AD, 0x1},
-	{MSIX_FH_INT_CAUSES_S2D,		CSR_MSIX_FH_INT_MASK_AD, 0x3},
-	{MSIX_FH_INT_CAUSES_FH_ERR,		CSR_MSIX_FH_INT_MASK_AD, 0x5},
-	{MSIX_HW_INT_CAUSES_REG_ALIVE,		CSR_MSIX_HW_INT_MASK_AD, 0x10},
-	{MSIX_HW_INT_CAUSES_REG_WAKEUP,		CSR_MSIX_HW_INT_MASK_AD, 0x11},
-	{MSIX_HW_INT_CAUSES_REG_RESET_DONE,	CSR_MSIX_HW_INT_MASK_AD, 0x12},
-	{MSIX_HW_INT_CAUSES_REG_CT_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x16},
-	{MSIX_HW_INT_CAUSES_REG_RF_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x17},
-	{MSIX_HW_INT_CAUSES_REG_PERIODIC,	CSR_MSIX_HW_INT_MASK_AD, 0x18},
-	{MSIX_HW_INT_CAUSES_REG_SCD,		CSR_MSIX_HW_INT_MASK_AD, 0x2A},
-	{MSIX_HW_INT_CAUSES_REG_FH_TX,		CSR_MSIX_HW_INT_MASK_AD, 0x2B},
-	{MSIX_HW_INT_CAUSES_REG_HW_ERR,		CSR_MSIX_HW_INT_MASK_AD, 0x2D},
-	{MSIX_HW_INT_CAUSES_REG_HAP,		CSR_MSIX_HW_INT_MASK_AD, 0x2E},
+	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH0_NUM),
+	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH1_NUM),
+	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_S2D),
+	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_FH_ERR),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_ALIVE),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_WAKEUP),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RESET_DONE),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_CT_KILL),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RF_KILL),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_PERIODIC),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SCD),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_FH_TX),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HW_ERR),
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HAP),
 };
 
 static const struct iwl_causes_list causes_list_pre_bz[] = {
-	{MSIX_HW_INT_CAUSES_REG_SW_ERR,		CSR_MSIX_HW_INT_MASK_AD, 0x29},
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR),
 };
 
 static const struct iwl_causes_list causes_list_bz[] = {
-	{MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ,	CSR_MSIX_HW_INT_MASK_AD, 0x15},
+	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ),
 };
 
 static void iwl_pcie_map_list(struct iwl_trans *trans,
@@ -1124,7 +1134,7 @@ static void iwl_pcie_map_list(struct iwl_trans *trans,
 	for (i = 0; i < arr_size; i++) {
 		iwl_write8(trans, CSR_MSIX_IVAR(causes[i].addr), val);
 		iwl_clear_bit(trans, causes[i].mask_reg,
-			      causes[i].cause_num);
+			      BIT(causes[i].bit));
 	}
 }
 
-- 
2.35.1

