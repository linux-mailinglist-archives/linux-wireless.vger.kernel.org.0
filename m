Return-Path: <linux-wireless+bounces-18994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5370A3738A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183543AB5DD
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565319342E;
	Sun, 16 Feb 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCJ//0Y0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A612192D77
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699047; cv=none; b=SZjRCfbz4BNiUHFKydzx98T7INHiXUbfNyP9cDEFtl+MmB8YvNO1fZqZOcufomsyO6rUi3Rkl0tIsv318bF8lFVlsJhbaS9btyjdJNBXwPpDhOj7K/l4dHt48Ad62f6IiIT8zqst3kyTY5866sbOOmflrH5A/iK0Cy7lziMEPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699047; c=relaxed/simple;
	bh=9rJ80QKEtjt+qtw+9g1sQvhe/HdkNtqRj5GNfYoVsCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=To64whnfHjm2edqYKUooQks3OOuR19275WbI4AWtPbLIArs2EuVx5rz7A2yOQ227LJEXwwU994/o5pQZAxUlWb9sIsK+rL9vai7rNUKjYp4ssLbcuxx9lb9P+ixGwG+hYdSWUmMcfUr2XT+tDhu+XU3mna/Xu9txKA21N5edkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCJ//0Y0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699047; x=1771235047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rJ80QKEtjt+qtw+9g1sQvhe/HdkNtqRj5GNfYoVsCo=;
  b=bCJ//0Y0f01tU8OGptY8kezVFqIM9PMneqAc+u35R34o9VERSOx7Pwso
   16nvqeg1ojQgvEvz3bPzWFwf440fwDJD2IG4Ty2tUB0tOXN9lbSGbb/xW
   BBhOShtk+Ymd+AnnlFo5wt8UT9l1CAK08jtT5zsIL0gKGLxeUEpS54g2Q
   fWu6tUOG5mjo1CdQhgxPLmSAxSr94NZXKHtvmyk4tru6H53DOgHfrmZ2S
   dpTdx7eSPkwg+8D8Z9fCVbTRisjAfG0xtVp1QOjFz0XMu3vSIy5uFYNd/
   HK/Q5sBYZ+XehZ9+5oZGbz4+vX12PbdfNQmrXNNQ/E+XzvjEUnjJ9aNt/
   A==;
X-CSE-ConnectionGUID: TMbXlTzVSnaU2nUXkaVM0w==
X-CSE-MsgGUID: VQDNGSRFSMuUiB9OoGVMNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323404"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:06 -0800
X-CSE-ConnectionGUID: gqwlmVz6Rby9Sp00CjQ1bg==
X-CSE-MsgGUID: E8xFTmVxTrGJFpx0JkzqhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785256"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 24/42] wifi: iwlwifi: mld: add file roc.h/c
Date: Sun, 16 Feb 2025 11:43:03 +0200
Message-Id: <20250216111648.0feaa62fdf2d.I5e6722ec0f08f9409bd32227955b064ec2f6b7bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

these files are handling remain on channel functionality

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/roc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.h b/drivers/net/wireless/intel/iwlwifi/mld/roc.h
new file mode 100644
index 000000000000..985d7f20a3d7
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_roc_h__
+#define __iwl_mld_roc_h__
+
+#include <net/mac80211.h>
+
+int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct ieee80211_channel *channel, int duration,
+		      enum ieee80211_roc_type type);
+
+int iwl_mld_cancel_roc(struct ieee80211_hw *hw,
+		       struct ieee80211_vif *vif);
+
+void iwl_mld_handle_roc_notif(struct iwl_mld *mld,
+			      struct iwl_rx_packet *pkt);
+
+#endif /* __iwl_mld_roc_h__ */
-- 
2.34.1


