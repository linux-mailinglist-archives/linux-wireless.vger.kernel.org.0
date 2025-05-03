Return-Path: <linux-wireless+bounces-22380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E80AA8264
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7D4189D49D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46427E7F7;
	Sat,  3 May 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpZfSVS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD727E7F1
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301517; cv=none; b=QP23jOQwrZxVCKoN19uffqHd/Tuq7Iqt7qdTxVE5WEKMo81K2lrdWny78etDfuuljQoMltHEjOY73CFdOnX5YIWdKFDYGQip/QFOSakuUlAAMr/jeWnHSGLwwhuGNHS3fRJWNEzlk3+NLGfooJydAxkVulcmkq/4EtlMQoOX9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301517; c=relaxed/simple;
	bh=IOJGEhFETQ6Rew08sWAQrEaL0XfE9iyOsZ2aqvlbQo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJxVYt3HaSfHmhan9q4wqzv291vn1p4pYE5qOHeICT3afjMQ0VKIYvkDJ+MzFFu9UoWKCAuEOGjPhizjkmPLdN2XkGp3pzp9vJLF7iKfQm8Ulrvyrzjp3G9ML1UJ9tuaA/S0zEkiu72yBUznQofte3U6Rh0EepdIOU9Uj6jakzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpZfSVS0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301515; x=1777837515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOJGEhFETQ6Rew08sWAQrEaL0XfE9iyOsZ2aqvlbQo0=;
  b=WpZfSVS0hgJtw+u0A/808H3heHMbdqSwNcMn+PGRnrm84RwYk0AA2+Yc
   nfgJaJgeT0Wvi1QsFz5/zxlLFHZ2DNgYcW7NNV/+n5rvVRM7ybs+ewkp8
   dHQZh0zJ8KO5ESN2OGFV5Z4mvuGSdL+h00w6KN9ypyw+oKqE9TA8qLQ/H
   tixW8UhC+T8P7goT/uL1KKnlpO/IJ/dO+hpAcrgHp6U1U1hSZA3QwZ8Kq
   5RLr3RfKyOxh15t5JUboIcOaOyyklmXAxp+kCTI/LTc8xjZ/5av7UKHqS
   ablb+3KkOpG9gRe6lx+cKUC0YB+/uF7lXkzvR9xsPwmRDi36eFEFWVRO2
   Q==;
X-CSE-ConnectionGUID: 76c9vB48RXKX6t0KsN2tNw==
X-CSE-MsgGUID: Kre9SSywTyS2ilAVd0HbFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613273"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613273"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:15 -0700
X-CSE-ConnectionGUID: 7880+v4fRG6Lr3UESInGlA==
X-CSE-MsgGUID: HpePHm+yRXiFR6TIAm/s+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644377"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlfiwi: mvm: Fix the rate reporting
Date: Sat,  3 May 2025 22:44:32 +0300
Message-Id: <20250503224232.0d1d1e022d63.I76833c14ba1d66f9bea5c32b25a54d8b36f229ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The rate validation in mac80211 considers a rate to be valid iff both
the rate index and the count are positive. When the rate scaling is
managed in the driver and not enough traffic passed to set the actual
rate, the driver set the rate to be the optimal rate. However, the rate
count is not set and thus the rate is considered not valid. Fix it by
setting the count to 1.

Fixes: 3e99b4d28219 ("wifi: mac80211: Sanity check tx bitrate if not provided by driver")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 068c58e9c1eb..c2729dab8e79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
+ * Copyright(c) 2025 Intel Corporation
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *****************************************************************************/
@@ -2709,6 +2710,7 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 							  optimal_rate);
 		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
 					     &txrc->reported_rate);
+		txrc->reported_rate.count = 1;
 	}
 	spin_unlock_bh(&lq_sta->pers.lock);
 }
-- 
2.34.1


