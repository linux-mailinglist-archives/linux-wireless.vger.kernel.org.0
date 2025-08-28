Return-Path: <linux-wireless+bounces-26731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F59B396D9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B85C16965E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D12DEA7B;
	Thu, 28 Aug 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrX2eMcj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148C2D9EC5
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369604; cv=none; b=NJ76Itxc75zcJrF9EArxcNS641uoW8O9MLtrehYul+T1fbI72C3cQXml50/Sa2TREd1BjrvjmLf2w91a7bm8fl7+SCDJ8rraCW7pt3oru8h2wPBRSXqGbfDx163S8wL85KeoVeCAvv3h6CgOEeO8+VeSACJnKvS/QeooCOFe19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369604; c=relaxed/simple;
	bh=8QvBrpu42JI6awObLiBGcOth/kt3XhapT7YW/40xFIc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZ6EYIEdWsg6cl9xf2Rlt0E3YTs4n52YlBtrANfP4pohkw71sLGBISTmcu40R0caXarab8q6oUaEr2+OyTK/TcNdhCn7Z3REQctJ6QWIgJexCHU4B9jSPgrn5Ugjr3lQ8PjE61bjaHr4cqpEizPFCZ1kfDuiPsNTJm3JI92WlhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrX2eMcj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369603; x=1787905603;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=8QvBrpu42JI6awObLiBGcOth/kt3XhapT7YW/40xFIc=;
  b=hrX2eMcjHKDWs423UR9/lSv89P/0H3VKRMZb/0hXOgPJAxZOSASvSl9t
   Rv+OCynU2vSQZiyAcKLZ/cVDjy+Q7LbAeRAkUtCvD3G5mM0+t/MG8OzTB
   cdMM9APkHVcxqs4VRa91os7W/8kZx/7NDCX83q7fajdJb6iiJwLy3qaFQ
   7beS+BsCF/htS9Y+P4SmxFipC1kjiX8ilM7GEJ8XGQ7QpcKXi27a0/3Bh
   B0CIhbkUqZT83ZYeD7IgQLK/mjI5fDynN+ysFYq5nPS69B7rD44PMEPhJ
   V+LbqlMD2hkxOBGxuntIAPUrn4yNXKzkfPK5A5SLBBf893Ym2qygVVidH
   g==;
X-CSE-ConnectionGUID: 7wiUwALuQRGgS2n/ouAtbw==
X-CSE-MsgGUID: r5lTG/NCRR+2EAVTJzZv7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003333"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003333"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:40 -0700
X-CSE-ConnectionGUID: 6e4PNf4hRE+UzRUFwyVoKQ==
X-CSE-MsgGUID: lp5jo5MiRh23c5D+FQ8pQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224494"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: don't publish TWT capabilities
Date: Thu, 28 Aug 2025 11:25:51 +0300
Message-Id: <20250828082601.537908-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Due to the echosystem readiness this is not supported for now.
Don't publish the capability.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index a67b9572aac3..c03f057ecddd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1042,10 +1042,6 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
 			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 
-	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
-		iftype_data->he_cap.he_cap_elem.mac_cap_info[2] |=
-			IEEE80211_HE_MAC_CAP2_BCAST_TWT;
-
 	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
 	    !is_ap) {
 		iftype_data->vendor_elems.data = iwl_vendor_caps;
-- 
2.34.1


