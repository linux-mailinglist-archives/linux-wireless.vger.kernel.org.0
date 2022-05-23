Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB04531ADF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiEWUDQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiEWUDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 16:03:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3EF13
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Gvnld1leQffvrLnz+tA3maEoaU4zFyI0xpDDj2YM3Ys=; t=1653336193; x=1654545793; 
        b=N6wpHLxTVlzjmOMoKhYOTfXeDrlIV0jA9TAoD9S8zoRflXtkrfqPqG5TQPSaVTLuA5iwLefxgWx
        +Zybdfq5Ergxmx1BACrpn1eYrTslOSZYrUcrEhVUXGeObBRIjWik3HP3Q7CDrFs3AHPedL7n6x6P4
        V6KYbvhTMvXBc7dZbwFIA4uhNpzwYnnY/xln0Offe1QZfTu43J+37INlaoNfcmOnFZ7ONWbrtyet5
        5V5wdi6NuVu9c5Y+VW2RE6buU/eZpawbb5IFSsNMTGb3gZXxct9zZdhY9RbWIKUsotW+sXLreG2dS
        eR54eb2kF04pEC11XMZN48Br5PSwBYHdhBiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ntEGj-002YJl-SS;
        Mon, 23 May 2022 22:03:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] iwlwifi: pcie: rename CAUSE macro
Date:   Mon, 23 May 2022 22:03:01 +0200
Message-Id: <20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

At least mips64 has ist own CAUSE macro, so rename ours to
IWL_CAUSE to fix build issues.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Fixes: c1918196427b ("iwlwifi: pcie: simplify MSI-X cause mapping")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 6fc69c42f36e..bd50f52a1aad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1090,7 +1090,7 @@ struct iwl_causes_list {
 	u8 addr;
 };
 
-#define CAUSE(reg, mask)						\
+#define IWL_CAUSE(reg, mask)						\
 	{								\
 		.mask_reg = reg,					\
 		.bit = ilog2(mask),					\
@@ -1101,28 +1101,28 @@ struct iwl_causes_list {
 	}
 
 static const struct iwl_causes_list causes_list_common[] = {
-	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH0_NUM),
-	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH1_NUM),
-	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_S2D),
-	CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_FH_ERR),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_ALIVE),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_WAKEUP),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RESET_DONE),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_CT_KILL),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RF_KILL),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_PERIODIC),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SCD),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_FH_TX),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HW_ERR),
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HAP),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH0_NUM),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH1_NUM),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_S2D),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_FH_ERR),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_ALIVE),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_WAKEUP),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RESET_DONE),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_CT_KILL),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RF_KILL),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_PERIODIC),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SCD),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_FH_TX),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HW_ERR),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HAP),
 };
 
 static const struct iwl_causes_list causes_list_pre_bz[] = {
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR),
 };
 
 static const struct iwl_causes_list causes_list_bz[] = {
-	CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ),
 };
 
 static void iwl_pcie_map_list(struct iwl_trans *trans,
-- 
2.36.1

