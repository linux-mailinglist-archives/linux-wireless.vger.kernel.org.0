Return-Path: <linux-wireless+bounces-3165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146184A6E5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A788B2668E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7B5788F;
	Mon,  5 Feb 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geYFmBXk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314757896
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160899; cv=none; b=hIEV/nxfhpIQSUHENjPFSdHdiVnsjs958gkR5ZbRRQb9SovzYBR08A9Y6uRDKu2nrTfX8PfSHcqd7nbD2QMsKiCAcKxWgYkUXLftOcF0ZtranMlYfkcWG0w843g4wBx4xUJQCfTGHyPD8tRjqNVjUEtfOvcueeQipSqKKx1bb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160899; c=relaxed/simple;
	bh=/0yrIIWdb5MChrL4kkETdwq8no7pPdnqnT2kgt3SiwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnAyZv4V/udljqUQZqvvlry3Qf0WiQFqL4yKlk0e9asWL1S66tfGSbmh75afQ5oqE0J3W4lll6t+TDo3ruYof0LJkWJyg7TTjtK5qTUakb+5EEA9Lq9xl7X/Su2T3N04naMlDX+MncCQAyAnaImwEJCLbDD43TmrLji0vQn0kRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geYFmBXk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160898; x=1738696898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/0yrIIWdb5MChrL4kkETdwq8no7pPdnqnT2kgt3SiwQ=;
  b=geYFmBXkkS4GCyOwo4B6m4cJSPp7Jg/OUvx8XTDWfXJXAtgeiTjs9ORo
   hzglaBkjsU89RDxCYKXNS5gzCys0XWi17eCUsV1zewqc49WkU6uoT5mZK
   9BmHvqhyuD3qYhAC/wtPU46JMkNBlXz67uDmNGcaP1RG1wKBfbxAfKdmN
   646po9EW7S+k1d9oa6FkDsnKkxfl032mKAmsXUYvxsYaG2Geh5ml5lhkM
   NPS7pGLtF7kUsPUWGpK0zh2jIR2NkhOLCdhXIjHcPAHIOMD0POgc1iVAC
   9NkDjcOp6eJwRU2PF0Ov7Rq9PgOKl3C9LlXrAOr3RnMJY9mAclevKZu1u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381561"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381561"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403074"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: define RX queue sync timeout as a macro
Date: Mon,  5 Feb 2024 21:21:02 +0200
Message-Id: <20240205211151.a6985ea87751.Iafb7ae13aa58d66512e4b3fa6c75149c75cbc305@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

define the timeout on RX queues notification as a macro so it will be
clearer.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a4ae3c09b543..6477a39f643e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6046,6 +6046,7 @@ void iwl_mvm_mac_event_callback(struct ieee80211_hw *hw,
 	}
 }
 
+#define SYNC_RX_QUEUE_TIMEOUT (HZ)
 void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 				     enum iwl_mvm_rxq_notif_type type,
 				     bool sync,
@@ -6095,7 +6096,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
 					 READ_ONCE(mvm->queue_sync_state) == 0 ||
 					 iwl_mvm_is_radio_killed(mvm),
-					 HZ);
+					 SYNC_RX_QUEUE_TIMEOUT);
 		WARN_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm),
 			  "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
 			  mvm->queue_sync_state,
-- 
2.34.1


