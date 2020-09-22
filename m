Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E5273A38
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgIVFhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:24 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:33970 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728901AbgIVFhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 882894F9DF4;
        Tue, 22 Sep 2020 05:37:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QOCw1OLEPeLI; Tue, 22 Sep 2020 05:37:20 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D0D604F9DF8;
        Tue, 22 Sep 2020 05:37:17 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 03/17] nl80211: support S1G capabilities
Date:   Mon, 21 Sep 2020 19:28:04 -0700
Message-Id: <20200922022818.15855-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Declare the structures needed to define S1G capabilities.

NL80211_ATTR_S1G_CAPABILITY can be passed along with
NL80211_ATTR_S1G_CAPABILITY_MASK to NL80211_CMD_ASSOCIATE
to indicate S1G capabilities which should override the
hardware capabilities in eg. the association request.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---

v4:
 - nit + use NLA_POLICY_EXACT_LEN() (Johannes)
 - move NL80211_S1G_CAPABILITY_LEN -> ieee80211.h (Johannes)
---
 include/linux/ieee80211.h    |  2 ++
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 17 +++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 53fba39d4ba6..f71cffa18176 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2330,6 +2330,8 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 }
 
 /* S1G Capabilities Information field */
+#define IEEE80211_S1G_CAPABILITY_LEN	15
+
 #define S1G_CAP0_S1G_LONG	BIT(0)
 #define S1G_CAP0_SGI_1MHZ	BIT(1)
 #define S1G_CAP0_SGI_2MHZ	BIT(2)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 10c2cc8f0efc..6d242ce8c520 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2528,6 +2528,8 @@ enum cfg80211_assoc_req_flags {
  * @fils_nonces: FILS nonces (part of AAD) for protecting (Re)Association
  *	Request/Response frame or %NULL if FILS is not used. This field starts
  *	with 16 octets of STA Nonce followed by 16 octets of AP Nonce.
+ * @s1g_capa: S1G capability override
+ * @s1g_capa_mask: S1G capability override mask
  */
 struct cfg80211_assoc_request {
 	struct cfg80211_bss *bss;
@@ -2542,6 +2544,7 @@ struct cfg80211_assoc_request {
 	const u8 *fils_kek;
 	size_t fils_kek_len;
 	const u8 *fils_nonces;
+	struct ieee80211_s1g_cap s1g_capa, s1g_capa_mask;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bdc90b8dfd24..84b37932f80f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2521,6 +2521,12 @@ enum nl80211_commands {
  *	unsolicited broadcast probe response. It is a nested attribute, see
  *	&enum nl80211_unsol_bcast_probe_resp_attributes.
  *
+ * @NL80211_ATTR_S1G_CAPABILITY: S1G Capability information element (from
+ *	association request when used with NL80211_CMD_NEW_STATION)
+ * @NL80211_ATTR_S1G_CAPABILITY_MASK: S1G Capability Information element
+ *	override mask. Used with NL80211_ATTR_S1G_CAPABILITY in
+ *	NL80211_CMD_ASSOCIATE or NL80211_CMD_CONNECT.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3007,6 +3013,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_UNSOL_BCAST_PROBE_RESP,
 
+	NL80211_ATTR_S1G_CAPABILITY,
+	NL80211_ATTR_S1G_CAPABILITY_MASK,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1a212db7a300..fe25ac23d7e9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -704,6 +704,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_fils_discovery_policy),
 	[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP] =
 		NLA_POLICY_NESTED(nl80211_unsol_bcast_probe_resp_policy),
+	[NL80211_ATTR_S1G_CAPABILITY] =
+		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
+	[NL80211_ATTR_S1G_CAPABILITY_MASK] =
+		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
 };
 
 /* policy for the key attributes */
@@ -9792,6 +9796,19 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			nla_data(info->attrs[NL80211_ATTR_FILS_NONCES]);
 	}
 
+	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY_MASK])
+		memcpy(&req.s1g_capa_mask,
+		       nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY_MASK]),
+		       sizeof(req.s1g_capa_mask));
+
+	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY]) {
+		if (!info->attrs[NL80211_ATTR_S1G_CAPABILITY_MASK])
+			return -EINVAL;
+		memcpy(&req.s1g_capa,
+		       nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]),
+		       sizeof(req.s1g_capa));
+	}
+
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
 	if (!err) {
 		wdev_lock(dev->ieee80211_ptr);
-- 
2.20.1

