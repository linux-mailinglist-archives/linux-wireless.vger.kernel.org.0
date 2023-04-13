Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF06E1449
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDMSlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDMSll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E36595
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411299; x=1712947299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P720BW9jGkirLg6b3SaUyBE1FTyc/3g1+gSs8BzHdPs=;
  b=C9DHYtkhGF3TsWnV7cugev0yhUqOLR0QyIIe//zILCn3/tCX+ozolaRK
   pqX2o/DjoJ+15WtohbiiZ4uvOyLz+yUnCyY1gyy207NVSY3P8TKn0cslN
   k/zDm+1sjd4tNPar8RKJpF4ZrIqvNRTc47E6G3XmXMh6tQeqZzE+TGwSM
   I8eE3W/E6PC8IdZnkSCcif0Voa0GdIyY9yHulPbb+UaoVQGfUIVSUXGMi
   Ssxo+2jorKPvuZqTn72/Ma2WVeO3nIBavVB0o2YT6oWfTPFauPkMykk/k
   OcTYxmfhsRVyc/d8Ux8YC+qWMux+IcNVbFSaDuQQMiaAFXYj05Qg4shem
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127030"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127030"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984352"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984352"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: support wowlan info notification version 2
Date:   Thu, 13 Apr 2023 21:40:27 +0300
Message-Id: <20230413213309.3b53213b10d4.Ibf2f15aca614def2d262dd267d1aad65931b58f1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

As part of version 2 we don't need to have wake_packet_bufsize
and wake_packet_length. The first one is already calculated by the driver,
the latter is sent as part of the wake packet notification.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 37 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 35 +++++++++++++++++-
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index df0833890e55..8a613e150a02 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -767,7 +767,7 @@ struct iwl_wowlan_status_v12 {
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_12 */
 
 /**
- * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * struct iwl_wowlan_info_notif_v1 - WoWLAN information notification
  * @gtk: GTK data
  * @igtk: IGTK data
  * @replay_ctr: GTK rekey replay counter
@@ -785,7 +785,7 @@ struct iwl_wowlan_status_v12 {
  * @station_id: station id
  * @reserved2: reserved
  */
-struct iwl_wowlan_info_notif {
+struct iwl_wowlan_info_notif_v1 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
@@ -803,6 +803,39 @@ struct iwl_wowlan_info_notif {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @reserved1: reserved
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @reserved2: reserved
+ */
+struct iwl_wowlan_info_notif {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 reserved1;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 reserved2[2];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
+
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
  * @wake_packet_length: wakeup packet length
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 40adf789c8fc..bf80b1d093a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2017,6 +2017,12 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 {
 	u32 i;
 
+	if (!data) {
+		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
+		status = NULL;
+		return;
+	}
+
 	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
@@ -2705,10 +2711,33 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_d3_data *d3_data = data;
 	u32 len;
 	int ret;
+	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mvm->fw,
+						      PROT_OFFLOAD_GROUP,
+						      WOWLAN_INFO_NOTIFICATION,
+						      IWL_FW_CMD_VER_UNKNOWN);
+
 
 	switch (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)) {
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
-		struct iwl_wowlan_info_notif *notif = (void *)pkt->data;
+		struct iwl_wowlan_info_notif *notif;
+
+		if (wowlan_info_ver < 2) {
+			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
+
+			notif = kmemdup(notif_v1,
+					offsetofend(struct iwl_wowlan_info_notif,
+						    received_beacons),
+					GFP_ATOMIC);
+
+			if (!notif)
+				return false;
+
+			notif->tid_tear_down = notif_v1->tid_tear_down;
+			notif->station_id = notif_v1->station_id;
+
+		} else {
+			notif = (void *)pkt->data;
+		}
 
 		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
 			/* We might get two notifications due to dual bss */
@@ -2721,6 +2750,10 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
 						len);
+
+		if (wowlan_info_ver < 2)
+			kfree(notif);
+
 		if (d3_data->status &&
 		    d3_data->status->wakeup_reasons & IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT)
 			/* We are supposed to get also wake packet notif */
-- 
2.38.1

