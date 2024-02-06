Return-Path: <linux-wireless+bounces-3233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AE84BA83
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8D61C21D97
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E60132467;
	Tue,  6 Feb 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PH9/h8QO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1413474A
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235351; cv=none; b=Z9J99Oaqm8ndT8rOTlvIVTwhrzEtq73BbYKv6jJdPyz60Zt5YKcJ0tdhhuj8lIwnltJ7sGrVeqzy8ng/hkOrZaFkFNytRsH0sRG0Pl033ji3ZKHKHuCF86xJrGSrNO9JW1mtZsg85xJw4GjbXa9vaJsB1tISzrgX1mPV9DRP5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235351; c=relaxed/simple;
	bh=9bxSUR/Aa+WbwU4uYsleMVu4tSAKMbdkUR0iwQwgcPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqXffugjcrBhOzJGtO87iCGdpx/BPNhPTxvD44+rKcTOXsYnanDa4a/YZNiBV7BTrj4fyvyuR5qUXMiidEzCQgpNwpJAL2ao+ndSPKQmk5EzUjy/kHrCDVBKPRa8PGrRbDXvFfIpQJgQqRRmeNOEN69WiVXizKTiqfPuMoIRPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PH9/h8QO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235351; x=1738771351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bxSUR/Aa+WbwU4uYsleMVu4tSAKMbdkUR0iwQwgcPA=;
  b=PH9/h8QO3Kh7/zsG4PIbOINOzRjfn7R+sJRU3RwpcX3mXWFvYRl0nJXU
   czEUWFb7G2MIMJT30V6HopiBevY2qIWCyjQIrzNTzhyCv9aoVmi3aEZ+h
   3JKjb80G3U1PAhiOXGbkHSG+Yat4XoT22cNpLx9T1sIbcY12tXv8XmzKS
   PPhK9Lvo64KQb4S7OQ77WcPvm16PYd/1TIrXdQPak6OZXx45RrP0b2fxG
   vb3uQbFjWCj8EWflixNGqv0yesqrPKA0PBHIYB6j9gQLIx8XNHz2fUSHF
   KJg7uzVHTuM2lzEmdbpoBGWenM/KiUHNYui/6xZZXxMBTbMAzDB0H23Fb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252308"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252308"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349817"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: fw: allow vmalloc for PNVM image
Date: Tue,  6 Feb 2024 18:02:05 +0200
Message-Id: <20240206175739.9b4c06b5d533.Idf699b36ec95ee36f530355cd2cb1da297a098f1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This image can be pretty big (I've seen order-7 allocations!),
and we later have to copy it to DMA memory (in newer FW even
there it won't need to be contiguous), so we can easily deal
with it being in vmalloc. Use kvmemdup()/kvfree() for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 053174f00e49..1195e708caa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2020-2023 Intel Corporation
+ * Copyright(c) 2020-2024 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -252,7 +252,7 @@ static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 	}
 
 	new_len = pnvm->size;
-	*data = kmemdup(pnvm->data, pnvm->size, GFP_KERNEL);
+	*data = kvmemdup(pnvm->data, pnvm->size, GFP_KERNEL);
 	release_firmware(pnvm);
 
 	if (!*data)
@@ -275,8 +275,8 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
 			if (*len >= sizeof(*package)) {
 				/* we need only the data */
 				*len -= sizeof(*package);
-				image = kmemdup(package->data,
-						*len, GFP_KERNEL);
+				image = kvmemdup(package->data,
+						 *len, GFP_KERNEL);
 			}
 			/*
 			 * free package regardless of whether kmemdup
@@ -333,7 +333,7 @@ static void iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 set:
 	iwl_trans_set_pnvm(trans, capa);
 free:
-	kfree(data);
+	kvfree(data);
 	kfree(pnvm_data);
 }
 
-- 
2.34.1


