Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB4255131
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgH0Wdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:52 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50640 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728084AbgH0Wdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 1190F4F809F;
        Thu, 27 Aug 2020 22:33:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0iqWw6X5ti-G; Thu, 27 Aug 2020 22:33:46 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 50B864F824E;
        Thu, 27 Aug 2020 22:33:14 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 21/22] mac80211_hwsim: indicate support for S1G
Date:   Thu, 27 Aug 2020 15:33:03 -0700
Message-Id: <20200827223304.16155-22-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Advertise S1G Capabilities and channels to mac80211.

Requires a few fixups to account for missing
sband->bitrates, and a custom regulatory db to actually
enable the S1G channels.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 80 ++++++++++++++++++++++++---
 include/linux/ieee80211.h             | 12 +++-
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 9dd9d73f4484..ee2f3a008e01 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -377,6 +377,50 @@ static const struct ieee80211_channel hwsim_channels_5ghz[] = {
 	CHAN5G(5925), /* Channel 185 */
 };
 
+#define NUM_S1G_CHANS_US 51
+static struct ieee80211_channel hwsim_channels_s1g[NUM_S1G_CHANS_US];
+
+static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
+	.s1g = true,
+	.cap = { S1G_CAPAB_B0_SGI_1MHZ | S1G_CAPAB_B0_SGI_2MHZ |
+		 SM(S1G_CAPAB_B0_SUPP_CH_WIDTH, S1G_SUPP_CH_WIDTH_2),
+		 0,
+		 0,
+		 S1G_CAPAB_B3_MAX_MPDU_LEN,
+		 0,
+		 S1G_CAPAB_B5_AMPDU,
+		 0,
+		 S1G_CAPAB_B7_DUP_1MHZ,
+		 S1G_CAPAB_B8_TWT_RESPOND | S1G_CAPAB_B8_TWT_REQUEST,
+		 0},
+	.nss_mcs = { 0xfc | 1, /* MCS 7 for 1 SS */
+	/* RX Highest Supported Long GI Data Rate 0:7 */
+		     0,
+	/* RX Highest Supported Long GI Data Rate 0:7 */
+	/* TX S1G MCS Map 0:6 */
+		     0xfa,
+	/* TX S1G MCS Map :7 */
+	/* TX Highest Supported Long GI Data Rate 0:6 */
+		     0x80,
+	/* TX Highest Supported Long GI Data Rate 7:8 */
+	/* Rx Single spatial stream and S1G-MCS Map for 1MHz */
+	/* Tx Single spatial stream and S1G-MCS Map for 1MHz */
+		     0 },
+};
+
+static void hwsim_init_s1g_channels(struct ieee80211_channel *channels)
+{
+	int ch, freq;
+
+	for (ch = 0; ch < NUM_S1G_CHANS_US; ch++) {
+		freq = 902000 + (ch + 1) * 500;
+		channels[ch].band = NL80211_BAND_S1GHZ;
+		channels[ch].center_freq = KHZ_TO_MHZ(freq);
+		channels[ch].freq_offset = freq % 1000;
+		channels[ch].hw_value = ch + 1;
+	}
+}
+
 static const struct ieee80211_rate hwsim_rates[] = {
 	{ .bitrate = 10 },
 	{ .bitrate = 20, .flags = IEEE80211_RATE_SHORT_PREAMBLE },
@@ -505,6 +549,7 @@ struct mac80211_hwsim_data {
 	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
 	struct ieee80211_channel channels_2ghz[ARRAY_SIZE(hwsim_channels_2ghz)];
 	struct ieee80211_channel channels_5ghz[ARRAY_SIZE(hwsim_channels_5ghz)];
+	struct ieee80211_channel channels_s1g[ARRAY_SIZE(hwsim_channels_s1g)];
 	struct ieee80211_rate rates[ARRAY_SIZE(hwsim_rates)];
 	struct ieee80211_iface_combination if_combination;
 	struct ieee80211_iface_limit if_limits[3];
@@ -900,12 +945,14 @@ static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
 	struct mac80211_hwsim_data *data = hw->priv;
 	struct sk_buff *skb;
 	struct hwsim_radiotap_hdr *hdr;
-	u16 flags;
+	u16 flags, bitrate;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_skb);
 	struct ieee80211_rate *txrate = ieee80211_get_tx_rate(hw, info);
 
-	if (WARN_ON(!txrate))
-		return;
+	if (!txrate)
+		bitrate = 0;
+	else
+		bitrate = txrate->bitrate;
 
 	if (!netif_running(hwsim_mon))
 		return;
@@ -924,10 +971,10 @@ static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
 					  (1 << IEEE80211_RADIOTAP_CHANNEL));
 	hdr->rt_tsft = __mac80211_hwsim_get_tsf(data);
 	hdr->rt_flags = 0;
-	hdr->rt_rate = txrate->bitrate / 5;
+	hdr->rt_rate = bitrate / 5;
 	hdr->rt_channel = cpu_to_le16(chan->center_freq);
 	flags = IEEE80211_CHAN_2GHZ;
-	if (txrate->flags & IEEE80211_RATE_ERP_G)
+	if (txrate && txrate->flags & IEEE80211_RATE_ERP_G)
 		flags |= IEEE80211_CHAN_OFDM;
 	else
 		flags |= IEEE80211_CHAN_CCK;
@@ -1341,6 +1388,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
 	rx_status.freq = chan->center_freq;
+	rx_status.freq_offset = chan->freq_offset ? 1 : 0;
 	rx_status.band = chan->band;
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_VHT_MCS) {
 		rx_status.rate_idx =
@@ -1522,14 +1570,18 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		/* fake header transmission time */
 		struct ieee80211_mgmt *mgmt;
 		struct ieee80211_rate *txrate;
+		/* TODO: get MCS */
+		int bitrate = 100;
 		u64 ts;
 
 		mgmt = (struct ieee80211_mgmt *)skb->data;
 		txrate = ieee80211_get_tx_rate(hw, txi);
+		if (txrate)
+			bitrate = txrate->bitrate;
 		ts = mac80211_hwsim_get_tsf_raw();
 		mgmt->u.probe_resp.timestamp =
 			cpu_to_le64(ts + data->tsf_offset +
-				    24 * 8 * 10 / txrate->bitrate);
+				    24 * 8 * 10 / bitrate);
 	}
 
 	mac80211_hwsim_monitor_rx(hw, skb, channel);
@@ -1664,6 +1716,8 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	struct ieee80211_rate *txrate;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
+	/* TODO: get MCS */
+	int bitrate = 100;
 
 	hwsim_check_magic(vif);
 
@@ -1683,13 +1737,15 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 				       ARRAY_SIZE(info->control.rates));
 
 	txrate = ieee80211_get_tx_rate(hw, info);
+	if (txrate)
+		bitrate = txrate->bitrate;
 
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	/* fake header transmission time */
 	data->abs_bcn_ts = mac80211_hwsim_get_tsf_raw();
 	mgmt->u.beacon.timestamp = cpu_to_le64(data->abs_bcn_ts +
 					       data->tsf_offset +
-					       24 * 8 * 10 / txrate->bitrate);
+					       24 * 8 * 10 / bitrate);
 
 	mac80211_hwsim_tx_frame(hw, skb,
 				rcu_dereference(vif->chanctx_conf)->def.chan);
@@ -3079,6 +3135,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		sizeof(hwsim_channels_2ghz));
 	memcpy(data->channels_5ghz, hwsim_channels_5ghz,
 		sizeof(hwsim_channels_5ghz));
+	memcpy(data->channels_s1g, hwsim_channels_s1g,
+	       sizeof(hwsim_channels_s1g));
 	memcpy(data->rates, hwsim_rates, sizeof(hwsim_rates));
 
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
@@ -3121,6 +3179,12 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			sband->vht_cap.vht_mcs.tx_mcs_map =
 				sband->vht_cap.vht_mcs.rx_mcs_map;
 			break;
+		case NL80211_BAND_S1GHZ:
+			memcpy(&sband->s1g_cap, &hwsim_s1g_cap,
+			       sizeof(sband->s1g_cap));
+			sband->channels = data->channels_s1g;
+			sband->n_channels = ARRAY_SIZE(hwsim_channels_s1g);
+			break;
 		default:
 			continue;
 		}
@@ -4318,6 +4382,8 @@ static int __init init_mac80211_hwsim(void)
 		goto out_exit_virtio;
 	}
 
+	hwsim_init_s1g_channels(hwsim_channels_s1g);
+
 	for (i = 0; i < radios; i++) {
 		struct hwsim_new_radio_params param = { 0 };
 
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 5cff6a373158..e2198453ecb6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2385,6 +2385,9 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 	return spr_len;
 }
 
+#define SM(f, v)	(((v) << f##_SHIFT) & f)
+#define MS(f, v)	(((v) & f) >> f##_SHIFT)
+
 /* S1G Capabilities Information field */
 #define S1G_CAPAB_B0_S1G_LONG BIT(0)
 #define S1G_CAPAB_B0_SGI_1MHZ BIT(1)
@@ -2392,9 +2395,16 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define S1G_CAPAB_B0_SGI_4MHZ BIT(3)
 #define S1G_CAPAB_B0_SGI_8MHZ BIT(4)
 #define S1G_CAPAB_B0_SGI_16MHZ BIT(5)
-#define S1G_CAPAB_B0_SUPP_CH_WIDTH_MASK (BIT(6) | BIT(7))
+#define S1G_CAPAB_B0_SUPP_CH_WIDTH	(BIT(6) | BIT(7))
 #define S1G_CAPAB_B0_SUPP_CH_WIDTH_SHIFT 6
 
+#define S1G_SUPP_CH_WIDTH_2	0
+#define S1G_SUPP_CH_WIDTH_4	1
+#define S1G_SUPP_CH_WIDTH_8	2
+#define S1G_SUPP_CH_WIDTH_16	3
+#define S1G_SUPP_CH_WIDTH_MAX(cap) ((1 << MS(S1G_CAPAB_B0_SUPP_CH_WIDTH, \
+					     cap[0])) << 1)
+
 #define S1G_CAPAB_B1_RX_LDPC BIT(0)
 #define S1G_CAPAB_B1_TX_STBC BIT(1)
 #define S1G_CAPAB_B1_RX_STBC BIT(2)
-- 
2.20.1

