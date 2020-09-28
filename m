Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFE27A897
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1H3T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 03:29:19 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:30567 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgI1H3S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 03:29:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601278157; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=zwz4Cph5z+HXWZK+fuCxzyir7h4Sc62UaQ48kOHbu3g=; b=pDpiihZdRYqFpYaEj4Wv6ron8WpYMJ4ZGBuJkzJHrEpvjaQIr8Bms1IeUj+sn/XpaNQ3VvGi
 mddBX6BH6NTLkzFoTCnqyc6+NAtvRjUXTrjfjXCTOn60nhUf6JahM0z1SKZqz2+stgl9pTUh
 gb0E0q8xgLmcr2SrBCeMncJCBQ8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f7190c7ebb17452baf40287 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 07:29:11
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24B46C433F1; Mon, 28 Sep 2020 07:29:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29B90C433CA;
        Mon, 28 Sep 2020 07:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29B90C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 1/2] nl80211: fix OBSS PD min and max offset validation
Date:   Mon, 28 Sep 2020 00:28:10 -0700
Message-Id: <1601278091-20313-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The SRG min and max offset won't present when SRG Information Present of
SR control field of Spatial Reuse Parameter Set element set to 0. Per
spec. IEEE802.11ax D7.0, SRG OBSS PD Min Offset ≤ SRG OBSS PD Max
Offset. Hence fix the constrain check to allow same values in both
offset and also call appropriate nla_get function to read the values.

Fixes: 796e90f42b7e ("cfg80211: add support for parsing OBBS_PD
attributes")
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/wireless/nl80211.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 666274f36d63..e7b84e36014c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4871,16 +4871,14 @@ static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
 	if (err)
 		return err;
 
-	if (!tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET] ||
-	    !tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET])
-		return -EINVAL;
-
-	he_obss_pd->min_offset =
-		nla_get_u32(tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET]);
-	he_obss_pd->max_offset =
-		nla_get_u32(tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET]);
-
-	if (he_obss_pd->min_offset >= he_obss_pd->max_offset)
+	if (tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET])
+		he_obss_pd->min_offset =
+			nla_get_u8(tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET]);
+	if (tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET])
+		he_obss_pd->max_offset =
+			nla_get_u8(tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET]);
+
+	if (he_obss_pd->min_offset > he_obss_pd->max_offset)
 		return -EINVAL;
 
 	he_obss_pd->enable = true;
-- 
2.7.4

