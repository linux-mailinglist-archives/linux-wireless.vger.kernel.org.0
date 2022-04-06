Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FF4F63C4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiDFPjS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiDFPiW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:38:22 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF436C730
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:52:46 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4Tb-000pov-Bo;
        Wed, 06 Apr 2022 15:09:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:20 +0300
Message-Id: <iwlwifi.20220406145756.04af2017dd54.I8817e862b11039a7ead1ac8395ea314250462460@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406120924.979792-1-luca@coelho.fi>
References: <20220406120924.979792-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 3/7] cfg80211/nl80211: move rx management data into a struct
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The functions for reporting rx management take many arguments.
Collect all the arguments into a struct, which also make it easier
to add more arguments if needed.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 60 +++++++++++++++++++++++++++++++++++++++---
 net/wireless/mlme.c    | 21 +++++++--------
 net/wireless/nl80211.c | 19 +++++++------
 net/wireless/nl80211.h |  5 ++--
 net/wireless/trace.h   |  8 +++---
 5 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 13c2ad88adb1..ae20256c3243 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7529,6 +7529,39 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
 			  enum nl80211_connect_failed_reason reason,
 			  gfp_t gfp);
 
+/**
+ * struct cfg80211_rx_info - received management frame info
+ *
+ * @freq: Frequency on which the frame was received in kHz
+ * @sig_dbm: signal strength in dBm, or 0 if unknown
+ * @buf: Management frame (header + body)
+ * @len: length of the frame data
+ * @flags: flags, as defined in enum nl80211_rxmgmt_flags
+ */
+struct cfg80211_rx_info {
+	int freq;
+	int sig_dbm;
+	const u8 *buf;
+	size_t len;
+	u32 flags;
+};
+
+/**
+ * cfg80211_rx_mgmt_ext - management frame notification with extended info
+ * @wdev: wireless device receiving the frame
+ * @info: RX info as defined in struct cfg80211_rx_info
+ *
+ * This function is called whenever an Action frame is received for a station
+ * mode interface, but is not processed in kernel.
+ *
+ * Return: %true if a user space application has registered for this frame.
+ * For action frames, that makes it responsible for rejecting unrecognized
+ * action frames; %false otherwise, in which case for action frames the
+ * driver is responsible for rejecting the frame.
+ */
+bool cfg80211_rx_mgmt_ext(struct wireless_dev *wdev,
+			  struct cfg80211_rx_info *info);
+
 /**
  * cfg80211_rx_mgmt_khz - notification of received, unprocessed management frame
  * @wdev: wireless device receiving the frame
@@ -7546,8 +7579,20 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * action frames; %false otherwise, in which case for action frames the
  * driver is responsible for rejecting the frame.
  */
-bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
-			  const u8 *buf, size_t len, u32 flags);
+static inline bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq,
+					int sig_dbm, const u8 *buf, size_t len,
+					u32 flags)
+{
+	struct cfg80211_rx_info info = {
+		.freq = freq,
+		.sig_dbm = sig_dbm,
+		.buf = buf,
+		.len = len,
+		.flags = flags
+	};
+
+	return cfg80211_rx_mgmt_ext(wdev, &info);
+}
 
 /**
  * cfg80211_rx_mgmt - notification of received, unprocessed management frame
@@ -7570,8 +7615,15 @@ static inline bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq,
 				    int sig_dbm, const u8 *buf, size_t len,
 				    u32 flags)
 {
-	return cfg80211_rx_mgmt_khz(wdev, MHZ_TO_KHZ(freq), sig_dbm, buf, len,
-				    flags);
+	struct cfg80211_rx_info info = {
+		.freq = MHZ_TO_KHZ(freq),
+		.sig_dbm = sig_dbm,
+		.buf = buf,
+		.len = len,
+		.flags = flags
+	};
+
+	return cfg80211_rx_mgmt_ext(wdev, &info);
 }
 
 /**
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index c8155a483ec2..f3492c5fb3d3 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
- * Copyright (C) 2019-2020 Intel Corporation
+ * Copyright (C) 2019-2020, 2022 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -759,15 +759,15 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 	return rdev_mgmt_tx(rdev, wdev, params, cookie);
 }
 
-bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
-			  const u8 *buf, size_t len, u32 flags)
+bool cfg80211_rx_mgmt_ext(struct wireless_dev *wdev,
+			  struct cfg80211_rx_info *info)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_mgmt_registration *reg;
 	const struct ieee80211_txrx_stypes *stypes =
 		&wiphy->mgmt_stypes[wdev->iftype];
-	struct ieee80211_mgmt *mgmt = (void *)buf;
+	struct ieee80211_mgmt *mgmt = (void *)info->buf;
 	const u8 *data;
 	int data_len;
 	bool result = false;
@@ -775,7 +775,7 @@ bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
 		cpu_to_le16(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE);
 	u16 stype;
 
-	trace_cfg80211_rx_mgmt(wdev, freq, sig_dbm);
+	trace_cfg80211_rx_mgmt(wdev, info);
 	stype = (le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
 
 	if (!(stypes->rx & BIT(stype))) {
@@ -783,8 +783,8 @@ bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
 		return false;
 	}
 
-	data = buf + ieee80211_hdrlen(mgmt->frame_control);
-	data_len = len - ieee80211_hdrlen(mgmt->frame_control);
+	data = info->buf + ieee80211_hdrlen(mgmt->frame_control);
+	data_len = info->len - ieee80211_hdrlen(mgmt->frame_control);
 
 	spin_lock_bh(&rdev->mgmt_registrations_lock);
 
@@ -801,9 +801,8 @@ bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
 		/* found match! */
 
 		/* Indicate the received Action frame to user space */
-		if (nl80211_send_mgmt(rdev, wdev, reg->nlportid,
-				      freq, sig_dbm,
-				      buf, len, flags, GFP_ATOMIC))
+		if (nl80211_send_mgmt(rdev, wdev, reg->nlportid, info,
+				      GFP_ATOMIC))
 			continue;
 
 		result = true;
@@ -815,7 +814,7 @@ bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
 	trace_cfg80211_return_bool(result);
 	return result;
 }
-EXPORT_SYMBOL(cfg80211_rx_mgmt_khz);
+EXPORT_SYMBOL(cfg80211_rx_mgmt_ext);
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev)
 {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bc9818dd2f9a..fe4b62b4715f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17420,14 +17420,13 @@ EXPORT_SYMBOL(cfg80211_rx_unexpected_4addr_frame);
 
 int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 		      struct wireless_dev *wdev, u32 nlportid,
-		      int freq, int sig_dbm,
-		      const u8 *buf, size_t len, u32 flags, gfp_t gfp)
+		      struct cfg80211_rx_info *info, gfp_t gfp)
 {
 	struct net_device *netdev = wdev->netdev;
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(100 + len, gfp);
+	msg = nlmsg_new(100 + info->len, gfp);
 	if (!msg)
 		return -ENOMEM;
 
@@ -17442,13 +17441,13 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 					netdev->ifindex)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
-	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, KHZ_TO_MHZ(freq)) ||
-	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ_OFFSET, freq % 1000) ||
-	    (sig_dbm &&
-	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
-	    nla_put(msg, NL80211_ATTR_FRAME, len, buf) ||
-	    (flags &&
-	     nla_put_u32(msg, NL80211_ATTR_RXMGMT_FLAGS, flags)))
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, KHZ_TO_MHZ(info->freq)) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ_OFFSET, info->freq % 1000) ||
+	    (info->sig_dbm &&
+	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, info->sig_dbm)) ||
+	    nla_put(msg, NL80211_ATTR_FRAME, info->len, info->buf) ||
+	    (info->flags &&
+	     nla_put_u32(msg, NL80211_ATTR_RXMGMT_FLAGS, info->flags)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index d642e3be4ee7..88824b357a7d 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions of this file
- * Copyright (C) 2018, 2020-2021 Intel Corporation
+ * Copyright (C) 2018, 2020-2022 Intel Corporation
  */
 #ifndef __NET_WIRELESS_NL80211_H
 #define __NET_WIRELESS_NL80211_H
@@ -107,8 +107,7 @@ void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 
 int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 		      struct wireless_dev *wdev, u32 nlpid,
-		      int freq, int sig_dbm,
-		      const u8 *buf, size_t len, u32 flags, gfp_t gfp);
+		      struct cfg80211_rx_info *info, gfp_t gfp);
 
 void
 nl80211_radar_notify(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 228079d7690a..288ee19e1eb6 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2892,8 +2892,8 @@ DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_del_sta,
 );
 
 TRACE_EVENT(cfg80211_rx_mgmt,
-	TP_PROTO(struct wireless_dev *wdev, int freq, int sig_dbm),
-	TP_ARGS(wdev, freq, sig_dbm),
+	TP_PROTO(struct wireless_dev *wdev, struct cfg80211_rx_info *info),
+	TP_ARGS(wdev, info),
 	TP_STRUCT__entry(
 		WDEV_ENTRY
 		__field(int, freq)
@@ -2901,8 +2901,8 @@ TRACE_EVENT(cfg80211_rx_mgmt,
 	),
 	TP_fast_assign(
 		WDEV_ASSIGN;
-		__entry->freq = freq;
-		__entry->sig_dbm = sig_dbm;
+		__entry->freq = info->freq;
+		__entry->sig_dbm = info->sig_dbm;
 	),
 	TP_printk(WDEV_PR_FMT ", freq: "KHZ_F", sig dbm: %d",
 		  WDEV_PR_ARG, PR_KHZ(__entry->freq), __entry->sig_dbm)
-- 
2.35.1

