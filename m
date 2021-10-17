Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E474430789
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbhJQJmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53676 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245177AbhJQJmj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eZ-000YUg-FN; Sun, 17 Oct 2021 12:40:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:14 +0300
Message-Id: <iwlwifi.20211017123741.5862bf4f14c4.Ib476b5443faa085539b79d49a0aebd81a213b42f@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: update definitions due to new rate & flags
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As a part of preparing to the new rate & flags version
Update the relevant definitions and use them.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 58 +++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 34 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 80 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 26 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 78 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 12 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 9 files changed, 147 insertions(+), 147 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 810dceb649c7..c150bae761be 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -248,7 +248,7 @@ enum {
 };
 
 /*
- * rate_n_flags bit fields
+ * rate_n_flags bit fields version 1
  *
  * The 32-bit value has different layouts in the low 8 bites depending on the
  * format. There are three formats, HT, VHT and legacy (11abg, with subformats
@@ -266,15 +266,15 @@ enum {
 
 /* Bit 8: (1) HT format, (0) legacy or VHT format */
 #define RATE_MCS_HT_POS 8
-#define RATE_MCS_HT_MSK (1 << RATE_MCS_HT_POS)
+#define RATE_MCS_HT_MSK_V1 BIT(RATE_MCS_HT_POS)
 
 /* Bit 9: (1) CCK, (0) OFDM.  HT (bit 8) must be "0" for this bit to be valid */
-#define RATE_MCS_CCK_POS 9
-#define RATE_MCS_CCK_MSK (1 << RATE_MCS_CCK_POS)
+#define RATE_MCS_CCK_POS_V1 9
+#define RATE_MCS_CCK_MSK_V1 BIT(RATE_MCS_CCK_POS_V1)
 
 /* Bit 26: (1) VHT format, (0) legacy format in bits 8:0 */
-#define RATE_MCS_VHT_POS 26
-#define RATE_MCS_VHT_MSK (1 << RATE_MCS_VHT_POS)
+#define RATE_MCS_VHT_POS_V1 26
+#define RATE_MCS_VHT_MSK_V1 BIT(RATE_MCS_VHT_POS_V1)
 
 
 /*
@@ -300,15 +300,15 @@ enum {
  * streams and 16-23 have three streams. We could also support MCS 32
  * which is the duplicate 20 MHz MCS (bit 5 set, all others zero.)
  */
-#define RATE_HT_MCS_RATE_CODE_MSK	0x7
-#define RATE_HT_MCS_NSS_POS             3
-#define RATE_HT_MCS_NSS_MSK             (3 << RATE_HT_MCS_NSS_POS)
+#define RATE_HT_MCS_RATE_CODE_MSK_V1	0x7
+#define RATE_HT_MCS_NSS_POS_V1          3
+#define RATE_HT_MCS_NSS_MSK_V1          (3 << RATE_HT_MCS_NSS_POS_V1)
 
 /* Bit 10: (1) Use Green Field preamble */
 #define RATE_HT_MCS_GF_POS		10
 #define RATE_HT_MCS_GF_MSK		(1 << RATE_HT_MCS_GF_POS)
 
-#define RATE_HT_MCS_INDEX_MSK		0x3f
+#define RATE_HT_MCS_INDEX_MSK_V1	0x3f
 
 /*
  * Very High-throughput (VHT) rate format for bits 7:0
@@ -347,26 +347,26 @@ enum {
  *        110)  11 Mbps
  * (bit 7 is 0)
  */
-#define RATE_LEGACY_RATE_MSK 0xff
+#define RATE_LEGACY_RATE_MSK_V1 0xff
 
 /* Bit 10 - OFDM HE */
-#define RATE_MCS_HE_POS		10
-#define RATE_MCS_HE_MSK		BIT(RATE_MCS_HE_POS)
+#define RATE_MCS_HE_POS_V1	10
+#define RATE_MCS_HE_MSK_V1	BIT(RATE_MCS_HE_POS_V1)
 
 /*
  * Bit 11-12: (0) 20MHz, (1) 40MHz, (2) 80MHz, (3) 160MHz
  * 0 and 1 are valid for HT and VHT, 2 and 3 only for VHT
  */
 #define RATE_MCS_CHAN_WIDTH_POS		11
-#define RATE_MCS_CHAN_WIDTH_MSK		(3 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_MSK_V1	(3 << RATE_MCS_CHAN_WIDTH_POS)
 #define RATE_MCS_CHAN_WIDTH_20		(0 << RATE_MCS_CHAN_WIDTH_POS)
 #define RATE_MCS_CHAN_WIDTH_40		(1 << RATE_MCS_CHAN_WIDTH_POS)
 #define RATE_MCS_CHAN_WIDTH_80		(2 << RATE_MCS_CHAN_WIDTH_POS)
 #define RATE_MCS_CHAN_WIDTH_160		(3 << RATE_MCS_CHAN_WIDTH_POS)
 
 /* Bit 13: (1) Short guard interval (0.4 usec), (0) normal GI (0.8 usec) */
-#define RATE_MCS_SGI_POS		13
-#define RATE_MCS_SGI_MSK		(1 << RATE_MCS_SGI_POS)
+#define RATE_MCS_SGI_POS_V1		13
+#define RATE_MCS_SGI_MSK_V1		BIT(RATE_MCS_SGI_POS_V1)
 
 /* Bit 14-16: Antenna selection (1) Ant A, (2) Ant B, (4) Ant C */
 #define RATE_MCS_ANT_POS		14
@@ -408,27 +408,27 @@ enum {
  *	3			(does not occur)
  */
 #define RATE_MCS_HE_GI_LTF_POS		20
-#define RATE_MCS_HE_GI_LTF_MSK		(3 << RATE_MCS_HE_GI_LTF_POS)
+#define RATE_MCS_HE_GI_LTF_MSK_V1		(3 << RATE_MCS_HE_GI_LTF_POS)
 
 /* Bit 22-23: HE type. (0) SU, (1) SU_EXT, (2) MU, (3) trigger based */
-#define RATE_MCS_HE_TYPE_POS		22
-#define RATE_MCS_HE_TYPE_SU		(0 << RATE_MCS_HE_TYPE_POS)
-#define RATE_MCS_HE_TYPE_EXT_SU		(1 << RATE_MCS_HE_TYPE_POS)
-#define RATE_MCS_HE_TYPE_MU		(2 << RATE_MCS_HE_TYPE_POS)
-#define RATE_MCS_HE_TYPE_TRIG		(3 << RATE_MCS_HE_TYPE_POS)
-#define RATE_MCS_HE_TYPE_MSK		(3 << RATE_MCS_HE_TYPE_POS)
+#define RATE_MCS_HE_TYPE_POS_V1		22
+#define RATE_MCS_HE_TYPE_SU_V1		(0 << RATE_MCS_HE_TYPE_POS_V1)
+#define RATE_MCS_HE_TYPE_EXT_SU_V1		BIT(RATE_MCS_HE_TYPE_POS_V1)
+#define RATE_MCS_HE_TYPE_MU_V1		(2 << RATE_MCS_HE_TYPE_POS_V1)
+#define RATE_MCS_HE_TYPE_TRIG_V1	(3 << RATE_MCS_HE_TYPE_POS_V1)
+#define RATE_MCS_HE_TYPE_MSK_V1		(3 << RATE_MCS_HE_TYPE_POS_V1)
 
 /* Bit 24-25: (0) 20MHz (no dup), (1) 2x20MHz, (2) 4x20MHz, 3 8x20MHz */
-#define RATE_MCS_DUP_POS		24
-#define RATE_MCS_DUP_MSK		(3 << RATE_MCS_DUP_POS)
+#define RATE_MCS_DUP_POS_V1		24
+#define RATE_MCS_DUP_MSK_V1		(3 << RATE_MCS_DUP_POS_V1)
 
 /* Bit 27: (1) LDPC enabled, (0) LDPC disabled */
-#define RATE_MCS_LDPC_POS		27
-#define RATE_MCS_LDPC_MSK		(1 << RATE_MCS_LDPC_POS)
+#define RATE_MCS_LDPC_POS_V1		27
+#define RATE_MCS_LDPC_MSK_V1		BIT(RATE_MCS_LDPC_POS_V1)
 
 /* Bit 28: (1) 106-tone RX (8 MHz RU), (0) normal bandwidth */
-#define RATE_MCS_HE_106T_POS		28
-#define RATE_MCS_HE_106T_MSK		(1 << RATE_MCS_HE_106T_POS)
+#define RATE_MCS_HE_106T_POS_V1		28
+#define RATE_MCS_HE_106T_MSK_V1		BIT(RATE_MCS_HE_106T_POS_V1)
 
 /* Bit 30-31: (1) RTS, (2) CTS */
 #define RATE_MCS_RTS_REQUIRED_POS  (30)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index fd352b2624a6..0065cc76a2a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -846,7 +846,7 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 
 	tx->rate_n_flags |= cpu_to_le32(iwl_mvm_mac80211_idx_to_hwrate(rate));
 	if (rate == IWL_FIRST_CCK_RATE)
-		tx->rate_n_flags |= cpu_to_le32(RATE_MCS_CCK_MSK);
+		tx->rate_n_flags |= cpu_to_le32(RATE_MCS_CCK_MSK_V1);
 
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 56da2759777c..1d664dd5915c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4878,7 +4878,7 @@ static int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 
 static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 {
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		rinfo->bw = RATE_INFO_BW_20;
 		break;
@@ -4893,24 +4893,24 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		break;
 	}
 
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
 		rinfo->flags |= RATE_INFO_FLAGS_MCS;
-		rinfo->mcs = u32_get_bits(rate_n_flags, RATE_HT_MCS_INDEX_MSK);
+		rinfo->mcs = u32_get_bits(rate_n_flags, RATE_HT_MCS_INDEX_MSK_V1);
 		rinfo->nss = u32_get_bits(rate_n_flags,
-					  RATE_HT_MCS_NSS_MSK) + 1;
-		if (rate_n_flags & RATE_MCS_SGI_MSK)
+					  RATE_HT_MCS_NSS_MSK_V1) + 1;
+		if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
 			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK) {
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
 		rinfo->mcs = u32_get_bits(rate_n_flags,
 					  RATE_VHT_MCS_RATE_CODE_MSK);
 		rinfo->nss = u32_get_bits(rate_n_flags,
 					  RATE_VHT_MCS_NSS_MSK) + 1;
-		if (rate_n_flags & RATE_MCS_SGI_MSK)
+		if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
 			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (rate_n_flags & RATE_MCS_HE_MSK) {
+	} else if (rate_n_flags & RATE_MCS_HE_MSK_V1) {
 		u32 gi_ltf = u32_get_bits(rate_n_flags,
-					  RATE_MCS_HE_GI_LTF_MSK);
+					  RATE_MCS_HE_GI_LTF_MSK_V1);
 
 		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
 		rinfo->mcs = u32_get_bits(rate_n_flags,
@@ -4918,24 +4918,24 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		rinfo->nss = u32_get_bits(rate_n_flags,
 					  RATE_VHT_MCS_NSS_MSK) + 1;
 
-		if (rate_n_flags & RATE_MCS_HE_106T_MSK) {
+		if (rate_n_flags & RATE_MCS_HE_106T_MSK_V1) {
 			rinfo->bw = RATE_INFO_BW_HE_RU;
 			rinfo->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_106;
 		}
 
-		switch (rate_n_flags & RATE_MCS_HE_TYPE_MSK) {
-		case RATE_MCS_HE_TYPE_SU:
-		case RATE_MCS_HE_TYPE_EXT_SU:
+		switch (rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1) {
+		case RATE_MCS_HE_TYPE_SU_V1:
+		case RATE_MCS_HE_TYPE_EXT_SU_V1:
 			if (gi_ltf == 0 || gi_ltf == 1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 			else if (gi_ltf == 2)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
-			else if (rate_n_flags & RATE_MCS_SGI_MSK)
+			else if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 			else
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 			break;
-		case RATE_MCS_HE_TYPE_MU:
+		case RATE_MCS_HE_TYPE_MU_V1:
 			if (gi_ltf == 0 || gi_ltf == 1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 			else if (gi_ltf == 2)
@@ -4943,7 +4943,7 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 			else
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 			break;
-		case RATE_MCS_HE_TYPE_TRIG:
+		case RATE_MCS_HE_TYPE_TRIG_V1:
 			if (gi_ltf == 0 || gi_ltf == 1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 			else
@@ -4954,7 +4954,7 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
 			rinfo->he_dcm = 1;
 	} else {
-		switch (u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK)) {
+		switch (u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK_V1)) {
 		case IWL_RATE_1M_PLCP:
 			rinfo->legacy = 10;
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 2783aca3619a..df248d83606a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -330,15 +330,15 @@ static const struct rs_tx_column rs_tx_columns[] = {
 static inline u8 rs_extract_rate(u32 rate_n_flags)
 {
 	/* also works for HT because bits 7:6 are zero there */
-	return (u8)(rate_n_flags & RATE_LEGACY_RATE_MSK);
+	return (u8)(rate_n_flags & RATE_LEGACY_RATE_MSK_V1);
 }
 
 static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
 {
 	int idx = 0;
 
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
-		idx = rate_n_flags & RATE_HT_MCS_RATE_CODE_MSK;
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
+		idx = rate_n_flags & RATE_HT_MCS_RATE_CODE_MSK_V1;
 		idx += IWL_RATE_MCS_0_INDEX;
 
 		/* skip 9M not supported in HT*/
@@ -346,8 +346,8 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
 			idx += 1;
 		if ((idx >= IWL_FIRST_HT_RATE) && (idx <= IWL_LAST_HT_RATE))
 			return idx;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK ||
-		   rate_n_flags & RATE_MCS_HE_MSK) {
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1 ||
+		   rate_n_flags & RATE_MCS_HE_MSK_V1) {
 		idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
 		idx += IWL_RATE_MCS_0_INDEX;
 
@@ -356,8 +356,8 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
 			idx++;
 		if ((idx >= IWL_FIRST_VHT_RATE) && (idx <= IWL_LAST_VHT_RATE))
 			return idx;
-		if ((rate_n_flags & RATE_MCS_HE_MSK) &&
-		    (idx <= IWL_LAST_HE_RATE))
+		if ((rate_n_flags & RATE_MCS_HE_MSK_V1) &&
+		    idx <= IWL_LAST_HE_RATE)
 			return idx;
 	} else {
 		/* legacy rate format, search for match in table */
@@ -815,7 +815,7 @@ static u32 ucode_rate_from_rs_rate(struct iwl_mvm *mvm,
 	if (is_legacy(rate)) {
 		ucode_rate |= iwl_rates[index].plcp;
 		if (index >= IWL_FIRST_CCK_RATE && index <= IWL_LAST_CCK_RATE)
-			ucode_rate |= RATE_MCS_CCK_MSK;
+			ucode_rate |= RATE_MCS_CCK_MSK_V1;
 		return ucode_rate;
 	}
 
@@ -830,7 +830,7 @@ static u32 ucode_rate_from_rs_rate(struct iwl_mvm *mvm,
 			IWL_ERR(mvm, "Invalid HT rate index %d\n", index);
 			index = IWL_LAST_HT_RATE;
 		}
-		ucode_rate |= RATE_MCS_HT_MSK;
+		ucode_rate |= RATE_MCS_HT_MSK_V1;
 
 		if (is_ht_siso(rate))
 			ucode_rate |= iwl_rates[index].plcp_ht_siso;
@@ -843,7 +843,7 @@ static u32 ucode_rate_from_rs_rate(struct iwl_mvm *mvm,
 			IWL_ERR(mvm, "Invalid VHT rate index %d\n", index);
 			index = IWL_LAST_VHT_RATE;
 		}
-		ucode_rate |= RATE_MCS_VHT_MSK;
+		ucode_rate |= RATE_MCS_VHT_MSK_V1;
 		if (is_vht_siso(rate))
 			ucode_rate |= iwl_rates[index].plcp_vht_siso;
 		else if (is_vht_mimo2(rate))
@@ -863,9 +863,9 @@ static u32 ucode_rate_from_rs_rate(struct iwl_mvm *mvm,
 
 	ucode_rate |= rate->bw;
 	if (rate->sgi)
-		ucode_rate |= RATE_MCS_SGI_MSK;
+		ucode_rate |= RATE_MCS_SGI_MSK_V1;
 	if (rate->ldpc)
-		ucode_rate |= RATE_MCS_LDPC_MSK;
+		ucode_rate |= RATE_MCS_LDPC_MSK_V1;
 
 	return ucode_rate;
 }
@@ -888,9 +888,9 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 	rate->ant = (ant_msk >> RATE_MCS_ANT_POS);
 
 	/* Legacy */
-	if (!(ucode_rate & RATE_MCS_HT_MSK) &&
-	    !(ucode_rate & RATE_MCS_VHT_MSK) &&
-	    !(ucode_rate & RATE_MCS_HE_MSK)) {
+	if (!(ucode_rate & RATE_MCS_HT_MSK_V1) &&
+	    !(ucode_rate & RATE_MCS_VHT_MSK_V1) &&
+	    !(ucode_rate & RATE_MCS_HE_MSK_V1)) {
 		if (num_of_ant == 1) {
 			if (band == NL80211_BAND_5GHZ)
 				rate->type = LQ_LEGACY_A;
@@ -902,20 +902,20 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 	}
 
 	/* HT, VHT or HE */
-	if (ucode_rate & RATE_MCS_SGI_MSK)
+	if (ucode_rate & RATE_MCS_SGI_MSK_V1)
 		rate->sgi = true;
-	if (ucode_rate & RATE_MCS_LDPC_MSK)
+	if (ucode_rate & RATE_MCS_LDPC_MSK_V1)
 		rate->ldpc = true;
 	if (ucode_rate & RATE_MCS_STBC_MSK)
 		rate->stbc = true;
 	if (ucode_rate & RATE_MCS_BF_MSK)
 		rate->bfer = true;
 
-	rate->bw = ucode_rate & RATE_MCS_CHAN_WIDTH_MSK;
+	rate->bw = ucode_rate & RATE_MCS_CHAN_WIDTH_MSK_V1;
 
-	if (ucode_rate & RATE_MCS_HT_MSK) {
-		nss = ((ucode_rate & RATE_HT_MCS_NSS_MSK) >>
-		       RATE_HT_MCS_NSS_POS) + 1;
+	if (ucode_rate & RATE_MCS_HT_MSK_V1) {
+		nss = ((ucode_rate & RATE_HT_MCS_NSS_MSK_V1) >>
+		       RATE_HT_MCS_NSS_POS_V1) + 1;
 
 		if (nss == 1) {
 			rate->type = LQ_HT_SISO;
@@ -928,7 +928,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 		} else {
 			WARN_ON_ONCE(1);
 		}
-	} else if (ucode_rate & RATE_MCS_VHT_MSK) {
+	} else if (ucode_rate & RATE_MCS_VHT_MSK_V1) {
 		nss = ((ucode_rate & RATE_VHT_MCS_NSS_MSK) >>
 		       RATE_VHT_MCS_NSS_POS) + 1;
 
@@ -943,7 +943,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 		} else {
 			WARN_ON_ONCE(1);
 		}
-	} else if (ucode_rate & RATE_MCS_HE_MSK) {
+	} else if (ucode_rate & RATE_MCS_HE_MSK_V1) {
 		nss = ((ucode_rate & RATE_VHT_MCS_NSS_MSK) >>
 		      RATE_VHT_MCS_NSS_POS) + 1;
 
@@ -2895,7 +2895,7 @@ void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg)
 
 	mvm->drv_rx_stats.success_frames++;
 
-	switch (rate & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		mvm->drv_rx_stats.bw_20_frames++;
 		break;
@@ -2912,10 +2912,10 @@ void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg)
 		WARN_ONCE(1, "bad BW. rate 0x%x", rate);
 	}
 
-	if (rate & RATE_MCS_HT_MSK) {
+	if (rate & RATE_MCS_HT_MSK_V1) {
 		mvm->drv_rx_stats.ht_frames++;
-		nss = ((rate & RATE_HT_MCS_NSS_MSK) >> RATE_HT_MCS_NSS_POS) + 1;
-	} else if (rate & RATE_MCS_VHT_MSK) {
+		nss = ((rate & RATE_HT_MCS_NSS_MSK_V1) >> RATE_HT_MCS_NSS_POS_V1) + 1;
+	} else if (rate & RATE_MCS_VHT_MSK_V1) {
 		mvm->drv_rx_stats.vht_frames++;
 		nss = ((rate & RATE_VHT_MCS_NSS_MSK) >>
 		       RATE_VHT_MCS_NSS_POS) + 1;
@@ -2928,7 +2928,7 @@ void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg)
 	else if (nss == 2)
 		mvm->drv_rx_stats.mimo2_frames++;
 
-	if (rate & RATE_MCS_SGI_MSK)
+	if (rate & RATE_MCS_SGI_MSK_V1)
 		mvm->drv_rx_stats.sgi_frames++;
 	else
 		mvm->drv_rx_stats.ngi_frames++;
@@ -3681,9 +3681,9 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	u8 mcs = 0, nss = 0;
 	u8 ant = (rate & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
 
-	if (!(rate & RATE_MCS_HT_MSK) &&
-	    !(rate & RATE_MCS_VHT_MSK) &&
-	    !(rate & RATE_MCS_HE_MSK)) {
+	if (!(rate & RATE_MCS_HT_MSK_V1) &&
+	    !(rate & RATE_MCS_VHT_MSK_V1) &&
+	    !(rate & RATE_MCS_HE_MSK_V1)) {
 		int index = iwl_hwrate_to_plcp_idx(rate);
 
 		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps",
@@ -3692,17 +3692,17 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 				 iwl_rate_mcs[index].mbps);
 	}
 
-	if (rate & RATE_MCS_VHT_MSK) {
+	if (rate & RATE_MCS_VHT_MSK_V1) {
 		type = "VHT";
 		mcs = rate & RATE_VHT_MCS_RATE_CODE_MSK;
 		nss = ((rate & RATE_VHT_MCS_NSS_MSK)
 		       >> RATE_VHT_MCS_NSS_POS) + 1;
-	} else if (rate & RATE_MCS_HT_MSK) {
+	} else if (rate & RATE_MCS_HT_MSK_V1) {
 		type = "HT";
-		mcs = rate & RATE_HT_MCS_INDEX_MSK;
-		nss = ((rate & RATE_HT_MCS_NSS_MSK)
-		       >> RATE_HT_MCS_NSS_POS) + 1;
-	} else if (rate & RATE_MCS_HE_MSK) {
+		mcs = rate & RATE_HT_MCS_INDEX_MSK_V1;
+		nss = ((rate & RATE_HT_MCS_NSS_MSK_V1)
+		       >> RATE_HT_MCS_NSS_POS_V1) + 1;
+	} else if (rate & RATE_MCS_HE_MSK_V1) {
 		type = "HE";
 		mcs = rate & RATE_VHT_MCS_RATE_CODE_MSK;
 		nss = ((rate & RATE_VHT_MCS_NSS_MSK)
@@ -3711,7 +3711,7 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 		type = "Unknown"; /* shouldn't happen */
 	}
 
-	switch (rate & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		bw = "20Mhz";
 		break;
@@ -3731,9 +3731,9 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	return scnprintf(buf, bufsz,
 			 "0x%x: %s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s%s",
 			 rate, type, rs_pretty_ant(ant), bw, mcs, nss,
-			 (rate & RATE_MCS_SGI_MSK) ? "SGI " : "NGI ",
+			 (rate & RATE_MCS_SGI_MSK_V1) ? "SGI " : "NGI ",
 			 (rate & RATE_MCS_STBC_MSK) ? "STBC " : "",
-			 (rate & RATE_MCS_LDPC_MSK) ? "LDPC " : "",
+			 (rate & RATE_MCS_LDPC_MSK_V1) ? "LDPC " : "",
 			 (rate & RATE_HE_DUAL_CARRIER_MODE_MSK) ? "DCM " : "",
 			 (rate & RATE_MCS_BF_MSK) ? "BF " : "");
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 87b0600ed48a..d22f40a5354d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -230,7 +230,7 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 		mdata->rx.airtime += le16_to_cpu(phy_info->frame_time);
 	}
 
-	if (!(rate_n_flags & (RATE_MCS_HT_MSK | RATE_MCS_VHT_MSK)))
+	if (!(rate_n_flags & (RATE_MCS_HT_MSK_V1 | RATE_MCS_VHT_MSK_V1)))
 		return;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
@@ -244,10 +244,10 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 	    mvmsta->sta_id != mvmvif->ap_sta_id)
 		return;
 
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
-		thr = thresh_tpt[rate_n_flags & RATE_HT_MCS_RATE_CODE_MSK];
-		thr *= 1 + ((rate_n_flags & RATE_HT_MCS_NSS_MSK) >>
-					RATE_HT_MCS_NSS_POS);
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
+		thr = thresh_tpt[rate_n_flags & RATE_HT_MCS_RATE_CODE_MSK_V1];
+		thr *= 1 + ((rate_n_flags & RATE_HT_MCS_NSS_MSK_V1) >>
+					RATE_HT_MCS_NSS_POS_V1);
 	} else {
 		if (WARN_ON((rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK) >=
 				ARRAY_SIZE(thresh_tpt)))
@@ -257,7 +257,7 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 					RATE_VHT_MCS_NSS_POS);
 	}
 
-	thr <<= ((rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) >>
+	thr <<= ((rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) >>
 				RATE_MCS_CHAN_WIDTH_POS);
 
 	mdata->uapsd_nonagg_detect.rx_bytes += len;
@@ -450,7 +450,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	/* Set up the HT phy flags */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
 	case RATE_MCS_CHAN_WIDTH_40:
@@ -463,20 +463,20 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->bw = RATE_INFO_BW_160;
 		break;
 	}
-	if (!(rate_n_flags & RATE_MCS_CCK_MSK) &&
-	    rate_n_flags & RATE_MCS_SGI_MSK)
+	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
+	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+	if (rate_n_flags & RATE_MCS_LDPC_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK;
+		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK) {
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->nss =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index ba65bfb2b43e..8cfec733756b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1197,7 +1197,7 @@ static void iwl_mvm_decode_he_mu_ext(struct iwl_mvm *mvm,
 	}
 
 	if (FIELD_GET(IWL_RX_PHY_DATA4_HE_MU_EXT_CH2_CRC_OK, phy_data4) &&
-	    (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) != RATE_MCS_CHAN_WIDTH_20) {
+	    (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) != RATE_MCS_CHAN_WIDTH_20) {
 		he_mu->flags1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_RU_KNOWN |
 				    IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_CTR_26T_RU_KNOWN);
@@ -1234,7 +1234,7 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 	 * the TSF/timers are not be transmitted in HE-MU.
 	 */
 	u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
 	u8 offs = 0;
 
 	rx_status->bw = RATE_INFO_BW_HE_RU;
@@ -1289,13 +1289,13 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 
 	if (he_mu)
 		he_mu->flags2 |=
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
-	else if (he_type == RATE_MCS_HE_TYPE_TRIG)
+	else if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
 		he->data6 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
 }
@@ -1440,7 +1440,7 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_he *he = NULL;
 	struct ieee80211_radiotap_he_mu *he_mu = NULL;
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
 	u8 stbc, ltf;
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
@@ -1493,15 +1493,15 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 		}
 	}
 
-	if (he_type == RATE_MCS_HE_TYPE_EXT_SU &&
-	    rate_n_flags & RATE_MCS_HE_106T_MSK) {
+	if (he_type == RATE_MCS_HE_TYPE_EXT_SU_V1 &&
+	    rate_n_flags & RATE_MCS_HE_106T_MSK_V1) {
 		rx_status->bw = RATE_INFO_BW_HE_RU;
 		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
 	}
 
 	/* actually data is filled in mac80211 */
-	if (he_type == RATE_MCS_HE_TYPE_SU ||
-	    he_type == RATE_MCS_HE_TYPE_EXT_SU)
+	if (he_type == RATE_MCS_HE_TYPE_SU_V1 ||
+	    he_type == RATE_MCS_HE_TYPE_EXT_SU_V1)
 		he->data1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
 
@@ -1520,39 +1520,39 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 #define CHECK_TYPE(F)							\
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
-		     (RATE_MCS_HE_TYPE_ ## F >> RATE_MCS_HE_TYPE_POS))
+		     (RATE_MCS_HE_TYPE_ ## F ##_V1 >> RATE_MCS_HE_TYPE_POS_V1))
 
 	CHECK_TYPE(SU);
 	CHECK_TYPE(EXT_SU);
 	CHECK_TYPE(MU);
 	CHECK_TYPE(TRIG);
 
-	he->data1 |= cpu_to_le16(he_type >> RATE_MCS_HE_TYPE_POS);
+	he->data1 |= cpu_to_le16(he_type >> RATE_MCS_HE_TYPE_POS_V1);
 
 	if (rate_n_flags & RATE_MCS_BF_MSK)
 		he->data5 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA5_TXBF);
 
-	switch ((rate_n_flags & RATE_MCS_HE_GI_LTF_MSK) >>
+	switch ((rate_n_flags & RATE_MCS_HE_GI_LTF_MSK_V1) >>
 		RATE_MCS_HE_GI_LTF_POS) {
 	case 0:
-		if (he_type == RATE_MCS_HE_TYPE_TRIG)
+		if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 		else
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
-		if (he_type == RATE_MCS_HE_TYPE_MU)
+		if (he_type == RATE_MCS_HE_TYPE_MU_V1)
 			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
 		else
 			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_1X;
 		break;
 	case 1:
-		if (he_type == RATE_MCS_HE_TYPE_TRIG)
+		if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 		else
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_2X;
 		break;
 	case 2:
-		if (he_type == RATE_MCS_HE_TYPE_TRIG) {
+		if (he_type == RATE_MCS_HE_TYPE_TRIG_V1) {
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
 		} else {
@@ -1561,9 +1561,9 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 		}
 		break;
 	case 3:
-		if ((he_type == RATE_MCS_HE_TYPE_SU ||
-		     he_type == RATE_MCS_HE_TYPE_EXT_SU) &&
-		    rate_n_flags & RATE_MCS_SGI_MSK)
+		if ((he_type == RATE_MCS_HE_TYPE_SU_V1 ||
+		     he_type == RATE_MCS_HE_TYPE_EXT_SU_V1) &&
+		    rate_n_flags & RATE_MCS_SGI_MSK_V1)
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 		else
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
@@ -1729,7 +1729,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
 	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
 	case RATE_MCS_CHAN_WIDTH_40:
@@ -1743,7 +1743,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		break;
 	}
 
-	if (rate_n_flags & RATE_MCS_HE_MSK)
+	if (rate_n_flags & RATE_MCS_HE_MSK_V1)
 		iwl_mvm_rx_he(mvm, skb, &phy_data, rate_n_flags,
 			      phy_info, queue);
 
@@ -1760,7 +1760,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
 	}
 	/* set the preamble flag if appropriate */
-	if (rate_n_flags & RATE_MCS_CCK_MSK &&
+	if (rate_n_flags & RATE_MCS_CCK_MSK_V1 &&
 	    phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 
@@ -1936,20 +1936,20 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		}
 	}
 
-	if (!(rate_n_flags & RATE_MCS_CCK_MSK) &&
-	    rate_n_flags & RATE_MCS_SGI_MSK)
+	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
+	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+	if (rate_n_flags & RATE_MCS_LDPC_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK;
+		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK) {
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->nss =
@@ -1960,7 +1960,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		if (rate_n_flags & RATE_MCS_BF_MSK)
 			rx_status->enc_flags |= RX_ENC_FLAG_BF;
-	} else if (!(rate_n_flags & RATE_MCS_HE_MSK)) {
+	} else if (!(rate_n_flags & RATE_MCS_HE_MSK_V1)) {
 		int rate = iwl_mvm_legacy_rate_to_mac80211_idx(rate_n_flags,
 							       rx_status->band);
 
@@ -2060,7 +2060,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
 	case RATE_MCS_CHAN_WIDTH_40:
@@ -2074,7 +2074,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		break;
 	}
 
-	if (rate_n_flags & RATE_MCS_HE_MSK)
+	if (rate_n_flags & RATE_MCS_HE_MSK_V1)
 		iwl_mvm_rx_he(mvm, skb, &phy_data, rate_n_flags,
 			      phy_info, queue);
 
@@ -2090,20 +2090,20 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	rcu_read_lock();
 
-	if (!(rate_n_flags & RATE_MCS_CCK_MSK) &&
-	    rate_n_flags & RATE_MCS_SGI_MSK)
+	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
+	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+	if (rate_n_flags & RATE_MCS_LDPC_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK;
+		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK) {
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
@@ -2119,7 +2119,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK) + 1;
-	} else if (rate_n_flags & RATE_MCS_HE_MSK) {
+	} else if (rate_n_flags & RATE_MCS_HE_MSK_V1) {
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index d78e436fa8b5..ce8bdbc70b7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -163,7 +163,7 @@ iwl_mvm_scan_rate_n_flags(struct iwl_mvm *mvm, enum nl80211_band band,
 	tx_ant = BIT(mvm->scan_last_antenna_idx) << RATE_MCS_ANT_POS;
 
 	if (band == NL80211_BAND_2GHZ && !no_cck)
-		return cpu_to_le32(IWL_RATE_1M_PLCP | RATE_MCS_CCK_MSK |
+		return cpu_to_le32(IWL_RATE_1M_PLCP | RATE_MCS_CCK_MSK_V1 |
 				   tx_ant);
 	else
 		return cpu_to_le32(IWL_RATE_6M_PLCP | tx_ant);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6151350fa66c..ff29c4b140dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -303,7 +303,7 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 
 	/* Set CCK flag as needed */
 	if ((rate_idx >= IWL_FIRST_CCK_RATE) && (rate_idx <= IWL_LAST_CCK_RATE))
-		rate_flags |= RATE_MCS_CCK_MSK;
+		rate_flags |= RATE_MCS_CCK_MSK_V1;
 
 	return (u32)rate_plcp | rate_flags;
 }
@@ -1290,7 +1290,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 {
 	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
 		r->flags |= IEEE80211_TX_RC_GREEN_FIELD;
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
 	case RATE_MCS_CHAN_WIDTH_40:
@@ -1303,12 +1303,12 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 		r->flags |= IEEE80211_TX_RC_160_MHZ_WIDTH;
 		break;
 	}
-	if (rate_n_flags & RATE_MCS_SGI_MSK)
+	if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		r->flags |= IEEE80211_TX_RC_SHORT_GI;
-	if (rate_n_flags & RATE_MCS_HT_MSK) {
+	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
 		r->flags |= IEEE80211_TX_RC_MCS;
-		r->idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK) {
+		r->idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		ieee80211_rate_set_vht(
 			r, rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK,
 			((rate_n_flags & RATE_VHT_MCS_NSS_MSK) >>
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 704fc71ac845..70ca6d7a31bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -159,7 +159,7 @@ static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band)
 {
-	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK;
+	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
 	int idx;
 	int band_offset = 0;
 
-- 
2.33.0

