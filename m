Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2E69520D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 21:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBMUkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 15:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBMUkf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 15:40:35 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2151042A
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 12:40:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id w3so15270990qts.7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 12:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676320833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2xMzIcygNnkJ8yDBrwr00/Y8AL0oJVNexFpSO7tHmI=;
        b=YUKVnoANa8l3HV/l+N1pieFDVsZbcL1WS3gq3ALcujjGU7piJK0sMduhD8buNVIgn9
         sDBK0gOv9vWZbVLlgLTtIa6sdgIPk/+FktXeR2DdAn+VmTyT9JM5TPz7jl3rDjEAHZxl
         6vYVbq8CXfVe5GqVEic1JUAzfxvlQsePQ2LEXleO3XpK01Sa5YKceG8efEJFxY8X+NJk
         li7vEElR3RD8HNqajG31iwBhBL9ngTJ8MFQSUlkw5R8RlDd+mP/nS1W3dSN0wbi5OrOi
         ipI6QZPmatBLMLA1QrR0S0TVnH4DEYVqhjJJrRYFm3AwU2XT1IENbr+w4lepax6B2fFE
         XUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676320833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2xMzIcygNnkJ8yDBrwr00/Y8AL0oJVNexFpSO7tHmI=;
        b=xbjTHALhUHp86ZPpz6XIawjdlfoNVauuVM+74o7a2Dsm6OF4lTQMdPVNKP3Yd1VNPz
         mnd22gjNE2IO+m4+Pa7Ludljm6Ecaa7vJfguDu9epbEExq2e5RGyGmnu9JRUm0fXBz7j
         vcTcmg6d1HEGxmJkm98bJNySX/tTzhi0JyAqMcppoIqxE1XTYQ3lY4Uy3n4OGsu1qHhY
         pbAwfIghFNxkH1fWx5WmNnbe1YFPWFhD+MuvIr7QRHJUCOCgoveR9QSdrTBFK7cecj0f
         ePeB+pbjXnRMW2nl9yaJxh6D63jjpfYnFTLEDlQi05tD/ug3YBEkrzb3DqivHmVBkvF5
         +Iww==
X-Gm-Message-State: AO0yUKVh3hN5a8gBp7idXWBj6M3eHNJ6lZ63beDBE7i0XNqeRHjeFw1J
        /L/4qf1Rjib1QFWV4oFc9E2B+swDQ+w=
X-Google-Smtp-Source: AK7set9wZZf3md+G0/FI5bLk9rGAfS8BnwBjtHTGSJQcXK6GnsqroRejg66rZ2uQGHEWOcUUN5zTFg==
X-Received: by 2002:a05:622a:1044:b0:3b8:689c:a8aa with SMTP id f4-20020a05622a104400b003b8689ca8aamr55139565qte.1.1676320833277;
        Mon, 13 Feb 2023 12:40:33 -0800 (PST)
Received: from netbook.. (c-73-171-102-37.hsd1.va.comcast.net. [73.171.102.37])
        by smtp.gmail.com with ESMTPSA id f63-20020a37d242000000b0073917fae4f8sm6749663qkj.25.2023.02.13.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:40:33 -0800 (PST)
From:   Stephen Douthit <stephen.douthit@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Douthit <stephen.douthit@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Sanity check tx bitrate if not provided by driver
Date:   Mon, 13 Feb 2023 15:40:24 -0500
Message-Id: <20230213204024.3377-1-stephen.douthit@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the driver doesn't fill NL80211_STA_INFO_TX_BITRATE in sta_set_sinfo()
then as a fallback sta->deflink.tx_stats.last_rate is used.  Unfortunately
there's no guarantee that this has actually been set before it's used.

Originally found when 'iw <dev> link' would always return a tx rate of
6Mbps regardless of actual link speed for the QCA9337 running firmware
WLAN.TF.2.1-00021-QCARMSWP-1 in my netbook.

Use the sanity check logic from ieee80211_fill_rx_status() and refactor
that to use the new inline function.

Signed-off-by: Stephen Douthit <stephen.douthit@gmail.com>
---
 include/net/mac80211.h  | 7 +++++++
 net/mac80211/airtime.c  | 2 +-
 net/mac80211/sta_info.c | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2635e6de8101..f6d4fd4d7ce9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1058,6 +1058,13 @@ struct ieee80211_tx_rate {
 
 #define IEEE80211_MAX_TX_RETRY		31
 
+static inline int ieee80211_rate_invalid(struct ieee80211_tx_rate *rate)
+{
+	if (rate->idx < 0 || !rate->count)
+		return -EINVAL;
+	return 0;
+}
+
 static inline void ieee80211_rate_set_vht(struct ieee80211_tx_rate *rate,
 					  u8 mcs, u8 nss)
 {
diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index e8ebd343e2bf..35ca46a9d709 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -557,7 +557,7 @@ static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
 	if (ieee80211_fill_rate_info(hw, stat, band, ri))
 		return 0;
 
-	if (rate->idx < 0 || !rate->count)
+	if (ieee80211_rate_invalid(rate))
 		return -1;
 
 	if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 27c737fe7fb8..f1c39de65f67 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2675,7 +2675,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
-	    !sta->sta.valid_links) {
+	    !sta->sta.valid_links &&
+	    !ieee80211_rate_invalid(&sta->deflink.tx_stats.last_rate)) {
 		sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate,
 				     &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-- 
2.39.1

