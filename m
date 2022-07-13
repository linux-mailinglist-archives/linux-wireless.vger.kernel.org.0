Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47809573A45
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiGMPez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF764C638
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NDVuU4hUY8s4cKu/LRQDiVWaVDRW97RVN78U/lr/wIk=;
        t=1657726483; x=1658936083; b=JC5VNMHHDqnweiI+rMDohxK3iTP0Zsm1cqMbygU4+PMpKu+
        w3Z5eeMJI+gSrYB1NmxPdgPshFeRqKZ1JSBjWgVNHZ0twGIchS8xC5GBnILkiYIWwfrOUYG6zvxym
        xsQvfPDuHQgDC1wGPXuCJ9a+CKU7BoonG+WE9YMrEsfKP0XAyAdOEJiUwfkT0TULELwwKXuVYyqY6
        c5LLHoCU4cnbQcPztEcmUaBMpdvWyuB3kuuQyb+tjnLIHsKVgfH6oAXekAzqVmUNz5L4tdwIKv15n
        JmmHY/+Ryc1v2cNCFUgzErAG5H7xZDNlsBT1ELiSN6w8utmwr5T7KBLVGP4HFzJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNs-00EnaA-GF;
        Wed, 13 Jul 2022 17:34:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/21] wifi: mac80211: mlme: switch some things back to deflink
Date:   Wed, 13 Jul 2022 17:34:25 +0200
Message-Id: <20220713173301.2941d7b03f50.I1da3e7cbc88305d2c2c89bd3e345d7f6b73a1ea7@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

With MLO, when we'll disconnect from an AP MLD, we'll just
destroy all the links. Therefore, the only thing we (may)
need to reset is the deflink data, so switch back to that
and adjust the comments accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 03f6da885ce4..999eead2129e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2437,7 +2437,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	struct ieee80211_link_data *link = &sdata->deflink;
 	u32 changed = 0;
 	struct ieee80211_prep_tx_info info = {
@@ -2455,7 +2454,10 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	ieee80211_stop_poll(sdata);
 
 	ifmgd->associated = false;
-	link->u.mgd.bss = NULL;
+
+	/* other links will be destroyed */
+	sdata->deflink.u.mgd.bss = NULL;
+
 	netif_carrier_off(sdata->dev);
 
 	/*
@@ -2493,7 +2495,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		 * driver requested so.
 		 */
 		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP) &&
-		    !link->u.mgd.have_beacon) {
+		    !sdata->deflink.u.mgd.have_beacon) {
 			drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		}
 
@@ -2524,9 +2526,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	changed |= BSS_CHANGED_ASSOC;
 	sdata->vif.cfg.assoc = false;
 
-	link->u.mgd.p2p_noa_index = -1;
-	memset(&link->conf->p2p_noa_attr, 0,
-	       sizeof(link->conf->p2p_noa_attr));
+	sdata->deflink.u.mgd.p2p_noa_index = -1;
+	memset(&sdata->vif.bss_conf.p2p_noa_attr, 0,
+	       sizeof(sdata->vif.bss_conf.p2p_noa_attr));
 
 	/* on the next assoc, re-program HT/VHT parameters */
 	memset(&ifmgd->ht_capa, 0, sizeof(ifmgd->ht_capa));
@@ -2534,15 +2536,19 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(&ifmgd->vht_capa, 0, sizeof(ifmgd->vht_capa));
 	memset(&ifmgd->vht_capa_mask, 0, sizeof(ifmgd->vht_capa_mask));
 
-	/* reset MU-MIMO ownership and group data */
-	memset(link->conf->mu_group.membership, 0,
-	       sizeof(link->conf->mu_group.membership));
-	memset(link->conf->mu_group.position, 0,
-	       sizeof(link->conf->mu_group.position));
-	changed |= BSS_CHANGED_MU_GROUPS;
-	link->conf->mu_mimo_owner = false;
+	/*
+	 * reset MU-MIMO ownership and group data in default link,
+	 * if used, other links are destroyed
+	 */
+	memset(sdata->vif.bss_conf.mu_group.membership, 0,
+	       sizeof(sdata->vif.bss_conf.mu_group.membership));
+	memset(sdata->vif.bss_conf.mu_group.position, 0,
+	       sizeof(sdata->vif.bss_conf.mu_group.position));
+	if (!sdata->vif.valid_links)
+		changed |= BSS_CHANGED_MU_GROUPS;
+	sdata->vif.bss_conf.mu_mimo_owner = false;
 
-	link->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
+	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 
 	del_timer_sync(&local->dynamic_ps_timer);
 	cancel_work_sync(&local->dynamic_ps_enable_work);
@@ -2551,7 +2557,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.cfg.arp_addr_cnt)
 		changed |= BSS_CHANGED_ARP_FILTER;
 
-	link->conf->qos = false;
+	sdata->vif.bss_conf.qos = false;
 	changed |= BSS_CHANGED_QOS;
 
 	/* The BSSID (not really interesting) and HT changed */
@@ -2564,27 +2570,27 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	del_timer_sync(&sdata->u.mgd.conn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.bcn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.timer);
-	del_timer_sync(&link->u.mgd.chswitch_timer);
+	del_timer_sync(&sdata->deflink.u.mgd.chswitch_timer);
 
-	link->conf->dtim_period = 0;
-	link->conf->beacon_rate = NULL;
+	sdata->vif.bss_conf.dtim_period = 0;
+	sdata->vif.bss_conf.beacon_rate = NULL;
 
-	link->u.mgd.have_beacon = false;
-	link->u.mgd.tracking_signal_avg = false;
-	link->u.mgd.disable_wmm_tracking = false;
+	sdata->deflink.u.mgd.have_beacon = false;
+	sdata->deflink.u.mgd.tracking_signal_avg = false;
+	sdata->deflink.u.mgd.disable_wmm_tracking = false;
 
 	ifmgd->flags = 0;
-	link->u.mgd.conn_flags = 0;
+	sdata->deflink.u.mgd.conn_flags = 0;
 	mutex_lock(&local->mtx);
 	ieee80211_link_release_channel(link);
 
-	link->conf->csa_active = false;
-	link->u.mgd.csa_waiting_bcn = false;
-	link->u.mgd.csa_ignored_same_chan = false;
-	if (link->csa_block_tx) {
+	sdata->vif.bss_conf.csa_active = false;
+	sdata->deflink.u.mgd.csa_waiting_bcn = false;
+	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		link->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 	mutex_unlock(&local->mtx);
 
@@ -2592,9 +2598,10 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
 	cancel_delayed_work_sync(&ifmgd->tx_tspec_wk);
 
-	bss_conf->pwr_reduction = 0;
-	bss_conf->tx_pwr_env_num = 0;
-	memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
+	sdata->vif.bss_conf.pwr_reduction = 0;
+	sdata->vif.bss_conf.tx_pwr_env_num = 0;
+	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
+	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -2911,6 +2918,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
 			       tx, frame_buf);
 	mutex_lock(&local->mtx);
+	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
 	if (sdata->deflink.csa_block_tx) {
@@ -3057,7 +3065,6 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		del_timer_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, assoc_data->bss->bssid);
 
-		/* FIXME: other links are destroyed? */
 		sdata->deflink.u.mgd.conn_flags = 0;
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
@@ -6407,7 +6414,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	return 0;
  err_clear:
-	eth_zero_addr(link->u.mgd.bssid);
+	eth_zero_addr(sdata->deflink.u.mgd.bssid);
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 					  BSS_CHANGED_BSSID);
 	ifmgd->assoc_data = NULL;
-- 
2.36.1

