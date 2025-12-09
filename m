Return-Path: <linux-wireless+bounces-29618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C43E1CAF050
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 07:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7023045086
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889DE31ED97;
	Tue,  9 Dec 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="hpOg0uUR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB41A76BB
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261524; cv=none; b=S/qdfWcKFip+hpGff+TLKLUm67TKGkZU+MVI6HEqRm5LxhjDN7ZoLLHyZ+oNankOE4y+6vna+V1i9Bn5O+DhLlaMO8x2XYgyrQFBhggZBaoS3E2ma8+gYXgPxf7IgWB1v38ZH/WX/jqYaSxG3WHFpBSkM8SACv6BvFjSkjc9tk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261524; c=relaxed/simple;
	bh=yTBkwBDN10jY3CVtKTaoLQxsoS6teRSyvy1NCP+gON8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLJ9pa8BwzLp7xkD5KUGg6CaW+N/hDlbrS409aWN+MILG2mN3v6kCOXFEkOfOOPmTLjfE6cWNORsR/b6IK9TvJg0ahrXGnMuMyHLL1wM9Aab02IGmb1LRSEPBHNX4Roajmw2HirPDmurC1HM/YX7m6hM12D3/89YH+KZvSuki2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=hpOg0uUR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7f1243792f2so144678b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 22:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765261522; x=1765866322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sysro7UmnRbj0j1nH6keFc89rdnt9+CIHaON+wGUlkM=;
        b=hpOg0uURu+CwpAYV5Kt4aSX9Pt2M3r8YOtKfYkzwKAQCJNE/OoXGYQpVDmRx0GtsBH
         9S1P6yb9oPb5zXI6izBSSfj7c0EnPhhp9HdH1bylfxdQGnJa+u0+HGVDAeKv/xTjU2Xe
         ECP2omUVa6PG3LgYeb58BILoL/T7X68PsJxeOW30wEOh2jOICYopaUvc6e3XASqCBlSk
         JdBUR/GayNkMdSSfv4Mn894YIJsqY2xxZgPT34M7WMuQY09dUR9Ye3BvR6p06DBs1pfR
         Cx0w5qQOuiQL4s+oNM/HVB/ISgJpg/4ryhpyWBpYFuce5UnMWxRRLyWXl96dGmfIs542
         t4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261522; x=1765866322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sysro7UmnRbj0j1nH6keFc89rdnt9+CIHaON+wGUlkM=;
        b=SKfSBYYZJN00XR2zBWPKA5nmYmmJVp+Lm3k1ratbkppmRINplMO1KPiSe0DyDiZvM/
         83g02D0nwlgr4xL4btVWivRaQNklVX4/gie8v26IhrT81ZgKDyN935Wgo0ORvW5Dq6sW
         1rix9W5O61PPTuv5tXNUv1A3EX+YGVHm3gvHT6qdZTQGyOizffpie3KV4iUXP/kSSWZn
         J/l42VDF5B1kWyq6pCwap2i9BmWpZLc48z0XkajqaEEH8mQrpAlG2qvJHF1gAzFIKC1+
         GPx/9KLKUOtHXZwYwpiPh6mmrXtMO9zVNI6MqVL50EQlW3hum1KWIZPiu3XTKUJIs1Ve
         KuEg==
X-Gm-Message-State: AOJu0Yyo8dCimVYDqRdCj7IBU63YxjRaVAz1tkcsGPbciGhL79YkqI4M
	gXf9l0Q8Lr23FmKF36bldAgZFkompuCvBRp5uDVzieaC8TbijPeReXPnTPD7NhOcUQ==
X-Gm-Gg: ASbGnctBkG+Cl+TMotD3NDSwh4EXqTYnguxpmFxZt2+YEcrHaRrHFQgt4xbm41eCRI9
	ex9SylGBn8P6SyI2Pi97rveyGbXHCXrdHRsYb0hhq22vhzS/L9MO0D22IXOY2x8qzBxyWBuqHrr
	WO6pbe1bvYksXX01ScjNfsfbHF72iiHHWrhCcCmgDRsm2GB5P9WPK+2XalVTb1KR6148xuk6HDG
	OZR29xQCUSVOsuGe0uvlGlinoOYxNg2wYnuxQuAeXamSepfrP8wk03K84EY6cGsbVUKdpgle7jz
	JbkDakce5CZJ8JGcPeb1MjlwECUH1XozZsOohq2yVU2aZVSRKcVbvQrt6KvIsNyfAkqwf7zdIPv
	U6EkIH7PR5jX7LF80fcCeX9krHsjW3zt7DG1cynlii3XEyqk8dLZkytuRb4cHv8d5yVcwgrdibK
	917SOKeUy2nXVNteT2jFJLG64M
X-Google-Smtp-Source: AGHT+IFRm6uvZxNYSUE8IXtPMJcmANjF4ys6sfidfHHpBxqGtl9uJTzerB1tBK5dTMT6RWZ/rIb/Wg==
X-Received: by 2002:a05:6a00:94f1:b0:7e8:43f5:bd54 with SMTP id d2e1a72fcca58-7e8c5048a31mr9168924b3a.64.1765261521909;
        Mon, 08 Dec 2025 22:25:21 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5c400sm14916187b3a.37.2025.12.08.22.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:25:21 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next v2 2/3] wifi: mac80211: track S1G Response Indication (RI) and notify drivers
Date: Tue,  9 Dec 2025 11:54:23 +0530
Message-Id: <20251209062424.3926297-3-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G STAs advertise a Response Indication (RI) that signals which
immediate response (at SIFS) is expected to the eliciting frame.

Updates mac80211 to track this configured response indication throughout
the device's operation. It ensures that changes are recognized and
communicated to the driver layer via BSS_CHANGED_S1G_RI, allowing
firmware/hardware to be configured accordingly while also maintaining
correct behaviour during interface restarts and ensuring that
non-S1G interfaces are unaffected.

enum defined for the RI types per IEEE Std 802.11-2024 Table 10-7.

Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
---

v1 -> v2
- fixed kernel doc
---
 include/linux/ieee80211-s1g.h | 14 ++++++++++++++
 include/net/mac80211.h        |  5 +++++
 net/mac80211/cfg.c            | 18 ++++++++++++++++++
 net/mac80211/link.c           |  1 +
 net/mac80211/util.c           |  3 +++
 5 files changed, 41 insertions(+)

diff --git a/include/linux/ieee80211-s1g.h b/include/linux/ieee80211-s1g.h
index 5b9ed2dcc00e..df5e37d07bf5 100644
--- a/include/linux/ieee80211-s1g.h
+++ b/include/linux/ieee80211-s1g.h
@@ -109,6 +109,20 @@ enum ieee80211_s1g_pri_chanwidth {
 	IEEE80211_S1G_PRI_CHANWIDTH_1MHZ = 1,
 };
 
+/**
+ * enum ieee80211_s1g_ri - S1G Response Indication type
+ * @IEEE80211_S1G_RI_NO_RESPONSE: No immediate response
+ * @IEEE80211_S1G_RI_NDP_RESPONSE: NDP Ack/CTS/BlockAck
+ * @IEEE80211_S1G_RI_NORMAL_RESPONSE: Ack/CTS/BlockAck/TACK
+ * @IEEE80211_S1G_RI_LONG_RESPONSE: Not an individual control response frame
+ */
+enum ieee80211_s1g_ri {
+	IEEE80211_S1G_RI_NO_RESPONSE = 0,
+	IEEE80211_S1G_RI_NDP_RESPONSE = 1,
+	IEEE80211_S1G_RI_NORMAL_RESPONSE = 2,
+	IEEE80211_S1G_RI_LONG_RESPONSE = 3,
+};
+
 /**
  * struct ieee80211_s1g_bcn_compat_ie - S1G Beacon Compatibility element
  * @compat_info: Compatibility Information
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..89084ae46d26 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -365,6 +365,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
  * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
  * @BSS_CHANGED_TPE: transmit power envelope changed
+ * @BSS_CHANGED_S1G_RI: S1G response indication type changed
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -402,6 +403,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 	BSS_CHANGED_TPE			= BIT_ULL(35),
+	BSS_CHANGED_S1G_RI		= BIT_ULL(36),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -760,6 +762,8 @@ struct ieee80211_parsed_tpe {
  *	(as opposed to hearing its value from another link's beacon).
  * @s1g_long_beacon_period: number of beacon intervals between each long
  *	beacon transmission.
+ * @s1g_ri: Response indication type expected for the frame sent on this
+ *	BSS
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -861,6 +865,7 @@ struct ieee80211_bss_conf {
 	u8 bss_param_ch_cnt_link_id;
 
 	u8 s1g_long_beacon_period;
+	enum ieee80211_s1g_ri s1g_ri;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..ae47ae70d36a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5533,6 +5533,23 @@ ieee80211_set_epcs(struct wiphy *wiphy, struct net_device *dev, bool enable)
 	return ieee80211_mgd_set_epcs(sdata, enable);
 }
 
+static int
+ieee80211_set_s1g_ri(struct wiphy *wiphy, struct net_device *dev, u8 ri)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	if (!sdata->vif.cfg.s1g)
+		return -EOPNOTSUPP;
+
+	sdata->vif.bss_conf.s1g_ri = ri;
+
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_S1G_RI);
+
+	return 0;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5649,4 +5666,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.get_radio_mask = ieee80211_get_radio_mask,
 	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
 	.set_epcs = ieee80211_set_epcs,
+	.set_s1g_ri = ieee80211_set_s1g_ri,
 };
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 1e05845872af..4bf8155b4935 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -109,6 +109,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 	link->user_power_level = sdata->local->user_power_level;
 	link_conf->txpower = INT_MIN;
+	link_conf->s1g_ri = IEEE80211_S1G_RI_NDP_RESPONSE;
 
 	wiphy_work_init(&link->csa.finalize_work,
 			ieee80211_csa_finalize_work);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..309a3a3b9441 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1960,6 +1960,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			ieee80211_assign_chanctx(local, sdata, link);
 		}
 
+		if (sdata->vif.cfg.s1g)
+			changed |= BSS_CHANGED_S1G_RI;
+
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
-- 
2.25.1


