Return-Path: <linux-wireless+bounces-16850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011FA9FDC32
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D58161569
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176001E515;
	Sat, 28 Dec 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+uNqDQq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68673446
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418092; cv=none; b=mx2adLVkR+619vV3pavG3DzZUJXjZL1QIBRzUTxIsf22Ump+t3na3hihnLVkugNW6KxSYZK7xZLGpvcVqQyGPRRVtJhhgxHyDM5mT0I+1HGpLlyQoEH2YCHLibBXZ5nqULvStITvPTlZfS06Qz7gXdwCkUrqMZ9oC5knae4n8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418092; c=relaxed/simple;
	bh=ES3MnL8K1rJSRKxgGIW3ZQEUZFv63eqPn1z19MzhQBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezyMOF4aOqFbrXnTmob7docEWcCi4TIRc0ZN9mn2izGENYtD4ARO9IfkP8NdtD/aCFr/bZZ08i7aUnl/AdZ/yrtcYxg/Tm1gYkDc5kDRIvd/xPVsssCOsST//v2pS94YZomWOz9+0rx6yxhlvO03O1fRF4HSei045SsIsbveYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+uNqDQq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418090; x=1766954090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ES3MnL8K1rJSRKxgGIW3ZQEUZFv63eqPn1z19MzhQBA=;
  b=L+uNqDQqQ6KbA/JAVVnXty1I/ZsLKMjPAAlt2Iymd4sHUZQoEjECZ33v
   skNRJ1oPYjbZFXwnB57kSdtDCwmgSJxctCkBkOKftnBTw6jGWVPIZXLsi
   w0ab5LUOhv3ZmNmUtag638eK6Ne2NlDRF6/hNODg3EWCtJyY/i+y7T6uT
   Zz84fK2SojT/bjFpjiaBBnhlgn9uGnG/Md76lcXsej3WrkyaaVVrKv2w3
   OlZD73rMpbfYaseJL51kJChkYoidQnX62aGXyWZHD9ZaiSMHfDg/pJS3V
   tgVOb51B8QxIc2anjPs3c1pxJQ3FjUPHV97LXzgBITULnfJQoDrmIgq9+
   g==;
X-CSE-ConnectionGUID: w/oSPz2/T62P4U/Jko65CQ==
X-CSE-MsgGUID: cbIVZ7igQViOe1Li2f6Mnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479768"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479768"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:48 -0800
X-CSE-ConnectionGUID: 9mOPIbNqSe6MF667WPeQJQ==
X-CSE-MsgGUID: G5MOM+phRUGiJfIPAypfSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488406"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: add channel_load_not_by_us in iwl_mvm_phy_ctxt
Date: Sat, 28 Dec 2024 22:34:12 +0200
Message-Id: <20241228223206.7c7f3ebebadf.Ifac005cf1e3b02cba0861eb19bfd8099957faad9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

Adding channel_load_not_by_us in the mvm phy context.

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 43e304f22475..fbf7306b9b6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -103,6 +103,7 @@ struct iwl_mvm_phy_ctxt {
 	u32 center_freq1;
 	bool rlc_disabled;
 	u32 channel_load_by_us;
+	u32 channel_load_not_by_us;
 };
 
 struct iwl_mvm_time_event_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 00aac76e8509..2dbef7b46355 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -789,6 +789,8 @@ static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
 			continue;
 		mvm->phy_ctxts[i].channel_load_by_us =
 			le32_to_cpu(per_phy[i].channel_load_by_us);
+		mvm->phy_ctxts[i].channel_load_not_by_us =
+			le32_to_cpu(per_phy[i].channel_load_not_by_us);
 	}
 }
 
-- 
2.34.1


