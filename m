Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0C72FDB8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjFNMAH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbjFNL72 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 07:59:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933912109
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686743966; x=1718279966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oc1w2oukMUa6cJqd90js9VQ8wN0s1kBQRbLOLcwYWJE=;
  b=g2m3a8KWyGQdalWptrA3oNNlu1UwY7RXMWjTuCdVaoPDP/I13UOkoOl2
   FRZl0OL0UfDkkmNmniD5GS3cMr6CEV+SIZeOIZ9vQIWazeS7H89Ld1FGc
   HCwptyhgLs8nhd25SpsawuFX5/hl+W5kV/VqDXbm+XpzGVhOWf8iUfMKV
   rsiZosgpme5bpmqin8iBdqdHYbdRxUattvW27v4bjGOP7iwLxZKsiKs6U
   5F+WwvBxv6JxZ/oK5gP93SfiNY3jPbWIcITCuDTQw/q8dBEH6EdvBqBRx
   Ds91nxbwqQjYH1LNUAg8PLDEuoVVPB3F2Z+u2ABtANi4lRxULC6p+f1Gv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348252518"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="348252518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 04:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="836249130"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="836249130"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 04:59:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 10/20] wifi: iwlwifi: mvm: disable new TX csum mode completely
Date:   Wed, 14 Jun 2023 14:59:05 +0300
Message-Id: <20230614145722.ddbc16c4affe.Ia6921e4b8a9624d4f57489ac775105ed0e400313@changeid>
X-Mailer: git-send-email 2.38.1
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

From: Johannes Berg <johannes.berg@intel.com>

The hardware isn't going to get fixed, so this mode cannot work
in the foreseeable future. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 13 +---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 --
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 14 -----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 60 ++-----------------
 4 files changed, 7 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 97edf5477ba7..842360b1e995 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_tx_h__
@@ -177,17 +177,6 @@ enum iwl_tx_offload_assist_flags_pos {
 #define IWL_TX_CMD_OFFLD_MH_MASK	0x1f
 #define IWL_TX_CMD_OFFLD_IP_HDR_MASK	0x3f
 
-enum iwl_tx_offload_assist_bz {
-	IWL_TX_CMD_OFFLD_BZ_RESULT_OFFS		= 0x000003ff,
-	IWL_TX_CMD_OFFLD_BZ_START_OFFS		= 0x001ff800,
-	IWL_TX_CMD_OFFLD_BZ_MH_LEN		= 0x07c00000,
-	IWL_TX_CMD_OFFLD_BZ_MH_PAD		= 0x08000000,
-	IWL_TX_CMD_OFFLD_BZ_AMSDU		= 0x10000000,
-	IWL_TX_CMD_OFFLD_BZ_ZERO2ONES		= 0x20000000,
-	IWL_TX_CMD_OFFLD_BZ_ENABLE_CSUM		= 0x40000000,
-	IWL_TX_CMD_OFFLD_BZ_PARTIAL_CSUM	= 0x80000000,
-};
-
 /* TODO: complete documentation for try_cnt and btkill_cnt */
 /**
  * struct iwl_tx_cmd - TX command struct to FW
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ee838dd60f4e..4c0a9cc9ff7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6142,10 +6142,6 @@ static bool iwl_mvm_mac_can_aggregate(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	if (iwl_mvm_has_new_tx_csum(mvm))
-		return iwl_mvm_tx_csum_bz(mvm, head, true) ==
-		       iwl_mvm_tx_csum_bz(mvm, skb, true);
-
 	/* For now don't aggregate IPv6 in AMSDU */
 	if (skb->protocol != htons(ETH_P_IP))
 		return false;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d8d6681e9411..6607409bd8ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1543,19 +1543,6 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_CAPA_CTDP_SUPPORT);
 }
 
-static inline bool iwl_mvm_has_new_tx_csum(struct iwl_mvm *mvm)
-{
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
-		return false;
-
-	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	    CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	    mvm->trans->hw_rev_step <= SILICON_B_STEP)
-		return false;
-
-	return true;
-}
-
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_gen2_tx_fifo[];
 
@@ -1633,7 +1620,6 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 				    struct ieee80211_sta *sta,
 				    unsigned int tid);
-u32 iwl_mvm_tx_csum_bz(struct iwl_mvm *mvm, struct sk_buff *skb, bool amsdu);
 
 #ifdef CONFIG_IWLWIFI_DEBUG
 const char *iwl_mvm_get_tx_fail_reason(u32 status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 06fb4b72ee9b..6f34208a6307 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -40,8 +40,9 @@ iwl_mvm_bar_check_trigger(struct iwl_mvm *mvm, const u8 *addr,
 #define OPT_HDR(type, skb, off) \
 	(type *)(skb_network_header(skb) + (off))
 
-static u16 iwl_mvm_tx_csum_pre_bz(struct iwl_mvm *mvm, struct sk_buff *skb,
-				  struct ieee80211_tx_info *info, bool amsdu)
+static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
+			   struct ieee80211_tx_info *info,
+			   bool amsdu)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
@@ -141,54 +142,6 @@ static u16 iwl_mvm_tx_csum_pre_bz(struct iwl_mvm *mvm, struct sk_buff *skb,
 	return offload_assist;
 }
 
-u32 iwl_mvm_tx_csum_bz(struct iwl_mvm *mvm, struct sk_buff *skb, bool amsdu)
-{
-	struct ieee80211_hdr *hdr = (void *)skb->data;
-	u32 offload_assist = IWL_TX_CMD_OFFLD_BZ_PARTIAL_CSUM;
-	unsigned int hdrlen = ieee80211_hdrlen(hdr->frame_control);
-	unsigned int csum_start = skb_checksum_start_offset(skb);
-
-	offload_assist |= u32_encode_bits(hdrlen / 2,
-					  IWL_TX_CMD_OFFLD_BZ_MH_LEN);
-	if (amsdu)
-		offload_assist |= IWL_TX_CMD_OFFLD_BZ_AMSDU;
-	else if (hdrlen % 4)
-		/* padding is inserted later in transport */
-		offload_assist |= IWL_TX_CMD_OFFLD_BZ_MH_PAD;
-
-	if (skb->ip_summed != CHECKSUM_PARTIAL)
-		return offload_assist;
-
-	offload_assist |= IWL_TX_CMD_OFFLD_BZ_ENABLE_CSUM |
-			  IWL_TX_CMD_OFFLD_BZ_ZERO2ONES;
-
-	/*
-	 * mac80211 will always calculate checksum in software for
-	 * non-fast-xmit, and so we can only do offloaded checksum
-	 * for fast-xmit frames. In this case, we always have the
-	 * RFC 1042 header present. skb_checksum_start_offset()
-	 * returns the offset from the beginning, but the hardware
-	 * needs it from after the header & SNAP header.
-	 */
-	csum_start -= hdrlen + 8;
-
-	offload_assist |= u32_encode_bits(csum_start,
-					  IWL_TX_CMD_OFFLD_BZ_START_OFFS);
-	offload_assist |= u32_encode_bits(csum_start + skb->csum_offset,
-					  IWL_TX_CMD_OFFLD_BZ_RESULT_OFFS);
-
-	return offload_assist;
-}
-
-static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
-			   struct ieee80211_tx_info *info,
-			   bool amsdu)
-{
-	if (!iwl_mvm_has_new_tx_csum(mvm))
-		return iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu);
-	return iwl_mvm_tx_csum_bz(mvm, skb, amsdu);
-}
-
 /*
  * Sets most of the Tx cmd's fields
  */
@@ -288,7 +241,7 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 	tx_cmd->sta_id = sta_id;
 
 	tx_cmd->offload_assist =
-		cpu_to_le16(iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu));
+		cpu_to_le16(iwl_mvm_tx_csum(mvm, skb, info, amsdu));
 }
 
 static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
@@ -612,9 +565,8 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
 		} else {
 			struct iwl_tx_cmd_gen2 *cmd = (void *)dev_cmd->payload;
-			u16 offload_assist = iwl_mvm_tx_csum_pre_bz(mvm, skb,
-								    info,
-								    amsdu);
+			u16 offload_assist = iwl_mvm_tx_csum(mvm, skb,
+							     info, amsdu);
 
 			cmd->offload_assist = cpu_to_le16(offload_assist);
 
-- 
2.38.1

