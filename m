Return-Path: <linux-wireless+bounces-8540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA388FC9AD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9D7B22A36
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E372192B91;
	Wed,  5 Jun 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/0Opv8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168E192B7F
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585523; cv=none; b=Wrf2QDpLheT0BQNrdAJWAmHvOKkW0qvdjkX9KQhMjwdvy0YomioxC8rIV1r3Jex5QIaym8Zy9sdQOLBZTEKKy3qcZGuuQdQxZXwWmPpCgrtiOWukUEGsG/i0R/ytAEuf78mOaQmDjdUpxJ8pH0fJS0aI2PiV1gQogtJtRkh67EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585523; c=relaxed/simple;
	bh=EmG97sEEcxUsnr+F4rOU0ezL9jgSHIt2wS3AFnqxRDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuCXInXYQzZyrJSwLFcQzS3O4qxT8EkngFnLKS0IICY6oCKa6FjS1Tv85xsXLBhgsbiHDcZSLDe+GAR+waY3emfY7PWcMnHb0QsJ4SblwZ5S2Kqjx1HXYWbTMcRX8W1HQIzvBlPiWXBtBIvb0zQCZTElsFmGRPI1KThewiGPBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/0Opv8w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585522; x=1749121522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EmG97sEEcxUsnr+F4rOU0ezL9jgSHIt2wS3AFnqxRDc=;
  b=K/0Opv8waLlVuDxInEj0yeI45eLzFz91COsAGeqGuMKoNh8L2s3PuMgw
   22IRwvz9xCNH+1kwUqqKUlNCFX+fknuCIryxlxE+cJ+HBrTkbxC7THuG0
   FXL2549BlLBm+7RPEH0/5+d4bPFkA/OwZSkQyQj4+UklxLnRKhAxypSxz
   VnvbnQrbtchzJUAC1PB6zXaGZxycxdOI7WFg+bO5LB33ha52e6JVYYkDl
   L7WGoRrAQxt3p4l+pSMYW3tzNVyVlrYyKIwAr/vJpZUrxYMaZhrntykma
   cJEFIP7oCPmkIhTYXohoEEX5FL60zDxPmOqdnAPsMzNpYmH99IuzZOOcK
   A==;
X-CSE-ConnectionGUID: bAh6cgGBTqGJW3pOCv1KQA==
X-CSE-MsgGUID: MYQYkQNGTJi09WOY8PSa2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402185"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402185"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:22 -0700
X-CSE-ConnectionGUID: tMsg8ZODQY2XrdX59nQ+0w==
X-CSE-MsgGUID: 3PI2VM2NTRaU+uBSZa3QJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997367"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: api: fix includes in debug.h
Date: Wed,  5 Jun 2024 14:05:01 +0300
Message-Id: <20240605140327.2d25691283eb.I0909621a0e293a8a21d4f1de6e5fd59c22e4b212@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This needs to include dbg-tlv.h since it uses the value of
IWL_FW_INI_ALLOCATION_NUM from that file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index b31ae6889bd0..bea0f4668cc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_debug_h__
 #define __iwl_fw_api_debug_h__
+#include "dbg-tlv.h"
 
 /**
  * enum iwl_debug_cmds - debug commands
-- 
2.34.1


