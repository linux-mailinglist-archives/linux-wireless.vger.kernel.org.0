Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF272E37C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbjFMM6U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbjFMM6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A219A7
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661081; x=1718197081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBlYQc5iUSEyLsN1MwLmsYxIX56sUQw1nA6kryoNBCU=;
  b=Rflqw+7K1DDhFao6ggLubGJ6bBzsoMMxaNh6UWNBB+mgiCShU56VA0pS
   kM7Gko2V7eZhJLnKLYTkUv4nKJhgnAKU6wNF0L1iTDHZidTiUUAmNeOoE
   cHcgyidqsHmY8MBlvsAcCf0CCyp4gQX1p1rRRgXL8No3LwNJTPH2q3S8r
   TtStl2PaJ0xQNcChgXBkskpSrz43b7om0S7p+IqmaS2WvyuYMNwnk75Ox
   zjt6XNOplb46JmC46yAHzn7guZ2rudiwKPpdUipiR5rSup2DQK5xKc1/e
   lh7VhLB6f9huzdqvdvDW/fKEZ0ecZrzukA9n2XOGjLEGKdak7V9gel2+u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973759"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973759"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880823"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880823"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: allow ADD_STA not to be advertised by the firwmare
Date:   Tue, 13 Jun 2023 15:57:23 +0300
Message-Id: <20230613155501.4b9305510223.I7cc143d87186f8441e9b8435cc550b76734c7eef@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Newest firmware don't advertise the version of ADD_STA because it has
been replaced by another command. There are old firmware images
that also don't advertise it. Replace all the checks with a new
inline, and in that check for either MLD API or the ADD_STA
command version.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c       | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c        |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c |  4 ++--
 6 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d1a559c4c6b9..ed9370aac1b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1637,7 +1637,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	 * internal aux station for all aux activities that don't
 	 * requires a dedicated data queue.
 	 */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
+	if (!iwl_mvm_has_new_station_api(mvm->fw)) {
 		 /*
 		  * In old version the aux station uses mac id like other
 		  * station and not lmac id
@@ -1806,7 +1806,7 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[i], NULL);
 	}
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
+	if (!iwl_mvm_has_new_station_api(mvm->fw)) {
 		/*
 		 * Add auxiliary station for scanning.
 		 * Newer versions of this command implies that the fw uses
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8267ff08e38d..ee838dd60f4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1243,7 +1243,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 
 	/* async_handlers_wk is now blocked */
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12)
+	if (!iwl_mvm_has_new_station_api(mvm->fw))
 		iwl_mvm_rm_aux_sta(mvm);
 
 	iwl_mvm_stop_device(mvm);
@@ -4521,7 +4521,7 @@ static int iwl_mvm_add_aux_sta_for_hs20(struct iwl_mvm *mvm, u32 lmac_id)
 		return -EINVAL;
 	}
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12) {
+	if (iwl_mvm_has_new_station_api(mvm->fw)) {
 		ret = iwl_mvm_add_aux_sta(mvm, lmac_id);
 		WARN(ret, "Failed to allocate aux station");
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8043f5fd26c7..d8d6681e9411 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1436,6 +1436,12 @@ static inline bool iwl_mvm_has_mld_api(const struct iwl_fw *fw)
 			   IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT);
 }
 
+static inline bool iwl_mvm_has_new_station_api(const struct iwl_fw *fw)
+{
+	return iwl_mvm_has_mld_api(fw) ||
+	       iwl_fw_lookup_cmd_ver(fw, ADD_STA, 0) >= 12;
+}
+
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
 {
 	/* TODO - replace with TLV once defined */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 175615755d9d..d7ac9ddbcfba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -647,7 +647,7 @@ static void iwl_mvm_scan_fill_tx_cmd(struct iwl_mvm *mvm,
 							   NL80211_BAND_2GHZ,
 							   no_cck);
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
+	if (!iwl_mvm_has_new_station_api(mvm->fw)) {
 		tx_cmd[0].sta_id = mvm->aux_sta.sta_id;
 		tx_cmd[1].sta_id = mvm->aux_sta.sta_id;
 
@@ -1084,7 +1084,7 @@ static void iwl_mvm_fill_scan_config_v1(struct iwl_mvm *mvm, void *config,
 	memcpy(&cfg->mac_addr, &mvm->addresses[0].addr, ETH_ALEN);
 
 	/* This function should not be called when using ADD_STA ver >=12 */
-	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12);
+	WARN_ON_ONCE(iwl_mvm_has_new_station_api(mvm->fw));
 
 	cfg->bcast_sta_id = mvm->aux_sta.sta_id;
 	cfg->channel_flags = channel_flags;
@@ -1135,7 +1135,7 @@ static void iwl_mvm_fill_scan_config_v2(struct iwl_mvm *mvm, void *config,
 	memcpy(&cfg->mac_addr, &mvm->addresses[0].addr, ETH_ALEN);
 
 	/* This function should not be called when using ADD_STA ver >=12 */
-	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12);
+	WARN_ON_ONCE(iwl_mvm_has_new_station_api(mvm->fw));
 
 	cfg->bcast_sta_id = mvm->aux_sta.sta_id;
 	cfg->channel_flags = channel_flags;
@@ -1250,7 +1250,7 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 
 	memset(&cfg, 0, sizeof(cfg));
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
+	if (!iwl_mvm_has_new_station_api(mvm->fw)) {
 		cfg.bcast_sta_id = mvm->aux_sta.sta_id;
 	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, SCAN_CFG_CMD, 0) < 5) {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 5e11b101d02e..ff1ce990a9d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2015, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2015, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1679,7 +1679,7 @@ static int iwl_mvm_add_int_sta_common(struct iwl_mvm *mvm,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.sta_id = sta->sta_id;
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12 &&
+	if (iwl_mvm_has_new_station_api(mvm->fw) &&
 	    sta->type == IWL_STA_AUX_ACTIVITY)
 		cmd.mac_id_n_color = cpu_to_le32(mac_id);
 	else
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 6b7b6250f1bb..5f0e7144a951 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -103,7 +103,7 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 		/* In newer version of this command an aux station is added only
 		 * in cases of dedicated tx queue and need to be removed in end
 		 * of use */
-		if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12)
+		if (iwl_mvm_has_new_station_api(mvm->fw))
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
-- 
2.38.1

