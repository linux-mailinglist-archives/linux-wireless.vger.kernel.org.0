Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2491D5ADE9E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiIFEtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIFEtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62265F981
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:49:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c24so9573261pgg.11
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cGKebCJTTmHoJDxgEyDfxV59WE1YuVso0IOHSeDM1lI=;
        b=wO/ETsTV2qOsXmTsnTQz34UjxOkDNgoXJIyJJVfLoOGuDBXrFsPaEx2i76RnDzn84J
         0/Csne0fUoriRurBuoC1ZSEpqLPQgksIExe1eWEAmUia7GPL1hnVthHIjlFOAHD867Vu
         sgRLikXi7onrtiQ0dGa3Pu1xQtFxsnTVsowImAzAbWms9voa16J0+QcaEnSwyBSnxnD4
         nnwLpD7o0JSdpON15nWPXQq3VRgFmbGaj9/hJepBaeumvk07BLjF6Ma1YxK/br2KQnHJ
         suKyc+Ip4MxDUeWjtt9DqzPEMoOCgXU15mbKDBEeVehh81ztWr2keoEe6AFoRUPIgN7R
         KwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cGKebCJTTmHoJDxgEyDfxV59WE1YuVso0IOHSeDM1lI=;
        b=qTFabjMkWK5flZLb58s88ZI/jgQAjI2F/LyDV15CsdrptlsjTLXYYs/srq1rZybItn
         +wA3gCHggn/vHnUuUk128bIQu7WmnBdhtXT4Wrv8lAF1hfu6ncGYnV9xWd2JhMG7X41a
         P71RLXte0TsCqv3UWTxsWjzujboj8knn4Ecv/E6ggvl1tAw8xXIWeorNmLa59Xc5PJMM
         l8ja0hJ2BD50LUtAl6PjtwOhQw8+1eddyjY4wZ6u6wmUby6s1crS6Z0AVSxYI9xBjHfI
         aSwqnyx5PR5EPmQcLxvg4cBQEHw5ZKiao87P6B0hUnl9RXXnCJJn6HhTeBmMluC80NLU
         sAeA==
X-Gm-Message-State: ACgBeo1lOqyEyQrfiLUoORGZZ7xyiCyWTDqml7CTh+SsIQyMBZTxDdD8
        RrPCUxg+gapfBN9nOWzQenEP0A==
X-Google-Smtp-Source: AA6agR4JpCal74uSGWvpzxVWwRXPXeMsceoxQURFEnAfjsYDOlPv9zylrWyxozZSZPOa2FTdQEyD/Q==
X-Received: by 2002:a62:1c8f:0:b0:537:2284:bd00 with SMTP id c137-20020a621c8f000000b005372284bd00mr53457672pfc.78.1662439748434;
        Mon, 05 Sep 2022 21:49:08 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:49:08 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 09/12] nl80211: support advertising S1G rate information
Date:   Tue,  6 Sep 2022 16:48:09 +1200
Message-Id: <20220906044812.7609-10-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
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
2.34.1

