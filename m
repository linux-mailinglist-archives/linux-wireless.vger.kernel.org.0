Return-Path: <linux-wireless+bounces-21895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0080A97F0D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA63A1932
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BAB266F15;
	Wed, 23 Apr 2025 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mapKemm0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814C266F19
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389035; cv=none; b=O3IOXuvddOzNu2A0QVmRF5kqe3vt26hd8lpPnRfvWROfZ+9YlIalEKxIUOSjIVqbShUHYcVsQPdh0PIr+RTovMuum4iH1MhHGXXc+wdyzcKvDOo5vaW+vVp2PM5Np3Acj7JNbsaRJDpK+6sx5TBoSpMqAXYOqjJtPwrAsUit/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389035; c=relaxed/simple;
	bh=ajIoWqSDuHD0IENlyOMoZsh9q4twXWKOjizwB4dtUDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZTMl1Nkqdd2XsOPqUpT3+kmmtRo1C837D+LLIwmgFYA/maXRy2kVqhgrfvBQSYp9k/wPajizjzv/FJJyAw0VvNdRODfwI78QCmOzWi8R4AKSOFOSenVJgeI4VJrHD+yeajPurnmHM06IYq4OwsEQu7/xEvUA3dD7GjzKnfsmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mapKemm0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389034; x=1776925034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajIoWqSDuHD0IENlyOMoZsh9q4twXWKOjizwB4dtUDQ=;
  b=mapKemm0cUe+w+JX4od25EEttQHJK1qSdrpiwTNfXF1x9Xt7A0GQC/vA
   25ykvHI5vEGo3vrlGiUAoDBb8IG2/dgYflEu7GzuzFAoAaYz4ZfNcE+vd
   tHf8Fvnx24tRpdZhiQRcQ4KIyEgwpIuZT9LwTIubprSjjV87htKGZHps7
   qP/Jo/rP5LiOYPwiVllOM5silecrC42gIkS3v2XbVj2c2RszXtsnHhkXO
   20H2uMA3QKUC9Cqa954Hqf/KLzRgGnZ2+0Uh7DjfN6djbYjNTbpUWGHvl
   W1fsVgDmVHlwg1TGsJ+LjzdHp/Mvl2/YT2/T4/iB9SYzC7vfF9g3NxYb+
   g==;
X-CSE-ConnectionGUID: dsCVoQm6TbuERZV+3KZoqA==
X-CSE-MsgGUID: bFIkVW6kS1SnrvG3GibEIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843661"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:14 -0700
X-CSE-ConnectionGUID: bdBvA8TXTqGyOfuPel/70g==
X-CSE-MsgGUID: W7+YxjVuRMaMVFGUq55tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269096"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: iwlwifi: mld: tests: simplify le32 bitfield handling
Date: Wed, 23 Apr 2025 09:16:40 +0300
Message-Id: <20250423091408.9155a412dcc7.I8330ca413d6bdf953e79361ac50939176bcc4e6e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We can use le32_encode_bits() instead of cpu_to_le32()
combined with FIELD_PREP().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
index 1fd664be1a7c..29b0248cec3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
@@ -474,14 +474,14 @@ static struct iwl_rx_mpdu_desc *setup_mpdu_desc(void)
 	KUNIT_ALLOC_AND_ASSERT(test, mpdu_desc);
 
 	mpdu_desc->reorder_data |=
-		cpu_to_le32(FIELD_PREP(IWL_RX_MPDU_REORDER_BAID_MASK,
-				       param->rx_pkt.baid));
+		le32_encode_bits(param->rx_pkt.baid,
+				 IWL_RX_MPDU_REORDER_BAID_MASK);
 	mpdu_desc->reorder_data |=
-		cpu_to_le32(FIELD_PREP(IWL_RX_MPDU_REORDER_SN_MASK,
-				       param->rx_pkt.sn));
+		le32_encode_bits(param->rx_pkt.sn,
+				 IWL_RX_MPDU_REORDER_SN_MASK);
 	mpdu_desc->reorder_data |=
-		cpu_to_le32(FIELD_PREP(IWL_RX_MPDU_REORDER_NSSN_MASK,
-				       param->rx_pkt.nssn));
+		le32_encode_bits(param->rx_pkt.nssn,
+				 IWL_RX_MPDU_REORDER_NSSN_MASK);
 	if (param->rx_pkt.old_sn)
 		mpdu_desc->reorder_data |=
 			cpu_to_le32(IWL_RX_MPDU_REORDER_BA_OLD_SN);
-- 
2.34.1


