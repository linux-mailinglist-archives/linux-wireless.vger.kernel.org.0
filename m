Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E8261B82
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgIHTEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:08 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52854 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731743AbgIHTD6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 7791C4F9B30;
        Tue,  8 Sep 2020 19:03:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1HF3OG1nA98S; Tue,  8 Sep 2020 19:03:49 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id ACA954F9B1A;
        Tue,  8 Sep 2020 19:03:25 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 19/22] mac80211: support S1G association
Date:   Tue,  8 Sep 2020 12:03:20 -0700
Message-Id: <20200908190323.15814-20-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The changes required for associating in S1G are:

- apply S1G BSS channel info before assoc
- mark all S1G STAs as QoS STAs
- include and parse AID request element
- handle new Association Response format
- don't fail assoc if supported rates element is missing

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h  | 21 ++++++++++
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         |  2 +
 net/mac80211/ibss.c        |  3 +-
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/mlme.c        | 80 ++++++++++++++++++++++++++++++++------
 net/mac80211/util.c        | 55 ++++++++++++++++++++++++++
 7 files changed, 153 insertions(+), 13 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a63ad4b4f973..1634650a44ce 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -987,6 +987,25 @@ enum ieee80211_vht_opmode_bits {
 	IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF	= 0x80,
 };
 
+/**
+ * enum ieee80211_s1g_chanwidth
+ * These are defined in IEEE802.11-2016ah Table 10-20
+ * as BSS Channel Width
+ *
+ * @IEEE80211_S1G_CHANWIDTH_1MHZ: 1MHz operating channel
+ * @IEEE80211_S1G_CHANWIDTH_2MHZ: 2MHz operating channel
+ * @IEEE80211_S1G_CHANWIDTH_4MHZ: 4MHz operating channel
+ * @IEEE80211_S1G_CHANWIDTH_8MHZ: 8MHz operating channel
+ * @IEEE80211_S1G_CHANWIDTH_16MHZ: 16MHz operating channel
+ */
+enum ieee80211_s1g_chanwidth {
+	IEEE80211_S1G_CHANWIDTH_1MHZ = 0,
+	IEEE80211_S1G_CHANWIDTH_2MHZ = 1,
+	IEEE80211_S1G_CHANWIDTH_4MHZ = 3,
+	IEEE80211_S1G_CHANWIDTH_8MHZ = 7,
+	IEEE80211_S1G_CHANWIDTH_16MHZ = 15,
+};
+
 #define WLAN_SA_QUERY_TR_ID_LEN 2
 #define WLAN_MEMBERSHIP_LEN 8
 #define WLAN_USER_POSITION_LEN 16
@@ -2854,6 +2873,8 @@ enum ieee80211_eid {
 
 	WLAN_EID_REDUCED_NEIGHBOR_REPORT = 201,
 
+	WLAN_EID_AID_REQUEST = 210,
+	WLAN_EID_AID_RESPONSE = 211,
 	WLAN_EID_S1G_BCN_COMPAT = 213,
 	WLAN_EID_S1G_SHORT_BCN_INTERVAL = 214,
 	WLAN_EID_S1G_CAPABILITIES = 217,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9ea743afb986..bc78edf1c994 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -674,6 +674,7 @@ struct ieee80211_bss_conf {
 	} he_oper;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	bool s1g;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4e39e31a985..086e51a78394 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1071,6 +1071,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	       sizeof(struct ieee80211_he_obss_pd));
 	memcpy(&sdata->vif.bss_conf.he_bss_color, &params->he_bss_color,
 	       sizeof(struct ieee80211_he_bss_color));
+	sdata->vif.bss_conf.s1g = params->chandef.chan->band ==
+				  NL80211_BAND_S1GHZ;
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index c0963969a465..1f552f374e97 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1037,7 +1037,8 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (sta && !sta->sta.wme &&
-	    elems->wmm_info && local->hw.queues >= IEEE80211_NUM_ACS) {
+	    (elems->wmm_info || elems->s1g_capab) &&
+	    local->hw.queues >= IEEE80211_NUM_ACS) {
 		sta->sta.wme = true;
 		ieee80211_check_fast_xmit(sta);
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9847cfa0e08c..60786e4b9f5f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1531,6 +1531,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_s1g_oper_ie *s1g_oper;
 	const u8 *s1g_tsbtt;
 	const struct ieee80211_s1g_bcn_compat_ie *s1g_bcn_compat;
+	const struct ieee80211_aid_response_ie *aid_resp;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -2206,6 +2207,7 @@ int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
 u8 *ieee80211_add_wmm_info_ie(u8 *buf, u8 qosinfo);
 u8 *ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 			       struct ieee80211_sta_s1g_cap *caps, u8 *buf);
+u8 *ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata, u8 *buf);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
@@ -2217,6 +2219,8 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_oper,
 				    struct cfg80211_chan_def *chandef);
+bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
+				struct cfg80211_chan_def *chandef);
 u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
 
 int __must_check
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9a26ef99cef9..2476d4a9596c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -149,6 +149,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			     const struct ieee80211_ht_operation *ht_oper,
 			     const struct ieee80211_vht_operation *vht_oper,
 			     const struct ieee80211_he_operation *he_oper,
+			     const struct ieee80211_s1g_oper_ie *s1g_oper,
 			     struct cfg80211_chan_def *chandef, bool tracking)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -176,6 +177,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
 	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
 
+	if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
+		ieee80211_chandef_s1g_oper(s1g_oper, chandef);
+		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
+		      IEEE80211_STA_DISABLE_VHT |
+		      IEEE80211_STA_DISABLE_80P80MHZ |
+		      IEEE80211_STA_DISABLE_160MHZ;
+		goto out;
+	}
+
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
@@ -347,6 +357,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 			       const struct ieee80211_ht_operation *ht_oper,
 			       const struct ieee80211_vht_operation *vht_oper,
 			       const struct ieee80211_he_operation *he_oper,
+			       const struct ieee80211_s1g_oper_ie *s1g_oper,
 			       const u8 *bssid, u32 *changed)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -393,7 +404,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	/* calculate new channel (type) based on HT/VHT/HE operation IEs */
 	flags = ieee80211_determine_chantype(sdata, sband, chan, vht_cap_info,
 					     ht_oper, vht_oper, he_oper,
-					     &chandef, true);
+					     s1g_oper, &chandef, true);
 
 	/*
 	 * Downgrade the new channel if we associated with restricted
@@ -812,6 +823,9 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	*pos++ = assoc_data->ssid_len;
 	memcpy(pos, assoc_data->ssid, assoc_data->ssid_len);
 
+	if (bss->s1g)
+		goto skip_rates;
+
 	/* add all rates which were marked to be used above */
 	supp_rates_len = rates_len;
 	if (supp_rates_len > 8)
@@ -847,6 +861,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		}
 	}
 
+skip_rates:
 	if (capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
 	    capab & WLAN_CAPABILITY_RADIO_MEASURE) {
 		pos = skb_put(skb, 4);
@@ -1021,9 +1036,11 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		pos = ieee80211_add_wmm_info_ie(skb_put(skb, 9), qos_info);
 	}
 
-	if (sband->band == NL80211_BAND_S1GHZ)
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		pos = ieee80211_add_aid_request_ie(sdata, skb_put(skb, 3));
 		pos = ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap,
 						 skb_put(skb, 17));
+	}
 
 	/* add any remaining custom (i.e. vendor specific here) IEs */
 	if (assoc_data->ie_len) {
@@ -3270,6 +3287,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct ieee802_11_elems *elems)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	struct sta_info *sta;
@@ -3279,13 +3297,24 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	u32 changed = 0;
+	u8 *pos;
 	int err;
 	bool ret;
 
 	/* AssocResp and ReassocResp have identical structure */
 
+	pos = mgmt->u.assoc_resp.variable;
 	aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
+	if (bss->s1g) {
+		pos = (u8 *) mgmt->u.s1g_assoc_resp.variable;
+		aid = 0; /* TODO */
+	}
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
+	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, elems,
+			       mgmt->bssid, assoc_data->bss->bssid);
+
+	if (elems->aid_resp)
+		aid = le16_to_cpu(elems->aid_resp->aid);
 
 	/*
 	 * The 5 MSB of the AID field are reserved
@@ -3302,7 +3331,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		ifmgd->broken_ap = true;
 	}
 
-	if (!elems->supp_rates) {
+	if (!bss->s1g && !elems->supp_rates) {
 		sdata_info(sdata, "no SuppRates element in AssocResp\n");
 		return false;
 	}
@@ -3544,7 +3573,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		sta->sta.mfp = false;
 	}
 
-	sta->sta.wme = elems->wmm_param && local->hw.queues >= IEEE80211_NUM_ACS;
+	sta->sta.wme = (elems->wmm_param || elems->s1g_capab) &&
+		       local->hw.queues >= IEEE80211_NUM_ACS;
 
 	err = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
 	if (!err && !(ifmgd->flags & IEEE80211_STA_CONTROL_PORT))
@@ -3636,7 +3666,8 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	int ac, uapsd_queues = -1;
 	u8 *pos;
 	bool reassoc;
-	struct cfg80211_bss *bss;
+	struct cfg80211_bss *cbss;
+	struct ieee80211_bss *bss;
 	struct ieee80211_event event = {
 		.type = MLME_EVENT,
 		.u.mlme.data = ASSOC_EVENT,
@@ -3646,9 +3677,13 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 
 	if (!assoc_data)
 		return;
+
 	if (!ether_addr_equal(assoc_data->bss->bssid, mgmt->bssid))
 		return;
 
+	cbss = assoc_data->bss;
+	bss = (void *) cbss->priv;
+
 	/*
 	 * AssocResp and ReassocResp have identical structure, so process both
 	 * of them in this function.
@@ -3660,7 +3695,12 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	reassoc = ieee80211_is_reassoc_resp(mgmt->frame_control);
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
 	status_code = le16_to_cpu(mgmt->u.assoc_resp.status_code);
+	pos = mgmt->u.assoc_resp.variable;
 	aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
+	if (bss->s1g) {
+		pos = (u8 *) mgmt->u.s1g_assoc_resp.variable;
+		aid = 0; /* TODO */
+	}
 
 	sdata_info(sdata,
 		   "RX %sssocResp from %pM (capab=0x%x status=%d aid=%d)\n",
@@ -3671,7 +3711,6 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	    fils_decrypt_assoc_resp(sdata, (u8 *)mgmt, &len, assoc_data) < 0)
 		return;
 
-	pos = mgmt->u.assoc_resp.variable;
 	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, &elems,
 			       mgmt->bssid, assoc_data->bss->bssid);
 
@@ -3691,8 +3730,6 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	bss = assoc_data->bss;
-
 	if (status_code != WLAN_STATUS_SUCCESS) {
 		sdata_info(sdata, "%pM denied association (code=%d)\n",
 			   mgmt->sa, status_code);
@@ -3701,10 +3738,10 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
-		if (!ieee80211_assoc_success(sdata, bss, mgmt, len, &elems)) {
+		if (!ieee80211_assoc_success(sdata, cbss, mgmt, len, &elems)) {
 			/* oops -- internal error -- send timeout for now */
 			ieee80211_destroy_assoc_data(sdata, false, false);
-			cfg80211_assoc_timeout(sdata->dev, bss);
+			cfg80211_assoc_timeout(sdata->dev, cbss);
 			return;
 		}
 		event.u.mlme.status = MLME_SUCCESS;
@@ -3725,7 +3762,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 				uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
 	}
 
-	cfg80211_rx_assoc_resp(sdata->dev, bss, (u8 *)mgmt, len, uapsd_queues,
+	cfg80211_rx_assoc_resp(sdata->dev, cbss, (u8 *)mgmt, len, uapsd_queues,
 			       ifmgd->assoc_req_ies, ifmgd->assoc_req_ies_len);
 }
 
@@ -4175,7 +4212,7 @@ static void ieee80211_rx_beacon(struct ieee80211_sub_if_data *sdata,
 	if (ieee80211_config_bw(sdata, sta, elems.ht_cap_elem,
 				elems.vht_cap_elem, elems.ht_operation,
 				elems.vht_operation, elems.he_operation,
-				bssid, &changed)) {
+				elems.s1g_oper, bssid, &changed)) {
 		mutex_unlock(&local->sta_mtx);
 		sdata_info(sdata,
 			   "failed to follow AP %pM bandwidth change, disconnect\n",
@@ -4912,6 +4949,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_ht_operation *ht_oper = NULL;
 	const struct ieee80211_vht_operation *vht_oper = NULL;
 	const struct ieee80211_he_operation *he_oper = NULL;
+	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
 	struct ieee80211_supported_band *sband;
 	struct cfg80211_chan_def chandef;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
@@ -5014,10 +5052,23 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!have_80mhz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		const u8 *s1g_oper_ie;
+
+		s1g_oper_ie = ieee80211_bss_get_ie(cbss,
+						   WLAN_EID_S1G_OPERATION);
+		if (s1g_oper_ie && s1g_oper_ie[1] >= sizeof(*s1g_oper))
+			s1g_oper = (void *)(s1g_oper_ie + 2);
+		else
+			sdata_info(sdata,
+				   "AP missing S1G operation element?\n");
+	}
+
 	ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
 						     cbss->channel,
 						     bss->vht_cap_info,
 						     ht_oper, vht_oper, he_oper,
+						     s1g_oper,
 						     &chandef, false);
 
 	sdata->needed_rx_chains = min(ieee80211_ht_vht_rx_chains(sdata, cbss),
@@ -5144,6 +5195,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		const struct cfg80211_bss_ies *ies;
 		int shift = ieee80211_vif_get_shift(&sdata->vif);
 
+		/* TODO: S1G Basic Rate Set is expressed elsewhere */
+		if (cbss->channel->band == NL80211_BAND_S1GHZ)
+			goto skip_rates;
+
 		ieee80211_get_rates(sband, bss->supp_rates,
 				    bss->supp_rates_len,
 				    &rates, &basic_rates,
@@ -5188,6 +5243,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		else
 			sdata->flags &= ~IEEE80211_SDATA_OPERATING_GMODE;
 
+skip_rates:
 		memcpy(ifmgd->bssid, cbss->bssid, ETH_ALEN);
 
 		/* set timing information */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 31845e392759..46cff63fea12 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1058,6 +1058,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 		case WLAN_EID_S1G_BCN_COMPAT:
 		case WLAN_EID_S1G_CAPABILITIES:
 		case WLAN_EID_S1G_OPERATION:
+		case WLAN_EID_AID_RESPONSE:
 		case WLAN_EID_S1G_SHORT_BCN_INTERVAL:
 		/*
 		 * not listing WLAN_EID_CHANNEL_SWITCH_WRAPPER -- it seems possible
@@ -1368,6 +1369,12 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			else
 				elem_parse_failed = true;
 			break;
+		case WLAN_EID_AID_RESPONSE:
+			if (elen == sizeof(struct ieee80211_aid_response_ie))
+				elems->aid_resp = (void *)pos;
+			else
+				elem_parse_failed = true;
+			break;
 		default:
 			break;
 		}
@@ -3450,6 +3457,42 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 
 	*chandef = he_chandef;
 
+	return false;
+}
+
+bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
+				struct cfg80211_chan_def *chandef)
+{
+	u32 oper_freq;
+
+	if (!oper)
+		return false;
+
+	switch (FIELD_GET(S1G_OPER_CH_WIDTH_OPER, oper->ch_width)) {
+	case IEEE80211_S1G_CHANWIDTH_1MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_1;
+		break;
+	case IEEE80211_S1G_CHANWIDTH_2MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_2;
+		break;
+	case IEEE80211_S1G_CHANWIDTH_4MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_4;
+		break;
+	case IEEE80211_S1G_CHANWIDTH_8MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_8;
+		break;
+	case IEEE80211_S1G_CHANWIDTH_16MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_16;
+		break;
+	default:
+		return false;
+	}
+
+	oper_freq = ieee80211_channel_to_freq_khz(oper->oper_ch,
+						  NL80211_BAND_S1GHZ);
+	chandef->center_freq1 = KHZ_TO_MHZ(oper_freq);
+	chandef->freq1_offset = oper_freq % 1000;
+
 	return true;
 }
 
@@ -4356,6 +4399,18 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 	return max_num_different_channels;
 }
 
+u8 *ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata, u8 *buf)
+{
+	u8 *pos = buf;
+
+	*pos++ = WLAN_EID_AID_REQUEST;
+	*pos++ = 1;
+
+	*pos++ = 0;
+
+	return pos;
+}
+
 u8 *ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 			       struct ieee80211_sta_s1g_cap *own_cap, u8 *buf)
 {
-- 
2.20.1

