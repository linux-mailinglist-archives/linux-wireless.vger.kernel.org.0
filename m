Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6623B6AB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 10:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgHDIQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgHDIQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 04:16:44 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE6C061756
        for <linux-wireless@vger.kernel.org>; Tue,  4 Aug 2020 01:16:44 -0700 (PDT)
Received: from [46.59.157.105] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k2s7i-0005Vr-UV; Tue, 04 Aug 2020 10:16:39 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V6 1/2] nl80211: add support for setting fixed HE rate/gi/ltf
Date:   Tue,  4 Aug 2020 10:16:29 +0200
Message-Id: <20200804081630.2013619-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

This patch adds the nl80211 structs, definitions, policies and parsing
code required to pass fixed HE rate, GI and LTF settings.

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in V6
* use dev and not skb->dev
* remove _WARN from policy
* fix description

Changes in V5
* use ieee80211_get_he_iftype_cap

Changes in V4
* fix sparse warnings

Changes in V3
* minor cleanup based on Johannes's feedback
* properly make use the iftype_data array

Changes in V2
* add more policies
* reoder enums
* remove incorrect he_cap from ieee80211_supported_band
* remove _WARN from policy

 include/net/cfg80211.h       |   3 +
 include/uapi/linux/nl80211.h |  28 ++++++++
 net/wireless/nl80211.c       | 135 +++++++++++++++++++++++++++++++++--
 3 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d9e6b9fbd95b..c9bce9bba511 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -678,7 +678,10 @@ struct cfg80211_bitrate_mask {
 		u32 legacy;
 		u8 ht_mcs[IEEE80211_HT_MCS_MASK_LEN];
 		u16 vht_mcs[NL80211_VHT_NSS_MAX];
+		u16 he_mcs[NL80211_HE_NSS_MAX];
 		enum nl80211_txrate_gi gi;
+		enum nl80211_he_gi he_gi;
+		enum nl80211_he_ltf he_ltf;
 	} control[NUM_NL80211_BANDS];
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 631f3a997b3c..7d853fae9571 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3186,6 +3186,18 @@ enum nl80211_he_gi {
 	NL80211_RATE_INFO_HE_GI_3_2,
 };
 
+/**
+ * enum nl80211_he_ltf - HE long training field
+ * @NL80211_RATE_INFO_HE_1xLTF: 3.2 usec
+ * @NL80211_RATE_INFO_HE_2xLTF: 6.4 usec
+ * @NL80211_RATE_INFO_HE_4xLTF: 12.8 usec
+ */
+enum nl80211_he_ltf {
+	NL80211_RATE_INFO_HE_1XLTF,
+	NL80211_RATE_INFO_HE_2XLTF,
+	NL80211_RATE_INFO_HE_4XLTF,
+};
+
 /**
  * enum nl80211_he_ru_alloc - HE RU allocation values
  * @NL80211_RATE_INFO_HE_RU_ALLOC_26: 26-tone RU allocation
@@ -4741,6 +4753,10 @@ enum nl80211_key_attributes {
  * @NL80211_TXRATE_VHT: VHT rates allowed for TX rate selection,
  *	see &struct nl80211_txrate_vht
  * @NL80211_TXRATE_GI: configure GI, see &enum nl80211_txrate_gi
+ * @NL80211_TXRATE_HE: HE rates allowed for TX rate selection,
+ *	see &struct nl80211_txrate_he
+ * @NL80211_TXRATE_HE_GI: configure HE GI, 0.8us, 1.6us and 3.2us.
+ * @NL80211_TXRATE_HE_LTF: configure HE LTF, 1XLTF, 2XLTF and 4XLTF.
  * @__NL80211_TXRATE_AFTER_LAST: internal
  * @NL80211_TXRATE_MAX: highest TX rate attribute
  */
@@ -4750,6 +4766,9 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HT,
 	NL80211_TXRATE_VHT,
 	NL80211_TXRATE_GI,
+	NL80211_TXRATE_HE,
+	NL80211_TXRATE_HE_GI,
+	NL80211_TXRATE_HE_LTF,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -4767,6 +4786,15 @@ struct nl80211_txrate_vht {
 	__u16 mcs[NL80211_VHT_NSS_MAX];
 };
 
+#define NL80211_HE_NSS_MAX		8
+/**
+ * struct nl80211_txrate_he - HE MCS/NSS txrate bitmap
+ * @mcs: MCS bitmap table for each NSS (array index 0 for 1 stream, etc.)
+ */
+struct nl80211_txrate_he {
+	__u16 mcs[NL80211_HE_NSS_MAX];
+};
+
 enum nl80211_txrate_gi {
 	NL80211_TXRATE_DEFAULT_GI,
 	NL80211_TXRATE_FORCE_SGI,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a096682ec0ad..0515c7acfb0c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -336,6 +336,13 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 				.len = NL80211_MAX_SUPP_HT_RATES },
 	[NL80211_TXRATE_VHT] = NLA_POLICY_EXACT_LEN_WARN(sizeof(struct nl80211_txrate_vht)),
 	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
+	[NL80211_TXRATE_HE] = NLA_POLICY_EXACT_LEN(sizeof(struct nl80211_txrate_he)),
+	[NL80211_TXRATE_HE_GI] =  NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_HE_GI_0_8,
+						   NL80211_RATE_INFO_HE_GI_3_2),
+	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_HE_1XLTF,
+						   NL80211_RATE_INFO_HE_4XLTF),
 };
 
 static const struct nla_policy
@@ -4419,21 +4426,106 @@ static bool vht_set_mcs_mask(struct ieee80211_supported_band *sband,
 	return true;
 }
 
+static u16 he_mcs_map_to_mcs_mask(u8 he_mcs_map)
+{
+	switch (he_mcs_map) {
+	case IEEE80211_HE_MCS_NOT_SUPPORTED:
+		return 0;
+	case IEEE80211_HE_MCS_SUPPORT_0_7:
+		return 0x00FF;
+	case IEEE80211_HE_MCS_SUPPORT_0_9:
+		return 0x03FF;
+	case IEEE80211_HE_MCS_SUPPORT_0_11:
+		return 0xFFF;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static void he_build_mcs_mask(u16 he_mcs_map,
+			      u16 he_mcs_mask[NL80211_HE_NSS_MAX])
+{
+	u8 nss;
+
+	for (nss = 0; nss < NL80211_HE_NSS_MAX; nss++) {
+		he_mcs_mask[nss] = he_mcs_map_to_mcs_mask(he_mcs_map & 0x03);
+		he_mcs_map >>= 2;
+	}
+}
+
+static u16 he_get_txmcsmap(struct genl_info *info,
+			   const struct ieee80211_sta_he_cap *he_cap)
+{
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	__le16	tx_mcs;
+
+	switch (wdev->chandef.width) {
+	case NL80211_CHAN_WIDTH_80P80:
+		tx_mcs = he_cap->he_mcs_nss_supp.tx_mcs_80p80;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		tx_mcs = he_cap->he_mcs_nss_supp.tx_mcs_160;
+		break;
+	default:
+		tx_mcs = he_cap->he_mcs_nss_supp.tx_mcs_80;
+		break;
+	}
+	return le16_to_cpu(tx_mcs);
+}
+
+static bool he_set_mcs_mask(struct genl_info *info,
+			    struct wireless_dev *wdev,
+			    struct ieee80211_supported_band *sband,
+			    struct nl80211_txrate_he *txrate,
+			    u16 mcs[NL80211_HE_NSS_MAX])
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	u16 tx_mcs_mask[NL80211_HE_NSS_MAX] = {};
+	u16 tx_mcs_map = 0;
+	u8 i;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, wdev->iftype);
+	if (!he_cap)
+		return false;
+
+	memset(mcs, 0, sizeof(u16) * NL80211_HE_NSS_MAX);
+
+	tx_mcs_map = he_get_txmcsmap(info, he_cap);
+
+	/* Build he_mcs_mask from HE capabilities */
+	he_build_mcs_mask(tx_mcs_map, tx_mcs_mask);
+
+	for (i = 0; i < NL80211_HE_NSS_MAX; i++) {
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
-					 struct cfg80211_bitrate_mask *mask)
+					 struct cfg80211_bitrate_mask *mask,
+					 struct net_device *dev)
 {
 	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int rem, i;
 	struct nlattr *tx_rates;
 	struct ieee80211_supported_band *sband;
-	u16 vht_tx_mcs_map;
+	u16 vht_tx_mcs_map, he_tx_mcs_map;
 
 	memset(mask, 0, sizeof(*mask));
 	/* Default to all rates enabled */
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
+		const struct ieee80211_sta_he_cap *he_cap;
+
 		sband = rdev->wiphy.bands[i];
 
 		if (!sband)
@@ -4449,6 +4541,16 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 
 		vht_tx_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
 		vht_build_mcs_mask(vht_tx_mcs_map, mask->control[i].vht_mcs);
+
+		he_cap = ieee80211_get_he_iftype_cap(sband, wdev->iftype);
+		if (!he_cap)
+			continue;
+
+		he_tx_mcs_map = he_get_txmcsmap(info, he_cap);
+		he_build_mcs_mask(he_tx_mcs_map, mask->control[i].he_mcs);
+
+		mask->control[i].he_gi = 0xFF;
+		mask->control[i].he_ltf = 0xFF;
 	}
 
 	/* if no rates are given set it back to the defaults */
@@ -4504,13 +4606,25 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 			if (mask->control[band].gi > NL80211_TXRATE_FORCE_LGI)
 				return -EINVAL;
 		}
+		if (tb[NL80211_TXRATE_HE] &&
+		    !he_set_mcs_mask(info, wdev, sband,
+				     nla_data(tb[NL80211_TXRATE_HE]),
+				     mask->control[band].he_mcs))
+			return -EINVAL;
+		if (tb[NL80211_TXRATE_HE_GI])
+			mask->control[band].he_gi =
+				nla_get_u8(tb[NL80211_TXRATE_HE_GI]);
+		if (tb[NL80211_TXRATE_HE_LTF])
+			mask->control[band].he_ltf =
+				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
 
 		if (mask->control[band].legacy == 0) {
 			/* don't allow empty legacy rates if HT or VHT
 			 * are not even supported.
 			 */
 			if (!(rdev->wiphy.bands[band]->ht_cap.ht_supported ||
-			      rdev->wiphy.bands[band]->vht_cap.vht_supported))
+			      rdev->wiphy.bands[band]->vht_cap.vht_supported ||
+			      ieee80211_get_he_iftype_cap(sband, wdev->iftype)))
 				return -EINVAL;
 
 			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
@@ -4521,6 +4635,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				if (mask->control[band].vht_mcs[i])
 					goto out;
 
+			for (i = 0; i < NL80211_HE_NSS_MAX; i++)
+				if (mask->control[band].he_mcs[i])
+					goto out;
+
 			/* legacy and mcs rates may not be both empty */
 			return -EINVAL;
 		}
@@ -4966,7 +5084,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
-						    &params.beacon_rate);
+						    &params.beacon_rate,
+						    dev);
 		if (err)
 			return err;
 
@@ -10799,7 +10918,8 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 		return -EOPNOTSUPP;
 
 	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
-					    NL80211_ATTR_TX_RATES, &mask);
+					    NL80211_ATTR_TX_RATES, &mask,
+					    dev);
 	if (err)
 		return err;
 
@@ -11407,7 +11527,8 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
-						    &setup.beacon_rate);
+						    &setup.beacon_rate,
+						    dev);
 		if (err)
 			return err;
 
@@ -14203,7 +14324,7 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
 			attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
 			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
-						    &tid_conf->txrate_mask);
+						    &tid_conf->txrate_mask, dev);
 			if (err)
 				return err;
 
-- 
2.25.1

