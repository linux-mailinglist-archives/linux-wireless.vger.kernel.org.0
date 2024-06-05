Return-Path: <linux-wireless+bounces-8537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7C18FC9A8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD71C20EC8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DC1922FB;
	Wed,  5 Jun 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYnOE93S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD861922F1
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585519; cv=none; b=G+JcJ2+xTeGJUoyUGEifE3C/MWmS0eK53JbduXRPwJ2PBG5I4MCquPQf58uc8QbB4pDpWHbXfs7LmS0TrufTkvfujOZ96lKfOqRgrZC1vIG41SKJ2EHzIdpYvgQza6mknbL6Xew45iaGoqQNdaKYAlFvCLCGl78i6N2R+jdLJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585519; c=relaxed/simple;
	bh=XS7C8V/A77OQaYyjVUXtdMXt+t8x4Kx5wI7nMWNn0DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NuIrD+skTQzNlhq2+1SJ3pMtrwetqOb1itR2bEh1PPIXhyCNL1xwrskGzJt4ZVmJCOg2yP+8FrHyJo+W+sukvdZY9++r9aMeaguB6HNmxGQ22ylj35oaPbOyzVv12qJJz9vaiJpTpHNHrFDSPfTgR69dVK3bJMHz4ufliiCmzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYnOE93S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585518; x=1749121518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XS7C8V/A77OQaYyjVUXtdMXt+t8x4Kx5wI7nMWNn0DQ=;
  b=CYnOE93StIImXuhq7AAdvmZPMC7+TqPipqSuOWh+PLTwHaETZmuvDkS0
   nKW9UnsOtJG6Ky2XKuTEorqw8rfVIrU27islP6qAdCYqma2IGZe+A25d1
   vMqEnMcCDkGKbuXKqSGQWPfOp5S618j75iVSxBavH296mf5bqLjpGsPRX
   9DvlGhIUPR3Pit6zzGfTHBDrzggVJDKRe+/eHZHWT3SDnGDf+qADyf67i
   CGO3mVos5rBS2yOs6eu5A7zir6EA4/2r2Ki5HsfKfv64wKdGv5OoEfsuI
   ogCStstYNaGFm2po7AeYtbp80yUPEEBleLA6nRTcnEPVIqAM0o1AU4To7
   A==;
X-CSE-ConnectionGUID: xQmPSqLPScGd9u/AWWt13A==
X-CSE-MsgGUID: XAnrWTJ+TvenZMrIKjX/9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402174"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402174"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:18 -0700
X-CSE-ConnectionGUID: fdxMkN4LT5G4DMaliINAIA==
X-CSE-MsgGUID: vUShnyVnS+ekJDe6D0NolA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997342"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: bump minimum API version in BZ/SC to 90
Date: Wed,  5 Jun 2024 14:04:58 +0300
Message-Id: <20240605140327.ff8477233010.Ic8c73bd6749cc5f8ab5297807bb0be9bd96a59fa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting older FWs.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 45905e57e084..e3d3abfc5fe4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	91
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	80
+#define IWL_BZ_UCODE_API_MIN	90
 
 /* NVM versions */
 #define IWL_BZ_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 653279e08927..7ad3322a3305 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	91
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	82
+#define IWL_SC_UCODE_API_MIN	90
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


