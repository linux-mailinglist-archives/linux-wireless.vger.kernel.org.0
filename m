Return-Path: <linux-wireless+bounces-27147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE264B4A491
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFC84E1480
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BC2459DC;
	Tue,  9 Sep 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="xNiT4QZl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560D27453
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405300; cv=none; b=VO7FTTNENxT6i1mfccAw8Q6TRuF2ZZEnxxDuZh1r3sp5bSaeloPMTFUzefVJipWwmYaV3oLgC5yIVhrnlZ52O3deExi4JCycfXLH2XrHP8QyhAlOOu++QBik+cGqnVk4pgYp3+EmGYoadAi0be1pRhFNL7jDA2Xr6ECshmmT9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405300; c=relaxed/simple;
	bh=QBXodacwUyNjDwk/6UhSgchwiAuNMLGNZLcwKZgQPbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNTQ3DDmZZ9N8WrcDIw2VqkqaA8ohYlMBJ3lZu2JIgHpnS3f93d/AaOpkPwNK8xF1VniuzG3beiN4q23Tn+Qqb2HJAsJU3I6xIO3ZVm3Do1+obdeaqOdQDBNbP6i/YyGqdZKRPgOyDiUdqymwayRL/DLaMxGWZJ7jo+uIijZ/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=xNiT4QZl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so4193372a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757405297; x=1758010097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0aNlZaacj3a2Mf26ame9GHgKjkee1TOEH/JpGetl04=;
        b=xNiT4QZlP6eCZryja3ZUTLvaqNwD+Ctj3o99OHQu37kCoSkgE7LogxkIG/RxZDh1A0
         VmM5ppByY7X3hOf/nQJyqIBi81hoOxCFiTWmeLchBqxDK/gShjSmHyaZbC4J46zC/pjK
         54OLD9w6sPy+0dKcv3nq2/fXmd3mrc7xGx9j49gc2XICGUMRZcc6ZSScrq2r4kJRaA+8
         ANE/HYfN22/8ciShJ5GUtDYsAaAd8PzSXFURcjDfehvxYmMJ9JAh8NRNDsVyE6Z6/Urj
         jIIp09f15jXfCJj57cmbHBCAmmnRappH/Cj8S4EmSFrYjDm+1Zn/I98OcRfV8VmGlxwF
         YG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405297; x=1758010097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0aNlZaacj3a2Mf26ame9GHgKjkee1TOEH/JpGetl04=;
        b=aCA4M+gpIrXMJiTFgV5wgXnCV4oBA+kpU7RuCc1mZ7ikKXWZYCBW1dJjpmAp/X2ruH
         pb63U7Sv75EJ0J8zKjqm9rjhR0Y3GKJvccnm2ftLUsEoFM2iQEbv3q2B3V9FfNLsC0V7
         W897eZPTtMyZ0bGF+UQ5GbRZgn3Ul/ixylZbwCa5vL87AO+3/Y0CtkiQ7gCOjpIQ2Xaf
         oCqFoMof9WiRqpGWiY0ZAY4OWYaV4iBWvpEFyTCUsLhZZSogpCfezV4zDm9T2BZW+8Gz
         6IqLpSPEPzPWGvY8QJ/KKVEh/hGFEvXS9HWzY40fFA6YwEbjHr8d1haAdKAu7X4kh0C2
         hGAw==
X-Gm-Message-State: AOJu0YzAxuHVd+GuwskqcW7LdHiKpTUFyxD4twBdwIN8ZSjX0Sa0iOSM
	KvaZ0T+4imIuCRGNxXzZzyz0ayzbngKdViwqo9A+laSm7gl2uYLIfd0Z/sctHZQgT89t1gsT/9e
	ButdT5HM=
X-Gm-Gg: ASbGncvPuIiBc8S/zt+EtiQrAgqXf9ucYuWrEP12ZtgpnsGYXiVKoayPgcJECFNXW5e
	D7OV+YJ96x1lxVps31YzhqejoeJSZfaZeESFohdMIgcYam6IVVtHDrn6Y5ugrnPKerTZXZLLoFo
	fsCJeJvLuOEw9Aty4hrfmoV64IjJ+6zj2Bnnw01iTLJos7NhimBUckdDc/YmMTNJYbmtGmia1Et
	/DMjXaPtlL1Gwql32Zjz1l9ZjkmR4oUoBjeMQUzJy+Wv4C7czl7T8ftnKt7/FNe1loT6rrVyZTz
	mR+BFR0ARqyXBNTmsJ52uFLFjJDK2Vpe4yo5O41QAjrpt1Gs68wkX1C7W7vGOvoDPKHrB2LZXJb
	j/WrZr2w9J1nCcr7J/OA/cLnRO4en3U84S5Wocyg7ExzB5QaRJY3O07qj5X6rLJGyVuvoAJrlWK
	acL+MEGmFlfsv+YoZQYmt1aRHbW2EwwIapqZV/U5v0wdEOi4EM
X-Google-Smtp-Source: AGHT+IEUI90hdgYAMoik5Dh8WB3Mfus0hfg0uPRiBoFF6lS0IstDl7RorWgt2U8MfAVPd9kZhJsjcg==
X-Received: by 2002:a17:902:e742:b0:248:a642:eec6 with SMTP id d9443c01a7336-25172b49d0bmr115369665ad.50.1757405297272;
        Tue, 09 Sep 2025 01:08:17 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm148882995ad.89.2025.09.09.01.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:08:16 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC wireless-next 2/3] wifi: mac80211: correctly initialise S1G chandef for STA
Date: Tue,  9 Sep 2025 18:07:49 +1000
Message-ID: <20250909080758.1004956-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When moving to the APs channel, ensure we correctly initialise the chandef
and perform the required validation. Additionally, if the AP is beaconing on a
2MHz primary, calculate the 2MHz primary center frequency by extracting
the sibling 1MHz primary and averaging the frequencies to find the 2MHz
primary center frequency.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/ieee80211.h  | 18 ++++++++++++-
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/main.c        |  6 +++--
 net/mac80211/mlme.c        | 52 +++++++++++++++++++++++++++++++++-----
 net/mac80211/scan.c        | 13 +++++-----
 net/mac80211/util.c        | 39 +++++++++++++++++++++++-----
 6 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d350263f23f3..ae8ce3700e0a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1182,6 +1182,18 @@ enum ieee80211_s1g_chanwidth {
 	IEEE80211_S1G_CHANWIDTH_16MHZ = 15,
 };
 
+/**
+ * enum ieee80211_s1g_pri_chanwidth - S1G primary channel widths
+ *	described in IEEE80211-2024 Table 10-39.
+ *
+ * @IEEE80211_S1G_PRI_CHANWIDTH_2MHZ: 2MHz primary channel
+ * @IEEE80211_S1G_PRI_CHANWIDTH_1MHZ: 1MHz primary channel
+ */
+enum ieee80211_s1g_pri_chanwidth {
+	IEEE80211_S1G_PRI_CHANWIDTH_2MHZ = 0,
+	IEEE80211_S1G_PRI_CHANWIDTH_1MHZ = 1,
+};
+
 #define WLAN_SA_QUERY_TR_ID_LEN 2
 #define WLAN_MEMBERSHIP_LEN 8
 #define WLAN_USER_POSITION_LEN 16
@@ -3170,8 +3182,12 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 
 #define S1G_CAP9_LINK_ADAPT_PER_CONTROL_RESPONSE BIT(0)
 
-#define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
+#define S1G_OPER_CH_WIDTH_PRIMARY	BIT(0)
 #define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
+#define S1G_OPER_CH_PRIMARY_LOCATION	BIT(5)
+
+#define S1G_2M_PRIMARY_LOCATION_LOWER	0
+#define S1G_2M_PRIMARY_LOCATION_UPPER	1
 
 /* EHT MAC capabilities as defined in P802.11be_D2.0 section 9.4.2.313.2 */
 #define IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS			0x01
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 07f5fb11569b..3c8a1d2c6ca5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2710,7 +2710,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_local *local,
 				    const struct ieee80211_he_operation *he_oper,
 				    const struct ieee80211_eht_operation *eht_oper,
 				    struct cfg80211_chan_def *chandef);
-bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
+bool ieee80211_chandef_s1g_oper(struct ieee80211_local *local,
+				const struct ieee80211_s1g_oper_ie *oper,
 				struct cfg80211_chan_def *chandef);
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *chandef,
 				 struct ieee80211_conn_settings *conn);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e8c85aa77c56..dc619b620b36 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1243,11 +1243,13 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		if (!dflt_chandef.chan) {
 			/*
 			 * Assign the first enabled channel to dflt_chandef
-			 * from the list of channels
+			 * from the list of channels. For S1G interfaces
+			 * ensure it can be used as a primary.
 			 */
 			for (i = 0; i < sband->n_channels; i++)
 				if (!(sband->channels[i].flags &
-						IEEE80211_CHAN_DISABLED))
+				      (IEEE80211_CHAN_DISABLED |
+				       IEEE80211_CHAN_S1G_NO_PRIMARY)))
 					break;
 			/* if none found then use the first anyway */
 			if (i == sband->n_channels)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 83a9986dd1c4..7b27b106cf05 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -180,11 +180,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 
 	/* get special S1G case out of the way */
 	if (sband->band == NL80211_BAND_S1GHZ) {
-		if (!ieee80211_chandef_s1g_oper(elems->s1g_oper, chandef)) {
-			sdata_info(sdata,
-				   "Missing S1G Operation Element? Trying operating == primary\n");
-			chandef->width = ieee80211_s1g_channel_width(channel);
-		}
+		if (!ieee80211_chandef_s1g_oper(sdata->local, elems->s1g_oper,
+						chandef))
+			WARN_ON(1);
 
 		return IEEE80211_CONN_MODE_S1G;
 	}
@@ -1046,6 +1044,14 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			ret = -EINVAL;
 			goto free;
 		}
+
+		chanreq->oper = *ap_chandef;
+		if (!cfg80211_chandef_usable(sdata->wdev.wiphy, &chanreq->oper,
+					     IEEE80211_CHAN_DISABLED)) {
+			ret = -EINVAL;
+			goto free;
+		}
+
 		return elems;
 	case NL80211_BAND_6GHZ:
 		if (ap_mode < IEEE80211_CONN_MODE_HE) {
@@ -7288,6 +7294,38 @@ static bool ieee80211_mgd_ssid_mismatch(struct ieee80211_sub_if_data *sdata,
 	return memcmp(elems->ssid, cfg->ssid, cfg->ssid_len);
 }
 
+static bool
+ieee80211_rx_beacon_freq_valid(struct ieee80211_local *local,
+			       struct ieee80211_mgmt *mgmt,
+			       struct ieee80211_rx_status *rx_status,
+			       struct ieee80211_chanctx_conf *chanctx)
+{
+	u32 pri_2mhz_khz;
+	struct ieee80211_channel *s1g_sibling_1mhz;
+	u32 pri_khz = ieee80211_channel_to_khz(chanctx->def.chan);
+	u32 rx_khz = ieee80211_rx_status_to_khz(rx_status);
+
+	if (rx_khz == pri_khz)
+		return true;
+
+	if (!chanctx->def.s1g_primary_2mhz)
+		return false;
+
+	/*
+	 * If we have an S1G interface with a 2MHz primary, beacons are
+	 * sent on the center frequency of the 2MHz primary. Find the sibling
+	 * 1MHz channel and calculate the 2MHz primary center frequency.
+	 */
+	s1g_sibling_1mhz = cfg80211_s1g_get_primary_sibling(local->hw.wiphy,
+							    &chanctx->def);
+	if (!s1g_sibling_1mhz)
+		return false;
+
+	pri_2mhz_khz =
+		(pri_khz + ieee80211_channel_to_khz(s1g_sibling_1mhz)) / 2;
+	return rx_khz == pri_2mhz_khz;
+}
+
 static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
@@ -7342,8 +7380,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		return;
 	}
 
-	if (ieee80211_rx_status_to_khz(rx_status) !=
-	    ieee80211_channel_to_khz(chanctx_conf->def.chan)) {
+	if (!ieee80211_rx_beacon_freq_valid(local, mgmt, rx_status,
+					    chanctx_conf)) {
 		rcu_read_unlock();
 		return;
 	}
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index dbf98aa4cd67..bb9563f50e7b 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -996,15 +996,15 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	local->scan_chandef.freq1_offset = chan->freq_offset;
 	local->scan_chandef.center_freq2 = 0;
 
-	/* For scanning on the S1G band, detect the channel width according to
-	 * the channel being scanned.
-	 */
+	/* For S1G, only scan the 1MHz primaries. */
 	if (chan->band == NL80211_BAND_S1GHZ) {
-		local->scan_chandef.width = ieee80211_s1g_channel_width(chan);
+		local->scan_chandef.width = NL80211_CHAN_WIDTH_1;
+		local->scan_chandef.s1g_primary_2mhz = false;
 		goto set_channel;
 	}
 
-	/* If scanning on oper channel, use whatever channel-type
+	/*
+	 * If scanning on oper channel, use whatever channel-type
 	 * is currently in use.
 	 */
 	if (chan == local->hw.conf.chandef.chan)
@@ -1213,7 +1213,8 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 
 		for (band = 0; band < NUM_NL80211_BANDS; band++) {
 			if (!local->hw.wiphy->bands[band] ||
-			    band == NL80211_BAND_6GHZ)
+			    band == NL80211_BAND_6GHZ ||
+			    band == NL80211_BAND_S1GHZ)
 				continue;
 
 			max_n = local->hw.wiphy->bands[band]->n_channels;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9eb35e3b9e52..fe731aa38ae1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3199,10 +3199,11 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_local *local,
 	return true;
 }
 
-bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
+bool ieee80211_chandef_s1g_oper(struct ieee80211_local *local,
+				const struct ieee80211_s1g_oper_ie *oper,
 				struct cfg80211_chan_def *chandef)
 {
-	u32 oper_freq;
+	u32 oper_khz, pri_1mhz_khz, pri_2mhz_khz;
 
 	if (!oper)
 		return false;
@@ -3227,12 +3228,36 @@ bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 		return false;
 	}
 
-	oper_freq = ieee80211_channel_to_freq_khz(oper->oper_ch,
-						  NL80211_BAND_S1GHZ);
-	chandef->center_freq1 = KHZ_TO_MHZ(oper_freq);
-	chandef->freq1_offset = oper_freq % 1000;
+	chandef->s1g_primary_2mhz = false;
 
-	return true;
+	switch (FIELD_GET(S1G_OPER_CH_WIDTH_PRIMARY, oper->ch_width)) {
+	case IEEE80211_S1G_PRI_CHANWIDTH_1MHZ:
+		pri_1mhz_khz = ieee80211_channel_to_freq_khz(
+			oper->primary_ch, NL80211_BAND_S1GHZ);
+		break;
+	case IEEE80211_S1G_PRI_CHANWIDTH_2MHZ:
+		chandef->s1g_primary_2mhz = true;
+		pri_2mhz_khz = ieee80211_channel_to_freq_khz(
+			oper->primary_ch, NL80211_BAND_S1GHZ);
+
+		if (FIELD_GET(S1G_OPER_CH_PRIMARY_LOCATION, oper->ch_width) ==
+		    S1G_2M_PRIMARY_LOCATION_LOWER)
+			pri_1mhz_khz = pri_2mhz_khz - 500;
+		else
+			pri_1mhz_khz = pri_2mhz_khz + 500;
+		break;
+	default:
+		return false;
+	}
+
+	oper_khz = ieee80211_channel_to_freq_khz(oper->oper_ch,
+						 NL80211_BAND_S1GHZ);
+	chandef->center_freq1 = KHZ_TO_MHZ(oper_khz);
+	chandef->freq1_offset = oper_khz % 1000;
+	chandef->chan =
+		ieee80211_get_channel_khz(local->hw.wiphy, pri_1mhz_khz);
+
+	return chandef->chan;
 }
 
 int ieee80211_put_srates_elem(struct sk_buff *skb,
-- 
2.43.0


