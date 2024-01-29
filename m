Return-Path: <linux-wireless+bounces-2692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5488412AB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE8F1F2124F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CF13E204;
	Mon, 29 Jan 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZJPCFx3w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F99159584
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553692; cv=none; b=knowFUYZVDsvCHU0za4lbQ7cnI0dK1RBB2up8dkoRIk3wbv08M30j9cWMopOI8D8S2+G96rxFTe7iFDKYImF1qfVmerJ0jztUoQZFAN7x9QHFZotSaIKFEkrVSThWxGRTeAOnRnPtBVtWJiHFCqPjOTAHVD9Yho+AO/Gm8NM0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553692; c=relaxed/simple;
	bh=wduMx3sJco/Zole8MTUA57KjClFKayDnKiRX+L39xYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpFGMOeGHOVR8ZWt6EOseWeak1w9YTxzj5xc0XuF5SWYNPUPyXVsdbdRZUO2SdbioYBCM1qKGGolAw+pcz1Ub19lt1emzFkMUn8IjcqBob2UsQqCsL8UW4m7a8EGQ9M+udP5uMZNso7q9iX+DGHSsIXU4XmoxTnDmW3QWEeqRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZJPCFx3w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ldQyQMGdsDqt5Et/dSvVEbIIFq3mOLoDkuZMW3GsnHA=;
	t=1706553685; x=1707763285; b=ZJPCFx3whGPj0CbmzPDOwLw+eJS7qVvUyv4zkEHdSb+tt2Y
	hwHwMmv5n4j71rLkcpcekpkCLnuflOyO9bZubyPfdZ7/DHTPStQ5p4FND5xPjex1H1AtCdpIO8x1E
	MRSlI5b8VrdKdfHRhI/aNPY4OI68LSv8KtKS1A54Fz6Kv3dbY46At/4b0wfNhMmFim/WbB7pbEjYU
	5SFxUumgVWFwIEDKdXOAziqTtX26vXGvWM3vTl+BwByxyTwjsGq0wntXMKuDSagoa/poYzZp4qLTO
	eAcgmioIl2v1FpRGxJe+PRmUIUzL971ugQ+ikTFuBe5KxJzbHzHWaiQEDFNJ1zGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZP-00000004z9N-1DtA;
	Mon, 29 Jan 2024 19:41:23 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into chandef
Date: Mon, 29 Jan 2024 19:34:49 +0100
Message-ID: <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Aloka originally suggested that puncturing should be part of
the chandef, so that it's treated correctly. At the time, I
disagreed and it ended up not part of the chandef, but I've
now realized that this was wrong. Even for clients, the RX,
and perhaps more importantly, CCA configuration needs to take
puncturing into account.

Move puncturing into the chandef, and adjust all the code
accordingly. Also add a few tests for puncturing in chandef
compatibility checking.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  16 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   6 +-
 drivers/net/wireless/marvell/mwifiex/11h.c    |   2 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   5 +-
 include/net/cfg80211.h                        |  44 ++---
 include/net/mac80211.h                        |  11 +-
 net/mac80211/cfg.c                            |  21 +-
 net/mac80211/chan.c                           |  10 +-
 net/mac80211/link.c                           |   2 +-
 net/mac80211/mlme.c                           | 180 +++---------------
 net/mac80211/util.c                           |  26 ++-
 net/wireless/chan.c                           |  62 +++---
 net/wireless/nl80211.c                        |  67 +++----
 net/wireless/tests/chan.c                     |  48 ++++-
 net/wireless/trace.h                          |  38 ++--
 17 files changed, 222 insertions(+), 320 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index e37db4af33de..61b2e3f15f0e 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1119,7 +1119,7 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
 					NL80211_CHAN_HT20 : NL80211_CHAN_NO_HT);
 
 	wiphy_lock(vif->ar->wiphy);
-	cfg80211_ch_switch_notify(vif->ndev, &chandef, 0, 0);
+	cfg80211_ch_switch_notify(vif->ndev, &chandef, 0);
 	wiphy_unlock(vif->ar->wiphy);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index be48b0fc9cb6..0f2d8be1c222 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 - 2023 Intel Corporation
+ * Copyright (C) 2022 - 2024 Intel Corporation
  */
 #include "mvm.h"
 #include "time-event.h"
@@ -190,12 +190,20 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	}
 
 	if (changes & LINK_CONTEXT_MODIFY_EHT_PARAMS) {
+		struct ieee80211_chanctx_conf *ctx;
+		struct cfg80211_chan_def *def = NULL;
+
+		rcu_read_lock();
+		ctx = rcu_dereference(link_conf->chanctx_conf);
+		if (ctx)
+			def = &ctx->def;
+
 		if (iwlwifi_mod_params.disable_11be ||
-		    !link_conf->eht_support)
+		    !link_conf->eht_support || !def)
 			changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
 		else
-			cmd.puncture_mask =
-				cpu_to_le16(link_conf->eht_puncturing);
+			cmd.puncture_mask = cpu_to_le16(def->punctured);
+		rcu_read_unlock();
 	}
 
 	cmd.bss_color = link_conf->he_bss_color.color;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index c7cbbee3e464..a62e105fb373 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022-2023 Intel Corporation
+ * Copyright (C) 2022-2024 Intel Corporation
  */
 #include "mvm.h"
 
@@ -749,8 +749,8 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
 	}
 
-	/* Update EHT Puncturing info */
-	if (changes & BSS_CHANGED_EHT_PUNCTURING && vif->cfg.assoc)
+	/* if associated, maybe puncturing changed - we'll check later */
+	if (vif->cfg.assoc)
 		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
 
 	if (link_changes) {
diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index da211372a481..b90f922f1cdc 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -288,6 +288,6 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	mwifiex_dbg(priv->adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
 	wiphy_lock(priv->wdev.wiphy);
-	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0, 0);
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
 	wiphy_unlock(priv->wdev.wiphy);
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 3b283e93a13e..76b07db284f8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -478,7 +478,7 @@ qtnf_event_handle_freq_change(struct qtnf_wmac *mac,
 			continue;
 
 		wiphy_lock(priv_to_wiphy(vif->mac));
-		cfg80211_ch_switch_notify(vif->netdev, &chandef, 0, 0);
+		cfg80211_ch_switch_notify(vif->netdev, &chandef, 0);
 		wiphy_unlock(priv_to_wiphy(vif->mac));
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e49360e29faf..876c8d581759 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2495,8 +2495,11 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	}
 
 	if (vif->bss_conf.eht_support) {
-		h2c->w4 |= le32_encode_bits(~vif->bss_conf.eht_puncturing,
+		u16 punct = vif->bss_conf.chanreq.oper.punctured;
+
+		h2c->w4 |= le32_encode_bits(~punct,
 					    CCTLINFO_G7_W4_ACT_SUBCH_CBW);
+		rcu_read_unlock();
 		h2c->m4 |= cpu_to_le32(CCTLINFO_G7_W4_ACT_SUBCH_CBW);
 	}
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d7333064866..965787d54e3a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7,7 +7,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014 Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/ethtool.h>
@@ -808,6 +808,9 @@ struct key_params {
  *	chan will define the primary channel and all other
  *	parameters are ignored.
  * @freq1_offset: offset from @center_freq1, in KHz
+ * @punctured: mask of the punctured 20 MHz subchannels, with
+ *	bits turned on being disabled (punctured); numbered
+ *	from lower to higher frequency (like in the spec)
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -816,6 +819,7 @@ struct cfg80211_chan_def {
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
+	u16 punctured;
 };
 
 /*
@@ -956,7 +960,8 @@ cfg80211_chandef_identical(const struct cfg80211_chan_def *chandef1,
 		chandef1->width == chandef2->width &&
 		chandef1->center_freq1 == chandef2->center_freq1 &&
 		chandef1->freq1_offset == chandef2->freq1_offset &&
-		chandef1->center_freq2 == chandef2->center_freq2);
+		chandef1->center_freq2 == chandef2->center_freq2 &&
+		chandef1->punctured == chandef2->punctured);
 }
 
 /**
@@ -1051,12 +1056,15 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
  * cfg80211_chandef_primary_freq - calculate primary 40/80/160 MHz freq
  * @chandef: chandef to calculate for
  * @primary_chan_width: primary channel width to calculate center for
+ * @punctured: punctured sub-channel bitmap, will be recalculated
+ *	according to the new bandwidth, can be %NULL
  *
  * Returns: the primary 40/80/160 MHz channel center frequency, or -1
- *	for errors
+ *	for errors, updating the punctured bitmap
  */
-int cfg80211_chandef_primary_freq(const struct cfg80211_chan_def *chandef,
-				  enum nl80211_chan_width primary_chan_width);
+int cfg80211_chandef_primary(const struct cfg80211_chan_def *chandef,
+			     enum nl80211_chan_width primary_chan_width,
+			     u16 *punctured);
 
 /**
  * nl80211_send_chandef - sends the channel definition.
@@ -1468,9 +1476,6 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
- * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
- *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
- *	Bit set to 1 indicates that the channel is punctured.
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1505,7 +1510,6 @@ struct cfg80211_ap_settings {
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
-	u16 punct_bitmap;
 };
 
 
@@ -1539,9 +1543,6 @@ struct cfg80211_ap_update {
  * @radar_required: whether radar detection is required on the new channel
  * @block_tx: whether transmissions should be blocked while changing
  * @count: number of beacons until switch
- * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
- *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
- *	Bit set to 1 indicates that the channel is punctured.
  */
 struct cfg80211_csa_settings {
 	struct cfg80211_chan_def chandef;
@@ -1554,7 +1555,6 @@ struct cfg80211_csa_settings {
 	bool radar_required;
 	bool block_tx;
 	u8 count;
-	u16 punct_bitmap;
 };
 
 /**
@@ -8734,14 +8734,13 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
  * @dev: the device which switched channels
  * @chandef: the new channel definition
  * @link_id: the link ID for MLO, must be 0 for non-MLO
- * @punct_bitmap: the new puncturing bitmap
  *
  * Caller must hold wiphy mutex, therefore must only be called from sleepable
  * driver context!
  */
 void cfg80211_ch_switch_notify(struct net_device *dev,
 			       struct cfg80211_chan_def *chandef,
-			       unsigned int link_id, u16 punct_bitmap);
+			       unsigned int link_id);
 
 /*
  * cfg80211_ch_switch_started_notify - notify channel switch start
@@ -8750,7 +8749,6 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @count: the number of TBTTs until the channel switch happens
  * @quiet: whether or not immediate quiet was requested by the AP
- * @punct_bitmap: the future puncturing bitmap
  *
  * Inform the userspace about the channel switch that has just
  * started, so that it can take appropriate actions (eg. starting
@@ -8759,7 +8757,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet, u16 punct_bitmap);
+				       bool quiet);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
@@ -9377,18 +9375,6 @@ static inline int cfg80211_color_change_notify(struct net_device *dev)
 					 0, 0);
 }
 
-/**
- * cfg80211_valid_disable_subchannel_bitmap - validate puncturing bitmap
- * @bitmap: bitmap to be validated
- * @chandef: channel definition
- *
- * Validate the puncturing bitmap.
- *
- * Return: %true if the bitmap is valid. %false otherwise.
- */
-bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
-					      const struct cfg80211_chan_def *chandef);
-
 /**
  * cfg80211_links_removed - Notify about removed STA MLD setup links.
  * @dev: network device.
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ab6bc89d3394..54aa4a06c878 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -216,6 +216,8 @@ struct ieee80211_low_level_stats {
  * @IEEE80211_CHANCTX_CHANGE_MIN_WIDTH: The min required channel width changed
  * @IEEE80211_CHANCTX_CHANGE_AP: The AP channel definition changed, so (wider
  *	bandwidth) OFDMA settings need to be changed
+ * @IEEE80211_CHANCTX_CHANGE_PUNCTURING: The punctured channel(s) bitmap
+ *	was changed.
  */
 enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_WIDTH		= BIT(0),
@@ -224,6 +226,7 @@ enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_CHANNEL	= BIT(3),
 	IEEE80211_CHANCTX_CHANGE_MIN_WIDTH	= BIT(4),
 	IEEE80211_CHANCTX_CHANGE_AP		= BIT(5),
+	IEEE80211_CHANCTX_CHANGE_PUNCTURING	= BIT(6),
 };
 
 /**
@@ -357,7 +360,6 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
  * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
  *	status changed.
- * @BSS_CHANGED_EHT_PUNCTURING: The channel puncturing bitmap changed.
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
  * @BSS_CHANGED_MLD_TTLM: TID to link mapping was changed
  */
@@ -394,7 +396,6 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
-	BSS_CHANGED_EHT_PUNCTURING	= BIT_ULL(32),
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 
@@ -661,9 +662,7 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
- * @eht_puncturing: bitmap to indicate which channels are punctured in this BSS
  * @csa_active: marks whether a channel switch is going on.
- * @csa_punct_bitmap: new puncturing bitmap for channel switch
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
  *	when it is not assigned. This pointer is RCU-protected due to the TX
@@ -766,10 +765,8 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
-	u16 eht_puncturing;
 
 	bool csa_active;
-	u16 csa_punct_bitmap;
 
 	bool mu_mimo_owner;
 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 400abed929f4..e006d59087e7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1339,8 +1339,6 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		link_conf->eht_support = true;
-		link_conf->eht_puncturing = params->punct_bitmap;
-		changed |= BSS_CHANGED_EHT_PUNCTURING;
 
 		link_conf->eht_su_beamformer =
 			params->eht_cap->fixed.phy_cap_info[0] &
@@ -3666,12 +3664,6 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	if (err)
 		return err;
 
-	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
-		sdata->vif.bss_conf.eht_puncturing =
-					sdata->vif.bss_conf.csa_punct_bitmap;
-		changed |= BSS_CHANGED_EHT_PUNCTURING;
-	}
-
 	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
 	if (link_data->csa_block_tx) {
@@ -3685,8 +3677,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		return err;
 
 	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chanreq.oper,
-				  link_data->link_id,
-				  link_data->conf->eht_puncturing);
+				  link_data->link_id);
 
 	return 0;
 }
@@ -3887,6 +3878,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				       &sdata->vif.bss_conf.chanreq.oper))
 		return -EINVAL;
 
+	if (chanreq.oper.punctured && !sdata->vif.bss_conf.eht_support)
+		return -EINVAL;
+
 	/* don't allow another channel switch if one is already active. */
 	if (sdata->vif.bss_conf.csa_active)
 		return -EBUSY;
@@ -3939,13 +3933,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	if (params->punct_bitmap && !sdata->vif.bss_conf.eht_support)
-		goto out;
-
 	sdata->deflink.csa_chanreq = chanreq; 
 	sdata->deflink.csa_block_tx = params->block_tx;
 	sdata->vif.bss_conf.csa_active = true;
-	sdata->vif.bss_conf.csa_punct_bitmap = params->punct_bitmap;
 
 	if (sdata->deflink.csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
@@ -3953,8 +3943,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &sdata->deflink.csa_chanreq.oper, 0,
-					  params->count, params->block_tx,
-					  sdata->vif.bss_conf.csa_punct_bitmap);
+					  params->count, params->block_tx);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 0d7944a9d3a6..9aba0a3a8eb4 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211 - channel management
- * Copyright 2020 - 2022 Intel Corporation
+ * Copyright 2020 - 2024 Intel Corporation
  */
 
 #include <linux/nl80211.h>
@@ -517,8 +517,12 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	ieee80211_remove_wbrf(local, &ctx->conf.def);
 
-	if (!cfg80211_chandef_identical(&ctx->conf.def, &chanreq->oper))
-		changed |= IEEE80211_CHANCTX_CHANGE_WIDTH;
+	if (!cfg80211_chandef_identical(&ctx->conf.def, &chanreq->oper)) {
+		if (ctx->conf.def.width != chanreq->oper.width)
+			changed |= IEEE80211_CHANCTX_CHANGE_WIDTH;
+		if (ctx->conf.def.punctured != chanreq->oper.punctured)
+			changed |= IEEE80211_CHANCTX_CHANGE_PUNCTURING;
+	}
 	if (!cfg80211_chandef_identical(&ctx->conf.ap, &chanreq->ap))
 		changed |= IEEE80211_CHANCTX_CHANGE_AP;
 	ctx->conf.def = *chandef;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 070f536acd76..79bda7184fe8 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -2,7 +2,7 @@
 /*
  * MLO link handling
  *
- * Copyright (C) 2022-2023 Intel Corporation
+ * Copyright (C) 2022-2024 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 03919bb36e2d..64367cb141ca 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -93,83 +93,6 @@ MODULE_PARM_DESC(probe_wait_ms,
  */
 #define IEEE80211_SIGNAL_AVE_MIN_COUNT	4
 
-/*
- * Extract from the given disabled subchannel bitmap (raw format
- * from the EHT Operation Element) the bits for the subchannel
- * we're using right now.
- */
-static u16
-ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
-				 struct cfg80211_chan_def *chandef, u16 bitmap)
-{
-	struct ieee80211_eht_operation_info *info = (void *)eht_oper->optional;
-	struct cfg80211_chan_def ap_chandef = *chandef;
-	u32 ap_center_freq, local_center_freq;
-	u32 ap_bw, local_bw;
-	int ap_start_freq, local_start_freq;
-	u16 shift, mask;
-
-	if (!(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) ||
-	    !(eht_oper->params &
-	      IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
-		return 0;
-
-	/* set 160/320 supported to get the full AP definition */
-	ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
-				   &ap_chandef);
-	ap_center_freq = ap_chandef.center_freq1;
-	ap_bw = 20 * BIT(u8_get_bits(info->control,
-				     IEEE80211_EHT_OPER_CHAN_WIDTH));
-	ap_start_freq = ap_center_freq - ap_bw / 2;
-	local_center_freq = chandef->center_freq1;
-	local_bw = 20 * BIT(ieee80211_chan_width_to_rx_bw(chandef->width));
-	local_start_freq = local_center_freq - local_bw / 2;
-	shift = (local_start_freq - ap_start_freq) / 20;
-	mask = BIT(local_bw / 20) - 1;
-
-	return (bitmap >> shift) & mask;
-}
-
-/*
- * Handle the puncturing bitmap, possibly downgrading bandwidth to get a
- * valid bitmap.
- */
-static void
-ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
-				   const struct ieee80211_eht_operation *eht_oper,
-				   u16 bitmap, u64 *changed)
-{
-	struct cfg80211_chan_def *chandef = &link->conf->chanreq.oper;
-	struct ieee80211_local *local = link->sdata->local;
-	u16 extracted;
-	u64 _changed = 0;
-
-	if (!changed)
-		changed = &_changed;
-
-	while (chandef->width > NL80211_CHAN_WIDTH_40) {
-		extracted =
-			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
-							 bitmap);
-
-		if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-							     chandef) &&
-		    !(bitmap && ieee80211_hw_check(&local->hw,
-						   DISALLOW_PUNCTURING)))
-			break;
-		ieee80211_chandef_downgrade(chandef, &link->u.mgd.conn);
-		*changed |= BSS_CHANGED_BANDWIDTH;
-	}
-
-	if (chandef->width <= NL80211_CHAN_WIDTH_40)
-		extracted = 0;
-
-	if (link->conf->eht_puncturing != extracted) {
-		link->conf->eht_puncturing = extracted;
-		*changed |= BSS_CHANGED_EHT_PUNCTURING;
-	}
-}
-
 /*
  * We can have multiple work items (and connection probing)
  * scheduling this timer, but we need to take care to only
@@ -396,6 +319,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
 					   &eht_chandef);
 
+		eht_chandef.punctured =
+			ieee80211_eht_oper_dis_subchan_bitmap(eht_oper);
+
 		if (!cfg80211_chandef_valid(&eht_chandef)) {
 			sdata_info(sdata,
 				   "AP EHT information is invalid, disabling EHT\n");
@@ -661,13 +587,27 @@ ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
 	return true;
 }
 
+static bool ieee80211_chandef_usable(struct ieee80211_sub_if_data *sdata,
+				     const struct cfg80211_chan_def *chandef,
+				     u32 prohibited_flags)
+{
+	if (!cfg80211_chandef_usable(sdata->local->hw.wiphy,
+				     chandef, prohibited_flags))
+		return false;
+
+	if (chandef->punctured &&
+	    ieee80211_hw_check(&sdata->local->hw, DISALLOW_PUNCTURING))
+		return false;
+
+	return true;
+}
+
 static struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
 			      struct cfg80211_bss *cbss, int link_id,
 			      struct ieee80211_chan_req *chanreq)
 {
-	struct ieee80211_local *local = sdata->local;
 	const struct cfg80211_bss_ies *ies = rcu_dereference(cbss->ies);
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct ieee80211_channel *channel = cbss->channel;
@@ -761,8 +701,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	else
 		chanreq->ap.chan = NULL;
 
-	while (!cfg80211_chandef_usable(sdata->local->hw.wiphy, &chanreq->oper,
-					IEEE80211_CHAN_DISABLED)) {
+	while (!ieee80211_chandef_usable(sdata, &chanreq->oper,
+					 IEEE80211_CHAN_DISABLED)) {
 		if (WARN_ON(chanreq->oper.width == NL80211_CHAN_WIDTH_20_NOHT)) {
 			ret = -EINVAL;
 			goto free;
@@ -812,30 +752,6 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		sdata_info(sdata, "required MCSes not supported, disabling EHT\n");
 	}
 
-	if (conn->mode >= IEEE80211_CONN_MODE_EHT) {
-		u16 bitmap;
-
-		if (WARN_ON_ONCE(!elems->eht_operation)) {
-			ret = -EINVAL;
-			goto free;
-		}
-
-		bitmap = ieee80211_eht_oper_dis_subchan_bitmap(elems->eht_operation);
-
-		if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-							      &ap_chandef) ||
-		    (bitmap &&
-		     ieee80211_hw_check(&local->hw, DISALLOW_PUNCTURING))) {
-			conn->mode = IEEE80211_CONN_MODE_HE;
-			conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
-					       conn->bw_limit,
-					       IEEE80211_CONN_BW_LIMIT_160);
-			sdata_info(sdata,
-				   "AP has invalid/unsupported puncturing, disabling EHT\n");
-		}
-		/* FIXME: store puncturing bitmap */
-	}
-
 	/* the mode can only decrease, so this must terminate */
 	if (ap_mode != conn->mode)
 		goto again;
@@ -2127,7 +2043,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	}
 
 	cfg80211_ch_switch_notify(sdata->dev, &link->reserved.oper,
-				  link->link_id, 0);
+				  link->link_id);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
@@ -2330,7 +2246,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
 					  link->link_id, csa_ie.count,
-					  csa_ie.mode, 0);
+					  csa_ie.mode);
 
 	if (local->ops->channel_switch) {
 		/* use driver's channel switch callback */
@@ -3393,8 +3309,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.u.mgd.tracking_signal_avg = false;
 	sdata->deflink.u.mgd.disable_wmm_tracking = false;
 
-	sdata->vif.bss_conf.eht_puncturing = 0;
-
 	ifmgd->flags = 0;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
@@ -4624,7 +4538,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 							    link_sta);
 
 			bss_conf->eht_support = link_sta->pub->eht_cap.has_eht;
-			*changed |= BSS_CHANGED_EHT_PUNCTURING;
 		} else {
 			bss_conf->eht_support = false;
 		}
@@ -5867,40 +5780,6 @@ static bool ieee80211_rx_our_beacon(const u8 *tx_bssid,
 	return ether_addr_equal(tx_bssid, bss->transmitted_bss->bssid);
 }
 
-static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
-					const struct ieee80211_eht_operation *eht_oper,
-					u64 *changed)
-{
-	struct ieee80211_local *local = link->sdata->local;
-	u16 bitmap, extracted;
-
-	bitmap = ieee80211_eht_oper_dis_subchan_bitmap(eht_oper);
-	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
-						     &link->conf->chanreq.oper,
-						     bitmap);
-
-	/* accept if there are no changes */
-	if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
-	    extracted == link->conf->eht_puncturing)
-		return true;
-
-	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-						      &link->conf->chanreq.oper)) {
-		link_info(link,
-			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
-			  link->u.mgd.bssid,
-			  bitmap,
-			  link->conf->chanreq.oper.width);
-		return false;
-	}
-
-	if (bitmap && ieee80211_hw_check(&local->hw, DISALLOW_PUNCTURING))
-		return false;
-
-	ieee80211_handle_puncturing_bitmap(link, eht_oper, bitmap, changed);
-	return true;
-}
-
 static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 				     struct wiphy_work *work)
 {
@@ -6616,21 +6495,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 					       elems->pwr_constr_elem,
 					       elems->cisco_dtpc_elem);
 
-	if (elems->eht_operation &&
-	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_EHT) {
-		if (!ieee80211_config_puncturing(link, elems->eht_operation,
-						 &changed)) {
-			ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-					       WLAN_REASON_DEAUTH_LEAVING,
-					       true, deauth_buf);
-			ieee80211_report_disconnect(sdata, deauth_buf,
-						    sizeof(deauth_buf), true,
-						    WLAN_REASON_DEAUTH_LEAVING,
-						    false);
-			goto free;
-		}
-	}
-
 	ieee80211_ml_reconfiguration(sdata, elems);
 	ieee80211_process_adv_ttlm(sdata, elems,
 				      le64_to_cpu(mgmt->u.beacon.timestamp));
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 63a88169d53d..5108dbaa9360 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -2810,9 +2810,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				    sdata->vif.bss_conf.protected_keep_alive)
 					changed |= BSS_CHANGED_KEEP_ALIVE;
 
-				if (sdata->vif.bss_conf.eht_puncturing)
-					changed |= BSS_CHANGED_EHT_PUNCTURING;
-
 				ieee80211_bss_info_change_notify(sdata,
 								 changed);
 			} else if (!WARN_ON(!link)) {
@@ -4365,14 +4362,17 @@ EXPORT_SYMBOL(ieee80211_radar_detected);
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 				 struct ieee80211_conn_settings *conn)
 {
-	/* no-HT indicates nothing to do */
-	enum nl80211_chan_width new_primary_width = NL80211_CHAN_WIDTH_20_NOHT;
+	enum nl80211_chan_width new_primary_width;
 	struct ieee80211_conn_settings _ignored = {};
 
 	/* allow passing NULL if caller doesn't care */
 	if (!conn)
 		conn = &_ignored;
 
+again:
+	/* no-HT indicates nothing to do */
+	new_primary_width = NL80211_CHAN_WIDTH_20_NOHT;
+
 	switch (c->width) {
 	default:
 	case NL80211_CHAN_WIDTH_20_NOHT:
@@ -4382,6 +4382,7 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 		c->width = NL80211_CHAN_WIDTH_20_NOHT;
 		conn->mode = IEEE80211_CONN_MODE_LEGACY;
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		c->punctured = 0;
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		c->width = NL80211_CHAN_WIDTH_20;
@@ -4389,6 +4390,7 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 		if (conn->mode == IEEE80211_CONN_MODE_VHT)
 			conn->mode = IEEE80211_CONN_MODE_HT;
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		c->punctured = 0;
 		break;
 	case NL80211_CHAN_WIDTH_80:
 		new_primary_width = NL80211_CHAN_WIDTH_40;
@@ -4429,11 +4431,19 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 	}
 
 	if (new_primary_width != NL80211_CHAN_WIDTH_20_NOHT) {
-		c->center_freq1 =
-			cfg80211_chandef_primary_freq(c, new_primary_width);
+		c->center_freq1 = cfg80211_chandef_primary(c, new_primary_width,
+							   &c->punctured);
 		c->width = new_primary_width;
 	}
 
+	/*
+	 * With an 80 MHz channel, we might have the puncturing in the primary
+	 * 40 Mhz channel, but that's not valid when downgraded to 40 MHz width.
+	 * In that case, downgrade again.
+	 */
+	if (!cfg80211_chandef_valid(c) && c->punctured)
+		goto again;
+
 	WARN_ON_ONCE(!cfg80211_chandef_valid(c));
 }
 
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index bfa2ea935fc2..e2ce89afa9ff 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018-2023	Intel Corporation
+ * Copyright 2018-2024	Intel Corporation
  */
 
 #include <linux/export.h>
@@ -27,11 +27,10 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 	if (WARN_ON(!chan))
 		return;
 
-	chandef->chan = chan;
-	chandef->freq1_offset = chan->freq_offset;
-	chandef->center_freq2 = 0;
-	chandef->edmg.bw_config = 0;
-	chandef->edmg.channels = 0;
+	*chandef = (struct cfg80211_chan_def) {
+		.chan = chan,
+		.freq1_offset = chan->freq_offset,
+	};
 
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
@@ -87,10 +86,9 @@ static const struct cfg80211_per_bw_puncturing_values per_bw_puncturing[] = {
 	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(320)
 };
 
-bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
-					      const struct cfg80211_chan_def *chandef)
+static bool valid_puncturing_bitmap(const struct cfg80211_chan_def *chandef)
 {
-	u32 idx, i, start_freq;
+	u32 idx, i, start_freq, primary_center = chandef->chan->center_freq;
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_80:
@@ -106,24 +104,23 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
 		start_freq = chandef->center_freq1 - 160;
 		break;
 	default:
-		*bitmap = 0;
-		break;
+		return chandef->punctured == 0;
 	}
 
-	if (!*bitmap)
+	if (!chandef->punctured)
 		return true;
 
 	/* check if primary channel is punctured */
-	if (*bitmap & (u16)BIT((chandef->chan->center_freq - start_freq) / 20))
+	if (chandef->punctured & (u16)BIT((primary_center - start_freq) / 20))
 		return false;
 
-	for (i = 0; i < per_bw_puncturing[idx].len; i++)
-		if (per_bw_puncturing[idx].valid_values[i] == *bitmap)
+	for (i = 0; i < per_bw_puncturing[idx].len; i++) {
+		if (per_bw_puncturing[idx].valid_values[i] == chandef->punctured)
 			return true;
+	}
 
 	return false;
 }
-EXPORT_SYMBOL(cfg80211_valid_disable_subchannel_bitmap);
 
 static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
@@ -386,17 +383,19 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	    !cfg80211_edmg_chandef_valid(chandef))
 		return false;
 
-	return true;
+	return valid_puncturing_bitmap(chandef);
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
 
-int cfg80211_chandef_primary_freq(const struct cfg80211_chan_def *c,
-				  enum nl80211_chan_width primary_chan_width)
+int cfg80211_chandef_primary(const struct cfg80211_chan_def *c,
+			     enum nl80211_chan_width primary_chan_width,
+			     u16 *punctured)
 {
 	int pri_width = nl80211_chan_width_to_mhz(primary_chan_width);
 	int width = cfg80211_chandef_get_width(c);
 	u32 control = c->chan->center_freq;
 	u32 center = c->center_freq1;
+	u16 _punct = 0;
 
 	if (WARN_ON_ONCE(pri_width < 0 || width < 0))
 		return -1;
@@ -405,26 +404,41 @@ int cfg80211_chandef_primary_freq(const struct cfg80211_chan_def *c,
 	if (WARN_ON_ONCE(pri_width > width))
 		return -1;
 
+	if (!punctured)
+		punctured = &_punct;
+
+	*punctured = c->punctured;
+
 	while (width > pri_width) {
-		if (control > center)
+		unsigned int bits_to_drop = width / 20 / 2;
+
+		if (control > center) {
 			center += width / 4;
-		else
+			*punctured >>= bits_to_drop;
+		} else {
 			center -= width / 4;
+			*punctured &= (1 << bits_to_drop) - 1;
+		}
 		width /= 2;
 	}
 
 	return center;
 }
-EXPORT_SYMBOL(cfg80211_chandef_primary_freq);
+EXPORT_SYMBOL(cfg80211_chandef_primary);
 
 static const struct cfg80211_chan_def *
 check_chandef_primary_compat(const struct cfg80211_chan_def *c1,
 			     const struct cfg80211_chan_def *c2,
 			     enum nl80211_chan_width primary_chan_width)
 {
+	u16 punct_c1 = 0, punct_c2 = 0;
+
 	/* check primary is compatible -> error if not */
-	if (cfg80211_chandef_primary_freq(c1, primary_chan_width) !=
-	    cfg80211_chandef_primary_freq(c2, primary_chan_width))
+	if (cfg80211_chandef_primary(c1, primary_chan_width, &punct_c1) !=
+	    cfg80211_chandef_primary(c2, primary_chan_width, &punct_c2))
+		return ERR_PTR(-EINVAL);
+
+	if (punct_c1 != punct_c2)
 		return ERR_PTR(-EINVAL);
 
 	/* assumes c1 is smaller width, if that was just checked -> done */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e4f41f86e295..1331e39da0e6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3214,21 +3214,6 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 		wdev->iftype == NL80211_IFTYPE_P2P_GO;
 }
 
-static int nl80211_parse_punct_bitmap(struct cfg80211_registered_device *rdev,
-				      struct genl_info *info,
-				      const struct cfg80211_chan_def *chandef,
-				      u16 *punct_bitmap)
-{
-	if (!wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_PUNCT))
-		return -EINVAL;
-
-	*punct_bitmap = nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
-	if (!cfg80211_valid_disable_subchannel_bitmap(punct_bitmap, chandef))
-		return -EINVAL;
-
-	return 0;
-}
-
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
 			  struct cfg80211_chan_def *chandef)
@@ -3336,6 +3321,19 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		chandef->edmg.channels = 0;
 	}
 
+	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
+		chandef->punctured =
+			nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
+
+		if (chandef->punctured &&
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_PUNCT)) {
+			NL_SET_ERR_MSG(extack,
+				       "driver doesn't support puncturing");
+			return -EINVAL;
+		}
+	}
+
 	if (!cfg80211_chandef_valid(chandef)) {
 		NL_SET_ERR_MSG(extack, "invalid channel definition");
 		return -EINVAL;
@@ -3812,6 +3810,10 @@ int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *ch
 	if (chandef->center_freq2 &&
 	    nla_put_u32(msg, NL80211_ATTR_CENTER_FREQ2, chandef->center_freq2))
 		return -ENOBUFS;
+	if (chandef->punctured &&
+	    nla_put_u32(msg, NL80211_ATTR_PUNCT_BITMAP, chandef->punctured))
+		return -ENOBUFS;
+
 	return 0;
 }
 EXPORT_SYMBOL(nl80211_send_chandef);
@@ -6057,14 +6059,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
-		err = nl80211_parse_punct_bitmap(rdev, info,
-						 &params->chandef,
-						 &params->punct_bitmap);
-		if (err)
-			goto out;
-	}
-
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params->chandef,
 					   wdev->iftype)) {
 		err = -EINVAL;
@@ -10224,14 +10218,6 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
-	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
-		err = nl80211_parse_punct_bitmap(rdev, info,
-						 &params.chandef,
-						 &params.punct_bitmap);
-		if (err)
-			goto free;
-	}
-
 	err = rdev_channel_switch(rdev, dev, &params);
 
 free:
@@ -19362,7 +19348,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
-				     u8 count, bool quiet, u16 punct_bitmap)
+				     u8 count, bool quiet)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct sk_buff *msg;
@@ -19396,9 +19382,6 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
-	if (nla_put_u32(msg, NL80211_ATTR_PUNCT_BITMAP, punct_bitmap))
-		goto nla_put_failure;
-
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
@@ -19411,7 +19394,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 
 void cfg80211_ch_switch_notify(struct net_device *dev,
 			       struct cfg80211_chan_def *chandef,
-			       unsigned int link_id, u16 punct_bitmap)
+			       unsigned int link_id)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19420,7 +19403,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	lockdep_assert_wiphy(wdev->wiphy);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_notify(dev, chandef, link_id, punct_bitmap);
+	trace_cfg80211_ch_switch_notify(dev, chandef, link_id);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
@@ -19449,15 +19432,14 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false,
-				 punct_bitmap);
+				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet, u16 punct_bitmap)
+				       bool quiet)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19466,13 +19448,12 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 	lockdep_assert_wiphy(wdev->wiphy);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id,
-						punct_bitmap);
+	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id);
 
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
-				 count, quiet, punct_bitmap);
+				 count, quiet);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
diff --git a/net/wireless/tests/chan.c b/net/wireless/tests/chan.c
index b9e7a27e43cb..d02258ac2dab 100644
--- a/net/wireless/tests/chan.c
+++ b/net/wireless/tests/chan.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <kunit/test.h>
@@ -140,6 +140,52 @@ static const struct chandef_compat_case {
 		},
 		.compat = true,
 	},
+	{
+		.desc = "matching primary 160 MHz & punctured secondary 160 Mhz",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 70,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 - 10,
+			.punctured = 0xf,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "matching primary 160 MHz & punctured matching",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 70,
+			.punctured = 0xc0,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 - 10,
+			.punctured = 0xc000,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "matching primary 160 MHz & punctured not matching",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 70,
+			.punctured = 0x80,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 - 10,
+			.punctured = 0xc000,
+		},
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(chandef_compat, chandef_compat_cases, desc)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a5..ae5e585b6863 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Portions of this file
+ * Copyright(c) 2016-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018, 2020-2024 Intel Corporation
+ */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cfg80211
 
@@ -135,7 +140,8 @@
 		       __field(u32, width)				\
 		       __field(u32, center_freq1)			\
 		       __field(u32, freq1_offset)			\
-		       __field(u32, center_freq2)
+		       __field(u32, center_freq2)			\
+		       __field(u16, punctured)
 #define CHAN_DEF_ASSIGN(chandef)					\
 	do {								\
 		if ((chandef) && (chandef)->chan) {			\
@@ -148,6 +154,7 @@
 			__entry->center_freq1 = (chandef)->center_freq1;\
 			__entry->freq1_offset = (chandef)->freq1_offset;\
 			__entry->center_freq2 = (chandef)->center_freq2;\
+			__entry->punctured = (chandef)->punctured;	\
 		} else {						\
 			__entry->band = 0;				\
 			__entry->control_freq = 0;			\
@@ -156,14 +163,15 @@
 			__entry->center_freq1 = 0;			\
 			__entry->freq1_offset = 0;			\
 			__entry->center_freq2 = 0;			\
+			__entry->punctured = 0;				\
 		}							\
 	} while (0)
 #define CHAN_DEF_PR_FMT							\
-	"band: %d, control freq: %u.%03u, width: %d, cf1: %u.%03u, cf2: %u"
+	"band: %d, control freq: %u.%03u, width: %d, cf1: %u.%03u, cf2: %u, punct: 0x%x"
 #define CHAN_DEF_PR_ARG __entry->band, __entry->control_freq,		\
 			__entry->freq_offset, __entry->width,		\
 			__entry->center_freq1, __entry->freq1_offset,	\
-			__entry->center_freq2
+			__entry->center_freq2, __entry->punctured
 
 #define FILS_AAD_ASSIGN(fa)						\
 	do {								\
@@ -3267,47 +3275,39 @@ TRACE_EVENT(cfg80211_chandef_dfs_required,
 TRACE_EVENT(cfg80211_ch_switch_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
-		 unsigned int link_id,
-		 u16 punct_bitmap),
-	TP_ARGS(netdev, chandef, link_id, punct_bitmap),
+		 unsigned int link_id),
+	TP_ARGS(netdev, chandef, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(unsigned int, link_id)
-		__field(u16, punct_bitmap)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 		__entry->link_id = link_id;
-		__entry->punct_bitmap = punct_bitmap;
 	),
-	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d, punct_bitmap:%u",
-		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id,
-		  __entry->punct_bitmap)
+	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
+		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(cfg80211_ch_switch_started_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
-		 unsigned int link_id,
-		 u16 punct_bitmap),
-	TP_ARGS(netdev, chandef, link_id, punct_bitmap),
+		 unsigned int link_id),
+	TP_ARGS(netdev, chandef, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(unsigned int, link_id)
-		__field(u16, punct_bitmap)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 		__entry->link_id = link_id;
-		__entry->punct_bitmap = punct_bitmap;
 	),
-	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d, punct_bitmap:%u",
-		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id,
-		  __entry->punct_bitmap)
+	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
+		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(cfg80211_radar_event,
-- 
2.43.0


