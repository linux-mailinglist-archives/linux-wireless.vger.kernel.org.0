Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289FF22F6B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfETIzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:22 -0400
Received: from nbd.name ([46.4.11.11]:41454 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731664AbfETIzW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:22 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4j-0002Y7-Ln; Mon, 20 May 2019 10:55:17 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V5 3/8] ath11k: move phymode selection from function to array lookup
Date:   Mon, 20 May 2019 10:55:03 +0200
Message-Id: <20190520085508.5888-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520085508.5888-1-john@phrozen.org>
References: <20190520085508.5888-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With HE support getting added, the approach of using functions will quickly
get convoluted. Change the code to use an array lookup function instead.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 117 ++++++++++++--------------
 include/uapi/linux/nl80211.h          |   4 +
 2 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cb0de8e2aa60..c5a55fb893ae 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -105,6 +105,52 @@ static struct ieee80211_rate ath11k_legacy_rates[] = {
 	{ .bitrate = 540, .hw_value = ATH11K_HW_RATE_OFDM_54M },
 };
 
+static const int
+ath11k_phymodes[NUM_NL80211_BANDS][2][__NL80211_CHAN_WIDTH_NUM] = {
+	[NL80211_BAND_2GHZ] = {
+		{
+			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11G,
+			[NL80211_CHAN_WIDTH_20] = MODE_11NG_HT20,
+			[NL80211_CHAN_WIDTH_40] = MODE_11NG_HT40,
+			[NL80211_CHAN_WIDTH_80] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_160] = MODE_UNKNOWN,
+		}, {
+			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11G,
+			[NL80211_CHAN_WIDTH_20] = MODE_11AX_HE20_2G,
+			[NL80211_CHAN_WIDTH_40] = MODE_11AX_HE40_2G,
+			[NL80211_CHAN_WIDTH_80] = MODE_11AX_HE80_2G,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_160] = MODE_UNKNOWN,
+		},
+	},
+	[NL80211_BAND_5GHZ] = {
+		{
+			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11A,
+			[NL80211_CHAN_WIDTH_20] = MODE_11AC_VHT20,
+			[NL80211_CHAN_WIDTH_40] = MODE_11AC_VHT40,
+			[NL80211_CHAN_WIDTH_80] = MODE_11AC_VHT80,
+			[NL80211_CHAN_WIDTH_160] = MODE_11AC_VHT160,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_11AC_VHT80_80,
+		}, {
+			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11A,
+			[NL80211_CHAN_WIDTH_20] = MODE_11AX_HE20,
+			[NL80211_CHAN_WIDTH_40] = MODE_11AX_HE40,
+			[NL80211_CHAN_WIDTH_80] = MODE_11AX_HE80,
+			[NL80211_CHAN_WIDTH_160] = MODE_11AX_HE160,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_11AX_HE80_80,
+		},
+	},
+};
+
 #define ATH11K_MAC_FIRST_OFDM_RATE_IDX 4
 #define ath11k_g_rates ath11k_legacy_rates
 #define ath11k_g_rates_size (ARRAY_SIZE(ath11k_legacy_rates))
@@ -151,69 +197,6 @@ static int get_num_chains(u32 mask)
 	return num_chains;
 }
 
-static inline enum wmi_phy_mode
-chan_to_phymode(const struct cfg80211_chan_def *chandef)
-{
-	enum wmi_phy_mode phymode = MODE_UNKNOWN;
-
-	switch (chandef->chan->band) {
-	case NL80211_BAND_2GHZ:
-		switch (chandef->width) {
-		case NL80211_CHAN_WIDTH_20_NOHT:
-			if (chandef->chan->flags & IEEE80211_CHAN_NO_OFDM)
-				phymode = MODE_11B;
-			else
-				phymode = MODE_11G;
-			break;
-		case NL80211_CHAN_WIDTH_20:
-			phymode = MODE_11NG_HT20;
-			break;
-		case NL80211_CHAN_WIDTH_40:
-			phymode = MODE_11NG_HT40;
-			break;
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
-		case NL80211_CHAN_WIDTH_80:
-		case NL80211_CHAN_WIDTH_80P80:
-		case NL80211_CHAN_WIDTH_160:
-			phymode = MODE_UNKNOWN;
-			break;
-		}
-		break;
-	case NL80211_BAND_5GHZ:
-		switch (chandef->width) {
-		case NL80211_CHAN_WIDTH_20_NOHT:
-			phymode = MODE_11A;
-			break;
-		case NL80211_CHAN_WIDTH_20:
-			phymode = MODE_11AC_VHT20;
-			break;
-		case NL80211_CHAN_WIDTH_40:
-			phymode = MODE_11AC_VHT40;
-			break;
-		case NL80211_CHAN_WIDTH_80:
-			phymode = MODE_11AC_VHT80;
-			break;
-		case NL80211_CHAN_WIDTH_160:
-			phymode = MODE_11AC_VHT160;
-			break;
-		case NL80211_CHAN_WIDTH_80P80:
-			phymode = MODE_11AC_VHT80_80;
-			break;
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
-			phymode = MODE_UNKNOWN;
-			break;
-		}
-		break;
-	default:
-		break;
-	}
-
-	WARN_ON(phymode == MODE_UNKNOWN);
-	return phymode;
-}
-
 u8 ath11k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
 			     u32 bitrate)
 {
@@ -3881,6 +3864,7 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	struct ath11k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
 	int ret = 0;
+	int he_support = arvif->vif->bss_conf.he_support;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -3893,7 +3877,12 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	arg.channel.freq = chandef->chan->center_freq;
 	arg.channel.band_center_freq1 = chandef->center_freq1;
 	arg.channel.band_center_freq2 = chandef->center_freq2;
-	arg.channel.mode = chan_to_phymode(chandef);
+	arg.channel.mode =
+		ath11k_phymodes[chandef->chan->band][he_support][chandef->width];
+	if (arg.channel.mode == MODE_11G &&
+	    chandef->chan->flags & IEEE80211_CHAN_NO_OFDM)
+		arg.channel.mode = MODE_11B;
+	WARN_ON(arg.channel.mode == MODE_UNKNOWN);
 
 	arg.channel.min_power = 0;
 	arg.channel.max_power = chandef->chan->max_power * 2;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dd4f86ee286e..b6e29161ec8b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4162,6 +4162,10 @@ enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_160,
 	NL80211_CHAN_WIDTH_5,
 	NL80211_CHAN_WIDTH_10,
+
+	/* keep last */
+	__NL80211_CHAN_WIDTH_NUM,
+	NL80211_CHAN_WIDTH_MAX = __NL80211_CHAN_WIDTH_NUM - 1,
 };
 
 /**
-- 
2.20.1

