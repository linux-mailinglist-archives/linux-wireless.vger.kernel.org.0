Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE70289BED
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 00:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392016AbgJIWup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 18:50:45 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:53903 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389409AbgJIWtx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 18:49:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602283792; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=VCdwQ+HlKc+a+4p6dF8BcMxPLeF3Xnk+vjVyCWPDJrw=; b=rZPFczjC5+rNttPW0qUqvOREhOTzDAa0S4kLb6Kxclnh9e0udw120DIvgKBLKK/RdSjyvxsD
 v8J/ytAZKHFIvGxRyeC6AyldCW6LgFfhW4SzP2W2/+oL0zoGZPX+yAXA7Clq6SUKQQxI2bqd
 01E9HLRy2qNSvgxKf5dqWUZSM88=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f80e91057b88ccb5684611d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 22:49:52
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27F2BC433CB; Fri,  9 Oct 2020 22:49:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FA44C433FE;
        Fri,  9 Oct 2020 22:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA44C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] iw: enable 80MHz support for 6GHz band 11s mesh
Date:   Fri,  9 Oct 2020 15:49:30 -0700
Message-Id: <1602283770-8026-2-git-send-email-pradeepc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
References: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

without this 11s mesh could not be configured with bandwidth 80MHz
in 6G band using iw. Also, this will be required to set frequency
for 6GHz band in 80MHz.

example:
iw <interface> mesh join <meshname> freq 6195 80MHz

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 util.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/util.c b/util.c
index 9ca32c5295ae..175470f11a27 100644
--- a/util.c
+++ b/util.c
@@ -1241,21 +1241,24 @@ void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
 int get_cf1(const struct chanmode *chanmode, unsigned long freq)
 {
 	unsigned int cf1 = freq, j;
-	unsigned int vht80[] = { 5180, 5260, 5500, 5580, 5660, 5745 };
+	unsigned int bw80[] = { 5180, 5260, 5500, 5580, 5660, 5745,
+				5955, 6035, 6115, 6195, 6275, 6355,
+				6435, 6515, 6595, 6675, 6755, 6835,
+				6195, 6995 };
 	unsigned int vht160[] = { 5180, 5500 };
 
 	switch (chanmode->width) {
 	case NL80211_CHAN_WIDTH_80:
 	        /* setup center_freq1 */
-		for (j = 0; j < ARRAY_SIZE(vht80); j++) {
-			if (freq >= vht80[j] && freq < vht80[j] + 80)
+		for (j = 0; j < ARRAY_SIZE(bw80); j++) {
+			if (freq >= bw80[j] && freq < bw80[j] + 80)
 				break;
 		}
 
-		if (j == ARRAY_SIZE(vht80))
+		if (j == ARRAY_SIZE(bw80))
 			break;
 
-		cf1 = vht80[j] + 30;
+		cf1 = bw80[j] + 30;
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		/* setup center_freq1 */
-- 
1.9.1

