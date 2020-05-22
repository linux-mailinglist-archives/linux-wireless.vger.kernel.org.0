Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADE1DE0C5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgEVHYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:24:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47192 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgEVHYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:24:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590132286; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=GkPPDowv8fF+eoncLt6ZIE6pGVBOH059qNd10rnxrkQ=; b=toXrPP7WqdhwzT1l8Q3nc1Q5nqj189Rj/84QCigeUu5xL6DZ8m9fI5DIDMvcWBl7QbqQk2C7
 TKGrkN8c2RDIHW3pfBb/Qy38WwHZ7qiG1hyH00sCwgL4SSSvtHcHMVAPGX3ExhWM11YaYz0c
 Gvjzwr9wGRRPCBNzHEAFuGCljTg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec77e3b.7f82d42f3df8-smtp-out-n05;
 Fri, 22 May 2020 07:24:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F2BAC43395; Fri, 22 May 2020 07:24:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B06B9C433C8;
        Fri, 22 May 2020 07:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B06B9C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 1/9] cfg80211: Add new channel flag to identify 6GHz PSC channel
Date:   Fri, 22 May 2020 00:24:23 -0700
Message-Id: <20200522072431.27601-2-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522072431.27601-1-pradeepc@codeaurora.org>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
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
n = 1, …, 15 as per IEEE P802.11ax/D6.0.

This flag also will be used when making scanning decision on
6GHz channels.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 include/net/cfg80211.h |  2 ++
 net/wireless/reg.c     | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fd6a973b1249..ca3e9df7adfe 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -96,6 +96,7 @@ struct wiphy;
  * @IEEE80211_CHAN_NO_10MHZ: 10 MHz bandwidth is not permitted
  *	on this channel.
  * @IEEE80211_CHAN_NO_HE: HE operation is not permitted on this channel.
+ * @IEEE80211_CHAN_PSC: 6GHz Channel is Preferred Scanning Channel(PSC)
  *
  */
 enum ieee80211_channel_flags {
@@ -113,6 +114,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_20MHZ		= 1<<11,
 	IEEE80211_CHAN_NO_10MHZ		= 1<<12,
 	IEEE80211_CHAN_NO_HE		= 1<<13,
+	IEEE80211_CHAN_PSC		= 1<<14,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0d74a31ef0ab..4ebaa57e60e4 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2023,6 +2023,21 @@ static bool is_ht40_allowed(struct ieee80211_channel *chan)
 	return true;
 }
 
+static bool reg_is_6ghz_channel_psc(struct ieee80211_channel *chan)
+{
+	/*
+	 * From IEEE P802.11ax/D6.0: The set of 20 MHz channels in the 6 GHz
+	 * band, with channel center frequency, ch_a = Channel starting
+	 * frequency – 55 + 80 × n (MHz) are referred to as preferred scanning
+	 * channels (PSCs). Channel starting frequency is defined in 27.3.23.2
+	 * (Channel allocation in the 6 GHz band), and n = 1, …, 15.
+	 */
+	if (!(((chan->center_freq - 5940 + 55) >> 4) % 5))
+		return true;
+
+	return false;
+}
+
 static void reg_process_ht_flags_channel(struct wiphy *wiphy,
 					 struct ieee80211_channel *channel)
 {
@@ -2305,6 +2320,10 @@ static void handle_channel_custom(struct wiphy *wiphy,
 	else
 		chan->flags |= map_regdom_flags(reg_rule->flags) | bw_flags;
 
+	if (chan->band == NL80211_BAND_6GHZ &&
+	    reg_is_6ghz_channel_psc(chan))
+		chan->flags |= IEEE80211_CHAN_PSC;
+
 	chan->max_antenna_gain = (int) MBI_TO_DBI(power_rule->max_antenna_gain);
 	chan->max_reg_power = chan->max_power =
 		(int) MBM_TO_DBM(power_rule->max_eirp);
-- 
2.17.1
