Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE41573342
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiGMJpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiGMJpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A501EE1F8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GdMJ2ZpKlgqfBEKvG04CNVwoULEfWzXovfw7N24GYM0=;
        t=1657705515; x=1658915115; b=THQIVQXWXtqqwf//e2sRBg25nIxK+NRSpaFJB76yVaIeQN1
        0Q1WFL7pT/kKxBb8ROMSTBOhkNE0YJVrZekWByqLiDGAqk/CveAVrNi6cDGNMBzfymp6CY7ueE/6d
        ljvPxoApB7MyB3/ND8+K/b0mewJpqLsPCK5U/4gCu7Tvbh/ef7n4reSxlpGcNi6Cw422Bl5dmiFbJ
        ztlblrBDCw5KBDFx1G67Oy2Cpf0SJQIjA+JhlSuMU3bPjgBjPngm5h8p6s6OGXrxrdrxTdMk7VNwU
        IUyHLvNHhkqvqcavk3x2X63RR7TNOiQHiNkEQiYOzSHLriC8WUmhjB4s2SqgZxSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvh-00EgvB-IP;
        Wed, 13 Jul 2022 11:45:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 31/76] wifi: mac80211: mlme: track AP (MLD) address separately
Date:   Wed, 13 Jul 2022 11:44:17 +0200
Message-Id: <20220713114425.f72d3661ee99.Ib8ef2a3152813334e166b8e4ca4bc71a9b5254f3@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

To prepare a bit more for MLO in the client code,
track the AP's address (for now only the BSSID, but
will track the AP MLD's address later) separately
from the per-link BSSID.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  3 +++
 net/mac80211/mlme.c    | 30 ++++++++++++++++--------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c4ed5afba380..398da2336707 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1728,6 +1728,8 @@ enum ieee80211_offload_flags {
  * @idle: This interface is idle. There's also a global idle flag in the
  *	hardware config which may be more appropriate depending on what
  *	your driver/device needs to do.
+ * @ap_addr: AP MLD address, or BSSID for non-MLO connections
+ *	(station mode only)
  */
 struct ieee80211_vif_cfg {
 	/* association related data */
@@ -1742,6 +1744,7 @@ struct ieee80211_vif_cfg {
 	size_t ssid_len;
 	bool s1g;
 	bool idle;
+	u8 ap_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bfb29d09bd1d..52dc336cadfa 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1807,7 +1807,7 @@ static bool ieee80211_powersave_allowed(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	rcu_read_lock();
-	sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	if (sta)
 		authorized = test_sta_flag(sta, WLAN_STA_AUTHORIZED);
 	rcu_read_unlock();
@@ -2312,6 +2312,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	sdata->u.mgd.associated = true;
 	sdata->deflink.u.mgd.bss = cbss;
 	memcpy(sdata->deflink.u.mgd.bssid, cbss->bssid, ETH_ALEN);
+	memcpy(sdata->vif.cfg.ap_addr, cbss->bssid, ETH_ALEN);
 
 	ieee80211_check_rate_mask(sdata);
 
@@ -2462,6 +2463,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	/* clear bssid only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
 
+	eth_zero_addr(sdata->vif.cfg.ap_addr);
 	sdata->vif.cfg.ssid_len = 0;
 
 	/* remove AP and TDLS peers */
@@ -2652,7 +2654,7 @@ static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u8 *dst = sdata->deflink.u.mgd.bssid;
+	u8 *dst = sdata->vif.cfg.ap_addr;
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
 
@@ -2881,13 +2883,13 @@ static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
 
 	if (ifmgd->connection_loss) {
 		sdata_info(sdata, "Connection to AP %pM lost\n",
-			   sdata->deflink.u.mgd.bssid);
+			   sdata->vif.cfg.ap_addr);
 		__ieee80211_disconnect(sdata);
 		ifmgd->connection_loss = false;
 	} else if (ifmgd->driver_disconnect) {
 		sdata_info(sdata,
 			   "Driver requested disconnection from AP %pM\n",
-			   sdata->deflink.u.mgd.bssid);
+			   sdata->vif.cfg.ap_addr);
 		__ieee80211_disconnect(sdata);
 		ifmgd->driver_disconnect = false;
 	} else {
@@ -3041,7 +3043,7 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 }
 
 static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata,
-				    const u8 *bssid)
+				    const u8 *ap_addr)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct sta_info *sta;
@@ -3055,14 +3057,14 @@ static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata,
 
 	/* move station state to auth */
 	mutex_lock(&sdata->local->sta_mtx);
-	sta = sta_info_get(sdata, bssid);
+	sta = sta_info_get(sdata, ap_addr);
 	if (!sta) {
-		WARN_ONCE(1, "%s: STA %pM not found", sdata->name, bssid);
+		WARN_ONCE(1, "%s: STA %pM not found", sdata->name, ap_addr);
 		result = false;
 		goto out;
 	}
 	if (sta_info_move_state(sta, IEEE80211_STA_AUTH)) {
-		sdata_info(sdata, "failed moving %pM to auth\n", bssid);
+		sdata_info(sdata, "failed moving %pM to auth\n", ap_addr);
 		result = false;
 		goto out;
 	}
@@ -4401,7 +4403,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 				erp_valid, erp_value);
 
 	mutex_lock(&local->sta_mtx);
-	sta = sta_info_get(sdata, bssid);
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 
 	changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
 
@@ -4884,7 +4886,7 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	    !sdata->deflink.u.mgd.csa_waiting_bcn)
 		return;
 
-	sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	if (!sta)
 		return;
 
@@ -4980,7 +4982,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 			.bssid = bssid,
 		};
 
-		memcpy(bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+		memcpy(bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 		ieee80211_mgd_deauth(sdata, &req);
 	}
 
@@ -5908,7 +5910,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new auth to %pM\n",
-			   sdata->deflink.u.mgd.bssid, req->bss->bssid);
+			   sdata->vif.cfg.ap_addr, req->bss->bssid);
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_UNSPECIFIED,
 				       false, frame_buf);
@@ -5985,7 +5987,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new assoc to %pM\n",
-			   sdata->deflink.u.mgd.bssid, req->bss->bssid);
+			   sdata->vif.cfg.ap_addr, req->bss->bssid);
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_UNSPECIFIED,
 				       false, frame_buf);
@@ -6343,7 +6345,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(sdata->deflink.u.mgd.bssid, req->bssid)) {
+	    ether_addr_equal(sdata->vif.cfg.ap_addr, req->bssid)) {
 		sdata_info(sdata,
 			   "deauthenticating from %pM by local choice (Reason: %u=%s)\n",
 			   req->bssid, req->reason_code,
-- 
2.36.1

