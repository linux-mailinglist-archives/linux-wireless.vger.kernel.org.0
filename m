Return-Path: <linux-wireless+bounces-19895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13850A549EF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F797A44A2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37D20AF99;
	Thu,  6 Mar 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShRfr7Z6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50B20AF69
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261753; cv=none; b=eXOH4e6PhG9pMsl9B42Vz1SV2lzp9F+j7iHRXiSGWagvje4kKDINTGGZ6yoPiZ+dEbDJctrok4FKyyNRIwJ+KCKeHYqNZ83Sc7MAuleGtIbyVF5VElJJwcshkp9mkfuZ2Jp1bzHyLtpZqkQhcFIL9dvkuvzeEezUTZaiRnZnulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261753; c=relaxed/simple;
	bh=iKg7xnPuy40w1VC5Z9rTJh4qis2fv4uTp7BLYhhiWfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLXxAmJqo0ALjw4/109Okvahj/LGz/WxPTpUsyQZ7gHeybtgjTp0PC28vaRFe6zmqrY8yoV98H5QsIHc1w1PC/fbbZ2Qd1r3X4YhSsVCFF8aUHUEpvZOh1HilG1Ay+VyByclNBQjl929GLg4vlL37HFwIjoKhqlNxW5WyvM+sPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShRfr7Z6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261752; x=1772797752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKg7xnPuy40w1VC5Z9rTJh4qis2fv4uTp7BLYhhiWfM=;
  b=ShRfr7Z6WNK6Va/oAYlV40LfxyyaBLQthictHFHzVdXXBBoXBMOLDULC
   RUR97zlyc8Fy3quItI2wS/NMPg8rKUqW4a4uOh3eI0IYTYPqY5ZyMDHcE
   p62fmipwEAi1hNTkvPmxPFmbpvtyh7zJlNAjCuN/cjdlcvGddP4aoVqBa
   6TUqfX/AfK66FJKgFVqCOnRhu5dk7CJkjGa32psIdeNjD6l7T44nmgPgZ
   bNs3efMxwT8/ZKwYG98W6Rw4LuYHf9sha/xCwvz7rLUqffEeDdqJKPkbn
   3H2FIN1adzX9NRYK2YxHQjAPhqEqyZWC8QE9vsVFBMHz010Vp/Bb8GRnf
   A==;
X-CSE-ConnectionGUID: qVGMY9+kROKuBJ5jv0gxwQ==
X-CSE-MsgGUID: DnT4MH98QgqtAlB9btZHew==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474500"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474500"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:10 -0800
X-CSE-ConnectionGUID: EsvbQirZRT++bEBtdZ6J2A==
X-CSE-MsgGUID: f2RF6cxYR/iuuYISAVT/jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915510"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 01/19] wifi: iwlwifi: bump FW API to 97 for BZ/SC/DC devices
Date: Thu,  6 Mar 2025 13:48:37 +0200
Message-Id: <20250306134558.003982747060.Iee3bbd245e7bc750b92624f7085afef02e7dbdc6@changeid>
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


