Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46556D266
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGKBJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGKBJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531315FE2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r1so3181108plo.10
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+ne/UYswmphwy9OweGF6u67TAf6M/bMHMTMkD1A5YU=;
        b=w+/sYLpOw4FnugUFIuzt8mqPeyFevJc1FYDEnWEvBx57/f6VMm2pEtWU+ErcP1Yxh9
         7EbnjCfxTZi0Obs4oDDolEWOgDDLCpjk5W0VPEXf+rOhQLoWpFk3fqhkdk9aHBFyZgMT
         kj+W1oFdnRTW5EXYTLnhVtZuFt4mHVGNhOVnAgybYjswlAUtzUq1xX/++BPEef1glspp
         bdU79lc8FZSASCmN41Pk0ODHaJCQzW3PPH8Ga3alItkd7dOO0WxnTWb52Co6VbMZexVA
         cEf56qsCXKGMURx3/k8bQ0RN2uPoLNbvNoJSnU15bXaJhubqT6BfY25uwNb/3gSNp9yM
         d0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+ne/UYswmphwy9OweGF6u67TAf6M/bMHMTMkD1A5YU=;
        b=s9IU/cE6HSa939wAVT4pDrxDUaKByr7SB9Gkn0i0h7o9S+nwXv1CbVLQlMJiMgZtpL
         1ch2BU4liZqi5HjY1coifXzez5aNurLMCBJL4KQizohYSH4MVWxtKk10SdrjjygrJ2nl
         HxhoSvIcISnUjofZs8kO/o6m243G/97sWw3GO++gcMxJZxlatF59hzjQbR8ZnFZ8JX08
         INtu/va38Sq2t7ReKbsgBEaMIwF9WMhWzftRf+x++HvlcVz5/qk7iNrDKoEB+DmQ5P0O
         1JVx+KTFhFF9DMELjgrNNGcz85z3u244OEQQTKWtxXLL+n9j/Px9n7P5tsvXrOI35OVQ
         5/rg==
X-Gm-Message-State: AJIora+voBp7aEN3zBZOe+ox+XWddxR/smOcNWbuTl+UkD25aQSns6oH
        e2oHDhH4Rd4MBKVGOXQ7srGKog==
X-Google-Smtp-Source: AGRyM1uVcMqGd/Zyza6/cJP5TUlGDeE5PDOWt9poK+k60xaxxo6Z79YXcXTuMnYKsCL+JyqSfcIa3g==
X-Received: by 2002:a17:902:7209:b0:16b:fa09:5d6 with SMTP id ba9-20020a170902720900b0016bfa0905d6mr16308442plb.120.1657501758016;
        Sun, 10 Jul 2022 18:09:18 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:17 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 09/12] nl80211: support advertising S1G rate information
Date:   Mon, 11 Jul 2022 01:08:13 +0000
Message-Id: <20220711010816.45927-10-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add S1G rate information to netlink STA rate message.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 71074332ccc5..19cf030004e9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3539,6 +3539,13 @@ enum nl80211_eht_ru_alloc {
  *	(u8, see &enum nl80211_eht_gi)
  * @NL80211_RATE_INFO_EHT_RU_ALLOC: EHT RU allocation, if not present then
  *	non-OFDMA was used (u8, see &enum nl80211_eht_ru_alloc)
+ * @NL80211_RATE_INFO_S1G_MCS: S1G MCS index (u8, 0-10)
+ * @NL80211_RATE_INFO_S1G_nss: S1G NSS value (u8, 1-4)
+ * @NL80211_RATE_INFO_1_MHZ_WIDTH: 1 MHz S1G rate
+ * @NL80211_RATE_INFO_2_MHZ_WIDTH: 2 MHz S1G rate
+ * @NL80211_RATE_INFO_4_MHZ_WIDTH: 4 MHz S1G rate
+ * @NL80211_RATE_INFO_8_MHZ_WIDTH: 8 MHz S1G rate
+ * @NL80211_RATE_INFO_16_MHZ_WIDTH: 16 MHz S1G rate
  * @__NL80211_RATE_INFO_AFTER_LAST: internal use
  */
 enum nl80211_rate_info {
@@ -3565,6 +3572,13 @@ enum nl80211_rate_info {
 	NL80211_RATE_INFO_EHT_NSS,
 	NL80211_RATE_INFO_EHT_GI,
 	NL80211_RATE_INFO_EHT_RU_ALLOC,
+	NL80211_RATE_INFO_S1G_MCS,
+	NL80211_RATE_INFO_S1G_NSS,
+	NL80211_RATE_INFO_1_MHZ_WIDTH,
+	NL80211_RATE_INFO_2_MHZ_WIDTH,
+	NL80211_RATE_INFO_4_MHZ_WIDTH,
+	NL80211_RATE_INFO_8_MHZ_WIDTH,
+	NL80211_RATE_INFO_16_MHZ_WIDTH,
 
 	/* keep last */
 	__NL80211_RATE_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 077dc2938551..70efed2b5899 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6073,6 +6073,21 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		return false;
 
 	switch (info->bw) {
+	case RATE_INFO_BW_1:
+		rate_flg = NL80211_RATE_INFO_1_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_2:
+		rate_flg = NL80211_RATE_INFO_2_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_4:
+		rate_flg = NL80211_RATE_INFO_4_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_8:
+		rate_flg = NL80211_RATE_INFO_8_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_16:
+		rate_flg = NL80211_RATE_INFO_16_MHZ_WIDTH;
+		break;
 	case RATE_INFO_BW_5:
 		rate_flg = NL80211_RATE_INFO_5_MHZ_WIDTH;
 		break;
@@ -6137,6 +6152,14 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		    nla_put_u8(msg, NL80211_RATE_INFO_HE_RU_ALLOC,
 			       info->he_ru_alloc))
 			return false;
+	} else if (info->flags & RATE_INFO_FLAGS_S1G_MCS) {
+		if (nla_put_u8(msg, NL80211_RATE_INFO_S1G_MCS, info->mcs))
+			return false;
+		if (nla_put_u8(msg, NL80211_RATE_INFO_S1G_NSS, info->nss))
+			return false;
+		if (info->flags & RATE_INFO_FLAGS_SHORT_GI &&
+		    nla_put_flag(msg, NL80211_RATE_INFO_SHORT_GI))
+			return false;
 	} else if (info->flags & RATE_INFO_FLAGS_EHT_MCS) {
 		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_MCS, info->mcs))
 			return false;
-- 
2.25.1

