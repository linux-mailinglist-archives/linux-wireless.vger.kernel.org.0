Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE21C03DD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD3R0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 13:26:00 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:41218 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726380AbgD3R0A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 13:26:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 3B3E74F7A11;
        Thu, 30 Apr 2020 17:26:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0CML6WX8NXZB; Thu, 30 Apr 2020 17:25:56 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 018BD4F80ED;
        Thu, 30 Apr 2020 17:25:55 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 1/5] cfg80211: add KHz variants of frame RX API
Date:   Thu, 30 Apr 2020 10:25:50 -0700
Message-Id: <20200430172554.18383-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430172554.18383-1-thomas@adapt-ip.com>
References: <20200430172554.18383-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drivers may wish to report the RX frequency in units of
KHz. Provide cfg80211_rx_mgmt_khz() and wrap it with
cfg80211_rx_mgmt() so exisiting drivers which can't report
KHz anyway don't need to change. Add a similar wrapper for
cfg80211_report_obss_beacon() so the frequency units stay
somewhat consistent.

This doesn't actually change the nl80211 API yet.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---
v3:
wrap functions with _khz() (Johannes)
update trace entries with PR_KHZ()

v4:
drop float from PR_KHZ (Johannes)
---
 include/linux/ieee80211.h |  2 ++
 include/net/cfg80211.h    | 54 +++++++++++++++++++++++++++++++++++----
 net/mac80211/rx.c         |  8 +++---
 net/wireless/mlme.c       |  8 +++---
 net/wireless/nl80211.c    | 14 +++++-----
 net/wireless/trace.h      | 12 ++++-----
 6 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a561db435a4b..41d5f000c0d9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3333,6 +3333,8 @@ static inline int ieee80211_get_tdls_action(struct sk_buff *skb, u32 hdr_size)
 /* convert frequencies */
 #define MHZ_TO_KHZ(freq) ((freq) * 1000)
 #define KHZ_TO_MHZ(freq) ((freq) / 1000)
+#define PR_KHZ(f) KHZ_TO_MHZ(f), f % 1000
+#define KHZ_F "%d.%03d"
 
 /* convert powers */
 #define DBI_TO_MBI(gain) ((gain) * 100)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a82fc59a1d82..3746b52c954e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6986,6 +6986,26 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
 			  enum nl80211_connect_failed_reason reason,
 			  gfp_t gfp);
 
+/**
+ * cfg80211_rx_mgmt_khz - notification of received, unprocessed management frame
+ * @wdev: wireless device receiving the frame
+ * @freq: Frequency on which the frame was received in KHz
+ * @sig_dbm: signal strength in dBm, or 0 if unknown
+ * @buf: Management frame (header + body)
+ * @len: length of the frame data
+ * @flags: flags, as defined in enum nl80211_rxmgmt_flags
+ *
+ * This function is called whenever an Action frame is received for a station
+ * mode interface, but is not processed in kernel.
+ *
+ * Return: %true if a user space application has registered for this frame.
+ * For action frames, that makes it responsible for rejecting unrecognized
+ * action frames; %false otherwise, in which case for action frames the
+ * driver is responsible for rejecting the frame.
+ */
+bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
+			  const u8 *buf, size_t len, u32 flags);
+
 /**
  * cfg80211_rx_mgmt - notification of received, unprocessed management frame
  * @wdev: wireless device receiving the frame
@@ -7003,8 +7023,13 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * action frames; %false otherwise, in which case for action frames the
  * driver is responsible for rejecting the frame.
  */
-bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq, int sig_dbm,
-		      const u8 *buf, size_t len, u32 flags);
+static inline bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq,
+				    int sig_dbm, const u8 *buf, size_t len,
+				    u32 flags)
+{
+	return cfg80211_rx_mgmt_khz(wdev, MHZ_TO_KHZ(freq), sig_dbm, buf, len,
+				    flags);
+}
 
 /**
  * cfg80211_mgmt_tx_status - notification of TX status for management frame
@@ -7202,6 +7227,21 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 			   u64 cookie, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp);
 
+/**
+ * cfg80211_report_obss_beacon_khz - report beacon from other APs
+ * @wiphy: The wiphy that received the beacon
+ * @frame: the frame
+ * @len: length of the frame
+ * @freq: frequency the frame was received on in KHz
+ * @sig_dbm: signal strength in dBm, or 0 if unknown
+ *
+ * Use this function to report to userspace when a beacon was
+ * received. It is not useful to call this when there is no
+ * netdev that is in AP/GO mode.
+ */
+void cfg80211_report_obss_beacon_khz(struct wiphy *wiphy, const u8 *frame,
+				     size_t len, int freq, int sig_dbm);
+
 /**
  * cfg80211_report_obss_beacon - report beacon from other APs
  * @wiphy: The wiphy that received the beacon
@@ -7214,9 +7254,13 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
  * received. It is not useful to call this when there is no
  * netdev that is in AP/GO mode.
  */
-void cfg80211_report_obss_beacon(struct wiphy *wiphy,
-				 const u8 *frame, size_t len,
-				 int freq, int sig_dbm);
+static inline void cfg80211_report_obss_beacon(struct wiphy *wiphy,
+					       const u8 *frame, size_t len,
+					       int freq, int sig_dbm)
+{
+	cfg80211_report_obss_beacon_khz(wiphy, frame, len, MHZ_TO_KHZ(freq),
+					sig_dbm);
+}
 
 /**
  * cfg80211_reg_can_beacon - check if beaconing is allowed
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index eaf8931e4627..007eca52afe6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3097,7 +3097,8 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 
 		cfg80211_report_obss_beacon(rx->local->hw.wiphy,
 					    rx->skb->data, rx->skb->len,
-					    status->freq, sig);
+					    ieee80211_rx_status_to_khz(status),
+					    sig);
 		rx->flags |= IEEE80211_RX_BEACON_REPORTED;
 	}
 
@@ -3443,8 +3444,9 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 	    !(status->flag & RX_FLAG_NO_SIGNAL_VAL))
 		sig = status->signal;
 
-	if (cfg80211_rx_mgmt(&rx->sdata->wdev, status->freq, sig,
-			     rx->skb->data, rx->skb->len, 0)) {
+	if (cfg80211_rx_mgmt_khz(&rx->sdata->wdev,
+				 ieee80211_rx_status_to_khz(status), sig,
+				 rx->skb->data, rx->skb->len, 0)) {
 		if (rx->sta)
 			rx->sta->rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 409497a3527d..ca51fbf89b80 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -729,8 +729,8 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 	return rdev_mgmt_tx(rdev, wdev, params, cookie);
 }
 
-bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq, int sig_dbm,
-		      const u8 *buf, size_t len, u32 flags)
+bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
+			  const u8 *buf, size_t len, u32 flags)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -745,7 +745,7 @@ bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq, int sig_dbm,
 		cpu_to_le16(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE);
 	u16 stype;
 
-	trace_cfg80211_rx_mgmt(wdev, freq, sig_dbm);
+	trace_cfg80211_rx_mgmt_khz(wdev, freq, sig_dbm);
 	stype = (le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
 
 	if (!(stypes->rx & BIT(stype))) {
@@ -785,7 +785,7 @@ bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq, int sig_dbm,
 	trace_cfg80211_return_bool(result);
 	return result;
 }
-EXPORT_SYMBOL(cfg80211_rx_mgmt);
+EXPORT_SYMBOL(cfg80211_rx_mgmt_khz);
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev)
 {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3d27b24c68b2..755701132d71 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16256,7 +16256,7 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 					netdev->ifindex)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
-	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, freq) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, KHZ_TO_MHZ(freq)) ||
 	    (sig_dbm &&
 	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
 	    nla_put(msg, NL80211_ATTR_FRAME, len, buf) ||
@@ -16882,16 +16882,15 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 }
 EXPORT_SYMBOL(cfg80211_probe_status);
 
-void cfg80211_report_obss_beacon(struct wiphy *wiphy,
-				 const u8 *frame, size_t len,
-				 int freq, int sig_dbm)
+void cfg80211_report_obss_beacon_khz(struct wiphy *wiphy, const u8 *frame,
+				     size_t len, int freq, int sig_dbm)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct sk_buff *msg;
 	void *hdr;
 	struct cfg80211_beacon_registration *reg;
 
-	trace_cfg80211_report_obss_beacon(wiphy, frame, len, freq, sig_dbm);
+	trace_cfg80211_report_obss_beacon_khz(wiphy, frame, len, freq, sig_dbm);
 
 	spin_lock_bh(&rdev->beacon_registrations_lock);
 	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -16907,7 +16906,8 @@ void cfg80211_report_obss_beacon(struct wiphy *wiphy,
 
 		if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 		    (freq &&
-		     nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, freq)) ||
+		     nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ,
+				 KHZ_TO_MHZ(freq))) ||
 		    (sig_dbm &&
 		     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
 		    nla_put(msg, NL80211_ATTR_FRAME, len, frame))
@@ -16924,7 +16924,7 @@ void cfg80211_report_obss_beacon(struct wiphy *wiphy,
 	spin_unlock_bh(&rdev->beacon_registrations_lock);
 	nlmsg_free(msg);
 }
-EXPORT_SYMBOL(cfg80211_report_obss_beacon);
+EXPORT_SYMBOL(cfg80211_report_obss_beacon_khz);
 
 #ifdef CONFIG_PM
 static int cfg80211_net_detect_results(struct sk_buff *msg,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 53c887ea67c7..8be8b9ce2a48 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2827,7 +2827,7 @@ DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_del_sta,
 	TP_ARGS(netdev, macaddr)
 );
 
-TRACE_EVENT(cfg80211_rx_mgmt,
+TRACE_EVENT(cfg80211_rx_mgmt_khz,
 	TP_PROTO(struct wireless_dev *wdev, int freq, int sig_dbm),
 	TP_ARGS(wdev, freq, sig_dbm),
 	TP_STRUCT__entry(
@@ -2840,8 +2840,8 @@ TRACE_EVENT(cfg80211_rx_mgmt,
 		__entry->freq = freq;
 		__entry->sig_dbm = sig_dbm;
 	),
-	TP_printk(WDEV_PR_FMT ", freq: %d, sig dbm: %d",
-		  WDEV_PR_ARG, __entry->freq, __entry->sig_dbm)
+	TP_printk(WDEV_PR_FMT ", freq: "KHZ_F", sig dbm: %d",
+		  WDEV_PR_ARG, PR_KHZ(__entry->freq), __entry->sig_dbm)
 );
 
 TRACE_EVENT(cfg80211_mgmt_tx_status,
@@ -3107,7 +3107,7 @@ TRACE_EVENT(cfg80211_pmksa_candidate_notify,
 		  BOOL_TO_STR(__entry->preauth))
 );
 
-TRACE_EVENT(cfg80211_report_obss_beacon,
+TRACE_EVENT(cfg80211_report_obss_beacon_khz,
 	TP_PROTO(struct wiphy *wiphy, const u8 *frame, size_t len,
 		 int freq, int sig_dbm),
 	TP_ARGS(wiphy, frame, len, freq, sig_dbm),
@@ -3121,8 +3121,8 @@ TRACE_EVENT(cfg80211_report_obss_beacon,
 		__entry->freq = freq;
 		__entry->sig_dbm = sig_dbm;
 	),
-	TP_printk(WIPHY_PR_FMT ", freq: %d, sig_dbm: %d",
-		  WIPHY_PR_ARG, __entry->freq, __entry->sig_dbm)
+	TP_printk(WIPHY_PR_FMT ", freq: "KHZ_F", sig_dbm: %d",
+		  WIPHY_PR_ARG, PR_KHZ(__entry->freq), __entry->sig_dbm)
 );
 
 TRACE_EVENT(cfg80211_tdls_oper_request,
-- 
2.20.1

