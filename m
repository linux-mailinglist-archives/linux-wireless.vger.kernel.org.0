Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9984F18A9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378631AbiDDPoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378362AbiDDPn7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 11:43:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F457393F5
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649086920; x=1680622920;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=SrAy0X+kV9h7VzIhvrYwXcY5mDZo8Zjvc6UY4PNmz+M=;
  b=kMv6IP5EK2r7MUDlkXSCTU1iIgxP8mdq+MMMBtiDXvJIYfxuMis4HjyZ
   VgM9LR9Bf0/KSmP/CiEoCXYutCwEeM8SfxSU/ZWGMS/xAQ+BS9eGUwAbn
   7Y0r4zK4Ap4nzX+WUYOV+3A7qS2WSttnp6BhvYm/Sml4ruhX2PHzb+09t
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Apr 2022 08:41:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 08:41:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 08:41:43 -0700
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 08:41:39 -0700
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] mac80211: prepare sta handling for MLO support
Date:   Mon, 4 Apr 2022 21:11:23 +0530
Message-ID: <1649086883-13246-1-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in mac80211 each STA object is represented
using sta_info datastructure with the associated
STA specific information and drivers access ieee80211_sta
part of it.

With MLO (Multi Link Operation) support being added
in 802.11be standard, though the association is logically
with a single Multi Link capable STA, at the physical level
communication can happen via different advertised
links (uniquely identified by Channel, operating class,
BSSID) and hence the need to handle multiple link
STA parameters within a composite sta_info object
called the MLD STA. The different link STA part of
MLD STA are identified using the link address which can
be same or different as the MLD STA address and unique
link id based on the link vif.

To support extension of such a model, the sta_info
datastructure is modified to hold multiple link STA
objects with link specific params currently within
sta_info moved to this new structure. Similarly this is
done for ieee80211_sta as well which will be accessed
within mac80211 as well as by drivers, hence trivial
driver changes are expected to support this.

For current non MLO supported drivers, only one link STA
is present and link information is accessed via 'deflink'
member.

Note for MLO supported drivers:
In mac80211 ops, the link id can be fetched from the
passed link vif struct (TBD) and corresponding link STA
within ieee80211_sta can be accessed. If the vif passed to
the driver is a MLD vif in any case, it implies all
the affliated link vif and its link STA needs to
be handled for the particular mac80211 op.

In mac80211 for MLO usage, in cases where we need link sta(ex. to
get MLD STA from link address in 802.11 header) needs a new
lookup function to search for link sta address, This is TBD.
For legacy driver too this will work directly since the
address in sta_info and link_sta_info are same.
MLD supported drivers need to pass the link id or link
address and pubsta for ethernet mode to find the link sta.
Stats are accumulated per link sta and finally aggregated
if mld sta stats is required. These will be supported along
with MLO support patches.

Currently in mac80211, all link STA info are accessed directly
via deflink. These will be updated to access via link pointers
indexed by link id with MLO support patches, with link id
being 0 for non MLO supported cases.

Except for couple of macro related changes, below spatch takes
care of updating mac80211 and driver code to access to the
link STA info via deflink.

  @ieee80211_sta@
  struct ieee80211_sta *s;
  struct sta_info *si;
  identifier var = {supp_rates, ht_cap, vht_cap, he_cap, he_6ghz_capa, eht_cap, rx_nss, bandwidth, txpwr};
  @@

  (
    s->
  -    var
  +    deflink.var
  |
   si->sta.
  -    var
  +    deflink.var
  )

  @sta_info@
  struct sta_info *si;
  identifier var = {gtk, pcpu_rx_stats, rx_stats, rx_stats_avg, status_stats, tx_stats, cur_max_bandwidth};
  @@

  (
    si->
  -    var
  +    deflink.var
  )

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
RFC->PATCH: Added eht_cap in ieee80211_link_sta info and updated spatch in commit

 include/net/mac80211.h             |  80 +++++++++++++------
 net/mac80211/agg-rx.c              |  12 +--
 net/mac80211/agg-tx.c              |   6 +-
 net/mac80211/airtime.c             |   4 +-
 net/mac80211/cfg.c                 |  11 +--
 net/mac80211/chan.c                |   8 +-
 net/mac80211/debugfs_sta.c         |  12 +--
 net/mac80211/eht.c                 |   6 +-
 net/mac80211/ethtool.c             |   4 +-
 net/mac80211/he.c                  |   8 +-
 net/mac80211/ht.c                  |   8 +-
 net/mac80211/ibss.c                |  26 +++----
 net/mac80211/key.c                 |   9 ++-
 net/mac80211/mesh_hwmp.c           |   2 +-
 net/mac80211/mesh_plink.c          |  24 +++---
 net/mac80211/mlme.c                |  18 ++---
 net/mac80211/ocb.c                 |   2 +-
 net/mac80211/rate.c                |   8 +-
 net/mac80211/rc80211_minstrel_ht.c |  20 ++---
 net/mac80211/rx.c                  |  85 ++++++++++----------
 net/mac80211/s1g.c                 |   4 +-
 net/mac80211/sta_info.c            | 110 ++++++++++++++------------
 net/mac80211/sta_info.h            | 155 +++++++++++++++++++++++--------------
 net/mac80211/status.c              |  41 +++++-----
 net/mac80211/tdls.c                |  26 +++----
 net/mac80211/trace.h               |   4 +-
 net/mac80211/tx.c                  |  26 +++----
 net/mac80211/vht.c                 |  78 +++++++++----------
 28 files changed, 443 insertions(+), 354 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 382ebb8..35b9292 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2056,6 +2056,45 @@ struct ieee80211_sta_txpwr {
 	enum nl80211_tx_power_setting type;
 };
 
+#define MAX_STA_LINKS			15
+
+/**
+ * struct ieee80211_link_sta - station Link specific info
+ * All link specific info for a STA link for a non MLD STA(single)
+ * or a MLD STA(multiple entries) are stored here.
+ *
+ * @addr: MAC address of the Link STA. For non-MLO STA this is same as the addr
+ *	in ieee80211_sta. For MLO Link STA this addr can be same or different
+ *	from addr in ieee80211_sta (representing MLD STA addr)
+ * @supp_rates: Bitmap of supported rates
+ * @ht_cap: HT capabilities of this STA; restricted to our own capabilities
+ * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
+ * @he_cap: HE capabilities of this STA
+ * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
+ * @eht_cap: EHT capabilities of this STA
+ * @bandwidth: current bandwidth the station can receive with
+ * @rx_nss: in HT/VHT, the maximum number of spatial streams the
+ *	station can receive at the moment, changed by operating mode
+ *	notifications and capabilities. The value is only valid after
+ *	the station moves to associated state.
+ * @txpwr: the station tx power configuration
+ *
+ */
+struct ieee80211_link_sta {
+	u8 addr[ETH_ALEN];
+
+	u32 supp_rates[NUM_NL80211_BANDS];
+	struct ieee80211_sta_ht_cap ht_cap;
+	struct ieee80211_sta_vht_cap vht_cap;
+	struct ieee80211_sta_he_cap he_cap;
+	struct ieee80211_he_6ghz_capa he_6ghz_capa;
+	struct ieee80211_sta_eht_cap eht_cap;
+
+	u8 rx_nss;
+	enum ieee80211_sta_rx_bandwidth bandwidth;
+	struct ieee80211_sta_txpwr txpwr;
+};
+
 /**
  * struct ieee80211_sta - station table entry
  *
@@ -2065,15 +2104,11 @@ struct ieee80211_sta_txpwr {
  * either be protected by rcu_read_lock() explicitly or implicitly,
  * or you must take good care to not use such a pointer after a
  * call to your sta_remove callback that removed it.
+ * This also represents the MLD STA in case of MLO association
+ * and holds pointers to various link STA's
  *
  * @addr: MAC address
  * @aid: AID we assigned to the station if we're an AP
- * @supp_rates: Bitmap of supported rates (per band)
- * @ht_cap: HT capabilities of this STA; restricted to our own capabilities
- * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
- * @he_cap: HE capabilities of this STA
- * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
- * @eht_cap: EHT capabilities of this STA
  * @max_rx_aggregation_subframes: maximal amount of frames in a single AMPDU
  *	that this station is allowed to transmit to us.
  *	Can be modified by driver.
@@ -2085,11 +2120,6 @@ struct ieee80211_sta_txpwr {
  *	if wme is supported. The bits order is like in
  *	IEEE80211_WMM_IE_STA_QOSINFO_AC_*.
  * @max_sp: max Service Period. Only valid if wme is supported.
- * @bandwidth: current bandwidth the station can receive with
- * @rx_nss: in HT/VHT, the maximum number of spatial streams the
- *	station can receive at the moment, changed by operating mode
- *	notifications and capabilities. The value is only valid after
- *	the station moves to associated state.
  * @smps_mode: current SMPS mode (off, static or dynamic)
  * @rates: rate control selection table
  * @tdls: indicates whether the STA is a TDLS peer
@@ -2102,25 +2132,28 @@ struct ieee80211_sta_txpwr {
  * @support_p2p_ps: indicates whether the STA supports P2P PS mechanism or not.
  * @max_rc_amsdu_len: Maximum A-MSDU size in bytes recommended by rate control.
  * @max_tid_amsdu_len: Maximum A-MSDU size in bytes for this TID
- * @txpwr: the station tx power configuration
  * @txq: per-TID data TX queues (if driver uses the TXQ abstraction); note that
  *	the last entry (%IEEE80211_NUM_TIDS) is used for non-data frames
+ * @multi_link_sta: Identifies if this sta is a MLD STA
+ * @deflink: This holds the default link STA information, for non MLO STA all link
+ *	specific STA information is accessed through @deflink or through
+ *	link[0] which points to address of @deflink. For MLO Link STA
+ *	the first added link STA will point to deflink.
+ * @link: reference to Link Sta entries. For Non MLO STA, except 1st link,
+ *	i.e link[0] all links would be assigned to NULL by default and
+ *	would access link information via @deflink or link[0]. For MLO
+ *	STA, first link STA being added will point its link pointer to
+ *	@deflink address and remaining would be allocated and the address
+ *	would be assigned to link[link_id] where link_id is the id assigned
+ *	by the AP.
  */
 struct ieee80211_sta {
-	u32 supp_rates[NUM_NL80211_BANDS];
 	u8 addr[ETH_ALEN];
 	u16 aid;
-	struct ieee80211_sta_ht_cap ht_cap;
-	struct ieee80211_sta_vht_cap vht_cap;
-	struct ieee80211_sta_he_cap he_cap;
-	struct ieee80211_he_6ghz_capa he_6ghz_capa;
-	struct ieee80211_sta_eht_cap eht_cap;
 	u16 max_rx_aggregation_subframes;
 	bool wme;
 	u8 uapsd_queues;
 	u8 max_sp;
-	u8 rx_nss;
-	enum ieee80211_sta_rx_bandwidth bandwidth;
 	enum ieee80211_smps_mode smps_mode;
 	struct ieee80211_sta_rates __rcu *rates;
 	bool tdls;
@@ -2147,10 +2180,13 @@ struct ieee80211_sta {
 	bool support_p2p_ps;
 	u16 max_rc_amsdu_len;
 	u16 max_tid_amsdu_len[IEEE80211_NUM_TIDS];
-	struct ieee80211_sta_txpwr txpwr;
 
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
+	bool multi_link_sta;
+	struct ieee80211_link_sta deflink;
+	struct ieee80211_link_sta *link[MAX_STA_LINKS];
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -6367,7 +6403,7 @@ static inline int rate_supported(struct ieee80211_sta *sta,
 				 enum nl80211_band band,
 				 int index)
 {
-	return (sta == NULL || sta->supp_rates[band] & BIT(index));
+	return (sta == NULL || sta->deflink.supp_rates[band] & BIT(index));
 }
 
 static inline s8
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 218cdc5..bfab393 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -263,7 +263,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	mgmt->u.action.u.addba_resp.timeout = cpu_to_le16(timeout);
 	mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
 
-	if (sta->sta.he_cap.has_he && addbaext)
+	if (sta->sta.deflink.he_cap.has_he && addbaext)
 		ieee80211_add_addbaext(sdata, skb, addbaext, buf_size);
 
 	ieee80211_tx_skb(sdata, skb);
@@ -296,7 +296,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (!sta->sta.ht_cap.ht_supported &&
+	if (!sta->sta.deflink.ht_cap.ht_supported &&
 	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ) {
 		ht_dbg(sta->sdata,
 		       "STA %pM erroneously requests BA session on tid %d w/o QoS\n",
@@ -312,9 +312,9 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (sta->sta.eht_cap.has_eht)
+	if (sta->sta.deflink.eht_cap.has_eht)
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_EHT;
-	else if (sta->sta.he_cap.has_he)
+	else if (sta->sta.deflink.he_cap.has_he)
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HE;
 	else
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
@@ -324,7 +324,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	 * and if buffer size does not exceeds max value */
 	/* XXX: check own ht delayed BA capability?? */
 	if (((ba_policy != 1) &&
-	     (!(sta->sta.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
+	     (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
 	    (buf_size > max_buf_size)) {
 		status = WLAN_STATUS_INVALID_QOS_PARAM;
 		ht_dbg_ratelimited(sta->sdata,
@@ -507,7 +507,7 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 			goto free;
 	}
 
-	if (sta->sta.eht_cap.has_eht && elems && elems->addba_ext_ie) {
+	if (sta->sta.deflink.eht_cap.has_eht && elems && elems->addba_ext_ie) {
 		u8 buf_size_1k = u8_get_bits(elems->addba_ext_ie->data,
 					     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
 
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 1deb3d8..91878ed 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -467,7 +467,7 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.he_cap.has_he) {
+	if (sta->sta.deflink.he_cap.has_he) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
 	} else {
 		/*
@@ -594,7 +594,7 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		 "Requested to start BA session on reserved tid=%d", tid))
 		return -EINVAL;
 
-	if (!pubsta->ht_cap.ht_supported &&
+	if (!pubsta->deflink.ht_cap.ht_supported &&
 	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
 		return -EINVAL;
 
@@ -647,7 +647,7 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 	 * is set when we receive a bss info from a probe response or a beacon.
 	 */
 	if (sta->sdata->vif.type == NL80211_IFTYPE_ADHOC &&
-	    !sta->sta.ht_cap.ht_supported) {
+	    !sta->sta.deflink.ht_cap.ht_supported) {
 		ht_dbg(sdata,
 		       "BA request denied - IBSS STA %pM does not advertise HT support\n",
 		       pubsta->addr);
diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 2619e12..4bab168 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -647,8 +647,8 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
 		struct ieee80211_rx_status stat;
-		struct ieee80211_tx_rate *tx_rate = &sta->tx_stats.last_rate;
-		struct rate_info *ri = &sta->tx_stats.last_rate_info;
+		struct ieee80211_tx_rate *tx_rate = &sta->deflink.tx_stats.last_rate;
+		struct rate_info *ri = &sta->deflink.tx_stats.last_rate_info;
 		u32 duration, overhead;
 		u8 agg_shift;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ba75253..8b7036b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -570,7 +570,8 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 		if (pairwise)
 			key = key_mtx_dereference(local, sta->ptk[key_idx]);
 		else
-			key = key_mtx_dereference(local, sta->gtk[key_idx]);
+			key = key_mtx_dereference(local,
+						  sta->deflink.gtk[key_idx]);
 	} else
 		key = key_mtx_dereference(local, sdata->keys[key_idx]);
 
@@ -620,7 +621,7 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 		else if (!pairwise &&
 			 key_idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
 			 NUM_DEFAULT_BEACON_KEYS)
-			key = rcu_dereference(sta->gtk[key_idx]);
+			key = rcu_dereference(sta->deflink.gtk[key_idx]);
 	} else
 		key = rcu_dereference(sdata->keys[key_idx]);
 
@@ -1728,9 +1729,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		sta->listen_interval = params->listen_interval;
 
 	if (params->sta_modify_mask & STATION_PARAM_APPLY_STA_TXPOWER) {
-		sta->sta.txpwr.type = params->txpwr.type;
+		sta->sta.deflink.txpwr.type = params->txpwr.type;
 		if (params->txpwr.type == NL80211_TX_POWER_LIMITED)
-			sta->sta.txpwr.power = params->txpwr.power;
+			sta->sta.deflink.txpwr.power = params->txpwr.power;
 		ret = drv_sta_set_txpwr(local, sdata, sta);
 		if (ret)
 			return ret;
@@ -1740,7 +1741,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
-					 &sta->sta.supp_rates[sband->band]);
+					 &sta->sta.deflink.supp_rates[sband->band]);
 	}
 
 	if (params->ht_capa)
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e26d42d..e345244 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -199,7 +199,7 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta)
 
 	switch (width) {
 	case IEEE80211_STA_RX_BW_20:
-		if (sta->sta.ht_cap.ht_supported)
+		if (sta->sta.deflink.ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20;
 		else
 			return NL80211_CHAN_WIDTH_20_NOHT;
@@ -375,15 +375,15 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 		new_sta_bw = ieee80211_sta_cur_vht_bw(sta);
 
 		/* nothing change */
-		if (new_sta_bw == sta->sta.bandwidth)
+		if (new_sta_bw == sta->sta.deflink.bandwidth)
 			continue;
 
 		/* vif changed to narrow BW and narrow BW for station wasn't
 		 * requested or vise versa */
-		if ((new_sta_bw < sta->sta.bandwidth) == !narrowed)
+		if ((new_sta_bw < sta->sta.deflink.bandwidth) == !narrowed)
 			continue;
 
-		sta->sta.bandwidth = new_sta_bw;
+		sta->sta.deflink.bandwidth = new_sta_bw;
 		rate_control_rate_update(local, sband, sta,
 					 IEEE80211_RC_BW_CHANGED);
 	}
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 9479f27..46d0886 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -447,7 +447,7 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 	int i;
 	ssize_t bufsz = 512;
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_ht_cap *htc = &sta->sta.ht_cap;
+	struct ieee80211_sta_ht_cap *htc = &sta->sta.deflink.ht_cap;
 	ssize_t ret;
 
 	buf = kzalloc(bufsz, GFP_KERNEL);
@@ -531,7 +531,7 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 {
 	char *buf, *p;
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.vht_cap;
+	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.deflink.vht_cap;
 	ssize_t ret;
 	ssize_t bufsz = 512;
 
@@ -646,7 +646,7 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	char *buf, *p;
 	size_t buf_sz = PAGE_SIZE;
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_he_cap *hec = &sta->sta.he_cap;
+	struct ieee80211_sta_he_cap *hec = &sta->sta.deflink.he_cap;
 	struct ieee80211_he_mcs_nss_supp *nss = &hec->he_mcs_nss_supp;
 	u8 ppe_size;
 	u8 *cap;
@@ -1052,9 +1052,9 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	DEBUGFS_ADD(vht_capa);
 	DEBUGFS_ADD(he_capa);
 
-	DEBUGFS_ADD_COUNTER(rx_duplicates, rx_stats.num_duplicates);
-	DEBUGFS_ADD_COUNTER(rx_fragments, rx_stats.fragments);
-	DEBUGFS_ADD_COUNTER(tx_filtered, status_stats.filtered);
+	DEBUGFS_ADD_COUNTER(rx_duplicates, deflink.rx_stats.num_duplicates);
+	DEBUGFS_ADD_COUNTER(rx_fragments, deflink.rx_stats.fragments);
+	DEBUGFS_ADD_COUNTER(tx_filtered, deflink.status_stats.filtered);
 
 	if (local->ops->wake_tx_queue) {
 		DEBUGFS_ADD(aqm);
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 364ad0e..96c9486 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -14,7 +14,7 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len, struct sta_info *sta)
 {
-	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.eht_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.deflink.eht_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 eht_ppe_size = 0;
 	u8 mcs_nss_size;
@@ -71,6 +71,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	eht_cap->has_eht = true;
 
-	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
-	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
+	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta);
 }
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index b2253df..31cd3c1 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -114,7 +114,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 		sta_set_sinfo(sta, &sinfo, false);
 
 		i = 0;
-		ADD_STA_STATS(sta);
+		ADD_STA_STATS(sta->link[0]);
 
 		data[i++] = sta->sta_state;
 
@@ -140,7 +140,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 			memset(&sinfo, 0, sizeof(sinfo));
 			sta_set_sinfo(sta, &sinfo, false);
 			i = 0;
-			ADD_STA_STATS(sta);
+			ADD_STA_STATS(sta->link[0]);
 		}
 	}
 
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index c05af70..1a61f75 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -49,7 +49,7 @@ ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_
 		break;
 	}
 
-	sta->sta.he_6ghz_capa = *he_6ghz_capa;
+	sta->sta.deflink.he_6ghz_capa = *he_6ghz_capa;
 }
 
 static void ieee80211_he_mcs_disable(__le16 *he_mcs)
@@ -110,7 +110,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
 				  struct sta_info *sta)
 {
-	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->sta.deflink.he_cap;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -153,8 +153,8 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
-	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
+	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta);
 
 	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta);
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 2eb7641..171bd16 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -243,9 +243,9 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_3839;
 
  apply:
-	changed = memcmp(&sta->sta.ht_cap, &ht_cap, sizeof(ht_cap));
+	changed = memcmp(&sta->sta.deflink.ht_cap, &ht_cap, sizeof(ht_cap));
 
-	memcpy(&sta->sta.ht_cap, &ht_cap, sizeof(ht_cap));
+	memcpy(&sta->sta.deflink.ht_cap, &ht_cap, sizeof(ht_cap));
 
 	switch (sdata->vif.bss_conf.chandef.width) {
 	default:
@@ -264,9 +264,9 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	sta->sta.bandwidth = bw;
+	sta->sta.deflink.bandwidth = bw;
 
-	sta->cur_max_bandwidth =
+	sta->deflink.cur_max_bandwidth =
 		ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 0416c4d..14c04fd 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -637,7 +637,7 @@ ieee80211_ibss_add_sta(struct ieee80211_sub_if_data *sdata, const u8 *bssid,
 
 	/* make sure mandatory rates are always added */
 	sband = local->hw.wiphy->bands[band];
-	sta->sta.supp_rates[band] = supp_rates |
+	sta->sta.deflink.supp_rates[band] = supp_rates |
 			ieee80211_mandatory_rates(sband, scan_width);
 
 	return ieee80211_ibss_finish_sta(sta);
@@ -1005,7 +1005,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		if (sta) {
 			u32 prev_rates;
 
-			prev_rates = sta->sta.supp_rates[band];
+			prev_rates = sta->sta.deflink.supp_rates[band];
 			/* make sure mandatory rates are always added */
 			scan_width = NL80211_BSS_CHAN_WIDTH_20;
 			if (rx_status->bw == RATE_INFO_BW_5)
@@ -1013,13 +1013,13 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 			else if (rx_status->bw == RATE_INFO_BW_10)
 				scan_width = NL80211_BSS_CHAN_WIDTH_10;
 
-			sta->sta.supp_rates[band] = supp_rates |
+			sta->sta.deflink.supp_rates[band] = supp_rates |
 				ieee80211_mandatory_rates(sband, scan_width);
-			if (sta->sta.supp_rates[band] != prev_rates) {
+			if (sta->sta.deflink.supp_rates[band] != prev_rates) {
 				ibss_dbg(sdata,
 					 "updated supp_rates set for %pM based on beacon/probe_resp (0x%x -> 0x%x)\n",
 					 sta->sta.addr, prev_rates,
-					 sta->sta.supp_rates[band]);
+					 sta->sta.deflink.supp_rates[band]);
 				rates_updated = true;
 			}
 		} else {
@@ -1043,7 +1043,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		/* we both use HT */
 		struct ieee80211_ht_cap htcap_ie;
 		struct cfg80211_chan_def chandef;
-		enum ieee80211_sta_rx_bandwidth bw = sta->sta.bandwidth;
+		enum ieee80211_sta_rx_bandwidth bw = sta->sta.deflink.bandwidth;
 
 		cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
 		ieee80211_chandef_ht_oper(elems->ht_operation, &chandef);
@@ -1058,7 +1058,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_40) {
 			/* we both use VHT */
 			struct ieee80211_vht_cap cap_ie;
-			struct ieee80211_sta_vht_cap cap = sta->sta.vht_cap;
+			struct ieee80211_sta_vht_cap cap = sta->sta.deflink.vht_cap;
 			u32 vht_cap_info =
 				le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 
@@ -1069,11 +1069,11 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 			memcpy(&cap_ie, elems->vht_cap_elem, sizeof(cap_ie));
 			ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 							    &cap_ie, sta);
-			if (memcmp(&cap, &sta->sta.vht_cap, sizeof(cap)))
+			if (memcmp(&cap, &sta->sta.deflink.vht_cap, sizeof(cap)))
 				rates_updated |= true;
 		}
 
-		if (bw != sta->sta.bandwidth)
+		if (bw != sta->sta.deflink.bandwidth)
 			rates_updated |= true;
 
 		if (!cfg80211_chandef_compatible(&sdata->u.ibss.chandef,
@@ -1083,12 +1083,12 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 
 	if (sta && rates_updated) {
 		u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
-		u8 rx_nss = sta->sta.rx_nss;
+		u8 rx_nss = sta->sta.deflink.rx_nss;
 
 		/* Force rx_nss recalculation */
-		sta->sta.rx_nss = 0;
+		sta->sta.deflink.rx_nss = 0;
 		rate_control_rate_init(sta);
-		if (sta->sta.rx_nss != rx_nss)
+		if (sta->sta.deflink.rx_nss != rx_nss)
 			changed |= IEEE80211_RC_NSS_CHANGED;
 
 		drv_sta_rc_update(local, sdata, &sta->sta, changed);
@@ -1235,7 +1235,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 
 	/* make sure mandatory rates are always added */
 	sband = local->hw.wiphy->bands[band];
-	sta->sta.supp_rates[band] = supp_rates |
+	sta->sta.deflink.supp_rates[band] = supp_rates |
 			ieee80211_mandatory_rates(sband, scan_width);
 
 	spin_lock(&ifibss->incomplete_lock);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index f695fc8..0fcf8ae 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -476,7 +476,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 			    !(new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX))
 				_ieee80211_set_tx_key(new, true);
 		} else {
-			rcu_assign_pointer(sta->gtk[idx], new);
+			rcu_assign_pointer(sta->deflink.gtk[idx], new);
 		}
 		/* Only needed for transition from no key -> key.
 		 * Still triggers unnecessary when using Extended Key ID
@@ -826,7 +826,8 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		    (old_key && old_key->conf.cipher != key->conf.cipher))
 			goto out;
 	} else if (sta) {
-		old_key = key_mtx_dereference(sdata->local, sta->gtk[idx]);
+		old_key = key_mtx_dereference(sdata->local,
+					      sta->deflink.gtk[idx]);
 	} else {
 		old_key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
 	}
@@ -1076,8 +1077,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 	int i;
 
 	mutex_lock(&local->key_mtx);
-	for (i = 0; i < ARRAY_SIZE(sta->gtk); i++) {
-		key = key_mtx_dereference(local, sta->gtk[i]);
+	for (i = 0; i < ARRAY_SIZE(sta->deflink.gtk); i++) {
+		key = key_mtx_dereference(local, sta->deflink.gtk[i]);
 		if (!key)
 			continue;
 		ieee80211_key_replace(key->sdata, key->sta,
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 44a6fdb..58ebdcd 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -310,7 +310,7 @@ void ieee80211s_update_metric(struct ieee80211_local *local,
 			LINK_FAIL_THRESH)
 		mesh_plink_broken(sta);
 
-	sta_set_rate_info_tx(sta, &sta->tx_stats.last_rate, &rinfo);
+	sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate, &rinfo);
 	ewma_mesh_tx_rate_avg_add(&sta->mesh->tx_rate_avg,
 				  cfg80211_calculate_bitrate(&rinfo));
 }
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a829470..42ba742 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -61,8 +61,8 @@ static bool rssi_threshold_check(struct ieee80211_sub_if_data *sdata,
 	s32 rssi_threshold = sdata->u.mesh.mshcfg.rssi_threshold;
 	return rssi_threshold == 0 ||
 	       (sta &&
-		(s8)-ewma_signal_read(&sta->rx_stats_avg.signal) >
-						rssi_threshold);
+		(s8)-ewma_signal_read(&sta->deflink.rx_stats_avg.signal) >
+		rssi_threshold);
 }
 
 /**
@@ -125,7 +125,7 @@ static u32 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
 			continue;
 
 		short_slot = false;
-		if (erp_rates & sta->sta.supp_rates[sband->band])
+		if (erp_rates & sta->sta.deflink.supp_rates[sband->band])
 			short_slot = true;
 		 else
 			break;
@@ -175,10 +175,10 @@ static u32 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 		    sta->mesh->plink_state != NL80211_PLINK_ESTAB)
 			continue;
 
-		if (sta->sta.bandwidth > IEEE80211_STA_RX_BW_20)
+		if (sta->sta.deflink.bandwidth > IEEE80211_STA_RX_BW_20)
 			continue;
 
-		if (!sta->sta.ht_cap.ht_supported) {
+		if (!sta->sta.deflink.ht_cap.ht_supported) {
 			mpl_dbg(sdata, "nonHT sta (%pM) is present\n",
 				       sta->sta.addr);
 			non_ht_sta = true;
@@ -415,7 +415,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	u32 rates, basic_rates = 0, changed = 0;
-	enum ieee80211_sta_rx_bandwidth bw = sta->sta.bandwidth;
+	enum ieee80211_sta_rx_bandwidth bw = sta->sta.deflink.bandwidth;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
@@ -425,7 +425,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					&basic_rates);
 
 	spin_lock_bh(&sta->mesh->plink_lock);
-	sta->rx_stats.last_rx = jiffies;
+	sta->deflink.rx_stats.last_rx = jiffies;
 
 	/* rates and capabilities don't change during peering */
 	if (sta->mesh->plink_state == NL80211_PLINK_ESTAB &&
@@ -433,9 +433,9 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	sta->mesh->processed_beacon = true;
 
-	if (sta->sta.supp_rates[sband->band] != rates)
+	if (sta->sta.deflink.supp_rates[sband->band] != rates)
 		changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
-	sta->sta.supp_rates[sband->band] = rates;
+	sta->sta.deflink.supp_rates[sband->band] = rates;
 
 	if (ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 					      elems->ht_cap_elem, sta))
@@ -449,16 +449,16 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					  elems->he_6ghz_capa,
 					  sta);
 
-	if (bw != sta->sta.bandwidth)
+	if (bw != sta->sta.deflink.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	/* HT peer is operating 20MHz-only */
 	if (elems->ht_operation &&
 	    !(elems->ht_operation->ht_param &
 	      IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)) {
-		if (sta->sta.bandwidth != IEEE80211_STA_RX_BW_20)
+		if (sta->sta.deflink.bandwidth != IEEE80211_STA_RX_BW_20)
 			changed |= IEEE80211_RC_BW_CHANGED;
-		sta->sta.bandwidth = IEEE80211_STA_RX_BW_20;
+		sta->sta.deflink.bandwidth = IEEE80211_STA_RX_BW_20;
 	}
 
 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1b30c72..b857915 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3342,7 +3342,7 @@ static bool ieee80211_twt_req_supported(const struct sta_info *sta,
 	if (!(elems->ext_capab[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
 		return false;
 
-	return sta->sta.he_cap.he_cap_elem.mac_cap_info[0] &
+	return sta->sta.deflink.he_cap.he_cap_elem.mac_cap_info[0] &
 		IEEE80211_HE_MAC_CAP0_TWT_RES;
 }
 
@@ -3369,7 +3369,7 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 					    ieee80211_vif_type_p2p(&sdata->vif));
 
 	return bss_conf->he_support &&
-		(sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
+		(sta->sta.deflink.he_cap.he_cap_elem.mac_cap_info[2] &
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT) &&
 		own_he_cap &&
 		(own_he_cap->he_cap_elem.mac_cap_info[2] &
@@ -3587,7 +3587,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 						  elems->he_6ghz_capa,
 						  sta);
 
-		bss_conf->he_support = sta->sta.he_cap.has_he;
+		bss_conf->he_support = sta->sta.deflink.he_cap.has_he;
 		if (elems->rsnx && elems->rsnx_len &&
 		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
 		    wiphy_ext_feature_isset(local->hw.wiphy,
@@ -3607,7 +3607,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 							    elems->eht_cap_len,
 							    sta);
 
-			bss_conf->eht_support = sta->sta.eht_cap.has_eht;
+			bss_conf->eht_support = sta->sta.deflink.eht_cap.has_eht;
 		} else {
 			bss_conf->eht_support = false;
 		}
@@ -3678,7 +3678,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
 		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 		nss += 1;
-		sta->sta.rx_nss = nss;
+		sta->sta.deflink.rx_nss = nss;
 	}
 
 	rate_control_rate_init(sta);
@@ -4836,9 +4836,9 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	if (!sta)
 		return;
 
-	timeout = sta->status_stats.last_ack;
-	if (time_before(sta->status_stats.last_ack, sta->rx_stats.last_rx))
-		timeout = sta->rx_stats.last_rx;
+	timeout = sta->deflink.status_stats.last_ack;
+	if (time_before(sta->deflink.status_stats.last_ack, sta->deflink.rx_stats.last_rx))
+		timeout = sta->deflink.rx_stats.last_rx;
 	timeout += IEEE80211_CONNECTION_IDLE_TIME;
 
 	/* If timeout is after now, then update timer to fire at
@@ -5638,7 +5638,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (rates)
-			new_sta->sta.supp_rates[cbss->channel->band] = rates;
+			new_sta->sta.deflink.supp_rates[cbss->channel->band] = rates;
 		else
 			sdata_info(sdata,
 				   "No rates found, keeping mandatory only\n");
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 7c1a735..f97cb4c 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -74,7 +74,7 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 
 	/* Add only mandatory rates for now */
 	sband = local->hw.wiphy->bands[band];
-	sta->sta.supp_rates[band] =
+	sta->sta.deflink.supp_rates[band] =
 		ieee80211_mandatory_rates(sband, scan_width);
 
 	spin_lock(&ifocb->incomplete_lock);
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 8c64161..ae9700e 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -371,7 +371,7 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 	WARN_ONCE(i == sband->n_bitrates,
 		  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x with flags 0x%x\n",
 		  sta ? sta->addr : NULL,
-		  sta ? sta->supp_rates[sband->band] : -1,
+		  sta ? sta->deflink.supp_rates[sband->band] : -1,
 		  sband->band,
 		  rate_mask, rate_flags);
 
@@ -781,11 +781,11 @@ static bool rate_control_cap_mask(struct ieee80211_sub_if_data *sdata,
 		u16 sta_vht_mask[NL80211_VHT_NSS_MAX];
 
 		/* Filter out rates that the STA does not support */
-		*mask &= sta->supp_rates[sband->band];
+		*mask &= sta->deflink.supp_rates[sband->band];
 		for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
-			mcs_mask[i] &= sta->ht_cap.mcs.rx_mask[i];
+			mcs_mask[i] &= sta->deflink.ht_cap.mcs.rx_mask[i];
 
-		sta_vht_cap = sta->vht_cap.vht_mcs.rx_mcs_map;
+		sta_vht_cap = sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
 		ieee80211_get_vht_mask_from_cap(sta_vht_cap, sta_vht_mask);
 		for (i = 0; i < NL80211_VHT_NSS_MAX; i++)
 			vht_mask[i] &= sta_vht_mask[i];
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 9c6ace8..5a6dc5c 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -603,7 +603,7 @@ minstrel_ht_prob_rate_reduce_streams(struct minstrel_ht_sta *mi)
 	int tmp_max_streams, group, tmp_idx, tmp_prob;
 	int tmp_tp = 0;
 
-	if (!mi->sta->ht_cap.ht_supported)
+	if (!mi->sta->deflink.ht_cap.ht_supported)
 		return;
 
 	group = MI_RATE_GROUP(mi->max_tp_rate[0]);
@@ -993,7 +993,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	u16 tmp_mcs_tp_rate[MAX_THR_RATES], tmp_group_tp_rate[MAX_THR_RATES];
 	u16 tmp_legacy_tp_rate[MAX_THR_RATES], tmp_max_prob_rate;
 	u16 index;
-	bool ht_supported = mi->sta->ht_cap.ht_supported;
+	bool ht_supported = mi->sta->deflink.ht_cap.ht_supported;
 
 	if (mi->ampdu_packets > 0) {
 		if (!ieee80211_hw_check(mp->hw, TX_STATUS_NO_AMPDU_LEN))
@@ -1416,7 +1416,7 @@ minstrel_ht_get_max_amsdu_len(struct minstrel_ht_sta *mi)
 	 * the limit here to avoid the complexity of having to de-aggregate
 	 * packets in the queue.
 	 */
-	if (!mi->sta->vht_cap.vht_supported)
+	if (!mi->sta->deflink.vht_cap.vht_supported)
 		return IEEE80211_MAX_MPDU_LEN_HT_BA;
 
 	/* unlimited */
@@ -1533,7 +1533,7 @@ minstrel_ht_update_cck(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	if (sband->band != NL80211_BAND_2GHZ)
 		return;
 
-	if (sta->ht_cap.ht_supported &&
+	if (sta->deflink.ht_cap.ht_supported &&
 	    !ieee80211_hw_check(mp->hw, SUPPORTS_HT_CCK_RATES))
 		return;
 
@@ -1556,7 +1556,7 @@ minstrel_ht_update_ofdm(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	const u8 *rates;
 	int i;
 
-	if (sta->ht_cap.ht_supported)
+	if (sta->deflink.ht_cap.ht_supported)
 		return;
 
 	rates = mp->ofdm_rates[sband->band];
@@ -1576,9 +1576,9 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 {
 	struct minstrel_priv *mp = priv;
 	struct minstrel_ht_sta *mi = priv_sta;
-	struct ieee80211_mcs_info *mcs = &sta->ht_cap.mcs;
-	u16 ht_cap = sta->ht_cap.cap;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	struct ieee80211_mcs_info *mcs = &sta->deflink.ht_cap.mcs;
+	u16 ht_cap = sta->deflink.ht_cap.cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
 	const struct ieee80211_rate *ctl_rate;
 	bool ldpc, erp;
 	int use_vht;
@@ -1650,7 +1650,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 		}
 
 		if (gflags & IEEE80211_TX_RC_40_MHZ_WIDTH &&
-		    sta->bandwidth < IEEE80211_STA_RX_BW_40)
+		    sta->deflink.bandwidth < IEEE80211_STA_RX_BW_40)
 			continue;
 
 		nss = minstrel_mcs_groups[i].streams;
@@ -1677,7 +1677,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 			continue;
 
 		if (gflags & IEEE80211_TX_RC_80_MHZ_WIDTH) {
-			if (sta->bandwidth < IEEE80211_STA_RX_BW_80 ||
+			if (sta->deflink.bandwidth < IEEE80211_STA_RX_BW_80 ||
 			    ((gflags & IEEE80211_TX_RC_SHORT_GI) &&
 			     !(vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80))) {
 				continue;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index beb6b92..4e60ce6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -221,7 +221,7 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 	skb_queue_tail(&sdata->skb_queue, skb);
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 	if (sta)
-		sta->rx_stats.packets++;
+		sta->deflink.rx_stats.packets++;
 }
 
 static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
@@ -1465,7 +1465,7 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 	if (unlikely(ieee80211_has_retry(hdr->frame_control) &&
 		     rx->sta->last_seq_ctrl[rx->seqno_idx] == hdr->seq_ctrl)) {
 		I802_DEBUG_INC(rx->local->dot11FrameDuplicateCount);
-		rx->sta->rx_stats.num_duplicates++;
+		rx->sta->deflink.rx_stats.num_duplicates++;
 		return RX_DROP_UNUSABLE;
 	} else if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
 		rx->sta->last_seq_ctrl[rx->seqno_idx] = hdr->seq_ctrl;
@@ -1761,46 +1761,47 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 						NL80211_IFTYPE_ADHOC);
 		if (ether_addr_equal(bssid, rx->sdata->u.ibss.bssid) &&
 		    test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
-			sta->rx_stats.last_rx = jiffies;
+			sta->deflink.rx_stats.last_rx = jiffies;
 			if (ieee80211_is_data(hdr->frame_control) &&
 			    !is_multicast_ether_addr(hdr->addr1))
-				sta->rx_stats.last_rate =
+				sta->deflink.rx_stats.last_rate =
 					sta_stats_encode_rate(status);
 		}
 	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
-		sta->rx_stats.last_rx = jiffies;
+		sta->deflink.rx_stats.last_rx = jiffies;
 	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
 		   !is_multicast_ether_addr(hdr->addr1)) {
 		/*
 		 * Mesh beacons will update last_rx when if they are found to
 		 * match the current local configuration when processed.
 		 */
-		sta->rx_stats.last_rx = jiffies;
+		sta->deflink.rx_stats.last_rx = jiffies;
 		if (ieee80211_is_data(hdr->frame_control))
-			sta->rx_stats.last_rate = sta_stats_encode_rate(status);
+			sta->deflink.rx_stats.last_rate = sta_stats_encode_rate(status);
 	}
 
-	sta->rx_stats.fragments++;
+	sta->deflink.rx_stats.fragments++;
 
-	u64_stats_update_begin(&rx->sta->rx_stats.syncp);
-	sta->rx_stats.bytes += rx->skb->len;
-	u64_stats_update_end(&rx->sta->rx_stats.syncp);
+	u64_stats_update_begin(&rx->sta->deflink.rx_stats.syncp);
+	sta->deflink.rx_stats.bytes += rx->skb->len;
+	u64_stats_update_end(&rx->sta->deflink.rx_stats.syncp);
 
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
-		sta->rx_stats.last_signal = status->signal;
-		ewma_signal_add(&sta->rx_stats_avg.signal, -status->signal);
+		sta->deflink.rx_stats.last_signal = status->signal;
+		ewma_signal_add(&sta->deflink.rx_stats_avg.signal,
+				-status->signal);
 	}
 
 	if (status->chains) {
-		sta->rx_stats.chains = status->chains;
+		sta->deflink.rx_stats.chains = status->chains;
 		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
 			int signal = status->chain_signal[i];
 
 			if (!(status->chains & BIT(i)))
 				continue;
 
-			sta->rx_stats.chain_signal_last[i] = signal;
-			ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
+			sta->deflink.rx_stats.chain_signal_last[i] = signal;
+			ewma_signal_add(&sta->deflink.rx_stats_avg.chain_signal[i],
 					-signal);
 		}
 	}
@@ -1861,7 +1862,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		 * Update counter and free packet here to avoid
 		 * counting this as a dropped packed.
 		 */
-		sta->rx_stats.packets++;
+		sta->deflink.rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
 		return RX_QUEUED;
 	}
@@ -1893,11 +1894,11 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
 	}
 
 	if (rx->sta)
-		key = rcu_dereference(rx->sta->gtk[idx]);
+		key = rcu_dereference(rx->sta->deflink.gtk[idx]);
 	if (!key)
 		key = rcu_dereference(sdata->keys[idx]);
 	if (!key && rx->sta)
-		key = rcu_dereference(rx->sta->gtk[idx2]);
+		key = rcu_dereference(rx->sta->deflink.gtk[idx2]);
 	if (!key)
 		key = rcu_dereference(sdata->keys[idx2]);
 
@@ -2012,7 +2013,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			    test_sta_flag(rx->sta, WLAN_STA_MFP))
 				return RX_DROP_MONITOR;
 
-			rx->key = rcu_dereference(rx->sta->gtk[mmie_keyidx]);
+			rx->key = rcu_dereference(rx->sta->deflink.gtk[mmie_keyidx]);
 		}
 		if (!rx->key)
 			rx->key = rcu_dereference(rx->sdata->keys[mmie_keyidx]);
@@ -2035,7 +2036,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		} else {
 			if (rx->sta) {
 				for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
-					key = rcu_dereference(rx->sta->gtk[i]);
+					key = rcu_dereference(rx->sta->deflink.gtk[i]);
 					if (key)
 						break;
 				}
@@ -2072,7 +2073,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 		/* check per-station GTK first, if multicast packet */
 		if (is_multicast_ether_addr(hdr->addr1) && rx->sta)
-			rx->key = rcu_dereference(rx->sta->gtk[keyidx]);
+			rx->key = rcu_dereference(rx->sta->deflink.gtk[keyidx]);
 
 		/* if not found, try default key */
 		if (!rx->key) {
@@ -2398,7 +2399,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
  out:
 	ieee80211_led_rx(rx->local);
 	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+		rx->sta->deflink.rx_stats.packets++;
 	return RX_CONTINUE;
 }
 
@@ -2645,9 +2646,9 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 		 * for non-QoS-data frames. Here we know it's a data
 		 * frame, so count MSDUs.
 		 */
-		u64_stats_update_begin(&rx->sta->rx_stats.syncp);
-		rx->sta->rx_stats.msdu[rx->seqno_idx]++;
-		u64_stats_update_end(&rx->sta->rx_stats.syncp);
+		u64_stats_update_begin(&rx->sta->deflink.rx_stats.syncp);
+		rx->sta->deflink.rx_stats.msdu[rx->seqno_idx]++;
+		u64_stats_update_end(&rx->sta->deflink.rx_stats.syncp);
 	}
 
 	if ((sdata->vif.type == NL80211_IFTYPE_AP ||
@@ -3296,7 +3297,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_HT:
 		/* reject HT action frames from stations not supporting HT */
-		if (!rx->sta->sta.ht_cap.ht_supported)
+		if (!rx->sta->sta.deflink.ht_cap.ht_supported)
 			goto invalid;
 
 		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
@@ -3360,7 +3361,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			struct sta_opmode_info sta_opmode = {};
 
 			/* If it doesn't support 40 MHz it can't change ... */
-			if (!(rx->sta->sta.ht_cap.cap &
+			if (!(rx->sta->sta.deflink.ht_cap.cap &
 					IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 				goto handled;
 
@@ -3370,13 +3371,13 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 				max_bw = ieee80211_sta_cap_rx_bw(rx->sta);
 
 			/* set cur_max_bandwidth and recalc sta bw */
-			rx->sta->cur_max_bandwidth = max_bw;
+			rx->sta->deflink.cur_max_bandwidth = max_bw;
 			new_bw = ieee80211_sta_cur_vht_bw(rx->sta);
 
-			if (rx->sta->sta.bandwidth == new_bw)
+			if (rx->sta->sta.deflink.bandwidth == new_bw)
 				goto handled;
 
-			rx->sta->sta.bandwidth = new_bw;
+			rx->sta->sta.deflink.bandwidth = new_bw;
 			sband = rx->local->hw.wiphy->bands[status->band];
 			sta_opmode.bw =
 				ieee80211_sta_rx_bw_to_chan_width(rx->sta);
@@ -3573,7 +3574,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
  handled:
 	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+		rx->sta->deflink.rx_stats.packets++;
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 
@@ -3607,7 +3608,7 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 				 ieee80211_rx_status_to_khz(status), sig,
 				 rx->skb->data, rx->skb->len, 0)) {
 		if (rx->sta)
-			rx->sta->rx_stats.packets++;
+			rx->sta->deflink.rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
 		return RX_QUEUED;
 	}
@@ -3645,7 +3646,7 @@ ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
 
  handled:
 	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+		rx->sta->deflink.rx_stats.packets++;
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 }
@@ -3865,7 +3866,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 	case RX_DROP_MONITOR:
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
 		if (rx->sta)
-			rx->sta->rx_stats.dropped++;
+			rx->sta->deflink.rx_stats.dropped++;
 		fallthrough;
 	case RX_CONTINUE: {
 		struct ieee80211_rate *rate = NULL;
@@ -3884,7 +3885,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 	case RX_DROP_UNUSABLE:
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
 		if (rx->sta)
-			rx->sta->rx_stats.dropped++;
+			rx->sta->deflink.rx_stats.dropped++;
 		dev_kfree_skb(rx->skb);
 		break;
 	case RX_QUEUED:
@@ -4436,15 +4437,15 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 	void *sa = skb->data + ETH_ALEN;
 	void *da = skb->data;
 
-	stats = &sta->rx_stats;
+	stats = &sta->deflink.rx_stats;
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+		stats = this_cpu_ptr(sta->deflink.pcpu_rx_stats);
 
 	/* statistics part of ieee80211_rx_h_sta_process() */
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
 		stats->last_signal = status->signal;
 		if (!fast_rx->uses_rss)
-			ewma_signal_add(&sta->rx_stats_avg.signal,
+			ewma_signal_add(&sta->deflink.rx_stats_avg.signal,
 					-status->signal);
 	}
 
@@ -4460,7 +4461,7 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 
 			stats->chain_signal_last[i] = signal;
 			if (!fast_rx->uses_rss)
-				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
+				ewma_signal_add(&sta->deflink.rx_stats_avg.chain_signal[i],
 						-signal);
 		}
 	}
@@ -4536,7 +4537,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 da[ETH_ALEN];
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
-	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
+	struct ieee80211_sta_rx_stats *stats = &sta->deflink.rx_stats;
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -4638,7 +4639,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
  drop:
 	dev_kfree_skb(skb);
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+		stats = this_cpu_ptr(sta->deflink.pcpu_rx_stats);
 
 	stats->dropped++;
 	return true;
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 4141bc8..8ca7d45 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -11,8 +11,8 @@
 void ieee80211_s1g_sta_rate_init(struct sta_info *sta)
 {
 	/* avoid indicating legacy bitrates for S1G STAs */
-	sta->tx_stats.last_rate.flags |= IEEE80211_TX_RC_S1G_MCS;
-	sta->rx_stats.last_rate =
+	sta->deflink.tx_stats.last_rate.flags |= IEEE80211_TX_RC_S1G_MCS;
+	sta->deflink.rx_stats.last_rate =
 			STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_S1G);
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 91fbb1e..e04a090 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -287,7 +287,7 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
 #endif
-	free_percpu(sta->pcpu_rx_stats);
+	free_percpu(sta->deflink.pcpu_rx_stats);
 	kfree(sta);
 }
 
@@ -346,9 +346,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		return NULL;
 
 	if (ieee80211_hw_check(hw, USES_RSS)) {
-		sta->pcpu_rx_stats =
+		sta->deflink.pcpu_rx_stats =
 			alloc_percpu_gfp(struct ieee80211_sta_rx_stats, gfp);
-		if (!sta->pcpu_rx_stats)
+		if (!sta->deflink.pcpu_rx_stats)
 			goto free;
 	}
 
@@ -376,6 +376,14 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->sta.max_rx_aggregation_subframes =
 		local->hw.max_rx_aggregation_subframes;
 
+	/* TODO link specific alloc and assignments for MLO Link STA */
+
+	/* For non MLO STA, link info can be accessed either via deflink
+	 * or link[0]
+	 */
+	sta->link[0] = &sta->deflink;
+	sta->sta.link[0] = &sta->sta.deflink;
+
 	/* Extended Key ID needs to install keys for keyid 0 and 1 Rx-only.
 	 * The Tx path starts to use a key as soon as the key slot ptk_idx
 	 * references to is not NULL. To not use the initial Rx-only key
@@ -387,9 +395,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 	sta->local = local;
 	sta->sdata = sdata;
-	sta->rx_stats.last_rx = jiffies;
+	sta->deflink.rx_stats.last_rx = jiffies;
 
-	u64_stats_init(&sta->rx_stats.syncp);
+	u64_stats_init(&sta->deflink.rx_stats.syncp);
 
 	ieee80211_init_frag_cache(&sta->frags);
 
@@ -399,10 +407,10 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->reserved_tid = IEEE80211_TID_UNRESERVED;
 
 	sta->last_connected = ktime_get_seconds();
-	ewma_signal_init(&sta->rx_stats_avg.signal);
-	ewma_avg_signal_init(&sta->status_stats.avg_ack_signal);
-	for (i = 0; i < ARRAY_SIZE(sta->rx_stats_avg.chain_signal); i++)
-		ewma_signal_init(&sta->rx_stats_avg.chain_signal[i]);
+	ewma_signal_init(&sta->deflink.rx_stats_avg.signal);
+	ewma_avg_signal_init(&sta->deflink.status_stats.avg_ack_signal);
+	for (i = 0; i < ARRAY_SIZE(sta->deflink.rx_stats_avg.chain_signal); i++)
+		ewma_signal_init(&sta->deflink.rx_stats_avg.chain_signal[i]);
 
 	if (local->ops->wake_tx_queue) {
 		void *txq_data;
@@ -472,7 +480,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 			if (!(rate->flags & mandatory))
 				continue;
-			sta->sta.supp_rates[i] |= BIT(r);
+			sta->sta.deflink.supp_rates[i] |= BIT(r);
 		}
 	}
 
@@ -524,7 +532,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (sta->sta.txq[0])
 		kfree(to_txq_info(sta->sta.txq[0]));
 free:
-	free_percpu(sta->pcpu_rx_stats);
+	free_percpu(sta->deflink.pcpu_rx_stats);
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
 #endif
@@ -2087,16 +2095,16 @@ int sta_info_move_state(struct sta_info *sta,
 
 u8 sta_info_tx_streams(struct sta_info *sta)
 {
-	struct ieee80211_sta_ht_cap *ht_cap = &sta->sta.ht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap = &sta->sta.deflink.ht_cap;
 	u8 rx_streams;
 
-	if (!sta->sta.ht_cap.ht_supported)
+	if (!sta->sta.deflink.ht_cap.ht_supported)
 		return 1;
 
-	if (sta->sta.vht_cap.vht_supported) {
+	if (sta->sta.deflink.vht_cap.vht_supported) {
 		int i;
 		u16 tx_mcs_map =
-			le16_to_cpu(sta->sta.vht_cap.vht_mcs.tx_mcs_map);
+			le16_to_cpu(sta->sta.deflink.vht_cap.vht_mcs.tx_mcs_map);
 
 		for (i = 7; i >= 0; i--)
 			if ((tx_mcs_map & (0x3 << (i * 2))) !=
@@ -2123,16 +2131,16 @@ u8 sta_info_tx_streams(struct sta_info *sta)
 static struct ieee80211_sta_rx_stats *
 sta_get_last_rx_stats(struct sta_info *sta)
 {
-	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
+	struct ieee80211_sta_rx_stats *stats = &sta->deflink.rx_stats;
 	int cpu;
 
-	if (!sta->pcpu_rx_stats)
+	if (!sta->deflink.pcpu_rx_stats)
 		return stats;
 
 	for_each_possible_cpu(cpu) {
 		struct ieee80211_sta_rx_stats *cpustats;
 
-		cpustats = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+		cpustats = per_cpu_ptr(sta->deflink.pcpu_rx_stats, cpu);
 
 		if (time_after(cpustats->last_rx, stats->last_rx))
 			stats = cpustats;
@@ -2226,13 +2234,15 @@ static void sta_set_tidstats(struct sta_info *sta,
 	int cpu;
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
-		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->rx_stats, tid);
+		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->deflink.rx_stats,
+							   tid);
 
-		if (sta->pcpu_rx_stats) {
+		if (sta->deflink.pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+						     cpu);
 				tidstats->rx_msdu +=
 					sta_get_tidstats_msdu(cpurxs, tid);
 			}
@@ -2243,19 +2253,19 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU))) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU);
-		tidstats->tx_msdu = sta->tx_stats.msdu[tid];
+		tidstats->tx_msdu = sta->deflink.tx_stats.msdu[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_RETRIES)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_RETRIES);
-		tidstats->tx_msdu_retries = sta->status_stats.msdu_retries[tid];
+		tidstats->tx_msdu_retries = sta->deflink.status_stats.msdu_retries[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_FAILED)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
-		tidstats->tx_msdu_failed = sta->status_stats.msdu_failed[tid];
+		tidstats->tx_msdu_failed = sta->deflink.status_stats.msdu_failed[tid];
 	}
 
 	if (local->ops->wake_tx_queue && tid < IEEE80211_NUM_TIDS) {
@@ -2326,26 +2336,27 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
 		sinfo->tx_bytes = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_bytes += sta->tx_stats.bytes[ac];
+			sinfo->tx_bytes += sta->deflink.tx_stats.bytes[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
 		sinfo->tx_packets = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_packets += sta->tx_stats.packets[ac];
+			sinfo->tx_packets += sta->deflink.tx_stats.packets[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 	}
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
+		sinfo->rx_bytes += sta_get_stats_bytes(&sta->deflink.rx_stats);
 
-		if (sta->pcpu_rx_stats) {
+		if (sta->deflink.pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+						     cpu);
 				sinfo->rx_bytes += sta_get_stats_bytes(cpurxs);
 			}
 		}
@@ -2354,12 +2365,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
-		sinfo->rx_packets = sta->rx_stats.packets;
-		if (sta->pcpu_rx_stats) {
+		sinfo->rx_packets = sta->deflink.rx_stats.packets;
+		if (sta->deflink.pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+						     cpu);
 				sinfo->rx_packets += cpurxs->packets;
 			}
 		}
@@ -2367,12 +2379,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES))) {
-		sinfo->tx_retries = sta->status_stats.retry_count;
+		sinfo->tx_retries = sta->deflink.status_stats.retry_count;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
-		sinfo->tx_failed = sta->status_stats.retry_failed;
+		sinfo->tx_failed = sta->deflink.status_stats.retry_failed;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
 
@@ -2393,12 +2405,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
 	}
 
-	sinfo->rx_dropped_misc = sta->rx_stats.dropped;
-	if (sta->pcpu_rx_stats) {
+	sinfo->rx_dropped_misc = sta->deflink.rx_stats.dropped;
+	if (sta->deflink.pcpu_rx_stats) {
 		for_each_possible_cpu(cpu) {
 			struct ieee80211_sta_rx_stats *cpurxs;
 
-			cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+			cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats, cpu);
 			sinfo->rx_dropped_misc += cpurxs->dropped;
 		}
 	}
@@ -2417,10 +2429,10 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 		}
 
-		if (!sta->pcpu_rx_stats &&
+		if (!sta->deflink.pcpu_rx_stats &&
 		    !(sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
 			sinfo->signal_avg =
-				-ewma_signal_read(&sta->rx_stats_avg.signal);
+				-ewma_signal_read(&sta->deflink.rx_stats_avg.signal);
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 		}
 	}
@@ -2433,7 +2445,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
 			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-		if (!sta->pcpu_rx_stats)
+		if (!sta->deflink.pcpu_rx_stats)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 
 		sinfo->chains = last_rxstats->chains;
@@ -2442,12 +2454,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sinfo->chain_signal[i] =
 				last_rxstats->chain_signal_last[i];
 			sinfo->chain_signal_avg[i] =
-				-ewma_signal_read(&sta->rx_stats_avg.chain_signal[i]);
+				-ewma_signal_read(&sta->deflink.rx_stats_avg.chain_signal[i]);
 		}
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
-		sta_set_rate_info_tx(sta, &sta->tx_stats.last_rate,
+		sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate,
 				     &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
@@ -2529,16 +2541,16 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
-	    sta->status_stats.ack_signal_filled) {
-		sinfo->ack_signal = sta->status_stats.last_ack_signal;
+	    sta->deflink.status_stats.ack_signal_filled) {
+		sinfo->ack_signal = sta->deflink.status_stats.last_ack_signal;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
-	    sta->status_stats.ack_signal_filled) {
+	    sta->deflink.status_stats.ack_signal_filled) {
 		sinfo->avg_ack_signal =
 			-(s8)ewma_avg_signal_read(
-				&sta->status_stats.avg_ack_signal);
+				&sta->deflink.status_stats.avg_ack_signal);
 		sinfo->filled |=
 			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 	}
@@ -2573,10 +2585,10 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 {
 	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
 
-	if (!sta->status_stats.last_ack ||
-	    time_after(stats->last_rx, sta->status_stats.last_ack))
+	if (!sta->deflink.status_stats.last_ack ||
+	    time_after(stats->last_rx, sta->deflink.status_stats.last_ack))
 		return stats->last_rx;
-	return sta->status_stats.last_ack;
+	return sta->deflink.status_stats.last_ack;
 }
 
 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 379fd36..35c390b 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -484,6 +484,86 @@ struct ieee80211_fragment_cache {
 #define STA_SLOW_THRESHOLD 6000 /* 6 Mbps */
 
 /**
+ * struct link_sta_info - Link STA information
+ * All link specific sta info are stored here for reference. This can be
+ * a single entry for non-MLD STA or multiple entries for MLD STA
+ * @addr: Link MAC address - Can be same as MLD STA mac address and is always
+ *	same for non-MLD STA. This is used as key for searching link STA
+ * @link_id: Link ID uniquely identifying the link STA. This is 0 for non-MLD
+ *	and set to the corresponding vif LinkId for MLD STA
+ * @sta: Points to the STA info
+ * @gtk: group keys negotiated with this station, if any
+ * @tx_stats: TX statistics
+ * @tx_stats.packets: # of packets transmitted
+ * @tx_stats.bytes: # of bytes in all packets transmitted
+ * @tx_stats.last_rate: last TX rate
+ * @tx_stats.msdu: # of transmitted MSDUs per TID
+ * @rx_stats: RX statistics
+ * @rx_stats_avg: averaged RX statistics
+ * @rx_stats_avg.signal: averaged signal
+ * @rx_stats_avg.chain_signal: averaged per-chain signal
+ * @pcpu_rx_stats: per-CPU RX statistics, assigned only if the driver needs
+ *	this (by advertising the USES_RSS hw flag)
+ * @status_stats: TX status statistics
+ * @status_stats.filtered: # of filtered frames
+ * @status_stats.retry_failed: # of frames that failed after retry
+ * @status_stats.retry_count: # of retries attempted
+ * @status_stats.lost_packets: # of lost packets
+ * @status_stats.last_pkt_time: timestamp of last ACKed packet
+ * @status_stats.msdu_retries: # of MSDU retries
+ * @status_stats.msdu_failed: # of failed MSDUs
+ * @status_stats.last_ack: last ack timestamp (jiffies)
+ * @status_stats.last_ack_signal: last ACK signal
+ * @status_stats.ack_signal_filled: last ACK signal validity
+ * @status_stats.avg_ack_signal: average ACK signal
+ * TODO Move other link params from sta_info as required for MLD operation
+ */
+struct link_sta_info {
+	u8 addr[ETH_ALEN];
+	u8 link_id;
+
+	/* TODO rhash head/node for finding link_sta based on addr */
+
+	struct sta_info *sta;
+	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
+					NUM_DEFAULT_MGMT_KEYS +
+					NUM_DEFAULT_BEACON_KEYS];
+	struct ieee80211_sta_rx_stats __percpu *pcpu_rx_stats;
+
+	/* Updated from RX path only, no locking requirements */
+	struct ieee80211_sta_rx_stats rx_stats;
+	struct {
+		struct ewma_signal signal;
+		struct ewma_signal chain_signal[IEEE80211_MAX_CHAINS];
+	} rx_stats_avg;
+
+	/* Updated from TX status path only, no locking requirements */
+	struct {
+		unsigned long filtered;
+		unsigned long retry_failed, retry_count;
+		unsigned int lost_packets;
+		unsigned long last_pkt_time;
+		u64 msdu_retries[IEEE80211_NUM_TIDS + 1];
+		u64 msdu_failed[IEEE80211_NUM_TIDS + 1];
+		unsigned long last_ack;
+		s8 last_ack_signal;
+		bool ack_signal_filled;
+		struct ewma_avg_signal avg_ack_signal;
+	} status_stats;
+
+	/* Updated from TX path only, no locking requirements */
+	struct {
+		u64 packets[IEEE80211_NUM_ACS];
+		u64 bytes[IEEE80211_NUM_ACS];
+		struct ieee80211_tx_rate last_rate;
+		struct rate_info last_rate_info;
+		u64 msdu[IEEE80211_NUM_TIDS + 1];
+	} tx_stats;
+
+	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
+};
+
+/**
  * struct sta_info - STA information
  *
  * This structure collects information about a station that
@@ -498,7 +578,6 @@ struct ieee80211_fragment_cache {
  * @sdata: virtual interface this station belongs to
  * @ptk: peer keys negotiated with this station, if any
  * @ptk_idx: last installed peer key index
- * @gtk: group keys negotiated with this station, if any
  * @rate_ctrl: rate control algorithm reference
  * @rate_ctrl_lock: spinlock used to protect rate control data
  *	(data inside the algorithm, so serializes calls there)
@@ -544,30 +623,19 @@ struct ieee80211_fragment_cache {
  * @fast_rx: RX fastpath information
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to
  *	the BSS one.
- * @tx_stats: TX statistics
- * @tx_stats.packets: # of packets transmitted
- * @tx_stats.bytes: # of bytes in all packets transmitted
- * @tx_stats.last_rate: last TX rate
- * @tx_stats.msdu: # of transmitted MSDUs per TID
- * @rx_stats: RX statistics
- * @rx_stats_avg: averaged RX statistics
- * @rx_stats_avg.signal: averaged signal
- * @rx_stats_avg.chain_signal: averaged per-chain signal
- * @pcpu_rx_stats: per-CPU RX statistics, assigned only if the driver needs
- *	this (by advertising the USES_RSS hw flag)
- * @status_stats: TX status statistics
- * @status_stats.filtered: # of filtered frames
- * @status_stats.retry_failed: # of frames that failed after retry
- * @status_stats.retry_count: # of retries attempted
- * @status_stats.lost_packets: # of lost packets
- * @status_stats.last_pkt_time: timestamp of last ACKed packet
- * @status_stats.msdu_retries: # of MSDU retries
- * @status_stats.msdu_failed: # of failed MSDUs
- * @status_stats.last_ack: last ack timestamp (jiffies)
- * @status_stats.last_ack_signal: last ACK signal
- * @status_stats.ack_signal_filled: last ACK signal validity
- * @status_stats.avg_ack_signal: average ACK signal
  * @frags: fragment cache
+ * @multi_link_sta: Identifies if this sta is a MLD STA or regular STA
+ * @deflink: This is the default link STA information, for non MLO STA all link
+ *	specific STA information is accessed through @deflink or through
+ *	link[0] which points to address of @deflink. For MLO Link STA
+ *	the first added link STA will point to deflink.
+ * @link: reference to Link Sta entries. For Non MLO STA, except 1st link,
+ *	i.e link[0] all links would be assigned to NULL by default and
+ *	would access link information via @deflink or link[0]. For MLO
+ *	STA, first link STA being added will point its link pointer to
+ *	@deflink address and remaining would be allocated and the address
+ *	would be assigned to link[link_id] where link_id is the id assigned
+ *	by the AP.
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -577,9 +645,6 @@ struct sta_info {
 	u8 addr[ETH_ALEN];
 	struct ieee80211_local *local;
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
-					NUM_DEFAULT_MGMT_KEYS +
-					NUM_DEFAULT_BEACON_KEYS];
 	struct ieee80211_key __rcu *ptk[NUM_DEFAULT_KEYS];
 	u8 ptk_idx;
 	struct rate_control_ref *rate_ctrl;
@@ -589,7 +654,6 @@ struct sta_info {
 
 	struct ieee80211_fast_tx __rcu *fast_tx;
 	struct ieee80211_fast_rx __rcu *fast_rx;
-	struct ieee80211_sta_rx_stats __percpu *pcpu_rx_stats;
 
 #ifdef CONFIG_MAC80211_MESH
 	struct mesh_sta *mesh;
@@ -619,38 +683,9 @@ struct sta_info {
 	u64 assoc_at;
 	long last_connected;
 
-	/* Updated from RX path only, no locking requirements */
-	struct ieee80211_sta_rx_stats rx_stats;
-	struct {
-		struct ewma_signal signal;
-		struct ewma_signal chain_signal[IEEE80211_MAX_CHAINS];
-	} rx_stats_avg;
-
 	/* Plus 1 for non-QoS frames */
 	__le16 last_seq_ctrl[IEEE80211_NUM_TIDS + 1];
 
-	/* Updated from TX status path only, no locking requirements */
-	struct {
-		unsigned long filtered;
-		unsigned long retry_failed, retry_count;
-		unsigned int lost_packets;
-		unsigned long last_pkt_time;
-		u64 msdu_retries[IEEE80211_NUM_TIDS + 1];
-		u64 msdu_failed[IEEE80211_NUM_TIDS + 1];
-		unsigned long last_ack;
-		s8 last_ack_signal;
-		bool ack_signal_filled;
-		struct ewma_avg_signal avg_ack_signal;
-	} status_stats;
-
-	/* Updated from TX path only, no locking requirements */
-	struct {
-		u64 packets[IEEE80211_NUM_ACS];
-		u64 bytes[IEEE80211_NUM_ACS];
-		struct ieee80211_tx_rate last_rate;
-		struct rate_info last_rate_info;
-		u64 msdu[IEEE80211_NUM_TIDS + 1];
-	} tx_stats;
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
 
 	struct airtime_info airtime[IEEE80211_NUM_ACS];
@@ -664,8 +699,6 @@ struct sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
-	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
-
 	enum ieee80211_smps_mode known_smps_mode;
 	const struct ieee80211_cipher_scheme *cipher_scheme;
 
@@ -677,6 +710,10 @@ struct sta_info {
 
 	struct ieee80211_fragment_cache frags;
 
+	bool multi_link_sta;
+	struct link_sta_info deflink;
+	struct link_sta_info *link[MAX_STA_LINKS];
+
 	/* keep last! */
 	struct ieee80211_sta sta;
 };
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index e81e8a5..c563fa7 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -72,7 +72,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	info->flags |= IEEE80211_TX_INTFL_RETRANSMISSION;
 	info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 
-	sta->status_stats.filtered++;
+	sta->deflink.status_stats.filtered++;
 
 	/*
 	 * Clear more-data bit on filtered frames, it might be set
@@ -776,7 +776,7 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
 		return;
 
-	sta->status_stats.lost_packets++;
+	sta->deflink.status_stats.lost_packets++;
 	if (sta->sta.tdls) {
 		pkt_time = STA_LOST_TDLS_PKT_TIME;
 		pkt_thr = STA_LOST_PKT_THRESHOLD;
@@ -789,13 +789,14 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	 * mechanism.
 	 * For non-TDLS, use STA_LOST_PKT_THRESHOLD and STA_LOST_PKT_TIME
 	 */
-	if (sta->status_stats.lost_packets < pkt_thr ||
-	    !time_after(jiffies, sta->status_stats.last_pkt_time + pkt_time))
+	if (sta->deflink.status_stats.lost_packets < pkt_thr ||
+	    !time_after(jiffies, sta->deflink.status_stats.last_pkt_time + pkt_time))
 		return;
 
 	cfg80211_cqm_pktloss_notify(sta->sdata->dev, sta->sta.addr,
-				    sta->status_stats.lost_packets, GFP_ATOMIC);
-	sta->status_stats.lost_packets = 0;
+				    sta->deflink.status_stats.lost_packets,
+				    GFP_ATOMIC);
+	sta->deflink.status_stats.lost_packets = 0;
 }
 
 static int ieee80211_tx_get_rates(struct ieee80211_hw *hw,
@@ -930,7 +931,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
-			sta->tx_stats.last_rate =
+			sta->deflink.tx_stats.last_rate =
 				info->status.rates[rates_idx];
 
 		if ((info->flags & IEEE80211_TX_STAT_AMPDU_NO_BACK) &&
@@ -976,9 +977,9 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			return;
 		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->status_stats.msdu_failed[tid]++;
+				sta->deflink.status_stats.msdu_failed[tid]++;
 
-			sta->status_stats.msdu_retries[tid] +=
+			sta->deflink.status_stats.msdu_retries[tid] +=
 				retry_count;
 		}
 
@@ -1111,7 +1112,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		sta = container_of(pubsta, struct sta_info, sta);
 
 		if (status->rate)
-			sta->tx_stats.last_rate_info = *status->rate;
+			sta->deflink.tx_stats.last_rate_info = *status->rate;
 	}
 
 	if (skb && (tx_time_est =
@@ -1142,8 +1143,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
 
 		if (!acked && !noack_success)
-			sta->status_stats.retry_failed++;
-		sta->status_stats.retry_count += retry_count;
+			sta->deflink.status_stats.retry_failed++;
+		sta->deflink.status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1152,13 +1153,13 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 							acked, info->status.tx_time);
 
 			if (acked) {
-				sta->status_stats.last_ack = jiffies;
+				sta->deflink.status_stats.last_ack = jiffies;
 
-				if (sta->status_stats.lost_packets)
-					sta->status_stats.lost_packets = 0;
+				if (sta->deflink.status_stats.lost_packets)
+					sta->deflink.status_stats.lost_packets = 0;
 
 				/* Track when last packet was ACKed */
-				sta->status_stats.last_pkt_time = jiffies;
+				sta->deflink.status_stats.last_pkt_time = jiffies;
 
 				/* Reset connection monitor */
 				if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1166,10 +1167,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 					sdata->u.mgd.probe_send_count = 0;
 
 				if (ack_signal_valid) {
-					sta->status_stats.last_ack_signal =
+					sta->deflink.status_stats.last_ack_signal =
 							 (s8)info->status.ack_signal;
-					sta->status_stats.ack_signal_filled = true;
-					ewma_avg_signal_add(&sta->status_stats.avg_ack_signal,
+					sta->deflink.status_stats.ack_signal_filled = true;
+					ewma_avg_signal_add(&sta->deflink.status_stats.avg_ack_signal,
 							    -info->status.ack_signal);
 				}
 			} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
@@ -1235,7 +1236,7 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 	rate_control_tx_status(local, sband, &status);
 
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
-		sta->tx_stats.last_rate = info->status.rates[0];
+		sta->deflink.tx_stats.last_rate = info->status.rates[0];
 }
 EXPORT_SYMBOL(ieee80211_tx_rate_update);
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 137be9e..4e2d22e 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -459,9 +459,9 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 		pos = skb_put(skb, sizeof(struct ieee80211_ht_cap) + 2);
 		ieee80211_ie_build_ht_cap(pos, &ht_cap, ht_cap.cap);
 	} else if (action_code == WLAN_TDLS_SETUP_RESPONSE &&
-		   ht_cap.ht_supported && sta->sta.ht_cap.ht_supported) {
+		   ht_cap.ht_supported && sta->sta.deflink.ht_cap.ht_supported) {
 		/* the peer caps are already intersected with our own */
-		memcpy(&ht_cap, &sta->sta.ht_cap, sizeof(ht_cap));
+		memcpy(&ht_cap, &sta->sta.deflink.ht_cap, sizeof(ht_cap));
 
 		pos = skb_put(skb, sizeof(struct ieee80211_ht_cap) + 2);
 		ieee80211_ie_build_ht_cap(pos, &ht_cap, ht_cap.cap);
@@ -510,9 +510,9 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 		pos = skb_put(skb, sizeof(struct ieee80211_vht_cap) + 2);
 		ieee80211_ie_build_vht_cap(pos, &vht_cap, vht_cap.cap);
 	} else if (action_code == WLAN_TDLS_SETUP_RESPONSE &&
-		   vht_cap.vht_supported && sta->sta.vht_cap.vht_supported) {
+		   vht_cap.vht_supported && sta->sta.deflink.vht_cap.vht_supported) {
 		/* the peer caps are already intersected with our own */
-		memcpy(&vht_cap, &sta->sta.vht_cap, sizeof(vht_cap));
+		memcpy(&vht_cap, &sta->sta.deflink.vht_cap, sizeof(vht_cap));
 
 		/* the AID is present only when VHT is implemented */
 		ieee80211_tdls_add_aid(sdata, skb);
@@ -603,13 +603,13 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 	 * if HT support is only added in TDLS, we need an HT-operation IE.
 	 * add the IE as required by IEEE802.11-2012 9.23.3.2.
 	 */
-	if (!ap_sta->sta.ht_cap.ht_supported && sta->sta.ht_cap.ht_supported) {
+	if (!ap_sta->sta.deflink.ht_cap.ht_supported && sta->sta.deflink.ht_cap.ht_supported) {
 		u16 prot = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED |
 			   IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT |
 			   IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT;
 
 		pos = skb_put(skb, 2 + sizeof(struct ieee80211_ht_operation));
-		ieee80211_ie_build_ht_oper(pos, &sta->sta.ht_cap,
+		ieee80211_ie_build_ht_oper(pos, &sta->sta.deflink.ht_cap,
 					   &sdata->vif.bss_conf.chandef, prot,
 					   true);
 	}
@@ -618,7 +618,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 
 	/* only include VHT-operation if not on the 2.4GHz band */
 	if (sband->band != NL80211_BAND_2GHZ &&
-	    sta->sta.vht_cap.vht_supported) {
+	    sta->sta.deflink.vht_cap.vht_supported) {
 		/*
 		 * if both peers support WIDER_BW, we can expand the chandef to
 		 * a wider compatible one, up to 80MHz
@@ -627,7 +627,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 			ieee80211_tdls_chandef_vht_upgrade(sdata, sta);
 
 		pos = skb_put(skb, 2 + sizeof(struct ieee80211_vht_operation));
-		ieee80211_ie_build_vht_oper(pos, &sta->sta.vht_cap,
+		ieee80211_ie_build_vht_oper(pos, &sta->sta.deflink.vht_cap,
 					    &sta->tdls_chandef);
 	}
 
@@ -1269,8 +1269,8 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 
 			bw = ieee80211_chan_width_to_rx_bw(conf->def.width);
 			bw = min(bw, ieee80211_sta_cap_rx_bw(sta));
-			if (bw != sta->sta.bandwidth) {
-				sta->sta.bandwidth = bw;
+			if (bw != sta->sta.deflink.bandwidth) {
+				sta->sta.deflink.bandwidth = bw;
 				rate_control_rate_update(local, sband, sta,
 							 IEEE80211_RC_BW_CHANGED);
 				/*
@@ -1296,7 +1296,7 @@ static int iee80211_tdls_have_ht_peers(struct ieee80211_sub_if_data *sdata)
 		if (!sta->sta.tdls || sta->sdata != sdata || !sta->uploaded ||
 		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
 		    !test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH) ||
-		    !sta->sta.ht_cap.ht_supported)
+		    !sta->sta.deflink.ht_cap.ht_supported)
 			continue;
 		result = true;
 		break;
@@ -1321,7 +1321,7 @@ iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
 		return;
 
-	tdls_ht = (sta && sta->sta.ht_cap.ht_supported) ||
+	tdls_ht = (sta && sta->sta.deflink.ht_cap.ht_supported) ||
 		  iee80211_tdls_have_ht_peers(sdata);
 
 	opmode = sdata->vif.bss_conf.ht_operation_mode;
@@ -1900,7 +1900,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* peer should have known better */
-	if (!sta->sta.ht_cap.ht_supported && elems->sec_chan_offs &&
+	if (!sta->sta.deflink.ht_cap.ht_supported && elems->sec_chan_offs &&
 	    elems->sec_chan_offs->sec_chan_offs) {
 		tdls_dbg(sdata, "TDLS chan switch - wide chan unsupported\n");
 		ret = -ENOTSUPP;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index d91498f..743adfb 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -860,8 +860,8 @@ TRACE_EVENT(drv_sta_set_txpwr,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		STA_ASSIGN;
-		__entry->txpwr = sta->txpwr.power;
-		__entry->type = sta->txpwr.type;
+		__entry->txpwr = sta->deflink.txpwr.power;
+		__entry->type = sta->deflink.txpwr.type;
 	),
 
 	TP_printk(
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b6b20f3..13253eb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -768,9 +768,9 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	if (txrc.reported_rate.idx < 0) {
 		txrc.reported_rate = tx->rate;
 		if (tx->sta && ieee80211_is_tx_data(tx->skb))
-			tx->sta->tx_stats.last_rate = txrc.reported_rate;
+			tx->sta->deflink.tx_stats.last_rate = txrc.reported_rate;
 	} else if (tx->sta)
-		tx->sta->tx_stats.last_rate = txrc.reported_rate;
+		tx->sta->deflink.tx_stats.last_rate = txrc.reported_rate;
 
 	if (ratetbl)
 		return TX_CONTINUE;
@@ -837,7 +837,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 		hdr->seq_ctrl = cpu_to_le16(tx->sdata->sequence_number);
 		tx->sdata->sequence_number += 0x10;
 		if (tx->sta)
-			tx->sta->tx_stats.msdu[IEEE80211_NUM_TIDS]++;
+			tx->sta->deflink.tx_stats.msdu[IEEE80211_NUM_TIDS]++;
 		return TX_CONTINUE;
 	}
 
@@ -851,7 +851,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 
 	/* include per-STA, per-TID sequence counter */
 	tid = ieee80211_get_tid(hdr);
-	tx->sta->tx_stats.msdu[tid]++;
+	tx->sta->deflink.tx_stats.msdu[tid]++;
 
 	hdr->seq_ctrl = ieee80211_tx_next_seq(tx->sta, tid);
 
@@ -1004,10 +1004,10 @@ ieee80211_tx_h_stats(struct ieee80211_tx_data *tx)
 
 	skb_queue_walk(&tx->skbs, skb) {
 		ac = skb_get_queue_mapping(skb);
-		tx->sta->tx_stats.bytes[ac] += skb->len;
+		tx->sta->deflink.tx_stats.bytes[ac] += skb->len;
 	}
 	if (ac >= 0)
-		tx->sta->tx_stats.packets[ac]++;
+		tx->sta->deflink.tx_stats.packets[ac]++;
 
 	return TX_CONTINUE;
 }
@@ -1159,7 +1159,7 @@ ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 	if (!ref || !(ref->ops->capa & RATE_CTRL_CAPA_AMPDU_TRIGGER))
 		return;
 
-	if (!sta || !sta->sta.ht_cap.ht_supported ||
+	if (!sta || !sta->sta.deflink.ht_cap.ht_supported ||
 	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
 	    skb->protocol == sdata->control_port_protocol)
 		return;
@@ -3462,18 +3462,18 @@ ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (skb_shinfo(skb)->gso_size)
-		sta->tx_stats.msdu[tid] +=
+		sta->deflink.tx_stats.msdu[tid] +=
 			DIV_ROUND_UP(skb->len, skb_shinfo(skb)->gso_size);
 	else
-		sta->tx_stats.msdu[tid]++;
+		sta->deflink.tx_stats.msdu[tid]++;
 
 	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	/* statistics normally done by ieee80211_tx_h_stats (but that
 	 * has to consider fragmentation, so is more complex)
 	 */
-	sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-	sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	sta->deflink.tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
+	sta->deflink.tx_stats.packets[skb_get_queue_mapping(skb)]++;
 
 	if (pn_offs) {
 		u64 pn;
@@ -4481,8 +4481,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	dev_sw_netstats_tx_add(dev, 1, skb->len);
 
-	sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-	sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	sta->deflink.tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
+	sta->deflink.tx_stats.packets[skb_get_queue_mapping(skb)]++;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 8f16aa9..ff26e0c 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -118,14 +118,14 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    struct sta_info *sta)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
 	struct ieee80211_sta_vht_cap own_cap;
 	u32 cap_info, i;
 	bool have_80mhz;
 
 	memset(vht_cap, 0, sizeof(*vht_cap));
 
-	if (!sta->sta.ht_cap.ht_supported)
+	if (!sta->sta.deflink.ht_cap.ht_supported)
 		return;
 
 	if (!vht_cap_ie || !sband->vht_cap.vht_supported)
@@ -295,10 +295,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	default:
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 
 		if (!(vht_cap->vht_mcs.tx_highest &
 				cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE)))
@@ -310,10 +310,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 		 * above) between 160 and 80+80 yet.
 		 */
 		if (cap_info & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
-			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 	}
 
-	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta);
 
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
@@ -332,9 +332,9 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 /* FIXME: move this to some better location - parses HE/EHT now */
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
-	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.eht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->sta.deflink.he_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.deflink.eht_cap;
 	u32 cap_width;
 
 	if (he_cap->has_he) {
@@ -369,7 +369,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 	}
 
 	if (!vht_cap->vht_supported)
-		return sta->sta.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		return sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 :
 				IEEE80211_STA_RX_BW_20;
 
@@ -392,14 +392,14 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 
 enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
 	u32 cap_width;
 
 	if (!vht_cap->vht_supported) {
-		if (!sta->sta.ht_cap.ht_supported)
+		if (!sta->sta.deflink.ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20_NOHT;
 
-		return sta->sta.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		return sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				NL80211_CHAN_WIDTH_40 : NL80211_CHAN_WIDTH_20;
 	}
 
@@ -416,13 +416,13 @@ enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta)
 enum nl80211_chan_width
 ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta)
 {
-	enum ieee80211_sta_rx_bandwidth cur_bw = sta->sta.bandwidth;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	enum ieee80211_sta_rx_bandwidth cur_bw = sta->sta.deflink.bandwidth;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
 	u32 cap_width;
 
 	switch (cur_bw) {
 	case IEEE80211_STA_RX_BW_20:
-		if (!sta->sta.ht_cap.ht_supported)
+		if (!sta->sta.deflink.ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20_NOHT;
 		else
 			return NL80211_CHAN_WIDTH_20;
@@ -473,7 +473,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
 	enum nl80211_chan_width bss_width = sdata->vif.bss_conf.chandef.width;
 
 	bw = ieee80211_sta_cap_rx_bw(sta);
-	bw = min(bw, sta->cur_max_bandwidth);
+	bw = min(bw, sta->deflink.cur_max_bandwidth);
 
 	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
 	 * IEEE80211-2016 specification makes higher bandwidth operation
@@ -501,12 +501,12 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 	bool support_160;
 
 	/* if we received a notification already don't overwrite it */
-	if (sta->sta.rx_nss)
+	if (sta->sta.deflink.rx_nss)
 		return;
 
-	if (sta->sta.eht_cap.has_eht) {
+	if (sta->sta.deflink.eht_cap.has_eht) {
 		int i;
-		const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
+		const u8 *rx_nss_mcs = (void *)&sta->sta.deflink.eht_cap.eht_mcs_nss_supp;
 
 		/* get the max nss for EHT over all possible bandwidths and mcs */
 		for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
@@ -515,10 +515,10 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 						       IEEE80211_EHT_MCS_NSS_RX));
 	}
 
-	if (sta->sta.he_cap.has_he) {
+	if (sta->sta.deflink.he_cap.has_he) {
 		int i;
 		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
-		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.deflink.he_cap;
 		u16 mcs_160_map =
 			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
@@ -549,23 +549,23 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 			he_rx_nss = rx_mcs_80;
 	}
 
-	if (sta->sta.ht_cap.ht_supported) {
-		if (sta->sta.ht_cap.mcs.rx_mask[0])
+	if (sta->sta.deflink.ht_cap.ht_supported) {
+		if (sta->sta.deflink.ht_cap.mcs.rx_mask[0])
 			ht_rx_nss++;
-		if (sta->sta.ht_cap.mcs.rx_mask[1])
+		if (sta->sta.deflink.ht_cap.mcs.rx_mask[1])
 			ht_rx_nss++;
-		if (sta->sta.ht_cap.mcs.rx_mask[2])
+		if (sta->sta.deflink.ht_cap.mcs.rx_mask[2])
 			ht_rx_nss++;
-		if (sta->sta.ht_cap.mcs.rx_mask[3])
+		if (sta->sta.deflink.ht_cap.mcs.rx_mask[3])
 			ht_rx_nss++;
 		/* FIXME: consider rx_highest? */
 	}
 
-	if (sta->sta.vht_cap.vht_supported) {
+	if (sta->sta.deflink.vht_cap.vht_supported) {
 		int i;
 		u16 rx_mcs_map;
 
-		rx_mcs_map = le16_to_cpu(sta->sta.vht_cap.vht_mcs.rx_mcs_map);
+		rx_mcs_map = le16_to_cpu(sta->sta.deflink.vht_cap.vht_mcs.rx_mcs_map);
 
 		for (i = 7; i >= 0; i--) {
 			u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
@@ -581,7 +581,7 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
 	rx_nss = max(eht_rx_nss, rx_nss);
-	sta->sta.rx_nss = max_t(u8, 1, rx_nss);
+	sta->sta.deflink.rx_nss = max_t(u8, 1, rx_nss);
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
@@ -601,8 +601,8 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	nss += 1;
 
-	if (sta->sta.rx_nss != nss) {
-		sta->sta.rx_nss = nss;
+	if (sta->sta.deflink.rx_nss != nss) {
+		sta->sta.deflink.rx_nss = nss;
 		sta_opmode.rx_nss = nss;
 		changed |= IEEE80211_RC_NSS_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
@@ -611,27 +611,27 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
+		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
+		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ:
 		if (opmode & IEEE80211_OPMODE_NOTIF_BW_160_80P80)
-			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		else
-			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ:
 		/* legacy only, no longer used by newer spec */
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	}
 
 	new_bw = ieee80211_sta_cur_vht_bw(sta);
-	if (new_bw != sta->sta.bandwidth) {
-		sta->sta.bandwidth = new_bw;
+	if (new_bw != sta->sta.deflink.bandwidth) {
+		sta->sta.deflink.bandwidth = new_bw;
 		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(sta);
 		changed |= IEEE80211_RC_BW_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_MAX_BW_CHANGED;
-- 
2.7.4

