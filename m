Return-Path: <linux-wireless+bounces-3348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A784E5BC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EE01C25D16
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F881AAA;
	Thu,  8 Feb 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrXMfuNC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE58121A
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411544; cv=none; b=ROPaWyTOqXbwOauXOaEphD6ejhsJOv16jBbxg7bq2g/ttp92VmOpg4iqBSgb6RFhQXzsub3hocryuhUwI+bU/YFDdrXKSYMxeDPLnAnAn9b/9MhbdJ0/AffbWZlwqPmmmEswpVtAu9nJBo1eLSOUAYs6uBgzD6Myc6WVC0/Smow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411544; c=relaxed/simple;
	bh=I/H4U/lfQUWwwj0yTN9/OSvpK9Z9N/+7f/OJgmDYRZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDKnyIx+BUnzKj+f2XCcpEOVEcxRwt9SfRtuPKhq7u6dI3xz0jKT6UVZ5fKcIk2x94uAYDijhW/vHviAiOi3ughqw57N/H37vCZgveoYHaVdyjKcwHoUHT+XPF4whjckOCa/bYKvwMFYrfYu/ScOPLL0fDglc9KhPaqCJoCiHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrXMfuNC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411542; x=1738947542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/H4U/lfQUWwwj0yTN9/OSvpK9Z9N/+7f/OJgmDYRZw=;
  b=TrXMfuNCDwDGW+16kcsh8WDwY3Raca+/QY3+UqD4hpIhJxA8/ARwU2kN
   8B6SURrWvc1Uy3Fi2DqsJSQbMQ9n3Hi8+qRNVYZ5RMjWtLymwcsfHpSSt
   QqmMIA9zo7zPgDkNZ+RnO16pHNxHVhK5UVjsVLfIeQqaFOTa/JV0M6ndc
   U7ZJBkPHaSnvDuR5prtw3Rlmv5HVscS0zCXPSY50fHR+RdGRyrmhnJxJt
   2RGHZRB9iJphc3RSul7UHwX6zD2QB+Io8h4EScBLicjofRcnvG+DMTQ1C
   i9wzJWo1uU1jhCv8y0ZrxpcnI3bRfYjYbGQLq4+Qfxc+M4s4pY7Wuv0M+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403966"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318830"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/13] wifi: iwlwifi: mvm: work around A-MSDU size problem
Date: Thu,  8 Feb 2024 18:58:36 +0200
Message-Id: <20240208185302.3dcd0a1767d0.I450d35f3085b3b04a96dd1e1e7d8c27bda9ce8f5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware will now start with 1500 byte A-MSDU size
rather than 3500 as before, and that seems to cause some
really hard to debug problems. Keep A-MSDU disabled if
the size is less than 2000 to disable this for now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 6cba8a353b53..d9b16ee8fd39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include "rs.h"
 #include "fw-api.h"
@@ -479,9 +479,15 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	}
 
 	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU && !mvm_link_sta->orig_amsdu_len) {
+		u32 enabled = le32_to_cpu(notif->amsdu_enabled);
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
+		if (size < 2000) {
+			size = 0;
+			enabled = 0;
+		}
+
 		if (link_sta->agg.max_amsdu_len < size) {
 			/*
 			 * In debug link_sta->agg.max_amsdu_len < size
@@ -492,7 +498,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 			goto out;
 		}
 
-		mvmsta->amsdu_enabled = le32_to_cpu(notif->amsdu_enabled);
+		mvmsta->amsdu_enabled = enabled;
 		mvmsta->max_amsdu_len = size;
 		link_sta->agg.max_rc_amsdu_len = mvmsta->max_amsdu_len;
 
-- 
2.34.1


