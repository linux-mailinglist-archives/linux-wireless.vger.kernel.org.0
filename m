Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59072CAB6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjFLPwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjFLPwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:52:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB24610E3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585141; x=1718121141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Od8OEAKzgSmzxF3jRO9uPZD3XabZVs9vs48Wed/8HqU=;
  b=j02MgfMHWxGc8UqiXrpFcW9CXxiqLdmDhSjbCKTwwwIDlfOVTEwWJbRg
   G5lq19Nb4bPkMutmwvsN9oM7ArAEPuTnZlhTvkUQMHqvoMKYhZDGzsG5o
   SbvRM8b+YEK3loSA2hMJgzENcYUxS2A5QLsTndtAMnxVjktXuqd7SaHUf
   cQpE7aPYtcyGKhwxzkoeldUUHFUMxDCXnKEnO96D3gFIObTZo3SDYsNpq
   33fTwq0SdejmMmNZ5D+zAxLkLzYMchoL0C7kD0wdJ9/WiS73MusB9WmHa
   6VWwx0+b2Tb0ZRrn8XPNXB9gc34PSCQfRZuwP7Ghb51JV/8aTCMw6V5vc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674301"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674301"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499408"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499408"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: pass ESR parameters to the firmware
Date:   Mon, 12 Jun 2023 18:51:14 +0300
Message-Id: <20230612184434.09fa06820d03.Ie9a9fd37d4948f8c5dd91161de254184b1a093c0@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware needs to know the esr_transtition_timeout to time the
transition between EMLSR and single radio with the AP.
Add the EMLSR support bit to the wiphy extended capabilities so that
it'll be sent in our association request frame. There are some
limitations in the implementation so we cannot use zero
padding/transition delay; fill the correct values.

Also, feed the medium_synchronization delay to the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   | 11 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c    | 12 ++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index a4cb24934a01..184db5a6f06f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -236,7 +236,7 @@ struct iwl_mac_low_latency_cmd {
  *	Available only from version 2 of the command.
  *	This values comes from the EMLSR transition delay in the EML
  *	Capabilities subfield.
- * @reserved: alignment
+ * @medium_sync_delay: the value as it appeasr in P802.11be_D2.2 Figure 9-1002j.
  * @assoc_id: unique ID assigned by the AP during association
  * @reserved1: alignment
  * @data_policy: see &enum iwl_mac_data_policy
@@ -247,7 +247,7 @@ struct iwl_mac_low_latency_cmd {
 struct iwl_mac_client_data {
 	u8 is_assoc;
 	u8 esr_transition_timeout;
-	__le16 reserved;
+	__le16 medium_sync_delay;
 
 	__le16 assoc_id;
 	__le16 reserved1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 96577dcc22b7..f7e2ca7eebf0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -245,12 +245,21 @@ static const u8 tm_if_types_ext_capa_sta[] = {
 /* Additional interface types for which extended capabilities are
  * specified separately
  */
+
+#define IWL_MVM_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
+				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
+					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
+					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+
 static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 	{
 		.iftype = NL80211_IFTYPE_STATION,
 		.extended_capabilities = he_if_types_ext_capa_sta,
 		.extended_capabilities_mask = he_if_types_ext_capa_sta,
 		.extended_capabilities_len = sizeof(he_if_types_ext_capa_sta),
+		/* relevant only if EHT is supported */
+		.eml_capabilities = IWL_MVM_EMLSR_CAPA,
 	},
 	{
 		.iftype = NL80211_IFTYPE_STATION,
@@ -258,7 +267,7 @@ static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 		.extended_capabilities_mask = tm_if_types_ext_capa_sta,
 		.extended_capabilities_len = sizeof(tm_if_types_ext_capa_sta),
 		/* relevant only if EHT is supported */
-		.eml_capabilities = IEEE80211_EML_CAP_EMLSR_SUPP,
+		.eml_capabilities = IWL_MVM_EMLSR_CAPA,
 	},
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 99bf71a2b690..0ff99deb0ae7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -96,6 +96,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 					u32 action, bool force_assoc_off)
 {
 	struct iwl_mac_config_cmd cmd = {};
+	u16 esr_transition_timeout;
 
 	WARN_ON(vif->type != NL80211_IFTYPE_STATION);
 
@@ -133,6 +134,17 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	}
 
 	cmd.client.assoc_id = cpu_to_le16(vif->cfg.aid);
+	if (ieee80211_vif_is_mld(vif)) {
+		esr_transition_timeout =
+			u16_get_bits(vif->cfg.eml_cap,
+				     IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
+
+		cmd.client.esr_transition_timeout =
+			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU,
+			      esr_transition_timeout);
+		cmd.client.medium_sync_delay =
+			cpu_to_le16(vif->cfg.eml_med_sync_delay);
+	}
 
 	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
 		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
-- 
2.38.1

