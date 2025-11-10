Return-Path: <linux-wireless+bounces-28766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E85C46BAD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93BD0341DF9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15630FC29;
	Mon, 10 Nov 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlmBkFUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5B30F939
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779431; cv=none; b=ieoPPSruZdfecQP1Lu6gAjrmsrTZaQgLrVHvNBPhssjuZZwMpr80DZyPgHYAgFLpqbWlxwbyBntxTgNTyjNowOFv33Q/QG6nireL0K4UOrRuOxCbuINc/YjZu273eXI9HXjIGBKtknIzk5cIlj7YgDZ7aNuY6SJgzZQuFvK/pMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779431; c=relaxed/simple;
	bh=3+HhfyHE1/JCxC5DZPH3OabnVTA+zHggZgrljW1tiNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DlRvFvBtV5oYAqJNXpv3gTAsyUcW18ExemVn2bNA60FJpiFDprvHjDKtoenyuZ897mQcdhGmyJVp/OxwbZg7uuxOtOcTl3KZcPaHMORt8FvcDgv83B0hpeh97okRv+HIEZ9xpHOdKLBEuM/j0CYKjKRF6HyU8whXYVJnw9IEIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlmBkFUZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779429; x=1794315429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3+HhfyHE1/JCxC5DZPH3OabnVTA+zHggZgrljW1tiNo=;
  b=PlmBkFUZu73lGCobj07MSjvtLkeQSZnm8W2ZKlC7QeJXs3d11hA7Amc2
   dPSEIXCLcEpYnieJs5dGHU1pkOJrVikJ1HaHJDQ6Sl7mEkiIGEEhZbwva
   ehmd7YeYuk1+WXbrUpRn85BUt1xGuRfBxOq/DIanT95sQjx3Yiw+ULlh0
   VpO1d10scOlJCSHSJraL6sO3S2WPJIKTzX7Ml8Qprxtl86yvMcXUSqrWE
   S7sfDJJgMZq7MArNi/PE5Uj4B5sIEYT79itU02s0DMPfdqEznuC3UW72N
   SMi4JirugwU9VtfPLTKm2elRgTBuGiXzBvc/RlMtuJf6jSVR1SF5nXrCf
   g==;
X-CSE-ConnectionGUID: vzsfN6kUQHq49kpuBAcLMA==
X-CSE-MsgGUID: vuz+2VcxTmSTyNwre5wJMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64868618"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64868618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:57:09 -0800
X-CSE-ConnectionGUID: nA/IFPtVTmWW7jHt8TlNng==
X-CSE-MsgGUID: lWbmn1HbRxybOx0fx+cOWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193050567"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:57:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: mld: always take beacon ies in link grading
Date: Mon, 10 Nov 2025 14:57:00 +0200
Message-Id: <20251110145652.b493dbb1853a.I058ba7309c84159f640cc9682d1bda56dd56a536@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

One of the factors of a link's grade is the channel load, which is
calculated from the AP's bss load element.
The current code takes this element from the beacon for an active link,
and from bss->ies for an inactive link.

bss->ies is set to either the beacon's ies or to the probe response
ones, with preference to the probe response (meaning that if there was
even one probe response, the ies of it will be stored in bss->ies and
won't be overiden by the beacon ies).

The probe response can be very old, i.e. from the connection time,
where a beacon is updated before each link selection (which is
triggered only after a passive scan).

In such case, the bss load element in the probe response will not
include the channel load caused by the STA, where the beacon will.

This will cause the inactive link to always have a lower channel
load, and therefore an higher grade than the active link's one.

This causes repeated link switches, causing the throughput to drop.

Fix this by always taking the ies from the beacon, as those are for
sure new.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 960dcd208f00..4db71dcf82e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -698,18 +698,13 @@ static int
 iwl_mld_get_chan_load_from_element(struct iwl_mld *mld,
 				   struct ieee80211_bss_conf *link_conf)
 {
-	struct ieee80211_vif *vif = link_conf->vif;
 	const struct cfg80211_bss_ies *ies;
 	const struct element *bss_load_elem = NULL;
 	const struct ieee80211_bss_load_elem *bss_load;
 
 	guard(rcu)();
 
-	if (ieee80211_vif_link_active(vif, link_conf->link_id))
-		ies = rcu_dereference(link_conf->bss->beacon_ies);
-	else
-		ies = rcu_dereference(link_conf->bss->ies);
-
+	ies = rcu_dereference(link_conf->bss->beacon_ies);
 	if (ies)
 		bss_load_elem = cfg80211_find_elem(WLAN_EID_QBSS_LOAD,
 						   ies->data, ies->len);
-- 
2.34.1


