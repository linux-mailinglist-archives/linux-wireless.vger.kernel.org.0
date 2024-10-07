Return-Path: <linux-wireless+bounces-13596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0C992AF6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612DC284A46
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2391D2B1B;
	Mon,  7 Oct 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9jEsz8k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B51D2B17
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302490; cv=none; b=hRGMxntTnvMm91U9KjA/1hOb4HAXZ/VM/2BRVMXCklT6M7fkibqaYyaM9nnWlRGdbUPsdzJIZLUdvOHOUch8sp682+GvHY3oaSBxZrixAfNyurkmvQBGk+bnnd4ZaY+esx+xQu94EtDz8JUuDH57ERjNfTjOjWvok5csokBJgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302490; c=relaxed/simple;
	bh=wXGUwY2b6ytmly0ysDizQKKp55BGx/zmYkIXsXY0QVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnjY4LLK07ntS3+GcXbGcQZCkaB9dN/iXL7ZvqHUHgo9rexE/budoeHvYTuevS6UyiH2i8lY7JUKJ4wOLGB5sOla+5RHfrLUHpWTYWGGusGRxS9j/9QrNMjgAuXERgvU2tLCgoDv/WSdSrveHK5lVt6gQQj/JvAz5sPt33L3yoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9jEsz8k; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302489; x=1759838489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wXGUwY2b6ytmly0ysDizQKKp55BGx/zmYkIXsXY0QVA=;
  b=g9jEsz8kcIV/HpufKLpke9NXS6tetMisPIQrWXPcKcL1dD0QW0pSruo8
   PI7l2hvXFGFdOzQXawptpNRYXfkegRV0/kR5jRS+Ubl+bykf79J8hZYk4
   w3k1ofngYJhUmOEqUVxuhoatadzWp2bp1NVQQBwV/UFtKLShlEFJnZCSG
   faCLIZbil4PgoQLbW56PQN0i1m9QDQAEaRWIW8A5/jSHG/CeQMEiXr3Kb
   k93c+ossVK5Ay/s3HwC+V9pHwqX1Symo+gs0U3tDs2WAa6ApqoMEpvzww
   qy1e8PjmUlR7Zgifcvwpffusd8xi0lfupgBh1TfWm3sn/5bqan1mLbqxd
   Q==;
X-CSE-ConnectionGUID: /2mTSPAJSVWY8rw1BUJUPg==
X-CSE-MsgGUID: LIZ4GLu+RE+w0Qqp5NZA2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099425"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:29 -0700
X-CSE-ConnectionGUID: 13AwtG2vQMK4ZtTQr+8wNg==
X-CSE-MsgGUID: P8O0GkEpRrKJqW6jUVG9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019279"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/14] wifi: mac80211: parse A-MSDU len from EHT capabilities
Date: Mon,  7 Oct 2024 15:00:55 +0300
Message-Id: <20241007144851.e05da59c419a.I0b1c047639160d9a96f48ab013c18ea33f5473b0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

On 2.4 GHz there's no VHT, so EHT defines its own bits for
the maximum MPDU length. Parse and store them in the link_sta.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/eht.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index ddc7acc68335..7a3116c36df9 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -2,7 +2,7 @@
 /*
  * EHT handling
  *
- * Copyright(c) 2021-2023 Intel Corporation
+ * Copyright(c) 2021-2024 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -75,4 +75,23 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
+
+	switch (u8_get_bits(eht_cap->eht_cap_elem.mac_cap_info[0],
+			    IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK)) {
+	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454:
+		link_sta->pub->agg.max_amsdu_len =
+			IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		break;
+	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991:
+		link_sta->pub->agg.max_amsdu_len =
+			IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		break;
+	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_3895:
+	default:
+		link_sta->pub->agg.max_amsdu_len =
+			IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		break;
+	}
+
+	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
-- 
2.34.1


