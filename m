Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B81EB5C4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgFBGWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jun 2020 02:22:52 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:45992 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725616AbgFBGWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jun 2020 02:22:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id E61AC4F8AF0;
        Tue,  2 Jun 2020 06:22:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t-64MaHCDtWb; Tue,  2 Jun 2020 06:22:48 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 36EEF4F8AEA;
        Tue,  2 Jun 2020 06:22:48 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v5] nl80211: S1G band and channel definitions
Date:   Mon,  1 Jun 2020 23:22:47 -0700
Message-Id: <20200602062247.23212-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
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
v5:
Add unhandled 8 and 16MHz channel width cases (Johannes)
---
 include/net/cfg80211.h       | 17 +++++++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/mac80211/chan.c          |  7 ++++++-
 net/mac80211/scan.c          |  1 +
 net/mac80211/tx.c            |  1 +
 net/mac80211/util.c          |  5 +++++
 net/wireless/chan.c          | 35 +++++++++++++++++++++++++++++++++++
 net/wireless/core.c          |  5 +++--
 net/wireless/util.c          |  8 ++++++++
 9 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e2dbc9c02ef3..baf5d41349dd 100644
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
index c14666b75e57..92689a626a37 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4429,6 +4429,11 @@ enum nl80211_key_mode {
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
@@ -4439,6 +4444,11 @@ enum nl80211_chan_width {
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
@@ -4449,11 +4459,15 @@ enum nl80211_chan_width {
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
@@ -4732,6 +4746,7 @@ enum nl80211_txrate_gi {
  * @NL80211_BAND_5GHZ: around 5 GHz band (4.9 - 5.7 GHz)
  * @NL80211_BAND_60GHZ: around 60 GHz band (58.32 - 69.12 GHz)
  * @NL80211_BAND_6GHZ: around 6 GHz band (5.9 - 7.2 GHz)
+ * @NL80211_BAND_S1GHZ: around 900MHz, supported by S1G PHYs
  * @NUM_NL80211_BANDS: number of bands, avoid using this in userspace
  *	since newer kernel versions may support more bands
  */
@@ -4740,6 +4755,7 @@ enum nl80211_band {
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
index e9ce658141f5..b322595ea4be 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -166,6 +166,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
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
index e111c08daa0e..644feeb74cc3 100644
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
@@ -911,6 +931,21 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
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
+	case NL80211_CHAN_WIDTH_8:
+		width = 8;
+		break;
+	case NL80211_CHAN_WIDTH_16:
+		width = 16;
+		break;
 	case NL80211_CHAN_WIDTH_5:
 		width = 5;
 		break;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index ac2c66539e26..82ddc23bfb82 100644
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

