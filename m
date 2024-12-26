Return-Path: <linux-wireless+bounces-16816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF89FCBAA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF2F18832D8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9059126BF9;
	Thu, 26 Dec 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7zvURWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB9143C63
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227929; cv=none; b=TsuCkStTSIeWXBu6v5N19V8V3cRjsoUfxmhQbt3Wdw6OoG1gmeXmBkAIwe8QKcPaCRqtB8EJmAsN88nfu3JQVXsflD54vmCmTuF8jnTuN98aOc2xthR2CNrLh+OXG0i2kTbiZl38MMrjFzkM6YXaxCudZhzKbY4X9NLXVNEZ/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227929; c=relaxed/simple;
	bh=9FSfb8Ar9vfok9GiD2X5SWsG62uWlOCx8E3ANshKuWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQUMyBmaS0l3HrjnpdAHuyuC7NLA1WavxR0LrKFjVo+Je5+QKyq2RjfWgocAWDjPGjGsYrxD4FTGqYVPqsXu6I9KTe9BFCmsl10JeQj7hFtIgb8hfOtn03BQLwCy6+KpqxuJFOUXLbFrHyRsVsom2bw2G4sk7xhq8xO2df9R0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7zvURWx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227928; x=1766763928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9FSfb8Ar9vfok9GiD2X5SWsG62uWlOCx8E3ANshKuWE=;
  b=R7zvURWx5rlTUEGzMWe33TjcuElFhVcs3mIaCd2uBgiAlEqEnMWfRoZf
   8qXqK+Y+Kb4Rqq8Xp4L34zoUtXbzBHoN0rCGEARURhTduXofXgPkoGbmK
   rKvN70NFbbryR/R1Xb4zir/9IG7S5sJ5zesLDthyxZIiHufB9paiDRLmK
   b790ZBVjjCoV64i/X/VssQgstAPg8EVEgfx1BuuQ5fmd8nffxjlKBfFdB
   lF5LhtooBtI2tyIcJqhyX2rKFT1FVLQc29xx6w7wOxol8iGmLpL59aeNd
   ek5x6+Qnd1Bmsd7VXM9h7XUJDa7hCI+zPkzEvHjebIR40XuyDhLtstZe2
   Q==;
X-CSE-ConnectionGUID: C7j+8n/DSWC+8a5/qjv9sA==
X-CSE-MsgGUID: PWBTo3y8SoiTyW5O4PRp2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878154"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878154"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:27 -0800
X-CSE-ConnectionGUID: VqyrCKuKQRSWXdCjjMVsUQ==
X-CSE-MsgGUID: tcut56oHSBewyPyLP2d64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99778005"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: add a new NMI type
Date: Thu, 26 Dec 2024 17:44:52 +0200
Message-Id: <20241226174257.596dfc97f6b1.Iec765d5fe12ac74c6ee0035e9cb62b98c11639cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

0x88 is not a regular firmware crash but a PREG NMI which means that we
access a place we're not supposed to.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index b7deca05a953..c2f4fc83a22c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2019 - 2021 Intel Corporation
+ * Copyright(c) 2024 Intel Corporation
  */
 #include <fw/api/commands.h>
 #include "img.h"
@@ -75,6 +76,7 @@ static const struct {
 	{ "NMI_INTERRUPT_ACTION_PT", 0x7C },
 	{ "NMI_INTERRUPT_UNKNOWN", 0x84 },
 	{ "NMI_INTERRUPT_INST_ACTION_PT", 0x86 },
+	{ "NMI_INTERRUPT_PREG", 0x88 },
 	{ "PNVM_MISSING", FW_SYSASSERT_PNVM_MISSING },
 	{ "ADVANCED_SYSASSERT", 0 },
 };
-- 
2.34.1


