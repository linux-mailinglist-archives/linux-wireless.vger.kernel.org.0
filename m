Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4A57332E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiGMJpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A5ED16E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Lljb1etc1+oTxQdmCYfUjGX74DZ6+JLiYubvM8qervo=;
        t=1657705509; x=1658915109; b=Pa3GzPRWhQBGLMQc4KAhGs/gqftP6sTxu9okZ7vtkytdJ6s
        fdrmPGtrXG7fS9gAyqz2KStUPuT3gOcejEERQDcLQawXDxrBEgXVsaKfeCV7ZK6cK1PxOTsK9V1d+
        wrll8vzqA/PN9r2dSSbnlOSYnZS8w18gPLP82Th+Bbh/XvADe43znq3u9Ov63No7KevPQCxi5HyVt
        NWPEiHdw1WUYe11SwKVAzMEE+AHt7lv/xCoYm30Fu9WK2P3jayxP2LqFy5rogE6Ue557iasvYbXVb
        zNk3zkPRynCSOFLVOzPofBTsOr/Zj/KEktiC18Pn4KmX/d05RRvyFesN75zqJ7Bw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvb-00EgvB-25;
        Wed, 13 Jul 2022 11:45:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 09/76] wifi: cfg80211/mac80211: separate link params from station params
Date:   Wed, 13 Jul 2022 11:43:55 +0200
Message-Id: <20220713114425.547f120c983e.I6011abf39c892feec784b824594280f2f352543c@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Put the link_station_parameters structure in the station_parameters
structure (and remove the station_parameters fields already existing
in link_station_parameters).
Now, for an MLD station, the default link is added together with
the station.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/marvell/mwifiex/sta_cmd.c    |  20 +--
 drivers/net/wireless/microchip/wilc1000/hif.c |  20 +--
 include/net/cfg80211.h                        |  28 +---
 net/mac80211/cfg.c                            | 143 +++++++++++-------
 net/wireless/nl80211.c                        |  97 ++++++------
 net/wireless/trace.h                          |  24 +--
 6 files changed, 180 insertions(+), 152 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 1e2798dce18f..851ea58fb38e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1790,29 +1790,31 @@ mwifiex_cmd_tdls_oper(struct mwifiex_private *priv,
 		wmm_qos_info->qos_info = 0;
 		config_len += sizeof(struct mwifiex_ie_types_qos_info);
 
-		if (params->ht_capa) {
+		if (params->link_sta_params.ht_capa) {
 			ht_capab = (struct mwifiex_ie_types_htcap *)(pos +
 								    config_len);
 			ht_capab->header.type =
 					    cpu_to_le16(WLAN_EID_HT_CAPABILITY);
 			ht_capab->header.len =
 				   cpu_to_le16(sizeof(struct ieee80211_ht_cap));
-			memcpy(&ht_capab->ht_cap, params->ht_capa,
+			memcpy(&ht_capab->ht_cap, params->link_sta_params.ht_capa,
 			       sizeof(struct ieee80211_ht_cap));
 			config_len += sizeof(struct mwifiex_ie_types_htcap);
 		}
 
-		if (params->supported_rates && params->supported_rates_len) {
+		if (params->link_sta_params.supported_rates &&
+		    params->link_sta_params.supported_rates_len) {
 			tlv_rates = (struct host_cmd_tlv_rates *)(pos +
 								  config_len);
 			tlv_rates->header.type =
 					       cpu_to_le16(WLAN_EID_SUPP_RATES);
 			tlv_rates->header.len =
-				       cpu_to_le16(params->supported_rates_len);
-			memcpy(tlv_rates->rates, params->supported_rates,
-			       params->supported_rates_len);
+				       cpu_to_le16(params->link_sta_params.supported_rates_len);
+			memcpy(tlv_rates->rates,
+			       params->link_sta_params.supported_rates,
+			       params->link_sta_params.supported_rates_len);
 			config_len += sizeof(struct host_cmd_tlv_rates) +
-				      params->supported_rates_len;
+				      params->link_sta_params.supported_rates_len;
 		}
 
 		if (params->ext_capab && params->ext_capab_len) {
@@ -1826,14 +1828,14 @@ mwifiex_cmd_tdls_oper(struct mwifiex_private *priv,
 			config_len += sizeof(struct mwifiex_ie_types_extcap) +
 				      params->ext_capab_len;
 		}
-		if (params->vht_capa) {
+		if (params->link_sta_params.vht_capa) {
 			vht_capab = (struct mwifiex_ie_types_vhtcap *)(pos +
 								    config_len);
 			vht_capab->header.type =
 					   cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
 			vht_capab->header.len =
 				  cpu_to_le16(sizeof(struct ieee80211_vht_cap));
-			memcpy(&vht_capab->vht_cap, params->vht_capa,
+			memcpy(&vht_capab->vht_cap, params->link_sta_params.vht_capa,
 			       sizeof(struct ieee80211_vht_cap));
 			config_len += sizeof(struct mwifiex_ie_types_vhtcap);
 		}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 4038a254465f..021e0db80bd2 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -816,15 +816,15 @@ static void wilc_hif_pack_sta_param(u8 *cur_byte, const u8 *mac,
 	put_unaligned_le16(params->aid, cur_byte);
 	cur_byte += 2;
 
-	*cur_byte++ = params->supported_rates_len;
-	if (params->supported_rates_len > 0)
-		memcpy(cur_byte, params->supported_rates,
-		       params->supported_rates_len);
-	cur_byte += params->supported_rates_len;
+	*cur_byte++ = params->link_sta_params.supported_rates_len;
+	if (params->link_sta_params.supported_rates_len > 0)
+		memcpy(cur_byte, params->link_sta_params.supported_rates,
+		       params->link_sta_params.supported_rates_len);
+	cur_byte += params->link_sta_params.supported_rates_len;
 
-	if (params->ht_capa) {
+	if (params->link_sta_params.ht_capa) {
 		*cur_byte++ = true;
-		memcpy(cur_byte, params->ht_capa,
+		memcpy(cur_byte, params->link_sta_params.ht_capa,
 		       sizeof(struct ieee80211_ht_cap));
 	} else {
 		*cur_byte++ = false;
@@ -1799,7 +1799,8 @@ int wilc_add_station(struct wilc_vif *vif, const u8 *mac,
 
 	wid.id = WID_ADD_STA;
 	wid.type = WID_BIN;
-	wid.size = WILC_ADD_STA_LENGTH + params->supported_rates_len;
+	wid.size = WILC_ADD_STA_LENGTH +
+		   params->link_sta_params.supported_rates_len;
 	wid.val = kmalloc(wid.size, GFP_KERNEL);
 	if (!wid.val)
 		return -ENOMEM;
@@ -1884,7 +1885,8 @@ int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
 
 	wid.id = WID_EDIT_STA;
 	wid.type = WID_BIN;
-	wid.size = WILC_ADD_STA_LENGTH + params->supported_rates_len;
+	wid.size = WILC_ADD_STA_LENGTH +
+		   params->link_sta_params.supported_rates_len;
 	wid.val = kmalloc(wid.size, GFP_KERNEL);
 	if (!wid.val)
 		return -ENOMEM;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a26d738a2f52..d4632b391a15 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1433,7 +1433,6 @@ enum station_parameters_apply_mask {
 	STATION_PARAM_APPLY_UAPSD = BIT(0),
 	STATION_PARAM_APPLY_CAPABILITY = BIT(1),
 	STATION_PARAM_APPLY_PLINK_STATE = BIT(2),
-	STATION_PARAM_APPLY_STA_TXPOWER = BIT(3),
 };
 
 /**
@@ -1517,9 +1516,6 @@ struct link_station_del_parameters {
  * Used to change and create a new station.
  *
  * @vlan: vlan interface station should belong to
- * @supported_rates: supported rates in IEEE 802.11 format
- *	(or NULL for no change)
- * @supported_rates_len: number of supported rates
  * @sta_flags_mask: station flags that changed
  *	(bitmask of BIT(%NL80211_STA_FLAG_...))
  * @sta_flags_set: station flags values
@@ -1530,8 +1526,6 @@ struct link_station_del_parameters {
  * @peer_aid: mesh peer AID or zero for no change
  * @plink_action: plink action to take
  * @plink_state: set the peer link state for a station
- * @ht_capa: HT capabilities of station
- * @vht_capa: VHT capabilities of station
  * @uapsd_queues: bitmap of queues configured for uapsd. same format
  *	as the AC bitmap in the QoS info field
  * @max_sp: max Service Period. same format as the MAX_SP in the
@@ -1548,19 +1542,11 @@ struct link_station_del_parameters {
  * @supported_channels_len: number of supported channels
  * @supported_oper_classes: supported oper classes in IEEE 802.11 format
  * @supported_oper_classes_len: number of supported operating classes
- * @opmode_notif: operating mode field from Operating Mode Notification
- * @opmode_notif_used: information if operating mode field is used
  * @support_p2p_ps: information if station supports P2P PS mechanism
- * @he_capa: HE capabilities of station
- * @he_capa_len: the length of the HE capabilities
  * @airtime_weight: airtime scheduler weight for this station
- * @txpwr: transmit power for an associated station
- * @he_6ghz_capa: HE 6 GHz Band capabilities of station
- * @eht_capa: EHT capabilities of station
- * @eht_capa_len: the length of the EHT capabilities
+ * @link_sta_params: link related params.
  */
 struct station_parameters {
-	const u8 *supported_rates;
 	struct net_device *vlan;
 	u32 sta_flags_mask, sta_flags_set;
 	u32 sta_modify_mask;
@@ -1568,11 +1554,8 @@ struct station_parameters {
 	u16 aid;
 	u16 vlan_id;
 	u16 peer_aid;
-	u8 supported_rates_len;
 	u8 plink_action;
 	u8 plink_state;
-	const struct ieee80211_ht_cap *ht_capa;
-	const struct ieee80211_vht_cap *vht_capa;
 	u8 uapsd_queues;
 	u8 max_sp;
 	enum nl80211_mesh_power_mode local_pm;
@@ -1583,16 +1566,9 @@ struct station_parameters {
 	u8 supported_channels_len;
 	const u8 *supported_oper_classes;
 	u8 supported_oper_classes_len;
-	u8 opmode_notif;
-	bool opmode_notif_used;
 	int support_p2p_ps;
-	const struct ieee80211_he_cap_elem *he_capa;
-	u8 he_capa_len;
 	u16 airtime_weight;
-	struct sta_txpwr txpwr;
-	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
-	const struct ieee80211_eht_cap_elem *eht_capa;
-	u8 eht_capa_len;
+	struct link_station_parameters link_sta_params;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fd6c4291c971..a63f9235bcc3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1581,6 +1581,83 @@ static void sta_apply_mesh_params(struct ieee80211_local *local,
 #endif
 }
 
+static int sta_link_apply_parameters(struct ieee80211_local *local,
+				     struct sta_info *sta,
+				     struct link_station_parameters *params)
+{
+	int ret = 0;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
+	struct link_sta_info *link_sta =
+		rcu_dereference_protected(sta->link[link_id],
+					  lockdep_is_held(&local->sta_mtx));
+
+	if (WARN_ON(!link_sta))
+		return -EINVAL;
+
+	sband = ieee80211_get_link_sband(sdata, link_id);
+	if (!sband)
+		return -EINVAL;
+
+	if (params->link_mac) {
+		memcpy(link_sta->addr, params->link_mac, ETH_ALEN);
+		memcpy(link_sta->pub->addr, params->link_mac, ETH_ALEN);
+	}
+
+	if (params->txpwr_set) {
+		link_sta->pub->txpwr.type = params->txpwr.type;
+		if (params->txpwr.type == NL80211_TX_POWER_LIMITED)
+			link_sta->pub->txpwr.power = params->txpwr.power;
+		ret = drv_sta_set_txpwr(local, sdata, sta);
+		if (ret)
+			return ret;
+	}
+
+	if (params->supported_rates &&
+	    params->supported_rates_len) {
+		ieee80211_parse_bitrates(&sdata->vif.link_conf[link_id]->chandef,
+					 sband, params->supported_rates,
+					 params->supported_rates_len,
+					 &link_sta->pub->supp_rates[sband->band]);
+	}
+
+	if (params->ht_capa)
+		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+						  params->ht_capa, link_sta);
+
+	/* VHT can override some HT caps such as the A-MSDU max length */
+	if (params->vht_capa)
+		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+						    params->vht_capa, link_sta);
+
+	if (params->he_capa)
+		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
+						  (void *)params->he_capa,
+						  params->he_capa_len,
+						  (void *)params->he_6ghz_capa,
+						  link_sta);
+
+	if (params->eht_capa)
+		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
+						    (u8 *)params->he_capa,
+						    params->he_capa_len,
+						    params->eht_capa,
+						    params->eht_capa_len,
+						    link_sta);
+
+	if (params->opmode_notif_used) {
+		/* returned value is only needed for rc update, but the
+		 * rc isn't initialized here yet, so ignore it
+		 */
+		__ieee80211_vht_handle_opmode(sdata, link_sta,
+					      params->opmode_notif,
+					      sband->band);
+	}
+
+	return ret;
+}
+
 static int sta_apply_parameters(struct ieee80211_local *local,
 				struct sta_info *sta,
 				struct station_parameters *params)
@@ -1588,9 +1665,11 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	int ret = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	u32 link_id = params->link_sta_params.link_id < 0 ?
+		      0 : params->link_sta_params.link_id;
 	u32 mask, set;
 
-	sband = ieee80211_get_sband(sdata);
+	sband = ieee80211_get_link_sband(sdata, link_id);
 	if (!sband)
 		return -EINVAL;
 
@@ -1721,56 +1800,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->listen_interval >= 0)
 		sta->listen_interval = params->listen_interval;
 
-	if (params->sta_modify_mask & STATION_PARAM_APPLY_STA_TXPOWER) {
-		sta->sta.deflink.txpwr.type = params->txpwr.type;
-		if (params->txpwr.type == NL80211_TX_POWER_LIMITED)
-			sta->sta.deflink.txpwr.power = params->txpwr.power;
-		ret = drv_sta_set_txpwr(local, sdata, sta);
-		if (ret)
-			return ret;
-	}
-
-	if (params->supported_rates && params->supported_rates_len) {
-		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &sta->sta.deflink.supp_rates[sband->band]);
-	}
-
-	if (params->ht_capa)
-		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-						  params->ht_capa,
-						  &sta->deflink);
-
-	/* VHT can override some HT caps such as the A-MSDU max length */
-	if (params->vht_capa)
-		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    params->vht_capa,
-						    &sta->deflink);
-
-	if (params->he_capa)
-		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
-						  (void *)params->he_capa,
-						  params->he_capa_len,
-						  (void *)params->he_6ghz_capa,
-						  &sta->deflink);
-
-	if (params->eht_capa)
-		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
-						    (u8 *)params->he_capa,
-						    params->he_capa_len,
-						    params->eht_capa,
-						    params->eht_capa_len,
-						    &sta->deflink);
-
-	if (params->opmode_notif_used) {
-		/* returned value is only needed for rc update, but the
-		 * rc isn't initialized here yet, so ignore it
-		 */
-		__ieee80211_vht_handle_opmode(sdata, &sta->deflink,
-					      params->opmode_notif,
-					      sband->band);
-	}
+	ret = sta_link_apply_parameters(local, sta, &params->link_sta_params);
+	if (ret)
+		return ret;
 
 	if (params->support_p2p_ps >= 0)
 		sta->sta.support_p2p_ps = params->support_p2p_ps;
@@ -1821,14 +1853,21 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	    !sdata->u.mgd.associated)
 		return -EINVAL;
 
-	sta = sta_info_alloc(sdata, mac, -1, GFP_KERNEL);
+	sta = sta_info_alloc(sdata, mac, params->link_sta_params.link_id,
+			     GFP_KERNEL);
 	if (!sta)
 		return -ENOMEM;
 
 	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER))
 		sta->sta.tdls = true;
 
+	/* Though the mutex is not needed here (since the station is not
+	 * visible yet), sta_apply_parameters (and inner functions) require
+	 * the mutex due to other paths.
+	 */
+	mutex_lock(&local->sta_mtx);
 	err = sta_apply_parameters(local, sta, params);
+	mutex_unlock(&local->sta_mtx);
 	if (err) {
 		sta_info_free(local, sta);
 		return err;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3cf8e01e3f7e..5f6cbc2d73b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6573,10 +6573,12 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 			return -EINVAL;
 		if (params->sta_modify_mask & STATION_PARAM_APPLY_CAPABILITY)
 			return -EINVAL;
-		if (params->supported_rates)
+		if (params->link_sta_params.supported_rates)
 			return -EINVAL;
-		if (params->ext_capab || params->ht_capa || params->vht_capa ||
-		    params->he_capa || params->eht_capa)
+		if (params->ext_capab || params->link_sta_params.ht_capa ||
+		    params->link_sta_params.vht_capa ||
+		    params->link_sta_params.he_capa ||
+		    params->link_sta_params.eht_capa)
 			return -EINVAL;
 	}
 
@@ -6624,7 +6626,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 			return -EINVAL;
 		/* force (at least) rates when authorizing */
 		if (params->sta_flags_set & BIT(NL80211_STA_FLAG_AUTHORIZED) &&
-		    !params->supported_rates)
+		    !params->link_sta_params.supported_rates)
 			return -EINVAL;
 		break;
 	case CFG80211_STA_TDLS_PEER_ACTIVE:
@@ -6648,7 +6650,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 	 */
 	if (statype != CFG80211_STA_AP_CLIENT_UNASSOC &&
 	    statype != CFG80211_STA_TDLS_PEER_SETUP)
-		params->opmode_notif_used = false;
+		params->link_sta_params.opmode_notif_used = false;
 
 	return 0;
 }
@@ -6769,26 +6771,26 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 	if (info->attrs[NL80211_ATTR_PEER_AID])
 		params->aid = nla_get_u16(info->attrs[NL80211_ATTR_PEER_AID]);
 	if (info->attrs[NL80211_ATTR_HT_CAPABILITY])
-		params->ht_capa =
+		params->link_sta_params.ht_capa =
 			nla_data(info->attrs[NL80211_ATTR_HT_CAPABILITY]);
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY])
-		params->vht_capa =
+		params->link_sta_params.vht_capa =
 			nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY]);
 	if (info->attrs[NL80211_ATTR_HE_CAPABILITY]) {
-		params->he_capa =
+		params->link_sta_params.he_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
-		params->he_capa_len =
+		params->link_sta_params.he_capa_len =
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 
 		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
-			params->eht_capa =
+			params->link_sta_params.eht_capa =
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-			params->eht_capa_len =
+			params->link_sta_params.eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params->he_capa,
-							(const u8 *)params->eht_capa,
-							params->eht_capa_len))
+			if (!ieee80211_eht_capa_size_ok((const u8 *)params->link_sta_params.he_capa,
+							(const u8 *)params->link_sta_params.eht_capa,
+							params->link_sta_params.eht_capa_len))
 				return -EINVAL;
 		}
 	}
@@ -6840,7 +6842,6 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	struct station_parameters params;
 	u8 *mac_addr;
 	int err;
-	bool txpwr_set;
 
 	memset(&params, 0, sizeof(params));
 
@@ -6876,9 +6877,9 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
 	if (info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]) {
-		params.supported_rates =
+		params.link_sta_params.supported_rates =
 			nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
-		params.supported_rates_len =
+		params.link_sta_params.supported_rates_len =
 			nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
 	}
 
@@ -6916,13 +6917,13 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 			info->attrs[NL80211_ATTR_LOCAL_MESH_POWER_MODE]);
 
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
-		params.opmode_notif_used = true;
-		params.opmode_notif =
+		params.link_sta_params.opmode_notif_used = true;
+		params.link_sta_params.opmode_notif =
 			nla_get_u8(info->attrs[NL80211_ATTR_OPMODE_NOTIF]);
 	}
 
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
-		params.he_6ghz_capa =
+		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_AIRTIME_WEIGHT])
@@ -6934,11 +6935,11 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_sta_txpower_setting(info, &params.txpwr, &txpwr_set);
+	err = nl80211_parse_sta_txpower_setting(info,
+						&params.link_sta_params.txpwr,
+						&params.link_sta_params.txpwr_set);
 	if (err)
 		return err;
-	if (txpwr_set)
-		params.sta_modify_mask |= STATION_PARAM_APPLY_STA_TXPOWER;
 
 	/* Include parameters for TDLS peer (will check later) */
 	err = nl80211_set_station_tdls(info, &params);
@@ -6981,7 +6982,6 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	u8 *mac_addr = NULL;
 	u32 auth_assoc = BIT(NL80211_STA_FLAG_AUTHENTICATED) |
 			 BIT(NL80211_STA_FLAG_ASSOCIATED);
-	bool txpwr_set;
 
 	memset(&params, 0, sizeof(params));
 
@@ -7001,10 +7001,13 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	    !info->attrs[NL80211_ATTR_PEER_AID])
 		return -EINVAL;
 
+	params.link_sta_params.link_id =
+		nl80211_link_id_or_invalid(info->attrs);
+
 	mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	params.supported_rates =
+	params.link_sta_params.supported_rates =
 		nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
-	params.supported_rates_len =
+	params.link_sta_params.supported_rates_len =
 		nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
 	params.listen_interval =
 		nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
@@ -7043,39 +7046,39 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_HT_CAPABILITY])
-		params.ht_capa =
+		params.link_sta_params.ht_capa =
 			nla_data(info->attrs[NL80211_ATTR_HT_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY])
-		params.vht_capa =
+		params.link_sta_params.vht_capa =
 			nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_HE_CAPABILITY]) {
-		params.he_capa =
+		params.link_sta_params.he_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
-		params.he_capa_len =
+		params.link_sta_params.he_capa_len =
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 
 		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
-			params.eht_capa =
+			params.link_sta_params.eht_capa =
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-			params.eht_capa_len =
+			params.link_sta_params.eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params.he_capa,
-							(const u8 *)params.eht_capa,
-							params.eht_capa_len))
+			if (!ieee80211_eht_capa_size_ok((const u8 *)params.link_sta_params.he_capa,
+							(const u8 *)params.link_sta_params.eht_capa,
+							params.link_sta_params.eht_capa_len))
 				return -EINVAL;
 		}
 	}
 
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
-		params.he_6ghz_capa =
+		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
-		params.opmode_notif_used = true;
-		params.opmode_notif =
+		params.link_sta_params.opmode_notif_used = true;
+		params.link_sta_params.opmode_notif =
 			nla_get_u8(info->attrs[NL80211_ATTR_OPMODE_NOTIF]);
 	}
 
@@ -7092,11 +7095,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_sta_txpower_setting(info, &params.txpwr, &txpwr_set);
+	err = nl80211_parse_sta_txpower_setting(info,
+						&params.link_sta_params.txpwr,
+						&params.link_sta_params.txpwr_set);
 	if (err)
 		return err;
-	if (txpwr_set)
-		params.sta_modify_mask |= STATION_PARAM_APPLY_STA_TXPOWER;
 
 	err = nl80211_parse_sta_channel_info(info, &params);
 	if (err)
@@ -7115,17 +7118,19 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	 * error in this case.
 	 */
 	if (!(params.sta_flags_set & BIT(NL80211_STA_FLAG_WME))) {
-		params.ht_capa = NULL;
-		params.vht_capa = NULL;
+		params.link_sta_params.ht_capa = NULL;
+		params.link_sta_params.vht_capa = NULL;
 
 		/* HE and EHT require WME */
-		if (params.he_capa_len || params.he_6ghz_capa ||
-		    params.eht_capa_len)
+		if (params.link_sta_params.he_capa_len ||
+		    params.link_sta_params.he_6ghz_capa ||
+		    params.link_sta_params.eht_capa_len)
 			return -EINVAL;
 	}
 
 	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
-	if (params.he_6ghz_capa && (params.ht_capa || params.vht_capa))
+	if (params.link_sta_params.he_6ghz_capa &&
+	    (params.link_sta_params.ht_capa || params.link_sta_params.vht_capa))
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 16d0fe53fcf2..e78bffbc6f95 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -738,7 +738,7 @@ DECLARE_EVENT_CLASS(station_add_change,
 		__array(u8, vht_capa, (int)sizeof(struct ieee80211_vht_cap))
 		__array(char, vlan, IFNAMSIZ)
 		__dynamic_array(u8, supported_rates,
-				params->supported_rates_len)
+				params->link_sta_params.supported_rates_len)
 		__dynamic_array(u8, ext_capab, params->ext_capab_len)
 		__dynamic_array(u8, supported_channels,
 				params->supported_channels_len)
@@ -758,20 +758,23 @@ DECLARE_EVENT_CLASS(station_add_change,
 		__entry->plink_state = params->plink_state;
 		__entry->uapsd_queues = params->uapsd_queues;
 		memset(__entry->ht_capa, 0, sizeof(struct ieee80211_ht_cap));
-		if (params->ht_capa)
-			memcpy(__entry->ht_capa, params->ht_capa,
+		if (params->link_sta_params.ht_capa)
+			memcpy(__entry->ht_capa,
+			       params->link_sta_params.ht_capa,
 			       sizeof(struct ieee80211_ht_cap));
 		memset(__entry->vht_capa, 0, sizeof(struct ieee80211_vht_cap));
-		if (params->vht_capa)
-			memcpy(__entry->vht_capa, params->vht_capa,
+		if (params->link_sta_params.vht_capa)
+			memcpy(__entry->vht_capa,
+			       params->link_sta_params.vht_capa,
 			       sizeof(struct ieee80211_vht_cap));
 		memset(__entry->vlan, 0, sizeof(__entry->vlan));
 		if (params->vlan)
 			memcpy(__entry->vlan, params->vlan->name, IFNAMSIZ);
-		if (params->supported_rates && params->supported_rates_len)
+		if (params->link_sta_params.supported_rates &&
+		    params->link_sta_params.supported_rates_len)
 			memcpy(__get_dynamic_array(supported_rates),
-			       params->supported_rates,
-			       params->supported_rates_len);
+			       params->link_sta_params.supported_rates,
+			       params->link_sta_params.supported_rates_len);
 		if (params->ext_capab && params->ext_capab_len)
 			memcpy(__get_dynamic_array(ext_capab),
 			       params->ext_capab,
@@ -788,8 +791,9 @@ DECLARE_EVENT_CLASS(station_add_change,
 			       params->supported_oper_classes_len);
 		__entry->max_sp = params->max_sp;
 		__entry->capability = params->capability;
-		__entry->opmode_notif = params->opmode_notif;
-		__entry->opmode_notif_used = params->opmode_notif_used;
+		__entry->opmode_notif = params->link_sta_params.opmode_notif;
+		__entry->opmode_notif_used =
+			params->link_sta_params.opmode_notif_used;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
 		  ", station flags mask: %u, station flags set: %u, "
-- 
2.36.1

