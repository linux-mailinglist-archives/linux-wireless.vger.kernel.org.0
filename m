Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425C26699B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKUjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:39:15 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:52608
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgIKUjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599856753;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=ehK3I+EhbjpnITc5KTl8pQ2hlL8S3vldQznjM7IU834=;
        b=KH47WXejcmG7VHZsD4i9vX0kBGQXTu7voMhO+nGccEEyEIIYH7JwT2AV0jbrEj0R
        v9lSWin7OSiG5N4G8jTbP0n7EnqGbSQ+qyk2MUcV+YD41gYT5L0LdxWFEKTIVl7LsoQ
        YADw2uFkVCCHpUGVpg17s5/GKeJXjhBvyHsITbN0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599856753;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=ehK3I+EhbjpnITc5KTl8pQ2hlL8S3vldQznjM7IU834=;
        b=fQhRcbtOqNe57m/PRzrQ0N7ieVXwNuJ+1r4nsQu38p9ERuK8BWIDAQWaqFeotWwY
        WXQOOMEY/yoSfTNoN/jHFuR0aJAX3VtkuQJYA7vsYmy5tMk6Tw7iMUquvk+o5WuQ/ZK
        yE3sjXJ+VbxmgZGDpunLo8wx60yrxwJGBmmazJ+s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37033C433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
Date:   Fri, 11 Sep 2020 20:39:13 +0000
Message-ID: <010101747ee4b989-1d670a2f-a032-4f64-aa65-3847a5951522-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Radiotap header needs a new channel flag for 6GHz packets.
This change uses value 0x200 for new enum balue for 6GHz which was
previously used for passsive scan flag but has since been removed.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/ieee80211_radiotap.h | 1 +
 net/mac80211/rx.c                | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 19c00d100096..df631d177cf9 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -101,6 +101,7 @@ enum ieee80211_radiotap_channel_flags {
 	IEEE80211_CHAN_OFDM = 0x0040,
 	IEEE80211_CHAN_2GHZ = 0x0080,
 	IEEE80211_CHAN_5GHZ = 0x0100,
+	IEEE80211_CHAN_6GHZ = 0x0200,
 	IEEE80211_CHAN_DYN = 0x0400,
 	IEEE80211_CHAN_HALF = 0x4000,
 	IEEE80211_CHAN_QUARTER = 0x8000,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 836cde516a18..21aa19c12afc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -451,7 +451,9 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 	else if (status->bw == RATE_INFO_BW_5)
 		channel_flags |= IEEE80211_CHAN_QUARTER;
 
-	if (status->band == NL80211_BAND_5GHZ)
+	if (status->band == NL80211_BAND_6GHZ)
+		channel_flags |= IEEE80211_CHAN_OFDM | IEEE80211_CHAN_6GHZ;
+	else if (status->band == NL80211_BAND_5GHZ)
 		channel_flags |= IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ;
 	else if (status->encoding != RX_ENC_LEGACY)
 		channel_flags |= IEEE80211_CHAN_DYN | IEEE80211_CHAN_2GHZ;
-- 
2.25.0

