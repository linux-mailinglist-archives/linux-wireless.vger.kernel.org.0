Return-Path: <linux-wireless+bounces-18497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F6A286C7
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97F1188A1F9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8C21A458;
	Wed,  5 Feb 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYciXEYn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454422ACC6
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748391; cv=none; b=DB9FAG9k3TfCVC7TlUPLJd7duvKvTQDVg57dqXUhmPNiGhd5cyFQUlAtayNSGngm+34jWujyuMtSvar2P5VVmeJ6thzg4gbTzXiUGjG9IcBXRUSbEdw2C1iD1kThnDh/+oJZPwAIHQ6X9YAQCGA4dpkyjVS4k4jqcMkSSLov3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748391; c=relaxed/simple;
	bh=9ex7rKXxWaVZXUss1XyVeBt/NZJL+hv2F6gRx+KDg3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIFf1cW2K9dlIfgznq0kkcNfMiTjYr3QYNY9vqLsWH7G1dq8WwFVTkEnDUaBBLWx+LN6OkHYNXGLmWAEH3KF76WM38u2Gwz+HJlN+hS89/pkc+DON7hp1VKwoTcs+DcD0mjJkfOHGdnTGQSXwPcTvU6O6ATgSQPTh1UBBSClJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYciXEYn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748389; x=1770284389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ex7rKXxWaVZXUss1XyVeBt/NZJL+hv2F6gRx+KDg3Y=;
  b=aYciXEYnCVyLrZXpP5pQib7k4u6Ktd/XKxcAsgON61xZGWF1UpXM/+QX
   lSQfRcg2Oduc+iCwgvOm4E5UUviI7qVf6voU//0ItZLw87gfgB/47HHjJ
   aKRLiEPl4Btu4mzh8cu79rMUScJRDPLzKQKHnk8YRtcukXbzx17J8MU39
   95pEKwASl8vpUacu/PA+0yl2IPVrK5m+LVFuPn0qlS9gKv/sh469/Fed7
   WKjiw1HrEQdZPeHmIkrFZYHb50h1SP6iIcUJACZlQsH9p55nNknBIbhvk
   ZR23DQ8z4bnycqvcD21lJlkyfqcf7mOAAm2/FnEaGUj34qGw+tfSMrORZ
   w==;
X-CSE-ConnectionGUID: qinHomqWQ/OXxKsRyik1gQ==
X-CSE-MsgGUID: 58nHq/JoRsu8RJHbLLkaAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225210"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225210"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:49 -0800
X-CSE-ConnectionGUID: Mue9uWysT5+6m+8LXKhEAw==
X-CSE-MsgGUID: kF5B+T+cT8qQVfhteyHrhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845275"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 03/17] wifi: mac80211: Add support for EPCS configuration
Date: Wed,  5 Feb 2025 11:39:13 +0200
Message-Id: <20250205110958.7a90afd7e140.I3f602d65f5c1fd849d6c70b12307dda33aa91ccb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for configuring EPCS state:

- When EPCS is enabled, send an EPCS enable request action frame
  to the AP. When the AP replies with EPCS enable response, enable
  EPCS by applying the QoS parameters provided by the AP. Do so for
  all the valid MLD links. Once EPCS is enabled, support processing
  of unsolicited EPCS enable response frames.
- When EPCS is disabled, send an EPCS teardown request to the AP
  and apply the QoS parameters as obtained from the last received
  beacons. Do so for all the valid links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h  |   7 +
 include/net/mac80211.h     |   3 +-
 net/mac80211/cfg.c         |   9 ++
 net/mac80211/ieee80211_i.h |  11 ++
 net/mac80211/iface.c       |   8 +
 net/mac80211/mlme.c        | 291 ++++++++++++++++++++++++++++++++++++-
 net/mac80211/rx.c          |  17 +++
 7 files changed, 344 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16741e542e81..8f35a3a5211c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1543,6 +1543,10 @@ struct ieee80211_mgmt {
 					u8 count;
 					u8 variable[];
 				} __packed ml_reconf_resp;
+				struct {
+					u8 action_code;
+					u8 variable[];
+				} __packed epcs;
 			} u;
 		} __packed action;
 		DECLARE_FLEX_ARRAY(u8, body); /* Generic frame body */
@@ -5570,6 +5574,9 @@ static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
 	       fixed + prof->sta_info_len - 1 <= len;
 }
 
+#define IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID			0x000f
+#define IEEE80211_EPCS_ENA_RESP_BODY_LEN                        3
+
 static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
 {
 	const struct ieee80211_ttlm_elem *t2l = (const void *)data;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c3ed2fcff8b7..a3a0de4a5d63 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -702,6 +702,7 @@ struct ieee80211_parsed_tpe {
  * @tpe: transmit power envelope information
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @epcs_support: does this BSS support EPCS
  * @csa_active: marks whether a channel switch is going on.
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
@@ -823,7 +824,7 @@ struct ieee80211_bss_conf {
 
 	u8 pwr_reduction;
 	bool eht_support;
-
+	bool epcs_support;
 	bool csa_active;
 
 	bool mu_mimo_owner;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9351c64608a9..e8f975e747e0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5197,6 +5197,14 @@ ieee80211_assoc_ml_reconf(struct wiphy *wiphy, struct net_device *dev,
 	return ieee80211_mgd_assoc_ml_reconf(sdata, add_links, rem_links);
 }
 
+static int
+ieee80211_set_epcs(struct wiphy *wiphy, struct net_device *dev, bool enable)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	return ieee80211_mgd_set_epcs(sdata, enable);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5312,4 +5320,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_ttlm = ieee80211_set_ttlm,
 	.get_radio_mask = ieee80211_get_radio_mask,
 	.assoc_ml_reconf = ieee80211_assoc_ml_reconf,
+	.set_epcs = ieee80211_set_epcs,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7dc3f0cfc9a..fc61d294ac63 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -615,6 +615,12 @@ struct ieee80211_if_managed {
 		u16 added_links;
 		u8 dialog_token;
 	} reconf;
+
+	/* Support for epcs */
+	struct {
+		bool enabled;
+		u8 dialog_token;
+	} epcs;
 };
 
 struct ieee80211_if_ibss {
@@ -2778,6 +2784,11 @@ int ieee80211_req_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
+int ieee80211_mgd_set_epcs(struct ieee80211_sub_if_data *sdata, bool enable);
+void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_mgmt *mgmt, size_t len);
+void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_mgmt *mgmt, size_t len);
 
 int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_assoc_link *add_links,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 0ea7e77860b7..90cb09283ffe 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1564,6 +1564,14 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				ieee80211_process_ml_reconf_resp(sdata, mgmt,
 								 skb->len);
 				break;
+			case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP:
+				ieee80211_process_epcs_ena_resp(sdata, mgmt,
+								skb->len);
+				break;
+			case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN:
+				ieee80211_process_epcs_teardown(sdata, mgmt,
+								skb->len);
+				break;
 			default:
 				break;
 			}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6feb4ce2c90d..aaf84c52cd2d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3794,6 +3794,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	/* other links will be destroyed */
 	sdata->deflink.conf->bss = NULL;
+	sdata->deflink.conf->epcs_support = false;
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 
 	netif_carrier_off(sdata->dev);
@@ -3980,6 +3981,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	 * when the flow started.
 	 */
 	ieee80211_ml_reconf_reset(sdata);
+
+	ifmgd->epcs.enabled = false;
+	ifmgd->epcs.dialog_token = 0;
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -4848,6 +4852,82 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT);
 }
 
+static void ieee80211_epcs_changed(struct ieee80211_sub_if_data *sdata,
+				   bool enabled)
+{
+	/* in any case this is called, dialog token should be reset */
+	sdata->u.mgd.epcs.dialog_token = 0;
+
+	if (sdata->u.mgd.epcs.enabled == enabled)
+		return;
+
+	sdata->u.mgd.epcs.enabled = enabled;
+	cfg80211_epcs_changed(sdata->dev, enabled);
+}
+
+static void ieee80211_epcs_teardown(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	u8 link_id;
+
+	if (!sdata->u.mgd.epcs.enabled)
+		return;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct ieee802_11_elems *elems;
+		struct ieee80211_link_data *link;
+		const struct cfg80211_bss_ies *ies;
+		bool ret;
+
+		rcu_read_lock();
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link || !link->conf || !link->conf->bss) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		if (link->u.mgd.disable_wmm_tracking) {
+			rcu_read_unlock();
+			ieee80211_set_wmm_default(link, false, false);
+			continue;
+		}
+
+		ies = rcu_dereference(link->conf->bss->beacon_ies);
+		if (!ies) {
+			rcu_read_unlock();
+			ieee80211_set_wmm_default(link, false, false);
+			continue;
+		}
+
+		elems = ieee802_11_parse_elems(ies->data, ies->len, false,
+					       NULL);
+		if (!elems) {
+			rcu_read_unlock();
+			ieee80211_set_wmm_default(link, false, false);
+			continue;
+		}
+
+		ret = _ieee80211_sta_wmm_params(local, link,
+						elems->wmm_param,
+						elems->wmm_param_len,
+						elems->mu_edca_param_set);
+
+		kfree(elems);
+		rcu_read_unlock();
+
+		if (!ret) {
+			ieee80211_set_wmm_default(link, false, false);
+			continue;
+		}
+
+		ieee80211_mgd_set_link_qos_params(link);
+		ieee80211_link_info_change_notify(sdata, link, BSS_CHANGED_QOS);
+	}
+}
+
 static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 					struct link_sta_info *link_sta,
 					struct cfg80211_bss *cbss,
@@ -5121,14 +5201,27 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 							    link_sta);
 
 			bss_conf->eht_support = link_sta->pub->eht_cap.has_eht;
+			bss_conf->epcs_support = bss_conf->eht_support &&
+				!!(elems->eht_cap->fixed.mac_cap_info[0] &
+				   IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS);
+
+			/* EPCS might be already enabled but a new added link
+			 * does not support EPCS. This should not really happen
+			 * in practice.
+			 */
+			if (sdata->u.mgd.epcs.enabled &&
+			    !bss_conf->epcs_support)
+				ieee80211_epcs_teardown(sdata);
 		} else {
 			bss_conf->eht_support = false;
+			bss_conf->epcs_support = false;
 		}
 	} else {
 		bss_conf->he_support = false;
 		bss_conf->twt_requester = false;
 		bss_conf->twt_protected = false;
 		bss_conf->eht_support = false;
+		bss_conf->epcs_support = false;
 	}
 
 	bss_conf->twt_broadcast =
@@ -7159,7 +7252,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	ieee80211_mgd_update_bss_param_ch_cnt(sdata, bss_conf, elems);
 
-	if (!link->u.mgd.disable_wmm_tracking &&
+	if (!sdata->u.mgd.epcs.enabled &&
+	    !link->u.mgd.disable_wmm_tracking &&
 	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
 				     elems->wmm_param_len,
 				     elems->mu_edca_param_set))
@@ -10334,3 +10428,198 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	kfree(data);
 	return err;
 }
+
+static bool ieee80211_mgd_epcs_supp(struct ieee80211_sub_if_data *sdata)
+{
+	unsigned long valid_links = sdata->vif.valid_links;
+	u8 link_id;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!ieee80211_vif_is_mld(&sdata->vif))
+		return false;
+
+	for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *bss_conf =
+			sdata_dereference(sdata->vif.link_conf[link_id], sdata);
+
+		if (WARN_ON(!bss_conf) || !bss_conf->epcs_support)
+			return false;
+	}
+
+	return true;
+}
+
+int ieee80211_mgd_set_epcs(struct ieee80211_sub_if_data *sdata, bool enable)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	int frame_len = offsetofend(struct ieee80211_mgmt,
+				    u.action.u.epcs) + (enable ? 1 : 0);
+
+	if (!ieee80211_mgd_epcs_supp(sdata))
+		return -EINVAL;
+
+	if (sdata->u.mgd.epcs.enabled == enable &&
+	    !sdata->u.mgd.epcs.dialog_token)
+		return 0;
+
+	/* Do not allow enabling EPCS if the AP didn't respond yet.
+	 * However, allow disabling EPCS in such a case.
+	 */
+	if (sdata->u.mgd.epcs.dialog_token && enable)
+		return -EALREADY;
+
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom + frame_len);
+	if (!skb)
+		return -ENOBUFS;
+
+	skb_reserve(skb, local->hw.extra_tx_headroom);
+	mgmt = skb_put_zero(skb, frame_len);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
+	if (enable) {
+		u8 *pos = mgmt->u.action.u.epcs.variable;
+
+		mgmt->u.action.u.epcs.action_code =
+			WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_REQ;
+
+		*pos = ++sdata->u.mgd.dialog_token_alloc;
+		sdata->u.mgd.epcs.dialog_token = *pos;
+	} else {
+		mgmt->u.action.u.epcs.action_code =
+			WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN;
+
+		ieee80211_epcs_teardown(sdata);
+		ieee80211_epcs_changed(sdata, false);
+	}
+
+	ieee80211_tx_skb(sdata, skb);
+	return 0;
+}
+
+static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
+			      struct ieee802_11_elems *elems)
+{
+	const struct element *sub;
+	size_t scratch_len = elems->ml_epcs_len;
+	u8 *scratch __free(kfree) = kzalloc(scratch_len, GFP_KERNEL);
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_epcs)
+		return;
+
+	if (WARN_ON(!scratch))
+		return;
+
+	/* Directly parse the sub elements as the common information doesn't
+	 * hold any useful information.
+	 */
+	for_each_mle_subelement(sub, (const u8 *)elems->ml_epcs,
+				elems->ml_epcs_len) {
+		struct ieee80211_link_data *link;
+		struct ieee802_11_elems *link_elems __free(kfree);
+		u8 *pos = (void *)sub->data;
+		u16 control;
+		ssize_t len;
+		u8 link_id;
+
+		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
+			continue;
+
+		if (sub->datalen < sizeof(control))
+			break;
+
+		control = get_unaligned_le16(pos);
+		link_id = control & IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		len = cfg80211_defragment_element(sub, (u8 *)elems->ml_epcs,
+						  elems->ml_epcs_len,
+						  scratch, scratch_len,
+						  IEEE80211_MLE_SUBELEM_FRAGMENT);
+		if (len < sizeof(control))
+			continue;
+
+		pos = scratch + sizeof(control);
+		len -= sizeof(control);
+
+		link_elems = ieee802_11_parse_elems(pos, len, false, NULL);
+		if (!link_elems)
+			continue;
+
+		if (ieee80211_sta_wmm_params(sdata->local, link,
+					     link_elems->wmm_param,
+					     link_elems->wmm_param_len,
+					     link_elems->mu_edca_param_set))
+			ieee80211_link_info_change_notify(sdata, link,
+							  BSS_CHANGED_QOS);
+	}
+}
+
+void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_mgmt *mgmt, size_t len)
+{
+	struct ieee802_11_elems *elems __free(kfree) = NULL;
+	size_t ies_len;
+	u16 status_code;
+	u8 *pos, dialog_token;
+
+	if (!ieee80211_mgd_epcs_supp(sdata))
+		return;
+
+	/* Handle dialog token and status code */
+	pos = mgmt->u.action.u.epcs.variable;
+	dialog_token = *pos;
+	status_code = get_unaligned_le16(pos + 1);
+
+	/* An EPCS enable response with dialog token == 0 is an unsolicited
+	 * notification from the AP MLD. In such a case, EPCS should already be
+	 * enabled and status must be success
+	 */
+	if (!dialog_token &&
+	    (!sdata->u.mgd.epcs.enabled ||
+	     status_code != WLAN_STATUS_SUCCESS))
+		return;
+
+	if (sdata->u.mgd.epcs.dialog_token != dialog_token)
+		return;
+
+	sdata->u.mgd.epcs.dialog_token = 0;
+
+	if (status_code != WLAN_STATUS_SUCCESS)
+		return;
+
+	pos += IEEE80211_EPCS_ENA_RESP_BODY_LEN;
+	ies_len = len - offsetof(struct ieee80211_mgmt,
+				 u.action.u.epcs.variable) -
+		IEEE80211_EPCS_ENA_RESP_BODY_LEN;
+
+	elems = ieee802_11_parse_elems(pos, ies_len, true, NULL);
+	if (!elems)
+		return;
+
+	ieee80211_ml_epcs(sdata, elems);
+	ieee80211_epcs_changed(sdata, true);
+}
+
+void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_mgmt *mgmt, size_t len)
+{
+	if (!ieee80211_vif_is_mld(&sdata->vif) ||
+	    !sdata->u.mgd.epcs.enabled)
+		return;
+
+	ieee80211_epcs_teardown(sdata);
+	ieee80211_epcs_changed(sdata, false);
+}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1e28efe4203c..2d4b8465d8fe 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3831,6 +3831,23 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 					u.action.u.ml_reconf_resp) + 3)
 				goto invalid;
 			goto queue;
+		case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			if (len < offsetofend(typeof(*mgmt),
+					      u.action.u.epcs) +
+			    IEEE80211_EPCS_ENA_RESP_BODY_LEN)
+				goto invalid;
+			goto queue;
+		case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			if (len < offsetofend(typeof(*mgmt),
+					      u.action.u.epcs))
+				goto invalid;
+			goto queue;
 		default:
 			break;
 		}
-- 
2.34.1


