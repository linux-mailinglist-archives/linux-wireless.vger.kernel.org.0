Return-Path: <linux-wireless+bounces-25068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CDAFDF28
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532CF4E6EDA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00226B756;
	Wed,  9 Jul 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak4PsmpO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922A26B75F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038236; cv=none; b=FNRUhWxqaftt6C8AXshMTnDDFnF8oxFntC5dzfveQn1VYayxP5+1FK/I1T/0oQG/yoIc9NFGXvaV/eU//VCdayKVOkbSeTpsnsTBcxwHfOYKBOAbCWJiNnwMJ3Z6e1Zh1kSC903PMZMYZIzUUpF+0vF2ZGPNAuwU7Hc2BHlQ6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038236; c=relaxed/simple;
	bh=8yeWEnOClSHq/cStlqAnOCWfXIKcCR/r0ZVSPuE6+l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5Opogtkl46GNIml1LSXN2UdxKT6ApCaCWRxYUyDzcAbwcXzo5Q+TncWQmNVouUWfdiBZuJZ9M/fcxAFIqb3/F9YzhThfZL8ndM8fGg3CcFc22Xr/lOkJLI+eBrQk1mrA92Ir7lAYIOY4ofOkCA3pqVLAP9LG3V3XF7NbnEIOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak4PsmpO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038235; x=1783574235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yeWEnOClSHq/cStlqAnOCWfXIKcCR/r0ZVSPuE6+l8=;
  b=ak4PsmpORkiL1Sd3pdDSlvlukM3/VVB7HHM5iUn/TfPXgZ6l5nHZoWQY
   +vvG5fFM/AScsj8XONdbDjQDDY76F/Nzq5NJekIiUN06lL/rc8tRMuxje
   VQDGwuOAi5B0Y7BQC9oNipFTdz2FYkc9ztVgOVJJbSU7Q9F6+A8O9tEgv
   YTJLmkytVSwpkPbUsijeW5lbqRi8hBbYcx4aa8IJqpA9jqm74CRmWHY/H
   OzyZYkZbMv3ECp5+XZd+L180rALa61CK2ULz5XfgdJdmAn9nHD4wfjx05
   cpYNPwsRsgQL3SIa1FA0Kz3QqOisrl6XglhiTS0kqc7CKumkKoDIKBVqv
   Q==;
X-CSE-ConnectionGUID: 4fgHy5gwRxydBwl4kK17wQ==
X-CSE-MsgGUID: 84M8BCuzREO2bqoOXRhQVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091181"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:15 -0700
X-CSE-ConnectionGUID: Q+Cd+DzyTXOGMVoSVJsLpQ==
X-CSE-MsgGUID: bWwYU1I9RfmhoAViDTBbpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 14/15] wifi: iwlwifi: bump minimum API version in BZ
Date: Wed,  9 Jul 2025 08:16:33 +0300
Message-Id: <20250709081300.71404c289481.Iea4f3d36e18029a817ec5d6641d08ac5ee025678@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting older FWs

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index c6cd892bff69..50d454514fe5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	94
+#define IWL_BZ_UCODE_API_MIN	98
 
 /* Memory offsets and lengths */
 #define IWL_BZ_SMEM_OFFSET		0x400000
-- 
2.34.1


