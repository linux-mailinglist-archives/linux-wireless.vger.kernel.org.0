Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840B03F8F25
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbhHZTsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 15:48:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33430 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243567AbhHZTsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 15:48:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJLLt-002XB4-RI; Thu, 26 Aug 2021 22:47:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 22:47:40 +0300
Message-Id: <iwlwifi.20210826224715.87bc9e45c40b.I770493dc4a293ed8bdf059518e94dccf5dd1b3a7@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826194748.826360-1-luca@coelho.fi>
References: <20210826194748.826360-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 04/12] iwlwifi: mvm: introduce iwl_stored_beacon_notif_v3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

The new version sends station id in the notification. It's still not
used, but need to adjust the code since the offset of the data was
changed.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/offload.h   | 31 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 26 ++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index f06214d418aa..5204aa94e72a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2012-2014 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
+ * Copyright (C) 2021 Intel Corporation
  */
 #ifndef __iwl_fw_api_offload_h__
 #define __iwl_fw_api_offload_h__
@@ -20,7 +21,7 @@ enum iwl_prot_offload_subcmd_ids {
 #define MAX_STORED_BEACON_SIZE 600
 
 /**
- * struct iwl_stored_beacon_notif - Stored beacon notification
+ * struct iwl_stored_beacon_notif_common - Stored beacon notif common fields
  *
  * @system_time: system time on air rise
  * @tsf: TSF on air rise
@@ -29,9 +30,8 @@ enum iwl_prot_offload_subcmd_ids {
  * @channel: channel this beacon was received on
  * @rates: rate in ucode internal format
  * @byte_count: frame's byte count
- * @data: beacon data, length in @byte_count
  */
-struct iwl_stored_beacon_notif {
+struct iwl_stored_beacon_notif_common {
 	__le32 system_time;
 	__le64 tsf;
 	__le32 beacon_timestamp;
@@ -39,7 +39,32 @@ struct iwl_stored_beacon_notif {
 	__le16 channel;
 	__le32 rates;
 	__le32 byte_count;
+} __packed;
+
+/**
+ * struct iwl_stored_beacon_notif - Stored beacon notification
+ *
+ * @common: fields common for all versions
+ * @data: beacon data, length in @byte_count
+ */
+struct iwl_stored_beacon_notif_v2 {
+	struct iwl_stored_beacon_notif_common common;
 	u8 data[MAX_STORED_BEACON_SIZE];
 } __packed; /* WOWLAN_STROED_BEACON_INFO_S_VER_2 */
 
+/**
+ * struct iwl_stored_beacon_notif_v3 - Stored beacon notification
+ *
+ * @common: fields common for all versions
+ * @sta_id: station for which the beacon was received
+ * @reserved: reserved for alignment
+ * @data: beacon data, length in @byte_count
+ */
+struct iwl_stored_beacon_notif_v3 {
+	struct iwl_stored_beacon_notif_common common;
+	u8 sta_id;
+	u8 reserved[3];
+	u8 data[MAX_STORED_BEACON_SIZE];
+} __packed; /* WOWLAN_STROED_BEACON_INFO_S_VER_3 */
+
 #endif /* __iwl_fw_api_offload_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 2fbc1a3bbdca..1ebd4654d18e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1432,14 +1432,34 @@ void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
-	struct iwl_stored_beacon_notif *sb = (void *)pkt->data;
+	struct iwl_stored_beacon_notif_common *sb = (void *)pkt->data;
 	struct ieee80211_rx_status rx_status;
 	struct sk_buff *skb;
+	u8 *data;
 	u32 size = le32_to_cpu(sb->byte_count);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+					STORED_BEACON_NTF, 0);
 
-	if (size == 0 || pkt_len < struct_size(sb, data, size))
+	if (size == 0)
 		return;
 
+	/* handle per-version differences */
+	if (ver <= 2) {
+		struct iwl_stored_beacon_notif_v2 *sb_v2 = (void *)pkt->data;
+
+		if (pkt_len < struct_size(sb_v2, data, size))
+			return;
+
+		data = sb_v2->data;
+	} else {
+		struct iwl_stored_beacon_notif_v3 *sb_v3 = (void *)pkt->data;
+
+		if (pkt_len < struct_size(sb_v3, data, size))
+			return;
+
+		data = sb_v3->data;
+	}
+
 	skb = alloc_skb(size, GFP_ATOMIC);
 	if (!skb) {
 		IWL_ERR(mvm, "alloc_skb failed\n");
@@ -1460,7 +1480,7 @@ void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 					       rx_status.band);
 
 	/* copy the data */
-	skb_put_data(skb, sb->data, size);
+	skb_put_data(skb, data, size);
 	memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
 
 	/* pass it as regular rx to mac80211 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 8ce937f8445a..6f60018feed1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -373,7 +373,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       struct iwl_mfu_assert_dump_notif),
 	RX_HANDLER_GRP(PROT_OFFLOAD_GROUP, STORED_BEACON_NTF,
 		       iwl_mvm_rx_stored_beacon_notif, RX_HANDLER_SYNC,
-		       struct iwl_stored_beacon_notif),
+		       struct iwl_stored_beacon_notif_v2),
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MU_GROUP_MGMT_NOTIF,
 		       iwl_mvm_mu_mimo_grp_notif, RX_HANDLER_SYNC,
 		       struct iwl_mu_group_mgmt_notif),
-- 
2.33.0

