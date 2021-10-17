Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3843078C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbhJQJmu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53694 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245186AbhJQJmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2ed-000YUg-EC; Sun, 17 Oct 2021 12:40:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:17 +0300
Message-Id: <iwlwifi.20211017123741.9fc0cb5d5898.I1f88e02317f79f1be7f792c01236d836045a44b3@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: mvm: Support version 3 of tlc_update_notif.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate_n_flags, a new version of tlc_update_notif
was added in FW in order to support the new rate_n_flags.
Add support for the new version, and move the all API to use the
new rate_n_flags only (if FW supports the old one - convert it).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  16 ++
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 125 ++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 150 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  12 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  67 ++------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  12 --
 8 files changed, 244 insertions(+), 144 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 8b4f3c311634..a09081d7ed45 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -184,6 +184,14 @@ struct iwl_tlc_update_notif {
 	__le32 amsdu_enabled;
 } __packed; /* TLC_MNG_UPDATE_NTFY_API_S_VER_2 */
 
+
+#define IWL_MAX_MCS_DISPLAY_SIZE        12
+
+struct iwl_rate_mcs_info {
+	char    mbps[IWL_MAX_MCS_DISPLAY_SIZE];
+	char    mcs[IWL_MAX_MCS_DISPLAY_SIZE];
+};
+
 /*
  * These serve as indexes into
  * struct iwl_rate_info fw_rate_idx_to_plcp[IWL_RATE_COUNT];
@@ -226,6 +234,8 @@ enum {
 	IWL_LAST_HE_RATE = IWL_RATE_MCS_11_INDEX,
 	IWL_RATE_COUNT_LEGACY = IWL_LAST_NON_HT_RATE + 1,
 	IWL_RATE_COUNT = IWL_LAST_HE_RATE + 1,
+	IWL_RATE_INVM_INDEX = IWL_RATE_COUNT,
+	IWL_RATE_INVALID = IWL_RATE_COUNT,
 };
 
 #define IWL_RATE_BIT_MSK(r) BIT(IWL_RATE_##r##M_INDEX)
@@ -548,6 +558,7 @@ enum {
 #define RATE_MCS_SGI_POS		RATE_MCS_HE_GI_LTF_POS
 #define RATE_MCS_SGI_MSK		(1 << RATE_MCS_SGI_POS)
 #define RATE_MCS_HE_SU_4_LTF		3
+#define RATE_MCS_HE_SU_4_LTF_08_GI	4
 
 /* Bit 24-23: HE type. (0) SU, (1) SU_EXT, (2) MU, (3) trigger based */
 #define RATE_MCS_HE_TYPE_POS		23
@@ -700,5 +711,10 @@ struct iwl_lq_cmd {
 u8 iwl_fw_rate_idx_to_plcp(int idx);
 u32 iwl_new_rate_from_v1(u32 rate_v1);
 u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags);
+const struct iwl_rate_mcs_info *iwl_rate_mcs(int idx);
+const char *iwl_rs_pretty_ant(u8 ant);
+const char *iwl_rs_pretty_bw(int bw);
+int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate);
+bool iwl_he_is_sgi(u32 rate_n_flags);
 
 #endif /* __iwl_fw_api_rs_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index 4e066588d5ba..a21c3befd93b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -6,12 +6,11 @@
 #include <net/mac80211.h>
 #include "fw/api/rs.h"
 #include "iwl-drv.h"
+#include "iwl-config.h"
 
 #define IWL_DECLARE_RATE_INFO(r) \
 	[IWL_RATE_##r##M_INDEX] = IWL_RATE_##r##M_PLCP
 
-u8 iwl_fw_rate_idx_to_plcp(int idx)
-{
 /*
  * Translate from fw_rate_index (IWL_RATE_XXM_INDEX) to PLCP
  * */
@@ -30,10 +29,68 @@ static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
 	IWL_DECLARE_RATE_INFO(54),
 };
 
+/* mbps, mcs */
+static const struct iwl_rate_mcs_info rate_mcs[IWL_RATE_COUNT] = {
+	{  "1", "BPSK DSSS"},
+	{  "2", "QPSK DSSS"},
+	{"5.5", "BPSK CCK"},
+	{ "11", "QPSK CCK"},
+	{  "6", "BPSK 1/2"},
+	{  "9", "BPSK 1/2"},
+	{ "12", "QPSK 1/2"},
+	{ "18", "QPSK 3/4"},
+	{ "24", "16QAM 1/2"},
+	{ "36", "16QAM 3/4"},
+	{ "48", "64QAM 2/3"},
+	{ "54", "64QAM 3/4"},
+	{ "60", "64QAM 5/6"},
+};
+
+static const char * const ant_name[] = {
+	[ANT_NONE] = "None",
+	[ANT_A]    = "A",
+	[ANT_B]    = "B",
+	[ANT_AB]   = "AB",
+};
+
+static const char * const pretty_bw[] = {
+	"20Mhz",
+	"40Mhz",
+	"80Mhz",
+	"160 Mhz",
+	"320Mhz",
+};
+
+u8 iwl_fw_rate_idx_to_plcp(int idx)
+{
 	return fw_rate_idx_to_plcp[idx];
 }
 IWL_EXPORT_SYMBOL(iwl_fw_rate_idx_to_plcp);
 
+const struct iwl_rate_mcs_info *iwl_rate_mcs(int idx)
+{
+	return &rate_mcs[idx];
+}
+IWL_EXPORT_SYMBOL(iwl_rate_mcs);
+
+const char *iwl_rs_pretty_ant(u8 ant)
+{
+	if (ant >= ARRAY_SIZE(ant_name))
+		return "UNKNOWN";
+
+	return ant_name[ant];
+}
+IWL_EXPORT_SYMBOL(iwl_rs_pretty_ant);
+
+const char *iwl_rs_pretty_bw(int bw)
+{
+	if (bw >= ARRAY_SIZE(pretty_bw))
+		return "unknown bw";
+
+	return pretty_bw[bw];
+}
+IWL_EXPORT_SYMBOL(iwl_rs_pretty_bw);
+
 u32 iwl_new_rate_from_v1(u32 rate_v1)
 {
 	u32 rate_v2 = 0;
@@ -129,3 +186,67 @@ u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
 	return -1;
 }
 
+int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
+{
+	char *type;
+	u8 mcs = 0, nss = 0;
+	u8 ant = (rate & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
+	u32 bw = (rate & RATE_MCS_CHAN_WIDTH_MSK) >>
+		RATE_MCS_CHAN_WIDTH_POS;
+	u32 format = rate & RATE_MCS_MOD_TYPE_MSK;
+	bool sgi;
+
+	if (format == RATE_MCS_CCK_MSK ||
+	    format == RATE_MCS_LEGACY_OFDM_MSK) {
+		int legacy_rate = rate & RATE_LEGACY_RATE_MSK;
+		int index = format == RATE_MCS_CCK_MSK ?
+			legacy_rate :
+			legacy_rate + IWL_FIRST_OFDM_RATE;
+
+		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps",
+				 iwl_rs_pretty_ant(ant),
+				 index == IWL_RATE_INVALID ? "BAD" :
+				 iwl_rate_mcs(index)->mbps);
+	}
+
+	if (format ==  RATE_MCS_VHT_MSK)
+		type = "VHT";
+	else if (format ==  RATE_MCS_HT_MSK)
+		type = "HT";
+	else if (format == RATE_MCS_HE_MSK)
+		type = "HE";
+	else
+		type = "Unknown"; /* shouldn't happen */
+
+	mcs = format == RATE_MCS_HT_MSK ?
+		RATE_HT_MCS_INDEX(rate) :
+		rate & RATE_MCS_CODE_MSK;
+	nss = ((rate & RATE_MCS_NSS_MSK)
+	       >> RATE_MCS_NSS_POS) + 1;
+	sgi = format == RATE_MCS_HE_MSK ?
+		iwl_he_is_sgi(rate) :
+		rate & RATE_MCS_SGI_MSK;
+
+	return scnprintf(buf, bufsz,
+			 "0x%x: %s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s%s",
+			 rate, type, iwl_rs_pretty_ant(ant), iwl_rs_pretty_bw(bw), mcs, nss,
+			 (sgi) ? "SGI " : "NGI ",
+			 (rate & RATE_MCS_STBC_MSK) ? "STBC " : "",
+			 (rate & RATE_MCS_LDPC_MSK) ? "LDPC " : "",
+			 (rate & RATE_HE_DUAL_CARRIER_MODE_MSK) ? "DCM " : "",
+			 (rate & RATE_MCS_BF_MSK) ? "BF " : "");
+}
+IWL_EXPORT_SYMBOL(rs_pretty_print_rate);
+
+bool iwl_he_is_sgi(u32 rate_n_flags)
+{
+	u32 type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	u32 ltf_gi = rate_n_flags & RATE_MCS_HE_GI_LTF_MSK;
+
+	if (type == RATE_MCS_HE_TYPE_SU ||
+	    type == RATE_MCS_HE_TYPE_EXT_SU)
+		return ltf_gi == RATE_MCS_HE_SU_4_LTF_08_GI;
+	return false;
+}
+IWL_EXPORT_SYMBOL(iwl_he_is_sgi);
+
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 8c2251178f97..1fba6b421d31 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -985,8 +985,8 @@ static ssize_t iwl_dbgfs_frame_stats_read(struct iwl_mvm *mvm,
 			continue;
 		pos += scnprintf(pos, endpos - pos, "Rate[%d]: ",
 				 (int)(ARRAY_SIZE(stats->last_rates) - i));
-		pos += rs_pretty_print_rate(pos, endpos - pos,
-					    stats->last_rates[idx]);
+		pos += rs_pretty_print_rate_v1(pos, endpos - pos,
+					       stats->last_rates[idx]);
 		if (pos < endpos - 1)
 			*pos++ = '\n';
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1d664dd5915c..4660f21c4e79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4878,7 +4878,9 @@ static int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 
 static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 {
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
+	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		rinfo->bw = RATE_INFO_BW_20;
 		break;
@@ -4893,49 +4895,84 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		break;
 	}
 
-	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
-		rinfo->flags |= RATE_INFO_FLAGS_MCS;
-		rinfo->mcs = u32_get_bits(rate_n_flags, RATE_HT_MCS_INDEX_MSK_V1);
-		rinfo->nss = u32_get_bits(rate_n_flags,
-					  RATE_HT_MCS_NSS_MSK_V1) + 1;
-		if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
-			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
-		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
-		rinfo->mcs = u32_get_bits(rate_n_flags,
-					  RATE_VHT_MCS_RATE_CODE_MSK);
-		rinfo->nss = u32_get_bits(rate_n_flags,
-					  RATE_VHT_MCS_NSS_MSK) + 1;
-		if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
-			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (rate_n_flags & RATE_MCS_HE_MSK_V1) {
+	if (format == RATE_MCS_CCK_MSK ||
+	    format == RATE_MCS_LEGACY_OFDM_MSK) {
+		int rate = u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK);
+
+		/* add the offset needed to get to the legacy ofdm indices */
+		if (format == RATE_MCS_LEGACY_OFDM_MSK)
+			rate += IWL_FIRST_OFDM_RATE;
+
+		switch (rate) {
+		case IWL_RATE_1M_INDEX:
+			rinfo->legacy = 10;
+			break;
+		case IWL_RATE_2M_INDEX:
+			rinfo->legacy = 20;
+			break;
+		case IWL_RATE_5M_INDEX:
+			rinfo->legacy = 55;
+			break;
+		case IWL_RATE_11M_INDEX:
+			rinfo->legacy = 110;
+			break;
+		case IWL_RATE_6M_INDEX:
+			rinfo->legacy = 60;
+			break;
+		case IWL_RATE_9M_INDEX:
+			rinfo->legacy = 90;
+			break;
+		case IWL_RATE_12M_INDEX:
+			rinfo->legacy = 120;
+			break;
+		case IWL_RATE_18M_INDEX:
+			rinfo->legacy = 180;
+			break;
+		case IWL_RATE_24M_INDEX:
+			rinfo->legacy = 240;
+			break;
+		case IWL_RATE_36M_INDEX:
+			rinfo->legacy = 360;
+			break;
+		case IWL_RATE_48M_INDEX:
+			rinfo->legacy = 480;
+			break;
+		case IWL_RATE_54M_INDEX:
+			rinfo->legacy = 540;
+		}
+		return;
+	}
+
+	rinfo->nss = u32_get_bits(rate_n_flags,
+				  RATE_MCS_NSS_MSK) + 1;
+	rinfo->mcs = format == RATE_MCS_HT_MSK ?
+		RATE_HT_MCS_INDEX(rate_n_flags) :
+		u32_get_bits(rate_n_flags, RATE_MCS_CODE_MSK);
+
+	if (format == RATE_MCS_HE_MSK) {
 		u32 gi_ltf = u32_get_bits(rate_n_flags,
-					  RATE_MCS_HE_GI_LTF_MSK_V1);
+					  RATE_MCS_HE_GI_LTF_MSK);
 
 		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
-		rinfo->mcs = u32_get_bits(rate_n_flags,
-					  RATE_VHT_MCS_RATE_CODE_MSK);
-		rinfo->nss = u32_get_bits(rate_n_flags,
-					  RATE_VHT_MCS_NSS_MSK) + 1;
 
-		if (rate_n_flags & RATE_MCS_HE_106T_MSK_V1) {
+		if (rate_n_flags & RATE_MCS_HE_106T_MSK) {
 			rinfo->bw = RATE_INFO_BW_HE_RU;
 			rinfo->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_106;
 		}
 
-		switch (rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1) {
-		case RATE_MCS_HE_TYPE_SU_V1:
-		case RATE_MCS_HE_TYPE_EXT_SU_V1:
+		switch (rate_n_flags & RATE_MCS_HE_TYPE_MSK) {
+		case RATE_MCS_HE_TYPE_SU:
+		case RATE_MCS_HE_TYPE_EXT_SU:
 			if (gi_ltf == 0 || gi_ltf == 1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 			else if (gi_ltf == 2)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
-			else if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
-				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
-			else
+			else if (gi_ltf == 3)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 			break;
-		case RATE_MCS_HE_TYPE_MU_V1:
+		case RATE_MCS_HE_TYPE_MU:
 			if (gi_ltf == 0 || gi_ltf == 1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 			else if (gi_ltf == 2)
@@ -4943,7 +4980,7 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 			else
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 			break;
-		case RATE_MCS_HE_TYPE_TRIG_V1:
+		case RATE_MCS_HE_TYPE_TRIG:
 			if (gi_ltf == 0 || gi_ltf == 1)
 				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 			else
@@ -4953,46 +4990,19 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 
 		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
 			rinfo->he_dcm = 1;
-	} else {
-		switch (u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK_V1)) {
-		case IWL_RATE_1M_PLCP:
-			rinfo->legacy = 10;
-			break;
-		case IWL_RATE_2M_PLCP:
-			rinfo->legacy = 20;
-			break;
-		case IWL_RATE_5M_PLCP:
-			rinfo->legacy = 55;
-			break;
-		case IWL_RATE_11M_PLCP:
-			rinfo->legacy = 110;
-			break;
-		case IWL_RATE_6M_PLCP:
-			rinfo->legacy = 60;
-			break;
-		case IWL_RATE_9M_PLCP:
-			rinfo->legacy = 90;
-			break;
-		case IWL_RATE_12M_PLCP:
-			rinfo->legacy = 120;
-			break;
-		case IWL_RATE_18M_PLCP:
-			rinfo->legacy = 180;
-			break;
-		case IWL_RATE_24M_PLCP:
-			rinfo->legacy = 240;
-			break;
-		case IWL_RATE_36M_PLCP:
-			rinfo->legacy = 360;
-			break;
-		case IWL_RATE_48M_PLCP:
-			rinfo->legacy = 480;
-			break;
-		case IWL_RATE_54M_PLCP:
-			rinfo->legacy = 540;
-			break;
-		}
+		return;
+	}
+
+	if (rate_n_flags & RATE_MCS_SGI_MSK)
+		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+	if (format == RATE_MCS_HT_MSK) {
+		rinfo->flags |= RATE_INFO_FLAGS_MCS;
+
+	} else if (format == RATE_MCS_VHT_MSK) {
+		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
 	}
+
 }
 
 static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f877d86b038e..50a11a595db1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1732,7 +1732,7 @@ iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 /* rate scaling */
 int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq);
 void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg);
-int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate);
+int rs_pretty_print_rate_v1(char *buf, int bufsz, const u32 rate);
 void rs_update_last_rssi(struct iwl_mvm *mvm,
 			 struct iwl_mvm_sta *mvmsta,
 			 struct ieee80211_rx_status *rx_status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 5b224a19bb32..958702403a45 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -310,7 +310,19 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 	if (flags & IWL_TLC_NOTIF_FLAG_RATE) {
 		char pretty_rate[100];
+
+	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+				    TLC_MNG_UPDATE_NOTIF, 0) < 3) {
+		rs_pretty_print_rate_v1(pretty_rate, sizeof(pretty_rate),
+					le32_to_cpu(notif->rate));
+		IWL_DEBUG_RATE(mvm,
+			       "Got rate in old format. Rate: %s. Converting.\n",
+			       pretty_rate);
+		lq_sta->last_rate_n_flags =
+			iwl_new_rate_from_v1(le32_to_cpu(notif->rate));
+	} else {
 		lq_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
+	}
 		rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
 				     lq_sta->last_rate_n_flags);
 		IWL_DEBUG_RATE(mvm, "new rate: %s\n", pretty_rate);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index df248d83606a..88b5969d7b51 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -454,40 +454,8 @@ static const u16 expected_tpt_mimo2_160MHz[4][IWL_RATE_COUNT] = {
 	{0, 0, 0, 0, 971, 0, 1925, 2861, 3779, 5574, 7304, 8147, 8976, 10592, 11640},
 };
 
-/* mbps, mcs */
-static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
-	{  "1", "BPSK DSSS"},
-	{  "2", "QPSK DSSS"},
-	{"5.5", "BPSK CCK"},
-	{ "11", "QPSK CCK"},
-	{  "6", "BPSK 1/2"},
-	{  "9", "BPSK 1/2"},
-	{ "12", "QPSK 1/2"},
-	{ "18", "QPSK 3/4"},
-	{ "24", "16QAM 1/2"},
-	{ "36", "16QAM 3/4"},
-	{ "48", "64QAM 2/3"},
-	{ "54", "64QAM 3/4"},
-	{ "60", "64QAM 5/6"},
-};
-
 #define MCS_INDEX_PER_STREAM	(8)
 
-static const char *rs_pretty_ant(u8 ant)
-{
-	static const char * const ant_name[] = {
-		[ANT_NONE] = "None",
-		[ANT_A]    = "A",
-		[ANT_B]    = "B",
-		[ANT_AB]   = "AB",
-	};
-
-	if (ant > ANT_AB)
-		return "UNKNOWN";
-
-	return ant_name[ant];
-}
-
 static const char *rs_pretty_lq_type(enum iwl_table_type type)
 {
 	static const char * const lq_types[] = {
@@ -549,7 +517,7 @@ static char *rs_pretty_rate(const struct rs_rate *rate)
 		rate_str = "BAD_RATE";
 
 	sprintf(buf, "(%s|%s|%s)", rs_pretty_lq_type(rate->type),
-		rs_pretty_ant(rate->ant), rate_str);
+		iwl_rs_pretty_ant(rate->ant), rate_str);
 	return buf;
 }
 
@@ -2539,7 +2507,7 @@ static void rs_get_initial_rate(struct iwl_mvm *mvm,
 	}
 
 	IWL_DEBUG_RATE(mvm, "Best ANT: %s Best RSSI: %d\n",
-		       rs_pretty_ant(best_ant), best_rssi);
+		       iwl_rs_pretty_ant(best_ant), best_rssi);
 
 	if (best_ant != ANT_A && best_ant != ANT_B)
 		rate->ant = first_antenna(valid_tx_ant);
@@ -3674,12 +3642,14 @@ static void rs_free_sta(void *mvm_r, struct ieee80211_sta *sta, void *mvm_sta)
 	IWL_DEBUG_RATE(mvm, "leave\n");
 }
 
-int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
+int rs_pretty_print_rate_v1(char *buf, int bufsz, const u32 rate)
 {
 
-	char *type, *bw;
+	char *type;
 	u8 mcs = 0, nss = 0;
 	u8 ant = (rate & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
+	u32 bw = (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) >>
+		RATE_MCS_CHAN_WIDTH_POS;
 
 	if (!(rate & RATE_MCS_HT_MSK_V1) &&
 	    !(rate & RATE_MCS_VHT_MSK_V1) &&
@@ -3687,9 +3657,9 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 		int index = iwl_hwrate_to_plcp_idx(rate);
 
 		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps",
-				 rs_pretty_ant(ant),
+				 iwl_rs_pretty_ant(ant),
 				 index == IWL_RATE_INVALID ? "BAD" :
-				 iwl_rate_mcs[index].mbps);
+				 iwl_rate_mcs(index)->mbps);
 	}
 
 	if (rate & RATE_MCS_VHT_MSK_V1) {
@@ -3711,26 +3681,9 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 		type = "Unknown"; /* shouldn't happen */
 	}
 
-	switch (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) {
-	case RATE_MCS_CHAN_WIDTH_20:
-		bw = "20Mhz";
-		break;
-	case RATE_MCS_CHAN_WIDTH_40:
-		bw = "40Mhz";
-		break;
-	case RATE_MCS_CHAN_WIDTH_80:
-		bw = "80Mhz";
-		break;
-	case RATE_MCS_CHAN_WIDTH_160:
-		bw = "160Mhz";
-		break;
-	default:
-		bw = "BAD BW";
-	}
-
 	return scnprintf(buf, bufsz,
 			 "0x%x: %s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s%s",
-			 rate, type, rs_pretty_ant(ant), bw, mcs, nss,
+			 rate, type, iwl_rs_pretty_ant(ant), iwl_rs_pretty_bw(bw), mcs, nss,
 			 (rate & RATE_MCS_SGI_MSK_V1) ? "SGI " : "NGI ",
 			 (rate & RATE_MCS_STBC_MSK) ? "STBC " : "",
 			 (rate & RATE_MCS_LDPC_MSK_V1) ? "LDPC " : "",
@@ -3876,7 +3829,7 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 
 		desc += scnprintf(buff + desc, bufsz - desc,
 				  " rate[%d] 0x%X ", i, r);
-		desc += rs_pretty_print_rate(buff + desc, bufsz - desc, r);
+		desc += rs_pretty_print_rate_v1(buff + desc, bufsz - desc, r);
 		if (desc < bufsz - 1)
 			buff[desc++] = '\n';
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 3e206df57347..b7bc8c1b2dda 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -31,11 +31,6 @@ struct iwl_rs_rate_info {
 
 #define IWL_RATE_60M_PLCP 3
 
-enum {
-	IWL_RATE_INVM_INDEX = IWL_RATE_COUNT,
-	IWL_RATE_INVALID = IWL_RATE_COUNT,
-};
-
 #define LINK_QUAL_MAX_RETRY_NUM 16
 
 enum {
@@ -206,13 +201,6 @@ struct rs_rate {
 #define is_ht80(rate)         ((rate)->bw == RATE_MCS_CHAN_WIDTH_80)
 #define is_ht160(rate)        ((rate)->bw == RATE_MCS_CHAN_WIDTH_160)
 
-#define IWL_MAX_MCS_DISPLAY_SIZE	12
-
-struct iwl_rate_mcs_info {
-	char	mbps[IWL_MAX_MCS_DISPLAY_SIZE];
-	char	mcs[IWL_MAX_MCS_DISPLAY_SIZE];
-};
-
 /**
  * struct iwl_lq_sta_rs_fw - rate and related statistics for RS in FW
  * @last_rate_n_flags: last rate reported by FW
-- 
2.33.0

