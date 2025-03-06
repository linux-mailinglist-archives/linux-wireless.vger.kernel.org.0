Return-Path: <linux-wireless+bounces-19906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E4A549F7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379AB7A3E11
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7820AF8D;
	Thu,  6 Mar 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAA/pTTw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD961A0711
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261770; cv=none; b=iqIwJ5jxLMWOpyzJr4U8Rlui/mbfw8jCVA9+CmZZZi0HsGUV/bHhBS5XPKcYOpDeCaYaBYSQVpPAtcLK2ObfOFBAr3pXQ9NY7RBS3J/j00VC0gMQSDdVt1zwdcbNT5P6/gfKM2hG+pnT2zz25XMs/d9dwQ69d3lgEurcyVDtH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261770; c=relaxed/simple;
	bh=aECVySNzn2V3AsKAmU1Lsz6ZK6tSpZELmMu9+FYa1SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fsk1R0iwFMlZL5JRYuLZLIvQVAJ+BWbZvNROGTusW1pHUJUmyS6fwIEc9ULY4ueZ+i6F7ywmpY2PUWeHUxxisbjXg78WJHdYkKqiigU3VrbNWQbg956go2cPUcV08kU9igfLhitxvJzdxf2a8nkVoZVx5HO9vczlvvMg9oU6ddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAA/pTTw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261770; x=1772797770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aECVySNzn2V3AsKAmU1Lsz6ZK6tSpZELmMu9+FYa1SA=;
  b=eAA/pTTwd2lAc6lMZ6qbO31ssQ36DjTRueainkjj3k5qLn9N21VXCQLu
   5o4SIzijDpdypSxoNLnu3g1Rgtpwa/aDNlSHYQw/Xp/2aNOXo2HXH29js
   JA8aAC1xqvJQ85+jUgq2WKSTZnmS3EtNFvToJmolJ11vGrlXHVy9vzkiv
   3ehyfJrRchA2iBLOj+1SnK4PYGWiN7u8mV7SCeOUBczIy1LJLY089tK+N
   mjwAbmoPP0f8eR9aS7zXoM1hbae9EDIj0nwUJIJItS3Ps/FI1OM0u/saN
   Kkg/hLXCz90lOBk3NFKhKLFMS1hR+/GucFIyFEtrb3Q9908GSQV7dl9EB
   A==;
X-CSE-ConnectionGUID: dw0K3mVNSgGzfBPjbpDb/Q==
X-CSE-MsgGUID: BDZ14ezTT/ax1rweBMJJow==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474547"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:30 -0800
X-CSE-ConnectionGUID: cNuI64zUSiueYx34n5Q74g==
X-CSE-MsgGUID: nM6MfQmrQJKOz9UnxtFZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915575"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 13/19] wifi: iwlwifi: bump minimum API version in BZ/SC to 93
Date: Thu,  6 Mar 2025 13:48:49 +0200
Message-Id: <20250306134559.e6b7fb55e44d.I942fa8cafc1791b9330ad18e2599fae11d7b3336@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
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
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index d7636f817b01..50be8ee8a637 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	92
+#define IWL_BZ_UCODE_API_MIN	93
 
 /* NVM versions */
 #define IWL_BZ_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index a9fc9e8ec431..670031fd60dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	92
+#define IWL_SC_UCODE_API_MIN	93
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


