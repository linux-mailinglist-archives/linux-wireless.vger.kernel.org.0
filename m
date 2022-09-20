Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B325BE393
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiITKmI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiITKll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DA6447
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so799188wmb.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c5J9I9vY/mPbtTeNVZ3vAl8CHXLB79/s4WJqXsA3snc=;
        b=iQ0GNeXM5ZyMqZyUnnWVTOMAwLvEbGZTK/eMwwx2MH1WVjwg4k4hd19bQVSNhAuN9m
         xY78FuunApFmlFkYfsnyBx9aQzPeRorJ1AA8FTHD9CxofV7hdDzdDPmOv2kvuukCqwUg
         mAsrHA3TviqLWBKKo08v+kE8P3XvozAfMTrkw12FPqSbx/SqE3bCLitNYhcKNgCFTyal
         04cZAhcBAn6MlKf+aTjxfFtnk3NG/buxYsAu++B8jVRYhj4Bo4+DPAxqT2Zc9UIa6spC
         VOFLIe/lnfgaaBsFYZlRJGu+xVgDPbBeAb8/UWTCDsSS8oberbKM7iYgZ0/9F7VW8Cnx
         BGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c5J9I9vY/mPbtTeNVZ3vAl8CHXLB79/s4WJqXsA3snc=;
        b=zzz4leuNYWbwUPPp0Zx4Wzp+Go98Cw8mynUxTT0udzIgoCG0ZT8qEMbzmIj+G3MtTX
         LbbAbdwl2gVKScRPtkLcGM8pNnnz4RIv0S7EMH0BVpyBkaVTF75PcKvZiT9vN6KugOLX
         nkjnPm/PoqeuiI8ce8YH/mGVrfaeKQHcfQtWdIe27JlCP6b8ydFXQ0+nEHZeG6ZDbSr3
         HMwJpjO1GS4yGspBlvWMbqNtgsLmByCfsoM3lyv43QSAtMNzkcwrdw9XRgziwdSRNMJm
         +z1DVm5MMo7vid6RWoicM2RYFX4js5zUlCon8ouvkTaOo73URHUBF61FclJCf4pm5xky
         H14Q==
X-Gm-Message-State: ACrzQf1lG6jxcGvSygFsGXDdzmvV1helu/l5gyBCcsuqHld1dFZs6ngq
        rMvDNKV942yukhvdM+yuQCallfQ7cFG5HQ==
X-Google-Smtp-Source: AMsMyM7mLF0th6jZOuTKOC+8BYyMVIIHmMM21h9eFaltc6OHPpy5Ldj7hBB4XSRw6hqFJOlqVFJ25Q==
X-Received: by 2002:a05:600c:310b:b0:3b4:c618:180d with SMTP id g11-20020a05600c310b00b003b4c618180dmr1860271wmo.25.1663670454146;
        Tue, 20 Sep 2022 03:40:54 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:53 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [RFC v2 4/6] mac80211: add utility function for tx_rate - rate_info conversion
Date:   Tue, 20 Sep 2022 12:40:30 +0200
Message-Id: <20220920104032.496697-5-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920104032.496697-1-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
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
index c4b55c7273ed..f17a03caa361 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1051,6 +1051,10 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
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
index 0ea5d50091dc..c76dc255bec3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4867,3 +4867,38 @@ void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
 
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

