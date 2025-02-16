Return-Path: <linux-wireless+bounces-18978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD5CA3737A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE4116CF1D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE318DB0C;
	Sun, 16 Feb 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCoUAr7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6818DF86
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699029; cv=none; b=oDGbann2CkNpY0jeGukbdsvJT7ZnG97QhwDfUcKcOwHIQM33gNTp6Jb/OhO1H9gFfIjLO3oqIOS61aG6vMazxrQlJArTxJ4Ik8ypu6NSh436X3yVw6jkdmqI9FXg2jyKNB4/K4bno6hmdz7X5ZXu3twGCX74Bd7fjNjjGMECN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699029; c=relaxed/simple;
	bh=pQtJ73sVVIryv8KAKGdy/k0GlOpI6OCZt4fRKlLEJ68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUrjVl8MPK8tet4XKA4OhpQK1K6wbCFDH0dfYQB0tmHUnZcx7ywQHA8xWMu/CD1cHxeWQBClx8dL3pwPmcOzN4mKd4jPPkuXmKJWsUHM8vz9O50C3UUdA4mYYSYKn7cmiy7FVXNc9J1VIPnUGlmeH8UKEaMFpbQa93msYqwLJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCoUAr7o; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699028; x=1771235028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQtJ73sVVIryv8KAKGdy/k0GlOpI6OCZt4fRKlLEJ68=;
  b=XCoUAr7o2Z5kRfaSN+vqWrRARvv9WGlMIFYCkKv8bhAn6zBFRjqAiykM
   aYhNEqmncJC9cHoeQcfiF29+Au7RpoHscDlVLuQUnPEc3Mpa5/7nsQ5KC
   8xLNKjDLOKY3Bx1j67Q0Vy2He3yW3Yx7sj7+CwexJHHQviqbncI6NZtzj
   tTkTSB52xWdbtUS3o7CgilbvfHDD/mGZVnNXWYqTAOtRQnrTHm67L+n1L
   CumSiYxovENVZeBDbyxkZ95MIAU6GO1S2ehWDnuJTj5+7Usmj6Y8nGM4D
   DLq4Z3Xx0hjGuqy9GMxI/kwSwSiDt5b2dOkaEqt7242oqGR79emw1v0yZ
   g==;
X-CSE-ConnectionGUID: qS7OUCunS9OYpOBI1+outw==
X-CSE-MsgGUID: x8BSq/FrRBOxsjsBl3XI6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323373"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323373"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:47 -0800
X-CSE-ConnectionGUID: 92jnZl82Sla3+3V0p/yONA==
X-CSE-MsgGUID: MChc+5MBT6yjWFsYLsC14w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785230"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/42] wifi: iwlwifi: mld: add file hcmd.h
Date: Sun, 16 Feb 2025 11:42:48 +0200
Message-Id: <20250216111648.4ea3be8704c0.Ib7598a8407749d75a7faffd4e1d9e1a9de70de28@changeid>
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

this file is handling sending host commands

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h b/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
new file mode 100644
index 000000000000..60d4ee63d3f1
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_hcmd_h__
+#define __iwl_mld_hcmd_h__
+
+static inline int iwl_mld_send_cmd(struct iwl_mld *mld, struct iwl_host_cmd *cmd)
+{
+	/* No commands, including the d3 related commands, should be sent
+	 * after entering d3
+	 */
+	if (WARN_ON(mld->fw_status.in_d3))
+		return -EIO;
+
+	if (!(cmd->flags & CMD_ASYNC))
+		lockdep_assert_wiphy(mld->wiphy);
+
+	/* Devices that need to shutdown immediately on rfkill are not
+	 * supported, so we can send all the cmds in rfkill
+	 */
+	cmd->flags |= CMD_SEND_IN_RFKILL;
+
+	return iwl_trans_send_cmd(mld->trans, cmd);
+}
+
+static inline int
+__iwl_mld_send_cmd_with_flags_pdu(struct iwl_mld *mld, u32 id,
+				  u32 flags, const void *data, u16 len)
+{
+	struct iwl_host_cmd cmd = {
+		.id = id,
+		.len = { data ? len : 0, },
+		.data = { data, },
+		.flags = flags,
+	};
+
+	return iwl_mld_send_cmd(mld, &cmd);
+}
+
+#define _iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, len,	\
+					 ignored...)			\
+	__iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, len)
+#define iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, len...)	\
+	_iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, ##len,	\
+					 sizeof(*(data)))
+
+#define iwl_mld_send_cmd_pdu(mld, id, ...)				\
+	iwl_mld_send_cmd_with_flags_pdu(mld, id, 0, __VA_ARGS__)
+
+#define iwl_mld_send_cmd_empty(mld, id)					\
+	iwl_mld_send_cmd_with_flags_pdu(mld, id, 0, NULL, 0)
+
+#endif /* __iwl_mld_hcmd_h__ */
-- 
2.34.1


