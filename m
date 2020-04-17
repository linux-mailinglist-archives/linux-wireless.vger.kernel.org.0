Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6516E1AD6FF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgDQHI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:08:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56376 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728625AbgDQHI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:08:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPL6u-000KNJ-7G; Fri, 17 Apr 2020 10:08:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 10:08:10 +0300
Message-Id: <iwlwifi.20200417100405.1f9142751fbc.Ifbfd0f928a0a761110b8f4f2ca5483a61fb21131@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417070814.2044774-1-luca@coelho.fi>
References: <20200417070814.2044774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 v5.7 2/6] iwlwifi: mvm: beacon statistics shouldn't go backwards
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We reset statistics also in case that we didn't reassoc so in
this cases keep last beacon counter.

Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 5ee33c8ae9d2..77b8def26edb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -566,6 +566,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 struct iwl_mvm_stat_data {
 	struct iwl_mvm *mvm;
+	__le32 flags;
 	__le32 mac_id;
 	u8 beacon_filter_average_energy;
 	void *general;
@@ -606,6 +607,13 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 			-general->beacon_average_energy[vif_id];
 	}
 
+	/* make sure that beacon statistics don't go backwards with TCM
+	 * request to clear statistics
+	 */
+	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
+		mvmvif->beacon_stats.accu_num_beacons +=
+			mvmvif->beacon_stats.num_beacons;
+
 	if (mvmvif->id != id)
 		return;
 
@@ -763,6 +771,7 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 
 		flags = stats->flag;
 	}
+	data.flags = flags;
 
 	iwl_mvm_rx_stats_check_trigger(mvm, pkt);
 
-- 
2.25.1

