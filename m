Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A409A1F773B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 13:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFLLWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 07:22:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694FC03E96F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2020 04:22:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so9355968wrp.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2020 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jo7yBrmeX1GY6ZlKqjKQxxARUuLWfKqWUIO8Mcrol1M=;
        b=p9LMr5VyjRMpIqMnHSpcWJIQTxoKjd3cvoA7989N6XePfyrTReZZ8PHsp/dDz0OHXp
         8opzvf29Y6KyfaFlRikUAPqooxZRYKK9oBGdu95r4FgiNcJj2UY621COVYj5rjkm7YLJ
         sAm7ApDdDK98O/5bT0h/D33QfgK/r5jzuMveCHeLX/ziXedZttfutz2PNZ+mQSeM0IY8
         yW2NjhKjdSW2pWXR0uwcb63sWUGvE8TpUSEinI4FAVA/ujEuDDC//XCBB6t1CBx5qNwB
         oA9TYDXWkOmXma067sdABBilqwqD2LKMURusjUW9CdCJ6X0N0yw+DQEShK+qbal2sbpL
         qm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jo7yBrmeX1GY6ZlKqjKQxxARUuLWfKqWUIO8Mcrol1M=;
        b=ZaWRA8sIyyWnUgC9Rfr7h1YwzX6IeibMjvs1OlvoSo9KfhqgWXKZL6sZ8Jo+q8Noym
         L42PRMqsGZqMrEXlOCRfeJ9jCZN5LRtA9zc9sTX3fw0v3sZCUwhspL0pB9zAv0jnszEf
         SmrnTXL5vzipPDp4SQPWNFN/4vnAprJWScuqDbNyeGC3c7xY5pELEpjEQ8pgi+77p+Sl
         fUweRcLfTDvztH9/ApOJvaV3QnwOIrh0ZZl/i0K2q4npg2HqNGP/e3qTb9K0uq6f2T8+
         Om9s7QS1+/+j0s66k7Mht1HBULo+/E7d4kMgymioSLqEaNnSmiOnDL1pZe3h1YDHhoAH
         0SNg==
X-Gm-Message-State: AOAM532LVsoNjuhFuWb3cy2i/SFjGs9YrguabCziv6raUhPVvhRLfjFb
        CkqbUdZFyqcCjFMKiF31tdzjcnasnHQ=
X-Google-Smtp-Source: ABdhPJxaGXnAokllfRL74+fxnE7OPzjY9goexm3evrwYHYXAMrvZ2Gb8VbrMLy2/NRLZ+xpsnw7O3g==
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr14399281wro.250.1591960954531;
        Fri, 12 Jun 2020 04:22:34 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id u9sm8969415wme.16.2020.06.12.04.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 04:22:34 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Add ieee80211 rx status rate information
Date:   Fri, 12 Jun 2020 13:27:34 +0200
Message-Id: <1591961254-10243-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Packet encoding, bandwidth and bitrate can be derived from the
wcn36xx rate_idx, part of the buffer descriptor.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 109 +++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index a690237..dda6d89 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -23,9 +23,104 @@ static inline int get_rssi0(struct wcn36xx_rx_bd *bd)
 	return 100 - ((bd->phy_stat0 >> 24) & 0xff);
 }
 
+struct wcn36xx_rate {
+	u16 bitrate;
+	u16 mcs_or_legacy_index;
+	enum mac80211_rx_encoding encoding;
+	enum mac80211_rx_encoding_flags encoding_flags;
+	enum rate_info_bw bw;
+};
+
+static const struct wcn36xx_rate wcn36xx_rate_table[] = {
+	/* 11b rates */
+	{  10, 0, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{  20, 1, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{  55, 2, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 110, 3, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+
+	/* 11b SP (short preamble) */
+	{  10, 0, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
+	{  20, 1, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
+	{  55, 2, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
+	{ 110, 3, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
+
+	/* 11ag */
+	{  60, 4, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{  90, 5, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 120, 6, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 180, 7, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 240, 8, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 360, 9, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 480, 10, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+	{ 540, 11, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
+
+	/* 11n */
+	{  65, 0, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 130, 1, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 195, 2, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 260, 3, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 390, 4, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 520, 5, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 585, 6, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{ 650, 7, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+
+	/* 11n SGI */
+	{  72, 0, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 144, 1, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 217, 2, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 289, 3, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 434, 4, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 578, 5, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 650, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{ 722, 7, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+
+	/* 11n GF (greenfield) */
+	{  65, 0, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 130, 1, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 195, 2, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 260, 3, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 390, 4, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 520, 5, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 585, 6, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+	{ 650, 7, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_20 },
+
+	/* 11n CB (channel bonding) */
+	{ 135, 0, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 270, 1, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 405, 2, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 540, 3, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 810, 4, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1080, 5, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1215, 6, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1350, 7, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+
+	/* 11n CB + SGI */
+	{ 150, 0, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 300, 1, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 450, 2, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 600, 3, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 900, 4, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1200, 5, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1500, 7, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11n GF + CB */
+	{ 135, 0, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 270, 1, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 405, 2, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 540, 3, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 810, 4, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 1080, 5, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 1215, 6, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+	{ 1350, 7, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
+
+	/* TODO: AC rates */
+};
+
 int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 {
 	struct ieee80211_rx_status status;
+	const struct wcn36xx_rate *rate;
 	struct ieee80211_hdr *hdr;
 	struct wcn36xx_rx_bd *bd;
 	u16 fc, sn;
@@ -61,7 +156,6 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	status.mactime = 10;
 	status.signal = -get_rssi0(bd);
 	status.antenna = 1;
-	status.rate_idx = 1;
 	status.flag = 0;
 	status.rx_flags = 0;
 	status.flag |= RX_FLAG_IV_STRIPPED |
@@ -70,6 +164,19 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 
 	wcn36xx_dbg(WCN36XX_DBG_RX, "status.flags=%x\n", status.flag);
 
+	if (bd->rate_id < ARRAY_SIZE(wcn36xx_rate_table)) {
+		rate = &wcn36xx_rate_table[bd->rate_id];
+		status.encoding = rate->encoding;
+		status.enc_flags = rate->encoding_flags;
+		status.bw = rate->bw;
+		status.rate_idx = rate->mcs_or_legacy_index;
+	} else {
+		status.encoding = 0;
+		status.bw = 0;
+		status.enc_flags = 0;
+		status.rate_idx = 0;
+	}
+
 	memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
-- 
2.7.4

