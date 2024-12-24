Return-Path: <linux-wireless+bounces-16788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BE9FC0F8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7C318836CF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 17:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9248212B3B;
	Tue, 24 Dec 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkoAeRKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC34212D71
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061272; cv=none; b=kgohJoysPAHyBMCLKVdhEvDe8ZKMea2dyGsDrLr33GEf98zU5+6yeKyXlq0+yLIGCI9RYwEOxu5x1ScbrKkX0qS+XZ/QRf7XPKe4Qqu/7pUvbMhGFd6+GhM9mO1mc0F64Kqc2kYLH9qpqP1QsF2NMo/YRzulduGZwv4FKKRFwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061272; c=relaxed/simple;
	bh=KXIhnbBGsCf5Y7YfLfYCegvEe30mifxMQtL+8/9JhBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eD9GJBCA2wydtknVM9uwRvCy+Rof3XwusyajcIRWjEA/JsOTVBZ2y7HnKukcjaHghp9PYLs1M1+iIaEUyt9CniSigfeVSiTjQtzqvq84YCU5Pr2IGq4gcyiX2J41eesa4jdZuIIuWmD07dmPp+QbKoodwsJI6GfwfQZGAejB9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkoAeRKA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735061271; x=1766597271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXIhnbBGsCf5Y7YfLfYCegvEe30mifxMQtL+8/9JhBg=;
  b=jkoAeRKAA5HnGqyzZ/3wjIlsG/BGx4J5nopFwtL82gxSM4b6mzy5L3fy
   /o7gZkdpSLrdIfVMUYgU0K4fpF+vC0IbBEgxHkklfmUvj3hRnIbS25re7
   bwWhJBcNWPcQC3PkeWGQ+Jk/MQGGrk7kxIHjZpRAN4fwPhn2sErqV8jca
   1ATN2TxNYtCybqXAi0mimTaRNv7FCbuLVQcQfTCRBe/GRvCfT5qRig7jP
   m6IjPbT+bkfTxNzCYGpLtwS7BvqRDcgGktTACjuGsJRHtRpJ5HFybRcG7
   gi8yOSJtU/koAvfo4/9SoGSzVf5+tQY28h8m91yTw2sYMcSAeYpqBlMUL
   g==;
X-CSE-ConnectionGUID: lCtUR/XgRBSMLL8XTpgA4g==
X-CSE-MsgGUID: lRiPL/BJS8G46FK4B0XaYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39311131"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39311131"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:51 -0800
X-CSE-ConnectionGUID: lbmbaq6XSCCna7rwUlAuUA==
X-CSE-MsgGUID: IzkyOVIyTRa0291L7MQkug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99341023"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [RESEND][PATCH 3/5] wifi: mac80211: add an option to filter a sta from being flushed
Date: Tue, 24 Dec 2024 19:27:29 +0200
Message-Id: <20241224192322.535e1fcca192.Icecf7f443bf98c9535ce8ec03b24d0d17dfbc28e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
References: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Sometimes we might want to flush only part of the stations of a vif,
for example only the TDLS ones.
To allow this, add a do_not_flush_sta argument to __sta_info_flush,
which in turn, will not flush this station.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c      | 2 +-
 net/mac80211/sta_info.c | 5 ++++-
 net/mac80211/sta_info.h | 5 +++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b8495d5f2297..cc6983b1ccc5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1671,7 +1671,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
 
-	__sta_info_flush(sdata, true, link_id);
+	__sta_info_flush(sdata, true, link_id, NULL);
 
 	ieee80211_remove_link_keys(link, &keys);
 	if (!list_empty(&keys)) {
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..82c278fdfea3 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1567,7 +1567,7 @@ void sta_info_stop(struct ieee80211_local *local)
 
 
 int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
-		     int link_id)
+		     int link_id, struct sta_info *do_not_flush_sta)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta, *tmp;
@@ -1585,6 +1585,9 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
 		    (!vlans || sdata->bss != sta->sdata->bss))
 			continue;
 
+		if (sta == do_not_flush_sta)
+			continue;
+
 		if (link_id >= 0 && sta->sta.valid_links &&
 		    !(sta->sta.valid_links & BIT(link_id)))
 			continue;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9f89fb5bee37..d4673e729525 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -899,9 +899,10 @@ void sta_info_stop(struct ieee80211_local *local);
  * @link_id: if given (>=0), all those STA entries using @link_id only
  *	     will be removed. If -1 is passed, all STA entries will be
  *	     removed.
+ * @do_not_flush_sta: a station that shouldn't be flushed.
  */
 int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
-		     int link_id);
+		     int link_id, struct sta_info *do_not_flush_sta);
 
 /**
  * sta_info_flush - flush matching STA entries from the STA table
@@ -916,7 +917,7 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
 static inline int sta_info_flush(struct ieee80211_sub_if_data *sdata,
 				 int link_id)
 {
-	return __sta_info_flush(sdata, false, link_id);
+	return __sta_info_flush(sdata, false, link_id, NULL);
 }
 
 void sta_set_rate_info_tx(struct sta_info *sta,
-- 
2.34.1


