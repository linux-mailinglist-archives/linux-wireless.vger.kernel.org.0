Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E376424B5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLEIgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiLEIgd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A812619
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229392; x=1701765392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+76k4nNRlIaJyulq9UarqjhrsrSqeWdbMuwKWAY12Q=;
  b=j+ui2iuorP/iU12iVSKqn+SlWHjwYs4w8QWsUqEkjWo0WII6gKyJ2i6k
   08cUhjoLsCcTqYeSVkwAdvafcRXVN/MMw04N36D6Gq7QmbAJbo1NyAvre
   VCrlL2VMjqT06DoCTgaOw2ZoW8h33MypGaPvOTKanWJUAnO62CObdV/E9
   XuxQs02W7Y1ZJuKoBs6CZrkxcqRDt34kRdMwKPxfoSHl1KEdN35NPKnU2
   KSkS+TrcIxYe8KTWz2SJGRDlBFVY9W5K3mcNSyX3zJZc0Oo20sJ45MW8z
   gp81r+XmrlV8N/ucLG+tAS1CHBY5mUTRXBukPa9tAk6AV8fUIsSbfAeAZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323083"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100374"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100374"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:18 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: mvm: don't access packet before checking len
Date:   Mon,  5 Dec 2022 10:35:40 +0200
Message-Id: <20221205102808.934da230c698.Ib56f11bbc8978e15d38394336a929cb4996ba39e@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently in sniffer mode we access pkt fields before checking that
the frame has the length to access it. Fix this by moving the check
to before the access.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 5f782ca1e254..97b67270f384 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2066,22 +2066,30 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct ieee80211_rx_status *rx_status;
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_rx_no_data *desc = (void *)pkt->data;
-	u32 rssi = le32_to_cpu(desc->rssi);
-	u32 info_type = le32_to_cpu(desc->info) & RX_NO_DATA_INFO_TYPE_MSK;
+	u32 rssi;
+	u32 info_type;
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
-	struct iwl_mvm_rx_phy_data phy_data = {
-		.d0 = desc->phy_info[0],
-		.d1 = desc->phy_info[1],
-		.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD,
-		.gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time),
-		.rate_n_flags = le32_to_cpu(desc->rate),
-		.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK),
-		.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK),
-		.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK),
-	};
+	struct iwl_mvm_rx_phy_data phy_data;
 	u32 format;
 
+	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
+		return;
+
+	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(struct iwl_rx_no_data)))
+		return;
+
+	rssi = le32_to_cpu(desc->rssi);
+	info_type = le32_to_cpu(desc->info) & RX_NO_DATA_INFO_TYPE_MSK;
+	phy_data.d0 = desc->phy_info[0];
+	phy_data.d1 = desc->phy_info[1];
+	phy_data.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
+	phy_data.gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time);
+	phy_data.rate_n_flags = le32_to_cpu(desc->rate);
+	phy_data.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK);
+	phy_data.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK);
+	phy_data.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
+
 	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
 				    RX_NO_DATA_NOTIF, 0) < 2) {
 		IWL_DEBUG_DROP(mvm, "Got an old rate format. Old rate: 0x%x\n",
@@ -2093,12 +2101,6 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
-	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*desc)))
-		return;
-
-	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
-		return;
-
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
 	 */
-- 
2.35.3

