Return-Path: <linux-wireless+bounces-6742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504858AF7B8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654911C220C1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7EC1422CB;
	Tue, 23 Apr 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PCe7Eib2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3751422C4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902431; cv=none; b=Q9f85crrH87j2FBFWm0v67EWpRHOgjnvWh4QP8FrsBsD5eEXCHcKf6Mp9qWRQ7Faz7ehS/RKLwwOY6czpJLQlIjaIt3KeQY80r5EsvOKoUdMm/1bqDYDeSnU0HgXaBJuZGP8eMuHn9u/zh/tWOizJKrAUK1XiH4CdQ6CYc8d+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902431; c=relaxed/simple;
	bh=wNvbuW6p2g459Loo5LtLVJ8swHwPiYpIN7oXeLqJfh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUkMwLfTapMgYhieTVnwe089j9M1qdCWvate8QsSLhxMOmXaMrpXFmpzF+2MFR6+euK/lAYPXmKCd36SlRs1/pZQwujr9zV59T3Ffa//D8oF0FcPHprqJh8qH3cOO0ilp7T5zEwd4VqGToSgJmxSf4gUQKx8E1dwPUeEFGD3ATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PCe7Eib2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/zjHCqxbrqKhIzOW5+ahxcoH9m76uYC3GZ0Kn6ioC6o=;
	t=1713902428; x=1715112028; b=PCe7Eib2wfmbd2v1+1sBgTkeLjJI2tKmQKwP53xDFY23AI8
	tzD833Di79PEy5lXIwZ9MODZoURkEHy0s0vEqzYkgkw2sfUZq3ndlMnxKKU1ekXcvTZZQhpjBqJyx
	Ya2GKmVAcEuL6HGNr+n3mfUUVPHXdFFe39YVLnBz1smGixG6B0PSS3qWclEh9gpFmrQkuQx3lXPzd
	97Uu1pzWT+dPgwYQLPK/k2JnlBtAekQTV7qXH+0/NeaF626tzYoU9DGZQ5c38wY10zPE/0ivmYKma
	n83PtO3K23YfDv2i1jiF3O3GgFVpFyRLyk15rr3E/J3SJd8MO/zonIFzpa8eKh+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzMJU-00000002OTL-3jus;
	Tue, 23 Apr 2024 22:00:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 3/4] wifi: mac80211: pass parsed TPE data to drivers
Date: Tue, 23 Apr 2024 21:56:14 +0200
Message-ID: <20240423220019.292eeed6fc1d.I265b28209e0b29772b2f125f7f83de44a4da877b@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423200019.192941-6-johannes@sipsolutions.net>
References: <20240423200019.192941-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of passing the full TPE elements, in all their glory
and mixed up data formats for HE backward compatibility, parse
them fully into the right values, and pass that to the drivers.

Also introduce proper validation already in mac80211, so that
drivers don't need to do it, and parse the EHT portions.

The code now passes the values in the right order according to
the channel used by an interface, which could also be a subset
of the data advertised by the AP, if we couldn't connect with
the full bandwidth (for whatever reason.)

Also add kunit tests for the more complicated bits of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 143 ++++----------
 include/linux/ieee80211.h             | 101 ++++++++--
 include/net/mac80211.h                |  41 +++-
 net/mac80211/ieee80211_i.h            |  13 +-
 net/mac80211/mlme.c                   | 227 +++++++++++++++++++---
 net/mac80211/parse.c                  |  92 ++++++++-
 net/mac80211/tests/Makefile           |   2 +-
 net/mac80211/tests/tpe.c              | 263 ++++++++++++++++++++++++++
 net/mac80211/util.c                   |  25 +++
 9 files changed, 737 insertions(+), 170 deletions(-)
 create mode 100644 net/mac80211/tests/tpe.c

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1a3ea072eec3..32d6552c90ae 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7507,32 +7507,6 @@ static int ath11k_mac_stop_vdev_early(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static u8 ath11k_mac_get_tpe_count(u8 txpwr_intrprt, u8 txpwr_cnt)
-{
-	switch (txpwr_intrprt) {
-	/* Refer "Table 9-276-Meaning of Maximum Transmit Power Count subfield
-	 * if the Maximum Transmit Power Interpretation subfield is 0 or 2" of
-	 * "IEEE Std 802.11ax 2021".
-	 */
-	case IEEE80211_TPE_LOCAL_EIRP:
-	case IEEE80211_TPE_REG_CLIENT_EIRP:
-		txpwr_cnt = txpwr_cnt <= 3 ? txpwr_cnt : 3;
-		txpwr_cnt = txpwr_cnt + 1;
-		break;
-	/* Refer "Table 9-277-Meaning of Maximum Transmit Power Count subfield
-	 * if Maximum Transmit Power Interpretation subfield is 1 or 3" of
-	 * "IEEE Std 802.11ax 2021".
-	 */
-	case IEEE80211_TPE_LOCAL_EIRP_PSD:
-	case IEEE80211_TPE_REG_CLIENT_EIRP_PSD:
-		txpwr_cnt = txpwr_cnt <= 4 ? txpwr_cnt : 4;
-		txpwr_cnt = txpwr_cnt ? (BIT(txpwr_cnt - 1)) : 1;
-		break;
-	}
-
-	return txpwr_cnt;
-}
-
 static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
 {
 	if (chan_def->chan->flags & IEEE80211_CHAN_PSD) {
@@ -7859,33 +7833,23 @@ static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
-	struct ieee80211_tx_pwr_env *single_tpe;
+	struct ieee80211_parsed_tpe_eirp *non_psd = NULL;
+	struct ieee80211_parsed_tpe_psd *psd = NULL;
 	enum wmi_reg_6ghz_client_type client_type;
 	struct cur_regulatory_info *reg_info;
+	u8 local_tpe_count, reg_tpe_count;
+	bool use_local_tpe;
 	int i;
-	u8 pwr_count, pwr_interpret, pwr_category;
-	u8 psd_index = 0, non_psd_index = 0, local_tpe_count = 0, reg_tpe_count = 0;
-	bool use_local_tpe, non_psd_set = false, psd_set = false;
 
 	reg_info = &ab->reg_info_store[ar->pdev_idx];
 	client_type = reg_info->client_type;
 
-	for (i = 0; i < bss_conf->tx_pwr_env_num; i++) {
-		single_tpe = &bss_conf->tx_pwr_env[i];
-		pwr_category = u8_get_bits(single_tpe->tx_power_info,
-					   IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
-		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
-					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
-
-		if (pwr_category == client_type) {
-			if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP ||
-			    pwr_interpret == IEEE80211_TPE_LOCAL_EIRP_PSD)
-				local_tpe_count++;
-			else if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP ||
-				 pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP_PSD)
-				reg_tpe_count++;
-		}
-	}
+	local_tpe_count =
+		bss_conf->tpe.max_local[client_type].valid +
+		bss_conf->tpe.psd_local[client_type].valid;
+	reg_tpe_count =
+		bss_conf->tpe.max_reg_client[client_type].valid +
+		bss_conf->tpe.psd_reg_client[client_type].valid;
 
 	if (!reg_tpe_count && !local_tpe_count) {
 		ath11k_warn(ab,
@@ -7898,83 +7862,44 @@ static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 		use_local_tpe = false;
 	}
 
-	for (i = 0; i < bss_conf->tx_pwr_env_num; i++) {
-		single_tpe = &bss_conf->tx_pwr_env[i];
-		pwr_category = u8_get_bits(single_tpe->tx_power_info,
-					   IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
-		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
-					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
-
-		if (pwr_category != client_type)
-			continue;
-
-		/* get local transmit power envelope */
-		if (use_local_tpe) {
-			if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP) {
-				non_psd_index = i;
-				non_psd_set = true;
-			} else if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP_PSD) {
-				psd_index = i;
-				psd_set = true;
-			}
-		/* get regulatory transmit power envelope */
-		} else {
-			if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP) {
-				non_psd_index = i;
-				non_psd_set = true;
-			} else if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP_PSD) {
-				psd_index = i;
-				psd_set = true;
-			}
-		}
+	if (use_local_tpe) {
+		psd = &bss_conf->tpe.psd_local[client_type];
+		if (!psd->valid)
+			psd = NULL;
+		non_psd = &bss_conf->tpe.max_local[client_type];
+		if (!non_psd->valid)
+			non_psd = NULL;
+	} else {
+		psd = &bss_conf->tpe.psd_reg_client[client_type];
+		if (!psd->valid)
+			psd = NULL;
+		non_psd = &bss_conf->tpe.max_reg_client[client_type];
+		if (!non_psd->valid)
+			non_psd = NULL;
 	}
 
-	if (non_psd_set && !psd_set) {
-		single_tpe = &bss_conf->tx_pwr_env[non_psd_index];
-		pwr_count = u8_get_bits(single_tpe->tx_power_info,
-					IEEE80211_TX_PWR_ENV_INFO_COUNT);
-		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
-					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+	if (non_psd && !psd) {
 		arvif->reg_tpc_info.is_psd_power = false;
 		arvif->reg_tpc_info.eirp_power = 0;
 
-		arvif->reg_tpc_info.num_pwr_levels =
-			ath11k_mac_get_tpe_count(pwr_interpret, pwr_count);
+		arvif->reg_tpc_info.num_pwr_levels = non_psd->count;
 
 		for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
 			ath11k_dbg(ab, ATH11K_DBG_MAC,
 				   "non PSD power[%d] : %d\n",
-				   i, single_tpe->tx_power[i]);
-			arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+				   i, non_psd->power[i]);
+			arvif->reg_tpc_info.tpe[i] = non_psd->power[i] / 2;
 		}
 	}
 
-	if (psd_set) {
-		single_tpe = &bss_conf->tx_pwr_env[psd_index];
-		pwr_count = u8_get_bits(single_tpe->tx_power_info,
-					IEEE80211_TX_PWR_ENV_INFO_COUNT);
-		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
-					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
-		arvif->reg_tpc_info.is_psd_power = true;
+	if (psd) {
+		arvif->reg_tpc_info.num_pwr_levels = psd->count;
 
-		if (pwr_count == 0) {
+		for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
 			ath11k_dbg(ab, ATH11K_DBG_MAC,
-				   "TPE PSD power : %d\n", single_tpe->tx_power[0]);
-			arvif->reg_tpc_info.num_pwr_levels =
-				ath11k_mac_get_num_pwr_levels(&ctx->def);
-
-			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++)
-				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[0] / 2;
-		} else {
-			arvif->reg_tpc_info.num_pwr_levels =
-				ath11k_mac_get_tpe_count(pwr_interpret, pwr_count);
-
-			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
-				ath11k_dbg(ab, ATH11K_DBG_MAC,
-					   "TPE PSD power[%d] : %d\n",
-					   i, single_tpe->tx_power[i]);
-				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
-			}
+				   "TPE PSD power[%d] : %d\n",
+				   i, psd->power[i]);
+			arvif->reg_tpc_info.tpe[i] = psd->power[i] / 2;
 		}
 	}
 }
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 68d861c9d873..8d47d0d2256b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2789,17 +2789,6 @@ struct ieee80211_he_6ghz_oper {
 	u8 minrate;
 } __packed;
 
-/*
- * In "9.4.2.161 Transmit Power Envelope element" of "IEEE Std 802.11ax-2021",
- * it show four types in "Table 9-275a-Maximum Transmit Power Interpretation
- * subfield encoding", and two category for each type in "Table E-12-Regulatory
- * Info subfield encoding in the United States".
- * So it it totally max 8 Transmit Power Envelope element.
- */
-#define IEEE80211_TPE_MAX_IE_COUNT	8
-
-#define IEEE80211_TPE_MAX_POWER_COUNT	8
-
 /* transmit power interpretation type of transmit power envelope element */
 enum ieee80211_tx_power_intrpt_type {
 	IEEE80211_TPE_LOCAL_EIRP,
@@ -2808,24 +2797,106 @@ enum ieee80211_tx_power_intrpt_type {
 	IEEE80211_TPE_REG_CLIENT_EIRP_PSD,
 };
 
+/* category type of transmit power envelope element */
+enum ieee80211_tx_power_category_6ghz {
+	IEEE80211_TPE_CAT_6GHZ_DEFAULT = 0,
+	IEEE80211_TPE_CAT_6GHZ_SUBORDINATE = 1,
+};
+
+/*
+ * For IEEE80211_TPE_LOCAL_EIRP / IEEE80211_TPE_REG_CLIENT_EIRP,
+ * setting to 63.5 dBm means no constraint.
+ */
+#define IEEE80211_TPE_MAX_TX_PWR_NO_CONSTRAINT	127
+
+/*
+ * For IEEE80211_TPE_LOCAL_EIRP_PSD / IEEE80211_TPE_REG_CLIENT_EIRP_PSD,
+ * setting to 127 indicates no PSD limit for the 20 MHz channel.
+ */
+#define IEEE80211_TPE_PSD_NO_LIMIT		127
+
 /**
  * struct ieee80211_tx_pwr_env - Transmit Power Envelope
- * @tx_power_info: Transmit Power Information field
- * @tx_power: Maximum Transmit Power field
+ * @info: Transmit Power Information field
+ * @variable: Maximum Transmit Power field
  *
  * This structure represents the payload of the "Transmit Power
  * Envelope element" as described in IEEE Std 802.11ax-2021 section
  * 9.4.2.161
  */
 struct ieee80211_tx_pwr_env {
-	u8 tx_power_info;
-	s8 tx_power[IEEE80211_TPE_MAX_POWER_COUNT];
+	u8 info;
+	u8 variable[];
 } __packed;
 
 #define IEEE80211_TX_PWR_ENV_INFO_COUNT 0x7
 #define IEEE80211_TX_PWR_ENV_INFO_INTERPRET 0x38
 #define IEEE80211_TX_PWR_ENV_INFO_CATEGORY 0xC0
 
+#define IEEE80211_TX_PWR_ENV_EXT_COUNT	0xF
+
+static inline bool ieee80211_valid_tpe_element(const u8 *data, u8 len)
+{
+	const struct ieee80211_tx_pwr_env *env = (const void *)data;
+	u8 count, interpret, category;
+	u8 needed = sizeof(*env);
+	u8 N; /* also called N in the spec */
+
+	if (len < needed)
+		return false;
+
+	count = u8_get_bits(env->info, IEEE80211_TX_PWR_ENV_INFO_COUNT);
+	interpret = u8_get_bits(env->info, IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+	category = u8_get_bits(env->info, IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
+
+	switch (category) {
+	case IEEE80211_TPE_CAT_6GHZ_DEFAULT:
+	case IEEE80211_TPE_CAT_6GHZ_SUBORDINATE:
+		break;
+	default:
+		return false;
+	}
+
+	switch (interpret) {
+	case IEEE80211_TPE_LOCAL_EIRP:
+	case IEEE80211_TPE_REG_CLIENT_EIRP:
+		if (count > 3)
+			return false;
+
+		needed += count + 1;
+
+		if (len < needed)
+			return false;
+
+		/* there can be extension fields not accounted for in 'count' */
+
+		return true;
+	case IEEE80211_TPE_LOCAL_EIRP_PSD:
+	case IEEE80211_TPE_REG_CLIENT_EIRP_PSD:
+		if (count > 4)
+			return false;
+
+		N = count ? 1 << (count - 1) : 1;
+		needed += N;
+
+		if (len < needed)
+			return false;
+
+		if (len > needed) {
+			u8 K = u8_get_bits(env->variable[N],
+					   IEEE80211_TX_PWR_ENV_EXT_COUNT);
+
+			needed += 1 + K;
+			if (len < needed)
+				return false;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
  * @he_oper_ie: byte data of the He Operations IE, stating from the byte
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 41f135a793ab..b8ce4531631e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -550,6 +550,39 @@ struct ieee80211_fils_discovery {
 	u32 max_interval;
 };
 
+#define IEEE80211_TPE_EIRP_ENTRIES_320MHZ	5
+struct ieee80211_parsed_tpe_eirp {
+	bool valid;
+	s8 power[IEEE80211_TPE_EIRP_ENTRIES_320MHZ];
+	u8 count;
+};
+
+#define IEEE80211_TPE_PSD_ENTRIES_320MHZ	16
+struct ieee80211_parsed_tpe_psd {
+	bool valid;
+	s8 power[IEEE80211_TPE_PSD_ENTRIES_320MHZ];
+	u8 count, n;
+};
+
+/**
+ * struct ieee80211_parsed_tpe - parsed transmit power envelope information
+ * @max_local: maximum local EIRP, one value for 20, 40, 80, 160, 320 MHz each
+ *	(indexed by TX power category)
+ * @max_reg_client: maximum regulatory client EIRP, one value for 20, 40, 80,
+ *	160, 320 MHz each
+ *	(indexed by TX power category)
+ * @psd_local: maximum local power spectral density, one value for each 20 MHz
+ *	subchannel per bss_conf's chanreq.oper
+ *	(indexed by TX power category)
+ * @psd_reg_client: maximum regulatory power spectral density, one value for
+ *	each 20 MHz subchannel per bss_conf's chanreq.oper
+ *	(indexed by TX power category)
+ */
+struct ieee80211_parsed_tpe {
+	struct ieee80211_parsed_tpe_eirp max_local[2], max_reg_client[2];
+	struct ieee80211_parsed_tpe_psd psd_local[2], psd_reg_client[2];
+};
+
 /**
  * struct ieee80211_bss_conf - holds the BSS's changing parameters
  *
@@ -662,8 +695,7 @@ struct ieee80211_fils_discovery {
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
  * @power_type: power type of BSS for 6 GHz
- * @tx_pwr_env: transmit power envelope array of BSS.
- * @tx_pwr_env_num: number of @tx_pwr_env.
+ * @tpe: transmit power envelope information
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
  * @csa_active: marks whether a channel switch is going on.
@@ -766,8 +798,9 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
 	enum ieee80211_ap_reg_power power_type;
-	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
-	u8 tx_pwr_env_num;
+
+	struct ieee80211_parsed_tpe tpe;
+
 	u8 pwr_reduction;
 	bool eht_support;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb62b7d4b4f7..7d541a2355f6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -26,6 +26,7 @@
 #include <linux/idr.h>
 #include <linux/rhashtable.h>
 #include <linux/rbtree.h>
+#include <kunit/visibility.h>
 #include <net/ieee80211_radiotap.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
@@ -1708,7 +1709,6 @@ struct ieee802_11_elems {
 	const struct ieee80211_he_spr *he_spr;
 	const struct ieee80211_mu_edca_param_set *mu_edca_param_set;
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
-	const struct ieee80211_tx_pwr_env *tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
 	const u8 *uora_element;
 	const u8 *mesh_id;
 	const u8 *peering;
@@ -1746,6 +1746,9 @@ struct ieee802_11_elems {
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
+	/* not the order in the psd values is per element, not per chandef */
+	struct ieee80211_parsed_tpe tpe;
+
 	/* length of them, respectively */
 	u8 ext_capab_len;
 	u8 ssid_len;
@@ -1764,8 +1767,6 @@ struct ieee802_11_elems {
 	u8 perr_len;
 	u8 country_elem_len;
 	u8 bssid_index_len;
-	u8 tx_pwr_env_len[IEEE80211_TPE_MAX_IE_COUNT];
-	u8 tx_pwr_env_num;
 	u8 eht_cap_len;
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
@@ -2243,6 +2244,7 @@ int ieee80211_frame_duration(enum nl80211_band band, size_t len,
 void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 					   struct ieee80211_tx_queue_params *qparam,
 					   int ac);
+void ieee80211_clear_tpe(struct ieee80211_parsed_tpe *tpe);
 void ieee80211_set_wmm_default(struct ieee80211_link_data *link,
 			       bool bss_notify, bool enable_qos);
 void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
@@ -2681,6 +2683,11 @@ void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_d
 #define VISIBLE_IF_MAC80211_KUNIT
 ieee80211_rx_result
 ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx);
+int ieee80211_calc_chandef_subchan_offset(const struct cfg80211_chan_def *ap,
+					  u8 n_partial_subchans);
+void ieee80211_rearrange_tpe_psd(struct ieee80211_parsed_tpe_psd *psd,
+				 const struct cfg80211_chan_def *ap,
+				 const struct cfg80211_chan_def *used);
 #else
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT static
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 742cf2561bda..409484d59c79 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -606,11 +606,195 @@ static bool ieee80211_chandef_usable(struct ieee80211_sub_if_data *sdata,
 	return true;
 }
 
+static int ieee80211_chandef_num_subchans(const struct cfg80211_chan_def *c)
+{
+	if (c->width == NL80211_CHAN_WIDTH_80P80)
+		return 4 + 4;
+
+	return nl80211_chan_width_to_mhz(c->width) / 20;
+}
+
+static int ieee80211_chandef_num_widths(const struct cfg80211_chan_def *c)
+{
+	switch (c->width) {
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		return 1;
+	case NL80211_CHAN_WIDTH_40:
+		return 2;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_80:
+		return 3;
+	case NL80211_CHAN_WIDTH_160:
+		return 4;
+	case NL80211_CHAN_WIDTH_320:
+		return 5;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+VISIBLE_IF_MAC80211_KUNIT int
+ieee80211_calc_chandef_subchan_offset(const struct cfg80211_chan_def *ap,
+				      u8 n_partial_subchans)
+{
+	int n = ieee80211_chandef_num_subchans(ap);
+	struct cfg80211_chan_def tmp = *ap;
+	int offset = 0;
+
+	/*
+	 * Given a chandef (in this context, it's the AP's) and a number
+	 * of subchannels that we want to look at ('n_partial_subchans'),
+	 * calculate the offset in number of subchannels between the full
+	 * and the subset with the desired width.
+	 */
+
+	/* same number of subchannels means no offset, obviously */
+	if (n == n_partial_subchans)
+		return 0;
+
+	/* don't WARN - misconfigured APs could cause this if their N > width */
+	if (n < n_partial_subchans)
+		return 0;
+
+	while (ieee80211_chandef_num_subchans(&tmp) > n_partial_subchans) {
+		u32 prev = tmp.center_freq1;
+
+		ieee80211_chandef_downgrade(&tmp, NULL);
+
+		/*
+		 * if center_freq moved up, half the original channels
+		 * are gone now but were below, so increase offset
+		 */
+		if (prev < tmp.center_freq1)
+			offset += ieee80211_chandef_num_subchans(&tmp);
+	}
+
+	/*
+	 * 80+80 with secondary 80 below primary - four subchannels for it
+	 * (we cannot downgrade *to* 80+80, so no need to consider 'tmp')
+	 */
+	if (ap->width == NL80211_CHAN_WIDTH_80P80 &&
+	    ap->center_freq2 < ap->center_freq1)
+		offset += 4;
+
+	return offset;
+}
+EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_calc_chandef_subchan_offset);
+
+VISIBLE_IF_MAC80211_KUNIT void
+ieee80211_rearrange_tpe_psd(struct ieee80211_parsed_tpe_psd *psd,
+			    const struct cfg80211_chan_def *ap,
+			    const struct cfg80211_chan_def *used)
+{
+	u8 needed = ieee80211_chandef_num_subchans(used);
+	u8 have = ieee80211_chandef_num_subchans(ap);
+	u8 tmp[IEEE80211_TPE_PSD_ENTRIES_320MHZ];
+	u8 offset;
+
+	if (!psd->valid)
+		return;
+
+	/* if N is zero, all defaults were used, no point in rearranging */
+	if (!psd->n)
+		goto out;
+
+	BUILD_BUG_ON(sizeof(tmp) != sizeof(psd->power));
+
+	/*
+	 * This assumes that 'N' is consistent with the HE channel, as
+	 * it should be (otherwise the AP is broken).
+	 *
+	 * In psd->power we have values in the order 0..N, 0..K, where
+	 * N+K should cover the entire channel per 'ap', but even if it
+	 * doesn't then we've pre-filled 'unlimited' as defaults.
+	 *
+	 * But this is all the wrong order, we want to have them in the
+	 * order of the 'used' channel.
+	 *
+	 * So for example, we could have a 320 MHz EHT AP, which has the
+	 * HE channel as 80 MHz (e.g. due to puncturing, which doesn't
+	 * seem to be considered for the TPE), as follows:
+	 *
+	 * EHT  320:   |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
+	 * HE    80:                           |  |  |  |  |
+	 * used 160:                           |  |  |  |  |  |  |  |  |
+	 *
+	 * N entries:                          |--|--|--|--|
+	 * K entries:  |--|--|--|--|--|--|--|--|           |--|--|--|--|
+	 * power idx:   4  5  6  7  8  9  10 11 0  1  2  3  12 13 14 15
+	 * full chan:   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
+	 * used chan:                           0  1  2  3  4  5  6  7
+	 *
+	 * The idx in the power array ('power idx') is this we since it
+	 * comes directly from the element's N and K entries in their
+	 * element order, and those are this way for HE compatibility.
+	 *
+	 * Rearrange them as desired here, first by putting them into the
+	 * 'full chan' order, and then selecting the necessary subset for
+	 * the 'used chan'.
+	 */
+
+	/* first reorder according to AP channel */
+	offset = ieee80211_calc_chandef_subchan_offset(ap, psd->n);
+	for (int i = 0; i < have; i++) {
+		if (i < offset)
+			tmp[i] = psd->power[i + psd->n];
+		else if (i < offset + psd->n)
+			tmp[i] = psd->power[i - offset];
+		else
+			tmp[i] = psd->power[i];
+	}
+
+	/*
+	 * and then select the subset for the used channel
+	 * (set everything to defaults first in case a driver is confused)
+	 */
+	memset(psd->power, IEEE80211_TPE_PSD_NO_LIMIT, sizeof(psd->power));
+	offset = ieee80211_calc_chandef_subchan_offset(ap, needed);
+	for (int i = 0; i < needed; i++)
+		psd->power[i] = tmp[offset + i];
+
+out:
+	/* limit, but don't lie if there are defaults in the data */
+	if (needed < psd->count)
+		psd->count = needed;
+}
+EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_rearrange_tpe_psd);
+
+static void ieee80211_rearrange_tpe(struct ieee80211_parsed_tpe *tpe,
+				    const struct cfg80211_chan_def *ap,
+				    const struct cfg80211_chan_def *used)
+{
+	/* ignore this completely for narrow/invalid channels */
+	if (!ieee80211_chandef_num_subchans(ap) ||
+	    !ieee80211_chandef_num_subchans(used)) {
+		ieee80211_clear_tpe(tpe);
+		return;
+	}
+
+	for (int i = 0; i < 2; i++) {
+		int needed_pwr_count;
+
+		ieee80211_rearrange_tpe_psd(&tpe->psd_local[i], ap, used);
+		ieee80211_rearrange_tpe_psd(&tpe->psd_reg_client[i], ap, used);
+
+		/* limit this to the widths we actually need */
+		needed_pwr_count = ieee80211_chandef_num_widths(used);
+		if (needed_pwr_count < tpe->max_local[i].count)
+			tpe->max_local[i].count = needed_pwr_count;
+		if (needed_pwr_count < tpe->max_reg_client[i].count)
+			tpe->max_reg_client[i].count = needed_pwr_count;
+	}
+}
+
 static struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
 			      struct cfg80211_bss *cbss, int link_id,
-			      struct ieee80211_chan_req *chanreq)
+			      struct ieee80211_chan_req *chanreq,
+			      struct cfg80211_chan_def *ap_chandef)
 {
 	const struct cfg80211_bss_ies *ies = rcu_dereference(cbss->ies);
 	struct ieee80211_bss *bss = (void *)cbss->priv;
@@ -624,7 +808,6 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	};
 	struct ieee802_11_elems *elems;
 	struct ieee80211_supported_band *sband;
-	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
 	int ret;
 
@@ -634,7 +817,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		return ERR_PTR(-ENOMEM);
 
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, bss->vht_cap_info,
-					      elems, false, conn, &ap_chandef);
+					      elems, false, conn, ap_chandef);
 
 	mlme_link_id_dbg(sdata, link_id, "determined AP %pM to be %s\n",
 			 cbss->bssid, ieee80211_conn_mode_str(ap_mode));
@@ -696,12 +879,12 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	}
 
 	conn->mode = ap_mode;
-	chanreq->oper = ap_chandef;
+	chanreq->oper = *ap_chandef;
 
 	/* wider-bandwidth OFDMA is only done in EHT */
 	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW))
-		chanreq->ap = ap_chandef;
+		chanreq->ap = *ap_chandef;
 	else
 		chanreq->ap.chan = NULL;
 
@@ -733,7 +916,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_BW_LIMIT_160);
 	}
 
-	if (chanreq->oper.width != ap_chandef.width || ap_mode != conn->mode)
+	if (chanreq->oper.width != ap_chandef->width || ap_mode != conn->mode)
 		sdata_info(sdata,
 			   "regulatory prevented using AP config, downgraded\n");
 
@@ -3268,9 +3451,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	sdata->vif.bss_conf.power_type = IEEE80211_REG_UNSET_AP;
 	sdata->vif.bss_conf.pwr_reduction = 0;
-	sdata->vif.bss_conf.tx_pwr_env_num = 0;
-	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
-	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
+	ieee80211_clear_tpe(&sdata->vif.bss_conf.tpe);
 
 	sdata->vif.cfg.eml_cap = 0;
 	sdata->vif.cfg.eml_med_sync_delay = 0;
@@ -5022,15 +5203,15 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	struct ieee80211_chan_req chanreq = {};
+	struct cfg80211_chan_def ap_chandef;
 	struct ieee802_11_elems *elems;
 	int ret;
-	u32 i;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rcu_read_lock();
 	elems = ieee80211_determine_chan_mode(sdata, conn, cbss, link_id,
-					      &chanreq);
+					      &chanreq, &ap_chandef);
 
 	if (IS_ERR(elems)) {
 		rcu_read_unlock();
@@ -5045,26 +5226,12 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (link && is_6ghz && conn->mode >= IEEE80211_CONN_MODE_HE) {
-		struct ieee80211_bss_conf *bss_conf;
-		u8 j = 0;
-
-		bss_conf = link->conf;
-
 		if (elems->pwr_constr_elem)
-			bss_conf->pwr_reduction = *elems->pwr_constr_elem;
+			link->conf->pwr_reduction = *elems->pwr_constr_elem;
 
-		BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
-			     ARRAY_SIZE(elems->tx_pwr_env));
-
-		for (i = 0; i < elems->tx_pwr_env_num; i++) {
-			if (elems->tx_pwr_env_len[i] > sizeof(bss_conf->tx_pwr_env[j]))
-				continue;
-
-			bss_conf->tx_pwr_env_num++;
-			memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
-			       elems->tx_pwr_env_len[i]);
-			j++;
-		}
+		link->conf->tpe = elems->tpe;
+		ieee80211_rearrange_tpe(&link->conf->tpe, &ap_chandef,
+					&chanreq.oper);
 	}
 	rcu_read_unlock();
 	/* the element data was RCU protected so no longer valid anyway */
@@ -7548,6 +7715,8 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	wiphy_delayed_work_init(&link->u.mgd.chswitch_work,
 				ieee80211_chswitch_work);
 
+	ieee80211_clear_tpe(&link->conf->tpe);
+
 	if (sdata->u.mgd.assoc_data)
 		ether_addr_copy(link->conf->addr,
 				sdata->u.mgd.assoc_data->link[link_id].addr);
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 55e5497f8978..de611aae2d65 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -187,6 +187,84 @@ ieee80211_parse_extension_element(u32 *crc,
 		*crc = crc32_be(*crc, (void *)elem, elem->datalen + 2);
 }
 
+static void ieee80211_parse_tpe(struct ieee802_11_elems *elems,
+				const u8 *data, u8 len)
+{
+	const struct ieee80211_tx_pwr_env *env = (const void *)data;
+	u8 count, interpret, category;
+	u8 *out, N, *cnt_out = NULL, *N_out = NULL;
+
+	if (!ieee80211_valid_tpe_element(data, len))
+		return;
+
+	count = u8_get_bits(env->info, IEEE80211_TX_PWR_ENV_INFO_COUNT);
+	interpret = u8_get_bits(env->info, IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+	category = u8_get_bits(env->info, IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
+
+	switch (interpret) {
+	case IEEE80211_TPE_LOCAL_EIRP:
+		out = elems->tpe.max_local[category].power;
+		cnt_out = &elems->tpe.max_local[category].count;
+		elems->tpe.max_local[category].valid = true;
+		break;
+	case IEEE80211_TPE_REG_CLIENT_EIRP:
+		out = elems->tpe.max_reg_client[category].power;
+		cnt_out = &elems->tpe.max_reg_client[category].count;
+		elems->tpe.max_reg_client[category].valid = true;
+		break;
+	case IEEE80211_TPE_LOCAL_EIRP_PSD:
+		out = elems->tpe.psd_local[category].power;
+		cnt_out = &elems->tpe.psd_local[category].count;
+		N_out = &elems->tpe.psd_local[category].n;
+		elems->tpe.psd_local[category].valid = true;
+		break;
+	case IEEE80211_TPE_REG_CLIENT_EIRP_PSD:
+		out = elems->tpe.psd_reg_client[category].power;
+		cnt_out = &elems->tpe.psd_reg_client[category].count;
+		N_out = &elems->tpe.psd_reg_client[category].n;
+		elems->tpe.psd_reg_client[category].valid = true;
+		break;
+	}
+
+	switch (interpret) {
+	case IEEE80211_TPE_LOCAL_EIRP:
+	case IEEE80211_TPE_REG_CLIENT_EIRP:
+		/* count was validated <= 3, plus 320 MHz */
+		BUILD_BUG_ON(IEEE80211_TPE_EIRP_ENTRIES_320MHZ < 5);
+		memcpy(out, env->variable, count + 1);
+		*cnt_out = count + 1;
+		/* separately take 320 MHz if present */
+		if (count == 3 && len > sizeof(*env) + count + 1) {
+			out[4] = env->variable[count + 2];
+			*cnt_out = 5;
+		}
+		break;
+	case IEEE80211_TPE_LOCAL_EIRP_PSD:
+	case IEEE80211_TPE_REG_CLIENT_EIRP_PSD:
+		if (!count) {
+			memset(out, env->variable[0],
+			       IEEE80211_TPE_PSD_ENTRIES_320MHZ);
+			*cnt_out = IEEE80211_TPE_PSD_ENTRIES_320MHZ;
+			break;
+		}
+
+		N = 1 << (count - 1);
+		memcpy(out, env->variable, N);
+		*cnt_out = N;
+		*N_out = N;
+
+		if (len > sizeof(*env) + N) {
+			int K = u8_get_bits(env->variable[N],
+					    IEEE80211_TX_PWR_ENV_EXT_COUNT);
+
+			K = min(K, IEEE80211_TPE_PSD_ENTRIES_320MHZ - N);
+			memcpy(out + N, env->variable + N + 1, K);
+			(*cnt_out) += K;
+		}
+		break;
+	}
+}
+
 static u32
 _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			     struct ieee80211_elems_parse *elems_parse,
@@ -593,16 +671,9 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elems->rsnx_len = elen;
 			break;
 		case WLAN_EID_TX_POWER_ENVELOPE:
-			if (elen < 1 ||
-			    elen > sizeof(struct ieee80211_tx_pwr_env))
+			if (params->mode < IEEE80211_CONN_MODE_HE)
 				break;
-
-			if (elems->tx_pwr_env_num >= ARRAY_SIZE(elems->tx_pwr_env))
-				break;
-
-			elems->tx_pwr_env[elems->tx_pwr_env_num] = (void *)pos;
-			elems->tx_pwr_env_len[elems->tx_pwr_env_num] = elen;
-			elems->tx_pwr_env_num++;
+			ieee80211_parse_tpe(elems, pos, elen);
 			break;
 		case WLAN_EID_EXTENSION:
 			ieee80211_parse_extension_element(calc_crc ?
@@ -889,6 +960,9 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	elems->ie_start = params->start;
 	elems->total_len = params->len;
 
+	/* set all TPE entries to unlimited (but invalid) */
+	ieee80211_clear_tpe(&elems->tpe);
+
 	nontransmitted_profile = elems_parse->scratch_pos;
 	nontransmitted_profile_len =
 		ieee802_11_find_bssid_profile(params->start, params->len,
diff --git a/net/mac80211/tests/Makefile b/net/mac80211/tests/Makefile
index 4fdaf3feaca3..511dfa226699 100644
--- a/net/mac80211/tests/Makefile
+++ b/net/mac80211/tests/Makefile
@@ -1,3 +1,3 @@
-mac80211-tests-y += module.o elems.o mfp.o
+mac80211-tests-y += module.o elems.o mfp.o tpe.o
 
 obj-$(CONFIG_MAC80211_KUNIT_TEST) += mac80211-tests.o
diff --git a/net/mac80211/tests/tpe.c b/net/mac80211/tests/tpe.c
new file mode 100644
index 000000000000..6f06a06d1860
--- /dev/null
+++ b/net/mac80211/tests/tpe.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for TPE element handling
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <kunit/test.h>
+#include "../ieee80211_i.h"
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static struct ieee80211_channel chan6g_1 = {
+	.band = NL80211_BAND_6GHZ,
+	.center_freq = 5955,
+};
+
+static struct ieee80211_channel chan6g_33 = {
+	.band = NL80211_BAND_6GHZ,
+	.center_freq = 6115,
+};
+
+static struct ieee80211_channel chan6g_61 = {
+	.band = NL80211_BAND_6GHZ,
+	.center_freq = 6255,
+};
+
+static const struct subchan_test_case {
+	const char *desc;
+	struct cfg80211_chan_def c;
+	u8 n;
+	int expect;
+} subchan_offset_cases[] = {
+	{
+		.desc = "identical 20 MHz",
+		.c.width = NL80211_CHAN_WIDTH_20,
+		.c.chan = &chan6g_1,
+		.c.center_freq1 = 5955,
+		.n = 1,
+		.expect = 0,
+	},
+	{
+		.desc = "identical 40 MHz",
+		.c.width = NL80211_CHAN_WIDTH_40,
+		.c.chan = &chan6g_1,
+		.c.center_freq1 = 5965,
+		.n = 2,
+		.expect = 0,
+	},
+	{
+		.desc = "identical 80+80 MHz",
+		/* not really is valid? doesn't matter for the test */
+		.c.width = NL80211_CHAN_WIDTH_80P80,
+		.c.chan = &chan6g_1,
+		.c.center_freq1 = 5985,
+		.c.center_freq2 = 6225,
+		.n = 16,
+		.expect = 0,
+	},
+	{
+		.desc = "identical 320 MHz",
+		.c.width = NL80211_CHAN_WIDTH_320,
+		.c.chan = &chan6g_1,
+		.c.center_freq1 = 6105,
+		.n = 16,
+		.expect = 0,
+	},
+	{
+		.desc = "lower 160 MHz of 320 MHz",
+		.c.width = NL80211_CHAN_WIDTH_320,
+		.c.chan = &chan6g_1,
+		.c.center_freq1 = 6105,
+		.n = 8,
+		.expect = 0,
+	},
+	{
+		.desc = "upper 160 MHz of 320 MHz",
+		.c.width = NL80211_CHAN_WIDTH_320,
+		.c.chan = &chan6g_61,
+		.c.center_freq1 = 6105,
+		.n = 8,
+		.expect = 8,
+	},
+	{
+		.desc = "upper 160 MHz of 320 MHz, go to 40",
+		.c.width = NL80211_CHAN_WIDTH_320,
+		.c.chan = &chan6g_61,
+		.c.center_freq1 = 6105,
+		.n = 2,
+		.expect = 8 + 4 + 2,
+	},
+	{
+		.desc = "secondary 80 above primary in 80+80 MHz",
+		/* not really is valid? doesn't matter for the test */
+		.c.width = NL80211_CHAN_WIDTH_80P80,
+		.c.chan = &chan6g_1,
+		.c.center_freq1 = 5985,
+		.c.center_freq2 = 6225,
+		.n = 4,
+		.expect = 0,
+	},
+	{
+		.desc = "secondary 80 below primary in 80+80 MHz",
+		/* not really is valid? doesn't matter for the test */
+		.c.width = NL80211_CHAN_WIDTH_80P80,
+		.c.chan = &chan6g_61,
+		.c.center_freq1 = 6225,
+		.c.center_freq2 = 5985,
+		.n = 4,
+		.expect = 4,
+	},
+	{
+		.desc = "secondary 80 below primary in 80+80 MHz, go to 20",
+		/* not really is valid? doesn't matter for the test */
+		.c.width = NL80211_CHAN_WIDTH_80P80,
+		.c.chan = &chan6g_61,
+		.c.center_freq1 = 6225,
+		.c.center_freq2 = 5985,
+		.n = 1,
+		.expect = 7,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(subchan_offset, subchan_offset_cases, desc);
+
+static void subchan_offset(struct kunit *test)
+{
+	const struct subchan_test_case *params = test->param_value;
+	int offset;
+
+	KUNIT_ASSERT_EQ(test, cfg80211_chandef_valid(&params->c), true);
+
+	offset = ieee80211_calc_chandef_subchan_offset(&params->c, params->n);
+
+	KUNIT_EXPECT_EQ(test, params->expect, offset);
+}
+
+static const struct psd_reorder_test_case {
+	const char *desc;
+	struct cfg80211_chan_def ap, used;
+	struct ieee80211_parsed_tpe_psd psd, out;
+} psd_reorder_cases[] = {
+	{
+		.desc = "no changes, 320 MHz",
+
+		.ap.width = NL80211_CHAN_WIDTH_320,
+		.ap.chan = &chan6g_1,
+		.ap.center_freq1 = 6105,
+
+		.used.width = NL80211_CHAN_WIDTH_320,
+		.used.chan = &chan6g_1,
+		.used.center_freq1 = 6105,
+
+		.psd.valid = true,
+		.psd.count = 16,
+		.psd.n = 8,
+		.psd.power = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+
+		.out.valid = true,
+		.out.count = 16,
+		.out.n = 8,
+		.out.power = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+	},
+	{
+		.desc = "320 MHz, HE is 80, used 160, all lower",
+
+		.ap.width = NL80211_CHAN_WIDTH_320,
+		.ap.chan = &chan6g_1,
+		.ap.center_freq1 = 6105,
+
+		.used.width = NL80211_CHAN_WIDTH_160,
+		.used.chan = &chan6g_1,
+		.used.center_freq1 = 6025,
+
+		.psd.valid = true,
+		.psd.count = 16,
+		.psd.n = 4,
+		.psd.power = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+
+		.out.valid = true,
+		.out.count = 8,
+		.out.n = 4,
+		.out.power = { 0, 1, 2, 3, 4, 5, 6, 7, 127, 127, 127, 127, 127, 127, 127, 127},
+	},
+	{
+		.desc = "320 MHz, HE is 80, used 160, all upper",
+		/*
+		 * EHT: | | | | | | | | | | | | | | | | |
+		 * HE:                          | | | | |
+		 * used:                | | | | | | | | |
+		 */
+
+		.ap.width = NL80211_CHAN_WIDTH_320,
+		.ap.chan = &chan6g_61,
+		.ap.center_freq1 = 6105,
+
+		.used.width = NL80211_CHAN_WIDTH_160,
+		.used.chan = &chan6g_61,
+		.used.center_freq1 = 6185,
+
+		.psd.valid = true,
+		.psd.count = 16,
+		.psd.n = 4,
+		.psd.power = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+
+		.out.valid = true,
+		.out.count = 8,
+		.out.n = 4,
+		.out.power = { 12, 13, 14, 15, 0, 1, 2, 3, 127, 127, 127, 127, 127, 127, 127, 127},
+	},
+	{
+		.desc = "320 MHz, HE is 80, used 160, split",
+		/*
+		 * EHT: | | | | | | | | | | | | | | | | |
+		 * HE:                  | | | | |
+		 * used:                | | | | | | | | |
+		 */
+
+		.ap.width = NL80211_CHAN_WIDTH_320,
+		.ap.chan = &chan6g_33,
+		.ap.center_freq1 = 6105,
+
+		.used.width = NL80211_CHAN_WIDTH_160,
+		.used.chan = &chan6g_33,
+		.used.center_freq1 = 6185,
+
+		.psd.valid = true,
+		.psd.count = 16,
+		.psd.n = 4,
+		.psd.power = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+
+		.out.valid = true,
+		.out.count = 8,
+		.out.n = 4,
+		.out.power = { 0, 1, 2, 3, 12, 13, 14, 15, 127, 127, 127, 127, 127, 127, 127, 127},
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(psd_reorder, psd_reorder_cases, desc);
+
+static void psd_reorder(struct kunit *test)
+{
+	const struct psd_reorder_test_case *params = test->param_value;
+	struct ieee80211_parsed_tpe_psd tmp = params->psd;
+
+	KUNIT_ASSERT_EQ(test, cfg80211_chandef_valid(&params->ap), true);
+	KUNIT_ASSERT_EQ(test, cfg80211_chandef_valid(&params->used), true);
+
+	ieee80211_rearrange_tpe_psd(&tmp, &params->ap, &params->used);
+	KUNIT_EXPECT_MEMEQ(test, &tmp, &params->out, sizeof(tmp));
+}
+
+static struct kunit_case tpe_test_cases[] = {
+	KUNIT_CASE_PARAM(subchan_offset, subchan_offset_gen_params),
+	KUNIT_CASE_PARAM(psd_reorder, psd_reorder_gen_params),
+	{}
+};
+
+static struct kunit_suite tpe = {
+	.name = "mac80211-tpe",
+	.test_cases = tpe_test_cases,
+};
+
+kunit_test_suite(tpe);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0b893e958959..721e4353ccdf 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4338,3 +4338,28 @@ ieee80211_min_bw_limit_from_chandef(struct cfg80211_chan_def *chandef)
 		return IEEE80211_CONN_BW_LIMIT_20;
 	}
 }
+
+void ieee80211_clear_tpe(struct ieee80211_parsed_tpe *tpe)
+{
+	for (int i = 0; i < 2; i++) {
+		tpe->max_local[i].valid = false;
+		memset(tpe->max_local[i].power,
+		       IEEE80211_TPE_MAX_TX_PWR_NO_CONSTRAINT,
+		       sizeof(tpe->max_local[i].power));
+
+		tpe->max_reg_client[i].valid = false;
+		memset(tpe->max_reg_client[i].power,
+		       IEEE80211_TPE_MAX_TX_PWR_NO_CONSTRAINT,
+		       sizeof(tpe->max_reg_client[i].power));
+
+		tpe->psd_local[i].valid = false;
+		memset(tpe->psd_local[i].power,
+		       IEEE80211_TPE_PSD_NO_LIMIT,
+		       sizeof(tpe->psd_local[i].power));
+
+		tpe->psd_reg_client[i].valid = false;
+		memset(tpe->psd_reg_client[i].power,
+		       IEEE80211_TPE_PSD_NO_LIMIT,
+		       sizeof(tpe->psd_reg_client[i].power));
+	}
+}
-- 
2.44.0


