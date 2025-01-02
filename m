Return-Path: <linux-wireless+bounces-16984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE39FFA5F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AA81629E3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45961B424D;
	Thu,  2 Jan 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErN6R98h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E41B4236
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827635; cv=none; b=JrFvJR2BuC+fSma1yVYlOO1ABOyfzjBGBUTZkkRLhlnDQvDVBdObPQf8PWuneBgNfAvpGxAG6yEmdkd85kAcuXBJXszzpvHONewhyADhLwsAfDnFgcPU2x/3WQUiGyC5jxrn4I4QVKA+0xGEkfxog3LOaGUsW64Wm4L8ZmumbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827635; c=relaxed/simple;
	bh=Oqse3GoMMSRQQA1XJg8n9BVRyEpDfj5KCuZxqKgNGRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+xgDWqoiQHSkO/7gdfBoweaJGCsqfvf3JLq6ti9XqDWNZB6e/NZ5qDrcLrN0WGG9IYgfqPJFQu0DTxcBN7nQgtl1S+eMlkUf0thEYzt9oPHILq7eEiz+A29QC/57LQz1xa1l3UIP1kgZOd/RnUUrljhQkXTA/BAM0kDl0Rvhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErN6R98h; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827633; x=1767363633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oqse3GoMMSRQQA1XJg8n9BVRyEpDfj5KCuZxqKgNGRE=;
  b=ErN6R98h2o/39WnBIJO3lMqzG5CCNDz6SUfi7YeEU245b5FoeD3eWdFJ
   6M80BxPhyA2Wrvu4B02CJI4gwJTIp/hVBLwibA5w+SefbG6g5laGHyju4
   ybnddXDKzbCdRM/Pv4yWilREhMU8kyaCd1qFCXu/6J6iG5i2BtCTH1VAs
   ips97QDelFa/8cEFQiDhkoxgDpZxnLthVHa4tD1ihUKYPyHd/hBFdTjp2
   l6ZRLiy23MFhQro0DLUKiJNXqNCtlrPQNcNTviMhvBv42hBCWutoQVDXh
   VkPPl48MiwNRSH5euPSGThNZmwzOyZ4H+Wk48H8GZwkTvOB6jipkZX/af
   w==;
X-CSE-ConnectionGUID: ixT7iTluROaQBy+AYIbMPA==
X-CSE-MsgGUID: 5ERtw/bqTGKUEAJYou7jbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735110"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735110"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:32 -0800
X-CSE-ConnectionGUID: CjeGp7EuS4SQ1KSW1ln+lA==
X-CSE-MsgGUID: MgjhRT3eTKysHGB0YjG4eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357397"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 06/17] wifi: mac80211: Support dynamic link addition and removal
Date: Thu,  2 Jan 2025 16:19:58 +0200
Message-Id: <20250102161730.ec0492a8dd21.I2869686642bbc0f86c40f284ebf7e6f644b551ab@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for adding and removing station links:

- Adding links is done asynchronously, i.e., first
  an ML reconfiguration action frame is sent to the AP
  requesting to add links, and only when the AP replies,
  links which were added successfully by the AP are added
  locally.
- Removing links is done synchronously, i.e., the links
  are removed before sending the ML reconfiguration
  action frame to the AP (to avoid using this links after
  the AP MLD removed them but before the station got the
  ML reconfiguration response). In case the AP replies with a
  status indicating that a link removal was not successful,
  disconnect (as this should not happen an is an indication
  that something might be wrong on the AP MLD).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h  |  11 +
 net/mac80211/cfg.c         |  13 +
 net/mac80211/ieee80211_i.h |  15 +
 net/mac80211/iface.c       |   4 +
 net/mac80211/mlme.c        | 757 ++++++++++++++++++++++++++++++++++++-
 net/mac80211/rx.c          |  12 +
 6 files changed, 811 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ee6bebfd041d..b5c5b5c39d9a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1532,6 +1532,17 @@ struct ieee80211_mgmt {
 				struct {
 					u8 action_code;
 				} __packed ttlm_tear_down;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 variable[];
+				} __packed ml_reconf_req;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 count;
+					u8 variable[];
+				} __packed ml_reconf_resp;
 			} u;
 		} __packed action;
 		DECLARE_FLEX_ARRAY(u8, body); /* Generic frame body */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b8495d5f2297..1a912cb8ae8d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5180,6 +5180,18 @@ ieee80211_set_ttlm(struct wiphy *wiphy, struct net_device *dev,
 	return ieee80211_req_neg_ttlm(sdata, params);
 }
 
+static int
+ieee80211_assoc_ml_reconf(struct wiphy *wiphy, struct net_device *dev,
+			  struct cfg80211_assoc_link *add_links,
+			  u16 rem_links)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	return ieee80211_mgd_assoc_ml_reconf(sdata, add_links, rem_links);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5294,4 +5306,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 	.set_ttlm = ieee80211_set_ttlm,
 	.get_radio_mask = ieee80211_get_radio_mask,
+	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7b8a0da8eaff..64df7d739ebf 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -606,6 +606,15 @@ struct ieee80211_if_managed {
 	/* dialog token enumerator for neg TTLM request */
 	u8 dialog_token_alloc;
 	struct wiphy_delayed_work neg_ttlm_timeout_work;
+
+	/* Locally initiated multi-link reconfiguration */
+	struct {
+		struct ieee80211_mgd_assoc_data *add_links_data;
+		struct wiphy_delayed_work wk;
+		u16 removed_links;
+		u16 added_links;
+		u8 dialog_token;
+	} reconf;
 };
 
 struct ieee80211_if_ibss {
@@ -2770,6 +2779,12 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 
+int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_assoc_link *add_links,
+				  u16 rem_links);
+
+void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
+				      struct ieee80211_mgmt *mgmt, size_t len);
 #if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 2e170dbde732..0ea7e77860b7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1560,6 +1560,10 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				ieee80211_process_neg_ttlm_res(sdata, mgmt,
 							       skb->len);
 				break;
+			case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
+				ieee80211_process_ml_reconf_resp(sdata, mgmt,
+								 skb->len);
+				break;
 			default:
 				break;
 			}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 390d4d994c6a..b08b59961bf3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3842,6 +3842,38 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	netif_carrier_on(sdata->dev);
 }
 
+static void ieee80211_ml_reconf_reset(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_mgd_assoc_data *add_links_data =
+		sdata->u.mgd.reconf.add_links_data;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif) ||
+	    !(sdata->u.mgd.reconf.added_links |
+	      sdata->u.mgd.reconf.removed_links))
+		return;
+
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &sdata->u.mgd.reconf.wk);
+	sdata->u.mgd.reconf.added_links = 0;
+	sdata->u.mgd.reconf.removed_links = 0;
+	sdata->u.mgd.reconf.dialog_token = 0;
+
+	if (add_links_data) {
+		struct cfg80211_mlo_reconf_done_data done_data = {};
+		u8 link_id;
+
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++)
+			done_data.links[link_id].bss =
+				add_links_data->link[link_id].bss;
+
+		cfg80211_mlo_reconf_add_done(sdata->dev, &done_data);
+
+		kfree(sdata->u.mgd.reconf.add_links_data);
+		sdata->u.mgd.reconf.add_links_data = NULL;
+	}
+}
+
 static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 				   u16 stype, u16 reason, bool tx,
 				   u8 *frame_buf)
@@ -4034,6 +4066,12 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	ieee80211_vif_set_links(sdata, 0, 0);
 
 	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
+
+	/* if disconnection happens in the middle of the ML reconfiguration
+	 * flow, cfg80211 must called to release the BSS references obtained
+	 * when the flow started.
+	 */
+	ieee80211_ml_reconf_reset(sdata);
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -4909,7 +4947,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 					u64 *changed)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	struct ieee80211_mgd_assoc_data *assoc_data = sdata->u.mgd.assoc_data;
+	struct ieee80211_mgd_assoc_data *assoc_data =
+		sdata->u.mgd.assoc_data ?: sdata->u.mgd.reconf.add_links_data;
 	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
 	unsigned int link_id = link->link_id;
@@ -8338,6 +8377,25 @@ static void ieee80211_request_smps_mgd_work(struct wiphy *wiphy,
 				     link->u.mgd.driver_smps_mode);
 }
 
+static void ieee80211_ml_sta_reconf_timeout(struct wiphy *wiphy,
+					    struct wiphy_work *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.reconf.wk.work);
+
+	if (!sdata->u.mgd.reconf.added_links &&
+	    !sdata->u.mgd.reconf.removed_links)
+		return;
+
+	sdata_info(sdata,
+		   "mlo: reconf: timeout: added=0x%x, removed=0x%x\n",
+		   sdata->u.mgd.reconf.added_links,
+		   sdata->u.mgd.reconf.removed_links);
+
+	__ieee80211_disconnect(sdata);
+}
+
 /* interface setup */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 {
@@ -8352,6 +8410,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 				ieee80211_tdls_peer_del_work);
 	wiphy_delayed_work_init(&ifmgd->ml_reconf_work,
 				ieee80211_ml_reconf_work);
+	wiphy_delayed_work_init(&ifmgd->reconf.wk,
+				ieee80211_ml_sta_reconf_timeout);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
@@ -8412,6 +8472,9 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	if (sdata->u.mgd.assoc_data)
 		ether_addr_copy(link->conf->addr,
 				sdata->u.mgd.assoc_data->link[link_id].addr);
+	else if (sdata->u.mgd.reconf.add_links_data)
+		ether_addr_copy(link->conf->addr,
+				sdata->u.mgd.reconf.add_links_data->link[link_id].addr);
 	else if (!is_valid_ether_addr(link->conf->addr))
 		eth_random_addr(link->conf->addr);
 }
@@ -9665,3 +9728,695 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif)
 	_ieee80211_enable_rssi_reports(sdata, 0, 0);
 }
 EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
+
+static void ieee80211_ml_reconf_selectors(unsigned long *userspace_selectors)
+{
+	*userspace_selectors = 0;
+
+	/* these selectors are mandatory for ML reconfiguration */
+	set_bit(BSS_MEMBERSHIP_SELECTOR_SAE_H2E, userspace_selectors);
+	set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, userspace_selectors);
+	set_bit(BSS_MEMBERSHIP_SELECTOR_EHT_PHY, userspace_selectors);
+}
+
+void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
+				      struct ieee80211_mgmt *mgmt, size_t len)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_mgd_assoc_data *add_links_data =
+		ifmgd->reconf.add_links_data;
+	struct sta_info *sta;
+	struct cfg80211_mlo_reconf_done_data done_data = {};
+	u16 sta_changed_links = sdata->u.mgd.reconf.added_links |
+		                sdata->u.mgd.reconf.removed_links;
+	u16 link_mask, valid_links;
+	unsigned int link_id;
+	unsigned long userspace_selectors;
+	size_t orig_len = len;
+	u8 i, group_key_data_len;
+	u8 *pos;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif) ||
+	    len < offsetofend(typeof(*mgmt), u.action.u.ml_reconf_resp) ||
+	    mgmt->u.action.u.ml_reconf_resp.dialog_token !=
+	    sdata->u.mgd.reconf.dialog_token ||
+	    !sta_changed_links)
+		return;
+
+	pos = mgmt->u.action.u.ml_reconf_resp.variable;
+	len -= offsetofend(typeof(*mgmt), u.action.u.ml_reconf_resp);
+
+	/* each status duple is 3 octets */
+	if (len < mgmt->u.action.u.ml_reconf_resp.count * 3) {
+		sdata_info(sdata,
+			   "mlo: reconf: unexpected len=%zu, count=%u\n",
+			   len, mgmt->u.action.u.ml_reconf_resp.count);
+		goto disconnect;
+	}
+
+	link_mask = sta_changed_links;
+	for (i = 0; i < mgmt->u.action.u.ml_reconf_resp.count; i++) {
+		u16 status = get_unaligned_le16(pos + 1);
+
+		link_id = *pos;
+
+		if (!(link_mask & BIT(link_id))) {
+			sdata_info(sdata,
+				   "mlo: reconf: unexpected link: %u, changed=0x%x\n",
+				   link_id, sta_changed_links);
+			goto disconnect;
+		}
+
+		/* clear the corresponding link, to detect the case that
+		 * the same link was included more than one time
+		 */
+		link_mask &= ~BIT(link_id);
+
+		/* Handle failure to remove links here. Failure to remove added
+		 * links will be done later in the flow.
+		 */
+		if (status != WLAN_STATUS_SUCCESS) {
+			sdata_info(sdata,
+				   "mlo: reconf: failed on link=%u, status=%u\n",
+				   link_id, status);
+
+			/* The AP MLD failed to remove a link that was already
+			 * removed locally. As this is not expected behavior,
+			 * disconnect
+			 */
+			if (sdata->u.mgd.reconf.removed_links & BIT(link_id))
+				goto disconnect;
+
+			/* The AP MLD failed to add a link. Remove it from the
+			 * added links.
+			 */
+			sdata->u.mgd.reconf.added_links &= ~BIT(link_id);
+		}
+
+		pos += 3;
+		len -= 3;
+	}
+
+	if (link_mask) {
+		sdata_info(sdata,
+			   "mlo: reconf: no response for links=0x%x\n",
+			   link_mask);
+		goto disconnect;
+	}
+
+	if (!sdata->u.mgd.reconf.added_links)
+		goto out;
+
+	if (len < 1 || len < 1 + *pos) {
+		sdata_info(sdata,
+			   "mlo: reconf: invalid group key data length");
+		goto disconnect;
+	}
+
+	/* The Group Key Data field must be present when links are added. This
+	 * field should be processed by userland.
+	 */
+	group_key_data_len = *pos++;
+
+	pos += group_key_data_len;
+	len -= group_key_data_len + 1;
+
+	/* Process the information for the added links */
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (WARN_ON(!sta))
+		goto disconnect;
+
+	valid_links = sdata->vif.valid_links;
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (!add_links_data->link[link_id].bss ||
+		    !(sdata->u.mgd.reconf.added_links & BIT(link_id)))
+
+			continue;
+
+		valid_links |= BIT(link_id);
+		if (ieee80211_sta_allocate_link(sta, link_id))
+			goto disconnect;
+	}
+
+	ieee80211_vif_set_links(sdata, valid_links, sdata->vif.dormant_links);
+	ieee80211_ml_reconf_selectors(&userspace_selectors);
+	link_mask = 0;
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct cfg80211_bss *cbss = add_links_data->link[link_id].bss;
+		struct ieee80211_link_data *link;
+		struct link_sta_info *link_sta;
+		u64 changed = 0;
+
+		if (!cbss)
+			continue;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (WARN_ON(!link))
+			goto disconnect;
+
+		link_info(link,
+			  "mlo: reconf: local address %pM, AP link address %pM\n",
+			  add_links_data->link[link_id].addr,
+			  add_links_data->link[link_id].bss->bssid);
+
+		link_sta = rcu_dereference_protected(sta->link[link_id],
+						     lockdep_is_held(&local->hw.wiphy->mtx));
+		if (WARN_ON(!link_sta))
+			goto disconnect;
+
+		if (!link->u.mgd.have_beacon) {
+			const struct cfg80211_bss_ies *ies;
+
+			rcu_read_lock();
+			ies = rcu_dereference(cbss->beacon_ies);
+			if (ies)
+				link->u.mgd.have_beacon = true;
+			else
+				ies = rcu_dereference(cbss->ies);
+			ieee80211_get_dtim(ies,
+					   &link->conf->sync_dtim_count,
+					   &link->u.mgd.dtim_period);
+			link->conf->beacon_int = cbss->beacon_interval;
+			rcu_read_unlock();
+		}
+
+		link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
+
+		link->u.mgd.conn = add_links_data->link[link_id].conn;
+		if (ieee80211_prep_channel(sdata, link, link_id, cbss,
+					   true, &link->u.mgd.conn,
+					   &userspace_selectors)) {
+			link_info(link, "mlo: reconf: prep_channel failed\n");
+			goto disconnect;
+		}
+
+		if (ieee80211_mgd_setup_link_sta(link, sta, link_sta,
+						 add_links_data->link[link_id].bss))
+			goto disconnect;
+
+		if (!ieee80211_assoc_config_link(link, link_sta,
+						 add_links_data->link[link_id].bss,
+						 mgmt, pos, len,
+						 &changed))
+			goto disconnect;
+
+		/* The AP MLD indicated success for this link, but the station
+		 * profile status indicated otherwise. Since there is an
+		 * inconsistency in the ML reconfiguration response, disconnect
+		 */
+		if (add_links_data->link[link_id].status != WLAN_STATUS_SUCCESS)
+			goto disconnect;
+
+		ieee80211_sta_init_nss(link_sta);
+		if (ieee80211_sta_activate_link(sta, link_id))
+			goto disconnect;
+
+		changed |= ieee80211_link_set_associated(link, cbss);
+		ieee80211_link_info_change_notify(sdata, link, changed);
+
+		ieee80211_recalc_smps(sdata, link);
+		link_mask |= BIT(link_id);
+	}
+
+	sdata_info(sdata,
+		   "mlo: reconf: current valid_links=0x%x, added=0x%x\n",
+		   valid_links, link_mask);
+
+	/* links might have changed due to rejected ones, set them again */
+	ieee80211_vif_set_links(sdata, valid_links, sdata->vif.dormant_links);
+	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_MLD_VALID_LINKS);
+
+	ieee80211_recalc_ps(local);
+	ieee80211_recalc_ps_vif(sdata);
+
+	done_data.buf = (const u8 *)mgmt;
+	done_data.len = orig_len;
+	done_data.added_links = link_mask;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		done_data.links[link_id].bss = add_links_data->link[link_id].bss;
+
+	cfg80211_mlo_reconf_add_done(sdata->dev, &done_data);
+	kfree(sdata->u.mgd.reconf.add_links_data);
+	sdata->u.mgd.reconf.add_links_data = NULL;
+out:
+	ieee80211_ml_reconf_reset(sdata);
+	return;
+
+disconnect:
+	__ieee80211_disconnect(sdata);
+}
+
+static struct sk_buff *
+ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
+			      struct ieee80211_mgd_assoc_data *add_links_data,
+			      u16 removed_links)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct ieee80211_multi_link_elem *ml_elem;
+	struct ieee80211_mle_basic_common_info *common;
+	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
+	struct sk_buff *skb;
+	size_t size;
+	unsigned int link_id;
+	__le16 eml_capa = 0, mld_capa_ops = 0;
+	struct ieee80211_tx_info *info;
+	u8 common_size, var_common_size;
+	u8 *ml_elem_len;
+	u16 capab = 0;
+
+	size = local->hw.extra_tx_headroom + sizeof(*mgmt);
+
+	/* Consider the maximal length of the reconfiguration ML element */
+	size += sizeof(struct ieee80211_multi_link_elem);
+
+	/* The Basic ML element and the Reconfiguration ML element have the same
+	 * fixed common information fields in the context of ML reconfiguration
+	 * action frame. The AP MLD MAC address must always be present
+	 */
+	common_size = sizeof(*common);
+
+	/* when adding links, the MLD capabilities must be present */
+	var_common_size = 0;
+	if (add_links_data) {
+		const struct wiphy_iftype_ext_capab *ift_ext_capa =
+			cfg80211_get_iftype_ext_capa(local->hw.wiphy,
+						     ieee80211_vif_type_p2p(&sdata->vif));
+
+		if (ift_ext_capa) {
+			eml_capa = cpu_to_le16(ift_ext_capa->eml_capabilities);
+			mld_capa_ops =
+				cpu_to_le16(ift_ext_capa->mld_capa_and_ops);
+		}
+
+		/* MLD capabilities and operation */
+		var_common_size += 2;
+
+		/* EML capabilities */
+		if (eml_capa & cpu_to_le16((IEEE80211_EML_CAP_EMLSR_SUPP |
+					    IEEE80211_EML_CAP_EMLMR_SUPPORT)))
+			var_common_size += 2;
+	}
+
+	/* Add the common information length */
+	size += common_size + var_common_size;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct cfg80211_bss *cbss;
+		size_t elems_len;
+
+		if (removed_links & BIT(link_id)) {
+			size += sizeof(struct ieee80211_mle_per_sta_profile) +
+				ETH_ALEN;
+			continue;
+		}
+
+		if (!add_links_data || !add_links_data->link[link_id].bss)
+			continue;
+
+		elems_len = add_links_data->link[link_id].elems_len;
+		cbss = add_links_data->link[link_id].bss;
+
+		/* should be the same across all BSSes */
+		if (cbss->capability & WLAN_CAPABILITY_PRIVACY)
+			capab |= WLAN_CAPABILITY_PRIVACY;
+
+		size += 2 + sizeof(struct ieee80211_mle_per_sta_profile) +
+			ETH_ALEN;
+
+		/* SSID element + WMM */
+		size += 2 + sdata->vif.cfg.ssid_len + 9;
+		size += ieee80211_link_common_elems_size(sdata, iftype, cbss,
+							 elems_len);
+	}
+
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, local->hw.extra_tx_headroom);
+	mgmt = skb_put_zero(skb, offsetofend(struct ieee80211_mgmt,
+					     u.action.u.ml_reconf_req));
+
+	/* Add the MAC header */
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
+
+	/* Add the action frame fixed fields */
+	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
+	mgmt->u.action.u.ml_reconf_req.action_code =
+		WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_REQ;
+
+	/* allocate a dialog token and store it */
+	sdata->u.mgd.reconf.dialog_token = ++sdata->u.mgd.dialog_token_alloc;
+	mgmt->u.action.u.ml_reconf_req.dialog_token =
+		sdata->u.mgd.reconf.dialog_token;
+
+	/* Add the ML reconfiguration element and the common information  */
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	ml_elem_len = skb_put(skb, 1);
+	skb_put_u8(skb, WLAN_EID_EXT_EHT_MULTI_LINK);
+	ml_elem = skb_put(skb, sizeof(*ml_elem));
+	ml_elem->control =
+		cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_RECONF |
+			    IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR);
+	common = skb_put(skb, common_size);
+	common->len = common_size + var_common_size;
+	memcpy(common->mld_mac_addr, sdata->vif.addr, ETH_ALEN);
+
+	if (add_links_data) {
+		if (eml_capa &
+		    cpu_to_le16((IEEE80211_EML_CAP_EMLSR_SUPP |
+				 IEEE80211_EML_CAP_EMLMR_SUPPORT))) {
+			ml_elem->control |=
+				cpu_to_le16(IEEE80211_MLC_RECONF_PRES_EML_CAPA);
+			skb_put_data(skb, &eml_capa, sizeof(eml_capa));
+		}
+
+		ml_elem->control |=
+			cpu_to_le16(IEEE80211_MLC_RECONF_PRES_MLD_CAPA_OP);
+
+		skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
+	}
+
+	if (sdata->u.mgd.flags & IEEE80211_STA_ENABLE_RRM)
+		capab |= WLAN_CAPABILITY_RADIO_MEASURE;
+
+	/* Add the per station profile */
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		u8 *subelem_len = NULL;
+		u16 ctrl;
+		const u8 *addr;
+
+		/* Skip links that are not changing */
+		if (!(removed_links & BIT(link_id)) &&
+		    (!add_links_data || !add_links_data->link[link_id].bss))
+			continue;
+
+		ctrl = link_id |
+		       IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT;
+
+		if (removed_links & BIT(link_id)) {
+			struct ieee80211_bss_conf *conf =
+				sdata_dereference(sdata->vif.link_conf[link_id],
+						  sdata);
+			if (!conf)
+				continue;
+
+			addr = conf->addr;
+			ctrl |= u16_encode_bits(IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_DEL_LINK,
+						IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE);
+		} else {
+			addr = add_links_data->link[link_id].addr;
+			ctrl |= IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE |
+				u16_encode_bits(IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_ADD_LINK,
+						IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE);
+		}
+
+		skb_put_u8(skb, IEEE80211_MLE_SUBELEM_PER_STA_PROFILE);
+		subelem_len = skb_put(skb, 1);
+
+		put_unaligned_le16(ctrl, skb_put(skb, sizeof(ctrl)));
+		skb_put_u8(skb, 1 + ETH_ALEN);
+		skb_put_data(skb, addr, ETH_ALEN);
+
+		if (!(removed_links & BIT(link_id))) {
+			u16 link_present_elems[PRESENT_ELEMS_MAX] = {};
+			size_t extra_used;
+			void *capab_pos;
+			u8 qos_info;
+
+			capab_pos = skb_put(skb, 2);
+
+			skb_put_u8(skb, WLAN_EID_SSID);
+			skb_put_u8(skb, sdata->vif.cfg.ssid_len);
+			skb_put_data(skb, sdata->vif.cfg.ssid,
+				     sdata->vif.cfg.ssid_len);
+
+			extra_used =
+				ieee80211_add_link_elems(sdata, skb, &capab, NULL,
+							 add_links_data->link[link_id].elems,
+							 add_links_data->link[link_id].elems_len,
+							 link_id, NULL,
+							 link_present_elems,
+							 add_links_data);
+
+			if (add_links_data->link[link_id].elems)
+				skb_put_data(skb,
+					     add_links_data->link[link_id].elems +
+					     extra_used,
+					     add_links_data->link[link_id].elems_len -
+					     extra_used);
+			if (sdata->u.mgd.flags & IEEE80211_STA_UAPSD_ENABLED) {
+				qos_info = sdata->u.mgd.uapsd_queues;
+				qos_info |= (sdata->u.mgd.uapsd_max_sp_len <<
+					     IEEE80211_WMM_IE_STA_QOSINFO_SP_SHIFT);
+			} else {
+				qos_info = 0;
+			}
+
+			ieee80211_add_wmm_info_ie(skb_put(skb, 9), qos_info);
+			put_unaligned_le16(capab, capab_pos);
+		}
+
+		ieee80211_fragment_element(skb, subelem_len,
+					   IEEE80211_MLE_SUBELEM_FRAGMENT);
+	}
+
+	ieee80211_fragment_element(skb, ml_elem_len, WLAN_EID_FRAGMENT);
+
+	info = IEEE80211_SKB_CB(skb);
+	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+
+	return skb;
+}
+
+int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_assoc_link *add_links,
+				  u16 rem_links)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgd_assoc_data *data = NULL;
+	struct sta_info *sta;
+	struct sk_buff *skb;
+	u16 added_links, new_valid_links;
+	int link_id, err;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif) ||
+	    !(sdata->vif.cfg.mld_capa_op &
+	      IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT))
+		return -EINVAL;
+
+	/* No support for concurrent ML reconfiguration operation */
+	if (sdata->u.mgd.reconf.added_links ||
+	    sdata->u.mgd.reconf.removed_links)
+		return -EBUSY;
+
+	added_links = 0;
+	for (link_id = 0; add_links && link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+	     link_id++) {
+		if (!add_links[link_id].bss)
+			continue;
+
+		added_links |= BIT(link_id);
+	}
+
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (WARN_ON(!sta))
+		return -ENOLINK;
+
+	if (rem_links & BIT(sta->sta.deflink.link_id))
+		return -EINVAL;
+
+	/* Adding links to the set of valid link is done only after a successful
+	 * ML reconfiguration frame exchange. Here prepare the data for the ML
+	 * reconfiguration frame construction and allocate the required
+	 * resources
+	 */
+	if (added_links) {
+		bool uapsd_supported;
+		unsigned long userspace_selectors;
+
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		uapsd_supported = true;
+		ieee80211_ml_reconf_selectors(&userspace_selectors);
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			struct ieee80211_supported_band *sband;
+			struct cfg80211_bss *link_cbss = add_links[link_id].bss;
+			struct ieee80211_bss *bss;
+
+			if (!link_cbss)
+				continue;
+
+			bss = (void *)link_cbss->priv;
+
+			if (!bss->wmm_used) {
+				err = -EINVAL;
+				goto err_free;
+			}
+
+			if (link_cbss->channel->band == NL80211_BAND_S1GHZ) {
+				err = -EINVAL;
+				goto err_free;
+			}
+
+			eth_random_addr(data->link[link_id].addr);
+			data->link[link_id].conn =
+				ieee80211_conn_settings_unlimited;
+			sband =
+				local->hw.wiphy->bands[link_cbss->channel->band];
+
+			ieee80211_determine_our_sta_mode(sdata, sband,
+							 NULL, true, link_id,
+							 &data->link[link_id].conn);
+
+			data->link[link_id].bss = link_cbss;
+			data->link[link_id].disabled =
+				add_links[link_id].disabled;
+			data->link[link_id].elems =
+				(u8 *)add_links[link_id].elems;
+			data->link[link_id].elems_len =
+				add_links[link_id].elems_len;
+
+			if (!bss->uapsd_supported)
+				uapsd_supported = false;
+
+			if (data->link[link_id].conn.mode <
+			    IEEE80211_CONN_MODE_EHT) {
+				err = -EINVAL;
+				goto err_free;
+			}
+
+			err = ieee80211_mgd_get_ap_ht_vht_capa(sdata, data,
+							       link_id);
+			if (err) {
+				err = -EINVAL;
+				goto err_free;
+			}
+		}
+
+		/* Require U-APSD support to be similar to the current valid
+		 * links
+		 */
+		if (uapsd_supported !=
+		    !!(sdata->u.mgd.flags & IEEE80211_STA_UAPSD_ENABLED)) {
+			err = -EINVAL;
+			goto err_free;
+		}
+
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			if (!data->link[link_id].bss)
+				continue;
+
+			/* only used to verify the mode, nothing is allocated */
+			err = ieee80211_prep_channel(sdata, NULL, link_id,
+						     data->link[link_id].bss,
+						     true,
+						     &data->link[link_id].conn,
+						     &userspace_selectors);
+			if (err)
+				goto err_free;
+		}
+	}
+
+	/* link removal is done before the ML reconfiguration frame exchange so
+	 * that these links will not be used between their removal by the AP MLD
+	 * and before the station got the ML reconfiguration response. Based on
+	 * Section 35.3.6.4 in Draft P802.11be_D7.0 the AP MLD should accept the
+	 * link removal request.
+	 */
+	if (rem_links) {
+		u16 new_active_links = sdata->vif.active_links & ~rem_links;
+
+		new_valid_links = sdata->vif.valid_links & ~rem_links;
+
+		/* Should not be left with no valid links to perform the
+		 * ML reconfiguration
+		 */
+		if (!new_valid_links ||
+		    !(new_valid_links & ~sdata->vif.dormant_links)) {
+			sdata_info(sdata, "mlo: reconf: no valid links\n");
+			err = -EINVAL;
+			goto err_free;
+		}
+
+		if (new_active_links != sdata->vif.active_links) {
+			if (!new_active_links)
+				new_active_links =
+					BIT(__ffs(new_valid_links &
+						  ~sdata->vif.dormant_links));
+
+			err = ieee80211_set_active_links(&sdata->vif,
+							 new_active_links);
+			if (err) {
+				sdata_info(sdata,
+					   "mlo: reconf: failed set active links\n");
+				goto err_free;
+			}
+		}
+	}
+
+	/* Build the SKB before the link removal as the construction of the
+	 * station info for removed links requires the local address.
+	 * Invalidate the removed links, so that the transmission of the ML
+	 * reconfiguration request frame would not be done using them, as the AP
+	 * is expected to send the ML reconfiguration response frame on the link
+	 * on which the request was received.
+	 */
+	skb = ieee80211_build_ml_reconf_req(sdata, data, rem_links);
+	if (!skb)
+		return -ENOMEM;
+
+	if (rem_links) {
+		u16 new_dormant_links = sdata->vif.dormant_links & ~rem_links;
+
+		err = ieee80211_vif_set_links(sdata, new_valid_links,
+					      new_dormant_links);
+		if (err) {
+			sdata_info(sdata,
+				   "mlo: reconf: failed set valid links\n");
+			kfree_skb(skb);
+			goto err_free;
+		}
+
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			if (!(rem_links & BIT(link_id)))
+				continue;
+
+			ieee80211_sta_remove_link(sta, link_id);
+		}
+
+		/* notify the driver and upper layers */
+		ieee80211_vif_cfg_change_notify(sdata,
+						BSS_CHANGED_MLD_VALID_LINKS);
+		cfg80211_links_removed(sdata->dev, rem_links);
+	}
+
+	sdata_info(sdata, "mlo: reconf: adding=0x%x, removed=0x%x\n",
+		   added_links, rem_links);
+
+	ieee80211_tx_skb(sdata, skb);
+
+	sdata->u.mgd.reconf.added_links = added_links;
+	sdata->u.mgd.reconf.add_links_data = data;
+	sdata->u.mgd.reconf.removed_links = rem_links;
+	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+				 &sdata->u.mgd.reconf.wk,
+				 IEEE80211_ASSOC_TIMEOUT_SHORT);
+	return 0;
+
+ err_free:
+	kfree(data);
+	return err;
+}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3c0cc3cf5ec8..82caf64a5b35 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3818,6 +3818,18 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 					      u.action.u.ttlm_res))
 				goto invalid;
 			goto queue;
+		case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			/* The reconfiguration response action frame must
+			 * least one 'Status Duple' entry (3 octets)
+			 */
+			if (len <
+			    offsetofend(typeof(*mgmt),
+					u.action.u.ml_reconf_resp) + 3)
+				goto invalid;
+			goto queue;
 		default:
 			break;
 		}
-- 
2.34.1


