Return-Path: <linux-wireless+bounces-28064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE7BEE101
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACEB14E8089
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2926F296;
	Sun, 19 Oct 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cubKrtr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9AC11713
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863544; cv=none; b=O0Fbc/ap1jy150CaAnuOuezD1WqyUCJgpqCBBKfVyS7FNGX0fx6zg9DE1WzUvpaQtCd3rNbkCGfB0BoTFmmi7GYDcGP8UVIOmahU/LKJOsRZpqmEM5GVchLXmjwD3x6V/jJLLrh0VjtluFuz6U1EvQvf89qE2m9pykn9TxIOcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863544; c=relaxed/simple;
	bh=yzE5EA6QkFy6mripinFGlM9LnLL/8RPMNUixP2J+o4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izQCsQiKi1S7//ENWcOBK1Y/iMRYxfg5Pvs+Nyb2QTzar+JJUfn05iRwn0jfRTRNnXMdcqmnWllgVQ9sgg66D5EiYwOYI/KLjujvyxEzAa86VpnrwhUMNM1KAa9ieQM0D4zM9fUyNRt3Mwe9wTYwo8543La8gPx12XXN2TeMp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cubKrtr8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863543; x=1792399543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yzE5EA6QkFy6mripinFGlM9LnLL/8RPMNUixP2J+o4w=;
  b=cubKrtr8qr+GP8rRmOtFou4QOzGdgz/6YD1TDSZVYlQqtNApppaVEQ0W
   vfI9P+ZHTFSJZhDwq+tPzxqHEj7fZh0J95RtfX/SXkyjAEfyzWBc36jiI
   dCjD64wFOH3+p/y5nyDToiFkwwIunvdM1s8VT2cSLco8ao2Y4k7z9hFTT
   ZaRPbGVXpmz2li4YAJMEdCTsFpkYjhyjp+HhxPjHCUDoMkTmXlzRNypm+
   b8ykG+Pvtj4Zd4vDrDF8kOa3YTkz85vrZ69AwRJqe0Lg/TDO14YM5Ysay
   cN/UZp9I+wTAHfZszQtVzNoN8VDbhnfWz9qQub3dkuKhtd22/r4AMa7jJ
   w==;
X-CSE-ConnectionGUID: Kf6moy1mTE+1WwfvmGRuGw==
X-CSE-MsgGUID: 4zx2HrpjT1i73LV7dp+4lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363188"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363188"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:42 -0700
X-CSE-ConnectionGUID: USZFH24PRGmfU7LDilatwg==
X-CSE-MsgGUID: DYe7UN5+SHyR6gVUl0S77A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279892"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mvm/mld: report non-HT frames as 20 MHz
Date: Sun, 19 Oct 2025 11:45:10 +0300
Message-Id: <20251019114304.23e6695039ca.I3da7c542bde6de4362755f200248dbcc12aa246e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Non-HT frames can only be encoded in 20 MHz, however, they
could be duplicated on all/some of the subchannels (mostly
used for RTS/CTS), in which case the firmware will report
and estimate of the overall used bandwidth based on energy
detected. This could be confusing so don't report it that
way, always use 20 MHz for non-HT/legacy frames instead.

Note that currently the value doesn't appear to be used by
mac80211, it never checks the bandwidth field for legacy
encodings.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 19e78d2fbf9b..6a76e3fcb581 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1309,6 +1309,9 @@ static void iwl_mld_set_rx_rate(struct iwl_mld *mld,
 		    iwl_mld_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
 							  rx_status->band);
 
+		/* override BW - it could be DUP and indicate the wrong BW */
+		rx_status->bw = RATE_INFO_BW_20;
+
 		/* valid rate */
 		if (rate >= 0 && rate <= 0xFF) {
 			rx_status->rate_idx = rate;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8c1bb3a7ffca..d0c0faae0122 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -519,6 +519,8 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 			return;
 		}
 		rx_status->rate_idx = rate;
+		/* override BW - it could be DUP and indicate the wrong BW */
+		rx_status->bw = RATE_INFO_BW_20;
 	}
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-- 
2.34.1


