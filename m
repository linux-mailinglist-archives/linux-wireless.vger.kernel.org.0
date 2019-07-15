Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A713A6897B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfGOMqZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 08:46:25 -0400
Received: from alexa-out-ams-01.qualcomm.com ([185.23.61.162]:48742 "EHLO
        alexa-out-ams-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730110AbfGOMqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 08:46:24 -0400
Received: from ironmsg01-ams.qualcomm.com ([10.251.56.2])
  by alexa-out-ams-01.qualcomm.com with ESMTP; 15 Jul 2019 14:46:21 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9318"; a="8780999"
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg01-ams.qualcomm.com with ESMTP; 15 Jul 2019 14:46:19 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v5 1/2] nl80211: Add support for EDMG channels
Date:   Mon, 15 Jul 2019 15:46:06 +0300
Message-Id: <1563194767-4817-2-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
References: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

802.11ay specification defines Enhanced Directional Multi-Gigabit
(EDMG) STA and AP which allow channel bonding of 2 channels and more.
Introduce NL80211_ATTR_WIPHY_EDMG_CHANNELS,
NL80211_ATTR_WIPHY_EDMG_BW_CONFIG, NL80211_BAND_ATTR_EDMG_CHANNELS,
NL80211_BAND_ATTR_EDMG_BW_CONFIG and RATE_INFO_FLAGS_EDMG
that needed for enabling and configuring EDMG support.
Driver is expected to report its EDMG capabilities: whether EDMG
is supported and the supported EDMG channels.
Bitrate calculation is enhanced to take into account EDMG support
according to the 802.11ay specification.
The kernel uses NL80211_BAND_ATTR_EDMG_CHANNELS and
NL80211_BAND_ATTR_EDMG_BW_CONFIG attributes in order to publish
the EDMG capabilities to the userspace.
NL80211_BAND_ATTR_EDMG_CHANNELS is a bitmap field that indicates
the 2.16 GHz channel(s) that are allowed to be used.
If NL80211_BAND_ATTR_EDMG_CHANNELS is not set then EDMG not
supported. NL80211_BAND_ATTR_EDMG_BW_CONFIG represent the allowed
channel bandwidth configurations.
NL80211_ATTR_WIPHY_EDMG_CHANNELS and NL80211_ATTR_WIPHY_EDMG_BW_CONFIG
will be used by the userspace for AP configuration and connect command.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c |   2 +-
 include/net/cfg80211.h                      |  86 ++++++++++++++-
 include/uapi/linux/nl80211.h                |  24 +++++
 net/wireless/chan.c                         | 159 ++++++++++++++++++++++++++++
 net/wireless/nl80211.c                      |  37 +++++++
 net/wireless/util.c                         |  42 +++++++-
 6 files changed, 344 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index a1e226652..ce68fbc 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -346,7 +346,7 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 			BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC) |
 			BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 
-	sinfo->txrate.flags = RATE_INFO_FLAGS_60G;
+	sinfo->txrate.flags = RATE_INFO_FLAGS_DMG;
 	sinfo->txrate.mcs = le16_to_cpu(reply.evt.bf_mcs);
 	sinfo->rxrate.mcs = stats->last_mcs_rx;
 	sinfo->rx_bytes = stats->rx_bytes;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 117691f..bb4da96 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -321,6 +321,60 @@ struct ieee80211_sband_iftype_data {
 };
 
 /**
+ * enum ieee80211_edmg_bw_config - allowed channel bandwidth configurations
+ *
+ * @IEEE80211_EDMG_BW_CONFIG_4: 2.16GHz
+ * @IEEE80211_EDMG_BW_CONFIG_5: 2.16GHz and 4.32GHz
+ * @IEEE80211_EDMG_BW_CONFIG_6: 2.16GHz, 4.32GHz and 6.48GHz
+ * @IEEE80211_EDMG_BW_CONFIG_7: 2.16GHz, 4.32GHz, 6.48GHz and 8.64GHz
+ * @IEEE80211_EDMG_BW_CONFIG_8: 2.16GHz and 2.16GHz + 2.16GHz
+ * @IEEE80211_EDMG_BW_CONFIG_9: 2.16GHz, 4.32GHz and 2.16GHz + 2.16GHz
+ * @IEEE80211_EDMG_BW_CONFIG_10: 2.16GHz, 4.32GHz, 6.48GHz and 2.16GHz+2.16GHz
+ * @IEEE80211_EDMG_BW_CONFIG_11: 2.16GHz, 4.32GHz, 6.48GHz, 8.64GHz and
+ *	2.16GHz+2.16GHz
+ * @IEEE80211_EDMG_BW_CONFIG_12: 2.16GHz, 2.16GHz + 2.16GHz and
+ *	4.32GHz + 4.32GHz
+ * @IEEE80211_EDMG_BW_CONFIG_13: 2.16GHz, 4.32GHz, 2.16GHz + 2.16GHz and
+ *	4.32GHz + 4.32GHz
+ * @IEEE80211_EDMG_BW_CONFIG_14: 2.16GHz, 4.32GHz, 6.48GHz, 2.16GHz + 2.16GHz
+ *	and 4.32GHz + 4.32GHz
+ * @IEEE80211_EDMG_BW_CONFIG_15: 2.16GHz, 4.32GHz, 6.48GHz, 8.64GHz,
+ *	2.16GHz + 2.16GHz and 4.32GHz + 4.32GHz
+ */
+enum ieee80211_edmg_bw_config {
+	IEEE80211_EDMG_BW_CONFIG_4	= 4,
+	IEEE80211_EDMG_BW_CONFIG_5	= 5,
+	IEEE80211_EDMG_BW_CONFIG_6	= 6,
+	IEEE80211_EDMG_BW_CONFIG_7	= 7,
+	IEEE80211_EDMG_BW_CONFIG_8	= 8,
+	IEEE80211_EDMG_BW_CONFIG_9	= 9,
+	IEEE80211_EDMG_BW_CONFIG_10	= 10,
+	IEEE80211_EDMG_BW_CONFIG_11	= 11,
+	IEEE80211_EDMG_BW_CONFIG_12	= 12,
+	IEEE80211_EDMG_BW_CONFIG_13	= 13,
+	IEEE80211_EDMG_BW_CONFIG_14	= 14,
+	IEEE80211_EDMG_BW_CONFIG_15	= 15,
+};
+
+/**
+ * struct ieee80211_edmg - EDMG configuration
+ *
+ * This structure describes most essential parameters needed
+ * to describe 802.11ay EDMG configuration
+ *
+ * @channels: bitmap that indicates the 2.16 GHz channel(s)
+ *	that are allowed to be used for transmissions.
+ *	Bit 0 indicates channel 1, bit 1 indicates channel 2, etc.
+ *	Set to 0 indicate EDMG not supported.
+ * @bw_config: Channel BW Configuration subfield encodes
+ *	the allowed channel bandwidth configurations
+ */
+struct ieee80211_edmg {
+	u8 channels;
+	enum ieee80211_edmg_bw_config bw_config;
+};
+
+/**
  * struct ieee80211_supported_band - frequency band definition
  *
  * This structure describes a frequency band a wiphy
@@ -336,6 +390,7 @@ struct ieee80211_sband_iftype_data {
  * @n_bitrates: Number of bitrates in @bitrates
  * @ht_cap: HT capabilities in this band
  * @vht_cap: VHT capabilities in this band
+ * @edmg_cap: EDMG capabilities in this band
  * @n_iftype_data: number of iftype data entries
  * @iftype_data: interface type data entries.  Note that the bits in
  *	@types_mask inside this structure cannot overlap (i.e. only
@@ -350,6 +405,7 @@ struct ieee80211_supported_band {
 	int n_bitrates;
 	struct ieee80211_sta_ht_cap ht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
+	struct ieee80211_edmg edmg_cap;
 	u16 n_iftype_data;
 	const struct ieee80211_sband_iftype_data *iftype_data;
 };
@@ -503,12 +559,17 @@ struct key_params {
  * @center_freq1: center frequency of first segment
  * @center_freq2: center frequency of second segment
  *	(only with 80+80 MHz)
+ * @edmg: define the EDMG channels configuration.
+ *	If edmg is requested (i.e. the .channels member is non-zero),
+ *	chan will define the primary channel and all other
+ *	parameters are ignored.
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
 	enum nl80211_chan_width width;
 	u32 center_freq1;
 	u32 center_freq2;
+	struct ieee80211_edmg edmg;
 };
 
 /**
@@ -567,6 +628,19 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 }
 
 /**
+ * cfg80211_chandef_is_edmg - check if chandef represents an EDMG channel
+ *
+ * @chandef: the channel definition
+ *
+ * Return: %true if EDMG defined, %false otherwise.
+ */
+static inline bool
+cfg80211_chandef_is_edmg(const struct cfg80211_chan_def *chandef)
+{
+	return chandef->edmg.channels || chandef->edmg.bw_config;
+}
+
+/**
  * cfg80211_chandef_compatible - check if two channel definitions are compatible
  * @chandef1: first channel definition
  * @chandef2: second channel definition
@@ -1144,15 +1218,17 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_MCS: mcs field filled with HT MCS
  * @RATE_INFO_FLAGS_VHT_MCS: mcs field filled with VHT MCS
  * @RATE_INFO_FLAGS_SHORT_GI: 400ns guard interval
- * @RATE_INFO_FLAGS_60G: 60GHz MCS
+ * @RATE_INFO_FLAGS_DMG: 60GHz MCS
  * @RATE_INFO_FLAGS_HE_MCS: HE MCS information
+ * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
 	RATE_INFO_FLAGS_VHT_MCS			= BIT(1),
 	RATE_INFO_FLAGS_SHORT_GI		= BIT(2),
-	RATE_INFO_FLAGS_60G			= BIT(3),
+	RATE_INFO_FLAGS_DMG			= BIT(3),
 	RATE_INFO_FLAGS_HE_MCS			= BIT(4),
+	RATE_INFO_FLAGS_EDMG			= BIT(5),
 };
 
 /**
@@ -1192,6 +1268,7 @@ enum rate_info_bw {
  * @he_dcm: HE DCM value
  * @he_ru_alloc: HE RU allocation (from &enum nl80211_he_ru_alloc,
  *	only valid if bw is %RATE_INFO_BW_HE_RU)
+ * @n_bonded_ch: In case of EDMG the number of bonded channels (1-4)
  */
 struct rate_info {
 	u8 flags;
@@ -1202,6 +1279,7 @@ struct rate_info {
 	u8 he_gi;
 	u8 he_dcm;
 	u8 he_ru_alloc;
+	u8 n_bonded_ch;
 };
 
 /**
@@ -2403,6 +2481,9 @@ struct cfg80211_bss_selection {
  * @fils_erp_rrk_len: Length of @fils_erp_rrk in octets.
  * @want_1x: indicates user-space supports and wants to use 802.1X driver
  *	offload of 4-way handshake.
+ * @edmg: define the EDMG channels.
+ *	This may specify multiple channels and bonding options for the driver
+ *	to choose from, based on BSS configuration.
  */
 struct cfg80211_connect_params {
 	struct ieee80211_channel *channel;
@@ -2436,6 +2517,7 @@ struct cfg80211_connect_params {
 	const u8 *fils_erp_rrk;
 	size_t fils_erp_rrk_len;
 	bool want_1x;
+	struct ieee80211_edmg edmg;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 25f70dd..b7427a9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -52,6 +52,11 @@
 #define NL80211_MULTICAST_GROUP_NAN		"nan"
 #define NL80211_MULTICAST_GROUP_TESTMODE	"testmode"
 
+#define NL80211_EDMG_BW_CONFIG_MIN	4
+#define NL80211_EDMG_BW_CONFIG_MAX	15
+#define NL80211_EDMG_CHANNELS_MIN	1
+#define NL80211_EDMG_CHANNELS_MAX	0x3c /* 0b00111100 */
+
 /**
  * DOC: Station handling
  *
@@ -2324,6 +2329,13 @@ enum nl80211_commands {
  *	should be picking up the lowest tx power, either tx power per-interface
  *	or per-station.
  *
+ * @NL80211_ATTR_WIPHY_EDMG_CHANNELS: bitmap that indicates the 2.16 GHz
+ *	channel(s) that are allowed to be used for EDMG transmissions.
+ *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251.
+ * @NL80211_ATTR_WIPHY_EDMG_BW_CONFIG: Channel BW Configuration subfield encodes
+ *	the allowed channel bandwidth configurations.
+ *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2777,6 +2789,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_STA_TX_POWER_SETTING,
 	NL80211_ATTR_STA_TX_POWER,
 
+	NL80211_ATTR_WIPHY_EDMG_CHANNELS,
+	NL80211_ATTR_WIPHY_EDMG_BW_CONFIG,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3385,6 +3400,12 @@ enum nl80211_band_iftype_attr {
  * @NL80211_BAND_ATTR_VHT_CAPA: VHT capabilities, as in the HT information IE
  * @NL80211_BAND_ATTR_IFTYPE_DATA: nested array attribute, with each entry using
  *	attributes from &enum nl80211_band_iftype_attr
+ * @NL80211_BAND_ATTR_EDMG_CHANNELS: bitmap that indicates the 2.16 GHz
+ *	channel(s) that are allowed to be used for EDMG transmissions.
+ *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251.
+ * @NL80211_BAND_ATTR_EDMG_BW_CONFIG: Channel BW Configuration subfield encodes
+ *	the allowed channel bandwidth configurations.
+ *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  * @NL80211_BAND_ATTR_MAX: highest band attribute currently defined
  * @__NL80211_BAND_ATTR_AFTER_LAST: internal use
  */
@@ -3402,6 +3423,9 @@ enum nl80211_band_attr {
 	NL80211_BAND_ATTR_VHT_CAPA,
 	NL80211_BAND_ATTR_IFTYPE_DATA,
 
+	NL80211_BAND_ATTR_EDMG_CHANNELS,
+	NL80211_BAND_ATTR_EDMG_BW_CONFIG,
+
 	/* keep last */
 	__NL80211_BAND_ATTR_AFTER_LAST,
 	NL80211_BAND_ATTR_MAX = __NL80211_BAND_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 7dc1bbd..d823e5f 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -14,6 +14,11 @@
 #include "core.h"
 #include "rdev-ops.h"
 
+static bool cfg80211_valid_60g_freq(u32 freq)
+{
+	return freq >= 58320 && freq <= 70200;
+}
+
 void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 			     struct ieee80211_channel *chan,
 			     enum nl80211_channel_type chan_type)
@@ -23,6 +28,8 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 
 	chandef->chan = chan;
 	chandef->center_freq2 = 0;
+	chandef->edmg.bw_config = 0;
+	chandef->edmg.channels = 0;
 
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
@@ -47,6 +54,91 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 }
 EXPORT_SYMBOL(cfg80211_chandef_create);
 
+static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
+{
+	int max_contiguous = 0;
+	int num_of_enabled = 0;
+	int contiguous = 0;
+	int i;
+
+	if (!chandef->edmg.channels || !chandef->edmg.bw_config)
+		return false;
+
+	if (!cfg80211_valid_60g_freq(chandef->chan->center_freq))
+		return false;
+
+	for (i = 0; i < 6; i++) {
+		if (chandef->edmg.channels & BIT(i)) {
+			contiguous++;
+			num_of_enabled++;
+		} else {
+			contiguous = 0;
+		}
+
+		max_contiguous = max(contiguous, max_contiguous);
+	}
+	/* basic verification of edmg configuration according to
+	 * IEEE P802.11ay/D4.0 section 9.4.2.251
+	 */
+	/* check bw_config against contiguous edmg channels */
+	switch (chandef->edmg.bw_config) {
+	case IEEE80211_EDMG_BW_CONFIG_4:
+	case IEEE80211_EDMG_BW_CONFIG_8:
+	case IEEE80211_EDMG_BW_CONFIG_12:
+		if (max_contiguous < 1)
+			return false;
+		break;
+	case IEEE80211_EDMG_BW_CONFIG_5:
+	case IEEE80211_EDMG_BW_CONFIG_9:
+	case IEEE80211_EDMG_BW_CONFIG_13:
+		if (max_contiguous < 2)
+			return false;
+		break;
+	case IEEE80211_EDMG_BW_CONFIG_6:
+	case IEEE80211_EDMG_BW_CONFIG_10:
+	case IEEE80211_EDMG_BW_CONFIG_14:
+		if (max_contiguous < 3)
+			return false;
+		break;
+	case IEEE80211_EDMG_BW_CONFIG_7:
+	case IEEE80211_EDMG_BW_CONFIG_11:
+	case IEEE80211_EDMG_BW_CONFIG_15:
+		if (max_contiguous < 4)
+			return false;
+		break;
+
+	default:
+		return false;
+	}
+
+	/* check bw_config against aggregated (non contiguous) edmg channels */
+	switch (chandef->edmg.bw_config) {
+	case IEEE80211_EDMG_BW_CONFIG_4:
+	case IEEE80211_EDMG_BW_CONFIG_5:
+	case IEEE80211_EDMG_BW_CONFIG_6:
+	case IEEE80211_EDMG_BW_CONFIG_7:
+		break;
+	case IEEE80211_EDMG_BW_CONFIG_8:
+	case IEEE80211_EDMG_BW_CONFIG_9:
+	case IEEE80211_EDMG_BW_CONFIG_10:
+	case IEEE80211_EDMG_BW_CONFIG_11:
+		if (num_of_enabled < 2)
+			return false;
+		break;
+	case IEEE80211_EDMG_BW_CONFIG_12:
+	case IEEE80211_EDMG_BW_CONFIG_13:
+	case IEEE80211_EDMG_BW_CONFIG_14:
+	case IEEE80211_EDMG_BW_CONFIG_15:
+		if (num_of_enabled < 4 || max_contiguous < 2)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
 	u32 control_freq;
@@ -112,6 +204,10 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		return false;
 	}
 
+	if (cfg80211_chandef_is_edmg(chandef) &&
+	    !cfg80211_edmg_chandef_valid(chandef))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
@@ -721,12 +817,66 @@ static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 	return true;
 }
 
+/* check if the operating channels are valid and supported */
+static bool cfg80211_edmg_usable(struct wiphy *wiphy, u8 edmg_channels,
+				 enum ieee80211_edmg_bw_config edmg_bw_config,
+				 int primary_channel,
+				 struct ieee80211_edmg *edmg_cap)
+{
+	struct ieee80211_channel *chan;
+	int i, freq;
+	int channels_counter = 0;
+
+	if (!edmg_channels && !edmg_bw_config)
+		return true;
+
+	if ((!edmg_channels && edmg_bw_config) ||
+	    (edmg_channels && !edmg_bw_config))
+		return false;
+
+	if (!(edmg_channels & BIT(primary_channel - 1)))
+		return false;
+
+	/* 60GHz channels 1..6 */
+	for (i = 0; i < 6; i++) {
+		if (!(edmg_channels & BIT(i)))
+			continue;
+
+		if (!(edmg_cap->channels & BIT(i)))
+			return false;
+
+		channels_counter++;
+
+		freq = ieee80211_channel_to_frequency(i + 1,
+						      NL80211_BAND_60GHZ);
+		chan = ieee80211_get_channel(wiphy, freq);
+		if (!chan || chan->flags & IEEE80211_CHAN_DISABLED)
+			return false;
+	}
+
+	/* IEEE802.11 allows max 4 channels */
+	if (channels_counter > 4)
+		return false;
+
+	/* check bw_config is a subset of what driver supports
+	 * (see IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13)
+	 */
+	if ((edmg_bw_config % 4) > (edmg_cap->bw_config % 4))
+		return false;
+
+	if (edmg_bw_config > edmg_cap->bw_config)
+		return false;
+
+	return true;
+}
+
 bool cfg80211_chandef_usable(struct wiphy *wiphy,
 			     const struct cfg80211_chan_def *chandef,
 			     u32 prohibited_flags)
 {
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_edmg *edmg_cap;
 	u32 width, control_freq, cap;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
@@ -734,6 +884,15 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 
 	ht_cap = &wiphy->bands[chandef->chan->band]->ht_cap;
 	vht_cap = &wiphy->bands[chandef->chan->band]->vht_cap;
+	edmg_cap = &wiphy->bands[chandef->chan->band]->edmg_cap;
+
+	if (edmg_cap->channels &&
+	    !cfg80211_edmg_usable(wiphy,
+				  chandef->edmg.channels,
+				  chandef->edmg.bw_config,
+				  chandef->chan->hw_value,
+				  edmg_cap))
+		return false;
 
 	control_freq = chandef->chan->center_freq;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index da3843a..ed8926e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -288,6 +288,13 @@ static int validate_ie_attr(const struct nlattr *attr,
 
 	[NL80211_ATTR_WIPHY_FREQ] = { .type = NLA_U32 },
 	[NL80211_ATTR_WIPHY_CHANNEL_TYPE] = { .type = NLA_U32 },
+	[NL80211_ATTR_WIPHY_EDMG_CHANNELS] = NLA_POLICY_RANGE(NLA_U8,
+						NL80211_EDMG_CHANNELS_MIN,
+						NL80211_EDMG_CHANNELS_MAX),
+	[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG] = NLA_POLICY_RANGE(NLA_U8,
+						NL80211_EDMG_BW_CONFIG_MIN,
+						NL80211_EDMG_BW_CONFIG_MAX),
+
 	[NL80211_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
 	[NL80211_ATTR_CENTER_FREQ1] = { .type = NLA_U32 },
 	[NL80211_ATTR_CENTER_FREQ2] = { .type = NLA_U32 },
@@ -1501,6 +1508,15 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 		nla_nest_end(msg, nl_iftype_data);
 	}
 
+	/* add EDMG info */
+	if (sband->edmg_cap.channels &&
+	    (nla_put_u8(msg, NL80211_BAND_ATTR_EDMG_CHANNELS,
+		       sband->edmg_cap.channels) ||
+	    nla_put_u8(msg, NL80211_BAND_ATTR_EDMG_BW_CONFIG,
+		       sband->edmg_cap.bw_config)))
+
+		return -ENOBUFS;
+
 	/* add bitrates */
 	nl_rates = nla_nest_start(msg, NL80211_BAND_ATTR_RATES);
 	if (!nl_rates)
@@ -2560,6 +2576,18 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ2]);
 	}
 
+	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
+		chandef->edmg.channels =
+		      nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
+
+		if (info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG])
+			chandef->edmg.bw_config =
+		     nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG]);
+	} else {
+		chandef->edmg.bw_config = 0;
+		chandef->edmg.channels = 0;
+	}
+
 	if (!cfg80211_chandef_valid(chandef)) {
 		NL_SET_ERR_MSG(extack, "invalid channel definition");
 		return -EINVAL;
@@ -9699,6 +9727,15 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
+		connect.edmg.channels =
+		      nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
+
+		if (info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG])
+			connect.edmg.bw_config =
+		     nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG]);
+	}
+
 	if (connect.privacy && info->attrs[NL80211_ATTR_KEYS]) {
 		connkeys = nl80211_parse_connkeys(rdev, info, NULL);
 		if (IS_ERR(connkeys))
diff --git a/net/wireless/util.c b/net/wireless/util.c
index cf63b63..7d06dd6 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1034,7 +1034,7 @@ static u32 cfg80211_calculate_bitrate_ht(struct rate_info *rate)
 	return (bitrate + 50000) / 100000;
 }
 
-static u32 cfg80211_calculate_bitrate_60g(struct rate_info *rate)
+static u32 cfg80211_calculate_bitrate_dmg(struct rate_info *rate)
 {
 	static const u32 __mcs2bitrate[] = {
 		/* control PHY */
@@ -1081,6 +1081,40 @@ static u32 cfg80211_calculate_bitrate_60g(struct rate_info *rate)
 	return __mcs2bitrate[rate->mcs];
 }
 
+static u32 cfg80211_calculate_bitrate_edmg(struct rate_info *rate)
+{
+	static const u32 __mcs2bitrate[] = {
+		/* control PHY */
+		[0] =   275,
+		/* SC PHY */
+		[1] =  3850,
+		[2] =  7700,
+		[3] =  9625,
+		[4] = 11550,
+		[5] = 12512, /* 1251.25 mbps */
+		[6] = 13475,
+		[7] = 15400,
+		[8] = 19250,
+		[9] = 23100,
+		[10] = 25025,
+		[11] = 26950,
+		[12] = 30800,
+		[13] = 38500,
+		[14] = 46200,
+		[15] = 50050,
+		[16] = 53900,
+		[17] = 57750,
+		[18] = 69300,
+		[19] = 75075,
+		[20] = 80850,
+	};
+
+	if (WARN_ON_ONCE(rate->mcs >= ARRAY_SIZE(__mcs2bitrate)))
+		return 0;
+
+	return __mcs2bitrate[rate->mcs] * rate->n_bonded_ch;
+}
+
 static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 {
 	static const u32 base[4][10] = {
@@ -1253,8 +1287,10 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 {
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
 		return cfg80211_calculate_bitrate_ht(rate);
-	if (rate->flags & RATE_INFO_FLAGS_60G)
-		return cfg80211_calculate_bitrate_60g(rate);
+	if (rate->flags & RATE_INFO_FLAGS_DMG)
+		return cfg80211_calculate_bitrate_dmg(rate);
+	if (rate->flags & RATE_INFO_FLAGS_EDMG)
+		return cfg80211_calculate_bitrate_edmg(rate);
 	if (rate->flags & RATE_INFO_FLAGS_VHT_MCS)
 		return cfg80211_calculate_bitrate_vht(rate);
 	if (rate->flags & RATE_INFO_FLAGS_HE_MCS)
-- 
1.9.1

