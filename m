Return-Path: <linux-wireless+bounces-25041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D5AFDEF5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29649583FB5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1C26A1A4;
	Wed,  9 Jul 2025 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m272Wcvb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D326A08F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037346; cv=none; b=QRdSDWRxqKs2wiJwcK2YRR7550zXrVOHQbPn9NiW+C5iPf4cZ08z/eGltTMI5gUWF8idZccJMYqX0VSYZGGDh7vlhj4SU/3UlYpCy5nNavz/Ml4Xotn3WcivXq3igbl7qSOMysDqwTvw6hAuRDBbs7kmNNRdH3+YeabTd960jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037346; c=relaxed/simple;
	bh=cdbe92eU1hiM/Q7/aaDJvqc8c2EML1IaLczFuCeKTL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyULrJl2QlLT30wX0hlmTiNLMWD4ktSYgSzd7a/d178IO9n5dNWOw2fTfhLf7axGjOoIH3hHC3H1+pjngR9Dk7sj9D1Rs82gzWwjNspD8rWF7af3CFlSndsPLXYEAM5e/eOWSgC/c1oOA4/kO5SRxSC2Ph+sVFe+6rj/EQVRkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m272Wcvb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037345; x=1783573345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdbe92eU1hiM/Q7/aaDJvqc8c2EML1IaLczFuCeKTL8=;
  b=m272WcvbJe1mjtTDpO9sRE4ogECXi1n10pwHPMlUnX2hbSBosd/zC1a7
   BLa2IMfjPUqyKCeOk1oFFBdpcRRtBvSfRIP+SM09hG3Cqhc8qtIq0q7hu
   W4fmngpXlGHRD2lHpkiL5zUiZkR5zpwTytGIr+YUbsF3SPRC5JCuEjWdH
   /Bqx6Y4PmmwRbYbzcQ0BNU2M/TJoEXURmAOmFY/q832Xu/eA4JYHg45vV
   RxSmlQHM0fKijuIiCljh/V1TyRpXWeBzZGr1PN+2rkwkOwIBkR2aBcGaM
   hDRP9kuriyinCLOCt0ddLAIH7I6u0XFtFKLn4Lk+Yrmzx64aeifQbb6RW
   g==;
X-CSE-ConnectionGUID: XJQvyL8yQRimm7hxM+yR1w==
X-CSE-MsgGUID: 5Qkj9U4TRjmlXtjIEA6h7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501456"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501456"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:25 -0700
X-CSE-ConnectionGUID: VTnO6bBFR8qqt9vuXE78vQ==
X-CSE-MsgGUID: vs65RnEQS9OvXuNYIytNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859223"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: bump minimum API version for SO/MA/TY
Date: Wed,  9 Jul 2025 08:01:47 +0300
Message-Id: <20250709075928.30d3899bf536.Idc95ca09101e52b4980b292945abe944c24fc5d1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting older FWs.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 5158ccbd1fc4..467c45ed9af2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -13,7 +13,7 @@
 #define IWL_AX210_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
-#define IWL_AX210_UCODE_API_MIN	77
+#define IWL_AX210_UCODE_API_MIN	89
 
 /* Memory offsets and lengths */
 #define IWL_AX210_SMEM_OFFSET		0x400000
-- 
2.34.1


