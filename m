Return-Path: <linux-wireless+bounces-2621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8683F494
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 09:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2861C210CC
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A82D52A;
	Sun, 28 Jan 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQKxB4nw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FBD520
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706430208; cv=none; b=mceyaclF1kZQ0HDuG4GSuqRdUQRbAqdprT7ykoA0vT/Jyd3S3VnCR+W8vvixj5gJ3/irW8GgELQ84b8Ug/9cRkJ1yN8GPyHf0UXcA5rcWciMtUv9DEsTOr9hrNQxCDQ9zlODKiarYecmLNMZAJKjyTWi0ulOFt5d1GfrTIc6KgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706430208; c=relaxed/simple;
	bh=hIrJKSNpYb4J6LmmBdTuR6sUK+GLx4HLsfkDwgd8VhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgLASRyzGCxinEOWjDCYz3Rs0+J+o4nc/bVs6b9sOwDAebn0x1w8YJuC7CPgEsMUuM6bM67wqHEJfex3dZbj8bxlkldCoO+kxayqBX+HlRDLAUXV6PeYFIeoRYfGNS1ae6bjrsEE4FJM3oGvRaWamAIVMLDDR2zCa2tTZyAvGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQKxB4nw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706430206; x=1737966206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hIrJKSNpYb4J6LmmBdTuR6sUK+GLx4HLsfkDwgd8VhY=;
  b=OQKxB4nw4Jqs0etqiRP8uIKn1AOvUC6YsINOFzb0CLIOYE0EvCUO488X
   rXzof1IkEYi1xQhVMCAyJArKzBhUX/l2UgCBF/IdRi/azG5aY59uPfDMc
   GgfdEGCAlCwSC/7cpKh7mVN4HQAdE+nd8qlVveDFj+k4mw/36SpI2e1F6
   WHJGR7DA1f6Fb2hYGmudNAJasg4QlsHQXK3Vqum26EhSLq/MyJ4aflI9L
   tzTUvGFhQj4iTcH8fGt33aVJm9ys1Splsjpe3ua4cQh5rD0r+cC9V8NR5
   OVERwofZ9RoFZsU98yvFlrAruDIxl+65o5BdYP+3l1EGbYAAOogevnMTk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="1687263"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="1687263"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 00:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3062384"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 00:23:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: remove extra kernel-doc
Date: Sun, 28 Jan 2024 10:23:09 +0200
Message-Id: <20240128102209.d2192d79bc09.Id9551728d618248dd471382a5283503a8976237a@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This no longer exists, remove the kernel-doc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index b877a2cd4005..e7ff043f9f0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -19,7 +19,6 @@
  * @fwrt_ptr: pointer to the buffer coming from fwrt
  * @trans_ptr: pointer to struct %iwl_trans_dump_data which contains the
  *	transport's data.
- * @trans_len: length of the valid data in trans_ptr
  * @fwrt_len: length of the valid data in fwrt_ptr
  */
 struct iwl_fw_dump_ptrs {
-- 
2.34.1


