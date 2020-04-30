Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86C1BED6A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 03:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD3BG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 21:06:56 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:58402 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726554AbgD3BG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 21:06:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C38AA4F8019;
        Thu, 30 Apr 2020 01:06:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2KnfDNEWgN0V; Thu, 30 Apr 2020 01:06:52 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id ECDBA4F802A;
        Thu, 30 Apr 2020 01:06:44 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 5/5] nl80211: S1G band and channel definitions
Date:   Wed, 29 Apr 2020 18:06:42 -0700
Message-Id: <20200430010642.22552-6-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430010642.22552-1-thomas@adapt-ip.com>
References: <20200430010642.22552-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Gives drivers the definitions needed to advertise support
for S1G bands.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/net/cfg80211.h       | 17 +++++++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/mac80211/chan.c          |  7 ++++++-
 net/mac80211/scan.c          |  1 +
 net/mac80211/tx.c            |  5 +++++
 net/mac80211/util.c          |  5 +++++
 net/wireless/chan.c          | 29 +++++++++++++++++++++++++++++
 net/wireless/core.c          |  5 +++--
 net/wireless/util.c          |  8 ++++++++
 9 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3746b52c954e..40c3f2fe4167 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -414,6 +414,22 @@ struct ieee80211_edmg {
 	enum ieee80211_edmg_bw_config bw_config;
 };
 
+/**
+ * struct ieee80211_sta_s1g_cap - STA's S1G capabilities
+ *
+ * This structure describes most essential parameters needed
+ * to describe 802.11ah S1G capabilities for a STA.
+ *
+ * @s1g_supported: is STA an S1G STA
+ * @cap: S1G capabilities information
+ * @nss_mcs: Supported NSS MCS set
+ */
+struct ieee80211_sta_s1g_cap {
+	bool s1g;
+	u8 cap[10]; /* use S1G_CAPAB_ */
+	u8 nss_mcs[5];
+};
+
 /**
  * struct ieee80211_supported_band - frequency band definition
  *
@@ -445,6 +461,7 @@ struct ieee80211_supported_band {
 	int n_bitrates;
 	struct ieee80211_sta_ht_cap ht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
+	struct ieee80211_sta_s1g_cap s1g_cap;
 	struct ieee80211_edmg edmg_cap;
 	u16 n_iftype_data;
 	const struct ieee80211_sband_iftype_data *iftype_data;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b6012aa5103b..332ec138b507 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4421,6 +4421,11 @@ enum nl80211_key_mode {
  *	attribute must be provided as well
  * @NL80211_CHAN_WIDTH_5: 5 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_10: 10 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_1: 1 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_2: 2 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_4: 4 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_8: 8 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_16: 16 MHz OFDM channel
  */
 enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_20_NOHT,
@@ -4431,6 +4436,11 @@ enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_160,
 	NL80211_CHAN_WIDTH_5,
 	NL80211_CHAN_WIDTH_10,
+	NL80211_CHAN_WIDTH_1,
+	NL80211_CHAN_WIDTH_2,
+	NL80211_CHAN_WIDTH_4,
+	NL80211_CHAN_WIDTH_8,
+	NL80211_CHAN_WIDTH_16,
 };
 
 /**
@@ -4441,11 +4451,15 @@ enum nl80211_chan_width {
  * @NL80211_BSS_CHAN_WIDTH_20: control channel is 20 MHz wide or compatible
  * @NL80211_BSS_CHAN_WIDTH_10: control channel is 10 MHz wide
  * @NL80211_BSS_CHAN_WIDTH_5: control channel is 5 MHz wide
+ * @NL80211_BSS_CHAN_WIDTH_1: control channel is 1 MHz wide
+ * @NL80211_BSS_CHAN_WIDTH_2: control channel is 2 MHz wide
  */
 enum nl80211_bss_scan_width {
 	NL80211_BSS_CHAN_WIDTH_20,
 	NL80211_BSS_CHAN_WIDTH_10,
 	NL80211_BSS_CHAN_WIDTH_5,
+	NL80211_BSS_CHAN_WIDTH_1,
+	NL80211_BSS_CHAN_WIDTH_2,
 };
 
 /**
@@ -4724,6 +4738,7 @@ enum nl80211_txrate_gi {
  * @NL80211_BAND_5GHZ: around 5 GHz band (4.9 - 5.7 GHz)
  * @NL80211_BAND_60GHZ: around 60 GHz band (58.32 - 69.12 GHz)
  * @NL80211_BAND_6GHZ: around 6 GHz band (5.9 - 7.2 GHz)
+ * @NL80211_BAND_S1GHZ: around 900MHz, supported by S1G PHYs
  * @NUM_NL80211_BANDS: number of bands, avoid using this in userspace
  *	since newer kernel versions may support more bands
  */
@@ -4732,6 +4747,7 @@ enum nl80211_band {
 	NL80211_BAND_5GHZ,
 	NL80211_BAND_60GHZ,
 	NL80211_BAND_6GHZ,
+	NL80211_BAND_S1GHZ,
 
 	NUM_NL80211_BANDS,
 };
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e6e192f53e4e..08cf9da9c1e3 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -313,9 +313,14 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	/* don't optimize 5MHz, 10MHz, and radar_enabled confs */
+	/* don't optimize non-20MHz based and radar_enabled confs */
 	if (ctx->conf.def.width == NL80211_CHAN_WIDTH_5 ||
 	    ctx->conf.def.width == NL80211_CHAN_WIDTH_10 ||
+	    ctx->conf.def.width == NL80211_CHAN_WIDTH_1 ||
+	    ctx->conf.def.width == NL80211_CHAN_WIDTH_2 ||
+	    ctx->conf.def.width == NL80211_CHAN_WIDTH_4 ||
+	    ctx->conf.def.width == NL80211_CHAN_WIDTH_8 ||
+	    ctx->conf.def.width == NL80211_CHAN_WIDTH_16 ||
 	    ctx->conf.radar_enabled) {
 		ctx->conf.min_def = ctx->conf.def;
 		return;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5db15996524f..d3935e308ea3 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -906,6 +906,7 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	case NL80211_BSS_CHAN_WIDTH_10:
 		local->scan_chandef.width = NL80211_CHAN_WIDTH_10;
 		break;
+	default:
 	case NL80211_BSS_CHAN_WIDTH_20:
 		/* If scanning on oper channel, use whatever channel-type
 		 * is currently in use.
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3dc1990e15c5..cf0ba8d229e4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -80,6 +80,10 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 	sband = local->hw.wiphy->bands[info->band];
 	txrate = &sband->bitrates[tx->rate.idx];
 
+	if (sband->band == NL80211_BAND_S1GHZ)
+		/* TODO */
+		return 0;
+
 	erp = txrate->flags & IEEE80211_RATE_ERP_G;
 
 	/*
@@ -166,6 +170,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 			if (r->flags & IEEE80211_RATE_MANDATORY_A)
 				mrate = r->bitrate;
 			break;
+		case NL80211_BAND_S1GHZ:
 		case NL80211_BAND_60GHZ:
 			/* TODO, for now fall through */
 		case NUM_NL80211_BANDS:
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 20436c86b9bf..c48e75dfdcdb 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3456,6 +3456,11 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		c->width = NL80211_CHAN_WIDTH_20_NOHT;
 		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_VHT;
 		break;
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 		WARN_ON_ONCE(1);
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e111c08daa0e..9ceea5f5b891 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -153,6 +153,11 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	control_freq = chandef->chan->center_freq;
 
 	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20:
@@ -263,6 +268,21 @@ static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 	int width;
 
 	switch (c->width) {
+	case NL80211_CHAN_WIDTH_1:
+		width = 1;
+		break;
+	case NL80211_CHAN_WIDTH_2:
+		width = 2;
+		break;
+	case NL80211_CHAN_WIDTH_4:
+		width = 4;
+		break;
+	case NL80211_CHAN_WIDTH_8:
+		width = 8;
+		break;
+	case NL80211_CHAN_WIDTH_16:
+		width = 16;
+		break;
 	case NL80211_CHAN_WIDTH_5:
 		width = 5;
 		break;
@@ -911,6 +931,15 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	control_freq = chandef->chan->center_freq;
 
 	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_1:
+		width = 1;
+		break;
+	case NL80211_CHAN_WIDTH_2:
+		width = 2;
+		break;
+	case NL80211_CHAN_WIDTH_4:
+		width = 4;
+		break;
 	case NL80211_CHAN_WIDTH_5:
 		width = 5;
 		break;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index b795f363d004..14b617fb160c 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -800,10 +800,11 @@ int wiphy_register(struct wiphy *wiphy)
 		if (WARN_ON(!sband->n_channels))
 			return -EINVAL;
 		/*
-		 * on 60GHz band, there are no legacy rates, so
+		 * on 60GHz or sub-1Ghz band, there are no legacy rates, so
 		 * n_bitrates is 0
 		 */
-		if (WARN_ON(band != NL80211_BAND_60GHZ &&
+		if (WARN_ON((band != NL80211_BAND_60GHZ &&
+			     band != NL80211_BAND_S1GHZ) &&
 			    !sband->n_bitrates))
 			return -EINVAL;
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index df75e58eca5d..3ba1f4873541 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -100,6 +100,8 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 		if (chan < 7)
 			return MHZ_TO_KHZ(56160 + chan * 2160);
 		break;
+	case NL80211_BAND_S1GHZ:
+		return 902000 + chan * 500;
 	default:
 		;
 	}
@@ -208,6 +210,12 @@ static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 		WARN_ON(!sband->ht_cap.ht_supported);
 		WARN_ON((sband->ht_cap.mcs.rx_mask[0] & 0x1e) != 0x1e);
 		break;
+	case NL80211_BAND_S1GHZ:
+		/* Figure 9-589bd: 3 means unsupported, so != 3 means at least
+		 * mandatory is ok.
+		 */
+		WARN_ON((sband->s1g_cap.nss_mcs[0] & 0x3) == 0x3);
+		break;
 	case NUM_NL80211_BANDS:
 	default:
 		WARN_ON(1);
-- 
2.20.1

