Return-Path: <linux-wireless+bounces-25511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3FB06D3D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D047A0622
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 05:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F02E6D2E;
	Wed, 16 Jul 2025 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ZKsYHhC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D02E6D2D
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644024; cv=none; b=AjDGSutRiDYm8xEEJxxRdwRdS/C8Ah1tg8+mU22gQAQiFvQ71AOy0xiSoT4SdqO448Xo6a6Kecp+VwFQ1UCbB63U2NYydhBrjdNOXX90ZCJurMc8mrx/gwwH8II/Qo2vsqzSCuA+jrYMdn7TYuqZlVoWnM/Png7693dF0T5/1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644024; c=relaxed/simple;
	bh=g+KgWyhZNg+s+0geMQi/eS9vdZGc+UgyLemdgB5kMBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZVY/Jd3ar4RjRxpexMLBAb5JT50PlFffADHoXCqUc/C6cBE244mKMTqqiX/+1BREm4akdjRDO3/XzFG/NpmyJg9wT0RZy0TtL0MFZNaQHxqGNkjbAy35Z/54k7NJHQ3uLfDcsIzMYPAKtq12sFhK8TDj/uiVjBE3xpYViyvNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ZKsYHhC2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso456373a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752644021; x=1753248821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjBA7khbBr3sBb7oY7+PyNZs+kpwDQvuXQ95+uoive8=;
        b=ZKsYHhC2ja/v73YMb34myeXATdUTLsLAyoj1kD1QwErBNkbxuREJMuE1qRBzp9Fmcz
         6la007xf2R7KZ4vZWKEs1TA8JrYHfJLnOBZ4QCUPnLYezX/W568CzqBtEIwWwLt+DXIG
         fjHu79Js8Equ7tvkFCV2K9pUop3fPpBLc/fE+bQRSC1CWQBBYGF2/Mct6rNUlaWwQzMW
         cmaLURVzXiKiuOMtDAYMdL+xPfDBcQvJmtfsbUocOgcAQVZy2+cX91Dnp9a+kuy8zrEy
         q5FwiG7yj3O9Bb2beYCgZgZuGPaCrmdTbz2bXjdTaz3m9uSFJEU+iUe2mCucrlK9ePnb
         LdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752644021; x=1753248821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjBA7khbBr3sBb7oY7+PyNZs+kpwDQvuXQ95+uoive8=;
        b=CTSFg0M+7/rFPiQjegicb21ZEdfa2D7frQUx0bYR6uaqNNVr33Io+e2JFSJ3aQQFNR
         MO7i942zwyD7Ipd3r11lSIOFG50hDBThyaWeAsT4Jxt7HOHFn3iMTxaXQ/HZuB8oq8BR
         /k77JNNEZC0UlDUJhxiFc95wU8IaLiFyFdQfXaHQp9rlV0Ryg2Y+7IHSD1Td2o7BCKvQ
         6atj6lZ671UCCXg9ULKecMAEGO5wVtSs5vZKr1bV8u430L3NsX73ymX5hzABITnnBtTR
         JyuRdmF21V0VWuGMC+Dys/dGhWzP6PtJRHo8N7HNE3mm3mkJiofWXZ1faozwyMv1tzc2
         n8CQ==
X-Gm-Message-State: AOJu0Yys1SRgL7WO0Ax7LhokyyXYLkySU56wymCca0iaOS6MXewfgFfB
	rAYG4BK7j0w7EYm8zuxdQoVxW6f9mDaQKS8sdfr20C979gnL+AOJZFrQkCyZrWS2FVU=
X-Gm-Gg: ASbGncs+EFoXXM/xn2n+Wskte/THDhhltokVHUjc6WlHS/rfvW53tZ4iQibip0SobFG
	crwM2X9U5bfTIrubYKjbghl5aiSlJOlEfPpG0gxy31914IXbVLs/rjP9M2voBUQTMrvZC7XVBhO
	9UZgUN64O8YmlibBv+snY8mITv/IhJRqyKiP85Sgi4NmVru3DyRtAtmPbPoY6ceE5Mg6yxvBhsw
	eeTL4xeCGGyw+CzCv8+qWHyUR9akoiinOkEWSUR6LsmbHgimqoysOkWJHs9PFiT8vYX1jLzAlSB
	B4qoN/KRV69bOnxz/1Fxe+YTvr0VP8xUvxniy4K4FYsVA0IoMFtQ4v7m5ou1Kqihv+RsmN5xgDX
	G9bvy0+1A1Qp0xOcbCJS92L549HvKPoqOIeJH3oo=
X-Google-Smtp-Source: AGHT+IGiGjAbCj579HI2St5lGhal9cYG+MNTv6FUxBzr+3i1dGuay/cfdhIA1inN9wZ9cHepejrAEg==
X-Received: by 2002:a17:90a:d44c:b0:30e:6a9d:d78b with SMTP id 98e67ed59e1d1-31c9e740c74mr2684745a91.12.1752644020648;
        Tue, 15 Jul 2025 22:33:40 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba792sm580382a91.5.2025.07.15.22.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 22:33:40 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 2/4] wifi: mac80211: support initialising an S1G short beaconing BSS
Date: Wed, 16 Jul 2025 15:32:52 +1000
Message-ID: <20250716053254.439698-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
References: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the ability to parse the short beacon data and long
beacon period. Ensure during the initialisation path we set the
long beacon period and set the s1g_short_beaconing boolean to true,
which determines if the S1G BSS is short beaconing. Additionally,
the update path only updates the beacon templates if there is
an update present, as the long beacon period cannot be
dynamically updated without tearing down the interface.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v1 -> v2:

- Remove validation not needed within mac80211 (its performed in
  cfg80211)
- remove short beacon DTIM and short beacon interval fields as we
  are using the existing beacon int and dtim period variables

---
 include/net/mac80211.h     |  9 ++++
 net/mac80211/cfg.c         | 85 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  9 ++++
 3 files changed, 103 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 577fd6a8c372..119466e64c42 100644
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
@@ -758,6 +760,10 @@ struct ieee80211_parsed_tpe {
  *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
  *	the link to know that it heard the latest value from its own beacon
  *	(as opposed to hearing its value from another link's beacon).
+ * @s1g_short_beaconing: determines if short beaconing is enabled for an S1G
+ *	BSS.
+ * @s1g_long_beacon_period: number of beacon intervals between each long
+ *	beacon transmission.
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -857,6 +863,9 @@ struct ieee80211_bss_conf {
 
 	u8 bss_param_ch_cnt;
 	u8 bss_param_ch_cnt_link_id;
+
+	bool s1g_short_beaconing;
+	u8 s1g_long_beacon_period;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d76643d46150..aeceac5747b6 100644
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
+	if (!params->update)
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
@@ -1493,9 +1547,16 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->twt_responder = params->twt_responder;
 	link_conf->he_obss_pd = params->he_obss_pd;
 	link_conf->he_bss_color = params->beacon.he_bss_color;
+	link_conf->s1g_short_beaconing = false;
 	sdata->vif.cfg.s1g = params->chandef.chan->band ==
 				  NL80211_BAND_S1GHZ;
 
+	if (sdata->vif.cfg.s1g && params->s1g_long_beacon_period) {
+		link_conf->s1g_short_beaconing = true;
+		link_conf->s1g_long_beacon_period =
+			params->s1g_long_beacon_period;
+	}
+
 	sdata->vif.cfg.ssid_len = params->ssid_len;
 	if (params->ssid_len)
 		memcpy(sdata->vif.cfg.ssid, params->ssid,
@@ -1541,6 +1602,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		goto error;
 
+	if (sdata->vif.cfg.s1g) {
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
@@ -1619,6 +1688,14 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		return err;
 
+	if (link_conf->s1g_short_beaconing) {
+		err = ieee80211_set_s1g_short_beacon(sdata,
+						     &params->s1g_short_beacon,
+						     link, link_conf, &changed);
+		if (err < 0)
+			return err;
+	}
+
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
 		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
@@ -1650,6 +1727,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct probe_resp *old_probe_resp;
 	struct fils_discovery_data *old_fils_discovery;
 	struct unsol_bcast_probe_resp_data *old_unsol_bcast_probe_resp;
+	struct s1g_short_beacon_data *old_s1g_short_beacon;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_link_data *link =
 		sdata_dereference(sdata->link[link_id], sdata);
@@ -1668,6 +1746,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	old_unsol_bcast_probe_resp =
 		sdata_dereference(link->u.ap.unsol_bcast_probe_resp,
 				  sdata);
+	old_s1g_short_beacon =
+		sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
 
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
@@ -1690,6 +1770,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	RCU_INIT_POINTER(link->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
 	RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
+	RCU_INIT_POINTER(link->u.ap.s1g_short_beacon, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -1697,6 +1778,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		kfree_rcu(old_fils_discovery, rcu_head);
 	if (old_unsol_bcast_probe_resp)
 		kfree_rcu(old_unsol_bcast_probe_resp, rcu_head);
+	if (old_s1g_short_beacon)
+		kfree_rcu(old_s1g_short_beacon, rcu_head);
 
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
@@ -1718,8 +1801,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
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


