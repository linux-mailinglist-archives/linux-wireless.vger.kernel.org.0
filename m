Return-Path: <linux-wireless+bounces-8116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D658D07F0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A38B1F21BC2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780017E912;
	Mon, 27 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2+vnRG3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792027347E
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825989; cv=none; b=nVnPSAEzvPxJaRAl9pMA+/2e4P6Lsq9ZO8lYPtUayVgOSWTx0XAYGwilJXUil6VVmJ5QllliNrdgnvx2PGhZVGtTCV3zOiS3owzqK/hF2KYKl1RWOS//TJnlitfoT0KNxcKjefJMNjQNfMYpFyzmSXTDw2f/U1umfO4ncAXvbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825989; c=relaxed/simple;
	bh=609RYTUe1Eiuo3cpjYJhXwnSKD4qdU2A3FS1aWur41s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pueRSOxL6ByXN8JPErYixGV5ySPBnd0ookmMBtOMtJQ/EgK9aP+sepeGT/ouhKbO6NIX9KVZaY78VchCie7pcETjbbm3JOjJ9lvkZVol+hP7YtMsAzbvAa6G+T5ank6t6R9u7ic4zZzZs1QHPEVV2vBdT1uLqrXbV9lGByrUJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2+vnRG3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825988; x=1748361988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=609RYTUe1Eiuo3cpjYJhXwnSKD4qdU2A3FS1aWur41s=;
  b=V2+vnRG3ZlrvVCdJM9Aw48LH6YvdAW0TsTWb34rPPAZ9ocsoztbR/Ux7
   +PmKohfomV1+2UKhy/lp2Pxv4rhm0QV7weF0QavIIYXqNfLDLOtIEXvJn
   0o6vszjSOM+nG1MhspxTrkGNCpeWstMj2licbdIKr8ViPjPQS4H+MIyMa
   yjZ6dxd8uSLAS4eGeBTrxSWkAozSGYTlwGApRYni0Ivq/wtTvId+3CJSf
   WDNU3O5sE/26ogEuP9LUgNWJibCSzIeXMSKB1Lpf/W05dVi4e/5ygsm18
   sZSMpWi824EpS9dO5G7MuLRq1GTjRnay7Q2HoJT6brpRyVxpgRQ5mNx88
   g==;
X-CSE-ConnectionGUID: jQPUAQjTQjqY5WfJfCECRQ==
X-CSE-MsgGUID: rXAWuvD4R5ePbkP3Td7XhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002070"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002070"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:28 -0700
X-CSE-ConnectionGUID: hXZ08PUjQCO7SQCtwJbSWQ==
X-CSE-MsgGUID: SImxyqXIS429Kf6stjARmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407069"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 02/20] wifi: iwlwifi: mvm: report 64-bit radiotap timestamp
Date: Mon, 27 May 2024 19:05:57 +0300
Message-Id: <20240527190228.4fc44356e7df.Ic8642d35f1090a415e09299a1bd409f51dfb6351@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use the new RX_FLAG_MACTIME_IS_RTAP_TS64 in mac80211 to report
a 64-bit timestamp in the mactime for radiotap only, in case we
report the synchronized PTP clock timestamp (otherwise we really
only have 32 bits anyway).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 34a0f524262a..5370580f6210 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1959,7 +1959,9 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		u64 adj_time =
 			iwl_mvm_ptp_get_adj_time(mvm, phy_data->gp2_on_air_rise * NSEC_PER_USEC);
 
-		rx_status->device_timestamp = div64_u64(adj_time, NSEC_PER_USEC);
+		rx_status->mactime = div64_u64(adj_time, NSEC_PER_USEC);
+		rx_status->flag |= RX_FLAG_MACTIME_IS_RTAP_TS64;
+		rx_status->flag &= ~RX_FLAG_MACTIME;
 	}
 
 	rx_status->freq = ieee80211_channel_to_frequency(phy_data->channel,
-- 
2.34.1


