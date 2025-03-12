Return-Path: <linux-wireless+bounces-20266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE9A5E73E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757CF3B351D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830001EFFB5;
	Wed, 12 Mar 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR2+R9I0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25621EF0AD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818174; cv=none; b=iLV0jim+kNoyB9SSXrxTYlwpypW34vl/rn5kBqLsfw6aApHimCEIO8N0Oe6I2TxvP5iEUxDiTDQMdWNiphU4A5lzLLHJkAn4zbtPS1EZ6a4vg1TDU8w7q8/Dwa32sqqtbqUZ0eiH4W4EDtRKQGMB7ZLli/w4e+8VBQTQqiiPUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818174; c=relaxed/simple;
	bh=omaYo5lEnyaphu6ew7N6ZAtLtlltC/FJPVbBBRY8wl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsGw9+sTD6MufLJnuOrtJI5SGmKyI2WBvUJC8MZd7enOQsKYqbFt70aSFfePzQpqm19FJJWUeKBECf3AIHJX2x6OR466yNkL0bQfTVnOqvKVYdP96fXJoXT4G58ovtLYQW82orgYa+3sysNs4CqIHjX2fgmF129NQTpa02OV490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR2+R9I0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818173; x=1773354173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omaYo5lEnyaphu6ew7N6ZAtLtlltC/FJPVbBBRY8wl0=;
  b=QR2+R9I0WT7D61dP3/30ENN47nCW4KsV5FTH8EQ9C3lJw9DpP3MzACln
   MRux4ZGtkrQGoWeVYXGOTj9O2S6C5mCD0zM3a1gqWe8jE0jLxqlmkONPH
   iyPEdVhN2DhYrkrVYS9NN9TrGFtDk8FWX2VHL+9zvhVMzVrg8r4HxmTw7
   IMHKldOnCPw7vTmz0B29UnspUeh5nxlOTqt/hu1hBET4++eQepZ0/Z+PQ
   U2227qqaM616a51jQbPJGAYiy9y70NlMpT/t6GjIqanTp6MfkAyxvjez6
   +7W5wuP3DqOvVuWjYb8oMEOr3pRxmogBkU8zkE4mQZJ0SL0j15SAPzlTQ
   g==;
X-CSE-ConnectionGUID: LFBhcuglTnK1NZWFAd4VUw==
X-CSE-MsgGUID: 3TIlM3AARuyaYCbnaAs8nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826729"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826729"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:53 -0700
X-CSE-ConnectionGUID: nqbgWnuaQvOeZ8KabUeb4g==
X-CSE-MsgGUID: 1cR/GTSoRbW1QJuFY1rq3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267342"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 01/15] wifi: iwlwifi: mld: Rename WIPHY_DEBUGFS_HANDLER_WRAPPER to WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER
Date: Thu, 13 Mar 2025 00:22:24 +0200
Message-Id: <20250313002008.bb8a1d7907c8.I53325f2f37ccaad2b212d35d10616e06c1555e48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Renamed the macro WIPHY_DEBUGFS_HANDLER_WRAPPER to
WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER to better reflect its purpose as a
write handler.

Additionally, updated the corresponding macro
WIPHY_DEBUGFS_HANDLER_WRAPPER_MLD to
WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER_MLD for consistency.

This change does not alter the functionality but enhances the
maintainability of the code.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
index 04c536db8b16..13d97184a31f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include "iface.h"
 #include "sta.h"
@@ -67,7 +67,7 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {		\
 	.release = _iwl_dbgfs_release,					\
 }
 
-#define WIPHY_DEBUGFS_HANDLER_WRAPPER(name)				\
+#define WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER(name)			\
 static ssize_t iwl_dbgfs_##name##_write_handler(struct wiphy *wiphy,	\
 				       struct file *file, char *buf,	\
 				       size_t count, void *data)	\
@@ -97,7 +97,7 @@ static inline struct iwl_mld *iwl_mld_from_vif(struct ieee80211_vif *vif)
 }
 
 #define WIPHY_DEBUGFS_WRITE_WRAPPER(name, bufsz, objtype)		\
-WIPHY_DEBUGFS_HANDLER_WRAPPER(name)					\
+WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER(name)				\
 static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
 					  const char __user *user_buf,	\
 					  size_t count, loff_t *ppos)	\
@@ -121,7 +121,7 @@ static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
 		.llseek = generic_file_llseek,				\
 	}
 
-#define WIPHY_DEBUGFS_HANDLER_WRAPPER_MLD(name)				\
+#define WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER_MLD(name)			\
 static ssize_t iwl_dbgfs_##name##_write_handler(struct wiphy *wiphy,	\
 				       struct file *file, char *buf,	\
 				       size_t count, void *data)	\
@@ -132,7 +132,7 @@ static ssize_t iwl_dbgfs_##name##_write_handler(struct wiphy *wiphy,	\
 }
 
 #define WIPHY_DEBUGFS_WRITE_WRAPPER_MLD(name)				\
-WIPHY_DEBUGFS_HANDLER_WRAPPER_MLD(name)					\
+WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER_MLD(name)				\
 static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
 					  const char __user *user_buf,	\
 					  size_t count, loff_t *ppos)	\
@@ -170,7 +170,7 @@ static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
 	}
 
 #define WIPHY_DEBUGFS_WRITE_WRAPPER_IEEE80211(name, bufsz, objtype)	\
-WIPHY_DEBUGFS_HANDLER_WRAPPER(name)					\
+WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER(name)				\
 static ssize_t _iwl_dbgfs_##name##_write(struct file *file,		\
 					  const char __user *user_buf,	\
 					  size_t count, loff_t *ppos)	\
-- 
2.34.1


