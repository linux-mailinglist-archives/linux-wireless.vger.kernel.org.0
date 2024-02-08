Return-Path: <linux-wireless+bounces-3351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE884E5C0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02161F2830C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2880C05;
	Thu,  8 Feb 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjTJkD/t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F54823BA
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411550; cv=none; b=HbkL3WNNepcZD3Dx7F3rWaOfruQ/rqqftQM+LZZItJ7IAuMt/akpPKVT5vcXWYzw8XEW4P6T0/6/XeWnhPY1NyFi40XDJ3JtR+WHIMNOFdH6Qqo8il1HqQWuBloZOHZnauzIlhzHzjK5Jfejr9rFr9EehnTNSRG++kd5pNegw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411550; c=relaxed/simple;
	bh=dZxhcsv1+S8MgBGzK1ltD7a+b4z8KzDGIaJu7HDjoxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qycWOv8NoAgRZOpxqBr/5GHixKptgJkcTo2JCrzaCicC4fRh7vZ2dZbp726cFT+OstrRDyFKjhuQ6xP/yD5qjVNztO506qjEUukPvBQ1DSD50TVSymM7pV4ivJIXR9ZJrAmk6RuJaL+1TbvJJ+95ICkDpUkV+339KSF1GpfTdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjTJkD/t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411549; x=1738947549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZxhcsv1+S8MgBGzK1ltD7a+b4z8KzDGIaJu7HDjoxs=;
  b=hjTJkD/tkeG78bSGevbRQywn8G13G5XARN/uNra/jUqDGTz5/KqUtiVj
   WumBxVVNq8Fhl5Dox3L3dfP8qH9XbStUkEcYGw4SEUNtgss4BOWPjxXqQ
   q0s8ySEdeqn17p4IdCHOv9SWqlZAm1RoTr7XTMV098L+zCeC/4I6YwvR8
   03yRX/YRWjj0rfvL5fp0ZnFvW+sJ4UqGX5iI+JaLg71Xm1xeIxVxkQZZH
   Jl8klunqgthzA4QUI35xY46vC35y4CYQpTmrHhFoyDRfCmAjbytyZAIPJ
   ZSVFcabxoO7i2VqKmI2mVdWgmif8SPIaKf80VGhzNJb48d0DlfsYX8gb+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403982"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403982"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318845"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/13] wifi: iwlwifi: api: fix constant version to match FW
Date: Thu,  8 Feb 2024 18:58:39 +0200
Message-Id: <20240208185302.fbcb99d896b3.Ibf018d22ca673565cb9028adabd04d4804231ac0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The versioning here comes from the firmware, so it should
be the same as in the firmware, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 55882190251c..545826973a80 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022, 2024 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_mac_h__
@@ -431,8 +431,8 @@ enum iwl_he_pkt_ext_constellations {
 };
 
 #define MAX_HE_SUPP_NSS	2
-#define MAX_CHANNEL_BW_INDX_API_D_VER_2	4
-#define MAX_CHANNEL_BW_INDX_API_D_VER_3	5
+#define MAX_CHANNEL_BW_INDX_API_D_VER_1	4
+#define MAX_CHANNEL_BW_INDX_API_D_VER_2	5
 
 /**
  * struct iwl_he_pkt_ext_v1 - QAM thresholds
@@ -455,7 +455,7 @@ enum iwl_he_pkt_ext_constellations {
  *		(0-low_th, 1-high_th)
  */
 struct iwl_he_pkt_ext_v1 {
-	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_CHANNEL_BW_INDX_API_D_VER_2][2];
+	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_CHANNEL_BW_INDX_API_D_VER_1][2];
 } __packed; /* PKT_EXT_DOT11AX_API_S_VER_1 */
 
 /**
@@ -480,7 +480,7 @@ struct iwl_he_pkt_ext_v1 {
  *	(0-low_th, 1-high_th)
  */
 struct iwl_he_pkt_ext_v2 {
-	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_CHANNEL_BW_INDX_API_D_VER_3][2];
+	u8 pkt_ext_qam_th[MAX_HE_SUPP_NSS][MAX_CHANNEL_BW_INDX_API_D_VER_2][2];
 } __packed; /* PKT_EXT_DOT11AX_API_S_VER_2 */
 
 /**
-- 
2.34.1


