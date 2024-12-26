Return-Path: <linux-wireless+bounces-16814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71919FCBA8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA05161C22
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5D1420DD;
	Thu, 26 Dec 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkSBeK4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C912E5B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227926; cv=none; b=JEm6TPyBWKCZOPKr9x72fnWVmea9WKGdY+l2iKF7MNQwrnzqw6HfKKFMZ9g8PVTeDN6QjW2oopk6AzsTaVFLNMeTwxMxJiDA7MMSn4+MYKMcY6azXnB0Yy8gtV7O2k2pkJ5n9uHnT9YgpzniFqQpQJGguKWmEL66tTNQYMAWLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227926; c=relaxed/simple;
	bh=09uEPtdgMGQnxNQcMg9fm2iCzzPkoU97sdMIi69FNEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhRVqcCYNTQ1XmGAEvzCvfZ28snwSMirYfo8BG0yRSVZ/pAcY9tifmbXVgzgy9XGYoY9ivEVzoaRi8GuWabr9SNMJ+TVqYsySJ/fjfGYxYTcRMzQXcwSbSrUEfvTtopjt4RcRTlv2Icde5XuAHvo2Obt6bZlwkMZWBj88OUxj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkSBeK4a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227925; x=1766763925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09uEPtdgMGQnxNQcMg9fm2iCzzPkoU97sdMIi69FNEg=;
  b=SkSBeK4aSH2ZTi2yz2azqbqi/weUNG1VmLk+D3qvuzFnABOJOTxH0OMe
   VYOJb+S/ptDYempLR3d/PyshIieINv/LSCJYA2Rg9a5Xw8AnqBmDM+M8b
   tWG+N/DOi5mWP6Z2qhIMpB7BsyPZMTRT+p0sqoQvjKf0CcfyiHvxgC6XP
   4P04uNAu1HV+oKt9yyVqKNslBa7x0sasQAgz7BnRNJXbs5ct+397ujL53
   WMkxx4qFjPyaRgRtD5Qspy/Fvk3QjADWl5nVPMIdkJn+tS0wPuzXk4qev
   fLzR2CNap9DfPP6FO9Prz7i2hLlmIY16knLt+RZ+JrI1D0pBCYRVvd4co
   g==;
X-CSE-ConnectionGUID: yO8cQ0D3QKWFNIGioC8EfQ==
X-CSE-MsgGUID: R+xtDpXGSUSyWexI9DqjBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878150"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:24 -0800
X-CSE-ConnectionGUID: jrQzoo2WT9K8ID0zcfsDmA==
X-CSE-MsgGUID: sVlf2LqOQdeK0eb9Hiq+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777999"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: Check BAR packet size before accessing data
Date: Thu, 26 Dec 2024 17:44:50 +0200
Message-Id: <20241226174257.72161a6c07c3.I4887bad2355213b201fca2da1836c9a3203ab42d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Validate the BAR frame release size before using its fields to avoid
potential invalid memory access.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index a2f16bfaec44..e8ea48936c2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2506,19 +2506,21 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_bar_frame_release *release = (void *)pkt->data;
-	unsigned int baid = le32_get_bits(release->ba_info,
-					  IWL_BAR_FRAME_RELEASE_BAID_MASK);
-	unsigned int nssn = le32_get_bits(release->ba_info,
-					  IWL_BAR_FRAME_RELEASE_NSSN_MASK);
-	unsigned int sta_id = le32_get_bits(release->sta_tid,
-					    IWL_BAR_FRAME_RELEASE_STA_MASK);
-	unsigned int tid = le32_get_bits(release->sta_tid,
-					 IWL_BAR_FRAME_RELEASE_TID_MASK);
 	struct iwl_mvm_baid_data *baid_data;
+	unsigned int baid, nssn, sta_id, tid;
 
 	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*release)))
 		return;
 
+	baid = le32_get_bits(release->ba_info,
+			     IWL_BAR_FRAME_RELEASE_BAID_MASK);
+	nssn = le32_get_bits(release->ba_info,
+			     IWL_BAR_FRAME_RELEASE_NSSN_MASK);
+	sta_id = le32_get_bits(release->sta_tid,
+			       IWL_BAR_FRAME_RELEASE_STA_MASK);
+	tid = le32_get_bits(release->sta_tid,
+			    IWL_BAR_FRAME_RELEASE_TID_MASK);
+
 	if (WARN_ON_ONCE(baid == IWL_RX_REORDER_DATA_INVALID_BAID ||
 			 baid >= ARRAY_SIZE(mvm->baid_map)))
 		return;
-- 
2.34.1


