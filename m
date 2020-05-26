Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6751E32E8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404428AbgEZWr6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 18:47:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12951 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389755AbgEZWr5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 18:47:57 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 18:47:38 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590533276; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=BKTf5sbZpwUcA83Stdp1FDd4+6uYo4GAbXrDP5BPwgg=; b=v97PhJioI22OZtGppp0cLPBgQHWkRoi+NriMy190jCJXVjoPARyl1J8FycZhTK3m7bmo2USs
 erocn/NeBeEUGwqx1lgZMPkSXx7gG0VlUh/QVT4Dg+0V/fuWhYWl1cwBFuv+Q1tLBmr2x7rx
 ZEjxmN71w1rfrhGDjqt8V7d6rSc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ecd9b5f5086732481801082 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 22:42:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BEEFC433AF; Tue, 26 May 2020 22:42:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DD74C433C9;
        Tue, 26 May 2020 22:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DD74C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v3 1/9] cfg80211: Add helper function to identify 6GHz PSC channel
Date:   Tue, 26 May 2020 15:42:09 -0700
Message-Id: <20200526224217.11119-2-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526224217.11119-1-pradeepc@codeaurora.org>
References: <20200526224217.11119-1-pradeepc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6GHz channels are divided into preferred scanning channels(PSC)
and non-PSC channels. One in every four 20MHz channels is a PSC.
Spec mandates to use only PSC channels as primary channels for
setting up BSS on 6GHz only AP.

The set of 20 MHz channels in the 6 GHz band, with channel center
frequency, ch_a = Channel starting frequency – 55 + 80 × n (MHz)
are referred to as preferred scanning channels (PSCs) where,
n = 1, …, 15 as per IEEE P802.11ax/D6.1.

This function can be used by drivers or cfg80211 when making
scanning decision on 6GHz channels.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v3:
 - update channel starting frequency from 5945 to 5950 as per
   IEEE P802.11ax/D6.1
 - Define helper function and remove cahnnel flag PSC

 include/net/cfg80211.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fd6a973b1249..bd27020ea8c9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5281,6 +5281,30 @@ ieee80211_get_channel(struct wiphy *wiphy, int freq)
 	return ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(freq));
 }
 
+/**
+ * ieee80211_is_channel_psc - is 6ghz channel a Preferred Scanning Channel (PSC)
+ *
+ * @chan: struct ieee80211_channel to determine
+ * Return: True if 6ghz channel is a PSC channel. False for the rest.
+ */
+static inline bool ieee80211_is_channel_psc(struct ieee80211_channel *chan)
+{
+	if (chan->band != NL80211_BAND_6GHZ)
+		return false;
+
+	/*
+	 * From IEEE P802.11ax/D6.1: The set of 20 MHz channels in the 6 GHz
+	 * band, with channel center frequency, ch_a = Channel starting
+	 * frequency – 55  80 × n (MHz) are referred to as preferred scanning
+	 * channels (PSCs). Channel starting frequency is defined in 27.3.23.2
+	 * (Channel allocation in the 6 GHz band), and n = 1, …, 15.
+	 */
+	if (!(((chan->center_freq - 5950 + 55) >> 4) % 5))
+		return true;
+
+	return false;
+}
+
 /**
  * ieee80211_get_response_rate - get basic rate for a given rate
  *
-- 
2.17.1

