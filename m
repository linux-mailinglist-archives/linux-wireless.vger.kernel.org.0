Return-Path: <linux-wireless+bounces-19945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83FA5594F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F23B248C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2731E5B86;
	Thu,  6 Mar 2025 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fv0NSViG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3627602D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298711; cv=none; b=EnzK5TC7jjqaplAZUXwqmuibTnSYMj46msLToUg7duUaFrK7R+/Dvf859Bg5YwOBIn/xSDlSwL4xBk/xTMdgVNezcO9nycBiemp4DRG0j+q07Q5NiQ9sff48MSGkgx6elJ40ySAiKOqvtTy4+JqY+WCn9f/8Yp+WxirJS+SOhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298711; c=relaxed/simple;
	bh=iKg7xnPuy40w1VC5Z9rTJh4qis2fv4uTp7BLYhhiWfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EB+29/4ePjTzxMJZV0pqn3Z5vPL8Zo4EGLH+Tnh6Y16xGjqU7pLXkzcLl0pfpGiazR/NRIRT03wTaRkEEQ4I9P+ZY+hFGSO4OA4ZrENo/AojlFCsRVl9/3UfsWQ0xNaCf6iXKfcliOEgiq8oX6P3rNB35yIcWYTwBnL/jT/b2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fv0NSViG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298710; x=1772834710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKg7xnPuy40w1VC5Z9rTJh4qis2fv4uTp7BLYhhiWfM=;
  b=Fv0NSViGL9S46P6l7Y1riwghQ1H0Uk2EG9gvH33FRclwHDh3vkFSefiS
   8oJ9tGq5EgrLaF57vviSaM1+D2uRBA3UN0DgYjC1VDq/nSHF8Y7Md85vm
   BJWRInLQFvOx0IKAm247F4SU4wa6XUpgMaOsYxbjwgI33q753WPJwtDI4
   vRejp2+XijIvXUl0gNU/xtvtemnI8LtNK1Ju2aQ92/ttSViO4hmyi0xAm
   9weIDDy32k7OVz09E7kOZeIerpxFHgcc5XDA9NYKHb3HaiBJF/S8O7loW
   BZRwGBL3jK5lzqoj1MXA9Z47UB/ieB6SlgOjYRoPsCoE9G2d0lIxV+mt2
   Q==;
X-CSE-ConnectionGUID: td8HFMYnRQ+BEF1SO8R8MA==
X-CSE-MsgGUID: rf/fh7MBRKCNG6AqPdfejQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474239"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474239"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:09 -0800
X-CSE-ConnectionGUID: R5w2rinfRRqg7lwD/94Fzw==
X-CSE-MsgGUID: XSvLIp7yS5CYkc4X79MUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061855"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 01/15] wifi: iwlwifi: bump FW API to 97 for BZ/SC/DC devices
Date: Fri,  7 Mar 2025 00:04:40 +0200
Message-Id: <20250307000213.1678abe8c9b6.Iee3bbd245e7bc750b92624f7085afef02e7dbdc6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 97 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 64a5bbb45c83..e0ec9d6337e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	96
+#define IWL_BZ_UCODE_API_MAX	97
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	92
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 69176b59b4de..e58fe8210988 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	96
+#define IWL_DR_UCODE_API_MAX	97
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	96
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index eb56af9a8411..e5c01ae87699 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	96
+#define IWL_SC_UCODE_API_MAX	97
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	92
-- 
2.34.1


