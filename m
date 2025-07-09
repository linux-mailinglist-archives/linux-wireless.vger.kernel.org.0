Return-Path: <linux-wireless+bounces-25112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BECAFF2A2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CCC1C82678
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AF525D20D;
	Wed,  9 Jul 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUS2Tb/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE82586EF
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091569; cv=none; b=WBzoO6ZTkXS06oCuInshx0uBiyNAdt0L4hkIN/uM2q8Ked0zUQbZreL5NrXmSWWN3w+Z4Khjj88npSBvMVJB5wSqpoKJUG721zm33ajgpK7MNZuucsYgLkDmFP8HFnDllOQ5WkF/79gsbfe2H5mI2rUfjdgPKz6HnclDl9Rjr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091569; c=relaxed/simple;
	bh=cdbe92eU1hiM/Q7/aaDJvqc8c2EML1IaLczFuCeKTL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jP4Ao8qcrZB+hrgybw90uAlZ3rySJzOHYuBKafBJihsizRHcc/X6jY8bYWlhKzmy5UvTYb133fP5PIZpNhB3gu0iZ7Rjb0n9Sjiv1jyOb2SBdqMXYdojqWZYaNMX2WPd+XitVaIOlOcYosQD7I67KVMK/ZKU2ktBRGFrs3AWDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUS2Tb/3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091567; x=1783627567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdbe92eU1hiM/Q7/aaDJvqc8c2EML1IaLczFuCeKTL8=;
  b=CUS2Tb/3TrqO/UYLVCf79gwH8qSbFVUoKzw/pEnu28FRlL3hSoS4FYGm
   crNYhQ3nnlK6tPyORZh5whPdPXm5NMZVk9feuaF4PcIM8l5OWv0qHmNii
   tqYwqxoFTQu/9h77z48u56bPmMDv6jaCa68icIhbZ6P8UNTUQHZGOcniG
   wwLP6NDNG1qLztRlN81onAMkGc2YjZjijIW+0ZsbZFjZedP1pw4r8gpen
   3FgDRRRKfnHQF428yIDva5n0/zTfAkMcdACv3oOzT/3+H1TAZ6aN+Q37s
   GX89Y44b1QVaR/CMaabjzDv1mTAKmhH5aZf5Wm8aPVcl1PsexjrkzCNu8
   Q==;
X-CSE-ConnectionGUID: NNBur1TNTfuXBcrRqb9fKw==
X-CSE-MsgGUID: eUf451x4T6im1z86TS7IjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240301"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:07 -0700
X-CSE-ConnectionGUID: 2u1hsUU+TmC5l20BPgJ8dQ==
X-CSE-MsgGUID: 2NCZJmq4QKeb6KZmUF+s1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126018"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: bump minimum API version for SO/MA/TY
Date: Wed,  9 Jul 2025 23:05:31 +0300
Message-Id: <20250709230308.64f504f3690d.Idc95ca09101e52b4980b292945abe944c24fc5d1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
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


