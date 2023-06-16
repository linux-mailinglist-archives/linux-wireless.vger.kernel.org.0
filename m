Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661717327F8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjFPGzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbjFPGyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664C1FF9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898492; x=1718434492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4krih0yM1FXgrOBY7qsCPn510mVutBbKC3UdfJnItrw=;
  b=jd2jYxuwqr3o3LG3HVU4Py4IDMm3GVVTgdV0crYh49HtKMe8peT7mUeo
   qHRYcDzbRdLvePHiPZpE6jWDqV11XbNpwv3rX7J52aAVJnM8tm/L/jZcm
   7NkhuOqMzc+sSXiu5xLavC49Jgu6PxkoZhDpmWtC3GyWJCVHqgIgoEyZd
   Ki6eDjHur2jBaNsdCcZl8ASDdxiZdrAchBZWPUhMkKA3Pg4bUsVueWAcq
   mE/cLZAV52TMYuuQUg1I6lejDViyrA9DLAZMv0FxAhE/3quwvBdopiiG3
   3KEBmTFGGvLojs59TkL3zJjBFL9Neg6Z0RSd83IFfBiw6IGoCtWTuTVr0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078884"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078884"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720129"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720129"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/20] wifi: mac80211: use new inform_bss callback
Date:   Fri, 16 Jun 2023 09:54:01 +0300
Message-Id: <20230616094949.39ebfe2f9e59.Ia012b08e0feed8ec431b666888b459f6366f7bd1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Doing this simplifies the code somewhat, as iteration over the
nontransmitted BSSs is not required anymore. Also, mac80211 should
not be iterating over the nontrans_list as it should only be accessed
while the bss_lock is held.

It also simplifies parsing of the IEs somewhat, as cfg80211 already
extracts the IEs and passes them to the callback.

Note that the only user left requiring parsing a specific BSS is the
association code if a beacon is required by the hardware.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c         |  1 +
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/scan.c        | 93 ++++++++++++++++----------------------
 3 files changed, 42 insertions(+), 55 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 359589d525d5..eea7028a46a7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5050,6 +5050,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.join_ocb = ieee80211_join_ocb,
 	.leave_ocb = ieee80211_leave_ocb,
 	.change_bss = ieee80211_change_bss,
+	.inform_bss = ieee80211_inform_bss,
 	.set_txq_params = ieee80211_set_txq_params,
 	.set_monitor_channel = ieee80211_set_monitor_channel,
 	.suspend = ieee80211_suspend,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f8d5f37ebe9a..b05dfdcfff11 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1929,6 +1929,9 @@ void ieee80211_scan_cancel(struct ieee80211_local *local);
 void ieee80211_run_deferred_scan(struct ieee80211_local *local);
 void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb);
 
+void ieee80211_inform_bss(struct wiphy *wiphy, struct cfg80211_bss *bss,
+			  const struct cfg80211_bss_ies *ies, void *data);
+
 void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local);
 struct ieee80211_bss *
 ieee80211_bss_info_update(struct ieee80211_local *local,
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index ea5383136fff..0805aa8603c6 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -55,27 +55,45 @@ static bool is_uapsd_supported(struct ieee802_11_elems *elems)
 	return qos_info & IEEE80211_WMM_IE_AP_QOSINFO_UAPSD;
 }
 
-static void
-ieee80211_update_bss_from_elems(struct ieee80211_local *local,
-				struct ieee80211_bss *bss,
-				struct ieee802_11_elems *elems,
-				struct ieee80211_rx_status *rx_status,
-				bool beacon)
+struct inform_bss_update_data {
+	struct ieee80211_rx_status *rx_status;
+	bool beacon;
+};
+
+void ieee80211_inform_bss(struct wiphy *wiphy,
+			  struct cfg80211_bss *cbss,
+			  const struct cfg80211_bss_ies *ies,
+			  void *data)
 {
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+	struct inform_bss_update_data *update_data = data;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
+	struct ieee80211_rx_status *rx_status;
+	struct ieee802_11_elems *elems;
 	int clen, srlen;
 
-	if (beacon)
+	/* This happens while joining an IBSS */
+	if (!update_data)
+		return;
+
+	elems = ieee802_11_parse_elems(ies->data, ies->len, false, NULL);
+	if (!elems)
+		return;
+
+	rx_status = update_data->rx_status;
+
+	if (update_data->beacon)
 		bss->device_ts_beacon = rx_status->device_timestamp;
 	else
 		bss->device_ts_presp = rx_status->device_timestamp;
 
 	if (elems->parse_error) {
-		if (beacon)
+		if (update_data->beacon)
 			bss->corrupt_data |= IEEE80211_BSS_CORRUPT_BEACON;
 		else
 			bss->corrupt_data |= IEEE80211_BSS_CORRUPT_PROBE_RESP;
 	} else {
-		if (beacon)
+		if (update_data->beacon)
 			bss->corrupt_data &= ~IEEE80211_BSS_CORRUPT_BEACON;
 		else
 			bss->corrupt_data &= ~IEEE80211_BSS_CORRUPT_PROBE_RESP;
@@ -124,7 +142,7 @@ ieee80211_update_bss_from_elems(struct ieee80211_local *local,
 			bss->valid_data |= IEEE80211_BSS_VALID_WMM;
 	}
 
-	if (beacon) {
+	if (update_data->beacon) {
 		struct ieee80211_supported_band *sband =
 			local->hw.wiphy->bands[rx_status->band];
 		if (!(rx_status->encoding == RX_ENC_HT) &&
@@ -138,6 +156,8 @@ ieee80211_update_bss_from_elems(struct ieee80211_local *local,
 			le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 	else
 		bss->vht_cap_info = 0;
+
+	kfree(elems);
 }
 
 struct ieee80211_bss *
@@ -148,16 +168,17 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 {
 	bool beacon = ieee80211_is_beacon(mgmt->frame_control) ||
 		      ieee80211_is_s1g_beacon(mgmt->frame_control);
-	struct cfg80211_bss *cbss, *non_tx_cbss;
-	struct ieee80211_bss *bss, *non_tx_bss;
+	struct cfg80211_bss *cbss;
+	struct inform_bss_update_data update_data = {
+		.rx_status = rx_status,
+		.beacon = beacon,
+	};
 	struct cfg80211_inform_bss bss_meta = {
 		.boottime_ns = rx_status->boottime_ns,
+		.drv_data = (void *)&update_data,
 	};
 	bool signal_valid;
 	struct ieee80211_sub_if_data *scan_sdata;
-	struct ieee802_11_elems *elems;
-	size_t baselen;
-	u8 *elements;
 
 	if (rx_status->flag & RX_FLAG_NO_SIGNAL_VAL)
 		bss_meta.signal = 0; /* invalid signal indication */
@@ -192,50 +213,12 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	if (!cbss)
 		return NULL;
 
-	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
-		elements = mgmt->u.probe_resp.variable;
-		baselen = offsetof(struct ieee80211_mgmt,
-				   u.probe_resp.variable);
-	} else if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		struct ieee80211_ext *ext = (void *) mgmt;
-
-		baselen = offsetof(struct ieee80211_ext, u.s1g_beacon.variable);
-		elements = ext->u.s1g_beacon.variable;
-	} else {
-		baselen = offsetof(struct ieee80211_mgmt, u.beacon.variable);
-		elements = mgmt->u.beacon.variable;
-	}
-
-	if (baselen > len)
-		return NULL;
-
-	elems = ieee802_11_parse_elems(elements, len - baselen, false, cbss);
-	if (!elems)
-		return NULL;
-
 	/* In case the signal is invalid update the status */
 	signal_valid = channel == cbss->channel;
 	if (!signal_valid)
 		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
-	bss = (void *)cbss->priv;
-	ieee80211_update_bss_from_elems(local, bss, elems, rx_status, beacon);
-	kfree(elems);
-
-	list_for_each_entry(non_tx_cbss, &cbss->nontrans_list, nontrans_list) {
-		non_tx_bss = (void *)non_tx_cbss->priv;
-
-		elems = ieee802_11_parse_elems(elements, len - baselen, false,
-					       non_tx_cbss);
-		if (!elems)
-			continue;
-
-		ieee80211_update_bss_from_elems(local, non_tx_bss, elems,
-						rx_status, beacon);
-		kfree(elems);
-	}
-
-	return bss;
+	return (void *)cbss->priv;
 }
 
 static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
-- 
2.38.1

