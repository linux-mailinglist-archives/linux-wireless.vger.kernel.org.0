Return-Path: <linux-wireless+bounces-8541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5538FC9AE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911332850A8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A17191481;
	Wed,  5 Jun 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaAWUxdc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4A1922ED
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585528; cv=none; b=kJ1AmCQgHKrtIwf047cc/Z+YSM7BE/HBw+mLlNrgRmezpLKPFRtH2ERuglLvwtDIU2XkU2/gVfGQY1VCX87YswAlN+jKtyeqvkei9iK6fn3iurKG2Zi28G8ZAssuToZ7Rur3PVXLu63/0G192hsx1dDNfWDa5P+sitkh8jRz28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585528; c=relaxed/simple;
	bh=G+Q8wcznfEoDpulEGuzrvEhwIIn0UZLoMuH2qbevAqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsTeEqzT6lcZk3Kq3JDdEsnOzI1on5EGa87+gBN/9LX4NhdQ3IsDvCyBBZwrXqc1aYd6yA/3V1p0J8o10Y0CvB98ro++H/evkbSuvExp+sNkGVNGKwYjRp+896OJkqOb2U8mWh94q3Sn3kQjQNCrowhDwnBat5pClQfQMNR20ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaAWUxdc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585527; x=1749121527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+Q8wcznfEoDpulEGuzrvEhwIIn0UZLoMuH2qbevAqE=;
  b=KaAWUxdcd0d/0cYKgqWhAwp2Or+MnOmAaxVqC2VwHLR0wsqj3WFFhfEU
   gl+qdW05Mf+hbLxRppXng5DzHF4Xqmc401iKCf6UhyinEKEzVK5IRmNQN
   JRN4TDbL5FCrXuVE3C4+K97qq+gd1aZtV2qCwzBeKKUdqhkYY7jKniRNA
   cCiijp1egfwIVnXfe3KcDNxIgz9C3Jr2weFLx/ww5xYZIAcZlMG9H0noY
   5St6ZLM1W3vTkO+AMYTQqD8fqx8MssKPvtMWxfC8LI8EgZbQywafWIR40
   INbbek7dzLPeArN71TdWgD8Q59wwBYg8XnfeCYD3UZ/4zJfOWWgQrZ1dn
   w==;
X-CSE-ConnectionGUID: yMVjKwJSSVyjuCaV2rkilQ==
X-CSE-MsgGUID: yP3CioqmRdu4PuWJvuBd6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402194"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:27 -0700
X-CSE-ConnectionGUID: XCEQfCLJSA+7fcADZHZaBg==
X-CSE-MsgGUID: MY1Dl/CXTKeJDBZUiBbBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997398"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH wireless 08/11] wifi: iwlwifi: mvm: unlock mvm mutex
Date: Wed,  5 Jun 2024 14:05:04 +0300
Message-Id: <20240605140327.96cb956db4af.Ib468cbad38959910977b5581f6111ab0afae9880@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Unlock the mvm mutex before returning from a
function with the mutex locked.

Fixes: a1efeb823084 ("wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active")
Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 8ee4498f4245..31bc80cdcb7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1238,6 +1238,7 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			if (te_data->id >= SESSION_PROTECT_CONF_MAX_ID) {
 				IWL_DEBUG_TE(mvm,
 					     "No remain on channel event\n");
+				mutex_unlock(&mvm->mutex);
 				return;
 			}
 
@@ -1253,6 +1254,7 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	te_data = iwl_mvm_get_roc_te(mvm);
 	if (!te_data) {
 		IWL_WARN(mvm, "No remain on channel event\n");
+		mutex_unlock(&mvm->mutex);
 		return;
 	}
 
-- 
2.34.1


