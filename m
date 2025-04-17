Return-Path: <linux-wireless+bounces-21652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB9CA91EC6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D80146465B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B024E4B2;
	Thu, 17 Apr 2025 13:53:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D224EA9C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898020; cv=none; b=KS8MLTzOcntCoKULohH10Ig3uWpkeEfwqKZHYTNs8aBiKVvNScUjCwtsXLWYONjzr+DvN1HrhTPABRTApL7+JxTWFBLN6NNz46mJpOMyo/Dqfdk3x2eBzL+fmhZT6pgF1QXs5gcDfvhXuIHMJgvVdPfHmhcP09FCLnv36Z+OuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898020; c=relaxed/simple;
	bh=seVdcN2f9FLehHM8iyNX8zksgZhOD1X2/Bgj52pP+ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t5kCS4XcbGg7svG+9D7rJo1Ml261CyjHi47lAOvR9k/09PdPy7t14tMAQSffwp9g50MEkkCj1vShu3s+9Dpj9OUApeBrK2GMPmbqLP9DY0i/W+YxmfqKa8wFIfg/zaMBjMTixfSEQSqESuqEDpDrwcSy2Xn8a5whLyIRgxp0wXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: CE6Z+OnnRYioRbDWXPLDzQ==
X-CSE-MsgGUID: x46zBHQWTdewixjEtYfEWw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:37 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 496684006DE8;
	Thu, 17 Apr 2025 22:53:33 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 12/38] ra6w: add dbgfs.c
Date: Thu, 17 Apr 2025 16:52:10 +0300
Message-Id: <20250417135236.52410-13-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/renesas/ra6w/dbgfs.c | 201 ++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/dbgfs.c

diff --git a/drivers/net/wireless/renesas/ra6w/dbgfs.c b/drivers/net/wireless/renesas/ra6w/dbgfs.c
new file mode 100644
index 000000000000..9c764feebe6d
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/dbgfs.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains debugfs handlers.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <net/cfg80211.h>
+
+#include "core.h"
+#include "cfg80211.h"
+#include "params.h"
+#include "dbg.h"
+#include "dbgfs.h"
+
+static ssize_t ra6w_dbgfs_stats_read(struct file *file,
+				     char __user *user_buf, size_t count, loff_t *ppos)
+{
+	const struct ra6w_cfg80211_priv *priv = file->private_data;
+	const struct ra6w_core_stat *tx = &priv->core->stats.tx;
+	const struct ra6w_core_stat *rx = &priv->core->stats.rx;
+	char *buf;
+	size_t n = 0;
+	size_t len = 256;
+	ssize_t ret = 0;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	n += scnprintf(&buf[n], len - n, "tx packets: %u\n", tx->packets);
+	n += scnprintf(&buf[n], len - n, "tx errors : %u\n", tx->err);
+	n += scnprintf(&buf[n], len - n, "rx packets: %u\n", rx->packets);
+	n += scnprintf(&buf[n], len - n, "rx errors : %u\n", rx->err);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, n);
+
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations ra6w_dbgfs_stats_ops = {
+	.read = ra6w_dbgfs_stats_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t ra6w_dbgfs_dev_info_read(struct file *file,
+					char __user *user_buf, size_t count, loff_t *ppos)
+{
+#define FSCNPRINTF(n, len, buf, NBIT, str)					\
+do {										\
+	bool set = test_bit(NBIT, &features);					\
+	(n) += scnprintf(&(buf)[n], (len) - (n), "%s : %d\n", str, set);	\
+} while (0)
+
+	struct ra6w_cfg80211_priv *priv = file->private_data;
+	struct ra6w_core *core = priv->core;
+	const struct ra6w_cmd_fw_ver_rsp *fw_ver = &core->sinfo.fw_ver;
+	unsigned long features;
+	char *buf;
+	size_t n = 0;
+	size_t len = count;
+	ssize_t ret = 0;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	n += scnprintf(&buf[n], len - n, "fw_version     : %s\n", core->sinfo.fw_version);
+	n += scnprintf(&buf[n], len - n, "machw_features : 0x%X\n",
+		       le32_to_cpu(fw_ver->machw_features));
+	n += scnprintf(&buf[n], len - n, "machw_version  : 0x%X\n",
+		       le32_to_cpu(fw_ver->machw_version));
+	n += scnprintf(&buf[n], len - n, "phy_feature    : 0x%X\n",
+		       le32_to_cpu(fw_ver->phy_feature));
+	n += scnprintf(&buf[n], len - n, "phy_version    : 0x%X\n",
+		       le32_to_cpu(fw_ver->phy_version));
+	n += scnprintf(&buf[n], len - n, "dev features   : 0x%X:\n", fw_ver->features);
+
+	features = (unsigned long)le32_to_cpu(fw_ver->features);
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_BCN_BIT,              " BCN             ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_RADAR_BIT,            " RADAR           ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_PS_BIT,               " PS              ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_UAPSD_BIT,            " UAPSD           ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_AMPDU_BIT,            " AMPDU           ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_AMSDU_BIT,            " AMSDU           ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_P2P_BIT,              " P2P             ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_P2P_GO_BIT,           " P2P_GO          ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_UMAC_BIT,             " UMAC            ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_VHT_BIT,              " VHT             ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_BFMEE_BIT,            " BFMEE           ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_BFMER_BIT,            " BFMER           ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_WAPI_BIT,             " WAPI            ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_MFP_BIT,              " MFP             ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_MU_MIMO_RX_BIT,       " MU_MIMO_RX      ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_MU_MIMO_TX_BIT,       " MU_MIMO_TX      ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_MESH_BIT,             " MESH            ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_TDLS_BIT,             " TDLS            ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_ANT_DIV_BIT,          " ANT_DIV         ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_UF_BIT,               " UF              ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_AMSDU_MAX_SIZE_0_BIT, " AMSDU_MAX_SIZE_0");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_AMSDU_MAX_SIZE_1_BIT, " AMSDU_MAX_SIZE_1");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_HE_BIT,               " HE              ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_TWT_BIT,              " TWT             ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_FTM_INIT_BIT,         " FTM_INIT        ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_FAKE_FTM_RSP_BIT,     " FAKE_FTM_RSP    ");
+	FSCNPRINTF(n, len, buf, RA6W_DEV_FEAT_HW_LLCSNAP_INS_BIT,   " HW_LLCSNAP_INS  ");
+
+	n += scnprintf(&buf[n], len - n, "max sta        : %u\n", le16_to_cpu(fw_ver->max_sta_nb));
+	n += scnprintf(&buf[n], len - n, "max vif        : %u\n", fw_ver->max_vif_nb);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, n);
+
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations ra6w_dbgfs_dev_info_ops = {
+	.read = ra6w_dbgfs_dev_info_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t ra6w_dbgfs_mac_info_read(struct file *file,
+					char __user *user_buf, size_t count, loff_t *ppos)
+{
+#define FSCNPRINTF(n, len, buf, NBIT, str)					\
+do {										\
+	bool set = test_bit(NBIT, &features);					\
+	(n) += scnprintf(&(buf)[n], (len) - (n), "%s : %d\n", str, set);	\
+} while (0)
+
+	struct ra6w_cfg80211_priv *priv = file->private_data;
+	struct ra6w_core *core = priv->core;
+	struct ra6w_sys_info *sinfo = &core->sinfo;
+	u32 mac_feat = le32_to_cpu(sinfo->fw_ver.machw_features);
+	unsigned long features = (unsigned long)mac_feat;
+	char *buf;
+	size_t n = 0;
+	size_t len = count;
+	ssize_t ret = 0;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	n += scnprintf(&buf[n], len - n, "mac features: 0x%X:\n", mac_feat);
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_QOS_BIT,        " QOS       ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_EDCA_BIT,       " EDCA      ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_SME_BIT,        " SME       ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_SECURITY_BIT,   " SECURITY  ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_TKIP_BIT,       " TKIP      ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_CCMP_BIT,       " CCMP      ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_RCE_BIT,        " RCE       ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_GCMP_BIT,       " GCMP      ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_HT_BIT,         " HT        ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_VHT_BIT,        " VHT       ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_TPC_BIT,        " TPC       ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_WAPI_BIT,       " WAPI      ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_COEX_BIT,       " COEX      ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_HE_BIT,         " HE        ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_BFMEE_BIT,      " BFMEE     ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_BFMER_BIT,      " BFMER     ");
+	FSCNPRINTF(n, len, buf, RA6W_MAC_FEAT_MU_MIMO_TX_BIT, " MU_MIMO_TX");
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, n);
+
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations ra6w_dbgfs_mac_info_ops = {
+	.read = ra6w_dbgfs_mac_info_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+void ra6w_dbgfs_register(struct ra6w_cfg80211_priv *priv)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir(KBUILD_MODNAME, priv->wiphy->debugfsdir);
+	priv->root = root;
+
+	debugfs_create_file("stats", 0600, root, priv, &ra6w_dbgfs_stats_ops);
+	debugfs_create_file("dev_info", 0600, root, priv, &ra6w_dbgfs_dev_info_ops);
+	debugfs_create_file("mac_info", 0600, root, priv, &ra6w_dbgfs_mac_info_ops);
+	debugfs_create_u32("log_level", 0600, root, &ra6w_params_list.module_params.log_level);
+}
+
+void ra6w_dbgfs_deregister(struct ra6w_cfg80211_priv *priv)
+{
+	debugfs_remove_recursive(priv->root);
+	priv->root = NULL;
+}
-- 
2.17.1


