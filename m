Return-Path: <linux-wireless+bounces-6309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336588A4AEB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647AB1C213CE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78D405CC;
	Mon, 15 Apr 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8n2dKlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD163FBB7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171296; cv=none; b=AsbqPSTCw+S52xI38b/GTqjt+7Qdc+m8Ptw6ljOjWXp7h1cvJhSqYSwndfwyJ33863mMVBWev4WHIO1k8/VXCbo9P6SPIAe22KEDqJW02vZr9MII8nhCWKig2vgeEMQ0DMOzwsI3oatC99s1OuD6r28qAbnej6UDjrK8qS/RyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171296; c=relaxed/simple;
	bh=dm2eP8Pi01XSaQIgtcadxmgHnGVJlPiUU+rwoJYY7mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJJ7S7H1XpQN79PRbjsLkvFAxuoFWBTejBoS2psrSgnx3H95sVggr3Gwxk/gFw+UuO3xny96YSQjmExWGcWjoSgqbVOUiqiEcocCOnL1AmO21tFolTbHY9/MLD7kUgoMEKFbk1HIKiBulHDeq7x3twE9jBK6KFoD3L48V/38wtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8n2dKlo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171295; x=1744707295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dm2eP8Pi01XSaQIgtcadxmgHnGVJlPiUU+rwoJYY7mQ=;
  b=G8n2dKlo8bSUTM9t4AIJj6o6DpBYW779Spg63bftRRteT1JtRgDWOape
   f56ksQAgShJVnGzToN5J2yZc/yh6jl5bt0r9/2xXcurN9QxfXlUcvMjeC
   hnLe8/PCsk/EFsPWr28r8PjPTU5VgeFdhAGwzhmEpBHCXz/0Q1qAL+yD8
   4PIyvnYTbwQzUnTa/ftGFJRjlkGcpcFgujZM+H/n8dRMbyunaI+wIM2P/
   E/qsM/94MZ1u/GMEnAngoBpKRq9vmr4f8377XY9gyhB68Ut/sDy8gMR2u
   bUEdJfO6efV6Hb3CqLi66TOUnXl/WlhYDkukLgDp8qTVj+1XuQM+9gn9X
   A==;
X-CSE-ConnectionGUID: NAD7spN0Q8KVzFpu4pniCg==
X-CSE-MsgGUID: d7YJPzDqT9Op27THSPI4Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100576"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100576"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:55 -0700
X-CSE-ConnectionGUID: OkPIOaw7TUGKNgouoO6+nw==
X-CSE-MsgGUID: PlTjLACxSjaj9jt7/H846g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21767921"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 01/11] wifi: iwlwifi: bump FW API to 91 for BZ/SC devices
Date: Mon, 15 Apr 2024 11:54:34 +0300
Message-Id: <20240415114847.12c0fa42da50.I99b4f24bba073414dd04a6e04a359c7fbba52990@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 91 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index bc98b87cf2a1..45905e57e084 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	90
+#define IWL_BZ_UCODE_API_MAX	91
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 9b79279fd76c..653279e08927 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	90
+#define IWL_SC_UCODE_API_MAX	91
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.34.1


