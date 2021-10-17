Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282343078B
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbhJQJms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53688 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245181AbhJQJmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2ec-000YUg-A5; Sun, 17 Oct 2021 12:40:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:16 +0300
Message-Id: <iwlwifi.20211017123741.1ea5263dafec.Iadffe7cb26554d4c23c9242eb2ec8326306202a9@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: mvm: convert old rate & flags to the new format.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate & flags, convert an old format rate to
the new. This is needed if the driver supports the new format
but the FW supports the old one.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |   7 +
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 131 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  25 +---
 4 files changed, 141 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/rs.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index d86918d162aa..0d4656efe908 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -15,7 +15,7 @@ iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
 iwlwifi-objs		+= queue/tx.o
 
-iwlwifi-objs		+= fw/img.o fw/notif-wait.o
+iwlwifi-objs		+= fw/img.o fw/notif-wait.o fw/rs.o
 iwlwifi-objs		+= fw/dbg.o fw/pnvm.o fw/dump.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 8d7198897535..8b4f3c311634 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -303,6 +303,7 @@ enum {
 #define RATE_HT_MCS_RATE_CODE_MSK_V1	0x7
 #define RATE_HT_MCS_NSS_POS_V1          3
 #define RATE_HT_MCS_NSS_MSK_V1          (3 << RATE_HT_MCS_NSS_POS_V1)
+#define RATE_HT_MCS_MIMO2_MSK		BIT(RATE_HT_MCS_NSS_POS_V1)
 
 /* Bit 10: (1) Use Green Field preamble */
 #define RATE_HT_MCS_GF_POS		10
@@ -324,6 +325,7 @@ enum {
 #define RATE_VHT_MCS_RATE_CODE_MSK	0xf
 #define RATE_VHT_MCS_NSS_POS		4
 #define RATE_VHT_MCS_NSS_MSK		(3 << RATE_VHT_MCS_NSS_POS)
+#define RATE_VHT_MCS_MIMO2_MSK		BIT(RATE_VHT_MCS_NSS_POS)
 
 /*
  * Legacy OFDM rate format for bits 7:0
@@ -545,6 +547,7 @@ enum {
 #define RATE_MCS_HE_GI_LTF_MSK		(0x7 << RATE_MCS_HE_GI_LTF_POS)
 #define RATE_MCS_SGI_POS		RATE_MCS_HE_GI_LTF_POS
 #define RATE_MCS_SGI_MSK		(1 << RATE_MCS_SGI_POS)
+#define RATE_MCS_HE_SU_4_LTF		3
 
 /* Bit 24-23: HE type. (0) SU, (1) SU_EXT, (2) MU, (3) trigger based */
 #define RATE_MCS_HE_TYPE_POS		23
@@ -694,4 +697,8 @@ struct iwl_lq_cmd {
 	__le32 ss_params;
 }; /* LINK_QUALITY_CMD_API_S_VER_1 */
 
+u8 iwl_fw_rate_idx_to_plcp(int idx);
+u32 iwl_new_rate_from_v1(u32 rate_v1);
+u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags);
+
 #endif /* __iwl_fw_api_rs_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
new file mode 100644
index 000000000000..4e066588d5ba
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <net/mac80211.h>
+#include "fw/api/rs.h"
+#include "iwl-drv.h"
+
+#define IWL_DECLARE_RATE_INFO(r) \
+	[IWL_RATE_##r##M_INDEX] = IWL_RATE_##r##M_PLCP
+
+u8 iwl_fw_rate_idx_to_plcp(int idx)
+{
+/*
+ * Translate from fw_rate_index (IWL_RATE_XXM_INDEX) to PLCP
+ * */
+static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
+	IWL_DECLARE_RATE_INFO(1),
+	IWL_DECLARE_RATE_INFO(2),
+	IWL_DECLARE_RATE_INFO(5),
+	IWL_DECLARE_RATE_INFO(11),
+	IWL_DECLARE_RATE_INFO(6),
+	IWL_DECLARE_RATE_INFO(9),
+	IWL_DECLARE_RATE_INFO(12),
+	IWL_DECLARE_RATE_INFO(18),
+	IWL_DECLARE_RATE_INFO(24),
+	IWL_DECLARE_RATE_INFO(36),
+	IWL_DECLARE_RATE_INFO(48),
+	IWL_DECLARE_RATE_INFO(54),
+};
+
+	return fw_rate_idx_to_plcp[idx];
+}
+IWL_EXPORT_SYMBOL(iwl_fw_rate_idx_to_plcp);
+
+u32 iwl_new_rate_from_v1(u32 rate_v1)
+{
+	u32 rate_v2 = 0;
+	u32 dup = 0;
+
+	if (rate_v1 == 0)
+		return rate_v1;
+	/* convert rate */
+	if (rate_v1 & RATE_MCS_HT_MSK_V1) {
+		u32 nss = 0;
+
+		rate_v2 |= RATE_MCS_HT_MSK;
+		rate_v2 |=
+			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
+		nss = (rate_v1 & RATE_HT_MCS_MIMO2_MSK) >>
+			RATE_HT_MCS_NSS_POS_V1;
+		rate_v2 |= nss << RATE_MCS_NSS_POS;
+	} else if (rate_v1 & RATE_MCS_VHT_MSK_V1 ||
+		   rate_v1 & RATE_MCS_HE_MSK_V1) {
+		rate_v2 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
+
+		rate_v2 |= rate_v1 & RATE_VHT_MCS_MIMO2_MSK;
+
+		if (rate_v1 & RATE_MCS_HE_MSK_V1) {
+			u32 he_type_bits = rate_v1 & RATE_MCS_HE_TYPE_MSK_V1;
+			u32 he_type = he_type_bits >> RATE_MCS_HE_TYPE_POS_V1;
+			u32 he_106t = (rate_v1 & RATE_MCS_HE_106T_MSK_V1) >>
+				RATE_MCS_HE_106T_POS_V1;
+			u32 he_gi_ltf = (rate_v1 & RATE_MCS_HE_GI_LTF_MSK_V1) >>
+				RATE_MCS_HE_GI_LTF_POS;
+
+			if ((he_type_bits == RATE_MCS_HE_TYPE_SU ||
+			     he_type_bits == RATE_MCS_HE_TYPE_EXT_SU) &&
+			    he_gi_ltf == RATE_MCS_HE_SU_4_LTF)
+				/* the new rate have an additional bit to
+				 * represent the value 4 rather then using SGI
+				 * bit for this purpose - as it was done in the old
+				 * rate */
+				he_gi_ltf += (rate_v1 & RATE_MCS_SGI_MSK_V1) >>
+					RATE_MCS_SGI_POS_V1;
+
+			rate_v2 |= he_gi_ltf << RATE_MCS_HE_GI_LTF_POS;
+			rate_v2 |= he_type << RATE_MCS_HE_TYPE_POS;
+			rate_v2 |= he_106t << RATE_MCS_HE_106T_POS;
+			rate_v2 |= rate_v1 & RATE_HE_DUAL_CARRIER_MODE_MSK;
+			rate_v2 |= RATE_MCS_HE_MSK;
+		} else {
+			rate_v2 |= RATE_MCS_VHT_MSK;
+		}
+	/* if legacy format */
+	} else {
+		u32 legacy_rate = iwl_legacy_rate_to_fw_idx(rate_v1);
+
+		WARN_ON(legacy_rate < 0);
+		rate_v2 |= legacy_rate;
+		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
+			rate_v2 |= RATE_MCS_LEGACY_OFDM_MSK;
+	}
+
+	/* convert flags */
+	if (rate_v1 & RATE_MCS_LDPC_MSK_V1)
+		rate_v2 |= RATE_MCS_LDPC_MSK;
+	rate_v2 |= (rate_v1 & RATE_MCS_CHAN_WIDTH_MSK_V1) |
+		(rate_v1 & RATE_MCS_ANT_AB_MSK) |
+		(rate_v1 & RATE_MCS_STBC_MSK) |
+		(rate_v1 & RATE_MCS_BF_MSK);
+
+	dup = (rate_v1 & RATE_MCS_DUP_MSK_V1) >> RATE_MCS_DUP_POS_V1;
+	if (dup) {
+		rate_v2 |= RATE_MCS_DUP_MSK;
+		rate_v2 |= dup << RATE_MCS_CHAN_WIDTH_POS;
+	}
+
+	if ((!(rate_v1 & RATE_MCS_HE_MSK_V1)) &&
+	    (rate_v1 & RATE_MCS_SGI_MSK_V1))
+		rate_v2 |= RATE_MCS_SGI_MSK;
+
+	return rate_v2;
+}
+IWL_EXPORT_SYMBOL(iwl_new_rate_from_v1);
+
+u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
+{
+	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
+	int idx;
+	bool ofdm = !(rate_n_flags & RATE_MCS_CCK_MSK_V1);
+	int offset = ofdm ? IWL_FIRST_OFDM_RATE : 0;
+	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
+
+	for (idx = offset; idx < last; idx++)
+		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
+			return idx - offset;
+	return -1;
+}
+
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 70ca6d7a31bf..dc1727280248 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -135,27 +135,6 @@ int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id, u16 len,
 	return iwl_mvm_send_cmd_status(mvm, &cmd, status);
 }
 
-#define IWL_DECLARE_RATE_INFO(r) \
-	[IWL_RATE_##r##M_INDEX] = IWL_RATE_##r##M_PLCP
-
-/*
- * Translate from fw_rate_index (IWL_RATE_XXM_INDEX) to PLCP
- */
-static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
-	IWL_DECLARE_RATE_INFO(1),
-	IWL_DECLARE_RATE_INFO(2),
-	IWL_DECLARE_RATE_INFO(5),
-	IWL_DECLARE_RATE_INFO(11),
-	IWL_DECLARE_RATE_INFO(6),
-	IWL_DECLARE_RATE_INFO(9),
-	IWL_DECLARE_RATE_INFO(12),
-	IWL_DECLARE_RATE_INFO(18),
-	IWL_DECLARE_RATE_INFO(24),
-	IWL_DECLARE_RATE_INFO(36),
-	IWL_DECLARE_RATE_INFO(48),
-	IWL_DECLARE_RATE_INFO(54),
-};
-
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band)
 {
@@ -167,7 +146,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 	if (band != NL80211_BAND_2GHZ)
 		band_offset = IWL_FIRST_OFDM_RATE;
 	for (idx = band_offset; idx < IWL_RATE_COUNT_LEGACY; idx++)
-		if (fw_rate_idx_to_plcp[idx] == rate)
+		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
 			return idx - band_offset;
 
 	return -1;
@@ -176,7 +155,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 u8 iwl_mvm_mac80211_idx_to_hwrate(int rate_idx)
 {
 	/* Get PLCP rate for tx_cmd->rate_n_flags */
-	return fw_rate_idx_to_plcp[rate_idx];
+	return iwl_fw_rate_idx_to_plcp(rate_idx);
 }
 
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac)
-- 
2.33.0

