Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D95974C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfF1JUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54692 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbfF1JUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3M-0001ny-TM; Fri, 28 Jun 2019 12:20:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 03/20] iwlwifi: remove some unnecessary NULL checks
Date:   Fri, 28 Jun 2019 12:19:51 +0300
Message-Id: <20190628092008.11049-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

These pointers are an offset into the "sta" struct.  They're assigned
like this:

	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;

They're not the first member of the struct (->supp_rates[] is first) so
they can't be NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 1cfd550c1ecb..b409e69cb1a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -101,7 +101,7 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	u8 supp = 0;
 
-	if (he_cap && he_cap->has_he)
+	if (he_cap->has_he)
 		return 0;
 
 	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
@@ -123,12 +123,12 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	bool vht_ena = vht_cap && vht_cap->vht_supported;
+	bool vht_ena = vht_cap->vht_supported;
 	u16 flags = 0;
 
 	if (mvm->cfg->ht_params->stbc &&
 	    (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) > 1)) {
-		if (he_cap && he_cap->has_he) {
+		if (he_cap->has_he) {
 			if (he_cap->he_cap_elem.phy_cap_info[2] &
 			    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
 				flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
@@ -136,15 +136,14 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 			if (he_cap->he_cap_elem.phy_cap_info[7] &
 			    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
 				flags |= IWL_TLC_MNG_CFG_FLAGS_HE_STBC_160MHZ_MSK;
-		} else if ((ht_cap &&
-			    (ht_cap->cap & IEEE80211_HT_CAP_RX_STBC)) ||
+		} else if ((ht_cap->cap & IEEE80211_HT_CAP_RX_STBC) ||
 			   (vht_ena &&
 			    (vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK)))
 			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
 	}
 
 	if (mvm->cfg->ht_params->ldpc &&
-	    ((ht_cap && (ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING)) ||
+	    ((ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
 	     (vht_ena && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
@@ -154,7 +153,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags &= ~IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	if (he_cap && he_cap->has_he &&
+	if (he_cap->has_he &&
 	    (he_cap->he_cap_elem.phy_cap_info[3] &
 	     IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK;
@@ -293,13 +292,13 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
 	/* HT/VHT rates */
-	if (he_cap && he_cap->has_he) {
+	if (he_cap->has_he) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
 		rs_fw_he_set_enabled_rates(sta, sband, cmd);
-	} else if (vht_cap && vht_cap->vht_supported) {
+	} else if (vht_cap->vht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_VHT;
 		rs_fw_vht_set_enabled_rates(sta, vht_cap, cmd);
-	} else if (ht_cap && ht_cap->ht_supported) {
+	} else if (ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[0][0] = cpu_to_le16(ht_cap->mcs.rx_mask[0]);
 		cmd->ht_rates[1][0] = cpu_to_le16(ht_cap->mcs.rx_mask[1]);
@@ -381,7 +380,7 @@ static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 
-	if (vht_cap && vht_cap->vht_supported) {
+	if (vht_cap->vht_supported) {
 		switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
 			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
@@ -391,7 +390,7 @@ static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 	}
 
-	} else if (ht_cap && ht_cap->ht_supported) {
+	} else if (ht_cap->ht_supported) {
 		if (ht_cap->cap & IEEE80211_HT_CAP_MAX_AMSDU)
 			/*
 			 * agg is offloaded so we need to assume that agg
-- 
2.20.1

