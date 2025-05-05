Return-Path: <linux-wireless+bounces-22478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941DAA9C20
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D64A5A015D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFDD20C465;
	Mon,  5 May 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WixZZgx1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757026FD9E
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471456; cv=none; b=DAf0JY5y2qBh2NNGjg6wor3GZDLxfwAHtT4v1EAU7DabIaRGlYxUD8yCUXWijzvUse7anwvj+OoAoIItSc8gx/EVVCckcdRrV9+U6ELJYT9trtW5oUf6f8eokDdwNTdugwvrak8hZo5fMBiY/4EvTLjZXYkH6svCJl1RiwYsRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471456; c=relaxed/simple;
	bh=0DKKmN3e2w+reMkQttV33UTjsFXQ5/kI8YdbfpaCgNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Knvx+RPkPQoiKCxZrdokI+W/DGXKY7vTBJ8gqgdPmx9pLas/U+lVpRGO08ZG8hRT+4DALrwrdl+wVYibuuGX9idPitg0iFEqs4dJytt7qVQjEnwWkSEs6tB2p/TmV7xV7muurJu0LgKHFUnwgF3QURwOpLNuCPzpp7/agzebLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WixZZgx1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471453; x=1778007453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0DKKmN3e2w+reMkQttV33UTjsFXQ5/kI8YdbfpaCgNY=;
  b=WixZZgx1th4aEaNWigMs7QHqhWSBclrBKk1adnfm3GFYmpKhUNjUKTMr
   rmPRBsl8FtZe5A3C9kPogvDkC84Z6vbkFP04aBR1aGebY5qFV+M2TjEcz
   FHtwfB1BtEIi8i6uQwpHH0L6V6+Bz/EI5gtl0enNLLxaEAWFKls6SXPSz
   QkZq/WpmiaGLKTz4Qg8xoV62iWiH1mwzIrBOM7xMz/lt+7oGjgVbHH/bQ
   JF4wB36rkcBm6SPa5YJwnvZiTziBwjkwzM+wIiKHFOw5aRB/FMwSDu1Cb
   pluT1hHUyomkHHBPk7Y4Ovs3L5sUsik3tOrHKybxzbggfqAcw0hpF7GPT
   Q==;
X-CSE-ConnectionGUID: yszXa8ioTFmIDe1j3LamkA==
X-CSE-MsgGUID: 1MNE+v14QT2cIMBtTS74FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359470"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359470"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:33 -0700
X-CSE-ConnectionGUID: 6SgVJyZBStaZjy5bjgw2Ng==
X-CSE-MsgGUID: QIm/MQSyRnWfRQG7Uk3+jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698071"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: handle v3 rates
Date: Mon,  5 May 2025 21:56:54 +0300
Message-Id: <20250505215513.84cde65a603f.Ic3119ef77cbc6461abd2a6bda104c0d236adcc8d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For UHR, a version 3 of the rate API is being added, which
increases the number of bits used for MCSes by shifting the
NSS bit up. Handle that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  65 ++++--
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  16 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  15 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |  98 ---------
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |  22 ++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  18 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   3 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  32 +--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  38 ++++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 187 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  26 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 112 +++++------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  12 +-
 22 files changed, 448 insertions(+), 264 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 86a265aa7e25..9b9c02c9a8f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -213,7 +213,8 @@ enum iwl_tlc_update_flags {
  * @sta_id: station id
  * @reserved: reserved
  * @flags: bitmap of notifications reported
- * @rate: current initial rate
+ * @rate: current initial rate, format depends on the notification
+ *	version
  * @amsdu_size: Max AMSDU size, in bytes
  * @amsdu_enabled: bitmap for per-TID AMSDU enablement
  */
@@ -224,7 +225,7 @@ struct iwl_tlc_update_notif {
 	__le32 rate;
 	__le32 amsdu_size;
 	__le32 amsdu_enabled;
-} __packed; /* TLC_MNG_UPDATE_NTFY_API_S_VER_2 */
+} __packed; /* TLC_MNG_UPDATE_NTFY_API_S_VER_2, _VER_3, _VER_4 */
 
 /**
  * enum iwl_tlc_debug_types - debug options
@@ -427,6 +428,7 @@ enum {
 
 /* Bit 4-5: (0) SISO, (1) MIMO2 (2) MIMO3 */
 #define RATE_VHT_MCS_RATE_CODE_MSK	0xf
+#define RATE_VHT_MCS_NSS_MSK		0x30
 
 /*
  * Legacy OFDM rate format for bits 7:0
@@ -541,7 +543,7 @@ enum {
 #define RATE_MCS_CTS_REQUIRED_POS  (31)
 #define RATE_MCS_CTS_REQUIRED_MSK  (0x1 << RATE_MCS_CTS_REQUIRED_POS)
 
-/* rate_n_flags bit field version 2
+/* rate_n_flags bit field version 2 and 3
  *
  * The 32-bit value has different layouts in the low 8 bits depending on the
  * format. There are three formats, HT, VHT and legacy (11abg, with subformats
@@ -553,6 +555,7 @@ enum {
  * (0) Legacy CCK (1) Legacy OFDM (2) High-throughput (HT)
  * (3) Very High-throughput (VHT) (4) High-efficiency (HE)
  * (5) Extremely High-throughput (EHT)
+ * (6) Ultra High Reliability (UHR) (v3 rate format only)
  */
 #define RATE_MCS_MOD_TYPE_POS		8
 #define RATE_MCS_MOD_TYPE_MSK		(0x7 << RATE_MCS_MOD_TYPE_POS)
@@ -562,14 +565,15 @@ enum {
 #define RATE_MCS_MOD_TYPE_VHT		(3 << RATE_MCS_MOD_TYPE_POS)
 #define RATE_MCS_MOD_TYPE_HE		(4 << RATE_MCS_MOD_TYPE_POS)
 #define RATE_MCS_MOD_TYPE_EHT		(5 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_UHR		(6 << RATE_MCS_MOD_TYPE_POS)
 
 /*
  * Legacy CCK rate format for bits 0:3:
  *
- * (0) 0xa - 1 Mbps
- * (1) 0x14 - 2 Mbps
- * (2) 0x37 - 5.5 Mbps
- * (3) 0x6e - 11 nbps
+ * (0) 1 Mbps
+ * (1) 2 Mbps
+ * (2) 5.5 Mbps
+ * (3) 11 Mbps
  *
  * Legacy OFDM rate format for bis 3:0:
  *
@@ -586,15 +590,19 @@ enum {
 #define RATE_LEGACY_RATE_MSK		0x7
 
 /*
- * HT, VHT, HE, EHT rate format for bits 3:0
- * 3-0: MCS
- * 4: NSS==2 indicator
- *
+ * HT, VHT, HE, EHT, UHR rate format
+ * Version 2: (not applicable for UHR)
+ *   3-0: MCS
+ *   4: NSS==2 indicator
+ * Version 3:
+ *   4-0: MCS
+ *   5: NSS==2 indicator
  */
 #define RATE_HT_MCS_CODE_MSK		0x7
-#define RATE_MCS_NSS_MSK		0x10
-#define RATE_MCS_CODE_MSK		0xf
-#define RATE_HT_MCS_INDEX(r)		((((r) & RATE_MCS_NSS_MSK) >> 1) | \
+#define RATE_MCS_NSS_MSK_V2		0x10
+#define RATE_MCS_NSS_MSK		0x20
+#define RATE_MCS_CODE_MSK		0x1f
+#define RATE_HT_MCS_INDEX(r)		((((r) & RATE_MCS_NSS_MSK) >> 2) | \
 					 ((r) & RATE_HT_MCS_CODE_MSK))
 
 /* Bits 7-5: reserved */
@@ -810,11 +818,38 @@ struct iwl_lq_cmd {
 }; /* LINK_QUALITY_CMD_API_S_VER_1 */
 
 u8 iwl_fw_rate_idx_to_plcp(int idx);
-u32 iwl_new_rate_from_v1(u32 rate_v1);
 const struct iwl_rate_mcs_info *iwl_rate_mcs(int idx);
 const char *iwl_rs_pretty_ant(u8 ant);
 const char *iwl_rs_pretty_bw(int bw);
 int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate);
 bool iwl_he_is_sgi(u32 rate_n_flags);
 
+static inline u32 iwl_v3_rate_from_v2_v3(__le32 rate, bool fw_v3)
+{
+	u32 val;
+
+	if (fw_v3)
+		return le32_to_cpu(rate);
+
+	val = le32_to_cpu(rate) & ~RATE_MCS_NSS_MSK_V2;
+	val |= u32_encode_bits(le32_get_bits(rate, RATE_MCS_NSS_MSK_V2),
+			       RATE_MCS_NSS_MSK);
+
+	return val;
+}
+
+static inline __le32 iwl_v3_rate_to_v2_v3(u32 rate, bool fw_v3)
+{
+	__le32 val;
+
+	if (fw_v3)
+		return cpu_to_le32(rate);
+
+	val = cpu_to_le32(rate & ~RATE_MCS_NSS_MSK);
+	val |= le32_encode_bits(u32_get_bits(rate, RATE_MCS_NSS_MSK),
+				RATE_MCS_NSS_MSK_V2);
+
+	return val;
+}
+
 #endif /* __iwl_fw_api_rs_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 42ddd03c1c65..7cf6d6ac7430 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -640,7 +640,9 @@ struct iwl_rx_mpdu_desc_v3 {
 	 */
 	__le32 reserved[1];
 } __packed; /* RX_MPDU_RES_START_API_S_VER_3,
-	       RX_MPDU_RES_START_API_S_VER_5 */
+	     * RX_MPDU_RES_START_API_S_VER_5,
+	     * RX_MPDU_RES_START_API_S_VER_6
+	     */
 
 /**
  * struct iwl_rx_mpdu_desc - RX MPDU descriptor
@@ -724,8 +726,10 @@ struct iwl_rx_mpdu_desc {
 		struct iwl_rx_mpdu_desc_v3 v3;
 	};
 } __packed; /* RX_MPDU_RES_START_API_S_VER_3,
-	       RX_MPDU_RES_START_API_S_VER_4,
-	       RX_MPDU_RES_START_API_S_VER_5 */
+	     * RX_MPDU_RES_START_API_S_VER_4,
+	     * RX_MPDU_RES_START_API_S_VER_5,
+	     * RX_MPDU_RES_START_API_S_VER_6
+	     */
 
 #define IWL_RX_DESC_SIZE_V1 offsetofend(struct iwl_rx_mpdu_desc, v1)
 
@@ -821,7 +825,7 @@ struct iwl_rx_no_data {
  *	15:8 chain-B, measured at FINA time (FINA_ENERGY), 16:23 channel
  * @on_air_rise_time: GP2 during on air rise
  * @fr_time: frame time
- * @rate: rate/mcs of frame
+ * @rate: rate/mcs of frame, format depends on the notification version
  * @phy_info: &enum iwl_rx_phy_eht_data0 and &enum iwl_rx_phy_info_type
  * @rx_vec: DW-12:9 raw RX vectors from DSP according to modulation type.
  *	for VHT: OFDM_RX_VECTOR_SIGA1_OUT, OFDM_RX_VECTOR_SIGA2_OUT
@@ -837,9 +841,7 @@ struct iwl_rx_no_data_ver_3 {
 	__le32 rate;
 	__le32 phy_info[2];
 	__le32 rx_vec[4];
-} __packed; /* RX_NO_DATA_NTFY_API_S_VER_1,
-	       RX_NO_DATA_NTFY_API_S_VER_2
-	       RX_NO_DATA_NTFY_API_S_VER_3 */
+} __packed; /* RX_NO_DATA_NTFY_API_S_VER_3, _VER_4 */
 
 struct iwl_frame_release {
 	u8 baid;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 50d1c590044f..0b59fabde7f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -286,7 +286,7 @@ struct iwl_tx_cmd_gen2 {
  * @offload_assist: TX offload configuration
  * @dram_info: FW internal DRAM storage
  * @rate_n_flags: rate for *all* Tx attempts, if TX_CMD_FLG_STA_RATE_MSK is
- *	cleared. Combination of RATE_MCS_*
+ *	cleared. Combination of RATE_MCS_*; format depends on version
  * @reserved: reserved
  * @hdr: 802.11 header
  */
@@ -298,7 +298,10 @@ struct iwl_tx_cmd_gen3 {
 	__le32 rate_n_flags;
 	u8 reserved[8];
 	struct ieee80211_hdr hdr[];
-} __packed; /* TX_CMD_API_S_VER_8, TX_CMD_API_S_VER_10 */
+} __packed; /* TX_CMD_API_S_VER_8,
+	     * TX_CMD_API_S_VER_10,
+	     * TX_CMD_API_S_VER_11
+	     */
 
 /*
  * TX response related data
@@ -549,7 +552,7 @@ struct iwl_tx_resp_v3 {
  * @failure_rts: num of failures due to unsuccessful RTS
  * @failure_frame: num failures due to no ACK (unused for agg)
  * @initial_rate: for non-agg: rate of the successful Tx. For agg: rate of the
- *	Tx of all the batch. RATE_MCS_*
+ *	Tx of all the batch. RATE_MCS_*; format depends on command version
  * @wireless_media_time: for non-agg: RTS + CTS + frame tx attempts time + ACK.
  *	for agg: RTS + CTS + aggregation tx time + block-ack time.
  *	in usec.
@@ -600,8 +603,10 @@ struct iwl_tx_resp {
 	__le16 reserved2;
 	struct agg_tx_status status;
 } __packed; /* TX_RSP_API_S_VER_6,
-	       TX_RSP_API_S_VER_7,
-	       TX_RSP_API_S_VER_8 */
+	     * TX_RSP_API_S_VER_7,
+	     * TX_RSP_API_S_VER_8,
+	     * TX_RSP_API_S_VER_9
+	     */
 
 /**
  * struct iwl_mvm_ba_notif - notifies about reception of BA
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index 326c2623d076..746f2acffb8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -91,104 +91,6 @@ const char *iwl_rs_pretty_bw(int bw)
 }
 IWL_EXPORT_SYMBOL(iwl_rs_pretty_bw);
 
-static u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
-{
-	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
-	int idx;
-	bool ofdm = !(rate_n_flags & RATE_MCS_CCK_MSK_V1);
-	int offset = ofdm ? IWL_FIRST_OFDM_RATE : 0;
-	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
-
-	for (idx = offset; idx < last; idx++)
-		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
-			return idx - offset;
-	return IWL_RATE_INVALID;
-}
-
-u32 iwl_new_rate_from_v1(u32 rate_v1)
-{
-	u32 rate_v2 = 0;
-	u32 dup = 0;
-
-	if (rate_v1 == 0)
-		return rate_v1;
-	/* convert rate */
-	if (rate_v1 & RATE_MCS_HT_MSK_V1) {
-		u32 nss = 0;
-
-		rate_v2 |= RATE_MCS_MOD_TYPE_HT;
-		rate_v2 |=
-			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
-		nss = (rate_v1 & RATE_HT_MCS_MIMO2_MSK) >>
-			RATE_HT_MCS_NSS_POS_V1;
-		rate_v2 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
-	} else if (rate_v1 & RATE_MCS_VHT_MSK_V1 ||
-		   rate_v1 & RATE_MCS_HE_MSK_V1) {
-		rate_v2 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
-
-		rate_v2 |= rate_v1 & RATE_MCS_NSS_MSK;
-
-		if (rate_v1 & RATE_MCS_HE_MSK_V1) {
-			u32 he_type_bits = rate_v1 & RATE_MCS_HE_TYPE_MSK_V1;
-			u32 he_type = he_type_bits >> RATE_MCS_HE_TYPE_POS_V1;
-			u32 he_106t = (rate_v1 & RATE_MCS_HE_106T_MSK_V1) >>
-				RATE_MCS_HE_106T_POS_V1;
-			u32 he_gi_ltf = (rate_v1 & RATE_MCS_HE_GI_LTF_MSK_V1) >>
-				RATE_MCS_HE_GI_LTF_POS;
-
-			if ((he_type_bits == RATE_MCS_HE_TYPE_SU ||
-			     he_type_bits == RATE_MCS_HE_TYPE_EXT_SU) &&
-			    he_gi_ltf == RATE_MCS_HE_SU_4_LTF)
-				/* the new rate have an additional bit to
-				 * represent the value 4 rather then using SGI
-				 * bit for this purpose - as it was done in the old
-				 * rate */
-				he_gi_ltf += (rate_v1 & RATE_MCS_SGI_MSK_V1) >>
-					RATE_MCS_SGI_POS_V1;
-
-			rate_v2 |= he_gi_ltf << RATE_MCS_HE_GI_LTF_POS;
-			rate_v2 |= he_type << RATE_MCS_HE_TYPE_POS;
-			rate_v2 |= he_106t << RATE_MCS_HE_106T_POS;
-			rate_v2 |= rate_v1 & RATE_HE_DUAL_CARRIER_MODE_MSK;
-			rate_v2 |= RATE_MCS_MOD_TYPE_HE;
-		} else {
-			rate_v2 |= RATE_MCS_MOD_TYPE_VHT;
-		}
-	/* if legacy format */
-	} else {
-		u32 legacy_rate = iwl_legacy_rate_to_fw_idx(rate_v1);
-
-		if (WARN_ON_ONCE(legacy_rate == IWL_RATE_INVALID))
-			legacy_rate = (rate_v1 & RATE_MCS_CCK_MSK_V1) ?
-				IWL_FIRST_CCK_RATE : IWL_FIRST_OFDM_RATE;
-
-		rate_v2 |= legacy_rate;
-		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
-			rate_v2 |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
-	}
-
-	/* convert flags */
-	if (rate_v1 & RATE_MCS_LDPC_MSK_V1)
-		rate_v2 |= RATE_MCS_LDPC_MSK;
-	rate_v2 |= (rate_v1 & RATE_MCS_CHAN_WIDTH_MSK_V1) |
-		(rate_v1 & RATE_MCS_ANT_AB_MSK) |
-		(rate_v1 & RATE_MCS_STBC_MSK) |
-		(rate_v1 & RATE_MCS_BF_MSK);
-
-	dup = (rate_v1 & RATE_MCS_DUP_MSK_V1) >> RATE_MCS_DUP_POS_V1;
-	if (dup) {
-		rate_v2 |= RATE_MCS_DUP_MSK;
-		rate_v2 |= dup << RATE_MCS_CHAN_WIDTH_POS;
-	}
-
-	if ((!(rate_v1 & RATE_MCS_HE_MSK_V1)) &&
-	    (rate_v1 & RATE_MCS_SGI_MSK_V1))
-		rate_v2 |= RATE_MCS_SGI_MSK;
-
-	return rate_v2;
-}
-IWL_EXPORT_SYMBOL(iwl_new_rate_from_v1);
-
 int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 {
 	char *type;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 0c896b4dba65..945da3857e7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -999,8 +999,8 @@ void iwl_mld_add_link_debugfs(struct ieee80211_hw *hw,
 		mld_link_dir = debugfs_create_dir("iwlmld", dir);
 }
 
-static ssize_t iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
-					  size_t count, void *data)
+static ssize_t _iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
+					   size_t count, void *data, bool v3)
 {
 	struct ieee80211_link_sta *link_sta = data;
 	struct iwl_mld_link_sta *mld_link_sta;
@@ -1022,6 +1022,10 @@ static ssize_t iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
 	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
 		return -EIO;
 
+	/* input is in FW format (v2 or v3) so convert to v3 */
+	rate = iwl_v3_rate_from_v2_v3(cpu_to_le32(rate), v3);
+	rate = le32_to_cpu(iwl_v3_rate_to_v2_v3(rate, mld->fw_rates_ver_3));
+
 	ret = iwl_mld_send_tlc_dhc(mld, fw_sta_id,
 				   partial ? IWL_TLC_DEBUG_PARTIAL_FIXED_RATE :
 					     IWL_TLC_DEBUG_FIXED_RATE,
@@ -1035,6 +1039,18 @@ static ssize_t iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
 	return ret ? : count;
 }
 
+static ssize_t iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
+					  size_t count, void *data)
+{
+	return _iwl_dbgfs_fixed_rate_write(mld, buf, count, data, false);
+}
+
+static ssize_t iwl_dbgfs_fixed_rate_v3_write(struct iwl_mld *mld, char *buf,
+					     size_t count, void *data)
+{
+	return _iwl_dbgfs_fixed_rate_write(mld, buf, count, data, true);
+}
+
 static ssize_t iwl_dbgfs_tlc_dhc_write(struct iwl_mld *mld, char *buf,
 				       size_t count, void *data)
 {
@@ -1074,6 +1090,7 @@ static ssize_t iwl_dbgfs_tlc_dhc_write(struct iwl_mld *mld, char *buf,
 
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(tlc_dhc, 64);
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(fixed_rate, 64);
+LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(fixed_rate_v3, 64);
 
 void iwl_mld_add_link_sta_debugfs(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
@@ -1081,5 +1098,6 @@ void iwl_mld_add_link_sta_debugfs(struct ieee80211_hw *hw,
 				  struct dentry *dir)
 {
 	LINK_STA_DEBUGFS_ADD_FILE(fixed_rate, dir, 0200);
+	LINK_STA_DEBUGFS_ADD_FILE(fixed_rate_v3, dir, 0200);
 	LINK_STA_DEBUGFS_ADD_FILE(tlc_dhc, dir, 0200);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 0406c727c0a2..1d6ab0a9cc94 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -376,6 +376,24 @@ static void iwl_mac_hw_set_misc(struct iwl_mld *mld)
 
 static int iwl_mld_hw_verify_preconditions(struct iwl_mld *mld)
 {
+	int ratecheck;
+
+	/* check for rates version 3 */
+	ratecheck =
+		(iwl_fw_lookup_cmd_ver(mld->fw, TX_CMD, 0) >= 11) +
+		(iwl_fw_lookup_notif_ver(mld->fw, DATA_PATH_GROUP,
+					 TLC_MNG_UPDATE_NOTIF, 0) >= 4) +
+		(iwl_fw_lookup_notif_ver(mld->fw, LEGACY_GROUP,
+					 REPLY_RX_MPDU_CMD, 0) >= 6) +
+		(iwl_fw_lookup_notif_ver(mld->fw, DATA_PATH_GROUP,
+					 RX_NO_DATA_NOTIF, 0) >= 4) +
+		(iwl_fw_lookup_notif_ver(mld->fw, LONG_GROUP, TX_CMD, 0) >= 9);
+
+	if (ratecheck != 0 && ratecheck != 5) {
+		IWL_ERR(mld, "Firmware has inconsistent rates\n");
+		return -EINVAL;
+	}
+
 	/* 11ax is expected to be enabled for all supported devices */
 	if (WARN_ON(!mld->nvm_data->sku_cap_11ax_enable))
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 5bd40b7697f4..2c15af7b8768 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -393,6 +393,9 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	iwl_construct_mld(mld, trans, cfg, fw, hw, dbgfs_dir);
 
+	/* we'll verify later it matches between commands */
+	mld->fw_rates_ver_3 = iwl_fw_lookup_cmd_ver(mld->fw, TX_CMD, 0) >= 11;
+
 	iwl_mld_construct_fw_runtime(mld, trans, fw, dbgfs_dir);
 
 	iwl_mld_get_bios_tables(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index cdbfe77e73f9..0d88463dd678 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -174,6 +174,7 @@
  * @mcast_filter_cmd: pointer to the multicast filter command.
  * @mgmt_tx_ant: stores the last TX antenna index; used for setting
  *	TX rate_n_flags for non-STA mgmt frames (toggles on every TX failure).
+ * @fw_rates_ver_3: FW rates are in version 3
  * @low_latency: low-latency manager.
  * @tzone: thermal zone device's data
  * @cooling_dev: cooling device's related data
@@ -268,6 +269,8 @@ struct iwl_mld {
 
 	u8 mgmt_tx_ant;
 
+	bool fw_rates_ver_3;
+
 	struct iwl_mld_low_latency low_latency;
 
 	bool ibss_manager;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index df279bf4de44..c0e62d46aba6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -304,13 +304,15 @@ CMD_VERSIONS(session_prot_notif,
 CMD_VERSIONS(missed_beacon_notif,
 	     CMD_VER_ENTRY(5, iwl_missed_beacons_notif))
 CMD_VERSIONS(tx_resp_notif,
-	     CMD_VER_ENTRY(8, iwl_tx_resp))
+	     CMD_VER_ENTRY(8, iwl_tx_resp)
+	     CMD_VER_ENTRY(9, iwl_tx_resp))
 CMD_VERSIONS(compressed_ba_notif,
 	     CMD_VER_ENTRY(5, iwl_compressed_ba_notif)
 	     CMD_VER_ENTRY(6, iwl_compressed_ba_notif)
 	     CMD_VER_ENTRY(7, iwl_compressed_ba_notif))
 CMD_VERSIONS(tlc_notif,
-	     CMD_VER_ENTRY(3, iwl_tlc_update_notif))
+	     CMD_VER_ENTRY(3, iwl_tlc_update_notif)
+	     CMD_VER_ENTRY(4, iwl_tlc_update_notif))
 CMD_VERSIONS(mu_mimo_grp_notif,
 	     CMD_VER_ENTRY(1, iwl_mu_group_mgmt_notif))
 CMD_VERSIONS(channel_switch_start_notif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index a27cdb77e446..ce0093d5c638 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -36,11 +36,13 @@ struct iwl_mld_rx_phy_data {
 };
 
 static void
-iwl_mld_fill_phy_data(struct iwl_rx_mpdu_desc *desc,
+iwl_mld_fill_phy_data(struct iwl_mld *mld,
+		      struct iwl_rx_mpdu_desc *desc,
 		      struct iwl_mld_rx_phy_data *phy_data)
 {
 	phy_data->phy_info = le16_to_cpu(desc->phy_info);
-	phy_data->rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
+	phy_data->rate_n_flags = iwl_v3_rate_from_v2_v3(desc->v3.rate_n_flags,
+							mld->fw_rates_ver_3);
 	phy_data->gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
 	phy_data->energy_a = desc->v3.energy_a;
 	phy_data->energy_b = desc->v3.energy_b;
@@ -1254,7 +1256,8 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 			rx_status->encoding = RX_ENC_EHT;
 		}
 
-		rx_status->nss = u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
+		rx_status->nss = u32_get_bits(rate_n_flags,
+					      RATE_MCS_NSS_MSK) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		break;
@@ -1760,7 +1763,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 
 	hdr = (void *)(pkt->data + mpdu_desc_size);
 
-	iwl_mld_fill_phy_data(mpdu_desc, &phy_data);
+	iwl_mld_fill_phy_data(mld, mpdu_desc, &phy_data);
 
 	if (mpdu_desc->mac_flags2 & IWL_RX_MPDU_MFLG2_PAD) {
 		/* If the device inserted padding it means that (it thought)
@@ -1982,7 +1985,8 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	phy_data.data1 = desc->phy_info[1];
 	phy_data.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
 	phy_data.gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time);
-	phy_data.rate_n_flags = le32_to_cpu(desc->rate);
+	phy_data.rate_n_flags = iwl_v3_rate_from_v2_v3(desc->rate,
+						       mld->fw_rates_ver_3);
 	phy_data.with_data = false;
 
 	BUILD_BUG_ON(sizeof(phy_data.rx_vec) != sizeof(desc->rx_vec));
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index f054cc921d9d..a4679627a027 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -658,7 +658,9 @@ void iwl_mld_handle_tlc_notif(struct iwl_mld *mld,
 		if (WARN_ON(!mld_link_sta))
 			return;
 
-		mld_link_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
+		mld_link_sta->last_rate_n_flags =
+			iwl_v3_rate_from_v2_v3(notif->rate,
+					       mld->fw_rates_ver_3);
 
 		rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
 				     mld_link_sta->last_rate_n_flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 1f018f03a68e..c95274c563c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -472,15 +472,19 @@ static u32 iwl_mld_get_inject_tx_rate(struct iwl_mld *mld,
 	return result;
 }
 
-static u32 iwl_mld_get_tx_rate_n_flags(struct iwl_mld *mld,
-				       struct ieee80211_tx_info *info,
-				       struct ieee80211_sta *sta, __le16 fc)
+static __le32 iwl_mld_get_tx_rate_n_flags(struct iwl_mld *mld,
+					  struct ieee80211_tx_info *info,
+					  struct ieee80211_sta *sta, __le16 fc)
 {
+	u32 rate;
+
 	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
-		return iwl_mld_get_inject_tx_rate(mld, info, sta, fc);
+		rate = iwl_mld_get_inject_tx_rate(mld, info, sta, fc);
+	else
+		rate = iwl_mld_mac80211_rate_idx_to_fw(mld, info, -1) |
+		       iwl_mld_get_tx_ant(mld, info, sta, fc);
 
-	return iwl_mld_mac80211_rate_idx_to_fw(mld, info, -1) |
-		iwl_mld_get_tx_ant(mld, info, sta, fc);
+	return iwl_v3_rate_to_v2_v3(rate, mld->fw_rates_ver_3);
 }
 
 static void
@@ -534,7 +538,7 @@ iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
 	bool amsdu = ieee80211_is_data_qos(hdr->frame_control) &&
 		     (*ieee80211_get_qos_ctl(hdr) &
 		      IEEE80211_QOS_CTL_A_MSDU_PRESENT);
-	u32 rate_n_flags = 0;
+	__le32 rate_n_flags = 0;
 	u16 flags = 0;
 
 	dev_tx_cmd->hdr.cmd = TX_CMD;
@@ -569,7 +573,7 @@ iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
 
 	tx_cmd->flags = cpu_to_le16(flags);
 
-	tx_cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
+	tx_cmd->rate_n_flags = rate_n_flags;
 }
 
 /* Caller of this need to check that info->control.vif is not NULL */
@@ -972,11 +976,14 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	rcu_read_unlock();
 }
 
-static void iwl_mld_hwrate_to_tx_rate(u32 rate_n_flags,
+static void iwl_mld_hwrate_to_tx_rate(struct iwl_mld *mld,
+				      __le32 rate_n_flags_fw,
 				      struct ieee80211_tx_info *info)
 {
 	enum nl80211_band band = info->band;
 	struct ieee80211_tx_rate *tx_rate = &info->status.rates[0];
+	u32 rate_n_flags = iwl_v3_rate_from_v2_v3(rate_n_flags_fw,
+						  mld->fw_rates_ver_3);
 	u32 sgi = rate_n_flags & RATE_MCS_SGI_MSK;
 	u32 chan_width = rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK;
 	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
@@ -1008,8 +1015,8 @@ static void iwl_mld_hwrate_to_tx_rate(u32 rate_n_flags,
 	case RATE_MCS_MOD_TYPE_VHT:
 		ieee80211_rate_set_vht(tx_rate,
 				       rate_n_flags & RATE_MCS_CODE_MSK,
-				       FIELD_GET(RATE_MCS_NSS_MSK,
-						 rate_n_flags) + 1);
+				       u32_get_bits(rate_n_flags,
+						    RATE_MCS_NSS_MSK) + 1);
 		tx_rate->flags |= IEEE80211_TX_RC_VHT_MCS;
 		break;
 	case RATE_MCS_MOD_TYPE_HE:
@@ -1107,8 +1114,7 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 			iwl_dbg_tlv_time_point(&mld->fwrt, tp, NULL);
 		}
 
-		iwl_mld_hwrate_to_tx_rate(le32_to_cpu(tx_resp->initial_rate),
-					  info);
+		iwl_mld_hwrate_to_tx_rate(mld, tx_resp->initial_rate, info);
 
 		if (likely(!iwl_mld_time_sync_frame(mld, skb, hdr->addr1)))
 			ieee80211_tx_status_skb(mld->hw, skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 83f1ed94ccab..7a103163b31c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -938,12 +938,19 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 
 u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 {
-	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
 	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw, BEACON_TEMPLATE_CMD, 0) > 10;
+	u16 flags, cck_flag;
+
+	if (is_new_rate) {
+		flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
+		cck_flag = IWL_MAC_BEACON_CCK;
+	} else {
+		cck_flag = IWL_MAC_BEACON_CCK_V1;
+		flags = iwl_fw_rate_idx_to_plcp(rate_idx);
+	}
 
 	if (rate_idx <= IWL_LAST_CCK_RATE)
-		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
-			  : IWL_MAC_BEACON_CCK_V1;
+		flags |= cck_flag;
 
 	return flags;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 19dcc2ed8396..70700fc76559 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1033,6 +1033,8 @@ struct iwl_mvm {
 
 	u8 cca_40mhz_workaround;
 
+	u8 fw_rates_ver;
+
 	u32 ampdu_ref;
 	bool ampdu_toggle;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7701fbc5f906..9797788d2fce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1291,6 +1291,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	size_t scan_size;
 	u32 min_backoff;
 	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
+	int ratecheck;
 	int err;
 
 	/*
@@ -1337,6 +1338,43 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	mvm->init_status = 0;
 
+	/* start with v1 rates */
+	mvm->fw_rates_ver = 1;
+
+	/* check for rates version 2 */
+	ratecheck =
+		(iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) >= 8) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+					 TLC_MNG_UPDATE_NOTIF, 0) >= 3) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					 REPLY_RX_MPDU_CMD, 0) >= 4) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) >= 6);
+	if (ratecheck != 0 && ratecheck != 4) {
+		IWL_ERR(mvm, "Firmware has inconsistent rates\n");
+		err = -EINVAL;
+		goto out_free;
+	}
+	if (ratecheck == 4)
+		mvm->fw_rates_ver = 2;
+
+	/* check for rates version 3 */
+	ratecheck =
+		(iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) >= 11) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+					 TLC_MNG_UPDATE_NOTIF, 0) >= 4) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					 REPLY_RX_MPDU_CMD, 0) >= 6) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+					 RX_NO_DATA_NOTIF, 0) >= 4) +
+		(iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) >= 9);
+	if (ratecheck != 0 && ratecheck != 5) {
+		IWL_ERR(mvm, "Firmware has inconsistent rates\n");
+		err = -EINVAL;
+		goto out_free;
+	}
+	if (ratecheck == 5)
+		mvm->fw_rates_ver = 3;
+
 	trans->conf.rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
 
 	if (iwl_mvm_has_new_rx_api(mvm)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index de5ac000272e..0360509b0827 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include "rs.h"
 #include "fw-api.h"
@@ -454,22 +454,11 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	if (flags & IWL_TLC_NOTIF_FLAG_RATE) {
 		char pretty_rate[100];
 
-		if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
-					    TLC_MNG_UPDATE_NOTIF, 0) < 3) {
-			rs_pretty_print_rate_v1(pretty_rate,
-						sizeof(pretty_rate),
-						le32_to_cpu(notif->rate));
-			IWL_DEBUG_RATE(mvm,
-				       "Got rate in old format. Rate: %s. Converting.\n",
-				       pretty_rate);
-			lq_sta->last_rate_n_flags =
-				iwl_new_rate_from_v1(le32_to_cpu(notif->rate));
-		} else {
-			lq_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
-		}
+		lq_sta->last_rate_n_flags =
+			iwl_mvm_v3_rate_from_fw(notif->rate, mvm->fw_rates_ver);
 		rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
 				     lq_sta->last_rate_n_flags);
-		IWL_DEBUG_RATE(mvm, "new rate: %s\n", pretty_rate);
+		IWL_DEBUG_RATE(mvm, "rate: %s\n", pretty_rate);
 	}
 
 	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU && !mvm_link_sta->orig_amsdu_len) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 50496edf41f8..5543d0568f4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -896,7 +896,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 			WARN_ON_ONCE(1);
 		}
 	} else if (ucode_rate & RATE_MCS_VHT_MSK_V1) {
-		nss = FIELD_GET(RATE_MCS_NSS_MSK, ucode_rate) + 1;
+		nss = FIELD_GET(RATE_VHT_MCS_NSS_MSK, ucode_rate) + 1;
 
 		if (nss == 1) {
 			rate->type = LQ_VHT_SISO;
@@ -910,7 +910,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 			WARN_ON_ONCE(1);
 		}
 	} else if (ucode_rate & RATE_MCS_HE_MSK_V1) {
-		nss = FIELD_GET(RATE_MCS_NSS_MSK, ucode_rate) + 1;
+		nss = FIELD_GET(RATE_VHT_MCS_NSS_MSK, ucode_rate) + 1;
 
 		if (nss == 1) {
 			rate->type = LQ_HE_SISO;
@@ -2697,7 +2697,9 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 	lq_sta = mvm_sta;
 
 	spin_lock_bh(&lq_sta->pers.lock);
-	iwl_mvm_hwrate_to_tx_rate(iwl_new_rate_from_v1(lq_sta->last_rate_n_flags),
+	iwl_mvm_hwrate_to_tx_rate(iwl_mvm_v3_rate_from_fw(
+					cpu_to_le32(lq_sta->last_rate_n_flags),
+					1),
 				  info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
 
@@ -2708,7 +2710,9 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		optimal_rate = rs_get_optimal_rate(mvm, lq_sta);
 		last_ucode_rate = ucode_rate_from_rs_rate(mvm,
 							  optimal_rate);
-		last_ucode_rate = iwl_new_rate_from_v1(last_ucode_rate);
+		last_ucode_rate =
+			iwl_mvm_v3_rate_from_fw(cpu_to_le32(last_ucode_rate),
+						1);
 		iwl_mvm_hwrate_to_tx_rate(last_ucode_rate, info->band,
 					  &txrc->reported_rate);
 		txrc->reported_rate.count = 1;
@@ -2890,10 +2894,10 @@ void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg)
 
 	if (rate & RATE_MCS_HT_MSK_V1) {
 		mvm->drv_rx_stats.ht_frames++;
-		nss = ((rate & RATE_HT_MCS_NSS_MSK_V1) >> RATE_HT_MCS_NSS_POS_V1) + 1;
+		nss = FIELD_GET(RATE_HT_MCS_MIMO2_MSK, rate) + 1;
 	} else if (rate & RATE_MCS_VHT_MSK_V1) {
 		mvm->drv_rx_stats.vht_frames++;
-		nss = FIELD_GET(RATE_MCS_NSS_MSK, rate) + 1;
+		nss = FIELD_GET(RATE_VHT_MCS_NSS_MSK, rate) + 1;
 	} else {
 		mvm->drv_rx_stats.legacy_frames++;
 	}
@@ -3676,16 +3680,15 @@ int rs_pretty_print_rate_v1(char *buf, int bufsz, const u32 rate)
 	if (rate & RATE_MCS_VHT_MSK_V1) {
 		type = "VHT";
 		mcs = rate & RATE_VHT_MCS_RATE_CODE_MSK;
-		nss = FIELD_GET(RATE_MCS_NSS_MSK, rate) + 1;
+		nss = FIELD_GET(RATE_VHT_MCS_NSS_MSK, rate) + 1;
 	} else if (rate & RATE_MCS_HT_MSK_V1) {
 		type = "HT";
 		mcs = rate & RATE_HT_MCS_INDEX_MSK_V1;
-		nss = ((rate & RATE_HT_MCS_NSS_MSK_V1)
-		       >> RATE_HT_MCS_NSS_POS_V1) + 1;
+		nss = FIELD_GET(RATE_HT_MCS_MIMO2_MSK, rate) + 1;
 	} else if (rate & RATE_MCS_HE_MSK_V1) {
 		type = "HE";
 		mcs = rate & RATE_VHT_MCS_RATE_CODE_MSK;
-		nss = FIELD_GET(RATE_MCS_NSS_MSK, rate) + 1;
+		nss = FIELD_GET(RATE_VHT_MCS_NSS_MSK, rate) + 1;
 	} else {
 		type = "Unknown"; /* shouldn't happen */
 	}
@@ -4175,3 +4178,167 @@ int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 	else
 		return rs_drv_tx_protection(mvm, mvmsta, enable);
 }
+
+static u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
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
+	return IWL_RATE_INVALID;
+}
+
+u32 iwl_mvm_v3_rate_from_fw(__le32 rate, u8 rate_ver)
+{
+	u32 rate_v3 = 0, rate_v1;
+	u32 dup = 0;
+
+	if (rate_ver > 1)
+		return iwl_v3_rate_from_v2_v3(rate, rate_ver >= 3);
+
+	rate_v1 = le32_to_cpu(rate);
+	if (rate_v1 == 0)
+		return rate_v1;
+	/* convert rate */
+	if (rate_v1 & RATE_MCS_HT_MSK_V1) {
+		u32 nss;
+
+		rate_v3 |= RATE_MCS_MOD_TYPE_HT;
+		rate_v3 |=
+			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
+		nss = u32_get_bits(rate_v1, RATE_HT_MCS_MIMO2_MSK);
+		rate_v3 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
+	} else if (rate_v1 & RATE_MCS_VHT_MSK_V1 ||
+		   rate_v1 & RATE_MCS_HE_MSK_V1) {
+		u32 nss = u32_get_bits(rate_v1, RATE_VHT_MCS_NSS_MSK);
+
+		rate_v3 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
+
+		rate_v3 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
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
+				 * bit for this purpose - as it was done in the
+				 * old rate
+				 */
+				he_gi_ltf += (rate_v1 & RATE_MCS_SGI_MSK_V1) >>
+					RATE_MCS_SGI_POS_V1;
+
+			rate_v3 |= he_gi_ltf << RATE_MCS_HE_GI_LTF_POS;
+			rate_v3 |= he_type << RATE_MCS_HE_TYPE_POS;
+			rate_v3 |= he_106t << RATE_MCS_HE_106T_POS;
+			rate_v3 |= rate_v1 & RATE_HE_DUAL_CARRIER_MODE_MSK;
+			rate_v3 |= RATE_MCS_MOD_TYPE_HE;
+		} else {
+			rate_v3 |= RATE_MCS_MOD_TYPE_VHT;
+		}
+	/* if legacy format */
+	} else {
+		u32 legacy_rate = iwl_legacy_rate_to_fw_idx(rate_v1);
+
+		if (WARN_ON_ONCE(legacy_rate == IWL_RATE_INVALID))
+			legacy_rate = (rate_v1 & RATE_MCS_CCK_MSK_V1) ?
+				IWL_FIRST_CCK_RATE : IWL_FIRST_OFDM_RATE;
+
+		rate_v3 |= legacy_rate;
+		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
+			rate_v3 |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
+	}
+
+	/* convert flags */
+	if (rate_v1 & RATE_MCS_LDPC_MSK_V1)
+		rate_v3 |= RATE_MCS_LDPC_MSK;
+	rate_v3 |= (rate_v1 & RATE_MCS_CHAN_WIDTH_MSK_V1) |
+		(rate_v1 & RATE_MCS_ANT_AB_MSK) |
+		(rate_v1 & RATE_MCS_STBC_MSK) |
+		(rate_v1 & RATE_MCS_BF_MSK);
+
+	dup = (rate_v1 & RATE_MCS_DUP_MSK_V1) >> RATE_MCS_DUP_POS_V1;
+	if (dup) {
+		rate_v3 |= RATE_MCS_DUP_MSK;
+		rate_v3 |= dup << RATE_MCS_CHAN_WIDTH_POS;
+	}
+
+	if ((!(rate_v1 & RATE_MCS_HE_MSK_V1)) &&
+	    (rate_v1 & RATE_MCS_SGI_MSK_V1))
+		rate_v3 |= RATE_MCS_SGI_MSK;
+
+	return rate_v3;
+}
+
+__le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver)
+{
+	u32 result = 0;
+	int rate_idx;
+
+	if (rate_ver > 1)
+		return iwl_v3_rate_to_v2_v3(rate, rate_ver > 2);
+
+	switch (rate & RATE_MCS_MOD_TYPE_MSK) {
+	case RATE_MCS_MOD_TYPE_CCK:
+		result = RATE_MCS_CCK_MSK_V1;
+		fallthrough;
+	case RATE_MCS_MOD_TYPE_LEGACY_OFDM:
+		rate_idx = u32_get_bits(rate, RATE_LEGACY_RATE_MSK);
+		if (!(result & RATE_MCS_CCK_MSK_V1))
+			rate_idx += IWL_FIRST_OFDM_RATE;
+		result |= u32_encode_bits(iwl_fw_rate_idx_to_plcp(rate_idx),
+					  RATE_LEGACY_RATE_MSK_V1);
+		break;
+	case RATE_MCS_MOD_TYPE_HT:
+		result = RATE_MCS_HT_MSK_V1;
+		result |= u32_encode_bits(u32_get_bits(rate,
+						       RATE_HT_MCS_CODE_MSK),
+					  RATE_HT_MCS_RATE_CODE_MSK_V1);
+		result |= u32_encode_bits(u32_get_bits(rate,
+						       RATE_MCS_NSS_MSK),
+					  RATE_HT_MCS_MIMO2_MSK);
+		break;
+	case RATE_MCS_MOD_TYPE_VHT:
+		result = RATE_MCS_VHT_MSK_V1;
+		result |= u32_encode_bits(u32_get_bits(rate,
+						       RATE_VHT_MCS_NSS_MSK),
+					  RATE_MCS_CODE_MSK);
+		result |= u32_encode_bits(u32_get_bits(rate, RATE_MCS_NSS_MSK),
+					  RATE_VHT_MCS_NSS_MSK);
+		break;
+	case RATE_MCS_MOD_TYPE_HE: /* not generated */
+	default:
+		WARN_ONCE(1, "bad modulation type %d\n",
+			  u32_get_bits(rate, RATE_MCS_MOD_TYPE_MSK));
+		return 0;
+	}
+
+	if (rate & RATE_MCS_LDPC_MSK)
+		result |= RATE_MCS_LDPC_MSK_V1;
+	WARN_ON_ONCE(u32_get_bits(rate, RATE_MCS_CHAN_WIDTH_MSK) >
+			RATE_MCS_CHAN_WIDTH_160_VAL);
+	result |= (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) |
+		  (rate & RATE_MCS_ANT_AB_MSK) |
+		  (rate & RATE_MCS_STBC_MSK) |
+		  (rate & RATE_MCS_BF_MSK);
+
+	/* not handling DUP since we don't use it */
+	WARN_ON_ONCE(rate & RATE_MCS_DUP_MSK);
+
+	if (rate & RATE_MCS_SGI_MSK)
+		result |= RATE_MCS_SGI_MSK_V1;
+
+	return cpu_to_le32(result);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index ea81cb236d5c..69259ebb966b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright (C) 2003 - 2014, 2018 - 2024 Intel Corporation
+ * Copyright (C) 2003 - 2014, 2018 - 2025 Intel Corporation
  *****************************************************************************/
 
 #ifndef __rs_h__
@@ -424,6 +424,9 @@ void iwl_mvm_rate_control_unregister(void);
 
 struct iwl_mvm_sta;
 
+u32 iwl_mvm_v3_rate_from_fw(__le32 rate, u8 rate_ver);
+__le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver);
+
 int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			  bool enable);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1cc35c82c392..2799a5e05790 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2059,7 +2059,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		phy_data.rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
+		phy_data.rate_n_flags =
+			iwl_mvm_v3_rate_from_fw(desc->v3.rate_n_flags,
+						mvm->fw_rates_ver);
 		phy_data.channel = desc->v3.channel;
 		phy_data.gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
 		phy_data.energy_a = desc->v3.energy_a;
@@ -2072,7 +2074,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		phy_data.eht_d4 = desc->phy_eht_data4;
 		phy_data.d5 = desc->v3.phy_data5;
 	} else {
-		phy_data.rate_n_flags = le32_to_cpu(desc->v1.rate_n_flags);
+		phy_data.rate_n_flags =
+			iwl_mvm_v3_rate_from_fw(desc->v1.rate_n_flags,
+						mvm->fw_rates_ver);
 		phy_data.channel = desc->v1.channel;
 		phy_data.gp2_on_air_rise = le32_to_cpu(desc->v1.gp2_on_air_rise);
 		phy_data.energy_a = desc->v1.energy_a;
@@ -2084,13 +2088,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		phy_data.d3 = desc->v1.phy_data3;
 	}
 
-	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-				    REPLY_RX_MPDU_CMD, 0) < 4) {
-		phy_data.rate_n_flags = iwl_new_rate_from_v1(phy_data.rate_n_flags);
-		IWL_DEBUG_DROP(mvm, "Got old format rate, converting. New rate: 0x%x\n",
-			       phy_data.rate_n_flags);
-	}
-
 	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
 	len = le16_to_cpu(desc->mpdu_len);
@@ -2384,7 +2381,6 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	phy_data.d1 = desc->phy_info[1];
 	phy_data.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
 	phy_data.gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time);
-	phy_data.rate_n_flags = le32_to_cpu(desc->rate);
 	phy_data.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK);
 	phy_data.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK);
 	phy_data.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
@@ -2392,14 +2388,8 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	phy_data.rx_vec[0] = desc->rx_vec[0];
 	phy_data.rx_vec[1] = desc->rx_vec[1];
 
-	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
-				    RX_NO_DATA_NOTIF, 0) < 2) {
-		IWL_DEBUG_DROP(mvm, "Got an old rate format. Old rate: 0x%x\n",
-			       phy_data.rate_n_flags);
-		phy_data.rate_n_flags = iwl_new_rate_from_v1(phy_data.rate_n_flags);
-		IWL_DEBUG_DROP(mvm, " Rate after conversion to the new format: 0x%x\n",
-			       phy_data.rate_n_flags);
-	}
+	phy_data.rate_n_flags = iwl_mvm_v3_rate_from_fw(desc->rate,
+							mvm->fw_rates_ver);
 
 	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index af62c7f7c834..6b183f5e9bbc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -259,7 +259,7 @@ struct iwl_mvm_tid_data {
 	u16 seq_number;
 	u16 next_reclaimed;
 	/* The rest is Tx AGG related */
-	u32 rate_n_flags;
+	__le32 rate_n_flags;
 	u8 lq_color;
 	bool amsdu_in_ampdu_allowed;
 	enum iwl_mvm_agg_state state;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1da0a829f529..dd6e5559d31d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -283,14 +283,10 @@ static u32 iwl_mvm_convert_rate_idx(struct iwl_mvm *mvm,
 		 (rate_idx <= IWL_LAST_CCK_RATE);
 
 	/* Set CCK or OFDM flag */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) > 8) {
-		if (!is_cck)
-			rate_flags |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
-		else
-			rate_flags |= RATE_MCS_MOD_TYPE_CCK;
-	} else if (is_cck) {
-		rate_flags |= RATE_MCS_CCK_MSK_V1;
-	}
+	if (!is_cck)
+		rate_flags |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
+	else
+		rate_flags |= RATE_MCS_MOD_TYPE_CCK;
 
 	return (u32)rate_plcp | rate_flags;
 }
@@ -303,45 +299,35 @@ static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	u32 result;
 
-	/*
-	 * we only care about legacy/HT/VHT so far, so we can
-	 * build in v1 and use iwl_new_rate_from_v1()
-	 */
-
 	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
 		u8 mcs = ieee80211_rate_get_vht_mcs(rate);
 		u8 nss = ieee80211_rate_get_vht_nss(rate);
 
-		result = RATE_MCS_VHT_MSK_V1;
+		result = RATE_MCS_MOD_TYPE_VHT;
 		result |= u32_encode_bits(mcs, RATE_VHT_MCS_RATE_CODE_MSK);
 		result |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
 		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
-			result |= RATE_MCS_SGI_MSK_V1;
+			result |= RATE_MCS_SGI_MSK;
 		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+			result |= RATE_MCS_CHAN_WIDTH_40;
 		else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-			result |= u32_encode_bits(2, RATE_MCS_CHAN_WIDTH_MSK_V1);
+			result |= RATE_MCS_CHAN_WIDTH_80;
 		else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
-			result |= u32_encode_bits(3, RATE_MCS_CHAN_WIDTH_MSK_V1);
-
-		if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
-			result = iwl_new_rate_from_v1(result);
+			result |= RATE_MCS_CHAN_WIDTH_160;
 	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
-		result = RATE_MCS_HT_MSK_V1;
-		result |= u32_encode_bits(rate->idx,
-					  RATE_HT_MCS_RATE_CODE_MSK_V1 |
-					  RATE_HT_MCS_NSS_MSK_V1);
+		result = RATE_MCS_MOD_TYPE_HT;
+		result |= u32_encode_bits(rate->idx & 0x7,
+					  RATE_HT_MCS_CODE_MSK);
+		result |= u32_encode_bits(rate->idx >> 3,
+					  RATE_MCS_NSS_MSK);
 		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
-			result |= RATE_MCS_SGI_MSK_V1;
+			result |= RATE_MCS_SGI_MSK;
 		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+			result |= RATE_MCS_CHAN_WIDTH_40;
 		if (info->flags & IEEE80211_TX_CTL_LDPC)
-			result |= RATE_MCS_LDPC_MSK_V1;
+			result |= RATE_MCS_LDPC_MSK;
 		if (u32_get_bits(info->flags, IEEE80211_TX_CTL_STBC))
 			result |= RATE_MCS_STBC_MSK;
-
-		if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
-			result = iwl_new_rate_from_v1(result);
 	} else {
 		int rate_idx = info->control.rates[0].idx;
 
@@ -391,15 +377,19 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	return iwl_mvm_convert_rate_idx(mvm, info, rate_idx);
 }
 
-static u32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
-				       struct ieee80211_tx_info *info,
-				       struct ieee80211_sta *sta, __le16 fc)
+static __le32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
+					  struct ieee80211_tx_info *info,
+					  struct ieee80211_sta *sta, __le16 fc)
 {
+	u32 rate;
+
 	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
-		return iwl_mvm_get_inject_tx_rate(mvm, info, sta, fc);
+		rate = iwl_mvm_get_inject_tx_rate(mvm, info, sta, fc);
+	else
+		rate = iwl_mvm_get_tx_rate(mvm, info, sta, fc) |
+		       iwl_mvm_get_tx_ant(mvm, info, sta, fc);
 
-	return iwl_mvm_get_tx_rate(mvm, info, sta, fc) |
-		iwl_mvm_get_tx_ant(mvm, info, sta, fc);
+	return iwl_mvm_v3_rate_to_fw(rate, mvm->fw_rates_ver);
 }
 
 /*
@@ -443,8 +433,7 @@ void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd *tx_cmd,
 	}
 
 	/* Set the rate in the TX cmd */
-	tx_cmd->rate_n_flags =
-		cpu_to_le32(iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc));
+	tx_cmd->rate_n_flags = iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc);
 }
 
 static inline void iwl_mvm_set_tx_cmd_pn(struct ieee80211_tx_info *info,
@@ -577,7 +566,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	dev_cmd->hdr.cmd = TX_CMD;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		u32 rate_n_flags = 0;
+		__le32 rate_n_flags = 0;
 		u16 flags = 0;
 		struct iwl_mvm_sta *mvmsta = sta ?
 			iwl_mvm_sta_from_mac80211(sta) : NULL;
@@ -624,7 +613,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			iwl_mvm_copy_hdr(cmd->hdr, hdr, hdrlen, addr3_override);
 
 			cmd->flags = cpu_to_le16(flags);
-			cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
+			cmd->rate_n_flags = rate_n_flags;
 		} else {
 			struct iwl_tx_cmd_gen2 *cmd = (void *)dev_cmd->payload;
 			u16 offload_assist = iwl_mvm_tx_csum(mvm, skb,
@@ -639,7 +628,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			iwl_mvm_copy_hdr(cmd->hdr, hdr, hdrlen, addr3_override);
 
 			cmd->flags = cpu_to_le32(flags);
-			cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
+			cmd->rate_n_flags = rate_n_flags;
 		}
 		goto out;
 	}
@@ -1503,20 +1492,25 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 /*
  * translate ucode response to mac80211 tx status control values
  */
-static void iwl_mvm_hwrate_to_tx_status(const struct iwl_fw *fw,
-					u32 rate_n_flags,
+static void iwl_mvm_hwrate_to_tx_status(struct iwl_mvm *mvm,
+					__le32 rate_n_flags,
 					struct ieee80211_tx_info *info)
 {
 	struct ieee80211_tx_rate *r = &info->status.rates[0];
+	u32 rate;
 
-	if (iwl_fw_lookup_notif_ver(fw, LONG_GROUP,
-				    TX_CMD, 0) <= 6)
-		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
+	/*
+	 * Technically this conversion is incorrect for BA status, however:
+	 *  - we only use the BA notif data for older firmware that have
+	 *    host rate scaling and don't use newer rate formats
+	 *  - the firmware API changed together for BA notif and TX CMD
+	 *    as well
+	 */
+	rate = iwl_mvm_v3_rate_from_fw(rate_n_flags, mvm->fw_rates_ver);
 
 	info->status.antenna =
-		((rate_n_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS);
-	iwl_mvm_hwrate_to_tx_rate(rate_n_flags,
-				  info->band, r);
+		((rate & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS);
+	iwl_mvm_hwrate_to_tx_rate(rate, info->band, r);
 }
 
 static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
@@ -1668,9 +1662,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
 
-		iwl_mvm_hwrate_to_tx_status(mvm->fw,
-					    le32_to_cpu(tx_resp->initial_rate),
-					    info);
+		iwl_mvm_hwrate_to_tx_status(mvm, tx_resp->initial_rate, info);
 
 		/* Don't assign the converted initial_rate, because driver
 		 * TLC uses this and doesn't support the new FW rate
@@ -1912,7 +1904,7 @@ static void iwl_mvm_rx_tx_cmd_agg(struct iwl_mvm *mvm,
 
 	if (!WARN_ON_ONCE(!mvmsta)) {
 		mvmsta->tid_data[tid].rate_n_flags =
-			le32_to_cpu(tx_resp->initial_rate);
+			tx_resp->initial_rate;
 		mvmsta->tid_data[tid].tx_time =
 			le16_to_cpu(tx_resp->wireless_media_time);
 		mvmsta->tid_data[tid].lq_color =
@@ -1937,7 +1929,7 @@ void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			       int txq, int index,
-			       struct ieee80211_tx_info *tx_info, u32 rate,
+			       struct ieee80211_tx_info *tx_info, __le32 rate,
 			       bool is_flush)
 {
 	struct sk_buff_head reclaimed_skbs;
@@ -2021,7 +2013,9 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	tx_info->status.status_driver_data[0] =
 		RS_DRV_DATA_PACK(tid_data->lq_color,
 				 tx_info->status.status_driver_data[0]);
-	tx_info->status.status_driver_data[1] = (void *)(uintptr_t)rate;
+	/* the value is only consumed for old FW that has v1 rates anyway */
+	tx_info->status.status_driver_data[1] =
+		(void *)(uintptr_t)le32_to_cpu(rate);
 
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -2040,7 +2034,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_AMPDU;
 			memcpy(&info->status, &tx_info->status,
 			       sizeof(tx_info->status));
-			iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, info);
+			iwl_mvm_hwrate_to_tx_status(mvm, rate, info);
 		}
 	}
 
@@ -2063,7 +2057,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			goto out;
 
 		tx_info->band = chanctx_conf->def.chan->band;
-		iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, tx_info);
+		iwl_mvm_hwrate_to_tx_status(mvm, rate, tx_info);
 
 		IWL_DEBUG_TX_REPLY(mvm, "No reclaim. Update rs directly\n");
 		iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
@@ -2152,7 +2146,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 					   (int)(le16_to_cpu(ba_tfd->q_num)),
 					   le16_to_cpu(ba_tfd->tfd_index),
 					   &ba_info,
-					   le32_to_cpu(ba_res->tx_rate), false);
+					   ba_res->tx_rate, false);
 		}
 
 		if (mvmsta) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 33be79e8cd1e..4416d35b1bcf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -169,15 +169,9 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx)
 {
-	if (iwl_fw_lookup_cmd_ver(fw, TX_CMD, 0) > 8)
-		/* In the new rate legacy rates are indexed:
-		 * 0 - 3 for CCK and 0 - 7 for OFDM.
-		 */
-		return (rate_idx >= IWL_FIRST_OFDM_RATE ?
-			rate_idx - IWL_FIRST_OFDM_RATE :
-			rate_idx);
-
-	return iwl_fw_rate_idx_to_plcp(rate_idx);
+	return (rate_idx >= IWL_FIRST_OFDM_RATE ?
+		rate_idx - IWL_FIRST_OFDM_RATE :
+		rate_idx);
 }
 
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac)
-- 
2.34.1


