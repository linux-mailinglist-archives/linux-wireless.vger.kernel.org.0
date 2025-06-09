Return-Path: <linux-wireless+bounces-23860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66FCAD256B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E4E16D319
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31527718;
	Mon,  9 Jun 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3S0iFfV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE22185AA
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493311; cv=none; b=ND2k0QJTP5y7/AhDs2QivVE0lS5pdMTR54fDUGh5IJEpfWr+nShec2NUmh1fPJxbShQjczHUyiLjY0VifBTeCqf2Mrmxo5w8P2QfC7QuJqjOPIqVtoT3Q5aFL5DBLEAySzfFiqlozpKAcqJcQKaeH6kvpTVkF8yAZXv3qql12sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493311; c=relaxed/simple;
	bh=ZAKej4HduCbX9s00H49OKxBhhiuMFNjBiIilIEVMWQo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDoOZcO65LmcLXUheFASniVVx4c6sCGl0Tm995OLlkBuz1ORnOMcNCUTq6vYE7Rehn1TfqXFkeqFD7+Av6uy2oFrDPaiINAWWuquyZbXy/2ZXVxkQ/5jznobWsKGD3eaZ7xgNfLjRJJR3msPJEj09l7lzNjzYbkNvTno8z52EdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3S0iFfV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493310; x=1781029310;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ZAKej4HduCbX9s00H49OKxBhhiuMFNjBiIilIEVMWQo=;
  b=Q3S0iFfVaqxQAeptLSzgkuyL7KTeI4Gya3zApbhPGSBPfLUVEMkQzgk3
   XXxpmvzUebYoI3hbwBXuyPIEmxUq42FNv1Ih81767lt+nd1JgHnCVNWAN
   b9DlhexuTnX078PhrkyCaY3qUpZvefH3bIn9w7z6Z4bfp2k19o/DsMZCM
   r41nH2jg4SwdduyP8Gl3GdRGFDxDBC4VPtwheK/8xUIiuhI+oGRdxswaz
   jJbgxB0o0AYl4j5JMW9En8itsk/Iwzk6ERhOIwJMzpvXmYfuJdHBvNxJt
   hMLXc9rs/yvYJ3QTnNj4bXV6ib4VcWo1EbHDJx3fEGz717rrU7ct6kBeK
   g==;
X-CSE-ConnectionGUID: R6ENsdJkSLOP7v18SZBvKg==
X-CSE-MsgGUID: Vl9hzkzNTCyU1GmX9DmrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237658"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237658"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:48 -0700
X-CSE-ConnectionGUID: PsgfR5BJSfu3PmH0TM2GwA==
X-CSE-MsgGUID: LxQoq94YTgKsM8nm34FkYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510226"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: remove unneeded compilations
Date: Mon,  9 Jun 2025 21:21:07 +0300
Message-Id: <20250609211928.3bfe5222fe79.I1ebd746b0c513e278d231b5c48f5438ca9b9231f@changeid>
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

Those are internal files so they should not be compiled.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
index ece66e7a9be4..c966e573f430 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
@@ -9,8 +9,4 @@ iwlmld-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o
 iwlmld-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmld-$(CONFIG_PM_SLEEP) += d3.o
 
-# non-upstream things
-iwlmld-$(CONFIG_IWL_VENDOR_CMDS) += vendor-cmd.o
-iwlmld-$(CONFIG_IWLMVM_AX_SOFTAP_TESTMODE) += ax-softap-testmode.o
-
 subdir-ccflags-y += -I$(src)/../
-- 
2.34.1


