Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20176CCE98
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC2AJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 20:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjC2AJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 20:09:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFED10F5
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 17:09:18 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SNU4Qm015607;
        Wed, 29 Mar 2023 00:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=2ZE35s6DY21tbqwkWu38GGFu17FSnDWWGcVXbWKb9+c=;
 b=jonsaJetzegHOPbXmrHHXa/WCsOY5LjIhkcDhtzSTBmYkpPPCsuDH3A7wPu7OCCRa0jR
 gR3LHRpGZW5aECz6371WfYUXJ39qdG1ler1SF4z2ljj4TcH+j12T/jEuSP3P4rXjH3gO
 thwsqo8Zw2Sm/2veBa5UAlEyWy1uFv2G/Hs7Lp8XA/NTnC5FhWCiPNpH7EUJ40KPKdMX
 +lMjVYJrECLZ1fW7x/iQoYePig6xXowqUKex0s0QHsh+uODiiqFmjEtk+e9FfDq5txwV
 1LUJmvtGdrzgitq33mT3BFI998Ey4HNNu65617Zzm/tW1SoC7OD3ZxvJLC8k7HcfSSl8 vQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pm7hcgby8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 00:09:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T09EsL029626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 00:09:14 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 28 Mar 2023 17:09:13 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH] wifi: cfg80211: beacon EHT rate support
Date:   Tue, 28 Mar 2023 17:09:02 -0700
Message-ID: <20230329000902.17992-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1cNbn8hFnP7rCfN55EhDO7GdrwbDOO1W
X-Proofpoint-GUID: 1cNbn8hFnP7rCfN55EhDO7GdrwbDOO1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280187
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Parse, validate and configure EHT beacon rate passed by the userspace.

- New feature flag, NL80211_EXT_FEATURE_BEACON_RATE_EHT, for drivers
to indicate support for EHT beacons rates.
- New member in enum nl80211_tx_rate_attributes, NL80211_TXRATE_EHT,
for EHT rates.
- New macro NL80211_EHT_NSS_MAX to indicate support for maximum NSS
in EHT, currently set to 8.
- New structures nl80211_txrate_eht and cfg80211_bitrate_mask to store
MCS rates for each stream.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h       |   1 +
 include/uapi/linux/nl80211.h |  22 +++-
 net/wireless/nl80211.c       | 189 ++++++++++++++++++++++++++++++++++-
 3 files changed, 206 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..128c149d40be 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -763,6 +763,7 @@ struct cfg80211_bitrate_mask {
 		u8 ht_mcs[IEEE80211_HT_MCS_MASK_LEN];
 		u16 vht_mcs[NL80211_VHT_NSS_MAX];
 		u16 he_mcs[NL80211_HE_NSS_MAX];
+		u16 eht_mcs[NL80211_EHT_NSS_MAX];
 		enum nl80211_txrate_gi gi;
 		enum nl80211_he_gi he_gi;
 		enum nl80211_he_ltf he_ltf;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cf4fb981e131..81ba087c64d1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1906,8 +1906,9 @@ enum nl80211_commands {
  *	The driver must also specify support for this with the extended
  *	features NL80211_EXT_FEATURE_BEACON_RATE_LEGACY,
  *	NL80211_EXT_FEATURE_BEACON_RATE_HT,
- *	NL80211_EXT_FEATURE_BEACON_RATE_VHT and
- *	NL80211_EXT_FEATURE_BEACON_RATE_HE.
+ *	NL80211_EXT_FEATURE_BEACON_RATE_VHT,
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HE and
+ *	NL80211_EXT_FEATURE_BEACON_RATE_EHT.
  *
  * @NL80211_ATTR_FRAME_MATCH: A binary attribute which typically must contain
  *	at least one byte, currently used with @NL80211_CMD_REGISTER_FRAME.
@@ -5218,6 +5219,8 @@ enum nl80211_key_attributes {
  *	see &struct nl80211_txrate_he
  * @NL80211_TXRATE_HE_GI: configure HE GI, 0.8us, 1.6us and 3.2us.
  * @NL80211_TXRATE_HE_LTF: configure HE LTF, 1XLTF, 2XLTF and 4XLTF.
+ * @NL80211_TXRATE_EHT: EHT rates allowed for TX rate selection,
+ *	see &struct nl80211_txrate_eht.
  * @__NL80211_TXRATE_AFTER_LAST: internal
  * @NL80211_TXRATE_MAX: highest TX rate attribute
  */
@@ -5230,6 +5233,7 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HE,
 	NL80211_TXRATE_HE_GI,
 	NL80211_TXRATE_HE_LTF,
+	NL80211_TXRATE_EHT,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -5256,6 +5260,16 @@ struct nl80211_txrate_he {
 	__u16 mcs[NL80211_HE_NSS_MAX];
 };
 
+#define NL80211_EHT_NSS_MAX    8
+/**
+ * struct nl80211_txrate_eht - EHT MCS/NSS txrate bitmap
+ * @mcs: MCS bitmap table for each NSS (array index 0 for 1 stream, etc).
+ *	Bits 0-15 for each NSS is set if that MCS is supported.
+ */
+struct nl80211_txrate_eht {
+	__u16 mcs[NL80211_EHT_NSS_MAX];
+};
+
 enum nl80211_txrate_gi {
 	NL80211_TXRATE_DEFAULT_GI,
 	NL80211_TXRATE_FORCE_SGI,
@@ -6365,6 +6379,9 @@ enum nl80211_feature_flags {
  *	in authentication and deauthentication frames sent to unassociated peer
  *	using @NL80211_CMD_FRAME.
  *
+ * @NL80211_EXT_FEATURE_BEACON_RATE_EHT: Driver supports beacon rate
+ *	configuration (AP/mesh) with EHT rates.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6436,6 +6453,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PUNCT,
 	NL80211_EXT_FEATURE_SECURE_NAN,
 	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
+	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f1cd3d9130dd..f05d48a82fe9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -393,6 +393,8 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
 						   NL80211_RATE_INFO_HE_1XLTF,
 						   NL80211_RATE_INFO_HE_4XLTF),
+	[NL80211_TXRATE_EHT] =
+			NLA_POLICY_EXACT_LEN(sizeof(struct nl80211_txrate_eht)),
 };
 
 static const struct nla_policy
@@ -5113,6 +5115,150 @@ static bool he_set_mcs_mask(struct genl_info *info,
 	return true;
 }
 
+static int eht_build_mcs_mask(struct genl_info *info, unsigned int link_id,
+			      const struct ieee80211_sta_he_cap *he_cap,
+			      const struct ieee80211_sta_eht_cap *eht_cap,
+			      u16 mcs_mask[NL80211_EHT_NSS_MAX])
+{
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	u8 mcs_len, mcs_7, mcs_9, mcs_11, mcs_13, nss;
+
+	mcs_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+					     &eht_cap->eht_cap_elem, true);
+	if (mcs_len == 4) {
+		const struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs =
+					&eht_cap->eht_mcs_nss_supp.only_20mhz;
+
+		mcs_7 = mcs->rx_tx_mcs7_max_nss;
+		mcs_9 = mcs->rx_tx_mcs9_max_nss;
+		mcs_11 = mcs->rx_tx_mcs11_max_nss;
+		mcs_13 = mcs->rx_tx_mcs13_max_nss;
+	} else {
+		const struct ieee80211_eht_mcs_nss_supp_bw *mcs;
+		enum nl80211_chan_width width;
+
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_AP:
+			width = wdev->u.ap.preset_chandef.width;
+			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			width = wdev->u.mesh.chandef.width;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (width) {
+		case NL80211_CHAN_WIDTH_320:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._320;
+			break;
+		case NL80211_CHAN_WIDTH_160:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._160;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+		case NL80211_CHAN_WIDTH_40:
+		case NL80211_CHAN_WIDTH_20:
+			mcs = &eht_cap->eht_mcs_nss_supp.bw._80;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/* STAs apart from 20 MHz-only STAs don't have a separate field
+		 * for MCS 7 hence value for MCS 9 is copied in both.
+		 */
+		mcs_7 = mcs->rx_tx_mcs9_max_nss;
+		mcs_9 = mcs->rx_tx_mcs9_max_nss;
+		mcs_11 = mcs->rx_tx_mcs11_max_nss;
+		mcs_13 = mcs->rx_tx_mcs13_max_nss;
+	}
+
+	memset(mcs_mask, 0, sizeof(u16) * NL80211_EHT_NSS_MAX);
+	for (nss = 0; nss < NL80211_EHT_NSS_MAX; nss++) {
+		/* For each spatial stream, set the bit if MCS is supported */
+
+		if (nss == 0) {
+			/* Only single stream supported for MCS 14 and 15 */
+			if (eht_cap->eht_cap_elem.phy_cap_info[6] &
+			    IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP)
+				mcs_mask[nss] |= 0x4000;
+			if (eht_cap->eht_cap_elem.phy_cap_info[6] &
+			    IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK)
+				mcs_mask[nss] |= 0x8000;
+		}
+
+		if (mcs_7) {
+			mcs_mask[nss] |= GENMASK(7, 0);
+			mcs_7--;
+		}
+
+		if (mcs_9) {
+			mcs_mask[nss] |= GENMASK(9, 8);
+			mcs_9--;
+		}
+
+		if (mcs_11) {
+			mcs_mask[nss] |= GENMASK(11, 10);
+			mcs_11--;
+		}
+
+		if (mcs_13) {
+			mcs_mask[nss] |= GENMASK(13, 12);
+			mcs_13--;
+		}
+	}
+
+	return 0;
+}
+
+static bool eht_set_mcs_mask(struct genl_info *info, struct wireless_dev *wdev,
+			     struct ieee80211_supported_band *sband,
+			     struct nl80211_txrate_eht *txrate,
+			     u16 mcs[NL80211_EHT_NSS_MAX], unsigned int link_id)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	u16 tx_mcs_mask[NL80211_EHT_NSS_MAX];
+	u8 i;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, wdev->iftype);
+	if (!he_cap)
+		return false;
+
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
+	if (!eht_cap)
+		return false;
+
+	/* Checks for MCS 14 and 15 */
+	if (txrate->mcs[0] & 0x4000) {
+		if (sband->band != NL80211_BAND_6GHZ)
+			return false;
+
+		if (!(eht_cap->eht_cap_elem.phy_cap_info[6] &
+		      IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP))
+			return false;
+	}
+
+	if (txrate->mcs[0] & 0x8000)
+		if (!(eht_cap->eht_cap_elem.phy_cap_info[6] &
+		      IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK))
+			return false;
+
+	if (eht_build_mcs_mask(info, link_id, he_cap, eht_cap, tx_mcs_mask))
+		return false;
+
+	memset(mcs, 0, sizeof(u16) * NL80211_EHT_NSS_MAX);
+	for (i = 0; i < NL80211_EHT_NSS_MAX; i++) {
+		if ((tx_mcs_mask[i] & txrate->mcs[i]) == txrate->mcs[i])
+			mcs[i] = txrate->mcs[i];
+		else
+			return false;
+	}
+
+	return true;
+}
+
 static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					 struct nlattr *attrs[],
 					 enum nl80211_attrs attr,
@@ -5133,6 +5279,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	/* Default to all rates enabled */
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		const struct ieee80211_sta_he_cap *he_cap;
+		const struct ieee80211_sta_eht_cap *eht_cap;
 
 		if (!default_all_enabled)
 			break;
@@ -5161,6 +5308,14 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 
 		mask->control[i].he_gi = 0xFF;
 		mask->control[i].he_ltf = 0xFF;
+
+		eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
+		if (!eht_cap)
+			continue;
+
+		if (eht_build_mcs_mask(info, link_id, he_cap, eht_cap,
+				       mask->control[i].eht_mcs))
+			return -EINVAL;
 	}
 
 	/* if no rates are given set it back to the defaults */
@@ -5232,13 +5387,20 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 			mask->control[band].he_ltf =
 				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
 
+		if (tb[NL80211_TXRATE_EHT] &&
+		    !eht_set_mcs_mask(info, wdev, sband,
+				      nla_data(tb[NL80211_TXRATE_EHT]),
+				      mask->control[band].eht_mcs, link_id))
+			return -EINVAL;
+
 		if (mask->control[band].legacy == 0) {
 			/* don't allow empty legacy rates if HT, VHT or HE
 			 * are not even supported.
 			 */
 			if (!(rdev->wiphy.bands[band]->ht_cap.ht_supported ||
 			      rdev->wiphy.bands[band]->vht_cap.vht_supported ||
-			      ieee80211_get_he_iftype_cap(sband, wdev->iftype)))
+			      ieee80211_get_he_iftype_cap(sband, wdev->iftype) ||
+			      ieee80211_get_eht_iftype_cap(sband, wdev->iftype)))
 				return -EINVAL;
 
 			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
@@ -5253,6 +5415,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				if (mask->control[band].he_mcs[i])
 					goto out;
 
+			for (i = 0; i < NL80211_EHT_NSS_MAX; i++)
+				if (mask->control[band].eht_mcs[i])
+					goto out;
+
 			/* legacy and mcs rates may not be both empty */
 			return -EINVAL;
 		}
@@ -5266,7 +5432,7 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				   enum nl80211_band band,
 				   struct cfg80211_bitrate_mask *beacon_rate)
 {
-	u32 count_ht, count_vht, count_he, i;
+	u32 count_ht, count_vht, count_he, count_eht, i;
 	u32 rate = beacon_rate->control[band].legacy;
 
 	/* Allow only one rate */
@@ -5312,8 +5478,19 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
-	if ((count_ht && count_vht && count_he) ||
-	    (!rate && !count_ht && !count_vht && !count_he))
+	count_eht = 0;
+	for (i = 0; i < NL80211_EHT_NSS_MAX; i++) {
+		if (hweight16(beacon_rate->control[band].eht_mcs[i]) > 1)
+			return -EINVAL;
+		if (beacon_rate->control[band].eht_mcs[i]) {
+			count_eht++;
+			if (rate || count_eht > 1)
+				return -EINVAL;
+		}
+	}
+
+	if ((count_ht && count_vht && count_he && count_eht) ||
+	    (!rate && !count_ht && !count_vht && !count_he && !count_eht))
 		return -EINVAL;
 
 	if (rate &&
@@ -5332,6 +5509,10 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	    !wiphy_ext_feature_isset(&rdev->wiphy,
 				     NL80211_EXT_FEATURE_BEACON_RATE_HE))
 		return -EINVAL;
+	if (count_eht &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_BEACON_RATE_EHT))
+		return -EINVAL;
 
 	return 0;
 }

base-commit: 2af3b2a631b194a43551ce119cb71559d8f6b54b
-- 
2.39.0

