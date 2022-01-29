Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3004A2E20
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiA2LQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37888 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237285AbiA2LQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:36 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDlib-0002ji-TM;
        Sat, 29 Jan 2022 13:16:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:20 +0200
Message-Id: <iwlwifi.20220129105618.6054f8028102.I07d7f406c29c9725d8cd9e979c0070332bbfc64b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: mvm: support v3 of station HE context command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This now includes 320 MHz and some other data for EHT, support
it, but don't fill in the additional EHT data for now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   | 127 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  86 ++++++++++--
 2 files changed, 193 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 11f0bd283e49..9b7caf968346 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -413,10 +413,11 @@ enum iwl_he_pkt_ext_constellations {
 };
 
 #define MAX_HE_SUPP_NSS	2
-#define MAX_HE_CHANNEL_BW_INDX	4
+#define MAX_CHANNEL_BW_INDX_API_D_VER_2	4
+#define MAX_CHANNEL_BW_INDX_API_D_VER_3	5
 
 /**
- * struct iwl_he_pkt_ext - QAM thresholds
+ * struct iwl_he_pkt_ext_v1 - QAM thresholds
  * The required PPE is set via HE Capabilities IE, per Nss x BW x MCS
  * The IE is organized in the following way:
  * Support for Nss x BW (or RU) matrix:
@@ -435,9 +436,34 @@ enum iwl_he_pkt_ext_constellations {
  *	Nss (0-siso, 1-mimo2) x BW (0-20MHz, 1-40MHz, 2-80MHz, 3-160MHz) x
  *		(0-low_th, 1-high_th)
  */
-struct iwl_he_pkt_ext {
-	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_HE_CHANNEL_BW_INDX][2];
-} __packed; /* PKT_EXT_DOT11AX_API_S */
+struct iwl_he_pkt_ext_v1 {
+	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_CHANNEL_BW_INDX_API_D_VER_2][2];
+} __packed; /* PKT_EXT_DOT11AX_API_S_VER_1 */
+
+/**
+ * struct iwl_he_pkt_ext_v2 - QAM thresholds
+ * The required PPE is set via HE Capabilities IE, per Nss x BW x MCS
+ * The IE is organized in the following way:
+ * Support for Nss x BW (or RU) matrix:
+ *	(0=SISO, 1=MIMO2) x (0-20MHz, 1-40MHz, 2-80MHz, 3-160MHz)
+ * Each entry contains 2 QAM thresholds for 8us and 16us:
+ *	0=BPSK, 1=QPSK, 2=16QAM, 3=64QAM, 4=256QAM, 5=1024QAM, 6=RES, 7=NONE
+ * i.e. QAM_th1 < QAM_th2 such if TX uses QAM_tx:
+ *	QAM_tx < QAM_th1            --> PPE=0us
+ *	QAM_th1 <= QAM_tx < QAM_th2 --> PPE=8us
+ *	QAM_th2 <= QAM_tx           --> PPE=16us
+ * @pkt_ext_qam_th: QAM thresholds
+ *	For each Nss/Bw define 2 QAM thrsholds (0..5)
+ *	For rates below the low_th, no need for PPE
+ *	For rates between low_th and high_th, need 8us PPE
+ *	For rates equal or higher then the high_th, need 16us PPE
+ *	Nss (0-siso, 1-mimo2) x
+ *	BW (0-20MHz, 1-40MHz, 2-80MHz, 3-160MHz, 4-320MHz) x
+ *	(0-low_th, 1-high_th)
+ */
+struct iwl_he_pkt_ext_v2 {
+	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_CHANNEL_BW_INDX_API_D_VER_3][2];
+} __packed; /* PKT_EXT_DOT11AX_API_S_VER_2 */
 
 /**
  * enum iwl_he_sta_ctxt_flags - HE STA context flags
@@ -464,6 +490,11 @@ struct iwl_he_pkt_ext {
  * @STA_CTXT_HE_RU_2MHZ_BLOCK: indicates that 26-tone RU OFDMA transmission are
  *      not allowed (as there are OBSS that might classify such transmissions as
  *      radar pulses).
+ * @STA_CTXT_HE_NDP_FEEDBACK_ENABLED: mark support for NDP feedback and change
+ *	of threshold
+ * @STA_CTXT_EHT_PUNCTURE_MASK_VALID: indicates the puncture_mask field is valid
+ * @STA_CTXT_EHT_LONG_PPE_ENABLED: indicates the PPE requirement should be
+ *	extended to 20us for BW > 160Mhz or for MCS w/ 4096-QAM.
  */
 enum iwl_he_sta_ctxt_flags {
 	STA_CTXT_HE_REF_BSSID_VALID		= BIT(4),
@@ -477,6 +508,9 @@ enum iwl_he_sta_ctxt_flags {
 	STA_CTXT_HE_MU_EDCA_CW			= BIT(12),
 	STA_CTXT_HE_NIC_NOT_ACK_ENABLED		= BIT(13),
 	STA_CTXT_HE_RU_2MHZ_BLOCK		= BIT(14),
+	STA_CTXT_HE_NDP_FEEDBACK_ENABLED	= BIT(15),
+	STA_CTXT_EHT_PUNCTURE_MASK_VALID	= BIT(16),
+	STA_CTXT_EHT_LONG_PPE_ENABLED		= BIT(17),
 };
 
 /**
@@ -551,7 +585,7 @@ struct iwl_he_sta_context_cmd_v1 {
 	u8 frag_min_size;
 
 	/* The below fields are set via PPE thresholds element */
-	struct iwl_he_pkt_ext pkt_ext;
+	struct iwl_he_pkt_ext_v1 pkt_ext;
 
 	/* The below fields are set via HE-Operation IE */
 	u8 bss_color;
@@ -568,7 +602,7 @@ struct iwl_he_sta_context_cmd_v1 {
 } __packed; /* STA_CONTEXT_DOT11AX_API_S_VER_1 */
 
 /**
- * struct iwl_he_sta_context_cmd - configure FW to work with HE AP
+ * struct iwl_he_sta_context_cmd_v2 - configure FW to work with HE AP
  * @sta_id: STA id
  * @tid_limit: max num of TIDs in TX HE-SU multi-TID agg
  *	0 - bad value, 1 - multi-tid not supported, 2..8 - tid limit
@@ -599,7 +633,7 @@ struct iwl_he_sta_context_cmd_v1 {
  * @bssid_count: actual number of VAPs in the MultiBSS Set
  * @reserved4: alignment
  */
-struct iwl_he_sta_context_cmd {
+struct iwl_he_sta_context_cmd_v2 {
 	u8 sta_id;
 	u8 tid_limit;
 	u8 reserved1;
@@ -619,7 +653,7 @@ struct iwl_he_sta_context_cmd {
 	u8 frag_min_size;
 
 	/* The below fields are set via PPE thresholds element */
-	struct iwl_he_pkt_ext pkt_ext;
+	struct iwl_he_pkt_ext_v1 pkt_ext;
 
 	/* The below fields are set via HE-Operation IE */
 	u8 bss_color;
@@ -642,6 +676,81 @@ struct iwl_he_sta_context_cmd {
 	u8 reserved4[3];
 } __packed; /* STA_CONTEXT_DOT11AX_API_S_VER_2 */
 
+/**
+ * struct iwl_he_sta_context_cmd_v3 - configure FW to work with HE AP
+ * @sta_id: STA id
+ * @tid_limit: max num of TIDs in TX HE-SU multi-TID agg
+ *	0 - bad value, 1 - multi-tid not supported, 2..8 - tid limit
+ * @reserved1: reserved byte for future use
+ * @reserved2: reserved byte for future use
+ * @flags: see %iwl_11ax_sta_ctxt_flags
+ * @ref_bssid_addr: reference BSSID used by the AP
+ * @reserved0: reserved 2 bytes for aligning the ref_bssid_addr field to 8 bytes
+ * @htc_flags: which features are supported in HTC
+ * @frag_flags: frag support in A-MSDU
+ * @frag_level: frag support level
+ * @frag_max_num: max num of "open" MSDUs in the receiver (in power of 2)
+ * @frag_min_size: min frag size (except last frag)
+ * @pkt_ext: optional, exists according to PPE-present bit in the HE-PHY capa
+ * @bss_color: 11ax AP ID that is used in the HE SIG-A to mark inter BSS frame
+ * @htc_trig_based_pkt_ext: default PE in 4us units
+ * @frame_time_rts_th: HE duration RTS threshold, in units of 32us
+ * @rand_alloc_ecwmin: random CWmin = 2**ECWmin-1
+ * @rand_alloc_ecwmax: random CWmax = 2**ECWmax-1
+ * @puncture_mask: puncture mask for EHT
+ * @trig_based_txf: MU EDCA Parameter set for the trigger based traffic queues
+ * @max_bssid_indicator: indicator of the max bssid supported on the associated
+ *	bss
+ * @bssid_index: index of the associated VAP
+ * @ema_ap: AP supports enhanced Multi BSSID advertisement
+ * @profile_periodicity: number of Beacon periods that are needed to receive the
+ *	complete VAPs info
+ * @bssid_count: actual number of VAPs in the MultiBSS Set
+ * @reserved4: alignment
+ */
+struct iwl_he_sta_context_cmd_v3 {
+	u8 sta_id;
+	u8 tid_limit;
+	u8 reserved1;
+	u8 reserved2;
+	__le32 flags;
+
+	/* The below fields are set via Multiple BSSID IE */
+	u8 ref_bssid_addr[6];
+	__le16 reserved0;
+
+	/* The below fields are set via HE-capabilities IE */
+	__le32 htc_flags;
+
+	u8 frag_flags;
+	u8 frag_level;
+	u8 frag_max_num;
+	u8 frag_min_size;
+
+	/* The below fields are set via PPE thresholds element */
+	struct iwl_he_pkt_ext_v2 pkt_ext;
+
+	/* The below fields are set via HE-Operation IE */
+	u8 bss_color;
+	u8 htc_trig_based_pkt_ext;
+	__le16 frame_time_rts_th;
+
+	/* Random access parameter set (i.e. RAPS) */
+	u8 rand_alloc_ecwmin;
+	u8 rand_alloc_ecwmax;
+	__le16 puncture_mask;
+
+	/* The below fields are set via MU EDCA parameter set element */
+	struct iwl_he_backoff_conf trig_based_txf[AC_NUM];
+
+	u8 max_bssid_indicator;
+	u8 bssid_index;
+	u8 ema_ap;
+	u8 profile_periodicity;
+	u8 bssid_count;
+	u8 reserved4[3];
+} __packed; /* STA_CONTEXT_DOT11AX_API_S_VER_2 */
+
 /**
  * struct iwl_he_monitor_cmd - configure air sniffer for HE
  * @bssid: the BSSID to sniff for
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6808445f80e5..1d74e8b3576a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2090,7 +2090,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif, u8 sta_id)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_he_sta_context_cmd sta_ctxt_cmd = {
+	struct iwl_he_sta_context_cmd_v3 sta_ctxt_cmd = {
 		.sta_id = sta_id,
 		.tid_limit = IWL_MAX_TID_COUNT,
 		.bss_color = vif->bss_conf.he_bss_color.color,
@@ -2098,16 +2098,39 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 		.frame_time_rts_th =
 			cpu_to_le16(vif->bss_conf.frame_time_rts_th),
 	};
-	int size = fw_has_api(&mvm->fw->ucode_capa,
-			      IWL_UCODE_TLV_API_MBSSID_HE) ?
-		   sizeof(sta_ctxt_cmd) :
-		   sizeof(struct iwl_he_sta_context_cmd_v1);
+	struct iwl_he_sta_context_cmd_v2 sta_ctxt_cmd_v2 = {};
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, STA_HE_CTXT_CMD);
+	u8 ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 2);
+	int size;
 	struct ieee80211_sta *sta;
 	u32 flags;
 	int i;
 	const struct ieee80211_sta_he_cap *own_he_cap = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	const struct ieee80211_supported_band *sband;
+	void *cmd;
+
+	if (!fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_MBSSID_HE))
+		ver = 1;
+
+	switch (ver) {
+	case 1:
+		/* same layout as v2 except some data at the end */
+		cmd = &sta_ctxt_cmd_v2;
+		size = sizeof(struct iwl_he_sta_context_cmd_v1);
+		break;
+	case 2:
+		cmd = &sta_ctxt_cmd_v2;
+		size = sizeof(struct iwl_he_sta_context_cmd_v2);
+		break;
+	case 3:
+		cmd = &sta_ctxt_cmd;
+		size = sizeof(struct iwl_he_sta_context_cmd_v3);
+		break;
+	default:
+		IWL_ERR(mvm, "bad STA_HE_CTXT_CMD version %d\n", ver);
+		return;
+	}
 
 	rcu_read_lock();
 
@@ -2202,7 +2225,9 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			u8 ru_index_tmp = ru_index_bitmap << 1;
 			u8 bw;
 
-			for (bw = 0; bw < MAX_HE_CHANNEL_BW_INDX; bw++) {
+			for (bw = 0;
+			     bw < ARRAY_SIZE(sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i]);
+			     bw++) {
 				ru_index_tmp >>= 1;
 				if (!(ru_index_tmp & 1))
 					continue;
@@ -2246,13 +2271,14 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 		/* Set the PPE thresholds accordingly */
 		if (low_th >= 0 && high_th >= 0) {
-			struct iwl_he_pkt_ext *pkt_ext =
-				(struct iwl_he_pkt_ext *)&sta_ctxt_cmd.pkt_ext;
+			struct iwl_he_pkt_ext_v2 *pkt_ext =
+				&sta_ctxt_cmd.pkt_ext;
 
 			for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
 				u8 bw;
 
-				for (bw = 0; bw < MAX_HE_CHANNEL_BW_INDX;
+				for (bw = 0;
+				     bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
 				     bw++) {
 					pkt_ext->pkt_ext_qam_th[i][bw][0] =
 						low_th;
@@ -2325,8 +2351,46 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	sta_ctxt_cmd.flags = cpu_to_le32(flags);
 
-	if (iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(DATA_PATH_GROUP, STA_HE_CTXT_CMD),
-				 0, size, &sta_ctxt_cmd))
+	if (ver < 3) {
+		/* fields before pkt_ext */
+		BUILD_BUG_ON(offsetof(typeof(sta_ctxt_cmd), pkt_ext) !=
+			     offsetof(typeof(sta_ctxt_cmd_v2), pkt_ext));
+		memcpy(&sta_ctxt_cmd_v2, &sta_ctxt_cmd,
+		       offsetof(typeof(sta_ctxt_cmd), pkt_ext));
+
+		/* pkt_ext */
+		for (i = 0;
+		     i < ARRAY_SIZE(sta_ctxt_cmd_v2.pkt_ext.pkt_ext_qam_th);
+		     i++) {
+			u8 bw;
+
+			for (bw = 0;
+			     bw < ARRAY_SIZE(sta_ctxt_cmd_v2.pkt_ext.pkt_ext_qam_th[i]);
+			     bw++) {
+				BUILD_BUG_ON(sizeof(sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw]) !=
+					     sizeof(sta_ctxt_cmd_v2.pkt_ext.pkt_ext_qam_th[i][bw]));
+
+				memcpy(&sta_ctxt_cmd_v2.pkt_ext.pkt_ext_qam_th[i][bw],
+				       &sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw],
+				       sizeof(sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw]));
+			}
+		}
+
+		/* fields after pkt_ext */
+		BUILD_BUG_ON(sizeof(sta_ctxt_cmd) -
+			     offsetofend(typeof(sta_ctxt_cmd), pkt_ext) !=
+			     sizeof(sta_ctxt_cmd_v2) -
+			     offsetofend(typeof(sta_ctxt_cmd_v2), pkt_ext));
+		memcpy((u8 *)&sta_ctxt_cmd_v2 +
+				offsetofend(typeof(sta_ctxt_cmd_v2), pkt_ext),
+		       (u8 *)&sta_ctxt_cmd +
+				offsetofend(typeof(sta_ctxt_cmd), pkt_ext),
+		       sizeof(sta_ctxt_cmd) -
+				offsetofend(typeof(sta_ctxt_cmd), pkt_ext));
+		sta_ctxt_cmd_v2.reserved3 = 0;
+	}
+
+	if (iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, size, cmd))
 		IWL_ERR(mvm, "Failed to config FW to work HE!\n");
 }
 
-- 
2.34.1

