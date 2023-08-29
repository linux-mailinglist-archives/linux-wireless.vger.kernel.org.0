Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066D78C22B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjH2KSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjH2KSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 06:18:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62435CD2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=UHWKz8BRHGadYReUlRLtFBUQUwzssWnEgmwTYitMFaI=; t=1693304268; x=1694513868; 
        b=psp3aMw7Nvsfs6X5pRzkxlvZKBvVxWT/+f8oEECT7C/t/8OKTKUlbT8tRxTQEF65lo3Kn0lJcom
        CLfWNLLLh/MLduxF7Ejf67qh5voHOljuPnyG/gnlFQv4mK/1jE/Avbl3pdVDf624+P11mYJBV/2k2
        zpVn3e/BvUkRMl1VnQeaQA+hcAXsqv799J2BcTJ8zQEZZiXxC2F+SNkhdOH4tdcomW/DMvjzQ5FzH
        x3wwd4NCwtcwSuvANltOjjv4G2MhB/KABY2p6l4tcfHIznO6c73CFl6ohgAv+mdCJa245uip5X7Nr
        k0P5WLwdTsHLxN1lKfY4AqLpsctKwn2YryNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qavn7-000zlu-2u;
        Tue, 29 Aug 2023 12:17:46 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: cfg80211: remove scan_width support
Date:   Tue, 29 Aug 2023 12:17:43 +0200
Message-ID: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There really isn't any support for scanning at different
channel widths than 20 MHz since there's no way to set it.
Remove this support for now, if somebody wants to maintain
this whole thing later we can revisit how it should work.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/wil6210/wmi.c        |  2 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  1 -
 include/net/cfg80211.h                        | 63 +---------------
 include/uapi/linux/nl80211.h                  |  2 +-
 net/mac80211/ibss.c                           | 30 ++------
 net/mac80211/ieee80211_i.h                    |  3 +-
 net/mac80211/ocb.c                            |  5 +-
 net/mac80211/scan.c                           | 71 ++++---------------
 net/wireless/mesh.c                           |  5 +-
 net/wireless/nl80211.c                        |  1 -
 net/wireless/scan.c                           | 23 +-----
 net/wireless/trace.h                          |  6 +-
 net/wireless/util.c                           | 14 ++--
 13 files changed, 35 insertions(+), 191 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6a5976a2944c..6fdb77d4c59e 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -870,7 +870,6 @@ static void wmi_evt_rx_mgmt(struct wil6210_vif *vif, int id, void *d, int len)
 		struct cfg80211_bss *bss;
 		struct cfg80211_inform_bss bss_data = {
 			.chan = channel,
-			.scan_width = NL80211_BSS_CHAN_WIDTH_20,
 			.signal = signal,
 			.boottime_ns = ktime_to_ns(ktime_get_boottime()),
 		};
@@ -1389,7 +1388,6 @@ wmi_evt_sched_scan_result(struct wil6210_vif *vif, int id, void *d, int len)
 	u32 d_len;
 	struct cfg80211_bss *bss;
 	struct cfg80211_inform_bss bss_data = {
-		.scan_width = NL80211_BSS_CHAN_WIDTH_20,
 		.boottime_ns = ktime_to_ns(ktime_get_boottime()),
 	};
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2a90bb24ba77..94b4a7b8793d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3367,7 +3367,6 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 
 	freq = ieee80211_channel_to_frequency(channel, band);
 	bss_data.chan = ieee80211_get_channel(wiphy, freq);
-	bss_data.scan_width = NL80211_BSS_CHAN_WIDTH_20;
 	bss_data.boottime_ns = ktime_to_ns(ktime_get_boottime());
 
 	notify_capability = le16_to_cpu(bi->capability);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index aa9c26a03f30..a9a678ba6941 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2487,7 +2487,6 @@ struct cfg80211_scan_6ghz_params {
  * @n_ssids: number of SSIDs
  * @channels: channels to scan on.
  * @n_channels: total number of channels to scan
- * @scan_width: channel width for scanning
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @duration: how long to listen on each channel, in TUs. If
@@ -2517,7 +2516,6 @@ struct cfg80211_scan_request {
 	struct cfg80211_ssid *ssids;
 	int n_ssids;
 	u32 n_channels;
-	enum nl80211_bss_scan_width scan_width;
 	const u8 *ie;
 	size_t ie_len;
 	u16 duration;
@@ -2612,7 +2610,6 @@ struct cfg80211_bss_select_adjust {
  * @ssids: SSIDs to scan for (passed in the probe_reqs in active scans)
  * @n_ssids: number of SSIDs
  * @n_channels: total number of channels to scan
- * @scan_width: channel width for scanning
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @flags: control flags from &enum nl80211_scan_flags
@@ -2660,7 +2657,6 @@ struct cfg80211_sched_scan_request {
 	struct cfg80211_ssid *ssids;
 	int n_ssids;
 	u32 n_channels;
-	enum nl80211_bss_scan_width scan_width;
 	const u8 *ie;
 	size_t ie_len;
 	u32 flags;
@@ -2708,7 +2704,6 @@ enum cfg80211_signal_type {
 /**
  * struct cfg80211_inform_bss - BSS inform data
  * @chan: channel the frame was received on
- * @scan_width: scan width that was used
  * @signal: signal strength value, according to the wiphy's
  *	signal type
  * @boottime_ns: timestamp (CLOCK_BOOTTIME) when the information was
@@ -2728,7 +2723,6 @@ enum cfg80211_signal_type {
  */
 struct cfg80211_inform_bss {
 	struct ieee80211_channel *chan;
-	enum nl80211_bss_scan_width scan_width;
 	s32 signal;
 	u64 boottime_ns;
 	u64 parent_tsf;
@@ -2762,7 +2756,6 @@ struct cfg80211_bss_ies {
  * for use in scan results and similar.
  *
  * @channel: channel this BSS is on
- * @scan_width: width of the control channel
  * @bssid: BSSID of the BSS
  * @beacon_interval: the beacon interval as from the frame
  * @capability: the capability field in host byte order
@@ -2792,7 +2785,6 @@ struct cfg80211_bss_ies {
  */
 struct cfg80211_bss {
 	struct ieee80211_channel *channel;
-	enum nl80211_bss_scan_width scan_width;
 
 	const struct cfg80211_bss_ies __rcu *ies;
 	const struct cfg80211_bss_ies __rcu *beacon_ies;
@@ -6272,13 +6264,11 @@ ieee80211_get_response_rate(struct ieee80211_supported_band *sband,
 /**
  * ieee80211_mandatory_rates - get mandatory rates for a given band
  * @sband: the band to look for rates in
- * @scan_width: width of the control channel
  *
  * This function returns a bitmap of the mandatory rates for the given
  * band, bits are set according to the rate position in the bitrates array.
  */
-u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband,
-			      enum nl80211_bss_scan_width scan_width);
+u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband);
 
 /*
  * Radiotap parsing functions -- for controlled injection support
@@ -6939,22 +6929,6 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 			       struct ieee80211_mgmt *mgmt, size_t len,
 			       gfp_t gfp);
 
-static inline struct cfg80211_bss * __must_check
-cfg80211_inform_bss_width_frame(struct wiphy *wiphy,
-				struct ieee80211_channel *rx_channel,
-				enum nl80211_bss_scan_width scan_width,
-				struct ieee80211_mgmt *mgmt, size_t len,
-				s32 signal, gfp_t gfp)
-{
-	struct cfg80211_inform_bss data = {
-		.chan = rx_channel,
-		.scan_width = scan_width,
-		.signal = signal,
-	};
-
-	return cfg80211_inform_bss_frame_data(wiphy, &data, mgmt, len, gfp);
-}
-
 static inline struct cfg80211_bss * __must_check
 cfg80211_inform_bss_frame(struct wiphy *wiphy,
 			  struct ieee80211_channel *rx_channel,
@@ -6963,7 +6937,6 @@ cfg80211_inform_bss_frame(struct wiphy *wiphy,
 {
 	struct cfg80211_inform_bss data = {
 		.chan = rx_channel,
-		.scan_width = NL80211_BSS_CHAN_WIDTH_20,
 		.signal = signal,
 	};
 
@@ -7065,26 +7038,6 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 			 u16 beacon_interval, const u8 *ie, size_t ielen,
 			 gfp_t gfp);
 
-static inline struct cfg80211_bss * __must_check
-cfg80211_inform_bss_width(struct wiphy *wiphy,
-			  struct ieee80211_channel *rx_channel,
-			  enum nl80211_bss_scan_width scan_width,
-			  enum cfg80211_bss_frame_type ftype,
-			  const u8 *bssid, u64 tsf, u16 capability,
-			  u16 beacon_interval, const u8 *ie, size_t ielen,
-			  s32 signal, gfp_t gfp)
-{
-	struct cfg80211_inform_bss data = {
-		.chan = rx_channel,
-		.scan_width = scan_width,
-		.signal = signal,
-	};
-
-	return cfg80211_inform_bss_data(wiphy, &data, ftype, bssid, tsf,
-					capability, beacon_interval, ie, ielen,
-					gfp);
-}
-
 static inline struct cfg80211_bss * __must_check
 cfg80211_inform_bss(struct wiphy *wiphy,
 		    struct ieee80211_channel *rx_channel,
@@ -7095,7 +7048,6 @@ cfg80211_inform_bss(struct wiphy *wiphy,
 {
 	struct cfg80211_inform_bss data = {
 		.chan = rx_channel,
-		.scan_width = NL80211_BSS_CHAN_WIDTH_20,
 		.signal = signal,
 	};
 
@@ -7180,19 +7132,6 @@ void cfg80211_bss_iter(struct wiphy *wiphy,
 				    void *data),
 		       void *iter_data);
 
-static inline enum nl80211_bss_scan_width
-cfg80211_chandef_to_scan_width(const struct cfg80211_chan_def *chandef)
-{
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_5:
-		return NL80211_BSS_CHAN_WIDTH_5;
-	case NL80211_CHAN_WIDTH_10:
-		return NL80211_BSS_CHAN_WIDTH_10;
-	default:
-		return NL80211_BSS_CHAN_WIDTH_20;
-	}
-}
-
 /**
  * cfg80211_rx_mlme_mgmt - notification of processed MLME management frame
  * @dev: network device
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 88eb85c63029..b628126e06fa 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5038,7 +5038,7 @@ enum nl80211_bss_scan_width {
  *	elements from a Beacon frame (bin); not present if no Beacon frame has
  *	yet been received
  * @NL80211_BSS_CHAN_WIDTH: channel width of the control channel
- *	(u32, enum nl80211_bss_scan_width)
+ *	(u32, enum nl80211_bss_scan_width) - No longer used!
  * @NL80211_BSS_BEACON_TSF: TSF of the last received beacon (u64)
  *	(not present if no beacon frame has been received yet)
  * @NL80211_BSS_PRESP_DATA: the data in @NL80211_BSS_INFORMATION_ELEMENTS and
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 9907cea6457c..55ec34602b53 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -377,7 +377,6 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		  round_jiffies(jiffies + IEEE80211_IBSS_MERGE_INTERVAL));
 
 	bss_meta.chan = chan;
-	bss_meta.scan_width = cfg80211_chandef_to_scan_width(&chandef);
 	bss = cfg80211_inform_bss_frame_data(local->hw.wiphy, &bss_meta, mgmt,
 					     presp->head_len, GFP_KERNEL);
 
@@ -595,7 +594,6 @@ ieee80211_ibss_add_sta(struct ieee80211_sub_if_data *sdata, const u8 *bssid,
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_supported_band *sband;
-	enum nl80211_bss_scan_width scan_width;
 	int band;
 
 	/*
@@ -624,7 +622,6 @@ ieee80211_ibss_add_sta(struct ieee80211_sub_if_data *sdata, const u8 *bssid,
 	if (WARN_ON_ONCE(!chanctx_conf))
 		return NULL;
 	band = chanctx_conf->def.chan->band;
-	scan_width = cfg80211_chandef_to_scan_width(&chanctx_conf->def);
 	rcu_read_unlock();
 
 	sta = sta_info_alloc(sdata, addr, GFP_KERNEL);
@@ -636,7 +633,7 @@ ieee80211_ibss_add_sta(struct ieee80211_sub_if_data *sdata, const u8 *bssid,
 	/* make sure mandatory rates are always added */
 	sband = local->hw.wiphy->bands[band];
 	sta->sta.deflink.supp_rates[band] = supp_rates |
-			ieee80211_mandatory_rates(sband, scan_width);
+			ieee80211_mandatory_rates(sband);
 
 	return ieee80211_ibss_finish_sta(sta);
 }
@@ -975,7 +972,6 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 {
 	struct sta_info *sta;
 	enum nl80211_band band = rx_status->band;
-	enum nl80211_bss_scan_width scan_width;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	bool rates_updated = false;
@@ -1001,15 +997,9 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 			u32 prev_rates;
 
 			prev_rates = sta->sta.deflink.supp_rates[band];
-			/* make sure mandatory rates are always added */
-			scan_width = NL80211_BSS_CHAN_WIDTH_20;
-			if (rx_status->bw == RATE_INFO_BW_5)
-				scan_width = NL80211_BSS_CHAN_WIDTH_5;
-			else if (rx_status->bw == RATE_INFO_BW_10)
-				scan_width = NL80211_BSS_CHAN_WIDTH_10;
 
 			sta->sta.deflink.supp_rates[band] = supp_rates |
-				ieee80211_mandatory_rates(sband, scan_width);
+				ieee80211_mandatory_rates(sband);
 			if (sta->sta.deflink.supp_rates[band] != prev_rates) {
 				ibss_dbg(sdata,
 					 "updated supp_rates set for %pM based on beacon/probe_resp (0x%x -> 0x%x)\n",
@@ -1196,7 +1186,6 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_supported_band *sband;
-	enum nl80211_bss_scan_width scan_width;
 	int band;
 
 	/*
@@ -1222,7 +1211,6 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 	band = chanctx_conf->def.chan->band;
-	scan_width = cfg80211_chandef_to_scan_width(&chanctx_conf->def);
 	rcu_read_unlock();
 
 	sta = sta_info_alloc(sdata, addr, GFP_ATOMIC);
@@ -1232,7 +1220,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	/* make sure mandatory rates are always added */
 	sband = local->hw.wiphy->bands[band];
 	sta->sta.deflink.supp_rates[band] = supp_rates |
-			ieee80211_mandatory_rates(sband, scan_width);
+			ieee80211_mandatory_rates(sband);
 
 	spin_lock(&ifibss->incomplete_lock);
 	list_add(&sta->list, &ifibss->incomplete_stations);
@@ -1282,7 +1270,6 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 static void ieee80211_sta_merge_ibss(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
-	enum nl80211_bss_scan_width scan_width;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -1304,9 +1291,8 @@ static void ieee80211_sta_merge_ibss(struct ieee80211_sub_if_data *sdata)
 	sdata_info(sdata,
 		   "No active IBSS STAs - trying to scan for other IBSS networks with same SSID (merge)\n");
 
-	scan_width = cfg80211_chandef_to_scan_width(&ifibss->chandef);
 	ieee80211_request_ibss_scan(sdata, ifibss->ssid, ifibss->ssid_len,
-				    NULL, 0, scan_width);
+				    NULL, 0);
 }
 
 static void ieee80211_sta_create_ibss(struct ieee80211_sub_if_data *sdata)
@@ -1424,7 +1410,6 @@ static void ieee80211_sta_find_ibss(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_bss *cbss;
 	struct ieee80211_channel *chan = NULL;
 	const u8 *bssid = NULL;
-	enum nl80211_bss_scan_width scan_width;
 	int active_ibss;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
@@ -1483,8 +1468,6 @@ static void ieee80211_sta_find_ibss(struct ieee80211_sub_if_data *sdata)
 
 		sdata_info(sdata, "Trigger new scan to find an IBSS to join\n");
 
-		scan_width = cfg80211_chandef_to_scan_width(&ifibss->chandef);
-
 		if (ifibss->fixed_channel) {
 			num = ieee80211_ibss_setup_scan_channels(local->hw.wiphy,
 								 &ifibss->chandef,
@@ -1492,11 +1475,10 @@ static void ieee80211_sta_find_ibss(struct ieee80211_sub_if_data *sdata)
 								 ARRAY_SIZE(channels));
 			ieee80211_request_ibss_scan(sdata, ifibss->ssid,
 						    ifibss->ssid_len, channels,
-						    num, scan_width);
+						    num);
 		} else {
 			ieee80211_request_ibss_scan(sdata, ifibss->ssid,
-						    ifibss->ssid_len, NULL,
-						    0, scan_width);
+						    ifibss->ssid_len, NULL, 0);
 		}
 	} else {
 		int interval = IEEE80211_SCAN_INTERVAL;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b8465d205076..0e20627ba60e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1908,8 +1908,7 @@ void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				const u8 *ssid, u8 ssid_len,
 				struct ieee80211_channel **channels,
-				unsigned int n_channels,
-				enum nl80211_bss_scan_width scan_width);
+				unsigned int n_channels);
 int ieee80211_request_scan(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_scan_request *req);
 void ieee80211_scan_cancel(struct ieee80211_local *local);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 6e2965ffb809..449af4e1cca4 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -44,7 +44,6 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_supported_band *sband;
-	enum nl80211_bss_scan_width scan_width;
 	struct sta_info *sta;
 	int band;
 
@@ -66,7 +65,6 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 	band = chanctx_conf->def.chan->band;
-	scan_width = cfg80211_chandef_to_scan_width(&chanctx_conf->def);
 	rcu_read_unlock();
 
 	sta = sta_info_alloc(sdata, addr, GFP_ATOMIC);
@@ -75,8 +73,7 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 
 	/* Add only mandatory rates for now */
 	sband = local->hw.wiphy->bands[band];
-	sta->sta.deflink.supp_rates[band] =
-		ieee80211_mandatory_rates(sband, scan_width);
+	sta->sta.deflink.supp_rates[band] = ieee80211_mandatory_rates(sband);
 
 	spin_lock(&ifocb->incomplete_lock);
 	list_add(&sta->list, &ifocb->incomplete_stations);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 58d525e41f6b..24fa06105378 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -187,12 +187,6 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	else if (ieee80211_hw_check(&local->hw, SIGNAL_UNSPEC))
 		bss_meta.signal = (rx_status->signal * 100) / local->hw.max_signal;
 
-	bss_meta.scan_width = NL80211_BSS_CHAN_WIDTH_20;
-	if (rx_status->bw == RATE_INFO_BW_5)
-		bss_meta.scan_width = NL80211_BSS_CHAN_WIDTH_5;
-	else if (rx_status->bw == RATE_INFO_BW_10)
-		bss_meta.scan_width = NL80211_BSS_CHAN_WIDTH_10;
-
 	bss_meta.chan = channel;
 
 	rcu_read_lock();
@@ -315,22 +309,11 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		ieee80211_rx_bss_put(local, bss);
 }
 
-static void
-ieee80211_prepare_scan_chandef(struct cfg80211_chan_def *chandef,
-			       enum nl80211_bss_scan_width scan_width)
+static void ieee80211_prepare_scan_chandef(struct cfg80211_chan_def *chandef)
 {
 	memset(chandef, 0, sizeof(*chandef));
-	switch (scan_width) {
-	case NL80211_BSS_CHAN_WIDTH_5:
-		chandef->width = NL80211_CHAN_WIDTH_5;
-		break;
-	case NL80211_BSS_CHAN_WIDTH_10:
-		chandef->width = NL80211_CHAN_WIDTH_10;
-		break;
-	default:
-		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-		break;
-	}
+
+	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 }
 
 /* return false if no more work */
@@ -378,7 +361,7 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	}
 
 	local->hw_scan_req->req.n_channels = n_chans;
-	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
+	ieee80211_prepare_scan_chandef(&chandef);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
 		flags |= IEEE80211_PROBE_FLAG_MIN_CONTENT;
@@ -919,7 +902,6 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 {
 	int skip;
 	struct ieee80211_channel *chan;
-	enum nl80211_bss_scan_width oper_scan_width;
 	struct cfg80211_scan_request *scan_req;
 
 	scan_req = rcu_dereference_protected(local->scan_req,
@@ -933,42 +915,21 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	local->scan_chandef.freq1_offset = chan->freq_offset;
 	local->scan_chandef.center_freq2 = 0;
 
-	/* For scanning on the S1G band, ignore scan_width (which is constant
-	 * across all channels) for now since channel width is specific to each
-	 * channel. Detect the required channel width here and likely revisit
-	 * later. Maybe scan_width could be used to build the channel scan list?
+	/* For scanning on the S1G band, detect the channel width according to
+	 * the channel being scanned.
 	 */
 	if (chan->band == NL80211_BAND_S1GHZ) {
 		local->scan_chandef.width = ieee80211_s1g_channel_width(chan);
 		goto set_channel;
 	}
 
-	switch (scan_req->scan_width) {
-	case NL80211_BSS_CHAN_WIDTH_5:
-		local->scan_chandef.width = NL80211_CHAN_WIDTH_5;
-		break;
-	case NL80211_BSS_CHAN_WIDTH_10:
-		local->scan_chandef.width = NL80211_CHAN_WIDTH_10;
-		break;
-	default:
-	case NL80211_BSS_CHAN_WIDTH_20:
-		/* If scanning on oper channel, use whatever channel-type
-		 * is currently in use.
-		 */
-		oper_scan_width = cfg80211_chandef_to_scan_width(
-					&local->_oper_chandef);
-		if (chan == local->_oper_chandef.chan &&
-		    oper_scan_width == scan_req->scan_width)
-			local->scan_chandef = local->_oper_chandef;
-		else
-			local->scan_chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
-		break;
-	case NL80211_BSS_CHAN_WIDTH_1:
-	case NL80211_BSS_CHAN_WIDTH_2:
-		/* shouldn't get here, S1G handled above */
-		WARN_ON(1);
-		break;
-	}
+	/* If scanning on oper channel, use whatever channel-type
+	 * is currently in use.
+	 */
+	if (chan == local->_oper_chandef.chan)
+		local->scan_chandef = local->_oper_chandef;
+	else
+		local->scan_chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
 
 set_channel:
 	if (ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL))
@@ -1152,8 +1113,7 @@ int ieee80211_request_scan(struct ieee80211_sub_if_data *sdata,
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				const u8 *ssid, u8 ssid_len,
 				struct ieee80211_channel **channels,
-				unsigned int n_channels,
-				enum nl80211_bss_scan_width scan_width)
+				unsigned int n_channels)
 {
 	struct ieee80211_local *local = sdata->local;
 	int ret = -EBUSY, i, n_ch = 0;
@@ -1210,7 +1170,6 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 
 	local->int_scan_req->ssids = &local->scan_ssid;
 	local->int_scan_req->n_ssids = 1;
-	local->int_scan_req->scan_width = scan_width;
 	memcpy(local->int_scan_req->ssids[0].ssid, ssid, IEEE80211_MAX_SSID_LEN);
 	local->int_scan_req->ssids[0].ssid_len = ssid_len;
 
@@ -1311,7 +1270,7 @@ int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
+	ieee80211_prepare_scan_chandef(&chandef);
 
 	ieee80211_build_preq_ies(sdata, ie, num_bands * iebufsz,
 				 &sched_scan_ies, req->ie,
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index dc75abdb8f2e..83306979fbe2 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -172,7 +172,6 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 	 * basic rates
 	 */
 	if (!setup->basic_rates) {
-		enum nl80211_bss_scan_width scan_width;
 		struct ieee80211_supported_band *sband =
 				rdev->wiphy.bands[setup->chandef.chan->band];
 
@@ -193,9 +192,7 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 				}
 			}
 		} else {
-			scan_width = cfg80211_chandef_to_scan_width(&setup->chandef);
-			setup->basic_rates = ieee80211_mandatory_rates(sband,
-								       scan_width);
+			setup->basic_rates = ieee80211_mandatory_rates(sband);
 		}
 	}
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 71a0a6e34bdb..213693001b1f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10283,7 +10283,6 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 	    nla_put_u32(msg, NL80211_BSS_FREQUENCY, res->channel->center_freq) ||
 	    nla_put_u32(msg, NL80211_BSS_FREQUENCY_OFFSET,
 			res->channel->freq_offset) ||
-	    nla_put_u32(msg, NL80211_BSS_CHAN_WIDTH, res->scan_width) ||
 	    nla_put_u32(msg, NL80211_BSS_SEEN_MS_AGO,
 			jiffies_to_msecs(jiffies - intbss->ts)))
 		goto nla_put_failure;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0cf1ce7b6934..2aebe5d904bd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1638,8 +1638,6 @@ static bool cfg80211_combine_bsses(struct cfg80211_registered_device *rdev,
 			continue;
 		if (bss->pub.channel != new->pub.channel)
 			continue;
-		if (bss->pub.scan_width != new->pub.scan_width)
-			continue;
 		if (rcu_access_pointer(bss->pub.beacon_ies))
 			continue;
 		ies = rcu_access_pointer(bss->pub.ies);
@@ -1936,8 +1934,7 @@ EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
  */
 static struct ieee80211_channel *
 cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
-			 struct ieee80211_channel *channel,
-			 enum nl80211_bss_scan_width scan_width)
+			 struct ieee80211_channel *channel)
 {
 	u32 freq;
 	int channel_number;
@@ -1977,16 +1974,6 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 		return channel;
 	}
 
-	if (scan_width == NL80211_BSS_CHAN_WIDTH_10 ||
-	    scan_width == NL80211_BSS_CHAN_WIDTH_5) {
-		/*
-		 * Ignore channel number in 5 and 10 MHz channels where there
-		 * may not be an n:1 or 1:n mapping between frequencies and
-		 * channel numbers.
-		 */
-		return channel;
-	}
-
 	/*
 	 * Use the channel determined through the payload channel number
 	 * instead of the RX channel reported by the driver.
@@ -2046,14 +2033,12 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	channel = data->channel;
 	if (!channel)
 		channel = cfg80211_get_bss_channel(wiphy, data->ie, data->ielen,
-						   drv_data->chan,
-						   drv_data->scan_width);
+						   drv_data->chan);
 	if (!channel)
 		return NULL;
 
 	memcpy(tmp.pub.bssid, data->bssid, ETH_ALEN);
 	tmp.pub.channel = channel;
-	tmp.pub.scan_width = drv_data->scan_width;
 	if (data->bss_source != BSS_SOURCE_STA_PROFILE)
 		tmp.pub.signal = drv_data->signal;
 	else
@@ -2814,8 +2799,7 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 			variable = ext->u.s1g_beacon.variable;
 	}
 
-	channel = cfg80211_get_bss_channel(wiphy, variable,
-					   ielen, data->chan, data->scan_width);
+	channel = cfg80211_get_bss_channel(wiphy, variable, ielen, data->chan);
 	if (!channel)
 		return NULL;
 
@@ -2868,7 +2852,6 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	tmp.pub.beacon_interval = beacon_int;
 	tmp.pub.capability = capability;
 	tmp.pub.channel = channel;
-	tmp.pub.scan_width = data->scan_width;
 	tmp.pub.signal = data->signal;
 	tmp.ts_boottime = data->boottime_ns;
 	tmp.parent_tsf = data->parent_tsf;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 617c0d0dfa96..126c3a03e43e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3590,7 +3590,6 @@ TRACE_EVENT(cfg80211_inform_bss_frame,
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		CHAN_ENTRY
-		__field(enum nl80211_bss_scan_width, scan_width)
 		__dynamic_array(u8, mgmt, len)
 		__field(s32, signal)
 		__field(u64, ts_boottime)
@@ -3600,7 +3599,6 @@ TRACE_EVENT(cfg80211_inform_bss_frame,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		CHAN_ASSIGN(data->chan);
-		__entry->scan_width = data->scan_width;
 		if (mgmt)
 			memcpy(__get_dynamic_array(mgmt), mgmt, len);
 		__entry->signal = data->signal;
@@ -3609,8 +3607,8 @@ TRACE_EVENT(cfg80211_inform_bss_frame,
 		MAC_ASSIGN(parent_bssid, data->parent_bssid);
 	),
 	TP_printk(WIPHY_PR_FMT ", " CHAN_PR_FMT
-		  "(scan_width: %d) signal: %d, tsb:%llu, detect_tsf:%llu, tsf_bssid: %pM",
-		  WIPHY_PR_ARG, CHAN_PR_ARG, __entry->scan_width,
+		  "signal: %d, tsb:%llu, detect_tsf:%llu, tsf_bssid: %pM",
+		  WIPHY_PR_ARG, CHAN_PR_ARG,
 		  __entry->signal, (unsigned long long)__entry->ts_boottime,
 		  (unsigned long long)__entry->parent_tsf,
 		  __entry->parent_bssid)
diff --git a/net/wireless/util.c b/net/wireless/util.c
index fff99fe43fdd..f345e43ec6b3 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -43,8 +43,7 @@ ieee80211_get_response_rate(struct ieee80211_supported_band *sband,
 }
 EXPORT_SYMBOL(ieee80211_get_response_rate);
 
-u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband,
-			      enum nl80211_bss_scan_width scan_width)
+u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband)
 {
 	struct ieee80211_rate *bitrates;
 	u32 mandatory_rates = 0;
@@ -54,15 +53,10 @@ u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband,
 	if (WARN_ON(!sband))
 		return 1;
 
-	if (sband->band == NL80211_BAND_2GHZ) {
-		if (scan_width == NL80211_BSS_CHAN_WIDTH_5 ||
-		    scan_width == NL80211_BSS_CHAN_WIDTH_10)
-			mandatory_flag = IEEE80211_RATE_MANDATORY_G;
-		else
-			mandatory_flag = IEEE80211_RATE_MANDATORY_B;
-	} else {
+	if (sband->band == NL80211_BAND_2GHZ)
+		mandatory_flag = IEEE80211_RATE_MANDATORY_B;
+	else
 		mandatory_flag = IEEE80211_RATE_MANDATORY_A;
-	}
 
 	bitrates = sband->bitrates;
 	for (i = 0; i < sband->n_bitrates; i++)
-- 
2.41.0

