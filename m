Return-Path: <linux-wireless+bounces-7200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B968BC800
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89FF1C212DD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA774F88E;
	Mon,  6 May 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDzjv9C9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908B5338C
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979075; cv=none; b=SOgpCwY1lraTz0IZykMDjj3AbHaJRBAsl6i18L05zMm48tNI71Y7mBjeXUj8TZFyFgAmURf8OMWDheBQrALm0yzoqiP/4XRfiRq6/Jed53oWLH6QXBlVKX51G8OfkcoQsuKh8GO+Kq5HlEnIYEXYbo/14aYY78uG3A4tTPxIn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979075; c=relaxed/simple;
	bh=enZ2varsg2W+zqST+fKjv9C0gYuntYzN0VElq7IDB6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaQnkpzu8okIOfiCvMHNwhbDXMthQUPKDw6eiXpThVlxGNiStvq2v0a4b2Ho5rxsQqcqvUxe4QuHouJ0rrSVRaEN+uIY6jbGj8Vqjp/WRszQ3hXrUaZXiEv1/ia5tdMehAM2z80lZBb7nimUkGrctcRgGiHSqfgDAMh6Udssxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDzjv9C9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979074; x=1746515074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=enZ2varsg2W+zqST+fKjv9C0gYuntYzN0VElq7IDB6I=;
  b=MDzjv9C9D+j0KdMgbrPppRlEtfl41TCUGyUcpvCmf0LUxmMxXJlMSGkM
   C561JX2zIz8OgWHFlXMqaxLoS9wKyBzThd7mq1SKWWzTAE81KLK/6Gvhv
   GhD8Efr8+HsvlNbKi4GsetsB0ncXwEqSYJoB5q+P30bOxQn+jQ2tnhQog
   bOvK7CtZ67x56AkxPTfDhxom45InNUvXWbhxqKTn3ecZf5r1w8s54BtVz
   NxeXzVcggjPRRTSgwY1Y9Yz1bCzPOn+113zWy889E3VFKUWCo0yUtmKOi
   HLJ+UGWFvarXJGo+7MLkVpmGMxG5sobhV8NW0QhVCoPi97lC983dJU6gl
   Q==;
X-CSE-ConnectionGUID: YjeMhZccRjCD9x0MlTRm4Q==
X-CSE-MsgGUID: dkXfD22USISXVv/UZ5yrEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638166"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638166"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:34 -0700
X-CSE-ConnectionGUID: tWgr8WLARwamJOPF2NAjXA==
X-CSE-MsgGUID: 9au8zrEAStO/9TFZj0VI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264876"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 03/15] wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
Date: Mon,  6 May 2024 10:04:07 +0300
Message-Id: <20240506095953.4e4b19128b56.I2f9196191f1ea78e96e92f9db8ecb3cc9bbfd9b3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 90 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 6c01859b4323..bc98b87cf2a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	89
+#define IWL_BZ_UCODE_API_MAX	90
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index dbbcb2d0968c..9b79279fd76c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	89
+#define IWL_SC_UCODE_API_MAX	90
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.34.1


