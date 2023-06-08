Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF0728250
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjFHOHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjFHOH0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339C2D71
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233242; x=1717769242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DbPnJNyoU20z6aNCigmmMZV0ExOcfseXjnryEdf1kic=;
  b=Y7i3L7VeWvW2xjDqiyXznnsvNoj5SuxqeRVMrZ2y7G7h/8Oiy0wfyqSp
   RydqCWV3XfVh/Ha2VW0nHilGyXX7x6f83MJOhVDgJrUjde1FD6Tfw1SR5
   6Y8aNOeNuwh+TFT5adD074pgWQzPRCipDdr4uiQKkRPafL4SwjO7h1H+e
   g/xu1nHi5lNZHTKUbQe6GMzh5FZk4W3OBftY9y5IMpxqF458wFGQEc6jr
   9oDNL3xurQazZ2exOoC1EMoJ8n9wI5gcsfcBiKBrT5/IhCD9gdEgUbLrm
   gUp72IcnIyjKOKff/qMayHlU3hU5I5UqSJkUHqbjHz7bGNB9p7JuNlpos
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176300"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706409"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706409"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: mac80211: Support disabled links during association
Date:   Thu,  8 Jun 2023 16:36:11 +0300
Message-Id: <20230608163202.c194fabeb81a.Iaefdef5ba0492afe9a5ede14c68060a4af36e444@changeid>
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

When the association is complete, do not configure disabled
links, and track them as part of the interface data.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h     |  6 ++++--
 net/mac80211/cfg.c         |  4 ++--
 net/mac80211/ieee80211_i.h |  4 +++-
 net/mac80211/link.c        | 38 +++++++++++++++++++++++---------------
 net/mac80211/mlme.c        | 35 ++++++++++++++++++++++-------------
 5 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5424301df3c8..b5704ef4308f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1846,6 +1846,8 @@ struct ieee80211_vif_cfg {
  * @active_links: The bitmap of active links, or 0 for non-MLO.
  *	The driver shouldn't change this directly, but use the
  *	API calls meant for that purpose.
+ * @dormant_links: bitmap of valid but disabled links, or 0 for non-MLO.
+ *	Must be a subset of valid_links.
  * @addr: address of this interface
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
@@ -1883,7 +1885,7 @@ struct ieee80211_vif {
 	struct ieee80211_vif_cfg cfg;
 	struct ieee80211_bss_conf bss_conf;
 	struct ieee80211_bss_conf __rcu *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
-	u16 valid_links, active_links;
+	u16 valid_links, active_links, dormant_links;
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
 
@@ -1916,7 +1918,7 @@ struct ieee80211_vif {
  */
 static inline u16 ieee80211_vif_usable_links(const struct ieee80211_vif *vif)
 {
-	return vif->valid_links;
+	return vif->valid_links & ~vif->dormant_links;
 }
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ca6d53d5751d..359589d525d5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4868,7 +4868,7 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&sdata->local->mtx);
-	res = ieee80211_vif_set_links(sdata, wdev->valid_links);
+	res = ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
 	mutex_unlock(&sdata->local->mtx);
 
 	return res;
@@ -4881,7 +4881,7 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
 	mutex_lock(&sdata->local->mtx);
-	ieee80211_vif_set_links(sdata, wdev->valid_links);
+	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
 	mutex_unlock(&sdata->local->mtx);
 }
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f55cec0e6b2d..561a2980f92f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -410,6 +410,8 @@ struct ieee80211_mgd_assoc_data {
 		ieee80211_conn_flags_t conn_flags;
 
 		u16 status;
+
+		bool disabled;
 	} link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
@@ -2019,7 +2021,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			 struct ieee80211_bss_conf *link_conf);
 void ieee80211_link_stop(struct ieee80211_link_data *link);
 int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links);
+			    u16 new_links, u16 dormant_links);
 void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata);
 
 /* tx handling */
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 55cba3760ef5..d090ecc41ea2 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -142,25 +142,34 @@ static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
 }
 
 static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
-					    u16 links)
+					    u16 valid_links, u16 dormant_links)
 {
-	sdata->vif.valid_links = links;
-
-	if (!links) {
+	sdata->vif.valid_links = valid_links;
+	sdata->vif.dormant_links = dormant_links;
+
+	if (!valid_links ||
+	    WARN((~valid_links & dormant_links) ||
+		 !(valid_links & ~dormant_links),
+		 "Invalid links: valid=0x%x, dormant=0x%x",
+		 valid_links, dormant_links)) {
 		sdata->vif.active_links = 0;
+		sdata->vif.dormant_links = 0;
 		return;
 	}
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
 		/* in an AP all links are always active */
-		sdata->vif.active_links = links;
+		sdata->vif.active_links = valid_links;
+
+		/* AP links are not expected to be disabled */
+		WARN_ON(dormant_links);
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (sdata->vif.active_links)
 			break;
-		WARN_ON(hweight16(links) > 1);
-		sdata->vif.active_links = links;
+		sdata->vif.active_links = valid_links & ~dormant_links;
+		WARN_ON(hweight16(sdata->vif.active_links) > 1);
 		break;
 	default:
 		WARN_ON(1);
@@ -169,7 +178,7 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 
 static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 				      struct link_container **to_free,
-				      u16 new_links)
+				      u16 new_links, u16 dormant_links)
 {
 	u16 old_links = sdata->vif.valid_links;
 	u16 old_active = sdata->vif.active_links;
@@ -245,7 +254,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		/* for keys we will not be able to undo this */
 		ieee80211_tear_down_links(sdata, to_free, rem);
 
-		ieee80211_set_vif_links_bitmaps(sdata, new_links);
+		ieee80211_set_vif_links_bitmaps(sdata, new_links, dormant_links);
 
 		/* tell the driver */
 		ret = drv_change_vif_links(sdata->local, sdata,
@@ -258,7 +267,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		/* restore config */
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
-		ieee80211_set_vif_links_bitmaps(sdata, old_links);
+		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
 		/* and free (only) the newly allocated links */
 		memset(to_free, 0, sizeof(links));
 		goto free;
@@ -282,12 +291,13 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 }
 
 int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links)
+			    u16 new_links, u16 dormant_links)
 {
 	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
 	int ret;
 
-	ret = ieee80211_vif_update_links(sdata, links, new_links);
+	ret = ieee80211_vif_update_links(sdata, links, new_links,
+					 dormant_links);
 	ieee80211_free_links(sdata, links);
 
 	return ret;
@@ -304,7 +314,7 @@ void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
 	 */
 
 	sdata_lock(sdata);
-	ieee80211_vif_update_links(sdata, links, 0);
+	ieee80211_vif_update_links(sdata, links, 0, 0);
 	sdata_unlock(sdata);
 
 	ieee80211_free_links(sdata, links);
@@ -328,7 +338,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return -EINVAL;
 
-	/* cannot activate links that don't exist */
 	if (active_links & ~ieee80211_vif_usable_links(&sdata->vif))
 		return -EINVAL;
 
@@ -484,7 +493,6 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return;
 
-	/* cannot activate links that don't exist */
 	if (active_links & ~ieee80211_vif_usable_links(&sdata->vif))
 		return;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fdd80f73e6cb..6970d5e7ac8f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2817,6 +2817,10 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		    assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS)
 			continue;
 
+		if (ieee80211_vif_is_mld(&sdata->vif) &&
+		    !(ieee80211_vif_usable_links(&sdata->vif) & BIT(link_id)))
+			continue;
+
 		link = sdata_dereference(sdata->link[link_id], sdata);
 		if (WARN_ON(!link))
 			return;
@@ -2843,6 +2847,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
 
 			if (!cbss ||
+			    !(BIT(link_id) &
+			      ieee80211_vif_usable_links(&sdata->vif)) ||
 			    assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS)
 				continue;
 
@@ -3057,7 +3063,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
 	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
 
-	ieee80211_vif_set_links(sdata, 0);
+	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -3510,7 +3516,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
-		ieee80211_vif_set_links(sdata, 0);
+		ieee80211_vif_set_links(sdata, 0, 0);
 		mutex_unlock(&sdata->local->mtx);
 	}
 
@@ -3569,7 +3575,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
-		ieee80211_vif_set_links(sdata, 0);
+		ieee80211_vif_set_links(sdata, 0, 0);
 		mutex_unlock(&sdata->local->mtx);
 	}
 
@@ -4978,7 +4984,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	unsigned int link_id;
 	struct sta_info *sta;
 	u64 changed[IEEE80211_MLD_MAX_NUM_LINKS] = {};
-	u16 valid_links = 0;
+	u16 valid_links = 0, dormant_links = 0;
 	int err;
 
 	mutex_lock(&sdata->local->sta_mtx);
@@ -4994,16 +5000,18 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 			if (!assoc_data->link[link_id].bss)
 				continue;
-			valid_links |= BIT(link_id);
 
-			if (link_id != assoc_data->assoc_link_id) {
+			valid_links |= BIT(link_id);
+			if (assoc_data->link[link_id].disabled) {
+				dormant_links |= BIT(link_id);
+			} else if (link_id != assoc_data->assoc_link_id) {
 				err = ieee80211_sta_allocate_link(sta, link_id);
 				if (err)
 					goto out_err;
 			}
 		}
 
-		ieee80211_vif_set_links(sdata, valid_links);
+		ieee80211_vif_set_links(sdata, valid_links, dormant_links);
 	}
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
@@ -5011,7 +5019,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
 
-		if (!cbss)
+		if (!cbss || assoc_data->link[link_id].disabled)
 			continue;
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
@@ -5083,7 +5091,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* links might have changed due to rejected ones, set them again */
-	ieee80211_vif_set_links(sdata, valid_links);
+	ieee80211_vif_set_links(sdata, valid_links, dormant_links);
 
 	rate_control_rate_init(sta);
 
@@ -6626,12 +6634,12 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		mlo = true;
 		if (WARN_ON(!ap_mld_addr))
 			return -EINVAL;
-		err = ieee80211_vif_set_links(sdata, BIT(link_id));
+		err = ieee80211_vif_set_links(sdata, BIT(link_id), 0);
 	} else {
 		if (WARN_ON(ap_mld_addr))
 			return -EINVAL;
 		ap_mld_addr = cbss->bssid;
-		err = ieee80211_vif_set_links(sdata, 0);
+		err = ieee80211_vif_set_links(sdata, 0, 0);
 		link_id = 0;
 		mlo = false;
 	}
@@ -6783,7 +6791,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 out_err:
 	ieee80211_link_release_channel(&sdata->deflink);
-	ieee80211_vif_set_links(sdata, 0);
+	ieee80211_vif_set_links(sdata, 0, 0);
 	return err;
 }
 
@@ -7323,10 +7331,11 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		for (i = 0; i < ARRAY_SIZE(assoc_data->link); i++) {
 			assoc_data->link[i].conn_flags = conn_flags;
 			assoc_data->link[i].bss = req->links[i].bss;
+			assoc_data->link[i].disabled = req->links[i].disabled;
 		}
 
 		/* if there was no authentication, set up the link */
-		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id));
+		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id), 0);
 		if (err)
 			goto err_clear;
 	} else {
-- 
2.38.1

