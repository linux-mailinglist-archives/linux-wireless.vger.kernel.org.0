Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE10C5A5943
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiH3CU4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiH3CUy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:20:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB47CA80
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so9749658plo.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Lnc1jRQoUitPJdCP9NlBPCdgamf0FJFP9HvqmIiYuFE=;
        b=qI/Opfxhx8qAw85Txt3I77Dw+LFuZjuu+pvf+Wif2+mAESb7Z9cX/jSEEl+c7NTNpT
         ka2z2ywWapJa5QrbZ10dTDckEkeurnDSb9YzGBoM0HmgncK9BHUy6phvHvP3q60TCkth
         Wu7bloYTJHckCI+ZbnKWJoaFP096RIN6HLzi98sc0iyGu3ifrOkwKyaZI3e9aaAB3/Fz
         HB7R3nNczPc65JnvA9yxeJu1XCAckKvJH7ZlfD2Wy1n1PI9LurB3X1CAIp8c09J1Mujy
         kfeI4MEsHqcgurfMTi1qOW8Gdw586L7XvyXV49XsNP2FhoauELDQl6z53ap6KtRO+fc3
         h+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Lnc1jRQoUitPJdCP9NlBPCdgamf0FJFP9HvqmIiYuFE=;
        b=swjOJFMnm/k1jNKDcaGJg2uiQaSI9/AdITSt+s7O+jmQ1e0DVNXf9pY1ueizYUybNs
         XyXvGIS59uuOslqfgHM+IbTQalx+ZBuVssNcfBEJL8qwBAr6ViJbCUk6TvGQbgkAdVnm
         OcDvMdoL5pFY4pYmUy8AEyzselJAWgOtlpwbXayGwzDzTuqqsu3M2OpIzrKvdgP+/ZdC
         e0nyrJRqQJA/drZ/D6HLkHXs9eHdXx4Kd4NUMDDbfQl21pXEYCcZvKw7GCDRdm+nigki
         yakTcVNvWPYm89KzF7L1VQZAdg8BvNNNsPLC76q/LLq1ulE26z6Kv6dwXtXqJkZinCQ4
         xh3g==
X-Gm-Message-State: ACgBeo0gpPV9nwxDYZm6UAV31mKjhEr9Sp1HPIKSQO1Wmcx7/FbYfG8H
        5vc7KuS+UFngnPKnxDQEXtVLKg==
X-Google-Smtp-Source: AA6agR6Og5qGE35Qa9ofTifmJWT9oXigxlmYkimPbGYoXcUbxWBybpI8z5W7990vHYF6pkfSAAph3A==
X-Received: by 2002:a17:902:7242:b0:171:398d:9e66 with SMTP id c2-20020a170902724200b00171398d9e66mr19317802pll.19.1661826052385;
        Mon, 29 Aug 2022 19:20:52 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:51 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 05/12] nl80211: support advertising S1G capabilities
Date:   Tue, 30 Aug 2022 02:20:10 +0000
Message-Id: <20220830022017.51017-6-kieran.frewen@morsemicro.com>
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

Include S1G capabilities in netlink band info messages.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7daa2ce1cb57..f20b9aefd420 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3994,6 +3994,10 @@ enum nl80211_band_iftype_attr {
  * @NL80211_BAND_ATTR_EDMG_BW_CONFIG: Channel BW Configuration subfield encodes
  *	the allowed channel bandwidth configurations.
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
+ * @NL80211_BAND_ATTR_S1G_MCS_NSS_SET: S1G capabilities, supported S1G-MCS and NSS
+ *	set subfield, as in the S1G information IE, 5 bytes
+ * @NL80211_BAND_ATTR_S1G_CAPA: S1G capabilities information subfield as in the
+ *	S1G information IE, 10 bytes
  * @NL80211_BAND_ATTR_MAX: highest band attribute currently defined
  * @__NL80211_BAND_ATTR_AFTER_LAST: internal use
  */
@@ -4014,6 +4018,9 @@ enum nl80211_band_attr {
 	NL80211_BAND_ATTR_EDMG_CHANNELS,
 	NL80211_BAND_ATTR_EDMG_BW_CONFIG,
 
+	NL80211_BAND_ATTR_S1G_MCS_NSS_SET,
+	NL80211_BAND_ATTR_S1G_CAPA,
+
 	/* keep last */
 	__NL80211_BAND_ATTR_AFTER_LAST,
 	NL80211_BAND_ATTR_MAX = __NL80211_BAND_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5e9aaa8c0d7d..931e35619cf4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1949,6 +1949,16 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 
 	nla_nest_end(msg, nl_rates);
 
+	/* S1G capabilities */
+	if (sband->band == NL80211_BAND_S1GHZ && sband->s1g_cap.s1g &&
+	    (nla_put(msg, NL80211_BAND_ATTR_S1G_CAPA,
+		     sizeof(sband->s1g_cap.cap),
+		     sband->s1g_cap.cap) ||
+	     nla_put(msg, NL80211_BAND_ATTR_S1G_MCS_NSS_SET,
+		     sizeof(sband->s1g_cap.nss_mcs),
+		     sband->s1g_cap.nss_mcs)))
+		return -ENOBUFS;
+
 	return 0;
 }
 
-- 
2.25.1

