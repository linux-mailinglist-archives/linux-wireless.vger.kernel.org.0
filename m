Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02635ADEA7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiIFEtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIFEtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807975FAD2
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:49:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fa2so10082459pjb.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=K8GudPxsF46B4+Ei1CxsynahHoMg60f2b5O5c9BJbtM=;
        b=Ibsx89k23ABRA1v3f/HUdPaEwPWfD3htmwZKVfDwePnZpYbcQcM76qMXQzWDLYBss2
         qd3DQ1bB8FZjpi9tauV5HS6S6YuLFeqy7d8FqAR1aMjqrvbrduAWOfklqmuC7gOAeMOj
         Qd7fQIOZf+yycDBnJOQJs3DbvunsSqvj9SanRhGJHoeBGVySWs1upRN9id6WNxB7lZPM
         gDvxP/yGetPi0ZfNjnQ8H2hyhv/WaeKD5bBuLTEeUcLlDQ31pUbDFvfSte5nrw+IjPrE
         c4RoLFbSCcx3BOso8QTxrpxbrpgGuLtVoQLz6Wg7DK8aruPO9gCMT08Xy6nzUgZff1BW
         9aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K8GudPxsF46B4+Ei1CxsynahHoMg60f2b5O5c9BJbtM=;
        b=mgBBs9YXwe18NN+WjRkW2lj60dLte/8rUg3YigbRtPKqeuOsAr/Z9AhSWkM4fXwj5a
         xIDJCXqUfsIGLh8e3TRidXk+oXtFziPrt7J8DUXIGFjks9yhcFr1o5fCfnIe4j5on+zx
         nx8AtOmzeShT5VxIIA5GBQNR7sviG/506/eMrrzJX+Sah1ItQsSWiAnlzD2LRxqj24jf
         Hg8IEyD1XtTBUwNDQEBDEE/dXUg7Q2Z5mMgv4rSqgZc2PASEe+vXOaeprfui6gWRkhTI
         OonvpMREuvtnnAJfPpd2gzBVHxqDT1oJfdJx1eIEF+SX4jLSuSBlP/6+mJh2FGwCCls+
         /eRQ==
X-Gm-Message-State: ACgBeo10FDwE+Ccx0rUR2J0AJ8M72k26z/ykfP4tl/d/Vkp8KBtfjE9g
        4ajLOZLxD1vI3Ar/FM1H713WzQ==
X-Google-Smtp-Source: AA6agR5CzYraGaNfpf0Fz53weHpPQ1UR0z/VHKsv4j5oFVviYr0oeicsDQiEW8Zh6NYy7Ngck/KwHg==
X-Received: by 2002:a17:90b:1bc8:b0:200:43c7:5940 with SMTP id oa8-20020a17090b1bc800b0020043c75940mr11801455pjb.46.1662439743104;
        Mon, 05 Sep 2022 21:49:03 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:49:02 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 07/12] mac80211: S1G capabilities information element in probe request
Date:   Tue,  6 Sep 2022 16:48:07 +1200
Message-Id: <20220906044812.7609-8-kieran.frewen@morsemicro.com>
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

Add the missing S1G capabilities information element to probe requests.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/util.c        | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cd8879998739..e8ff4af9fc03 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2400,6 +2400,7 @@ void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb);
 void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
+u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 53826c663723..78e8c286011e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1857,6 +1857,12 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
 	shift = ieee80211_chandef_get_shift(chandef);
 
+	/* For direct mac80211 scan (probe request), add S1G IE and consider its override bits */
+	if (band == NL80211_BAND_S1GHZ) {
+		pos = ieee80211_ie_build_s1g_cap(pos, &sband->s1g_cap);
+		goto done;
+	}
+
 	num_rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if ((BIT(i) & rate_mask) == 0)
@@ -2919,6 +2925,21 @@ size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset)
 	return pos;
 }
 
+u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap)
+{
+	*pos++ = WLAN_EID_S1G_CAPABILITIES;
+	*pos++ = sizeof(struct ieee80211_s1g_cap);
+	memset(pos, 0, sizeof(struct ieee80211_s1g_cap));
+
+	memcpy(pos, &s1g_cap->cap, sizeof(s1g_cap->cap));
+	pos += sizeof(s1g_cap->cap);
+
+	memcpy(pos, &s1g_cap->nss_mcs, sizeof(s1g_cap->nss_mcs));
+	pos += sizeof(s1g_cap->nss_mcs);
+
+	return pos;
+}
+
 u8 *ieee80211_ie_build_ht_cap(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 			      u16 cap)
 {
-- 
2.34.1

