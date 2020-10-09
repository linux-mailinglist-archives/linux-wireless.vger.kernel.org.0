Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5019E2886AD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgJIKPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbgJIKPc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 06:15:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223C3C0613D2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Oct 2020 03:15:32 -0700 (PDT)
Received: from [134.101.218.207] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kQpQv-0004jy-Or; Fri, 09 Oct 2020 12:15:30 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V4 1/4] nl80211: add basic multiple bssid support
Date:   Fri,  9 Oct 2020 12:15:25 +0200
Message-Id: <20201009101528.4780-2-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009101528.4780-1-john@phrozen.org>
References: <20201009101528.4780-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for passing the multiple bssid config to the
kernel when adding an AP gets started. If the BSS is non-transmitting we
need to pass the ifidx of the transmitting parent. The multiple bssid
elements are passed as an array inside the beacon data. This allows use to
generate multiple bssid beacons aswell as EMA ones.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 21 +++++++++++++++++++++
 net/wireless/nl80211.c       | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index aee47f2b5709..20782e9c5aaa 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -496,6 +496,21 @@ struct ieee80211_supported_band {
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
@@ -1027,6 +1042,19 @@ struct cfg80211_crypto_settings {
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
@@ -1053,6 +1081,7 @@ struct cfg80211_crypto_settings {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @multiple_bssid: multiple_bssid data
  */
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
@@ -1071,6 +1100,8 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+
+	struct cfg80211_multiple_bssid_data multiple_bssid;
 };
 
 struct mac_address {
@@ -1175,6 +1206,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @multiple_bssid: AP settings for multiple bssid
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1207,6 +1239,7 @@ struct cfg80211_ap_settings {
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
index 91d4550677d0..ecaa4c8879f3 100644
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
@@ -4864,6 +4869,21 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
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
 
@@ -5318,6 +5338,20 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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

