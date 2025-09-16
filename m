Return-Path: <linux-wireless+bounces-27358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC61B7DB63
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9637B5D3E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB384A3E;
	Tue, 16 Sep 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="eIsc4knG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E99222566
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061221; cv=none; b=hMeAYcKX5oLbdQXCJYpb+apJTCzLCM/PQoAv4PM+Ob4C++ZqtZKWW8k10F/OYeRXsRJFVJTCFgso/mFQlEIK4qEKiA4kdBMU/tLxY56wS3oznks6mI6kqih74UIwottZ7bWknh6PzzaO4bJvOgNknoni/tjBVA9pvpxAVlF7P5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061221; c=relaxed/simple;
	bh=pE1MEA2g2iI5/HhNfssVsltu5S/yQYfj63u7t7qydAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysw1J6WyK6CSoMzIGnlWAtrdH9yx1RgEaULwAC4GcYjxDLQkpGy6M+PCSGJwCZYmN020uXfhW/SGckdjK8ypBg4eqYoUA3C1ctOv7KQHg0OidUCRlwik/d6Mib7/fG1L/vqIo5mUA9OvyGTgLKfcsp9eU3q2m7q1mmWtayVNBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=eIsc4knG; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061219; x=1789597219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pE1MEA2g2iI5/HhNfssVsltu5S/yQYfj63u7t7qydAM=;
  b=eIsc4knG1HsxLH7mluUUi5XCfZW6ySOPk3rlWEKmbge5ijFmmUoT/6mE
   QJwpxMhYaICVHZ9ius+z7aof3Vdv4UH3VaG4ChZCsGAYUfBPBtn/uAzzu
   9W3jHwhLWqfRQFdu+2RsczB+Yx5TfD5LhxnuHtaPcKZjWUVDHgiBanIu8
   Q=;
X-CSE-ConnectionGUID: DBQ97rRJQuiILw2PinudXw==
X-CSE-MsgGUID: a3aQzbdVQlW8NQ9EYn+8/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918155"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918155"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:20:13 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:20:12 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:20:09 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 08/57] wifi: inffmac: add wlan_sense.c/h
Date: Wed, 17 Sep 2025 03:47:23 +0530
Message-ID: <20250916221821.4387-9-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of WLAN sensing (802.11bf) Measurement. Handles the
WLAN Sensing PMSR requests from cfg80211 and sends the configs to the
Device firmware. Also collects Channel State Information (CSI) from the
WLAN device and notifies it to the userspace through the cfg80211 driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/wlan_sense.c    | 916 ++++++++++++++++++
 .../wireless/infineon/inffmac/wlan_sense.h    | 177 ++++
 2 files changed, 1093 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/wlan_sense.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/wlan_sense.h

diff --git a/drivers/net/wireless/infineon/inffmac/wlan_sense.c b/drivers/net/wireless/infineon/inffmac/wlan_sense.c
new file mode 100644
index 000000000000..083586767980
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/wlan_sense.c
@@ -0,0 +1,916 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/rtnetlink.h>
+
+#include "core.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "fwil.h"
+#include "feature.h"
+#include "bus.h"
+#include "pmsr.h"
+
+/**
+ * inff_wlan_sense_stats_read() - Read the contents of the debugfs file "wlan_sense_stats".
+ *
+ * @seq: sequence for debugfs entry.
+ * @data: raw data pointer.
+ *
+ * return: 0.
+ */
+int
+inff_wlan_sense_stats_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_if *ifp = NULL;
+	struct inff_cfg80211_info *cfg80211_info = NULL;
+	struct inff_wlan_sense_info *wlan_sense = NULL;
+	struct inff_wlan_sense_cfg *cfg = NULL;
+	struct inff_wlan_sense_counters *counters = NULL;
+	int i, j;
+
+	if (!inff_feat_is_enabled(inff_get_ifp(drvr, 0), INFF_FEAT_WLAN_SENSE)) {
+		inff_err("the low layer not support WLAN SENSE\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Iterate the interface list in struct inff_pub */
+	for (i = 0; i < INFF_MAX_IFS; i++) {
+		ifp = drvr->iflist[i];
+
+		if (!ifp || !ifp->vif ||
+		    ifp->vif->wdev.iftype != NL80211_IFTYPE_WLAN_SENSE)
+			continue;
+
+		cfg80211_info = ifp->drvr->config;
+		wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+		if (!wlan_sense)
+			continue;
+		cfg = &wlan_sense->cfg;
+		counters = &wlan_sense->counters;
+
+		seq_printf(seq, "ifname: %s, ifidx: %u, bsscfgidx: %d: MAC: %pM\n",
+			   inff_ifname(ifp), ifp->ifidx, ifp->bsscfgidx,
+			   wlan_sense->dev_addr.octet);
+
+		/* WLAN Sensing Started */
+		seq_printf(seq, "\tSensing State: %s\n",
+			   wlan_sense->sensing ? "ENABLED" : "DISABLED");
+
+		/* WLAN Sensing Schedule Configuration */
+		seq_puts(seq, "\tSensing Schedule Config:\n");
+		seq_printf(seq, "\t\tInterval  : %u ms%s\n", cfg->interval,
+			   cfg->interval ? "" : " (Non-Periodic)");
+		seq_printf(seq, "\t\tDuration  : %u ms\n", cfg->duration);
+
+		/* WLAN Sensing Mode Configuration */
+		seq_puts(seq, "\tSensing Mode Config:\n");
+		seq_printf(seq, "\t\t%s Mode\n",
+			   cfg->mode_flags & INFF_WLAN_SENSE_MODE_SOLICITED ?
+			   "Solicited" : "Un-Soclited");
+		seq_printf(seq, "\t\t%s Mode\n",
+			   cfg->mode_flags & INFF_WLAN_SENSE_MODE_ASSOCIATED ?
+			   "Associated" : "Un-Associated");
+
+		/* WLAN Sensing Filter Configuration */
+		seq_puts(seq, "\tSensing Filter Config:\n");
+		seq_printf(seq, "\t\tBSS Scope :%u\n", cfg->filter.bss_scope);
+		seq_printf(seq, "\t\tIgnore FCS:%u\n", cfg->filter.ignore_fcs);
+
+		seq_puts(seq, "\t\tFrame Transmitter ADDR:\n");
+		for (j = 0; j < INFF_WLAN_SENSE_FILTER_FRM_RA_NUM; j++)
+			seq_printf(seq, "\t\t\t#%u: %pM\n", j,
+				   cfg->filter.ta[j].octet);
+
+		seq_puts(seq, "\t\tFrame Type & Subtype:\n");
+		for (j = 0; j < INFF_WLAN_SENSE_FILTER_FRM_TYP_SUBTYP_NUM; j++)
+			seq_printf(seq, "\t\t\t#%u: 0x%x\n", j,
+				   cfg->filter.frmtyp_subtyp[j]);
+
+		seq_puts(seq, "\tCSI Fragment & De-fragemented Data realted Counters:\n");
+		seq_printf(seq, "\t\tFragment avail FW Event Total                : %u\n",
+			   counters->csi_frag_fw_evt_tot_ct);
+		seq_printf(seq, "\t\tFragment avail FW Event handle Success       : %u\n",
+			   counters->csi_frag_fw_evt_handle_succ_ct);
+		seq_printf(seq, "\t\tFragment avail FW Event handle Failure       : %u\n",
+			   counters->csi_frag_fw_evt_handle_fail_ct);
+	}
+
+	return 0;
+}
+
+static inline void
+inff_wlan_sense_dump_fil_cfg(struct inff_wlan_sense_fil_cfg fil_cfg)
+{
+	inff_dbg(WLAN_SENSE, "FIL CONFIG  :\n"
+		  "csi_enable                   : %u\n"
+		  "capture_interval_ms          : %d\n"
+		  "capture_duration_ms          : %u\n"
+		  "solicit_mode                 : %u\n"
+		  "assoc_mode                   : %u\n"
+		  "bss_mode                     : %u\n"
+		  "ignore_fcs                   : %u\n"
+		  "macaddr[0]                   : %pM\n"
+		  "macaddr[1]                   : %pM\n"
+		  "macaddr[2]                   : %pM\n"
+		  "macaddr[3]                   : %pM\n"
+		  "chanspec                     : %u\n"
+		  "multi_csi_per_mac            : %u\n"
+		  "link_protection              : %u\n"
+		  "subcarriers                  : %u\n"
+		  "frmtyp_subtyp[0]             : %u\n"
+		  "frmtyp_subtyp[1]             : %u\n",
+		  fil_cfg.csi_enable,
+		  fil_cfg.capture_interval_ms,
+		  fil_cfg.capture_duration_ms,
+		  fil_cfg.solicit_mode,
+		  fil_cfg.assoc_mode,
+		  fil_cfg.bss_mode,
+		  fil_cfg.ignore_fcs,
+		  fil_cfg.macaddr[0].octet,
+		  fil_cfg.macaddr[1].octet,
+		  fil_cfg.macaddr[2].octet,
+		  fil_cfg.macaddr[3].octet,
+		  fil_cfg.chanspec,
+		  fil_cfg.multi_csi_per_mac,
+		  fil_cfg.link_protection,
+		  fil_cfg.subcarriers,
+		  fil_cfg.frmtyp_subtyp[0],
+		  fil_cfg.frmtyp_subtyp[1]);
+}
+
+/**
+ * inff_wlan_sense_generate_vif_mac() - derive mac addresses for WLAN Sensing.
+ *
+ * @wlan_sense: WLAN Sensing specific data.
+ * @dev_addr: optional device address.
+ *
+ * WLAN Sensing interface needs mac address. If no device
+ * address it specified, these are derived from a random ethernet
+ * address.
+ */
+static void
+inff_wlan_sense_generate_vif_mac(struct inff_wlan_sense_info *wlan_sense, u8 *dev_addr)
+{
+	struct inff_cfg80211_info *cfg80211_info = wlan_sense->cfg80211_info;
+	struct inff_if *pri_ifp;
+
+	pri_ifp = netdev_priv(cfg_to_ndev(cfg80211_info));
+
+	if (!dev_addr || is_zero_ether_addr(dev_addr)) {
+		/* Generate the WLAN Sensing Device Address obtaining a random ethernet
+		 * address with the locally administered bit set.
+		 */
+		eth_random_addr(wlan_sense->dev_addr.octet);
+	} else {
+		memcpy(wlan_sense->dev_addr.octet, dev_addr, ETH_ALEN);
+	}
+
+	wlan_sense->dev_addr.octet[0] |= 0x02;
+}
+
+/**
+ * inff_wlan_sense_add_vif() - create a new WLAN Sensing virtual interface.
+ *
+ * @wiphy: wiphy device of new interface.
+ * @name: name of the new interface.
+ * @name_assign_type: origin of the interface name
+ * @iftype: nl80211 interface type.
+ * @params: contains mac address for WLAN Sensing device.
+ */
+struct wireless_dev *
+inff_wlan_sense_add_vif(struct wiphy *wiphy, const char *name,
+			unsigned char name_assign_type,
+			enum nl80211_iftype iftype,
+			struct vif_params *params)
+{
+	struct inff_cfg80211_info *cfg80211_info = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg80211_info->pub;
+	struct inff_if *pri_ifp;
+	struct inff_if *wlan_sense_ifp;
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	struct inff_cfg80211_vif *wlan_sense_vif;
+	struct inff_fil_wlan_sense_if_le if_request;
+	int err = 0;
+
+	pri_ifp = netdev_priv(cfg_to_ndev(cfg80211_info));
+
+	if (!inff_feat_is_enabled(pri_ifp, INFF_FEAT_WLAN_SENSE) ||
+	    iftype != NL80211_IFTYPE_WLAN_SENSE)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (inff_cfg80211_vif_event_armed(cfg80211_info))
+		return ERR_PTR(-EBUSY);
+
+	inff_dbg(INFO, "adding vif \"%s\" (type=%d)\n", name, iftype);
+
+	wlan_sense_vif = inff_alloc_vif(wlan_sense->cfg80211_info, NL80211_IFTYPE_WLAN_SENSE);
+	if (IS_ERR(wlan_sense_vif)) {
+		iphy_err(drvr, "could not create discovery vif\n");
+		return (struct wireless_dev *)wlan_sense_vif;
+	}
+
+	/* firmware requires unique mac address for wlan_sensedev interface */
+	if (params && ether_addr_equal(params->macaddr, pri_ifp->mac_addr)) {
+		iphy_err(drvr, "wlan_sense vif must be different from primary interface\n");
+		err = -EINVAL;
+		goto fail;
+	}
+
+	/* Generate MAC */
+	inff_wlan_sense_generate_vif_mac(wlan_sense, params->macaddr);
+
+	/* fill the firmware request */
+	ether_addr_copy(if_request.addr.octet, wlan_sense->dev_addr.octet);
+	inff_fweh_wlan_sensedev_setup(pri_ifp, true);
+
+	inff_cfg80211_arm_vif_event(wlan_sense->cfg80211_info, wlan_sense_vif);
+	/* Create WLAN Sensing interface in the firmware */
+	err = inff_fil_iovar_data_set(pri_ifp, "csi_ifadd", &if_request,
+				      sizeof(struct inff_fil_wlan_sense_if_le));
+	if (err < 0) {
+		iphy_err(drvr, "set csi_ifadd error\n");
+		inff_fweh_wlan_sensedev_setup(pri_ifp, false);
+		inff_cfg80211_arm_vif_event(wlan_sense->cfg80211_info, NULL);
+		goto fail;
+	}
+
+	/* wait for firmware event */
+	err = inff_cfg80211_wait_vif_event(wlan_sense->cfg80211_info, INFF_E_IF_ADD,
+					   INFF_VIF_EVENT_TIMEOUT);
+	inff_cfg80211_arm_vif_event(wlan_sense->cfg80211_info, NULL);
+	inff_fweh_wlan_sensedev_setup(pri_ifp, false);
+	if (!err) {
+		iphy_err(drvr, "timeout occurred\n");
+		err = -EIO;
+		goto fail;
+	}
+
+	/* WLAN Sensing interface created */
+	wlan_sense_ifp = wlan_sense_vif->ifp;
+	wlan_sense->vif = wlan_sense_vif;
+	ether_addr_copy(wlan_sense_ifp->mac_addr, wlan_sense->dev_addr.octet);
+	ether_addr_copy(wlan_sense_vif->wdev.address, wlan_sense->dev_addr.octet);
+
+	return &wlan_sense_vif->wdev;
+fail:
+	inff_free_vif(wlan_sense_vif);
+	return ERR_PTR(err);
+}
+
+void inff_wlan_sense_ifp_removed(struct inff_if *ifp, bool locked)
+{
+	struct inff_cfg80211_info *cfg;
+	struct inff_cfg80211_vif *vif;
+
+	inff_dbg(INFO, "WLAN Sense: device interface removed\n");
+	vif = ifp->vif;
+	cfg = wdev_to_cfg(&vif->wdev);
+	cfg->pmsr_info->wlan_sense_info->vif = NULL;
+	if (!locked) {
+		rtnl_lock();
+		wiphy_lock(cfg->wiphy);
+		cfg80211_unregister_wdev(&vif->wdev);
+		wiphy_unlock(cfg->wiphy);
+		rtnl_unlock();
+	} else {
+		cfg80211_unregister_wdev(&vif->wdev);
+	}
+	inff_free_vif(vif);
+}
+
+/**
+ * inff_wlan_sense_del_vif() - delete a WLAN sensing virtual interface.
+ *
+ * @wiphy: wiphy device of interface.
+ * @wdev: wireless device of interface.
+ */
+int
+inff_wlan_sense_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg80211_info = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg80211_info->pub;
+	struct inff_if *wlan_sense_ifp = NULL;
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	struct inff_cfg80211_vif *vif;
+	enum nl80211_iftype iftype;
+	int err;
+
+	vif = wdev_to_vif(wdev);
+	if (!vif) {
+		err = -EIO;
+		goto fail;
+	}
+
+	wlan_sense_ifp = vif->ifp;
+	if (!wlan_sense_ifp) {
+		err = -EIO;
+		goto fail;
+	}
+
+	if (!inff_feat_is_enabled(wlan_sense_ifp, INFF_FEAT_WLAN_SENSE))
+		return -EOPNOTSUPP;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	iftype = vif->wdev.iftype;
+
+	if (iftype != NL80211_IFTYPE_WLAN_SENSE)
+		return -EOPNOTSUPP;
+
+	inff_dbg(WLAN_SENSE, "delete WLAN Sensing vif wlan_sense_ifp=0x%p\n",
+		 wlan_sense_ifp);
+
+	inff_cfg80211_arm_vif_event(cfg80211_info, vif);
+	err = inff_fil_iovar_data_set(wlan_sense_ifp, "csi_ifdel", wlan_sense->dev_addr.octet,
+				      ETH_ALEN);
+	if (err) {
+		iphy_err(drvr, "set csi_ifdel error\n");
+		goto fail;
+	}
+
+	/* wait for firmware event */
+	err = inff_cfg80211_wait_vif_event(cfg80211_info, INFF_E_IF_DEL,
+					   INFF_VIF_EVENT_TIMEOUT);
+	if (err)
+		err = -EIO;
+
+	inff_remove_interface(drvr->iflist[wlan_sense_ifp->bsscfgidx], true);
+
+	inff_cfg80211_arm_vif_event(cfg80211_info, NULL);
+fail:
+	return err;
+}
+
+/**
+ * inff_wlan_sense_enabled_event_handler() - Handle the WLAN Sensing enabled Event notification
+ *	from the Firmware.
+ *
+ */
+static s32
+inff_wlan_sense_enabled_event_handler(struct inff_if *ifp, const struct inff_event_msg *e,
+				      void *data)
+{
+	struct inff_cfg80211_info *cfg80211_info = ifp->drvr->config;
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	struct inff_wlan_sense_cfg *cfg = &wlan_sense->cfg;
+	struct inff_wlan_sense_fil_cfg fil_cfg = { 0 };
+	int i = 0;
+	s32 ret = 0;
+
+	ret = inff_fil_iovar_data_get(ifp, "csi", &fil_cfg,
+				      sizeof(struct inff_wlan_sense_fil_cfg));
+	if (ret) {
+		inff_err("WLAN SENSE: WLAN Sensing Config Fetch failed, Firmware error (%d)",
+			 ret);
+		goto fail;
+	}
+
+	/* WLAN Sensing Started */
+	wlan_sense->sensing = fil_cfg.csi_enable ? true : false;
+
+	/* WLAN Sensing Schedule Configuration */
+	if (le32_to_cpu(fil_cfg.capture_interval_ms) == -1)
+		cfg->interval = 0;
+	else
+		cfg->interval = le32_to_cpu(fil_cfg.capture_interval_ms);
+
+	cfg->duration = le16_to_cpu(fil_cfg.capture_duration_ms);
+
+	/* WLAN Sensing Mode Configuration */
+	cfg->mode_flags |= (fil_cfg.solicit_mode ? INFF_WLAN_SENSE_MODE_SOLICITED : 0);
+	cfg->mode_flags |= (fil_cfg.assoc_mode ? INFF_WLAN_SENSE_MODE_ASSOCIATED : 0);
+
+	/* WLAN Sensing Filter Configuration */
+	cfg->filter.bss_scope = fil_cfg.bss_mode;
+	cfg->filter.ignore_fcs = fil_cfg.ignore_fcs ? true : false;
+
+	for (i = 0; i < INFF_WLAN_SENSE_FILTER_FRM_RA_NUM; i++)
+		ether_addr_copy(cfg->filter.ta[i].octet, fil_cfg.macaddr[i].octet);
+
+	for (i = 0; i < INFF_WLAN_SENSE_FILTER_FRM_TYP_SUBTYP_NUM; i++) {
+		cfg->filter.frmtyp_subtyp[i] = 0;
+
+		cfg->filter.frmtyp_subtyp[i] |= ((fil_cfg.frmtyp_subtyp[i] & 0x3) << 4);
+		cfg->filter.frmtyp_subtyp[i] |= ((fil_cfg.frmtyp_subtyp[i] >> 2) & 0xF);
+	}
+
+fail:
+	return ret;
+}
+
+/**
+ * inff_wlan_sense_data_avail_event_handler() - Handle the new CSI data available event
+ *	notification from the Firmware.
+ *
+ */
+static s32
+inff_wlan_sense_data_avail_event_handler(struct inff_if *ifp,
+					 const struct inff_event_msg *emsg_hdr,
+					 void *emsg)
+{
+	struct inff_cfg80211_info *cfg80211_info = ifp->drvr->config;
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	struct inff_csi_data_frag_hdr *frag_hdr = (struct inff_csi_data_frag_hdr *)emsg;
+	struct cfg80211_pmsr_result result = {0};
+	u32 frag_hdr_len = sizeof(struct inff_csi_data_frag_hdr);
+	void *data_frag = NULL;
+	u32 data_frag_len = 0, data_buf_old_len = 0, data_buf_new_len = 0;
+	struct inff_wlan_sense_counters *counters;
+	unsigned char *data_buf = NULL;
+	s32 ret = 0;
+
+	/* Check if WLAN Sensing is in progress, before handling data available event */
+	if (!wlan_sense || !wlan_sense->sensing)
+		return -EINVAL;
+
+	counters = &wlan_sense->counters;
+
+	data_frag_len = emsg_hdr->datalen - frag_hdr_len;
+	data_frag = emsg + frag_hdr_len;
+	inff_dbg(TRACE, "CSI Data frag len: %u frag num: %d frag ct: %d seq: %d  hdr: %d\n",
+		 data_frag_len, frag_hdr->fragment_num, frag_hdr->total_fragments,
+		 frag_hdr->sequence_num, frag_hdr->hdr_version);
+
+	counters->csi_frag_fw_evt_tot_ct++;
+
+	/*
+	 * TODO: Need to handle sequence number, fragment number mismatches.
+	 * Also need check fragment header version.
+	 */
+
+	if (frag_hdr->fragment_num == 0) {
+		/* Handling Head fragment of CSI Data */
+		wlan_sense->data_buf = kcalloc(data_frag_len, sizeof(char), GFP_KERNEL);
+		if (!wlan_sense->data_buf)
+			goto fail;
+
+		data_buf = wlan_sense->data_buf;
+		wlan_sense->data_buf_len = data_frag_len;
+	} else {
+		/* Handling Body fragment of CSI Data */
+		data_buf_old_len = wlan_sense->data_buf_len;
+		data_buf_new_len = data_buf_old_len + data_frag_len;
+
+		if (data_buf_new_len > INFF_WLAN_SENSE_DATA_LEN_MAX) {
+			counters->csi_frag_fw_evt_handle_fail_ct++;
+			goto skip_data_frag;
+		}
+
+		data_buf = wlan_sense->data_buf;
+		wlan_sense->data_buf = krealloc(data_buf, data_buf_new_len,
+						GFP_KERNEL);
+		if (!wlan_sense->data_buf) {
+			kfree(data_buf);
+			goto fail;
+		}
+
+		data_buf = wlan_sense->data_buf + data_buf_old_len;
+		wlan_sense->data_buf_len = data_buf_new_len;
+	}
+
+	/* Copy CSI Data Fragment into the CSI Data buf */
+	memcpy(data_buf, data_frag, data_frag_len);
+
+	counters->csi_frag_fw_evt_handle_succ_ct++;
+
+skip_data_frag:
+	if (frag_hdr->fragment_num == (frag_hdr->total_fragments - 1)) {
+		inff_dbg(TRACE, "CSI Data len: %u", wlan_sense->data_buf_len);
+		result.host_time = (u64)ktime_to_ns(ktime_get_boottime());
+		result.status = NL80211_PMSR_STATUS_SUCCESS;
+		result.final = 0;
+		result.type = NL80211_PMSR_TYPE_SENSING;
+		result.sensing.seq_number = frag_hdr->sequence_num;
+		result.sensing.data_len = wlan_sense->data_buf_len;
+		result.sensing.data = wlan_sense->data_buf;
+
+		cfg80211_pmsr_report(&ifp->vif->wdev, wlan_sense->sense_req,
+				     &result, GFP_KERNEL);
+		kfree(wlan_sense->data_buf);
+	}
+
+	return ret;
+fail:
+	counters->csi_frag_fw_evt_handle_fail_ct++;
+	inff_err("WLAN SENSE: Failed to allocate buffer for CSI Fragment Data\n");
+	return -ENOMEM;
+}
+
+/**
+ * inff_wlan_sense_disabled_event_handler() - Handle the WLAN Sensing disabled Event
+ *	notification from the Firmware.
+ *
+ */
+static s32
+inff_wlan_sense_disabled_event_handler(struct inff_if *ifp, const struct inff_event_msg *e,
+				       void *data)
+{
+	struct inff_cfg80211_info *cfg80211_info = ifp->drvr->config;
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	s32 ret = 0;
+
+	if (!wlan_sense)
+		return ret;
+
+	/* WLAN Sensing Stopped */
+	wlan_sense->sensing = false;
+
+	/* complete the PMSR request */
+	cfg80211_pmsr_complete(&ifp->vif->wdev, wlan_sense->sense_req, GFP_KERNEL);
+	wlan_sense->sense_req = NULL;
+
+	return ret;
+}
+
+/**
+ * inff_notify_wlan_sense_event() - Handle the WLAN SENSE Event notifications from Firmware.
+ *
+ * @ifp: interface instatnce.
+ * @e: event message.
+ * @data: CSI data
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+s32
+inff_notify_wlan_sense_event(struct inff_if *ifp, const struct inff_event_msg *e,
+			     void *data)
+{
+	s32 ret = 0;
+
+	inff_dbg(WLAN_SENSE, "WLAN SENSE: EVENT from firmware\n");
+
+	if (!ifp) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	switch (e->event_code) {
+	case INFF_E_WLAN_SENSE_ENABLED:
+		ret = inff_wlan_sense_enabled_event_handler(ifp, e, data);
+		if (ret) {
+			inff_err("WLAN_SENSE: EVENT: Failed to handle ENABLED event ret=%d\n",
+				 ret);
+			goto exit;
+		}
+		inff_dbg(WLAN_SENSE, "WLAN SENSE: ENABLED\n");
+		break;
+	case INFF_E_WLAN_SENSE_DATA:
+		ret = inff_wlan_sense_data_avail_event_handler(ifp, e, data);
+		if (ret) {
+			inff_err("WLAN_SENSE: EVENT: Failed to handle Data event ret=%d\n", ret);
+			goto exit;
+		}
+		break;
+	case INFF_E_WLAN_SENSE_DISABLED:
+		ret = inff_wlan_sense_disabled_event_handler(ifp, e, data);
+		if (ret) {
+			inff_err("WLAN_SENSE: EVENT: Failed to handle DISABLED event ret=%d\n",
+				 ret);
+			goto exit;
+		}
+		inff_dbg(WLAN_SENSE, "WLAN SENSE: DISABLED\n");
+		break;
+	default:
+		inff_err("WLAN_SENSE: Received event %d not handled", e->event_code);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+exit:
+	return ret;
+}
+
+/**
+ * inff_wlan_sense_enable_oper_handler() - Handle the WLAN Sense enable Operation request
+ *	from Userspace.
+ *
+ * @ifp: interface instance.
+ * @cfg: WLAN Sense parameters.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_wlan_sense_enable_oper_handler(struct inff_if *ifp, struct inff_wlan_sense_cfg cfg)
+{
+	struct inff_wlan_sense_fil_cfg fil_cfg;
+	int i = 0;
+	s32 ret = 0;
+
+	memset(&fil_cfg, 0, sizeof(struct inff_wlan_sense_fil_cfg));
+
+	/* Enable WLAN Sensing Functionality */
+	fil_cfg.csi_enable = 1;
+
+	/* WLAN Sensing Schedule Configuration */
+	if (cfg.interval == 0)
+		fil_cfg.capture_interval_ms = cpu_to_le32(-1);
+	else
+		fil_cfg.capture_interval_ms = cpu_to_le32(cfg.interval);
+
+	fil_cfg.capture_duration_ms = cpu_to_le16(cfg.duration);
+
+	/* WLAN Sensing Mode Configuration */
+	fil_cfg.solicit_mode = (cfg.mode_flags & INFF_WLAN_SENSE_MODE_SOLICITED) ? 1 : 0;
+	fil_cfg.assoc_mode = (cfg.mode_flags & INFF_WLAN_SENSE_MODE_ASSOCIATED) ? 1 : 0;
+
+	/* WLAN Sensing Filter Configuration */
+	fil_cfg.bss_mode = cfg.filter.bss_scope;
+	fil_cfg.ignore_fcs = cfg.filter.ignore_fcs ? 1 : 0;
+
+	for (i = 0; i < INFF_WLAN_SENSE_FILTER_FRM_RA_NUM; i++)
+		ether_addr_copy(fil_cfg.macaddr[i].octet, cfg.filter.ta[i].octet);
+
+	for (i = 0; i < INFF_WLAN_SENSE_FILTER_FRM_TYP_SUBTYP_NUM; i++) {
+		fil_cfg.frmtyp_subtyp[i] |= ((cfg.filter.frmtyp_subtyp[i] & 0xF) << 2);
+		fil_cfg.frmtyp_subtyp[i] |= ((cfg.filter.frmtyp_subtyp[i] >> 4) & 0x3);
+	}
+
+	fil_cfg.multi_csi_per_mac = 1;
+	fil_cfg.link_protection = 0;
+	fil_cfg.chanspec = 255;
+	fil_cfg.subcarriers = 0;
+
+	ret = inff_fil_iovar_data_set(ifp, "csi", &fil_cfg,
+				      sizeof(struct inff_wlan_sense_fil_cfg));
+	if (ret) {
+		inff_err("WLAN SENSE: ENABLE: Failed, Firmware error (%d)", ret);
+		goto fail;
+	}
+
+	inff_wlan_sense_dump_fil_cfg(fil_cfg);
+fail:
+	return ret;
+}
+
+/**
+ * inff_wlan_sense_disable_oper_handler() - Handle the WLAN Sense disable Operation request
+ *	from Userspace.
+ *
+ * @ifp: interface instance.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_wlan_sense_disable_oper_handler(struct inff_if *ifp)
+{
+	struct inff_wlan_sense_fil_cfg fil_cfg;
+	s32 ret = 0;
+
+	memset(&fil_cfg, 0, sizeof(struct inff_wlan_sense_fil_cfg));
+
+	/* Disable WLAN Sensing Functionality */
+	fil_cfg.csi_enable = 0;
+
+	ret = inff_fil_iovar_data_set(ifp, "csi", &fil_cfg,
+				      sizeof(struct inff_wlan_sense_fil_cfg));
+	if (ret) {
+		inff_err("WLAN SENSE: DISABLE: Failed, Firmware error (%d)", ret);
+		goto fail;
+	}
+
+	inff_wlan_sense_dump_fil_cfg(fil_cfg);
+fail:
+	return ret;
+}
+
+/**
+ * inff_wlan_sense_configure_oper_handler() - Handle the WLAN Sense configure Operation
+ *	request from Userspace.
+ *
+ * @ifp: interface instance.
+ * @cfg: WLAN Sense parameters.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_wlan_sense_configure_oper_handler(struct inff_if *ifp, struct inff_wlan_sense_cfg cfg)
+{
+	struct inff_cfg80211_info *cfg80211_info = ifp->drvr->config;
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	s32 ret = 0;
+
+	if (!wlan_sense) {
+		inff_dbg(WLAN_SENSE, "WLAN_SENSE: no data structure\n");
+		return ret;
+	}
+
+	if (!memcmp(&wlan_sense->cfg, &cfg, sizeof(struct inff_wlan_sense_cfg))) {
+		inff_dbg(WLAN_SENSE, "WLAN_SENSE: Skipping new Duplicate configuration request\n");
+		return ret;
+	}
+
+	if (wlan_sense->sensing) {
+		/* If WLAN Sensing is already running, send IOVAR request
+		 * to Firmware with the new configurations
+		 */
+		ret = inff_wlan_sense_enable_oper_handler(ifp, cfg);
+	} else {
+		/* If WLAN Sensing is not running, store the new configurations
+		 * in memory and wait for WLAN Sensing enable request from the user.
+		 */
+		memcpy(&wlan_sense->cfg, &cfg, sizeof(struct inff_wlan_sense_cfg));
+	}
+
+	return ret;
+}
+
+/**
+ * inff_wlan_sense_oper_handler() - Handle the WLAN Sense Operation requests from Userspace.
+ *
+ * @wiphy: wiphy object for cfg80211 interface.
+ * @wdev: wireless device.
+ * @oper: WLAN sensing operation
+ * @cfg: WLAN Sensing Configuration
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+s32
+inff_wlan_sense_oper_handler(struct wiphy *wiphy, struct wireless_dev *wdev,
+			     enum inff_wlan_sense_oper oper,
+			     struct inff_wlan_sense_cfg cfg)
+{
+	struct inff_cfg80211_info *cfg80211_info = wiphy_to_cfg(wiphy);
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+	struct inff_cfg80211_vif *vif = NULL;
+	struct inff_if *ifp = NULL;
+	s32 ret = 0;
+
+	vif = wdev_to_vif(wdev);
+	if (!vif) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	ifp = vif->ifp;
+	if (!ifp) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	/* Check if WLAN Sense feature is supported in the Firmware */
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_WLAN_SENSE)) {
+		inff_err("WLAN SENSE: Operation(%d) can't be handled, WLAN Sense not enabled on VIF(%s)",
+			 oper, inff_ifname(ifp));
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	switch (oper) {
+	case INFF_WLAN_SENSE_OPER_CONFIGURE:
+		ret = inff_wlan_sense_configure_oper_handler(ifp, cfg);
+		break;
+	case INFF_WLAN_SENSE_OPER_ENABLE:
+		ret = inff_wlan_sense_enable_oper_handler(ifp, wlan_sense->cfg);
+		break;
+	case INFF_WLAN_SENSE_OPER_DISABLE:
+		ret = inff_wlan_sense_disable_oper_handler(ifp);
+		break;
+	default:
+		inff_err("WLAN SENSE: Operation(%d) not supported on VIF(%s)",
+			 oper, inff_ifname(ifp));
+		ret = -EOPNOTSUPP;
+	}
+exit:
+	return ret;
+}
+
+s32
+inff_wlan_sense_parse_req(struct cfg80211_pmsr_request_peer *peer,
+			  struct inff_wlan_sense_cfg *wlan_sense_cfg)
+{
+	char *token;
+	char delim[] = ",\n";
+	char *buf = peer->sensing.vendor_req;
+	unsigned long val;
+	s32 err = 0;
+
+	inff_dbg(TRACE, "WLAN SENSE: vendor_req(%d): %s\n", peer->sensing.vendor_req_len, buf);
+	wlan_sense_cfg->interval = peer->sensing.interval;
+	wlan_sense_cfg->duration = peer->sensing.duration;
+	wlan_sense_cfg->mode_flags = 0;
+	if (peer->sensing.associated)
+		wlan_sense_cfg->mode_flags |= INFF_WLAN_SENSE_MODE_ASSOCIATED;
+	ether_addr_copy(wlan_sense_cfg->filter.ta[0].octet, peer->addr);
+
+	/* parse vendor data */
+	token = strsep(&buf, delim);
+	while (token) {
+		if (!strncmp(token, "solicit_mode=", 13)) {
+			err = kstrtoul(token + 13, 0, &val);
+			if (err)
+				break;
+			if (val)
+				wlan_sense_cfg->mode_flags |= INFF_WLAN_SENSE_MODE_SOLICITED;
+		}
+		if (!strncmp(token, "bss_scope=", 10)) {
+			err = kstrtoul(token + 10, 0, &val);
+			if (err)
+				break;
+			wlan_sense_cfg->filter.bss_scope = val;
+		}
+		if (!strncmp(token, "ignore_fcs=", 11)) {
+			err = kstrtoul(token + 11, 0, &val);
+			if (err)
+				break;
+			wlan_sense_cfg->filter.ignore_fcs = !!val;
+		}
+		if (!strncmp(token, "frmtyp_subtyp0=", 15)) {
+			err = kstrtoul(token + 15, 0, &val);
+			if (err)
+				break;
+			wlan_sense_cfg->filter.frmtyp_subtyp[0] = val;
+		}
+		if (!strncmp(token, "frmtyp_subtyp1=", 15)) {
+			err = kstrtoul(token + 15, 0, &val);
+			if (err)
+				break;
+			wlan_sense_cfg->filter.frmtyp_subtyp[1] = val;
+		}
+		token = strsep(&buf, delim);
+	}
+
+	if (err)
+		inff_err("WLAN SENSE: Parse fail %d!\n", err);
+
+	return err;
+}
+
+/**
+ * inff_wlan_sense_attach() - attach for WLAN Sense.
+ *
+ * @cfg80211_info: driver private data for cfg80211 interface.
+ */
+s32
+inff_wlan_sense_attach(struct inff_cfg80211_info *cfg80211_info)
+{
+	struct inff_wlan_sense_info *wlan_sense;
+	struct inff_if *pri_ifp;
+	s32 err = 0;
+
+	pri_ifp = netdev_priv(cfg_to_ndev(cfg80211_info));
+
+	wlan_sense = kzalloc(sizeof(*wlan_sense), GFP_KERNEL);
+	if (!wlan_sense) {
+		err = -ENOMEM;
+		inff_err("WLAN SENSE: Failed to allocate memory for wlan_sense\n");
+		goto fail;
+	}
+
+	wlan_sense->sensing = false;
+	wlan_sense->sense_req = NULL;
+	wlan_sense->cfg80211_info = cfg80211_info;
+	cfg80211_info->pmsr_info->wlan_sense_info = wlan_sense;
+
+fail:
+	return err;
+}
+
+/**
+ * inff_wlan_sense_detach() - detach WLAN Sense.
+ *
+ * @cfg80211_info: driver private data for cfg80211 interface.
+ */
+void
+inff_wlan_sense_detach(struct inff_cfg80211_info *cfg80211_info)
+{
+	struct inff_wlan_sense_info *wlan_sense = cfg80211_info->pmsr_info->wlan_sense_info;
+
+	if (!wlan_sense || !wlan_sense->vif)
+		return;
+
+	kfree(wlan_sense->data_buf);
+	kfree(wlan_sense);
+	cfg80211_info->pmsr_info->wlan_sense_info = NULL;
+}
+
+int inff_wlan_sense_start(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	inff_dbg(TRACE, "WLAN SENSE: enter\n");
+
+	/* do nothing for now */
+	return 0;
+}
+
+void inff_wlan_sense_stop(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	s32 err = 0;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_wlan_sense_info *wlan_sense_info = cfg->pmsr_info->wlan_sense_info;
+	struct inff_wlan_sense_cfg wlan_sense_cfg = {0};
+
+	inff_dbg(TRACE, "WLAN SENSE: enter\n");
+
+	/* abort running sensing process if we get interface stop command */
+	if (!wlan_sense_info->sense_req || !wlan_sense_info->sensing)
+		return;
+
+	err = inff_wlan_sense_oper_handler(wiphy, wdev,
+					   INFF_WLAN_SENSE_OPER_DISABLE,
+					   wlan_sense_cfg);
+	inff_dbg(TRACE, "WLAN SENSE: err %d\n", err);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/wlan_sense.h b/drivers/net/wireless/infineon/inffmac/wlan_sense.h
new file mode 100644
index 000000000000..1345ff33b7ea
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/wlan_sense.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_WLAN_SENSE_H
+#define INFF_WLAN_SENSE_H
+
+#define INFF_WLAN_SENSE_FILTER_FRM_RA_NUM		4
+#define INFF_WLAN_SENSE_FILTER_FRM_TYP_SUBTYP_NUM	2
+#define INFF_WLAN_SENSE_METADATA	64
+/* 16k + Meta(64) for 2x2 80Mhz QoS HE */
+#define INFF_WLAN_SENSE_DATA_LEN_MAX	(16384 + INFF_WLAN_SENSE_METADATA)
+
+struct inff_csi_data_frag_hdr {
+	u8 hdr_version;
+	u8 sequence_num;
+	u8 fragment_num;
+	u8 total_fragments;
+} __packed;
+
+enum inff_wlan_sense_oper {
+	INFF_WLAN_SENSE_OPER_UNSPECIFIED,
+	INFF_WLAN_SENSE_OPER_CONFIGURE,
+	INFF_WLAN_SENSE_OPER_ENABLE,
+	INFF_WLAN_SENSE_OPER_DISABLE,
+};
+
+enum inff_wlan_sense_mode_flags {
+	INFF_WLAN_SENSE_MODE_SOLICITED = 1 << 0,
+	INFF_WLAN_SENSE_MODE_ASSOCIATED = 1 << 1,
+};
+
+enum inff_wlan_sense_filter_bss_scope {
+	INFF_WLAN_SENSE_FILTER_BSS_SCOPE_OWN_RA,
+	INFF_WLAN_SENSE_FILTER_BSS_SCOPE_CURR_BSS,
+	INFF_WLAN_SENSE_FILTER_BSS_SCOPE_ALL_BSS,
+};
+
+struct inff_wlan_sense_filter {
+	enum inff_wlan_sense_filter_bss_scope bss_scope;
+	bool ignore_fcs;
+	struct ether_addr ta[INFF_WLAN_SENSE_FILTER_FRM_RA_NUM];
+	u8 frmtyp_subtyp[INFF_WLAN_SENSE_FILTER_FRM_TYP_SUBTYP_NUM];
+};
+
+struct inff_wlan_sense_cfg {
+	u32 interval;
+	u16 duration;
+	u8 mode_flags;
+	struct inff_wlan_sense_filter filter;
+};
+
+struct inff_wlan_sense_fil_cfg {
+	/* 1: Enable CSI capture  0: Disable CSI capture */
+	u8 csi_enable;
+
+	/* -1: Disable periodic CSI capture */
+	s32 capture_interval_ms;
+	u16 capture_duration_ms;
+
+	/* 0: Unsolicited Mode 1: Solicited Mode */
+	u8 solicit_mode;
+
+	/* 0: Unassociated Mode 1: Associated Mode */
+	u8 assoc_mode;
+
+	/* 0: Allow all Rx   1: My BSS  2: Other BSS */
+	u8 bss_mode;
+
+	/* Also capture badfcs packets */
+	u8 ignore_fcs;
+
+	/* Only capture pkts from specified macaddr (Unassociated Mode) */
+	struct ether_addr
+	macaddr[INFF_WLAN_SENSE_FILTER_FRM_RA_NUM];
+
+	/* Capture CSI only for specified chanspec */
+	u16 chanspec;
+
+	/* Capture multiple CSI per mac address (Unsolicited Mode) */
+	u8 multi_csi_per_mac;
+
+	/* Enable PM indication before CSI window (Associated Mode) */
+	u8 link_protection;
+
+	/* Capture CSI  only from selected subcarriers (Not Implemented) */
+	u8 subcarriers;
+
+	/* FrameType & SubType */
+	u8 frmtyp_subtyp[INFF_WLAN_SENSE_FILTER_FRM_TYP_SUBTYP_NUM];
+};
+
+struct inff_fil_wlan_sense_if_le {
+	struct ether_addr addr;
+};
+
+/**
+ * struct wlan_sense_bss - WLAN Sensing bss related information.
+ *
+ * @vif: virtual interface of this WLAN Sensing bss.
+ * @private_data: TBD
+ */
+struct wlan_sense_bss {
+	struct inff_cfg80211_vif *vif;
+	void *private_data;
+};
+
+/**
+ * struct inff_wlan_sense_counters - WLAN Sensing debug counters
+ *
+ * @csi_frag_fw_evt_tot_ct: CSI Data Fragment Firmware event total count.
+ * @csi_frag_fw_evt_handle_fail_ct: CSI Data Fragment Firmware event handled successfully count.
+ * @csi_frag_fw_evt_handle_succ_ct: CSI Data Fragment Firmware event handle failure count.
+ */
+struct inff_wlan_sense_counters {
+	u32 csi_frag_fw_evt_tot_ct;
+	u32 csi_frag_fw_evt_handle_succ_ct;
+	u32 csi_frag_fw_evt_handle_fail_ct;
+};
+
+/**
+ * struct inff_wlan_sense_info - wlan_sense specific driver information.
+ *
+ * @cfg80211_info: driver private data for cfg80211 interface.
+ * @vif: WLAN Sensing vif structure
+ * @dev_addr: WLAN Sensing device address.
+ * @cfg: WLAN Sensing Configuration.
+ * @sense_req: the pmsr request sent from cfg80211
+ * @data_buf: CSI Data buffer pointer.
+ * @data_buf_len: CSI Data buffer allocated memory size.
+ * @counters: CSI Data Debug counters.
+ * @sensing: WLAN Sensing in progress.
+ */
+struct inff_wlan_sense_info {
+	struct inff_cfg80211_info *cfg80211_info;
+	struct inff_cfg80211_vif *vif;
+	struct ether_addr dev_addr;
+	struct inff_wlan_sense_cfg cfg;
+	struct cfg80211_pmsr_request *sense_req;
+	char *data_buf;
+	u32 data_buf_len;
+	struct inff_wlan_sense_counters counters;
+	bool sensing;
+};
+
+int inff_wlan_sense_start(struct wiphy *wiphy, struct wireless_dev *wdev);
+void inff_wlan_sense_stop(struct wiphy *wiphy, struct wireless_dev *wdev);
+
+struct wireless_dev *
+inff_wlan_sense_add_vif(struct wiphy *wiphy, const char *name,
+			unsigned char name_assign_type,
+			 enum nl80211_iftype type,
+			 struct vif_params *params);
+void
+inff_wlan_sense_ifp_removed(struct inff_if *ifp, bool locked);
+int
+inff_wlan_sense_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev);
+int
+inff_wlan_sense_stats_read(struct seq_file *seq, void *data);
+s32
+inff_notify_wlan_sense_event(struct inff_if *ifp, const struct inff_event_msg *e,
+			     void *data);
+s32
+inff_wlan_sense_oper_handler(struct wiphy *wiphy, struct wireless_dev *wdev,
+			     enum inff_wlan_sense_oper oper,
+			     struct inff_wlan_sense_cfg wlan_sense_cfg);
+s32
+inff_wlan_sense_parse_req(struct cfg80211_pmsr_request_peer *peer,
+			  struct inff_wlan_sense_cfg *wlan_sense_cfg);
+s32
+inff_wlan_sense_attach(struct inff_cfg80211_info *cfg);
+void
+inff_wlan_sense_detach(struct inff_cfg80211_info *cfg);
+
+#endif /* INFF_WLAN_SENSE_H */
-- 
2.25.1


