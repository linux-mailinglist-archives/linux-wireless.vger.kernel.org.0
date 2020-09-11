Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6556526566D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 03:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgIKBLi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 21:11:38 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:37864
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgIKBLf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 21:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599786695;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=E/AQsDCUpDVP0lmpm4INGF51NRXzmJb7LzqsCDibAaw=;
        b=bJULnC2vAjiUwza2wv6MtDBfcCx+U2ZmOTA6kQ2xmyMfMM8Zb/yUTG0h43kNNgBy
        ZQU+l+XIfs3Ta7IoaA9Lo8IbcoBgoOoZXb42XlLIZfBfrK1jFQBCxEKdDh1zKe0Nhvm
        4WXUh9DjNti2C+NIpv6RhHfj+tXEEa1hdWj2NhN0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599786695;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=E/AQsDCUpDVP0lmpm4INGF51NRXzmJb7LzqsCDibAaw=;
        b=a9gLzAoQP276siDD+fSND55ca/9j6AXEOOAYNuItN2puN1mijHUVr1uJzgVsxQa3
        y7T2ibcZLwX9KKobf1tc8DStkPRYPlsRPc5mY1pCanDM3S3wFDpHCwVhRaZlvovUj8I
        jCo2kaGUcrXOiE54y1GKxUwnUA8gmMvSiK6iFOMI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F207C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH] mac80211: Fix radiotap header channel flag for 6GHz band
Date:   Fri, 11 Sep 2020 01:11:35 +0000
Message-ID: <010101747ab7b703-1d7c9851-1594-43bf-81f7-f79ce7a67cc6-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Radiotap header field 'Channel flags' has '2 GHz spectrum' set to
'true' for 6GHz packet.
Change it to 5GHz as there isn't a separate option available for 6GHz.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 net/mac80211/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 836cde516a18..a959ebf56852 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -451,7 +451,8 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 	else if (status->bw == RATE_INFO_BW_5)
 		channel_flags |= IEEE80211_CHAN_QUARTER;
 
-	if (status->band == NL80211_BAND_5GHZ)
+	if (status->band == NL80211_BAND_5GHZ ||
+	    status->band == NL80211_BAND_6GHZ)
 		channel_flags |= IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ;
 	else if (status->encoding != RX_ENC_LEGACY)
 		channel_flags |= IEEE80211_CHAN_DYN | IEEE80211_CHAN_2GHZ;
-- 
2.25.0

