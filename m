Return-Path: <linux-wireless+bounces-28065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F2ABEE107
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39FA4E85AF
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F92356BA;
	Sun, 19 Oct 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEOmeWba"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0E2BE05B
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863546; cv=none; b=DIP2WN2W1hUeLcH8s5dMf/Dlt+IFs31ECr7Gf8T+Q2Xy+sa2bn6L//FotzyazoQk8ofs9UaXLrC2cDvXIcNAQp2hlAbabT6EA2JYPslp4sLSjJUx57AYx+m4NXufOqx1Tc2beXkUbAvvjsvKIU4hUPH4Vz5RKHfLectr9WkzMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863546; c=relaxed/simple;
	bh=oRYcCyI9Wu/4/wi7EWtwLdykA1+wX992WMQDxCPuSC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Chq+xXampk0KxzB2lVFi3CXXnkzjyzu3ybUEd7I98Mcj3dffT8weOc1VrQm3rJZzDXwQjjwovHbDMsSTlBzp24ojj939NTuOR3YpL26QCET1ADxpQX62aYcyhO9A1Yb21pbOLfDKRPgSQQrdxK3N038cIgmqss874a7uG+8CXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEOmeWba; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863545; x=1792399545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRYcCyI9Wu/4/wi7EWtwLdykA1+wX992WMQDxCPuSC8=;
  b=hEOmeWbalrr0Mt07UJbDUGpBoYRMyOLtsXu6CVIM4qNmyWsUDe7nDWNN
   VAgu+zTLs4d4QPim9+x/iZjbB1Axk3Zkkag8+wezytL1LVAR4cwN0CLCC
   xHvpgF0EL9Uk8U7Dl00pWu/v0PAGCvnHw4RZ984R/9xQ2S79ZUF1m6mZD
   zTYekIhrG9gRNL2HNzd31Ch+1hxcD573J/gukswhw07n/DnyQB58lsTNi
   jLHiGYM5ib4n/IFoT9MX7ZGUGmGF7kel08cp/7REoCKRBt206kdMXJue3
   hP0c/kXSUOKUZULNuO0ei0w/IUZUqvYDo0CwZjuxyLXatbp1DI24ghNXz
   Q==;
X-CSE-ConnectionGUID: WhZk/8B9TG2Ceij9otUOcg==
X-CSE-MsgGUID: I6LJ1Ua8Qm66Ba2aIq4X+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363189"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:44 -0700
X-CSE-ConnectionGUID: LcjDrNYZSxep9shJSusIzw==
X-CSE-MsgGUID: zq9y8TbQQgCh2+HFVfoWYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279896"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: use FW_CHECK on bad ROC notification
Date: Sun, 19 Oct 2025 11:45:11 +0300
Message-Id: <20251019114304.48aff2c8922e.Ie27b21eb26b67c8010d13ce9590751cad417d1ad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the firmware sends a ROC notification after the driver
cancelled it, we can get into this WARN_ON(). Don't do that,
use IWL_FW_CHECK() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/roc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
index 4136c98030d0..4e37a288471e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/roc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -231,7 +231,9 @@ void iwl_mld_handle_roc_notif(struct iwl_mld *mld,
 	struct ieee80211_vif *vif;
 
 	vif = iwl_mld_find_roc_vif(mld, activity);
-	if (WARN_ON(!vif))
+	if (IWL_FW_CHECK(mld, !vif,
+			 "unexpected ROC notif from FW for activity %d\n",
+			 activity))
 		return;
 
 	mld_vif = iwl_mld_vif_from_mac80211(vif);
-- 
2.34.1


