Return-Path: <linux-wireless+bounces-16889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D279FE27F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0E71881C28
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CE1632EF;
	Mon, 30 Dec 2024 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGSoRjMj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE4185B76
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534579; cv=none; b=ttFemlfSXo04dqkNApwBon1mwSz5boczufN18lIXz+uI0jAst1nRvP0g1BB1mj4AOyIe/syoJVTs9jT3qNw6NeV1YEV019x/OSOgUxBysNfXSvq6PLIAhVk9muJDoxxx8HOEVRbQnYXDLAN1EqmfTdr0Z/PmQL++Bp5b70QaUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534579; c=relaxed/simple;
	bh=rusKcqkfOzlDl8iJ0ZFjQpY5Xy7NX6J/IG24+cx1ZMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUrTnvuNjpvsdcGoKsDzVr7V78eJ1tQld6CFIBh2RgLtLFE+8ZNf3c1PAw+Ip+ws6SttrN7t+uKvQzhjoQqlI+NGMKif8A/o+ezF3yemAaHCUEZcgucf+3qF95J/hQuc4e8vZPmyCh10Nvx01x95/kjkE1XK8VVJjo/A4uG4xHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGSoRjMj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534578; x=1767070578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rusKcqkfOzlDl8iJ0ZFjQpY5Xy7NX6J/IG24+cx1ZMI=;
  b=hGSoRjMjuNg73DDjHvhNtnl64O3zwpmzCY7hyObcocW/YnnIOj28gudP
   klAjR6eZ/ElubvJSY45LtNw03vgBqW3qiGRfoqdwa7742UZp9o0TNrsG3
   2cR5uYn8DtrWjE6PBIzQO6/I1Fo6Q/Brgo/bGiSeGfq907ujro1V4hXji
   RuBbx0OTDqfc9/b3wsW9GB4AF+HRHWyNbVkxGv6IhAkunoYum+FrdyJ5b
   HrP4FWalRzJIU7zFMOJGxCT/ToxiRBgGyOLwfwBBxaTA0ac/4yPjFLoNJ
   h4Il39Ubbi0he5BrRIoPwvOglH6+eoJE5Q9r/eOMB2es+jwfOzT8Dkt+U
   A==;
X-CSE-ConnectionGUID: OEtJMSn8Ti+UlY2GNz5N2w==
X-CSE-MsgGUID: /V2pit8mTo64+i0OXGeHvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405012"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405012"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:17 -0800
X-CSE-ConnectionGUID: 1JriUH5BQuy2A3vhFRXfIg==
X-CSE-MsgGUID: yqfXCGyGTMud8MFbmyf1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758889"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 06/15] wifi: cfg80211: scan: skip duplicate RNR entries
Date: Mon, 30 Dec 2024 06:55:45 +0200
Message-Id: <20241230065327.b0012c70f503.Id6fcad979434c1437340aa283abae2906345cca1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There really shouldn't be duplicate entries when we give
the list to the driver, and since we already have a list
it's easy to avoid.

While at it, remove the unnecessary allocation there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d056248c43d2..ec9c071915f3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -704,7 +704,7 @@ cfg80211_parse_colocated_ap_iter(void *_data, u8 type,
 					   bss_params)))
 		return RNR_ITER_CONTINUE;
 
-	entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN, GFP_ATOMIC);
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return RNR_ITER_ERROR;
 
@@ -713,6 +713,17 @@ cfg80211_parse_colocated_ap_iter(void *_data, u8 type,
 
 	if (!cfg80211_parse_ap_info(entry, tbtt_info, tbtt_info_len,
 				    data->ssid_elem, data->s_ssid_tmp)) {
+		struct cfg80211_colocated_ap *tmp;
+
+		/* Don't add duplicate BSSIDs on the same channel. */
+		list_for_each_entry(tmp, &data->ap_list, list) {
+			if (ether_addr_equal(tmp->bssid, entry->bssid) &&
+			    tmp->center_freq == entry->center_freq) {
+				kfree(entry);
+				return RNR_ITER_CONTINUE;
+			}
+		}
+
 		data->n_coloc++;
 		list_add_tail(&entry->list, &data->ap_list);
 	} else {
-- 
2.34.1


