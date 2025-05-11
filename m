Return-Path: <linux-wireless+bounces-22853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5044BAB29D0
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DC23A43D8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AAC25DB05;
	Sun, 11 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2wIBHDc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAD25DAFB
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982434; cv=none; b=DUjzzcp+q3L4LZWNJ1xGcyiq2psEXfxT7BvPoA3u8GFHE8jsZSkpkw5iMkSqGl8a8GJV0BKBRYH+HOX7aZhrSbAYhGIYNdo2Zif2lRtRufKt6Jvo9/nAnNzPR5zB09/dSkYpalVxosjAbK844YR92Q10lFDkhlGqIxcUF63pkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982434; c=relaxed/simple;
	bh=aEz2Uk5I4W2BLfe7dtWO02byahOwwps+yDe9ANQ1ho8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvBtlphH/Xgew5fHPmv43nf2Iosp1+JSlWFrr2gBnv3DWE/cI0vH6k7Un6Fwve/9LSGmaq40UdHeGgr3SMHNfsjYhDWL5pZuRA/CbA+WX0mytHOOKPAqsOCpA74NWLbKKg+3g9YwmEL/pqz/J5jBN2sQTzSUnyprjHxca3/1Ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2wIBHDc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982434; x=1778518434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aEz2Uk5I4W2BLfe7dtWO02byahOwwps+yDe9ANQ1ho8=;
  b=n2wIBHDcTXxiaCAr7h6HX+0cDhPLzsIcghqvrWUVtSpsQA1Cjs/QqttR
   rsOVhJ1Rz3jy2x698w4sGC9cvpmYZ865imdD+D3qJ6GJ9KqWiGyMWRGsz
   7gfdZxTrKoIBRvevVwpKyHSO3MoOKXxS6tPShDqD0kVwKuzJbWyqU6m0z
   GXi9Kyn+WAU1nWtYFAoyJ78LBlytA7XuxDXia3ZF9WS/ZrKn4NoT2yICw
   JBXKJ8I+I4M23dYvVOsFIrFZIV8ea1XfbJpM4nlCWpsSa/HCUZ18Jtn/Z
   5uiI39eo9PJ+j99kUEGa2Y2wqVNNXEU2PnSUwPleSCsf+2/PpGIdXdBLc
   Q==;
X-CSE-ConnectionGUID: nMgnnH08QgGUeX7SmRIiDw==
X-CSE-MsgGUID: erh52A5CTNKbZI14x6ELqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582705"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582705"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:53 -0700
X-CSE-ConnectionGUID: E9Pa8SLYRCOh2EshvNVaIw==
X-CSE-MsgGUID: 3/VJzeOXRpO++Z0z9n014g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: fw: api: include required headers in rs/location
Date: Sun, 11 May 2025 19:53:20 +0300
Message-Id: <20250511195137.956281013349.I4c537dffb82f5e5042e4a880cde3c6da38a56cbc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Various headers are required for these to build properly.
Include the needed files.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 5 +++++
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h       | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index c1b4a38a93de..33541f92c7c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -6,6 +6,11 @@
  */
 #ifndef __iwl_fw_api_location_h__
 #define __iwl_fw_api_location_h__
+#include <linux/ieee80211.h>
+#include <linux/if_ether.h>
+#include <linux/types.h>
+#include <linux/bits.h>
+#include "rs.h"
 
 /**
  * enum iwl_location_subcmd_ids - location group command IDs
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 9b9c02c9a8f3..3222cbcbe1ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -5,7 +5,9 @@
  */
 #ifndef __iwl_fw_api_rs_h__
 #define __iwl_fw_api_rs_h__
-
+#include <linux/bitfield.h>
+#include <linux/types.h>
+#include <linux/bits.h>
 #include "mac.h"
 
 /**
-- 
2.34.1


