Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88831076A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBEJLq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:11:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43734 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230106AbhBEJHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7x4f-0044i1-Hi; Fri, 05 Feb 2021 11:06:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  5 Feb 2021 11:06:31 +0200
Message-Id: <iwlwifi.20210205110447.f5a3d53301b3.I23e84c9bb0b039d9106a07e9d6847776757f9029@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205090642.1553849-1-luca@coelho.fi>
References: <20210205090642.1553849-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [RESEND PATCH 01/12] iwlwifi: mvm: advertise BIGTK client support if available
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the firmware has support, then advertise it to the stack and
send the key down. Since we re-check the protection in the host
anyway, we don't really need to do anything on RX except that we
should drop frames that the firmware _knows_ are replay errors,
since beacon filtering might otherwise result in replays being
possible.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 85 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  8 +-
 6 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 821ed472ccff..2c74db823778 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -140,7 +140,8 @@ enum iwl_rx_phy_flags {
  * @RX_MPDU_RES_STATUS_SEC_TKIP_ENC: this frame is encrypted using TKIP
  * @RX_MPDU_RES_STATUS_SEC_EXT_ENC: this frame is encrypted using extension
  *	algorithm
- * @RX_MPDU_RES_STATUS_SEC_CCM_CMAC_ENC: this frame is encrypted using CCM_CMAC
+ * @RX_MPDU_RES_STATUS_SEC_CMAC_GMAC_ENC: this frame is protected using
+ *	CMAC or GMAC
  * @RX_MPDU_RES_STATUS_SEC_ENC_ERR: this frame couldn't be decrypted
  * @RX_MPDU_RES_STATUS_SEC_ENC_MSK: bitmask of the encryption algorithm
  * @RX_MPDU_RES_STATUS_DEC_DONE: this frame has been successfully decrypted
@@ -167,7 +168,7 @@ enum iwl_mvm_rx_status {
 	RX_MPDU_RES_STATUS_SEC_CCM_ENC			= (2 << 8),
 	RX_MPDU_RES_STATUS_SEC_TKIP_ENC			= (3 << 8),
 	RX_MPDU_RES_STATUS_SEC_EXT_ENC			= (4 << 8),
-	RX_MPDU_RES_STATUS_SEC_CCM_CMAC_ENC		= (6 << 8),
+	RX_MPDU_RES_STATUS_SEC_CMAC_GMAC_ENC		= (6 << 8),
 	RX_MPDU_RES_STATUS_SEC_ENC_ERR			= (7 << 8),
 	RX_MPDU_RES_STATUS_SEC_ENC_MSK			= (7 << 8),
 	RX_MPDU_RES_STATUS_DEC_DONE			= BIT(11),
@@ -239,6 +240,8 @@ enum iwl_rx_mpdu_status {
 	IWL_RX_MPDU_STATUS_ICV_OK		= BIT(5),
 	IWL_RX_MPDU_STATUS_MIC_OK		= BIT(6),
 	IWL_RX_MPDU_RES_STATUS_TTAK_OK		= BIT(7),
+	/* overlayed since IWL_UCODE_TLV_API_DEPRECATE_TTAK */
+	IWL_RX_MPDU_STATUS_REPLAY_ERROR		= BIT(7),
 	IWL_RX_MPDU_STATUS_SEC_MASK		= 0x7 << 8,
 	IWL_RX_MPDU_STATUS_SEC_UNKNOWN		= IWL_RX_MPDU_STATUS_SEC_MASK,
 	IWL_RX_MPDU_STATUS_SEC_NONE		= 0x0 << 8,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 7cd9c0bf5ba2..e7068811590b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -440,6 +440,8 @@ enum iwl_ucode_tlv_capa {
 	 */
 	IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)98,
 
+	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
+
 	NUM_IWL_UCODE_TLV_CAPA
 #ifdef __CHECKER__
 		/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 04fda8250291..a529404d416c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -472,6 +472,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->pmsr_capa = &iwl_mvm_pmsr_capa;
 	}
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT))
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT);
+
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	hw->wiphy->features |=
 		NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
@@ -3419,6 +3424,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 	switch (cmd) {
 	case SET_KEY:
+		if (keyidx == 6 || keyidx == 7)
+			rcu_assign_pointer(mvmvif->bcn_prot.keys[keyidx - 6],
+					   key);
+
 		if ((vif->type == NL80211_IFTYPE_ADHOC ||
 		     vif->type == NL80211_IFTYPE_AP) && !sta) {
 			/*
@@ -3527,6 +3536,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 		break;
 	case DISABLE_KEY:
+		if (keyidx == 6 || keyidx == 7)
+			RCU_INIT_POINTER(mvmvif->bcn_prot.keys[keyidx - 6],
+					 NULL);
+
 		ret = -ENOENT;
 		for (i = 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++) {
 			if (mvmvif->ap_early_keys[i] == key) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5d022776a2da..4925792257d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -419,6 +419,10 @@ struct iwl_mvm_vif {
 
 	/* 26-tone RU OFDMA transmissions should be blocked */
 	bool he_ru_2mhz_block;
+
+	struct {
+		struct ieee80211_key_conf __rcu *keys[2];
+	} bcn_prot;
 };
 
 static inline struct iwl_mvm_vif *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7509d73ae724..7b0b7d191fc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -272,7 +272,72 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 	rx_status->chain_signal[2] = S8_MIN;
 }
 
-static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
+static int iwl_mvm_rx_mgmt_crypto(struct ieee80211_sta *sta,
+				  struct ieee80211_hdr *hdr,
+				  struct iwl_rx_mpdu_desc *desc,
+				  u32 status)
+{
+	struct iwl_mvm_sta *mvmsta;
+	struct iwl_mvm_vif *mvmvif;
+	u8 fwkeyid = u32_get_bits(status, IWL_RX_MPDU_STATUS_KEY);
+	u8 keyid;
+	struct ieee80211_key_conf *key;
+	u32 len = le16_to_cpu(desc->mpdu_len);
+	const u8 *frame = (void *)hdr;
+
+	/*
+	 * For non-beacon, we don't really care. But beacons may
+	 * be filtered out, and we thus need the firmware's replay
+	 * detection, otherwise beacons the firmware previously
+	 * filtered could be replayed, or something like that, and
+	 * it can filter a lot - though usually only if nothing has
+	 * changed.
+	 */
+	if (!ieee80211_is_beacon(hdr->frame_control))
+		return 0;
+
+	/* good cases */
+	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
+		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)))
+		return 0;
+
+	if (!sta)
+		return -1;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+	/* what? */
+	if (fwkeyid != 6 && fwkeyid != 7)
+		return -1;
+
+	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
+
+	key = rcu_dereference(mvmvif->bcn_prot.keys[fwkeyid - 6]);
+	if (!key)
+		return -1;
+
+	if (len < key->icv_len + IEEE80211_GMAC_PN_LEN + 2)
+		return -1;
+
+	/*
+	 * See if the key ID matches - if not this may be due to a
+	 * switch and the firmware may erroneously report !MIC_OK.
+	 */
+	keyid = frame[len - key->icv_len - IEEE80211_GMAC_PN_LEN - 2];
+	if (keyid != fwkeyid)
+		return -1;
+
+	/* Report status to mac80211 */
+	if (!(status & IWL_RX_MPDU_STATUS_MIC_OK))
+		ieee80211_key_mic_failure(key);
+	else if (status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)
+		ieee80211_key_replay(key);
+
+	return -1;
+}
+
+static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			     struct ieee80211_hdr *hdr,
 			     struct ieee80211_rx_status *stats, u16 phy_info,
 			     struct iwl_rx_mpdu_desc *desc,
 			     u32 pkt_flags, int queue, u8 *crypt_len)
@@ -345,6 +410,8 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 			return -1;
 		stats->flag |= RX_FLAG_DECRYPTED;
 		return 0;
+	case RX_MPDU_RES_STATUS_SEC_CMAC_GMAC_ENC:
+		return iwl_mvm_rx_mgmt_crypto(sta, hdr, desc, status);
 	default:
 		/*
 		 * Sometimes we can get frames that were not decrypted
@@ -1682,15 +1749,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	iwl_mvm_decode_lsig(skb, &phy_data);
 
-	rx_status = IEEE80211_SKB_RXCB(skb);
-
-	if (iwl_mvm_rx_crypto(mvm, hdr, rx_status, phy_info, desc,
-			      le32_to_cpu(pkt->len_n_flags), queue,
-			      &crypt_len)) {
-		kfree_skb(skb);
-		return;
-	}
-
 	/*
 	 * Keep packets with CRC errors (and with overrun) for monitor mode
 	 * (otherwise the firmware discards them) but mark them as bad.
@@ -1774,6 +1832,13 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		sta = ieee80211_find_sta_by_ifaddr(mvm->hw, hdr->addr2, NULL);
 	}
 
+	if (iwl_mvm_rx_crypto(mvm, sta, hdr, rx_status, phy_info, desc,
+			      le32_to_cpu(pkt->len_n_flags), queue,
+			      &crypt_len)) {
+		kfree_skb(skb);
+		goto out;
+	}
+
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 		struct ieee80211_vif *tx_blocked_vif =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index f54dda8bfdae..2050cb4a0d18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3304,7 +3304,8 @@ static int iwl_mvm_send_sta_igtk(struct iwl_mvm *mvm,
 
 	/* verify the key details match the required command's expectations */
 	if (WARN_ON((keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE) ||
-		    (keyconf->keyidx != 4 && keyconf->keyidx != 5) ||
+		    (keyconf->keyidx != 4 && keyconf->keyidx != 5 &&
+		     keyconf->keyidx != 6 && keyconf->keyidx != 7) ||
 		    (keyconf->cipher != WLAN_CIPHER_SUITE_AES_CMAC &&
 		     keyconf->cipher != WLAN_CIPHER_SUITE_BIP_GMAC_128 &&
 		     keyconf->cipher != WLAN_CIPHER_SUITE_BIP_GMAC_256)))
@@ -3353,9 +3354,10 @@ static int iwl_mvm_send_sta_igtk(struct iwl_mvm *mvm,
 						       ((u64) pn[0] << 40));
 	}
 
-	IWL_DEBUG_INFO(mvm, "%s igtk for sta %u\n",
+	IWL_DEBUG_INFO(mvm, "%s %sIGTK (%d) for sta %u\n",
 		       remove_key ? "removing" : "installing",
-		       igtk_cmd.sta_id);
+		       keyconf->keyidx >= 6 ? "B" : "",
+		       keyconf->keyidx, igtk_cmd.sta_id);
 
 	if (!iwl_mvm_has_new_rx_api(mvm)) {
 		struct iwl_mvm_mgmt_mcast_key_cmd_v1 igtk_cmd_v1 = {
-- 
2.30.0

