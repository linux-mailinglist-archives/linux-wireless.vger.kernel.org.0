Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B813D2D4516
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgLIPG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35514 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727313AbgLIPG6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:58 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11v-003Dg4-KK; Wed, 09 Dec 2020 17:05:24 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:14 +0200
Message-Id: <iwlwifi.20201209170243.ade5aa9e44b4.I4b7e72824d06dc0719a40021d933e29edfc14713@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/11] iwlwifi: mvm: validate notification size when waiting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When waiting for a notification and then processing it,
we also need to check the size of the data before we use
it. Most places do that already, but fix the remaining
ones to do it as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c | 16 +++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     | 10 ++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c b/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
index 312ae841f112..bad5659840a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014 Intel Corporation
+ * Copyright (C) 2005-2014, 2020 Intel Corporation
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
 #include <linux/slab.h>
@@ -147,13 +147,23 @@ IWL_EXPORT_SYMBOL(iwl_phy_db_free);
 int iwl_phy_db_set_section(struct iwl_phy_db *phy_db,
 			   struct iwl_rx_packet *pkt)
 {
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct iwl_calib_res_notif_phy_db *phy_db_notif =
 			(struct iwl_calib_res_notif_phy_db *)pkt->data;
-	enum iwl_phy_db_section_type type = le16_to_cpu(phy_db_notif->type);
-	u16 size  = le16_to_cpu(phy_db_notif->length);
+	enum iwl_phy_db_section_type type;
+	u16 size;
 	struct iwl_phy_db_entry *entry;
 	u16 chg_id = 0;
 
+	if (pkt_len < sizeof(*phy_db_notif))
+		return -EINVAL;
+
+	type = le16_to_cpu(phy_db_notif->type);
+	size = le16_to_cpu(phy_db_notif->length);
+
+	if (pkt_len < sizeof(*phy_db_notif) + size)
+		return -EINVAL;
+
 	if (!phy_db)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8f15f68ffc70..0637eb1cff4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -160,6 +160,7 @@ void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
 static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 			 struct iwl_rx_packet *pkt, void *data)
 {
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct iwl_mvm *mvm =
 		container_of(notif_wait, struct iwl_mvm, notif_wait);
 	struct iwl_mvm_alive_data *alive_data = data;
@@ -177,6 +178,9 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 				    UCODE_ALIVE_NTFY, 0) == 5) {
 		struct iwl_alive_ntf_v5 *palive;
 
+		if (pkt_len < sizeof(*palive))
+			return false;
+
 		palive = (void *)pkt->data;
 		umac = &palive->umac_data;
 		lmac1 = &palive->lmac_data[0];
@@ -194,6 +198,9 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	} else if (iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
 		struct iwl_alive_ntf_v4 *palive;
 
+		if (pkt_len < sizeof(*palive))
+			return false;
+
 		palive = (void *)pkt->data;
 		umac = &palive->umac_data;
 		lmac1 = &palive->lmac_data[0];
@@ -203,6 +210,9 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		   sizeof(struct iwl_alive_ntf_v3)) {
 		struct iwl_alive_ntf_v3 *palive3;
 
+		if (pkt_len < sizeof(*palive3))
+			return false;
+
 		palive3 = (void *)pkt->data;
 		umac = &palive3->umac_data;
 		lmac1 = &palive3->lmac_data;
-- 
2.29.2

