Return-Path: <linux-wireless+bounces-30776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE8D1B424
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5243130A650E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00CA2FDC35;
	Tue, 13 Jan 2026 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="CVPnPxDe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A12BCF6C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336757; cv=none; b=JiFUEMQNYp724K8OF0GP+kDXoNsc+pOhQsQ0Gf0MBABP0QHAtQIVBL3d9ZVkXhRYF+sIsxPy6nzGgjv+0Wowk1Hw6xPF0e5rtseMAyd7/5gPDX0kzSXHBhDuhNbhM3Bzfrtaz+Ko30h/ffpZnOgUJLwmwMOLZVPWLTKpdpfhEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336757; c=relaxed/simple;
	bh=Xn/63MUPGw7xsj33YZBMDRlwCEGJwgPaMAhnszNpq5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CavmUtSyONmvPPE4obIo5TDNs1PVmArPKEZm3q6hCEjSfzluB+08rfX9wczjVD7tGKJQnMLoi3pc7MDhchgdsy+DWtEzH2TNVit/Hr25WWWUKAhU1/+bvSEfDFoyV8jaI7m1WHk/vGlvzAWucZzLDXOQJj15jy1wstosQl0QDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=CVPnPxDe; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336756; x=1799872756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xn/63MUPGw7xsj33YZBMDRlwCEGJwgPaMAhnszNpq5E=;
  b=CVPnPxDeQA2kqPOKgGBpmIoUu3U4mkaTx0VHQH4h6Mu7A0V7BALBqgyl
   fyiS4OKRShcbogROstOMnPtepLgXMWb+wAmDdnkExSLFXS7GwWX4zp0au
   xctPYRSYw2utBa/giIZQ3vTdkkGCyDcYGpOBG29BFx0yVzOAq/pb+D9xl
   w=;
X-CSE-ConnectionGUID: ODINrONhRHSqpAkhdOmuUw==
X-CSE-MsgGUID: 7oU1alYQTJunjbsuSlfGqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568476"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568476"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:39:12 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:39:11 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:39:09 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 21/34] wifi: inffmac: add feature.c/h
Date: Wed, 14 Jan 2026 02:03:34 +0530
Message-ID: <20260113203350.16734-22-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation to detect and maintain the feature capabilities of
the currently loaded Device firmware. All other driver source files
utilizes these firmware feature flags for finding if the firmware is
supporting a specific operation or functionality.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/feature.c   | 319 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/feature.h   | 129 +++++++
 2 files changed, 448 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/feature.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/feature.h

diff --git a/drivers/net/wireless/infineon/inffmac/feature.c b/drivers/net/wireless/infineon/inffmac/feature.c
new file mode 100644
index 000000000000..6a686f03455f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/feature.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/module.h>
+
+#include "main.h"
+#include "debug.h"
+#include "dev_cmd.h"
+#include "feature.h"
+#include "bus_proto.h"
+#include "twt.h"
+
+static const char * const inff_feat_names[] = {
+	"MBSS",
+	"MCHAN",
+	"RSV2",
+	"WOWL",
+	"P2P",
+	"RSDB",
+	"RSV6",
+	"SCAN_RANDOM_MAC",
+	"WOWL_ND",
+	"WOWL_GTK",
+	"WOWL_ARP_ND",
+	"MFP",
+	"GSCAN",
+	"FWSUP",
+	"RSV14",
+	"RSV15",
+	"RSV16",
+	"RSV17",
+	"DOT11H",
+	"SAE",
+	"FWAUTH",
+	"DUMP_OBSS",
+	"SCAN_V2",
+	"PMKID_V2",
+	"PMKID_V3",
+	"SURVEY_DUMP",
+	"SAE_EXT",
+	"FBT",
+	"OKC",
+	"GCMP",
+	"TWT",
+	"RSV31",
+	"ULP",
+	"PROPTXSTATUS",
+	"OWE",
+	"RSV35",
+	"FTM",
+	"GTKO",
+	"MCHAN_CONFIG",
+	"RSV39",
+	"LAST"
+};
+
+struct inff_feat_fwcap {
+	enum inff_feat_id feature;
+	const char * const fwcap_id;
+};
+
+static const struct inff_feat_fwcap inff_fwcap_map[] = {
+	{ INFF_FEAT_MBSS, "mbss" },
+	{ INFF_FEAT_MCHAN, "mchan" },
+	{ INFF_FEAT_P2P, "p2p" },
+	{ INFF_FEAT_DOT11H, "802.11h" },
+	{ INFF_FEAT_SAE, "sae " },
+	{ INFF_FEAT_FWAUTH, "idauth" },
+	{ INFF_FEAT_SAE_EXT, "sae_ext " },
+	{ INFF_FEAT_FBT, "fbt " },
+	{ INFF_FEAT_OKC, "okc" },
+	{ INFF_FEAT_GCMP, "gcmp" },
+	{ INFF_FEAT_ULP, "ulp" },
+	{ INFF_FEAT_PROPTXSTATUS, "proptxstatus" },
+	{ INFF_FEAT_OWE, "owe" },
+	{ INFF_FEAT_FTM, "ftm" },
+	{ INFF_FEAT_GTKO, "gtko" },
+	{ INFF_FEAT_MCHAN_CONFIG, "mchan_config" },
+};
+
+#ifdef DEBUG
+static const char * const inff_quirk_names[] = {
+	"QUIRK_AUTO_AUTH",
+	"QUIRK_NEED_MPC",
+	"QUIRK_LAST"
+};
+
+/**
+ * inff_feat_debugfs_read() - expose feature info to debugfs.
+ *
+ * @seq: sequence for debugfs entry.
+ * @data: raw data pointer.
+ */
+static int inff_feat_debugfs_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	u8 feats[DIV_ROUND_UP(INFF_FEAT_LAST, 8)] = {0};
+	u32 quirks = bus_if->drvr->chip_quirks;
+	int id, i;
+	u8 size = INFF_FEAT_LAST / 8;
+
+	memcpy(feats, bus_if->drvr->feat_flags, sizeof(feats));
+
+	seq_puts(seq, "Features: ");
+	for (i = 0; i < size; i++)
+		seq_printf(seq, "%02x", feats[i]);
+	seq_puts(seq, "\n");
+
+	for (id = 0; id < INFF_FEAT_LAST; id++)
+		if (feats[id / 8] & BIT(id % 8))
+			seq_printf(seq, "\t%s\n", inff_feat_names[id]);
+
+	seq_printf(seq, "\nQuirks:   %08x\n", quirks);
+	for (id = 0; id < INFF_FEAT_QUIRK_LAST; id++)
+		if (quirks & BIT(id))
+			seq_printf(seq, "\t%s\n", inff_quirk_names[id]);
+	return 0;
+}
+#else
+static int inff_feat_debugfs_read(struct seq_file *seq, void *data)
+{
+	return 0;
+}
+#endif /* DEBUG */
+
+struct inff_feat_wlcfeat {
+	u16 min_ver_major;
+	u16 min_ver_minor;
+	u32 feat_flags;
+};
+
+static const struct inff_feat_wlcfeat inff_feat_wlcfeat_map[] = {
+	{ 12, 0, BIT(INFF_FEAT_PMKID_V2) },
+	{ 13, 0, BIT(INFF_FEAT_PMKID_V3) },
+};
+
+static void inff_feat_wlc_version_overrides(struct inff_pub *drv)
+{
+	struct inff_if *ifp = inff_get_ifp(drv, 0);
+	struct inff_wlc_version_le ver;
+	int err, major, minor;
+
+	err = inff_fwcmd_iovar_data_get(ifp, "wlc_ver", &ver, sizeof(ver));
+	if (err)
+		return;
+
+	major = le16_to_cpu(ver.wlc_ver_major);
+	minor = le16_to_cpu(ver.wlc_ver_minor);
+
+	inff_dbg(INFO, "WLC version: %d.%d\n", major, minor);
+}
+
+/**
+ * inff_feat_iovar_int_get() - determine feature through iovar query.
+ *
+ * @ifp: interface to query.
+ * @id: feature id.
+ * @name: iovar name.
+ */
+static void inff_feat_iovar_int_get(struct inff_if *ifp,
+				    enum inff_feat_id id, char *name)
+{
+	u32 data = 0;
+	int err;
+
+	/* we need to know firmware error */
+	ifp->fwil_fwerr = true;
+
+	err = inff_fwcmd_iovar_int_get(ifp, name, &data);
+	if (err != -INFF_FW_UNSUPPORTED) {
+		inff_dbg(INFO, "enabling feature: %s\n", inff_feat_names[id]);
+		ifp->drvr->feat_flags[id / 8] |= BIT(id % 8);
+	} else {
+		inff_dbg(TRACE, "%s feature check failed: %d\n",
+			 inff_feat_names[id], err);
+	}
+
+	ifp->fwil_fwerr = false;
+}
+
+static void inff_feat_iovar_enab_get(struct inff_if *ifp,
+				     enum inff_feat_id id, char *name,
+				     u16 subcmd_id)
+{
+	int err;
+	u8 val;
+
+	/* we need to know firmware error */
+	ifp->fwil_fwerr = true;
+
+	err = inff_fwcmd_xtlv_data_get(ifp, name, subcmd_id,
+				       (void *)&val, sizeof(val));
+
+	if (!err) {
+		inff_dbg(INFO, "enabling feature: %s\n", inff_feat_names[id]);
+		ifp->drvr->feat_flags[id / 8] |= BIT(id % 8);
+	} else {
+		inff_dbg(TRACE, "%s feature check failed: %d\n",
+			 inff_feat_names[id], err);
+	}
+
+	ifp->fwil_fwerr = false;
+}
+
+#define MAX_CAPS_BUFFER_SIZE	768
+static void inff_feat_firmware_capabilities(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	char caps[MAX_CAPS_BUFFER_SIZE];
+	enum inff_feat_id id;
+	int i, err;
+
+	err = inff_fwcmd_iovar_data_get(ifp, "cap", caps, sizeof(caps));
+	if (err) {
+		iphy_err(drvr, "could not get firmware cap (%d)\n", err);
+		return;
+	}
+
+	inff_dbg(INFO, "[ %s]\n", caps);
+
+	for (i = 0; i < ARRAY_SIZE(inff_fwcap_map); i++) {
+		if (strnstr(caps, inff_fwcap_map[i].fwcap_id, sizeof(caps))) {
+			id = inff_fwcap_map[i].feature;
+			inff_dbg(INFO, "enabling feature: %s\n",
+				 inff_feat_names[id]);
+			ifp->drvr->feat_flags[id / 8] |= BIT(id % 8);
+		}
+	}
+}
+
+/**
+ * inff_feat_fwcap_debugfs_read() - expose firmware capabilities to debugfs.
+ *
+ * @seq: sequence for debugfs entry.
+ * @data: raw data pointer.
+ */
+static int inff_feat_fwcap_debugfs_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	char caps[MAX_CAPS_BUFFER_SIZE + 1] = { };
+	char *tmp;
+	int err;
+
+	err = inff_fwcmd_iovar_data_get(ifp, "cap", caps, sizeof(caps));
+	if (err) {
+		iphy_err(drvr, "could not get firmware cap (%d)\n", err);
+		return err;
+	}
+
+	/* Put every capability in a new line */
+	for (tmp = caps; *tmp; tmp++) {
+		if (*tmp == ' ')
+			*tmp = '\n';
+	}
+
+	/* Usually there is a space at the end of capabilities string */
+	seq_printf(seq, "%s", caps);
+	/* So make sure we don't print two line breaks */
+	if (tmp > caps && *(tmp - 1) != '\n')
+		seq_puts(seq, "\n");
+
+	return 0;
+}
+
+void inff_feat_attach(struct inff_pub *drvr)
+{
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	u32 wowl_cap = 0;
+	s32 err;
+
+	inff_feat_firmware_capabilities(ifp);
+	if (drvr->bus_if->wowl_supported)
+		inff_feat_iovar_int_get(ifp, INFF_FEAT_WOWL, "wowl");
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_WOWL)) {
+		err = inff_fwcmd_iovar_int_get(ifp, "wowl_cap", &wowl_cap);
+		if (!err) {
+			ifp->drvr->feat_flags[INFF_FEAT_WOWL_ARP_ND / 8] |=
+				BIT(INFF_FEAT_WOWL_ARP_ND % 8);
+			if (wowl_cap & INFF_WOWL_GTK_FAILURE)
+				ifp->drvr->feat_flags[INFF_FEAT_WOWL_GTK / 8] |=
+					BIT(INFF_FEAT_WOWL_GTK % 8);
+		}
+	}
+
+	inff_feat_iovar_int_get(ifp, INFF_FEAT_RSDB, "rsdb_mode");
+	inff_feat_iovar_int_get(ifp, INFF_FEAT_MFP, "mfp");
+	inff_feat_iovar_int_get(ifp, INFF_FEAT_DUMP_OBSS, "dump_obss");
+	inff_feat_iovar_int_get(ifp, INFF_FEAT_SURVEY_DUMP, "cca_survey_dump");
+	inff_feat_iovar_int_get(ifp, INFF_FEAT_FWSUP, "sup_wpa");
+	inff_feat_iovar_int_get(ifp, INFF_FEAT_SCAN_V2, "scan_ver");
+	inff_feat_iovar_enab_get(ifp, INFF_FEAT_TWT, "twt", INFF_TWT_CMD_ENAB);
+
+	inff_feat_wlc_version_overrides(drvr);
+}
+
+void inff_feat_debugfs_create(struct inff_pub *drvr)
+{
+	inff_debugfs_add_entry(drvr, "features", inff_feat_debugfs_read);
+	inff_debugfs_add_entry(drvr, "fwcap", inff_feat_fwcap_debugfs_read);
+}
+
+bool inff_feat_is_enabled(struct inff_if *ifp, enum inff_feat_id id)
+{
+	return (ifp->drvr->feat_flags[id / 8] & BIT(id % 8));
+}
+
+bool inff_feat_is_quirk_enabled(struct inff_if *ifp,
+				enum inff_feat_quirk quirk)
+{
+	return (ifp->drvr->chip_quirks & BIT(quirk));
+}
diff --git a/drivers/net/wireless/infineon/inffmac/feature.h b/drivers/net/wireless/infineon/inffmac/feature.h
new file mode 100644
index 000000000000..adc7c370b067
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/feature.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FEATURE_H
+#define INFF_FEATURE_H
+
+/*
+ * Features:
+ *
+ * MBSS: multiple BSSID support (eg. guest network in AP mode).
+ * MCHAN: multi-channel for concurrent P2P.
+ * P2P: peer-to-peer
+ * RSDB: Real Simultaneous Dual Band
+ * SCAN_RANDOM_MAC: Random MAC during (net detect) scheduled scan.
+ * WOWL_ND: WOWL net detect (PNO)
+ * WOWL_GTK: WOWL GTK rekey failure detect
+ * WOWL_ARP_ND: ARP and Neighbor Discovery offload support during WOWL.
+ * MFP: 802.11w Management Frame Protection.
+ * GSCAN: enhanced scan offload feature.
+ * FWSUP: Firmware supplicant.
+ * DOT11H: firmware supports 802.11h
+ * SAE: simultaneous authentication of equals
+ * FWAUTH: Firmware authenticator
+ * DUMP_OBSS: Firmware has capable to dump obss info to support ACS
+ * SCAN_V2: Version 2 scan params
+ * SURVEY_DUMP: Firmware has capable to survey dump info
+ * SAE_EXT: SAE be handled by userspace supplicant
+ * GCMP: firmware has defined GCMP or not.
+ * TWT: Firmware has the TWT Module Support.
+ * ULP: Firmware supports Ultra Low Power mode of operation.
+ * GTKO: GTK rekey offload.
+ */
+enum inff_feat_id {
+	INFF_FEAT_MBSS,
+	INFF_FEAT_MCHAN,
+	INFF_FEAT_RSV2,
+	INFF_FEAT_WOWL,
+	INFF_FEAT_P2P,
+	INFF_FEAT_RSDB,
+	INFF_FEAT_RSV6,
+	INFF_FEAT_SCAN_RANDOM_MAC,
+	INFF_FEAT_WOWL_ND,
+	INFF_FEAT_WOWL_GTK,
+	INFF_FEAT_WOWL_ARP_ND,
+	INFF_FEAT_MFP,
+	INFF_FEAT_GSCAN,
+	INFF_FEAT_FWSUP,
+	INFF_FEAT_RSV14,
+	INFF_FEAT_RSV15,
+	INFF_FEAT_RSV16,
+	INFF_FEAT_RSV17,
+	INFF_FEAT_DOT11H,
+	INFF_FEAT_SAE,
+	INFF_FEAT_FWAUTH,
+	INFF_FEAT_DUMP_OBSS,
+	INFF_FEAT_SCAN_V2,
+	INFF_FEAT_PMKID_V2,
+	INFF_FEAT_PMKID_V3,
+	INFF_FEAT_SURVEY_DUMP,
+	INFF_FEAT_SAE_EXT,
+	INFF_FEAT_FBT,
+	INFF_FEAT_OKC,
+	INFF_FEAT_GCMP,
+	INFF_FEAT_TWT,
+	INFF_FEAT_RSV31,
+	INFF_FEAT_ULP,
+	INFF_FEAT_PROPTXSTATUS,
+	INFF_FEAT_OWE,
+	INFF_FEAT_RSV35,
+	INFF_FEAT_FTM,
+	INFF_FEAT_GTKO,
+	INFF_FEAT_MCHAN_CONFIG,
+	INFF_FEAT_RSV39,
+	INFF_FEAT_LAST
+};
+
+/*
+ * Quirks:
+ *
+ * AUTO_AUTH: workaround needed for automatic authentication type.
+ * NEED_MPC: driver needs to disable MPC during scanning operation.
+ */
+enum inff_feat_quirk {
+	INFF_FEAT_QUIRK_AUTO_AUTH,
+	INFF_FEAT_QUIRK_NEED_MPC,
+	INFF_FEAT_QUIRK_LAST
+};
+
+/**
+ * inff_feat_attach() - determine features and quirks.
+ *
+ * @drvr: driver instance.
+ */
+void inff_feat_attach(struct inff_pub *drvr);
+
+/**
+ * inff_feat_debugfs_create() - create debugfs entries.
+ *
+ * @drvr: driver instance.
+ */
+void inff_feat_debugfs_create(struct inff_pub *drvr);
+
+/**
+ * inff_feat_is_enabled() - query feature.
+ *
+ * @ifp: interface instance.
+ * @id: feature id to check.
+ *
+ * Return: true is feature is enabled; otherwise false.
+ */
+bool inff_feat_is_enabled(struct inff_if *ifp, enum inff_feat_id id);
+
+/**
+ * inff_feat_is_quirk_enabled() - query chip quirk.
+ *
+ * @ifp: interface instance.
+ * @quirk: quirk id to check.
+ *
+ * Return: true is quirk is enabled; otherwise false.
+ */
+bool inff_feat_is_quirk_enabled(struct inff_if *ifp,
+				enum inff_feat_quirk quirk);
+
+#endif /* INFF_FEATURE_H */
-- 
2.25.1


