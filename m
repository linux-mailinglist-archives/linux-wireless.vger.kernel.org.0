Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0671125512C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgH0Wdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:44 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50590 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728054AbgH0Wdn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 1FF294F8442;
        Thu, 27 Aug 2020 22:33:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I0IbQua6Bclh; Thu, 27 Aug 2020 22:33:37 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 100C54F825E;
        Thu, 27 Aug 2020 22:33:12 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 18/22] mac80211: receive and process S1G beacons
Date:   Thu, 27 Aug 2020 15:33:00 -0700
Message-Id: <20200827223304.16155-19-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G beacons are 802.11 Extension Frames, so the fixed
header part differs from regular beacons.

Add a handler to process S1G beacons and abstract out the
fetching of BSSID and element start locations in the
beacon body handler.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/iface.c       |  5 +++
 net/mac80211/mlme.c        | 87 +++++++++++++++++++++++++++++---------
 net/mac80211/rx.c          | 84 ++++++++++++++++--------------------
 net/mac80211/util.c        | 52 +++++++++++++++++++++++
 5 files changed, 164 insertions(+), 68 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8b779ad363c5..5d0157065db6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1649,6 +1649,8 @@ int ieee80211_set_arp_filter(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
+void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
+				 struct sk_buff *skb);
 void ieee80211_sta_reset_beacon_monitor(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_reset_conn_monitor(struct ieee80211_sub_if_data *sdata);
 void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata);
@@ -2294,6 +2296,8 @@ void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
 				      const u8 *peer, u16 reason);
 const char *ieee80211_get_reason_code_string(u16 reason_code);
 __le16 ieee80211_encode_usf(int val);
+u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
+			enum nl80211_iftype type);
 
 extern const struct ethtool_ops ieee80211_ethtool_ops;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9740ae8fa697..1369f6e575d7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1379,6 +1379,11 @@ static void ieee80211_iface_work(struct work_struct *work)
 				WARN_ON(1);
 				break;
 			}
+		} else if (ieee80211_is_ext(mgmt->frame_control)) {
+			if (sdata->vif.type == NL80211_IFTYPE_STATION)
+				ieee80211_sta_rx_queued_ext(sdata, skb);
+			else
+				WARN_ON(1);
 		} else if (ieee80211_is_data_qos(mgmt->frame_control)) {
 			struct ieee80211_hdr *hdr = (void *)mgmt;
 			/*
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6a62a221b89e..9a26ef99cef9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1604,6 +1604,9 @@ static u32 ieee80211_handle_pwr_constr(struct ieee80211_sub_if_data *sdata,
 	int new_ap_level;
 	__le16 capab = mgmt->u.probe_resp.capab_info;
 
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
+		return 0;	/* TODO */
+
 	if (country_ie &&
 	    (capab & cpu_to_le16(WLAN_CAPABILITY_SPECTRUM_MGMT) ||
 	     capab & cpu_to_le16(WLAN_CAPABILITY_RADIO_MEASURE))) {
@@ -2450,7 +2453,8 @@ void ieee80211_sta_rx_notify(struct ieee80211_sub_if_data *sdata,
 	 * data idle periods for sending the periodic probe request to the
 	 * AP we're connected to.
 	 */
-	if (is_multicast_ether_addr(hdr->addr1))
+	if (is_multicast_ether_addr(hdr->addr1) ||
+	    ieee80211_is_s1g_beacon(hdr->frame_control))
 		return;
 
 	ieee80211_sta_reset_conn_monitor(sdata);
@@ -3919,12 +3923,13 @@ static bool ieee80211_rx_our_beacon(const u8 *tx_bssid,
 	return ether_addr_equal(tx_bssid, bss->transmitted_bss->bssid);
 }
 
-static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
-				     struct ieee80211_mgmt *mgmt, size_t len,
-				     struct ieee80211_rx_status *rx_status)
+static void ieee80211_rx_beacon(struct ieee80211_sub_if_data *sdata,
+				struct ieee80211_hdr *hdr, size_t len,
+				struct ieee80211_rx_status *rx_status)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_mgmt *mgmt = (void *) hdr;
 	size_t baselen;
 	struct ieee802_11_elems elems;
 	struct ieee80211_local *local = sdata->local;
@@ -3934,14 +3939,24 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	u32 changed = 0;
 	bool erp_valid;
 	u8 erp_value = 0;
-	u32 ncrc;
-	u8 *bssid;
+	u32 ncrc = 0;
+	u8 *bssid, *variable = mgmt->u.beacon.variable;
 	u8 deauth_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
 	sdata_assert_lock(sdata);
 
 	/* Process beacon from the current BSS */
-	baselen = (u8 *) mgmt->u.beacon.variable - (u8 *) mgmt;
+	bssid = ieee80211_get_bssid(hdr, len, sdata->vif.type);
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		struct ieee80211_ext *ext = (void *) mgmt;
+
+		if (ieee80211_is_s1g_short_beacon(ext->frame_control))
+			variable = ext->u.s1g_short_beacon.variable;
+		else
+			variable = ext->u.s1g_beacon.variable;
+	}
+
+	baselen = (u8 *) variable - (u8 *) mgmt;
 	if (baselen > len)
 		return;
 
@@ -3961,10 +3976,10 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	rcu_read_unlock();
 
 	if (ifmgd->assoc_data && ifmgd->assoc_data->need_beacon &&
-	    ieee80211_rx_our_beacon(mgmt->bssid, ifmgd->assoc_data->bss)) {
-		ieee802_11_parse_elems(mgmt->u.beacon.variable,
+	    ieee80211_rx_our_beacon(bssid, ifmgd->assoc_data->bss)) {
+		ieee802_11_parse_elems(variable,
 				       len - baselen, false, &elems,
-				       mgmt->bssid,
+				       bssid,
 				       ifmgd->assoc_data->bss->bssid);
 
 		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
@@ -3997,7 +4012,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!ifmgd->associated ||
-	    !ieee80211_rx_our_beacon(mgmt->bssid,  ifmgd->associated))
+	    !ieee80211_rx_our_beacon(bssid,  ifmgd->associated))
 		return;
 	bssid = ifmgd->associated->bssid;
 
@@ -4017,8 +4032,14 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 */
 	ieee80211_sta_reset_beacon_monitor(sdata);
 
-	ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
-	ncrc = ieee802_11_parse_elems_crc(mgmt->u.beacon.variable,
+	/* TODO: CRC urrently not calculated on S1G Beacon Compatibility
+	 * element (which carries the beacon interval). Don't forget to add a
+	 * bit to care_about_ies[] above if mac80211 is interested in a
+	 * changing S1G element.
+	 */
+	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
+		ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
+	ncrc = ieee802_11_parse_elems_crc(variable,
 					  len - baselen, false, &elems,
 					  care_about_ies, ncrc,
 					  mgmt->bssid, bssid);
@@ -4052,7 +4073,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_p2p_noa_attr noa = {};
 		int ret;
 
-		ret = cfg80211_get_p2p_attr(mgmt->u.beacon.variable,
+		ret = cfg80211_get_p2p_attr(variable,
 					    len - baselen,
 					    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 					    (u8 *) &noa, sizeof(noa));
@@ -4088,7 +4109,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 * the driver will use them. The synchronized view is currently
 	 * guaranteed only in certain callbacks.
 	 */
-	if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+	if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
+	    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
 		sdata->vif.bss_conf.sync_tsf =
 			le64_to_cpu(mgmt->u.beacon.timestamp);
 		sdata->vif.bss_conf.sync_device_ts =
@@ -4096,7 +4118,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.bss_conf.sync_dtim_count = elems.dtim_count;
 	}
 
-	if (ncrc == ifmgd->beacon_crc && ifmgd->beacon_crc_valid)
+	if ((ncrc == ifmgd->beacon_crc && ifmgd->beacon_crc_valid) ||
+	    ieee80211_is_s1g_short_beacon(mgmt->frame_control))
 		return;
 	ifmgd->beacon_crc = ncrc;
 	ifmgd->beacon_crc_valid = true;
@@ -4137,9 +4160,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	} else {
 		erp_valid = false;
 	}
-	changed |= ieee80211_handle_bss_capability(sdata,
-			le16_to_cpu(mgmt->u.beacon.capab_info),
-			erp_valid, erp_value);
+
+	if (!ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		changed |= ieee80211_handle_bss_capability(sdata,
+				le16_to_cpu(mgmt->u.beacon.capab_info),
+				erp_valid, erp_value);
+	}
 
 	mutex_lock(&local->sta_mtx);
 	sta = sta_info_get(sdata, bssid);
@@ -4177,6 +4203,26 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	ieee80211_bss_info_change_notify(sdata, changed);
 }
 
+void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
+				 struct sk_buff *skb)
+{
+	struct ieee80211_rx_status *rx_status;
+	struct ieee80211_hdr *hdr;
+	u16 fc;
+
+	rx_status = (struct ieee80211_rx_status *) skb->cb;
+	hdr = (struct ieee80211_hdr *) skb->data;
+	fc = le16_to_cpu(hdr->frame_control);
+
+	sdata_lock(sdata);
+	switch (fc & IEEE80211_FCTL_STYPE) {
+	case IEEE80211_STYPE_S1G_BEACON:
+		ieee80211_rx_beacon(sdata, hdr, skb->len, rx_status);
+		break;
+	}
+	sdata_unlock(sdata);
+}
+
 void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb)
 {
@@ -4194,7 +4240,8 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 
 	switch (fc & IEEE80211_FCTL_STYPE) {
 	case IEEE80211_STYPE_BEACON:
-		ieee80211_rx_mgmt_beacon(sdata, mgmt, skb->len, rx_status);
+		ieee80211_rx_beacon(sdata, (struct ieee80211_hdr *) mgmt,
+				    skb->len, rx_status);
 		break;
 	case IEEE80211_STYPE_PROBE_RESP:
 		ieee80211_rx_mgmt_probe_resp(sdata, skb);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5b92f56682e2..e1291898bde8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -42,51 +42,6 @@ static inline void ieee80211_rx_stats(struct net_device *dev, u32 len)
 	u64_stats_update_end(&tstats->syncp);
 }
 
-static u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
-			       enum nl80211_iftype type)
-{
-	__le16 fc = hdr->frame_control;
-
-	if (ieee80211_is_data(fc)) {
-		if (len < 24) /* drop incorrect hdr len (data) */
-			return NULL;
-
-		if (ieee80211_has_a4(fc))
-			return NULL;
-		if (ieee80211_has_tods(fc))
-			return hdr->addr1;
-		if (ieee80211_has_fromds(fc))
-			return hdr->addr2;
-
-		return hdr->addr3;
-	}
-
-	if (ieee80211_is_mgmt(fc)) {
-		if (len < 24) /* drop incorrect hdr len (mgmt) */
-			return NULL;
-		return hdr->addr3;
-	}
-
-	if (ieee80211_is_ctl(fc)) {
-		if (ieee80211_is_pspoll(fc))
-			return hdr->addr1;
-
-		if (ieee80211_is_back_req(fc)) {
-			switch (type) {
-			case NL80211_IFTYPE_STATION:
-				return hdr->addr2;
-			case NL80211_IFTYPE_AP:
-			case NL80211_IFTYPE_AP_VLAN:
-				return hdr->addr1;
-			default:
-				break; /* fall through to the return */
-			}
-		}
-	}
-
-	return NULL;
-}
-
 /*
  * monitor mode reception
  *
@@ -1801,7 +1756,8 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		}
 	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
 		sta->rx_stats.last_rx = jiffies;
-	} else if (!is_multicast_ether_addr(hdr->addr1)) {
+	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
+		   is_multicast_ether_addr(hdr->addr1)) {
 		/*
 		 * Mesh beacons will update last_rx when if they are found to
 		 * match the current local configuration when processed.
@@ -1839,6 +1795,9 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		}
 	}
 
+	if (ieee80211_is_s1g_beacon(hdr->frame_control))
+		return RX_CONTINUE;
+
 	/*
 	 * Change STA power saving mode only at the end of a frame
 	 * exchange sequence, and only for a data or management
@@ -1949,6 +1908,9 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	__le16 fc;
 	const struct ieee80211_cipher_scheme *cs = NULL;
 
+	if (ieee80211_is_ext(hdr->frame_control))
+		return RX_CONTINUE;
+
 	/*
 	 * Key selection 101
 	 *
@@ -2257,7 +2219,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	hdr = (struct ieee80211_hdr *)rx->skb->data;
 	fc = hdr->frame_control;
 
-	if (ieee80211_is_ctl(fc))
+	if (ieee80211_is_ctl(fc) || ieee80211_is_ext(fc))
 		return RX_CONTINUE;
 
 	sc = le16_to_cpu(hdr->seq_ctrl);
@@ -3131,6 +3093,9 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *) rx->skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
+		return RX_CONTINUE;
+
 	/*
 	 * From here on, look only at management frames.
 	 * Data and control frames are already handled,
@@ -3597,6 +3562,27 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 	return RX_QUEUED;
 }
 
+static ieee80211_rx_result debug_noinline
+ieee80211_rx_h_ext(struct ieee80211_rx_data *rx)
+{
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	struct ieee80211_hdr *hdr = (void *)rx->skb->data;
+
+	if (!ieee80211_is_ext(hdr->frame_control))
+		return RX_CONTINUE;
+
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+		return RX_DROP_MONITOR;
+
+	/* for now only beacons are ext, so queue them */
+	skb_queue_tail(&sdata->skb_queue, rx->skb);
+	ieee80211_queue_work(&rx->local->hw, &sdata->work);
+	if (rx->sta)
+		rx->sta->rx_stats.packets++;
+
+	return RX_QUEUED;
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 {
@@ -3816,6 +3802,7 @@ static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 		CALL_RXH(ieee80211_rx_h_userspace_mgmt);
 		CALL_RXH(ieee80211_rx_h_action_post_userspace);
 		CALL_RXH(ieee80211_rx_h_action_return);
+		CALL_RXH(ieee80211_rx_h_ext);
 		CALL_RXH(ieee80211_rx_h_mgmt);
 
  rxh_next:
@@ -3982,7 +3969,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
+			 ieee80211_is_s1g_beacon(hdr->frame_control);
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index caf4098deeda..0d304c328f7e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -45,6 +45,58 @@ struct ieee80211_hw *wiphy_to_ieee80211_hw(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_to_ieee80211_hw);
 
+u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
+			enum nl80211_iftype type)
+{
+	__le16 fc = hdr->frame_control;
+
+	if (ieee80211_is_data(fc)) {
+		if (len < 24) /* drop incorrect hdr len (data) */
+			return NULL;
+
+		if (ieee80211_has_a4(fc))
+			return NULL;
+		if (ieee80211_has_tods(fc))
+			return hdr->addr1;
+		if (ieee80211_has_fromds(fc))
+			return hdr->addr2;
+
+		return hdr->addr3;
+	}
+
+	if (ieee80211_is_s1g_beacon(fc)) {
+		struct ieee80211_ext *ext = (void *) hdr;
+
+		return ext->u.s1g_beacon.sa;
+	}
+
+	if (ieee80211_is_mgmt(fc)) {
+		if (len < 24) /* drop incorrect hdr len (mgmt) */
+			return NULL;
+		return hdr->addr3;
+	}
+
+	if (ieee80211_is_ctl(fc)) {
+		if (ieee80211_is_pspoll(fc))
+			return hdr->addr1;
+
+		if (ieee80211_is_back_req(fc)) {
+			switch (type) {
+			case NL80211_IFTYPE_STATION:
+				return hdr->addr2;
+			case NL80211_IFTYPE_AP:
+			case NL80211_IFTYPE_AP_VLAN:
+				return hdr->addr1;
+			default:
+				break; /* fall through to the return */
+			}
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ieee80211_get_bssid);
+
 void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx)
 {
 	struct sk_buff *skb;
-- 
2.20.1

