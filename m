Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146D21C36AB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgEDKVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 06:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728253AbgEDKU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 06:20:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F4C061A0F
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 03:20:58 -0700 (PDT)
Received: from [149.224.141.1] (helo=bertha8.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jVYDX-0000o1-Sk; Mon, 04 May 2020 12:20:55 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V4 1/3] nl80211: add support for setting fixed HE rate/gi/ltf
Date:   Mon,  4 May 2020 12:20:49 +0200
Message-Id: <20200504102051.6438-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

This patch adds the nl80211 structs, definitions, policies and parsing
code required to pass fixed HE rate, gi and ltf settings.

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
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

 include/net/cfg80211.h       |  25 +++++++
 include/uapi/linux/nl80211.h |  28 ++++++++
 net/wireless/nl80211.c       | 123 ++++++++++++++++++++++++++++++++++-
 3 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c78bd4ff9e33..deaa3668d47a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -495,6 +495,28 @@ ieee80211_get_he_iftype_cap(const struct ieee80211_supported_band *sband,
 	return NULL;
 }
 
+/**
+ * ieee80211_get_he_cap - return the first he_cap that we find for a sband
+ * @sband: the sband that we want to check for HE support
+ *
+ * Return: return a valid he_cap or NULL
+ */
+static inline const struct ieee80211_sta_he_cap *
+ieee80211_get_he_cap(const struct ieee80211_supported_band *sband)
+{
+	int i;
+
+	for (i = 0; i < sband->n_iftype_data; i++)  {
+		const struct ieee80211_sband_iftype_data *data =
+			&sband->iftype_data[i];
+
+		if (data->he_cap.has_he)
+			return &data->he_cap;
+	}
+
+	return NULL;
+}
+
 /**
  * ieee80211_get_he_sta_cap - return HE capabilities for an sband's STA
  * @sband: the sband to search for the STA on
@@ -1006,7 +1028,10 @@ struct cfg80211_bitrate_mask {
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
index 2b691161830f..966887bd654c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3134,6 +3134,18 @@ enum nl80211_he_gi {
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
@@ -4653,6 +4665,10 @@ enum nl80211_key_attributes {
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
@@ -4662,6 +4678,9 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HT,
 	NL80211_TXRATE_VHT,
 	NL80211_TXRATE_GI,
+	NL80211_TXRATE_HE,
+	NL80211_TXRATE_HE_GI,
+	NL80211_TXRATE_HE_LTF,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -4679,6 +4698,15 @@ struct nl80211_txrate_vht {
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
index 5fa402144cda..ed545b2a958d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4403,6 +4403,87 @@ static bool vht_set_mcs_mask(struct ieee80211_supported_band *sband,
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
+			    struct ieee80211_supported_band *sband,
+			    struct nl80211_txrate_he *txrate,
+			    u16 mcs[NL80211_HE_NSS_MAX])
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	u16 tx_mcs_mask[NL80211_HE_NSS_MAX] = {};
+	u16 tx_mcs_map = 0;
+	u8 i;
+
+	he_cap = ieee80211_get_he_cap(sband);
+
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
 static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 	[NL80211_TXRATE_LEGACY] = { .type = NLA_BINARY,
 				    .len = NL80211_MAX_SUPP_RATES },
@@ -4413,6 +4494,16 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 		.len = sizeof(struct nl80211_txrate_vht),
 	},
 	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
+	[NL80211_TXRATE_HE] = {
+		.type = NLA_EXACT_LEN,
+		.len = sizeof(struct nl80211_txrate_he),
+	},
+	[NL80211_TXRATE_HE_GI] =  NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_HE_GI_0_8,
+						   NL80211_RATE_INFO_HE_GI_3_2),
+	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_HE_1XLTF,
+						   NL80211_RATE_INFO_HE_4XLTF),
 };
 
 static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
@@ -4423,11 +4514,13 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
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
@@ -4443,6 +4536,16 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 
 		vht_tx_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
 		vht_build_mcs_mask(vht_tx_mcs_map, mask->control[i].vht_mcs);
+
+		he_cap = ieee80211_get_he_cap(sband);
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
@@ -4498,13 +4601,25 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 			if (mask->control[band].gi > NL80211_TXRATE_FORCE_LGI)
 				return -EINVAL;
 		}
+		if (tb[NL80211_TXRATE_HE] &&
+		    !he_set_mcs_mask(info, sband,
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
+			      ieee80211_get_he_cap(rdev->wiphy.bands[band])))
 				return -EINVAL;
 
 			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
@@ -4515,6 +4630,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				if (mask->control[band].vht_mcs[i])
 					goto out;
 
+			for (i = 0; i < NL80211_HE_NSS_MAX; i++)
+				if (mask->control[band].he_mcs[i])
+					goto out;
+
 			/* legacy and mcs rates may not be both empty */
 			return -EINVAL;
 		}
-- 
2.20.1

