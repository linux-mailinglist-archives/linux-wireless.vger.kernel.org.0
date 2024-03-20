Return-Path: <linux-wireless+bounces-5053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728AD881912
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB16B22A0E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2A85C51;
	Wed, 20 Mar 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZD8mbgp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04E85C58
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970032; cv=none; b=VojAeVayCuarT06zzBGNm5WtRu9VFQ5FQ3OO0KD7tF0GqfqwxDluEvk82/nWD4LbsIVSFjAhUKJsHzZIJftMVXzgOWGyO2DA+h8bidb4WJYhWQ8cep72rR414rp+eJEXPzlIgPzS/Z/1BVMkdT7eqgUf4t0Jgm89vYcYYbWL+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970032; c=relaxed/simple;
	bh=S2OVw3zqxD+vnLQJBOqFCVxGXIL/GIW50cjVMgk8AhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adlQDJ5y4SHwwzH/zGHIP0vyCyXVIgSLQLNKmA4AxWf2kSMgK/3dVxvn9Or5NdnyrjVtDE21TZnp2Mhn9EjpSb1kWbTEND1gRG155daUAx1SNxuXicNtAFsv23pFo0NlX0CY4M8YuHhsMUBL4sehNvpbEmSalntJ5d2jxxHp6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZD8mbgp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970030; x=1742506030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2OVw3zqxD+vnLQJBOqFCVxGXIL/GIW50cjVMgk8AhE=;
  b=WZD8mbgpsv3kdgOL+TfnOsPjBV10z918XcVWwN/cZn+QuNpWB0PFiw+x
   xeWU1lt8yI+Mvz48PdLXwVuWsm6DoDmj4YUm9VvBEo9ajSnXlCXFAVZ2k
   HsJ7EoslHqD5uCt9WOqr1GBScTd80Wk+U9fdaoirZIYnHhFL3lpXaFA8Z
   TCR5E7QErZC19gKYGaUVXVZgbVHcjmhoaH8LMyr11ZwdN5loQSXoujeLE
   VJ0qObtmA81/NDHDiSgCIwgO1YzUJWb4YRQSDIUdBME5ZXsDUqcvl6mSp
   x1k4hDrzU8cPdG/ph3cPK4vcccSa7O3Q9DaIe3ovayEN2INz6GtV5tql7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698095"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698095"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184176"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/17] wifi: iwlwifi: mvm: Remove outdated comment
Date: Wed, 20 Mar 2024 23:26:31 +0200
Message-Id: <20240320232419.d656c2385b06.Icccd0640eb9f1ad72ff74792086435dfc0bee6eb@changeid>
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

This comment was added when iwl_mvm_alloc_sta_after_restart configured
the FW with an internal station, but then it was changed by
164a52d45e4a ("wifi: iwlwifi: mvm: send full STA during HW restart")
to configure the full sta, So there is no reason to "wait for mac80211 to
add the STA" as this is exacly where it happens.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 94a01c0f261a..902c64f210aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -616,9 +616,6 @@ static void iwl_mvm_mld_set_ap_sta_id(struct ieee80211_sta *sta,
 	}
 }
 
-/* FIXME: consider waiting for mac80211 to add the STA instead of allocating
- * queues here
- */
 static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_sta *sta)
-- 
2.34.1


