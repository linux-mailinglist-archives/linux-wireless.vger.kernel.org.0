Return-Path: <linux-wireless+bounces-19011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58AFA3739E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B454616D2D1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C019B5B4;
	Sun, 16 Feb 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9vNG4Rg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB119ADA2
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699069; cv=none; b=Vb6ZzzigkfNA6tNK/PsFqePOjc6MICNDYC4JpkRebzEHj4A244EMdK1F6FhjFsssOxhaLJIi34PzMMH94bnJNOocBc09zDd9N2t/0GBqIRvqDSEXUi0iaNqdy5K9GaAHkEnLcThfMXYInYDnzDgB0AMsQppZppKk+zcnDieZjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699069; c=relaxed/simple;
	bh=6CZaKz0zJRtvo0bJl/RsnSI3WFdEdkF9uHIpNT8O38Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuONlufekwj0TUhgHoIXNbMTWBXAwc+F3kAzo+1m3DfIqaAcbGvxKRs87oz05Pyyk5ajQjccQupsIsSai6xIqzjeYzDes4BUdHEEoH3IyIqwgJYdGQu2IyzhfU50dRKAjlcCJHeS5OajyJpCCqI2nwcPR/UjRvFdr+P6fH/Wtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9vNG4Rg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699068; x=1771235068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CZaKz0zJRtvo0bJl/RsnSI3WFdEdkF9uHIpNT8O38Y=;
  b=M9vNG4RgsA5duGTsPBQSmkRp76Y6XHg82xZ6kg4Wg9h5UynaIEUpwkHL
   CYRUmA/bzrbwlN+UnW93gXBPVk61Y5ubgpWq726hAj3ric9HeKV5+Tcl6
   GeFm72o1/++EGjPIYUUwAOgrYuKoJr7cdUEVM7EFv9FaUZx0MKXEMODlM
   jAlY+OlJnJMbXJ1m9VqO7GCNa0Z3ub5+TAy3Gn8pnQBcv8P9WlLkzBZ9j
   E4cuu2fD+u1jc9eIJZFEWjcKmUtY6Vcffbs8DlIy+sytWqBOQAs+GYqOJ
   QweiTkbqmysuZYwgtimFNZt0qLN9wOJis880kJ6w0FtoH+vAGa5plc0p6
   w==;
X-CSE-ConnectionGUID: 0FNyFW4FQAeVoqeCYkbUOw==
X-CSE-MsgGUID: kkoTce4UR4OgwI5zE+jtag==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323441"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:28 -0800
X-CSE-ConnectionGUID: 8lfLvd4YTIGW0eVOQx3LmQ==
X-CSE-MsgGUID: UoRH1/nZQaGHu2OYitTk8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785316"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 41/42] wifi: iwlwifi: mld: add KUnit tests Makefile
Date: Sun, 16 Feb 2025 11:43:20 +0200
Message-Id: <20250216111649.94730d1b39ef.I9b84b74fe6903060c8f1ccd83f01edfd76fe4650@changeid>
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

Added the Makefile of the tests directory

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
new file mode 100644
index 000000000000..36317feb923b
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+iwlmld-tests-y += module.o hcmd.o utils.o link.o rx.o agg.o link-selection.o
+
+ccflags-y += -I$(src)/../
+obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmld-tests.o
-- 
2.34.1


