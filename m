Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17EB27AAA4
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgI1JXd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52768 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726629AbgI1JXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNZ-002KgD-MY; Mon, 28 Sep 2020 12:23:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:16 +0300
Message-Id: <iwlwifi.20200928121852.da97d87d7adf.If06301d4660b14e459195a15831b069b9f6c5e3c@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: rs: set RTS protection for all non legacy rates
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This helps with congested environments reducing the conflict cost to
RTS retries only, instead of the entire BA packet.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h | 11 +++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c    |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 4347be6491e9..73b839c3cac1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -486,6 +486,13 @@ enum {
 #define RATE_MCS_HE_106T_POS		28
 #define RATE_MCS_HE_106T_MSK		(1 << RATE_MCS_HE_106T_POS)
 
+/* Bit 30-31: (1) RTS, (2) CTS */
+#define RATE_MCS_RTS_REQUIRED_POS  (30)
+#define RATE_MCS_RTS_REQUIRED_MSK  (0x1 << RATE_MCS_RTS_REQUIRED_POS)
+
+#define RATE_MCS_CTS_REQUIRED_POS  (31)
+#define RATE_MCS_CTS_REQUIRED_MSK  (0x1 << RATE_MCS_CTS_REQUIRED_POS)
+
 /* Link Quality definitions */
 
 /* # entries in rate scale table to support Tx retries */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 86b2ebb5d5fb..ed7382e7ea17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -830,6 +830,12 @@ static u32 ucode_rate_from_rs_rate(struct iwl_mvm *mvm,
 		return ucode_rate;
 	}
 
+	/* set RTS protection for all non legacy rates
+	 * This helps with congested environments reducing the conflict cost to
+	 * RTS retries only, instead of the entire BA packet.
+	 */
+	ucode_rate |= RATE_MCS_RTS_REQUIRED_MSK;
+
 	if (is_ht(rate)) {
 		if (index < IWL_FIRST_HT_RATE || index > IWL_LAST_HT_RATE) {
 			IWL_ERR(mvm, "Invalid HT rate index %d\n", index);
-- 
2.28.0

