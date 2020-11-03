Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9992A3FCE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgKCJR5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCJRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:17:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C9FC0617A6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:17:52 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsRo-0006BN-Pb; Tue, 03 Nov 2020 10:17:48 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V5 1/4] nl80211: add basic multiple bssid support
Date:   Tue,  3 Nov 2020 10:17:40 +0100
Message-Id: <20201103091743.1924854-2-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103091743.1924854-1-john@phrozen.org>
References: <20201103091743.1924854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for passing the multiple bssid config to the
kernel when an AP gets started. If the BSS is non-transmitting we need
to pass

* the ifidx of the transmitting parent
* the BSS index in the set
* the BSS count of the set
* flag indicating if we want to do EMA
* the multiple bssid elements as an array inside the beacon data

This allows use to generate multiple bssid beacons aswell as EMA ones.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 21 +++++++++++++++++++++
 net/wireless/nl80211.c       | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 661edfc8722e..0be0c11c95fd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -497,6 +497,21 @@ struct ieee80211_supported_band {
 	const struct ieee80211_sband_iftype_data *iftype_data;
 };
 
+/**
+ * struct ieee80211_multiple_bssid - AP settings for multi bssid
+ *
+ * @index: the index of this AP in the multi bssid group.
+ * @count: the total number of multi bssid peer APs.
+ * @parent: non-transmitted BSSs transmitted parents index
+ * @ema: Shall the beacons be sent out in EMA mode.
+ */
+struct ieee80211_multiple_bssid {
+	u8 index;
+	u8 count;
+	u32 parent;
+	bool ema;
+};
+
 /**
  * ieee80211_get_sband_iftype_data - return sband data for a given iftype
  * @sband: the sband to search for the STA on
@@ -1028,6 +1043,19 @@ struct cfg80211_crypto_settings {
 	u8 sae_pwd_len;
 };
 
+/**
+ * struct cfg80211_multiple_bssid_data - multiple_bssid data
+ * @ies: array of extra information element(s) to add into Beacon frames for multiple
+ *	bssid or %NULL
+ * @len: array of lengths of multiple_bssid.ies in octets
+ * @cnt: number of entries in multiple_bssid.ies
+ */
+struct cfg80211_multiple_bssid_data {
+	u8 *ies[NL80211_MULTIPLE_BSSID_IES_MAX];
+	size_t len[NL80211_MULTIPLE_BSSID_IES_MAX];
+	int cnt;
+};
+
 /**
  * struct cfg80211_beacon_data - beacon data
  * @head: head portion of beacon (before TIM IE)
@@ -1054,6 +1082,7 @@ struct cfg80211_crypto_settings {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @multiple_bssid: multiple_bssid data
  */
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
@@ -1072,6 +1101,8 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+
+	struct cfg80211_multiple_bssid_data multiple_bssid;
 };
 
 struct mac_address {
@@ -1176,6 +1207,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @multiple_bssid: AP settings for multiple bssid
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1208,6 +1240,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	struct ieee80211_multiple_bssid multiple_bssid;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 47700a2b9af9..91b338b0b9cb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2527,6 +2527,19 @@ enum nl80211_commands {
  *	override mask. Used with NL80211_ATTR_S1G_CAPABILITY in
  *	NL80211_CMD_ASSOCIATE or NL80211_CMD_CONNECT.
  *
+ * @NL80211_ATTR_MULTIPLE_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
+ *	the parent (transmitting) interface.
+ *
+ * @NL80211_ATTR_MULTIPLE_BSSID_INDEX: The index of this BSS inside the multi bssid
+ *	element.
+ *
+ * @NL80211_ATTR_MULTIPLE_BSSID_COUNT: The number of BSSs inside the multi bssid element.
+ *
+ * @NL80211_ATTR_MULTIPLE_BSSID_IES: The Elements that describe our multiple BSS group.
+ *	these get passed separately as the kernel might need to split them up for EMA VAP.
+ *
+ * @NL80211_ATTR_MULTIPLE_BSSID_EMA: Shall the multiple BSS beacons be sent out in EMA mode.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3016,6 +3029,12 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_CAPABILITY,
 	NL80211_ATTR_S1G_CAPABILITY_MASK,
 
+	NL80211_ATTR_MULTIPLE_BSSID_PARENT,
+	NL80211_ATTR_MULTIPLE_BSSID_INDEX,
+	NL80211_ATTR_MULTIPLE_BSSID_COUNT,
+	NL80211_ATTR_MULTIPLE_BSSID_IES,
+	NL80211_ATTR_MULTIPLE_BSSID_EMA,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3079,6 +3098,8 @@ enum nl80211_attrs {
 
 #define NL80211_CQM_TXE_MAX_INTVL		1800
 
+#define NL80211_MULTIPLE_BSSID_IES_MAX		8
+
 /**
  * enum nl80211_iftype - (virtual) interface types
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 554796a6c6fe..45765d033d05 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -715,6 +715,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
 	[NL80211_ATTR_S1G_CAPABILITY_MASK] =
 		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
+	[NL80211_ATTR_MULTIPLE_BSSID_PARENT] = { .type = NLA_U32 },
+	[NL80211_ATTR_MULTIPLE_BSSID_INDEX] = { .type = NLA_U8 },
+	[NL80211_ATTR_MULTIPLE_BSSID_COUNT] = NLA_POLICY_RANGE(NLA_U8, 1, 16),
+	[NL80211_ATTR_MULTIPLE_BSSID_IES] = { .type = NLA_NESTED },
+	[NL80211_ATTR_MULTIPLE_BSSID_EMA] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -4867,6 +4872,21 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_MULTIPLE_BSSID_IES]) {
+		struct nlattr *nl_ie;
+		int rem_ie;
+
+		nla_for_each_nested(nl_ie, attrs[NL80211_ATTR_MULTIPLE_BSSID_IES], rem_ie) {
+			if (bcn->multiple_bssid.cnt > NL80211_MULTIPLE_BSSID_IES_MAX)
+				return -EINVAL;
+			if (nla_type(nl_ie) != bcn->multiple_bssid.cnt + 1)
+				return -EINVAL;
+			bcn->multiple_bssid.ies[bcn->multiple_bssid.cnt] = nla_data(nl_ie);
+			bcn->multiple_bssid.len[bcn->multiple_bssid.cnt] = nla_len(nl_ie);
+			bcn->multiple_bssid.cnt++;
+		}
+	}
+
 	return 0;
 }
 
@@ -5321,6 +5341,20 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT])
+		params.multiple_bssid.parent =
+			nla_get_u32(info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT]);
+
+	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_INDEX])
+		params.multiple_bssid.index = nla_get_u8(
+				info->attrs[NL80211_ATTR_MULTIPLE_BSSID_INDEX]);
+
+	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_COUNT])
+		params.multiple_bssid.count = nla_get_u8(
+				info->attrs[NL80211_ATTR_MULTIPLE_BSSID_COUNT]);
+	params.multiple_bssid.ema =
+		nla_get_flag(info->attrs[NL80211_ATTR_MULTIPLE_BSSID_EMA]);
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.25.1

