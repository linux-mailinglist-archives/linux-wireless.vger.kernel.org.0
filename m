Return-Path: <linux-wireless+bounces-9206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C3290DA4A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 19:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6711B2F923
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900E143C7A;
	Tue, 18 Jun 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beDJIs8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F213DB98
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729074; cv=none; b=YSKNrf1cIDV4nQk0GMRDrwjh5tozDKri0eW98zBBHh+RTRIHKVqhKQDLJEyXfgvctDXC9TeFMBst5SsRgXfMGtqoh6osO8MBK7FvYjkDCV3eAIxzNZDINkFNsdsk5GZAwQh/OzkQwzgEtmvBo9of0sAhjA+ONfPF7AACpOeRjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729074; c=relaxed/simple;
	bh=bZBx8rHpovzKPCAvOuvDNTLW3qpNmAz7gwGaWrciFjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFre9CF37k/MoCnvr3h4HD8QB2Qwb3G0rRRHRdz576M3f74NPEaU6b0+DAGFozndnUrLREVuYDGlBnnVvutRgoZ+hGVFHiH/+y3V+zxSaKV6WhTE19pg1xLCpCnFZbYBq7d6j3l+sqjMRVa4d/dFPBpQFvZyffaB8gpWaw3et4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beDJIs8o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729072; x=1750265072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZBx8rHpovzKPCAvOuvDNTLW3qpNmAz7gwGaWrciFjI=;
  b=beDJIs8oNY/B7SH9j6yKXa5aGk2P6fy9I5mDjLjuEqXO0Qbg+eFdzjZD
   B4Q4JuNcdYMPxdaLCq9OGEymk2NhundmJdc/KpZP083j/sVRj0g3AYwNp
   mA6T8UYH05BsbnwlY0R+PMZYun52zwg8LNR6RIBbMUdoiwCt/J6XNHQQ3
   OpYhp9lr3ZrqTQIqY7VtnhgWhlX/pJMOBlZhgE/1nYt2TZGpn9q304pNS
   I5A6/W1KEyy6TkjXxLutPCcw+Zw8Cbw0qdwpLVuUvfaT/TwMmYx00ghyM
   3oZ6K664bkE+3cbwKL55fzM31Vz27PK5giGqrOUgQmG0284/urgmdX/Kk
   Q==;
X-CSE-ConnectionGUID: Q+XWVyK3TAyOiecjbj1VQw==
X-CSE-MsgGUID: +Muwq8wjSR2DpInYS3RRDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257182"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257182"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:30 -0700
X-CSE-ConnectionGUID: 4vMDhH8uSWeeaxjszhsmUw==
X-CSE-MsgGUID: Rm+JX+GORZGyvyjx46ZGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306522"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: don't assume op_mode_nic_config exists
Date: Tue, 18 Jun 2024 19:44:07 +0300
Message-Id: <20240618194245.718983e7b832.I02fb130aa3d2044958cba7dced357031b92e33bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The new op_mode won't have this callback.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 1ca82f3e4ebf..595fa6ddf084 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -185,7 +185,8 @@ static inline void iwl_op_mode_cmd_queue_full(struct iwl_op_mode *op_mode)
 static inline void iwl_op_mode_nic_config(struct iwl_op_mode *op_mode)
 {
 	might_sleep();
-	op_mode->ops->nic_config(op_mode);
+	if (op_mode->ops->nic_config)
+		op_mode->ops->nic_config(op_mode);
 }
 
 static inline void iwl_op_mode_wimax_active(struct iwl_op_mode *op_mode)
-- 
2.34.1


