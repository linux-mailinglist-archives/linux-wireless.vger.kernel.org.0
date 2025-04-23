Return-Path: <linux-wireless+bounces-21874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353BA97E57
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D8188E39A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A05266B51;
	Wed, 23 Apr 2025 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j68viy2t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467126738C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387471; cv=none; b=DyXtqzdEt+in7R3i8ge0IF/fe2DrOTeYfIEVZmRwY2bd3EEmMF7p9JoLixVeD9slD5+MZPUGEvKKg5tfRhwi7U6WgXbejRwewgKVO/OeXRLTFFg3ddyMLJn6y4LIUzuwi+Ovs3M7TkLIh5tl6y5uBulcfGTctYyumkARDmqbnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387471; c=relaxed/simple;
	bh=ajIoWqSDuHD0IENlyOMoZsh9q4twXWKOjizwB4dtUDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4GyC6oEC8OXRicwDQ4FWJ6fWA126i5ZeJcew9CXT9D4lmQw0FIZNoy4ASD6EwmasVoQhXJlM0J1O6SKavZlCZlOzCQNKBVG4wpuqqxXjiV7YHy+PwsaTNFzexlJ9tYnH2zc5JpCTM3ok+4FmzT8DuqOi5yytCNBioc6XobodVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j68viy2t; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387470; x=1776923470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajIoWqSDuHD0IENlyOMoZsh9q4twXWKOjizwB4dtUDQ=;
  b=j68viy2tKUEaxbJA6v+sH35J6iCq+D3JXYGKuRSQ5O0fg1725HFKZ6oe
   ClREFNCfoPweK1qFz51M6RGbehyY6sOmmLTErpiKeQD+ms56iQe/n4kWF
   w/ifG23pU3mo57mWaaIcg8CW75vj6HklE1zxGwYzg/yQJoi4J2K25nwLe
   Sz0TghVaOxcqPlh8QaPbr82kkdQQKTR5dvSuqZfDFoCVcJAzIFfnyk8xM
   UdUKEJJwXLJ/SFUvkPP6vPhxq7Q5e1z5hMtnbythKWluWR+xz/XSy5kpv
   yucoanGO7pwAYd+qrMk83xjW7v1nqtgXsE47oxcjxESqo+kcheoDNbbv0
   g==;
X-CSE-ConnectionGUID: xpv267YyQyeSwpPEhOkMaQ==
X-CSE-MsgGUID: FMhiIBUJSm2Rbv/YhDjjWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844649"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844649"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:10 -0700
X-CSE-ConnectionGUID: 0MjVX0ryRzCJo+p3vrbFlA==
X-CSE-MsgGUID: zWyPXntGQUW0rcEMS7wAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164363"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 14/17] wifi: iwlwifi: mld: tests: simplify le32 bitfield handling
Date: Wed, 23 Apr 2025 08:50:33 +0300
Message-Id: <20250423084826.9155a412dcc7.I8330ca413d6bdf953e79361ac50939176bcc4e6e@changeid>
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


