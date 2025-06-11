Return-Path: <linux-wireless+bounces-24008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93479AD5F0C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D416189EB9C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC812BDC2D;
	Wed, 11 Jun 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdjjqIG7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047792BDC35
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670022; cv=none; b=flg/uFqyEka0Jz72pLNpcfxpUi0Jk4QE0hMP4qZcgVvqoHN0qFPuXJBbfNIrj8zsrWEtmAT52DkQJmfd+Lfk2Ir3vwYAuxSguXhzjgnntoSE3OquY2+QeJE8ozM1mGRBQqgdRZOfzkPj8PDBX7UWbEvcWpofGDK0GUf7aep/xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670022; c=relaxed/simple;
	bh=h/OcQtffMb6TcbuatTOWYtrnUNADKzrAmEMT9oiCllw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKqikj1CXlMhWJ47pdl78oDHHgyIRAzXjI+EVT7C/AdpgO8EST7SCv1bx17vY5+oLI15StiUzeA+1Z93v6SqJb2rS1FJ5weTch9jt6Sjix1vx0z1Xg0JRfDt7ZRnClN0BMDEygOELQkSbfnua1OYxWhjscfi7M7ijF4EyaaCRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdjjqIG7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670021; x=1781206021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/OcQtffMb6TcbuatTOWYtrnUNADKzrAmEMT9oiCllw=;
  b=JdjjqIG78Uw/mawBAYFENUXRyNckSjpfZKuQzptTc+oXXgWIUt7Cb8ba
   FqWUayczw9lX0VR8QYV38S5uD/XiyAgMCKN37GLyLfZNJwZPjdZo3kbLX
   xi42JNpufngt70itSogsYomafFKOXacuIHIgG+htPaM2EuApG93wsVoCC
   BZWs4kOj8AeShk5I9PjRr8Y6k5gfBNzKjM4OcfhTgmcZOGcUbkwU8Sn47
   vpUH0XdVudko/IALAA/R3Q255p19Il+pKPvmVlPMi5zzxMKNuQEGQdTYK
   eO9pz/AHh4ulbIuYjI210EUK/B5QFB2s6lCQoxWGfuTJlTkVkuty/OFbv
   A==;
X-CSE-ConnectionGUID: NqoBDUM8Q06nHlHDSDPBNg==
X-CSE-MsgGUID: MC7iu5WCQVylI8s/gMCb0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360892"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360892"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:01 -0700
X-CSE-ConnectionGUID: Sdfq3gbYTWqWqERCKw9ZIA==
X-CSE-MsgGUID: 1OIaNAYHTPqae5RBFUQ16w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165855"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 08/15] wifi: iwlwifi: mld: fix last_mlo_scan_time type
Date: Wed, 11 Jun 2025 22:26:27 +0300
Message-Id: <20250611222325.5381030253cd.I4e3a7bca5b52fc826e26311055286421508c4d1b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This should be u64, otherwise it rolls over quickly on 32-bit
systems.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.h b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
index 3ae940d55065..4044cac3f086 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
@@ -130,7 +130,7 @@ struct iwl_mld_scan {
 	void *cmd;
 	unsigned long last_6ghz_passive_jiffies;
 	unsigned long last_start_time_jiffies;
-	unsigned long last_mlo_scan_time;
+	u64 last_mlo_scan_time;
 };
 
 #endif /* __iwl_mld_scan_h__ */
-- 
2.34.1


