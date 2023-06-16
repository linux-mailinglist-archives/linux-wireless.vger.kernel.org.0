Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0363F7327F5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbjFPGyk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjFPGye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428391FF9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898472; x=1718434472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vIJaBVn4MFkx004Ie9ZB3rt4GFYUPCy4U6I+jp6O11Y=;
  b=SrYSeNpHuWq2nOUs9LNGma8D0G+1ZF28hstidEowNPIWwQPaywRjUUz4
   lwAbYPey2FC4rInYqUhk0gdLQ1j/1oGPnufl2snD+nPkCQS2mznfT8+sh
   ibJGM3AabXEQtc7feMhvJ9cswY5xT0AVdB+igUHkgF7Z5lq+7d8iQ9yEg
   +9XdhTY2CpcZXJhV9AZ+i8U8iQVs2ls8y2NxJKmmL7EkNSjd4ECjY/hkq
   XVA24cFqyP/IbLKa574QcjLXlNiD7vhLwfOzV77+9rKz5vV1ALNlmvRdL
   KyA9NmWHUYQI3I0oAPED7b8dvFgkRMALRjm2guLkTTwJlZnBZmGVkHudY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078792"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802719979"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802719979"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/20] wifi: mac80211: handle TDLS negotiation with MLO
Date:   Fri, 16 Jun 2023 09:53:51 +0300
Message-Id: <20230616094948.ce1fc230b505.Ie773c5679805001f5a52680d68d9ce0232c57648@changeid>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Userspace can now select the link to use for TDLS management
frames (indicating e.g. which BSSID should be used), use the
link_id received from cfg80211 to build the frames.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tdls.c | 147 +++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 58 deletions(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 6575b2801676..8f59f92ea9d9 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -39,9 +39,10 @@ void ieee80211_tdls_peer_del_work(struct work_struct *wk)
 	mutex_unlock(&local->mtx);
 }
 
-static void ieee80211_tdls_add_ext_capab(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_tdls_add_ext_capab(struct ieee80211_link_data *link,
 					 struct sk_buff *skb)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	bool chan_switch = local->hw.wiphy->features &
@@ -50,7 +51,7 @@ static void ieee80211_tdls_add_ext_capab(struct ieee80211_sub_if_data *sdata,
 			  !ifmgd->tdls_wider_bw_prohibited;
 	bool buffer_sta = ieee80211_hw_check(&local->hw,
 					     SUPPORTS_TDLS_BUFFER_STA);
-	struct ieee80211_supported_band *sband = ieee80211_get_sband(sdata);
+	struct ieee80211_supported_band *sband = ieee80211_get_link_sband(link);
 	bool vht = sband && sband->vht_cap.vht_supported;
 	u8 *pos = skb_put(skb, 10);
 
@@ -152,13 +153,13 @@ ieee80211_tdls_add_supp_channels(struct ieee80211_sub_if_data *sdata,
 	*pos = 2 * subband_cnt;
 }
 
-static void ieee80211_tdls_add_oper_classes(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_tdls_add_oper_classes(struct ieee80211_link_data *link,
 					    struct sk_buff *skb)
 {
 	u8 *pos;
 	u8 op_class;
 
-	if (!ieee80211_chandef_to_operating_class(&sdata->vif.bss_conf.chandef,
+	if (!ieee80211_chandef_to_operating_class(&link->conf->chandef,
 						  &op_class))
 		return;
 
@@ -180,7 +181,7 @@ static void ieee80211_tdls_add_bss_coex_ie(struct sk_buff *skb)
 	*pos++ = WLAN_BSS_COEX_INFORMATION_REQUEST;
 }
 
-static u16 ieee80211_get_tdls_sta_capab(struct ieee80211_sub_if_data *sdata,
+static u16 ieee80211_get_tdls_sta_capab(struct ieee80211_link_data *link,
 					u16 status_code)
 {
 	struct ieee80211_supported_band *sband;
@@ -189,7 +190,8 @@ static u16 ieee80211_get_tdls_sta_capab(struct ieee80211_sub_if_data *sdata,
 	if (status_code != 0)
 		return 0;
 
-	sband = ieee80211_get_sband(sdata);
+	sband = ieee80211_get_link_sband(link);
+
 	if (sband && sband->band == NL80211_BAND_2GHZ) {
 		return WLAN_CAPABILITY_SHORT_SLOT_TIME |
 		       WLAN_CAPABILITY_SHORT_PREAMBLE;
@@ -198,10 +200,11 @@ static u16 ieee80211_get_tdls_sta_capab(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static void ieee80211_tdls_add_link_ie(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_tdls_add_link_ie(struct ieee80211_link_data *link,
 				       struct sk_buff *skb, const u8 *peer,
 				       bool initiator)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_tdls_lnkie *lnkid;
 	const u8 *init_addr, *rsp_addr;
 
@@ -218,7 +221,7 @@ static void ieee80211_tdls_add_link_ie(struct ieee80211_sub_if_data *sdata,
 	lnkid->ie_type = WLAN_EID_LINK_ID;
 	lnkid->ie_len = sizeof(struct ieee80211_tdls_lnkie) - 2;
 
-	memcpy(lnkid->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	memcpy(lnkid->bssid, link->u.mgd.bssid, ETH_ALEN);
 	memcpy(lnkid->init_sta, init_addr, ETH_ALEN);
 	memcpy(lnkid->resp_sta, rsp_addr, ETH_ALEN);
 }
@@ -359,11 +362,12 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 }
 
 static void
-ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
+ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 				   struct sk_buff *skb, const u8 *peer,
 				   u8 action_code, bool initiator,
 				   const u8 *extra_ies, size_t extra_ies_len)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sta_ht_cap ht_cap;
@@ -372,8 +376,8 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 	size_t offset = 0, noffset;
 	u8 *pos;
 
-	sband = ieee80211_get_sband(sdata);
-	if (!sband)
+	sband = ieee80211_get_link_sband(link);
+	if (WARN_ON_ONCE(!sband))
 		return;
 
 	ieee80211_add_srates_ie(sdata, skb, false, sband->band);
@@ -397,7 +401,7 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 		offset = noffset;
 	}
 
-	ieee80211_tdls_add_ext_capab(sdata, skb);
+	ieee80211_tdls_add_ext_capab(link, skb);
 
 	/* add the QoS element if we support it */
 	if (local->hw.queues >= IEEE80211_NUM_ACS &&
@@ -436,10 +440,10 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 			return;
 		}
 
-		sta->tdls_chandef = sdata->vif.bss_conf.chandef;
+		sta->tdls_chandef = link->conf->chandef;
 	}
 
-	ieee80211_tdls_add_oper_classes(sdata, skb);
+	ieee80211_tdls_add_oper_classes(link, skb);
 
 	/*
 	 * with TDLS we can switch channels, and HT-caps are not necessarily
@@ -472,7 +476,7 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 	    (ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 		ieee80211_tdls_add_bss_coex_ie(skb);
 
-	ieee80211_tdls_add_link_ie(sdata, skb, peer, initiator);
+	ieee80211_tdls_add_link_ie(link, skb, peer, initiator);
 
 	/* add any custom IEs that go before VHT capabilities */
 	if (extra_ies_len) {
@@ -540,31 +544,33 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 }
 
 static void
-ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
+ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_link_data *link,
 				 struct sk_buff *skb, const u8 *peer,
 				 bool initiator, const u8 *extra_ies,
 				 size_t extra_ies_len)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	size_t offset = 0, noffset;
 	struct sta_info *sta, *ap_sta;
 	struct ieee80211_supported_band *sband;
 	u8 *pos;
 
-	sband = ieee80211_get_sband(sdata);
-	if (!sband)
+	sband = ieee80211_get_link_sband(link);
+	if (WARN_ON_ONCE(!sband))
 		return;
 
 	mutex_lock(&local->sta_mtx);
 
 	sta = sta_info_get(sdata, peer);
-	ap_sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
+	ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+
 	if (WARN_ON_ONCE(!sta || !ap_sta)) {
 		mutex_unlock(&local->sta_mtx);
 		return;
 	}
 
-	sta->tdls_chandef = sdata->vif.bss_conf.chandef;
+	sta->tdls_chandef = link->conf->chandef;
 
 	/* add any custom IEs that go before the QoS IE */
 	if (extra_ies_len) {
@@ -610,11 +616,11 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 
 		pos = skb_put(skb, 2 + sizeof(struct ieee80211_ht_operation));
 		ieee80211_ie_build_ht_oper(pos, &sta->sta.deflink.ht_cap,
-					   &sdata->vif.bss_conf.chandef, prot,
+					   &link->conf->chandef, prot,
 					   true);
 	}
 
-	ieee80211_tdls_add_link_ie(sdata, skb, peer, initiator);
+	ieee80211_tdls_add_link_ie(link, skb, peer, initiator);
 
 	/* only include VHT-operation if not on the 2.4GHz band */
 	if (sband->band != NL80211_BAND_2GHZ &&
@@ -641,7 +647,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 }
 
 static void
-ieee80211_tdls_add_chan_switch_req_ies(struct ieee80211_sub_if_data *sdata,
+ieee80211_tdls_add_chan_switch_req_ies(struct ieee80211_link_data *link,
 				       struct sk_buff *skb, const u8 *peer,
 				       bool initiator, const u8 *extra_ies,
 				       size_t extra_ies_len, u8 oper_class,
@@ -670,7 +676,7 @@ ieee80211_tdls_add_chan_switch_req_ies(struct ieee80211_sub_if_data *sdata,
 		offset = noffset;
 	}
 
-	ieee80211_tdls_add_link_ie(sdata, skb, peer, initiator);
+	ieee80211_tdls_add_link_ie(link, skb, peer, initiator);
 
 	/* add any remaining IEs */
 	if (extra_ies_len) {
@@ -680,20 +686,20 @@ ieee80211_tdls_add_chan_switch_req_ies(struct ieee80211_sub_if_data *sdata,
 }
 
 static void
-ieee80211_tdls_add_chan_switch_resp_ies(struct ieee80211_sub_if_data *sdata,
+ieee80211_tdls_add_chan_switch_resp_ies(struct ieee80211_link_data *link,
 					struct sk_buff *skb, const u8 *peer,
 					u16 status_code, bool initiator,
 					const u8 *extra_ies,
 					size_t extra_ies_len)
 {
 	if (status_code == 0)
-		ieee80211_tdls_add_link_ie(sdata, skb, peer, initiator);
+		ieee80211_tdls_add_link_ie(link, skb, peer, initiator);
 
 	if (extra_ies_len)
 		skb_put_data(skb, extra_ies, extra_ies_len);
 }
 
-static void ieee80211_tdls_add_ies(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_tdls_add_ies(struct ieee80211_link_data *link,
 				   struct sk_buff *skb, const u8 *peer,
 				   u8 action_code, u16 status_code,
 				   bool initiator, const u8 *extra_ies,
@@ -705,7 +711,8 @@ static void ieee80211_tdls_add_ies(struct ieee80211_sub_if_data *sdata,
 	case WLAN_TDLS_SETUP_RESPONSE:
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
 		if (status_code == 0)
-			ieee80211_tdls_add_setup_start_ies(sdata, skb, peer,
+			ieee80211_tdls_add_setup_start_ies(link,
+							   skb, peer,
 							   action_code,
 							   initiator,
 							   extra_ies,
@@ -713,7 +720,7 @@ static void ieee80211_tdls_add_ies(struct ieee80211_sub_if_data *sdata,
 		break;
 	case WLAN_TDLS_SETUP_CONFIRM:
 		if (status_code == 0)
-			ieee80211_tdls_add_setup_cfm_ies(sdata, skb, peer,
+			ieee80211_tdls_add_setup_cfm_ies(link, skb, peer,
 							 initiator, extra_ies,
 							 extra_ies_len);
 		break;
@@ -722,16 +729,17 @@ static void ieee80211_tdls_add_ies(struct ieee80211_sub_if_data *sdata,
 		if (extra_ies_len)
 			skb_put_data(skb, extra_ies, extra_ies_len);
 		if (status_code == 0 || action_code == WLAN_TDLS_TEARDOWN)
-			ieee80211_tdls_add_link_ie(sdata, skb, peer, initiator);
+			ieee80211_tdls_add_link_ie(link, skb,
+						   peer, initiator);
 		break;
 	case WLAN_TDLS_CHANNEL_SWITCH_REQUEST:
-		ieee80211_tdls_add_chan_switch_req_ies(sdata, skb, peer,
+		ieee80211_tdls_add_chan_switch_req_ies(link, skb, peer,
 						       initiator, extra_ies,
 						       extra_ies_len,
 						       oper_class, chandef);
 		break;
 	case WLAN_TDLS_CHANNEL_SWITCH_RESPONSE:
-		ieee80211_tdls_add_chan_switch_resp_ies(sdata, skb, peer,
+		ieee80211_tdls_add_chan_switch_resp_ies(link, skb, peer,
 							status_code,
 							initiator, extra_ies,
 							extra_ies_len);
@@ -742,6 +750,7 @@ static void ieee80211_tdls_add_ies(struct ieee80211_sub_if_data *sdata,
 
 static int
 ieee80211_prep_tdls_encap_data(struct wiphy *wiphy, struct net_device *dev,
+			       struct ieee80211_link_data *link,
 			       const u8 *peer, u8 action_code, u8 dialog_token,
 			       u16 status_code, struct sk_buff *skb)
 {
@@ -766,7 +775,7 @@ ieee80211_prep_tdls_encap_data(struct wiphy *wiphy, struct net_device *dev,
 		skb_put(skb, sizeof(tf->u.setup_req));
 		tf->u.setup_req.dialog_token = dialog_token;
 		tf->u.setup_req.capability =
-			cpu_to_le16(ieee80211_get_tdls_sta_capab(sdata,
+			cpu_to_le16(ieee80211_get_tdls_sta_capab(link,
 								 status_code));
 		break;
 	case WLAN_TDLS_SETUP_RESPONSE:
@@ -777,7 +786,7 @@ ieee80211_prep_tdls_encap_data(struct wiphy *wiphy, struct net_device *dev,
 		tf->u.setup_resp.status_code = cpu_to_le16(status_code);
 		tf->u.setup_resp.dialog_token = dialog_token;
 		tf->u.setup_resp.capability =
-			cpu_to_le16(ieee80211_get_tdls_sta_capab(sdata,
+			cpu_to_le16(ieee80211_get_tdls_sta_capab(link,
 								 status_code));
 		break;
 	case WLAN_TDLS_SETUP_CONFIRM:
@@ -824,7 +833,8 @@ ieee80211_prep_tdls_encap_data(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 ieee80211_prep_tdls_direct(struct wiphy *wiphy, struct net_device *dev,
-			   const u8 *peer, u8 action_code, u8 dialog_token,
+			   const u8 *peer, struct ieee80211_link_data *link,
+			   u8 action_code, u8 dialog_token,
 			   u16 status_code, struct sk_buff *skb)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
@@ -833,8 +843,7 @@ ieee80211_prep_tdls_direct(struct wiphy *wiphy, struct net_device *dev,
 	mgmt = skb_put_zero(skb, 24);
 	memcpy(mgmt->da, peer, ETH_ALEN);
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
-
+	memcpy(mgmt->bssid, link->u.mgd.bssid, ETH_ALEN);
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 
@@ -847,7 +856,7 @@ ieee80211_prep_tdls_direct(struct wiphy *wiphy, struct net_device *dev,
 		mgmt->u.action.u.tdls_discover_resp.dialog_token =
 			dialog_token;
 		mgmt->u.action.u.tdls_discover_resp.capability =
-			cpu_to_le16(ieee80211_get_tdls_sta_capab(sdata,
+			cpu_to_le16(ieee80211_get_tdls_sta_capab(link,
 								 status_code));
 		break;
 	default:
@@ -859,15 +868,23 @@ ieee80211_prep_tdls_direct(struct wiphy *wiphy, struct net_device *dev,
 
 static struct sk_buff *
 ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
-				      const u8 *peer, u8 action_code,
-				      u8 dialog_token, u16 status_code,
-				      bool initiator, const u8 *extra_ies,
-				      size_t extra_ies_len, u8 oper_class,
+				      const u8 *peer, int link_id,
+				      u8 action_code, u8 dialog_token,
+				      u16 status_code, bool initiator,
+				      const u8 *extra_ies, size_t extra_ies_len,
+				      u8 oper_class,
 				      struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	int ret;
+	struct ieee80211_link_data *link;
+
+	link_id = link_id >= 0 ? link_id : 0;
+	rcu_read_lock();
+	link = rcu_dereference(sdata->link[link_id]);
+	if (WARN_ON(!link))
+		goto unlock;
 
 	skb = netdev_alloc_skb(sdata->dev,
 			       local->hw.extra_tx_headroom +
@@ -887,7 +904,7 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 			       extra_ies_len +
 			       sizeof(struct ieee80211_tdls_lnkie));
 	if (!skb)
-		return NULL;
+		goto unlock;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 
@@ -900,13 +917,13 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 	case WLAN_TDLS_CHANNEL_SWITCH_REQUEST:
 	case WLAN_TDLS_CHANNEL_SWITCH_RESPONSE:
 		ret = ieee80211_prep_tdls_encap_data(local->hw.wiphy,
-						     sdata->dev, peer,
+						     sdata->dev, link, peer,
 						     action_code, dialog_token,
 						     status_code, skb);
 		break;
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
 		ret = ieee80211_prep_tdls_direct(local->hw.wiphy, sdata->dev,
-						 peer, action_code,
+						 peer, link, action_code,
 						 dialog_token, status_code,
 						 skb);
 		break;
@@ -918,19 +935,23 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 	if (ret < 0)
 		goto fail;
 
-	ieee80211_tdls_add_ies(sdata, skb, peer, action_code, status_code,
+	ieee80211_tdls_add_ies(link, skb, peer, action_code, status_code,
 			       initiator, extra_ies, extra_ies_len, oper_class,
 			       chandef);
+	rcu_read_unlock();
 	return skb;
 
 fail:
 	dev_kfree_skb(skb);
+unlock:
+	rcu_read_unlock();
 	return NULL;
 }
 
 static int
 ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
-				const u8 *peer, u8 action_code, u8 dialog_token,
+				const u8 *peer, int link_id,
+				u8 action_code, u8 dialog_token,
 				u16 status_code, u32 peer_capability,
 				bool initiator, const u8 *extra_ies,
 				size_t extra_ies_len, u8 oper_class,
@@ -988,7 +1009,8 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 	if (ret < 0)
 		goto fail;
 
-	skb = ieee80211_tdls_build_mgmt_packet_data(sdata, peer, action_code,
+	skb = ieee80211_tdls_build_mgmt_packet_data(sdata, peer,
+						    link_id, action_code,
 						    dialog_token, status_code,
 						    initiator, extra_ies,
 						    extra_ies_len, oper_class,
@@ -999,7 +1021,7 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
-		ieee80211_tx_skb(sdata, skb);
+		ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
 		return 0;
 	}
 
@@ -1066,7 +1088,8 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
-			  const u8 *peer, u8 action_code, u8 dialog_token,
+			  const u8 *peer, int link_id,
+			  u8 action_code, u8 dialog_token,
 			  u16 status_code, u32 peer_capability, bool initiator,
 			  const u8 *extra_ies, size_t extra_ies_len)
 {
@@ -1115,7 +1138,8 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 	mutex_unlock(&local->mtx);
 
 	/* we cannot take the mutex while preparing the setup packet */
-	ret = ieee80211_tdls_prep_mgmt_packet(wiphy, dev, peer, action_code,
+	ret = ieee80211_tdls_prep_mgmt_packet(wiphy, dev, peer,
+					      link_id, action_code,
 					      dialog_token, status_code,
 					      peer_capability, initiator,
 					      extra_ies, extra_ies_len, 0,
@@ -1139,7 +1163,8 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 ieee80211_tdls_mgmt_teardown(struct wiphy *wiphy, struct net_device *dev,
-			     const u8 *peer, u8 action_code, u8 dialog_token,
+			     const u8 *peer, int link_id,
+			     u8 action_code, u8 dialog_token,
 			     u16 status_code, u32 peer_capability,
 			     bool initiator, const u8 *extra_ies,
 			     size_t extra_ies_len)
@@ -1159,7 +1184,8 @@ ieee80211_tdls_mgmt_teardown(struct wiphy *wiphy, struct net_device *dev,
 				  IEEE80211_QUEUE_STOP_REASON_TDLS_TEARDOWN);
 	ieee80211_flush_queues(local, sdata, false);
 
-	ret = ieee80211_tdls_prep_mgmt_packet(wiphy, dev, peer, action_code,
+	ret = ieee80211_tdls_prep_mgmt_packet(wiphy, dev, peer,
+					      link_id, action_code,
 					      dialog_token, status_code,
 					      peer_capability, initiator,
 					      extra_ies, extra_ies_len, 0,
@@ -1204,13 +1230,14 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	switch (action_code) {
 	case WLAN_TDLS_SETUP_REQUEST:
 	case WLAN_TDLS_SETUP_RESPONSE:
-		ret = ieee80211_tdls_mgmt_setup(wiphy, dev, peer, action_code,
+		ret = ieee80211_tdls_mgmt_setup(wiphy, dev, peer,
+						link_id, action_code,
 						dialog_token, status_code,
 						peer_capability, initiator,
 						extra_ies, extra_ies_len);
 		break;
 	case WLAN_TDLS_TEARDOWN:
-		ret = ieee80211_tdls_mgmt_teardown(wiphy, dev, peer,
+		ret = ieee80211_tdls_mgmt_teardown(wiphy, dev, peer, link_id,
 						   action_code, dialog_token,
 						   status_code,
 						   peer_capability, initiator,
@@ -1228,7 +1255,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
 		/* no special handling */
 		ret = ieee80211_tdls_prep_mgmt_packet(wiphy, dev, peer,
-						      action_code,
+						      link_id, action_code,
 						      dialog_token,
 						      status_code,
 						      peer_capability,
@@ -1240,8 +1267,8 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 		break;
 	}
 
-	tdls_dbg(sdata, "TDLS mgmt action %d peer %pM status %d\n",
-		 action_code, peer, ret);
+	tdls_dbg(sdata, "TDLS mgmt action %d peer %pM link_id %d status %d\n",
+		 action_code, peer, link_id, ret);
 	return ret;
 }
 
@@ -1497,6 +1524,7 @@ ieee80211_tdls_ch_sw_tmpl_get(struct sta_info *sta, u8 oper_class,
 	int extra_ies_len = 2 + sizeof(struct ieee80211_ch_switch_timing);
 	u8 *pos = extra_ies;
 	struct sk_buff *skb;
+	int link_id = sta->sta.valid_links ? ffs(sta->sta.valid_links) - 1 : 0;
 
 	/*
 	 * if chandef points to a wide channel add a Secondary-Channel
@@ -1524,6 +1552,7 @@ ieee80211_tdls_ch_sw_tmpl_get(struct sta_info *sta, u8 oper_class,
 	iee80211_tdls_add_ch_switch_timing(pos, 0, 0);
 
 	skb = ieee80211_tdls_build_mgmt_packet_data(sdata, sta->sta.addr,
+					      link_id,
 					      WLAN_TDLS_CHANNEL_SWITCH_REQUEST,
 					      0, 0, !sta->sta.tdls_initiator,
 					      extra_ies, extra_ies_len,
@@ -1644,11 +1673,13 @@ ieee80211_tdls_ch_sw_resp_tmpl_get(struct sta_info *sta,
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct sk_buff *skb;
 	u8 extra_ies[2 + sizeof(struct ieee80211_ch_switch_timing)];
+	int link_id = sta->sta.valid_links ? ffs(sta->sta.valid_links) - 1 : 0;
 
 	/* initial timing are always zero in the template */
 	iee80211_tdls_add_ch_switch_timing(extra_ies, 0, 0);
 
 	skb = ieee80211_tdls_build_mgmt_packet_data(sdata, sta->sta.addr,
+					link_id,
 					WLAN_TDLS_CHANNEL_SWITCH_RESPONSE,
 					0, 0, !sta->sta.tdls_initiator,
 					extra_ies, sizeof(extra_ies), 0, NULL);
-- 
2.38.1

