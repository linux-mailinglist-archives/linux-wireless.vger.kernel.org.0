Return-Path: <linux-wireless+bounces-9536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73425916E73
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0628124B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913C176FA3;
	Tue, 25 Jun 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBtFroA+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EF175579
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334298; cv=none; b=XTAjr7f1i9gbYB3uMdMOPK5B+BMnOP4LKP2RajYRPWSU3l9kK/8pDtTrn7UlqytVmqLACtP/n/uLXKe+IonmMMvEQ9J4cjuz2LWsjRoqRIcFPJNMiID1ZRqlex8oGpmsxym73OHf/uYC9MuX/FiEWPEQhPhjY0NfLb1gYZPVGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334298; c=relaxed/simple;
	bh=AkQ3W1pf/c8MAmd9EKkARhOAbbGMgIsawC+YkEEAYKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e8MUNmxPe0zo1j9WzVEw/rt5UTSH3FC6l+QgYNlyzWV3y16dTRJc/AppKCCWqcWX2VAds26OO6VGYp7dvK7adf/Qp8nIuM4OMbx/qb4NB3iuJ0A0nC2MJk6GkaUMVZDnU46nEFQSORmnKWgmtoWJgKH5yvSzULETzXNQfZmVZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBtFroA+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334296; x=1750870296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkQ3W1pf/c8MAmd9EKkARhOAbbGMgIsawC+YkEEAYKg=;
  b=SBtFroA+G30Kjy3T+xjabD9Sp/oKHaHRDirJOHVuXFBp84wWblY+mKgF
   ItMAmulu93kTTL85WmBV24NoTQyUUdS8yAGH2XZfK9ykPRXOI+dJpb9Vy
   tKXAPfocNpXoi2A1asIJrhHm6U0vHQKqAc8jumFKlQ2fiBAKc+w213l4w
   wy8MM7Xp4Jy1SYRfJxrSJLb4YDs3XUI9sQoqbMSrvPTJ+u1oALw1Pp+v2
   Ew/u7sn16buJohT+vsPhxXwHq9BMZuFiLKhWKmSGlwVaN+6dKr/Y4BGPS
   VHae5wli+p9saxPTu7iC7q+0/CHZUTw8/xSsl5jSjN5889aUJxxsgtL5I
   w==;
X-CSE-ConnectionGUID: zWV8ngmTSQG23jiz2+5AQg==
X-CSE-MsgGUID: wuve1drdQvKzqJtLOfPdWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594684"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594684"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:35 -0700
X-CSE-ConnectionGUID: icSSBSSORYW62BiELYBeGw==
X-CSE-MsgGUID: y/+L/TRZRuGeqYDL7X7Cfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632454"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/17] wifi: iwlwifi: mvm: don't flush BSSes on restart with MLD API
Date: Tue, 25 Jun 2024 19:51:08 +0300
Message-Id: <20240625194805.c6d86dc2377e.I246d0fae0d23ed34b7cd9c3400edb004eb5ac1d0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the firmware has MLD APIs, it will handle all timing and we
don't need to give it timestamps. Therefore, we don't care about
the timestamps stored in the BSS table, so there's no need to
flush the BSS table.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ef5acecd11fc..52102a24f972 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -457,12 +457,14 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 #endif
 
 	/*
+	 * For pre-MLD API (MLD API doesn't use the timestamps):
 	 * All the BSSes in the BSS table include the GP2 in the system
 	 * at the beacon Rx time, this is of course no longer relevant
 	 * since we are resetting the firmware.
 	 * Purge all the BSS table.
 	 */
-	cfg80211_bss_flush(mvm->hw->wiphy);
+	if (!mvm->mld_api_is_used)
+		cfg80211_bss_flush(mvm->hw->wiphy);
 
 	return 0;
 }
-- 
2.34.1


