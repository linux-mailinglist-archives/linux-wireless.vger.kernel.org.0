Return-Path: <linux-wireless+bounces-30469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D2CFFF11
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0415430D393A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FF33C515;
	Wed,  7 Jan 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LXwIGHwc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6733A712
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795823; cv=none; b=HI0ofd0CvUDMYG8h0TGNX9nZ/qc+FmTZODC7R3n98t+gY/jlkYaOEPIWJj9WNolqtic8cEJZdbol0joI+w7DITHEuptFoS1V4rKsdXXw2EL7hc7lGfiMG928soAfU0+1YOsx39246Vv1YeYdWrzTZ+3OMEjNgvk6R/FgjFIXDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795823; c=relaxed/simple;
	bh=cfjEt6dK+6fzyVN2P/U1hZQ8dFMAO/o/sqXZe6gXLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4OjvJIYyNREI5l7HgKG5ujQXbKmaXZe+qu0bx2wnsfhzFO2qgW6aXDup/74rkIxA6R9MC9KdOv5v8O1BH6f6IlKfDzF6rHdMjV1QgHmzb3zprpl4OXvoE81DXV2G9JTZk2sRXeLh/L7hrkuqEeAWuH6lhP++y4D4YD4F8RGSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LXwIGHwc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iGHD3khavFQklNnLli/iEUxLqVA6AJiecsSUr/Yh5vQ=;
	t=1767795821; x=1769005421; b=LXwIGHwcjLQqDSER3OCdzCOm//IrBrGf4hivOhDRaWZtjU+
	5tHNg2Cpj68lQBRJTUPWJMkzm8XbLrsXeP628q1ujBsPUb5zX80jarFX7b+P2JEaq5DHc6z4CwXuN
	BOiALmAn+vd6U3s2Q/Qxdy+9/2Y+GD1mCIue+gJeAQ6tlursn12I9HwqDcpsdBy9trcF/8YVw426/
	4aAULBb90vvzadAU2qxMtJb9R9kaeSO4R+KbwWOAP+bfvM+Ovmktmqpw8OWEOFLnkY2kwRNPCvoVo
	wBF6QPKAixBemhGW7GRSSLhM48Sb4731U/2bTT+fDMtlB4dJ5FOL6jok4FcBw0zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURm-00000005agF-1zxW;
	Wed, 07 Jan 2026 15:23:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 06/46] wifi: mac80211_hwsim: split NAN handling into separate file
Date: Wed,  7 Jan 2026 15:22:05 +0100
Message-ID: <20260107152324.4475c625d840.I9484d746286eb2ab71ac987dfb907497d213c2bb@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Having everything in one file for mac80211_hwsim is starting to get a
lot and it will be even worse if we implement more parts of NAN. Split
the NAN implementation into separate files to improve the code
structuring.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/Makefile         |   2 +
 .../net/wireless/virtual/mac80211_hwsim_i.h   | 136 ++++++++
 ...mac80211_hwsim.c => mac80211_hwsim_main.c} | 307 ++----------------
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 171 ++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  34 ++
 5 files changed, 363 insertions(+), 287 deletions(-)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_i.h
 rename drivers/net/wireless/virtual/{mac80211_hwsim.c => mac80211_hwsim_main.c} (96%)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.h

diff --git a/drivers/net/wireless/virtual/Makefile b/drivers/net/wireless/virtual/Makefile
index 5773cc6d643e..6ad860dd7643 100644
--- a/drivers/net/wireless/virtual/Makefile
+++ b/drivers/net/wireless/virtual/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211_hwsim.o
+mac80211_hwsim-objs		+= mac80211_hwsim_main.o
+mac80211_hwsim-objs		+= mac80211_hwsim_nan.o
 
 obj-$(CONFIG_VIRT_WIFI)	+= virt_wifi.o
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
new file mode 100644
index 000000000000..e1a36eb7a3d5
--- /dev/null
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mac80211_hwsim - software simulator of 802.11 radio(s) for mac80211
+ * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
+ * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
+ * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright (C) 2018 - 2025 Intel Corporation
+ */
+
+#ifndef __MAC80211_HWSIM_I_H
+#define __MAC80211_HWSIM_I_H
+
+#include <net/mac80211.h>
+#include "mac80211_hwsim.h"
+#include "mac80211_hwsim_nan.h"
+
+struct mac80211_hwsim_link_data {
+	u32 link_id;
+	u64 beacon_int	/* beacon interval in us */;
+	struct hrtimer beacon_timer;
+};
+
+#define HWSIM_NUM_CHANNELS_2GHZ		14
+#define HWSIM_NUM_CHANNELS_5GHZ		40
+#define HWSIM_NUM_CHANNELS_6GHZ		59
+#define HWSIM_NUM_S1G_CHANNELS_US	51
+#define HWSIM_NUM_RATES			12
+#define HWSIM_NUM_CIPHERS		11
+
+struct mac80211_hwsim_data {
+	struct list_head list;
+	struct rhash_head rht;
+	struct ieee80211_hw *hw;
+	struct device *dev;
+	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
+	struct ieee80211_channel channels_2ghz[HWSIM_NUM_CHANNELS_2GHZ];
+	struct ieee80211_channel channels_5ghz[HWSIM_NUM_CHANNELS_5GHZ];
+	struct ieee80211_channel channels_6ghz[HWSIM_NUM_CHANNELS_6GHZ];
+	struct ieee80211_channel channels_s1g[HWSIM_NUM_S1G_CHANNELS_US];
+	struct ieee80211_rate rates[HWSIM_NUM_RATES];
+	struct ieee80211_iface_combination if_combination;
+	struct ieee80211_iface_limit if_limits[4];
+	int n_if_limits;
+	/* Storage space for channels, etc. */
+	struct mac80211_hwsim_phy_data *phy_data;
+
+	struct ieee80211_iface_combination if_combination_radio;
+	struct wiphy_radio_freq_range radio_range[NUM_NL80211_BANDS];
+	struct wiphy_radio radio[NUM_NL80211_BANDS];
+
+	u32 ciphers[HWSIM_NUM_CIPHERS];
+
+	struct mac_address addresses[3];
+	int channels, idx;
+	bool use_chanctx;
+	bool destroy_on_close;
+	u32 portid;
+	char alpha2[2];
+	const struct ieee80211_regdomain *regd;
+
+	struct ieee80211_channel *tmp_chan;
+	struct ieee80211_channel *roc_chan;
+	u32 roc_duration;
+	struct delayed_work roc_start;
+	struct delayed_work roc_done;
+	struct delayed_work hw_scan;
+	struct cfg80211_scan_request *hw_scan_request;
+	struct ieee80211_vif *hw_scan_vif;
+	int scan_chan_idx;
+	u8 scan_addr[ETH_ALEN];
+	struct {
+		struct ieee80211_channel *channel;
+		unsigned long next_start, start, end;
+	} survey_data[HWSIM_NUM_CHANNELS_2GHZ +
+		      HWSIM_NUM_CHANNELS_5GHZ +
+		      HWSIM_NUM_CHANNELS_6GHZ];
+
+	struct ieee80211_channel *channel;
+	enum nl80211_chan_width bw;
+	unsigned int rx_filter;
+	bool started, idle, scanning;
+	struct mutex mutex;
+	enum ps_mode {
+		PS_DISABLED, PS_ENABLED, PS_AUTO_POLL, PS_MANUAL_POLL
+	} ps;
+	bool ps_poll_pending;
+	struct dentry *debugfs;
+
+	atomic_t pending_cookie;
+	struct sk_buff_head pending;	/* packets pending */
+	/*
+	 * Only radios in the same group can communicate together (the
+	 * channel has to match too). Each bit represents a group. A
+	 * radio can be in more than one group.
+	 */
+	u64 group;
+
+	/* group shared by radios created in the same netns */
+	int netgroup;
+	/* wmediumd portid responsible for netgroup of this radio */
+	u32 wmediumd;
+
+	/* difference between this hw's clock and the real clock, in usecs */
+	s64 tsf_offset;
+	s64 bcn_delta;
+	/* absolute beacon transmission time. Used to cover up "tx" delay. */
+	u64 abs_bcn_ts;
+
+	/* Stats */
+	u64 tx_pkts;
+	u64 rx_pkts;
+	u64 tx_bytes;
+	u64 rx_bytes;
+	u64 tx_dropped;
+	u64 tx_failed;
+
+	/* RSSI in rx status of the receiver */
+	int rx_rssi;
+
+	/* only used when pmsr capability is supplied */
+	struct cfg80211_pmsr_capabilities pmsr_capa;
+	struct cfg80211_pmsr_request *pmsr_request;
+	struct wireless_dev *pmsr_request_wdev;
+
+	struct mac80211_hwsim_link_data link_data[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	struct mac80211_hwsim_nan_data nan;
+};
+
+extern spinlock_t hwsim_radio_lock;
+extern struct list_head hwsim_radios;
+
+u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif);
+
+#endif /* __MAC80211_HWSIM_I_H */
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
similarity index 96%
rename from drivers/net/wireless/virtual/mac80211_hwsim.c
rename to drivers/net/wireless/virtual/mac80211_hwsim_main.c
index f4ceb9e3042c..d933e91d7700 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -36,7 +36,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
-#include "mac80211_hwsim.h"
+#include "mac80211_hwsim_i.h"
 
 #define WARN_QUEUE 100
 #define MAX_QUEUE 200
@@ -375,6 +375,8 @@ static const struct ieee80211_channel hwsim_channels_2ghz[] = {
 	CHAN2G(2472), /* Channel 13 */
 	CHAN2G(2484), /* Channel 14 */
 };
+static_assert(HWSIM_NUM_CHANNELS_2GHZ == ARRAY_SIZE(hwsim_channels_2ghz),
+	      "Inconsistent 2 GHz channel count");
 
 static const struct ieee80211_channel hwsim_channels_5ghz[] = {
 	CHAN5G(5180), /* Channel 36 */
@@ -424,6 +426,8 @@ static const struct ieee80211_channel hwsim_channels_5ghz[] = {
 	CHAN5G(5920), /* Channel 184 */
 	CHAN5G(5925), /* Channel 185 */
 };
+static_assert(HWSIM_NUM_CHANNELS_5GHZ == ARRAY_SIZE(hwsim_channels_5ghz),
+	      "Inconsistent 5 GHz channel count");
 
 static const struct ieee80211_channel hwsim_channels_6ghz[] = {
 	CHAN6G(5955), /* Channel 1 */
@@ -486,9 +490,10 @@ static const struct ieee80211_channel hwsim_channels_6ghz[] = {
 	CHAN6G(7095), /* Channel 229 */
 	CHAN6G(7115), /* Channel 233 */
 };
+static_assert(HWSIM_NUM_CHANNELS_6GHZ == ARRAY_SIZE(hwsim_channels_6ghz),
+	      "Inconsistent 6 GHz channel count");
 
-#define NUM_S1G_CHANS_US 51
-static struct ieee80211_channel hwsim_channels_s1g[NUM_S1G_CHANS_US];
+static struct ieee80211_channel hwsim_channels_s1g[HWSIM_NUM_S1G_CHANNELS_US];
 
 static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 	.s1g = true,
@@ -521,7 +526,7 @@ static void hwsim_init_s1g_channels(struct ieee80211_channel *chans)
 {
 	int ch, freq;
 
-	for (ch = 0; ch < NUM_S1G_CHANS_US; ch++) {
+	for (ch = 0; ch < ARRAY_SIZE(hwsim_channels_s1g); ch++) {
 		freq = 902000 + (ch + 1) * 500;
 		chans[ch].band = NL80211_BAND_S1GHZ;
 		chans[ch].center_freq = KHZ_TO_MHZ(freq);
@@ -544,6 +549,8 @@ static const struct ieee80211_rate hwsim_rates[] = {
 	{ .bitrate = 480 },
 	{ .bitrate = 540 }
 };
+static_assert(HWSIM_NUM_RATES == ARRAY_SIZE(hwsim_rates),
+	      "Inconsistent rates count");
 
 #define DEFAULT_RX_RSSI -50
 
@@ -560,6 +567,8 @@ static const u32 hwsim_ciphers[] = {
 	WLAN_CIPHER_SUITE_BIP_GMAC_128,
 	WLAN_CIPHER_SUITE_BIP_GMAC_256,
 };
+static_assert(HWSIM_NUM_CIPHERS == ARRAY_SIZE(hwsim_ciphers),
+	      "Inconsistent cipher count");
 
 #define OUI_QCA 0x001374
 #define QCA_NL80211_SUBCMD_TEST 1
@@ -640,12 +649,11 @@ static const struct nl80211_vendor_cmd_info mac80211_hwsim_vendor_events[] = {
 	{ .vendor_id = OUI_QCA, .subcmd = 1 },
 };
 
-static DEFINE_SPINLOCK(hwsim_radio_lock);
-static LIST_HEAD(hwsim_radios);
+DEFINE_SPINLOCK(hwsim_radio_lock);
+LIST_HEAD(hwsim_radios);
 static struct rhashtable hwsim_radios_rht;
 static int hwsim_radio_idx;
 static int hwsim_radios_generation = 1;
-static u8 hwsim_nan_cluster_id[ETH_ALEN];
 
 static struct platform_driver mac80211_hwsim_driver = {
 	.driver = {
@@ -653,119 +661,6 @@ static struct platform_driver mac80211_hwsim_driver = {
 	},
 };
 
-struct mac80211_hwsim_link_data {
-	u32 link_id;
-	u64 beacon_int	/* beacon interval in us */;
-	struct hrtimer beacon_timer;
-};
-
-struct mac80211_hwsim_nan_data {
-	struct ieee80211_vif *device_vif;
-	u8 bands;
-
-	enum nl80211_band curr_dw_band;
-	struct hrtimer timer;
-	bool notify_dw;
-};
-
-struct mac80211_hwsim_data {
-	struct list_head list;
-	struct rhash_head rht;
-	struct ieee80211_hw *hw;
-	struct device *dev;
-	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
-	struct ieee80211_channel channels_2ghz[ARRAY_SIZE(hwsim_channels_2ghz)];
-	struct ieee80211_channel channels_5ghz[ARRAY_SIZE(hwsim_channels_5ghz)];
-	struct ieee80211_channel channels_6ghz[ARRAY_SIZE(hwsim_channels_6ghz)];
-	struct ieee80211_channel channels_s1g[ARRAY_SIZE(hwsim_channels_s1g)];
-	struct ieee80211_rate rates[ARRAY_SIZE(hwsim_rates)];
-	struct ieee80211_iface_combination if_combination;
-	struct ieee80211_iface_limit if_limits[4];
-	int n_if_limits;
-
-	struct ieee80211_iface_combination if_combination_radio;
-	struct wiphy_radio_freq_range radio_range[NUM_NL80211_BANDS];
-	struct wiphy_radio radio[NUM_NL80211_BANDS];
-
-	u32 ciphers[ARRAY_SIZE(hwsim_ciphers)];
-
-	struct mac_address addresses[3];
-	int channels, idx;
-	bool use_chanctx;
-	bool destroy_on_close;
-	u32 portid;
-	char alpha2[2];
-	const struct ieee80211_regdomain *regd;
-
-	struct ieee80211_channel *tmp_chan;
-	struct ieee80211_channel *roc_chan;
-	u32 roc_duration;
-	struct delayed_work roc_start;
-	struct delayed_work roc_done;
-	struct delayed_work hw_scan;
-	struct cfg80211_scan_request *hw_scan_request;
-	struct ieee80211_vif *hw_scan_vif;
-	int scan_chan_idx;
-	u8 scan_addr[ETH_ALEN];
-	struct {
-		struct ieee80211_channel *channel;
-		unsigned long next_start, start, end;
-	} survey_data[ARRAY_SIZE(hwsim_channels_2ghz) +
-		      ARRAY_SIZE(hwsim_channels_5ghz) +
-		      ARRAY_SIZE(hwsim_channels_6ghz)];
-
-	struct ieee80211_channel *channel;
-	enum nl80211_chan_width bw;
-	unsigned int rx_filter;
-	bool started, idle, scanning;
-	struct mutex mutex;
-	enum ps_mode {
-		PS_DISABLED, PS_ENABLED, PS_AUTO_POLL, PS_MANUAL_POLL
-	} ps;
-	bool ps_poll_pending;
-	struct dentry *debugfs;
-
-	atomic_t pending_cookie;
-	struct sk_buff_head pending;	/* packets pending */
-	/*
-	 * Only radios in the same group can communicate together (the
-	 * channel has to match too). Each bit represents a group. A
-	 * radio can be in more than one group.
-	 */
-	u64 group;
-
-	/* group shared by radios created in the same netns */
-	int netgroup;
-	/* wmediumd portid responsible for netgroup of this radio */
-	u32 wmediumd;
-
-	/* difference between this hw's clock and the real clock, in usecs */
-	s64 tsf_offset;
-	s64 bcn_delta;
-	/* absolute beacon transmission time. Used to cover up "tx" delay. */
-	u64 abs_bcn_ts;
-
-	/* Stats */
-	u64 tx_pkts;
-	u64 rx_pkts;
-	u64 tx_bytes;
-	u64 rx_bytes;
-	u64 tx_dropped;
-	u64 tx_failed;
-
-	/* RSSI in rx status of the receiver */
-	int rx_rssi;
-
-	/* only used when pmsr capability is supplied */
-	struct cfg80211_pmsr_capabilities pmsr_capa;
-	struct cfg80211_pmsr_request *pmsr_request;
-	struct wireless_dev *pmsr_request_wdev;
-
-	struct mac80211_hwsim_link_data link_data[IEEE80211_MLD_MAX_NUM_LINKS];
-
-	struct mac80211_hwsim_nan_data nan;
-};
-
 static const struct rhashtable_params hwsim_rht_params = {
 	.nelem_hint = 2,
 	.automatic_shrinking = true,
@@ -1227,8 +1122,8 @@ static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
 	return cpu_to_le64(now + data->tsf_offset);
 }
 
-static u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
-				  struct ieee80211_vif *vif)
+u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	return le64_to_cpu(__mac80211_hwsim_get_tsf(data));
@@ -3995,168 +3890,6 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	return err;
 }
 
-static enum hrtimer_restart
-mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
-{
-	struct mac80211_hwsim_data *data =
-		container_of(timer, struct mac80211_hwsim_data,
-			     nan.timer);
-	struct ieee80211_hw *hw = data->hw;
-	u64 orig_tsf = mac80211_hwsim_get_tsf(hw, NULL), tsf = orig_tsf;
-	u32 dw_int = 512 * 1024;
-	u64 until_dw;
-
-	if (!data->nan.device_vif)
-		return HRTIMER_NORESTART;
-
-	if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
-		if (data->nan.curr_dw_band == NL80211_BAND_2GHZ) {
-			dw_int = 128 * 1024;
-			data->nan.curr_dw_band = NL80211_BAND_5GHZ;
-		} else if (data->nan.curr_dw_band == NL80211_BAND_5GHZ) {
-			data->nan.curr_dw_band = NL80211_BAND_2GHZ;
-		}
-	}
-
-	until_dw = dw_int - do_div(tsf, dw_int);
-
-	/* The timer might fire just before the actual DW, in which case
-	 * update the timeout to the actual next DW
-	 */
-	if (until_dw < dw_int / 2)
-		until_dw += dw_int;
-
-	/* The above do_div() call directly modifies the 'tsf' variable, thus,
-	 * use a copy so that the print below would show the original TSF.
-	 */
-	wiphy_debug(hw->wiphy,
-		    "%s: tsf=%llx, curr_dw_band=%u, next_dw=%llu\n",
-		    __func__, orig_tsf, data->nan.curr_dw_band,
-		    until_dw);
-
-	hrtimer_forward_now(&data->nan.timer,
-			    ns_to_ktime(until_dw * NSEC_PER_USEC));
-
-	if (data->nan.notify_dw) {
-		struct ieee80211_channel *ch;
-		struct wireless_dev *wdev =
-			ieee80211_vif_to_wdev(data->nan.device_vif);
-
-		if (data->nan.curr_dw_band == NL80211_BAND_5GHZ)
-			ch = ieee80211_get_channel(hw->wiphy, 5475);
-		else
-			ch = ieee80211_get_channel(hw->wiphy, 2437);
-
-		cfg80211_next_nan_dw_notif(wdev, ch, GFP_ATOMIC);
-	}
-
-	return HRTIMER_RESTART;
-}
-
-static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct cfg80211_nan_conf *conf)
-{
-	struct mac80211_hwsim_data *data = hw->priv;
-	u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
-	u32 dw_int = 512 * 1000;
-	u64 until_dw = dw_int - do_div(tsf, dw_int);
-	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
-
-	if (vif->type != NL80211_IFTYPE_NAN)
-		return -EINVAL;
-
-	if (data->nan.device_vif)
-		return -EALREADY;
-
-	/* set this before starting the timer, as preemption might occur */
-	data->nan.device_vif = vif;
-	data->nan.bands = conf->bands;
-	data->nan.curr_dw_band = NL80211_BAND_2GHZ;
-
-	wiphy_debug(hw->wiphy, "nan_started, next_dw=%llu\n",
-		    until_dw);
-
-	hrtimer_start(&data->nan.timer,
-		      ns_to_ktime(until_dw * NSEC_PER_USEC),
-		      HRTIMER_MODE_REL_SOFT);
-
-	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
-	    is_zero_ether_addr(hwsim_nan_cluster_id)) {
-		memcpy(hwsim_nan_cluster_id, conf->cluster_id, ETH_ALEN);
-	} else if (is_zero_ether_addr(hwsim_nan_cluster_id)) {
-		hwsim_nan_cluster_id[0] = 0x50;
-		hwsim_nan_cluster_id[1] = 0x6f;
-		hwsim_nan_cluster_id[2] = 0x9a;
-		hwsim_nan_cluster_id[3] = 0x01;
-		hwsim_nan_cluster_id[4] = get_random_u8();
-		hwsim_nan_cluster_id[5] = get_random_u8();
-	}
-
-	data->nan.notify_dw = conf->enable_dw_notification;
-
-	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
-				    GFP_KERNEL);
-
-	return 0;
-}
-
-static int mac80211_hwsim_stop_nan(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif)
-{
-	struct mac80211_hwsim_data *data = hw->priv;
-	struct mac80211_hwsim_data *data2;
-	bool nan_cluster_running = false;
-
-	if (vif->type != NL80211_IFTYPE_NAN || !data->nan.device_vif ||
-	    data->nan.device_vif != vif)
-		return -EINVAL;
-
-	hrtimer_cancel(&data->nan.timer);
-	data->nan.device_vif = NULL;
-
-	spin_lock(&hwsim_radio_lock);
-	list_for_each_entry(data2, &hwsim_radios, list) {
-		if (data2->nan.device_vif) {
-			nan_cluster_running = true;
-			break;
-		}
-	}
-	spin_unlock(&hwsim_radio_lock);
-
-	if (!nan_cluster_running)
-		memset(hwsim_nan_cluster_id, 0, ETH_ALEN);
-
-	return 0;
-}
-
-static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
-					    struct ieee80211_vif *vif,
-					    struct cfg80211_nan_conf *conf,
-					    u32 changes)
-{
-	struct mac80211_hwsim_data *data = hw->priv;
-
-	if (vif->type != NL80211_IFTYPE_NAN)
-		return -EINVAL;
-
-	if (!data->nan.device_vif)
-		return -EINVAL;
-
-	wiphy_debug(hw->wiphy, "nan_config_changed: changes=0x%x\n", changes);
-
-	/* Handle only the changes we care about for simulation purposes */
-	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS) {
-		data->nan.bands = conf->bands;
-		data->nan.curr_dw_band = NL80211_BAND_2GHZ;
-	}
-
-	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG)
-		data->nan.notify_dw = conf->enable_dw_notification;
-
-	return 0;
-}
-
 #ifdef CONFIG_MAC80211_DEBUGFS
 #define HWSIM_DEBUGFS_OPS					\
 	.link_add_debugfs = mac80211_hwsim_link_add_debugfs,
@@ -4189,9 +3922,9 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.get_et_strings = mac80211_hwsim_get_et_strings,	\
 	.start_pmsr = mac80211_hwsim_start_pmsr,		\
 	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
-	.start_nan = mac80211_hwsim_start_nan,                  \
-	.stop_nan = mac80211_hwsim_stop_nan,                    \
-	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.start_nan = mac80211_hwsim_nan_start,			\
+	.stop_nan = mac80211_hwsim_nan_stop,			\
+	.nan_change_conf = mac80211_hwsim_nan_change_config,	\
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
new file mode 100644
index 000000000000..5d7c736d7972
--- /dev/null
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mac80211_hwsim_nan - NAN software simulation for mac80211_hwsim
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include "mac80211_hwsim_i.h"
+
+static u8 hwsim_nan_cluster_id[ETH_ALEN];
+
+enum hrtimer_restart
+mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
+{
+	struct mac80211_hwsim_data *data =
+		container_of(timer, struct mac80211_hwsim_data,
+			     nan.timer);
+	struct ieee80211_hw *hw = data->hw;
+	u64 orig_tsf = mac80211_hwsim_get_tsf(hw, NULL), tsf = orig_tsf;
+	u32 dw_int = 512 * 1024;
+	u64 until_dw;
+
+	if (!data->nan.device_vif)
+		return HRTIMER_NORESTART;
+
+	if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
+		if (data->nan.curr_dw_band == NL80211_BAND_2GHZ) {
+			dw_int = 128 * 1024;
+			data->nan.curr_dw_band = NL80211_BAND_5GHZ;
+		} else if (data->nan.curr_dw_band == NL80211_BAND_5GHZ) {
+			data->nan.curr_dw_band = NL80211_BAND_2GHZ;
+		}
+	}
+
+	until_dw = dw_int - do_div(tsf, dw_int);
+
+	/* The timer might fire just before the actual DW, in which case
+	 * update the timeout to the actual next DW
+	 */
+	if (until_dw < dw_int / 2)
+		until_dw += dw_int;
+
+	/* The above do_div() call directly modifies the 'tsf' variable, thus,
+	 * use a copy so that the print below would show the original TSF.
+	 */
+	wiphy_debug(hw->wiphy,
+		    "%s: tsf=%llx, curr_dw_band=%u, next_dw=%llu\n",
+		    __func__, orig_tsf, data->nan.curr_dw_band,
+		    until_dw);
+
+	hrtimer_forward_now(&data->nan.timer,
+			    ns_to_ktime(until_dw * NSEC_PER_USEC));
+
+	if (data->nan.notify_dw) {
+		struct ieee80211_channel *ch;
+		struct wireless_dev *wdev =
+			ieee80211_vif_to_wdev(data->nan.device_vif);
+
+		if (data->nan.curr_dw_band == NL80211_BAND_5GHZ)
+			ch = ieee80211_get_channel(hw->wiphy, 5745);
+		else
+			ch = ieee80211_get_channel(hw->wiphy, 2437);
+
+		cfg80211_next_nan_dw_notif(wdev, ch, GFP_ATOMIC);
+	}
+
+	return HRTIMER_RESTART;
+}
+
+int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_nan_conf *conf)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
+	u32 dw_int = 512 * 1000;
+	u64 until_dw = dw_int - do_div(tsf, dw_int);
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
+
+	if (vif->type != NL80211_IFTYPE_NAN)
+		return -EINVAL;
+
+	if (data->nan.device_vif)
+		return -EALREADY;
+
+	/* set this before starting the timer, as preemption might occur */
+	data->nan.device_vif = vif;
+	data->nan.bands = conf->bands;
+	data->nan.curr_dw_band = NL80211_BAND_2GHZ;
+
+	wiphy_debug(hw->wiphy, "nan_started, next_dw=%llu\n",
+		    until_dw);
+
+	hrtimer_start(&data->nan.timer,
+		      ns_to_ktime(until_dw * NSEC_PER_USEC),
+		      HRTIMER_MODE_REL_SOFT);
+
+	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
+	    is_zero_ether_addr(hwsim_nan_cluster_id)) {
+		memcpy(hwsim_nan_cluster_id, conf->cluster_id, ETH_ALEN);
+	} else if (is_zero_ether_addr(hwsim_nan_cluster_id)) {
+		hwsim_nan_cluster_id[0] = 0x50;
+		hwsim_nan_cluster_id[1] = 0x6f;
+		hwsim_nan_cluster_id[2] = 0x9a;
+		hwsim_nan_cluster_id[3] = 0x01;
+		hwsim_nan_cluster_id[4] = get_random_u8();
+		hwsim_nan_cluster_id[5] = get_random_u8();
+	}
+
+	data->nan.notify_dw = conf->enable_dw_notification;
+
+	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
+				    GFP_KERNEL);
+
+	return 0;
+}
+
+int mac80211_hwsim_nan_stop(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	struct mac80211_hwsim_data *data2;
+	bool nan_cluster_running = false;
+
+	if (vif->type != NL80211_IFTYPE_NAN || !data->nan.device_vif ||
+	    data->nan.device_vif != vif)
+		return -EINVAL;
+
+	hrtimer_cancel(&data->nan.timer);
+	data->nan.device_vif = NULL;
+
+	spin_lock_bh(&hwsim_radio_lock);
+	list_for_each_entry(data2, &hwsim_radios, list) {
+		if (data2->nan.device_vif) {
+			nan_cluster_running = true;
+			break;
+		}
+	}
+	spin_unlock_bh(&hwsim_radio_lock);
+
+	if (!nan_cluster_running)
+		memset(hwsim_nan_cluster_id, 0, ETH_ALEN);
+
+	return 0;
+}
+
+int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct cfg80211_nan_conf *conf,
+				     u32 changes)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (vif->type != NL80211_IFTYPE_NAN)
+		return -EINVAL;
+
+	if (!data->nan.device_vif)
+		return -EINVAL;
+
+	wiphy_debug(hw->wiphy, "nan_config_changed: changes=0x%x\n", changes);
+
+	/* Handle only the changes we care about for simulation purposes */
+	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS) {
+		data->nan.bands = conf->bands;
+		data->nan.curr_dw_band = NL80211_BAND_2GHZ;
+	}
+
+	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG)
+		data->nan.notify_dw = conf->enable_dw_notification;
+
+	return 0;
+}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
new file mode 100644
index 000000000000..eac64ac37589
--- /dev/null
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mac80211_hwsim_nan - NAN software simulation for mac80211_hwsim
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#ifndef __MAC80211_HWSIM_NAN_H
+#define __MAC80211_HWSIM_NAN_H
+
+struct mac80211_hwsim_nan_data {
+	struct ieee80211_vif *device_vif;
+	u8 bands;
+
+	enum nl80211_band curr_dw_band;
+	struct hrtimer timer;
+	bool notify_dw;
+};
+
+enum hrtimer_restart
+mac80211_hwsim_nan_dw_start(struct hrtimer *timer);
+
+int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_nan_conf *conf);
+
+int mac80211_hwsim_nan_stop(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif);
+
+int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct cfg80211_nan_conf *conf,
+				     u32 changes);
+
+#endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.52.0


