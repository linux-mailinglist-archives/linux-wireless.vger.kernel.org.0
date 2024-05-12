Return-Path: <linux-wireless+bounces-7517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7868C3508
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D701C20E78
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F517548;
	Sun, 12 May 2024 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkGCLAY+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFA14286
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488295; cv=none; b=HXv2sZnFRadElXrBF7syrCeBryprrK1GFpTFVLmdLKXMgS3VsRtgLHRYVnb0l9fkDbr7h/uzKdtyqEsJP8lGBV2k+07f3NXnoSP0UvSgiAXwQqnA4bk0IR/Ar+Gk+zSKxkSiRxeki/RvJXrPEWwa9rKsdDfIbUX4UvnBVd40vDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488295; c=relaxed/simple;
	bh=QhqG7UP0HVXKNSRLthzPpzkThTw7hORoyvQcQDUNJkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukjNK8dKdRQXN2BaVz7UU39V8xCtG4H4cc58clzqHWUSKeFJR4lMG1cfZGsFjYakVyjEakSKdiCoMpALh+E6+9Qd8wX7tyPrmcRURc+aWf1I8AaXM+QXcw/JZO3c05bZeyVbZ1IS+UbhV7ttDZS0Ydqrm86kmI8feZltp/Fp/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkGCLAY+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488293; x=1747024293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhqG7UP0HVXKNSRLthzPpzkThTw7hORoyvQcQDUNJkM=;
  b=BkGCLAY+FdBGlg95LmKgse2JMFC3IoXkLcgcA05pzkJE1AXuInpUd/PB
   yWs6ncQr6B3FhFu3tWoyjBxXffo+zb2sxww/zWrJSParQv1/hzi595g48
   rjr/3m9StgrHhpAJVS9eaCpKxnE+iqmng8xq9TTerBxUqFcciTUtxTVfZ
   TnLnQGwD5vKpy2c7YhcIyzJojfTBRDZvMLzdCBkJxSmSvjxF6SdEUF8tP
   DGFNWPka1sMBdXrKj2lALSzIhS6qIJe9j/GZWbOF3XXLEIz2ysoBF6Hcs
   HQZjROeKNA1RHvmTmw+dotFDSBRVZBgzWr660TDUxbwTd2w7u2kVYKxab
   g==;
X-CSE-ConnectionGUID: FZFZkCpURWmxwYoccOU+qQ==
X-CSE-MsgGUID: 1vDmvvuIR6Czz+D4zecQUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323846"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323846"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:33 -0700
X-CSE-ConnectionGUID: EkF8OoCAQn+tUuBwJ93kkg==
X-CSE-MsgGUID: n09QPY7iT6GcQU0O4kAv8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532156"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/16] wifi: iwlwifi: mei: unify iwl_mei_set_power_limit() prototype
Date: Sun, 12 May 2024 07:31:00 +0300
Message-Id: <20240512072733.854427753c92.I557716085cb1f6a35d1f97640388fa421f42a56a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The two versions of iwl_mei_set_power_limit() are a bit different,
and while really the const isn't all that necessary on the inline,
it's still better to have it be the same.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 1f3c885aeb65..ee48b86674a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2021-2023 Intel Corporation
+ * Copyright (C) 2021-2024 Intel Corporation
  */
 
 #ifndef __iwl_mei_h__
@@ -488,7 +488,7 @@ static inline void iwl_mei_set_nic_info(const u8 *mac_address, const u8 *nvm_add
 static inline void iwl_mei_set_country_code(u16 mcc)
 {}
 
-static inline void iwl_mei_set_power_limit(__le16 *power_limit)
+static inline void iwl_mei_set_power_limit(const __le16 *power_limit)
 {}
 
 static inline int iwl_mei_register(void *priv,
-- 
2.34.1


