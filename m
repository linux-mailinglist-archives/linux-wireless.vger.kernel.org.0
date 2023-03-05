Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3056AAF70
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCEMR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCEMRy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E18126E6
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018666; x=1709554666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXzwdXPm3u2r9rFuoTR9QZOD49pBq5BrOexQ/9YBeKk=;
  b=mpIXPL4qpyBvBSQe7D4gcPzeXKaIKewPN9OLxWUFa9ySIBK8Qw6PaeW7
   yybk2lwbYOtida0L1y9NyIoEmA0C026a2HMfKR60miiopcJUuo9B/4Uv7
   NuUmLkOwo9JukmwnQNnG/Cl02cE4Fxrl4PzmSjDnKzBIRnLxg7JDnpatQ
   jy8DDTSQxDcHYFww4c+Fa5DDEiKTote7+zuTr23DiI1C0dAQ+eGCHsfzJ
   hHdSSJgUbHRUwupeJHDm1hrcITCrveRlyBVZnE5JlvPvAzquUX6FEioYE
   sZ66Wn01m+e3L0WJ5edk2KR1DBJx6iZS3oLGlbRLdw3hd3/Vckxtt475U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193300"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355237"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355237"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:42 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/21] wifi: iwlwifi: Do not include radiotap EHT user info if not needed
Date:   Sun,  5 Mar 2023 14:16:34 +0200
Message-Id: <20230305124407.ac6474ded9bd.I9655589e9afbacc16820f35f6f5d90c6a91b8b05@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Do not include user information in radtiotap EHT data for EHT sounding
NDP as the frame doesn't include the user specific field. Instead,
encode the NSS and the beamforming information in the EHT data.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 56 ++++++++++++-------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index a54548f1e940..d8dda72a5a5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1839,6 +1839,7 @@ static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	struct ieee80211_radiotap_eht *eht;
 	struct ieee80211_radiotap_eht_usig *usig;
+	size_t eht_len = sizeof(*eht);
 
 	u32 rate_n_flags = phy_data->rate_n_flags;
 	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
@@ -1848,8 +1849,10 @@ static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 	u32 bw;
 
 	/* u32 for 1 user_info */
-	eht = iwl_mvm_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT,
-				       sizeof(*eht) + sizeof(u32));
+	if (phy_data->with_data)
+		eht_len += sizeof(u32);
+
+	eht = iwl_mvm_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT, eht_len);
 
 	usig = iwl_mvm_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT_USIG,
 					sizeof(*usig));
@@ -1939,26 +1942,39 @@ static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 				    rx_status->eht.gi));
 	}
 
-	eht->user_info[0] |= cpu_to_le32
-		(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
-		 IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
-		 IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
-		 IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_KNOWN_O |
-		 IEEE80211_RADIOTAP_EHT_USER_INFO_DATA_FOR_USER);
-
-	if (rate_n_flags & RATE_MCS_BF_MSK)
-		eht->user_info[0] |=
-			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_O);
 
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+	if (!phy_data->with_data) {
+		eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_NSS_S |
+					  IEEE80211_RADIOTAP_EHT_KNOWN_BEAMFORMED_S);
+		eht->data[7] |=
+			le32_encode_bits(le32_get_bits(phy_data->rx_vec[2],
+						       RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK),
+						 IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
+		if (rate_n_flags & RATE_MCS_BF_MSK)
+			eht->data[7] |=
+				cpu_to_le32(IEEE80211_RADIOTAP_EHT_DATA7_BEAMFORMED_S);
+	} else {
 		eht->user_info[0] |=
-			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_CODING);
-
-	eht->user_info[0] |= cpu_to_le32
-		(FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS,
-			    FIELD_GET(RATE_VHT_MCS_RATE_CODE_MSK, rate_n_flags)) |
-		 FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O,
-			    FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags)));
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_KNOWN_O |
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_DATA_FOR_USER);
+
+		if (rate_n_flags & RATE_MCS_BF_MSK)
+			eht->user_info[0] |=
+				cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_O);
+
+		if (rate_n_flags & RATE_MCS_LDPC_MSK)
+			eht->user_info[0] |=
+				cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_CODING);
+
+		eht->user_info[0] |= cpu_to_le32
+			(FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS,
+				    FIELD_GET(RATE_VHT_MCS_RATE_CODE_MSK, rate_n_flags)) |
+			 FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O,
+				    FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags)));
+	}
 }
 
 static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
-- 
2.38.1

