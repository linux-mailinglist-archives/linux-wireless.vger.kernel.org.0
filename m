Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6581279392
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIYVbG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52328 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbgIYVbE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ0-002J1P-7q; Sat, 26 Sep 2020 00:31:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:45 +0300
Message-Id: <iwlwifi.20200926002540.5edc24ef3907.I68820c8c0946451cf0cca14dda171fa304b1dc43@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/15] iwlwifi: mvm: add support for new  version of WOWLAN_TKIP_SETTING_API_S
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dan Halperin <Dan1.Halperin@intel.com>

Add a sta_id (__le32) to the cmd, in order to support CDB protocol.

Signed-off-by: Dan Halperin <Dan1.Halperin@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 15 ++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 19 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index c4562e1f8d18..c44384be75ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -469,13 +469,22 @@ struct iwl_p1k_cache {
 
 #define IWL_NUM_RX_P1K_CACHE	2
 
-struct iwl_wowlan_tkip_params_cmd {
+struct iwl_wowlan_tkip_params_cmd_ver_1 {
 	struct iwl_mic_keys mic_keys;
 	struct iwl_p1k_cache tx;
 	struct iwl_p1k_cache rx_uni[IWL_NUM_RX_P1K_CACHE];
 	struct iwl_p1k_cache rx_multi[IWL_NUM_RX_P1K_CACHE];
 } __packed; /* WOWLAN_TKIP_SETTING_API_S_VER_1 */
 
+struct iwl_wowlan_tkip_params_cmd {
+	struct iwl_mic_keys mic_keys;
+	struct iwl_p1k_cache tx;
+	struct iwl_p1k_cache rx_uni[IWL_NUM_RX_P1K_CACHE];
+	struct iwl_p1k_cache rx_multi[IWL_NUM_RX_P1K_CACHE];
+	u8     reversed[2];
+	__le32 sta_id;
+} __packed; /* WOWLAN_TKIP_SETTING_API_S_VER_2 */
+
 #define IWL_KCK_MAX_SIZE	32
 #define IWL_KEK_MAX_SIZE	32
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index bcdd2b376ce5..081d35497ccb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -783,9 +783,26 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	if (key_data.use_tkip &&
 	    !fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_TKIP_MIC_KEYS)) {
+		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+						WOWLAN_TKIP_PARAM);
+		int size;
+
+		if (ver == 2) {
+			size = sizeof(tkip_cmd);
+			key_data.tkip->sta_id =
+				cpu_to_le32(mvmvif->ap_sta_id);
+		} else if (ver == 1 || ver == IWL_FW_CMD_VER_UNKNOWN) {
+			size = sizeof(struct iwl_wowlan_tkip_params_cmd_ver_1);
+		} else {
+			ret =  -EINVAL;
+			WARN_ON_ONCE(1);
+			goto out;
+		}
+
+		/* send relevant data according to CMD version */
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WOWLAN_TKIP_PARAM,
-					   cmd_flags, sizeof(tkip_cmd),
+					   cmd_flags, size,
 					   &tkip_cmd);
 		if (ret)
 			goto out;
-- 
2.28.0

