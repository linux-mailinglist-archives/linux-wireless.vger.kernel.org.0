Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7090D5A5948
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiH3CVG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiH3CVF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:21:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2C7F265
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fa2so2062875pjb.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZVa/R6UME+KAXTvZ2VEc4+25YJNjCZ9DOcQLRqlS3Rg=;
        b=cw7lhNzSn040sBGnoDq4pxcT157HKq1qhMdkCa8jYtOeW3Ulkx8CFPvL18ip4SeMaM
         XSfIF9V8S0wGyHxLgaXbKBSsaaEc7cc0pmRY/VQuybq3aNZg6oisxgLAiWBtCJVWoNFL
         stDu+KHsoXbADo6LqyxZDdkJTT6JAvx5UG2D6CuUq7WgFZZXVmk7TH9dqwqBLLOgAfxz
         hIiN38z1kV242tDPNOk5zams5zhB9E465HsNEzl6+r/Dp0z3f7zUhNUKJijUSTFw7wk5
         L/8qoYH1pJqngkuf2azqLXJj7lWzHh5fPbWBhfh1BAnRpweGtFmov1EUM2v6aAwWzoWS
         aOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZVa/R6UME+KAXTvZ2VEc4+25YJNjCZ9DOcQLRqlS3Rg=;
        b=il/O3hJQTX1ASR8FVrfHBo8Ka76G/QIclMksaXKFe4fx+fsxwnSNusrR1ths6c0Lu8
         frHc7onB4iX64dVlP2lsDQ1XXYyLN5hVjB322sHNKgTUNGTWpQccBzxXNKZMGtBlysTj
         5TAjoKmHpnKW8/W8yjqQSw+QbYodU+MTES2+9HzNmSkwJtIGU7n4FKX9GcdaNjj1z8JY
         9rxGz6De2U0VqnlWqkd8jgTzClxSUKVsuCuarJ0H1gohht6ogA9mMuS8lWYzW1oH34by
         lNUETwT31BFOJOt50hAo8pmn4H8RKwa/HNvo30Eadc77JfVBot01YhtCdT1bX14uqdS3
         yGxw==
X-Gm-Message-State: ACgBeo3+un0/LwP/CQTxr+ZHyvlSMGyTOjSIPPj+/wY9MLMVv/1XQlfG
        vNqA2UjSM41Rnf2aLcz6f6VRkw==
X-Google-Smtp-Source: AA6agR7fX8WR3hZSalJ8TR14Qv6ePomKVLWtuXGGhlbe2en+A+26QcsoWzuLKaTXucUIEXnFHUhcPA==
X-Received: by 2002:a17:902:f712:b0:171:29d0:6f9f with SMTP id h18-20020a170902f71200b0017129d06f9fmr19267716plo.84.1661826063753;
        Mon, 29 Aug 2022 19:21:03 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:21:03 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 09/12] nl80211: support advertising S1G rate information
Date:   Tue, 30 Aug 2022 02:20:14 +0000
Message-Id: <20220830022017.51017-10-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
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
---
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f20b9aefd420..5ae301905671 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3600,6 +3600,13 @@ enum nl80211_eht_ru_alloc {
  *	(u8, see &enum nl80211_eht_gi)
  * @NL80211_RATE_INFO_EHT_RU_ALLOC: EHT RU allocation, if not present then
  *	non-OFDMA was used (u8, see &enum nl80211_eht_ru_alloc)
+ * @NL80211_RATE_INFO_S1G_MCS: S1G MCS index (u8, 0-10)
+ * @NL80211_RATE_INFO_S1G_NSS: S1G NSS value (u8, 1-4)
+ * @NL80211_RATE_INFO_1_MHZ_WIDTH: 1 MHz S1G rate
+ * @NL80211_RATE_INFO_2_MHZ_WIDTH: 2 MHz S1G rate
+ * @NL80211_RATE_INFO_4_MHZ_WIDTH: 4 MHz S1G rate
+ * @NL80211_RATE_INFO_8_MHZ_WIDTH: 8 MHz S1G rate
+ * @NL80211_RATE_INFO_16_MHZ_WIDTH: 16 MHz S1G rate
  * @__NL80211_RATE_INFO_AFTER_LAST: internal use
  */
 enum nl80211_rate_info {
@@ -3626,6 +3633,13 @@ enum nl80211_rate_info {
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
index 931e35619cf4..73eef7e9f4c3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6133,12 +6133,27 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
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
 	case RATE_INFO_BW_5:
 		rate_flg = NL80211_RATE_INFO_5_MHZ_WIDTH;
 		break;
+	case RATE_INFO_BW_8:
+		rate_flg = NL80211_RATE_INFO_8_MHZ_WIDTH;
+		break;
 	case RATE_INFO_BW_10:
 		rate_flg = NL80211_RATE_INFO_10_MHZ_WIDTH;
 		break;
+	case RATE_INFO_BW_16:
+		rate_flg = NL80211_RATE_INFO_16_MHZ_WIDTH;
+		break;
 	default:
 		WARN_ON(1);
 		fallthrough;
@@ -6197,6 +6212,14 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
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

