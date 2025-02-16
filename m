Return-Path: <linux-wireless+bounces-18973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76363A37375
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2467D16CF1D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90618DB02;
	Sun, 16 Feb 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiZoRqQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68018DB0F
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699021; cv=none; b=Dld8GnUHBC+5QMVeJ12FV/SjA42MiMSh7BQbZOeTdnUBupaXi9j38nd9pyN9CMZ7H5wI5oUa5nY0MdbHjNKlXwO5MobZ7WY2sUAWHeecI/GsL9yci7nHLcrRonyGzBgKjzjvsmE+n7FpI8Mv1D9ECIinWLlM0+AGHsHICPI4qrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699021; c=relaxed/simple;
	bh=hiegRx6RFuQsv9J+rDjKr4YDnfxNBHj0r9tO7b3ewrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LN61uAj6VdqGrCopYb4xcSZIkIqBpJqTtR2eHIPWV9WNzS+kynji7emoDFgZquhgEMhE2t8I3MGCcP5Y/KNOBfkPfAJVZXm8StrVL0LzBU6qhjmP4ESwSQNJ80r5yRUEdnXu3OhmILsSaFpk6kMjW0bP0nbP/HcLGgk1QS/7+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiZoRqQY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699020; x=1771235020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hiegRx6RFuQsv9J+rDjKr4YDnfxNBHj0r9tO7b3ewrQ=;
  b=UiZoRqQYp+CEB0czC+UcorNlHoSHO2mLWV/0bGmzRB8++uVVHQBHBqNE
   uQViJU6JTrQWJ73Qu0ki47RnN5RtevER0dCipGgDDiHdEOZ3mlwISHOhL
   AOplyBpOL7lPTca0YK/UwrmD0SAntN44XydReP+4lwDv1jyC4lXpeO6/d
   KySB5tl7FTivaa01+wu5tXvLBzSMPMzdYy2/us997kHZU0mRCQ4aftpEf
   GRV4jDrgl9X1JzLImiYjgZJ1vxIwj2uZnVX+6tJ4VKo4uwsbbW1c5i/KH
   nCTHiTZdLWvNaM4aed7HZ+cGfD/EgX5MaCag/VZLygH9Ju3AgVo78YrMR
   w==;
X-CSE-ConnectionGUID: zo2CLr0ETCib13Ok7Z3mdA==
X-CSE-MsgGUID: VAeO44cTQTWAPBYdi2fCFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323347"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323347"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:39 -0800
X-CSE-ConnectionGUID: x1J0eX0rQJGlOSis26xuxw==
X-CSE-MsgGUID: KVKHIqLgRbCkb+PIDKN7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785195"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 03/42] wifi: iwlwifi: mld: add file coex.h/c
Date: Sun, 16 Feb 2025 11:42:42 +0200
Message-Id: <20250216111648.810e180e09c2.I163d1196b1fcc31f553053a09dee86e5a5eb37c2@changeid>
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

this file is handling BT Coex

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/coex.c | 40 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/coex.h | 15 +++++++
 2 files changed, 55 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/coex.c b/drivers/net/wireless/intel/iwlwifi/mld/coex.c
new file mode 100644
index 000000000000..5f262bd43f21
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/coex.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include "fw/api/coex.h"
+
+#include "coex.h"
+#include "mld.h"
+#include "hcmd.h"
+#include "mlo.h"
+
+int iwl_mld_send_bt_init_conf(struct iwl_mld *mld)
+{
+	struct iwl_bt_coex_cmd cmd = {
+		.mode = cpu_to_le32(BT_COEX_NW),
+		.enabled_modules = cpu_to_le32(BT_COEX_MPLUT_ENABLED |
+					       BT_COEX_HIGH_BAND_RET),
+	};
+
+	return iwl_mld_send_cmd_pdu(mld, BT_CONFIG, &cmd);
+}
+
+void iwl_mld_handle_bt_coex_notif(struct iwl_mld *mld,
+				  struct iwl_rx_packet *pkt)
+{
+	const struct iwl_bt_coex_profile_notif *notif = (void *)pkt->data;
+	const struct iwl_bt_coex_profile_notif zero_notif = {};
+	/* zeroed structure means that BT is OFF */
+	bool bt_is_active = memcmp(notif, &zero_notif, sizeof(*notif));
+
+	if (bt_is_active == mld->bt_is_active)
+		return;
+
+	IWL_DEBUG_INFO(mld, "BT was turned %s\n", bt_is_active ? "ON" : "OFF");
+
+	mld->bt_is_active = bt_is_active;
+
+	iwl_mld_emlsr_check_bt(mld);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/coex.h b/drivers/net/wireless/intel/iwlwifi/mld/coex.h
new file mode 100644
index 000000000000..a77c5dc9613c
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/coex.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_coex_h__
+#define __iwl_mld_coex_h__
+
+#include "mld.h"
+
+int iwl_mld_send_bt_init_conf(struct iwl_mld *mld);
+
+void iwl_mld_handle_bt_coex_notif(struct iwl_mld *mld,
+				  struct iwl_rx_packet *pkt);
+
+#endif /* __iwl_mld_coex_h__ */
-- 
2.34.1


