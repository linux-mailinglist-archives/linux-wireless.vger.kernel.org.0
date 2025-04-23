Return-Path: <linux-wireless+bounces-21872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829CA97E55
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72AC17E21B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C9266B70;
	Wed, 23 Apr 2025 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ae7MmCHw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BF267396
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387469; cv=none; b=VKESV9CivRmoINDkApf3Pjj4P++w/LdJPf3Dki1g5VNzbITtXNX/xUqFDLqUp18qYHz8nYZk0Pnhrh9OreruGqYQC1ytRB+al7acconr3UwiqAK2IDJ3+CsihoTDZZNx7HmLRTPso20CkDNIv6Lm/MRXZ5/f61TMQ0RrhltveDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387469; c=relaxed/simple;
	bh=TDgUanoiDYEsLusK4sJsMvwRnzTz2Q1fOhniUcB4p7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0zSpP1YeGc76WWDZ+ZXekQMeZ9bUX8v6ekQbFO3XK8wz1cUtBo4/RDEnTKqSsl7TJ3z1seYVXJJpvTk/dKtNAIrWigJYkSqoJKBlJulg8jyUtbA4igzo/vFmbE3E7YZizzCi7v/LUsVvvBt2OfW/siA7Lus5pv8aOBg56yFkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ae7MmCHw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387468; x=1776923468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDgUanoiDYEsLusK4sJsMvwRnzTz2Q1fOhniUcB4p7I=;
  b=Ae7MmCHwX8/jTqRlEEzkfkFv+JHP6J2JiPcuBwhgs8F8ZOD+2Kk+mqtc
   K1dIry4sCxUOEfBJgqwHp9SNLzyHLigWmVAORL3FOWs6HcmwQ+hF3elBD
   UdLNIHwKjvaOpBOmsvad7kDiJj7zm2IBwlOUWx9DmB4GSK3fRrxCksDak
   Cmvp4B4g/IOiHx31ttagE3uXWfCc9P8CnvmsH2kHqg1k7upxg2YvIlX3V
   Fh8yLoagpsXUmphV0NicD3qjhWwdOxsYvvegko7B//caRGcuIb3WUuEUT
   7tBUJvgwOlv559HvVfT48VUAhImhO4J+eyyzizRNFY46YxxlsAl8A+GJC
   w==;
X-CSE-ConnectionGUID: Vv2MSyzxRNquXLlqzND/gQ==
X-CSE-MsgGUID: zTwBEIuaTgyC3ThvrUT6XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844642"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844642"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:07 -0700
X-CSE-ConnectionGUID: J3jD0Ex5RMuOEjPdUEwI4Q==
X-CSE-MsgGUID: VyjVq8I9T3m11A/GYT8FGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164352"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 12/17] wifi: iwlwifi: mld: inform trans on init failure
Date: Wed, 23 Apr 2025 08:50:31 +0300
Message-Id: <20250423084826.c7e178748ef7.Ifaf15bdd8ef8c59e04effbd2e7aa0034b30eeacb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If starting the op mode failed, the opmode memory is being freed,
so trans->op_mode needs to be NULLified. Otherwise, trans will access
already freed memory.
Call iwl_trans_op_mode_leave in that case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 562d320b2c3a..87624730fb50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -425,7 +425,7 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (ret) {
 		wiphy_unlock(mld->wiphy);
 		rtnl_unlock();
-		goto free_hw;
+		goto err;
 	}
 
 	/* We are about to stop the FW. Notifications may require an
@@ -471,7 +471,8 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_mld_leds_exit(mld);
 free_nvm:
 	kfree(mld->nvm_data);
-free_hw:
+err:
+	iwl_trans_op_mode_leave(mld->trans);
 	ieee80211_free_hw(mld->hw);
 	return ERR_PTR(ret);
 }
-- 
2.34.1


