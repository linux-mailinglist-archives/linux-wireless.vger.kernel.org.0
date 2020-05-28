Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F61E6F55
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 00:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437273AbgE1WnZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 18:43:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64770 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437076AbgE1WnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 18:43:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590705802; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hySI25lC4e9I+AGlBCntZ59v9h0qDPXapukEFpgoQes=; b=ZRdOnNdW60j8s7maBvdwyWLxRPN1KJScizG6a46HcQCsX6ILy+J0fwio2ftUwUGkv2k4UFfw
 r9gzGqYD9qYqOHkljtGOBEr+AjhDoFKweSzmJhDfFeULb3KlRKN7Zb5/+Jaa1TCWhZkDwp/e
 hENlzOsfdvHUwXR/SE5kIfSoCjs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed03e86c28b2cdd985959ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 22:43:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A99BC433C6; Thu, 28 May 2020 22:43:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC2FAC433CA;
        Thu, 28 May 2020 22:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC2FAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH] nl80211: Add HE UL MU fixed rate setting
Date:   Thu, 28 May 2020 15:43:09 -0700
Message-Id: <1590705789-20910-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds nl80211 definitions, policies and parsing code required
to pass HE UL MU fixed rate settings.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 include/net/cfg80211.h       | 1 +
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 96bf879c049b..a6cc2c8a8c92 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1039,6 +1039,7 @@ struct cfg80211_bitrate_mask {
 		enum nl80211_txrate_gi gi;
 		enum nl80211_he_gi he_gi;
 		enum nl80211_he_ltf he_ltf;
+		u16 he_ul_mcs[NL80211_HE_NSS_MAX];
 	} control[NUM_NL80211_BANDS];
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 69e2cf22a329..e418c6be9494 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4685,6 +4685,7 @@ enum nl80211_key_attributes {
  *	see &struct nl80211_txrate_he
  * @NL80211_TXRATE_HE_GI: configure HE GI, 0.8us, 1.6us and 3.2us.
  * @NL80211_TXRATE_HE_LTF: configure HE LTF, 1XLTF, 2XLTF and 4XLTF.
+ * @NL80211_TXRATE_HE_UL: HE MCS rates of connected HE STA for uplink traffic.
  * @__NL80211_TXRATE_AFTER_LAST: internal
  * @NL80211_TXRATE_MAX: highest TX rate attribute
  */
@@ -4697,6 +4698,7 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HE,
 	NL80211_TXRATE_HE_GI,
 	NL80211_TXRATE_HE_LTF,
+	NL80211_TXRATE_HE_UL,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33f1ad127e8f..b057168941c9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4467,6 +4467,10 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
 						   NL80211_RATE_INFO_HE_1XLTF,
 						   NL80211_RATE_INFO_HE_4XLTF),
+	[NL80211_TXRATE_HE_UL] = {
+		.type = NLA_EXACT_LEN,
+		.len = sizeof(struct nl80211_txrate_he),
+	},
 };
 
 static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
@@ -4575,6 +4579,11 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 		if (tb[NL80211_TXRATE_HE_LTF])
 			mask->control[band].he_ltf =
 				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
+		if (tb[NL80211_TXRATE_HE_UL] &&
+		    !he_set_mcs_mask(info, sband,
+				     nla_data(tb[NL80211_TXRATE_HE_UL]),
+				     mask->control[band].he_ul_mcs))
+			return -EINVAL;
 
 		if (mask->control[band].legacy == 0) {
 			/* don't allow empty legacy rates if HT or VHT
-- 
2.7.4

