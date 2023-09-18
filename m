Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2924F7A4821
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbjIRLMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbjIRLMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0554499
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035532; x=1726571532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/fLHsIXguI302wCK7EF4Saa82D53mU1uz7McoUT5Yk=;
  b=MFabiJbTxePfyA8Z2b9sqD5dZ3PyVINS2/bVcp/vzvA8DMtMxuSLqXzn
   jqa2bkPyMJqEakhF/uQ5VeWzrqDje74CiEgToraSx04C9A3hbHKAT/75a
   WsCjOjnm097ayAfub5FP0+Mo/yepcxXw793snVcffHdotcD872sPUuJZ2
   saFcKX3Dcsw/FSGAK4o/EkbpFSSOR17ayYF1Z2rDBdD/VMpR4S9FL3cmI
   T6sAgMCV2bVzVYqBsXGU0e3ZXMRCluvJDBBTqpg6F/QGtE922tREYCMzc
   2rOlrLo1y634A464S37I7rrOUkcx/NBb/uwbP6JXWQrDG3/P1/x8d24lt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535929"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025528"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025528"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/18] wifi: mac80211: support handling of advertised TID-to-link mapping
Date:   Mon, 18 Sep 2023 14:10:59 +0300
Message-Id: <20230918140607.df88937b7ae0.Iab0a6f561d85b8ab6efe541590985a2b6e9e74aa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

Support handling of advertised TID-to-link mapping elements received
in a beacon.
These elements are used by AP MLD to disable specific links and force
all clients to stop using these links.
By default if no TID-to-link mapping is advertised, all TIDs shall be
mapped to all links.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h |  15 +++
 net/mac80211/mlme.c        | 196 +++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fde956f8a939..6f639c614414 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -467,6 +467,17 @@ struct ieee80211_sta_tx_tspec {
 	bool downgraded;
 };
 
+/* Advertised TID-to-link mapping info */
+struct ieee80211_adv_t2l_map_info {
+	/* time in TUs at which the new mapping is established, or 0 if there is
+	 * no planned advertised TID-to-link mapping
+	 */
+	u16 switch_time;
+	u32 duration; /* duration of the planned T2L map in TUs */
+	u16 map; /* map of usable links for all TIDs */
+	bool active; /* whether the advertised mapping is active or not */
+};
+
 DECLARE_EWMA(beacon_signal, 4, 4)
 
 struct ieee80211_if_managed {
@@ -560,6 +571,10 @@ struct ieee80211_if_managed {
 
 	struct wiphy_delayed_work ml_reconf_work;
 	u16 removed_links;
+
+	/* TID-to-link mapping support */
+	struct wiphy_delayed_work t2l_map_work;
+	struct ieee80211_adv_t2l_map_info t2l_map_info;
 };
 
 struct ieee80211_if_ibss {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 091ec0753df7..7d69fd2713a8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3053,6 +3053,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
 	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
 
+	memset(&sdata->u.mgd.t2l_map_info, 0,
+	       sizeof(sdata->u.mgd.t2l_map_info));
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->t2l_map_work);
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
@@ -5844,6 +5847,194 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 				 TU_TO_JIFFIES(delay));
 }
 
+static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
+					   struct wiphy_work *work)
+{
+	u16 new_active_links, new_dormant_links;
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.t2l_map_work.work);
+	int ret;
+
+	new_active_links = sdata->u.mgd.t2l_map_info.map &
+			   sdata->vif.valid_links;
+	new_dormant_links = ~sdata->u.mgd.t2l_map_info.map &
+			    sdata->vif.valid_links;
+	if (!new_active_links) {
+		ieee80211_disconnect(&sdata->vif, false);
+		return;
+	}
+
+	ieee80211_vif_set_links(sdata, sdata->vif.valid_links, 0);
+	new_active_links = BIT(ffs(new_active_links) - 1);
+	ieee80211_set_active_links(&sdata->vif, new_active_links);
+
+	ret = ieee80211_vif_set_links(sdata, sdata->vif.valid_links,
+				      new_dormant_links);
+
+	sdata->u.mgd.t2l_map_info.active = true;
+	sdata->u.mgd.t2l_map_info.switch_time = 0;
+
+	if (!ret)
+		ieee80211_vif_cfg_change_notify(sdata,
+						BSS_CHANGED_MLD_VALID_LINKS);
+}
+
+static u16 ieee80211_get_t2l_map(u8 bm_size, u8 *data)
+{
+	if (bm_size == 1)
+		return *data;
+	else
+		return get_unaligned_le16(data);
+}
+
+static int
+ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
+			const struct ieee80211_t2l_map_elem *t2l_map,
+			struct ieee80211_adv_t2l_map_info *t2l_map_info)
+{
+	/* The element size was already validated in
+	 * ieee80211_tid_to_link_map_size_ok()
+	 */
+	u8 control, link_map_presence, map_size, tid;
+	u8 *pos;
+
+	memset(t2l_map_info, 0, sizeof(*t2l_map_info));
+	pos = (void *)t2l_map->optional;
+	control	= t2l_map->control;
+
+	if ((control & IEEE80211_T2L_MAP_CONTROL_DEF_LINK_MAP) ||
+	    !(control & IEEE80211_T2L_MAP_CONTROL_SWITCH_TIME_PRESENT))
+		return 0;
+
+	if ((control & IEEE80211_T2L_MAP_CONTROL_DIRECTION) !=
+	    IEEE80211_T2L_MAP_DIRECTION_BOTH) {
+		sdata_info(sdata, "Invalid advertised T2L map direction\n");
+		return -EINVAL;
+	}
+
+	link_map_presence = *pos;
+	pos++;
+
+	t2l_map_info->switch_time = get_unaligned_le16(pos);
+	pos += 2;
+
+	if (control & IEEE80211_T2L_MAP_CONTROL_EXPECTED_DUR_PRESENT) {
+		t2l_map_info->duration = pos[0] | pos[1] << 8 | pos[2] << 16;
+		pos += 3;
+	}
+
+	if (control & IEEE80211_T2L_MAP_CONTROL_LINK_MAP_SIZE)
+		map_size = 1;
+	else
+		map_size = 2;
+
+	/* According to Draft P802.11be_D3.0 clause 35.3.7.1.7, an AP MLD shall
+	 * not advertise a TID-to-link mapping that does not map all TIDs to the
+	 * same link set, reject frame if not all links have mapping
+	 */
+	if (link_map_presence != 0xff) {
+		sdata_info(sdata,
+			   "Invalid advertised T2L mapping presence indicator\n");
+		return -EINVAL;
+	}
+
+	t2l_map_info->map = ieee80211_get_t2l_map(map_size, pos);
+	if (!t2l_map_info->map) {
+		sdata_info(sdata,
+			   "Invalid advertised T2L map for TID 0\n");
+		return -EINVAL;
+	}
+
+	pos += map_size;
+
+	for (tid = 1; tid < 8; tid++) {
+		u16 map = ieee80211_get_t2l_map(map_size, pos);
+
+		if (map != t2l_map_info->map) {
+			sdata_info(sdata, "Invalid advertised T2L map for tid %d\n",
+				   tid);
+			return -EINVAL;
+		}
+
+		pos += map_size;
+	}
+	return 0;
+}
+
+static void ieee80211_process_adv_t2l_map(struct ieee80211_sub_if_data *sdata,
+					  struct ieee802_11_elems *elems,
+					  u64 beacon_ts)
+{
+	u8 i;
+	int ret;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif))
+		return;
+
+	if (!elems->t2l_map_num) {
+		if (sdata->u.mgd.t2l_map_info.switch_time) {
+			/* if a planned TID-to-link mapping was cancelled -
+			 * abort it
+			 */
+			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+						  &sdata->u.mgd.t2l_map_work);
+		} else if (sdata->u.mgd.t2l_map_info.active) {
+			/* if no TID-to-link element, set to default mapping in
+			 * which all TIDs are mapped to all setup links
+			 */
+			ret = ieee80211_vif_set_links(sdata,
+						      sdata->vif.valid_links,
+						      0);
+			if (ret) {
+				sdata_info(sdata, "Failed setting valid/dormant links\n");
+				return;
+			}
+			ieee80211_vif_cfg_change_notify(sdata,
+							BSS_CHANGED_MLD_VALID_LINKS);
+		}
+		memset(&sdata->u.mgd.t2l_map_info, 0,
+		       sizeof(sdata->u.mgd.t2l_map_info));
+		return;
+	}
+
+	for (i = 0; i < elems->t2l_map_num; i++) {
+		struct ieee80211_adv_t2l_map_info t2l_map_info;
+		u32 res;
+
+		res = ieee80211_parse_adv_t2l(sdata, elems->t2l_map[i],
+					      &t2l_map_info);
+
+		if (res) {
+			__ieee80211_disconnect(sdata);
+			return;
+		}
+
+		if (t2l_map_info.switch_time) {
+			u32 st_us, delay = 0;
+			u32 ts_l26 = beacon_ts & GENMASK(25, 0);
+
+			/* The t2l map switch time is indicated with a partial
+			 * TSF value, convert it to TSF and calc the delay
+			 * to the start time.
+			 */
+			st_us = ieee80211_tu_to_usec(t2l_map_info.switch_time);
+			if (st_us > ts_l26)
+				delay = st_us - ts_l26;
+			else
+				continue;
+
+			sdata->u.mgd.t2l_map_info = t2l_map_info;
+			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+						  &sdata->u.mgd.t2l_map_work);
+			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+						 &sdata->u.mgd.t2l_map_work,
+						 usecs_to_jiffies(delay));
+			return;
+		}
+	}
+}
+
 static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
@@ -6167,6 +6358,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	ieee80211_ml_reconfiguration(sdata, elems);
+	ieee80211_process_adv_t2l_map(sdata, elems,
+				      le64_to_cpu(mgmt->u.beacon.timestamp));
 
 	ieee80211_link_info_change_notify(sdata, link, changed);
 free:
@@ -6789,6 +6982,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
 	wiphy_delayed_work_init(&ifmgd->tx_tspec_wk,
 				ieee80211_sta_handle_tspec_ac_params_wk);
+	wiphy_delayed_work_init(&ifmgd->t2l_map_work,
+				ieee80211_tid_to_link_map_work);
 
 	ifmgd->flags = 0;
 	ifmgd->powersave = sdata->wdev.ps;
@@ -7863,6 +8058,7 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 				  &ifmgd->tdls_peer_del_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->ml_reconf_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->t2l_map_work);
 
 	if (ifmgd->assoc_data)
 		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
-- 
2.38.1

