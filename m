Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29A5A4F80
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiH2OmL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiH2OmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:42:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B7E979CB
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e20so10440064wri.13
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QKJYCZBZ7zF/rLnjuEFP7T+ofEp0leg9es3w94vqizY=;
        b=awE/RH/UqWjtxXVINq2YBt9UbMhX8jW6WyCPYzZRoVzXCAI5yRrFLnHsptST33nC/O
         fm/PWJFAEAjE3PM/e+6PwPx6pURxEvY3AXCJeqUitziOEEFJ+mmRxobdw18KRvVA0J5H
         2S8QxLEJMT99xMyYu4Vow3GtJD50dLvmfp2fcHDHEnk8jHTkiMoN2N3Gu/buRKoJfKEE
         TKVHLuEin3z+a8ytG09a09YnAdZx381VDRGkyebg33ax0/OG71SEGV5+KWSpFb1LRLiA
         gUU85WHeaabmzvZVFCU3T8XH5Hd12BlNa8h/Ya6l570g4MqmaKQizP9VO8Vp7kr0k3DF
         HmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QKJYCZBZ7zF/rLnjuEFP7T+ofEp0leg9es3w94vqizY=;
        b=24MaNTs+y4E2rFiS5lPG1P47ZCvP1xW2mflvyWbX7Q4lZ+PaRQyTLF/rpAsUyCv7D6
         ISlSl/PWF3LYVBFAF7xLyMU205y6He11ZYvdUhBLUmic3Swucd1uEuojKw+iXf/u2kV/
         4u+UhFlbFPoZtuOaJtp60SCMW6E9G1OnBJ7HudyACVP1A/DFcG+xXLgnATI6VAe61ZsL
         TmQhds+vppLKcagSBXmE4bJRT8aLVtHvB9efZ4e4T0we5qeHMEO2inPDXcP9hMBsC8f0
         wVDGq1/be0RZhmhUfF6A8MepwEtfbgzX6KIkMvl+5LO4aSYFKvko5PVtJrptcGScYJ/g
         mSGA==
X-Gm-Message-State: ACgBeo2UoOwi2LOGKW9p+kQS5hSVXCRlxceS0dzZeEc0yMsQX0t6Ul15
        uGz9gc1XaPR2XKSU0nA8hT4Qx71IH1k=
X-Google-Smtp-Source: AA6agR5iled6ZlalhYFm7u7/W3BCRmsfgZaO4QiPKkro3ufU/pO6nuCSkYKcHGDbMOxzqF3EcUXBAw==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr6650059wri.455.1661784124549;
        Mon, 29 Aug 2022 07:42:04 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f18a600880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f18:a600:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9398431wmc.41.2022.08.29.07.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:42:03 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [RFC 4/4] mac80211: add utility function for tx_rate - rate_info conversion
Date:   Mon, 29 Aug 2022 16:41:47 +0200
Message-Id: <20220829144147.484787-5-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829144147.484787-1-jelonek.jonas@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds an utility function to mac80211 for conversion between
ieee80211_tx_rate (mac80211.h) and rate_info (cfg80211.h).

struct ieee80211_tx_rate is space limited to annotate rates up to IEEE
802.11ac. The new struct rate_info is able to annotate IEEE 802.11ax
rates and beyond. Several drivers internally still use ieee80211_tx_rate
but mac80211 expects rate_info in struct ieee80211_rate_status. This
struct is in turn required to allow, e.g., tx-power status report or
dynamic number of mrr stages.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 include/net/mac80211.h |  4 ++++
 net/mac80211/util.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ce3241313e06..cecba460a518 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1050,6 +1050,10 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
 	return (rate->idx >> 4) + 1;
 }
 
+void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate *rate,
+				  struct wiphy *wiphy, u8 band,
+				  struct rate_info *rate_info);
+
 /**
  * struct ieee80211_tx_info - skb transmit information
  *
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a292e63377c3..466d49ff8dcf 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4870,3 +4870,38 @@ void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
 
 	*len_pos = elem_len;
 }
+
+
+void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate *rate,
+				  struct wiphy *wiphy, u8 band,
+				  struct rate_info *rate_info)
+{
+	memset(rate_info, 0, sizeof(struct rate_info));
+
+	if (rate->flags & IEEE80211_TX_RC_MCS) { /* 802.11n */
+		rate_info->flags |= RATE_INFO_FLAGS_MCS;
+		rate_info->mcs = rate->idx;
+	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) { /* 802.11ac */
+		rate_info->flags |= RATE_INFO_FLAGS_VHT_MCS;
+		rate_info->mcs = ieee80211_rate_get_vht_mcs(rate);
+		rate_info->nss = ieee80211_rate_get_vht_nss(rate);
+	} else { /* 802.11a/b/g */
+		rate_info->legacy = wiphy->bands[band]->bitrates[rate->idx].bitrate;
+		rate_info->bw = RATE_INFO_BW_20;
+		return;
+	}
+
+	if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+		rate_info->bw = RATE_INFO_BW_40;
+	else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+		rate_info->bw = RATE_INFO_BW_80;
+	else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+		rate_info->bw = RATE_INFO_BW_160;
+	else
+		rate_info->bw = RATE_INFO_BW_20;
+
+	if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
+		rate_info->flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+}
+EXPORT_SYMBOL(ieee80211_rate_get_rate_info);
-- 
2.30.2

