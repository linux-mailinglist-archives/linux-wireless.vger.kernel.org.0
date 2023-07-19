Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4301759EDD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSTkr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjGSTkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 15:40:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CB1FD3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 12:40:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8baa836a5so38855ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689795643; x=1690400443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=538CnBBrHOSem6p7BaqZGrPHWTZO235qiwneX3PtIpk=;
        b=ML0eDQsY6hXz8g9K+f3FAY0yBisvXuEGe547NeRU+dpqwQxTukHJuCmIGNZAy8s1fA
         C+aROZnC4ekzG/pbwGpk1yUi5S2gJ8nfB9zYmL3D9zhFfywgbm14orYhDxkS+iKLetxq
         u1TWk5s+TBvmkLAzBnEMzMj7xYhcGKeAiEuvau9D2DXih83XqFlY6kWmtNB5goUkS4UL
         Oh7/96jRpePI5y/EjedtjLqpmRUzvtK1JyeIINqJlOKp2pGnGTQUVUx4rrz6Wb6xqSex
         n7lGbwY7KASOtD4ZgcWkSrK+M6E7Qygjo75Er1MVYPW0A/tOSzCqod/8u7mvXtaOC2fi
         /iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795643; x=1690400443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=538CnBBrHOSem6p7BaqZGrPHWTZO235qiwneX3PtIpk=;
        b=MJ+DioL232+zFn8TgF93Pd/RBpnDiEhzfF9iKmzX3n8kOAP6qz92R5ViTj5HTA2JLn
         6p6sLX3Xvxeudm0UhyPTTaaqYTEqJOAsdNrRg0PRfN4FX5Bo+FbHLMFARPwIX0bgRP4r
         aOyhsgQ2TDKJ7b8R0M6THFSL2hVGoaW6ZwT8a9bkJOMk+TIWeAFYv4TiL3Qm7AZ7Rear
         9uPdC5I1q6trMngigftRa1y5GeYBF2/yAo2YC3v9oOP4wCMEtCxkwH+fSnAkZIUJ2u8A
         H8iXhb9XO1WKekBJeGQ/6TyIjG9UgyGzAuJkiEYxqYjA1uuL7AE7YG5SibGVK7lzQXs+
         cszQ==
X-Gm-Message-State: ABy/qLaBI4j1XrXZkrx+4OBWzULr/sW33VtlCasQpzhpMykeRh2oZfPr
        oDvgfnbzaOa3aA7D2rq4f8ggAbI+SkY=
X-Google-Smtp-Source: APBJJlEmEzJZLyoAgwxUJI0LpZxOa4aiy7aJZWt2En58B0Hg0vej3Y48rn6EkMJmco2E/gscSx7Dww==
X-Received: by 2002:a17:902:dad2:b0:1b8:b3f7:4872 with SMTP id q18-20020a170902dad200b001b8b3f74872mr23869479plx.28.1689795643089;
        Wed, 19 Jul 2023 12:40:43 -0700 (PDT)
Received: from smtp.gmail.com ([49.205.249.77])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001b042c0939fsm4358299plb.99.2023.07.19.12.40.41
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:40:42 -0700 (PDT)
From:   Chaitanya Tata <chaitanya.mgit@gmail.com>
X-Google-Original-From: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: Add support for sending BSSMaxIdle in association request
Date:   Thu, 20 Jul 2023 01:10:39 +0530
Message-Id: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When WNM is enabled, a station can send its preferred BSS maximum idle
period in the association request, add a new netlink attribute to get
this value from the supplicant and add BSS maximum idle IE in the
association request.

Tested using mac80211_hwsim with the corresponding WPA supplicant patch.

Signed-off-by: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  2 ++
 net/mac80211/ieee80211_i.h   |  4 ++++
 net/mac80211/mlme.c          |  4 ++++
 net/mac80211/util.c          | 11 +++++++++++
 net/wireless/nl80211.c       | 11 +++++++++++
 net/wireless/sme.c           |  1 +
 7 files changed, 35 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..fe8a5149a1d5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2961,6 +2961,7 @@ struct cfg80211_assoc_request {
 	struct cfg80211_assoc_link links[IEEE80211_MLD_MAX_NUM_LINKS];
 	const u8 *ap_mld_addr;
 	s8 link_id;
+	u16 bss_max_idle_period;
 };
 
 /**
@@ -3173,6 +3174,7 @@ struct cfg80211_connect_params {
 	size_t fils_erp_rrk_len;
 	bool want_1x;
 	struct ieee80211_edmg edmg;
+	u16 bss_max_idle_period;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c59fec406da5..b1608df96b83 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3341,6 +3341,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EMA_RNR_ELEMS,
 
+	NL80211_ATTR_BSS_MAX_IDLE_PERIOD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a0a7839cb961..5d83e9bd30ea 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -436,6 +436,8 @@ struct ieee80211_mgd_assoc_data {
 	u8 fils_kek[FILS_MAX_KEK_LEN];
 	size_t fils_kek_len;
 
+	u16 bss_max_idle_period;
+
 	size_t ie_len;
 	u8 *ie_pos; /* used to fill ie[] with link[].elems */
 	u8 ie[];
@@ -2614,4 +2616,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+
+u8 *ieee80211_add_bss_max_idle_ie(u8 *buf, u16 max_idle_period);
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e13a0354c397..2d955b237014 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1203,6 +1203,8 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
 	}
 
+	ieee80211_add_bss_max_idle_ie(skb_put(skb, 5), assoc_data->bss_max_idle_period);
+
 	if (iftd && iftd->vendor_elems.data && iftd->vendor_elems.len)
 		skb_put_data(skb, iftd->vendor_elems.data, iftd->vendor_elems.len);
 
@@ -7378,6 +7380,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 					req->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth = req->crypto.control_port_no_preauth;
 
+	assoc_data->bss_max_idle_period = req->bss_max_idle_period;
+
 	/* kick off associate process */
 	ifmgd->assoc_data = assoc_data;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1527d6aafc14..d0217fd50d50 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -5076,3 +5076,14 @@ void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
 
 	*len_pos = elem_len;
 }
+
+u8 *ieee80211_add_bss_max_idle_ie(u8 *buf, u16 max_idle_period)
+{
+	*buf++ = WLAN_EID_BSS_MAX_IDLE_PERIOD;
+	*buf++ = 3;
+	*(u16 *)buf++ = cpu_to_le16(max_idle_period);
+	/* Protected keep alive not applicable in association request */
+	*buf++ = 0;
+
+	return buf;
+}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d95f8053020d..1e6c49096407 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -816,6 +816,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
+	[NL80211_ATTR_BSS_MAX_IDLE_PERIOD] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -11136,6 +11137,11 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		ap_addr = req.bss->bssid;
 	}
 
+	if (info->attrs[NL80211_ATTR_BSS_MAX_IDLE_PERIOD]) {
+		req.bss_max_idle_period =
+			nla_get_u16(info->attrs[NL80211_ATTR_BSS_MAX_IDLE_PERIOD]);
+	}
+
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
 	if (!err) {
 		wdev_lock(dev->ieee80211_ptr);
@@ -11971,6 +11977,11 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_MLO_SUPPORT]))
 		connect.flags |= CONNECT_REQ_MLO_SUPPORT;
 
+	if (info->attrs[NL80211_ATTR_BSS_MAX_IDLE_PERIOD]) {
+		connect.bss_max_idle_period =
+			nla_get_u16(info->attrs[NL80211_ATTR_BSS_MAX_IDLE_PERIOD]);
+	}
+
 	wdev_lock(dev->ieee80211_ptr);
 
 	err = cfg80211_connect(rdev, dev, &connect, connkeys,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7bdeb8eea92d..3ab9adb3f1a4 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -200,6 +200,7 @@ static int cfg80211_conn_do_work(struct wireless_dev *wdev,
 		req.vht_capa = params->vht_capa;
 		req.vht_capa_mask = params->vht_capa_mask;
 		req.link_id = -1;
+		req.bss_max_idle_period = params->bss_max_idle_period;
 
 		req.bss = cfg80211_get_bss(&rdev->wiphy, params->channel,
 					   params->bssid,
-- 
2.34.1

