Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01003169E6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBJPQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45288 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231810AbhBJPQL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD9-0049kS-9b; Wed, 10 Feb 2021 17:15:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:13 +0200
Message-Id: <iwlwifi.20210210171218.59f44e210096.I8f31968f6f7303255e212d869ca0131becd309aa@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlmvm: set properly NIC_NOT_ACK_ENABLED flag
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

The STA_CTXT_HE_NIC_NOT_ACK_ENABLED flag tells the firmware
whether *we* support ack-enabled.
So what should be checked is our *own* capability and not
the *peer's* capability.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h  |  5 +++++
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.h   |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 2d03d7bb5da5..93084bbad534 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -452,6 +452,10 @@ struct iwl_he_pkt_ext {
  *	enabled AGG, i.e. both BACK and non-BACK frames in a single AGG
  * @STA_CTXT_HE_MU_EDCA_CW: indicates that there is an element of MU EDCA
  *	parameter set, i.e. the backoff counters for trig-based ACs
+ * @STA_CTXT_HE_NIC_NOT_ACK_ENABLED: mark that the NIC doesn't support receiving
+ *	ACK-enabled AGG, (i.e. both BACK and non-BACK frames in single AGG).
+ *	If the NIC is not ACK_ENABLED it may use the EOF-bit in first non-0
+ *	len delim to determine if AGG or single.
  * @STA_CTXT_HE_RU_2MHZ_BLOCK: indicates that 26-tone RU OFDMA transmission are
  *      not allowed (as there are OBSS that might classify such transmissions as
  *      radar pulses).
@@ -466,6 +470,7 @@ enum iwl_he_sta_ctxt_flags {
 	STA_CTXT_HE_CONST_TRIG_RND_ALLOC	= BIT(10),
 	STA_CTXT_HE_ACK_ENABLED			= BIT(11),
 	STA_CTXT_HE_MU_EDCA_CW			= BIT(12),
+	STA_CTXT_HE_NIC_NOT_ACK_ENABLED		= BIT(13),
 	STA_CTXT_HE_RU_2MHZ_BLOCK		= BIT(14),
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index aca1ccdd1aa4..e1f5a9741850 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -80,4 +80,5 @@ void iwl_nvm_fixups(u32 hw_id, unsigned int section, u8 *data,
  */
 struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 				 const struct iwl_fw *fw);
+
 #endif /* __iwl_nvm_parse_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6704ad0895cb..baf7404c137d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2007,9 +2007,21 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	struct ieee80211_sta *sta;
 	u32 flags;
 	int i;
+	const struct ieee80211_sta_he_cap *own_he_cap = NULL;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	const struct ieee80211_supported_band *sband;
 
 	rcu_read_lock();
 
+	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	if (WARN_ON(!chanctx_conf)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	sband = mvm->hw->wiphy->bands[chanctx_conf->def.chan->band];
+	own_he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_ctxt_cmd.sta_id]);
 	if (IS_ERR_OR_NULL(sta)) {
 		rcu_read_unlock();
@@ -2196,6 +2208,10 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			(vif->bss_conf.uora_ocw_range >> 3) & 0x7;
 	}
 
+	if (own_he_cap && !(own_he_cap->he_cap_elem.mac_cap_info[2] &
+			    IEEE80211_HE_MAC_CAP2_ACK_EN))
+		flags |= STA_CTXT_HE_NIC_NOT_ACK_ENABLED;
+
 	if (vif->bss_conf.nontransmitted) {
 		flags |= STA_CTXT_HE_REF_BSSID_VALID;
 		ether_addr_copy(sta_ctxt_cmd.ref_bssid_addr,
-- 
2.30.0

