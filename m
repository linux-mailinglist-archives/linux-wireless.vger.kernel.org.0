Return-Path: <linux-wireless+bounces-1400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39274822220
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A229C1F231A1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717516414;
	Tue,  2 Jan 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn5WD7Mz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEA16411
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224181; x=1735760181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=40+D6IN+0bQkumWyRHtK016+mE0LRilrRLtdVXLKGgo=;
  b=Sn5WD7MzJsIoIy0lqocbqRfFBySVoDsSeTlZoksHEzIFIZmob7OY47U4
   CFSDznl7c2ipbKKQ+Jzxx4CUF1/xU1L5cK2nDDZo7C6kL/grRkoiDURB+
   wjzhY3xZC0OI2T6MnOkLMkG+TAG130Rk4EpvhV4BtonC6A606AuA9K0kL
   1p0BSQHJsrrnMcba/MmAEw2wwVwuCsIpsOAy+7rY0UZcP7gpZegEE8TsT
   S4NgL+NOmloEXYhq4Dcmt6YFb54DCK3EbNZypnOM/dAeZe9bo0Y47IzCD
   syF8hF57u1vWiJQ4meBoAk9eZsdDWOy7NWTqAQBGfVE/QwpBlpnPAJf99
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314307"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624499"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624499"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: mac80211: process and save negotiated TID to Link mapping request
Date: Tue,  2 Jan 2024 21:35:34 +0200
Message-Id: <20240102213313.0bc1a24fcc9d.Ie72e47dc6f8c77d4a2f0947b775ef6367fe0edac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

An MLD may send TID-to-Link mapping request frame to negotiate
TID to link mapping with a peer MLD.
Support handling negotiated TID-to-Link mapping request frame
by parsing the frame, asking the driver whether it supports the
received mapping or not, and sending a TID-to-Link mapping response
to the AP MLD.
Theoretically, links that became inactive due to the received TID-to-Link
mapping request, can be selected to be activated but this would require
tearing down the negotiated TID-to-Link mapping, which is still not
supported.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     |  46 ++++-
 net/mac80211/driver-ops.h  |  19 +++
 net/mac80211/ieee80211_i.h |   2 +
 net/mac80211/iface.c       |  12 ++
 net/mac80211/main.c        |   3 +-
 net/mac80211/mlme.c        | 335 +++++++++++++++++++++++++++++++++++--
 net/mac80211/rx.c          |  14 ++
 net/mac80211/trace.h       |  52 ++++++
 8 files changed, 465 insertions(+), 18 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d400fe2e8668..6490b92d5cc1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -342,6 +342,7 @@ struct ieee80211_vif_chanctx_switch {
  *	status changed.
  * @BSS_CHANGED_EHT_PUNCTURING: The channel puncturing bitmap changed.
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
+ * @BSS_CHANGED_MLD_TTLM: TID to link mapping was changed
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -378,6 +379,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
 	BSS_CHANGED_EHT_PUNCTURING	= BIT_ULL(32),
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
+	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -1845,6 +1847,35 @@ struct ieee80211_vif_cfg {
 	u8 ap_addr[ETH_ALEN] __aligned(2);
 };
 
+#define IEEE80211_TTLM_NUM_TIDS 8
+
+/**
+ * struct ieee80211_neg_ttlm - negotiated TID to link map info
+ *
+ * @downlink: bitmap of active links per TID for downlink, or 0 if mapping for
+ *	this TID is not included.
+ * @uplink: bitmap of active links per TID for uplink, or 0 if mapping for this
+ *	TID is not included.
+ * @valid: info is valid or not.
+ */
+struct ieee80211_neg_ttlm {
+	u16 downlink[IEEE80211_TTLM_NUM_TIDS];
+	u16 uplink[IEEE80211_TTLM_NUM_TIDS];
+	bool valid;
+};
+
+/**
+ * enum ieee80211_neg_ttlm_res - return value for negotiated TTLM handling
+ * @NEG_TTLM_RES_ACCEPT: accept the request
+ * @NEG_TTLM_RES_REJECT: reject the request
+ * @NEG_TTLM_RES_SUGGEST_PREFERRED: reject and suggest a new mapping
+ */
+enum ieee80211_neg_ttlm_res {
+	NEG_TTLM_RES_ACCEPT,
+	NEG_TTLM_RES_REJECT,
+	NEG_TTLM_RES_SUGGEST_PREFERRED
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -1863,6 +1894,11 @@ struct ieee80211_vif_cfg {
  *	API calls meant for that purpose.
  * @dormant_links: bitmap of valid but disabled links, or 0 for non-MLO.
  *	Must be a subset of valid_links.
+ * @suspended_links: subset of dormant_links representing links that are
+ *	suspended.
+ *	0 for non-MLO.
+ * @neg_ttlm: negotiated TID to link mapping info.
+ *	see &struct ieee80211_neg_ttlm.
  * @addr: address of this interface
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
@@ -1900,7 +1936,8 @@ struct ieee80211_vif {
 	struct ieee80211_vif_cfg cfg;
 	struct ieee80211_bss_conf bss_conf;
 	struct ieee80211_bss_conf __rcu *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
-	u16 valid_links, active_links, dormant_links;
+	u16 valid_links, active_links, dormant_links, suspended_links;
+	struct ieee80211_neg_ttlm neg_ttlm;
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
 
@@ -4293,6 +4330,10 @@ struct ieee80211_prep_tx_info {
  *	flow offloading for flows originating from the vif.
  *	Note that the driver must not assume that the vif driver_data is valid
  *	at this point, since the callback can be called during netdev teardown.
+ * @can_neg_ttlm: for managed interface, requests the driver to determine
+ *	if the requested TID-To-Link mapping can be accepted or not.
+ *	If it's not accepted the driver may suggest a preferred mapping and
+ *	modify @ttlm parameter with the suggested TID-to-Link mapping.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4673,6 +4714,9 @@ struct ieee80211_ops {
 			    struct net_device *dev,
 			    enum tc_setup_type type,
 			    void *type_data);
+	enum ieee80211_neg_ttlm_res
+	(*can_neg_ttlm)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_neg_ttlm *ttlm);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index eb482fb8c3af..e20c64edb880 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1695,4 +1695,23 @@ int drv_change_sta_links(struct ieee80211_local *local,
 			 struct ieee80211_sta *sta,
 			 u16 old_links, u16 new_links);
 
+static inline enum ieee80211_neg_ttlm_res
+drv_can_neg_ttlm(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_neg_ttlm *neg_ttlm)
+{
+	enum ieee80211_neg_ttlm_res res = NEG_TTLM_RES_REJECT;
+
+	might_sleep();
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	trace_drv_can_neg_ttlm(local, sdata, neg_ttlm);
+	if (local->ops->can_neg_ttlm)
+		res = local->ops->can_neg_ttlm(&local->hw, &sdata->vif,
+					       neg_ttlm);
+	trace_drv_neg_ttlm_res(local, sdata, res, neg_ttlm);
+
+	return res;
+}
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0ed82cc263f2..0dc78ee1269b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2603,6 +2603,8 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_mgmt *mgmt, size_t len);
 
 void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e4e7c0b38cb6..4a87d2d336ae 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1546,6 +1546,18 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		default:
 			break;
 		}
+	} else if (ieee80211_is_action(mgmt->frame_control) &&
+		   mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_EHT) {
+		if (sdata->vif.type == NL80211_IFTYPE_STATION) {
+			switch (mgmt->u.action.u.ttlm_req.action_code) {
+			case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
+				ieee80211_process_neg_ttlm_req(sdata, mgmt,
+							       skb->len);
+				break;
+			default:
+				break;
+			}
+		}
 	} else if (ieee80211_is_ext(mgmt->frame_control)) {
 		if (sdata->vif.type == NL80211_IFTYPE_STATION)
 			ieee80211_sta_rx_queued_ext(sdata, skb);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f2ece7793573..13c417eda281 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -208,7 +208,8 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 				   BSS_CHANGED_IBSS |\
 				   BSS_CHANGED_ARP_FILTER |\
 				   BSS_CHANGED_SSID |\
-				   BSS_CHANGED_MLD_VALID_LINKS)
+				   BSS_CHANGED_MLD_VALID_LINKS |\
+				   BSS_CHANGED_MLD_TTLM)
 
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				      u64 changed)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 967282baf0e2..71d5149ca4d6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1318,8 +1318,6 @@ static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 			cpu_to_le16(IEEE80211_MLC_BASIC_PRES_EML_CAPA);
 		skb_put_data(skb, &eml_capa, sizeof(eml_capa));
 	}
-	/* need indication from userspace to support this */
-	mld_capa_ops &= ~cpu_to_le16(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP);
 	skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
@@ -5899,6 +5897,56 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 				 TU_TO_JIFFIES(delay));
 }
 
+static int ieee80211_ttlm_set_links(struct ieee80211_sub_if_data *sdata,
+				    u16 active_links, u16 dormant_links,
+				    u16 suspended_links)
+{
+	u64 changed = 0;
+	int ret;
+
+	if (!active_links) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* If there is an active negotiated TTLM, it should be discarded by
+	 * the new negotiated/advertised TTLM.
+	 */
+	if (sdata->vif.neg_ttlm.valid) {
+		memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
+		sdata->vif.suspended_links = 0;
+		changed = BSS_CHANGED_MLD_TTLM;
+	}
+
+	if (sdata->vif.active_links != active_links) {
+		ret = ieee80211_set_active_links(&sdata->vif, active_links);
+		if (ret) {
+			sdata_info(sdata, "Failed to set TTLM active links\n");
+			goto out;
+		}
+	}
+
+	ret = ieee80211_vif_set_links(sdata, sdata->vif.valid_links,
+				      dormant_links);
+	if (ret) {
+		sdata_info(sdata, "Failed to set TTLM dormant links\n");
+		goto out;
+	}
+
+	changed |= BSS_CHANGED_MLD_VALID_LINKS;
+	sdata->vif.suspended_links = suspended_links;
+	if (sdata->vif.suspended_links)
+		changed |= BSS_CHANGED_MLD_TTLM;
+
+	ieee80211_vif_cfg_change_notify(sdata, changed);
+
+out:
+	if (ret)
+		ieee80211_disconnect(&sdata->vif, false);
+
+	return ret;
+}
+
 static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
 					   struct wiphy_work *work)
 {
@@ -5906,30 +5954,19 @@ static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
 			     u.mgd.ttlm_work.work);
-	int ret;
 
 	new_active_links = sdata->u.mgd.ttlm_info.map &
 			   sdata->vif.valid_links;
 	new_dormant_links = ~sdata->u.mgd.ttlm_info.map &
 			    sdata->vif.valid_links;
-	if (!new_active_links) {
-		ieee80211_disconnect(&sdata->vif, false);
-		return;
-	}
 
 	ieee80211_vif_set_links(sdata, sdata->vif.valid_links, 0);
-	new_active_links = BIT(ffs(new_active_links) - 1);
-	ieee80211_set_active_links(&sdata->vif, new_active_links);
-
-	ret = ieee80211_vif_set_links(sdata, sdata->vif.valid_links,
-				      new_dormant_links);
+	if (ieee80211_ttlm_set_links(sdata, new_active_links, new_dormant_links,
+				     0))
+		return;
 
 	sdata->u.mgd.ttlm_info.active = true;
 	sdata->u.mgd.ttlm_info.switch_time = 0;
-
-	if (!ret)
-		ieee80211_vif_cfg_change_notify(sdata,
-						BSS_CHANGED_MLD_VALID_LINKS);
 }
 
 static u16 ieee80211_get_ttlm(u8 bm_size, u8 *data)
@@ -6446,6 +6483,272 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	kfree(elems);
 }
 
+static void ieee80211_apply_neg_ttlm(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_neg_ttlm neg_ttlm)
+{
+	u16 new_active_links, new_dormant_links, new_suspended_links, map = 0;
+	u8 i;
+
+	for (i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++)
+		map |= neg_ttlm.downlink[i] | neg_ttlm.uplink[i];
+
+	/* If there is an active TTLM, unset previously suspended links */
+	if (sdata->vif.neg_ttlm.valid)
+		sdata->vif.dormant_links &= ~sdata->vif.suspended_links;
+
+	/* exclude links that are already disabled by advertised TTLM */
+	new_active_links =
+		map & sdata->vif.valid_links & ~sdata->vif.dormant_links;
+	new_suspended_links =
+		(~map & sdata->vif.valid_links) & ~sdata->vif.dormant_links;
+	new_dormant_links = sdata->vif.dormant_links | new_suspended_links;
+	if (ieee80211_ttlm_set_links(sdata, new_active_links,
+				     new_dormant_links, new_suspended_links))
+		return;
+
+	sdata->vif.neg_ttlm = neg_ttlm;
+	sdata->vif.neg_ttlm.valid = true;
+}
+
+static void
+ieee80211_neg_ttlm_add_suggested_map(struct sk_buff *skb,
+				     struct ieee80211_neg_ttlm *neg_ttlm)
+{
+	u8 i, direction[IEEE80211_TTLM_MAX_CNT];
+
+	if (memcmp(neg_ttlm->downlink, neg_ttlm->uplink,
+		   sizeof(neg_ttlm->downlink))) {
+		direction[0] = IEEE80211_TTLM_DIRECTION_DOWN;
+		direction[1] = IEEE80211_TTLM_DIRECTION_UP;
+	} else {
+		direction[0] = IEEE80211_TTLM_DIRECTION_BOTH;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(direction); i++) {
+		u8 tid, len, map_ind = 0, *len_pos, *map_ind_pos, *pos;
+		__le16 map;
+
+		len = sizeof(struct ieee80211_ttlm_elem) + 1 + 1;
+
+		pos = skb_put(skb, len + 2);
+		*pos++ = WLAN_EID_EXTENSION;
+		len_pos = pos++;
+		*pos++ = WLAN_EID_EXT_TID_TO_LINK_MAPPING;
+		*pos++ = direction[i];
+		map_ind_pos = pos++;
+		for (tid = 0; tid < IEEE80211_TTLM_NUM_TIDS; tid++) {
+			map = direction[i] == IEEE80211_TTLM_DIRECTION_UP ?
+				cpu_to_le16(neg_ttlm->uplink[tid]) :
+				cpu_to_le16(neg_ttlm->downlink[tid]);
+			if (!map)
+				continue;
+
+			len += 2;
+			map_ind |= BIT(tid);
+			skb_put_data(skb, &map, sizeof(map));
+		}
+
+		*map_ind_pos = map_ind;
+		*len_pos = len;
+
+		if (direction[i] == IEEE80211_TTLM_DIRECTION_BOTH)
+			break;
+	}
+}
+
+static void
+ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
+			    enum ieee80211_neg_ttlm_res ttlm_res,
+			    u8 dialog_token,
+			    struct ieee80211_neg_ttlm *neg_ttlm)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_res);
+	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
+		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
+
+	skb = dev_alloc_skb(local->tx_headroom + hdr_len + ttlm_max_len);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, local->tx_headroom);
+	mgmt = skb_put_zero(skb, hdr_len);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
+	mgmt->u.action.u.ttlm_res.action_code =
+		WLAN_PROTECTED_EHT_ACTION_TTLM_RES;
+	mgmt->u.action.u.ttlm_res.dialog_token = dialog_token;
+	switch (ttlm_res) {
+	default:
+		WARN_ON(1);
+		fallthrough;
+	case NEG_TTLM_RES_REJECT:
+		mgmt->u.action.u.ttlm_res.status_code =
+			WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
+		break;
+	case NEG_TTLM_RES_ACCEPT:
+		mgmt->u.action.u.ttlm_res.status_code = WLAN_STATUS_SUCCESS;
+		break;
+	case NEG_TTLM_RES_SUGGEST_PREFERRED:
+		mgmt->u.action.u.ttlm_res.status_code =
+			WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
+		ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
+		break;
+	}
+
+	ieee80211_tx_skb(sdata, skb);
+}
+
+static int
+ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
+			 const struct ieee80211_ttlm_elem *ttlm,
+			 struct ieee80211_neg_ttlm *neg_ttlm,
+			 u8 *direction)
+{
+	u8 control, link_map_presence, map_size, tid;
+	u8 *pos;
+
+	/* The element size was already validated in
+	 * ieee80211_tid_to_link_map_size_ok()
+	 */
+	pos = (void *)ttlm->optional;
+
+	control = ttlm->control;
+
+	/* mapping switch time and expected duration fields are not expected
+	 * in case of negotiated TTLM
+	 */
+	if (control & (IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT |
+		       IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT)) {
+		mlme_dbg(sdata,
+			 "Invalid TTLM element in negotiated TTLM request\n");
+		return -EINVAL;
+	}
+
+	if (control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP) {
+		for (tid = 0; tid < IEEE80211_TTLM_NUM_TIDS; tid++) {
+			neg_ttlm->downlink[tid] = sdata->vif.valid_links;
+			neg_ttlm->uplink[tid] = sdata->vif.valid_links;
+		}
+		*direction = IEEE80211_TTLM_DIRECTION_BOTH;
+		return 0;
+	}
+
+	*direction = u8_get_bits(control, IEEE80211_TTLM_CONTROL_DIRECTION);
+	if (*direction != IEEE80211_TTLM_DIRECTION_DOWN &&
+	    *direction != IEEE80211_TTLM_DIRECTION_UP &&
+	    *direction != IEEE80211_TTLM_DIRECTION_BOTH)
+		return -EINVAL;
+
+	link_map_presence = *pos;
+	pos++;
+
+	if (control & IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE)
+		map_size = 1;
+	else
+		map_size = 2;
+
+	for (tid = 0; tid < IEEE80211_TTLM_NUM_TIDS; tid++) {
+		u16 map;
+
+		if (link_map_presence & BIT(tid)) {
+			map = ieee80211_get_ttlm(map_size, pos);
+			if (!map) {
+				mlme_dbg(sdata,
+					 "No active links for TID %d", tid);
+				return -EINVAL;
+			}
+		} else {
+			map = 0;
+		}
+
+		switch (*direction) {
+		case IEEE80211_TTLM_DIRECTION_BOTH:
+			neg_ttlm->downlink[tid] = map;
+			neg_ttlm->uplink[tid] = map;
+			break;
+		case IEEE80211_TTLM_DIRECTION_DOWN:
+			neg_ttlm->downlink[tid] = map;
+			break;
+		case IEEE80211_TTLM_DIRECTION_UP:
+			neg_ttlm->uplink[tid] = map;
+			break;
+		default:
+			return -EINVAL;
+		}
+		pos += map_size;
+	}
+	return 0;
+}
+
+void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_mgmt *mgmt, size_t len)
+{
+	u8 dialog_token, direction[IEEE80211_TTLM_MAX_CNT] = {}, i;
+	size_t ies_len;
+	enum ieee80211_neg_ttlm_res ttlm_res = NEG_TTLM_RES_ACCEPT;
+	struct ieee802_11_elems *elems = NULL;
+	struct ieee80211_neg_ttlm neg_ttlm = {};
+
+	BUILD_BUG_ON(ARRAY_SIZE(direction) != ARRAY_SIZE(elems->ttlm));
+
+	if (!ieee80211_vif_is_mld(&sdata->vif))
+		return;
+
+	dialog_token = mgmt->u.action.u.ttlm_req.dialog_token;
+	ies_len  = len - offsetof(struct ieee80211_mgmt,
+				  u.action.u.ttlm_req.variable);
+	elems = ieee802_11_parse_elems(mgmt->u.action.u.ttlm_req.variable,
+				       ies_len, true, NULL);
+	if (!elems) {
+		ttlm_res = NEG_TTLM_RES_REJECT;
+		goto out;
+	}
+
+	for (i = 0; i < elems->ttlm_num; i++) {
+		if (ieee80211_parse_neg_ttlm(sdata, elems->ttlm[i],
+					     &neg_ttlm, &direction[i]) ||
+		    (direction[i] == IEEE80211_TTLM_DIRECTION_BOTH &&
+		     elems->ttlm_num != 1)) {
+			ttlm_res = NEG_TTLM_RES_REJECT;
+			goto out;
+		}
+	}
+
+	if (!elems->ttlm_num ||
+	    (elems->ttlm_num == 2 && direction[0] == direction[1])) {
+		ttlm_res = NEG_TTLM_RES_REJECT;
+		goto out;
+	}
+
+	for (i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++) {
+		if ((neg_ttlm.downlink[i] &&
+		     (neg_ttlm.downlink[i] & ~sdata->vif.valid_links)) ||
+		    (neg_ttlm.uplink[i] &&
+		     (neg_ttlm.uplink[i] & ~sdata->vif.valid_links))) {
+			ttlm_res = NEG_TTLM_RES_REJECT;
+			goto out;
+		}
+	}
+
+	ttlm_res = drv_can_neg_ttlm(sdata->local, sdata, &neg_ttlm);
+
+	if (ttlm_res != NEG_TTLM_RES_ACCEPT)
+		goto out;
+
+	ieee80211_apply_neg_ttlm(sdata, neg_ttlm);
+out:
+	kfree(elems);
+	ieee80211_send_neg_ttlm_res(sdata, ttlm_res, dialog_token, &neg_ttlm);
+}
+
 void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb)
 {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a57c8272c1dc..a3bb92ac2443 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3761,6 +3761,20 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		}
 		break;
+	case WLAN_CATEGORY_PROTECTED_EHT:
+		switch (mgmt->u.action.u.ttlm_req.action_code) {
+		case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			if (len < offsetofend(typeof(*mgmt),
+					      u.action.u.ttlm_req))
+				goto invalid;
+			goto queue;
+		default:
+			break;
+		}
+		break;
 	}
 
 	return RX_CONTINUE;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 06835ed4c44f..1c0c46b11c6d 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3088,6 +3088,58 @@ TRACE_EVENT(stop_queue,
 	)
 );
 
+TRACE_EVENT(drv_can_neg_ttlm,
+	    TP_PROTO(struct ieee80211_local *local,
+		     struct ieee80211_sub_if_data *sdata,
+		     struct ieee80211_neg_ttlm *neg_ttlm),
+
+	TP_ARGS(local, sdata, neg_ttlm),
+
+	TP_STRUCT__entry(LOCAL_ENTRY
+			 VIF_ENTRY
+			 __array(u16, downlink, sizeof(u16) * 8)
+			 __array(u16, uplink, sizeof(u16) * 8)
+	),
+
+	TP_fast_assign(LOCAL_ASSIGN;
+		       VIF_ASSIGN;
+		       memcpy(__entry->downlink, neg_ttlm->downlink,
+			      sizeof(neg_ttlm->downlink));
+		       memcpy(__entry->uplink, neg_ttlm->uplink,
+			      sizeof(neg_ttlm->uplink));
+	),
+
+	TP_printk(LOCAL_PR_FMT ", " VIF_PR_FMT, LOCAL_PR_ARG, VIF_PR_ARG)
+);
+
+TRACE_EVENT(drv_neg_ttlm_res,
+	    TP_PROTO(struct ieee80211_local *local,
+		     struct ieee80211_sub_if_data *sdata,
+		     enum ieee80211_neg_ttlm_res res,
+		     struct ieee80211_neg_ttlm *neg_ttlm),
+
+	TP_ARGS(local, sdata, res, neg_ttlm),
+
+	TP_STRUCT__entry(LOCAL_ENTRY
+			 VIF_ENTRY
+			 __field(u32, res)
+			 __array(u16, downlink, sizeof(u16) * 8)
+			 __array(u16, uplink, sizeof(u16) * 8)
+	),
+
+	TP_fast_assign(LOCAL_ASSIGN;
+		       VIF_ASSIGN;
+		       __entry->res = res;
+		       memcpy(__entry->downlink, neg_ttlm->downlink,
+			      sizeof(neg_ttlm->downlink));
+		       memcpy(__entry->uplink, neg_ttlm->uplink,
+			      sizeof(neg_ttlm->uplink));
+	),
+
+	TP_printk(LOCAL_PR_FMT  VIF_PR_FMT " response: %d\n ",
+		  LOCAL_PR_ARG, VIF_PR_ARG, __entry->res
+	)
+);
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


