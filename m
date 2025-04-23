Return-Path: <linux-wireless+bounces-21865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D300BA97E4E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA3417E20F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9726658F;
	Wed, 23 Apr 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rav2x9Z9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4B264A96
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387459; cv=none; b=iNKhbh89isogxCP/MpqWsA/+ojBjTEox1geU8QkuJHaM33h1LGSTKbiv6BGolS0K/diKpesG6E0xuHvNdOL9y6sb6XWsg6parHfcGVPM3Z13PFBJd6sgztMSH64e8yfZI6OAcqS+3imuWLyQQK52EWfKGy97Z/2Ff2x/bUXzIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387459; c=relaxed/simple;
	bh=NOq6/f8vnecOpLLLBXcUEJZOu3U+aUpseDi1yRiS2V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KC7YYb1kc4Cw+KwDDlc8xGH+61DzZDK/9ZqPAfqDi2u+zyxiKcp3yfxbcUJzWjJA/OMFqDd/54uLtGHVdJonOTDPCZ/tZ7urD63USQtZUp19DzmDBqg5PZMbIHlhuHoejgdLM+ve0s6SR/5Sb361c8j5SA8JJ8eYiGJvUL4zKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rav2x9Z9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387457; x=1776923457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOq6/f8vnecOpLLLBXcUEJZOu3U+aUpseDi1yRiS2V8=;
  b=Rav2x9Z9MfrOvdlPhX3FagI0Ny9mnRoD7BM6UjKwh+rC7UKQQKshx6Q7
   4PS0ozz187th+ZQx/L352Oez2QaKpA2xPL6CpaMzdx/QxdkcraoxRbqWN
   L/KTVla8j1lXY7HcBulnWcZK5GYDYTkiTjNOR/jusshBC9mbeBZeRMxin
   NbEChjFFkgkitX6XdtymvnlfiSXxukXP4jQrpVuvH0d/09ddPTg8n8K+R
   YHF82psN/ZzyYCAmJD+j8NNCvL2W9QToA7PVBf/AD/6wfuUJYoSuE4MJx
   VqTPHSATsL9EHnTKLvXR6OI2Dnmr3ircREAABkCcudabV1KFRiEDne6WM
   Q==;
X-CSE-ConnectionGUID: M4Vwbn/QSo6dt6TxQ15oAA==
X-CSE-MsgGUID: 50J0iOdaT/++YHNvT0rang==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844624"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844624"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:57 -0700
X-CSE-ConnectionGUID: mLr2VFypT8GK0+EcvMgCww==
X-CSE-MsgGUID: HrSRVU6tSCCNv/AsxTJDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164324"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 05/17] wifi: iwlwifi: mld: remove P2P powersave tracking
Date: Wed, 23 Apr 2025 08:50:24 +0300
Message-Id: <20250423084826.ee164b464c21.I29de491b4d74b2b8084e54bfbd28646b15dee196@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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


