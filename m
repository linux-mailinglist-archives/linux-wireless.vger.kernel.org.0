Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793371E760A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgE2Gjn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34986 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725562AbgE2Gjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYg8-000jvb-QY; Fri, 29 May 2020 09:39:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:22 +0300
Message-Id: <iwlwifi.20200529092401.5405db448555.Ie3c110932ebbd5b6aca99938a5e0a1e4dfbaa848@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/11] iwlwifi: pcie: don't count on the FW to set persistence mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

Apparently the FW can't set the persistence in all flows. Don't count
on the FW setting it in AX210 devices or above either to avoid
potential resets on resume.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8ccfc7cc7348..3bcbc2967c88 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2007 - 2015 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2007 - 2015, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2015 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2007 - 2015, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -1495,14 +1493,10 @@ static int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
 	int ret;
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	/*
-	 * Family IWL_DEVICE_FAMILY_AX210 and above persist mode is set by FW.
-	 */
-	if (!reset && trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+	if (!reset)
 		/* Enable persistence mode to avoid reset */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PERSIST_MODE);
-	}
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
-- 
2.26.2

