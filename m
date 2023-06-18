Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A507347C9
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjFRSu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFRSux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5BE56
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114248; x=1718650248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4GSY+XLUH+TEQ/DDc44Y8yutZ9/wQnD4edAumhVfpY=;
  b=jm5yhumjtHSLBKbLsfm70AJxt3kxAP057BUqk291hUtwpt+KQXW1J1/6
   3e9mg2IOK8zVTSBEWKMhtwfKsXSSTcMYYRSnDljuSDEGavqAN0yY4Lsor
   01rrGkucZPMhmaN7vtez1ZyKO2BHKqrPg4oKTxsB3nR8Fifzw1nWFhOab
   IjITfurJC+8Ta18NeGrF6dRZJ9oQH5/SuT9T4tyZmHXPhT3RdB3cKhS9u
   zKixvDhmxWmMJUnoRZk7WYRR2t5HvQzYyA5TSlJonYXjOpY1XVmxWN1t6
   LbuNUg0MQz1uzLqm/EpCkTIGusbj5NT2drGGC1k7WT/olHiV5jk1Nzvsh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116660"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116660"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:47 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234049"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234049"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/20] wifi: mac80211: Support link removal using Reconfiguration ML element
Date:   Sun, 18 Jun 2023 21:49:55 +0300
Message-Id: <20230618214436.d8a046dc0c1a.I4dcf794da2a2d9f4e5f63a4b32158075d27c0660@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add support for handling link removal indicated by the
Reconfiguration Multi-Link element.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h  |  33 ++++++++
 net/mac80211/ieee80211_i.h |   3 +
 net/mac80211/mlme.c        | 159 +++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e145af7448a3..98223b665456 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4891,6 +4891,39 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 	       fixed + prof->sta_info_len <= len;
 }
 
+#define IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID			0x000f
+#define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
+#define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
+#define IEEE80211_MLE_STA_RECONF_CONTROL_DELETE_TIMER_PRESENT		0x0040
+
+/**
+ * ieee80211_mle_reconf_sta_prof_size_ok - validate reconfiguration multi-link
+ *	element sta profile size.
+ * @data: pointer to the sub element data
+ * @len: length of the containing sub element
+ */
+static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
+							 size_t len)
+{
+	const struct ieee80211_mle_per_sta_profile *prof = (const void *)data;
+	u16 control;
+	u8 fixed = sizeof(*prof);
+	u8 info_len = 1;
+
+	if (len < fixed)
+		return false;
+
+	control = le16_to_cpu(prof->control);
+
+	if (control & IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT)
+		info_len += ETH_ALEN;
+	if (control & IEEE80211_MLE_STA_RECONF_CONTROL_DELETE_TIMER_PRESENT)
+		info_len += 2;
+
+	return prof->sta_info_len >= info_len &&
+	       fixed + prof->sta_info_len - 1 <= len;
+}
+
 #define for_each_mle_subelement(_elem, _data, _len)			\
 	if (ieee80211_mle_size_ok(_data, _len))				\
 		for_each_element(_elem,					\
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index be3294719cb4..b5678f2d83f5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -551,6 +551,9 @@ struct ieee80211_if_managed {
 	 */
 	u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
+
+	struct delayed_work ml_reconf_work;
+	u16 removed_links;
 };
 
 struct ieee80211_if_ibss {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 30588703ffd3..f0fa1f0991ed 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5606,6 +5606,161 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 	return true;
 }
 
+static void ieee80211_ml_reconf_work(struct work_struct *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.ml_reconf_work.work);
+	u16 new_valid_links, new_active_links, new_dormant_links;
+	int ret;
+
+	if (!sdata->u.mgd.removed_links)
+		return;
+
+	sdata_info(sdata,
+		   "MLO Reconfiguration: work: valid=0x%x, removed=0x%x\n",
+		   sdata->vif.valid_links, sdata->u.mgd.removed_links);
+
+	new_valid_links = sdata->vif.valid_links & ~sdata->u.mgd.removed_links;
+	if (new_valid_links == sdata->vif.valid_links)
+		return;
+
+	if (!new_valid_links ||
+	    !(new_valid_links & ~sdata->vif.dormant_links)) {
+		sdata_info(sdata, "No valid links after reconfiguration\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	new_active_links = sdata->vif.active_links & ~sdata->u.mgd.removed_links;
+	if (new_active_links != sdata->vif.active_links) {
+		if (!new_active_links)
+			new_active_links = ffs(new_valid_links &
+					       ~sdata->vif.dormant_links) - 1;
+
+		ret = ieee80211_set_active_links(&sdata->vif,
+						 new_active_links);
+		if (ret) {
+			sdata_info(sdata,
+				   "Failed setting active links\n");
+			goto out;
+		}
+	}
+
+	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
+
+	ret = ieee80211_vif_set_links(sdata, new_valid_links,
+				      new_dormant_links);
+	if (ret)
+		sdata_info(sdata, "Failed setting valid links\n");
+
+out:
+	if (!ret) {
+		sdata_lock(sdata);
+		cfg80211_cqm_links_state_change_notify(sdata->dev,
+						       sdata->u.mgd.removed_links);
+		sdata_unlock(sdata);
+	} else {
+		__ieee80211_disconnect(sdata);
+	}
+
+	sdata->u.mgd.removed_links = 0;
+}
+
+static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
+					 struct ieee802_11_elems *elems)
+{
+	const struct ieee80211_multi_link_elem *ml;
+	const struct element *sub;
+	size_t ml_len;
+	unsigned long removed_links = 0;
+	u16 link_removal_timeout[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	u8 link_id;
+	u32 delay;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_reconf)
+		return;
+
+	ml_len = cfg80211_defragment_element(elems->ml_reconf_elem,
+					     elems->ie_start,
+					     elems->total_len,
+					     elems->scratch_pos,
+					     elems->scratch + elems->scratch_len -
+					     elems->scratch_pos,
+					     WLAN_EID_FRAGMENT);
+
+	elems->ml_reconf = (const void *)elems->scratch_pos;
+	elems->ml_reconf_len = ml_len;
+	ml = elems->ml_reconf;
+
+	/* Directly parse the sub elements as the common information doesn't
+	 * hold any useful information.
+	 */
+	for_each_mle_subelement(sub, (u8 *)ml, ml_len) {
+		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
+		u8 *pos = prof->variable;
+		u16 control;
+
+		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
+			continue;
+
+		if (!ieee80211_mle_reconf_sta_prof_size_ok(sub->data,
+							   sub->datalen))
+			return;
+
+		control = le16_to_cpu(prof->control);
+		link_id = control & IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID;
+
+		removed_links |= BIT(link_id);
+
+		/* the MAC address should not be included, but handle it */
+		if (control &
+		    IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT)
+			pos += 6;
+
+		/* According to Draft P802.11be_D3.0, the control should
+		 * include the AP Removal Timer present. If the AP Removal Timer
+		 * is not present assume immediate removal.
+		 */
+		if (control &
+		    IEEE80211_MLE_STA_RECONF_CONTROL_DELETE_TIMER_PRESENT)
+			link_removal_timeout[link_id] = le16_to_cpu(*(__le16 *)pos);
+	}
+
+	removed_links &= sdata->vif.valid_links;
+	if (!removed_links) {
+		/* In case the removal was cancelled, abort it */
+		if (sdata->u.mgd.removed_links) {
+			sdata->u.mgd.removed_links = 0;
+			cancel_delayed_work(&sdata->u.mgd.ml_reconf_work);
+		}
+		return;
+	}
+
+	delay = 0;
+	for_each_set_bit(link_id, &removed_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			sdata_dereference(sdata->vif.link_conf[link_id], sdata);
+		u32 link_delay;
+
+		if (!link_conf) {
+			removed_links &= ~BIT(link_id);
+			continue;
+		}
+
+		link_delay = link_conf->beacon_int *
+			link_removal_timeout[link_id];
+
+		if (!delay)
+			delay = link_delay;
+		else
+			delay = min(delay, link_delay);
+	}
+
+	sdata->u.mgd.removed_links = removed_links;
+	schedule_delayed_work(&sdata->u.mgd.ml_reconf_work, TU_TO_JIFFIES(delay));
+}
+
 static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
@@ -5935,6 +6090,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		}
 	}
 
+	ieee80211_ml_reconfiguration(sdata, elems);
+
 	ieee80211_link_info_change_notify(sdata, link, changed);
 free:
 	kfree(elems);
@@ -6561,6 +6718,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 			ieee80211_csa_connection_drop_work);
 	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
 			  ieee80211_tdls_peer_del_work);
+	INIT_DELAYED_WORK(&ifmgd->ml_reconf_work, ieee80211_ml_reconf_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
@@ -7573,6 +7731,7 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->csa_connection_drop_work);
 	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
+	cancel_delayed_work_sync(&ifmgd->ml_reconf_work);
 
 	sdata_lock(sdata);
 	if (ifmgd->assoc_data)
-- 
2.38.1

