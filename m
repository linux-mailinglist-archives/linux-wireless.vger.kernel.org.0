Return-Path: <linux-wireless+bounces-14612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE39B3652
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248DE283682
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A221DE8B7;
	Mon, 28 Oct 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzcyDpha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16227189F20
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132362; cv=none; b=MzCv/syCujMyDIOE+7N6z736nO797WlakzzlLPHpCH1TGGwDL6jZIA5805sdmXgPXiJgovE8GUww9P1ZCFGoXHetQAnspEpRxBInhHd+h8AJqZa5i0BJyVpF5S2GwZT6iZQRwycRgYzxwPLxwjZGvU7DRaFCBFX1u0yBLpMuOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132362; c=relaxed/simple;
	bh=IfMuFgoQwtWAnKhx2RgPbBK7s6cYLiE2MKfvs6Ifzqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCCO79xv92Dv2+B9eEsr7ysWG+N++qjG/kaBl7RbtaEY3l67Ej97sVKy/C/CHNm8/5UWqjF4/Wl2ReX0GmrbGgQ2yBLvRXamzXY+RLA3ZjflhNpAT4vE2rYgyeQ97qiFE0YFUDldTLO1AWkeALh9YX91cTeez98QxkYYhVt8+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzcyDpha; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132360; x=1761668360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IfMuFgoQwtWAnKhx2RgPbBK7s6cYLiE2MKfvs6Ifzqg=;
  b=UzcyDphaEFQjobxzHXf10KSCaDn4fQr6s5IKSzsyViYhz46eiOGDzSt/
   kOsLrsHJa638lE3Yux0sfJhaP0yZNHQITlZKv3SfkF+CHlTNeS2/E9drO
   2Gn25dM057jmyp7WIzUQlD/PSIsJuHH23fJv47KGpSY0GuBd752LXkf90
   bzOYU7wLQCj/PmMjkGnTZ6J+UxHdz3GOogUa0K58NwKxKKZwq9XfsVoJ3
   ZuNIlFQ9lCxzefJApyF38YgEllgngnzxsX4J5jhPLo/0L51jmB+pR/WK/
   HDuJZqNWoU4/evA1yaZHdbQqASXyCSBMH8x1LJQ0nHXxGhqmb2Ls3QGR0
   Q==;
X-CSE-ConnectionGUID: p9YjU/mISSWbnibAPc5QqA==
X-CSE-MsgGUID: LOlbeFdaQr+qDP8hC7pXwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41099899"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41099899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:19 -0700
X-CSE-ConnectionGUID: b90UvliIQuymdFgEDUPffg==
X-CSE-MsgGUID: 7c5fd8j/Rpukn03qCVoTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81561552"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] wifi: mac80211: add an option to filter a sta from being flushed
Date: Mon, 28 Oct 2024 18:19:00 +0200
Message-Id: <20241028181512.8cef96922b5c.Icecf7f443bf98c9535ce8ec03b24d0d17dfbc28e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
References: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
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
index 6c0b228523cb..20cc46dc0f8e 100644
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


