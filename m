Return-Path: <linux-wireless+bounces-21886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753DBA97F04
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42C5176167
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C28266B5B;
	Wed, 23 Apr 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6SHLpHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A22676DC
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389023; cv=none; b=Eu5O7cuHtFQd7XFM1LGKhK/bjGVXgn41CDs/Fn8Z2dYvjqBD2kyiQW5kf4S4+n3Z5YorBz/VORcC5hFi2Lt1RHkbtrEmPddk+UdE7WSLz1FHEVpSoth08y+Lg7tFx/Nvf0IbcVGkjnwnSUEM9/wQXx762xEDt46QKUXcbWyOkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389023; c=relaxed/simple;
	bh=NOq6/f8vnecOpLLLBXcUEJZOu3U+aUpseDi1yRiS2V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btzLisirtK8ng0eGZPNP72pHyG5PA0pOKUwEwAhDcCy2+U/H+BOLuoxTEi7gXUWXGnfoEfNEFXvfO8l7hvf6ooNEvc4z4sbtbWD0Cx+DMDxsHBucySpwKi+2xd2sYlJ2UOcqdrcHGWrZlg4C4dy4CeCDsaq/kqjyCQ7TQNTrhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6SHLpHk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389021; x=1776925021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOq6/f8vnecOpLLLBXcUEJZOu3U+aUpseDi1yRiS2V8=;
  b=E6SHLpHk/pNJ1p7KoYdAWq8EW1KN8tSmBvtormN/jti6yCoOTc3jCvSW
   24aDmnEALE/WLQBVWKn79ppLAEhjZjscImX2L9+Ce220EzNmWR2CHZjjT
   fjBkNxyLiHVWjbklhUdAfG5ySCXgrfXOWffgG5f8CEExSSnAWM4hAoufX
   rvVlwrZFub0Xte+qFFyKSjMsNj/tsY786MefyZnVENpWxD1+jIVKwCHvo
   U9TlBXwCEs2Pwfzxd1F6MQO8qWp6FSuqcVh87oSl8pUrz/kfpQE74Hw4w
   FMAYQOr7mtDvORFb6zb8eKff5B7Jl4N8kWFBb8O49CFxMvBxxwN1yoADu
   w==;
X-CSE-ConnectionGUID: WUhLz8IlQe27TTLIGZMoBg==
X-CSE-MsgGUID: 1AXMGpmPQ3a+pBpA3gyf9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843627"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843627"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:01 -0700
X-CSE-ConnectionGUID: dsZzcAD8TY+0DmgbhB26MQ==
X-CSE-MsgGUID: 08f1S/rlQdGSBajtp1/g6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269029"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: iwlwifi: mld: remove P2P powersave tracking
Date: Wed, 23 Apr 2025 09:16:31 +0300
Message-Id: <20250423091408.ee164b464c21.I29de491b4d74b2b8084e54bfbd28646b15dee196@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since the FW is tracking the CT window by itself, we don't need
to update the MAC context or even fill in the value. We just had
added that because a firmware bug had broken it for a while.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index e49e2260ac05..47b5b31b5b91 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -226,11 +226,6 @@ static void iwl_mld_fill_mac_cmd_sta(struct iwl_mld *mld,
 	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
 		cmd->filter_flags |=
 			cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
-
-	if (vif->p2p)
-		cmd->client.ctwin =
-			cpu_to_le32(vif->bss_conf.p2p_noa_attr.oppps_ctwindow &
-				    IEEE80211_P2P_OPPPS_CTWINDOW_MASK);
 }
 
 static void iwl_mld_fill_mac_cmd_ap(struct iwl_mld *mld,
-- 
2.34.1


