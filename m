Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41067D88C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjAZWgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjAZWgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293223C39
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772597; x=1706308597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A21FMTUGMJpXDmqJCOp8QRmBfKdQgefyVNui2Bxs/vk=;
  b=Gf2Klg7pGNNLIT4qMV9ZyBe+k56wZoREnJUPwjXUWN5+jEeJ5NzJcsEE
   YUG8EBEOvyDWUxRd9WaCdBn8hZm6VM4GXu9a5cyhb2Ov2B0tLCGG1JuN+
   dFNjpoST9qtYpRdBKxJWvQ5vGc2e1ObmIpk3z7gcIfAWAjYjC3cOx5e+m
   Cm06V9QXCf4gqxrgCmjwxB+AaTI7ypIKfLZfpmf0OreSJ78H9iAlaT6hh
   3oKlm055wkOHr6CaSqZb6ycKdalx5j5AAZb3Mx0Lhsfr8dXsRbPNM+Ag9
   C+L50D2l7CC7LINWo/bztCSThm6m9YnbdFc8M/7Crarzrlwm8uKAGZDaz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098664"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986260"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986260"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:14 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/12] wifi: iwlwifi: rx: add sniffer support for EHT mode
Date:   Fri, 27 Jan 2023 00:28:15 +0200
Message-Id: <20230127002430.ba9b364fbacf.I469af2a07b3ff51cbd8d67e572478f4c56ce22ba@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Start by adding a parsing option for all the new fields coming from FW
and checking that we have the right version for parsing EHT.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 28 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 18 +++++++++++-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 6de50868866f..b74ef26a4e7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -88,7 +88,7 @@ enum iwl_data_path_subcmd_ids {
 	MONITOR_NOTIF = 0xF4,
 
 	/**
-	 * @RX_NO_DATA_NOTIF: &struct iwl_rx_no_data
+	 * @RX_NO_DATA_NOTIF: &struct iwl_rx_no_data or &struct iwl_rx_no_data_ver_3
 	 */
 	RX_NO_DATA_NOTIF = 0xF5,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 74a01888715b..ffa9f3409a9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -645,6 +645,7 @@ struct iwl_rx_mpdu_desc {
 
 #define RX_NO_DATA_RX_VEC0_HE_NSTS_MSK	0x03800000
 #define RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK	0x38000000
+#define RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK	0x00f00000
 
 /**
  * struct iwl_rx_no_data - RX no data descriptor
@@ -670,6 +671,33 @@ struct iwl_rx_no_data {
 } __packed; /* RX_NO_DATA_NTFY_API_S_VER_1,
 	       RX_NO_DATA_NTFY_API_S_VER_2 */
 
+/**
+ * struct iwl_rx_no_data_ver_3 - RX no data descriptor
+ * @info: 7:0 frame type, 15:8 RX error type
+ * @rssi: 7:0 energy chain-A,
+ *	15:8 chain-B, measured at FINA time (FINA_ENERGY), 16:23 channel
+ * @on_air_rise_time: GP2 during on air rise
+ * @fr_time: frame time
+ * @rate: rate/mcs of frame
+ * @phy_info: &enum iwl_rx_phy_data0 and &enum iwl_rx_phy_info_type
+ * @rx_vec: DW-12:9 raw RX vectors from DSP according to modulation type.
+ *	for VHT: OFDM_RX_VECTOR_SIGA1_OUT, OFDM_RX_VECTOR_SIGA2_OUT
+ *	for HE: OFDM_RX_VECTOR_HE_SIGA1_OUT, OFDM_RX_VECTOR_HE_SIGA2_OUT
+ *	for EHT: OFDM_RX_VECTOR_USIG_A1_OUT, OFDM_RX_VECTOR_USIG_A2_OUT,
+ *	OFDM_RX_VECTOR_EHT_OUT, OFDM_RX_VECTOR_EHT_USER_FIELD_OUT
+ */
+struct iwl_rx_no_data_ver_3 {
+	__le32 info;
+	__le32 rssi;
+	__le32 on_air_rise_time;
+	__le32 fr_time;
+	__le32 rate;
+	__le32 phy_info[2];
+	__le32 rx_vec[4];
+} __packed; /* RX_NO_DATA_NTFY_API_S_VER_1,
+	       RX_NO_DATA_NTFY_API_S_VER_2
+	       RX_NO_DATA_NTFY_API_S_VER_3 */
+
 struct iwl_frame_release {
 	u8 baid;
 	u8 reserved;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 99a18bb0c968..6048f5e2f8a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2066,7 +2066,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 {
 	struct ieee80211_rx_status *rx_status;
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_rx_no_data *desc = (void *)pkt->data;
+	struct iwl_rx_no_data_ver_3 *desc = (void *)pkt->data;
 	u32 rssi;
 	u32 info_type;
 	struct ieee80211_sta *sta = NULL;
@@ -2102,6 +2102,18 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
+	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+				    RX_NO_DATA_NOTIF, 0) >= 3) {
+		if (unlikely(iwl_rx_packet_payload_len(pkt) <
+		    sizeof(struct iwl_rx_no_data_ver_3)))
+		/* invalid len for ver 3 */
+			return;
+	} else {
+		if (format == RATE_MCS_EHT_MSK)
+			/* no support for EHT before version 3 API */
+			return;
+	}
+
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
 	 */
@@ -2153,6 +2165,10 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
 		break;
+	case RATE_MCS_EHT_MSK:
+		rx_status->nss =
+			le32_get_bits(desc->rx_vec[2],
+				      RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK) + 1;
 	}
 
 	rcu_read_lock();
-- 
2.38.1

