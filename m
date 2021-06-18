Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461613AC5AE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhFRIFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48090 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233009AbhFRIEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:04:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RQ-001YIf-Ln; Fri, 18 Jun 2021 11:01:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:18 +0300
Message-Id: <iwlwifi.20210618105614.3d488885f77c.Ib97a2bc57c1e9fb98927dc6f802568db313abe3b@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/10] iwlwifi: mvm: fill phy_data.d1 for no-data RX
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't fill in phy_data.d1 in no-data RX, and thus we
pretend some data is actually filled in radiotap when it
isn't or has default (zero) values.

Fill in phy_data.d1 appropriately, and while at it also
move the info_type initialization into the initializer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 8e26422ca326..c0babb8d5b5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -2001,8 +2001,10 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct sk_buff *skb;
 	u8 channel, energy_a, energy_b;
 	struct iwl_mvm_rx_phy_data phy_data = {
+		.info_type = le32_get_bits(desc->phy_info[1],
+					   IWL_RX_PHY_DATA1_INFO_TYPE_MASK),
 		.d0 = desc->phy_info[0],
-		.info_type = IWL_RX_PHY_INFO_TYPE_NONE,
+		.d1 = desc->phy_info[1],
 	};
 
 	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*desc)))
@@ -2015,10 +2017,6 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	energy_b = (rssi & RX_NO_DATA_CHAIN_B_MSK) >> RX_NO_DATA_CHAIN_B_POS;
 	channel = (rssi & RX_NO_DATA_CHANNEL_MSK) >> RX_NO_DATA_CHANNEL_POS;
 
-	phy_data.info_type =
-		le32_get_bits(desc->phy_info[1],
-			      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
-
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
 	 */
-- 
2.32.0

