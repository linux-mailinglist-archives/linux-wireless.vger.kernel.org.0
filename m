Return-Path: <linux-wireless+bounces-11912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A4E95E448
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2737281989
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52213156F3C;
	Sun, 25 Aug 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqBnmmVW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F5155742
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602656; cv=none; b=I9a0ZCSmh8LvGuLQT42lcVIWXUfW5OCkMDf6a+kPVDqDNAgkgy2MtjmGqfCOf67Q3/Z6UWWigqx1cGEWmUEwlWp5rK5zS87cju/ISehk3gVgklvUFAt5GhCnCrhJYuGJ3g+/ERTYwwwEQbnh+W0yH5tYBpYjMXeWZq2Ng4gsWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602656; c=relaxed/simple;
	bh=E4eSGNBPOD2JYsEtUgEpWR17PVDKPzLnqyParV2+7ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrOvMnAQmCrH7U7IJOFhZFp2OAYwmFWd/S08MR/+kIWuLrE9JfFBQHevX72osJihacVGvHhUFYS1JYxXnCALnP9kUbHRB9tsTesXNe/kl23pUZFVZ3wzGQxG4cei/B1V+lTpPbtopoIOho+h0QEZGKkSFYfm5Yku5eNeG7spyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqBnmmVW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602654; x=1756138654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4eSGNBPOD2JYsEtUgEpWR17PVDKPzLnqyParV2+7ZE=;
  b=HqBnmmVWSMbl/BbS/bnkXYUSHXNOa7uDbGvyk3HC/o3K2OBgVUg5ucZ3
   tRzKnTJxCFomHYWGXQf5gnJTEKpRqUXWlVGuQNi9e73nAD0FavzwnjK3a
   CTZFTeLg4HFD++3GUePnQs6IhRDtQySoyVo1rZNXl/U/qtPDBLY8RYOlX
   gmlWrBF5kVO23Uw5l2gGZqzanmyZgntlJwatu1M5Hw+1FP5wGOxdf1mxz
   V31QpwuOcLas7gscvwBgGxicAv6i82g2EcfFCczBBNA1IJSxP5Z4WJqV7
   JD6Q7+rl3IhU7Cw9y90ooP6rn16CC4GpMQnTW1aQXbjRus1y27xaM8dhm
   w==;
X-CSE-ConnectionGUID: TUU452BtQtm7FJKP+xoGGA==
X-CSE-MsgGUID: 7BtFmIaWTBWgS2EnBKXkLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544129"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544129"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:34 -0700
X-CSE-ConnectionGUID: /W5ypF8ISl6JetdEb+4d8w==
X-CSE-MsgGUID: 70Oa70ZNQ2qWzquGXl0TMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999749"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 07/13] wifi: iwlwifi: mvm: take the mutex before running link selection
Date: Sun, 25 Aug 2024 19:17:07 +0300
Message-Id: <20240825191257.0cacecd5db1e.Iaca38a078592b69bdd06549daf63408ccf1810e4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

iwl_mvm_select_links is called by the link selection worker and it
requires the mutex.
Take it in the link selection worker.
This logic used to run from iwl_mvm_rx_umac_scan_complete_notif which
had the mvm->mutex held. This was changed to run in a worker holding the
wiphy mutex, but we also need the mvm->mutex.

Fixes: 2e194efa3809 ("wifi: iwlwifi: mvm: Fix race in scan completion")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1cc5667340e8..d809742528af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1198,10 +1198,12 @@ static void iwl_mvm_trig_link_selection(struct wiphy *wiphy,
 	struct iwl_mvm *mvm =
 		container_of(wk, struct iwl_mvm, trig_link_selection_wk);
 
+	mutex_lock(&mvm->mutex);
 	ieee80211_iterate_active_interfaces(mvm->hw,
 					    IEEE80211_IFACE_ITER_NORMAL,
 					    iwl_mvm_find_link_selection_vif,
 					    NULL);
+	mutex_unlock(&mvm->mutex);
 }
 
 static struct iwl_op_mode *
-- 
2.34.1


