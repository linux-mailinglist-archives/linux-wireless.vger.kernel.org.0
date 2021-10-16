Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881B2430133
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhJPIqN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 04:46:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52856 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234494AbhJPIqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 04:46:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mbfIR-000Xqv-Ee; Sat, 16 Oct 2021 11:44:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 16 Oct 2021 11:43:56 +0300
Message-Id: <iwlwifi.20211016114029.ee163f4a7513.I7f87bd969a0b038c7f3a1a962d9695ffd18c5da1@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016084359.246930-1-luca@coelho.fi>
References: <20211016084359.246930-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.15 2/5] iwlwifi: change all JnP to NO-160 configuration
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

JnP should not have the 160 MHz.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e3996ff99bad..3b974388d834 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -931,9 +931,9 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr_b0, iwl_ax203_name),
 
 	/* Qu C step */
@@ -945,7 +945,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr_b0, iwl_ax203_name),
 
 	/* QuZ */
-- 
2.33.0

