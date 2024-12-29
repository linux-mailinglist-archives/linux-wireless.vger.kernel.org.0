Return-Path: <linux-wireless+bounces-16867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A240B9FDF44
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513DC1618ED
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B76A191F74;
	Sun, 29 Dec 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5n8Pghj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC931957FC
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483517; cv=none; b=u8/Clh+w60V369vjZ95B1ssaWfKMxiyEmF2hwlZoLgETKTuIkEUw6I5wUZC8rubw5SSUuazW9qaHfViGK1zEL2BUrkWx4P7AXf+3rLtio8SpE/SlwUH0+tPx2kfVziWQcl5PLIYiC3SEY7HwdzOB1iX6omGCh1CM8U2pkuW46Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483517; c=relaxed/simple;
	bh=498tFDKw3O1/sO+AlB8SFBIny3nje5rH6LuY7qdcTCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sG3LmpxbEmnu/70ad7aP6hRWevuZX2A8AkRZt6VfYkSLWCvYtLesHLogrN4e7esO126idMr7ODDcZLh3Kv30RWXmvOX2CkXi2g7PacLVgQf8s1IEspiiJb+1+N+pgDFq98pypt8rBf4QJCAovB5fIQ4FST2l45NpEP0XUr2RdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5n8Pghj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483516; x=1767019516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=498tFDKw3O1/sO+AlB8SFBIny3nje5rH6LuY7qdcTCI=;
  b=h5n8PghjBs6HKKrWC0ABab87LV3ukBUIIfxCKIjSYnkm4mo/frDtq4Pd
   BNjpQgkJbeW0wcJqTzwbrOWdy9ljOOR+skT4iU+mRLGbXvrHv7H4AqKq8
   5IPV/yKXsv5l7SmWPj7Eso4Xrm6HCDpkuhgIpclrdz6TeZi/8iKL9VtwN
   w5GxQswAAu/DRv0A1emCEi6RuOs0P6b/IDKYwq8OXT+ji9gILEOOo+C0m
   jMnSYHeVk4lgntePterjKv7HB8jJDKGUANxD2ZV9waB+GMZk9gPWD3enw
   /iakpLHFcEK1lS0Mz9sf3qFnJZ9ukennGP0L9yu4PSoFw5478wPfatAOf
   A==;
X-CSE-ConnectionGUID: /zjBrCQVS6+HVLVx870ucw==
X-CSE-MsgGUID: TQjXMf86RlKFQFAZerS4AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572437"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572437"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:15 -0800
X-CSE-ConnectionGUID: MRPIyycNTYOzmSWEWDLm0A==
X-CSE-MsgGUID: bQ1eBirBREKCHHbYL3BJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656917"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/17] wifi: iwlwifi: mvm: fix AP STA comparison
Date: Sun, 29 Dec 2024 16:44:41 +0200
Message-Id: <20241229164246.08b05aca37cf.Iba1a6a637a758691f710dc4f3f03bd1d960fb087@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This should be comparing the AP STA, not the deflink firmware STA
ID. Correct the implementation so that statistics can be requested
for the AP, but not for other stations that may end up with the
firmware STA ID matching 0 in the deflink, or so.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6e0e12229672..359b8bf25e49 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6280,7 +6280,7 @@ void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 
 	guard(mvm)(mvm);
 
-	if (mvmvif->deflink.ap_sta_id != mvmsta->deflink.sta_id)
+	if (sta != mvmvif->ap_sta)
 		return;
 
 	if (iwl_mvm_request_statistics(mvm, false))
-- 
2.34.1


