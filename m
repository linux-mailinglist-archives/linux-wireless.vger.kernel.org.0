Return-Path: <linux-wireless+bounces-22471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7134AA9C18
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7F63BEF7F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE03269AFD;
	Mon,  5 May 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWpTBjXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C91C1F12
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471442; cv=none; b=nJaYBDh5eLs8bB0PWgckIgfmqJSPpOLJeoz24fksLhTm/+sfFUpZhSDtXjmEn7ZzhArUHylINHVmdVad0GIiEE0MkQBAch8uCdhGGnsyjznZ/LvD/FlLX7EFWlfw7HHO5ylBHcANT666dtHiNAWu/wqIuDVMWY0KZZGoz2TAwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471442; c=relaxed/simple;
	bh=pQ4HreC6jnx6+2/6Hfam2nA2t/Qw8Gr94G5NwhZRT2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTudub8f7lNYBC4iZO5J/oNNnw+mPAx06Vuk/hUPTZRAMw/GGIQhbuOAtSnj71mVl5t4uCQpC+oFZ64ZFeXXAgtntDl+iKAFLCaWhRuAMTkhvBV1W81OOgiMYXzvRZmi2RL0E5aK3J5Wg2NhmMMAG9qAxWnJf6BRZ1rLyZMMVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWpTBjXa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471441; x=1778007441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQ4HreC6jnx6+2/6Hfam2nA2t/Qw8Gr94G5NwhZRT2M=;
  b=YWpTBjXalL0CwIpB2ux6UG7RgSv4LX5nAbUqjj1dNcHKkfAAc7f7iMDf
   YQZeqlua92QB1uipJy97Fq/BsLOdXqMPA1G+IRAxgyjlLf7B9ietKBPvM
   3Q5zkcESqI3YWoGVG0uMX3HPFd/Zlh9JNXBokL9lC9ghWieO4NiYXIXb9
   Cb5hiXFhhWX7JeWDBGcqvbOXtMpc/tavcNhvLPi0xPEdPhtlCBgSB4rvu
   75rNam/kwQRtmDgFTQ9CiTPIgETRdoknYsNSmehBg0+0GVb0rOwCsugW+
   wSdQUHeM3W01g32eZldNPukO8dWPj92j/6WnLeLiF5fGB41tqjYWXBxI/
   A==;
X-CSE-ConnectionGUID: aLF0b0ChT1W/MZ+1PhKIiA==
X-CSE-MsgGUID: Sl4ycmqLSuCSHGRZUYmopQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359450"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359450"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:21 -0700
X-CSE-ConnectionGUID: 7f7qbb1MTC6G3Rj/eJEG5w==
X-CSE-MsgGUID: lDcZ2MyGSkG+iDzikFcplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697997"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm: fix beacon CCK flag
Date: Mon,  5 May 2025 21:56:47 +0300
Message-Id: <20250505215513.fe18b7d92d7d.I7bb40a92cea102677b695beb1e2a62a5ea72678b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The beacon CCK flag should be set for any CCK rate, not
just for 1 Mbps. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index bec18d197f31..83f1ed94ccab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -941,7 +941,7 @@ u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
 	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw, BEACON_TEMPLATE_CMD, 0) > 10;
 
-	if (rate_idx <= IWL_FIRST_CCK_RATE)
+	if (rate_idx <= IWL_LAST_CCK_RATE)
 		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
 			  : IWL_MAC_BEACON_CCK_V1;
 
-- 
2.34.1


