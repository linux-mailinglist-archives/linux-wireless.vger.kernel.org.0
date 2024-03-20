Return-Path: <linux-wireless+bounces-5046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177BB88190B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBC6B22924
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EA85951;
	Wed, 20 Mar 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ee1NblPc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963885C46
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970017; cv=none; b=M+zuFOnZkx+W3WN0siygXex1RkwWH/BnhO4XvNnlozZvCuHUYRGJxe2iH51cL0qpurlxm+v5H7FFkvljFAqalNYmjExVo0EeyhJ/9QCOm4HiyH1fHiBdeawOgDNTmD0w1ohBvdqrsME2JYjbBpIrc3vY6XWEcNSt9Y16TqNB4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970017; c=relaxed/simple;
	bh=avv9ud8dXx0F1ls+X/6l7JwporMnyHH2oqTnQisLuPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkG84dxGx8tiuzXcPPnWSDNQXV8rDwOiz4Nieo4eYhoa1KuqNKOb9gg1QLrKxxW+RlxP7iMHdaYUqJqSooSgNBF2rV/H+AeOkTvUlmmKe9OVbogAGh6Sc/EzieEdPVBe+6k15PIQYzwrhreAJKf2iOX9mcoWaD0Krxp0LsAW6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ee1NblPc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970015; x=1742506015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=avv9ud8dXx0F1ls+X/6l7JwporMnyHH2oqTnQisLuPg=;
  b=ee1NblPc3SRy0tsX+Afu4F/9fiITnP3N3B+lbmW/dqc6v0DCO9089o6q
   PJFxJ5F7LfEsTzzcmlPc8cxFvrVIlOXnCqgeCEm9UBPxXuBRBG1xJJ4w8
   XiAM7CHYzj2BzmWciHROc+P9T6GbZU5KG6d9/Gn7bYPfnDU2QXTDtZyUI
   d4hclaSMxXGsQfRlXuuQNDaPirr0VDiveV2yF8wt+/kMCg1I7O8ds/3eq
   TxTvBdXoeRzqQHKtqPj0BbLoDStOSGTSFNqykWJDgUvSJUG9ZSfeXxcxt
   kfQ2fIa1kKL9asR1P9klMyGBNT8RvmVBXuiCNO2KJ6+LZHPUk2QZaN5h+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698053"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698053"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184116"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/17] wifi: iwlwifi: mvm: assign link STA ID lookups during restart
Date: Wed, 20 Mar 2024 23:26:24 +0200
Message-Id: <20240320232419.4a3273e5c6be.I7cb6cf096ab135f4b489f2806b116563624aa5ee@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When restarting the HW, mac80211 first adds the STA back with only one
link enabled. This means that iwl_mvm_alloc_sta_after_restart will not
see the other links and will not do the assignment.

As such, do the assignment when mac80211 is activating the link for the
station.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 4ba1599ed71c..94a01c0f261a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1122,10 +1122,21 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 		}
 
 		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-			if (WARN_ON(!mvm_sta->link[link_id])) {
+			struct iwl_mvm_link_sta *mvm_link_sta =
+				rcu_dereference_protected(mvm_sta->link[link_id],
+							  lockdep_is_held(&mvm->mutex));
+			u32 sta_id;
+
+			if (WARN_ON(!mvm_link_sta)) {
 				ret = -EINVAL;
 				goto err;
 			}
+
+			sta_id = mvm_link_sta->sta_id;
+
+			rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
+			rcu_assign_pointer(mvm->fw_id_to_link_sta[sta_id],
+					   link_sta);
 		} else {
 			if (WARN_ON(mvm_sta->link[link_id])) {
 				ret = -EINVAL;
-- 
2.34.1


