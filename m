Return-Path: <linux-wireless+bounces-2732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752AF841348
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D42289F2C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD011C85;
	Mon, 29 Jan 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0xgdhOW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945386F08E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556169; cv=none; b=eWv5H94xLHA5WqScpUs2wspM9lYBf6T9Nx1vM/PxbPVzxVb7H2xPkHm3G+EOgP/QhVZyVykCoYqMgPAW1pKD10SYLiEdbFOJZw4cjoDEf2kmN+h1iLPC3tL37kyW4St/XP+oJM/jaVhYvQ/0y/l0MMLzOgWTyVWKWFqiR5cEj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556169; c=relaxed/simple;
	bh=MslHVZ1NfqB1BAd6L6h1fG4tXjUWXHKNAaQZFB2udUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQi/r23P3YXYt2LxCEDSXXFVZG0MDxemAY49VqkczkRDwYJWbTg6KGcuDYcMeHpCoHCfMU/xYqVBdeJCan4l3tK1U8QdN7jHdn+EUx6/Oahi5/DeDsj2FxabdJLSWlcmcya3eBMEvgE6tHUjnzgyAoVcx87PBB6ewVKVr9go9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0xgdhOW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556168; x=1738092168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MslHVZ1NfqB1BAd6L6h1fG4tXjUWXHKNAaQZFB2udUE=;
  b=c0xgdhOWkZr9HaLwlVN+Ty9rNS0yLYhm1QufVWJNgRr9ncNgNrGIPIe1
   RQir6HtRWhsrVflJ5f12pvs9QzOVh5cCmXHIZ8QUaYZV/xXaxpscRbBrd
   qLp6CTLTzcwivA2YVi2uM4jH4H+TwtoE++L0gZLwzakO+YA2z8IBhoDrA
   HEshDlSTJyH5EZ8+4dGyNO5lukKxUcwOCaFfkxyBfwCgMISN82+h1ZuE2
   Q9pBBirXVB+l5Som29WPUUcoik+Gfolvzp1uWuB1sgiw+ly8E4pb3rpq8
   4fl5+GwF2Mx9I8cjKhltLn+odgWM15nw+njt4XKyAlV5wwV++/sz7GSnN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943051"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943051"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459142"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
Date: Mon, 29 Jan 2024 21:21:59 +0200
Message-Id: <20240129211905.1deca7eaff14.I597abd7aab36fdab4aa8311a48c98a3d5bd433ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

ADD_STA resets the link quality data inside the firmware. This is not
supposed to happen and has been fixed for newer devices. For older
devices (AX201 and down), this makes us send frames with rates that are
not in the TLC table.

Fixes: 5a86dcb4a908 ("wifi: iwlwifi: mvm: update station's MFP flag after association")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d19e478f382b..0ec1156c89c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3804,13 +3804,17 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 	mvm_sta->authorized = true;
 
-	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
-
 	/* MFP is set by default before the station is authorized.
 	 * Clear it here in case it's not used.
 	 */
-	if (!sta->mfp)
-		return callbacks->update_sta(mvm, vif, sta);
+	if (!sta->mfp) {
+		int ret = callbacks->update_sta(mvm, vif, sta);
+
+		if (ret)
+			return ret;
+	}
+
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	return 0;
 }
-- 
2.34.1


