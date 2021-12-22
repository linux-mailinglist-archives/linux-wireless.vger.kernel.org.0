Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D267047CEBA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhLVJFl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:41 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34949 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232940AbhLVJFl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163941; x=1671699941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6Ac0fZOO9O4g/H/0IDOlMuzuRMio8rh8lqeE+uCSvBk=;
  b=dlhPcI+NrvGer+HE+uBrkYKL+I7pI99DeBqhFodndIwsyBFGPblRMzw2
   ua8kor+O/YTn49DXAfdU5/CVAflG9aX2kuReUaVZ3IBMwE0KwdGCGz+2V
   gIzZpQhBD4td68znXM6XL2+NAMhf7mH+fGG5witDZV1qbquWH/ZO3nTDe
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Dec 2021 01:05:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:40 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:36 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 1/6] ieee80211: add EHT capabilities element definitions
Date:   Wed, 22 Dec 2021 14:34:38 +0530
Message-ID: <1640163883-12696-2-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vikram Kandukuri <quic_vikram@quicinc.com>

Add definitions from P802.11be_D1.3, Section 9.4.2.313 EHT Capabilities
element and related helper functions.

Signed-off-by: Vikram Kandukuri <quic_vikram@quicinc.com>
Co-authored-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-authored-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/linux/ieee80211.h | 702 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 702 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c6..5137e7d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -20,6 +20,7 @@
 #include <linux/etherdevice.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
+#include <linux/bitfield.h>
 
 /*
  * DS bit usage
@@ -2606,6 +2607,706 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define IEEE80211_MAX_USF	FIELD_MAX(LISTEN_INT_USF)
 #define IEEE80211_MAX_UI	FIELD_MAX(LISTEN_INT_UI)
 
+/**
+ * struct ieee80211_eht_cap_elem - EHT capabilities element
+ *
+ * @mac_cap_info: EHT MAC Capabilities Information
+ * @phy_cap_info: EHT PHY Capabilities Information
+ *
+ * This structure represents the "EHT capabilities element" fixed fields as
+ * described in P802.11be_D1.3 section 9.4.2.313.2 and 9.4.2.313.3.
+ */
+struct ieee80211_eht_cap_elem {
+	u8 mac_cap_info[2];
+	u8 phy_cap_info[8];
+} __packed;
+
+/* 802.11be EHT MAC capabilities from P802.11be_D1.3, section 9.4.2.313.2 */
+#define IEEE80211_EHT_MAC_CAP0_NSEP_PRIORITY_ACCESS	BIT(0)
+#define IEEE80211_EHT_MAC_CAP0_EHT_OM_CONTROL		BIT(1)
+#define IEEE80211_EHT_MAC_CAP0_TXOP_SHARING_MODE1	BIT(2)
+#define IEEE80211_EHT_MAC_CAP0_TXOP_SHARING_MODE2	BIT(3)
+#define IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT		BIT(4)
+#define IEEE80211_EHT_MAC_CAP0_SCS_TRAFFIC_DESC		BIT(5)
+
+#define IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN		GENMASK(7, 6)
+
+/**
+ * enum ieee80211_eht_max_mpdu_len - maximum MPDU length that STA is capable of
+ *	receiving
+ * @EHT_MAX_MPDU_LEN_3895: maximum 3895 octets supported
+ * @EHT_MAX_MPDU_LEN_7991: maximum 7991 octets supported
+ * @EHT_MAX_MPDU_LEN_11454: maximum 11454 octets supported
+ */
+enum ieee80211_eht_max_mpdu_len {
+	EHT_MAX_MPDU_LEN_3895 = 0,
+	EHT_MAX_MPDU_LEN_7991,
+	EHT_MAX_MPDU_LEN_11454,
+};
+
+/**
+ * ieee80211_eht_set_max_mpdu_len - set maximum MPDU length that STA is capable
+ *	of receiving
+ *
+ * @mac_cap_info: EHT MAC capabilities information field data
+ * @max_len: maximum MPDU length supported, see &enum ieee80211_eht_max_mpdu_len
+ *
+ * Set "Maximum MPDU Length" subfield as encoded in "EHT MAC Capabilities
+ * Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_max_mpdu_len(u8 *mac_cap_info,
+			       enum ieee80211_eht_max_mpdu_len max_len)
+{
+	mac_cap_info[0] |= FIELD_PREP(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN,
+				      max_len);
+}
+
+/**
+ * ieee80211_eht_get_max_mpdu_len - get maximum MPDU length that STA is capable
+ *	of receiving
+ *
+ * @mac_cap_info: EHT MAC capabilities information field data
+ *
+ * Get "Maximum MPDU Length" subfield value from "EHT MAC Capabilities
+ * Information" field in EHT Capabilities element
+ *
+ * Return: maximum MPDU length supported, see &enum ieee80211_eht_max_mpdu_len
+ */
+static inline enum ieee80211_eht_max_mpdu_len
+ieee80211_eht_get_max_mpdu_len(const u8 *mac_cap_info)
+{
+	return FIELD_GET(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN, mac_cap_info[0]);
+}
+
+/* 802.11be EHT PHY capabilities from P802.11be_D1.3, section 9.4.2.313.3 */
+#define IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ				BIT(1)
+#define IEEE80211_EHT_PHY_CAP0_NON_AP_20MHZ_ONLY_STA_242_RU_SUPPORT	BIT(2)
+#define IEEE80211_EHT_PHY_CAP0_NDP_4x_LTF_AND_3_2US			BIT(3)
+#define IEEE80211_EHT_PHY_CAP0_PARTIAL_BANDWIDTH_UL_MUMIMO		BIT(4)
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER				BIT(5)
+#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE				BIT(6)
+
+/* Beamformee SS for under 80MHz is split between byte #1 and byte #2 */
+#define IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_MAX_STS_UPTO_80MHZ	GENMASK(7, 7)
+#define IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_UPTO_80MHZ	GENMASK(1, 0)
+#define IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_160MHZ	GENMASK(4, 2)
+#define IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_320MHZ	GENMASK(7, 5)
+
+#define IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_UPTO_80MHZ	\
+	GENMASK(2, 0)
+#define IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_160MHZ	GENMASK(5, 3)
+
+/*
+ * Number of sounding dimensions supported for 320MHz is split
+ * between byte #2 and byte #3
+ */
+#define IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_320MHZ	GENMASK(7, 6)
+#define IEEE80211_EHT_PHY_CAP3_BEAMFORMER_NUM_SND_DIM_320MHZ	GENMASK(0, 0)
+
+#define IEEE80211_EHT_PHY_CAP3_NG16_SU_FEEDBACK			BIT(1)
+#define IEEE80211_EHT_PHY_CAP3_NG16_MU_FEEDBACK			BIT(2)
+
+#define IEEE80211_EHT_PHY_CAP3_CODEBOOK_SIZE_42_SU		BIT(3)
+#define IEEE80211_EHT_PHY_CAP3_CODEBOOK_SIZE_75_MU		BIT(4)
+
+#define IEEE80211_EHT_PHY_CAP3_TRIG_SU_BEAMFORMER_FB		BIT(5)
+#define IEEE80211_EHT_PHY_CAP3_TRIG_MU_BEAMFORMER_FB		BIT(6)
+#define IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FB			BIT(7)
+
+#define IEEE80211_EHT_PHY_CAP4_PARTIAL_BANDWIDTH_DL_MUMIMO	BIT(0)
+#define IEEE80211_EHT_PHY_CAP4_PSR_BASED_SR			BIT(1)
+#define IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACTOR_AR		BIT(2)
+#define IEEE80211_EHT_PHY_CAP4_MU_PPDU_4XLTF_AND_08_US_GI	BIT(3)
+
+#define IEEE80211_EHT_PHY_CAP4_MAX_NC				GENMASK(7, 4)
+
+#define IEEE80211_EHT_PHY_CAP5_NON_TRIGGERED_CQI_FEEDBACK		BIT(0)
+#define IEEE80211_EHT_PHY_CAP5_TX_1024_4096_QAM_LESS_THAN_242_TONE_RU	BIT(1)
+#define IEEE80211_EHT_PHY_CAP5_RX_1024_4096_QAM_LESS_THAN_242_TONE_RU	BIT(2)
+#define IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT			BIT(3)
+
+#define IEEE80211_EHT_PHY_CAP5_NOMINAL_PKT_PADDING	GENMASK(5, 4)
+
+/* Maximum Number Of Supported EHT-LTFs is split between byte 5 and byte 6 */
+#define IEEE80211_EHT_PHY_CAP5_MAX_EHT_LTF_SUPP			BIT(6)
+#define IEEE80211_EHT_PHY_CAP5_MAX_EHT_LTF_SUPP_SU		GENMASK(7, 7)
+#define IEEE80211_EHT_PHY_CAP6_MAX_EHT_LTF_SUPP_SU_RESERVED	GENMASK(0, 0)
+#define IEEE80211_EHT_PHY_CAP6_MAX_EHT_LTF_SUPP_MU		GENMASK(2, 1)
+
+#define IEEE80211_EHT_PHY_CAP6_MCS15_52_26_TONE_106_26_TONE_SUPP	BIT(3)
+#define IEEE80211_EHT_PHY_CAP6_MCS15_484_242_TONE_80MHZ_SUPP		BIT(4)
+#define IEEE80211_EHT_PHY_CAP6_MCS15_996_484_TONE_160MHZ_SUPP		BIT(5)
+#define IEEE80211_EHT_PHY_CAP6_MCS15_3X996_TONE_320MHZ_SUPP		BIT(6)
+#define IEEE80211_EHT_PHY_CAP6_EHT_DUP_SUPP_6GHZ			BIT(7)
+
+#define IEEE80211_EHT_PHY_CAP7_20MHZ_STA_NDP_WIDE_BW_SUPP		BIT(0)
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_UNDER_80MHZ		BIT(1)
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ		BIT(2)
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ		BIT(3)
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_MU_BEAMFORMER_UNDER_80MHZ	BIT(4)
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_MU_BEAMFORMER_160MHZ		BIT(5)
+#define IEEE80211_EHT_PHY_CAP7_NON_OFDMA_MU_BEAMFORMER_320MHZ		BIT(6)
+#define IEEE80211_EHT_PHY_CAP7_TB_SND_FB_RATE_LIMIT			BIT(7)
+
+/**
+ * enum ieee80211_eht_beamformee_max_sts - maximum number of spatial streams
+ *	that the STA is capable of receiving in an EHT sounding NDP. Minimal
+ *	allowed spatial streams is 4.
+ * @EHT_BEAMFORMEE_MAX_STS_4: 4 spatial streams supported
+ * @EHT_BEAMFORMEE_MAX_STS_5: 5 spatial streams supported
+ * @EHT_BEAMFORMEE_MAX_STS_6: 6 spatial streams supported
+ * @EHT_BEAMFORMEE_MAX_STS_7: 7 spatial streams supported
+ * @EHT_BEAMFORMEE_MAX_STS_8: 8 spatial streams supported
+ */
+enum ieee80211_eht_beamformee_max_sts {
+	EHT_BEAMFORMEE_MAX_STS_4 = 3,
+	EHT_BEAMFORMEE_MAX_STS_5 = 4,
+	EHT_BEAMFORMEE_MAX_STS_6 = 5,
+	EHT_BEAMFORMEE_MAX_STS_7 = 6,
+	EHT_BEAMFORMEE_MAX_STS_8 = 7,
+};
+
+/**
+ * ieee80211_eht_beamformee_set_max_sts_upto_80mhz - set maximum number of
+ *	spatial streams that the STA is capable of receiving in an EHT sounding
+ *	NDP for bandwidths upto 80 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @max_sts: maximum number of spatial streams supported, see &enum
+ *	ieee80211_eht_beamformee_max_sts
+ *
+ * Set "Beamformee SS upto 80 MHz" subfield as encoded in "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_beamformee_set_max_sts_upto_80mhz(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_beamformee_max_sts max_sts)
+{
+	phy_cap_info[0] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_MAX_STS_UPTO_80MHZ,
+		   max_sts);
+
+	phy_cap_info[1] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_UPTO_80MHZ,
+		   max_sts >> 1);
+}
+
+/**
+ * ieee80211_eht_beamformee_get_max_sts_upto_80mhz - get maximum number of
+ *	spatial streams that the STA is capable of receiving in an EHT sounding
+ *	NDP for bandwidths upto 80 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Beamformee SS upto 80 MHz" subfield value from "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ *
+ * Return: maximum number of spatial streams supported, see &enum
+ *	ieee80211_eht_beamformee_max_sts
+ */
+static inline enum ieee80211_eht_beamformee_max_sts
+ieee80211_eht_beamformee_get_max_sts_upto_80mhz(const u8 *phy_cap_info)
+{
+
+	u8 max_sts = FIELD_GET(
+			IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_MAX_STS_UPTO_80MHZ,
+			phy_cap_info[0]);
+
+	max_sts += FIELD_GET(
+			IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_UPTO_80MHZ,
+			phy_cap_info[1]) << 1;
+
+	return max_sts;
+}
+
+/**
+ * ieee80211_eht_beamformee_set_max_sts_160mhz - set maximum number of spatial
+ *	streams that the STA is capable of receiving in an EHT sounding NDP for
+ *	bandwidth 160 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @max_sts: maximum number of spatial streams supported, see &enum
+ *	ieee80211_eht_beamformee_max_sts
+ *
+ * Set "Beamformee SS for 160 MHz" subfield as encoded in "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_beamformee_set_max_sts_160mhz(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_beamformee_max_sts max_sts)
+{
+	phy_cap_info[1] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_160MHZ, max_sts);
+}
+
+/**
+ * ieee80211_eht_beamformee_get_max_sts_160mhz - get maximum number of spatial
+ *	streams that the STA is capable of receiving in an EHT sounding NDP for
+ *	bandwidth 160 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Beamformee SS for 160 MHz" subfield value from "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ *
+ * Return: maximum number of spatial streams supported, see &enum
+ *	ieee80211_eht_beamformee_max_sts
+ */
+static inline enum ieee80211_eht_beamformee_max_sts
+ieee80211_eht_beamformee_get_max_sts_160mhz(const u8 *phy_cap_info)
+{
+
+	return FIELD_GET(IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_160MHZ,
+			 phy_cap_info[1]);
+}
+
+/**
+ * ieee80211_eht_beamformee_set_max_sts_320mhz - set maximum number of spatial
+ *	streams that the STA is capable of receiving in an EHT sounding NDP for
+ *	bandwidth 320 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @max_sts: maximum number of spatial streams supported, see &enum
+ *	ieee80211_eht_beamformee_max_sts
+ *
+ * Set "Beamformee SS for 320 MHz" subfield as encoded in "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_beamformee_set_max_sts_320mhz(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_beamformee_max_sts max_sts)
+{
+	phy_cap_info[1] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_320MHZ, max_sts);
+}
+
+/**
+ * ieee80211_eht_beamformee_get_max_sts_320mhz - get maximum number of spatial
+ *	streams that the STA is capable of receiving in an EHT sounding NDP for
+ *	bandwidth 320 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Beamformee SS for 320 MHz" subfield value from "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ *
+ * Return: maximum number of spatial streams supported, see &enum
+ *	ieee80211_eht_beamformee_max_sts
+ */
+static inline enum ieee80211_eht_beamformee_max_sts
+ieee80211_eht_beamformee_get_max_sts_320mhz(const u8 *phy_cap_info)
+{
+
+	return FIELD_GET(IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_MAX_STS_320MHZ,
+			 phy_cap_info[1]);
+}
+
+/**
+ * enum ieee80211_eht_beamformer_snd_dim - Beamformer number of supported
+ *	sounding dimensions
+ * @EHT_BEAMFORMER_SND_DIM_1: 1 sounding dimension supported
+ * @EHT_BEAMFORMER_SND_DIM_2: 2 sounding dimensions supported
+ * @EHT_BEAMFORMER_SND_DIM_3: 3 sounding dimensions supported
+ * @EHT_BEAMFORMER_SND_DIM_4: 4 sounding dimensions supported
+ * @EHT_BEAMFORMER_SND_DIM_5: 5 sounding dimensions supported
+ * @EHT_BEAMFORMER_SND_DIM_6: 6 sounding dimensions supported
+ * @EHT_BEAMFORMER_SND_DIM_7: 7 sounding dimensions supported
+ * @EHT_BEAMFORMER_SND_DIM_8: 8 sounding dimensions supported
+ */
+enum ieee80211_eht_beamformer_snd_dim {
+	EHT_BEAMFORMER_SND_DIM_1 = 0,
+	EHT_BEAMFORMER_SND_DIM_2,
+	EHT_BEAMFORMER_SND_DIM_3,
+	EHT_BEAMFORMER_SND_DIM_4,
+	EHT_BEAMFORMER_SND_DIM_5,
+	EHT_BEAMFORMER_SND_DIM_6,
+	EHT_BEAMFORMER_SND_DIM_7,
+	EHT_BEAMFORMER_SND_DIM_8,
+};
+
+/**
+ * ieee80211_eht_set_snd_dim_upto_80mhz - set number of sounding dimensions
+ *	supported upto 80 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @num_snd_dim: number of sounding dimensions supported, see &enum
+ *	ieee80211_eht_beamformer_snd_dim
+ *
+ * Set "Number Of Sounding Dimensions for upto 80 MHz" subfield as encoded in
+ * "EHT PHY Capabilities Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_snd_dim_upto_80mhz(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_beamformer_snd_dim num_snd_dim)
+{
+	phy_cap_info[2] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_UPTO_80MHZ,
+		   num_snd_dim);
+}
+
+/**
+ * ieee80211_eht_get_snd_dim_upto_80mhz - get number of sounding dimensions
+ *	supported upto 80 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Number Of Sounding Dimensions upto 80 MHz" subfield value from "EHT PHY
+ * Capabilities Information" field in EHT Capabilities element
+ *
+ * Return: number of sounding dimensions supported, see &enum
+ *	ieee80211_eht_beamformer_snd_dim
+ */
+static inline enum ieee80211_eht_beamformer_snd_dim
+ieee80211_eht_get_snd_dim_upto_80mhz(const u8 *phy_cap_info)
+{
+	return FIELD_GET(
+		IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_UPTO_80MHZ,
+		phy_cap_info[2]);
+}
+
+/**
+ * ieee80211_eht_set_snd_dim_160mhz - set number of sounding dimensions
+ *	supported upto 160 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @num_snd_dim: number of sounding dimensions supported, see &enum
+ *	ieee80211_eht_beamformer_snd_dim
+ *
+ * Set "Number Of Sounding Dimensions for 160 MHz" subfield as encoded in "EHT
+ * PHY Capabilities Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_snd_dim_160mhz(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_beamformer_snd_dim num_snd_dim)
+{
+	phy_cap_info[2] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_160MHZ,
+		   num_snd_dim);
+}
+
+/**
+ * ieee80211_eht_get_snd_dim_160mhz - get number of sounding dimensions
+ *	supported for 160 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Number Of Sounding Dimensions for 160 MHz" subfield value from "EHT PHY
+ * Capabilities Information" field in EHT Capabilities element
+ *
+ * Return: number of sounding dimensions supported, see &enum
+ *	ieee80211_eht_beamformer_snd_dim
+ */
+static inline enum ieee80211_eht_beamformer_snd_dim
+ieee80211_eht_get_snd_dim_160mhz(const u8 *phy_cap_info)
+{
+	return FIELD_GET(
+		IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_160MHZ,
+		phy_cap_info[2]);
+}
+
+/**
+ * ieee80211_eht_set_snd_dim_320mhz - set number of sounding dimensions
+ *	supported for 320 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @num_snd_dim: number of sounding dimensions supported, &enum
+ *	ieee80211_eht_beamformer_snd_dim
+ *
+ * Set "Number Of Sounding Dimensions for 320 MHz" subfield as encoded in "EHT
+ * PHY Capabilities Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_max_snd_dim_320(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_beamformer_snd_dim num_snd_dim)
+{
+	phy_cap_info[2] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_320MHZ,
+		   num_snd_dim);
+
+	phy_cap_info[3] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP3_BEAMFORMER_NUM_SND_DIM_320MHZ,
+		   num_snd_dim >> 2);
+}
+
+/**
+ * ieee80211_eht_get_snd_dim_320mhz - get number of sounding dimensions
+ *	supported for 320 MHz
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Number Of Sounding Dimensions for 320 MHz" subfield value from "EHT
+ * PHY Capabilities Information" field in EHT Capabilities element
+ *
+ * Return: number of sounding dimensions supported, &enum
+ *	ieee80211_eht_beamformer_snd_dim
+ */
+static inline enum ieee80211_eht_beamformer_snd_dim
+ieee80211_eht_get_max_snd_dim_320(const u8 *phy_cap_info)
+{
+	u8 num_snd_dim =
+	FIELD_GET(IEEE80211_EHT_PHY_CAP2_BEAMFORMER_NUM_SND_DIM_320MHZ,
+		   phy_cap_info[2]);
+
+	if (FIELD_GET(IEEE80211_EHT_PHY_CAP3_BEAMFORMER_NUM_SND_DIM_320MHZ,
+		      phy_cap_info[3]))
+		num_snd_dim += 4;
+
+	return num_snd_dim;
+}
+
+/**
+ * enum ieee80211_eht_max_nc - maximum supported Nc definitions
+ * @EHT_MAX_NC_1: maximum 1 Nc supported
+ * @EHT_MAX_NC_2: maximum 2 Nc supported
+ * @EHT_MAX_NC_3: maximum 3 Nc supported
+ * @EHT_MAX_NC_4: maximum 4 Nc supported
+ * @EHT_MAX_NC_5: maximum 5 Nc supported
+ * @EHT_MAX_NC_6: maximum 6 Nc supported
+ * @EHT_MAX_NC_7: maximum 7 Nc supported
+ * @EHT_MAX_NC_8: maximum 8 Nc supported
+ */
+enum ieee80211_eht_max_nc {
+	EHT_MAX_NC_1 = 0,
+	EHT_MAX_NC_2,
+	EHT_MAX_NC_3,
+	EHT_MAX_NC_4,
+	EHT_MAX_NC_5,
+	EHT_MAX_NC_6,
+	EHT_MAX_NC_7,
+	EHT_MAX_NC_8,
+};
+
+/**
+ * ieee80211_eht_set_max_nc - set maximum supported Nc
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @max_nc: Maximum supported Nc, see &enum ieee80211_eht_max_nc
+ *
+ * Set "Max Nc" subfield as encoded in "EHT PHY Capabilities Information" field
+ * in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_max_nc(u8 *phy_cap_info, enum ieee80211_eht_max_nc max_nc)
+{
+	phy_cap_info[4] |= FIELD_PREP(IEEE80211_EHT_PHY_CAP4_MAX_NC, max_nc);
+}
+
+/**
+ * ieee80211_eht_get_max_nc - get maximum supported Nc
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Get "Max Nc" subfield value from "EHT PHY Capabilities Information" field
+ * in EHT Capabilities element
+ *
+ * Return: Max supported Nc, see &enum ieee80211_eht_max_nc
+ */
+static inline enum ieee80211_eht_max_nc
+ieee80211_eht_get_max_nc(const u8 *phy_cap_info)
+{
+	return FIELD_GET(IEEE80211_EHT_PHY_CAP4_MAX_NC, phy_cap_info[4]);
+}
+
+/**
+ * enum ieee80211_eht_nominal_pkt_padding - EHT nominal packet padding
+ *	definitions
+ * @EHT_NOMINAL_PKT_PADDING_0US - 0 us common nominal packet padding
+ * @EHT_NOMINAL_PKT_PADDING_8US - 8 us common nominal packet padding
+ * @EHT_NOMINAL_PKT_PADDING_16US - 16 us common nominal packet padding
+ * @EHT_NOMINAL_PKT_PADDING_16US_OR_20US - 16 us common nominal packet padding
+ *	for all modes with constellation <= 1024, nss <= 8, RU/MRU <= 2x996 and
+ *	20 us for all other modes
+ */
+enum ieee80211_eht_nominal_pkt_padding {
+	EHT_NOMINAL_PKT_PADDING_0US = 0,
+	EHT_NOMINAL_PKT_PADDING_8US,
+	EHT_NOMINAL_PKT_PADDING_16US,
+	EHT_NOMINAL_PKT_PADDING_16US_OR_20US,
+};
+
+/**
+ * ieee80211_eht_set_common_nominal_pkt_padding - set EHT common nominal packet
+ *	padding.
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @nominal_pkt_pad: common nominal packet padding, see &enum
+ *	ieee80211_eht_nominal_pkt_padding
+ *
+ * Set "Common Nominal Packet Padding" subfield as encoded in "EHT PHY
+ * Capabilities Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_common_nominal_pkt_padding(
+	u8 *phy_cap_info,
+	enum ieee80211_eht_nominal_pkt_padding nominal_pkt_pad)
+{
+	phy_cap_info[5] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP5_NOMINAL_PKT_PADDING, nominal_pkt_pad);
+}
+
+/**
+ * ieee80211_eht_get_common_nominal_pkt_padding - get EHT common nominal packet
+ *	padding.
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ *
+ * Set "Common Nominal Packet Padding" subfield value from "EHT PHY Capabilities
+ * Information" field in EHT Capabilities element
+ *
+ * Return: EHT common nominal packet padding capability, see &enum
+ *	ieee80211_eht_nominal_pkt_padding
+ */
+static inline enum ieee80211_eht_nominal_pkt_padding
+ieee80211_eht_get_common_nominal_pkt_padding(const u8 *phy_cap_info)
+{
+	return FIELD_GET(IEEE80211_EHT_PHY_CAP5_NOMINAL_PKT_PADDING,
+			 phy_cap_info[5]);
+}
+
+/**
+ * enum ieee80211_eht_max_ltf_supp - EHT maximum LTF support definitions
+ * @EHT_MAX_4XLTF_SUPP - Maximum of four EHT-LTFs supported
+ * @EHT_MAX_8XLTF_SUPP - Maximum of eight EHT-LTFs supported
+ */
+enum ieee80211_eht_max_ltf_supp {
+	EHT_MAX_4XLTF_SUPP = 0,
+	EHT_MAX_8XLTF_SUPP,
+};
+
+/**
+ * ieee80211_eht_set_max_eht_ltf_supp - set maximum number of supported EHT-LTFs
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @mu: Multiple user configuration
+ * @max_ltf: Maximum number of EHT-LTFs supported, see &enum
+ *	ieee80211_eht_max_ltf_supp
+ *
+ * Set "Maximum Number Of Supported EHT-LTFs" subfield as encoded in "EHT PHY
+ * Capabilities Information" field in EHT Capabilities element
+ */
+static inline void
+ieee80211_eht_set_max_eht_ltf_supp(u8 *phy_cap_info, bool mu,
+				   enum ieee80211_eht_max_ltf_supp max_ltf)
+{
+
+	if (mu) {
+		phy_cap_info[6] |=
+		FIELD_PREP(IEEE80211_EHT_PHY_CAP6_MAX_EHT_LTF_SUPP_MU, max_ltf);
+		return;
+	}
+
+	phy_cap_info[5] |=
+	FIELD_PREP(IEEE80211_EHT_PHY_CAP5_MAX_EHT_LTF_SUPP_SU, max_ltf);
+}
+
+/**
+ * ieee80211_eht_get_max_eht_ltf_supp - get maximum number of supported EHT-LTFs
+ *
+ * @phy_cap_info: EHT PHY capabilities information field data
+ * @mu: Multiple user configuration
+ *
+ * Get "Maximum Number Of Supported EHT-LTFs" subfield value from "EHT PHY
+ * Capabilities Information" field in EHT Capabilities element
+ *
+ * Return: Maximum number of EHT-LTFs supported, see &enum
+ *	ieee80211_eht_max_ltf_supp
+ */
+static inline enum ieee80211_eht_max_ltf_supp
+ieee80211_eht_get_max_eht_ltf_supp(const u8 *phy_cap_info, bool mu)
+{
+	if (mu)
+		return FIELD_GET(IEEE80211_EHT_PHY_CAP6_MAX_EHT_LTF_SUPP_MU,
+				 phy_cap_info[6]);
+
+	return FIELD_GET(IEEE80211_EHT_PHY_CAP5_MAX_EHT_LTF_SUPP_SU,
+			 phy_cap_info[5]);
+}
+
+/**
+ * ieee80211_eht_mcs_nss_size - Get EHT MCS NSS Support Field size
+ *
+ * @eht_cap: EHT capabilities element
+ * @he_cap: HE capabilities element
+ *
+ * Calculate Tx/Rx EHT MCS NSS Support Field size in EHT capabilities IE
+ *
+ * Return: EHT MCS NSS Support Field size
+ */
+static inline u8
+ieee80211_eht_mcs_nss_size(const struct ieee80211_eht_cap_elem *eht_cap,
+			   const struct ieee80211_he_cap_elem *he_cap)
+{
+	if ((he_cap->phy_cap_info[0] &
+	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0)
+		return 4;
+
+	if (eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+		return 9;
+
+	if (he_cap->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+		return 6;
+
+	return 3;
+}
+
+/* EHT PPE Thresholds from P802.11be_D1.3, section 9.4.2.313.5 */
+#define IEEE80211_EHT_PPE_THRES0_NSS			GENMASK(3, 0)
+
+/* RU Index Bitmask is split between byte 0 and byte 1 */
+#define IEEE80211_EHT_PPE_THRES0_RU_INDEX		GENMASK(7, 4)
+#define IEEE80211_EHT_PPE_THRES1_RU_INDEX		BIT(0)
+
+/* PPE Thresholds Information subfields size in number of bits */
+#define IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE		9
+#define IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE			6
+
+/**
+ * ieee80211_eht_ppe_size - Get EHT PPE Thresholds Info Field size
+ *
+ * @ppe_thres_hdr: Header bytes of PPE Thresholds field
+ * @phy_cap_info: EHT PHY capabilities information
+ *
+ * Calculate EHT PPE Thresholds Info Field size in EHT capabilities IE
+ *
+ * Return: EHT PPE Thresholds Info Field size
+ */
+static inline u8
+ieee80211_eht_ppe_size(const u8 *ppe_thres_hdr, const u8 *phy_cap_info)
+{
+	u8 n;
+
+	if ((phy_cap_info[5] &
+	     IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) == 0)
+		return 0;
+
+	n = hweight8(FIELD_GET(IEEE80211_EHT_PPE_THRES0_RU_INDEX,
+			       ppe_thres_hdr[0]));
+	n += hweight8(FIELD_GET(IEEE80211_EHT_PPE_THRES1_RU_INDEX,
+				ppe_thres_hdr[1]));
+
+	n *= (1 + FIELD_GET(IEEE80211_EHT_PPE_THRES0_NSS, ppe_thres_hdr[0]));
+
+	/**
+	 * Each pair is 6 bits, and we need to add the 9 "header" bits to the
+	 * total size.
+	 */
+	n = (n * IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE) +
+	    IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+	n = DIV_ROUND_UP(n, 8);
+
+	return n;
+}
+
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
 #define WLAN_AUTH_SHARED_KEY 1
@@ -3054,6 +3755,7 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_SHORT_SSID_LIST = 58,
 	WLAN_EID_EXT_HE_6GHZ_CAPA = 59,
 	WLAN_EID_EXT_UL_MU_POWER_CAPA = 60,
+	WLAN_EID_EXT_EHT_CAPABILITY = 108,
 };
 
 /* Action category code */
-- 
2.7.4

