Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D313B202FD8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 08:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgFVGj3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 02:39:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44860 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgFVGj2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 02:39:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592807967; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FcqLgeJNH87Wg92GBHqnG2DAhKaH2JapgH9YWF6Dv2c=; b=I85X7Rp2EtiBvogc/RrNfBhf1tuT8x6wCyO8N1r6KGyk/rNjTcUWe6wxOD7VsZaiCKuDy0Xe
 kcJmC7iK3wy3TlanoXZRXscbfo2BC0lSZ/1WPsKTnNTb5aMG/G/xaXlSWu6zfdab7KLuTsjz
 rZ8nbqzLgtqVAgMZHVRCWM+Osmo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ef05211c4bb4f886da10de3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 06:39:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A8B4C433C8; Mon, 22 Jun 2020 06:39:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14523C433C6;
        Mon, 22 Jun 2020 06:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14523C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] iw: update freq to chan mappings for 6GHz band per IEEE P802.11ax/D6.1
Date:   Sun, 21 Jun 2020 23:39:06 -0700
Message-Id: <20200622063906.24957-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes dfferences in 6GHz frequencies which were updated in
IEEE P802.11ax/D6.1.

Also sync 60GHz band channel to freq mapping with kernel.

Fixes: 43789196 ("iw: sync frequency to channel mapping with kernel for 6GHz band")
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 util.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/util.c b/util.c
index ac6a96dc2851..048312c0aa58 100644
--- a/util.c
+++ b/util.c
@@ -181,12 +181,14 @@ int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
 			return 5000 + chan * 5;
 		break;
 	case NL80211_BAND_6GHZ:
-	/* see 802.11ax D4.1 27.3.22.2 */
+		/* see 802.11ax D6.1 27.3.23.2 */
+		if (chan == 2)
+			return MHZ_TO_KHZ(5935);
 		if (chan <= 253)
-			return 5940 + chan * 5;
+			return 5950 + chan * 5;
 		break;
 	case NL80211_BAND_60GHZ:
-		if (chan < 5)
+		if (chan < 7)
 			return 56160 + chan * 2160;
 		break;
 	default:
@@ -200,15 +202,18 @@ int ieee80211_frequency_to_channel(int freq)
 	/* see 802.11-2007 17.3.8.3.2 and Annex J */
 	if (freq == 2484)
 		return 14;
+	/* see 802.11ax D6.1 27.3.23.2 and Annex E */
+	else if (freq == 5935)
+		return 2;
 	else if (freq < 2484)
 		return (freq - 2407) / 5;
 	else if (freq >= 4910 && freq <= 4980)
 		return (freq - 4000) / 5;
-	else if (freq < 5945)
+	else if (freq < 5950)
 		return (freq - 5000) / 5;
 	else if (freq <= 45000) /* DMG band lower limit */
-		/* see 802.11ax D4.1 27.3.22.2 */
-		return (freq - 5940) / 5;
+		/* see 802.11ax D6.1 27.3.23.2 */
+		return (freq - 5950) / 5;
 	else if (freq >= 58320 && freq <= 70200)
 		return (freq - 56160) / 2160;
 	else
-- 
2.17.1

