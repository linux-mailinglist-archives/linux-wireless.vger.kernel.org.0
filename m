Return-Path: <linux-wireless+bounces-28772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3ADC46BF0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6913A34750D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431C12D373F;
	Mon, 10 Nov 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l65JHSuX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81643101DB
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779762; cv=none; b=AExoUuIybuLHaVd5n/0RPrks9vJvT3lcyscQ9FWm8AtNXd9pjcwOqWSFl4Sb2G2gx0XEHWpoglJDkTFI+505yn2DTI9xDH5z9NkCcnKX3GWBQu68DBro4iAFDS8OUXwbildaIta70KbYHJCZJmctMBuDm5NDSNh/kkrdR62mWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779762; c=relaxed/simple;
	bh=NZp5bGdYuYd1V5GF34uDD0XWFV4+lXIKpWr82P148A8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozSbqgXQ3rjNeHCIkIKKdnTB3KtpA3LhxxjzvxD9hKPoRGrfH6IHshxL5Tqz8CRApAVeEwThXOVlDa85HY34G7bZ2Ce+fTcugG520kkMpwnOITsiFs8MNC6siPi65R/p2S9JXTwYb8JCkrxrggtOLw2bLIQQ3lXbL0MJtChd2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l65JHSuX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779761; x=1794315761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZp5bGdYuYd1V5GF34uDD0XWFV4+lXIKpWr82P148A8=;
  b=l65JHSuXat+4skGZjaoWT//rlbsM5PZX8scoEQmanSfqB0uiApSLADc4
   9VTA1/nfb35Cx1Y/9vVzoljk08uoT7LoZ/2gC3n/hXVeACC0IIO9DKN8v
   vHRHSSxEnl05fg9ix5jrREfnb48+hbz3iOKOrIeB0ezFhpPoyOM4sVBbC
   HmlAu4ydX3VZ8KY1xuDoaI8Gtohk5miFRVdMNZRmD3+gqogZmf0ETV0nu
   yngE00aEI4vtaJw44ETGfxgA6LfpmxkTBoZtTdOXvKGEW+R+/fXfMPScl
   JpFIg4e45I1+t9gJ0il3zKHcL/xQ39nmYdvN8Rk0r75yhcl7FXGtG1tmH
   Q==;
X-CSE-ConnectionGUID: 1/nZBOLiSCyvqeWj13g9pw==
X-CSE-MsgGUID: O94xHHJtQbKQGrENsCe68Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454878"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454878"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:40 -0800
X-CSE-ConnectionGUID: oxANb+TLSeemM41YaCcO5A==
X-CSE-MsgGUID: pygc1vmlS4mTVlMrZd2VAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928512"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: fw: fix documentation reference for ap_type field
Date: Mon, 10 Nov 2025 15:02:16 +0200
Message-Id: <20251110150012.d70f56dd24b0.I82956bd93a36c7fa5585f014c197afea0610a076@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Fix the documentation comment for the ap_type field
in AP_TX_POWER_CONSTRAINTS_CMD to reference the correct
enum iwl_6ghz_ap_type.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 535864e22626..0cd8a12e0f7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -766,7 +766,7 @@ enum iwl_6ghz_ap_type {
  * AP_TX_POWER_CONSTRAINTS_CMD
  * Used for VLP/LPI/AFC Access Point power constraints for 6GHz channels
  * @link_id: linkId
- * @ap_type: see &enum iwl_ap_type
+ * @ap_type: see &enum iwl_6ghz_ap_type
  * @eirp_pwr: 8-bit 2s complement signed integer in the range
  *	-64 dBm to 63 dBm with a 0.5 dB step
  *	default &DEFAULT_TPE_TX_POWER (no maximum limit)
-- 
2.34.1


