Return-Path: <linux-wireless+bounces-29581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D8CABF99
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893DE300E7BC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 03:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34142F7478;
	Mon,  8 Dec 2025 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="UDrKhsxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A5233704
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165224; cv=none; b=FTdmW4U44L75gElofhaBLV3xRoQfDWnAmU/C7HX4SxrdMOQQBB8aArGtmrDtf/TZNfxus7WE0BuDQOL6WCLNIbypWkqNG58mxCQTyjfUKUzkzHwSpKaz5grp6fPYyo74Fcb5w8DXRHedz0OPvn9+cHsSO0Rp10D0ucEgN4cjFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165224; c=relaxed/simple;
	bh=2UhmhsfnWbZt6zDcPyiojZezuQ24O9gAlv2mVwaPDwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cII8yqByY4EL8X9CeMrqRrTt14t5yF4NtEoitkn8EeI7u6U0lctSmnvQACryhcGL1c7G/h1dlrLpAHmkbi+FqQC+pyWi8/2V+Mg3+hGNdbUPDIEoHG6scx16TdCoy4oHufVALKgCt9GiFw3kLxU+aUk5bmwqb23eXGWsKOKUj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=UDrKhsxP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso2564279a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 19:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765165222; x=1765770022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MlP8HULbF0RNoTNae1SDX0p1yQIU3Il+t2wwdZX93o=;
        b=UDrKhsxPSin/gAsmrn+cVCYKKPNe9w6dZ2Iz0dDCdGeShlaGGJjyvjprAAkOhSpgHa
         bLEtOvG4vQcfRM8tvFl54wPR/HHQUHe/xSs445m7Ig/Yyeck32PTponWnUPv3GmrMuzU
         2mkVo55XD/dN7qmey8Vg5bK/UloXO0YosCL2is1OL2fm725jzaplm9MO+IxZiFq3rkTx
         Z1AF8kUfaZoT6D6xpKzImW0sAonG2cBTj7ypH4mLEnsy85XifGFdUryelmJl4H7Fx15q
         d3/mFANrGKEbvYGLia5ykYF6xbGDRioj+u/xtkjKXfKVkKc0iDxMUHocR2xRVWoGnGRx
         gGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165222; x=1765770022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3MlP8HULbF0RNoTNae1SDX0p1yQIU3Il+t2wwdZX93o=;
        b=Oy9E29KVXgfcon6SYecrGI4slEsiNHSSrxcyH9OI1m6XFa5GPCpcZSxYz4KgrlxsSf
         vmk7/nHW7ISkxZ65XpSQakJ/5N+r9XWQ7c9QTUfxlVoz1ZKm/9ThaIcNi1FybRYYBjc6
         K3G7pz+HFEeeXLUhul/W6RD17StyFC1+ICqG7wkH+Zaweuzk59CaHshkqTZmXJ216Ve+
         dZumbYGccbmXAHt8kqZKL+fl+vSjyihi2PM6TzIAdvtq4B2sJNuMQEUUpUxW45z6/lcT
         T5oyHAXTXEzh5p592/l6rqn5q5AZ6l9AaXDJ2Cq/ITSekJWgCmr+d1QlozhFVRuVbw7U
         3zPQ==
X-Gm-Message-State: AOJu0Yzj94TVKb+VL9kmAl4nH8oN4YIo6y+mrCKsVeKIx6pUyF5gQw/+
	q06KGjBeqLQ3VllTUUA93m6xXrEJs/ESrACf3IxUqxZk2XpLx8oFqBo9AyhxqU3DDA==
X-Gm-Gg: ASbGncsHw2kNuevLgVKoPR+N/GRXTEbfdJEXl+AYE27Vdz/X9tdbL0RM7toxmUxaJP9
	tZ0vZDBFMbAypOOPsDGaVToowA7EiBvqgH+1YzJlDADirIG2Z1bTIjjVaoeuo5APDVPjzTjOWv9
	f5XrcEskqOfie8C3qTjL7j9yEDKN25iCpgj5wK9rFx1AerPl4Dftfmte/5Nw6d9X6mdq2nAizBu
	NfDOEx1zns/nm2e/m1VCt3WPYTtlw8gE40Lme7BwMlOdwUKCbSJVZ8T9LoIiofC+SCaP637ic/+
	vJGh9LLgDoikYITvOrDTmQ4v1AOMC9qYDQdgBjUbLd+Jl0uUv/uQSnxwOY+iJ3KuyqbJm7prQcE
	ZXNcHZONMFWS3eeO8Spi3WxiZYXLTKhTwEiCJ7Odfmf7mBSUzer8qbwfHC/k7/w9dWpV7whGVSI
	y1aeCAcFEhgR2KXk7Ep4IuWWgt
X-Google-Smtp-Source: AGHT+IFHwy3lC1vxJy0vcaDgD/be5hmLCPA3zB1eycG5JxjyrNs9o/skyI0kc7ldM/N7tt6b5y8B/g==
X-Received: by 2002:a17:90b:3c0e:b0:340:a5b2:c305 with SMTP id 98e67ed59e1d1-349a24d9203mr4718059a91.2.1765165221703;
        Sun, 07 Dec 2025 19:40:21 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea899desm10383209a91.17.2025.12.07.19.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:40:21 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	arien.judge@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: track S1G Response Indication (RI) and notify drivers
Date: Mon,  8 Dec 2025 09:09:38 +0530
Message-Id: <20251208033939.3005700-3-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
References: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
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
 include/linux/ieee80211-s1g.h | 14 ++++++++++++++
 include/net/mac80211.h        |  2 ++
 net/mac80211/cfg.c            | 18 ++++++++++++++++++
 net/mac80211/link.c           |  1 +
 net/mac80211/util.c           |  3 +++
 5 files changed, 38 insertions(+)

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
index c2e49542626c..8aa7640bb49f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -402,6 +402,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 	BSS_CHANGED_TPE			= BIT_ULL(35),
+	BSS_CHANGED_S1G_RI		= BIT_ULL(36),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -861,6 +862,7 @@ struct ieee80211_bss_conf {
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


