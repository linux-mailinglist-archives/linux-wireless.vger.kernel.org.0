Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9684B1389
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbiBJQwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiBJQwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:34 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24284F9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:35 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDS-000Bxy-QR;
        Thu, 10 Feb 2022 18:22:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:27 +0200
Message-Id: <iwlwifi.20220210181930.1fd6adfb6f1e.Icc8f5fd517735fcc10db098999ff1272da291298@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 04/11] iwlwifi: tlc: Add logs in rs_fw_rate_init func to print TLC configuration
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

Add logs in rs_fw_rate_init function. It helps in
verifying TLC Configuration while debuging TLC related bugs.

Update kernel doc for TLC_MNG_CONFIG_CMD with correct version
of struct iwl_tlc_config_cmd.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Fixes: ae4c1bb06b66 ("iwlwifi: rs: add support for TLC config command ver 4")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     | 14 +++++++++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 5539d402daa9..99235baab85d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -42,7 +42,7 @@ enum iwl_data_path_subcmd_ids {
 	RFH_QUEUE_CONFIG_CMD = 0xD,
 
 	/**
-	 * @TLC_MNG_CONFIG_CMD: &struct iwl_tlc_config_cmd
+	 * @TLC_MNG_CONFIG_CMD: &struct iwl_tlc_config_cmd_v4
 	 */
 	TLC_MNG_CONFIG_CMD = 0xF,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 173a6991587b..2198ca5269e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_rs_h__
@@ -133,7 +133,7 @@ enum IWL_TLC_MCS_PER_BW {
 };
 
 /**
- * struct tlc_config_cmd - TLC configuration
+ * struct iwl_tlc_config_cmd_v3 - TLC configuration
  * @sta_id: station id
  * @reserved1: reserved
  * @max_ch_width: max supported channel width from @enum iwl_tlc_mng_cfg_cw
@@ -168,7 +168,7 @@ struct iwl_tlc_config_cmd_v3 {
 } __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_3 */
 
 /**
- * struct tlc_config_cmd - TLC configuration
+ * struct iwl_tlc_config_cmd_v4 - TLC configuration
  * @sta_id: station id
  * @reserved1: reserved
  * @max_ch_width: max supported channel width from &enum iwl_tlc_mng_cfg_cw
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 6ba591f8d9c3..9830d2663689 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include "rs.h"
 #include "fw-api.h"
@@ -456,6 +456,18 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 					WIDE_ID(DATA_PATH_GROUP,
 						TLC_MNG_CONFIG_CMD),
 					0);
+	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, sta_id=%d, max_ch_width=%d, mode=%d\n",
+		       cfg_cmd.sta_id, cfg_cmd.max_ch_width, cfg_cmd.mode);
+	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, chains=0x%X, ch_wid_supp=%d, flags=0x%X\n",
+		       cfg_cmd.chains, cfg_cmd.sgi_ch_width_supp, cfg_cmd.flags);
+	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, mpdu_len=%d, no_ht_rate=0x%X, tx_op=%d\n",
+		       cfg_cmd.max_mpdu_len, cfg_cmd.non_ht_rates, cfg_cmd.max_tx_op);
+	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, ht_rate[0][0]=0x%X, ht_rate[1][0]=0x%X\n",
+		       cfg_cmd.ht_rates[0][0], cfg_cmd.ht_rates[1][0]);
+	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, ht_rate[0][1]=0x%X, ht_rate[1][1]=0x%X\n",
+		       cfg_cmd.ht_rates[0][1], cfg_cmd.ht_rates[1][1]);
+	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, ht_rate[0][2]=0x%X, ht_rate[1][2]=0x%X\n",
+		       cfg_cmd.ht_rates[0][2], cfg_cmd.ht_rates[1][2]);
 	if (cmd_ver == 4) {
 		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC,
 					   sizeof(cfg_cmd), &cfg_cmd);
-- 
2.34.1

