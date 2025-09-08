Return-Path: <linux-wireless+bounces-27092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4240B48BD8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB051B26F54
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A703019B0;
	Mon,  8 Sep 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKwSI5xX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF03019B1
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330034; cv=none; b=anuWeP/UMMiYcMzgT0q2du9VTM8/2K2jPhNJ2JRznaANnu8p4mu2wx+ow2FjsEpcjiuNttBpvO0XjvKPyk8YoUg3f4A/EgTEJTQlh4b//xUotwDwm8xBEIluh3/CUvmlTzvq89vJy5Voo/roBvus0Ytjj1cUhPFDcDKRcOc/7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330034; c=relaxed/simple;
	bh=XudZVpnk6HhvSTe10bMDertpByToOJNbufGCv5KIbX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1hIbzfGTu+Otid7V63KYKkXcoJD6WVIqgnX8G//sg+kXOzc/uyH3GTCp0Qi20d436QHTg+G+RJuLZ38oKfuizwjoyS/Wr6zQYPxIfccyf85ZyVlV1dppf7FqEv6yzoreGutxWTJeLhFtTA7Y4ohxPyfRLHIjFkRTb5gOt1c3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKwSI5xX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330033; x=1788866033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XudZVpnk6HhvSTe10bMDertpByToOJNbufGCv5KIbX4=;
  b=WKwSI5xXeHVdfmm/Kv63yajET1tPZIUYUW0L70WfvNN6+FVtyFkkPgl+
   D9QEcxkfelqY8y+vnFHVbtQkcVSzHy6Hdx/M2+qtKuB1TaNMi+h6mrEwR
   YS8s3p6GTV2PjmdXquVBKO0UqAjiEOwFNGQHTXXkbpg7bXPeJwv6ZOPsY
   Y3U2kiwZAu3+9cFanVtbPZMdxzRAEA4ULww6jF/7q75Qs/59dqAWNnJmU
   ljrsE2GpGm82OD4Z/gDWaDikyAJznLEAztzmQEtFB0zwP96iJF1FxNEzN
   oTwuVlAzxCNBx0ICuP6qtpCEZXWmvN5AxCuN8d+hjt/ZgoWHXmgtYCW0+
   A==;
X-CSE-ConnectionGUID: Cltr/wwLTO+hS16N1KvibA==
X-CSE-MsgGUID: VRrYBMdGRpWIo8RDhHSusA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037915"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037915"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:50 -0700
X-CSE-ConnectionGUID: vGvQTyW2QgqWu2aBBrB9dw==
X-CSE-MsgGUID: xubVK8PQSCG4IeuJ0kRq+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126600"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/14] wifi: mac80211: Track NAN interface start/stop
Date: Mon,  8 Sep 2025 14:13:04 +0300
Message-Id: <20250908140015.2711d62fce22.I9b9f826490e50967a66788d713b0eba985879873@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

In case that NAN is started, mark the device as non idle,
and set LED triggering similar to scan and ROC. Set the
device to idle once NAN is stopped.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c         | 20 +++++++++++++++++---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/iface.c       |  9 +++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b26f61f13605..252c0804de2f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -320,6 +320,9 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
+	if (sdata->u.nan.started)
+		return -EALREADY;
+
 	ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
 	if (ret < 0)
 		return ret;
@@ -329,12 +332,18 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 		return ret;
 
 	ret = drv_start_nan(sdata->local, sdata, conf);
-	if (ret)
+	if (ret) {
 		ieee80211_sdata_stop(sdata);
+		return ret;
+	}
 
-	sdata->u.nan.conf = *conf;
+	sdata->u.nan.started = true;
+	ieee80211_recalc_idle(sdata->local);
 
-	return ret;
+	sdata->u.nan.conf.master_pref = conf->master_pref;
+	sdata->u.nan.conf.bands = conf->bands;
+
+	return 0;
 }
 
 static void ieee80211_stop_nan(struct wiphy *wiphy,
@@ -342,8 +351,13 @@ static void ieee80211_stop_nan(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+	if (!sdata->u.nan.started)
+		return;
+
 	drv_stop_nan(sdata->local, sdata);
+	sdata->u.nan.started = false;
 	ieee80211_sdata_stop(sdata);
+	ieee80211_recalc_idle(sdata->local);
 }
 
 static int ieee80211_nan_change_conf(struct wiphy *wiphy,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 07f5fb11569b..5ccb22b5ecf7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -985,11 +985,13 @@ struct ieee80211_if_mntr {
  * struct ieee80211_if_nan - NAN state
  *
  * @conf: current NAN configuration
+ * @started: true iff NAN is started
  * @func_lock: lock for @func_inst_ids
  * @function_inst_ids: a bitmap of available instance_id's
  */
 struct ieee80211_if_nan {
 	struct cfg80211_nan_conf conf;
+	bool started;
 
 	/* protects function_inst_ids */
 	spinlock_t func_lock;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 07ba68f7cd81..4a9175d9f51c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -107,6 +107,7 @@ static u32 __ieee80211_recalc_idle(struct ieee80211_local *local,
 {
 	bool working, scanning, active;
 	unsigned int led_trig_start = 0, led_trig_stop = 0;
+	struct ieee80211_sub_if_data *iter;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -117,6 +118,14 @@ static u32 __ieee80211_recalc_idle(struct ieee80211_local *local,
 	working = !local->ops->remain_on_channel &&
 		  !list_empty(&local->roc_list);
 
+	list_for_each_entry(iter, &local->interfaces, list) {
+		if (iter->vif.type == NL80211_IFTYPE_NAN &&
+		    iter->u.nan.started) {
+			working = true;
+			break;
+		}
+	}
+
 	scanning = test_bit(SCAN_SW_SCANNING, &local->scanning) ||
 		   test_bit(SCAN_ONCHANNEL_SCANNING, &local->scanning);
 
-- 
2.34.1


