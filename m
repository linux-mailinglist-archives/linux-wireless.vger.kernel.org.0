Return-Path: <linux-wireless+bounces-25586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CBB0872F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759623BF7E5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368A25393E;
	Thu, 17 Jul 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="NXJAqsiK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5B259CA4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738151; cv=none; b=itVqH2Tku73y2Kub04ZO2SPpZEVyPqOEwidIDCUnsnd7A9m/gG7/VvAKIMhoi91exvVgw6/gNuPBoi+tQeixabNPlz1T4UON+XufcITxd6LhABr82TX6tKYLOBgrsoZdmAJi4gN4F5sgJqQ9aTb8wrI5TP+ljATYl6r0VQ4owek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738151; c=relaxed/simple;
	bh=lqDYjDxtYzrrUP/ImI6+LFWM55mRvfFxvvcK+Vkr8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjv2h3IzR0Ad5/qH9yNnwn08zwv3cxczOorj2sSApXuqy+mnR1PeN340AlteKLH8SPgAjv22eQMcZ9R6MAMygiDbkBpy5SQ4QHkowggNjp4HQDqNtZ7SBdwuhUUNEi5UWE4SwtedcEHvUBhbAGdlxH0YqaSd7uXcqzjebwMKjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=NXJAqsiK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e81d37a7so456764b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752738149; x=1753342949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqKf4LxyYDId9RkaPBEmNEPUjhoFeJ1M9Uzb3dg6fUI=;
        b=NXJAqsiKkB5bcdnF8jj2msboBGn6Xvfc7e+VNEoSvS+qMOjCWfxZmfgC5DqJBIMH4T
         R7OvwNiM3KjfABDLVVsK+Wzxu/ZOkdZPvPm6Ar+dOl6b0rBZAz3Rj4OldIYocLID7G0J
         NY3F5fHmfcw0OKK/SsuzzSqOZUz+BtYv593FcsjEjdo7TCYvv0evIhu+RsAqAEOt3LSx
         jY3MZn1iyfUS/OKUdkbpy8w+xfH7IH4MVpMaXvYcaxo39IK0o9HlevW5Sh8ymeGAvYYz
         uISS252mYkNmnmPaJwttj19LnEteVWw2Q4fMgTYYz2pO4TGb/7Ajy8p772AtEHQgSXn7
         905g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738149; x=1753342949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqKf4LxyYDId9RkaPBEmNEPUjhoFeJ1M9Uzb3dg6fUI=;
        b=NMC/Qm+jvR13yUZhYSs0h+GW9V+IYJGa+UXuPJhuY0JDNWiGaB3yNERDz0Ywg3/+3H
         +i6hsOXh7wbgivHCM7K/HX14a1P0KvZgA/JrsX5dGnezhpkJcKyNSifm0si0SaZJCFrT
         TCsV5ovtBESnXjimNlRVesUc33e1H0YGUqsidZq/th4ZUZArPWFexsICOcZyKGaVcT5j
         BcR6ALwKcZMrPMZP2fXj+FiHBHMHKG9uuXAFwBRwAJyNxBSyC2R1JZLde6ywQZqczzT5
         A81BIhs9kQlfbuNWslsyy2uYJqf5cvKt9P17J+qLkLzH0rXExVkKdiA5UhHQfyxPuUqw
         vRjA==
X-Gm-Message-State: AOJu0YwXhdFpItwMGFb5xk2LoYYaOTIojLsU26j+JENThu3O6QhFcVO5
	y3SBiMp6BqzOHZADdTEsKlUMuc3KQv10mu0R4y/oeraeqwiIr9/KSktOzMhduhE7a1g=
X-Gm-Gg: ASbGncuyy5MQ1L43dLCshcv60F+wiPzFIe+HJz4gDDTjWbFKyca6DG07SuQGaBnOGQi
	fiteKLQGN/MYgU0cwe0DWWVqu+CRFEWCKa0CFwHe1qO0j5cxnkD9PUn2JhQ5i2Tj5Kd0mBg0NvG
	qMq0Ed30DpjgOXhCKhEXeM40hVYCDS3wsyph+V/M5yK1yNKjzoGLDyIxrDUKC68Mmqbatt0SiG4
	FD32aFxQzfcmTc+xDEJpmc33kVKBx9RvjDkr5fbzD6OUu4BObKKpzyyb/mGZJD8Keb0Z+TlM2bx
	hXxMyL7riyN+snN7+g9w6DfoRO/ERktJoDQ1mklaWni1dGOzWM97Sql4b3yLjpapx/zfSRbFq1O
	3iAgfFxmIllafXB8IbTJpp0+R8dLwXzP2onaAy+iHsX7rlAJSws7e+PDe/Vt3YTY+zLzivZE=
X-Google-Smtp-Source: AGHT+IHMgc7+FpaWMXFnkNekWSm1Y/XstX+Uqw9zbT9oS7p3QQz/X/STdWbiecQTOj7JzW6hoY1O4g==
X-Received: by 2002:a05:6a20:244d:b0:234:10b7:f0ae with SMTP id adf61e73a8af0-237d76447e1mr10704367637.35.1752738149101;
        Thu, 17 Jul 2025 00:42:29 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e063b3sm16072550b3a.54.2025.07.17.00.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:42:28 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v3 2/4] wifi: mac80211: support initialising an S1G short beaconing BSS
Date: Thu, 17 Jul 2025 17:42:03 +1000
Message-ID: <20250717074205.312577-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
References: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the ability to parse the short beacon data and long
beacon period. The long beacon period represents the number of beacon
intervals between each long beacon transmission. Additionally,
as a BSS cannot change its configuration such that short beaconing
is dynamically disabled/enabled without tearing down the interface
- we ensure we have an existing short beacon before performing
the update.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v2 -> v3:

- Removed s1g_short_beaconing boolean from the BSS conf
- Refactored ieee80211_set_s1g_short_beacon to not rely on the old
  short beacon, we simply update the beacon if we receive an update,
  else do nothing. Also some code cleanup.
- Removed the BSS change flag, since mac80211 handles that internally.
- Unconditionally set the long beacon period, will be 0 for non S1G
  interfaces and eiher 0 or > 1 for an S1G interface to be more inline
  with other BSS parameters.
- Minor style fix for assigning sdata.vif.cfg.s1g (it can fit on a
  single line)
- Since the s1g_short_beaconing boolean has been removed, rely on
  link->u.ap.s1g_short_beacon for validation.

---
 include/net/mac80211.h     |  4 +++
 net/mac80211/cfg.c         | 66 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  9 ++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 577fd6a8c372..a2dbaad2f6d3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -758,6 +758,8 @@ struct ieee80211_parsed_tpe {
  *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
  *	the link to know that it heard the latest value from its own beacon
  *	(as opposed to hearing its value from another link's beacon).
+ * @s1g_long_beacon_period: number of beacon intervals between each long
+ *	beacon transmission.
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -857,6 +859,8 @@ struct ieee80211_bss_conf {
 
 	u8 bss_param_ch_cnt;
 	u8 bss_param_ch_cnt_link_id;
+
+	u8 s1g_long_beacon_period;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d76643d46150..2b5c6318697f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1071,6 +1071,47 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int
+ieee80211_set_s1g_short_beacon(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_link_data *link,
+			       struct cfg80211_s1g_short_beacon *params)
+{
+	struct s1g_short_beacon_data *new;
+	struct s1g_short_beacon_data *old =
+		sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
+	size_t new_len =
+		sizeof(*new) + params->short_head_len + params->short_tail_len;
+
+	if (!params->update)
+		return 0;
+
+	if (!params->short_head)
+		return -EINVAL;
+
+	new = kzalloc(new_len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	/* Memory layout: | struct | head | tail | */
+	new->short_head = (u8 *)new + sizeof(*new);
+	new->short_head_len = params->short_head_len;
+	memcpy(new->short_head, params->short_head, params->short_head_len);
+
+	if (params->short_tail) {
+		new->short_tail = new->short_head + params->short_head_len;
+		new->short_tail_len = params->short_tail_len;
+		memcpy(new->short_tail, params->short_tail,
+		       params->short_tail_len);
+	}
+
+	rcu_assign_pointer(link->u.ap.s1g_short_beacon, new);
+
+	if (old)
+		kfree_rcu(old, rcu_head);
+
+	return 0;
+}
+
 static int ieee80211_set_ftm_responder_params(
 				struct ieee80211_sub_if_data *sdata,
 				const u8 *lci, size_t lci_len,
@@ -1493,8 +1534,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->twt_responder = params->twt_responder;
 	link_conf->he_obss_pd = params->he_obss_pd;
 	link_conf->he_bss_color = params->beacon.he_bss_color;
-	sdata->vif.cfg.s1g = params->chandef.chan->band ==
-				  NL80211_BAND_S1GHZ;
+	link_conf->s1g_long_beacon_period = params->s1g_long_beacon_period;
+	sdata->vif.cfg.s1g = params->chandef.chan->band == NL80211_BAND_S1GHZ;
 
 	sdata->vif.cfg.ssid_len = params->ssid_len;
 	if (params->ssid_len)
@@ -1541,6 +1582,13 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		goto error;
 
+	if (sdata->vif.cfg.s1g) {
+		err = ieee80211_set_s1g_short_beacon(sdata, link,
+						     &params->s1g_short_beacon);
+		if (err < 0)
+			goto error;
+	}
+
 	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
 		old = sdata_dereference(link->u.ap.beacon, sdata);
@@ -1619,6 +1667,13 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		return err;
 
+	if (link->u.ap.s1g_short_beacon) {
+		err = ieee80211_set_s1g_short_beacon(sdata, link,
+						     &params->s1g_short_beacon);
+		if (err < 0)
+			return err;
+	}
+
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
 		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
@@ -1650,6 +1705,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct probe_resp *old_probe_resp;
 	struct fils_discovery_data *old_fils_discovery;
 	struct unsol_bcast_probe_resp_data *old_unsol_bcast_probe_resp;
+	struct s1g_short_beacon_data *old_s1g_short_beacon;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_link_data *link =
 		sdata_dereference(sdata->link[link_id], sdata);
@@ -1668,6 +1724,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	old_unsol_bcast_probe_resp =
 		sdata_dereference(link->u.ap.unsol_bcast_probe_resp,
 				  sdata);
+	old_s1g_short_beacon =
+		sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
 
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
@@ -1690,6 +1748,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	RCU_INIT_POINTER(link->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
 	RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
+	RCU_INIT_POINTER(link->u.ap.s1g_short_beacon, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -1697,6 +1756,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		kfree_rcu(old_fils_discovery, rcu_head);
 	if (old_unsol_bcast_probe_resp)
 		kfree_rcu(old_unsol_bcast_probe_resp, rcu_head);
+	if (old_s1g_short_beacon)
+		kfree_rcu(old_s1g_short_beacon, rcu_head);
 
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
@@ -1720,6 +1781,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->enable_beacon = false;
 	sdata->beacon_rate_set = false;
 	sdata->vif.cfg.ssid_len = 0;
+	sdata->vif.cfg.s1g = false;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
 	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_BEACON_ENABLED);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec68204fddc9..47b51c7eb09c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -296,6 +296,14 @@ struct unsol_bcast_probe_resp_data {
 	u8 data[];
 };
 
+struct s1g_short_beacon_data {
+	struct rcu_head rcu_head;
+	u8 *short_head;
+	u8 *short_tail;
+	int short_head_len;
+	int short_tail_len;
+};
+
 struct ps_data {
 	/* yes, this looks ugly, but guarantees that we can later use
 	 * bitmap_empty :)
@@ -1042,6 +1050,7 @@ struct ieee80211_link_data_ap {
 	struct probe_resp __rcu *probe_resp;
 	struct fils_discovery_data __rcu *fils_discovery;
 	struct unsol_bcast_probe_resp_data __rcu *unsol_bcast_probe_resp;
+	struct s1g_short_beacon_data __rcu *s1g_short_beacon;
 
 	/* to be used after channel switch. */
 	struct cfg80211_beacon_data *next_beacon;
-- 
2.43.0


