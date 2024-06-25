Return-Path: <linux-wireless+bounces-9551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85833916E88
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68571C22511
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B3B17623D;
	Tue, 25 Jun 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONToFxFi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99B17C7AE
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334319; cv=none; b=ZGQgevAhmXrKOIhOb/YM1JrVQXuHdO9fjtXfoFz3N2eLJiCtOdT64/4D4kv3UY9ix6UJyhIckvnUqXgno5jMp7hQMvgAhX/ssl0bwWl4m7TcnSO0rPG4QZFYrBy65PkNRR5tTAaU/QIcnDKsvasMiabzvKzeaLiyPX3oqIL5os0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334319; c=relaxed/simple;
	bh=ngV9qu62hnE3OAugcHfuJni1Sa/Km9DjbtcX7FaUWAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLjsEtzdb9ygLlJjjnXZRyy3ZNSdy7JVGEgZYQaWBmTvPScXTr3EvyLLxTYM7tPtYwxTKve3Y2BYgpAAtqoV/hJfLc0cj2btpV2majuORGmI/sOE2dB85lRN1/qCAAH35hDh1DFSN7FN0XTQs1Itk/b+Gypa7LWKtwfwUVrQ1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONToFxFi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334318; x=1750870318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ngV9qu62hnE3OAugcHfuJni1Sa/Km9DjbtcX7FaUWAI=;
  b=ONToFxFiReEQzCvXqJBK9pp6kC0SnAfFNXX56Il3ccaVtDL5FsIt0So9
   9No1sNMiidofyaS0h2A6Uk4TRG3RxK0LKTiIVXyYTdSe/FgUOAUieZKVv
   /rv6D4cwVCl6xy+zX8CZehD5N3vkc7cuvMwU209dlXb+0RayR7P+59ofC
   MFQeX3DUwvF7Oii4lPt6kVASSwgwGoMd6JKf/rQ/a9YIDiifXf95R9hqQ
   NFIQdy6e3w2dYq2Br4aoLlEzOWUstCA3JYp+a4TJ7Gpq5FKM/KvdyZtru
   EeuhVAsXk9efmia/7MemQvbtkNcC8ie0mQgtmLLWJ+QHQAN6WWLeROxbo
   Q==;
X-CSE-ConnectionGUID: MhW3TnA3S0SIU/h+cWATaw==
X-CSE-MsgGUID: U3izJW7tSFC8wrJwM8/82g==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594804"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594804"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:58 -0700
X-CSE-ConnectionGUID: fNQYJOqJSzi6cxs4SFUg+w==
X-CSE-MsgGUID: tXfMdfYoT1+li6kBoqRW7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632906"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/17] wifi: iwlwifi: mvm: fix rs.h kernel-doc
Date: Tue, 25 Jun 2024 19:51:23 +0300
Message-Id: <20240625194805.baa3bd60c8f8.Ibc4886f7fe696d57991689cc2885cde5cecc8f90@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some things are mislabeled here, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 20b9fa7deeda..ea81cb236d5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -198,11 +198,12 @@ struct rs_rate {
 /**
  * struct iwl_lq_sta_rs_fw - rate and related statistics for RS in FW
  * @last_rate_n_flags: last rate reported by FW
+ * @pers: persistent fields
  * @pers.sta_id: the id of the station
- * @chains: bitmask of chains reported in %chain_signal
- * @chain_signal: per chain signal strength
- * @last_rssi: last rssi reported
- * @drv: pointer back to the driver data
+ * @pers.chains: bitmask of chains reported in %chain_signal
+ * @pers.chain_signal: per chain signal strength
+ * @pers.last_rssi: last rssi reported
+ * @pers.drv: pointer back to the driver data
  */
 struct iwl_lq_sta_rs_fw {
 	/* last tx rate_n_flags */
@@ -213,11 +214,11 @@ struct iwl_lq_sta_rs_fw {
 		u32 sta_id;
 #ifdef CONFIG_MAC80211_DEBUGFS
 		/**
-		 * @dbg_fixed_rate: for debug, use fixed rate if not 0
+		 * @pers.dbg_fixed_rate: for debug, use fixed rate if not 0
 		 */
 		u32 dbg_fixed_rate;
 		/**
-		 * @dbg_agg_frame_count_lim: for debug, max number of
+		 * @pers.dbg_agg_frame_count_lim: for debug, max number of
 		 *	frames in A-MPDU
 		 */
 		u16 dbg_agg_frame_count_lim;
-- 
2.34.1


