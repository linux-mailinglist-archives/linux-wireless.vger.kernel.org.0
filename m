Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43312310F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfLQQFH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 11:05:07 -0500
Received: from nbd.name ([46.4.11.11]:48384 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfLQQFH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 11:05:07 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihFLL-0002Ku-NX; Tue, 17 Dec 2019 17:05:03 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/3] nl80211: add support for setting fixed HE rate/gi/ltf
Date:   Tue, 17 Dec 2019 17:04:53 +0100
Message-Id: <20191217160455.311-1-john@phrozen.org>
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

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
---
 include/net/cfg80211.h       |   4 ++
 include/uapi/linux/nl80211.h |  28 +++++++++
 net/wireless/nl80211.c       | 111 ++++++++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fed307d9a4fe..cf2350dd7a79 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -386,6 +386,7 @@ struct ieee80211_supported_band {
 	int n_bitrates;
 	struct ieee80211_sta_ht_cap ht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
+	struct ieee80211_sta_he_cap he_cap;
 	u16 n_iftype_data;
 	const struct ieee80211_sband_iftype_data *iftype_data;
 };
@@ -888,7 +889,10 @@ struct cfg80211_bitrate_mask {
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
index fd5028459c3a..4c7c5c881f24 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3013,6 +3013,18 @@ enum nl80211_he_gi {
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
@@ -4510,6 +4522,10 @@ enum nl80211_key_attributes {
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
@@ -4519,6 +4535,9 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HT,
 	NL80211_TXRATE_VHT,
 	NL80211_TXRATE_GI,
+	NL80211_TXRATE_HE,
+	NL80211_TXRATE_HE_GI,
+	NL80211_TXRATE_HE_LTF,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
@@ -4536,6 +4555,15 @@ struct nl80211_txrate_vht {
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
index 65e33db93633..de4e33869061 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4161,6 +4161,80 @@ static bool vht_set_mcs_mask(struct ieee80211_supported_band *sband,
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
+
+	switch (wdev->chandef.width) {
+	case NL80211_CHAN_WIDTH_80P80:
+		return he_cap->he_mcs_nss_supp.tx_mcs_80p80;
+	case NL80211_CHAN_WIDTH_160:
+		return he_cap->he_mcs_nss_supp.tx_mcs_160;
+	default:
+		break;
+	}
+	return he_cap->he_mcs_nss_supp.tx_mcs_80;
+}
+
+static bool he_set_mcs_mask(struct genl_info *info,
+			    struct ieee80211_supported_band *sband,
+			    struct nl80211_txrate_he *txrate,
+			    u16 mcs[NL80211_HE_NSS_MAX])
+{
+	u16 tx_mcs_map = 0;
+	u16 tx_mcs_mask[NL80211_HE_NSS_MAX] = {};
+	u8 i;
+
+	if (!sband->iftype_data->he_cap.has_he)
+		return false;
+
+	memset(mcs, 0, sizeof(u16) * NL80211_HE_NSS_MAX);
+
+	tx_mcs_map = le16_to_cpu(he_get_txmcsmap(info, &sband->iftype_data->he_cap));
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
@@ -4170,6 +4244,10 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 		.type = NLA_EXACT_LEN_WARN,
 		.len = sizeof(struct nl80211_txrate_vht),
 	},
+	[NL80211_TXRATE_HE] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = sizeof(struct nl80211_txrate_he),
+	},
 	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
 };
 
@@ -4181,7 +4259,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	int rem, i;
 	struct nlattr *tx_rates;
 	struct ieee80211_supported_band *sband;
-	u16 vht_tx_mcs_map;
+	u16 vht_tx_mcs_map, he_tx_mcs_map;
 
 	memset(mask, 0, sizeof(*mask));
 	/* Default to all rates enabled */
@@ -4201,6 +4279,13 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 
 		vht_tx_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
 		vht_build_mcs_mask(vht_tx_mcs_map, mask->control[i].vht_mcs);
+
+		he_tx_mcs_map = he_get_txmcsmap(info, &sband->iftype_data->he_cap);
+		he_tx_mcs_map = le16_to_cpu(he_tx_mcs_map);
+		he_build_mcs_mask(he_tx_mcs_map, mask->control[i].he_mcs);
+
+		mask->control[i].he_gi = 0xFF;
+		mask->control[i].he_ltf = 0xFF;
 	}
 
 	/* if no rates are given set it back to the defaults */
@@ -4256,13 +4341,31 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 			if (mask->control[band].gi > NL80211_TXRATE_FORCE_LGI)
 				return -EINVAL;
 		}
+		if (tb[NL80211_TXRATE_HE]) {
+			if (!he_set_mcs_mask(info, sband, nla_data(tb[NL80211_TXRATE_HE]),
+					     mask->control[band].he_mcs))
+				return -EINVAL;
+		}
+		if (tb[NL80211_TXRATE_HE_GI]) {
+			mask->control[band].he_gi =
+				nla_get_u8(tb[NL80211_TXRATE_HE_GI]);
+			if (mask->control[band].he_gi > NL80211_RATE_INFO_HE_GI_3_2)
+				return -EINVAL;
+		}
+		if (tb[NL80211_TXRATE_HE_LTF]) {
+			mask->control[band].he_ltf =
+				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
+			if (mask->control[band].he_ltf > NL80211_RATE_INFO_HE_4XLTF)
+				return -EINVAL;
+		}
 
 		if (mask->control[band].legacy == 0) {
 			/* don't allow empty legacy rates if HT or VHT
 			 * are not even supported.
 			 */
 			if (!(rdev->wiphy.bands[band]->ht_cap.ht_supported ||
-			      rdev->wiphy.bands[band]->vht_cap.vht_supported))
+			      rdev->wiphy.bands[band]->vht_cap.vht_supported ||
+			      rdev->wiphy.bands[band]->he_cap.has_he))
 				return -EINVAL;
 
 			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
@@ -4273,6 +4376,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
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

