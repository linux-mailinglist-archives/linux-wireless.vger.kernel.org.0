Return-Path: <linux-wireless+bounces-7184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E968C8BBF72
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DDF281DA6
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8823B0;
	Sun,  5 May 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVSej6HG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0C6FA8
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890028; cv=none; b=AucExI+mBhoDYou1RukdWEQMuuZ5UKv2aOsQAHGeFwx2bZoibj6t92z53Blw5GLN/d5PwdExdA4O7i/zM+fhAiP1GXQLxb+vaIQ4Efu3ztV1iNzfvSskH/vihmnN0/gnzXPv0X8rAh290mpbnG1kcctctP0uhj54MNP2jqNhpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890028; c=relaxed/simple;
	bh=DTo/uaxtyOfASmehvluczep0GFn52uKxTV1Fr5U9CIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ut3YSEbziGqgQh+7gGqWO/u2rau+wKOarP+l7nS/XBxL3EDODt5Otxt0L8+xhHSiZ3Mij8NwNT/8En0olm4v9O+HNbWmpD/+3heYgABSlIXBpCjMnhdL+H1LMW2LsrrAH+/1bfzDyW/V8yoaUIFkHYtoTf1TH8GiShKa34ygPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVSej6HG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890027; x=1746426027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTo/uaxtyOfASmehvluczep0GFn52uKxTV1Fr5U9CIs=;
  b=mVSej6HGNUZ7ybGtCjtVFZy7+QSbW52Jg249NvsMuigRiHcfVS9C2HZj
   WWnZAxKlWtcbpx3IFXfYlkgeNjZn3xgT1HcwH6mVCvbhbGwHe/+oiXSUt
   POGUYWq/hOv1lxMhLyLzfJGRvIXtwyoIKUoxa70Io3JqcMq8tzgAyLrlT
   Fg1hk4nqKlz6OFYhADeHfsNkw0H+db0GOZVFHpEzYMJrcxymHh/GjOcsc
   PabE8zg6JZe+wlS9rMNCzYSy3TzTcyWyaWqytfiEFEfgJUoF52Pme3Llp
   sVDQBtfMAYXKFjuPS8FmYNGubNjg6ia55hKwDjhbVZo9YBrjjN0+1whid
   Q==;
X-CSE-ConnectionGUID: aYMFRYT1R+O2hE5MB13NCA==
X-CSE-MsgGUID: UOU7tJnATVGaV6QGZER80g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461809"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461809"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:20 -0700
X-CSE-ConnectionGUID: unNgmFxpTp2W47IqIV+6ZA==
X-CSE-MsgGUID: OMCgiyJKQDmY7VYaielATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903601"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: don't always unblock EMLSR
Date: Sun,  5 May 2024 09:19:49 +0300
Message-Id: <20240505091420.eb861402dac9.I6a1d9f774f5551cfab60ea37b71a62640496af9b@changeid>
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

When an event occurs to unblock EMLSR, the code attempts to re-enable
EMLSR. However, the current implementation always tries to activate
EMLSR, regardless of whether the blocker was set before the unblocking
event or not. If EMLSR was already unblocked, there is no need to
re-activate it.

Fixes: 6cf7df9f013f ("wifi: iwlwifi: mvm: Add helper functions to update EMLSR status")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 1ce52adf3173..79f048f54a21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -956,9 +956,11 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
 		return;
 
-	if (mvmvif->esr_disable_reason & reason)
-		IWL_DEBUG_INFO(mvm, "Unblocking EMSLR mode. reason = 0x%x\n",
-			       reason);
+	/* No Change */
+	if (!(mvmvif->esr_disable_reason & reason))
+		return;
+
+	IWL_DEBUG_INFO(mvm, "Unblocking EMSLR mode. reason = 0x%x\n", reason);
 
 	mvmvif->esr_disable_reason &= ~reason;
 
-- 
2.34.1


