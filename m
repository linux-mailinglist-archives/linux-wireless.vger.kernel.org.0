Return-Path: <linux-wireless+bounces-3753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E385985A
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9683E1F217C0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3EE6F08E;
	Sun, 18 Feb 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZaT1A1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB356F518
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278761; cv=none; b=Vd4yQAmZeCl0/J3vZ1gGNmwpdf9w7Ym7JUks13+HIIssXAZPR8ON76mdoZJfcya6fMdFAN+lMll3RmhyMQ2FVgH+S+8d0RsJeDZYpTjr6QLaWkRL/O8LlDpkNnR53z7atrHD60aA+WYKcdDS92JRY1CLllz8WfNvIL3DfQJsYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278761; c=relaxed/simple;
	bh=KSEpyKvAdo5uhi+/DeSgeGGGk4hmuO9GhRr1pE6hQA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAMHI296e40SpE1dGHc0ocOLx7ZE7745Ls/7u0CNH9pxbd+6GHYnIvhmS+C5EahqQNbp94i1Xv28aeZjm5S5T0prqkd1zwcjCAzr0rlOngLJ6itLDkjjpGVh/XQhMSs/1RAJ3uVEgdLLu1kbLCPEiZkZ1MUTdMMWR3b2iB9A6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZaT1A1r; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278752; x=1739814752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSEpyKvAdo5uhi+/DeSgeGGGk4hmuO9GhRr1pE6hQA8=;
  b=hZaT1A1rcNL5mypUoxvRXWQQ1f9hxKzjFWM+yFHvCb0PZVCWETNGXRVL
   c7U8q1SEt1mAQX5noi8kAxuo9qsdGCX8fs8/r1UxrgtelTQ0sCLsovP5J
   Jp06wf2tH1PkmcTCC7AeeDbfNjyiNVa+5VkRoSl161aIJfxCIcUXEY4ID
   0OqFxHB27jkORklTksjdxqhJFyzKUp3Ff7Zhc6OUc84UVhPOBtIXi6i9l
   6dQMPpTOftASstxzSGSeVMb62cwuk6UDmHNGDRFD/3eY6EkrfmhKrN3Ry
   22Y0Je6cFySEwsVL+HfiPEnMJM0m4c4y33yEbXVaWAizIM/Rhpa+9vh9A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464994"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464994"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459461"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: load b0 version of ucode for HR1/HR2
Date: Sun, 18 Feb 2024 19:51:52 +0200
Message-Id: <20240218194912.0166f5d2d5d2.I34c1d46aefd70b34c1c75cea67792bc5ec8bc285@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

load b0 version of ucode for both a0 and b0 step of HR RF.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 91e974de0ade..4696d73c8971 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -187,6 +187,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 	case IWL_CFG_RF_TYPE_HR1:
 	case IWL_CFG_RF_TYPE_HR2:
 		rf = "hr";
+		rf_step = 'b';
 		break;
 	case IWL_CFG_RF_TYPE_GF:
 		rf = "gf";
-- 
2.34.1


