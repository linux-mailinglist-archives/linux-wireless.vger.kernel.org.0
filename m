Return-Path: <linux-wireless+bounces-14599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F29B2F67
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859811F222E7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37971BDA8C;
	Mon, 28 Oct 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEbAcU9c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B31D9699
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116535; cv=none; b=XbaHO4LmM/ebqvXFVx//UVYPBGlWWTM97NDmkPRJQlKQnY/ttkibGlB0KPNP4PuQvI5O+6UyJMWap30VDYqR/StTkVCUAsQs2QxRj/WWSQmszWu6H2Y4+fdFKpo+7O66QooXWey6gNLucC44tilmFy4PJ8kjJaUVJAeOJb0PzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116535; c=relaxed/simple;
	bh=E2imZeqBATpmgWFII4SeoylyWq1A2PQ4yakO2GM5Gmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9KXuue9jEc6Aa23bTNh89h1gFJ/fJXXNkaUtt5uSxDrbalkemmUcqTapEfHt7VdT3VUvrNOieLk3iDHNsl8wzEp89vXKQeCseVRk/+itelJ50dNtuAeq2oOciRWJJrtgi4ZBT6O8n7KHPorFb87wyTYWMWH5LEGrWqKS3aeSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEbAcU9c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116534; x=1761652534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E2imZeqBATpmgWFII4SeoylyWq1A2PQ4yakO2GM5Gmk=;
  b=kEbAcU9chZWa9OKJsuUsFZKOvsT1QNAaUYEIl9HsfrwTq7269XIwa1ZG
   eoOt9Ryyn1mRiLHmtgMKSMNARQUa7ZeJOT5CgzTNCAaScmumBGJe+uhA/
   MccPHWmFRuY8paATdO327R/CNbUdw6h0zwZFAXMnF0Jj1ozeFBbweBIZM
   BaLZgiCj/1JBky0KKpNDjw+2tRVjMi+XXiy+2G30lofu7LCU5k4OBrYka
   MIoWrjMassuoClzbd3YQFd+OVVsb65a6zDjac9WLpxfMqJjSHSOv9LxIj
   rkB5o2aLmTPWDIHalWrLmFvQkCu8bQWstekIbD0Pid0ZhIwOM69g+Vvof
   g==;
X-CSE-ConnectionGUID: Yd3lo0/DTEKBPJAfkKYtMg==
X-CSE-MsgGUID: q0u095cwSE2uBt7L8dLXJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813917"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:34 -0700
X-CSE-ConnectionGUID: VCcwK4pGST6GTc6yoywXVA==
X-CSE-MsgGUID: 4A5GVXkWStW2GVOmaTu1gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432611"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 12/15] wifi: iwlwifi: bump minimum API version in BZ/SC to 92
Date: Mon, 28 Oct 2024 13:54:57 +0200
Message-Id: <20241028135215.525fe67393b6.Idbb031cf68d04b7c0c2b9fbc7d79181c538994f6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
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
index ea40d402681d..cd1fe8490ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	94
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	90
+#define IWL_BZ_UCODE_API_MIN	92
 
 /* NVM versions */
 #define IWL_BZ_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 635fed641c19..fc5e6e44c6aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	94
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	90
+#define IWL_SC_UCODE_API_MIN	92
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


