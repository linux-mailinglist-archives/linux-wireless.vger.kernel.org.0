Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6511C1B8220
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 00:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDXWma (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 18:42:30 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57358 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgDXWm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 18:42:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587768149; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cheA3LCyJJRur1FCaizcxQDlGa3ekuGU1bw9Vi/c/XE=; b=KuoBvfvPP1Ags7a8qTFwn2TD5VU9Sji0ion9Df6ECIUq6ThYagAgYJi0LX9nMyq5JZzsO1Fb
 C6LeA8cjwPIMuHQRetbdOfzuyKash/CFzZGJONu1hx6d1+ekUZXDbjIiPZc6fZWCRsN+Q1Gh
 iwSmf8jn+xfTk2edGfisk4a6YkM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea36b46.7fbb8aea0ab0-smtp-out-n04;
 Fri, 24 Apr 2020 22:42:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7F6BC433D2; Fri, 24 Apr 2020 22:42:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B279C433CB;
        Fri, 24 Apr 2020 22:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B279C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 02/10] cfg80211: validate 6 GHz chandef
Date:   Fri, 24 Apr 2020 15:41:40 -0700
Message-Id: <1587768108-25248-3-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Validate the params of set_channel against 6 GHz frequency range
and bandwidth allowed.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/net/cfg80211.h | 14 ++++++++++++++
 net/wireless/chan.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 70e48f66dac8..13d3d8f92c99 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -730,6 +730,20 @@ cfg80211_chandef_is_edmg(const struct cfg80211_chan_def *chandef)
 }
 
 /**
+ * cfg80211_chandef_is_6ghz - check if chandef represents an 6 GHz channel
+ *
+ * @chandef: the channel definition
+ *
+ * Return: %true if frequency is in 6 GHz range, %false otherwise.
+ */
+static inline bool
+cfg80211_chandef_is_6ghz(const struct cfg80211_chan_def *chandef)
+{
+	return (chandef->center_freq1 > 5940 && chandef->center_freq1 < 7105);
+}
+
+
+/**
  * cfg80211_chandef_compatible - check if two channel definitions are compatible
  * @chandef1: first channel definition
  * @chandef2: second channel definition
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index fcac5c6366e1..42d27cada237 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -19,6 +19,29 @@ static bool cfg80211_valid_60g_freq(u32 freq)
 	return freq >= 58320 && freq <= 70200;
 }
 
+static bool cfg80211_is_6ghz_freq(u32 freq)
+{
+	return (freq > 5940 && freq < 7105);
+}
+
+static enum nl80211_chan_width cfg80211_chan_to_bw_6ghz(u8 idx)
+{
+	/* channels: 1, 5, 9, 13... */
+	if ((idx & 0x3) == 0x1)
+		return NL80211_CHAN_WIDTH_20;
+	/* channels 3, 11, 19... */
+	if ((idx & 0x7) == 0x3)
+		return NL80211_CHAN_WIDTH_40;
+	/* channels 7, 23, 39.. */
+	if ((idx & 0xf) == 0x7)
+		return NL80211_CHAN_WIDTH_80;
+	/* channels 15, 47, 79...*/
+	if ((idx & 0x1f) == 0xf)
+		return NL80211_CHAN_WIDTH_160;
+
+	return NL80211_CHAN_WIDTH_20;
+}
+
 void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 			     struct ieee80211_channel *chan,
 			     enum nl80211_channel_type chan_type)
@@ -139,6 +162,25 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 	return true;
 }
 
+static bool cfg80211_6ghz_chandef_valid(const struct cfg80211_chan_def *chandef)
+{
+	enum nl80211_chan_width bw;
+	int chan_idx;
+
+	if (!cfg80211_is_6ghz_freq(chandef->center_freq1))
+		return false;
+
+	chan_idx = ieee80211_frequency_to_channel(chandef->center_freq1);
+	if (chan_idx <= 0)
+		return false;
+
+	bw = cfg80211_chan_to_bw_6ghz(chan_idx);
+	if (bw != chandef->width)
+		return false;
+
+	return true;
+}
+
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
 	u32 control_freq;
@@ -213,6 +255,10 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	    !cfg80211_edmg_chandef_valid(chandef))
 		return false;
 
+	if (cfg80211_chandef_is_6ghz(chandef) &&
+	    !cfg80211_6ghz_chandef_valid(chandef))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
-- 
2.7.4
