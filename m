Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35B32DCB4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE2MZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:56 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54312 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbfE2MZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeP-0007wy-4t; Wed, 29 May 2019 15:25:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 08/10] mac80211: use STA info in rate_control_send_low()
Date:   Wed, 29 May 2019 15:25:35 +0300
Message-Id: <20190529122537.8564-9-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Even if we have a station, we currently call rate_control_send_low()
with the NULL station unless further rate control (driver, minstrel)
has been initialized.

Change this so we can use more information about the station to use
a better rate. For example, when we associate with an AP, we will
now use the lowest rate it advertised as supported (that we can)
rather than the lowest mandatory rate. This aligns our behaviour
with most other 802.11 implementations.

To make this possible, we need to also ensure that we have non-zero
rates at all times, so in case we really have *nothing* pre-fill
the supp_rates bitmap with the very lowest mandatory bitmap (11b
and 11a on 2.4 and 5 GHz respectively).

Additionally, hostapd appears to be giving us an empty supported
rates bitmap (it can and should do better, since the STA must have
supported for at least the basic rates in the BSS), so ignore any
such bitmaps that would actually zero out the supp_rates, and in
that case just keep the pre-filled mandatory rates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/cfg.c      |  4 ++--
 net/mac80211/mlme.c     |  7 ++++++-
 net/mac80211/rate.c     | 12 ++++++------
 net/mac80211/sta_info.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 52e6a091b7e4..16d006b92eab 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018-2019 Intel Corporation
  *
  * This file is GPLv2 as found in COPYING.
  */
@@ -1466,7 +1466,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 			return ret;
 	}
 
-	if (params->supported_rates) {
+	if (params->supported_rates && params->supported_rates_len) {
 		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b7a9fe3d5fcb..bc2fdadf69bc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4941,7 +4941,12 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			basic_rates = BIT(min_rate_index);
 		}
 
-		new_sta->sta.supp_rates[cbss->channel->band] = rates;
+		if (rates)
+			new_sta->sta.supp_rates[cbss->channel->band] = rates;
+		else
+			sdata_info(sdata,
+				   "No rates found, keeping mandatory only\n");
+
 		sdata->vif.bss_conf.basic_rates = basic_rates;
 
 		/* cf. IEEE 802.11 9.2.12 */
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index c78a259d81ed..8747231f7aa3 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -887,11 +887,6 @@ void rate_control_get_rate(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txrc->skb);
 	int i;
 
-	if (sta && test_sta_flag(sta, WLAN_STA_RATE_CONTROL)) {
-		ista = &sta->sta;
-		priv_sta = sta->rate_ctrl_priv;
-	}
-
 	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
 		info->control.rates[i].idx = -1;
 		info->control.rates[i].flags = 0;
@@ -901,9 +896,14 @@ void rate_control_get_rate(struct ieee80211_sub_if_data *sdata,
 	if (ieee80211_hw_check(&sdata->local->hw, HAS_RATE_CONTROL))
 		return;
 
-	if (rate_control_send_low(ista, txrc))
+	if (rate_control_send_low(sta ? &sta->sta : NULL, txrc))
 		return;
 
+	if (sta && test_sta_flag(sta, WLAN_STA_RATE_CONTROL)) {
+		ista = &sta->sta;
+		priv_sta = sta->rate_ctrl_priv;
+	}
+
 	if (ista) {
 		spin_lock_bh(&sta->rate_ctrl_lock);
 		ref->ops->get_rate(ref->priv, ista, priv_sta, txrc);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index a4932ee3595c..315adb473e2c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3,7 +3,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018-2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -404,6 +404,47 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
 		sta->last_seq_ctrl[i] = cpu_to_le16(USHRT_MAX);
 
+	for (i = 0; i < NUM_NL80211_BANDS; i++) {
+		u32 mandatory = 0;
+		int r;
+
+		if (!hw->wiphy->bands[i])
+			continue;
+
+		switch (i) {
+		case NL80211_BAND_2GHZ:
+			/*
+			 * We use both here, even if we cannot really know for
+			 * sure the station will support both, but the only use
+			 * for this is when we don't know anything yet and send
+			 * management frames, and then we'll pick the lowest
+			 * possible rate anyway.
+			 * If we don't include _G here, we cannot find a rate
+			 * in P2P, and thus trigger the WARN_ONCE() in rate.c
+			 */
+			mandatory = IEEE80211_RATE_MANDATORY_B |
+				    IEEE80211_RATE_MANDATORY_G;
+			break;
+		case NL80211_BAND_5GHZ:
+			mandatory = IEEE80211_RATE_MANDATORY_A;
+			break;
+		case NL80211_BAND_60GHZ:
+			WARN_ON(1);
+			mandatory = 0;
+			break;
+		}
+
+		for (r = 0; r < hw->wiphy->bands[i]->n_bitrates; r++) {
+			struct ieee80211_rate *rate;
+
+			rate = &hw->wiphy->bands[i]->bitrates[r];
+
+			if (!(rate->flags & mandatory))
+				continue;
+			sta->sta.supp_rates[i] |= BIT(r);
+		}
+	}
+
 	sta->sta.smps_mode = IEEE80211_SMPS_OFF;
 	if (sdata->vif.type == NL80211_IFTYPE_AP ||
 	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-- 
2.20.1

