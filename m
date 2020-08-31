Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5562258311
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgHaU4X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:23 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52258 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729579AbgHaU4V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5F8AC4F8FD1;
        Mon, 31 Aug 2020 20:56:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JkVdohn1JObb; Mon, 31 Aug 2020 20:56:17 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 410D54F8DB8;
        Mon, 31 Aug 2020 20:56:09 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 08/22] nl80211: support S1G capabilities
Date:   Mon, 31 Aug 2020 13:55:46 -0700
Message-Id: <20200831205600.21058-9-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
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
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 16 ++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d3d85bd9c0aa..de04c7996b27 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2489,6 +2489,8 @@ enum cfg80211_assoc_req_flags {
  * @fils_nonces: FILS nonces (part of AAD) for protecting (Re)Association
  *	Request/Response frame or %NULL if FILS is not used. This field starts
  *	with 16 octets of STA Nonce followed by 16 octets of AP Nonce.
+ * @s1g_capa: S1G capability override
+ * @s1g_capa_mask: S1G capability override mask
  */
 struct cfg80211_assoc_request {
 	struct cfg80211_bss *bss;
@@ -2503,6 +2505,7 @@ struct cfg80211_assoc_request {
 	const u8 *fils_kek;
 	size_t fils_kek_len;
 	const u8 *fils_nonces;
+	struct ieee80211_s1g_cap s1g_capa, s1g_capa_mask;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e119c6afa31..70076492ebc9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2513,6 +2513,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
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
@@ -2995,6 +3001,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_S1G_CAPABILITY,
+	NL80211_ATTR_S1G_CAPABILITY_MASK,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3046,6 +3054,7 @@ enum nl80211_attrs {
 #define NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY	24
 #define NL80211_HT_CAPABILITY_LEN		26
 #define NL80211_VHT_CAPABILITY_LEN		12
+#define NL80211_S1G_CAPABILITY_LEN		15
 #define NL80211_HE_MIN_CAPABILITY_LEN           16
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3bf595c828db..578d99088719 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -685,6 +685,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
 	[NL80211_ATTR_HE_6GHZ_CAPABILITY] =
 		NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
+	[NL80211_ATTR_S1G_CAPABILITY] = { .len = NL80211_S1G_CAPABILITY_LEN },
+	[NL80211_ATTR_S1G_CAPABILITY_MASK] = {
+					.len = NL80211_S1G_CAPABILITY_LEN },
 };
 
 /* policy for the key attributes */
@@ -9698,6 +9701,19 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
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

