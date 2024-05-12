Return-Path: <linux-wireless+bounces-7544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43E8C367C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995BD1C211E5
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2E3F8F1;
	Sun, 12 May 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDnTdBT6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB4381AD
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516730; cv=none; b=prAlSSDkWpRrtaGUxFIimf2EcM5aEZlRGQLw4FUjt01zz4C/fED+a5bKsfvnh5IGJH7eempveq5lz4wK9kk1szhELTC53/pQzimB3cveN7+fRgHx5m6TZe17qxXBc/vx2zIYjE+MNixG9h+7aQR9etkvSDvI3MJ2L5aj2En+guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516730; c=relaxed/simple;
	bh=VS4KftS/w5xGxn/PIPGafOo8FOkHdaNZ2ljk72Xxyw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u79JkqCD3ZLJ9+CIc6ARGQw882voLtMGcBEO5wKzLbWYhFJ72nutGbc+4OP8PH9kPv/NBrZV2ucZIbUmvhBO5VNU2nnpyf1RZu9MWPHef2DN4AQgAXRMEVanqkUoJwEGOODimQr8Fpg1NUehIu/ba7ZGDGO2YgHLe/0uEefjdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDnTdBT6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516729; x=1747052729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VS4KftS/w5xGxn/PIPGafOo8FOkHdaNZ2ljk72Xxyw8=;
  b=HDnTdBT63CGkFiT0wzr/QQr4seRltyDzx8jfdv7HIqnqum8Le7eh7OMF
   ghobFM2n34H9H7wU1GEAUkYpkOoQMyUfEJeuxbMTyieLhwbw6Y0w3N+pA
   oTcnxlQOydRUMPwvWdOQtw7oCSQWXbIHflp7Lef48CgGiEDbQngdxV9AJ
   KHYq4YafSOM+27pAzjTfhNF/CKymg6bUj8vMe4wjGFpvGNq2FIP8G5tXV
   r8Tjwed6CRO/TanY7cJHq9QX1rWmeQoEXyNq/Nh7wjt89QLDEAcjCcj6J
   /jR3lslTNVXKvVb9+/DNN4ls7B13I3o5CxW/clRmeQHg9JECyy1YP0rQE
   Q==;
X-CSE-ConnectionGUID: jqLt4oHNTPu/Yl4uy7bZ6g==
X-CSE-MsgGUID: bJLnoxpySsOvIvFlGvc5pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397210"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397210"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:28 -0700
X-CSE-ConnectionGUID: wBTIQFBPRqa/MR8H5wISYA==
X-CSE-MsgGUID: 2+tFrilmTCGTYPtMwSZsdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761333"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: kill iwl-eeprom-read
Date: Sun, 12 May 2024 15:25:02 +0300
Message-Id: <20240512152312.72f4bf256c8d.I7433bda9b0fc9eece5210db2cb90c2f03973f5ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is used by dvm only, move to dvm.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile          |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/Makefile      |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h         |  4 +++-
 .../iwlwifi/{iwl-eeprom-read.c => dvm/eeprom.c}      |  5 ++---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c        |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h | 12 ------------
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c         |  3 +--
 7 files changed, 10 insertions(+), 22 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-read.c => dvm/eeprom.c} (98%)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 8bb94a4c12cd..2c2c18cef9ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IWLWIFI)	+= iwlwifi.o
 iwlwifi-objs		+= iwl-io.o
 iwlwifi-objs		+= iwl-drv.o
 iwlwifi-objs		+= iwl-debug.o
-iwlwifi-objs		+= iwl-eeprom-read.o iwl-eeprom-parse.o
+iwlwifi-objs		+= iwl-eeprom-parse.o
 iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
 iwlwifi-objs		+= pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o
 iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/Makefile b/drivers/net/wireless/intel/iwlwifi/dvm/Makefile
index 0486b17d7c41..2d0b6d287af4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/Makefile
@@ -2,7 +2,7 @@
 # DVM
 obj-$(CONFIG_IWLDVM)	+= iwldvm.o
 iwldvm-objs		+= main.o rs.o mac80211.o ucode.o tx.o
-iwldvm-objs		+= lib.o calib.o tt.o sta.o rx.o
+iwldvm-objs		+= lib.o calib.o tt.o sta.o rx.o eeprom.o
 
 iwldvm-objs		+= power.o
 iwldvm-objs		+= scan.o
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index fefaa414272b..47d21413ba59 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2021, 2024 Intel Corporation
  */
 #ifndef __iwl_agn_h__
 #define __iwl_agn_h__
@@ -385,6 +385,8 @@ static inline void iwl_dvm_set_pmi(struct iwl_priv *priv, bool state)
 	iwl_trans_set_pmi(priv->trans, state);
 }
 
+int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size);
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_dbgfs_register(struct iwl_priv *priv, struct dentry *dbgfs_dir);
 #else
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
similarity index 98%
rename from drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
rename to drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 5f386bb1a353..3972775fc133 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2019, 2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021, 2024 Intel Corporation
  */
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -8,10 +8,10 @@
 
 #include "iwl-drv.h"
 #include "iwl-debug.h"
-#include "iwl-eeprom-read.h"
 #include "iwl-io.h"
 #include "iwl-prph.h"
 #include "iwl-csr.h"
+#include "agn.h"
 
 /*
  * EEPROM access time values:
@@ -391,4 +391,3 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_read_eeprom);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 8774dd7b921e..7bb3011e12e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014, 2018 - 2022  Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2018 - 2022 Intel Corporation. All rights reserved.
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
  *
  * Portions of this file are derived from the ipw3945 project, as well
@@ -25,7 +26,6 @@
 
 #include <asm/div64.h>
 
-#include "iwl-eeprom-read.h"
 #include "iwl-eeprom-parse.h"
 #include "iwl-io.h"
 #include "iwl-trans.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h
deleted file mode 100644
index 63b8e6c6659b..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/*
- * Copyright (C) 2005-2014 Intel Corporation
- */
-#ifndef __iwl_eeprom_h__
-#define __iwl_eeprom_h__
-
-#include "iwl-trans.h"
-
-int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size);
-
-#endif  /* __iwl_eeprom_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index ae8177222881..1e949b48188e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -10,7 +10,6 @@
 #include "iwl-csr.h"
 #include "mvm.h"
 #include "iwl-eeprom-parse.h"
-#include "iwl-eeprom-read.h"
 #include "iwl-nvm-parse.h"
 #include "iwl-prph.h"
 #include "fw/acpi.h"
-- 
2.34.1


