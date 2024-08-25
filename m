Return-Path: <linux-wireless+bounces-11909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF595E445
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612621C20A0A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE015B108;
	Sun, 25 Aug 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9N0/NO+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFD16BE1C
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602651; cv=none; b=H6x42MyWUli2hjCsYRWrQq0Smn2nCPm55S1jRc3jC/z0FPGqp7dYX/FWvj2mF4lJm2cko7cm3qh+ljmP59AiOFZTTqGJHqblCPOa+bMpfWmDVOVg+oCXSrYW4mGJXJKmtG0v9wMleXN72j0Nr2cMZK7oU8yWNUjsYStTeNXKlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602651; c=relaxed/simple;
	bh=UETGaDT7mDaLgwscxlnaZu2HAsMYoP0Ni2SvwHqlz5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw/tqUEKQmlBRSCTs/1QO6YAfzQqUPAFsm2WnU9PCevO+dN+1lVfQ4W27HKxa6HNaBap1NptX60ogEukKv8l0AgyVkdMuKyeL/SLv+R9o/eW4FpxcCi3jtnZwqDxZdssNBTMXTmAzBjwjtGPIsJmzcMdlWSWPBEQ4kI50IowdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9N0/NO+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602649; x=1756138649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UETGaDT7mDaLgwscxlnaZu2HAsMYoP0Ni2SvwHqlz5Y=;
  b=e9N0/NO+G22JvNRI9ZmNUgH+UNiSSA7Zt6w/LFudXsfvQ7HMlEg7oigw
   XEsVNbabN+G5EWVh353nMG+qTTIB5IModcRK3UnI6r4yvu5qDAPNNG2Fn
   ht6Uj/6AO7jg3Mhqkdp+xGmTIwdpTHW6JGb0HuIlv5k12pD2MpreSjfLA
   chPGI5tH1fDIibX9yPMsZSMMFj3x3Y0QTTQiIqJKJihvSc7AYXUkoLFDE
   4NViIJ+0CTaxGIvVS0cri1khBmFm2vjYLa8gm0OCp/eYhmts8liGki08H
   7Um+51tKZMvzHJnljVPJwkZjlLlQMw7h5womhyemGTtHMNbmKw6aJnhcm
   A==;
X-CSE-ConnectionGUID: C2ULjcRTTmi9dxK3wcwZTg==
X-CSE-MsgGUID: pwzx+vczQKmTxZTyjxRWQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544123"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:29 -0700
X-CSE-ConnectionGUID: cSN7O//rQWW3gUmxa4Gsiw==
X-CSE-MsgGUID: XcNr48+dShSAoZu0pAnTbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999738"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/13] wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
Date: Sun, 25 Aug 2024 19:17:04 +0300
Message-Id: <20240825191257.a7cbd794cee9.I44a739fbd4ffcc46b83844dd1c7b2eb0c7b270f6@changeid>
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

There is a WARNING in iwl_trans_wait_tx_queues_empty() which we hit it's
become a WARNING.
The problem is that we can't expect anything from the firmware after
it's declared dead.
Don't call iwl_trans_wait_tx_queues_empty() in this case. While it could
be a good idea to stop the flow earlier, the flush functions do some
maintenance work that is not related to the firmware, so keep that part
of the code running even when the firmware is not running.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7236ff7277ce..5544426dfd1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5818,6 +5818,10 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	int i;
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
+		/* we can't ask the firmware anything if it is dead */
+		if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			     &mvm->status))
+			return;
 		if (drop) {
 			guard(mvm)(mvm);
 			iwl_mvm_flush_tx_path(mvm,
@@ -5911,8 +5915,11 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	/* this can take a while, and we may need/want other operations
 	 * to succeed while doing this, so do it without the mutex held
+	 * If the firmware is dead, this can't work...
 	 */
-	if (!drop && !iwl_mvm_has_new_tx_api(mvm))
+	if (!drop && !iwl_mvm_has_new_tx_api(mvm) &&
+	    !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+		      &mvm->status))
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
-- 
2.34.1


