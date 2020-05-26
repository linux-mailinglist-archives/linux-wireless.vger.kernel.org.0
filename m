Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F119B9CE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbgDBBSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:31 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46546 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733272AbgDBBSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 51E134F7B01;
        Thu,  2 Apr 2020 01:18:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IJjuyU7nmNjd; Thu,  2 Apr 2020 01:18:26 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 8A07B4F7AF8;
        Thu,  2 Apr 2020 01:18:13 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 8/9] ieee80211: S1G defines
Date:   Wed,  1 Apr 2020 18:18:09 -0700
Message-Id: <20200402011810.22947-9-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402011810.22947-1-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These are found in IEEE-802.11ah-2016.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h | 221 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 8c4226b8a048..a49bcd85f9d4 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -105,6 +105,51 @@
 
 /* extension, added by 802.11ad */
 #define IEEE80211_STYPE_DMG_BEACON		0x0000
+#define IEEE80211_STYPE_S1G_BEACON		0x0010
+
+/* bits unique to S1G beacon */
+#define IEEE80211_S1G_BCN_NEXT_TBTT	0x100
+
+/* see 802.11ah-2016 9.9 NDP CMAC frames */
+#define IEEE80211_S1G_1MHZ_NDP_BITS	25
+#define IEEE80211_S1G_1MHZ_NDP_BYTES	4
+#define IEEE80211_S1G_2MHZ_NDP_BITS	37
+#define IEEE80211_S1G_2MHZ_NDP_BYTES	5
+
+#define IEEE80211_NDP_FTYPE_CTS			0
+#define IEEE80211_NDP_FTYPE_CF_END		0
+#define IEEE80211_NDP_FTYPE_PS_POLL		1
+#define IEEE80211_NDP_FTYPE_ACK			2
+#define IEEE80211_NDP_FTYPE_PS_POLL_ACK		3
+#define IEEE80211_NDP_FTYPE_BA			4
+#define IEEE80211_NDP_FTYPE_BF_REPORT_POLL	5
+#define IEEE80211_NDP_FTYPE_PAGING		6
+#define IEEE80211_NDP_FTYPE_PREQ		7
+
+#define SM64(f, v)	((((u64)v) << f##_S) & f)
+
+/* NDP CMAC frame fields */
+#define IEEE80211_NDP_FTYPE                    0x0000000000000007
+#define IEEE80211_NDP_FTYPE_S                  0x0000000000000000
+
+/* 1M Probe Request 11ah 9.9.3.1.1 */
+#define IEEE80211_NDP_1M_PREQ_ANO      0x0000000000000008
+#define IEEE80211_NDP_1M_PREQ_ANO_S                     3
+#define IEEE80211_NDP_1M_PREQ_CSSID    0x00000000000FFFF0
+#define IEEE80211_NDP_1M_PREQ_CSSID_S                   4
+#define IEEE80211_NDP_1M_PREQ_RTYPE    0x0000000000100000
+#define IEEE80211_NDP_1M_PREQ_RTYPE_S                  20
+#define IEEE80211_NDP_1M_PREQ_RSV      0x0000000001E00000
+#define IEEE80211_NDP_1M_PREQ_RSV      0x0000000001E00000
+/* 2M Probe Request 11ah 9.9.3.1.2 */
+#define IEEE80211_NDP_2M_PREQ_ANO      0x0000000000000008
+#define IEEE80211_NDP_2M_PREQ_ANO_S                     3
+#define IEEE80211_NDP_2M_PREQ_CSSID    0x0000000FFFFFFFF0
+#define IEEE80211_NDP_2M_PREQ_CSSID_S                   4
+#define IEEE80211_NDP_2M_PREQ_RTYPE    0x0000001000000000
+#define IEEE80211_NDP_2M_PREQ_RTYPE_S                  36
+
+#define IEEE80211_ANO_NETTYPE_WILD              15
 
 /* control extension - for IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTL_EXT */
 #define IEEE80211_CTL_EXT_POLL		0x2000
@@ -121,6 +166,21 @@
 #define IEEE80211_MAX_SN		IEEE80211_SN_MASK
 #define IEEE80211_SN_MODULO		(IEEE80211_MAX_SN + 1)
 
+
+/* PV1 Layout 11ah 9.8.3.1 */
+#define IEEE80211_PV1_FCTL_VERS		0x0003
+#define IEEE80211_PV1_FCTL_FTYPE	0x001c
+#define IEEE80211_PV1_FCTL_STYPE	0x00e0
+#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
+#define IEEE80211_PV1_FCTL_PM		0x0400
+#define IEEE80211_PV1_FCTL_MOREDATA	0x0800
+#define IEEE80211_PV1_FCTL_PROTECTED	0x1000
+#define IEEE80211_PV1_FCTL_END_SP       0x2000
+#define IEEE80211_PV1_FCTL_RELAYED      0x4000
+#define IEEE80211_PV1_FCTL_ACK_POLICY   0x8000
+#define IEEE80211_PV1_FCTL_CTL_EXT	0x0f00
+
 static inline bool ieee80211_sn_less(u16 sn1, u16 sn2)
 {
 	return ((sn1 - sn2) & IEEE80211_SN_MASK) > (IEEE80211_SN_MODULO >> 1);
@@ -148,6 +208,7 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 #define IEEE80211_MAX_FRAG_THRESHOLD	2352
 #define IEEE80211_MAX_RTS_THRESHOLD	2353
 #define IEEE80211_MAX_AID		2007
+#define IEEE80211_MAX_AID_S1G		8191
 #define IEEE80211_MAX_TIM_LEN		251
 #define IEEE80211_MAX_MESH_PEERINGS	63
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
@@ -371,6 +432,17 @@ static inline bool ieee80211_is_data(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_DATA);
 }
 
+/**
+ * ieee80211_is_ext - check if type is IEEE80211_FTYPE_EXT
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee80211_is_ext(__le16 fc)
+{
+	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE)) ==
+	       cpu_to_le16(IEEE80211_FTYPE_EXT);
+}
+
+
 /**
  * ieee80211_is_data_qos - check if type is IEEE80211_FTYPE_DATA and IEEE80211_STYPE_QOS_DATA is set
  * @fc: frame control bytes in little-endian byteorder
@@ -469,6 +541,18 @@ static inline bool ieee80211_is_beacon(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON);
 }
 
+/**
+ * ieee80211_is_s1g_beacon - check if IEEE80211_FTYPE_EXT &&
+ * IEEE80211_STYPE_S1G_BEACON
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee80211_is_s1g_beacon(__le16 fc)
+{
+	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE |
+				 IEEE80211_FCTL_STYPE)) ==
+	       cpu_to_le16(IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON);
+}
+
 /**
  * ieee80211_is_atim - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ATIM
  * @fc: frame control bytes in little-endian byteorder
@@ -898,6 +982,59 @@ struct ieee80211_addba_ext_ie {
 	u8 data;
 } __packed;
 
+/**
+ * struct ieee80211_s1g_bcn_compat_ie
+ *
+ * S1G Beacon Compatibility element
+ */
+struct ieee80211_s1g_bcn_compat_ie {
+	__le16 compat_info;
+	__le16 beacon_int;
+	__le32 tsf_completion;
+} __packed;
+
+/**
+ * struct ieee80211_s1g_oper_ie
+ *
+ * S1G Operation element
+ */
+struct ieee80211_s1g_oper_ie {
+	u8 ch_width;
+	u8 oper_class;
+	u8 primary_ch;
+	u8 oper_ch;
+	__le16 basic_mcs_nss;
+} __packed;
+
+/**
+ * struct ieee80211_aid_response_ie
+ *
+ * AID Response element
+ */
+struct ieee80211_aid_response_ie {
+	__le16 aid;
+	u8 switch_count;
+	__le16 response_int;
+} __packed;
+
+struct ieee80211_s1g_cap {
+	u8 capab_info[10];
+	u8 supp_mcs_nss[5];
+} __packed;
+
+struct ieee80211_ext {
+	__le16 frame_control;
+	__le16 duration;
+	union {
+		struct {
+			u8 sa[ETH_ALEN];
+			__le32 timestamp;
+			u8 change_seq;
+			u8 variable[0];
+		} __packed s1g_beacon;
+	} u;
+} __packed __aligned(2);
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
@@ -2130,6 +2267,86 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 	return spr_len;
 }
 
+/* S1G Capabilities Information field */
+#define S1G_CAPAB_B0_S1G_LONG BIT(0)
+#define S1G_CAPAB_B0_SGI_1MHZ BIT(1)
+#define S1G_CAPAB_B0_SGI_2MHZ BIT(2)
+#define S1G_CAPAB_B0_SGI_4MHZ BIT(3)
+#define S1G_CAPAB_B0_SGI_8MHZ BIT(4)
+#define S1G_CAPAB_B0_SGI_16MHZ BIT(5)
+#define S1G_CAPAB_B0_SUPP_CH_WIDTH_MASK (BIT(6) | BIT(7))
+#define S1G_CAPAB_B0_SUPP_CH_WIDTH_SHIFT 6
+
+#define S1G_CAPAB_B1_RX_LDPC BIT(0)
+#define S1G_CAPAB_B1_TX_STBC BIT(1)
+#define S1G_CAPAB_B1_RX_STBC BIT(2)
+#define S1G_CAPAB_B1_SU_BFER BIT(3)
+#define S1G_CAPAB_B1_SU_BFEE BIT(4)
+#define S1G_CAPAB_B1_BFEE_STS_MASK (BIT(5) | BIT(6) | BIT(7))
+#define S1G_CAPAB_B1_BFEE_STS_SHIFT 5
+
+#define S1G_CAPAB_B2_SOUNDING_DIMENSIONS_MASK (BIT(0) | BIT(1) | BIT(2))
+#define S1G_CAPAB_B2_SOUNDING_DIMENSIONS_SHIFT 0
+#define S1G_CAPAB_B2_MU_BFER BIT(3)
+#define S1G_CAPAB_B2_MU_BFEE BIT(4)
+#define S1G_CAPAB_B2_PLUS_HTC_VHT BIT(5)
+#define S1G_CAPAB_B2_TRAVELING_PILOT_MASK ((BIT(6) | BIT(7))
+#define S1G_CAPAB_B2_TRAVELING_PILOT_SHIFT 6
+
+#define S1G_CAPAB_B3_RD_RESPONDER BIT(0)
+#define S1G_CAPAB_B3_HT_DELAYED_BA BIT(1)
+#define S1G_CAPAB_B3_MAX_MPDU_LEN BIT(2)
+#define S1G_CAPAB_B3_MAX_AMPDU_LEN_EXP_MASK (BIT(3) | BIT(4))
+#define S1G_CAPAB_B3_MAX_AMPDU_LEN_EXP_SHIFT 3
+#define S1G_CAPAB_B3_MIN_MPDU_START_MASK (BIT(5) | BIT(6) | BIT(7))
+#define S1G_CAPAB_B3_MIN_MPDU_START_SHIFT 5
+
+#define S1G_CAPAB_B4_UPLINK_SYNC BIT(0)
+#define S1G_CAPAB_B4_DYNAMIC_AID BIT(1)
+#define S1G_CAPAB_B4_BAT BIT(2)
+#define S1G_CAPAB_B4_TIME_ADE BIT(3)
+#define S1G_CAPAB_B4_NON_TIM BIT(4)
+#define S1G_CAPAB_B4_GROUP_AID BIT(5)
+#define S1G_CAPAB_B4_STA_TYPE_MASK (BIT(6) | BIT(7))
+#define S1G_CAPAB_B4_STA_TYPE_SHIFT 6
+
+#define S1G_CAPAB_B5_CENT_AUTH_CONTROL BIT(0)
+#define S1G_CAPAB_B5_DIST_AUTH_CONTROL BIT(1)
+#define S1G_CAPAB_B5_AMSDU BIT(2)
+#define S1G_CAPAB_B5_AMPDU BIT(3)
+#define S1G_CAPAB_B5_ASYMMETRIC_BA BIT(4)
+#define S1G_CAPAB_B5_FLOW_CONTROL BIT(5)
+#define S1G_CAPAB_B5_SECTORIZED_BEAM_MASK (BIT(6) | BIT(7))
+#define S1G_CAPAB_B5_SECTORIZED_BEAM_SHIFT 6
+
+#define S1G_CAPAB_B6_OBSS_MITIGATION BIT(0)
+#define S1G_CAPAB_B6_FRAGMENT_BA BIT(1)
+#define S1G_CAPAB_B6_NDP_PS_POLL BIT(2)
+#define S1G_CAPAB_B6_RAW_OPERATION BIT(3)
+#define S1G_CAPAB_B6_PAGE_SLICING BIT(4)
+#define S1G_CAPAB_B6_TXOP_SHARING_IMP_ACK BIT(5)
+#define S1G_CAPAB_B6_VHT_LINK_ADAPT_MASK (BIT(6) | BIT(7))
+#define S1G_CAPAB_B6_VHT_LINK_ADAPT_SHIFT 6
+
+#define S1G_CAPAB_B7_TACK_AS_PS_POLL BIT(0)
+#define S1G_CAPAB_B7_DUP_1MHZ BIT(1)
+#define S1G_CAPAB_B7_MCS_NEGOTIATION BIT(2)
+#define S1G_CAPAB_B7_1MHZ_CTL_RESPONSE_PREAMBLE BIT(3)
+#define S1G_CAPAB_B7_NDP_BFING_REPORT_POLL BIT(4)
+#define S1G_CAPAB_B7_UNSOLICITED_DYN_AID BIT(5)
+#define S1G_CAPAB_B7_SECTOR_TRAINING_OPERATION BIT(6)
+#define S1G_CAPAB_B7_TEMP_PS_MODE_SWITCH BIT(7)
+
+#define S1G_CAPAB_B8_TWT_GROUPING BIT(0)
+#define S1G_CAPAB_B8_BDT BIT(1)
+#define S1G_CAPAB_B8_COLOR_MASK (BIT(2) | BIT(3) | BIT(4))
+#define S1G_CAPAB_B8_COLOR_SHIFT 2
+#define S1G_CAPAB_B8_TWT_REQUEST BIT(5)
+#define S1G_CAPAB_B8_TWT_RESPOND BIT(6)
+#define S1G_CAPAB_B8_PV1_FRAME BIT(7)
+
+#define S1G_CAPAB_B9_LINK_ADAPT_PER_CONTROL_RESPONSE BIT(0)
+
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
 #define WLAN_AUTH_SHARED_KEY 1
@@ -2525,8 +2742,12 @@ enum ieee80211_eid {
 	WLAN_EID_QUIET_CHANNEL = 198,
 	WLAN_EID_OPMODE_NOTIF = 199,
 
+	WLAN_EID_S1G_BCN_COMPAT = 213,
+	WLAN_EID_S1G_SHORT_BCN_INTERVAL = 214,
+	WLAN_EID_S1G_CAPABILITIES = 217,
 	WLAN_EID_VENDOR_SPECIFIC = 221,
 	WLAN_EID_QOS_PARAMETER = 222,
+	WLAN_EID_S1G_OPERATION = 232,
 	WLAN_EID_CAG_NUMBER = 237,
 	WLAN_EID_AP_CSN = 239,
 	WLAN_EID_FILS_INDICATION = 240,
-- 
2.20.1

