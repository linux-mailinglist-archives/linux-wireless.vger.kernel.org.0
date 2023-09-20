Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285387A8BB5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjITS1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjITS1I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:27:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA3DE
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234410; x=1726770410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Fh8EU/JRaUK2guq/7/Lxf8x1+0EOynLZrNiPGeIFzU=;
  b=Fo1Oh+e97umQrelAYBm/+X4XFobkB9LLv6GlKEN7VeC6Qi3wQIQGNUMw
   BfCnlKfyeY8nkLYacN5XhuvuJC2vhyACh1yyvSBERfefJOaT7SonlSoLF
   jb0G8TVkCsAiIKvYmHsEFcrjQoP0WiQL9x/M6USnWjodKH8uR5UzbtWKy
   4brwlxyIpieMryT8/cZX8mZhbGC+el7zB0mQDM9jPnvARLdgJOjec+aV5
   BRT8n1PWRwfnNZyJM9aGGzJCggdNOBEEJn+ZLZd5ec9xLm7caxnDi/xez
   dne68AVZdgD3TPNCO0F2ef7V0FL1RQPXs+ahXxFDCrSopE1ZKYfrgGhOm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556436"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556436"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424272"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424272"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 14/18] wifi: mac80211: support handling of advertised TID-to-link mapping
Date:   Wed, 20 Sep 2023 21:25:25 +0300
Message-Id: <20230920211508.623c4b692ff9.Iab0a6f561d85b8ab6efe541590985a2b6e9e74aa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 3209c7c11207..eb459a6a76f5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -467,6 +467,17 @@ struct ieee80211_sta_tx_tspec {
 	bool downgraded;
 };
 
+/* Advertised TID-to-link mapping info */
+struct ieee80211_adv_ttlm_info {
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
+	struct wiphy_delayed_work ttlm_work;
+	struct ieee80211_adv_ttlm_info ttlm_info;
 };
 
 struct ieee80211_if_ibss {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 091ec0753df7..c1619bb2b11d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3053,6 +3053,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
 	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
 
+	memset(&sdata->u.mgd.ttlm_info, 0,
+	       sizeof(sdata->u.mgd.ttlm_info));
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
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
+			     u.mgd.ttlm_work.work);
+	int ret;
+
+	new_active_links = sdata->u.mgd.ttlm_info.map &
+			   sdata->vif.valid_links;
+	new_dormant_links = ~sdata->u.mgd.ttlm_info.map &
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
+	sdata->u.mgd.ttlm_info.active = true;
+	sdata->u.mgd.ttlm_info.switch_time = 0;
+
+	if (!ret)
+		ieee80211_vif_cfg_change_notify(sdata,
+						BSS_CHANGED_MLD_VALID_LINKS);
+}
+
+static u16 ieee80211_get_ttlm(u8 bm_size, u8 *data)
+{
+	if (bm_size == 1)
+		return *data;
+	else
+		return get_unaligned_le16(data);
+}
+
+static int
+ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
+			const struct ieee80211_ttlm_elem *ttlm,
+			struct ieee80211_adv_ttlm_info *ttlm_info)
+{
+	/* The element size was already validated in
+	 * ieee80211_tid_to_link_map_size_ok()
+	 */
+	u8 control, link_map_presence, map_size, tid;
+	u8 *pos;
+
+	memset(ttlm_info, 0, sizeof(*ttlm_info));
+	pos = (void *)ttlm->optional;
+	control	= ttlm->control;
+
+	if ((control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP) ||
+	    !(control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT))
+		return 0;
+
+	if ((control & IEEE80211_TTLM_CONTROL_DIRECTION) !=
+	    IEEE80211_TTLM_DIRECTION_BOTH) {
+		sdata_info(sdata, "Invalid advertised T2L map direction\n");
+		return -EINVAL;
+	}
+
+	link_map_presence = *pos;
+	pos++;
+
+	ttlm_info->switch_time = get_unaligned_le16(pos);
+	pos += 2;
+
+	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT) {
+		ttlm_info->duration = pos[0] | pos[1] << 8 | pos[2] << 16;
+		pos += 3;
+	}
+
+	if (control & IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE)
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
+	ttlm_info->map = ieee80211_get_ttlm(map_size, pos);
+	if (!ttlm_info->map) {
+		sdata_info(sdata,
+			   "Invalid advertised T2L map for TID 0\n");
+		return -EINVAL;
+	}
+
+	pos += map_size;
+
+	for (tid = 1; tid < 8; tid++) {
+		u16 map = ieee80211_get_ttlm(map_size, pos);
+
+		if (map != ttlm_info->map) {
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
+static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
+					  struct ieee802_11_elems *elems,
+					  u64 beacon_ts)
+{
+	u8 i;
+	int ret;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif))
+		return;
+
+	if (!elems->ttlm_num) {
+		if (sdata->u.mgd.ttlm_info.switch_time) {
+			/* if a planned TID-to-link mapping was cancelled -
+			 * abort it
+			 */
+			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+						  &sdata->u.mgd.ttlm_work);
+		} else if (sdata->u.mgd.ttlm_info.active) {
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
+		memset(&sdata->u.mgd.ttlm_info, 0,
+		       sizeof(sdata->u.mgd.ttlm_info));
+		return;
+	}
+
+	for (i = 0; i < elems->ttlm_num; i++) {
+		struct ieee80211_adv_ttlm_info ttlm_info;
+		u32 res;
+
+		res = ieee80211_parse_adv_t2l(sdata, elems->ttlm[i],
+					      &ttlm_info);
+
+		if (res) {
+			__ieee80211_disconnect(sdata);
+			return;
+		}
+
+		if (ttlm_info.switch_time) {
+			u32 st_us, delay = 0;
+			u32 ts_l26 = beacon_ts & GENMASK(25, 0);
+
+			/* The t2l map switch time is indicated with a partial
+			 * TSF value, convert it to TSF and calc the delay
+			 * to the start time.
+			 */
+			st_us = ieee80211_tu_to_usec(ttlm_info.switch_time);
+			if (st_us > ts_l26)
+				delay = st_us - ts_l26;
+			else
+				continue;
+
+			sdata->u.mgd.ttlm_info = ttlm_info;
+			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+						  &sdata->u.mgd.ttlm_work);
+			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+						 &sdata->u.mgd.ttlm_work,
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
+	ieee80211_process_adv_ttlm(sdata, elems,
+				      le64_to_cpu(mgmt->u.beacon.timestamp));
 
 	ieee80211_link_info_change_notify(sdata, link, changed);
 free:
@@ -6789,6 +6982,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
 	wiphy_delayed_work_init(&ifmgd->tx_tspec_wk,
 				ieee80211_sta_handle_tspec_ac_params_wk);
+	wiphy_delayed_work_init(&ifmgd->ttlm_work,
+				ieee80211_tid_to_link_map_work);
 
 	ifmgd->flags = 0;
 	ifmgd->powersave = sdata->wdev.ps;
@@ -7863,6 +8058,7 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 				  &ifmgd->tdls_peer_del_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->ml_reconf_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
 
 	if (ifmgd->assoc_data)
 		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
-- 
2.38.1

