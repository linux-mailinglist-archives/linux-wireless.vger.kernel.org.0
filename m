Return-Path: <linux-wireless+bounces-18445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40CA278D4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2827A1494
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316E216E1A;
	Tue,  4 Feb 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lANOyrbm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF812165F4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691004; cv=none; b=SzUizvr2UnDk7qGct1kqN9TdTu+woaliW1QP8vRHHMTbuBg2bCIj0w3gYrxGVZoeWmTC/C9VoddcoPLCGZsE4rO1PENBmR30O8wY4pZ+k8gqqhSvDkUTZ/H15I8KqKzaXFNifxlym3ESvMiDiPfQDBXYi7mR9lb8AG2V8PzFjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691004; c=relaxed/simple;
	bh=mEsCwKt/TGDq8TJuaCaDlH5UK/dW7n1nRU/Q/QSIMvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5SKTG2LgahZ/af4HV/AI3kS1M1DMReIrmO9QO2J/JTp1qrk/3ViK2QDnZ2J+J0X1lm+LJqul2yV8pBssm4nGcTICY13jInkDekp4QXjqh6LB9wDvGoiUrzfaTq5h6JHCeHNAAoPog2/FmsFdDL8/jKMXGp+PY/+EeFFTlHPkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lANOyrbm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691003; x=1770227003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEsCwKt/TGDq8TJuaCaDlH5UK/dW7n1nRU/Q/QSIMvA=;
  b=lANOyrbmtdYcgtP+YsJriXmzc5/l9Pl3tGJViLB+wKTBIAz/KQlqkWjx
   MVM/fsmMfNP1SQKdIJlZ/1fqVIFHr2uIG+XBRA7TftxsHHiEr3mf9leiD
   vh2uPxf4lnXQn5Q1ge7POuuMvbGktYVb7x8Wl3rEOK7v5wsvbQIJdJqq/
   buXxD9fHxkt/5qKY+bEcSBfxOxo7fg0c1Gxe0xyWSkCLCL9R+d9TEFwhf
   fbAjYuIEHXR2cAvkOve3AlLMyjn70IlcV8II3PQK1/eaf4j+/VimsNy/O
   LJ7ZLEwZ7GTadXD8ch7HvopP5tj5aboXc1PlOSoW9d+fq8oRyDWUF59R7
   A==;
X-CSE-ConnectionGUID: bvI+yW4pQWm0hM0Cze2jng==
X-CSE-MsgGUID: xuzW9Z1LQQ6pCtv1ka2o7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585379"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:42 -0800
X-CSE-ConnectionGUID: 92BaY7TATM+fXIqRZVElWA==
X-CSE-MsgGUID: oOW7mK26R8yZOK5uYx+Ngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696725"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/20] wifi: mac80211: Add processing of TTLM teardown frame
Date: Tue,  4 Feb 2025 19:42:02 +0200
Message-Id: <20250204193721.860691076786.I32df71182c25c5f84e4534f40efe1316926b8249@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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


