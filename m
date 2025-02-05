Return-Path: <linux-wireless+bounces-18533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA75A28B04
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E227A3441
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8671CD0C;
	Wed,  5 Feb 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deXdSLIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E56B677
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760193; cv=none; b=UmEBLPHa+HCNngKcrfmrE7mks7fFP9v1SSh0ah5xTcWLMVkpwmkjnff45rRCZ0OnTGFiOja5mFDfv459PcCe+ydU9flqlKS4MAxslsbdcvvK9B7kjpYQjP5VFTdckRwTRKTXudgc9pDhBOvCRQv7wMloY8uA45mGECOF8+TiWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760193; c=relaxed/simple;
	bh=AJgMS/3rss5Neb2tlKSN3dScesI/X8jToeY16uq63pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rObgG+mA7Tiaxl4x2ijb9Rfxx6OVESqP0OGq4JsSsebkQgvNDuMuUD7TxyoOwNWqOtrpXeJvHHGQXIPp0AYWuYootjoZDjbtCdQ/j/5SiAI5C64BA14UFzZt3yDedOyOWN2IC/Zvhvjmhuth+t9Nry9f7T15TuK+DStfMAB2Xqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deXdSLIf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760192; x=1770296192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AJgMS/3rss5Neb2tlKSN3dScesI/X8jToeY16uq63pg=;
  b=deXdSLIfYQM2NpcTfnhKxMrD579fupFA/r2rBDZZojbWCVHmq4beJjY4
   FKATSxyTi1XN1JwtYePMYqoCBHeKPR1/csD3fedrVIMDVSJijLAbvskR3
   UeQYXJRJJ3bL/CnV3AO4AypCzqQd5q2Ip0ux9TQO+mneLqH2yAjDka6Tl
   ixsyKAkPqwrdWL+zDI0uyWHBckyQSXcyuvamaKycclJwVmHZxVkCz6lFK
   8/3gYrQZgm5UZiXHBss2q10e4QsUFDIPZKEoYRecqCZzC4kDwyT+MhcBA
   hsYR/oK6vqjC19+SL6nIShrXzu9eUI0iGNcbEdpi+l/lyf3uhZQs1A3Lj
   g==;
X-CSE-ConnectionGUID: HaP8c4PuQr+8u824AjpxVQ==
X-CSE-MsgGUID: VEwMCPkxSG2ARt5W0jxNAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159217"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159217"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:31 -0800
X-CSE-ConnectionGUID: jrUeipU3R5uUhJBdNc3dcA==
X-CSE-MsgGUID: LleGvd4NQGSZfObAXhYjrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745495"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/19] wifi: iwlwifi: clarify the meaning of IWL_INIT_PHY
Date: Wed,  5 Feb 2025 14:55:44 +0200
Message-Id: <20250205145347.097510347ae2.Ica00b4b30163a21bf993fa968dd406ee4023fc9e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is a bit that tells the firmware to wait for the
PHY_CONFIGURATION_CMD before completing its init sequence.
Clarify this in the comment.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index ebe85fdf08d3..42360a8f23aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2021, 2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021, 2024-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -117,7 +117,7 @@ struct iwl_alive_ntf_v6 {
  *	finishing init flow
  * @IWL_INIT_DEBUG_CFG: driver is going to send debug config command
  * @IWL_INIT_NVM: driver is going to send NVM_ACCESS commands
- * @IWL_INIT_PHY: driver is going to send PHY_DB commands
+ * @IWL_INIT_PHY: driver is going to send the PHY_CONFIGURATION_CMD
  */
 enum iwl_extended_cfg_flags {
 	IWL_INIT_DEBUG_CFG,
-- 
2.34.1


