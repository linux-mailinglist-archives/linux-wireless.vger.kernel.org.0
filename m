Return-Path: <linux-wireless+bounces-19857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3430A54790
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F247A45FA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93301FF1AA;
	Thu,  6 Mar 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAuj67CQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D61EA7C5
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256328; cv=none; b=igKN77cNI/Vq/nNIqlI4yY55n5UC8v1aPFAGlagq/SOMRMgsE+o910MS/9ujhz4KK/kJ2CsUEefZwiNhUYTSziUlaHVsjO2WhHUT1+t7w2Cm+9r9uV8aa7SeWUIRt4+li7kavcvin85O6f9JJydIYD1xluCjVUUFyJ8pbVCVHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256328; c=relaxed/simple;
	bh=9gXbdCw8cKuWNEKljFZzi2H2Kv0B7d2KlMpOZodb3mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kazsQ56Y+OC7oAn5FPw88FDjg9EvJiesvQvYo0MSVaYlJSAy2MYg9XARm0Emn9TTPxftpySoVYFV6fT6WTU2pGF+WPZbrNpGF4DW1CSos8csdc5rfubu66SEHIJJ2QalSpt1AAZwkk6buiVndzkGkMGbfUb7b+FvSwEA9HwdtkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAuj67CQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256328; x=1772792328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gXbdCw8cKuWNEKljFZzi2H2Kv0B7d2KlMpOZodb3mw=;
  b=TAuj67CQFx3yzNwyo+LfyabfaIB7AZotFcp40qr4fNu3S8hDBLcLv54l
   dke/ZpsnIYgheIbhNoasuz/6/DqeK5ELACZKSQny66KVrzmbiiUqK6h6o
   N1wFzo8IjtAVYVZh0xSLyBg1zkKWpk1i0BRdN98J0ZbLD0+51S2Ea+veV
   wHV84R6D9MErY2GTvfeF3PMJeAk+VmbtjhnNp/fjhpe1EPmIl2SeKedsc
   WOhVYk6EHv7OUx2ynobzw8u+9E7uNgElTZiMNxkGY5f0CNDujiZ+DITGA
   pNNwTkKCtjAn2OUeKSmgziId70hqwUP+kNdrog2S9AgM1Wv6Uau/c5uaA
   Q==;
X-CSE-ConnectionGUID: AKAI7zf9Rd6d3r4B6SlAwQ==
X-CSE-MsgGUID: ElX5ap9UTL6/pf7MuhHzvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46181361"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46181361"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:47 -0800
X-CSE-ConnectionGUID: CjRJGaLTQd+CzpGkhxO0Eg==
X-CSE-MsgGUID: K7G1v1j/QQGq2TMIvHRt3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118705699"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state
Date: Thu,  6 Mar 2025 12:18:27 +0200
Message-Id: <20250306121409.450bc40e8b04.I636ba96843c77f13309c15c9fd6eb0c5a52a7976@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
References: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
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


