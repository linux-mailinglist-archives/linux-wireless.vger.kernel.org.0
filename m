Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF654526327
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiEMNux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382452AbiEMNsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 09:48:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72C4BFEE
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5xBuWRW3Lkv/UrR2KPYisX5AO4bb8LQj6Pm9VFPrsDI=;
        t=1652449697; x=1653659297; b=Yl0VdiamYybY5LoaYKl+Up94x6iY1oxPvRYUICXy4mO7MYc
        4rptPpK67OlibHtnF8ov48G3umRcOAQL5uE8zQcddvGrMANzyRXLmtNh2yuSGfbxxMzfpdDSfj0SN
        41quldSrccmFdK6WCKxBIC7PSvw1d4obnsFphQPVaVzxqhRt2bfX+UUv0mnrcWQAU7sjVH1PYTcHa
        NMxe2bNKV1+qGfDiluyyR5I65y7J/Dgf4MZhmoBuxYgDA/OETJJG4H8ZgmMaUGCGoZYgdEDtwO+zv
        L0ShpUoxDvtOmcpToO2GcOej0Pgxd1IFjQiEXdaRiV29FpWaMB5BxT3pdi7dax1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1npVeQ-00Abtz-9M;
        Fri, 13 May 2022 15:48:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] mac80211: use ifmgd->bssid instead of ifmgd->associated->bssid
Date:   Fri, 13 May 2022 15:48:05 +0200
Message-Id: <20220513154805.6d84f3407fce.Ic51ef93a9fc004b137f2cae4935bb9da4a17db18@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220513154805.23c69eb5e00a.I9f843f8106faa8572380bcf3954cf26ce9e592d3@changeid>
References: <20220513154805.23c69eb5e00a.I9f843f8106faa8572380bcf3954cf26ce9e592d3@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Since we always track the BSSID there when we get associated,
these are equivalent, but ifmgd->bssid saves a dereference and
thus makes the code a bit smaller, and more readable.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c            |  2 +-
 net/mac80211/debugfs_netdev.c |  2 +-
 net/mac80211/main.c           |  2 +-
 net/mac80211/mlme.c           | 34 +++++++++++++++++-----------------
 net/mac80211/offchannel.c     |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f1d211e61e49..f817cf763069 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2928,7 +2928,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
-	ap = sdata->u.mgd.associated->bssid;
+	ap = sdata->u.mgd.bssid;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index e490c3da3aca..cf71484658c6 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -337,7 +337,7 @@ static ssize_t ieee80211_if_parse_tkip_mic_test(
 			dev_kfree_skb(skb);
 			return -ENOTCONN;
 		}
-		memcpy(hdr->addr1, sdata->u.mgd.associated->bssid, ETH_ALEN);
+		memcpy(hdr->addr1, sdata->u.mgd.bssid, ETH_ALEN);
 		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 		memcpy(hdr->addr3, addr, ETH_ALEN);
 		sdata_unlock(sdata);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a48a32f87897..03f772c4ee42 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -287,7 +287,7 @@ static void ieee80211_restart_work(struct work_struct *work)
 			if (sdata->vif.csa_active) {
 				sdata_lock(sdata);
 				ieee80211_sta_connection_lost(sdata,
-							      sdata->u.mgd.associated->bssid,
+							      sdata->u.mgd.bssid,
 							      WLAN_REASON_UNSPECIFIED, false);
 				sdata_unlock(sdata);
 			}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c32cfb5de5d8..1bf6efe86c02 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1398,7 +1398,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
 					   bss->vht_cap_info,
 					   ifmgd->flags,
-					   ifmgd->associated->bssid, &csa_ie);
+					   ifmgd->bssid, &csa_ie);
 
 	if (!res) {
 		ch_switch.timestamp = timestamp;
@@ -1427,7 +1427,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	    csa_ie.chandef.chan->band) {
 		sdata_info(sdata,
 			   "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
-			   ifmgd->associated->bssid,
+			   ifmgd->bssid,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
 			   csa_ie.chandef.center_freq2);
@@ -1440,7 +1440,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 			   "AP %pM switches to unsupported channel "
 			   "(%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), "
 			   "disconnecting\n",
-			   ifmgd->associated->bssid,
+			   ifmgd->bssid,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.chan->freq_offset,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
@@ -1456,7 +1456,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 			return;
 		sdata_info(sdata,
 			   "AP %pM tries to chanswitch to same channel, ignore\n",
-			   ifmgd->associated->bssid);
+			   ifmgd->bssid);
 		ifmgd->csa_ignored_same_chan = true;
 		return;
 	}
@@ -2609,7 +2609,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	const struct element *ssid;
-	u8 *dst = ifmgd->associated->bssid;
+	u8 *dst = ifmgd->bssid;
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
 
@@ -3219,8 +3219,8 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(mgmt->bssid, ifmgd->associated->bssid)) {
-		const u8 *bssid = ifmgd->associated->bssid;
+	    ether_addr_equal(mgmt->bssid, ifmgd->bssid)) {
+		const u8 *bssid = ifmgd->bssid;
 
 		sdata_info(sdata, "deauthenticated from %pM (Reason: %u=%s)\n",
 			   bssid, reason_code,
@@ -3262,7 +3262,7 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (!ifmgd->associated ||
-	    !ether_addr_equal(mgmt->bssid, ifmgd->associated->bssid))
+	    !ether_addr_equal(mgmt->bssid, ifmgd->bssid))
 		return;
 
 	reason_code = le16_to_cpu(mgmt->u.disassoc.reason_code);
@@ -3966,7 +3966,7 @@ static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_sub_if_data *sdata,
 	ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(mgmt->bssid, ifmgd->associated->bssid))
+	    ether_addr_equal(mgmt->bssid, ifmgd->bssid))
 		ieee80211_reset_ap_probe(sdata);
 }
 
@@ -4197,7 +4197,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	if (!ifmgd->associated ||
 	    !ieee80211_rx_our_beacon(bssid,  ifmgd->associated))
 		return;
-	bssid = ifmgd->associated->bssid;
+	bssid = ifmgd->bssid;
 
 	if (!(rx_status->flag & RX_FLAG_NO_SIGNAL_VAL))
 		ieee80211_handle_beacon_sig(sdata, ifmgd, bss_conf,
@@ -4747,7 +4747,7 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 		u8 bssid[ETH_ALEN];
 		int max_tries;
 
-		memcpy(bssid, ifmgd->associated->bssid, ETH_ALEN);
+		memcpy(bssid, ifmgd->bssid, ETH_ALEN);
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 			max_tries = max_nullfunc_tries;
@@ -4928,7 +4928,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 			.bssid = bssid,
 		};
 
-		memcpy(bssid, ifmgd->associated->bssid, ETH_ALEN);
+		memcpy(bssid, ifmgd->bssid, ETH_ALEN);
 		ieee80211_mgd_deauth(sdata, &req);
 	}
 
@@ -4950,7 +4950,7 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_RESUME;
 		mlme_dbg(sdata, "driver requested disconnect after resume\n");
 		ieee80211_sta_connection_lost(sdata,
-					      ifmgd->associated->bssid,
+					      ifmgd->bssid,
 					      WLAN_REASON_UNSPECIFIED,
 					      true);
 		sdata_unlock(sdata);
@@ -4961,7 +4961,7 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_HW_RESTART;
 		mlme_dbg(sdata, "driver requested disconnect after hardware restart\n");
 		ieee80211_sta_connection_lost(sdata,
-					      ifmgd->associated->bssid,
+					      ifmgd->bssid,
 					      WLAN_REASON_UNSPECIFIED,
 					      true);
 		sdata_unlock(sdata);
@@ -5836,7 +5836,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new auth to %pM\n",
-			   ifmgd->associated->bssid, req->bss->bssid);
+			   ifmgd->bssid, req->bss->bssid);
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_UNSPECIFIED,
 				       false, frame_buf);
@@ -5912,7 +5912,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new assoc to %pM\n",
-			   ifmgd->associated->bssid, req->bss->bssid);
+			   ifmgd->bssid, req->bss->bssid);
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_UNSPECIFIED,
 				       false, frame_buf);
@@ -6270,7 +6270,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(ifmgd->associated->bssid, req->bssid)) {
+	    ether_addr_equal(ifmgd->bssid, req->bssid)) {
 		sdata_info(sdata,
 			   "deauthenticating from %pM by local choice (Reason: %u=%s)\n",
 			   req->bssid, req->reason_code,
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 853c9a369d72..c5d2ab9df1e7 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -819,7 +819,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		if (!sdata->u.mgd.associated ||
 		    (params->offchan && params->wait &&
 		     local->ops->remain_on_channel &&
-		     memcmp(sdata->u.mgd.associated->bssid,
+		     memcmp(sdata->u.mgd.bssid,
 			    mgmt->bssid, ETH_ALEN)))
 			need_offchan = true;
 		sdata_unlock(sdata);
-- 
2.35.3

