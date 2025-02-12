Return-Path: <linux-wireless+bounces-18807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D7A31E19
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DD73A844F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECE1F9AAB;
	Wed, 12 Feb 2025 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eo88MVXZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC1271837
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339033; cv=none; b=crc97mu5OPqLnqnO6TAwvrDrjjBCCXd8KmiLmlhvdIYLbqqK7BR7r7d1v7hmWejUumol5qTYrtGBA+UiDdUfRvBhev4ioygopZNdLqb7SBEbpnmXPmLZvvTTJfeDKLmAokhaZEa882pRKm8OtuyQTmXS9BybYxDQNn9rGdnuOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339033; c=relaxed/simple;
	bh=YaOmYvLJplOkAlhEm1aRd2UwF08fT8C0GIOIKN7EYLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=en6pvBBSeg8nY1t5vt9yV3Yb56N7GvWQ2n7VA2dhY96kBpLkzpV8c6mOv5vx5XlvchZcmcsC8nhFxD0CUcUs86NMugPq7sHtd0IqkCIEVofLUv5+cof2i5ZXrwEmoNDrYO1XN0aysrpFH6soQivbL6KKW3Pz+4w/C8YoYoUn/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eo88MVXZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339031; x=1770875031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaOmYvLJplOkAlhEm1aRd2UwF08fT8C0GIOIKN7EYLU=;
  b=Eo88MVXZZkqSkoYKJ+n64pEfOsXfzykCmYgz+btXw4uYuSQSk882OR+j
   eyxF5C6MQWEwlyRsJLbcGgysVAW6om0DOenXmjoaOzqZpMBtJnOO5CaJn
   Oj7mRBuIs3U6iPIFjZQoVmj+ilryaJvtvyxLedaj2pZJ57qlM6zoU7Tfu
   qh5H0u8X+ybY3tRc+NOSkRK8apLSqk/b7/ITcJiAIZrVD20ziwepD8DGl
   tCinzsV050p8G71fEgOourZBc0y40E+5REMV4WATagQLwT4FRRURry6U9
   bmzgE5kGudA9II4ZkcLrm88/1z8t1vfEPxdnMmFUgtksjtU6uoynuwc1y
   w==;
X-CSE-ConnectionGUID: thj65em0TZ+fJBm4YGin/g==
X-CSE-MsgGUID: 6dYjS3AdSi2SQq6V3rf2sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172208"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172208"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:51 -0800
X-CSE-ConnectionGUID: NIhcDiIXR/Wo3wgLq0CWXA==
X-CSE-MsgGUID: jU9PPfj4Qgm3+eP0DqVuPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893844"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/12] wifi: iwlwifi: use 0xff instead of 0xffffffff for invalid
Date: Wed, 12 Feb 2025 07:43:23 +0200
Message-Id: <20250212073923.c6719e6dc0a6.Ifd149101fa886730602dbbb02f980be8e554fe84@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware is now able to understand 0xff and that is more widely
used.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/context.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/context.h b/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
index a9fa5f054ce0..464eed9b5e71 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2022, 2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -14,6 +14,9 @@
  * @FW_CTXT_COLOR_POS: position of the color
  * @FW_CTXT_COLOR_MSK: mask of the color
  * @FW_CTXT_INVALID: value used to indicate unused/invalid
+ * @FW_CTXT_ID_INVALID: value used to indicate unused/invalid. This can be
+ *	used with newer firmware which no longer use the color. Typically,
+ *	firmware versions supported by iwlmld can use this value.
  */
 enum iwl_ctxt_id_and_color {
 	FW_CTXT_ID_POS		= 0,
@@ -21,6 +24,7 @@ enum iwl_ctxt_id_and_color {
 	FW_CTXT_COLOR_POS	= 8,
 	FW_CTXT_COLOR_MSK	= 0xff << FW_CTXT_COLOR_POS,
 	FW_CTXT_INVALID		= 0xffffffff,
+	FW_CTXT_ID_INVALID	= 0xff,
 };
 
 #define FW_CMD_ID_AND_COLOR(_id, _color) (((_id) << FW_CTXT_ID_POS) |\
-- 
2.34.1


