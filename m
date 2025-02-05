Return-Path: <linux-wireless+bounces-18499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE96A286CC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2366188A33F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C4122A7FD;
	Wed,  5 Feb 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi379PeJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BB22A7F4
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748394; cv=none; b=D8AyUYAJ4CPDwIfk4Xj1hNIYYmohq3TjHkQ+XJusXi1ToS6p6qMjl1ViyMz+xAp+f+rlfZdoISL6nllXUOkE0Nl1CDtX0287a2NxlIfPUPhqUtJeOxE0G3MbKz+hm1fkMfUlN595FBgBvWg3rCOMZjD6TrNBCOJ7rXGkYsKsoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748394; c=relaxed/simple;
	bh=mEsCwKt/TGDq8TJuaCaDlH5UK/dW7n1nRU/Q/QSIMvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oxmj/U+N42/2bAHNorQhA6mAOOgwfXNOG4owbLnF55s8onxrDkXmzfkfadTfJGy/3hu4CfQLmhYF00c7G/jpfHG/gHPbFIrDrkRDBwg5y1/ySYWMQcGT8LxJXgmpmnWME23bD3400NbP4UhMkuwRXgg8/3XHveRdoNsry9+xlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi379PeJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748393; x=1770284393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEsCwKt/TGDq8TJuaCaDlH5UK/dW7n1nRU/Q/QSIMvA=;
  b=bi379PeJ/KdrQYCjlyT+ZfM4skGWPrQkZXru9mqEZWTJ0P/MHGnBIVPN
   IrjPQR6BogbQROBoHH3jSeqqkvJ/YMcoI9VKOZjNTUM+rsPrn7blKVaY8
   EKlM5FSxTtbUxxDQG7sxn3nFhE2sPJ/8G3NDtbu5gZ2QmkvX/tRcTjlt2
   6UnhRciOazESNjw62vvF6o17UrbgDiYZJ984QNqHQpZu1ZZ1/zFy2yG/T
   xTHkpXYk5Uho7GthefB81f5DXy0GC3hyLg/63LSFPxAF7kI6Kp9seoIqz
   WnTGPiRjOv6c3YlJLLd/XwEwzLoiUca6ZcQrhhd7MK9uhhFgaNuDUEo4p
   A==;
X-CSE-ConnectionGUID: 2QrwkUfzTDqsVs9ZNxVP8Q==
X-CSE-MsgGUID: VS41ajYXRLuAlN654/TvKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225220"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225220"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:53 -0800
X-CSE-ConnectionGUID: BM3K5uUTRzCUzQPd5AGQDQ==
X-CSE-MsgGUID: Sf0wbbDLTjCsxzJHycdFgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845283"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/17] wifi: mac80211: Add processing of TTLM teardown frame
Date: Wed,  5 Feb 2025 11:39:15 +0200
Message-Id: <20250205110958.860691076786.I32df71182c25c5f84e4534f40efe1316926b8249@changeid>
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

Add processing of negotiated TTLM tear down frame.
Handle this frame similar to the way a locally initiated
tear down is handled.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/iface.c       |  3 +++
 net/mac80211/mlme.c        | 16 +++++++++++-----
 net/mac80211/rx.c          |  8 ++++++++
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fc61d294ac63..cee534aac668 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2780,6 +2780,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt, size_t len);
 int ieee80211_req_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_ttlm_params *params);
+void ieee80211_process_ttlm_teardown(struct ieee80211_sub_if_data *sdata);
 
 void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 90cb09283ffe..f8aaa2db52ce 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1560,6 +1560,9 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				ieee80211_process_neg_ttlm_res(sdata, mgmt,
 							       skb->len);
 				break;
+			case WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN:
+				ieee80211_process_ttlm_teardown(sdata);
+				break;
 			case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
 				ieee80211_process_ml_reconf_resp(sdata, mgmt,
 								 skb->len);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index aaf84c52cd2d..04e1ea43b2df 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7705,13 +7705,9 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		__ieee80211_disconnect(sdata);
 }
 
-static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
-					 struct wiphy_work *work)
+void ieee80211_process_ttlm_teardown(struct ieee80211_sub_if_data *sdata)
 {
 	u16 new_dormant_links;
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
-			     u.mgd.teardown_ttlm_work);
 
 	if (!sdata->vif.neg_ttlm.valid)
 		return;
@@ -7726,6 +7722,16 @@ static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
 					       BSS_CHANGED_MLD_VALID_LINKS);
 }
 
+static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
+					 struct wiphy_work *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.teardown_ttlm_work);
+
+	ieee80211_process_ttlm_teardown(sdata);
+}
+
 void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2d4b8465d8fe..56f6a69e7cba 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3819,6 +3819,14 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 					      u.action.u.ttlm_res))
 				goto invalid;
 			goto queue;
+		case WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			if (len < offsetofend(typeof(*mgmt),
+					      u.action.u.ttlm_tear_down))
+				goto invalid;
+			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
-- 
2.34.1


