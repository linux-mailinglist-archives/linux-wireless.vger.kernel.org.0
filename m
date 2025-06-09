Return-Path: <linux-wireless+bounces-23885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC5AD25B6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486C23B19C0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B721FF29;
	Mon,  9 Jun 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ife+EDJr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19B21E0AF
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494159; cv=none; b=qAjlCO/TXPGBuo83cwchl6xxxmDYE2wr9youelMe4/dGN1oPxVoT/xAxYFDuzsMrcHT8tPPiU5mlqzAHMHgJk+jN5wBHeyRC1s0wEgZ57G7r1tdo3iGgqe4mqrwaF00x6f6x4AQIzcrkMAQEOXgT78f5yBaSxvWSsTgCuYWHn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494159; c=relaxed/simple;
	bh=aeeIcwxXJvyC/M2i1WEiaQlrqCya6xanewfVDWdkOZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bclMiQscWFsImq4+1w8bwFyCX2AXETD+LfRqvVVwo1OjGoMYMqJx8awuC8lem4AH2poRSPgkZFNBlkXoMrPB/gRnkZG2NwoB7BsKE5jMXTfI5uuROxVyrb5OkjO5l5b/vsB21tnDc/DB5TckN0teSLSWHxfNJvQManN+0DtM08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ife+EDJr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494157; x=1781030157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aeeIcwxXJvyC/M2i1WEiaQlrqCya6xanewfVDWdkOZE=;
  b=ife+EDJrYFTZn4YB1MHApG5s0R5hrGet8p9hFgAdJInionOBJ92eu19W
   hyLPVlmEdqXMt+PsGi82HEusZ3PWZxgc4JhOkYUnI20Gdcmxx1iAl+hxk
   l8RC0gpc7gsVyS/8DduVgAUdxD7WMMdCJHfTl7YWFDMTRY1ZJ8J9tbKXX
   4dKqEu05yxZd0QpyJmIQUDk7HtGMZrecFX8RnbqyFu8dOpZsMxcd0q4uH
   7UDQ8ctvyyS1yUDgtHsq1x9YQy/0Of9bfF10E23P+gXZqHi8YISGaBcpa
   JdGcW7c8xCc9kGlxgA4gb/WyGKrzqT0OEMSGt45T4Dn3ZZLY4p947sBnU
   A==;
X-CSE-ConnectionGUID: BaZ1vPYjTyesluMiQKDCRA==
X-CSE-MsgGUID: sE4tX5eASfqDlXD3EX+GFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249772"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249772"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:57 -0700
X-CSE-ConnectionGUID: XysArW1ATjWAlsqS5n+1Iw==
X-CSE-MsgGUID: 35EwuqnJT629lgZH7I0cuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732520"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: mac80211: remove DISALLOW_PUNCTURING_5GHZ code
Date: Mon,  9 Jun 2025 21:35:22 +0300
Message-Id: <20250609213231.4dff5fb8890f.Ie531f912b252a0042c18c0734db50c3afe1adfb5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since iwlwifi was the only driver using this and no
longer does, we can remove all this code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 3 ---
 net/mac80211/debugfs.c | 3 +--
 net/mac80211/mlme.c    | 4 ----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 27a665b49712..4a4c9019805e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2850,8 +2850,6 @@ struct ieee80211_txq {
  *
  * @IEEE80211_HW_DISALLOW_PUNCTURING: HW requires disabling puncturing in EHT
  *	and connecting with a lower bandwidth instead
- * @IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ: HW requires disabling puncturing in
- *	EHT in 5 GHz and connecting with a lower bandwidth instead
  *
  * @IEEE80211_HW_HANDLES_QUIET_CSA: HW/driver handles quieting for CSA, so
  *	no need to stop queues. This really should be set by a driver that
@@ -2921,7 +2919,6 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DETECTS_COLOR_COLLISION,
 	IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX,
 	IEEE80211_HW_DISALLOW_PUNCTURING,
-	IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
 	IEEE80211_HW_STRICT,
 
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 69e03630f64c..e8b78ec682da 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018 - 2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2018 - 2019, 2021-2025 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -490,7 +490,6 @@ static const char *hw_flag_names[] = {
 	FLAG(DETECTS_COLOR_COLLISION),
 	FLAG(MLO_MCAST_MULTI_LINK_TX),
 	FLAG(DISALLOW_PUNCTURING),
-	FLAG(DISALLOW_PUNCTURING_5GHZ),
 	FLAG(HANDLES_QUIET_CSA),
 	FLAG(STRICT),
 #undef FLAG
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ef15a60ef522..85f1d101fea3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -776,10 +776,6 @@ static bool ieee80211_chandef_usable(struct ieee80211_sub_if_data *sdata,
 	    ieee80211_hw_check(&sdata->local->hw, DISALLOW_PUNCTURING))
 		return false;
 
-	if (chandef->punctured && chandef->chan->band == NL80211_BAND_5GHZ &&
-	    ieee80211_hw_check(&sdata->local->hw, DISALLOW_PUNCTURING_5GHZ))
-		return false;
-
 	return true;
 }
 
-- 
2.34.1


