Return-Path: <linux-wireless+bounces-8128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B98D07FD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5A82A8E5F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63FE169393;
	Mon, 27 May 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaRT1G+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8D16A378
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826005; cv=none; b=aSdNpDLOITkTDgkx+snAcQJCRryUj48UOUK+5/BHDY9EEkPOgu1BzDvHNfD5jN8ZtLogKjThgSVinwH+7jcd/7YP/KwjmOuQPjwWff8wK/tFaWpn+Dg4typ7tfuSLKQVdaKqhqCXvK43Blrd6ROAgSDNBzdsPS6tO5jWsAC5IwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826005; c=relaxed/simple;
	bh=rduEwfeldFbQSu+DyFXro32lUWD4fBdfFwjuxNDKnUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tlmsx+pIRzYs4nmxer9Mk0SKOBBnxldpYKSbXM4xHFOBtuuFkNY5JiCWkIyF5WZjukZM4lzlyHILMflml38EqNZoG5ckUYBzrYY2ipAx1+W0TwhhQLlgYpSJuxhYX042skl1m+niZXaEwLvEimfygr6RBtgEoojcQ3XTZPxJSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaRT1G+I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826005; x=1748362005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rduEwfeldFbQSu+DyFXro32lUWD4fBdfFwjuxNDKnUU=;
  b=JaRT1G+I0tTlMaiRQ4uoX3ULx27t0GfCatgjdt81km22b49bRQM9u7Gg
   9OD4WRLLBj//20Fm7vVzPF0oQFt2qMFku7e18xYUwD2GSa4V1cx1VNYhA
   6guTtVcWGeFTIFtC0o1g2MBMW+H3Et86voah2gIfZrl4ZpUv/YTCZgtsO
   2upDUjnSrGxNof1/8m9YsAcjbi8p/UWw17B3nMvndARLhLrcHvwdMl1Lu
   Q9YnVtcAPKQoV27fhbJrsWuc5IQFkbJZRasGIGpJRCo22enyxWvt1CUnZ
   qrO1afI+TJyDsc/FtUZUJAtma+DnKAlRQVLAKPVGUcBk1Vs7jIZFRkFre
   Q==;
X-CSE-ConnectionGUID: xuN0Yj5xQEiGL0eAtSVRyw==
X-CSE-MsgGUID: eAlJL3pwQ6+uPcmn4i3zyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002105"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002105"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:45 -0700
X-CSE-ConnectionGUID: KAEBlLyOQ72j699a3LlBnw==
X-CSE-MsgGUID: oUFjJ7hISUenVBRqPl3xwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407120"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/20] wifi: iwlwifi: mvm: add debug data for MPDU counting
Date: Mon, 27 May 2024 19:06:09 +0300
Message-Id: <20240527190228.77ef3c2654dc.I1796a3995da2a49dd5102d33766af1ad416dd60b@changeid>
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

It is hard to debug issues of EMLSR entry/exit due to low throughput.
Add debug data.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c           | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c          | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b2b6dbdcc44f..ebf313e161f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -222,6 +222,8 @@ static void iwl_mvm_restart_mpdu_count(struct iwl_mvm *mvm,
 		mvmsta->mpdu_counters[q].window_start = jiffies;
 		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
 	}
+
+	IWL_DEBUG_STATS(mvm, "MPDU counters are cleared\n");
 }
 
 static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 4fa8066a89b6..b7185ddcca87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1010,6 +1010,9 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
 	}
 
+	IWL_DEBUG_STATS(mvm, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
+			total_tx, total_rx);
+
 	/* If we don't have enough MPDUs - exit EMLSR */
 	if (total_tx < IWL_MVM_ENTER_ESR_TPT_THRESH &&
 	    total_rx < IWL_MVM_ENTER_ESR_TPT_THRESH) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cc79fe991c26..2a8ad718ce78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4433,6 +4433,7 @@ void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
 			bool tx, int queue)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvm_sta->vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
 	struct iwl_mvm_tpt_counter *queue_counter;
 	struct iwl_mvm_mpdu_counter *link_counter;
 	u32 total_mpdus = 0;
@@ -4469,6 +4470,8 @@ void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
 		memset(queue_counter->per_link, 0,
 		       sizeof(queue_counter->per_link));
 		queue_counter->window_start = jiffies;
+
+		IWL_DEBUG_STATS(mvm, "MPDU counters are cleared\n");
 	}
 
 	for (int i = 0; i < IWL_MVM_FW_MAX_LINK_ID; i++)
-- 
2.34.1


