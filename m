Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A652667E9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIKRy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:54:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50246 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725936AbgIKRyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:54:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6K-0028eU-HD; Fri, 11 Sep 2020 20:44:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:31 +0300
Message-Id: <iwlwifi.20200911204056.e5e36b41fbd7.I25be500451890be2165fa56cbe0b0a600b4a2a9e@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/11] iwlwifi: mvm: set PROTECTED_TWT in MAC data policy
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

If Protected-TWT is supported by BSS and by us, set the
PROTECTED_TWT bit in the data_policy in the MAC context command.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b78992e341d5..58d6e2302a9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -704,8 +702,12 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax) {
 		cmd.filter_flags |= cpu_to_le32(MAC_FILTER_IN_11AX);
-		if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT)
+		if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT) {
 			ctxt_sta->data_policy |= cpu_to_le32(TWT_SUPPORTED);
+			if (vif->bss_conf.twt_protected)
+				ctxt_sta->data_policy |=
+					cpu_to_le32(PROTECTED_TWT_SUPPORTED);
+		}
 	}
 
 
-- 
2.28.0

