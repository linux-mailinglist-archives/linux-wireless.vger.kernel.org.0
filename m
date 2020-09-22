Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0D273A40
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIVFhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:36 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34086 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728898AbgIVFhg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9FFB54F9E11;
        Tue, 22 Sep 2020 05:37:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fL7VILiX_Z7D; Tue, 22 Sep 2020 05:37:33 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id C18274F9E02;
        Tue, 22 Sep 2020 05:37:19 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 11/17] mac80211: handle S1G low rates
Date:   Mon, 21 Sep 2020 19:28:12 -0700
Message-Id: <20200922022818.15855-12-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G doesn't have legacy (sband->bitrates) rates, only MCS.
For now, just send a frame at MCS 0 if a low rate is
requested. Note we also redefine (since we're out of TX
flags) TX_RC_VHT_MCS as TX_RC_S1G_MCS to indicate an S1G
MCS. This is probably OK as VHT MCS is not valid on S1G
band and vice versa.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/rate.c    | 33 ++++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e90089d104b0..de22524e9270 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -833,6 +833,8 @@ enum mac80211_tx_info_flags {
 
 #define IEEE80211_TX_CTL_STBC_SHIFT		23
 
+#define IEEE80211_TX_RC_S1G_MCS IEEE80211_TX_RC_VHT_MCS
+
 /**
  * enum mac80211_tx_control_flags - flags to describe transmit control
  *
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index b051f125d3af..63266d73c252 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -266,10 +266,15 @@ void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON(!sdata->vif.bss_conf.chandef.chan))
 		return;
 
+	band = sdata->vif.bss_conf.chandef.chan->band;
+	if (band == NL80211_BAND_S1GHZ) {
+		/* TODO */
+		return;
+	}
+
 	if (WARN_ON_ONCE(!basic_rates))
 		return;
 
-	band = sdata->vif.bss_conf.chandef.chan->band;
 	user_mask = sdata->rc_rateidx_mask[band];
 	sband = local->hw.wiphy->bands[band];
 
@@ -296,21 +301,29 @@ static bool rc_no_data_or_no_ack_use_min(struct ieee80211_tx_rate_control *txrc)
 		!ieee80211_is_data(fc);
 }
 
-static void rc_send_low_basicrate(s8 *idx, u32 basic_rates,
+static void rc_send_low_basicrate(struct ieee80211_tx_rate *rate,
+				  u32 basic_rates,
 				  struct ieee80211_supported_band *sband)
 {
 	u8 i;
 
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		/* TODO */
+		rate->flags |= IEEE80211_TX_RC_S1G_MCS;
+		rate->idx = 0;
+		return;
+	}
+
 	if (basic_rates == 0)
 		return; /* assume basic rates unknown and accept rate */
-	if (*idx < 0)
+	if (rate->idx < 0)
 		return;
-	if (basic_rates & (1 << *idx))
+	if (basic_rates & (1 << rate->idx))
 		return; /* selected rate is a basic rate */
 
-	for (i = *idx + 1; i <= sband->n_bitrates; i++) {
+	for (i = rate->idx + 1; i <= sband->n_bitrates; i++) {
 		if (basic_rates & (1 << i)) {
-			*idx = i;
+			rate->idx = i;
 			return;
 		}
 	}
@@ -328,6 +341,12 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 	u32 rate_flags =
 		ieee80211_chandef_rate_flags(&hw->conf.chandef);
 
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		info->control.rates[0].flags |= IEEE80211_TX_RC_S1G_MCS;
+		info->control.rates[0].idx = 0;
+		return;
+	}
+
 	if ((sband->band == NL80211_BAND_2GHZ) &&
 	    (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE))
 		rate_flags |= IEEE80211_RATE_ERP_G;
@@ -388,7 +407,7 @@ static bool rate_control_send_low(struct ieee80211_sta *pubsta,
 		}
 
 		if (use_basicrate)
-			rc_send_low_basicrate(&info->control.rates[0].idx,
+			rc_send_low_basicrate(&info->control.rates[0],
 					      txrc->bss_conf->basic_rates,
 					      sband);
 
-- 
2.20.1

