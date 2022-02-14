Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05E4B562F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356390AbiBNQaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356380AbiBNQaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497D260D86
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1J9TTp6X+7ZS+ZORXI6NSBSYkVaifJimV34Hm3CRfTc=;
        t=1644856211; x=1646065811; b=kzKPPdiWiMY6O7SL9us74abVHhRsNLN+A+1UZ+p6TWg9tNx
        dpjKtJfjlX2mhCHETKY7ZMRHb3j1av1QO6619hWm3sx7ROkIVuntZ0DUyaKpjzUdjEgzO3l4QWCGT
        vMDPsXKGTXpJVKo1zKxSMV5PlUAvjz5iE2HQg/V2jNytg3tbMTR6TcToIQCvl1FKWpCRllNqiGWsh
        893zLG2fGB45CspcY56/aL1kWEvuUU8CSbHd5/ibWtpw/I3aIjtQN1Z3IYduvNxjDc/8xL/zdPGjd
        YAiq90PE+PbgAhyCXrM2Y5qBCKZ6JR7wjZL8ZsxRJdBQzDee+GHvdrbCT1ddWhaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEr-0011mw-B8;
        Mon, 14 Feb 2022 17:30:09 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 04/19] ieee80211: Add EHT (802.11be) definitions
Date:   Mon, 14 Feb 2022 17:29:51 +0100
Message-Id: <20220214173004.928e23cacb2b.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Based on Draft P802.11be_D1.4.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 299 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index dfc84680af82..7204bc28ca31 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
+#include <linux/bitfield.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1925,6 +1926,111 @@ struct ieee80211_mu_edca_param_set {
 	struct ieee80211_he_mu_edca_param_ac_rec ac_vo;
 } __packed;
 
+#define IEEE80211_EHT_MCS_NSS_RX 0x0f
+#define IEEE80211_EHT_MCS_NSS_TX 0xf0
+
+/**
+ * struct ieee80211_eht_mcs_nss_supp_20mhz_only - EHT 20MHz only station max
+ * supported NSS for per MCS.
+ *
+ * For each field below, bits 0 - 3 indicate the maximal number of spatial
+ * streams for Rx, and bits 4 - 7 indicate the maximal number of spatial streams
+ * for Tx.
+ *
+ * @rx_tx_mcs7_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 0 - 7.
+ * @rx_tx_mcs9_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 8 - 9.
+ * @rx_tx_mcs11_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 10 - 11.
+ * @rx_tx_mcs13_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 12 - 13.
+ */
+struct ieee80211_eht_mcs_nss_supp_20mhz_only {
+	u8 rx_tx_mcs7_max_nss;
+	u8 rx_tx_mcs9_max_nss;
+	u8 rx_tx_mcs11_max_nss;
+	u8 rx_tx_mcs13_max_nss;
+};
+
+/**
+ * struct ieee80211_eht_mcs_nss_supp_bw - EHT max supported NSS per MCS (except
+ * 20MHz only stations).
+ *
+ * For each field below, bits 0 - 3 indicate the maximal number of spatial
+ * streams for Rx, and bits 4 - 7 indicate the maximal number of spatial streams
+ * for Tx.
+ *
+ * @rx_tx_mcs9_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 0 - 9.
+ * @rx_tx_mcs11_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 10 - 11.
+ * @rx_tx_mcs13_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 12 - 13.
+ */
+struct ieee80211_eht_mcs_nss_supp_bw {
+	u8 rx_tx_mcs9_max_nss;
+	u8 rx_tx_mcs11_max_nss;
+	u8 rx_tx_mcs13_max_nss;
+};
+
+/**
+ * struct ieee80211_eht_cap_elem_fixed - EHT capabilities fixed data
+ *
+ * This structure is the "EHT Capabilities element" fixed fields as
+ * described in P802.11be_D1.4 section 9.4.2.313.
+ *
+ * @mac_cap_info: MAC capabilities, see IEEE80211_EHT_MAC_CAP*
+ * @phy_cap_info: PHY capabilities, see IEEE80211_EHT_PHY_CAP*
+ */
+struct ieee80211_eht_cap_elem_fixed {
+	u8 mac_cap_info[2];
+	u8 phy_cap_info[9];
+} __packed;
+
+/**
+ * struct ieee80211_eht_cap_elem - EHT capabilities element
+ * @fixed: fixed parts, see &ieee80211_eht_cap_elem_fixed
+ * @optional: optional parts
+ */
+struct ieee80211_eht_cap_elem {
+	struct ieee80211_eht_cap_elem_fixed fixed;
+
+	/*
+	 * Followed by:
+	 * Supported EHT-MCS And NSS Set field: 4, 3, 6 or 9 octets.
+	 * EHT PPE Thresholds field: variable length.
+	 */
+	u8 optional[];
+} __packed;
+
+/**
+ * struct ieee80211_eht_operation - eht operation element
+ *
+ * This structure is the "EHT Operation Element" fields as
+ * described in P802.11be_D1.4 section 9.4.2.311
+ *
+ * FIXME: The spec is unclear how big the fields are, and doesn't
+ *	  indicate the "Disabled Subchannel Bitmap Present" in the
+ *	  structure (Figure 9-1002a) at all ...
+ */
+struct ieee80211_eht_operation {
+	u8 chan_width;
+	u8 ccfs;
+	u8 present_bm;
+
+	u8 disable_subchannel_bitmap[];
+} __packed;
+
+#define IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT	0x1
+
 /* 802.11ac VHT Capabilities */
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
@@ -2129,6 +2235,8 @@ enum ieee80211_client_reg_power {
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G	0x04
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G		0x08
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G	0x10
+#define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL		0x1e
+
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G	0x20
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G	0x40
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK			0xfe
@@ -2622,6 +2730,194 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
 #define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
 
+/* EHT MAC capabilities as defined in P802.11be_D1.4 section 9.4.2.313.2 */
+#define IEEE80211_EHT_MAC_CAP0_NSEP_PRIO_ACCESS			0x01
+#define IEEE80211_EHT_MAC_CAP0_OM_CONTROL			0x02
+#define IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1		0x04
+#define IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2		0x08
+#define IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT			0x10
+#define IEEE80211_EHT_MAC_CAP0_SCS_TRAFFIC_DESC			0x20
+#define IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_MASK		0xc0
+#define		IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_3895	0
+#define		IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_7991	1
+#define		IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_11454	2
+
+/* EHT PHY capabilities as defined in P802.11be_D1.4 section 9.4.2.313.3 */
+#define IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ			0x02
+#define IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ		0x04
+#define IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI		0x08
+#define IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO		0x10
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER			0x20
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE			0x40
+
+/* EHT beamformee number of spatial streams <= 80MHz is split */
+#define IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK		0x80
+#define IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK		0x03
+
+#define IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK	0x1c
+#define IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK	0xe0
+
+#define IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK		0x07
+#define IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK		0x38
+
+/* EHT number of sounding dimensions for 320MHz is split */
+#define IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK		0xc0
+#define IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK		0x01
+#define IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK		0x02
+#define IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK		0x04
+#define IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK		0x08
+#define IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK		0x10
+#define IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK			0x20
+#define IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK		0x40
+#define IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK			0x80
+
+#define IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO		0x01
+#define IEEE80211_EHT_PHY_CAP4_PSR_SR_SUPP			0x02
+#define IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP		0x04
+#define IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI	0x08
+#define IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK			0xf0
+
+#define IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK		0x01
+#define IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP		0x02
+#define IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP		0x04
+#define IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT		0x08
+#define IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK	0x30
+#define   IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_0US	0
+#define   IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US	1
+#define   IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US	2
+#define   IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US	3
+
+/* Maximum number of supported EHT LTF is split */
+#define IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK	0xc0
+#define IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK	0x07
+
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK			0x78
+#define IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP		0x80
+
+#define IEEE80211_EHT_PHY_CAP7_20MHZ_STA_RX_NDP_WIDER_BW	0x01
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ	0x02
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ	0x04
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ	0x08
+#define IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ		0x10
+#define IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ		0x20
+#define IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ		0x40
+#define IEEE80211_EHT_PHY_CAP7_TB_SOUNDING_FDBK_RATE_LIMIT	0x80
+
+#define IEEE80211_EHT_PHY_CAP8_RX_1024QAM_WIDER_BW_DL_OFDMA	0x01
+#define IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA	0x02
+
+/*
+ * EHT operation channel width as defined in P802.11be_D1.4 section 9.4.2.311
+ */
+#define IEEE80211_EHT_OPER_CHAN_WIDTH		0x7
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ	0
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ	1
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ	2
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ	3
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ	4
+
+/* Calculate 802.11be EHT capabilities IE Tx/Rx EHT MCS NSS Support Field size */
+static inline u8
+ieee80211_eht_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap,
+			   const struct ieee80211_eht_cap_elem_fixed *eht_cap)
+{
+	u8 count = 0;
+
+	/* on 2.4 GHz, if it supports 40 MHz, the result is 3 */
+	if (he_cap->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
+		return 3;
+
+	/* on 2.4 GHz, these three bits are reserved, so should be 0 */
+	if (he_cap->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
+		count += 3;
+
+	if (he_cap->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+		count += 3;
+
+	if (eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+		count += 3;
+
+	return count ? count : 4;
+}
+
+/* 802.11be EHT PPE Thresholds */
+#define IEEE80211_EHT_PPE_THRES_NSS_POS			0
+#define IEEE80211_EHT_PPE_THRES_NSS_MASK		0xf
+#define IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK	0x1f0
+#define IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE		3
+#define IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE	9
+
+/*
+ * Calculate 802.11be EHT capabilities IE EHT field size
+ */
+static inline u8
+ieee80211_eht_ppe_size(u16 ppe_thres_hdr, const u8 *phy_cap_info)
+{
+	u32 n;
+
+	if (!(phy_cap_info[5] &
+	      IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT))
+		return 0;
+
+	n = hweight16(ppe_thres_hdr &
+		      IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+	n *= 1 + u16_get_bits(ppe_thres_hdr, IEEE80211_EHT_PPE_THRES_NSS_MASK);
+
+	/*
+	 * Each pair is 6 bits, and we need to add the 9 "header" bits to the
+	 * total size.
+	 */
+	n = n * IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2 +
+	    IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+	return DIV_ROUND_UP(n, 8);
+}
+
+static inline bool
+ieee80211_eht_capa_size_ok(const u8 *he_capa, const u8 *data, u8 len)
+{
+	const struct ieee80211_eht_cap_elem_fixed *elem = (const void *)data;
+	u8 needed = sizeof(struct ieee80211_eht_cap_elem_fixed);
+
+	if (len < needed || !he_capa)
+		return false;
+
+	needed += ieee80211_eht_mcs_nss_size((const void *)he_capa,
+					     (const void *)data);
+	if (len < needed)
+		return false;
+
+	if (elem->phy_cap_info[5] &
+			IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
+		u16 ppe_thres_hdr;
+
+		if (len < needed + sizeof(ppe_thres_hdr))
+			return false;
+
+		ppe_thres_hdr = get_unaligned_le16(data + needed);
+		needed += ieee80211_eht_ppe_size(ppe_thres_hdr,
+						 elem->phy_cap_info);
+	}
+
+	return len >= needed;
+}
+
+static inline bool
+ieee80211_eht_oper_size_ok(const u8 *data, u8 len)
+{
+	const struct ieee80211_eht_operation *elem = (const void *)data;
+	u8 needed = sizeof(*elem);
+
+	if (len < needed)
+		return false;
+
+	if (elem->present_bm & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)
+		needed += 2;
+
+	return len >= needed;
+}
 
 #define LISTEN_INT_USF	GENMASK(15, 14)
 #define LISTEN_INT_UI	GENMASK(13, 0)
@@ -3077,6 +3373,9 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_SHORT_SSID_LIST = 58,
 	WLAN_EID_EXT_HE_6GHZ_CAPA = 59,
 	WLAN_EID_EXT_UL_MU_POWER_CAPA = 60,
+	WLAN_EID_EXT_EHT_OPERATION = 106,
+	WLAN_EID_EXT_EHT_MULTI_LINK = 107,
+	WLAN_EID_EXT_EHT_CAPABILITY = 108,
 };
 
 /* Action category code */
-- 
2.34.1

