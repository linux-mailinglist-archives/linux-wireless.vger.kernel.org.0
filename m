Return-Path: <linux-wireless+bounces-2963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4329F845A03
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65FF1F25AAF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE15D492;
	Thu,  1 Feb 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpIJfB2g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932675F493
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797224; cv=none; b=G38ZR1cq8dabw6qFyK9/5VR9YyveMnU0iOhs3TLgz+NDn6DGME2IwKAC/4sOdiPQuohlDKmNOXSt4K0YnzeCIW98qWqi0umr3J1sV6G81MG0WhUJR/+7akpcCIwsoiSDhQjuh8pQkUfOEbGMJOkHQar0yP7twfHjy6QLA+c1ds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797224; c=relaxed/simple;
	bh=LEkdljdWXlOHSEJmeR2FiUAoE/LseeiCg8C7a4LTC/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+rSAcP84nXUJlInCsHYv5H7883+RqBVUYYz2nNFf2o3Lt0i8sRodxqFLaWP6gXtGrAmXPtG/rOuY2uObFaMsxjJ9Isz5izBKBFULv4UKVQc/4LPdITWUJFxxQoFTp9QmZQZK0zUlIvY0yLJZBT/jo5zGcvW19RUAKd+fpo2/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpIJfB2g; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797222; x=1738333222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEkdljdWXlOHSEJmeR2FiUAoE/LseeiCg8C7a4LTC/Y=;
  b=SpIJfB2grLPK6ThRLAlhlUWmRlf2aUNJw+CKt9WCZfea3VUOH4OElbq8
   HvyMVJALiNzr/X5pJR8Pnb1U+ueP/3bMPbliiu4NDi8W1sEHMwsanFNiM
   bdBqmzdYYZRA9c2riNC6qE3X8CbsunPN9bhlKwDvY8uwO9P71ohlcZYmK
   CZ7N2yZM38FZeBr3C3DPIaQOKr8X/eFfCz2OW5sK8APweIZnaXdY4nogS
   kBkt8l+cMEbY/t4PU3WPpCo56FVO9CASAKmWvrhHWPrZA8kB3w7e+GZC2
   du0HmvCHAxmKt3V/X/74K+XUMz9Lo+t1XuZs69HHpazqVadZgQHc4Io8v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435063003"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435063003"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94548"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/17] wifi: iwlwifi: bump FW API to 88 for AX/BZ/SC devices
Date: Thu,  1 Feb 2024 16:17:40 +0200
Message-Id: <20240201155157.e35556d3f956.I6543857041a33e2b35e67eecf648c9cc6972e60a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 88 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 02b727687fb8..456c7fff60a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_AX210_UCODE_API_MAX	87
+#define IWL_AX210_UCODE_API_MAX	88
 
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	59
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b0b003a6a46e..c858f355701e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	87
+#define IWL_BZ_UCODE_API_MAX	88
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 51b8f50d8795..e0679093ed8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	87
+#define IWL_SC_UCODE_API_MAX	88
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.34.1


