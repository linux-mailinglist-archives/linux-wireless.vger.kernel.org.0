Return-Path: <linux-wireless+bounces-20056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0BBA57E83
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83C5189268E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048720B803;
	Sat,  8 Mar 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmE01H1w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D220C031
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468795; cv=none; b=DZGxsTT13rMsl2eMe8JGNCw7xRbufqVonWcIMz93Pn5K+8Eo3GllCdiQ/qe8rTwl/V5CB0blT5wY+nfLf1PK7B6ZzLkNi/HqrQjtKeIAuvhCvJWFF5K6jpVrKuv5D8HN15DZW2oeoLb3XLonlEQveLvCAMunax8ptRRH6rqjFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468795; c=relaxed/simple;
	bh=ZXmibLRbiU43LSmBNtFknoOQ2FY0nQZWBglffmp59Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtJSuhdzNsYWDm54HQ65p7UAPCKHwzl1MMPaMIOopcVXTKWx7OAB79RCEttBNRA7SKyyTHfrrOy1VdbTuQqOP5AOyJYmvBUf3bU72948F/CjhoUpBpjwHMW/zt3CqzrQyuUe0BXYNnev0Tz1bML3jXF2pNxPoWydNmrSCVBHgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmE01H1w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468794; x=1773004794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZXmibLRbiU43LSmBNtFknoOQ2FY0nQZWBglffmp59Sw=;
  b=mmE01H1w9HEajlMAPfIzqtDl9nI/oX88raA1CcsDfRZ8jF0/BweoSh2T
   Ix3lBfJTTqN6VgKW1v3TZQYIaSZwgmOWcod694rcWH0zMtzj6AM+ZiJKp
   aqxgrGwWg158ut2+OS+kS2vNSnbTRgCKossev1JiOZaLzF5QsZNpBryKn
   mAiAk7JPVlDTCogv6d2nHS0hMxTwjeVaR9D2jDoT5bfU9kspS1U8MAKhJ
   OLf7rvaE+SUbrok6vNuv6ApO/DMfW9VHw9E6bP825nGoZxTtabdYcU4gb
   isj+h/wdgyLcrnyTR10DLLFf5rfq7XwN88vREd6oDRIcmlNBfl4bYm02y
   A==;
X-CSE-ConnectionGUID: R7xbP0ePTXS5lrq5GXDcoQ==
X-CSE-MsgGUID: L+5CcLHxTBGbP/nWqL65Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052385"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052385"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:54 -0800
X-CSE-ConnectionGUID: FDvgDenVTuKFEzlFTz/wiQ==
X-CSE-MsgGUID: +xfJf+hhTdSkYCnZoMUthg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859947"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 11/14] wifi: iwlwifi: bump minimum API version in BZ/SC to 93
Date: Sat,  8 Mar 2025 23:19:22 +0200
Message-Id: <20250308231427.73e962ca3e6c.I942fa8cafc1791b9330ad18e2599fae11d7b3336@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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
index dbd303385157..f055255a7c93 100644
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


