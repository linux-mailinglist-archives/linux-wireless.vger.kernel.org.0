Return-Path: <linux-wireless+bounces-476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3B806A16
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891F91F215A6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9E1DFF4;
	Wed,  6 Dec 2023 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4mFmewx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35151A4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852577; x=1733388577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p8um2O37dpepdJJgYM/Co5gPR3mDblqffzTI6Gohli8=;
  b=M4mFmewxNPQRiXz7slzjDmgvkfyGJuiIy8vUSQfFKkF0ba5Cd0J2i8R2
   /cEIhvAg4iLiB2O+EVOyqe/Xr8Eeao8dLGQR85kkTWf4N280Wx2AmPKvG
   iVVDmBXprt+3dTxS3zJFys780UN+nPLah0QTmriqhnjQHQHR3exR/hK3q
   vGQLNRGOEcyL5CKdPIT5qHRg+cV681wyqHQLMbfmLDAThGLe9L5uWx78e
   BNWJ/cHlO/d8RkxZNgMbLMlM/p19VFbLCCDsg1v66ZD5K9NWJIcutFY7U
   RCrIC6bWYzt8k+t/p0jlpYBYT7xxl2Jj1cMG3BxW5knKTfT+DBSuL/6A/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916514"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575373"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575373"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:36 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 03/13] wifi: iwlwifi: don't support triggered EHT CQI feedback
Date: Thu,  7 Dec 2023 04:50:08 +0200
Message-Id: <20231207044813.092528daf59e.I5715769490835819beddb00c91bbc9e806e170cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

EHT CQI is one of the EHT PHY capabilities. We don't support EHT CQI.
The non-triggered CQI feedback bit was unset in a previous patch,
but the triggered CQI feedback bit wasn't. Unset it.

Fixes: 0e21ec6edbb5 ("wifi: iwlwifi: nvm: Update EHT capabilities for GL device")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 6015e1255d2a..480f8edbfd35 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1029,7 +1029,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			  IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
 			  IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
 			  IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
-			  IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK);
+			  IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+			  IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK);
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[4] &=
 			~(IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
 			  IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP);
-- 
2.34.1


