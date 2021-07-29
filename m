Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D07E3DABF6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhG2TmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 15:42:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46019 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhG2TmZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 15:42:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627587741; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oj9aoRDqvxYQKmFYD9c0RSHhaUvfuUqLJJKlhAbD4BE=; b=ks9sjIE/2CRBlCQEtzDiXdaORZgF0BBt9nlB7BNb9pTtTadxnruCeMNvNIEvFoCw9LBZB0Xl
 azD/WviM4v0zQFtwqW15/C7SRXjlZdEyFDrONkw6rMW2afiwT+ykcGZ/ANCUc3iUGVJ44tvr
 4KTzaNDPhoVCGoVhdXvkDaWoPkQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61030487e81205dd0adc581e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 19:41:59
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84645C4338A; Thu, 29 Jul 2021 19:41:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72901C433F1;
        Thu, 29 Jul 2021 19:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72901C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH v2] nl80211: Add HE UL MU fixed rate setting
Date:   Thu, 29 Jul 2021 12:41:41 -0700
Message-Id: <1627587701-13134-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
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
index 161cdf7df1a0..6aa10479a2ce 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -694,6 +694,7 @@ struct cfg80211_bitrate_mask {
 		enum nl80211_txrate_gi gi;
 		enum nl80211_he_gi he_gi;
 		enum nl80211_he_ltf he_ltf;
+		u16 he_ul_mcs[NL80211_HE_NSS_MAX];
 	} control[NUM_NL80211_BANDS];
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index db474994fa73..db40b34eec06 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4839,6 +4839,7 @@ enum nl80211_key_attributes {
  *	see &struct nl80211_txrate_he
  * @NL80211_TXRATE_HE_GI: configure HE GI, 0.8us, 1.6us and 3.2us.
  * @NL80211_TXRATE_HE_LTF: configure HE LTF, 1XLTF, 2XLTF and 4XLTF.
+ * @NL80211_TXRATE_HE_UL: HE MCS rates of connected HE STA for uplink traffic.
  * @__NL80211_TXRATE_AFTER_LAST: internal
  * @NL80211_TXRATE_MAX: highest TX rate attribute
  */
@@ -4851,6 +4852,7 @@ enum nl80211_tx_rate_attributes {
 	NL80211_TXRATE_HE,
 	NL80211_TXRATE_HE_GI,
 	NL80211_TXRATE_HE_LTF,
+	NL80211_TXRATE_HE_UL,
 
 	/* keep last */
 	__NL80211_TXRATE_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 50eb405b0690..e3ed33940185 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -384,6 +384,7 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 	[NL80211_TXRATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
 						   NL80211_RATE_INFO_HE_1XLTF,
 						   NL80211_RATE_INFO_HE_4XLTF),
+	[NL80211_TXRATE_HE_UL] = NLA_POLICY_EXACT_LEN(sizeof(struct nl80211_txrate_he)),
 };
 
 static const struct nla_policy
@@ -4869,6 +4870,14 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 		if (tb[NL80211_TXRATE_HE_LTF])
 			mask->control[band].he_ltf =
 				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
+		if (tb[NL80211_TXRATE_HE_UL] &&
+		    !he_set_mcs_mask(info, wdev, sband,
+				     nla_data(tb[NL80211_TXRATE_HE_UL]),
+				     mask->control[band].he_ul_mcs)) {
+			NL_SET_ERR_MSG(info->extack,
+					    "Unable to build HE mcs mask");
+			return -EINVAL;
+		}
 
 		if (mask->control[band].legacy == 0) {
 			/* don't allow empty legacy rates if HT, VHT or HE
-- 
2.7.4

