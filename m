Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB3F1C0A4F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 00:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgD3WVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 18:21:31 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59894 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727850AbgD3WVb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 18:21:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588285291; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hiGeAG8v37l3WG8lFHQP4B3vaVMogqoRQFmN8YZJCY8=; b=gCZvEgWel2BCBa0gx3jRS8CvPfbQ1TZH9VGPonecNNJtBcOFuDnte8/i/zsIb/yI2qIrMvFh
 8Oc0dnfwTh55+Oe9BqzUSbiOxUSmYByVkIkx9muPnVn9lGdFyc3Vy+ZA01s9iM194DKLaC6U
 dBypE/Br5mYA5MM4Q9XF5z+x5ok=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eab4f57.7fa7510dc5a8-smtp-out-n02;
 Thu, 30 Apr 2020 22:21:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17C9EC433D2; Thu, 30 Apr 2020 22:21:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65A55C433CB;
        Thu, 30 Apr 2020 22:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65A55C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v2 02/11] cfg80211: handle 6 GHz capability of new station
Date:   Thu, 30 Apr 2020 15:20:43 -0700
Message-Id: <1588285252-30034-2-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
References: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle 6 GHz HE capability while adding new station. It will be used
later in mac80211 station processing.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 70e48f66dac8..0797a296c083 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1225,6 +1225,7 @@ struct sta_txpwr {
  * @he_capa_len: the length of the HE capabilities
  * @airtime_weight: airtime scheduler weight for this station
  * @txpwr: transmit power for an associated station
+ * @he_6ghz_capa: HE 6 GHz Band capabilities of station
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -1257,6 +1258,7 @@ struct station_parameters {
 	u8 he_capa_len;
 	u16 airtime_weight;
 	struct sta_txpwr txpwr;
+	const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..9c0a912f1684 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2470,6 +2470,9 @@ enum nl80211_commands {
  *	no roaming occurs between the reauth threshold and PMK expiration,
  *	disassociation is still forced.
  *
+ * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
+ *	association request when used with NL80211_CMD_NEW_STATION).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2945,6 +2948,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_PMK_LIFETIME,
 	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
 
+	NL80211_ATTR_HE_6GHZ_CAPABILITY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -2998,6 +3003,7 @@ enum nl80211_attrs {
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
 #define NL80211_MAX_NR_AKM_SUITES		2
+#define NL80211_HE_6GHZ_CAPABILITY_LEN		2
 
 #define NL80211_MIN_REMAIN_ON_CHANNEL_TIME	10
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd35f809..bcd7a452e8b1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -661,6 +661,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
+	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
+		.type = NLA_EXACT_LEN,
+		.len = NL80211_HE_6GHZ_CAPABILITY_LEN,
+	},
 };
 
 /* policy for the key attributes */
@@ -6129,6 +6133,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
+		params.he_6ghz_capa =
+			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
 		params.opmode_notif_used = true;
 		params.opmode_notif =
@@ -6177,6 +6185,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
+	if (params.he_6ghz_capa && (params.ht_capa || params.vht_capa))
+		return -EINVAL;
+
 	/* When you run into this, adjust the code below for the new flag */
 	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
 
-- 
2.7.4
