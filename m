Return-Path: <linux-wireless+bounces-19008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C12A3739B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EF416D2B1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7A18DB16;
	Sun, 16 Feb 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo9jYTk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6619AA58
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699065; cv=none; b=gvJWODbFJbNPiXdaZ2LTwSXJB4qIzx3WBawVI8xLnwi7dNAs8J1WmSIKMEk4nGN1wV2W0amp/uZkgl8b/yEiux4wRQKIDVOiC8refwPu1SS74cnsmCXcBzPMaKp6XO1fPxkFbcaZF8JTOQSLq8x608yPsYH8nUVOQWula6Ag+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699065; c=relaxed/simple;
	bh=X4jlrpKKWGx4D9Gml0H8OF5uidp1nN6YgAx9mqtTLyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/tdDVomJAMcI4Pm+OwUp6MqKb8pwlhu4E47SWNFkRtSyeDt9dIdSvweaLM7RwhFjPo+BdD7wPBk3M3hsGsx2ctwpjSaUsyyk5eWw9qFB9tgisRrHyXuKNpb6j+q+AuqgOUh3+CTHTXuO2yzN3mh63qSrM3zzy07YRw+eyY/u2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo9jYTk0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699064; x=1771235064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4jlrpKKWGx4D9Gml0H8OF5uidp1nN6YgAx9mqtTLyc=;
  b=Xo9jYTk0Mwp6+bThjyUIa1PcuVe/4HvDys3CkzpunkkPM9dP4irCvYn2
   cqxiYMRWKFq1y4maYBJURfUSRHeSH/MOxHuzkZmQaIiT6YXKnWpyxreJf
   aVjyrJ3M8kRXOWQvDAHOBdI90ngR7b9ZiBZh7865LiCeapshxGxMBtu5o
   J8w7FD8VKtj72zCsbqRdI2+SrdiFU0D6gRZNj1K39zVywNVkha7Bobejb
   UiOvpcFmVrgi+9Wc3kVGYFebZl8VLijLbjoy3cpb6tKQaFYsqILl2R2VR
   rBEsDf1F/k1WbN7KS5EVWlIbXHu0aOE6D/NYak7gy+EbBPcGkx3rbIMSI
   g==;
X-CSE-ConnectionGUID: WdGr7NaSR8qTPVcjhuG8Lw==
X-CSE-MsgGUID: 2S7jSJxrSFOKt2GBDM991Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323434"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323434"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:24 -0800
X-CSE-ConnectionGUID: lcYlAfBmSe6NqSijFSmTxA==
X-CSE-MsgGUID: B88Tsvk5Qne+9APekM84kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785304"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 38/42] wifi: iwlwifi: mld: add KUnit tests module file
Date: Sun, 16 Feb 2025 11:43:17 +0200
Message-Id: <20250216111649.fa3b2c8427cd.I3e4c626677af92c33065d37d495ed852b19751ae@changeid>
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

Added the module file of the KUnit tests module

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tests/module.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/module.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/module.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/module.c
new file mode 100644
index 000000000000..5d9818587b23
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/module.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * This is just module boilerplate for the iwlmld kunit module.
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <linux/module.h>
+
+MODULE_IMPORT_NS("IWLWIFI");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("kunit tests for iwlmld");
-- 
2.34.1


