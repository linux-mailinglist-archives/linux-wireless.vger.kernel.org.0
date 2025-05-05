Return-Path: <linux-wireless+bounces-22474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99873AA9C1B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D2B17E145
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC226F44A;
	Mon,  5 May 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYBpBVIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2B25D539
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471449; cv=none; b=dm4m9r6RCKynYI60A3fWhVaBnSEtyJf8sD++v16DL5S0CJuHwRKPd1lTQaAeNVb4JeDd7nzDnDZLbR1ALhgLKyOXsoZa6xgRRG1LZwVnbygmoWnpXGJBahPAby4nPn9smesX9wppfrNs793Y+qzAeAcd4CHxgexS5X1Xi1s+BpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471449; c=relaxed/simple;
	bh=kmpfgoaStvATV5NfEQP4eNYHmQ1uH2BYjPBdQ1XlLe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvNLr2ycW48zaBXpF/mbq0xsk5IUn1YFuOqFbQ/xwwBmQDzZ43snV2+XCc6yx4nsKLDGL6LPQTJq3OalZ3fjdc67oPBl1KfuwtllMpZyeYzryYwAd6gL+aT0OFQNt2gqYK0HaiWraa04zx9sjcDJhE1shri8DYRpUnRfjjjAUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYBpBVIa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471446; x=1778007446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmpfgoaStvATV5NfEQP4eNYHmQ1uH2BYjPBdQ1XlLe0=;
  b=WYBpBVIaZmnwPImCFIc3M9b/w2RSeEiekVkpKQk6uTcVFMpZIvXV34Z1
   L8CpJFBxoJBnI/N9O51/7AmXVZB0KDG+E2uG4Q0lnsuFmryFMukR0Hxzc
   WFfiCshmfhh4G6PH66gDlAL6MimoqP6pouQTUxqvIOZy/5PAMaHURJzeh
   ffNnNq3SvrtLJs4avGjJ0g2tDOC6vsKHmvZSpX8xdi/7LwgWia6qgBD14
   tZEU6Mvb1m2GoUX8Y1AgfaPp72PhELFr5IEpR6mHB66wiWSWAXRDOV5il
   8ZL/hYd8hgd2b0zyMHnHRFhF0UVeVvqPuEqEN12znh4NyDVyYx9HBI/9w
   Q==;
X-CSE-ConnectionGUID: Ateqll3sQDy8uxW9hqD6Wg==
X-CSE-MsgGUID: OyMZWKnrS0S7L7YQLWKnmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359457"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359457"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:26 -0700
X-CSE-ConnectionGUID: JBnKK7IKS0SGbLkxlh6aJQ==
X-CSE-MsgGUID: 7ccbqVz4SZqGIAE6hlE4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698023"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: drop whtc RF
Date: Mon,  5 May 2025 21:56:50 +0300
Message-Id: <20250505215513.01fb866e7c38.I23611aa4abb8fd031a6d63a21f4b87b0d38a36a1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This RF module is now a product. No need to support the test chip
anymore.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index e7629420be6a..6e0e03a59fdc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -252,13 +252,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		rf = "fm";
 		break;
 	case IWL_CFG_RF_TYPE_WH:
-		if (SILICON_Z_STEP ==
-		    CSR_HW_RFID_STEP(trans->info.hw_rf_id)) {
-			rf = "whtc";
-			rf_step = 'a';
-		} else {
-			rf = "wh";
-		}
+		rf = "wh";
 		break;
 	case IWL_CFG_RF_TYPE_PE:
 		rf = "pe";
-- 
2.34.1


