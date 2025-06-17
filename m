Return-Path: <linux-wireless+bounces-24179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0368ADC432
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B21885354
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184422949E3;
	Tue, 17 Jun 2025 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="2oZHPNqA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54511293B5C
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147638; cv=none; b=AmzNzLNUGcx6+qiS0PfbKBZT+SfBBkwt9zQPH2LiJXUIJxhK9mf4KHn1BBDB6xoKfRwq5HxOHW/EB6McDCERRjbtxSakqN8iUMxAcVyPM8F87HprkHUSaHtH6z+s/SA6SLi1sm1wCknHsZ7oQkoeinSDazurNqE76JF9wo5deb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147638; c=relaxed/simple;
	bh=fwwMqhfVe+1mHmWz6yYhaQyrXgIQlUUr5o33QJ6Q54A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knbQeOQALNzXFBjtGQPwIpWQ16b5UkMBkKvPyDDqN/jBeysqAQo4+y80z0ouO+StceomBTTuwEsa8jomF7DSONjiA7duuRQuGBmT6L5tu/ndPzmDoN0x3q+Q2zb+8+G9gi3DcWxn5iTVuA1FWh0LRQu2Qj37mVLtrlFz+BOMHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=2oZHPNqA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso6307388a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750147636; x=1750752436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB0lQRt6Xpqqy3P5+XcfNIt4DXQKBIJJSeQkQiuboUU=;
        b=2oZHPNqASOY1Itu9cPPLxgQUc162OPsLsr9uE2QAhVwPDwX7smLDYUDQSoy/IZLTIT
         BmI5StRsaNdZ0BicG17JR8QLIM3vi7tQu6aUyL1m288k1y4ayencZScTqPkaeTxqs0De
         T5OxCNA4364mFjSF076S6crTNEyGhftwpO3sdnitLbsQhSj2IAib2LIEId20EsG9ZbQj
         O1doyy0gfn6NZ1EX1V+oyou8sAuX8ojRE+1UUkOYRAin5asictm4QalIrBzlI1nJ5AoU
         Hd21kbuHkGaXjhmRxDh5YUORxXt4P8uwmkHDHytYCmO+J0jWDMA4+2VIT4RnNRUWI4YD
         6fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147636; x=1750752436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB0lQRt6Xpqqy3P5+XcfNIt4DXQKBIJJSeQkQiuboUU=;
        b=Rd37E5NqNAKiT+aXdTk94PL1oyP/bSvBUTnjmYXYsbenhTP5rfIZK6tVoJYmc9BzWw
         NiV03qxHzqweKR9mHF0g1NpRXJQthr0kGx0DRGeE3Ij5ARGhKAkA16+ZNYBmCQ+CQLdd
         xvqcGkv+xuctzcQzeb5/jlSdO5JjV8wDt0929VPcQLuM7qx9Xh6K+HAd65eqUMakvuv0
         oG5srE6kFdbIbooFK09hWN/aIwdN/AQW6t/gbCwDPQzXTYHQ4ccS1Ej06L7wP3Yptn3Q
         s+0/siXQN2O2ar4GM3tT5UM3TzLZXS3Fpju0ftCJbu+7WufliYyUhdY561wT3S/KJlOr
         hK7w==
X-Gm-Message-State: AOJu0YwrZUdNj6LQlqZnnZeu21InxpHYpYJxBB/vol7YKQ9tj9GpIw91
	s0+91gyGcUUWVZe9hHCIWXUQMu7RtrtQNCZRUSwplalL7CtKSOwcPWuWpBP/Z86dheo=
X-Gm-Gg: ASbGnct8/ze7srgcGc/7KEQKWha01bmTSGOQfxyD5w1qXnaHyj31C28lOB9q4WbPV5Q
	OphAbtOAAAhwUvXHoSVeFDGvC/+ETH/SySKTGJSjfcIyQu4XZNOaWVNtZMl2A5HLZHACL3znJEI
	Ne4E32y+V1znEGJPlmsEDl7JuNXBjsasM5EdUWB3UM+Ciys3GuA0Dhz15QdupObJyLquFPlMgnk
	Chx+q7md2e9m+VToIRkbMv//0SO55CksLrgZqj8F8o0UvaAljOvEU9dkiovIxrPXkyuk3XGih0q
	5FnBVEfd32dUtuPZcipj445k+2HV/i108G27YE9herdT0SMQJgrn2icQHn4V8OpxMs/s/GPfBcx
	Amuy+cDOfAG4o9rTLl5hgz7VLAuAKFF6L9E0=
X-Google-Smtp-Source: AGHT+IEnruaqr2fda94ONXKl2O4h2/k0xv7Pod3BA2WNa84ZgSIjPsbWelMSzJ0TvDrkqsKO+bvSfA==
X-Received: by 2002:a17:90b:4c09:b0:313:17e3:7ae0 with SMTP id 98e67ed59e1d1-313f1d8346bmr14763592a91.34.1750147635614;
        Tue, 17 Jun 2025 01:07:15 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31413d2c8fbsm3579365a91.10.2025.06.17.01.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:07:15 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 2/4] wifi: mac80211: handle station association response with S1G
Date: Tue, 17 Jun 2025 18:06:08 +1000
Message-ID: <20250617080610.756048-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
References: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for updating the stations S1G capabilities when
an S1G association occurs.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/ieee80211.h  |  4 ++++
 include/net/mac80211.h     |  2 ++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        |  6 ++++++
 net/mac80211/s1g.c         | 26 ++++++++++++++++++++++++++
 5 files changed, 41 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ce377f7fb912..5425a5becd5c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3160,6 +3160,10 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
 #define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
 
+/* IEEE80211 2024 Table 9-351 */
+#define S1G_CAP3_MAX_MPDU_LEN_3895 0
+#define S1G_CAP3_MAX_MPDU_LEN_7991 1
+
 /* EHT MAC capabilities as defined in P802.11be_D2.0 section 9.4.2.313.2 */
 #define IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS			0x01
 #define IEEE80211_EHT_MAC_CAP0_OM_CONTROL			0x02
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 82617579d910..c022b7c1a52d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2428,6 +2428,7 @@ struct ieee80211_sta_aggregates {
  * @he_cap: HE capabilities of this STA
  * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
  * @eht_cap: EHT capabilities of this STA
+ * @s1g_cap: S1G capabilities of this STA
  * @agg: per-link data for multi-link aggregation
  * @bandwidth: current bandwidth the station can receive with
  * @rx_nss: in HT/VHT, the maximum number of spatial streams the
@@ -2450,6 +2451,7 @@ struct ieee80211_link_sta {
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 	struct ieee80211_sta_eht_cap eht_cap;
+	struct ieee80211_sta_s1g_cap s1g_cap;
 
 	struct ieee80211_sta_aggregates agg;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 30809f0b35f7..7e080f601ac9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2269,6 +2269,9 @@ void ieee80211_s1g_rx_twt_action(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb);
 void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 				     struct sk_buff *skb);
+void ieee80211_s1g_cap_to_sta_s1g_cap(struct ieee80211_sub_if_data *sdata,
+				      const struct ieee80211_s1g_cap *s1g_cap_ie,
+				      struct link_sta_info *link_sta);
 
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d46d4af60d7..8c98ee2b1d2b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5399,6 +5399,12 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		bss_conf->epcs_support = false;
 	}
 
+	if (elems->s1g_oper &&
+	    link->u.mgd.conn.mode == IEEE80211_CONN_MODE_S1G &&
+	    elems->s1g_capab)
+		ieee80211_s1g_cap_to_sta_s1g_cap(sdata, elems->s1g_capab,
+						 link_sta);
+
 	bss_conf->twt_broadcast =
 		ieee80211_twt_bcast_support(sdata, bss_conf, sband, link_sta);
 
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index d4ed0c0a335c..1f68df6e8067 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -194,3 +194,29 @@ void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 }
+
+void ieee80211_s1g_cap_to_sta_s1g_cap(struct ieee80211_sub_if_data *sdata,
+				      const struct ieee80211_s1g_cap *s1g_cap_ie,
+				      struct link_sta_info *link_sta)
+{
+	struct ieee80211_sta_s1g_cap *s1g_cap = &link_sta->pub->s1g_cap;
+
+	memset(s1g_cap, 0, sizeof(*s1g_cap));
+
+	memcpy(s1g_cap->cap, s1g_cap_ie->capab_info, sizeof(s1g_cap->cap));
+	memcpy(s1g_cap->nss_mcs, s1g_cap_ie->supp_mcs_nss,
+	       sizeof(s1g_cap->nss_mcs));
+
+	s1g_cap->s1g = true;
+
+	/* Maximum MPDU length is 1 bit for S1G */
+	if (s1g_cap->cap[3] & S1G_CAP3_MAX_MPDU_LEN) {
+		link_sta->pub->agg.max_amsdu_len =
+			IEEE80211_MAX_MPDU_LEN_VHT_7991;
+	} else {
+		link_sta->pub->agg.max_amsdu_len =
+			IEEE80211_MAX_MPDU_LEN_VHT_3895;
+	}
+
+	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
+}
-- 
2.43.0


