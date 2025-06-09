Return-Path: <linux-wireless+bounces-23866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7821AD2571
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996D4188D154
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63221D58C;
	Mon,  9 Jun 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7v21Le0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FF21D3C5
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493317; cv=none; b=Yu+5DIjb2U/uKuaA2ftjZMhlNHtylrhL24k9wA7G+RksWp0TN50Dog2RPawWYgpDb4Ycrff+bBcJX1bJWRixaMxY3JkfIbG3wqtxHzfMqHTCQQLF71zugikfc9POyxAKQcUVpiRsEOfv5x7iPQxHBTjZdSe+Dmxla0VNX5Zagd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493317; c=relaxed/simple;
	bh=JARJaGnKZOGPnD2K6yvct0srAFjcJWWZFdL0bqvEtUI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMEsYZoAi0QLMBu6+Iqe9LBWT460KPfnJ+jMHTFnj1ne5BN4IGMa8i8BnLtvlO/jeMdyVgdeolN34RzHcjfuJv3Qcbx6GWGi5os7fyqB/prFsdyyMvXJQdflITmNmoRd8TYaAcS2keDd7BPg+osda9ds1JxtEAYyTt1Bo0vMT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7v21Le0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493316; x=1781029316;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JARJaGnKZOGPnD2K6yvct0srAFjcJWWZFdL0bqvEtUI=;
  b=S7v21Le0U58NMtCYl5FtsUebQ6iAAUYa4Dlml4CgLODgKGOyWdrvrZYO
   nqoDZkkY8sGe/CBnSCY6TJ9OWGUjYqG0WgPGEd1ZPYi4hTXnlWxRttkV4
   /XesY5Ij0fGhGd5/BEG7GKzpBCpHGSEdQmfP58TBC42WjQi9BOJYTk/4L
   /snxOlsi0L9JRe0IWok/P1RlMndDqiS58SCIv+WrE0qlDdkv6lGQXWzYe
   I4t4JDm0byVi/1u5B3p/Ch1J2BmTb8lSuA+5hz2Oj1yD5Hqgg3vfWo38G
   /VFMFnz3U3gjPUNEZQB+ajNihXr++/IlshvGnCvyFLMbVDVhQRE8W6Jsg
   g==;
X-CSE-ConnectionGUID: l6AWDiw7TnS8SGyhQDuuBg==
X-CSE-MsgGUID: aiIGTbsCQra+QTDa5AjnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237684"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237684"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:56 -0700
X-CSE-ConnectionGUID: KMRlzZ/mRDuhE902ddW/Pg==
X-CSE-MsgGUID: 9fBLimMAR9yl//GJU59IBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510283"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: bump minimum API version in BZ/SC/DR
Date: Mon,  9 Jun 2025 21:21:13 +0300
Message-Id: <20250609211928.aeeef3290d03.I2433bfe9def643b5f4c0e77ff3cf8cd1285f5aad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
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
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 600206432c25..e616c0381360 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	93
+#define IWL_BZ_UCODE_API_MIN	94
 
 /* Memory offsets and lengths */
 #define IWL_BZ_SMEM_OFFSET		0x400000
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 5de7a530ae68..4dbf3d3694b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -12,7 +12,7 @@
 #define IWL_DR_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
-#define IWL_DR_UCODE_API_MIN	97
+#define IWL_DR_UCODE_API_MIN	98
 
 /* Memory offsets and lengths */
 #define IWL_DR_SMEM_OFFSET		0x400000
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 97545c2a3b00..44bc0274bc47 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	97
+#define IWL_SC_UCODE_API_MIN	98
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


