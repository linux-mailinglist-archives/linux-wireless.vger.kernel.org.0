Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D046E8CD
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhLINKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbhLINKl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C5C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 05:07:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4DF65CE2558
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDF1C341C3;
        Thu,  9 Dec 2021 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055223;
        bh=8rY+paDkLWyML1syoznPT4pcmkhNpBuIxaBkKxAqT8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mxx2k6iL4bvGNLUoEGV0pCaZaxdc890WSDTMM+kmJl3CDeQgvuxze2xhB4aDwKnlq
         txolmxtMKb/ty4UXUsuFErvvlg1Ch40cHtFVudg2+34PyS1ACWP5epbfavVPeTOlmK
         Ya9RhLb6uFsqt5s9z4AMgKsFlB9kWAK30FQKEekwiR+DQywnK2z789NOGuirTMFast
         Czif39Y0odGB+cAQF6+/zqV5p7bONBi4QlZ9s8UbtCUYCvVTGaq1KjarARrNbXHGM+
         1ZxQ20JCtDNcU5zWC/qvta9uHAtyyw42ypwIP30iL7RcWig/IXhxch55XBu7xKxJE5
         t9/rG3rQWB9qw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 7/7] mt76: mt7915: rely on mt76_connac definitions
Date:   Thu,  9 Dec 2021 14:06:29 +0100
Message-Id: <2b491a4a9116e4ce9089a07bac09a07998906eeb.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove duplicated mcu definitions in mt7915 mcu.h and reused connac
ones.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 127 ---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 400 ++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  17 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 796 +-----------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  14 -
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 128 ---
 7 files changed, 411 insertions(+), 1075 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3a6fa6c8d471..759dcf0e6783 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -821,7 +821,7 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 
 	bss = (struct bss_info_basic *)tlv;
 	bss->network_type = cpu_to_le32(type);
-	bss->bmc_tx_wlan_idx = wlan_idx;
+	bss->bmc_wcid_lo = wlan_idx;
 	bss->wmm_idx = mvif->mt76.wmm_idx;
 	bss->active = enable;
 
@@ -1622,7 +1622,7 @@ static int mt7615_load_firmware(struct mt7615_dev *dev)
 
 	if (!mt76_poll_msec(dev, MT_TOP_MISC2, MT_TOP_MISC2_FW_STATE,
 			    FIELD_PREP(MT_TOP_MISC2_FW_STATE,
-				       FW_STATE_CR4_RDY), 500)) {
+				       FW_STATE_RDY), 500)) {
 		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
 		return -EIO;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 98c383e400a1..47863ae9f30b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -76,35 +76,6 @@ struct mt7615_uni_txd {
 	u8 reserved2[4];
 } __packed __aligned(4);
 
-/* event table */
-enum {
-	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
-	MCU_EVENT_FW_START = 0x01,
-	MCU_EVENT_GENERIC = 0x01,
-	MCU_EVENT_ACCESS_REG = 0x02,
-	MCU_EVENT_MT_PATCH_SEM = 0x04,
-	MCU_EVENT_REG_ACCESS = 0x05,
-	MCU_EVENT_SCAN_DONE = 0x0d,
-	MCU_EVENT_ROC = 0x10,
-	MCU_EVENT_BSS_ABSENCE  = 0x11,
-	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
-	MCU_EVENT_CH_PRIVILEGE = 0x18,
-	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
-	MCU_EVENT_EXT = 0xed,
-	MCU_EVENT_RESTART_DL = 0xef,
-	MCU_EVENT_COREDUMP = 0xf0,
-};
-
-/* ext event table */
-enum {
-	MCU_EXT_EVENT_PS_SYNC = 0x5,
-	MCU_EXT_EVENT_FW_LOG_2_HOST = 0x13,
-	MCU_EXT_EVENT_THERMAL_PROTECT = 0x22,
-	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
-	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
-	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
-};
-
 enum {
     MT_SKU_CCK_1_2 = 0,
     MT_SKU_CCK_55_11,
@@ -233,20 +204,6 @@ struct mt7615_mcu_rdd_report {
 #define MCU_PQ_ID(p, q)		(((p) << 15) | ((q) << 10))
 #define MCU_PKT_ID		0xa0
 
-enum {
-	MCU_Q_QUERY,
-	MCU_Q_SET,
-	MCU_Q_RESERVED,
-	MCU_Q_NA
-};
-
-enum {
-	MCU_S2D_H2N,
-	MCU_S2D_C2N,
-	MCU_S2D_H2C,
-	MCU_S2D_H2CN
-};
-
 enum {
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
 	MCU_ATE_SET_TX_POWER_CONTROL = 0x15,
@@ -280,21 +237,6 @@ struct mt7615_roc_tlv {
 	u8 rsv1[8];
 } __packed;
 
-enum {
-	PATCH_NOT_DL_SEM_FAIL	 = 0x0,
-	PATCH_IS_DL		 = 0x1,
-	PATCH_NOT_DL_SEM_SUCCESS = 0x2,
-	PATCH_REL_SEM_SUCCESS	 = 0x3
-};
-
-enum {
-	FW_STATE_INITIAL          = 0,
-	FW_STATE_FW_DOWNLOAD      = 1,
-	FW_STATE_NORMAL_OPERATION = 2,
-	FW_STATE_NORMAL_TRX       = 3,
-	FW_STATE_CR4_RDY          = 7
-};
-
 enum {
 	FW_STATE_PWR_ON = 1,
 	FW_STATE_N9_RDY = 2,
@@ -312,73 +254,4 @@ enum {
 	__DBDC_TYPE_MAX,
 };
 
-struct bss_info_omac {
-	__le16 tag;
-	__le16 len;
-	u8 hw_bss_idx;
-	u8 omac_idx;
-	u8 band_idx;
-	u8 rsv0;
-	__le32 conn_type;
-	u32 rsv1;
-} __packed;
-
-struct bss_info_basic {
-	__le16 tag;
-	__le16 len;
-	__le32 network_type;
-	u8 active;
-	u8 rsv0;
-	__le16 bcn_interval;
-	u8 bssid[ETH_ALEN];
-	u8 wmm_idx;
-	u8 dtim_period;
-	u8 bmc_tx_wlan_idx;
-	u8 cipher; /* not used */
-	u8 phymode; /* not used */
-	u8 rsv1[5];
-} __packed;
-
-struct bss_info_rf_ch {
-	__le16 tag;
-	__le16 len;
-	u8 pri_ch;
-	u8 central_ch0;
-	u8 central_ch1;
-	u8 bw;
-} __packed;
-
-struct bss_info_ext_bss {
-	__le16 tag;
-	__le16 len;
-	__le32 mbss_tsf_offset; /* in unit of us */
-	u8 rsv[8];
-} __packed;
-
-enum {
-	BSS_INFO_OMAC,
-	BSS_INFO_BASIC,
-	BSS_INFO_RF_CH, /* optional, for BT/LTE coex */
-	BSS_INFO_PM, /* sta only */
-	BSS_INFO_UAPSD, /* sta only */
-	BSS_INFO_ROAM_DETECTION, /* obsoleted */
-	BSS_INFO_LQ_RM, /* obsoleted */
-	BSS_INFO_EXT_BSS,
-	BSS_INFO_BMC_INFO, /* for bmc rate control in CR4 */
-	BSS_INFO_SYNC_MODE, /* obsoleted */
-	BSS_INFO_RA,
-	BSS_INFO_MAX_NUM
-};
-
-enum {
-	CH_SWITCH_NORMAL = 0,
-	CH_SWITCH_SCAN = 3,
-	CH_SWITCH_MCC = 4,
-	CH_SWITCH_DFS = 5,
-	CH_SWITCH_BACKGROUND_SCAN_START = 6,
-	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
-	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
-	CH_SWITCH_SCAN_BYPASS_DPD = 9
-};
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 039e228e0435..2b7db7b467cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -11,6 +11,76 @@ struct tlv {
 	__le16 len;
 } __packed;
 
+struct bss_info_omac {
+	__le16 tag;
+	__le16 len;
+	u8 hw_bss_idx;
+	u8 omac_idx;
+	u8 band_idx;
+	u8 rsv0;
+	__le32 conn_type;
+	u32 rsv1;
+} __packed;
+
+struct bss_info_basic {
+	__le16 tag;
+	__le16 len;
+	__le32 network_type;
+	u8 active;
+	u8 rsv0;
+	__le16 bcn_interval;
+	u8 bssid[ETH_ALEN];
+	u8 wmm_idx;
+	u8 dtim_period;
+	u8 bmc_wcid_lo;
+	u8 cipher;
+	u8 phy_mode;
+	u8 max_bssid;	/* max BSSID. range: 1 ~ 8, 0: MBSSID disabled */
+	u8 non_tx_bssid;/* non-transmitted BSSID, 0: transmitted BSSID */
+	u8 bmc_wcid_hi;	/* high Byte and version */
+	u8 rsv[2];
+} __packed;
+
+struct bss_info_rf_ch {
+	__le16 tag;
+	__le16 len;
+	u8 pri_ch;
+	u8 center_ch0;
+	u8 center_ch1;
+	u8 bw;
+	u8 he_ru26_block;	/* 1: don't send HETB in RU26, 0: allow */
+	u8 he_all_disable;	/* 1: disallow all HETB, 0: allow */
+	u8 rsv[2];
+} __packed;
+
+struct bss_info_ext_bss {
+	__le16 tag;
+	__le16 len;
+	__le32 mbss_tsf_offset; /* in unit of us */
+	u8 rsv[8];
+} __packed;
+
+enum {
+	BSS_INFO_OMAC,
+	BSS_INFO_BASIC,
+	BSS_INFO_RF_CH,		/* optional, for BT/LTE coex */
+	BSS_INFO_PM,		/* sta only */
+	BSS_INFO_UAPSD,		/* sta only */
+	BSS_INFO_ROAM_DETECT,	/* obsoleted */
+	BSS_INFO_LQ_RM,		/* obsoleted */
+	BSS_INFO_EXT_BSS,
+	BSS_INFO_BMC_RATE,	/* for bmc rate control in CR4 */
+	BSS_INFO_SYNC_MODE,	/* obsoleted */
+	BSS_INFO_RA,
+	BSS_INFO_HW_AMSDU,
+	BSS_INFO_BSS_COLOR,
+	BSS_INFO_HE_BASIC,
+	BSS_INFO_PROTECT_INFO,
+	BSS_INFO_OFFLOAD,
+	BSS_INFO_11V_MBSSID,
+	BSS_INFO_MAX_NUM
+};
+
 /* sta_rec */
 
 struct sta_ntlv_hdr {
@@ -54,7 +124,7 @@ struct sta_rec_vht {
 	__le32 vht_cap;
 	__le16 vht_rx_mcs_map;
 	__le16 vht_tx_mcs_map;
-	/* mt7921 */
+	/* mt7915 - mt7921 */
 	u8 rts_bw_sig;
 	u8 rsv[3];
 } __packed;
@@ -152,6 +222,191 @@ struct sta_rec_he_6g_capa {
 	u8 rsv[2];
 } __packed;
 
+struct sec_key {
+	u8 cipher_id;
+	u8 cipher_len;
+	u8 key_id;
+	u8 key_len;
+	u8 key[32];
+} __packed;
+
+struct sta_rec_sec {
+	__le16 tag;
+	__le16 len;
+	u8 add;
+	u8 n_cipher;
+	u8 rsv[2];
+
+	struct sec_key key[2];
+} __packed;
+
+struct sta_rec_bf {
+	__le16 tag;
+	__le16 len;
+
+	__le16 pfmu;		/* 0xffff: no access right for PFMU */
+	bool su_mu;		/* 0: SU, 1: MU */
+	u8 bf_cap;		/* 0: iBF, 1: eBF */
+	u8 sounding_phy;	/* 0: legacy, 1: OFDM, 2: HT, 4: VHT */
+	u8 ndpa_rate;
+	u8 ndp_rate;
+	u8 rept_poll_rate;
+	u8 tx_mode;		/* 0: legacy, 1: OFDM, 2: HT, 4: VHT ... */
+	u8 ncol;
+	u8 nrow;
+	u8 bw;			/* 0: 20M, 1: 40M, 2: 80M, 3: 160M */
+
+	u8 mem_total;
+	u8 mem_20m;
+	struct {
+		u8 row;
+		u8 col: 6, row_msb: 2;
+	} mem[4];
+
+	__le16 smart_ant;
+	u8 se_idx;
+	u8 auto_sounding;	/* b7: low traffic indicator
+				 * b6: Stop sounding for this entry
+				 * b5 ~ b0: postpone sounding
+				 */
+	u8 ibf_timeout;
+	u8 ibf_dbw;
+	u8 ibf_ncol;
+	u8 ibf_nrow;
+	u8 nrow_bw160;
+	u8 ncol_bw160;
+	u8 ru_start_idx;
+	u8 ru_end_idx;
+
+	bool trigger_su;
+	bool trigger_mu;
+	bool ng16_su;
+	bool ng16_mu;
+	bool codebook42_su;
+	bool codebook75_mu;
+
+	u8 he_ltf;
+	u8 rsv[3];
+} __packed;
+
+struct sta_rec_bfee {
+	__le16 tag;
+	__le16 len;
+	bool fb_identity_matrix;	/* 1: feedback identity matrix */
+	bool ignore_feedback;		/* 1: ignore */
+	u8 rsv[2];
+} __packed;
+
+struct sta_rec_muru {
+	__le16 tag;
+	__le16 len;
+
+	struct {
+		bool ofdma_dl_en;
+		bool ofdma_ul_en;
+		bool mimo_dl_en;
+		bool mimo_ul_en;
+		u8 rsv[4];
+	} cfg;
+
+	struct {
+		u8 punc_pream_rx;
+		bool he_20m_in_40m_2g;
+		bool he_20m_in_160m;
+		bool he_80m_in_160m;
+		bool lt16_sigb;
+		bool rx_su_comp_sigb;
+		bool rx_su_non_comp_sigb;
+		u8 rsv;
+	} ofdma_dl;
+
+	struct {
+		u8 t_frame_dur;
+		u8 mu_cascading;
+		u8 uo_ra;
+		u8 he_2x996_tone;
+		u8 rx_t_frame_11ac;
+		u8 rsv[3];
+	} ofdma_ul;
+
+	struct {
+		bool vht_mu_bfee;
+		bool partial_bw_dl_mimo;
+		u8 rsv[2];
+	} mimo_dl;
+
+	struct {
+		bool full_ul_mimo;
+		bool partial_ul_mimo;
+		u8 rsv[2];
+	} mimo_ul;
+} __packed;
+
+struct sta_phy {
+	u8 type;
+	u8 flag;
+	u8 stbc;
+	u8 sgi;
+	u8 bw;
+	u8 ldpc;
+	u8 mcs;
+	u8 nss;
+	u8 he_ltf;
+};
+
+struct sta_rec_ra {
+	__le16 tag;
+	__le16 len;
+
+	u8 valid;
+	u8 auto_rate;
+	u8 phy_mode;
+	u8 channel;
+	u8 bw;
+	u8 disable_cck;
+	u8 ht_mcs32;
+	u8 ht_gf;
+	u8 ht_mcs[4];
+	u8 mmps_mode;
+	u8 gband_256;
+	u8 af;
+	u8 auth_wapi_mode;
+	u8 rate_len;
+
+	u8 supp_mode;
+	u8 supp_cck_rate;
+	u8 supp_ofdm_rate;
+	__le32 supp_ht_mcs;
+	__le16 supp_vht_mcs[4];
+
+	u8 op_mode;
+	u8 op_vht_chan_width;
+	u8 op_vht_rx_nss;
+	u8 op_vht_rx_nss_type;
+
+	__le32 sta_cap;
+
+	struct sta_phy phy;
+} __packed;
+
+struct sta_rec_ra_fixed {
+	__le16 tag;
+	__le16 len;
+
+	__le32 field;
+	u8 op_mode;
+	u8 op_vht_chan_width;
+	u8 op_vht_rx_nss;
+	u8 op_vht_rx_nss_type;
+
+	struct sta_phy phy;
+
+	u8 spe_en;
+	u8 short_preamble;
+	u8 is_5g;
+	u8 mmps_mode;
+} __packed;
+
 /* wtbl_rec */
 
 struct wtbl_req_hdr {
@@ -234,6 +489,7 @@ struct wtbl_ba {
 	__le16 sn;
 	u8 ba_en;
 	u8 ba_winsize_idx;
+	/* originator & recipient */
 	__le16 ba_winsize;
 	/* recipient only */
 	u8 peer_addr[ETH_ALEN];
@@ -304,12 +560,17 @@ struct wtbl_raw {
 
 #define MT76_CONNAC_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct sta_rec_basic) +	\
+					 sizeof(struct sta_rec_bf) +	\
 					 sizeof(struct sta_rec_ht) +	\
 					 sizeof(struct sta_rec_he) +	\
 					 sizeof(struct sta_rec_ba) +	\
 					 sizeof(struct sta_rec_vht) +	\
 					 sizeof(struct sta_rec_uapsd) + \
 					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct sta_rec_muru) +	\
+					 sizeof(struct sta_rec_bfee) +	\
+					 sizeof(struct sta_rec_ra) +	\
+					 sizeof(struct sta_rec_ra_fixed) + \
 					 sizeof(struct sta_rec_he_6g_capa) + \
 					 sizeof(struct tlv) +		\
 					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
@@ -432,6 +693,21 @@ enum {
 #define MODE_VHT				BIT(3)
 #define MODE_HE					BIT(4)
 
+#define STA_CAP_WMM				BIT(0)
+#define STA_CAP_SGI_20				BIT(4)
+#define STA_CAP_SGI_40				BIT(5)
+#define STA_CAP_TX_STBC				BIT(6)
+#define STA_CAP_RX_STBC				BIT(7)
+#define STA_CAP_VHT_SGI_80			BIT(16)
+#define STA_CAP_VHT_SGI_160			BIT(17)
+#define STA_CAP_VHT_TX_STBC			BIT(18)
+#define STA_CAP_VHT_RX_STBC			BIT(19)
+#define STA_CAP_VHT_LDPC			BIT(23)
+#define STA_CAP_LDPC				BIT(24)
+#define STA_CAP_HT				BIT(26)
+#define STA_CAP_VHT				BIT(27)
+#define STA_CAP_HE				BIT(28)
+
 enum {
 	PHY_TYPE_HR_DSSS_INDEX = 0,
 	PHY_TYPE_ERP_INDEX,
@@ -490,6 +766,120 @@ enum {
 	DEV_INFO_MAX_NUM
 };
 
+/* event table */
+enum {
+	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
+	MCU_EVENT_FW_START = 0x01,
+	MCU_EVENT_GENERIC = 0x01,
+	MCU_EVENT_ACCESS_REG = 0x02,
+	MCU_EVENT_MT_PATCH_SEM = 0x04,
+	MCU_EVENT_REG_ACCESS = 0x05,
+	MCU_EVENT_LP_INFO = 0x07,
+	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_TX_DONE = 0x0f,
+	MCU_EVENT_ROC = 0x10,
+	MCU_EVENT_BSS_ABSENCE  = 0x11,
+	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
+	MCU_EVENT_CH_PRIVILEGE = 0x18,
+	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
+	MCU_EVENT_DBG_MSG = 0x27,
+	MCU_EVENT_TXPWR = 0xd0,
+	MCU_EVENT_EXT = 0xed,
+	MCU_EVENT_RESTART_DL = 0xef,
+	MCU_EVENT_COREDUMP = 0xf0,
+};
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_PS_SYNC = 0x5,
+	MCU_EXT_EVENT_FW_LOG_2_HOST = 0x13,
+	MCU_EXT_EVENT_THERMAL_PROTECT = 0x22,
+	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
+	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
+	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
+	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
+};
+
+enum {
+	MCU_Q_QUERY,
+	MCU_Q_SET,
+	MCU_Q_RESERVED,
+	MCU_Q_NA
+};
+
+enum {
+	MCU_S2D_H2N,
+	MCU_S2D_C2N,
+	MCU_S2D_H2C,
+	MCU_S2D_H2CN
+};
+
+enum {
+	PATCH_NOT_DL_SEM_FAIL,
+	PATCH_IS_DL,
+	PATCH_NOT_DL_SEM_SUCCESS,
+	PATCH_REL_SEM_SUCCESS
+};
+
+enum {
+	FW_STATE_INITIAL,
+	FW_STATE_FW_DOWNLOAD,
+	FW_STATE_NORMAL_OPERATION,
+	FW_STATE_NORMAL_TRX,
+	FW_STATE_RDY = 7
+};
+
+enum {
+	CH_SWITCH_NORMAL = 0,
+	CH_SWITCH_SCAN = 3,
+	CH_SWITCH_MCC = 4,
+	CH_SWITCH_DFS = 5,
+	CH_SWITCH_BACKGROUND_SCAN_START = 6,
+	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
+	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
+	CH_SWITCH_SCAN_BYPASS_DPD = 9
+};
+
+enum {
+	THERMAL_SENSOR_TEMP_QUERY,
+	THERMAL_SENSOR_MANUAL_CTRL,
+	THERMAL_SENSOR_INFO_QUERY,
+	THERMAL_SENSOR_TASK_CTRL,
+};
+
+enum mcu_cipher_type {
+	MCU_CIPHER_NONE = 0,
+	MCU_CIPHER_WEP40,
+	MCU_CIPHER_WEP104,
+	MCU_CIPHER_WEP128,
+	MCU_CIPHER_TKIP,
+	MCU_CIPHER_AES_CCMP,
+	MCU_CIPHER_CCMP_256,
+	MCU_CIPHER_GCMP,
+	MCU_CIPHER_GCMP_256,
+	MCU_CIPHER_WAPI,
+	MCU_CIPHER_BIP_CMAC_128,
+};
+
+enum {
+	EE_MODE_EFUSE,
+	EE_MODE_BUFFER,
+};
+
+enum {
+	EE_FORMAT_BIN,
+	EE_FORMAT_WHOLE,
+	EE_FORMAT_MULTIPLE,
+};
+
+enum {
+	MCU_PHY_STATE_TX_RATE,
+	MCU_PHY_STATE_RX_RATE,
+	MCU_PHY_STATE_RSSI,
+	MCU_PHY_STATE_CONTENTION_RX_RATE,
+	MCU_PHY_STATE_OFDMLQ_CNINFO,
+};
+
 #define MCU_CMD_ACK				BIT(0)
 #define MCU_CMD_UNI				BIT(1)
 #define MCU_CMD_QUERY				BIT(2)
@@ -502,6 +892,7 @@ enum {
 #define __MCU_CMD_FIELD_QUERY			BIT(16)
 #define __MCU_CMD_FIELD_UNI			BIT(17)
 #define __MCU_CMD_FIELD_CE			BIT(18)
+#define __MCU_CMD_FIELD_WA			BIT(19)
 
 #define MCU_CMD(_t)				FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							   MCU_CMD_##_t)
@@ -517,6 +908,12 @@ enum {
 							   MCU_CE_CMD_##_t))
 #define MCU_CE_QUERY(_t)			(MCU_CE_CMD(_t) | __MCU_CMD_FIELD_QUERY)
 
+#define MCU_WA_CMD(_t)				(MCU_CMD(_t) | __MCU_CMD_FIELD_WA)
+#define MCU_WA_EXT_CMD(_t)			(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_WA)
+#define MCU_WA_PARAM_CMD(_t)			(MCU_WA_CMD(WA_PARAM) | \
+						 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
+							    MCU_WA_PARAM_CMD_##_t))
+
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
 	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
@@ -558,7 +955,6 @@ enum {
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
 	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
-	MCU_EXT_CMD_OFFCH_SCAN_CTRL = 0x9a,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_MURU_CTRL = 0x9f,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d7a6df23fc42..6f0f9925030a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -613,7 +613,7 @@ mt7915_mcu_alloc_wtbl_req(struct mt7915_dev *dev, struct mt7915_sta *msta,
 
 	if (!nskb) {
 		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-					  MT7915_WTBL_UPDATE_MAX_SIZE);
+					  MT76_CONNAC_WTBL_UPDATE_MAX_SIZE);
 		if (!nskb)
 			return ERR_PTR(-ENOMEM);
 
@@ -1204,7 +1204,7 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 		msta->wcid.amsdu = false;
 
 	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
+				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1223,7 +1223,7 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 		return ret;
 
 	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
+				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1738,7 +1738,8 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct sk_buff *skb;
 
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7915_WTBL_UPDATE_MAX_SIZE);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2090,7 +2091,7 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	int ret;
 
 	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
+				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2303,7 +2304,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	int ret;
 
 	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
+				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2370,7 +2371,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
 
 	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
+				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2945,7 +2946,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 
 	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
 			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
-				       FW_STATE_WACPU_RDY), 1000)) {
+				       FW_STATE_RDY), 1000)) {
 		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
 		return -EIO;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 49e41874c602..3ccded528965 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -4,6 +4,8 @@
 #ifndef __MT7915_MCU_H
 #define __MT7915_MCU_H
 
+#include "../mt76_connac_mcu.h"
+
 struct mt7915_mcu_txd {
 	__le32 txd[8];
 
@@ -23,29 +25,6 @@ struct mt7915_mcu_txd {
 	u32 reserved[5];
 } __packed __aligned(4);
 
-/* event table */
-enum {
-	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
-	MCU_EVENT_FW_START = 0x01,
-	MCU_EVENT_GENERIC = 0x01,
-	MCU_EVENT_ACCESS_REG = 0x02,
-	MCU_EVENT_MT_PATCH_SEM = 0x04,
-	MCU_EVENT_CH_PRIVILEGE = 0x18,
-	MCU_EVENT_EXT = 0xed,
-	MCU_EVENT_RESTART_DL = 0xef,
-};
-
-/* ext event table */
-enum {
-	MCU_EXT_EVENT_PS_SYNC = 0x5,
-	MCU_EXT_EVENT_FW_LOG_2_HOST = 0x13,
-	MCU_EXT_EVENT_THERMAL_PROTECT = 0x22,
-	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
-	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
-	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
-	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
-};
-
 enum {
 	MCU_ATE_SET_TRX = 0x1,
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
@@ -215,85 +194,12 @@ struct mt7915_mcu_tx {
 #define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
 #define MCU_PKT_ID			0xa0
 
-enum {
-	MCU_Q_QUERY,
-	MCU_Q_SET,
-	MCU_Q_RESERVED,
-	MCU_Q_NA
-};
-
-enum {
-	MCU_S2D_H2N,
-	MCU_S2D_C2N,
-	MCU_S2D_H2C,
-	MCU_S2D_H2CN
-};
-
 enum {
 	MCU_FW_LOG_WM,
 	MCU_FW_LOG_WA,
 	MCU_FW_LOG_TO_HOST,
 };
 
-#define __MCU_CMD_FIELD_ID	GENMASK(7, 0)
-#define __MCU_CMD_FIELD_EXT_ID	GENMASK(15, 8)
-#define __MCU_CMD_FIELD_QUERY	BIT(16)
-#define __MCU_CMD_FIELD_WA	BIT(17)
-
-enum {
-	MCU_CMD_TARGET_ADDRESS_LEN_REQ = 0x01,
-	MCU_CMD_FW_START_REQ = 0x02,
-	MCU_CMD_INIT_ACCESS_REG = 0x3,
-	MCU_CMD_NIC_POWER_CTRL = 0x4,
-	MCU_CMD_PATCH_START_REQ = 0x05,
-	MCU_CMD_PATCH_FINISH_REQ = 0x07,
-	MCU_CMD_PATCH_SEM_CONTROL = 0x10,
-	MCU_CMD_WA_PARAM = 0xC4,
-	MCU_CMD_EXT_CID = 0xED,
-	MCU_CMD_FW_SCATTER = 0xEE,
-	MCU_CMD_RESTART_DL_REQ = 0xEF,
-};
-
-enum {
-	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
-	MCU_EXT_CMD_RF_TEST = 0x04,
-	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
-	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
-	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
-	MCU_EXT_CMD_TXBF_ACTION = 0x1e,
-	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
-	MCU_EXT_CMD_THERMAL_PROT = 0x23,
-	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
-	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
-	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
-	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
-	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
-	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
-	MCU_EXT_CMD_SET_DRR_CTRL = 0x36,
-	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
-	MCU_EXT_CMD_ATE_CTRL = 0x3d,
-	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
-	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
-	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
-	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
-	MCU_EXT_CMD_RX_AIRTIME_CTRL = 0x4a,
-	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
-	MCU_EXT_CMD_EFUSE_FREE_BLOCK = 0x4f,
-	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
-	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
-	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
-	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
-	MCU_EXT_CMD_SCS_CTRL = 0x82,
-	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
-	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
-	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
-	MCU_EXT_CMD_MURU_CTRL = 0x9f,
-	MCU_EXT_CMD_SET_SPR = 0xa8,
-	MCU_EXT_CMD_GROUP_PRE_CAL_INFO = 0xab,
-	MCU_EXT_CMD_DPD_PRE_CAL_INFO = 0xac,
-	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
-};
-
 enum {
 	MCU_TWT_AGRT_ADD,
 	MCU_TWT_AGRT_MODIFY,
@@ -315,57 +221,6 @@ enum {
 	MCU_WA_PARAM_RED = 0x0e,
 };
 
-#define MCU_CMD(_t)		FIELD_PREP(__MCU_CMD_FIELD_ID, MCU_CMD_##_t)
-#define MCU_EXT_CMD(_t)		(MCU_CMD(EXT_CID) | \
-				 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
-					    MCU_EXT_CMD_##_t))
-#define MCU_EXT_QUERY(_t)	(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_QUERY)
-
-#define MCU_WA_CMD(_t)		(MCU_CMD(_t) | __MCU_CMD_FIELD_WA)
-#define MCU_WA_EXT_CMD(_t)	(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_WA)
-#define MCU_WA_PARAM_CMD(_t)	(MCU_WA_CMD(WA_PARAM) | \
-				 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
-					    MCU_WA_PARAM_CMD_##_t))
-
-enum {
-	PATCH_SEM_RELEASE,
-	PATCH_SEM_GET
-};
-
-enum {
-	PATCH_NOT_DL_SEM_FAIL,
-	PATCH_IS_DL,
-	PATCH_NOT_DL_SEM_SUCCESS,
-	PATCH_REL_SEM_SUCCESS
-};
-
-enum {
-	FW_STATE_INITIAL,
-	FW_STATE_FW_DOWNLOAD,
-	FW_STATE_NORMAL_OPERATION,
-	FW_STATE_NORMAL_TRX,
-	FW_STATE_WACPU_RDY        = 7
-};
-
-enum {
-	EE_MODE_EFUSE,
-	EE_MODE_BUFFER,
-};
-
-enum {
-	EE_FORMAT_BIN,
-	EE_FORMAT_WHOLE,
-	EE_FORMAT_MULTIPLE,
-};
-
-enum {
-	MCU_PHY_STATE_TX_RATE,
-	MCU_PHY_STATE_RX_RATE,
-	MCU_PHY_STATE_RSSI,
-	MCU_PHY_STATE_CONTENTION_RX_RATE,
-	MCU_PHY_STATE_OFDMLQ_CNINFO,
-};
-
 enum mcu_mmps_mode {
 	MCU_MMPS_STATIC,
 	MCU_MMPS_DYNAMIC,
@@ -396,11 +251,6 @@ enum mcu_mmps_mode {
 #define CONN_STATE_CONNECT		1
 #define CONN_STATE_PORT_SECURE		2
 
-enum {
-	DEV_INFO_ACTIVE,
-	DEV_INFO_MAX_NUM
-};
-
 enum {
 	SCS_SEND_DATA,
 	SCS_SET_MANUAL_PD_TH,
@@ -411,75 +261,6 @@ enum {
 	SCS_GET_GLO_ADDR_EVENT,
 };
 
-enum {
-	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
-	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
-	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
-	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
-	CMD_CBW_10MHZ,
-	CMD_CBW_5MHZ,
-	CMD_CBW_8080MHZ,
-
-	CMD_HE_MCS_BW80 = 0,
-	CMD_HE_MCS_BW160,
-	CMD_HE_MCS_BW8080,
-	CMD_HE_MCS_BW_NUM
-};
-
-struct tlv {
-	__le16 tag;
-	__le16 len;
-} __packed;
-
-struct bss_info_omac {
-	__le16 tag;
-	__le16 len;
-	u8 hw_bss_idx;
-	u8 omac_idx;
-	u8 band_idx;
-	u8 rsv0;
-	__le32 conn_type;
-	u32 rsv1;
-} __packed;
-
-struct bss_info_basic {
-	__le16 tag;
-	__le16 len;
-	__le32 network_type;
-	u8 active;
-	u8 rsv0;
-	__le16 bcn_interval;
-	u8 bssid[ETH_ALEN];
-	u8 wmm_idx;
-	u8 dtim_period;
-	u8 bmc_wcid_lo;
-	u8 cipher;
-	u8 phy_mode;
-	u8 max_bssid;	/* max BSSID. range: 1 ~ 8, 0: MBSSID disabled */
-	u8 non_tx_bssid;/* non-transmitted BSSID, 0: transmitted BSSID */
-	u8 bmc_wcid_hi;	/* high Byte and version */
-	u8 rsv[2];
-} __packed;
-
-struct bss_info_rf_ch {
-	__le16 tag;
-	__le16 len;
-	u8 pri_ch;
-	u8 center_ch0;
-	u8 center_ch1;
-	u8 bw;
-	u8 he_ru26_block;	/* 1: don't send HETB in RU26, 0: allow */
-	u8 he_all_disable;	/* 1: disallow all HETB, 0: allow */
-	u8 rsv[2];
-} __packed;
-
-struct bss_info_ext_bss {
-	__le16 tag;
-	__le16 len;
-	__le32 mbss_tsf_offset; /* in unit of us */
-	u8 rsv[8];
-} __packed;
-
 struct bss_info_bmc_rate {
 	__le16 tag;
 	__le16 len;
@@ -588,384 +369,6 @@ enum {
 	BSS_INFO_BCN_MAX
 };
 
-enum {
-	BSS_INFO_OMAC,
-	BSS_INFO_BASIC,
-	BSS_INFO_RF_CH,		/* optional, for BT/LTE coex */
-	BSS_INFO_PM,		/* sta only */
-	BSS_INFO_UAPSD,		/* sta only */
-	BSS_INFO_ROAM_DETECT,	/* obsoleted */
-	BSS_INFO_LQ_RM,		/* obsoleted */
-	BSS_INFO_EXT_BSS,
-	BSS_INFO_BMC_RATE,	/* for bmc rate control in CR4 */
-	BSS_INFO_SYNC_MODE,	/* obsoleted */
-	BSS_INFO_RA,
-	BSS_INFO_HW_AMSDU,
-	BSS_INFO_BSS_COLOR,
-	BSS_INFO_HE_BASIC,
-	BSS_INFO_PROTECT_INFO,
-	BSS_INFO_OFFLOAD,
-	BSS_INFO_11V_MBSSID,
-	BSS_INFO_MAX_NUM
-};
-
-enum {
-	WTBL_RESET_AND_SET = 1,
-	WTBL_SET,
-	WTBL_QUERY,
-	WTBL_RESET_ALL
-};
-
-struct wtbl_req_hdr {
-	u8 wlan_idx_lo;
-	u8 operation;
-	__le16 tlv_num;
-	u8 wlan_idx_hi;
-	u8 rsv[3];
-} __packed;
-
-struct wtbl_generic {
-	__le16 tag;
-	__le16 len;
-	u8 peer_addr[ETH_ALEN];
-	u8 muar_idx;
-	u8 skip_tx;
-	u8 cf_ack;
-	u8 qos;
-	u8 mesh;
-	u8 adm;
-	__le16 partial_aid;
-	u8 baf_en;
-	u8 aad_om;
-} __packed;
-
-struct wtbl_rx {
-	__le16 tag;
-	__le16 len;
-	u8 rcid;
-	u8 rca1;
-	u8 rca2;
-	u8 rv;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_ht {
-	__le16 tag;
-	__le16 len;
-	u8 ht;
-	u8 ldpc;
-	u8 af;
-	u8 mm;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_vht {
-	__le16 tag;
-	__le16 len;
-	u8 ldpc;
-	u8 dyn_bw;
-	u8 vht;
-	u8 txop_ps;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_hdr_trans {
-	__le16 tag;
-	__le16 len;
-	u8 to_ds;
-	u8 from_ds;
-	u8 no_rx_trans;
-	u8 _rsv;
-};
-
-enum {
-	MT_BA_TYPE_INVALID,
-	MT_BA_TYPE_ORIGINATOR,
-	MT_BA_TYPE_RECIPIENT
-};
-
-enum {
-	RST_BA_MAC_TID_MATCH,
-	RST_BA_MAC_MATCH,
-	RST_BA_NO_MATCH
-};
-
-struct wtbl_ba {
-	__le16 tag;
-	__le16 len;
-	/* common */
-	u8 tid;
-	u8 ba_type;
-	u8 rsv0[2];
-	/* originator only */
-	__le16 sn;
-	u8 ba_en;
-	u8 ba_winsize_idx;
-	/* originator & recipient */
-	__le16 ba_winsize;
-	/* recipient only */
-	u8 peer_addr[ETH_ALEN];
-	u8 rst_ba_tid;
-	u8 rst_ba_sel;
-	u8 rst_ba_sb;
-	u8 band_idx;
-	u8 rsv1[4];
-} __packed;
-
-struct wtbl_smps {
-	__le16 tag;
-	__le16 len;
-	u8 smps;
-	u8 rsv[3];
-} __packed;
-
-enum {
-	WTBL_GENERIC,
-	WTBL_RX,
-	WTBL_HT,
-	WTBL_VHT,
-	WTBL_PEER_PS,		/* not used */
-	WTBL_TX_PS,
-	WTBL_HDR_TRANS,
-	WTBL_SEC_KEY,
-	WTBL_BA,
-	WTBL_RDG,		/* obsoleted */
-	WTBL_PROTECT,		/* not used */
-	WTBL_CLEAR,		/* not used */
-	WTBL_BF,
-	WTBL_SMPS,
-	WTBL_RAW_DATA,		/* debug only */
-	WTBL_PN,
-	WTBL_SPE,
-	WTBL_MAX_NUM
-};
-
-struct sta_ntlv_hdr {
-	u8 rsv[2];
-	__le16 tlv_num;
-} __packed;
-
-struct sta_req_hdr {
-	u8 bss_idx;
-	u8 wlan_idx_lo;
-	__le16 tlv_num;
-	u8 is_tlv_append;
-	u8 muar_idx;
-	u8 wlan_idx_hi;
-	u8 rsv;
-} __packed;
-
-struct sta_rec_basic {
-	__le16 tag;
-	__le16 len;
-	__le32 conn_type;
-	u8 conn_state;
-	u8 qos;
-	__le16 aid;
-	u8 peer_addr[ETH_ALEN];
-	__le16 extra_info;
-} __packed;
-
-struct sta_rec_ht {
-	__le16 tag;
-	__le16 len;
-	__le16 ht_cap;
-	u16 rsv;
-} __packed;
-
-struct sta_rec_vht {
-	__le16 tag;
-	__le16 len;
-	__le32 vht_cap;
-	__le16 vht_rx_mcs_map;
-	__le16 vht_tx_mcs_map;
-	u8 rts_bw_sig;
-	u8 rsv[3];
-} __packed;
-
-struct sta_rec_uapsd {
-	__le16 tag;
-	__le16 len;
-	u8 dac_map;
-	u8 tac_map;
-	u8 max_sp;
-	u8 rsv0;
-	__le16 listen_interval;
-	u8 rsv1[2];
-} __packed;
-
-struct sta_rec_muru {
-	__le16 tag;
-	__le16 len;
-
-	struct {
-		bool ofdma_dl_en;
-		bool ofdma_ul_en;
-		bool mimo_dl_en;
-		bool mimo_ul_en;
-		u8 rsv[4];
-	} cfg;
-
-	struct {
-		u8 punc_pream_rx;
-		bool he_20m_in_40m_2g;
-		bool he_20m_in_160m;
-		bool he_80m_in_160m;
-		bool lt16_sigb;
-		bool rx_su_comp_sigb;
-		bool rx_su_non_comp_sigb;
-		u8 rsv;
-	} ofdma_dl;
-
-	struct {
-		u8 t_frame_dur;
-		u8 mu_cascading;
-		u8 uo_ra;
-		u8 he_2x996_tone;
-		u8 rx_t_frame_11ac;
-		u8 rsv[3];
-	} ofdma_ul;
-
-	struct {
-		bool vht_mu_bfee;
-		bool partial_bw_dl_mimo;
-		u8 rsv[2];
-	} mimo_dl;
-
-	struct {
-		bool full_ul_mimo;
-		bool partial_ul_mimo;
-		u8 rsv[2];
-	} mimo_ul;
-} __packed;
-
-struct sta_rec_he {
-	__le16 tag;
-	__le16 len;
-
-	__le32 he_cap;
-
-	u8 t_frame_dur;
-	u8 max_ampdu_exp;
-	u8 bw_set;
-	u8 device_class;
-	u8 dcm_tx_mode;
-	u8 dcm_tx_max_nss;
-	u8 dcm_rx_mode;
-	u8 dcm_rx_max_nss;
-	u8 dcm_max_ru;
-	u8 punc_pream_rx;
-	u8 pkt_ext;
-	u8 rsv1;
-
-	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
-
-	u8 rsv2[2];
-} __packed;
-
-struct sta_rec_ba {
-	__le16 tag;
-	__le16 len;
-	u8 tid;
-	u8 ba_type;
-	u8 amsdu;
-	u8 ba_en;
-	__le16 ssn;
-	__le16 winsize;
-} __packed;
-
-struct sta_rec_amsdu {
-	__le16 tag;
-	__le16 len;
-	u8 max_amsdu_num;
-	u8 max_mpdu_size;
-	u8 amsdu_en;
-	u8 rsv;
-} __packed;
-
-struct sec_key {
-	u8 cipher_id;
-	u8 cipher_len;
-	u8 key_id;
-	u8 key_len;
-	u8 key[32];
-} __packed;
-
-struct sta_rec_sec {
-	__le16 tag;
-	__le16 len;
-	u8 add;
-	u8 n_cipher;
-	u8 rsv[2];
-
-	struct sec_key key[2];
-} __packed;
-
-struct sta_phy {
-	u8 type;
-	u8 flag;
-	u8 stbc;
-	u8 sgi;
-	u8 bw;
-	u8 ldpc;
-	u8 mcs;
-	u8 nss;
-	u8 he_ltf;
-};
-
-struct sta_rec_ra {
-	__le16 tag;
-	__le16 len;
-
-	u8 valid;
-	u8 auto_rate;
-	u8 phy_mode;
-	u8 channel;
-	u8 bw;
-	u8 disable_cck;
-	u8 ht_mcs32;
-	u8 ht_gf;
-	u8 ht_mcs[4];
-	u8 mmps_mode;
-	u8 gband_256;
-	u8 af;
-	u8 auth_wapi_mode;
-	u8 rate_len;
-
-	u8 supp_mode;
-	u8 supp_cck_rate;
-	u8 supp_ofdm_rate;
-	__le32 supp_ht_mcs;
-	__le16 supp_vht_mcs[4];
-
-	u8 op_mode;
-	u8 op_vht_chan_width;
-	u8 op_vht_rx_nss;
-	u8 op_vht_rx_nss_type;
-
-	__le32 sta_cap;
-
-	struct sta_phy phy;
-} __packed;
-
-struct sta_rec_ra_fixed {
-	__le16 tag;
-	__le16 len;
-
-	__le32 field;
-	u8 op_mode;
-	u8 op_vht_chan_width;
-	u8 op_vht_rx_nss;
-	u8 op_vht_rx_nss_type;
-
-	struct sta_phy phy;
-
-	u8 spe_en;
-	u8 short_preamble;
-	u8 is_5g;
-	u8 mmps_mode;
-} __packed;
-
 enum {
 	RATE_PARAM_FIXED = 3,
 	RATE_PARAM_MMPS_UPDATE = 5,
@@ -984,120 +387,6 @@ enum {
 #define RATE_CFG_PHY_TYPE		GENMASK(27, 24)
 #define RATE_CFG_HE_LTF			GENMASK(31, 28)
 
-struct sta_rec_bf {
-	__le16 tag;
-	__le16 len;
-
-	__le16 pfmu;		/* 0xffff: no access right for PFMU */
-	bool su_mu;		/* 0: SU, 1: MU */
-	u8 bf_cap;		/* 0: iBF, 1: eBF */
-	u8 sounding_phy;	/* 0: legacy, 1: OFDM, 2: HT, 4: VHT */
-	u8 ndpa_rate;
-	u8 ndp_rate;
-	u8 rept_poll_rate;
-	u8 tx_mode;		/* 0: legacy, 1: OFDM, 2: HT, 4: VHT ... */
-	u8 ncol;
-	u8 nrow;
-	u8 bw;			/* 0: 20M, 1: 40M, 2: 80M, 3: 160M */
-
-	u8 mem_total;
-	u8 mem_20m;
-	struct {
-		u8 row;
-		u8 col: 6, row_msb: 2;
-	} mem[4];
-
-	__le16 smart_ant;
-	u8 se_idx;
-	u8 auto_sounding;	/* b7: low traffic indicator
-				 * b6: Stop sounding for this entry
-				 * b5 ~ b0: postpone sounding
-				 */
-	u8 ibf_timeout;
-	u8 ibf_dbw;
-	u8 ibf_ncol;
-	u8 ibf_nrow;
-	u8 nrow_bw160;
-	u8 ncol_bw160;
-	u8 ru_start_idx;
-	u8 ru_end_idx;
-
-	bool trigger_su;
-	bool trigger_mu;
-	bool ng16_su;
-	bool ng16_mu;
-	bool codebook42_su;
-	bool codebook75_mu;
-
-	u8 he_ltf;
-	u8 rsv[3];
-} __packed;
-
-struct sta_rec_bfee {
-	__le16 tag;
-	__le16 len;
-	bool fb_identity_matrix;	/* 1: feedback identity matrix */
-	bool ignore_feedback;		/* 1: ignore */
-	u8 rsv[2];
-} __packed;
-
-enum {
-	STA_REC_BASIC,
-	STA_REC_RA,
-	STA_REC_RA_CMM_INFO,
-	STA_REC_RA_UPDATE,
-	STA_REC_BF,
-	STA_REC_AMSDU,
-	STA_REC_BA,
-	STA_REC_RED,		/* not used */
-	STA_REC_TX_PROC,	/* for hdr trans and CSO in CR4 */
-	STA_REC_HT,
-	STA_REC_VHT,
-	STA_REC_APPS,
-	STA_REC_KEY,
-	STA_REC_WTBL,
-	STA_REC_HE,
-	STA_REC_HW_AMSDU,
-	STA_REC_WTBL_AADOM,
-	STA_REC_KEY_V2,
-	STA_REC_MURU,
-	STA_REC_MUEDCA,
-	STA_REC_BFEE,
-	STA_REC_MAX_NUM
-};
-
-enum mcu_cipher_type {
-	MCU_CIPHER_NONE = 0,
-	MCU_CIPHER_WEP40,
-	MCU_CIPHER_WEP104,
-	MCU_CIPHER_WEP128,
-	MCU_CIPHER_TKIP,
-	MCU_CIPHER_AES_CCMP,
-	MCU_CIPHER_CCMP_256,
-	MCU_CIPHER_GCMP,
-	MCU_CIPHER_GCMP_256,
-	MCU_CIPHER_WAPI,
-	MCU_CIPHER_BIP_CMAC_128,
-};
-
-enum {
-	CH_SWITCH_NORMAL = 0,
-	CH_SWITCH_SCAN = 3,
-	CH_SWITCH_MCC = 4,
-	CH_SWITCH_DFS = 5,
-	CH_SWITCH_BACKGROUND_SCAN_START = 6,
-	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
-	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
-	CH_SWITCH_SCAN_BYPASS_DPD = 9
-};
-
-enum {
-	THERMAL_SENSOR_TEMP_QUERY,
-	THERMAL_SENSOR_MANUAL_CTRL,
-	THERMAL_SENSOR_INFO_QUERY,
-	THERMAL_SENSOR_TASK_CTRL,
-};
-
 enum {
 	THERMAL_PROTECT_PARAMETER_CTRL,
 	THERMAL_PROTECT_BASIC_INFO,
@@ -1125,29 +414,6 @@ enum {
 	MURU_PLATFORM_TYPE_PERF_LEVEL_2,
 };
 
-#define MT7915_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_generic) +	\
-					 sizeof(struct wtbl_rx) +	\
-					 sizeof(struct wtbl_ht) +	\
-					 sizeof(struct wtbl_vht) +	\
-					 sizeof(struct wtbl_hdr_trans) +\
-					 sizeof(struct wtbl_ba) +	\
-					 sizeof(struct wtbl_smps))
-
-#define MT7915_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
-					 sizeof(struct sta_rec_basic) +	\
-					 sizeof(struct sta_rec_bf) +	\
-					 sizeof(struct sta_rec_ht) +	\
-					 sizeof(struct sta_rec_he) +	\
-					 sizeof(struct sta_rec_ba) +	\
-					 sizeof(struct sta_rec_vht) +	\
-					 sizeof(struct sta_rec_uapsd) + \
-					 sizeof(struct sta_rec_amsdu) +	\
-					 sizeof(struct sta_rec_muru) +	\
-					 sizeof(struct sta_rec_bfee) +	\
-					 sizeof(struct tlv) +		\
-					 MT7915_WTBL_UPDATE_MAX_SIZE)
-
 #define MT7915_BSS_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct bss_info_omac) +	\
 					 sizeof(struct bss_info_basic) +\
@@ -1163,62 +429,4 @@ enum {
 					 sizeof(struct bss_info_bcn_mbss) + \
 					 sizeof(struct bss_info_bcn_cont))
 
-#define PHY_MODE_A			BIT(0)
-#define PHY_MODE_B			BIT(1)
-#define PHY_MODE_G			BIT(2)
-#define PHY_MODE_GN			BIT(3)
-#define PHY_MODE_AN			BIT(4)
-#define PHY_MODE_AC			BIT(5)
-#define PHY_MODE_AX_24G			BIT(6)
-#define PHY_MODE_AX_5G			BIT(7)
-#define PHY_MODE_AX_6G			BIT(8)
-
-#define MODE_CCK			BIT(0)
-#define MODE_OFDM			BIT(1)
-#define MODE_HT				BIT(2)
-#define MODE_VHT			BIT(3)
-#define MODE_HE				BIT(4)
-
-#define STA_CAP_WMM			BIT(0)
-#define STA_CAP_SGI_20			BIT(4)
-#define STA_CAP_SGI_40			BIT(5)
-#define STA_CAP_TX_STBC			BIT(6)
-#define STA_CAP_RX_STBC			BIT(7)
-#define STA_CAP_VHT_SGI_80		BIT(16)
-#define STA_CAP_VHT_SGI_160		BIT(17)
-#define STA_CAP_VHT_TX_STBC		BIT(18)
-#define STA_CAP_VHT_RX_STBC		BIT(19)
-#define STA_CAP_VHT_LDPC		BIT(23)
-#define STA_CAP_LDPC			BIT(24)
-#define STA_CAP_HT			BIT(26)
-#define STA_CAP_VHT			BIT(27)
-#define STA_CAP_HE			BIT(28)
-
-/* HE MAC */
-#define STA_REC_HE_CAP_HTC			BIT(0)
-#define STA_REC_HE_CAP_BQR			BIT(1)
-#define STA_REC_HE_CAP_BSR			BIT(2)
-#define STA_REC_HE_CAP_OM			BIT(3)
-#define STA_REC_HE_CAP_AMSDU_IN_AMPDU		BIT(4)
-/* HE PHY */
-#define STA_REC_HE_CAP_DUAL_BAND		BIT(5)
-#define STA_REC_HE_CAP_LDPC			BIT(6)
-#define STA_REC_HE_CAP_TRIG_CQI_FK		BIT(7)
-#define STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE	BIT(8)
-/* STBC */
-#define STA_REC_HE_CAP_LE_EQ_80M_TX_STBC	BIT(9)
-#define STA_REC_HE_CAP_LE_EQ_80M_RX_STBC	BIT(10)
-#define STA_REC_HE_CAP_GT_80M_TX_STBC		BIT(11)
-#define STA_REC_HE_CAP_GT_80M_RX_STBC		BIT(12)
-/* GI */
-#define STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI	BIT(13)
-#define STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI	BIT(14)
-#define STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI	BIT(15)
-#define STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI	BIT(16)
-#define STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI	BIT(17)
-/* 242 TONE */
-#define STA_REC_HE_CAP_BW20_RU242_SUPPORT	BIT(18)
-#define STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242	BIT(19)
-#define STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242	BIT(20)
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c6c846d1900b..d2fbe52772c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -285,20 +285,6 @@ struct mt7915_dev {
 	} twt;
 };
 
-enum {
-	HW_BSSID_0 = 0x0,
-	HW_BSSID_1,
-	HW_BSSID_2,
-	HW_BSSID_3,
-	HW_BSSID_MAX = HW_BSSID_3,
-	EXT_BSSID_START = 0x10,
-	EXT_BSSID_1,
-	EXT_BSSID_15 = 0x1f,
-	EXT_BSSID_MAX = EXT_BSSID_15,
-	REPEATER_BSSID_START = 0x20,
-	REPEATER_BSSID_MAX = 0x3f,
-};
-
 enum {
 	MT_CTX0,
 	MT_HIF0 = 0x0,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 821af6e8d99a..0436e7015634 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -76,21 +76,6 @@ struct mt7921_uni_txd {
 	u8 reserved2[4];
 } __packed __aligned(4);
 
-/* event table */
-enum {
-	MCU_EVENT_REG_ACCESS = 0x05,
-	MCU_EVENT_LP_INFO = 0x07,
-	MCU_EVENT_SCAN_DONE = 0x0d,
-	MCU_EVENT_TX_DONE = 0x0f,
-	MCU_EVENT_BSS_ABSENCE  = 0x11,
-	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
-	MCU_EVENT_CH_PRIVILEGE = 0x18,
-	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
-	MCU_EVENT_DBG_MSG = 0x27,
-	MCU_EVENT_TXPWR = 0xd0,
-	MCU_EVENT_COREDUMP = 0xf0,
-};
-
 struct mt7921_mcu_tx_done_event {
 	u8 pid;
 	u8 status;
@@ -153,130 +138,17 @@ struct mt7921_mcu_eeprom_info {
 #define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
 #define MCU_PKT_ID			0xa0
 
-enum {
-	MCU_Q_QUERY,
-	MCU_Q_SET,
-	MCU_Q_RESERVED,
-	MCU_Q_NA
-};
-
-enum {
-	MCU_S2D_H2N,
-	MCU_S2D_C2N,
-	MCU_S2D_H2C,
-	MCU_S2D_H2CN
-};
-
 struct mt7921_mcu_uni_event {
 	u8 cid;
 	u8 pad[3];
 	__le32 status; /* 0: success, others: fail */
 } __packed;
 
-enum {
-	PATCH_NOT_DL_SEM_FAIL,
-	PATCH_IS_DL,
-	PATCH_NOT_DL_SEM_SUCCESS,
-	PATCH_REL_SEM_SUCCESS
-};
-
-enum {
-	FW_STATE_INITIAL,
-	FW_STATE_FW_DOWNLOAD,
-	FW_STATE_NORMAL_OPERATION,
-	FW_STATE_NORMAL_TRX,
-	FW_STATE_WACPU_RDY        = 7
-};
-
-enum {
-	EE_MODE_EFUSE,
-	EE_MODE_BUFFER,
-};
-
-enum {
-	EE_FORMAT_BIN,
-	EE_FORMAT_WHOLE,
-	EE_FORMAT_MULTIPLE,
-};
-
-enum {
-	MCU_PHY_STATE_TX_RATE,
-	MCU_PHY_STATE_RX_RATE,
-	MCU_PHY_STATE_RSSI,
-	MCU_PHY_STATE_CONTENTION_RX_RATE,
-	MCU_PHY_STATE_OFDMLQ_CNINFO,
-};
-
-struct sec_key {
-	u8 cipher_id;
-	u8 cipher_len;
-	u8 key_id;
-	u8 key_len;
-	u8 key[32];
-} __packed;
-
-struct sta_rec_sec {
-	__le16 tag;
-	__le16 len;
-	u8 add;
-	u8 n_cipher;
-	u8 rsv[2];
-
-	struct sec_key key[2];
-} __packed;
-
-enum mcu_cipher_type {
-	MCU_CIPHER_NONE = 0,
-	MCU_CIPHER_WEP40,
-	MCU_CIPHER_WEP104,
-	MCU_CIPHER_WEP128,
-	MCU_CIPHER_TKIP,
-	MCU_CIPHER_AES_CCMP,
-	MCU_CIPHER_CCMP_256,
-	MCU_CIPHER_GCMP,
-	MCU_CIPHER_GCMP_256,
-	MCU_CIPHER_WAPI,
-	MCU_CIPHER_BIP_CMAC_128,
-};
-
-enum {
-	CH_SWITCH_NORMAL = 0,
-	CH_SWITCH_SCAN = 3,
-	CH_SWITCH_MCC = 4,
-	CH_SWITCH_DFS = 5,
-	CH_SWITCH_BACKGROUND_SCAN_START = 6,
-	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
-	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
-	CH_SWITCH_SCAN_BYPASS_DPD = 9
-};
-
-enum {
-	THERMAL_SENSOR_TEMP_QUERY,
-	THERMAL_SENSOR_MANUAL_CTRL,
-	THERMAL_SENSOR_INFO_QUERY,
-	THERMAL_SENSOR_TASK_CTRL,
-};
-
 enum {
 	MT_EBF = BIT(0),	/* explicit beamforming */
 	MT_IBF = BIT(1)		/* implicit beamforming */
 };
 
-#define STA_CAP_WMM			BIT(0)
-#define STA_CAP_SGI_20			BIT(4)
-#define STA_CAP_SGI_40			BIT(5)
-#define STA_CAP_TX_STBC			BIT(6)
-#define STA_CAP_RX_STBC			BIT(7)
-#define STA_CAP_VHT_SGI_80		BIT(16)
-#define STA_CAP_VHT_SGI_160		BIT(17)
-#define STA_CAP_VHT_TX_STBC		BIT(18)
-#define STA_CAP_VHT_RX_STBC		BIT(19)
-#define STA_CAP_VHT_LDPC		BIT(23)
-#define STA_CAP_LDPC			BIT(24)
-#define STA_CAP_HT			BIT(26)
-#define STA_CAP_VHT			BIT(27)
-#define STA_CAP_HE			BIT(28)
-
 struct mt7921_mcu_reg_event {
 	__le32 reg;
 	__le32 val;
-- 
2.31.1

