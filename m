Return-Path: <linux-wireless+bounces-19870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D396A54800
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E0618944EE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD520B1E7;
	Thu,  6 Mar 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntZLRlHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525D20468E
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257495; cv=none; b=b7uIswV4oRQ0xFru5K2kLXGpLk4eZjDeI2y1TM9IDlV1U8JMVj5k9W3EAG41bUsqmQs0aNfvQmYs2rShC8Fnshw8HCkFNpdZmDCFmwoAuQizkB6PKQoVrqTvtiW+IRRZRn+a/WQTGSJ1ZubHCFVnvScZFQxq2t+DyQgEP0xBAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257495; c=relaxed/simple;
	bh=9gXbdCw8cKuWNEKljFZzi2H2Kv0B7d2KlMpOZodb3mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdjhdr37QJA9nARxGmp1YYVb66y02scS0mKGpsO7fo/RsXEPqbfiidCVogi2VqRTYGgYWapLMK32jUzWein3fnIOIM19kpI9FbEdnVwCDH23qQ8ePNDavH0NpZ4qG84iFuWzndclHpzv9dKGjLvrnAgoAYa57ok32Ws6YzzWu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntZLRlHN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257494; x=1772793494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gXbdCw8cKuWNEKljFZzi2H2Kv0B7d2KlMpOZodb3mw=;
  b=ntZLRlHN993QW9Maa6DXhghiAT0z8dgFlJ97ZFgs9PTMqojkdyDmhDtE
   QVL9kHZv3Uc5W7xRnrP15hGFe4ub86tVvPtSXCmP3s0O4G4XfaVg4docb
   5U1st+9GCyEAGBaVFZ028nU8x92jFXcfRbIl6OZH6Qd0S91On5e60LNNu
   Rf67B8GHL+KGPcpdK3N4ByUk3/XgNxyhbQ95tOosJ3L9f/i3cU2E/z7Ug
   TeQ/YCkEUlkG/y19jS8/RPjMqrNe9B3ogjLmGJybtL8FH1MPkEGsejFpP
   STnR/eqsuf7IJwjtgWD6v5A5tXbEYX1VBGBy+1BGcrZxhwaeLG4uMLDqZ
   Q==;
X-CSE-ConnectionGUID: jQA2gWo/Sby/02UAS9w7rQ==
X-CSE-MsgGUID: itxHU6i1TIaU2nL+QmySLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45915017"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45915017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:13 -0800
X-CSE-ConnectionGUID: gZ0BJUsWTCWvKF1zUHJS5Q==
X-CSE-MsgGUID: w3E2wa2fQq26xdy7lGaCyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123138375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless 1/5] wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state
Date: Thu,  6 Mar 2025 12:37:55 +0200
Message-Id: <20250306123626.450bc40e8b04.I636ba96843c77f13309c15c9fd6eb0c5a52a7976@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
References: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We first want to flush the station to make sure we no longer have any
frames being Tx by the station before the station is moved to
un-authorized state. Failing to do that will lead to races: a frame may
be sent after the station's state has been changed.

Since the API clearly states that the driver can't fail the sta_state()
transition down the list of state, we can easily flush the station
first, and only then call the driver's sta_state().

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/sta_info.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f83268fa9f92..caa3d0236b5e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1335,9 +1335,13 @@ static int _sta_info_move_state(struct sta_info *sta,
 		sta->sta.addr, new_state);
 
 	/* notify the driver before the actual changes so it can
-	 * fail the transition
+	 * fail the transition if the state is increasing.
+	 * The driver is required not to fail when the transition
+	 * is decreasing the state, so first, do all the preparation
+	 * work and only then, notify the driver.
 	 */
-	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
+	if (new_state > sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
 		int err = drv_sta_state(sta->local, sta->sdata, sta,
 					sta->sta_state, new_state);
 		if (err)
@@ -1413,6 +1417,16 @@ static int _sta_info_move_state(struct sta_info *sta,
 		break;
 	}
 
+	if (new_state < sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
+		int err = drv_sta_state(sta->local, sta->sdata, sta,
+					sta->sta_state, new_state);
+
+		WARN_ONCE(err,
+			  "Driver is not allowed to fail if the sta_state is transitioning down the list: %d\n",
+			  err);
+	}
+
 	sta->sta_state = new_state;
 
 	return 0;
-- 
2.34.1


