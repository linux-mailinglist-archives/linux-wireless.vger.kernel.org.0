Return-Path: <linux-wireless+bounces-27095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABDB48BDB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1B41B257CD
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BA3019C3;
	Mon,  8 Sep 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9IMAlD2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A73019CE
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330037; cv=none; b=YgWejSIfsB7qciU52uH6aF6leiQfN3VlngWgao5Lddr0lBggCK8YWf7z15DdbVH9gcJ3MbARwVpe7/MSXp2m4BU8Qb331irnjMN4vW2WJtiJp8xNiMV82ebKHvJqUogJ1ilaC5yLeMun1KHGm9H6bsaqOM0DNcXyhLVKak4GZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330037; c=relaxed/simple;
	bh=BcR1hC6yUa3Gde6Pya5lLv5mudqgrca2KbEdlUB/+ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdXzA06TYmm9UWPf76Uu4WU7GGIV6xKRB581Hf+rpgMl1YQhuF0sZLYy0Ppse4bBrBjMw91XU2mdq1kWWpWkIslIjt4KK+wfGnPevAZXYFmbw6nuFwaJzxOgWFUAEfhyQ9siF6Cd1pyI1wemPVWK2GIQNZpUpzyrcn0b5u7WlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9IMAlD2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330036; x=1788866036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcR1hC6yUa3Gde6Pya5lLv5mudqgrca2KbEdlUB/+ks=;
  b=N9IMAlD2SIIdPQKkZr/JDkY4hl7IzfQOvVyC1URP0fvpBeG0bmfz+pzd
   a5aLLsZlPwXHXsx7JTaGD/DMkiJj8OYeHVjfqVk49MCZKQkMGGe9pS4H+
   DB1NAt8/UZEoMdwSomlVbhEpBo/s4fI9tL8fdaROhYTo4at+CH14TAKg2
   fAiiCVU79cyBiEBbVDO+lOs1WiPBEADrrFeK1JjrRak4XA3PXorfIfHja
   LDMkPxd6MOqCDVT1knaWSyxtXdMbjcEJClxCc2d8EHv1E56GvGB7X6Fmx
   /0E1oPmq5RWVbfHDJNhzd8njbJOz4aokPJAr9wdNE6eFxzl8weFJPNbDf
   A==;
X-CSE-ConnectionGUID: hYiLwRtbTIOiyk58fl1fmA==
X-CSE-MsgGUID: dpcVZ1ZSTHOLFqSLnZuPaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037930"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:54 -0700
X-CSE-ConnectionGUID: 8k01X4qHQXq+fW5YqWDK7A==
X-CSE-MsgGUID: 9aSyojiUTdiZ+4OaDsggIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126618"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 13/14] wifi: mac80211: Extend support for changing NAN configuration
Date: Mon,  8 Sep 2025 14:13:07 +0300
Message-Id: <20250908140015.92b530ddaedf.I2b6d6f6074e25487303fde573ce764a64f87bdcd@changeid>
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

As 'struct cfg80211_nan_config' was updated, update the relevant
logic to accommodate these changes.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 136 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 252c0804de2f..da15ccfcf4a2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -311,6 +311,96 @@ static void ieee80211_stop_p2p_device(struct wiphy *wiphy,
 	ieee80211_sdata_stop(IEEE80211_WDEV_TO_SUB_IF(wdev));
 }
 
+static void ieee80211_nan_conf_free(struct cfg80211_nan_conf *conf)
+{
+	kfree(conf->cluster_id);
+	kfree(conf->extra_nan_attrs);
+	kfree(conf->vendor_elems);
+	memset(conf, 0, sizeof(*conf));
+}
+
+static void ieee80211_stop_nan(struct wiphy *wiphy,
+			       struct wireless_dev *wdev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+
+	if (!sdata->u.nan.started)
+		return;
+
+	drv_stop_nan(sdata->local, sdata);
+	sdata->u.nan.started = false;
+
+	ieee80211_nan_conf_free(&sdata->u.nan.conf);
+
+	ieee80211_sdata_stop(sdata);
+	ieee80211_recalc_idle(sdata->local);
+}
+
+static int ieee80211_nan_conf_copy(struct cfg80211_nan_conf *dst,
+				   struct cfg80211_nan_conf *src,
+				   u32 changes)
+{
+	if (changes & CFG80211_NAN_CONF_CHANGED_PREF)
+		dst->master_pref = src->master_pref;
+
+	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS)
+		dst->bands = src->bands;
+
+	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG) {
+		dst->scan_period = src->scan_period;
+		dst->scan_dwell_time = src->scan_dwell_time;
+		dst->discovery_beacon_interval =
+			src->discovery_beacon_interval;
+		dst->enable_dw_notification = src->enable_dw_notification;
+		memcpy(&dst->band_cfgs, &src->band_cfgs,
+		       sizeof(dst->band_cfgs));
+
+		kfree(dst->cluster_id);
+		dst->cluster_id = NULL;
+
+		kfree(dst->extra_nan_attrs);
+		dst->extra_nan_attrs = NULL;
+		dst->extra_nan_attrs_len = 0;
+
+		kfree(dst->vendor_elems);
+		dst->vendor_elems = NULL;
+		dst->vendor_elems_len = 0;
+
+		if (src->cluster_id) {
+			dst->cluster_id = kmemdup(src->cluster_id, ETH_ALEN,
+						  GFP_KERNEL);
+			if (!dst->cluster_id)
+				goto no_mem;
+		}
+
+		if (src->extra_nan_attrs && src->extra_nan_attrs_len) {
+			dst->extra_nan_attrs = kmemdup(src->extra_nan_attrs,
+						       src->extra_nan_attrs_len,
+						       GFP_KERNEL);
+			if (!dst->extra_nan_attrs)
+				goto no_mem;
+
+			dst->extra_nan_attrs_len = src->extra_nan_attrs_len;
+		}
+
+		if (src->vendor_elems && src->vendor_elems_len) {
+			dst->vendor_elems = kmemdup(src->vendor_elems,
+						    src->vendor_elems_len,
+						    GFP_KERNEL);
+			if (!dst->vendor_elems)
+				goto no_mem;
+
+			dst->vendor_elems_len = src->vendor_elems_len;
+		}
+	}
+
+	return 0;
+
+no_mem:
+	ieee80211_nan_conf_free(dst);
+	return -ENOMEM;
+}
+
 static int ieee80211_start_nan(struct wiphy *wiphy,
 			       struct wireless_dev *wdev,
 			       struct cfg80211_nan_conf *conf)
@@ -340,33 +430,22 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 	sdata->u.nan.started = true;
 	ieee80211_recalc_idle(sdata->local);
 
-	sdata->u.nan.conf.master_pref = conf->master_pref;
-	sdata->u.nan.conf.bands = conf->bands;
+	ret = ieee80211_nan_conf_copy(&sdata->u.nan.conf, conf, 0xFFFFFFFF);
+	if (ret) {
+		ieee80211_stop_nan(wiphy, wdev);
+		return ret;
+	}
 
 	return 0;
 }
 
-static void ieee80211_stop_nan(struct wiphy *wiphy,
-			       struct wireless_dev *wdev)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-
-	if (!sdata->u.nan.started)
-		return;
-
-	drv_stop_nan(sdata->local, sdata);
-	sdata->u.nan.started = false;
-	ieee80211_sdata_stop(sdata);
-	ieee80211_recalc_idle(sdata->local);
-}
-
 static int ieee80211_nan_change_conf(struct wiphy *wiphy,
 				     struct wireless_dev *wdev,
 				     struct cfg80211_nan_conf *conf,
 				     u32 changes)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-	struct cfg80211_nan_conf new_conf;
+	struct cfg80211_nan_conf new_conf = {};
 	int ret = 0;
 
 	if (sdata->vif.type != NL80211_IFTYPE_NAN)
@@ -375,17 +454,28 @@ static int ieee80211_nan_change_conf(struct wiphy *wiphy,
 	if (!ieee80211_sdata_running(sdata))
 		return -ENETDOWN;
 
-	new_conf = sdata->u.nan.conf;
+	if (!changes)
+		return 0;
 
-	if (changes & CFG80211_NAN_CONF_CHANGED_PREF)
-		new_conf.master_pref = conf->master_pref;
+	/* First make a full copy of the previous configuration and then apply
+	 * the changes. This might be a little wasteful, but it is simpler.
+	 */
+	ret = ieee80211_nan_conf_copy(&new_conf, &sdata->u.nan.conf,
+				      0xFFFFFFFF);
+	if (ret < 0)
+		return ret;
 
-	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS)
-		new_conf.bands = conf->bands;
+	ret = ieee80211_nan_conf_copy(&new_conf, conf, changes);
+	if (ret < 0)
+		return ret;
 
 	ret = drv_nan_change_conf(sdata->local, sdata, &new_conf, changes);
-	if (!ret)
+	if (ret) {
+		ieee80211_nan_conf_free(&new_conf);
+	} else {
+		ieee80211_nan_conf_free(&sdata->u.nan.conf);
 		sdata->u.nan.conf = new_conf;
+	}
 
 	return ret;
 }
-- 
2.34.1


