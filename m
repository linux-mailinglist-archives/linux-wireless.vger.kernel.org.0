Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53A4CD344
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiCDLW3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbiCDLW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:28 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166F1B0BC6
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:40 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ608-000QSW-81;
        Fri, 04 Mar 2022 13:21:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:20 +0200
Message-Id: <iwlwifi.20220304131517.8b3c8b4adf41.Ib3ddb6b250ea2dd72b4ecc88bdd5cffb86af1dcc@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 04/13] iwlwifi: mvm: remove cipher scheme support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are no shipping firmware versions with this, and there
will also not be in the future, so remove the support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 28 ------------------
 drivers/net/wireless/intel/iwlwifi/fw/img.h   | 12 --------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 28 ------------------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 29 +------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 5 files changed, 1 insertion(+), 97 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index fa2a73ae4183..35e4adb7006f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -518,34 +518,6 @@ enum iwl_fw_phy_cfg {
 	FW_PHY_CFG_SHARED_CLK = BIT(31),
 };
 
-#define IWL_UCODE_MAX_CS		1
-
-/**
- * struct iwl_fw_cipher_scheme - a cipher scheme supported by FW.
- * @cipher: a cipher suite selector
- * @flags: cipher scheme flags (currently reserved for a future use)
- * @hdr_len: a size of MPDU security header
- * @pn_len: a size of PN
- * @pn_off: an offset of pn from the beginning of the security header
- * @key_idx_off: an offset of key index byte in the security header
- * @key_idx_mask: a bit mask of key_idx bits
- * @key_idx_shift: bit shift needed to get key_idx
- * @mic_len: mic length in bytes
- * @hw_cipher: a HW cipher index used in host commands
- */
-struct iwl_fw_cipher_scheme {
-	__le32 cipher;
-	u8 flags;
-	u8 hdr_len;
-	u8 pn_len;
-	u8 pn_off;
-	u8 key_idx_off;
-	u8 key_idx_mask;
-	u8 key_idx_shift;
-	u8 mic_len;
-	u8 hw_cipher;
-} __packed;
-
 enum iwl_fw_dbg_reg_operator {
 	CSR_ASSIGN,
 	CSR_SETBIT,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 89869edb23e8..f878ac508801 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -133,16 +133,6 @@ struct iwl_fw_paging {
 	u32 fw_offs;
 };
 
-/**
- * struct iwl_fw_cscheme_list - a cipher scheme list
- * @size: a number of entries
- * @cs: cipher scheme entries
- */
-struct iwl_fw_cscheme_list {
-	u8 size;
-	struct iwl_fw_cipher_scheme cs[];
-} __packed;
-
 /**
  * enum iwl_fw_type - iwlwifi firmware type
  * @IWL_FW_DVM: DVM firmware
@@ -197,7 +187,6 @@ struct iwl_dump_exclude {
  * @inst_evtlog_size: event log size for runtime ucode.
  * @inst_errlog_ptr: error log offfset for runtime ucode.
  * @type: firmware type (&enum iwl_fw_type)
- * @cipher_scheme: optional external cipher scheme.
  * @human_readable: human readable version
  *	we get the ALIVE from the uCode
  * @phy_integration_ver: PHY integration version string
@@ -228,7 +217,6 @@ struct iwl_fw {
 
 	enum iwl_fw_type type;
 
-	struct iwl_fw_cipher_scheme cs[IWL_UCODE_MAX_CS];
 	u8 human_readable[FW_VER_HUMAN_READABLE_SZ];
 
 	struct iwl_fw_dbg dbg;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index f92bcab5fdf6..8bb4f54d9b38 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -324,30 +324,6 @@ static void set_sec_offset(struct iwl_firmware_pieces *pieces,
 	pieces->img[type].sec[sec].offset = offset;
 }
 
-static int iwl_store_cscheme(struct iwl_fw *fw, const u8 *data, const u32 len)
-{
-	int i, j;
-	const struct iwl_fw_cscheme_list *l =
-		(const struct iwl_fw_cscheme_list *)data;
-	const struct iwl_fw_cipher_scheme *fwcs;
-
-	if (len < sizeof(*l) ||
-	    len < sizeof(l->size) + l->size * sizeof(l->cs[0]))
-		return -EINVAL;
-
-	for (i = 0, j = 0; i < IWL_UCODE_MAX_CS && i < l->size; i++) {
-		fwcs = &l->cs[j];
-
-		/* we skip schemes with zero cipher suite selector */
-		if (!fwcs->cipher)
-			continue;
-
-		fw->cs[j++] = *fwcs;
-	}
-
-	return 0;
-}
-
 /*
  * Gets uCode section from tlv.
  */
@@ -926,10 +902,6 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				return -EINVAL;
 			}
 			break;
-		case IWL_UCODE_TLV_CSCHEME:
-			if (iwl_store_cscheme(&drv->fw, tlv_data, tlv_len))
-				goto invalid_tlv_len;
-			break;
 		case IWL_UCODE_TLV_N_SCAN_CHANNELS:
 			if (tlv_len != sizeof(u32))
 				goto invalid_tlv_len;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2ce09e58e74c..81d02a17dfe4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -448,28 +448,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->n_cipher_suites++;
 	}
 
-	/* currently FW API supports only one optional cipher scheme */
-	if (mvm->fw->cs[0].cipher) {
-		const struct iwl_fw_cipher_scheme *fwcs = &mvm->fw->cs[0];
-		struct ieee80211_cipher_scheme *cs = &mvm->cs[0];
-
-		mvm->hw->n_cipher_schemes = 1;
-
-		cs->cipher = le32_to_cpu(fwcs->cipher);
-		cs->iftype = BIT(NL80211_IFTYPE_STATION);
-		cs->hdr_len = fwcs->hdr_len;
-		cs->pn_len = fwcs->pn_len;
-		cs->pn_off = fwcs->pn_off;
-		cs->key_idx_off = fwcs->key_idx_off;
-		cs->key_idx_mask = fwcs->key_idx_mask;
-		cs->key_idx_shift = fwcs->key_idx_shift;
-		cs->mic_len = fwcs->mic_len;
-
-		mvm->hw->cipher_schemes = mvm->cs;
-		mvm->ciphers[hw->wiphy->n_cipher_suites] = cs->cipher;
-		hw->wiphy->n_cipher_suites++;
-	}
-
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_FTM_CALIBRATED)) {
 		wiphy_ext_feature_set(hw->wiphy,
@@ -3744,12 +3722,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		/* support HW crypto on TX */
 		return 0;
 	default:
-		/* currently FW supports only one optional cipher scheme */
-		if (hw->n_cipher_schemes &&
-		    hw->cipher_schemes->cipher == key->cipher)
-			key->flags |= IEEE80211_KEY_FLAG_PUT_IV_SPACE;
-		else
-			return -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	switch (cmd) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ecfe322ebef2..7c6802f92ef7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1075,7 +1075,6 @@ struct iwl_mvm {
 
 
 	u32 ciphers[IWL_MVM_NUM_CIPHERS];
-	struct ieee80211_cipher_scheme cs[IWL_UCODE_MAX_CS];
 
 	struct cfg80211_ftm_responder_stats ftm_resp_stats;
 	struct {
-- 
2.35.1

