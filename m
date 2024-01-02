Return-Path: <linux-wireless+bounces-1403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE9822225
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A7284207
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680815E9B;
	Tue,  2 Jan 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STpvBGBl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC715E90
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224189; x=1735760189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bD6jtK27lBqaMMk3lJRPfP5wH62Cl/HpsdVRgP0azyM=;
  b=STpvBGBl0L0QfHP+jvynTksf0QROUc/OO2Q4arbPXBaFiahidk4EA8DH
   m32jOyd4DDGfZ2sAkTwXWjqDt14/m69V7eW+ts69ic+VTGAQgNsGG8ybH
   3kE3ZWsBfKu6bIIL2P6x6zEwlE4+ILHnhuoThDLl00o7IojK8tF6PTMvd
   XYyJylgsySeupajKCniIk0fshXBKs8nFi5aR1TBq0eFShFGgu+uZhXtrN
   /1FlSUholfbBaYprEZh+iLzQYeUfgspdwVayuX3gx0a2J24DLcx4rNqkV
   ZXcLLkE0/K1RckLfC4NtGLOY/Pqynfd1I+zjLbMDGdw2S04LyOelhC1xC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314318"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314318"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624549"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624549"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] wifi: mac80211: add support for negotiated TTLM request
Date: Tue,  2 Jan 2024 21:35:37 +0200
Message-Id: <20240102213313.eeb385d771df.I2a5441c14421de884dbd93d1624ce7bb2c944833@changeid>
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

Update neg_ttlm and active_links according to the new mapping,
and send a negotiated TID-to-link map request with the new mapping.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h  |  37 ++++++++++++
 include/net/mac80211.h     |   7 ++-
 net/mac80211/cfg.c         |  12 ++++
 net/mac80211/ieee80211_i.h |   8 +++
 net/mac80211/iface.c       |   4 ++
 net/mac80211/mlme.c        | 114 +++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c          |   8 +++
 7 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c311b5812df5..61dbee51025d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5023,6 +5023,43 @@ static inline u16 ieee80211_mle_get_eml_cap(const u8 *data)
 	return get_unaligned_le16(common);
 }
 
+/**
+ * ieee80211_mle_get_mld_capa_op - returns the MLD capabilities and operations.
+ * @data: pointer to the multi link EHT IE
+ *
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ *
+ * If the MLD capabilities and operations field is not present, 0 will be
+ * returned.
+ */
+static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	/*
+	 * common points now at the beginning of
+	 * ieee80211_mle_basic_common_info
+	 */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP))
+		return 0;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_EML_CAPA)
+		common += 2;
+
+	return get_unaligned_le16(common);
+}
+
 /**
  * ieee80211_mle_size_ok - validate multi-link element size
  * @data: pointer to the element data
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6490b92d5cc1..84cc66dd93c1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1810,9 +1810,11 @@ enum ieee80211_offload_flags {
  * @ps: power-save mode (STA only). This flag is NOT affected by
  *	offchannel/dynamic_ps operations.
  * @aid: association ID number, valid only when @assoc is true
- * @eml_cap: EML capabilities as described in P802.11be_D2.2 Figure 9-1002k.
+ * @eml_cap: EML capabilities as described in P802.11be_D4.1 Figure 9-1001j.
  * @eml_med_sync_delay: Medium Synchronization delay as described in
- *	P802.11be_D2.2 Figure 9-1002j.
+ *	P802.11be_D4.1 Figure 9-1001i.
+ * @mld_capa_op: MLD Capabilities and Operations per P802.11be_D4.1
+ *	Figure 9-1001k
  * @arp_addr_list: List of IPv4 addresses for hardware ARP filtering. The
  *	may filter ARP queries targeted for other addresses than listed here.
  *	The driver must allow ARP queries targeted for all address listed here
@@ -1837,6 +1839,7 @@ struct ieee80211_vif_cfg {
 	u16 aid;
 	u16 eml_cap;
 	u16 eml_med_sync_delay;
+	u16 mld_capa_op;
 
 	__be32 arp_addr_list[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	int arp_addr_cnt;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e0a4f9eecb2c..035b18a01853 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4966,6 +4966,17 @@ static int ieee80211_set_hw_timestamp(struct wiphy *wiphy,
 	return local->ops->set_hw_timestamp(&local->hw, &sdata->vif, hwts);
 }
 
+static int
+ieee80211_set_ttlm(struct wiphy *wiphy, struct net_device *dev,
+		   struct cfg80211_ttlm_params *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	return ieee80211_req_neg_ttlm(sdata, params);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5078,4 +5089,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.mod_link_station = ieee80211_mod_link_station,
 	.del_link_station = ieee80211_del_link_station,
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
+	.set_ttlm = ieee80211_set_ttlm,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0dc78ee1269b..a821f84f8bb6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -579,6 +579,10 @@ struct ieee80211_if_managed {
 	/* TID-to-link mapping support */
 	struct wiphy_delayed_work ttlm_work;
 	struct ieee80211_adv_ttlm_info ttlm_info;
+
+	/* dialog token enumerator for neg TTLM request */
+	u8 dialog_token_alloc;
+	struct wiphy_delayed_work neg_ttlm_timeout_work;
 };
 
 struct ieee80211_if_ibss {
@@ -2605,6 +2609,10 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct link_sta_info *link_sta);
 void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt, size_t len);
+void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_mgmt *mgmt, size_t len);
+int ieee80211_req_neg_ttlm(struct ieee80211_sub_if_data *sdata,
+			   struct cfg80211_ttlm_params *params);
 
 void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4a87d2d336ae..df314222c2c9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1554,6 +1554,10 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				ieee80211_process_neg_ttlm_req(sdata, mgmt,
 							       skb->len);
 				break;
+			case WLAN_PROTECTED_EHT_ACTION_TTLM_RES:
+				ieee80211_process_neg_ttlm_res(sdata, mgmt,
+							       skb->len);
+				break;
 			default:
 				break;
 			}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 71d5149ca4d6..2f81f045eb07 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -46,6 +46,8 @@
 #define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS msecs_to_jiffies(100)
 #define IEEE80211_ADV_TTLM_ST_UNDERFLOW 0xff00
 
+#define IEEE80211_NEG_TTLM_REQ_TIMEOUT (HZ / 5)
+
 static int max_nullfunc_tries = 2;
 module_param(max_nullfunc_tries, int, 0644);
 MODULE_PARM_DESC(max_nullfunc_tries,
@@ -3087,6 +3089,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->neg_ttlm_timeout_work);
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
@@ -4984,6 +4988,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				ieee80211_mle_get_eml_cap(eht_ml_elem->data + 1);
 			sdata->vif.cfg.eml_med_sync_delay =
 				ieee80211_mle_get_eml_med_sync_delay(eht_ml_elem->data + 1);
+			sdata->vif.cfg.mld_capa_op =
+				ieee80211_mle_get_mld_capa_op(eht_ml_elem->data + 1);
 		}
 	}
 
@@ -6510,6 +6516,19 @@ static void ieee80211_apply_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.neg_ttlm.valid = true;
 }
 
+static void ieee80211_neg_ttlm_timeout_work(struct wiphy *wiphy,
+					    struct wiphy_work *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.neg_ttlm_timeout_work.work);
+
+	sdata_info(sdata,
+		   "No negotiated TTLM response from AP, disconnecting.\n");
+
+	__ieee80211_disconnect(sdata);
+}
+
 static void
 ieee80211_neg_ttlm_add_suggested_map(struct sk_buff *skb,
 				     struct ieee80211_neg_ttlm *neg_ttlm)
@@ -6556,6 +6575,74 @@ ieee80211_neg_ttlm_add_suggested_map(struct sk_buff *skb,
 	}
 }
 
+static void
+ieee80211_send_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
+			    struct ieee80211_neg_ttlm *neg_ttlm,
+			    u8 dialog_token)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_req);
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
+	mgmt->u.action.u.ttlm_req.action_code =
+		WLAN_PROTECTED_EHT_ACTION_TTLM_REQ;
+	mgmt->u.action.u.ttlm_req.dialog_token = dialog_token;
+	ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
+	ieee80211_tx_skb(sdata, skb);
+}
+
+int ieee80211_req_neg_ttlm(struct ieee80211_sub_if_data *sdata,
+			   struct cfg80211_ttlm_params *params)
+{
+	struct ieee80211_neg_ttlm neg_ttlm = {};
+	u8 i;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif) ||
+	    !(sdata->vif.cfg.mld_capa_op &
+	      IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP))
+		return -EINVAL;
+
+	for (i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++) {
+		if ((params->dlink[i] & ~sdata->vif.valid_links) ||
+		    (params->ulink[i] & ~sdata->vif.valid_links))
+			return -EINVAL;
+
+		neg_ttlm.downlink[i] = params->dlink[i];
+		neg_ttlm.uplink[i] = params->ulink[i];
+	}
+
+	if (drv_can_neg_ttlm(sdata->local, sdata, &neg_ttlm) !=
+	    NEG_TTLM_RES_ACCEPT)
+		return -EINVAL;
+
+	ieee80211_apply_neg_ttlm(sdata, neg_ttlm);
+	sdata->u.mgd.dialog_token_alloc++;
+	ieee80211_send_neg_ttlm_req(sdata, &sdata->vif.neg_ttlm,
+				    sdata->u.mgd.dialog_token_alloc);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &sdata->u.mgd.neg_ttlm_timeout_work);
+	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+				 &sdata->u.mgd.neg_ttlm_timeout_work,
+				 IEEE80211_NEG_TTLM_REQ_TIMEOUT);
+	return 0;
+}
+
 static void
 ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 			    enum ieee80211_neg_ttlm_res ttlm_res,
@@ -6749,6 +6836,29 @@ void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	ieee80211_send_neg_ttlm_res(sdata, ttlm_res, dialog_token, &neg_ttlm);
 }
 
+void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_mgmt *mgmt, size_t len)
+{
+	if (!ieee80211_vif_is_mld(&sdata->vif) ||
+	    mgmt->u.action.u.ttlm_req.dialog_token !=
+	    sdata->u.mgd.dialog_token_alloc)
+		return;
+
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &sdata->u.mgd.neg_ttlm_timeout_work);
+
+	/* MLD station sends a TID to link mapping request, mainly to handle
+	 * BTM (BSS transition management) request, in which case it needs to
+	 * restrict the active links set.
+	 * In this case it's not expected that the MLD AP will reject the
+	 * negotiated TTLM request.
+	 * This can be better implemented in the future, to handle request
+	 * rejections.
+	 */
+	if (mgmt->u.action.u.ttlm_res.status_code != WLAN_STATUS_SUCCESS)
+		__ieee80211_disconnect(sdata);
+}
+
 void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb)
 {
@@ -7378,6 +7488,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 				ieee80211_sta_handle_tspec_ac_params_wk);
 	wiphy_delayed_work_init(&ifmgd->ttlm_work,
 				ieee80211_tid_to_link_map_work);
+	wiphy_delayed_work_init(&ifmgd->neg_ttlm_timeout_work,
+				ieee80211_neg_ttlm_timeout_work);
 
 	ifmgd->flags = 0;
 	ifmgd->powersave = sdata->wdev.ps;
@@ -8468,6 +8580,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->ml_reconf_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->neg_ttlm_timeout_work);
 
 	if (ifmgd->assoc_data)
 		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a3bb92ac2443..a5644686548a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3771,6 +3771,14 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 					      u.action.u.ttlm_req))
 				goto invalid;
 			goto queue;
+		case WLAN_PROTECTED_EHT_ACTION_TTLM_RES:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			if (len < offsetofend(typeof(*mgmt),
+					      u.action.u.ttlm_res))
+				goto invalid;
+			goto queue;
 		default:
 			break;
 		}
-- 
2.34.1


