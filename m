Return-Path: <linux-wireless+bounces-24178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D78ADC42D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68301897AE5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A028FA89;
	Tue, 17 Jun 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="h8+ZZqlg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14957293B55
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147631; cv=none; b=lxlAZMb6Kg6uWHlau4YwBmzj/L4CNaAEevSPekVpe2tX9aHw2O0I3ApAPmR5Qk+xvpEgBUA79b8xesEcFAoaK+4f/VKzcuQ5iN0qUEJDg9X1wX/fSxYC2TT7r9JfGhIyeN2p1vRqDv4eCqVgrOL6Qq7uOAPPugQQ0einrYKFOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147631; c=relaxed/simple;
	bh=P/EbJlqv2XUN9Ebq5NtsPlFHuL9Ro0JB9Gb1lH176fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPCUuqrhq4jY/rklRa2QZLVJh+/Zo/JTD5yK6sozLO9lvKKsLiPE3Bi7jaBZsG8ApKiKP5D8RKKiJ7/x9prThqcCkucBgKVtHaNv4XfahUy5hwKds3dzZlz22UMPLsdfs2kjiRFC48Liz3VC2W0ApvQyL5hSobYuDzn5yJWZ94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=h8+ZZqlg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso4449860a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750147629; x=1750752429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu1nvUxweSKjVbF2MtXKMBXFLPQYrBXqXqdw3tZCfx8=;
        b=h8+ZZqlgpra22Ou373Syhzd2Jguf7nyeaL3l2hZXwbIkw9wWVzZ2XJiIp996vQ5637
         3LhplkkbQymbz6lT+mqn+WKqtn57zMQe1FNRD8vubvYzXtVptbkI5lsv/B7LmIi4y3gq
         djO+jvYvSKC9JLCy6q8h6JkSdx5LSD40Hytbf7nVvRECSHOwaEk9SanU0oTwcAEM5w0n
         MCbFOucz3G4G4lYBUHbY1aVBt0DjaY/BfVjwmgECUXE3GbK4l3ffP9A4lWubaoS7UVif
         gQOenaVRxLYlgijW8Ajc07/4AeN92xNAE1rW3rjcGK1P/r/uzXI75Qm0+85oLFGWpcwy
         kSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147629; x=1750752429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu1nvUxweSKjVbF2MtXKMBXFLPQYrBXqXqdw3tZCfx8=;
        b=pn3DAIeJ7saDuD+ZsxZcobtM6cwdqLKLGh7v98MpR6BkBPA6biVnu2yytHno3zxUSC
         zwZXSVhMw+WpCw/5JtDK3XqUp1jzJgLd5BzFWP+jcS1sEdnumw38xkBIWPamZEbivD+D
         cJqK0NEGCVGGRbvegdifcF+G6deucJQTkku6i2CsVrQhGX1bnqxlAPZsJZhD8vmzSdKi
         XOYK72gO2sjSbE6lmLH4wOFCS8clzJt1G8KfQDmNa/kQp47vnCldDQxJHnfGmgOsX3BN
         AUEBFm/UkY3/OXHk9HjYbihJt5fbPXqDzDqwL2MLzsZTmt2DgeGYsUZtEc5kKsgszScO
         iNLQ==
X-Gm-Message-State: AOJu0YxIT1IUCGwq4DzHAAAhVkFYI/2Wm9WqVhksnCUOcNMwfdh9rECQ
	rtUJs1SJ6i1tRwkS08hF8oHndrX0tPoFxv7jw/Tc5vRuHYuPuDNxQ9rPZLZxGv+3gvNZMOXZ7c4
	3JRw3AX4=
X-Gm-Gg: ASbGncsvj2ykOGJbF/2s1EWRlIOFh6glvkkxo+o5mt9XjwKSQwjB+5+FsI83rRmO4ZR
	cCOt+6adpJuq52+sUjQEvnKIJyheZxAZYeAq+w/h7Mc2kF51HZl3kXna/d+4ZODXAzNvuLgQLQA
	wteBV2vEVmNjIOEAGvF6z17CDuNRH8ur7eXRY7OCRWf+pa71qdic/BC1R4OdfUjSWIzc6Tbaxgh
	SvI9+w4JvWEDn38CmaEFzlhJaNxk3ZK//CvAbd1TQmGZbEqnVu6/BrMUbs6eTBM48Ah9Mzz7hr5
	28ACJ77Web94LMWjMadLi4NJ18SYqxGo5bF03dF2sJ6gt7UOw8K/uA+zznqFfgiH7LzlSV0cJCb
	Sylat2FJbyeCE7b5Pi7zXZq3nWKNTuNVSDq0=
X-Google-Smtp-Source: AGHT+IHUe8Oqush8zSdzSUAlQkf3Lh3wQrq9M0A6DZAiaD2NENzpJQbomH4gsxI2xCtI2vEnKJS0bg==
X-Received: by 2002:a17:90b:4b90:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-313f6fa5d94mr13249651a91.22.1750147629178;
        Tue, 17 Jun 2025 01:07:09 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31413d2c8fbsm3579365a91.10.2025.06.17.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:07:08 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 1/4] wifi: cfg80211: support configuration of S1G station capabilities
Date: Tue, 17 Jun 2025 18:06:07 +1000
Message-ID: <20250617080610.756048-2-lachlan.hodges@morsemicro.com>
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

Currently there is no support for initialising a peers S1G capabilities,
this patch adds support for configuring an S1G station.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/cfg80211.h | 4 +++-
 net/wireless/nl80211.c | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..abbf409b936b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -560,7 +560,7 @@ struct ieee80211_sta_s1g_cap {
  * @vht_cap: VHT capabilities in this band
  * @s1g_cap: S1G capabilities in this band
  * @edmg_cap: EDMG capabilities in this band
- * @s1g_cap: S1G capabilities in this band (S1B band only, of course)
+ * @s1g_cap: S1G capabilities in this band (S1G band only, of course)
  * @n_iftype_data: number of iftype data entries
  * @iftype_data: interface type data entries.  Note that the bits in
  *	@types_mask inside this structure cannot overlap (i.e. only
@@ -1653,6 +1653,7 @@ struct sta_txpwr {
  * @he_6ghz_capa: HE 6 GHz Band capabilities of station
  * @eht_capa: EHT capabilities of station
  * @eht_capa_len: the length of the EHT capabilities
+ * @s1g_capa: S1G capabilities of station
  */
 struct link_station_parameters {
 	const u8 *mld_mac;
@@ -1671,6 +1672,7 @@ struct link_station_parameters {
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
 	const struct ieee80211_eht_cap_elem *eht_capa;
 	u8 eht_capa_len;
+	const struct ieee80211_s1g_cap *s1g_capa;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85f139016da2..8bf5e092fabe 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7349,6 +7349,10 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
+		params->link_sta_params.s1g_capa =
+			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
+
 	err = nl80211_parse_sta_channel_info(info, params);
 	if (err)
 		return err;
@@ -7675,6 +7679,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
+	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
+		params.link_sta_params.s1g_capa =
+			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
 		params.link_sta_params.opmode_notif_used = true;
 		params.link_sta_params.opmode_notif =
-- 
2.43.0


