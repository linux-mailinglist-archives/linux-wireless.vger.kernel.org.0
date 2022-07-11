Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E256D263
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGKBJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiGKBJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED55615A24
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y18so3203979plb.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP2Xh2jTVuEvoNP5QULFaNS+5OUv0Z2UMJAizsDyPds=;
        b=PFor8hDk3U8LxtvWU0mbNtVd8XtId6oJbGrj7y7YVmvhAMByUa8pXj+xbDb3MHGnjq
         uyzKzHm5ZCSyfa8ckMvSn1w4WYpbBGzPpjXx2rHtsDLg7o6jKWXojyqtrpO0Z5n4EEIS
         tVI9XTpDP/NFrqeo+c72Mq1qGwvUocTHEyMj5zFJNXUf4wKcGTu5lCapNEEqkx2cI2I7
         6M7qH3V2kFWM9knIZOIDTUT48sB5UJYFqiJEfqf0SP1yzQP4DcJ0hYCUKe31RH3KqAEF
         RWwtnjoJs5OIf1jROlGCWre8L/41a8iHkJtcoP2tnRdrKkKC0tvy0obqJm3PugSzcsvL
         PIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP2Xh2jTVuEvoNP5QULFaNS+5OUv0Z2UMJAizsDyPds=;
        b=oaCSFNmIjGFqI+Skk8PM9QiVgVQxj6Bbs7ZgMS2HdkaLddqWQD6IoM36W7Q9JYWKYS
         8iFWfxwspkR5fMrMhH18pFKzqJxNCNsfJwfFc2u5swVyMIwyWPsuMvY3S1Xm6iVW9QkG
         6yVZKXFxNooCIYqrkBfZCAMJhariajmD4UqJlxeVhHayMjCdf4iKrfOUs5T0XWiQxneM
         2djvXf8Kk/jHUgYsSz1m+jW9LcjWPHsnim/iCbRHXNCaqWdrWf5e+ePrCgPRDx+qPZYR
         XnEz71BlJiDT0HA2GoK8+yS2vBUIsOsNSjigJrzS1dnywipsQD7lgLSUPJ0/DgB5/HSo
         oMtg==
X-Gm-Message-State: AJIora+UB4RHT7RVXK7oL6AS+ty5h7WKvG1V5lNcLRb/+iZHOPNcY2Bv
        wXLoNyaWjtwUKlHc7uH/fVz42g==
X-Google-Smtp-Source: AGRyM1twaeuK3LLDlf0Fxs5IajXc+Sn8mvqOzZc9oQcC05Pz5yS+TStp5jusUYaC/on+D+3eh14C/w==
X-Received: by 2002:a17:902:6a81:b0:16b:d807:9acd with SMTP id n1-20020a1709026a8100b0016bd8079acdmr15473644plk.40.1657501752390;
        Sun, 10 Jul 2022 18:09:12 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:12 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 07/12] mac80211: S1G capabilities information element in probe request
Date:   Mon, 11 Jul 2022 01:08:11 +0000
Message-Id: <20220711010816.45927-8-kieran.frewen@morsemicro.com>
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

Add the missing S1G capabilities information element to probe requests.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/mac80211/util.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bccc3a309ed0..51a2c1dee360 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1832,6 +1832,43 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
 	shift = ieee80211_chandef_get_shift(chandef);
 
+	/* For direct mac80211 scan (probe request), add S1G IE and consider its override bits */
+	if (band == NL80211_BAND_S1GHZ) {
+		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+		struct ieee80211_s1g_cap s1g_capab;
+
+		*pos++ = WLAN_EID_S1G_CAPABILITIES;
+		*pos++ = sizeof(s1g_capab);
+
+		memcpy(s1g_capab.capab_info,
+		       sband->s1g_cap.cap,
+		       sizeof(sband->s1g_cap.cap));
+		memcpy(s1g_capab.supp_mcs_nss,
+		       sband->s1g_cap.nss_mcs,
+		       sizeof(sband->s1g_cap.nss_mcs));
+
+		/* override the capability info */
+		for (i = 0; i < sizeof(ifmgd->s1g_capa.capab_info); i++) {
+			u8 mask = ifmgd->s1g_capa_mask.capab_info[i];
+
+			s1g_capab.capab_info[i] &= ~mask;
+			s1g_capab.capab_info[i] |= ifmgd->s1g_capa.capab_info[i] & mask;
+		}
+
+		/* then MCS and NSS set */
+		for (i = 0; i < sizeof(ifmgd->s1g_capa.supp_mcs_nss); i++) {
+			u8 mask = ifmgd->s1g_capa_mask.supp_mcs_nss[i];
+
+			s1g_capab.supp_mcs_nss[i] &= ~mask;
+			s1g_capab.supp_mcs_nss[i] |= ifmgd->s1g_capa.supp_mcs_nss[i] & mask;
+		}
+
+		memcpy(pos, &s1g_capab, sizeof(s1g_capab));
+		pos += sizeof(s1g_capab);
+		/* No more IEs relevant for S1G */
+		goto done;
+	}
+
 	num_rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if ((BIT(i) & rate_mask) == 0)
-- 
2.25.1

