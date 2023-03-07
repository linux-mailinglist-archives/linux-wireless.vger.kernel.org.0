Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1C96ADBB7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCGKWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 05:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCGKWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 05:22:37 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CE584A1
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 02:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oCrIf8Uh745ADMsCTE4EGx86u0hy3DQEM9mJ6tcV2iE=;
        t=1678184554; x=1679394154; b=pflKLYouT9hBtr5rEfWd/XwPdCliObO1BFTGVil5dDMp8ns
        2dxXsCM7vXHLEQVbatop36q0fY9zH/yfuDE2gD2FgeV3GVlBNd519HutuyO40zmgDxlYxpmNOdZZQ
        1tETQlBm50kyURU3EuTuEnGx4Ok2M9xYCJTkvIatVliEj7UfgDhaLDCdSAKWsZyCO4L4SrHdJZ3Db
        SCFJpUVC5e7cFfpNw3RsrHeEPYny++rqoGaXJhy+WNO/QE0ZBLMYq4Duas6cLsesfQ6KSk8g5ziKp
        NTE8lpcvBmrLob1A7EHAXr2osNad6M1+2eSKer18haJ4PcL7whYjrwxH1Oo2v45w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pZUSk-00EIM7-2O;
        Tue, 07 Mar 2023 11:22:30 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: [PATCH] wifi: mac80211: Add support to randomize TA of auth and deauth frames
Date:   Tue,  7 Mar 2023 11:22:25 +0100
Message-Id: <20230307102225.74883-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
References: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>

Cache the TA of the authentication and deauthentication frames
temporarily till the response waiting time offchannel period complete
and indicate the temporary address to driver when driver supports
randomizing TA of auth and deauth frames. Driver should allow TX and RX
of the frames when the temporary address is TA and RA respectively.
Allow the authentication and deauthentication frames with cached
address as RA in RX path.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Link: https://lore.kernel.org/r/20230112012415.167556-3-quic_vjakkam@quicinc.com
[simplify, fix locking]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
So this is the patch I ended up with after some cleanups, but
then at the end I noticed you didn't unset the temp address
when the remain-on-channel expires, and wasn't sure exactly
how that should be handled, and you probably have the better
test setup right now too ...

johannes
---
 include/net/mac80211.h    | 12 ++++++++++++
 net/mac80211/main.c       |  3 ++-
 net/mac80211/offchannel.c | 38 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c         | 18 ++++++++++++++----
 net/mac80211/util.c       |  7 ++++++-
 5 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f12edca660ba..d6ff3bd1dd72 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -341,6 +341,8 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
  *	status changed.
  * @BSS_CHANGED_EHT_PUNCTURING: The channel puncturing bitmap changed.
+ * @BSS_CHANGED_TEMP_ADDR: Temporary self address allowed for authentication and
+ *	deauthentication frames is changed.
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -376,6 +378,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
 	BSS_CHANGED_EHT_PUNCTURING	= BIT_ULL(32),
+	BSS_CHANGED_TEMP_ADDR		= BIT_ULL(33),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -1805,6 +1808,14 @@ enum ieee80211_offload_flags {
  *	your driver/device needs to do.
  * @ap_addr: AP MLD address, or BSSID for non-MLO connections
  *	(station mode only)
+ * @temp_addr: Temporary self address allowed for the authentication and
+ *	deauthentication frames till the response waiting time offchannel period
+ *	complete. Driver should allow TX and RX of the frames with the temporary
+ *	address as TA and RA respectively when it is non zero. This will be set
+ *	to zero address when no temporary self address is active.
+ *	Change in the value of this will be indicated with
+ *	%BSS_CHANGED_TEMP_ADDR. This will be used only when driver supports
+ *	%NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA.
  */
 struct ieee80211_vif_cfg {
 	/* association related data */
@@ -1820,6 +1831,7 @@ struct ieee80211_vif_cfg {
 	bool s1g;
 	bool idle;
 	u8 ap_addr[ETH_ALEN] __aligned(2);
+	u8 temp_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 846528850612..238cbf05d08d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -205,7 +205,8 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 				   BSS_CHANGED_PS |\
 				   BSS_CHANGED_IBSS |\
 				   BSS_CHANGED_ARP_FILTER |\
-				   BSS_CHANGED_SSID)
+				   BSS_CHANGED_SSID |\
+				   BSS_CHANGED_TEMP_ADDR)
 
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				      u64 changed)
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index d78c82d6b696..74d2b826916a 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -187,6 +187,12 @@ static void ieee80211_roc_notify_destroy(struct ieee80211_roc_work *roc)
 					 roc->mgmt_tx_cookie,
 					 roc->chan, GFP_KERNEL);
 
+	if (!is_zero_ether_addr(roc->sdata->vif.cfg.temp_addr)) {
+		eth_zero_addr(roc->sdata->vif.cfg.temp_addr);
+		ieee80211_vif_cfg_change_notify(roc->sdata,
+						BSS_CHANGED_TEMP_ADDR);
+	}
+
 	list_del(&roc->list);
 	kfree(roc);
 }
@@ -234,6 +240,36 @@ static bool ieee80211_recalc_sw_work(struct ieee80211_local *local,
 	return true;
 }
 
+static void ieee80211_config_temp_addr(struct ieee80211_sub_if_data *sdata,
+				       const struct ieee80211_hdr *hdr)
+{
+	unsigned int link;
+
+	if (!wiphy_ext_feature_isset(sdata->local->hw.wiphy,
+			NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA))
+		return;
+
+	if (ether_addr_equal(sdata->vif.cfg.temp_addr, hdr->addr2))
+		return;
+
+	rcu_read_lock();
+	for (link = 0; link < ARRAY_SIZE(sdata->vif.link_conf); link++) {
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = rcu_dereference(sdata->vif.link_conf[link]);
+		if (!link_conf)
+			continue;
+		if (ether_addr_equal(link_conf->addr, hdr->addr2)) {
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+
+	memcpy(sdata->vif.cfg.temp_addr, hdr->addr2, ETH_ALEN);
+	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_TEMP_ADDR);
+}
+
 static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 					 unsigned long start_time)
 {
@@ -245,6 +281,8 @@ static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 
 	if (roc->mgmt_tx_cookie) {
 		if (!WARN_ON(!roc->frame)) {
+			ieee80211_config_temp_addr(roc->sdata,
+						   (void *) roc->frame->data);
 			ieee80211_tx_skb_tid_band(roc->sdata, roc->frame, 7,
 						  roc->chan->band);
 			roc->frame = NULL;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0255c5745e1c..fb2c54367046 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4255,6 +4255,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
 	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
 			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool skip_addr1_check = false;
+
+	if ((ieee80211_is_auth(hdr->frame_control) ||
+	     ieee80211_is_deauth(hdr->frame_control)) &&
+	    ether_addr_equal(sdata->vif.cfg.temp_addr, hdr->addr1))
+		skip_addr1_check = true;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
@@ -4265,6 +4271,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
+		if (skip_addr1_check)
+			return true;
 		return ieee80211_is_our_addr(sdata, hdr->addr1, &rx->link_id);
 	case NL80211_IFTYPE_ADHOC:
 		if (!bssid)
@@ -4277,7 +4285,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return true;
 		if (!ieee80211_bssid_match(bssid, sdata->u.ibss.bssid))
 			return false;
-		if (!multicast &&
+		if (!multicast && !skip_addr1_check &&
 		    !ether_addr_equal(sdata->vif.addr, hdr->addr1))
 			return false;
 		if (!rx->sta) {
@@ -4297,7 +4305,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (!is_broadcast_ether_addr(bssid))
 			return false;
-		if (!multicast &&
+		if (!multicast && !skip_addr1_check &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
 		if (!rx->sta) {
@@ -4315,10 +4323,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
+		if (skip_addr1_check)
+			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_AP:
-		if (!bssid)
+		if (!bssid && !skip_addr1_check)
 			return ieee80211_is_our_addr(sdata, hdr->addr1,
 						     &rx->link_id);
 
@@ -4330,7 +4340,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			 * and location updates. Note that mac80211
 			 * itself never looks at these frames.
 			 */
-			if (!multicast &&
+			if (!multicast && !skip_addr1_check &&
 			    !ieee80211_is_our_addr(sdata, hdr->addr1,
 						   &rx->link_id))
 				return false;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1a28fe5cb614..017bfb0e5387 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2614,7 +2614,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	/* Finally also reconfigure all the BSS information */
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		unsigned int link_id;
-		u32 changed;
+		u64 changed;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
@@ -2663,6 +2663,11 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			  BSS_CHANGED_TXPOWER |
 			  BSS_CHANGED_MCAST_RATE;
 
+		if (!is_zero_ether_addr(sdata->vif.cfg.temp_addr)) {
+			eth_zero_addr(sdata->vif.cfg.temp_addr);
+			changed |= BSS_CHANGED_TEMP_ADDR;
+		}
+
 		if (sdata->vif.bss_conf.mu_mimo_owner)
 			changed |= BSS_CHANGED_MU_GROUPS;
 
-- 
2.39.2

