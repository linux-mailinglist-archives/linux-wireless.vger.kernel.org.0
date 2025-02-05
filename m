Return-Path: <linux-wireless+bounces-18507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A11A286D0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9733165F00
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0422ACC6;
	Wed,  5 Feb 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgNwVPSl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0B22A7E9
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748415; cv=none; b=OaQsJMTuRvqbUAcvX7Yu61M/YF6jnfXOSACoQ5h5tzUZjvYJHYQsk6rNN6aGVjXWnJ5Jv0MD6VMWXLi4AeJwBsMSMtQfwWVQEhEioGa8UYqeubt5gcODsL2X0z8IQR4bRi93S6+w9Prdv9iCNf5bGVs7KVtMknI8N9d0VbTbrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748415; c=relaxed/simple;
	bh=gZMD+ynmVD5lyQG7Hf4jaCdjR5Sddc/qp4lj1ahTe7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d91o/DVycJN2jDZogi86KN7EkQjPiWCH1jN4guc7K6ukxITaI32FuIvhAGQcXiWwy9IVK9ridGOLLClyJOwJ3IXjX8pTjefaNApRb5c/+nL2qJeWwtfuCpuJNrRIGogBbua8Soa2fLwwaMVMUlg9sqz1EC+VKf/DDBhs+YyK0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgNwVPSl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748414; x=1770284414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZMD+ynmVD5lyQG7Hf4jaCdjR5Sddc/qp4lj1ahTe7c=;
  b=bgNwVPSl8EnDzZMQl5y5PsSxfRtCH1FTXNYm0tI6ijmY3SrwudQmPbXg
   sfuXGimFjpxWoWQRCHTXs5NBq78cT10uIi5itJtJ5hCo/s5BbVHRiTUEe
   +KLDvuVLnNCt8HXiBBkxLM9M0IaF2DyCWvxzLfgg1PWwhDMo8C2zj96/y
   IGIvoSbNluv1xE8z3HcWFk86HtePGg7+m0BwZPerucg+pamgB8YfFwvLN
   +fhOX8eAwmELFhv+Jq9w/BNzWEqJOP/cgmyxisV3UVsWg7gqbrwvEIkYD
   F+LaVtFv8Yc3+XLT3+AdZw9X2Mp2eIWEkqPnJwIvf2WvuLSsanAww5C19
   A==;
X-CSE-ConnectionGUID: eW9MTgKvS9qb1iw4d94reA==
X-CSE-MsgGUID: YM2iCo8MSoepgFQ9qYP7qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225253"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225253"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:06 -0800
X-CSE-ConnectionGUID: LED85YVnSz+KEBE+P3gP2A==
X-CSE-MsgGUID: hZRT4eIsThGt6oUz060nvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845322"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/17] wifi: mac80211: always send max agg subframe num in strict mode
Date: Wed,  5 Feb 2025 11:39:23 +0200
Message-Id: <20250205110958.5910263db6da.Icd1f93fabc9705e4e760d834095c29b60b934d9e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of only sending the correct number for EHT and up,
always send the correct number as it should be in strict
mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/agg-tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 61f2cac37728..92120f905149 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -464,7 +464,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.deflink.eht_cap.has_eht) {
+	if (sta->sta.deflink.eht_cap.has_eht ||
+	    ieee80211_hw_check(&local->hw, STRICT)) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
 	} else if (sta->sta.deflink.he_cap.has_he) {
 		buf_size = min_t(u16, local->hw.max_tx_aggregation_subframes,
-- 
2.34.1


