Return-Path: <linux-wireless+bounces-7193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C273E8BBF7B
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20908281D01
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015F3FC2;
	Sun,  5 May 2024 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apxNFh97"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B923B0
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890043; cv=none; b=a9qxIytEXsO4QeU85dJC+ADRWt7DZ5gi4SvjIYWd42b+o6Y99PijZIYX9fdOHosKvx2az+bXPtZZA9I9GzQg9z9K+I0ZrvyXNQyznTcMkRHAhVmjek3ZQO11LEtFw7Up3niNenorjHDJZ6gFtCwwmDyVlEe1d+JnLDY8u6aEISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890043; c=relaxed/simple;
	bh=sPyJtZzCzFZ3yFWPiGJb+me5ToFRH0FgdRHpMmu4aF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epiHoQuUEi8cULJwa/URF+Q/qhLuYn5JVcEpuCiWtr3uyYCbJDKZmEjWkSyc9m5K+3GHnil7l4G97Oaz5ovphTpCQiBrGiValD6LZpd9S2PQsK1HDA4tF3MDlMNoSoqJVD4jswukg7oKe0KCTnKR8Y0fUTiMMJzmdOyNNs/m4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apxNFh97; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890042; x=1746426042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPyJtZzCzFZ3yFWPiGJb+me5ToFRH0FgdRHpMmu4aF8=;
  b=apxNFh971dyiIfOyVQyo3x0JbzshHxc5CB16Oo3GfLUcAtiHl06jy8V3
   5z322YziB0QXA0F3u+F93MsBaLohLEnyP6Sbpbu9swma+OlYjc8JGdW8g
   UrfqGh60ZYwn2hCB4HQEESoOaoXZmOLL2WyuXRxnw2WiLDNO9xt9Zx4VW
   V4gIRuZOeVGVie6bpitspKJjYE+U8Jmn+YQ1Z1KgfWBkpqSKVfSn0v/p3
   uPzXcHvCUECsAhdVOhiWgnALUIJqctHWm3cFXdmAna6VBo1E32vuAkbn1
   IbjwGmY2A9w2HU3+aF6QmAn7uhOT/HEGAPJsUWgOVMW71xOW/GsN/ZhwF
   w==;
X-CSE-ConnectionGUID: 2lszbHR+SrKegUvCHFcwLg==
X-CSE-MsgGUID: nX3k7J6DQEWdXv6+CjfC9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461839"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461839"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:41 -0700
X-CSE-ConnectionGUID: z7l+vV/FQNm1z9d4bDK28g==
X-CSE-MsgGUID: O2fFmLdZRoK+Vv+3x/6qOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903641"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: don't reset link selection during restart
Date: Sun,  5 May 2024 09:19:59 +0300
Message-Id: <20240505091420.e81db303f1dc.Ie8267082f623d14376a2052d222e18da6545f34b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

After restart, we might want to end up with the same config
as before, even for multi-link/EMLSR. Therefore, don't reset
the stored link selection result in that case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index dbfbbfb5b678..57a0d8af9b28 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3937,9 +3937,12 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif));
 
 		mvmvif->authorized = 1;
-		mvmvif->link_selection_res = vif->active_links;
-		mvmvif->link_selection_primary =
-			vif->active_links ? __ffs(vif->active_links) : 0;
+
+		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+			mvmvif->link_selection_res = vif->active_links;
+			mvmvif->link_selection_primary =
+				vif->active_links ? __ffs(vif->active_links) : 0;
+		}
 
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
-- 
2.34.1


