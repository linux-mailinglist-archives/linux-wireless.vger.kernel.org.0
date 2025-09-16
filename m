Return-Path: <linux-wireless+bounces-27397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFD5B7DC83
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7FC1C067C4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F132951F;
	Tue, 16 Sep 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="g8EwDOL6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835F329506
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061700; cv=none; b=elUI9N+ain8tf92iaUYqmjyAxkEFVOsf7djno4hkEYUGy6yNXhL6InP2lUBln4whRxHgrhYah/Ux+VZK0qTxaBtZYwk7NFQtWe1RCMLUioOqsSKZLDCBvo/9whMwbsQbse5IRjvkaR6iljSUxOJvPy5NpMOOQlcFv66HWFg62/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061700; c=relaxed/simple;
	bh=guHEGzfCGQPun3f4ck0BoI+vsi10wog1Hs0MqpIQS9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcAG0BC9Uek89CQbF4jaPWlmHkr4SlO8xlQheCX4pDCuXVGlHfDxAUuEYBUiBKjARQN9LO7OPUCGTXbDYziqaDR4kKdhSxQbht4seO459XYgOA+XMrkv6GQAwUCqiQM16fMLqwECUSjL/jUpmLYjFlNo/oosOHID1yGEMoHSrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=g8EwDOL6; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061698; x=1789597698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guHEGzfCGQPun3f4ck0BoI+vsi10wog1Hs0MqpIQS9A=;
  b=g8EwDOL6Ln2gXwtTdar5TnIYG5eHVEM3wZCaLc6P+xEqWOKjPc4IkrbL
   sIAABAkkno4q6Ad/2cdPygxSfNCurZpYPXwWB9zAIESyk6j5j0NLRGobV
   YbYziDQYhAl3Jv3PzUde0ELfEADzrK9tFGGgBsChZBdFcm75P9qslzeNO
   Q=;
X-CSE-ConnectionGUID: L1jPrjQzSaSYJFuW3Ko63w==
X-CSE-MsgGUID: HXWbtG48TO298zHEw6/yGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294231"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294231"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:28:14 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:28:13 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:28:10 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 42/57] wifi: inffmac: add common.c/h
Date: Wed, 17 Sep 2025 03:48:02 +0530
Message-ID: <20250916221821.4387-48-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

Driver main file to initialize and De-initialize the Kernel module in the
kernel. Also maintains some of the common module param registrations.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/common.c    | 765 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/common.h    | 140 ++++
 2 files changed, 905 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/common.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/common.h

diff --git a/drivers/net/wireless/infineon/inffmac/common.c b/drivers/net/wireless/infineon/inffmac/common.c
new file mode 100644
index 000000000000..d4cbb8b5bb12
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/common.c
@@ -0,0 +1,765 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/reboot.h>
+#include <linux/notifier.h>
+
+#include "chanspec.h"
+#include "utils.h"
+#include "core.h"
+#include "bus.h"
+#include "debug.h"
+#include "fwil.h"
+#include "fwil_types.h"
+#include "tracepoint.h"
+#include "common.h"
+#include "firmware.h"
+#include "dfu.h"
+#include "chip.h"
+#include "defs.h"
+#include "fweh.h"
+#include "hw_ids.h"
+#include "pcie.h"
+#include "sdio.h"
+#include "offload.h"
+
+MODULE_AUTHOR("Infineon Technologies AG");
+MODULE_DESCRIPTION("Infineon 802.11 wireless LAN fullmac driver.");
+MODULE_LICENSE("Dual BSD/GPL");
+
+#define INFF_DEFAULT_SCAN_CHANNEL_TIME	40
+#define INFF_DEFAULT_SCAN_UNASSOC_TIME	40
+
+/* default boost value for RSSI_DELTA in preferred join selection */
+#define INFF_JOIN_PREF_RSSI_BOOST	8
+
+#define INFF_DEFAULT_TXGLOM_SIZE	32  /* max tx frames in glom chain */
+
+static int inff_sdiod_txglomsz = INFF_DEFAULT_TXGLOM_SIZE;
+module_param_named(txglomsz, inff_sdiod_txglomsz, int, 0);
+MODULE_PARM_DESC(txglomsz, "Maximum tx packet chain size [SDIO]");
+
+/* Debug level configuration. See debug.h for bits, sysfs modifiable */
+int inff_msg_level;
+module_param_named(debug, inff_msg_level, int, 0600);
+MODULE_PARM_DESC(debug, "Level of debug output");
+
+static int inff_p2p_enable;
+module_param_named(p2pon, inff_p2p_enable, int, 0);
+MODULE_PARM_DESC(p2pon, "Enable legacy p2p management functionality");
+
+static u8 inff_feature_disable[INFF_MAX_FEATURE_BYTES] = {0};
+static int inff_feature_disable_size;
+module_param_array_named(feature_disable, inff_feature_disable, byte,
+			 &inff_feature_disable_size, 0644);
+MODULE_PARM_DESC(feature_disable, "Disable features (bitmap)");
+
+static char inff_firmware_path[INFF_FW_ALTPATH_LEN];
+module_param_string(alternative_fw_path, inff_firmware_path,
+		    INFF_FW_ALTPATH_LEN, 0400);
+MODULE_PARM_DESC(alternative_fw_path, "Alternative firmware path");
+
+static int inff_fcmode = 2;
+module_param_named(fcmode, inff_fcmode, int, 0);
+MODULE_PARM_DESC(fcmode, "Mode of firmware signalled flow control");
+
+static int inff_roamoff;
+module_param_named(roamoff, inff_roamoff, int, 0400);
+MODULE_PARM_DESC(roamoff,
+		 "Do not use fw roaming engine: 0=use fw_roam, 1=fw_roam off & report BCNLOST_MSG, 2=fw_roam off & report DISCONNECTED");
+
+static int inff_iapp_enable;
+module_param_named(iapp, inff_iapp_enable, int, 0);
+MODULE_PARM_DESC(iapp, "Enable partial support for the obsoleted Inter-Access Point Protocol");
+
+static int inff_eap_restrict;
+module_param_named(eap_restrict, inff_eap_restrict, int, 0400);
+MODULE_PARM_DESC(eap_restrict, "Block non-802.1X frames until auth finished");
+
+static int inff_max_pm;
+module_param_named(max_pm, inff_max_pm, int, 0);
+MODULE_PARM_DESC(max_pm, "Use max power management mode by default");
+
+int inff_pkt_prio_enable;
+module_param_named(pkt_prio, inff_pkt_prio_enable, int, 0);
+MODULE_PARM_DESC(pkt_prio, "Support for update the packet priority");
+
+#ifdef DEBUG
+/* always succeed inff_bus_started() */
+static int inff_ignore_probe_fail;
+module_param_named(ignore_probe_fail, inff_ignore_probe_fail, int, 0);
+MODULE_PARM_DESC(ignore_probe_fail, "always succeed probe for debugging");
+#endif
+
+static int inff_fw_ap_select;
+module_param_named(fw_ap_select, inff_fw_ap_select, int, 0400);
+MODULE_PARM_DESC(fw_ap_select, "Allow FW for AP selection");
+
+static int inff_disable_6ghz;
+module_param_named(disable_6ghz, inff_disable_6ghz, int, 0400);
+MODULE_PARM_DESC(disable_6ghz, "Disable 6GHz Operation");
+
+static int inff_sdio_in_isr;
+module_param_named(sdio_in_isr, inff_sdio_in_isr, int, 0400);
+MODULE_PARM_DESC(sdio_in_isr, "Handle SDIO DPC in ISR");
+
+static int inff_sdio_rxf_in_kthread;
+module_param_named(sdio_rxf_thread, inff_sdio_rxf_in_kthread, int, 0400);
+MODULE_PARM_DESC(sdio_rxf_thread, "SDIO RX Frame in Kthread");
+
+static int inff_bt_over_sdio;
+module_param_named(bt_over_sdio, inff_bt_over_sdio, int, 0);
+MODULE_PARM_DESC(bt_over_sdio, "Enable BT over SDIO");
+
+static int inff_sdio_idleclk_disable = INFFMAC_AUTO;
+module_param_named(sdio_idleclk_disable, inff_sdio_idleclk_disable, int, 0644);
+MODULE_PARM_DESC(sdio_idleclk_disable, "Disable SDIO idle clock");
+
+static int inff_sdio_bus_idle_time = INFF_DEFAULT_SDIO_IDLE_CONFIG;
+module_param_named(bus_idle_time, inff_sdio_bus_idle_time, int, 0644);
+MODULE_PARM_DESC(bus_idle_time, "Config SDIO bus idle time");
+
+static int inff_short_psq;
+module_param_named(short_psq, inff_short_psq, int, 0);
+MODULE_PARM_DESC(short_psq, "Use shorter PS Queue");
+
+static int inff_tx_cpu = -1;
+module_param_named(tx_cpu, inff_tx_cpu, int, 0644);
+MODULE_PARM_DESC(tx_cpu, "CPU affinity for TX");
+
+static int inff_napi_cpu = -1;
+module_param_named(napi_cpu, inff_napi_cpu, int, 0644);
+MODULE_PARM_DESC(napi_cpu, "CPU affinity for NAPI");
+
+static int inff_napi_enable;
+module_param_named(napi_enable, inff_napi_enable, int, 0644);
+MODULE_PARM_DESC(napi_enable, "Enable NAPI");
+
+static int inff_commonring_depth[5] = {0};
+module_param_array_named(commonring_depth, inff_commonring_depth,
+			 int, NULL, 0644);
+MODULE_PARM_DESC(commonring_depth, "PCIe commonrings (CTRL SUB, RXPOST SUB, CTRL CMPL, TX CMPL, RX CMPL) depth");
+
+static int inff_flowring_depth;
+module_param_named(flowring_depth, inff_flowring_depth, int, 0644);
+MODULE_PARM_DESC(flowring_depth, "PCIe flowrings TX SUB depth");
+
+static int inff_logring_depth = INFF_LOGRING_DEPTH_DEFAULT;
+module_param_named(logring_depth, inff_logring_depth, int, 0);
+MODULE_PARM_DESC(logring_depth, "Debug log ring depth");
+
+static int inff_logger_level = INFF_LOGGER_LEVEL_DEFAULT;
+module_param_named(logger_level, inff_logger_level, int, 0);
+MODULE_PARM_DESC(logger_level, "Debug logger level");
+
+static int inff_reboot_callback(struct notifier_block *this, unsigned long code, void *unused);
+static struct notifier_block inff_reboot_notifier = {
+	.notifier_call = inff_reboot_callback,
+	.priority = 1,
+};
+
+void inff_c_set_joinpref_default(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_join_pref_params join_pref_params[2];
+	int err;
+
+	/* Setup join_pref to select target by RSSI (boost on 5GHz) */
+	join_pref_params[0].type = INFF_JOIN_PREF_RSSI_DELTA;
+	join_pref_params[0].len = 2;
+	join_pref_params[0].rssi_gain = INFF_JOIN_PREF_RSSI_BOOST;
+	join_pref_params[0].band = WLC_BAND_5G;
+
+	join_pref_params[1].type = INFF_JOIN_PREF_RSSI;
+	join_pref_params[1].len = 2;
+	join_pref_params[1].rssi_gain = 0;
+	join_pref_params[1].band = 0;
+	err = inff_fil_iovar_data_set(ifp, "join_pref", join_pref_params,
+				      sizeof(join_pref_params));
+	if (err)
+		iphy_err(drvr, "Set join_pref error (%d)\n", err);
+}
+
+static int inff_c_download(struct inff_if *ifp, u16 flag,
+			   struct inff_dload_data_le *dload_buf,
+			   u32 len)
+{
+	s32 err;
+
+	flag |= (DLOAD_HANDLER_VER << DLOAD_FLAG_VER_SHIFT);
+	dload_buf->flag = cpu_to_le16(flag);
+	dload_buf->dload_type = cpu_to_le16(DL_TYPE_CLM);
+	dload_buf->len = cpu_to_le32(len);
+	dload_buf->crc = cpu_to_le32(0);
+
+	err = inff_fil_iovar_data_set(ifp, "clmload", dload_buf,
+				      struct_size(dload_buf, data, len));
+
+	return err;
+}
+
+static int inff_c_process_clm_blob(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_bus *bus = drvr->bus_if;
+	struct inff_dload_data_le *chunk_buf;
+	const struct firmware *clm = NULL;
+	u32 chunk_len;
+	u32 datalen;
+	u32 cumulative_len;
+	u16 dl_flag = DL_BEGIN;
+	u32 status;
+	s32 err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	err = inff_bus_get_blob(bus, &clm, INFF_BLOB_CLM);
+	if (err || !clm) {
+		inff_info("no clm_blob available (err=%d), device may have limited channels available\n",
+			  err);
+		return 0;
+	}
+
+	chunk_buf = kzalloc(struct_size(chunk_buf, data, MAX_CHUNK_LEN),
+			    GFP_KERNEL);
+	if (!chunk_buf) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	datalen = clm->size;
+	cumulative_len = 0;
+	do {
+		if (datalen > MAX_CHUNK_LEN) {
+			chunk_len = MAX_CHUNK_LEN;
+		} else {
+			chunk_len = datalen;
+			dl_flag |= DL_END;
+		}
+		memcpy(chunk_buf->data, clm->data + cumulative_len, chunk_len);
+
+		err = inff_c_download(ifp, dl_flag, chunk_buf, chunk_len);
+
+		dl_flag &= ~DL_BEGIN;
+
+		cumulative_len += chunk_len;
+		datalen -= chunk_len;
+	} while ((datalen > 0) && (err == 0));
+
+	if (err) {
+		iphy_err(drvr, "clmload (%zu byte file) failed (%d)\n",
+			 clm->size, err);
+		/* Retrieve clmload_status and print */
+		err = inff_fil_iovar_int_get(ifp, "clmload_status", &status);
+		if (err)
+			iphy_err(drvr, "get clmload_status failed (%d)\n", err);
+		else
+			inff_dbg(INFO, "clmload_status=%d\n", status);
+		err = -EIO;
+	}
+
+	kfree(chunk_buf);
+done:
+	release_firmware(clm);
+	return err;
+}
+
+int inff_c_set_cur_etheraddr(struct inff_if *ifp, const u8 *addr)
+{
+	s32 err;
+
+	err = inff_fil_iovar_data_set(ifp, "cur_etheraddr", addr, ETH_ALEN);
+	if (err < 0)
+		iphy_err(ifp->drvr, "Setting cur_etheraddr failed, %d\n", err);
+
+	return err;
+}
+
+/* On some boards there is no eeprom to hold the nvram, in this case instead
+ * a board specific nvram is loaded from /lib/firmware. On most boards the
+ * macaddr setting in the /lib/firmware nvram file is ignored because the
+ * wifibt chip has a unique MAC programmed into the chip itself.
+ * But in some cases the actual MAC from the /lib/firmware nvram file gets
+ * used, leading to MAC conflicts.
+ * The MAC addresses in the troublesome nvram files seem to all come from
+ * the same nvram file template, so we only need to check for 1 known
+ * address to detect this.
+ */
+static const u8 inff_default_mac_address[ETH_ALEN] = {
+	0x00, 0x90, 0x4c, 0xc5, 0x12, 0x38
+};
+
+int inff_c_preinit_dcmds(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s8 eventmask[INFF_EVENTING_MASK_LEN];
+	u8 buf[INFF_DCMD_SMLEN];
+	struct inff_bus *bus;
+	struct inff_rev_info_le revinfo;
+	struct inff_rev_info *ri;
+	struct inff_wlc_version_le wlc_ver;
+	char *clmver;
+	char *ptr;
+	s32 err;
+	struct eventmsgs_ext *eventmask_msg = NULL;
+	u8 msglen;
+
+	if (is_valid_ether_addr(ifp->mac_addr)) {
+		/* set mac address */
+		err = inff_c_set_cur_etheraddr(ifp, ifp->mac_addr);
+		if (err < 0)
+			goto done;
+	} else {
+		/* retrieve mac address */
+		err = inff_fil_iovar_data_get(ifp, "cur_etheraddr", ifp->mac_addr,
+					      sizeof(ifp->mac_addr));
+		if (err < 0) {
+			iphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
+			goto done;
+		}
+
+		if (ether_addr_equal_unaligned(ifp->mac_addr, inff_default_mac_address)) {
+			iphy_err(drvr, "Default MAC is used, replacing with random MAC to avoid conflicts\n");
+			eth_random_addr(ifp->mac_addr);
+			ifp->ndev->addr_assign_type = NET_ADDR_RANDOM;
+			err = inff_c_set_cur_etheraddr(ifp, ifp->mac_addr);
+			if (err < 0)
+				goto done;
+		}
+	}
+
+	memcpy(ifp->drvr->mac, ifp->mac_addr, sizeof(ifp->drvr->mac));
+	memcpy(ifp->drvr->wiphy->perm_addr, ifp->drvr->mac, ETH_ALEN);
+
+	bus = ifp->drvr->bus_if;
+	ri = &ifp->drvr->revinfo;
+
+	err = inff_fil_cmd_data_get(ifp, INFF_C_GET_REVINFO,
+				    &revinfo, sizeof(revinfo));
+	if (err < 0) {
+		iphy_err(drvr, "retrieving revision info failed, %d\n", err);
+		strscpy(ri->chipname, "UNKNOWN", sizeof(ri->chipname));
+	} else {
+		ri->vendorid = le32_to_cpu(revinfo.vendorid);
+		ri->deviceid = le32_to_cpu(revinfo.deviceid);
+		ri->radiorev = le32_to_cpu(revinfo.radiorev);
+		ri->corerev = le32_to_cpu(revinfo.corerev);
+		ri->boardid = le32_to_cpu(revinfo.boardid);
+		ri->boardvendor = le32_to_cpu(revinfo.boardvendor);
+		ri->boardrev = le32_to_cpu(revinfo.boardrev);
+		ri->driverrev = le32_to_cpu(revinfo.driverrev);
+		ri->ucoderev = le32_to_cpu(revinfo.ucoderev);
+		ri->bus = le32_to_cpu(revinfo.bus);
+		ri->phytype = le32_to_cpu(revinfo.phytype);
+		ri->phyrev = le32_to_cpu(revinfo.phyrev);
+		ri->anarev = le32_to_cpu(revinfo.anarev);
+		ri->chippkg = le32_to_cpu(revinfo.chippkg);
+		ri->nvramrev = le32_to_cpu(revinfo.nvramrev);
+
+		/* use revinfo if not known yet */
+		if (!bus->chip) {
+			bus->chip = le32_to_cpu(revinfo.chipnum);
+			bus->chiprev = le32_to_cpu(revinfo.chiprev);
+		}
+	}
+	ri->result = err;
+
+	if (bus->chip)
+		inff_chip_name(bus->chip, bus->chiprev,
+			       ri->chipname, sizeof(ri->chipname));
+
+	/* Do any CLM downloading */
+	err = inff_c_process_clm_blob(ifp);
+	if (err < 0) {
+		iphy_err(drvr, "download CLM blob file failed, %d\n", err);
+		goto done;
+	}
+
+	/* query for 'ver' to get version info from firmware */
+	memset(buf, 0, sizeof(buf));
+	err = inff_fil_iovar_data_get(ifp, "ver", buf, sizeof(buf));
+	if (err < 0) {
+		iphy_err(drvr, "Retrieving version information failed, %d\n",
+			 err);
+		goto done;
+	}
+	buf[sizeof(buf) - 1] = '\0';
+	ptr = (char *)buf;
+	strsep(&ptr, "\n");
+
+	/* Print fw version info */
+	inff_info("Firmware: %s %s\n", ri->chipname, buf);
+
+	/* locate firmware version number for ethtool */
+	ptr = strrchr(buf, ' ');
+	if (!ptr) {
+		iphy_err(drvr, "Retrieving version number failed");
+		goto done;
+	}
+	strscpy(ifp->drvr->fwver, ptr + 1, sizeof(ifp->drvr->fwver));
+
+	/* Get wlc interface version, set to 0 for legacy chip
+	 * that is not supporting wlc_ver iovar
+	 */
+	err = inff_fil_iovar_data_get(ifp, "wlc_ver", &wlc_ver, sizeof(wlc_ver));
+	if (err < 0) {
+		ifp->drvr->wlc_ver.wlc_ver_major = 0;
+		ifp->drvr->wlc_ver.wlc_ver_minor = 0;
+	} else {
+		ifp->drvr->wlc_ver.wlc_ver_major = le16_to_cpu(wlc_ver.wlc_ver_major);
+		ifp->drvr->wlc_ver.wlc_ver_minor = le16_to_cpu(wlc_ver.wlc_ver_minor);
+	}
+	inff_dbg(TRACE, "wlc interface version, major=%d, minor=%d\n",
+		 ifp->drvr->wlc_ver.wlc_ver_major,
+		 ifp->drvr->wlc_ver.wlc_ver_minor);
+
+	/* Query for 'clmver' to get CLM version info from firmware */
+	memset(buf, 0, sizeof(buf));
+	err = inff_fil_iovar_data_get(ifp, "clmver", buf, sizeof(buf));
+	if (err) {
+		inff_dbg(TRACE, "retrieving clmver failed, %d\n", err);
+	} else {
+		buf[sizeof(buf) - 1] = '\0';
+		clmver = (char *)buf;
+
+		/* Replace all newline/linefeed characters with space
+		 * character
+		 */
+		strreplace(clmver, '\n', ' ');
+
+		/* store CLM version for adding it to revinfo debugfs file */
+		memcpy(ifp->drvr->clmver, clmver, sizeof(ifp->drvr->clmver));
+
+		inff_dbg(INFO, "CLM version = %s\n", clmver);
+	}
+
+	/* set apsta */
+	err = inff_fil_iovar_int_set(ifp, "apsta", 1);
+	if (err)
+		inff_info("failed setting apsta, %d\n", err);
+
+	/* set mpc */
+	err = inff_fil_iovar_int_set(ifp, "mpc", 1);
+	if (err) {
+		iphy_err(drvr, "failed setting mpc\n");
+		goto done;
+	}
+
+	inff_c_set_joinpref_default(ifp);
+
+	/* Setup event_msgs, enable E_IF */
+	err = inff_fil_iovar_data_get(ifp, "event_msgs", eventmask,
+				      INFF_EVENTING_MASK_LEN);
+	if (err) {
+		iphy_err(drvr, "Get event_msgs error (%d)\n", err);
+		goto done;
+	}
+	setbit(eventmask, INFF_E_IF);
+	err = inff_fil_iovar_data_set(ifp, "event_msgs", eventmask,
+				      INFF_EVENTING_MASK_LEN);
+	if (err) {
+		iphy_err(drvr, "Set event_msgs error (%d)\n", err);
+		goto done;
+	}
+
+	/* Enable event_msg_ext specific to 43022 chip */
+	if (bus->chip == INF_CC_43022_CHIP_ID) {
+		/* Program event_msg_ext to support event larger than 128 */
+		msglen = (roundup(INFF_E_LAST, NBBY) / NBBY) +
+				  EVENTMSGS_EXT_STRUCT_SIZE;
+		/* Allocate buffer for eventmask_msg */
+		eventmask_msg = kzalloc(msglen, GFP_KERNEL);
+		if (!eventmask_msg) {
+			err = -ENOMEM;
+			goto done;
+		}
+
+		/* Read the current programmed event_msgs_ext */
+		eventmask_msg->ver = EVENTMSGS_VER;
+		eventmask_msg->len = roundup(INFF_E_LAST, NBBY) / NBBY;
+		err = inff_fil_iovar_data_get(ifp, "event_msgs_ext",
+					      eventmask_msg,
+					       msglen);
+
+		/* Enable ULP event */
+		inff_dbg(EVENT, "enable event ULP\n");
+		setbit(eventmask_msg->mask, INFF_E_ULP);
+
+		/* Write updated Event mask */
+		eventmask_msg->ver = EVENTMSGS_VER;
+		eventmask_msg->command = EVENTMSGS_SET_MASK;
+		eventmask_msg->len = (roundup(INFF_E_LAST, NBBY) / NBBY);
+
+		err = inff_fil_iovar_data_set(ifp, "event_msgs_ext",
+					      eventmask_msg, msglen);
+		if (err) {
+			inff_err("Set event_msgs_ext error (%d)\n", err);
+			kfree(eventmask_msg);
+			goto done;
+		}
+		kfree(eventmask_msg);
+	}
+	/* Setup default scan channel time */
+	err = inff_fil_cmd_int_set(ifp, INFF_C_SET_SCAN_CHANNEL_TIME,
+				   INFF_DEFAULT_SCAN_CHANNEL_TIME);
+	if (err) {
+		iphy_err(drvr, "INFF_C_SET_SCAN_CHANNEL_TIME error (%d)\n",
+			 err);
+		goto done;
+	}
+
+	/* Setup default scan unassoc time */
+	err = inff_fil_cmd_int_set(ifp, INFF_C_SET_SCAN_UNASSOC_TIME,
+				   INFF_DEFAULT_SCAN_UNASSOC_TIME);
+	if (err) {
+		iphy_err(drvr, "INFF_C_SET_SCAN_UNASSOC_TIME error (%d)\n",
+			 err);
+		goto done;
+	}
+
+	/* Enable tx beamforming, errors can be ignored (not supported) */
+	(void)inff_fil_iovar_int_set(ifp, "txbf", 1);
+	err = inff_fil_iovar_int_set(ifp, "chanspec", 0x1001);
+	if (err < 0) {
+		iphy_err(drvr, "Initial Channel failed %d\n", err);
+		goto done;
+	}
+	/* add unicast packet filter */
+	err = inff_pktfilter_add_remove(ifp->ndev,
+					INFF_UNICAST_FILTER_NUM, true);
+	if (err == -INFF_FW_UNSUPPORTED) {
+		/* FW not support can be ignored */
+		err = 0;
+		goto done;
+	} else if (err) {
+		iphy_err(drvr, "Add unicast filter error (%d)\n", err);
+	}
+
+done:
+	return err;
+}
+
+#ifndef CONFIG_INF_TRACING
+void __inff_err(struct inff_bus *bus, const char *func, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	if (bus)
+		dev_err(bus->dev, "%s: %pV", func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
+
+	va_end(args);
+}
+#endif /* CONFIG_INF_TRACING */
+
+#if defined(CONFIG_INF_TRACING) || defined(CONFIG_INF_DEBUG)
+void __inff_dbg(u32 level, const char *func, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	if (inff_msg_level & level)
+		pr_debug("%s %pV", func, &vaf);
+	trace_inff_dbg(level, func, &vaf);
+	va_end(args);
+}
+#endif /* CONFIG_INF_TRACING || CONFIG_INF_DEBUG */
+
+int inff_debugfs_param_read(struct seq_file *s, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(s->private);
+
+	seq_printf(s, "%-20s: %s\n", "Name", "Value");
+	seq_printf(s, "%-20s: 0x%x\n", "debug", inff_msg_level);
+	seq_printf(s, "%-20s: %s\n", "alternative_fw_path", inff_firmware_path);
+	seq_printf(s, "%-20s: %d\n", "p2pon", !!inff_p2p_enable);
+	seq_printf(s, "%-20s: %d\n", "fcmode", bus_if->drvr->settings->fcmode);
+	seq_printf(s, "%-20s: %d\n", "roamoff", !!inff_roamoff);
+	seq_printf(s, "%-20s: %d\n", "iapp", !!inff_iapp_enable);
+	seq_printf(s, "%-20s: %d\n", "eap_restrict", !!inff_eap_restrict);
+	seq_printf(s, "%-20s: %d\n", "max_pm", !!inff_max_pm);
+#ifdef DEBUG
+	seq_printf(s, "%-20s: %d\n", "ignore_probe_fail", !!inff_ignore_probe_fail);
+#endif
+	seq_printf(s, "%-20s: %d\n", "fw_ap_select", !!inff_fw_ap_select);
+	seq_printf(s, "%-20s: %d\n", "disable_6ghz", !!inff_disable_6ghz);
+	seq_printf(s, "%-20s: %d\n", "sdio_in_isr", !!inff_sdio_in_isr);
+	seq_printf(s, "%-20s: %d\n", "pkt_prio", !!inff_pkt_prio_enable);
+	seq_printf(s, "%-20s: %d\n", "sdio_rxf_thread", !!inff_sdio_rxf_in_kthread);
+	seq_printf(s, "%-20s: %d\n", "offload_prof", inff_offload_prof);
+	seq_printf(s, "%-20s: 0x%x\n", "offload_feat", inff_offload_feat);
+	seq_printf(s, "%-20s: %d\n", "txglomsz", inff_sdiod_txglomsz);
+	seq_printf(s, "%-20s: %d\n", "bt_over_sdio", !!inff_bt_over_sdio);
+	seq_printf(s, "%-20s: %d\n", "bus_idle_time", inff_sdio_bus_idle_time);
+	seq_printf(s, "%-20s: %d\n", "short_psq", !!inff_short_psq);
+	seq_printf(s, "%-20s: %d\n", "tx_cpu", bus_if->drvr->settings->tx_cpu);
+	seq_printf(s, "%-20s: %d\n", "napi_cpu", bus_if->drvr->settings->napi_cpu);
+	seq_printf(s, "%-20s: %d\n", "napi_enable", bus_if->drvr->settings->napi_enable);
+
+	for (int i = 0; i < 5; i++)
+		seq_printf(s, "%-20s[%d]: %d\n", "commonring_depth",
+			   i, bus_if->drvr->settings->commonring_depth[i]);
+	seq_printf(s, "%-20s: %d\n", "flowring_depth", bus_if->drvr->settings->flowring_depth);
+	seq_printf(s, "%-20s: %d\n", "logring_depth", bus_if->drvr->settings->logring_depth);
+	seq_printf(s, "%-20s: %d\n", "logger_level", bus_if->drvr->settings->logger_level);
+
+	return 0;
+}
+
+struct inff_mp_device *inff_get_module_param(struct device *dev,
+					     enum inff_bus_type bus_type,
+					     u32 chip, u32 chiprev)
+{
+	struct inff_mp_device *settings;
+	int i;
+
+	inff_dbg(INFO, "Enter, bus=%d, chip=%d, rev=%d\n", bus_type, chip,
+		 chiprev);
+	settings = kzalloc(sizeof(*settings), GFP_ATOMIC);
+	if (!settings)
+		return NULL;
+
+	/* start by using the module parameters */
+	inff_dbg(INFO, "debug: 0x%x\n", inff_msg_level);
+	strscpy(settings->firmware_path, inff_firmware_path,
+		INFF_FW_ALTPATH_LEN);
+	inff_dbg(INFO, "alternative_fw_path: %s\n", settings->firmware_path);
+	settings->p2p_enable = !!inff_p2p_enable;
+	inff_dbg(INFO, "p2pon: %d\n", settings->p2p_enable);
+	memcpy(settings->feature_disable,
+	       inff_feature_disable,
+	       sizeof(inff_feature_disable));
+	inff_dbg(INFO, "feature_disable: ");
+	for (i = 0; i < INFF_MAX_FEATURE_BYTES; i++)
+		inff_dbg(INFO, "0x%x ", settings->feature_disable[i]);
+	inff_dbg(INFO, "\n");
+
+	settings->fcmode = inff_fcmode;
+	inff_dbg(INFO, "fcmode: %d\n", settings->fcmode);
+	settings->roamoff = inff_roamoff;
+	inff_dbg(INFO, "roamoff: %d\n", settings->roamoff);
+	settings->iapp = !!inff_iapp_enable;
+	inff_dbg(INFO, "iapp: %d\n", settings->iapp);
+	settings->eap_restrict = !!inff_eap_restrict;
+	inff_dbg(INFO, "eap_restrict: %d\n", settings->eap_restrict);
+	settings->default_pm = !!inff_max_pm ? PM_MAX : PM_FAST;
+	inff_dbg(INFO, "max_pm: %d\n", !!inff_max_pm);
+#ifdef DEBUG
+	settings->ignore_probe_fail = !!inff_ignore_probe_fail;
+	inff_dbg(INFO, "ignore_probe_fail: %d\n", settings->ignore_probe_fail);
+#endif
+	settings->fw_ap_select = !!inff_fw_ap_select;
+	inff_dbg(INFO, "fw_ap_select: %d\n", settings->fw_ap_select);
+	settings->disable_6ghz = !!inff_disable_6ghz;
+	inff_dbg(INFO, "disable_6ghz: %d\n", settings->disable_6ghz);
+	settings->sdio_in_isr = !!inff_sdio_in_isr;
+	inff_dbg(INFO, "sdio_in_isr: %d\n", settings->sdio_in_isr);
+	settings->pkt_prio = !!inff_pkt_prio_enable;
+	inff_dbg(INFO, "pkt_prio: %d\n", settings->pkt_prio);
+	settings->sdio_rxf_in_kthread_enabled = !!inff_sdio_rxf_in_kthread;
+	inff_dbg(INFO, "sdio_rxf_thread: %d\n", settings->sdio_rxf_in_kthread_enabled);
+
+	inff_dbg(INFO, "offload_prof: %d\n", inff_offload_prof);
+	if (inff_offload_prof >= INFF_OFFLOAD_PROF_TYPE_MAX) {
+		inff_err("Invalid Offload power profile %u, using default profile 1",
+			 inff_offload_prof);
+		inff_offload_prof = INFF_OFFLOAD_PROF_TYPE_LOW_PWR;
+	}
+	settings->offload_prof = inff_offload_prof;
+	settings->offload_feat = inff_offload_feat;
+	inff_dbg(INFO, "offload_feat: 0x%x\n", settings->offload_feat);
+
+	settings->bt_over_sdio = !!inff_bt_over_sdio;
+	inff_dbg(INFO, "bt_over_sdio: %d\n", settings->bt_over_sdio);
+	settings->short_psq = !!inff_short_psq;
+	inff_dbg(INFO, "inff_short_psq: %d\n", settings->short_psq);
+
+	settings->idleclk_disable = inff_sdio_idleclk_disable;
+	inff_dbg(INFO, "idleclk_disable: %d\n", settings->idleclk_disable);
+	settings->tx_cpu = inff_tx_cpu;
+	inff_dbg(INFO, "tx_cpu: %d\n", settings->tx_cpu);
+	settings->napi_cpu = inff_napi_cpu;
+	inff_dbg(INFO, "napi_cpu: %d\n", settings->napi_cpu);
+	settings->napi_enable = inff_napi_enable;
+	inff_dbg(INFO, "napi_enable: %d\n", settings->napi_enable);
+
+	for (i = 0; i < 5; i++) {
+		settings->commonring_depth[i] = inff_commonring_depth[i];
+		inff_dbg(INFO, "commonring_depth[%d] : %d\n",
+			 i, settings->commonring_depth[i]);
+	}
+
+	settings->flowring_depth = inff_flowring_depth;
+	inff_dbg(INFO, "flowring_depth : %d\n", settings->flowring_depth);
+
+	if (bus_type == INFF_BUSTYPE_SDIO) {
+		settings->bus.sdio.txglomsz = inff_sdiod_txglomsz;
+		inff_dbg(INFO, "txglomsz: %d\n", settings->bus.sdio.txglomsz);
+	}
+
+	settings->sdio_bus_idle_time = inff_sdio_bus_idle_time;
+	inff_dbg(INFO, "sdio_bus_idle_time: %d\n", settings->sdio_bus_idle_time);
+
+	settings->logring_depth = inff_logring_depth;
+	inff_dbg(INFO, "logring_depth : %d\n", settings->logring_depth);
+
+	settings->logger_level = inff_logger_level;
+	inff_dbg(INFO, "logger_level : %d\n", settings->logger_level);
+
+	return settings;
+}
+
+void inff_release_module_param(struct inff_mp_device *module_param)
+{
+	kfree(module_param);
+}
+
+static int
+inff_reboot_callback(struct notifier_block *this, unsigned long code, void *unused)
+{
+	inff_dbg(INFO, "code = %ld\n", code);
+	if (code == SYS_RESTART)
+		inff_core_exit();
+	return NOTIFY_DONE;
+}
+
+static int __init inff_module_init(void)
+{
+	int err;
+
+	/* Continue the initialization by registering the different busses */
+	err = inff_core_init();
+	if (!err)
+		register_reboot_notifier(&inff_reboot_notifier);
+
+	return err;
+}
+
+static void __exit inff_module_exit(void)
+{
+	inff_core_exit();
+	unregister_reboot_notifier(&inff_reboot_notifier);
+}
+
+module_init(inff_module_init);
+module_exit(inff_module_exit);
diff --git a/drivers/net/wireless/infineon/inffmac/common.h b/drivers/net/wireless/infineon/inffmac/common.h
new file mode 100644
index 000000000000..0e679f6394ac
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/common.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_COMMON_H
+#define INFF_COMMON_H
+
+#include "fwil_types.h"
+#include "bus.h"
+
+#define INFF_FW_ALTPATH_LEN			256
+
+#define INFFMAC_DISABLE	0
+#define INFFMAC_ENABLE		1
+#define INFFMAC_AUTO		2
+
+#define INFF_DEFAULT_SDIO_IDLE_CONFIG         2
+/* Keeping these macro definition here because these are defined in mmc drivers.
+ * So for 3rd party mmc, fmac build should not fail due to build error.
+ */
+
+/* SDIO IDLECLOCK Support - reusing pm_caps */
+#ifndef SDIO_IDLECLOCK_DIS
+#define SDIO_IDLECLOCK_DIS	BIT(2)	/* Start SDClock */
+#define SDIO_IDLECLOCK_EN	BIT(3)	/* Stop SDClock */
+#define SDIO_SDMODE_1BIT	BIT(4)	/* Set 1-bit Bus mode */
+#define SDIO_SDMODE_4BIT	BIT(5)	/* Set 4-bit Bus mode */
+#endif /* !SDIO_IDLECLOCK_DIS */
+
+struct inff_sdio_platform_data {
+	int		txglomsz;
+	bool		oob_irq_supported;
+	unsigned int	oob_irq_nr;
+	unsigned long	oob_irq_flags;
+	bool		broken_sg_support;
+	unsigned short	sd_head_align;
+	unsigned short	sd_sgentry_align;
+};
+
+/**
+ * struct inff_mp_device - Device module parameters.
+ *
+ * @p2p_enable: Legacy P2P0 enable (old wpa_supplicant).
+ * @feature_disable: Feature_disable bitmask.
+ * @fcmode: FWS flow control.
+ * @roamoff: Firmware roaming off?
+ * @eap_restrict: Not allow data tx/rx until 802.1X auth succeeds
+ * @default_pm: default power management (PM) mode.
+ * @ignore_probe_fail: Ignore probe failure.
+ * @fw_ap_select: Allow FW to select AP.
+ * @disable_6ghz: Disable 6GHz operation
+ * @sdio_in_isr: Handle SDIO DPC in ISR.
+ * @offload_prof: Enable offloads configuration power profile (Low,Mid,High)
+ * @offload_feat: offloads feature flags to be enabled for selected pwr profile
+ * @country_codes: If available, pointer to struct for translating country codes
+ * @bus: Bus specific platform data. Only SDIO at the mmoment.
+ * @pkt_prio: Support customer dscp to WMM up mapping.
+ * @idleclk_disable: SDIO bus clock output disable when bus is idle.
+ * @idle_time_zero: Set idle interval to zero.
+ * @commonring_depth: Set commonring depth.
+ * @flowring_depth: Set flowring depth.
+ * @logring_depth: Set logring depth.
+ * @logger_level: Set logger level.
+ */
+#define INFF_MAX_FEATURE_BYTES DIV_ROUND_UP(INFF_FEAT_LAST, 8)
+struct inff_mp_device {
+	char		firmware_path[INFF_FW_ALTPATH_LEN];
+	bool		p2p_enable;
+	unsigned char	feature_disable[INFF_MAX_FEATURE_BYTES];
+	int		fcmode;
+	unsigned int	roamoff;
+	bool		iapp;
+	bool		eap_restrict;
+	int		default_pm;
+	bool		ignore_probe_fail;
+	bool		fw_ap_select;
+	bool		disable_6ghz;
+	bool		sdio_in_isr;
+	bool		sdio_rxf_in_kthread_enabled;
+	unsigned int	offload_prof;
+	unsigned int	offload_feat;
+	bool		bt_over_sdio;
+	bool		short_psq;
+	const char	*board_type;
+	unsigned char	mac[ETH_ALEN];
+	union {
+		struct inff_sdio_platform_data sdio;
+	} bus;
+	bool		pkt_prio;
+	int			idleclk_disable;
+	int             sdio_bus_idle_time;
+	int		tx_cpu;
+	int		napi_cpu;
+	int		napi_enable;
+	int		commonring_depth[5];
+	int		flowring_depth;
+	int		logring_depth;
+	int		logger_level;
+};
+
+/**
+ * enum inff_roamoff_mode - using fw roaming and report event mode if not use it.
+ *
+ * @INFF_ROAMOFF_DISABLE: use firmware roaming engine
+ * @INFF_ROAMOFF_EN_BCNLOST_MSG:
+ *	don't use firmware roaming engine, and report to cfg80211 layer by BCNLOST_MSG event
+ * @INFF_ROAMOFF_EN_DISCONNECT_EVT:
+ *	don't use firmware roaming engine, and report to cfg80211 layer by DISCONNECT event
+ * @INFF_ROAMOFF_MAX:
+ *	for sanity checking purpose.
+ */
+
+enum inff_roamoff_mode {
+	INFF_ROAMOFF_DISABLE = 0,
+	INFF_ROAMOFF_EN_BCNLOST_MSG = 1,
+	INFF_ROAMOFF_EN_DISCONNECT_EVT = 2,
+	INFF_ROAMOFF_MAX
+};
+
+void inff_c_set_joinpref_default(struct inff_if *ifp);
+
+struct inff_mp_device *inff_get_module_param(struct device *dev,
+					     enum inff_bus_type bus_type,
+					       u32 chip, u32 chiprev);
+int inff_debugfs_param_read(struct seq_file *s, void *data);
+void inff_release_module_param(struct inff_mp_device *module_param);
+
+/* Sets dongle media info (drv_version, mac address). */
+int inff_c_preinit_dcmds(struct inff_if *ifp);
+int inff_c_set_cur_etheraddr(struct inff_if *ifp, const u8 *addr);
+
+u8 inff_map_prio_to_prec(void *cfg, u8 prio);
+
+u8 inff_map_prio_to_aci(void *cfg, u8 prio);
+
+#endif /* INFF_COMMON_H */
-- 
2.25.1


