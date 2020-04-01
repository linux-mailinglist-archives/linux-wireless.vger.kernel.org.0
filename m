Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9855F19ADC9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbgDAO1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 10:27:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:33009 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732749AbgDAO1E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 10:27:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585751224; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hKmDSFnt4XlbDcKZk9ygMnOt+kN/ht1bsWx8zI+R9QY=; b=X5FiJwJi+EF/R43C+TSarnsLbq2nU1vuhbXfW9RP9hHeWrS8lS/nr7a188cndmdFRZmYWlFU
 854R8rIx9uQAgx6zbdvulRUEBvYzFhdg26HvZGKlIH+Aby2Ry9+e7Q93578z2dYE2FsWY8FV
 TjSGqb8n3vkOHXtjnceJxzb0YG4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e84a4b1.7f5dbd645d18-smtp-out-n03;
 Wed, 01 Apr 2020 14:26:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF797C433D2; Wed,  1 Apr 2020 14:26:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E67A5C433BA;
        Wed,  1 Apr 2020 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E67A5C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/2] mac80211: Report beacon protection failures to user space
Date:   Wed,  1 Apr 2020 17:25:48 +0300
Message-Id: <20200401142548.6990-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401142548.6990-1-jouni@codeaurora.org>
References: <20200401142548.6990-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report received Beacon frames that do not have a valid MME MIC when
beacon protection is enabled. This covers both the cases of no MME in
the received frame and invalid MIC in the MME.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/rx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 91a13aee4378..a724551b8ddf 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1984,8 +1984,12 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 		if (mmie_keyidx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS ||
 		    mmie_keyidx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
-		    NUM_DEFAULT_BEACON_KEYS)
+		    NUM_DEFAULT_BEACON_KEYS) {
+			cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
+						     skb->data,
+						     skb->len);
 			return RX_DROP_MONITOR; /* unexpected BIP keyidx */
+		}
 
 		rx->key = ieee80211_rx_get_bigtk(rx, mmie_keyidx);
 		if (!rx->key)
@@ -2131,6 +2135,10 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	/* either the frame has been decrypted or will be dropped */
 	status->flag |= RX_FLAG_DECRYPTED;
 
+	if (unlikely(ieee80211_is_beacon(fc) && result == RX_DROP_UNUSABLE))
+		cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
+					     skb->data, skb->len);
+
 	return result;
 }
 
@@ -2411,8 +2419,12 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 			return -EACCES;
 		}
 		if (unlikely(ieee80211_is_beacon(fc) && rx->key &&
-			     ieee80211_get_mmie_keyidx(rx->skb) < 0))
+			     ieee80211_get_mmie_keyidx(rx->skb) < 0)) {
+			cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
+						     rx->skb->data,
+						     rx->skb->len);
 			return -EACCES;
+		}
 		/*
 		 * When using MFP, Action frames are not allowed prior to
 		 * having configured keys.
-- 
2.20.1
