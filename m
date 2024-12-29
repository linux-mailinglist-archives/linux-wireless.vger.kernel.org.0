Return-Path: <linux-wireless+bounces-16875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467BD9FDF4C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C57F3A1999
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48776190692;
	Sun, 29 Dec 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gfev4JAr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5CA19883C
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483530; cv=none; b=Z7V+HUBUfEdOPiOTT4vs00hx1P8ruipwXH/2mKhgQ0+nPL0rYDvxMhH5hKFUub12yEOkJ0LzN1VS/Brwc9/jCjqNEDZH8BzkDq7r/0c0o4luFc/3ItsPE+NtXro4ZfgF4cv8ExPgBujLr08PSKCQ+BJlbmajZTNYX94Ug2eaTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483530; c=relaxed/simple;
	bh=CFvbiM7q2ncfW/FkuHO+TjO4es/gYLM4+ocmcO6p688=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIjoOBoZpPIxR4ZlTZkXj2x0/lTL+eqk206jHB80UgWrBgmw3MSZky+0+L4frAlIyAq7t2bk86k7JGF3SASZIChf8jUis9t7MY+7mf6xUsM8elcmTjmNfgghiJ1AYxgAO8hy1YQQtO/zzDQqqR3E6OKed8eMDMifn7BYpFijYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gfev4JAr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483529; x=1767019529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CFvbiM7q2ncfW/FkuHO+TjO4es/gYLM4+ocmcO6p688=;
  b=Gfev4JAr26xjKzgSbnNXLKl97OprS35YdViqe7s2goG5Tf8wx08NpGic
   2jwkMi6MkG4ULQtCw/DKsIls7yLaIbyyRPOS74vH/dzE4XvNNeioNPtuS
   +uM4YNMl4/25NeUALD4uJhXi5Rb9A+GpZ8awPKch+olZe7GQnKHcNizjd
   vkFv2Eq1PaLWi9q9yUgl40GbImXlt5ov2T1ulB5xmyG7yJZ9qmubIGDnU
   b8YB5h/nhLuFbjjNjFtfzb58+vgpx/TOSO/EHBACufcSS+BfLAk/j9+0z
   rWBRmLUDhIZ6mTGKh+sIQU8FbL+a5jEinPFOmzmOQcMutrkev3N96eTbp
   g==;
X-CSE-ConnectionGUID: p0JPTqG/Raa1bcx/znZrAQ==
X-CSE-MsgGUID: INgDhFnfRsC9vN4HZOUdMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572464"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572464"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:29 -0800
X-CSE-ConnectionGUID: TMgDu8U8R4qXuJVtfsHJtw==
X-CSE-MsgGUID: dVvKoIZPTWqqOicrVFvV9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656988"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Minjie Du <duminjie@vivo.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 14/17] wifi: iwlwifi: Remove a duplicate assignment in iwl_dbgfs_amsdu_len_write()
Date: Sun, 29 Dec 2024 16:44:49 +0200
Message-Id: <20241229164246.b1b0dadc2e9e.Ie57cbe8039b9f388632141447ac910b6fcc3d0c0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Minjie Du <duminjie@vivo.com>

Delete a duplicate statement from this function implementation.

Signed-off-by: Minjie Du <duminjie@vivo.com>
Link: https://msgid.link/20230705114934.16523-1-duminjie@vivo.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 2472a78ada47..6ec1cae5314a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -463,7 +463,6 @@ static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_link_sta *link_sta,
 	if (amsdu_len) {
 		mvm_link_sta->orig_amsdu_len = link_sta->agg.max_amsdu_len;
 		link_sta->agg.max_amsdu_len = amsdu_len;
-		link_sta->agg.max_amsdu_len = amsdu_len;
 		for (i = 0; i < ARRAY_SIZE(link_sta->agg.max_tid_amsdu_len); i++)
 			link_sta->agg.max_tid_amsdu_len[i] = amsdu_len;
 	} else {
-- 
2.34.1


