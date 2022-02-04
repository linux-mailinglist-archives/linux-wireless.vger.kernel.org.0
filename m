Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE24AA2BA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbiBDWDF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245257AbiBDWDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F5BC061741
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M6UKLtFxeMqdiBqhOdN00DTRssXWrdNf6QwQ7hhMpXg=;
        t=1644012182; x=1645221782; b=O/r7RmJM2h6wCfEbGI/vTocHNif1OKhtBWlWTs/4lz0Ctkl
        2j4Oh0CXT+xQ7kwi8qEYMqSgftI17KzUOQ2HsbxHhN+wc5iZ9gz52ih9iZ1u7R4IU5jipR+zA8D4E
        zxIwibg/d3ffnx9RePRUMf4B4fL/W2Pw5yg5W4w1zkXgA9aISnQC8t9T8eS5UBoUAf5Danyvrm0IV
        QgrA5u9m4tR/jMJTWqSlVHStsziRXC3VjJslwgdEMsGY2h4Ox0ig6XwENmMURVSxGESlydXd9DaO3
        0ebUBDE6vl3x8i0PczgbOUIYhAwiqLXZCvUakvf+5xxkFhL6YD7ZMmyyG7fscRkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fU-00EeJL-Tg;
        Fri, 04 Feb 2022 23:03:01 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 04/19] ieee80211: Add EHT (802.11be) definitions
Date:   Fri,  4 Feb 2022 23:02:40 +0100
Message-Id: <20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Based on Draft P802.11be_D1.3.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 270 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 60ee7b3f58e7..25137f2b6f35 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
+#include <linux/bitfield.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1925,6 +1926,135 @@ struct ieee80211_mu_edca_param_set {
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
+ *     supported for transmission for MCS 8 - 9.
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
+ * struct ieee80211_eht_mcs_nss_supp - EHT max supported NSS per MCS
+ *
+ * @only_20mhz: For a 20 MHz-only STA, indicates the maximum number of spatial
+ *     streams supported for reception and the maximum number of spatial streams
+ *     supported for transmission, for each MCS value. Optionally present in
+ *     &struct ieee80211_eht_cap_elem.
+ * @bw_80: If the operating channel width of the STA is greater than or equal to
+ *     80 MHz, indicates the maximum number of spatial streams supported for
+ *     reception and the maximum number of spatial streams supported for
+ *     transmission, for each MCS value, in a PPDU with a bandwidth of 20, 40, or
+ *     80 MHz. Optionally present in &struct ieee80211_eht_cap_elem.
+ * @bw_160: If the operating channel width of the STA is greater than or equal to
+ *     160 MHz, indicates the maximum number of spatial streams supported for
+ *     reception and the maximum number of spatial streams supported for
+ *     transmission, for each MCS value, in a PPDU with a bandwidth of 160 MHz.
+ *     Optionally present in &struct ieee80211_eht_cap_elem.
+ * @bw_320: If the operating channel width of the STA is greater than or equal to
+ *     320 MHz, indicates the maximum number of spatial streams supported for
+ *     reception and the maximum number of spatial streams supported for
+ *     transmission, for each MCS value, in a PPDU with a bandwidth of 320 MHz.
+ *     Optionally present in &struct ieee80211_eht_cap_elem.
+ */
+struct ieee80211_eht_mcs_nss_supp {
+	struct ieee80211_eht_mcs_nss_supp_20mhz_only only_20mhz;
+	struct ieee80211_eht_mcs_nss_supp_bw bw_80;
+	struct ieee80211_eht_mcs_nss_supp_bw bw_160;
+	struct ieee80211_eht_mcs_nss_supp_bw bw_320;
+};
+
+/**
+ * struct ieee80211_eht_cap_elem_fixed - EHT capabilities fixed data
+ *
+ * This structure is the "EHT capabilities element" fixed fields as
+ * described in P802.11be_D1.0 section 9.4.2.295a
+ *
+ * @mac_cap_info: MAC capabilities
+ * @phy_cap_info: PHY capabilities
+ */
+struct ieee80211_eht_cap_elem_fixed {
+	u8 mac_cap_info[2];
+	u8 phy_cap_info[8];
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
+	 * Supported EHT-MCS And NSS Set field: 0, 3, 6, 9, or 12 octets.
+	 * EHT PPE Thresholds field: variable length.
+	 */
+	u8 optional[];
+} __packed;
+
+/**
+ * struct ieee80211_eht_operation - eht operation element
+ *
+ * This structure is the "eht operation element" fields as
+ * described in P802.11be_D1.0 section 9.4.2.295c
+ *
+ * TODO: the actual layout of the EHT operation element is not clearly defined
+ * in the specification. For now assume the below layout.
+ */
+struct ieee80211_eht_operation {
+	u8 chan_width;
+	u8 ccfs;
+} __packed;
+
 /* 802.11ac VHT Capabilities */
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
@@ -2129,6 +2259,8 @@ enum ieee80211_client_reg_power {
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G	0x04
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G		0x08
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G	0x10
+#define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL		0x1e
+
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G	0x20
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G	0x40
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK			0xfe
@@ -2599,6 +2731,141 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
 #define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
 
+/* EHT MAC capabilities as defined in P802.11be_D1.0 section 9.4.2.295c */
+#define IEEE80211_EHT_MAC_CAP0_NSEP_PRIO_ACCESS_SUPP  0x01
+#define IEEE80211_EHT_MAC_CAP0_OM_CONTROL_SUPP        0x02
+#define IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_SUPP 0x04
+#define IEEE80211_EHT_MAC_CAP0_ARR_CONTROL_SUPP       0x08
+
+/* EHT PHY capabilities as defined in P802.11be_D1.0 section 9.4.2.295c */
+#define IEEE80211_EHT_PHY_CAP0_RSERVED                0x01
+#define IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ         0x02
+#define IEEE80211_EHT_PHY_CAP0_242_TONE_RU            0x04
+#define IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI    0x08
+#define IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO  0x10
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER          0x20
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE          0x40
+
+/* EHT beamformee SU number of spatial streams <= 80MHz is split between octet 0
+ * and octet 1
+ */
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE_SS_80MHZ  0x80
+
+#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_80MHZ  0x03
+#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_160MHZ 0x1c
+#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_320MHZ 0xe0
+
+#define IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ      0x07
+#define IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ     0x38
+
+/* EHT number of sounding dimensions for 320MHz is split between octet 2
+ * and octet 3
+ */
+#define IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ     0xc0
+
+#define IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ         0x01
+#define IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK           0x02
+#define IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK           0x04
+#define IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FEEDBACK    0x08
+#define IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FEEDBACK    0x10
+#define IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FEEDBACK         0x20
+#define IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FEEDBACK 0x40
+#define IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FEEDBACK           0x80
+
+#define IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO          0x01
+#define IEEE80211_EHT_PHY_CAP4_PSR_SR_SUPP                 0x02
+#define IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP       0x04
+#define IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI 0x08
+#define IEEE80211_EHT_PHY_CAP4_MAX_NC                      0xf0
+
+#define IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK       0x01
+#define IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP    0x02
+#define IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP    0x04
+#define IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT       0x08
+#define IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL              0x30
+
+/* Maximum number of supported EHT LTF is split between octet 5
+ * and octet 6
+ */
+#define IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF        0xc0
+
+#define IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF        0x03
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP                  0x7c
+#define IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP           0x80
+
+#define IEEE80211_EHT_PHY_CAP7_20MHZ_STA_RX_NDP_WIDER_BW   0x01
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ  0x02
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ 0x04
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ 0x08
+#define IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ         0x10
+#define IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ        0x20
+#define IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ        0x40
+#define IEEE80211_EHT_PHY_CAP7_RESERVED                    0x80
+
+/*
+ * EHT operation channel width as defined in P802.11be_D1.0 section 9.4.2.295a
+ */
+#define IEEE80211_EHT_OPER_CHAN_WIDTH        0x7
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ  0
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ  1
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ  2
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ 3
+#define IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ 4
+
+/* Calculate 802.11be EHT capabilities IE Tx/Rx EHT MCS NSS Support Field size */
+static inline u8
+ieee80211_eht_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap,
+			   const struct ieee80211_eht_cap_elem_fixed *eht_cap)
+{
+	u8 count = 0;
+
+	if (!(he_cap->phy_cap_info[0] &
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL))
+		return 4;
+
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
+	return count;
+}
+
+/* 802.11be EHT PPE Thresholds */
+#define IEEE80211_EHT_PPE_THRES_NSS_POS               0
+#define IEEE80211_EHT_PPE_THRES_NSS_MASK              0xf
+#define IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK 0x1f0
+#define IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE	      3
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
+	n = hweight8(ppe_thres_hdr &
+		     IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+	n *= 1 + u16_get_bits(ppe_thres_hdr, IEEE80211_EHT_PPE_THRES_NSS_MASK);
+
+	/*
+	 * Each pair is 6 bits, and we need to add the 9 "header" bits to the
+	 * total size.
+	 */
+	n = n * IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2 + 9;
+	return DIV_ROUND_UP(n, 8);
+}
 
 #define LISTEN_INT_USF	GENMASK(15, 14)
 #define LISTEN_INT_UI	GENMASK(13, 0)
@@ -3054,6 +3321,9 @@ enum ieee80211_eid_ext {
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

