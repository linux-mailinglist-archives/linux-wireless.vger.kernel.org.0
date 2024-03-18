Return-Path: <linux-wireless+bounces-4858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C886987EE18
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C4281FE2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577456454;
	Mon, 18 Mar 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kivnIe/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B556453
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780859; cv=none; b=BXJZjqOzQSKki7vS1OIyu3kJfwbcwkfcu4WIbB9HAjYFK83P4EN4Z+CgSLylZmSxiNK7Z0cxIY1n+jHkw6MNk0GQju3bo4XB5c54bn+h3ku/UAI4E1UNqDlGAI9/qYSbe00pQRm1xWfA+rU02m61NsjdfrmwFf/tOnsjUU8pQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780859; c=relaxed/simple;
	bh=9Jf+1w8MpZIEe+sqnFfRIhhm8N0KbGuEhK+k7yoIgF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lutCbIAaCYdiXtUBqfYosZHVqldFVGXnZWQuokL2cpyt8d/oLNhzzg6nGzBKYTs55p1XNspGRTglMEtuNzavjJ3ZhbTgupsfEWmo4Y7AyxDXe7guQTN6iAln7zObVLteESWBDmdszrKweDxs3B/r+BVvMiVh8Y/eFE6TkeefbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kivnIe/q; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780858; x=1742316858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Jf+1w8MpZIEe+sqnFfRIhhm8N0KbGuEhK+k7yoIgF8=;
  b=kivnIe/qMSLlD0iSsOnRL8Eg/7fta31gmCl9aDPBUZKchra/4Ev6hEZL
   ozJiw/k3vfE+O5HIpFj+FsGozhJhFNjXEMRRH7Gc18Xu9gmw95zmHIxvK
   iAvRExwmmrsja/OrGyVKLb79IA+w7p5WjVwXWIBUkOTnJqLPq5LYU9UCX
   NgAEr83BmAEw12xAKSXsArLxd2DADXqVs68gHaZ1aXdLh1S3uT8/kJPHi
   2p92lb8y6g5jDaqMrX7trek6IDGfNudddRCaOBEGC7V+F1VwgImAwShxq
   RvxJDJ37OMGJqd5tGK68rMQsF0TMxru4SnJEoX8ol4w81xLzeSfFLnC15
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819496"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819496"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909960"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: mac80211: add support for tearing down negotiated TTLM
Date: Mon, 18 Mar 2024 18:53:31 +0200
Message-Id: <20240318184907.d480cbf46fcf.Idedad472469d2c27dd2a088cf80a13a1e1cf9b78@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

In order to activate a link that is currently inactive due to
a negotiated TTLM request, need to first tear down the negotiated
TTLM request.
Add support for sending TTLM teardown request and update the links
state accordingly.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     |  9 ++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 58 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/status.c      | 22 ++++++++++++++-
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 88bb781f33f6..f57c29de3a91 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7591,6 +7591,15 @@ int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
 void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 				      u16 active_links);
 
+/**
+ * ieee80211_send_teardown_neg_ttlm - tear down a negotiated TTLM request
+ * @vif: the interface on which the tear down request should be sent.
+ *
+ * This function can be used to tear down a previously accepted negotiated
+ * TTLM request.
+ */
+void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif);
+
 /* for older drivers - let's not document these ... */
 int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
 				  struct ieee80211_chanctx_conf *ctx);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b6fead612b66..925e875f9b96 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -89,6 +89,7 @@ enum ieee80211_status_data {
 	IEEE80211_STATUS_TYPE_MASK	= 0x00f,
 	IEEE80211_STATUS_TYPE_INVALID	= 0,
 	IEEE80211_STATUS_TYPE_SMPS	= 1,
+	IEEE80211_STATUS_TYPE_NEG_TTLM	= 2,
 	IEEE80211_STATUS_SUBDATA_MASK	= 0xff0,
 };
 
@@ -595,6 +596,7 @@ struct ieee80211_if_managed {
 	/* TID-to-link mapping support */
 	struct wiphy_delayed_work ttlm_work;
 	struct ieee80211_adv_ttlm_info ttlm_info;
+	struct wiphy_work teardown_ttlm_work;
 
 	/* dialog token enumerator for neg TTLM request */
 	u8 dialog_token_alloc;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 082fe2bf14fd..cd4b54e02653 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6798,6 +6798,60 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		__ieee80211_disconnect(sdata);
 }
 
+static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
+					 struct wiphy_work *work)
+{
+	u16 new_dormant_links;
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.neg_ttlm_timeout_work.work);
+
+	if (!sdata->vif.neg_ttlm.valid)
+		return;
+
+	memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
+	new_dormant_links =
+		sdata->vif.dormant_links & ~sdata->vif.suspended_links;
+	sdata->vif.suspended_links = 0;
+	ieee80211_vif_set_links(sdata, sdata->vif.valid_links,
+				new_dormant_links);
+	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_MLD_TTLM |
+					       BSS_CHANGED_MLD_VALID_LINKS);
+}
+
+void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	int frame_len = offsetofend(struct ieee80211_mgmt,
+				  u.action.u.ttlm_tear_down);
+	struct ieee80211_tx_info *info;
+
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom + frame_len);
+	if (!skb)
+		return;
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
+	mgmt->u.action.u.ttlm_tear_down.action_code =
+		WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN;
+
+	info = IEEE80211_SKB_CB(skb);
+	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+	info->status_data = IEEE80211_STATUS_TYPE_NEG_TTLM;
+	ieee80211_tx_skb(sdata, skb);
+}
+EXPORT_SYMBOL(ieee80211_send_teardown_neg_ttlm);
+
 void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb)
 {
@@ -7429,6 +7483,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 				ieee80211_tid_to_link_map_work);
 	wiphy_delayed_work_init(&ifmgd->neg_ttlm_timeout_work,
 				ieee80211_neg_ttlm_timeout_work);
+	wiphy_work_init(&ifmgd->teardown_ttlm_work,
+			ieee80211_teardown_ttlm_work);
 
 	ifmgd->flags = 0;
 	ifmgd->powersave = sdata->wdev.ps;
@@ -8618,6 +8674,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->beacon_connection_loss_work);
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->csa_connection_drop_work);
+	wiphy_work_cancel(sdata->local->hw.wiphy,
+			  &ifmgd->teardown_ttlm_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->tdls_peer_del_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 1708b33cdc5e..dd8f857a1fbc 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2021-2023  Intel Corporation
+ * Copyright 2021-2024  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -696,6 +696,23 @@ static void ieee80211_handle_smps_status(struct ieee80211_sub_if_data *sdata,
 	wiphy_work_queue(sdata->local->hw.wiphy, &link->u.mgd.recalc_smps);
 }
 
+static void
+ieee80211_handle_teardown_ttlm_status(struct ieee80211_sub_if_data *sdata,
+				      bool acked)
+{
+	if (!sdata || !ieee80211_sdata_running(sdata))
+		return;
+
+	if (!acked)
+		return;
+
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+		return;
+
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &sdata->u.mgd.teardown_ttlm_work);
+}
+
 static void ieee80211_report_used_skb(struct ieee80211_local *local,
 				      struct sk_buff *skb, bool dropped,
 				      ktime_t ack_hwtstamp)
@@ -773,6 +790,9 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 			ieee80211_handle_smps_status(sdata, acked,
 						     info->status_data);
 			break;
+		case IEEE80211_STATUS_TYPE_NEG_TTLM:
+			ieee80211_handle_teardown_ttlm_status(sdata, acked);
+			break;
 		}
 		rcu_read_unlock();
 	}
-- 
2.34.1


