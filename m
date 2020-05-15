Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0C1D584D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEORv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 13:51:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11676 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbgEORv5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 13:51:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589565117; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bslKtWCXsJbwrBTfNoUqwKXZl22LdigGSXwOTdE5U4M=; b=jVdwAqPhdZxZh2O6DerSo69km+op9a8xZWtk7rIaldGFxMMLyy9Ty2E6obCp/yLAI1Eisrx7
 BdUS7uDkUKhs4kinfINuqclxplCDS9b2rYA85bMTpMzlMMLxXzeYGh3AlSuapAoF/ZXfGfqG
 R/m72Wff6mTYTfpjc/N8SAf60rI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ebed6bc75dd50406ea7b967 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 May 2020 17:51:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99CFEC44788; Fri, 15 May 2020 17:51:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79584C43636;
        Fri, 15 May 2020 17:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79584C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] iw: sync frequency to channel mapping with kernel for 6GHz band
Date:   Fri, 15 May 2020 10:51:45 -0700
Message-Id: <20200515175145.30080-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This enables support for channel to frequency conversion and vice versa
for 6GHz channels and frequencies. Channel numbers of 6GHz band might
overlap with those of 5G and 2G bands.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 util.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/util.c b/util.c
index 886fef2b5e2c..ac6a96dc2851 100644
--- a/util.c
+++ b/util.c
@@ -180,6 +180,11 @@ int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
 		else
 			return 5000 + chan * 5;
 		break;
+	case NL80211_BAND_6GHZ:
+	/* see 802.11ax D4.1 27.3.22.2 */
+		if (chan <= 253)
+			return 5940 + chan * 5;
+		break;
 	case NL80211_BAND_60GHZ:
 		if (chan < 5)
 			return 56160 + chan * 2160;
@@ -199,9 +204,12 @@ int ieee80211_frequency_to_channel(int freq)
 		return (freq - 2407) / 5;
 	else if (freq >= 4910 && freq <= 4980)
 		return (freq - 4000) / 5;
-	else if (freq <= 45000) /* DMG band lower limit */
+	else if (freq < 5945)
 		return (freq - 5000) / 5;
-	else if (freq >= 58320 && freq <= 64800)
+	else if (freq <= 45000) /* DMG band lower limit */
+		/* see 802.11ax D4.1 27.3.22.2 */
+		return (freq - 5940) / 5;
+	else if (freq >= 58320 && freq <= 70200)
 		return (freq - 56160) / 2160;
 	else
 		return 0;
-- 
2.17.1

