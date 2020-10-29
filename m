Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7429F430
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJ2SiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 14:38:13 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36921 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgJ2SiM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 14:38:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603996692; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=XA9dKQuycvf4OlYd9/d2zC/N8Qn1ulTaJHN/DPRyW/8=; b=lhruZ3OSWYPgZpBNo/gofBtTtXdURjiE4RGzWCg66npT2ECbswNbemF9t0/pKgkbrz+nb4mx
 5JwUjCnr68P2+ivjq5JwNg7gs/S6EB7b8NkEzL7NvksPpeNV+IH+8LiMfO8aTsK/kHv2KVrB
 tADzJ9OBtyoLYW7NsaUhlyQY6NY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f9b0c13580ed2b2f266389e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 18:38:11
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D1A1C433C9; Thu, 29 Oct 2020 18:38:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-85-8-nat.elisa-mobile.fi [85.76.85.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61A19C433FF;
        Thu, 29 Oct 2020 18:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61A19C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Vamsi Krishna <vamsin@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] cfg80211: Add support to calculate and report 4096-QAM HE rates
Date:   Thu, 29 Oct 2020 20:34:57 +0200
Message-Id: <20201029183457.7005-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vamsi Krishna <vamsin@codeaurora.org>

Drivers supporting 4096-QAM rates as a vendor extension in HE mode need
to update the correct rate info to userspace while using 4096-QAM (MCS12
and MCS13) in HE mode. Add support to calculate bitrates of HE-MCS12 and
HE-MCS13 which represent the 4096-QAM modulation schemes. The MCS12 and
MCS13 bitrates are defined in IEEE P802.11be/D0.1.

In addition, scale up the bitrates by 3*2048 in order to accommodate
calculations for the new MCS12 and MCS13 rates without losing fraction
values.

Signed-off-by: Vamsi Krishna <vamsin@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/wireless/util.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index f01746894a4e..5b6c80ae564a 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1276,20 +1276,22 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 
 static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 {
-#define SCALE 2048
-	u16 mcs_divisors[12] = {
-		34133, /* 16.666666... */
-		17067, /*  8.333333... */
-		11378, /*  5.555555... */
-		 8533, /*  4.166666... */
-		 5689, /*  2.777777... */
-		 4267, /*  2.083333... */
-		 3923, /*  1.851851... */
-		 3413, /*  1.666666... */
-		 2844, /*  1.388888... */
-		 2560, /*  1.250000... */
-		 2276, /*  1.111111... */
-		 2048, /*  1.000000... */
+#define SCALE 6144
+	u32 mcs_divisors[14] = {
+		102399, /* 16.666666... */
+		 51201, /*  8.333333... */
+		 34134, /*  5.555555... */
+		 25599, /*  4.166666... */
+		 17067, /*  2.777777... */
+		 12801, /*  2.083333... */
+		 11769, /*  1.851851... */
+		 10239, /*  1.666666... */
+		  8532, /*  1.388888... */
+		  7680, /*  1.250000... */
+		  6828, /*  1.111111... */
+		  6144, /*  1.000000... */
+		  5690, /*  0.926106... */
+		  5120, /*  0.833333... */
 	};
 	u32 rates_160M[3] = { 960777777, 907400000, 816666666 };
 	u32 rates_969[3] =  { 480388888, 453700000, 408333333 };
@@ -1301,7 +1303,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	u64 tmp;
 	u32 result;
 
-	if (WARN_ON_ONCE(rate->mcs > 11))
+	if (WARN_ON_ONCE(rate->mcs > 13))
 		return 0;
 
 	if (WARN_ON_ONCE(rate->he_gi > NL80211_RATE_INFO_HE_GI_3_2))
-- 
2.20.1

