Return-Path: <linux-wireless+bounces-16956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD619FF2D7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A120E161C29
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE510A1E;
	Wed,  1 Jan 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvpfzVpf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854AF9F8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707963; cv=none; b=SCzzpipslNJlmFoADyN1TToqnlknw6XlRn1tqF+lZZ1hddYK/9Guk6dY+oTXavHFpHdd7qnOXg4TCuqIRwD/ww5YUYRNtcIaXZtmt0ZXRYMHgg2jKuwU9DtHnMA4WCHxvZaBc/uDc+Uv9xPbsBwGplelb4fJgUZqNP054Qqko34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707963; c=relaxed/simple;
	bh=rusKcqkfOzlDl8iJ0ZFjQpY5Xy7NX6J/IG24+cx1ZMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuQqKDpGkopRCbo0yijhpQy3lDkqeMWLQY3BPlu++jtGzY15WfVYloL+A0bqql6ymbw338L1m2rzQnuzKXbv6Mr8ZYFIXgkNIHQSb5c/KYq8839QMGLbkDJ0ktsnIixHSW6ki7QXpMOKz0/7l3dMJ/4PxgVN4wmY2Vw0HEU4nUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvpfzVpf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707962; x=1767243962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rusKcqkfOzlDl8iJ0ZFjQpY5Xy7NX6J/IG24+cx1ZMI=;
  b=dvpfzVpfth+htotvGjjWQg1ZLC5ctDcaWVUciXjmJTrvZmSiHvyscsFq
   73Od9/lm20kOYJil0BkP1vx1suvDJeOk2opiX7iB9wSSNIlh3O3OZvAK6
   xKyLEfNSHUZ4iRri5NN0Y6m8pmiTjaL1StEXc5pbLSI10+HIYg4oAuajv
   nUeKiZZYrAgoI/CJkLd0wGpESiKeF0/X0JWghzUJlSe2xp9BVut5dlo8a
   t831ay8KpZbpWMUdxsR9TdSpmVY5WiDqKt/FjXjNyTCIlV+T19RmYdeub
   1lqleg3IwYkA9skc+RcXjZvu7hT5KxwnJeAwvsGeKFCZhgknY0D1hj/5k
   g==;
X-CSE-ConnectionGUID: kUNeFMKmSzyzwoH/Pz6nWQ==
X-CSE-MsgGUID: HSbWpf+VTfCdvE3CwnUHpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194411"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194411"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:02 -0800
X-CSE-ConnectionGUID: o1Kk7eVyRqymeWxVT+1mag==
X-CSE-MsgGUID: HaZiMQS2Tc6wI5UePli+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618889"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 06/19] wifi: cfg80211: scan: skip duplicate RNR entries
Date: Wed,  1 Jan 2025 07:05:26 +0200
Message-Id: <20250101070249.b0012c70f503.Id6fcad979434c1437340aa283abae2906345cca1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


