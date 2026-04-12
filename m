Return-Path: <linux-wireless+bounces-34664-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHf5CSiM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34664-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BE3E3C04
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB993014437
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7A37B41A;
	Sun, 12 Apr 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myaYDWNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B673783DB
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995913; cv=none; b=TYiw6BOffAewvBEA2O+w+t0U5D/2q8uLfFOISuIVwILziKhWFdZlbpMdGWyY0SszrgIBTgkWGeUPD1DHTRAfo+iRhLwnQhdo+pGTtZ3vIsstmjQJwrBMWcELbCTBuLCnEYyTcyTJG04gj3rMrByAtdCwJVH+4GbciBPdwZQ70wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995913; c=relaxed/simple;
	bh=cLaBfR2UjFUbQtfhKgV01gtQ89lOTQqkh19jQeGYfrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLjICSx0NSxAdmokm2jQjWLVKrYPlOWCtDXDW6/TRzG5+mHw/QFNt1Y8vImHnDBxP2YmsT1/OxBA5zxd9iI4+MpsOyVP0T0EBlt0IkSJGPgroXQO7W62VtB1Bk3zhZus43CckQlRS2vEa71jFm2cxN79oEyGysRgr9gkUSxh5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myaYDWNQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995911; x=1807531911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLaBfR2UjFUbQtfhKgV01gtQ89lOTQqkh19jQeGYfrQ=;
  b=myaYDWNQ1Dcb7Gw053JOKK2fmDsC4FrsczcQisJUeV7WRtnkuiTz/RF0
   n8JZsxMLLx5zQNNvzoJ2JAJIAhvIsa0tIkwRaG1zGJehfIDVLtl+XZh32
   vQ1Jkwoy1nhJvXYqUo2TiBQdF8Ii94kQhSI7yYGalK2+CsMcmMyNiJ9j7
   yPptHvFXOzB8Tqo7WUW1HIINo+g+gvWWKwzGBmCuSu/SVYTv4/4S9dFwi
   /EStbXe+gh0X+kNqw589VjIm+Cm+S1l9+oAlD+uRR4AE69cS3uVLW93TP
   P0fYxvr1E5PHVVjg4PfGKt4P4AHicHVXUlLPmZFXbERiQ7ISughrfMV4o
   Q==;
X-CSE-ConnectionGUID: QYbEO71TQaSmuRnbmY58bg==
X-CSE-MsgGUID: jhIIh9lOQpmBSgLAwxk9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028472"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028472"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:50 -0700
X-CSE-ConnectionGUID: zQR8FxMCSxmt7cifMGaZrw==
X-CSE-MsgGUID: 7dtAqO8sRi+haQqwvySMWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411924"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: mac80211_hwsim: split NAN handling into separate file
Date: Sun, 12 Apr 2026 15:11:19 +0300
Message-Id: <20260412150826.79f4c8f8214e.I9484d746286eb2ab71ac987dfb907497d213c2bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34664-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,w1.fi:email]
X-Rspamd-Queue-Id: 981BE3E3C04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

Having everything in one file for mac80211_hwsim is starting to get a
lot and it will be even worse if we implement more parts of NAN. Split
the NAN implementation into separate files to improve the code
structuring.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/Makefile         |   2 +
 .../net/wireless/virtual/mac80211_hwsim_i.h   | 137 ++++++++
 ...mac80211_hwsim.c => mac80211_hwsim_main.c} | 307 ++----------------
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 171 ++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  34 ++
 5 files changed, 364 insertions(+), 287 deletions(-)
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
index 000000000000..741eb08f8a85
--- /dev/null
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -0,0 +1,137 @@
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
+	struct cfg80211_chan_def radar_background_chandef;
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
index d5b9170f690c..4ad2c6f38663 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -39,6 +39,7 @@
 #include <linux/uaccess.h>
 #include <linux/string.h>
 #include "mac80211_hwsim.h"
+#include "mac80211_hwsim_i.h"
 
 #define WARN_QUEUE 100
 #define MAX_QUEUE 200
@@ -379,6 +380,8 @@ static const struct ieee80211_channel hwsim_channels_2ghz[] = {
 	CHAN2G(2472), /* Channel 13 */
 	CHAN2G(2484), /* Channel 14 */
 };
+static_assert(HWSIM_NUM_CHANNELS_2GHZ == ARRAY_SIZE(hwsim_channels_2ghz),
+	      "Inconsistent 2 GHz channel count");
 
 static const struct ieee80211_channel hwsim_channels_5ghz[] = {
 	CHAN5G(5180), /* Channel 36 */
@@ -428,6 +431,8 @@ static const struct ieee80211_channel hwsim_channels_5ghz[] = {
 	CHAN5G(5920), /* Channel 184 */
 	CHAN5G(5925), /* Channel 185 */
 };
+static_assert(HWSIM_NUM_CHANNELS_5GHZ == ARRAY_SIZE(hwsim_channels_5ghz),
+	      "Inconsistent 5 GHz channel count");
 
 static const struct ieee80211_channel hwsim_channels_6ghz[] = {
 	CHAN6G(5955), /* Channel 1 */
@@ -490,9 +495,10 @@ static const struct ieee80211_channel hwsim_channels_6ghz[] = {
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
@@ -525,7 +531,7 @@ static void hwsim_init_s1g_channels(struct ieee80211_channel *chans)
 {
 	int ch, freq;
 
-	for (ch = 0; ch < NUM_S1G_CHANS_US; ch++) {
+	for (ch = 0; ch < ARRAY_SIZE(hwsim_channels_s1g); ch++) {
 		freq = 902000 + (ch + 1) * 500;
 		chans[ch].band = NL80211_BAND_S1GHZ;
 		chans[ch].center_freq = KHZ_TO_MHZ(freq);
@@ -548,6 +554,8 @@ static const struct ieee80211_rate hwsim_rates[] = {
 	{ .bitrate = 480 },
 	{ .bitrate = 540 }
 };
+static_assert(HWSIM_NUM_RATES == ARRAY_SIZE(hwsim_rates),
+	      "Inconsistent rates count");
 
 #define DEFAULT_RX_RSSI -50
 
@@ -564,6 +572,8 @@ static const u32 hwsim_ciphers[] = {
 	WLAN_CIPHER_SUITE_BIP_GMAC_128,
 	WLAN_CIPHER_SUITE_BIP_GMAC_256,
 };
+static_assert(HWSIM_NUM_CIPHERS == ARRAY_SIZE(hwsim_ciphers),
+	      "Inconsistent cipher count");
 
 #define OUI_QCA 0x001374
 #define QCA_NL80211_SUBCMD_TEST 1
@@ -644,12 +654,11 @@ static const struct nl80211_vendor_cmd_info mac80211_hwsim_vendor_events[] = {
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
@@ -657,120 +666,6 @@ static struct platform_driver mac80211_hwsim_driver = {
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
-	struct cfg80211_chan_def radar_background_chandef;
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
@@ -1327,8 +1222,8 @@ static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
 	return cpu_to_le64(now + data->tsf_offset);
 }
 
-static u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
-				  struct ieee80211_vif *vif)
+u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	return le64_to_cpu(__mac80211_hwsim_get_tsf(data));
@@ -4130,168 +4025,6 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
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
-			ch = ieee80211_get_channel(hw->wiphy, 5745);
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
-	if (!is_zero_ether_addr(conf->cluster_id) &&
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
-	spin_lock_bh(&hwsim_radio_lock);
-	list_for_each_entry(data2, &hwsim_radios, list) {
-		if (data2->nan.device_vif) {
-			nan_cluster_running = true;
-			break;
-		}
-	}
-	spin_unlock_bh(&hwsim_radio_lock);
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
 static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
 					       struct cfg80211_chan_def *chan)
 {
@@ -4342,11 +4075,11 @@ static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
 	.get_et_strings = mac80211_hwsim_get_et_strings,	\
 	.start_pmsr = mac80211_hwsim_start_pmsr,		\
 	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
-	.start_nan = mac80211_hwsim_start_nan,                  \
-	.stop_nan = mac80211_hwsim_stop_nan,                    \
-	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
 	.set_radar_background = mac80211_hwsim_set_radar_background, \
 	.set_key = mac80211_hwsim_set_key,			\
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
2.34.1


