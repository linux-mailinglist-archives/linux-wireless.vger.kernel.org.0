Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73872824E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbjFHOHd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjFHOHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C5F272E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233239; x=1717769239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+ihFb5GadD/3X4pydvBVd4V8AuqW2zy0seuxMp3YhQ=;
  b=i1G5cwKnNR889KODr76LFbMFqt7cUfaIdFfjOLSXVXg9zF5aobl/6GQ3
   IgsbLgaSSbEoD7ArjkQb4wXd12k0Q1u0Nur0mKe3HrXZS/vHrxlhGPoB1
   ljpkoxAQIIAjpxIy4xT3Eip3lDNhKpPANXD6BjLTEzSpcULiqnzxlFQPc
   yDsuN3ouwDHlVp750iVxQl21cywmS1uyrszw4jOEzAGe+cKSEiuR2UmMW
   e6x5HmyyO0yZNp1dMzDyf0n19Y1g9N+ikviTykxRZ/oaFssLVtD/dSq+m
   iA3VC1mkKDg+/olpRzLjEf9KajFtot7hT3GM3yd+6AN7f0VNoI0vm8pHj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176273"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706344"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706344"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: mac80211: Add getter functions for vif MLD state
Date:   Thu,  8 Jun 2023 16:36:08 +0300
Message-Id: <20230608163202.86e3351da1fc.If6fe3a339fda2019f13f57ff768ecffb711b710a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133611.1303724-1-gregory.greenman@intel.com>
References: <20230608133611.1303724-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

As a preparation to support disabled/dormant links, add the
following function:

- ieee80211_vif_usable_links(): returns the bitmap of the links
  that can be activated. Use this function in all the places that
  the bitmap of the usable links is needed.

- ieee80211_vif_is_mld(): returns true iff the vif is an MLD.
  Use this function in all the places where an indication that the
  connection is a MLD is needed.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h     | 21 +++++++++++++++++++
 net/mac80211/cfg.c         |  4 ++--
 net/mac80211/debug.h       |  8 +++----
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       |  4 ++--
 net/mac80211/link.c        |  4 ++--
 net/mac80211/mlme.c        | 43 +++++++++++++++++++-------------------
 net/mac80211/rx.c          |  2 +-
 net/mac80211/tx.c          | 22 +++++++++----------
 net/mac80211/util.c        | 14 ++++++-------
 10 files changed, 73 insertions(+), 51 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 98cb2c532025..5424301df3c8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1909,6 +1909,27 @@ struct ieee80211_vif {
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
+/**
+ * ieee80211_vif_usable_links - Return the usable links for the vif
+ * @vif: the vif for which the usable links are requested
+ * Return: the usable link bitmap
+ */
+static inline u16 ieee80211_vif_usable_links(const struct ieee80211_vif *vif)
+{
+	return vif->valid_links;
+}
+
+/**
+ * ieee80211_vif_is_mld - Returns true iff the vif is an MLD one
+ * @vif: the vif
+ * Return: %true if the vif is an MLD, %false otherwise.
+ */
+static inline bool ieee80211_vif_is_mld(const struct ieee80211_vif *vif)
+{
+	/* valid_links != 0 indicates this vif is an MLD */
+	return vif->valid_links != 0;
+}
+
 #define for_each_vif_active_link(vif, link, link_id)				\
 	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++)	\
 		if ((!(vif)->active_links ||					\
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4aaead4895b7..ca6d53d5751d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -35,7 +35,7 @@ ieee80211_link_or_deflink(struct ieee80211_sub_if_data *sdata, int link_id,
 		 * the return value at all (if it's not a pairwise key),
 		 * so in that case (require_valid==false) don't error.
 		 */
-		if (require_valid && sdata->vif.valid_links)
+		if (require_valid && ieee80211_vif_is_mld(&sdata->vif))
 			return ERR_PTR(-EINVAL);
 
 		return &sdata->deflink;
@@ -228,7 +228,7 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 			return 0;
 
 		/* FIXME: no support for 4-addr MLO yet */
-		if (sdata->vif.valid_links)
+		if (ieee80211_vif_is_mld(&sdata->vif))
 			return -EOPNOTSUPP;
 
 		sdata->u.mgd.use_4addr = params->use_4addr;
diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index b4c20f5e778e..d49894df2351 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #ifndef __MAC80211_DEBUG_H
 #define __MAC80211_DEBUG_H
@@ -136,7 +136,7 @@ do {									\
 
 #define link_info(link, fmt, ...)					\
 	do {								\
-		if ((link)->sdata->vif.valid_links)			\
+		if (ieee80211_vif_is_mld(&(link)->sdata->vif))          \
 			_sdata_info((link)->sdata, "[link %d] " fmt,	\
 				    (link)->link_id,			\
 				    ##__VA_ARGS__);			\
@@ -145,7 +145,7 @@ do {									\
 	} while (0)
 #define link_err(link, fmt, ...)					\
 	do {								\
-		if ((link)->sdata->vif.valid_links)			\
+		if (ieee80211_vif_is_mld(&(link)->sdata->vif))          \
 			_sdata_err((link)->sdata, "[link %d] " fmt,	\
 				   (link)->link_id,			\
 				   ##__VA_ARGS__);			\
@@ -154,7 +154,7 @@ do {									\
 	} while (0)
 #define link_dbg(link, fmt, ...)					\
 	do {								\
-		if ((link)->sdata->vif.valid_links)			\
+		if (ieee80211_vif_is_mld(&(link)->sdata->vif))          \
 			_sdata_dbg(1, (link)->sdata, "[link %d] " fmt,	\
 				   (link)->link_id,			\
 				   ##__VA_ARGS__);			\
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f918e73469a7..f55cec0e6b2d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1614,7 +1614,7 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	enum nl80211_band band;
 
-	WARN_ON(sdata->vif.valid_links);
+	WARN_ON(ieee80211_vif_is_mld(&sdata->vif));
 
 	rcu_read_lock();
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 5b67b44e3f89..9518acf9643b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -521,7 +521,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	cancel_work_sync(&sdata->recalc_smps);
 
 	sdata_lock(sdata);
-	WARN(sdata->vif.valid_links,
+	WARN(ieee80211_vif_is_mld(&sdata->vif),
 	     "destroying interface with valid links 0x%04x\n",
 	     sdata->vif.valid_links);
 
@@ -1815,7 +1815,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 		return -EBUSY;
 
 	/* for now, don't support changing while links exist */
-	if (sdata->vif.valid_links)
+	if (ieee80211_vif_is_mld(&sdata->vif))
 		return -EBUSY;
 
 	switch (sdata->vif.type) {
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 40f030b8ece9..55cba3760ef5 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -329,7 +329,7 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 
 	/* cannot activate links that don't exist */
-	if (active_links & ~sdata->vif.valid_links)
+	if (active_links & ~ieee80211_vif_usable_links(&sdata->vif))
 		return -EINVAL;
 
 	/* nothing to do */
@@ -485,7 +485,7 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 		return;
 
 	/* cannot activate links that don't exist */
-	if (active_links & ~sdata->vif.valid_links)
+	if (active_links & ~ieee80211_vif_usable_links(&sdata->vif))
 		return;
 
 	/* nothing to do */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d1e30ff54c1f..fdd80f73e6cb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1282,7 +1282,7 @@ static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 	u8 *ml_elem_len;
 	void *capab_pos;
 
-	if (!sdata->vif.valid_links)
+	if (!ieee80211_vif_is_mld(&sdata->vif))
 		return;
 
 	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy,
@@ -1456,7 +1456,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 			capab |= WLAN_CAPABILITY_PRIVACY;
 	}
 
-	if (sdata->vif.valid_links) {
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
 		/* consider the multi-link element with STA profile */
 		size += sizeof(struct ieee80211_multi_link_elem);
 		/* max common info field in basic multi-link element */
@@ -1789,7 +1789,7 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	if (WARN_ON(sdata->vif.valid_links))
+	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
 		success = false;
 
 	trace_api_chswitch_done(sdata, success);
@@ -2835,7 +2835,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	if (vif_cfg->arp_addr_cnt)
 		vif_changed |= BSS_CHANGED_ARP_FILTER;
 
-	if (sdata->vif.valid_links) {
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
 		for (link_id = 0;
 		     link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
@@ -2867,7 +2867,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	mutex_unlock(&local->iflist_mtx);
 
 	/* leave this here to not change ordering in non-MLO cases */
-	if (!sdata->vif.valid_links)
+	if (!ieee80211_vif_is_mld(&sdata->vif))
 		ieee80211_recalc_smps(sdata, &sdata->deflink);
 	ieee80211_recalc_ps_vif(sdata);
 
@@ -2963,7 +2963,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sta_info_flush(sdata);
 
 	/* finally reset all BSS / config parameters */
-	if (!sdata->vif.valid_links)
+	if (!ieee80211_vif_is_mld(&sdata->vif))
 		changed |= ieee80211_reset_erp_info(sdata);
 
 	ieee80211_led_assoc(local, 0);
@@ -2988,7 +2988,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	       sizeof(sdata->vif.bss_conf.mu_group.membership));
 	memset(sdata->vif.bss_conf.mu_group.position, 0,
 	       sizeof(sdata->vif.bss_conf.mu_group.position));
-	if (!sdata->vif.valid_links)
+	if (!ieee80211_vif_is_mld(&sdata->vif))
 		changed |= BSS_CHANGED_MU_GROUPS;
 	sdata->vif.bss_conf.mu_mimo_owner = false;
 
@@ -3002,7 +3002,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		changed |= BSS_CHANGED_ARP_FILTER;
 
 	sdata->vif.bss_conf.qos = false;
-	if (!sdata->vif.valid_links) {
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		changed |= BSS_CHANGED_QOS;
 		/* The BSSID (not really interesting) and HT changed */
 		changed |= BSS_CHANGED_BSSID | BSS_CHANGED_HT;
@@ -3171,7 +3171,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
 
-	if (WARN_ON(sdata->vif.valid_links))
+	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
 		return;
 
 	/*
@@ -3219,7 +3219,7 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	bool already = false;
 
-	if (WARN_ON_ONCE(sdata->vif.valid_links))
+	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
 		return;
 
 	if (!ieee80211_sdata_running(sdata))
@@ -3294,7 +3294,7 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 	int ssid_len;
 
 	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION ||
-		    sdata->vif.valid_links))
+		    ieee80211_vif_is_mld(&sdata->vif)))
 		return NULL;
 
 	sdata_assert_lock(sdata);
@@ -3359,7 +3359,8 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	}
 
 	/* in MLO assume we have a link where we can TX the frame */
-	tx = sdata->vif.valid_links || !sdata->deflink.csa_block_tx;
+	tx = ieee80211_vif_is_mld(&sdata->vif) ||
+		!sdata->deflink.csa_block_tx;
 
 	if (!ifmgd->driver_disconnect) {
 		unsigned int link_id;
@@ -3560,7 +3561,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 			for (i = 0; i < ARRAY_SIZE(data.bss); i++)
 				data.bss[i] = assoc_data->link[i].bss;
 
-			if (sdata->vif.valid_links)
+			if (ieee80211_vif_is_mld(&sdata->vif))
 				data.ap_mld_addr = assoc_data->ap_addr;
 
 			cfg80211_assoc_failure(sdata->dev, &data);
@@ -4989,7 +4990,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!sta))
 		goto out_err;
 
-	if (sdata->vif.valid_links) {
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 			if (!assoc_data->link[link_id].bss)
 				continue;
@@ -5017,7 +5018,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		if (WARN_ON(!link))
 			goto out_err;
 
-		if (sdata->vif.valid_links)
+		if (ieee80211_vif_is_mld(&sdata->vif))
 			link_info(link,
 				  "local address %pM, AP link address %pM%s\n",
 				  link->conf->addr,
@@ -5266,7 +5267,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 			ifmgd->broken_ap = true;
 		}
 
-		if (sdata->vif.valid_links) {
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
 			if (!elems->multi_link) {
 				sdata_info(sdata,
 					   "MLO association with %pM but no multi-link element in response!\n",
@@ -5333,7 +5334,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 				resp.uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
 	}
 
-	if (sdata->vif.valid_links) {
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
 		ether_addr_copy(ap_mld_addr, sdata->vif.cfg.ap_addr);
 		resp.ap_mld_addr = ap_mld_addr;
 	}
@@ -5659,7 +5660,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	rcu_read_unlock();
 
 	if (ifmgd->assoc_data && ifmgd->assoc_data->need_beacon &&
-	    !WARN_ON(sdata->vif.valid_links) &&
+	    !WARN_ON(ieee80211_vif_is_mld(&sdata->vif)) &&
 	    ieee80211_rx_our_beacon(bssid, ifmgd->assoc_data->link[0].bss)) {
 		parse_params.bss = ifmgd->assoc_data->link[0].bss;
 		elems = ieee802_11_parse_elems_full(&parse_params);
@@ -6357,7 +6358,7 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.bcn_mon_timer);
 
-	if (WARN_ON(sdata->vif.valid_links))
+	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
 		return;
 
 	if (sdata->vif.bss_conf.csa_active &&
@@ -6381,7 +6382,7 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	struct sta_info *sta;
 	unsigned long timeout;
 
-	if (WARN_ON(sdata->vif.valid_links))
+	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
 		return;
 
 	if (sdata->vif.bss_conf.csa_active &&
@@ -6937,7 +6938,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	return 0;
 
  err_clear:
-	if (!sdata->vif.valid_links) {
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 77c7dac760ba..6ebec32b4ebc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2505,7 +2505,7 @@ bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 	if (ether_addr_equal(sdata->vif.addr, addr))
 		return true;
 
-	if (!sdata->vif.valid_links)
+	if (!ieee80211_vif_is_mld(&sdata->vif))
 		return false;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->vif.link_conf); link_id++) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 7972de64e779..d8460a14b6bd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -844,7 +844,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 
 	/* SNS11 from 802.11be 10.3.2.14 */
 	if (unlikely(is_multicast_ether_addr(hdr->addr1) &&
-		     info->control.vif->valid_links &&
+		     ieee80211_vif_is_mld(info->control.vif) &&
 		     info->control.vif->type == NL80211_IFTYPE_AP)) {
 		if (info->control.flags & IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX)
 			tx->sdata->mld_mcast_seq += 0x10;
@@ -2610,7 +2610,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	ethertype = (skb->data[12] << 8) | skb->data[13];
 	fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA);
 
-	if (!sdata->vif.valid_links)
+	if (!ieee80211_vif_is_mld(&sdata->vif))
 		chanctx_conf =
 			rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 
@@ -2627,7 +2627,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 			authorized = test_sta_flag(sta, WLAN_STA_AUTHORIZED);
 			wme_sta = sta->sta.wme;
 		}
-		if (!sdata->vif.valid_links) {
+		if (!ieee80211_vif_is_mld(&sdata->vif)) {
 			struct ieee80211_sub_if_data *ap_sdata;
 
 			/* override chanctx_conf from AP (we don't have one) */
@@ -2645,7 +2645,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		/* DA BSSID SA */
 		memcpy(hdr.addr1, skb->data, ETH_ALEN);
 
-		if (sdata->vif.valid_links && sta && !sta->sta.mlo) {
+		if (ieee80211_vif_is_mld(&sdata->vif) && sta && !sta->sta.mlo) {
 			struct ieee80211_link_data *link;
 
 			link_id = sta->deflink.link_id;
@@ -2797,7 +2797,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!chanctx_conf) {
-		if (!sdata->vif.valid_links) {
+		if (!ieee80211_vif_is_mld(&sdata->vif)) {
 			ret = -ENOTCONN;
 			goto free;
 		}
@@ -3039,7 +3039,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    !ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG))
 		goto out;
 
-	if (!sdata->vif.valid_links) {
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		rcu_read_lock();
 		chanctx_conf =
 			rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
@@ -3110,7 +3110,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 		fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS);
 		/* DA BSSID SA */
 		build.da_offs = offsetof(struct ieee80211_hdr, addr1);
-		if (sta->sta.mlo || !sdata->vif.valid_links) {
+		if (sta->sta.mlo || !ieee80211_vif_is_mld(&sdata->vif)) {
 			memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 		} else {
 			unsigned int link_id = sta->deflink.link_id;
@@ -4479,7 +4479,7 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 			__ieee80211_subif_start_xmit(skb, dev, 0,
 						     IEEE80211_TX_CTRL_MLO_LINK_UNSPEC,
 						     NULL);
-	} else if (sdata->vif.valid_links &&
+	} else if (ieee80211_vif_is_mld(&sdata->vif) &&
 		   sdata->vif.type == NL80211_IFTYPE_AP &&
 		   !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) {
 		ieee80211_mlo_multicast_tx(dev, skb);
@@ -4755,7 +4755,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 
 	if (info->control.flags & IEEE80211_TX_INTCFL_NEED_TXPROCESSING) {
 		/* update band only for non-MLD */
-		if (!sdata->vif.valid_links) {
+		if (!ieee80211_vif_is_mld(&sdata->vif)) {
 			chanctx_conf =
 				rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 			if (unlikely(!chanctx_conf)) {
@@ -6002,7 +6002,7 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 	BUILD_BUG_ON(!FIELD_FIT(IEEE80211_TX_CTRL_MLO_LINK,
 				IEEE80211_LINK_UNSPECIFIED));
 
-	if (!sdata->vif.valid_links) {
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		link = 0;
 	} else if (link_id >= 0) {
 		link = link_id;
@@ -6048,7 +6048,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band band;
 
 	rcu_read_lock();
-	if (!sdata->vif.valid_links) {
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		WARN_ON(link_id >= 0);
 		chanctx_conf =
 			rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a5be07a4dbe3..3aa363bdb6e0 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1824,7 +1824,7 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
-	bool multi_link = sdata->vif.valid_links;
+	bool multi_link = ieee80211_vif_is_mld(&sdata->vif);
 	struct {
 		u8 id;
 		u8 len;
@@ -2671,7 +2671,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			continue;
 
 		sdata_lock(sdata);
-		if (sdata->vif.valid_links) {
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
 			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS] = {
 				[0] = &sdata->vif.bss_conf,
 			};
@@ -2691,7 +2691,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		for (link_id = 0;
 		     link_id < ARRAY_SIZE(sdata->vif.link_conf);
 		     link_id++) {
-			if (sdata->vif.valid_links &&
+			if (ieee80211_vif_is_mld(&sdata->vif) &&
 			    !(sdata->vif.active_links & BIT(link_id)))
 				continue;
 
@@ -2723,12 +2723,12 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		if (sdata->vif.bss_conf.mu_mimo_owner)
 			changed |= BSS_CHANGED_MU_GROUPS;
 
-		if (!sdata->vif.valid_links)
+		if (!ieee80211_vif_is_mld(&sdata->vif))
 			changed |= BSS_CHANGED_IDLE;
 
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_STATION:
-			if (!sdata->vif.valid_links) {
+			if (!ieee80211_vif_is_mld(&sdata->vif)) {
 				changed |= BSS_CHANGED_ASSOC |
 					   BSS_CHANGED_ARP_FILTER |
 					   BSS_CHANGED_PS;
@@ -2766,7 +2766,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP:
 			changed |= BSS_CHANGED_P2P_PS;
 
-			if (sdata->vif.valid_links)
+			if (ieee80211_vif_is_mld(&sdata->vif))
 				ieee80211_vif_cfg_change_notify(sdata,
 								BSS_CHANGED_SSID);
 			else
@@ -2780,7 +2780,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			if (sdata->vif.type == NL80211_IFTYPE_AP) {
 				changed |= BSS_CHANGED_AP_PROBE_RESP;
 
-				if (sdata->vif.valid_links) {
+				if (ieee80211_vif_is_mld(&sdata->vif)) {
 					ieee80211_reconfig_ap_links(local,
 								    sdata,
 								    changed);
-- 
2.38.1

