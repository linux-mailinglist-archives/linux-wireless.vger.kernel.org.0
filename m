Return-Path: <linux-wireless+bounces-23869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E392AD2573
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA39C188CC16
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22221D3C0;
	Mon,  9 Jun 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0bu+rEp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9021CA14
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493322; cv=none; b=WmWzeTDcgkn/sUkeBzZ4kxwEb7ohcerC0UTi1p8yMjGa2GWUeIcc3l1oduSr/Es52zibJKyANtLo04qf7fstBs4uSCtgu14iy3nOs+a308qUkBb8eqUmQmDicK+HQLp116juLSqbZCVqIcxz4mgWenLZrkGaM28kgahN7uiWCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493322; c=relaxed/simple;
	bh=LRgemWFWSWjM7MUCohzbJnvRWyOwOzOsQ6m27aDDeMo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETDB91Z0lfzoAZE3PvKIQoiU7vqsXbQdnZcQnPyvFMqfFLQCy1/+hzfFE5sMYF1cKBoEI6+e+Vm58B5sVoXc53N9/Yq88l5qabRCQ1BrGV8JDgXtx+hGYMroGMzQwpGNzV5YcEB5CYQFWHj/yKTlQSJVtyQNPw0c3PULVQ60qY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0bu+rEp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493320; x=1781029320;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LRgemWFWSWjM7MUCohzbJnvRWyOwOzOsQ6m27aDDeMo=;
  b=F0bu+rEpl7nx2Ecxn2Jg1tEE1fB7rtCxwYncPYOWymQKg9JqvNIwXSV6
   06JFX5WFIc3Kfvz70MLBrwxuY+9GMcCFVwS4kV/BHXW/y1LlYoBN6g6VK
   LUNuiKbf8yUyIZ/yUuVE1/g4kKqeeteg2eI/sVNHD07UBLOCrSDe2emDw
   /0LAWZ9pVfdnJ9FHfKCLCjbn0PbGtpJ95wHEdMQxc40wjFPkrcj5YrS+d
   cVtRBjOEIRKo6ARrYqfFifxGXBq78Zy2TiO4eN+ViweQtXsHuhaWrNt7W
   0VAqhVCDraI5nQ3Pn0GA/b5wI/kD0Y/LmhL/QXdm7lmPCbEOl8wbRCF3A
   A==;
X-CSE-ConnectionGUID: RwS+V2B7Q2eL2NJCb7Brvw==
X-CSE-MsgGUID: ctPKHQCYT6SaY9nJcK4KwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237690"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237690"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:00 -0700
X-CSE-ConnectionGUID: bUR0qHjcS5yujVHcGDYj3g==
X-CSE-MsgGUID: 5Morg1KkSWOf0/9NTcWmsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510340"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: pcie: move generation specific files to a folder
Date: Mon,  9 Jun 2025 21:21:16 +0300
Message-Id: <20250609211928.bb0757c326c5.I66345c2b3fda55dcb8ff779c64de72d5c19f6649@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

As a new generation of pcie is going to be written, we will need a
folder for each generation.
Since gen1 and gen2 code is tightly coupled and has with shared logic -
it is not really separable.
Put the code of both in one folder.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile               | 8 +++++---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c            | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c             | 2 +-
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/internal.h   | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c | 2 +-
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c | 4 ++--
 .../net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans.c  | 2 +-
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c    | 0
 drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c | 0
 11 files changed, 14 insertions(+), 12 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/internal.h (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c (100%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c (100%)

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 3f476e333726..71101067b889 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -7,9 +7,11 @@ iwlwifi-objs		+= iwl-debug.o
 iwlwifi-objs		+= iwl-nvm-utils.o
 iwlwifi-objs		+= iwl-utils.o
 iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
-iwlwifi-objs		+= pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o
-iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-v2.o
-iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
+
+# Bus
+iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-v2.o pcie/drv.o
+iwlwifi-objs		+= pcie/gen1_2/rx.o pcie/gen1_2/tx.o pcie/gen1_2/trans.o
+iwlwifi-objs		+= pcie/gen1_2/trans-gen2.o pcie/gen1_2/tx-gen2.o
 
 CFLAGS_pcie/drv.o += -Wno-override-init
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 221c3997ee87..5dba76b009a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -14,7 +14,7 @@
 #include "iwl-fh.h"
 #include <linux/dmapool.h>
 #include "fw/api/commands.h"
-#include "pcie/internal.h"
+#include "pcie/gen1_2/internal.h"
 #include "pcie/iwl-context-info-v2.h"
 
 struct iwl_trans_dev_restart_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
index 976fd1f58da4..0df379fda463 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
@@ -6,7 +6,7 @@
 #include "iwl-trans.h"
 #include "iwl-fh.h"
 #include "iwl-context-info-v2.h"
-#include "internal.h"
+#include "gen1_2/internal.h"
 #include "iwl-prph.h"
 
 static const struct dmi_system_id dmi_force_scu_active_approved_list[] = {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index cb36baac14da..d53dab95c3e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -6,7 +6,7 @@
 #include "iwl-trans.h"
 #include "iwl-fh.h"
 #include "iwl-context-info.h"
-#include "internal.h"
+#include "gen1_2/internal.h"
 #include "iwl-prph.h"
 
 static void *_iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 656f8b06c27b..44e19b27f36a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -15,7 +15,7 @@
 #include "iwl-trans.h"
 #include "iwl-drv.h"
 #include "iwl-prph.h"
-#include "internal.h"
+#include "gen1_2/internal.h"
 
 #define _IS_A(cfg, _struct) __builtin_types_compatible_p(typeof(cfg),	\
 							 struct _struct)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
similarity index 99%
rename from drivers/net/wireless/intel/iwlwifi/pcie/internal.h
rename to drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 3b7c12fc4f9e..c90707cfd351 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -22,7 +22,7 @@
 #include "iwl-io.h"
 #include "iwl-op-mode.h"
 #include "iwl-drv.h"
-#include "iwl-context-info.h"
+#include "pcie/iwl-context-info.h"
 
 /*
  * RX related structures and functions
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
similarity index 99%
rename from drivers/net/wireless/intel/iwlwifi/pcie/rx.c
rename to drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index fefde167c41b..7b56eb78663c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -12,7 +12,7 @@
 #include "iwl-io.h"
 #include "internal.h"
 #include "iwl-op-mode.h"
-#include "iwl-context-info-v2.h"
+#include "pcie/iwl-context-info-v2.h"
 #include "fw/dbg.h"
 
 /******************************************************************************
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
similarity index 99%
rename from drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
rename to drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 38ad719161e6..6c5acb7bf643 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -5,8 +5,8 @@
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
-#include "iwl-context-info.h"
-#include "iwl-context-info-v2.h"
+#include "pcie/iwl-context-info.h"
+#include "pcie/iwl-context-info-v2.h"
 #include "internal.h"
 #include "fw/dbg.h"
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
similarity index 99%
rename from drivers/net/wireless/intel/iwlwifi/pcie/trans.c
rename to drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index cc4d289b110d..4d2806d071d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -28,7 +28,7 @@
 #include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
-#include "iwl-context-info-v2.h"
+#include "pcie/iwl-context-info-v2.h"
 
 /* extended range in FW SRAM */
 #define IWL_FW_MEM_EXTENDED_START	0x40000
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c
similarity index 100%
rename from drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
rename to drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
similarity index 100%
rename from drivers/net/wireless/intel/iwlwifi/pcie/tx.c
rename to drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
-- 
2.34.1


