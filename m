Return-Path: <linux-wireless+bounces-18990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8296DA37386
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEAE3AAF22
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5121922E1;
	Sun, 16 Feb 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhoxySqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC0191F68
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699043; cv=none; b=MKSZ79AB851YZcKID/S/RusHgLWRNphUX2AVOUo/XIq4cr3zUN42LYxXfe4bHqzca70C8o3O5LxAJ/UaT9KRS7+GDpJCuqULXVJRAEKtR0/SYFGkTfHcYG0Aulm+o6CE93OBcLpErA6XgEI5Izwn9c6vvHW01jdcclg/yrLv+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699043; c=relaxed/simple;
	bh=g74WkMc3yArRL6TZRcqrmQqYAjW5bnHmbMRdFs6g7E8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5oxiIBSX+81IaPsh6+6vvdsadltDpPALVlERu3ooEI0FQ99B2ELobjZk3KyLDnr2qs9WGhvAfPbjeiCGlsPp6x3PBFvv+ow2ctBSUO/uarkP7jGTtCAsn77fuGiGJQrChqOPNv2aQFLe28Wtxa88HjxHev4c7rId9w+RrULWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhoxySqt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699042; x=1771235042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g74WkMc3yArRL6TZRcqrmQqYAjW5bnHmbMRdFs6g7E8=;
  b=LhoxySqtOcxzYwSPZW0hgHpwGUU5aYW0rDQPJdcCF86i4mGEMkwpxL6S
   NVaswdtjw6WkG58ljF09UhkwrIdLGrLufQNyXrs7sBoYb+92Og9gCuuRl
   CbH+jNTQAA4UaicjUeZZ6WUlzfJpHdKmnwthB3ac9MQoV7IW0tJ3zIYKG
   hblM/znIcJw/ej8A+Nw+CnO/Dba9haidWMKoQDC7Jo0RQG1YG1PLfAK0A
   CKo/fTYa3yINOdOhSmYIQ61O8fa0otWEY6FR1sPSjHtXKQaJKcDU57+8J
   aPufxbJhSp12x032SPibnB+d1Dyx+BkxayST0/5CnWzCjOLnJBjEjFT1S
   Q==;
X-CSE-ConnectionGUID: vpWBPFfKQtSVVzzWqUl2lA==
X-CSE-MsgGUID: lB3QCugUSAyRQTpnRPXVVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323396"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:01 -0800
X-CSE-ConnectionGUID: KXYILyf8T729VhLOX+NURA==
X-CSE-MsgGUID: +n8G8daTTUuM2lg8mZPvpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785248"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 20/42] wifi: iwlwifi: mld: add file phy.h/c
Date: Sun, 16 Feb 2025 11:42:59 +0200
Message-Id: <20250216111648.2de31d5cb201.I6ec4f5c6ed795e7866516f7669666504fb9f5208@changeid>
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

these fils are handling the driver-level chanctx object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/phy.c | 116 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h |  49 ++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
new file mode 100644
index 000000000000..c38f101628de
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#include <net/mac80211.h>
+
+#include "phy.h"
+#include "hcmd.h"
+#include "fw/api/phy-ctxt.h"
+
+int iwl_mld_allocate_fw_phy_id(struct iwl_mld *mld)
+{
+	int id;
+	unsigned long used = mld->used_phy_ids;
+
+	for_each_clear_bit(id, &used, NUM_PHY_CTX) {
+		mld->used_phy_ids |= BIT(id);
+		return id;
+	}
+
+	return -ENOSPC;
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_allocate_fw_phy_id);
+
+struct cfg80211_chan_def *
+iwl_mld_get_chandef_from_chanctx(struct ieee80211_chanctx_conf *ctx)
+{
+	bool use_def = cfg80211_channel_is_psc(ctx->def.chan) ||
+		(ctx->def.chan->band == NL80211_BAND_6GHZ &&
+		 ctx->def.width >= NL80211_CHAN_WIDTH_80);
+
+	return use_def ? &ctx->def : &ctx->min_def;
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_get_chandef_from_chanctx);
+
+static u8
+iwl_mld_nl80211_width_to_fw(enum nl80211_chan_width width)
+{
+	switch (width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		return IWL_PHY_CHANNEL_MODE20;
+	case NL80211_CHAN_WIDTH_40:
+		return IWL_PHY_CHANNEL_MODE40;
+	case NL80211_CHAN_WIDTH_80:
+		return IWL_PHY_CHANNEL_MODE80;
+	case NL80211_CHAN_WIDTH_160:
+		return IWL_PHY_CHANNEL_MODE160;
+	case NL80211_CHAN_WIDTH_320:
+		return IWL_PHY_CHANNEL_MODE320;
+	default:
+		WARN(1, "Invalid channel width=%u", width);
+		return IWL_PHY_CHANNEL_MODE20;
+	}
+}
+
+/* Maps the driver specific control channel position (relative to the center
+ * freq) definitions to the fw values
+ */
+u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef)
+{
+	int offs = chandef->chan->center_freq - chandef->center_freq1;
+	int abs_offs = abs(offs);
+	u8 ret;
+
+	if (offs == 0) {
+		/* The FW is expected to check the control channel position only
+		 * when in HT/VHT and the channel width is not 20MHz. Return
+		 * this value as the default one.
+		 */
+		return 0;
+	}
+
+	/* this results in a value 0-7, i.e. fitting into 0b0111 */
+	ret = (abs_offs - 10) / 20;
+	/* But we need the value to be in 0b1011 because 0b0100 is
+	 * IWL_PHY_CTRL_POS_ABOVE, so shift bit 2 up to land in
+	 * IWL_PHY_CTRL_POS_OFFS_EXT (0b1000)
+	 */
+	ret = (ret & IWL_PHY_CTRL_POS_OFFS_MSK) |
+	      ((ret & BIT(2)) << 1);
+	/* and add the above bit */
+	ret |= (offs > 0) * IWL_PHY_CTRL_POS_ABOVE;
+
+	return ret;
+}
+
+int iwl_mld_phy_fw_action(struct iwl_mld *mld,
+			  struct ieee80211_chanctx_conf *ctx, u32 action)
+{
+	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
+	struct cfg80211_chan_def *chandef = &phy->chandef;
+	struct iwl_phy_context_cmd cmd = {
+		.id_and_color = cpu_to_le32(phy->fw_id),
+		.action = cpu_to_le32(action),
+		.puncture_mask = cpu_to_le16(chandef->punctured),
+		/* Channel info */
+		.ci.channel = cpu_to_le32(chandef->chan->hw_value),
+		.ci.band = iwl_mld_nl80211_band_to_fw(chandef->chan->band),
+		.ci.width = iwl_mld_nl80211_width_to_fw(chandef->width),
+		.ci.ctrl_pos = iwl_mld_get_fw_ctrl_pos(chandef),
+	};
+	int ret;
+
+	if (ctx->ap.chan) {
+		cmd.sbb_bandwidth =
+			iwl_mld_nl80211_width_to_fw(ctx->ap.width);
+		cmd.sbb_ctrl_channel_loc = iwl_mld_get_fw_ctrl_pos(&ctx->ap);
+	}
+
+	ret = iwl_mld_send_cmd_pdu(mld, PHY_CONTEXT_CMD, &cmd);
+	if (ret)
+		IWL_ERR(mld, "Failed to send PHY_CONTEXT_CMD ret = %d\n", ret);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.h b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
new file mode 100644
index 000000000000..0413f3c8a888
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_phy_h__
+#define __iwl_mld_phy_h__
+
+#include "mld.h"
+
+/**
+ * struct iwl_mld_phy - PHY configuration parameters
+ *
+ * @fw_id: fw id of the phy.
+ * @chandef: the last chandef that mac80211 configured the driver
+ *	with. Used to detect a no-op when the chanctx changes.
+ * @channel_load_by_us: channel load on this channel caused by
+ *	the NIC itself, as indicated by firmware
+ */
+struct iwl_mld_phy {
+	/* Add here fields that need clean up on hw restart */
+	struct_group(zeroed_on_hw_restart,
+		u8 fw_id;
+		struct cfg80211_chan_def chandef;
+	);
+	/* And here fields that survive a hw restart */
+	u32 channel_load_by_us;
+};
+
+static inline struct iwl_mld_phy *
+iwl_mld_phy_from_mac80211(struct ieee80211_chanctx_conf *channel)
+{
+	return (void *)channel->drv_priv;
+}
+
+/* Cleanup function for struct iwl_mld_phy, will be called in restart */
+static inline void
+iwl_mld_cleanup_phy(struct iwl_mld *mld, struct iwl_mld_phy *phy)
+{
+	CLEANUP_STRUCT(phy);
+}
+
+int iwl_mld_allocate_fw_phy_id(struct iwl_mld *mld);
+int iwl_mld_phy_fw_action(struct iwl_mld *mld,
+			  struct ieee80211_chanctx_conf *ctx, u32 action);
+struct cfg80211_chan_def *
+iwl_mld_get_chandef_from_chanctx(struct ieee80211_chanctx_conf *ctx);
+u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef);
+
+#endif /* __iwl_mld_phy_h__ */
-- 
2.34.1


