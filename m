Return-Path: <linux-wireless+bounces-30767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12FD1B3F3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F473050CF3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC42772D;
	Tue, 13 Jan 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="pcqq5HpV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B7276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336630; cv=none; b=tDcehI/DnD/pd6G2eh6YWC83Ek9+F1jHeX9bQFTKG6H9OARxoQxoJfsZRyqGlXuw0D8PYD6kHrCA3XikqUM54mZS6E61lYSJDFod94srGg5Z1HJSIsr1zPLKMPPivGSuZkdWcCDkvWTG0ND8mIIUwJkqAjOGTRg+J1noGp7QxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336630; c=relaxed/simple;
	bh=qOcAZvlHmCBxMZcIHQsIFKLGN5N+UbGWli5UFKSo5fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJlrkQJD1wJY6LHr253S9LOE6dyT5fjjM7XMMdWvvuUa3Ovc7lvP/tq61zWREItzJbmjLeq3/82kxxgHUs62CxYrOV6r+hAA6ywmojcvKbPMhTdb8cc1xP7LvLKexl0qraCYcGxXHzGP/1fblFymluL2oeSS+COWC8xPNB1Exmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=pcqq5HpV; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336628; x=1799872628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOcAZvlHmCBxMZcIHQsIFKLGN5N+UbGWli5UFKSo5fQ=;
  b=pcqq5HpVb8o770IwyeiXXYkeskgpLmCWtJfjAUyodb41JsRPfiFdtGIa
   RedgaI7v1vEcxtLqKdP4RH5vCAB4iQDjHffyKi43x3ogPMzlGTN7TYqSW
   avf27DamS6mZl6d5Lb5lLN2dPQuKI2U5WSsjRDO6YA26r89zvNV4FSLCl
   E=;
X-CSE-ConnectionGUID: ixnIWNEASU2gEDUCWniEWg==
X-CSE-MsgGUID: yXtSz7zkRuqBYhc6fqPu6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78107067"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="78107067"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:37:06 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:37:05 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:37:03 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 12/34] wifi: inffmac: add main.c/h
Date: Wed, 14 Jan 2026 02:03:25 +0530
Message-ID: <20260113203350.16734-13-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE827.infineon.com (172.23.29.20)

Driver main file to initialize and De-initialize the Kernel module in the
kernel. Also maintains some of the core driver structures, functions and
common module param registrations.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/main.c | 1133 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/main.h |  377 ++++++
 2 files changed, 1510 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/main.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/main.h

diff --git a/drivers/net/wireless/infineon/inffmac/main.c b/drivers/net/wireless/infineon/inffmac/main.c
new file mode 100644
index 000000000000..e9c470118b64
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/main.c
@@ -0,0 +1,1133 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/etherdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/reboot.h>
+
+#include "main.h"
+#include "net.h"
+#include "cfg80211.h"
+#include "utils.h"
+#include "chan.h"
+#include "debug.h"
+#include "bus_proto.h"
+#include "sdio.h"
+#include "pcie.h"
+#include "chip.h"
+#include "firmware.h"
+#include "dev_cmd.h"
+#include "dev_evt.h"
+#include "p2p.h"
+#include "feature.h"
+#include "twt.h"
+#include "pmsr.h"
+
+#define INFF_DEFAULT_SCAN_CHANNEL_TIME	40
+#define INFF_DEFAULT_SCAN_UNASSOC_TIME	40
+
+/* default boost value for RSSI_DELTA in preferred join selection */
+#define INFF_JOIN_PREF_RSSI_BOOST	8
+
+/* Debug level configuration. See debug.h for bits, sysfs modifiable */
+int inff_msg_level;
+module_param_named(debug, inff_msg_level, int, 0600);
+MODULE_PARM_DESC(debug, "Level of debug output");
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
+static int inff_reboot_callback(struct notifier_block *this, unsigned long code, void *unused);
+static struct notifier_block inff_reboot_notifier = {
+	.notifier_call = inff_reboot_callback,
+	.priority = 1,
+};
+
+#define MAX_WAIT_FOR_8021X_TX			msecs_to_jiffies(950)
+
+bool inff_socitype_is_ai(struct inff_bus *bus)
+{
+	return (bus->chip_pub->socitype == INFF_SOCI_AI);
+}
+
+bool inff_socitype_is_cp(struct inff_bus *bus)
+{
+	return (bus->chip_pub->socitype == INFF_SOCI_CP);
+}
+
+char *inff_ifname(struct inff_if *ifp)
+{
+	if (!ifp)
+		return "<if_null>";
+
+	if (ifp->ndev)
+		return ifp->ndev->name;
+
+	return "<if_none>";
+}
+
+struct inff_if *inff_get_ifp(struct inff_pub *drvr, int ifidx)
+{
+	struct inff_if *ifp;
+	s32 bsscfgidx;
+
+	if (ifidx < 0 || ifidx >= INFF_MAX_IFS) {
+		iphy_err(drvr, "ifidx %d out of range\n", ifidx);
+		return NULL;
+	}
+
+	ifp = NULL;
+	bsscfgidx = drvr->if2bss[ifidx];
+	if (bsscfgidx >= 0)
+		ifp = drvr->iflist[bsscfgidx];
+
+	return ifp;
+}
+
+int inff_rx_hdrpull(struct inff_pub *drvr, struct sk_buff *skb,
+		    struct inff_if **ifp)
+{
+	int ret;
+
+	/* process and remove protocol-specific header */
+	ret = inff_proto_hdrpull(drvr, true, skb, ifp);
+
+	if (ret || !(*ifp) || !(*ifp)->ndev) {
+		if (ret != -ENODATA && *ifp && (*ifp)->ndev)
+			(*ifp)->ndev->stats.rx_errors++;
+		inff_pkt_buf_free_skb(skb);
+		return -ENODATA;
+	}
+
+	skb->protocol = eth_type_trans(skb, (*ifp)->ndev);
+	inff_dbg(DATA, "protocol: 0x%04X\n", skb->protocol);
+
+	return 0;
+}
+
+void inff_txfinalize(struct inff_if *ifp, struct sk_buff *txp, bool success)
+{
+	struct ethhdr *eh;
+	u16 type;
+
+	if (!ifp) {
+		inff_pkt_buf_free_skb(txp);
+		return;
+	}
+
+	eh = (struct ethhdr *)(txp->data);
+	type = ntohs(eh->h_proto);
+
+	if (type == ETH_P_PAE) {
+		atomic_dec(&ifp->pend_8021x_cnt);
+		/* check is there any 8021x under waiting */
+		if (waitqueue_active(&ifp->pend_8021x_wait))
+			wake_up(&ifp->pend_8021x_wait);
+	}
+
+	if (!success && ifp->ndev)
+		ifp->ndev->stats.tx_errors++;
+
+	inff_pkt_buf_free_skb(txp);
+}
+
+void inff_dev_coredump(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+
+	if (inff_debug_create_memdump(bus_if, NULL, 0) < 0)
+		inff_dbg(TRACE, "failed to create coredump\n");
+}
+
+void inff_fw_crashed(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	iphy_err(drvr, "Firmware has halted or crashed\n");
+
+	inff_dev_coredump(dev);
+
+	if (drvr->bus_reset.func)
+		schedule_work(&drvr->bus_reset);
+}
+
+static int inff_get_pend_8021x_cnt(struct inff_if *ifp)
+{
+	return atomic_read(&ifp->pend_8021x_cnt);
+}
+
+int inff_netdev_wait_pend8021x(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int err;
+
+	err = wait_event_timeout(ifp->pend_8021x_wait,
+				 !inff_get_pend_8021x_cnt(ifp),
+				 MAX_WAIT_FOR_8021X_TX);
+
+	if (!err) {
+		iphy_err(drvr, "Timed out waiting for no pending 802.1x packets\n");
+		atomic_set(&ifp->pend_8021x_cnt, 0);
+	}
+
+	return !err;
+}
+
+int
+inff_pktfilter_add_remove(struct net_device *ndev, int filter_num, bool add)
+{
+	struct inff_if *ifp =  netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pkt_filter_le *pkt_filter;
+	int filter_fixed_len = offsetof(struct inff_pkt_filter_le, u);
+	int pattern_fixed_len = offsetof(struct inff_pkt_filter_pattern_le,
+				  mask_and_pattern);
+	u16 mask_and_pattern[MAX_PKTFILTER_PATTERN_SIZE];
+	int buflen = 0;
+	int ret = 0;
+
+	inff_dbg(INFO, "%s packet filter number %d\n",
+		 (add ? "add" : "remove"), filter_num);
+
+	pkt_filter = kzalloc(sizeof(*pkt_filter) +
+			(MAX_PKTFILTER_PATTERN_FILL_SIZE), GFP_ATOMIC);
+	if (!pkt_filter)
+		return -ENOMEM;
+
+	switch (filter_num) {
+	case INFF_UNICAST_FILTER_NUM:
+		pkt_filter->id = cpu_to_le32(100);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(1);
+		mask_and_pattern[0] = 0x0001;
+		break;
+	case INFF_BROADCAST_FILTER_NUM:
+		//filter_pattern = "101 0 0 0 0xFFFFFFFFFFFF 0xFFFFFFFFFFFF";
+		pkt_filter->id = cpu_to_le32(101);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(6);
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0xFFFF;
+		mask_and_pattern[2] = 0xFFFF;
+		mask_and_pattern[3] = 0xFFFF;
+		mask_and_pattern[4] = 0xFFFF;
+		mask_and_pattern[5] = 0xFFFF;
+		break;
+	case INFF_MULTICAST4_FILTER_NUM:
+		//filter_pattern = "102 0 0 0 0xFFFFFF 0x01005E";
+		pkt_filter->id = cpu_to_le32(102);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(3);
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0x01FF;
+		mask_and_pattern[2] = 0x5E00;
+		break;
+	case INFF_MULTICAST6_FILTER_NUM:
+		//filter_pattern = "103 0 0 0 0xFFFF 0x3333";
+		pkt_filter->id = cpu_to_le32(103);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(2);
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0x3333;
+		break;
+	case INFF_MDNS_FILTER_NUM:
+		//filter_pattern = "104 0 0 0 0xFFFFFFFFFFFF 0x01005E0000FB";
+		pkt_filter->id = cpu_to_le32(104);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(6);
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0xFFFF;
+		mask_and_pattern[2] = 0xFFFF;
+		mask_and_pattern[3] = 0x0001;
+		mask_and_pattern[4] = 0x005E;
+		mask_and_pattern[5] = 0xFB00;
+		break;
+	case INFF_ARP_FILTER_NUM:
+		//filter_pattern = "105 0 0 12 0xFFFF 0x0806";
+		pkt_filter->id = cpu_to_le32(105);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = cpu_to_le32(12);
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(2);
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0x0608;
+		break;
+	case INFF_BROADCAST_ARP_FILTER_NUM:
+		//filter_pattern = "106 0 0 0
+		//0xFFFFFFFFFFFF0000000000000806
+		//0xFFFFFFFFFFFF0000000000000806";
+		pkt_filter->id = cpu_to_le32(106);
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = cpu_to_le32(14);
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0xFFFF;
+		mask_and_pattern[2] = 0xFFFF;
+		mask_and_pattern[3] = 0x0000;
+		mask_and_pattern[4] = 0x0000;
+		mask_and_pattern[5] = 0x0000;
+		mask_and_pattern[6] = 0x0608;
+		mask_and_pattern[7] = 0xFFFF;
+		mask_and_pattern[8] = 0xFFFF;
+		mask_and_pattern[9] = 0xFFFF;
+		mask_and_pattern[10] = 0x0000;
+		mask_and_pattern[11] = 0x0000;
+		mask_and_pattern[12] = 0x0000;
+		mask_and_pattern[13] = 0x0608;
+		break;
+	default:
+		ret = -EINVAL;
+		goto failed;
+	}
+	memcpy(pkt_filter->u.pattern.mask_and_pattern, mask_and_pattern,
+	       le32_to_cpu(pkt_filter->u.pattern.size_bytes) * 2);
+	buflen = filter_fixed_len + pattern_fixed_len +
+		  le32_to_cpu(pkt_filter->u.pattern.size_bytes) * 2;
+
+	if (add) {
+		/* Add filter */
+		ifp->fwil_fwerr = true;
+		ret = inff_fwcmd_iovar_data_set(ifp, "pkt_filter_add",
+						pkt_filter, buflen);
+		ifp->fwil_fwerr = false;
+		if (ret)
+			goto failed;
+		drvr->pkt_filter[filter_num].id = pkt_filter->id;
+		drvr->pkt_filter[filter_num].enable  = 0;
+
+	} else {
+		/* Delete filter */
+		ifp->fwil_fwerr = true;
+		ret = inff_fwcmd_iovar_int_set(ifp, "pkt_filter_delete",
+					       le32_to_cpu(pkt_filter->id));
+		ifp->fwil_fwerr = false;
+		if (ret == -INFF_FW_BADARG)
+			ret = 0;
+		if (ret)
+			goto failed;
+
+		drvr->pkt_filter[filter_num].id = 0;
+		drvr->pkt_filter[filter_num].enable  = 0;
+	}
+failed:
+	if (ret)
+		inff_err("%s packet filter failed, ret=%d\n",
+			 (add ? "add" : "remove"), ret);
+
+	kfree(pkt_filter);
+	return ret;
+}
+
+int inff_pktfilter_enable(struct net_device *ndev, bool enable)
+{
+	struct inff_if *ifp =  netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	int ret = 0;
+	int idx = 0;
+
+	for (idx = 0; idx < MAX_PKT_FILTER_COUNT; ++idx) {
+		if (drvr->pkt_filter[idx].id != 0) {
+			drvr->pkt_filter[idx].enable = cpu_to_le32(enable);
+			ret = inff_fwcmd_iovar_data_set(ifp, "pkt_filter_enable",
+							&drvr->pkt_filter[idx],
+							sizeof(struct inff_pkt_filter_enable_le));
+			if (ret) {
+				inff_err("%s packet filter id(%d) failed, ret=%d\n",
+					 (enable ? "enable" : "disable"),
+					 drvr->pkt_filter[idx].id, ret);
+			}
+		}
+	}
+	return ret;
+}
+
+/** Find STA with MAC address ea in an interface's STA list. */
+struct inff_sta *
+inff_find_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta  *sta;
+	unsigned long flags;
+
+	INFF_IF_STA_LIST_LOCK(ifp, flags);
+	list_for_each_entry(sta, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			inff_dbg(INFO, "Found STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+				 sta->ea.octet[0], sta->ea.octet[1],
+				 sta->ea.octet[2], sta->ea.octet[3],
+				 sta->ea.octet[4], sta->ea.octet[5]);
+			INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+			return sta;
+		}
+	}
+	INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+
+	return INFF_STA_NULL;
+}
+
+/** Add STA into the interface's STA list. */
+static struct inff_sta *
+inff_add_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta *sta;
+	unsigned long flags;
+
+	sta =  kzalloc(sizeof(*sta), GFP_KERNEL);
+	if (sta == INFF_STA_NULL) {
+		inff_err("Alloc failed\n");
+		return INFF_STA_NULL;
+	}
+	memcpy(sta->ea.octet, ea, ETH_ALEN);
+	inff_dbg(INFO, "Add STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+		 sta->ea.octet[0], sta->ea.octet[1],
+		 sta->ea.octet[2], sta->ea.octet[3],
+		 sta->ea.octet[4], sta->ea.octet[5]);
+
+	/* link the sta and the inff_if interface */
+	sta->ifp = ifp;
+	INIT_LIST_HEAD(&sta->list);
+
+	INFF_IF_STA_LIST_LOCK(ifp, flags);
+
+	list_add_tail(&sta->list, &ifp->sta_list);
+
+	INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+	return sta;
+}
+
+/** Delete STA from the interface's STA list. */
+void
+inff_del_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta *sta, *next;
+	unsigned long flags;
+
+	INFF_IF_STA_LIST_LOCK(ifp, flags);
+	list_for_each_entry_safe(sta, next, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			inff_dbg(INFO, "del STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x from sta list\n",
+				 ea[0], ea[1], ea[2], ea[3],
+				 ea[4], ea[5]);
+			list_del(&sta->list);
+			kfree(sta);
+		}
+	}
+
+	INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+}
+
+/** Add STA if it doesn't exist. Not reentrant. */
+struct inff_sta*
+inff_findadd_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta *sta = NULL;
+
+	sta = inff_find_sta(ifp, ea);
+
+	if (!sta) {
+		/* Add entry */
+		sta = inff_add_sta(ifp, ea);
+	}
+	return sta;
+}
+
+static int
+inff_psm_watchdog_notify(struct inff_if *ifp,
+			 const struct inff_event_msg *evtmsg,
+			 void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int err;
+
+	iphy_err(drvr, "PSM's watchdog has fired bsscfgidx=%d !\n",
+		 ifp->bsscfgidx);
+
+	err = inff_debug_create_memdump(ifp->drvr->bus_if, data,
+					evtmsg->datalen);
+	if (err)
+		iphy_err(drvr, "Failed to get memory dump, %d\n", err);
+
+	return err;
+}
+
+void
+inff_set_joinpref_default(struct inff_if *ifp)
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
+	err = inff_fwcmd_iovar_data_set(ifp, "join_pref", join_pref_params,
+					sizeof(join_pref_params));
+	if (err)
+		iphy_err(drvr, "Set join_pref error (%d)\n", err);
+}
+
+static int
+inff_download_clm_blob(struct inff_if *ifp, u16 flag,
+		       struct inff_dload_data_le *dload_buf,
+		       u32 len)
+{
+	s32 err;
+
+	flag |= (DLOAD_HANDLER_VER << DLOAD_FLAG_VER_SHIFT);
+	dload_buf->flag = cpu_to_le16(flag);
+	dload_buf->dload_type = cpu_to_le16(DL_TYPE_CLM);
+	dload_buf->len = cpu_to_le32(len);
+	dload_buf->crc = cpu_to_le32(0);
+
+	err = inff_fwcmd_iovar_data_set(ifp, "clmload", dload_buf,
+					struct_size(dload_buf, data, len));
+
+	return err;
+}
+
+static int
+inff_process_clm_blob(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_bus *bus = drvr->bus_if;
+	struct inff_dload_data_le *chunk_buf;
+	const struct firmware *clm = NULL;
+	u32 chunk_len;
+	u32 datalen;
+	u32 cumulative_len;
+	u16 dl_flag = DL_BEGIN;
+	u32 status = 0;
+	s32 err;
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
+		err = inff_download_clm_blob(ifp, dl_flag, chunk_buf, chunk_len);
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
+		err = inff_fwcmd_iovar_int_get(ifp, "clmload_status", &status);
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
+int
+inff_set_cur_etheraddr(struct inff_if *ifp, const u8 *addr)
+{
+	s32 err;
+
+	err = inff_fwcmd_iovar_data_set(ifp, "cur_etheraddr", addr, ETH_ALEN);
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
+static int
+inff_set_preinit_dcmds(struct inff_if *ifp)
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
+		err = inff_set_cur_etheraddr(ifp, ifp->mac_addr);
+		if (err < 0)
+			goto done;
+	} else {
+		/* retrieve mac address */
+		err = inff_fwcmd_iovar_data_get(ifp, "cur_etheraddr", ifp->mac_addr,
+						sizeof(ifp->mac_addr));
+		if (err < 0) {
+			iphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
+			goto done;
+		}
+
+		if (ether_addr_equal_unaligned(ifp->mac_addr, inff_default_mac_address)) {
+			iphy_err(drvr, "Default MAC is used, replacing with random MAC to avoid conflicts\n");
+			eth_random_addr(ifp->mac_addr);
+			ifp->ndev->addr_assign_type = NET_ADDR_RANDOM;
+			err = inff_set_cur_etheraddr(ifp, ifp->mac_addr);
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
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_REVINFO,
+				      &revinfo, sizeof(revinfo));
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
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		/* Download CLM BLOB */
+		err = inff_process_clm_blob(ifp);
+		if (err < 0) {
+			iphy_err(drvr, "download CLM blob file failed, %d\n", err);
+			goto done;
+		}
+	}
+
+	/* query for 'ver' to get version info from firmware */
+	memset(buf, 0, sizeof(buf));
+	err = inff_fwcmd_iovar_data_get(ifp, "ver", buf, sizeof(buf));
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
+	err = inff_fwcmd_iovar_data_get(ifp, "wlc_ver", &wlc_ver, sizeof(wlc_ver));
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
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		memset(buf, 0, sizeof(buf));
+		err = inff_fwcmd_iovar_data_get(ifp, "clmver", buf, sizeof(buf));
+		if (err) {
+			inff_dbg(TRACE, "retrieving clmver failed, %d\n", err);
+		} else {
+			buf[sizeof(buf) - 1] = '\0';
+			clmver = (char *)buf;
+
+			/* Replace all newline/linefeed characters with space
+			 * character
+			 */
+			strreplace(clmver, '\n', ' ');
+
+			/* store CLM version for adding it to revinfo debugfs file */
+			memcpy(ifp->drvr->clmver, clmver, sizeof(ifp->drvr->clmver));
+
+			inff_dbg(INFO, "CLM version = %s\n", clmver);
+		}
+	}
+
+	/* set apsta */
+	err = inff_fwcmd_iovar_int_set(ifp, "apsta", 1);
+	if (err)
+		inff_info("failed setting apsta, %d\n", err);
+
+	/* set mpc */
+	err = inff_fwcmd_iovar_int_set(ifp, "mpc", 1);
+	if (err) {
+		iphy_err(drvr, "failed setting mpc\n");
+		goto done;
+	}
+
+	inff_set_joinpref_default(ifp);
+
+	/* Setup event_msgs, enable E_IF */
+	err = inff_fwcmd_iovar_data_get(ifp, "event_msgs", eventmask,
+					INFF_EVENTING_MASK_LEN);
+	if (err) {
+		iphy_err(drvr, "Get event_msgs error (%d)\n", err);
+		goto done;
+	}
+	setbit(eventmask, INFF_E_IF);
+	err = inff_fwcmd_iovar_data_set(ifp, "event_msgs", eventmask,
+					INFF_EVENTING_MASK_LEN);
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
+		err = inff_fwcmd_iovar_data_get(ifp, "event_msgs_ext",
+						eventmask_msg,
+					       msglen);
+
+		/* Enable ULP event */
+		inff_dbg(DEVEVT, "enable event ULP\n");
+		setbit(eventmask_msg->mask, INFF_E_ULP);
+
+		/* Write updated Event mask */
+		eventmask_msg->ver = EVENTMSGS_VER;
+		eventmask_msg->command = EVENTMSGS_SET_MASK;
+		eventmask_msg->len = (roundup(INFF_E_LAST, NBBY) / NBBY);
+
+		err = inff_fwcmd_iovar_data_set(ifp, "event_msgs_ext",
+						eventmask_msg, msglen);
+		if (err) {
+			inff_err("Set event_msgs_ext error (%d)\n", err);
+			kfree(eventmask_msg);
+			goto done;
+		}
+		kfree(eventmask_msg);
+	}
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		/* Setup default scan channel time */
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_SCAN_CHANNEL_TIME,
+					     INFF_DEFAULT_SCAN_CHANNEL_TIME);
+		if (err) {
+			iphy_err(drvr, "INFF_C_SET_SCAN_CHANNEL_TIME error (%d)\n",
+				 err);
+			goto done;
+		}
+
+		/* Setup default scan unassoc time */
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_SCAN_UNASSOC_TIME,
+					     INFF_DEFAULT_SCAN_UNASSOC_TIME);
+		if (err) {
+			iphy_err(drvr, "INFF_C_SET_SCAN_UNASSOC_TIME error (%d)\n",
+				 err);
+			goto done;
+		}
+	}
+	/* Enable tx beamforming, errors can be ignored (not supported) */
+	(void)inff_fwcmd_iovar_int_set(ifp, "txbf", 1);
+	err = inff_fwcmd_iovar_int_set(ifp, "chanspec", 0x1001);
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
+static int
+inff_revinfo_read(struct seq_file *s, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(s->private);
+	struct inff_rev_info *ri = &bus_if->drvr->revinfo;
+	char drev[INFF_DOTREV_LEN];
+	char brev[INFF_BOARDREV_LEN];
+
+	seq_printf(s, "vendorid: 0x%04x\n", ri->vendorid);
+	seq_printf(s, "deviceid: 0x%04x\n", ri->deviceid);
+	seq_printf(s, "radiorev: %s\n", inff_dotrev_str(ri->radiorev, drev));
+	seq_printf(s, "chip: %s\n", ri->chipname);
+	seq_printf(s, "chippkg: %u\n", ri->chippkg);
+	seq_printf(s, "corerev: %u\n", ri->corerev);
+	seq_printf(s, "boardid: 0x%04x\n", ri->boardid);
+	seq_printf(s, "boardvendor: 0x%04x\n", ri->boardvendor);
+	seq_printf(s, "boardrev: %s\n", inff_boardrev_str(ri->boardrev, brev));
+	seq_printf(s, "driverrev: %s\n", inff_dotrev_str(ri->driverrev, drev));
+	seq_printf(s, "ucoderev: %u\n", ri->ucoderev);
+	seq_printf(s, "bus: %u\n", ri->bus);
+	seq_printf(s, "phytype: %u\n", ri->phytype);
+	seq_printf(s, "phyrev: %u\n", ri->phyrev);
+	seq_printf(s, "anarev: %u\n", ri->anarev);
+	seq_printf(s, "nvramrev: %08x\n", ri->nvramrev);
+
+	seq_printf(s, "clmver: %s\n", bus_if->drvr->clmver);
+
+	return 0;
+}
+
+int
+inff_bus_attach(struct device *dev, bool start_bus)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_if *pri_ifp;
+	s32 bsscfgidx, ifidx;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(drvr->if2bss); i++)
+		drvr->if2bss[i] = INFF_BSSIDX_INVALID;
+
+	mutex_init(&drvr->proto_block);
+
+	/* Link to bus module */
+	drvr->hdrlen = 0;
+
+	drvr->req_mpc = 1;
+	/* Attach and link in the protocol */
+	ret = inff_bus_proto_attach(drvr);
+	if (ret < 0) {
+		iphy_err(drvr, "inff_prot_attach failed\n");
+		goto fail;
+	}
+
+	if (inff_socitype_is_ai(bus_if)) {
+		/* Attach to events important for core code */
+		inff_fwevt_register(drvr, INFF_E_PSM_WATCHDOG,
+				    inff_psm_watchdog_notify);
+		/* attach firmware event handler */
+		inff_fwevt_attach(drvr);
+	} else if (inff_socitype_is_cp(bus_if)) {
+		ret = inff_cpevt_attach(drvr);
+		if (ret != 0) {
+			iphy_err(drvr, "Event attach failed.!\n");
+			goto fail;
+		}
+	}
+
+	if (!start_bus)
+		goto exit;
+
+	/* add primary netdev in station mode */
+	bsscfgidx = 0;
+	ifidx = 0;
+	pri_ifp = inff_net_add_if(drvr, bsscfgidx, ifidx, "wlan%d",
+				  is_valid_ether_addr(drvr->settings->mac) ?
+				  drvr->settings->mac : NULL,
+				  NL80211_IFTYPE_STATION);
+	if (IS_ERR(pri_ifp)) {
+		ret = PTR_ERR(pri_ifp);
+		goto fail;
+	}
+
+	if (inff_socitype_is_ai(bus_if)) {
+		/* signal bus ready */
+		inff_bus_change_state(bus_if, INFF_BUS_UP);
+
+		/* do bus specific preinit here */
+		ret = inff_bus_preinit(bus_if);
+		if (ret < 0)
+			goto fail;
+
+		ret = inff_bus_set_fcmode(bus_if);
+		/* Set fcmode = 0 for PCIe */
+		if (ret < 0)
+			drvr->settings->fcmode = 0;
+
+		ret = inff_proto_init_done(drvr);
+		if (ret < 0)
+			goto fail;
+
+		inff_proto_add_if(drvr, pri_ifp);
+	}
+
+	inff_feat_attach(drvr);
+
+	/* Bus is ready, do any initialization */
+	ret = inff_set_preinit_dcmds(pri_ifp);
+	if (ret < 0)
+		goto fail;
+
+	drvr->config = inff_cfg80211_attach(drvr, drvr->ops);
+	if (IS_ERR(drvr->config)) {
+		ret = PTR_ERR(drvr->config);
+		goto fail;
+	}
+
+	ret = inff_net_attach(pri_ifp, false);
+	if (ret)
+		goto fail;
+
+	/* populate debugfs */
+	inff_debugfs_add_entry(drvr, "revinfo", inff_revinfo_read);
+	inff_debugfs_add_entry(drvr, "parameter", inff_debugfs_param_read);
+	inff_feat_debugfs_create(drvr);
+	inff_bus_proto_debugfs_create(drvr);
+
+	if (inff_socitype_is_ai(bus_if)) {
+		inff_twt_debugfs_create(drvr);
+		inff_pmsr_debugfs_create(drvr);
+	}
+
+	goto exit;
+fail:
+	iphy_err(drvr, "dongle is not responding: err=%d\n",
+		 ret);
+	inff_bus_detach(dev);
+exit:
+	return ret;
+}
+
+void
+inff_bus_detach(struct device *dev)
+{
+	s32 i;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	if (!drvr)
+		return;
+
+	inff_bus_stop(bus_if);
+
+	inff_bus_change_state(bus_if, INFF_BUS_DOWN);
+
+	/* make sure primary interface removed last */
+	for (i = INFF_MAX_IFS - 1; i > -1; i--) {
+		if (drvr->iflist[i])
+			inff_net_del_if(drvr, drvr->iflist[i], false);
+	}
+
+	if (inff_socitype_is_ai(bus_if)) {
+		inff_fwevt_detach(drvr);
+	} else if (inff_socitype_is_cp(bus_if)) {
+		inff_cpevt_detach(drvr);
+		inff_cp_scan_abort(&drvr->config->scan);
+	}
+
+	inff_bus_proto_detach(drvr);
+
+	if (drvr->config) {
+		inff_cfg80211_detach(drvr->config);
+		drvr->config = NULL;
+	}
+}
+
+int inff_debugfs_param_read(struct seq_file *s, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(s->private);
+
+	seq_printf(s, "%-20s: %s\n", "Name", "Value");
+	seq_printf(s, "%-20s: 0x%x\n", "debug", inff_msg_level);
+	seq_printf(s, "%-20s: %s\n", "alternative_fw_path", inff_firmware_path);
+	seq_printf(s, "%-20s: %d\n", "fcmode", bus_if->drvr->settings->fcmode);
+	seq_printf(s, "%-20s: %d\n", "roamoff", !!inff_roamoff);
+
+	return 0;
+}
+
+struct inff_mp_device *inff_get_module_param(struct device *dev)
+{
+	struct inff_mp_device *settings;
+
+	settings = kzalloc(sizeof(*settings), GFP_ATOMIC);
+	if (!settings)
+		return NULL;
+
+	/* start by using the module parameters */
+	inff_dbg(INFO, "debug: 0x%x\n", inff_msg_level);
+	strscpy(settings->firmware_path, inff_firmware_path,
+		INFF_FW_ALTPATH_LEN);
+	inff_dbg(INFO, "alternative_fw_path: %s\n", settings->firmware_path);
+
+	settings->fcmode = inff_fcmode;
+	inff_dbg(INFO, "fcmode: %d\n", settings->fcmode);
+	settings->roamoff = inff_roamoff;
+	inff_dbg(INFO, "roamoff: %d\n", settings->roamoff);
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
+	if (code == SYS_RESTART) {
+		inff_pcie_exit();
+		inff_sdio_exit();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init inff_module_init(void)
+{
+	int err;
+
+	err = inff_sdio_register();
+	if (err)
+		return err;
+
+	err = inff_pcie_register();
+	if (err) {
+		inff_sdio_exit();
+		return err;
+	}
+
+	register_reboot_notifier(&inff_reboot_notifier);
+
+	return 0;
+}
+
+static void __exit inff_module_exit(void)
+{
+	inff_pcie_exit();
+	inff_sdio_exit();
+
+	unregister_reboot_notifier(&inff_reboot_notifier);
+}
+
+module_init(inff_module_init);
+module_exit(inff_module_exit);
+
+MODULE_AUTHOR("Infineon Technologies AG");
+MODULE_DESCRIPTION("Infineon 802.11 wireless LAN fullmac driver.");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/infineon/inffmac/main.h b/drivers/net/wireless/infineon/inffmac/main.h
new file mode 100644
index 000000000000..fab91ead3d6c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/main.h
@@ -0,0 +1,377 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_MAIN_H
+#define INFF_MAIN_H
+
+#include <linux/types.h>
+#include <linux/firmware.h>
+#include <net/cfg80211.h>
+
+#include "dev_evt.h"
+#include "dev_cmd.h"
+#include "feature.h"
+
+/* The interval to poll console */
+#define INFF_CONSOLE	500
+
+/* The maximum console interval value (5 mins) */
+#define MAX_CONSOLE_INTERVAL	(5 * 60 * 1000)
+
+/*
+ * Priority definitions according 802.1D
+ */
+#define	PRIO_8021D_NONE		2
+#define	PRIO_8021D_BK		1
+#define	PRIO_8021D_BE		0
+#define	PRIO_8021D_EE		3
+#define	PRIO_8021D_CL		4
+#define	PRIO_8021D_VI		5
+#define	PRIO_8021D_VO		6
+#define	PRIO_8021D_NC		7
+
+#define MAXPRIO			7
+#define NUMPRIO			(MAXPRIO + 1)
+
+/* Bit masks for radio disabled status - returned by WL_GET_RADIO */
+
+#define WL_RADIO_SW_DISABLE       BIT(0)
+#define WL_RADIO_HW_DISABLE       BIT(1)
+/* some countries don't support any channel */
+#define WL_RADIO_COUNTRY_DISABLE  BIT(3)
+
+/* Override bit for SET_TXPWR.  if set, ignore other level limits */
+#define WL_TXPWR_OVERRIDE         BIT(31)
+
+/*
+ * Sonics Configuration Space Registers.
+ */
+
+/* core sbconfig regs are top 256bytes of regs */
+#define	SBCONFIGOFF		0xf00
+
+#define TOE_TX_CSUM_OL		0x00000001
+#define TOE_RX_CSUM_OL		0x00000002
+
+/* For supporting multiple interfaces */
+#define INFF_MAX_IFS	16
+
+/* Small, medium and maximum buffer size for dcmd
+ */
+#define INFF_DCMD_SMLEN	256
+#define INFF_DCMD_MEDLEN	1536
+#define INFF_DCMD_MAXLEN	8192
+
+/* IOCTL from host to device are limited in length. A device can only handle
+ * ethernet frame size. This limitation is to be applied by protocol layer.
+ */
+#define INFF_TX_IOCTL_MAX_MSG_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN)
+
+#define INFF_AMPDU_RX_REORDER_MAXFLOWS		256
+
+/* Length of firmware version string stored for
+ * ethtool driver info which uses 32 bytes as well.
+ */
+#define INFF_DRIVER_FIRMWARE_VERSION_LEN	32
+
+#define NDOL_MAX_ENTRIES	8
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
+ * @fcmode: FWS flow control.
+ * @roamoff: Firmware roaming off?
+ * @country_codes: If available, pointer to struct for translating country codes
+ * @bus: Bus specific platform data. Only SDIO at the mmoment.
+ */
+#define INFF_MAX_FEATURE_BYTES DIV_ROUND_UP(INFF_FEAT_LAST, 8)
+struct inff_mp_device {
+	char		firmware_path[INFF_FW_ALTPATH_LEN];
+	int		fcmode;
+	unsigned int	roamoff;
+	const char	*board_type;
+	unsigned char	mac[ETH_ALEN];
+	union {
+		struct inff_sdio_platform_data sdio;
+	} bus;
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
+/**
+ * struct inff_ampdu_rx_reorder - AMPDU receive reorder info
+ *
+ * @flow_id: AMPDU flow identifier.
+ * @cur_idx: last AMPDU index from firmware.
+ * @exp_idx: expected next AMPDU index.
+ * @max_idx: maximum amount of packets per AMPDU.
+ * @pend_pkts: number of packets currently in @pktslots.
+ * @pktslots: array for ordering AMPDU packets.
+ */
+struct inff_ampdu_rx_reorder {
+	u8 flow_id;
+	u8 cur_idx;
+	u8 exp_idx;
+	u8 max_idx;
+	u8 pend_pkts;
+	struct sk_buff *pktslots[];
+};
+
+/* Forward decls for struct inff_pub (see below) */
+struct inff_proto;	/* device communication protocol info */
+struct inff_fws_info;	/* firmware signalling info */
+struct inff_mp_device;	/* module parameters, device specific */
+
+/*
+ * struct inff_rev_info
+ *
+ * The result field stores the error code of the
+ * revision info request from firmware. For the
+ * other fields see struct inff_rev_info_le in
+ * fwil_types.h
+ */
+struct inff_rev_info {
+	int result;
+	u32 vendorid;
+	u32 deviceid;
+	u32 radiorev;
+	u32 corerev;
+	u32 boardid;
+	u32 boardvendor;
+	u32 boardrev;
+	u32 driverrev;
+	u32 ucoderev;
+	u32 bus;
+	char chipname[12];
+	u32 phytype;
+	u32 phyrev;
+	u32 anarev;
+	u32 chippkg;
+	u32 nvramrev;
+};
+
+/** wlc interface version */
+struct inff_wlc_version {
+	/* wlc interface version numbers */
+	u16	wlc_ver_major;		/**< wlc interface major version number */
+	u16	wlc_ver_minor;		/**< wlc interface minor version number */
+};
+
+/* Common structure for module and instance linkage */
+struct inff_pub {
+	/* Linkage ponters */
+	struct inff_bus *bus_if;
+	struct inff_proto *proto;
+	struct wiphy *wiphy;
+	struct cfg80211_ops *ops;
+	struct inff_cfg80211_info *config;
+
+	/* Internal inff items */
+	uint hdrlen;		/* Total INFF header length (proto + bus) */
+
+	/* Dongle media info */
+	char fwver[INFF_DRIVER_FIRMWARE_VERSION_LEN];
+	u8 mac[ETH_ALEN];		/* MAC address obtained from dongle */
+
+	struct mac_address addresses[INFF_MAX_IFS];
+
+	struct inff_if *iflist[INFF_MAX_IFS];
+	s32 if2bss[INFF_MAX_IFS];
+
+	struct mutex proto_block;	/* used to protect proto resource */
+	unsigned char proto_buf[INFF_DCMD_MAXLEN];
+
+	struct inff_fwevt_info fwevt;
+
+	struct inff_ampdu_rx_reorder
+		*reorder_flows[INFF_AMPDU_RX_REORDER_MAXFLOWS];
+
+	u8 feat_flags[DIV_ROUND_UP(INFF_FEAT_LAST, 8)];
+	u32 chip_quirks;
+	int req_mpc;
+
+	struct inff_rev_info revinfo;
+	struct inff_wlc_version wlc_ver;
+#ifdef DEBUG
+	struct dentry *dbgfs_dir;
+#endif
+
+	struct inff_mp_device *settings;
+
+	struct work_struct bus_reset;
+
+	u8 clmver[INFF_DCMD_SMLEN];
+	u8 sta_mac_idx;
+	struct inff_pkt_filter_enable_le pkt_filter[MAX_PKT_FILTER_COUNT];
+	u16 cnt_ver;
+
+	struct inff_dfu *dfu;
+	struct inff_cpevt_info evi;
+};
+
+/* forward declarations */
+struct inff_cfg80211_vif;
+struct inff_fws_mac_descriptor;
+
+#define INFF_BSSIDX_INVALID			-1
+
+/**
+ * struct inff_if - interface control information.
+ *
+ * @drvr: points to device related information.
+ * @vif: points to cfg80211 specific interface information.
+ * @ndev: associated network device.
+ * @multicast_work: wiphy work object for multicast provisioning.
+ * @fws_desc: interface specific firmware-signalling descriptor.
+ * @ifidx: interface index in device firmware.
+ * @bsscfgidx: index of bss associated with this interface.
+ * @mac_addr: assigned mac address.
+ * @netif_stop: bitmap indicates reason why netif queues are stopped.
+ * @netif_stop_lock: spinlock for update netif_stop from multiple sources.
+ * @pend_8021x_cnt: tracks outstanding number of 802.1x frames.
+ * @pend_8021x_wait: used for signalling change in count.
+ * @fwil_fwerr: flag indicating fwil layer should return firmware error codes.
+ * @sta_list: dll of associated stations.
+ * @sta_list_lock: station list lock.
+ * @twt_sess_list: dll of TWT sessions.
+ * @twt_sess_list_lock: TWT session list lock.
+ * @twt_timeout_work: TWT firmware event timeout work.
+ * @fmac_pkt_fwd_en: Driver packet forward enabled for AP Mode.
+ * @napi: NAPI structure for handling the RX packets received on this interface.
+ * @napi_gro: NAPI GRO Receive enabled flag.
+ */
+struct inff_if {
+	struct inff_pub *drvr;
+	struct inff_cfg80211_vif *vif;
+	struct net_device *ndev;
+	struct wiphy_work multicast_work;
+	struct inff_fws_mac_descriptor *fws_desc;
+	int ifidx;
+	s32 bsscfgidx;
+	bool isap;
+	u8 mac_addr[ETH_ALEN];
+	u8 netif_stop;
+	spinlock_t netif_stop_lock;	/* used to protect netif_stop resource */
+	atomic_t pend_8021x_cnt;
+	wait_queue_head_t pend_8021x_wait;
+	bool fwil_fwerr;
+	struct list_head sta_list;
+	spinlock_t sta_list_lock;	/* used to protect STA list */
+	struct list_head twt_sess_list;
+	spinlock_t twt_sess_list_lock;	/* used to protect TWT session list */
+	struct wiphy_delayed_work twt_timeout_work;
+	bool fmac_pkt_fwd_en;
+	struct napi_struct napi;
+	bool napi_gro;
+	bool connected;
+};
+
+struct ether_addr {
+	u8 octet[ETH_ALEN];
+};
+
+#define INFF_IF_STA_LIST_LOCK_INIT(ifp) spin_lock_init(&(ifp)->sta_list_lock)
+#define INFF_IF_STA_LIST_LOCK(ifp, flags) \
+	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags))
+#define INFF_IF_STA_LIST_UNLOCK(ifp, flags) \
+	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags))
+
+#define INFF_STA_NULL ((struct inff_sta *)NULL)
+
+/*
+ * struct inff_sta - Per STA param.
+ *
+ * @ifp: associated inff_if pointer.
+ * @ea: station ethernet MAC address.
+ * @list: link to inff_if::sta_list.
+ */
+struct inff_sta {
+	void *ifp;
+	struct ether_addr ea;
+	struct list_head list;
+};
+
+bool inff_socitype_is_ai(struct inff_bus *bus);
+bool inff_socitype_is_cp(struct inff_bus *bus);
+/* Return pointer to interface name */
+char *inff_ifname(struct inff_if *ifp);
+struct inff_if *inff_get_ifp(struct inff_pub *drvr, int ifidx);
+int inff_rx_hdrpull(struct inff_pub *drvr, struct sk_buff *skb,
+		    struct inff_if **ifp);
+void inff_txfinalize(struct inff_if *ifp, struct sk_buff *txp, bool success);
+/* Request from bus module to initiate a coredump */
+void inff_dev_coredump(struct device *dev);
+/* Indication that firmware has halted or crashed */
+void inff_fw_crashed(struct device *dev);
+int inff_netdev_wait_pend8021x(struct inff_if *ifp);
+
+int inff_pktfilter_add_remove(struct net_device *ndev, int filter_num,
+			      bool add);
+int inff_pktfilter_enable(struct net_device *ndev, bool enable);
+
+struct inff_sta *inff_find_sta(struct inff_if *ifp, const u8 *ea);
+void inff_del_sta(struct inff_if *ifp, const u8 *ea);
+struct inff_sta *inff_findadd_sta(struct inff_if *ifp, const u8 *ea);
+
+void inff_set_joinpref_default(struct inff_if *ifp);
+int inff_set_cur_etheraddr(struct inff_if *ifp, const u8 *addr);
+
+/* Indication from bus module regarding presence/insertion of dongle. */
+int inff_bus_attach(struct device *dev, bool start_bus);
+/* Indication from bus module regarding removal/absence of dongle */
+void inff_bus_detach(struct device *dev);
+
+int inff_debugfs_param_read(struct seq_file *s, void *data);
+struct inff_mp_device *inff_get_module_param(struct device *dev);
+void inff_release_module_param(struct inff_mp_device *module_param);
+#endif /* INFF_MAIN_H */
-- 
2.25.1


