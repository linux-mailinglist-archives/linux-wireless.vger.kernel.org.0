Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09752D04F7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgLFMzw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34938 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbgLFMzp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltZ4-003AHZ-Dj; Sun, 06 Dec 2020 14:54:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:48 +0200
Message-Id: <iwlwifi.20201206145305.4387040b99a0.I74bcf19238f75a5960c4098b10e355123d933281@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] mac80211: Fix calculation of minimal channel width
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When calculating the minimal channel width for channel context,
the current operation Rx channel width of a station was used and not
the overall channel width capability of the station, i.e., both for
Tx and Rx.

Fix ieee80211_get_sta_bw() to use the maximal channel width the
station is capable. While at it make the function static.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/chan.c        | 10 ++++++----
 net/mac80211/ieee80211_i.h |  1 -
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b6c80a45b9f5..c42574f2d48c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -191,11 +191,13 @@ ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
 	return NULL;
 }
 
-enum nl80211_chan_width ieee80211_get_sta_bw(struct ieee80211_sta *sta)
+static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta)
 {
-	switch (sta->bandwidth) {
+	enum ieee80211_sta_rx_bandwidth width = ieee80211_sta_cap_rx_bw(sta);
+
+	switch (width) {
 	case IEEE80211_STA_RX_BW_20:
-		if (sta->ht_cap.ht_supported)
+		if (sta->sta.ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20;
 		else
 			return NL80211_CHAN_WIDTH_20_NOHT;
@@ -232,7 +234,7 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata)
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
 
-		max_bw = max(max_bw, ieee80211_get_sta_bw(&sta->sta));
+		max_bw = max(max_bw, ieee80211_get_sta_bw(sta));
 	}
 	rcu_read_unlock();
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cb721c7c1cdb..8bf9c0e974d6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2277,7 +2277,6 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 enum ieee80211_chanctx_mode chanmode,
 				 u8 radar_detect);
 int ieee80211_max_num_channels(struct ieee80211_local *local);
-enum nl80211_chan_width ieee80211_get_sta_bw(struct ieee80211_sta *sta);
 void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx);
 
-- 
2.29.2

