Return-Path: <linux-wireless+bounces-25350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DCB0357E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741307A76DD
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 05:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540118D;
	Mon, 14 Jul 2025 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="2NTl2CrG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AD1F19A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470075; cv=none; b=DbFRuXu1hG48Mf6mDQEBylTFbSl9V8MHowkq7qbk/19cz+DsvKYMQbpujY+6rgyz/vVLvMUcnA5BjJIvPJ04fpaG+1VsC4CZk/8mOHLsqK5w+QYxCd2lRAIo/bUTXQ49y2T488cPCK+qTIUb9h5gRlxVFiKrH2Oz2ZwcMvigUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470075; c=relaxed/simple;
	bh=fZkIfGXSmsHuhmkw9OKVafAXEmSIddXqRExGAuflOh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbAA11071wcJFwzm4zyVvKpistRVkq/9cr9cIB3FhXw4ixLnW8hfwDcgZXpiHhf1jkRCqludoGzIuxqxtgH82QVAg4vWdo6OhEjDI4q6Plv4RqhdiMVgxrsV/8tvJS9aIPXw7O53OdsTkOlPbIbgCj3dOKSHZIjh5P1oDHHgiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=2NTl2CrG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b391ca6146eso3524009a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752470072; x=1753074872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+bO90wzmB3PBNLJuhFc48xRt9iunV2JpdP8Mjptp/g=;
        b=2NTl2CrGIspsO/MIC/toII2juj2vP5llC/oIs1ORzQ9W6YrTlg6S/o96a85x2CHy/I
         JDUAEPRd8XCr23Yk919QDw3RY6jhIPnS7Osx5jd0b28AFSHUGX++qHFd+Mk+oF+GNkBW
         ZWz7mNiDiYlL558AzKJx+xS13si3PH3fQPRm+Jw+JJ0CuJXSvl56uZjIbOJpwoGmhdoG
         hKqn/rxK836Xu1Kps1ZZXUzHawXDmvB0sAm91YmyH6zfHv5OPka8EI1vtQMfS2qmdDl2
         NiJrvQF5llIh0Pb4azkVij75htp/wrrsBf1MB/mSpjaYdncTu2PsPpv4DSSpjQabcheu
         +Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752470072; x=1753074872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+bO90wzmB3PBNLJuhFc48xRt9iunV2JpdP8Mjptp/g=;
        b=wPBV/V0kmgjsFvHpNnHnM6WVPCgifpYySA0r6V9BFzrKtVarXIHb7ZChtV2lfemEHo
         AJlGFM8BCWOTcdwIGRBZMpJrdeyf21LYLTQBhdKp2zSCuGANsG9101MejpW/IMHtHx45
         Tf6JW/FXR7w8v4fla7TSTKzENzun1OFij1rJ83V648msKEI7ioYPoaljee0/JEUcSndJ
         ot3huTIWju8nMPd7eBqBJ7vezCO4PlXDJYBzar/1oQAltFtCYjogZpdItENZcRNfDYTi
         a9PdsiJgcZyKQCre14gI4w+eSPmVo0RBfj6anw5okzGO5cQ9cbLnwdudl3zNJUg8pwiW
         fXPw==
X-Gm-Message-State: AOJu0YzijMwV25HMHkkEbWq3We2LDhU7hjqFQLOAjwyBsJcBUdxyhqUT
	Xn+wadUhDqvGr8V59BsdtkEqdLawuBAhdEZgJBByXrZqjLEPuwa5ztDz4Yle9eN+aWw=
X-Gm-Gg: ASbGncuHr2Hp7AV9anDlJK9f9NIEZal4lA3rkNr5pnSosnclwRnhglg2CDJeHebNj6T
	uxoHcPGvUcja8Kk+dG80MsYZuDkhgj/nApNwy/wkOlu1EusOiUB5fVTDnN8TmfVdHESa7IshcLa
	Df96wR2R4NK6eua43MQJb86JJiHS31q71UTlu3juUtwDiGSpp1bsosLHCIn/QXshnXtQRtom0v+
	JWzIVQVxDB0UaGgbBgpY9WDrD/HNHbkHXusp2ztOt7Fv0IbCoxjjjqZcIeYYoA8VcHAWUE2UjFi
	CAwgV7ivtZGPcLS1+z7q1qCPTp8wzfAGOgLTTFdfR5NzgzFohGa0d5IRiTqU6TgbtrRruuo0iLM
	nEEwBlcRgrdqTtyegmo1YfGVrw66GmHVUZzkkQ869s8lSyo8JmIS5KXeaGPjqg63YcRXyUz4=
X-Google-Smtp-Source: AGHT+IHjj6ucgiFW4MgYoewlrUR63MsMMLfXtvMvBPt+vglgghC3/QteTnyCM4BcpLU6hAE7N1GWKw==
X-Received: by 2002:a17:90b:5445:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31c4cd542d1mr17019882a91.30.1752470072438;
        Sun, 13 Jul 2025 22:14:32 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb61291sm9881930a91.34.2025.07.13.22.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:14:32 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC 2/5] wifi: mac80211: support initialising an S1G short beaconing BSS
Date: Mon, 14 Jul 2025 15:14:00 +1000
Message-ID: <20250714051403.597090-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an S1G BSS has been configured with short beaconing enabled,
utilise the short beacon DTIM period and short beacon interval as
opposed to the regular DTIM period and beacon interval as per
IEEE80211-2024 9.4.2.5.1 and 11.1.2.1 respectively. These values use
the base unit of TSBTT's (Target Short Beacon Transmission Time)
rather then TBTT. Additionally, introduce a new BSS parameter
s1g_short_beacon_period which represents the number of short beacons
sent per long beacon. This value is calcuated based on the ratio of
TSBTT's per TBTT such that:

short_beacon_period = beacon_int / short_beacon_int

as per IEEE80211-2024 11.1.3.10.2. This value will be used to
initialise the short beacon count every TBTT.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/mac80211.h     |  17 +++++
 net/mac80211/cfg.c         | 124 +++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |   9 +++
 3 files changed, 150 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 577fd6a8c372..3782a3d12dff 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -365,6 +365,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
  * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
  * @BSS_CHANGED_TPE: transmit power envelope changed
+ * @BSS_CHANGED_S1G_SHORT_BEACON: S1G short beacon changed
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -402,6 +403,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 	BSS_CHANGED_TPE			= BIT_ULL(35),
+	BSS_CHANGED_S1G_SHORT_BEACON	= BIT_ULL(36),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -758,6 +760,16 @@ struct ieee80211_parsed_tpe {
  *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
  *	the link to know that it heard the latest value from its own beacon
  *	(as opposed to hearing its value from another link's beacon).
+ * @s1g_short_beaconing: determines if short beaconing is enabled for an S1G
+ *	BSS.
+ * @s1g_short_beacon_int: short beacon interval in TUs. When short beaconing is
+ *	enabled beacon transmission times are computed using this value as
+ *	opposed to beacon_int as per IEEE80211-2024 11.1.2.1.
+ * @s1g_short_beacon_dtim_period: number of short beacon intervals that elapse
+ *	between each beacon with a TIM element whose DTIM count is 0. When
+ *	short beaconing is enabled, this value is used as opposed to
+ *	dtim_period as per IEEE80211-2024 9.4.2.5.1.
+ * @s1g_short_beacon_period: number of short beacons sent per long beacon.
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -857,6 +869,11 @@ struct ieee80211_bss_conf {
 
 	u8 bss_param_ch_cnt;
 	u8 bss_param_ch_cnt_link_id;
+
+	bool s1g_short_beaconing;
+	u16 s1g_short_beacon_int;
+	u8 s1g_short_beacon_dtim_period;
+	u16 s1g_short_beacon_period;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d76643d46150..d955bf8a6654 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1071,6 +1071,60 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int
+ieee80211_set_s1g_short_beacon(struct ieee80211_sub_if_data *sdata,
+			       struct cfg80211_s1g_short_beacon *params,
+			       struct ieee80211_link_data *link,
+			       struct ieee80211_bss_conf *link_conf,
+			       u64 *changed)
+{
+	struct s1g_short_beacon_data *new, *old;
+	int new_head_len, new_tail_len, size;
+
+	if (!sdata->vif.bss_conf.s1g_short_beaconing)
+		return 0;
+
+	old = sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
+	if (!params->short_head && !old)
+		return -EINVAL;
+
+	new_head_len = params->short_head ? params->short_head_len :
+					    old->short_head_len;
+	new_tail_len = (params->short_tail || !old) ? params->short_tail_len :
+						      old->short_tail_len;
+
+	size = sizeof(*new) + new_head_len + new_tail_len;
+
+	new = kzalloc(size, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	/* Memory layout: |struct|head|tail| */
+	new->short_head = ((u8 *)new) + sizeof(*new);
+	new->short_tail = new->short_head + new_head_len;
+
+	new->short_head_len = new_head_len;
+	new->short_tail_len = new_tail_len;
+
+	if (params->short_head)
+		memcpy(new->short_head, params->short_head, new_head_len);
+	else
+		memcpy(new->short_head, old->short_head, new_head_len);
+
+	if (params->short_tail)
+		memcpy(new->short_tail, params->short_tail, new_tail_len);
+	else if (old && old->short_tail)
+		memcpy(new->short_tail, old->short_tail, new_tail_len);
+
+	rcu_assign_pointer(link->u.ap.s1g_short_beacon, new);
+
+	if (old)
+		kfree_rcu(old, rcu_head);
+
+	*changed |= BSS_CHANGED_S1G_SHORT_BEACON;
+	return 0;
+}
+
 static int ieee80211_set_ftm_responder_params(
 				struct ieee80211_sub_if_data *sdata,
 				const u8 *lci, size_t lci_len,
@@ -1489,6 +1543,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	link_conf->dtim_period = params->dtim_period;
 	link_conf->enable_beacon = true;
+	link_conf->s1g_short_beaconing = false;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
 	link_conf->he_obss_pd = params->he_obss_pd;
@@ -1496,6 +1551,41 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.cfg.s1g = params->chandef.chan->band ==
 				  NL80211_BAND_S1GHZ;
 
+	if (sdata->vif.cfg.s1g) {
+		u64 beacon_interval = link_conf->beacon_int;
+
+		/*
+		 * If we have only passed in the short beacon head/tail when
+		 * the BSS has not been configured, error out.
+		 */
+		if (params->s1g_short_beacon.update) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		if (params->s1g_short_beacon.short_interval) {
+			/*
+			 * IEEE80211-2024 11.1.3.10.2:
+			 * beacon_int = n * short_beacon_int where n is a
+			 * positive integer and represents the short beacon
+			 * period which is the number of short beacons
+			 * transmitted per long beacon.
+			 */
+			if (do_div(beacon_interval,
+				   params->s1g_short_beacon.short_interval)) {
+				err = -EINVAL;
+				goto error;
+			}
+
+			link_conf->s1g_short_beaconing = true;
+			link_conf->s1g_short_beacon_int =
+				params->s1g_short_beacon.short_interval;
+			link_conf->s1g_short_beacon_dtim_period =
+				params->s1g_short_beacon.short_dtim_period;
+			link_conf->s1g_short_beacon_period = beacon_interval;
+		}
+	}
+
 	sdata->vif.cfg.ssid_len = params->ssid_len;
 	if (params->ssid_len)
 		memcpy(sdata->vif.cfg.ssid, params->ssid,
@@ -1541,6 +1631,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		goto error;
 
+	if (sdata->vif.cfg.s1g && link_conf->s1g_short_beaconing) {
+		err = ieee80211_set_s1g_short_beacon(sdata,
+						     &params->s1g_short_beacon,
+						     link, link_conf, &changed);
+		if (err < 0)
+			goto error;
+	}
+
 	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
 		old = sdata_dereference(link->u.ap.beacon, sdata);
@@ -1619,6 +1717,24 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		return err;
 
+	if (sdata->vif.cfg.s1g) {
+		/*
+		 * If we are updating the short beacon and the BSS has not
+		 * been configured for short beaconing, error out.
+		 */
+		if (!link_conf->s1g_short_beaconing &&
+		    params->s1g_short_beacon.update)
+			return -EINVAL;
+
+		if (link_conf->s1g_short_beaconing) {
+			err = ieee80211_set_s1g_short_beacon(
+				sdata, &params->s1g_short_beacon, link,
+				link_conf, &changed);
+			if (err < 0)
+				return err;
+		}
+	}
+
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
 		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
@@ -1650,6 +1766,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct probe_resp *old_probe_resp;
 	struct fils_discovery_data *old_fils_discovery;
 	struct unsol_bcast_probe_resp_data *old_unsol_bcast_probe_resp;
+	struct s1g_short_beacon_data *old_s1g_short_beacon;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_link_data *link =
 		sdata_dereference(sdata->link[link_id], sdata);
@@ -1668,6 +1785,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	old_unsol_bcast_probe_resp =
 		sdata_dereference(link->u.ap.unsol_bcast_probe_resp,
 				  sdata);
+	old_s1g_short_beacon =
+		sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
 
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
@@ -1690,6 +1809,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	RCU_INIT_POINTER(link->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
 	RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
+	RCU_INIT_POINTER(link->u.ap.s1g_short_beacon, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -1697,6 +1817,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		kfree_rcu(old_fils_discovery, rcu_head);
 	if (old_unsol_bcast_probe_resp)
 		kfree_rcu(old_unsol_bcast_probe_resp, rcu_head);
+	if (old_s1g_short_beacon)
+		kfree_rcu(old_s1g_short_beacon, rcu_head);
 
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
@@ -1718,8 +1840,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	RCU_INIT_POINTER(link_conf->tx_bss_conf, NULL);
 
 	link_conf->enable_beacon = false;
+	link_conf->s1g_short_beaconing = false;
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


