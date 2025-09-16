Return-Path: <linux-wireless+bounces-27404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFEB7DFF6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91291C024CE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42D330C620;
	Tue, 16 Sep 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="iNwPtEe7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89253294F5
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061788; cv=none; b=Koaa1cQFJg6Ie0c9oV8Vwr2TW9D0MSEtQLi4F71WzlSHhNcnrxaW5Ro2nGDIOAgWVatRQsmT94P2MskYNiGtG3TVOL5CrVNQ+o7TbNu21+/Xp70CR0VlqqMDRtwc01p3I/VE/iAmL1XppCuXcq4ZFKYkNkqzRLL5nVWIsOgmGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061788; c=relaxed/simple;
	bh=M/sXOBJQEO/3IqPC75rlrPMfXr0tS8mgBwNLoqywTfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuZjly9G5RgZcgxi+ruPvU2qa/zSUIjOOLFY6y28DRIUHX7PAW9/wSd+Ovh4Dqy8TwAbbK7AuT38hhbNSrEH3m/EsMUim7HpZsnmnpn5Qhe1dWETffvbwwNshdM9QPizNRv98hYnQ2QdNY8VVerfdeYGkxMzLVgB0phsjxaW2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=iNwPtEe7; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061786; x=1789597786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/sXOBJQEO/3IqPC75rlrPMfXr0tS8mgBwNLoqywTfg=;
  b=iNwPtEe71N09NO8o9a2a67XNBCU0lw74XCqYSxM4qRZG0/fxyXiQTMX2
   XPMwdRQXsHGvmy46OFKUQjZYk0evv76sTMD/7SRtc+STor3B6WWzUpnzZ
   VPttsLe6/Y6df8SrouDTt3DCDn5W6gMb87AoMzXb+61CKDYC0t9eTqY8b
   A=;
X-CSE-ConnectionGUID: fEonX3d5R1SGw9Xg+exE1w==
X-CSE-MsgGUID: A1loinAdRNGelXtSbeWsZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093853"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093853"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:29:44 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:29:43 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:29:40 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 49/57] wifi: inffmac: add interface.c/h
Date: Wed, 17 Sep 2025 03:48:09 +0530
Message-ID: <20250916221821.4387-55-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE827.infineon.com (172.23.29.20)

Implementions the functions for creating, mananging and deleting various
type of WLAN interfaces.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/interface.c | 523 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/interface.h |  80 +++
 2 files changed, 603 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.h

diff --git a/drivers/net/wireless/infineon/inffmac/interface.c b/drivers/net/wireless/infineon/inffmac/interface.c
new file mode 100644
index 000000000000..9fa4a78dd000
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/interface.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+#include <uapi/linux/if_arp.h>
+
+#include "utils.h"
+#include "defs.h"
+#include "chanspec.h"
+#include "hw_ids.h"
+#include "core.h"
+#include "debug.h"
+#include "tracepoint.h"
+#include "fwil_types.h"
+#include "p2p.h"
+#include "btcoex.h"
+#include "pno.h"
+#include "fwsignal.h"
+#include "cfg80211.h"
+#include "feature.h"
+#include "fwil.h"
+#include "proto.h"
+#include "vendor.h"
+#include "vendor_inf.h"
+#include "bus.h"
+#include "common.h"
+#include "he.h"
+#include "eht.h"
+#include "twt.h"
+#include "offload.h"
+#include "pmsr.h"
+
+bool inff_is_apmode_operating(struct wiphy *wiphy)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_cfg80211_vif *vif;
+	bool ret = false;
+
+	list_for_each_entry(vif, &cfg->vif_list, list) {
+		if (inff_is_apmode(vif) &&
+		    test_bit(INFF_VIF_STATUS_AP_CREATED, &vif->sme_state))
+			ret = true;
+	}
+
+	return ret;
+}
+
+bool inff_is_apmode(struct inff_cfg80211_vif *vif)
+{
+	enum nl80211_iftype iftype;
+
+	iftype = vif->wdev.iftype;
+	return iftype == NL80211_IFTYPE_AP || iftype == NL80211_IFTYPE_P2P_GO;
+}
+
+bool inff_is_ibssmode(struct inff_cfg80211_vif *vif)
+{
+	return vif->wdev.iftype == NL80211_IFTYPE_ADHOC;
+}
+
+bool check_vif_up(struct inff_cfg80211_vif *vif)
+{
+	if (!test_bit(INFF_VIF_STATUS_READY, &vif->sme_state)) {
+		inff_dbg(INFO, "device is not ready : status (%lu)\n",
+			 vif->sme_state);
+		return false;
+	}
+	return true;
+}
+
+enum nl80211_iftype inff_cfg80211_get_iftype(struct inff_if *ifp)
+{
+	struct wireless_dev *wdev = &ifp->vif->wdev;
+
+	return wdev->iftype;
+}
+
+static int inff_get_first_free_bsscfgidx(struct inff_pub *drvr)
+{
+	int bsscfgidx;
+
+	for (bsscfgidx = 0; bsscfgidx < INFF_MAX_IFS; bsscfgidx++) {
+		/* bsscfgidx 1 is reserved for legacy P2P */
+		if (bsscfgidx == 1)
+			continue;
+		if (!drvr->iflist[bsscfgidx])
+			return bsscfgidx;
+	}
+
+	return -ENOMEM;
+}
+
+static void inff_set_vif_sta_macaddr(struct inff_if *ifp, u8 *mac_addr)
+{
+	u8 mac_idx = ifp->drvr->sta_mac_idx;
+
+	/* set difference MAC address with locally administered bit */
+	memcpy(mac_addr, ifp->mac_addr, ETH_ALEN);
+	mac_addr[0] |= 0x02;
+	mac_addr[3] ^= mac_idx ? 0xC0 : 0xA0;
+	mac_idx++;
+	mac_idx = mac_idx % 2;
+	ifp->drvr->sta_mac_idx = mac_idx;
+}
+
+static int inff_cfg80211_request_sta_if(struct inff_if *ifp, u8 *macaddr)
+{
+	struct wl_interface_create_v1 iface_v1;
+	struct wl_interface_create_v2 iface_v2;
+	struct wl_interface_create_v3 iface_v3;
+	u32 iface_create_ver;
+	int err;
+
+	/* interface_create version 1 */
+	memset(&iface_v1, 0, sizeof(iface_v1));
+	iface_v1.ver = WL_INTERFACE_CREATE_VER_1;
+	iface_v1.flags = WL_INTERFACE_CREATE_STA |
+			 WL_INTERFACE_MAC_USE;
+	if (!is_zero_ether_addr(macaddr))
+		memcpy(iface_v1.mac_addr, macaddr, ETH_ALEN);
+	else
+		inff_set_vif_sta_macaddr(ifp, iface_v1.mac_addr);
+
+	err = inff_fil_iovar_data_get(ifp, "interface_create",
+				      &iface_v1,
+				      sizeof(iface_v1));
+	if (err) {
+		inff_dbg(INFO, "failed to create interface(v1), err=%d\n",
+			 err);
+	} else {
+		inff_dbg(INFO, "interface created(v1)\n");
+		return 0;
+	}
+
+	/* interface_create version 2 */
+	memset(&iface_v2, 0, sizeof(iface_v2));
+	iface_v2.ver = WL_INTERFACE_CREATE_VER_2;
+	iface_v2.flags = WL_INTERFACE_MAC_USE;
+	iface_v2.iftype = WL_INTERFACE_CREATE_STA;
+	if (!is_zero_ether_addr(macaddr))
+		memcpy(iface_v2.mac_addr, macaddr, ETH_ALEN);
+	else
+		inff_set_vif_sta_macaddr(ifp, iface_v2.mac_addr);
+
+	err = inff_fil_iovar_data_get(ifp, "interface_create",
+				      &iface_v2,
+				      sizeof(iface_v2));
+	if (err) {
+		inff_dbg(INFO, "failed to create interface(v2), err=%d\n",
+			 err);
+	} else {
+		inff_dbg(INFO, "interface created(v2)\n");
+		return 0;
+	}
+
+	/* interface_create version 3+ */
+	/* get supported version from firmware side */
+	iface_create_ver = 0;
+	err = inff_fil_bsscfg_int_get(ifp, "interface_create",
+				      &iface_create_ver);
+	if (err) {
+		inff_err("fail to get supported version, err=%d\n", err);
+		return -EOPNOTSUPP;
+	}
+
+	switch (iface_create_ver) {
+	case WL_INTERFACE_CREATE_VER_3:
+		memset(&iface_v3, 0, sizeof(iface_v3));
+		iface_v3.ver = WL_INTERFACE_CREATE_VER_3;
+		iface_v3.flags = WL_INTERFACE_MAC_USE;
+		iface_v3.iftype = WL_INTERFACE_CREATE_STA;
+		if (!is_zero_ether_addr(macaddr))
+			memcpy(iface_v3.mac_addr, macaddr, ETH_ALEN);
+		else
+			inff_set_vif_sta_macaddr(ifp, iface_v3.mac_addr);
+
+		err = inff_fil_iovar_data_get(ifp, "interface_create",
+					      &iface_v3,
+					       sizeof(iface_v3));
+
+		if (!err)
+			inff_dbg(INFO, "interface created(v3)\n");
+		break;
+	default:
+		inff_err("not support interface create(v%d)\n",
+			 iface_create_ver);
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	if (err) {
+		inff_info("station interface creation failed (%d)\n",
+			  err);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int inff_cfg80211_request_ap_if(struct inff_if *ifp)
+{
+	struct wl_interface_create_v1 iface_v1;
+	struct wl_interface_create_v2 iface_v2;
+	struct wl_interface_create_v3 iface_v3;
+	u32 iface_create_ver;
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_mbss_ssid_le mbss_ssid_le;
+	int bsscfgidx;
+	int err;
+
+	/* interface_create version 1 */
+	memset(&iface_v1, 0, sizeof(iface_v1));
+	iface_v1.ver = WL_INTERFACE_CREATE_VER_1;
+	iface_v1.flags = WL_INTERFACE_CREATE_AP |
+			 WL_INTERFACE_MAC_USE;
+
+	inff_set_vif_sta_macaddr(ifp, iface_v1.mac_addr);
+
+	err = inff_fil_iovar_data_get(ifp, "interface_create",
+				      &iface_v1,
+				      sizeof(iface_v1));
+	if (err) {
+		inff_dbg(INFO, "failed to create interface(v1), err=%d\n",
+			 err);
+	} else {
+		inff_dbg(INFO, "interface created(v1)\n");
+		return 0;
+	}
+
+	/* interface_create version 2 */
+	memset(&iface_v2, 0, sizeof(iface_v2));
+	iface_v2.ver = WL_INTERFACE_CREATE_VER_2;
+	iface_v2.flags = WL_INTERFACE_MAC_USE;
+	iface_v2.iftype = WL_INTERFACE_CREATE_AP;
+
+	inff_set_vif_sta_macaddr(ifp, iface_v2.mac_addr);
+
+	err = inff_fil_iovar_data_get(ifp, "interface_create",
+				      &iface_v2,
+				      sizeof(iface_v2));
+	if (err) {
+		inff_dbg(INFO, "failed to create interface(v2), err=%d\n",
+			 err);
+	} else {
+		inff_dbg(INFO, "interface created(v2)\n");
+		return 0;
+	}
+
+	/* interface_create version 3+ */
+	/* get supported version from firmware side */
+	iface_create_ver = 0;
+	err = inff_fil_bsscfg_int_get(ifp, "interface_create",
+				      &iface_create_ver);
+	if (err) {
+		inff_err("fail to get supported version, err=%d\n", err);
+		return -EOPNOTSUPP;
+	}
+
+	switch (iface_create_ver) {
+	case WL_INTERFACE_CREATE_VER_3:
+		memset(&iface_v3, 0, sizeof(iface_v3));
+		iface_v3.ver = WL_INTERFACE_CREATE_VER_3;
+		iface_v3.flags = WL_INTERFACE_MAC_USE;
+		iface_v3.iftype = WL_INTERFACE_CREATE_AP;
+		inff_set_vif_sta_macaddr(ifp, iface_v3.mac_addr);
+
+		err = inff_fil_iovar_data_get(ifp, "interface_create",
+					      &iface_v3,
+					       sizeof(iface_v3));
+
+		if (!err)
+			inff_dbg(INFO, "interface created(v3)\n");
+		break;
+	default:
+		inff_err("not support interface create(v%d)\n",
+			 iface_create_ver);
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	if (err) {
+		inff_info("Does not support interface_create (%d)\n",
+			  err);
+		memset(&mbss_ssid_le, 0, sizeof(mbss_ssid_le));
+		bsscfgidx = inff_get_first_free_bsscfgidx(ifp->drvr);
+		if (bsscfgidx < 0)
+			return bsscfgidx;
+
+		mbss_ssid_le.bsscfgidx = cpu_to_le32(bsscfgidx);
+		mbss_ssid_le.SSID_len = cpu_to_le32(5);
+		sprintf(mbss_ssid_le.SSID, "ssid%d", bsscfgidx);
+
+		err = inff_fil_bsscfg_data_set(ifp, "bsscfg:ssid", &mbss_ssid_le,
+					       sizeof(mbss_ssid_le));
+
+		if (err < 0)
+			iphy_err(drvr, "setting ssid failed %d\n", err);
+	}
+
+	return err;
+}
+
+/**
+ * inff_apsta_add_vif() - create a new AP or STA virtual interface
+ *
+ * @wiphy: wiphy device of new interface.
+ * @name: name of the new interface.
+ * @params: contains mac address for AP or STA device.
+ * @type: interface type.
+ *
+ * Return: pointer to new vif on success, ERR_PTR(-errno) if not
+ */
+struct wireless_dev *inff_apsta_add_vif(struct wiphy *wiphy, const char *name,
+					struct vif_params *params,
+					enum nl80211_iftype type)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_vif *vif;
+	int err;
+
+	if (type != NL80211_IFTYPE_STATION && type != NL80211_IFTYPE_AP)
+		return ERR_PTR(-EINVAL);
+
+	if (inff_cfg80211_vif_event_armed(cfg))
+		return ERR_PTR(-EBUSY);
+
+	inff_dbg(INFO, "Adding vif \"%s\"\n", name);
+
+	vif = inff_alloc_vif(cfg, type);
+	if (IS_ERR(vif))
+		return (struct wireless_dev *)vif;
+
+	inff_cfg80211_arm_vif_event(cfg, vif);
+
+	if (type == NL80211_IFTYPE_STATION)
+		err = inff_cfg80211_request_sta_if(ifp, params->macaddr);
+	else
+		err = inff_cfg80211_request_ap_if(ifp);
+	if (err) {
+		inff_cfg80211_arm_vif_event(cfg, NULL);
+		goto fail;
+	}
+
+	/* wait for firmware event */
+	err = inff_cfg80211_wait_vif_event(cfg, INFF_E_IF_ADD,
+					   INFF_VIF_EVENT_TIMEOUT);
+	inff_cfg80211_arm_vif_event(cfg, NULL);
+	if (!err) {
+		iphy_err(drvr, "timeout occurred\n");
+		err = -EIO;
+		goto fail;
+	}
+
+	/* interface created in firmware */
+	ifp = vif->ifp;
+	if (!ifp) {
+		iphy_err(drvr, "no if pointer provided\n");
+		err = -ENOENT;
+		goto fail;
+	}
+
+	strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
+	err = inff_net_attach(ifp, true);
+	if (err) {
+		iphy_err(drvr, "Registering netdevice failed\n");
+		free_netdev(ifp->ndev);
+		goto fail;
+	}
+
+	return &ifp->vif->wdev;
+
+fail:
+	inff_free_vif(vif);
+	return ERR_PTR(err);
+}
+
+/**
+ * inff_mon_add_vif() - create monitor mode virtual interface
+ *
+ * @wiphy: wiphy device of new interface.
+ * @name: name of the new interface.
+ *
+ * Return: pointer to new vif on success, ERR_PTR(-errno) if not
+ */
+struct wireless_dev *inff_mon_add_vif(struct wiphy *wiphy, const char *name)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_cfg80211_vif *vif;
+	struct net_device *ndev;
+	struct inff_if *ifp;
+	int err;
+
+	if (cfg->pub->mon_if) {
+		err = -EEXIST;
+		goto err_out;
+	}
+
+	vif = inff_alloc_vif(cfg, NL80211_IFTYPE_MONITOR);
+	if (IS_ERR(vif)) {
+		err = PTR_ERR(vif);
+		goto err_out;
+	}
+
+	ndev = alloc_netdev(sizeof(*ifp), name, NET_NAME_UNKNOWN, ether_setup);
+	if (!ndev) {
+		err = -ENOMEM;
+		goto err_free_vif;
+	}
+	ndev->type = ARPHRD_IEEE80211_RADIOTAP;
+	ndev->ieee80211_ptr = &vif->wdev;
+	ndev->needs_free_netdev = true;
+	ndev->priv_destructor = inff_cfg80211_free_netdev;
+	SET_NETDEV_DEV(ndev, wiphy_dev(cfg->wiphy));
+
+	ifp = netdev_priv(ndev);
+	ifp->vif = vif;
+	ifp->ndev = ndev;
+	ifp->drvr = cfg->pub;
+
+	vif->ifp = ifp;
+	vif->wdev.netdev = ndev;
+
+	err = inff_net_mon_attach(ifp);
+	if (err) {
+		inff_err("Failed to attach %s device\n", ndev->name);
+		free_netdev(ndev);
+		goto err_free_vif;
+	}
+
+	cfg->pub->mon_if = ifp;
+
+	return &vif->wdev;
+
+err_free_vif:
+	inff_free_vif(vif);
+err_out:
+	return ERR_PTR(err);
+}
+
+int inff_mon_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = wdev->netdev;
+
+	ndev->netdev_ops->ndo_stop(ndev);
+
+	inff_net_detach(ndev, true);
+
+	cfg->pub->mon_if = NULL;
+
+	return 0;
+}
+
+int inff_cfg80211_del_apsta_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = wdev->netdev;
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	int ret;
+	int err;
+
+	inff_cfg80211_arm_vif_event(cfg, ifp->vif);
+
+	err = inff_fil_bsscfg_data_set(ifp, "interface_remove", NULL, 0);
+	if (err) {
+		iphy_err(drvr, "interface_remove failed %d\n", err);
+		goto err_unarm;
+	}
+
+	/* wait for firmware event */
+	ret = inff_cfg80211_wait_vif_event(cfg, INFF_E_IF_DEL, INFF_VIF_EVENT_TIMEOUT);
+	if (!ret) {
+		iphy_err(drvr, "timeout occurred\n");
+		err = -EIO;
+		goto err_unarm;
+	}
+
+	inff_remove_interface(ifp, true);
+
+err_unarm:
+	inff_cfg80211_arm_vif_event(cfg, NULL);
+	return err;
+}
+
+struct inff_cfg80211_vif *inff_alloc_vif(struct inff_cfg80211_info *cfg,
+					 enum nl80211_iftype type)
+{
+	struct inff_cfg80211_vif *vif;
+
+	inff_dbg(TRACE, "allocating virtual interface (size=%zu)\n",
+		 sizeof(*vif));
+	vif = kzalloc(sizeof(*vif), GFP_KERNEL);
+	if (!vif)
+		return ERR_PTR(-ENOMEM);
+
+	vif->wdev.wiphy = cfg->wiphy;
+	vif->wdev.iftype = type;
+
+	inff_init_prof(&vif->profile);
+	init_completion(&vif->mgmt_tx);
+	list_add_tail(&vif->list, &cfg->vif_list);
+	return vif;
+}
+
+void inff_free_vif(struct inff_cfg80211_vif *vif)
+{
+	list_del(&vif->list);
+	kfree(vif);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/interface.h b/drivers/net/wireless/infineon/inffmac/interface.h
new file mode 100644
index 000000000000..3d35a67666f8
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/interface.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_INTERFACE_H
+#define INFF_INTERFACE_H
+
+#define WLC_E_IF_ROLE_STA		0	/* Infra STA */
+#define WLC_E_IF_ROLE_AP		1	/* Access Point */
+#define WLC_E_IF_ROLE_WLAN_SENSE		10	/* WLAN Sensing interface */
+
+#define WL_INTERFACE_CREATE_VER_1		1
+#define WL_INTERFACE_CREATE_VER_2		2
+#define WL_INTERFACE_CREATE_VER_3		3
+#define WL_INTERFACE_CREATE_VER_MAX		WL_INTERFACE_CREATE_VER_3
+
+#define WL_INTERFACE_MAC_DONT_USE	0x0
+#define WL_INTERFACE_MAC_USE		0x2
+
+#define WL_INTERFACE_CREATE_STA		0x0
+#define WL_INTERFACE_CREATE_AP		0x1
+
+struct wl_interface_create_v1 {
+	u16	ver;			/* structure version */
+	u32	flags;			/* flags for operation */
+	u8	mac_addr[ETH_ALEN];	/* MAC address */
+	u32	wlc_index;		/* optional for wlc index */
+};
+
+struct wl_interface_create_v2 {
+	u16	ver;			/* structure version */
+	u8	pad1[2];
+	u32	flags;			/* flags for operation */
+	u8	mac_addr[ETH_ALEN];	/* MAC address */
+	u8	iftype;			/* type of interface created */
+	u8	pad2;
+	u32	wlc_index;		/* optional for wlc index */
+};
+
+struct wl_interface_create_v3 {
+	u16 ver;			/* structure version */
+	u16 len;			/* length of structure + data */
+	u16 fixed_len;			/* length of structure */
+	u8 iftype;			/* type of interface created */
+	u8 wlc_index;			/* optional for wlc index */
+	u32 flags;			/* flags for operation */
+	u8 mac_addr[ETH_ALEN];		/* MAC address */
+	u8 bssid[ETH_ALEN];		/* optional for BSSID */
+	u8 if_index;			/* interface index request */
+	u8 pad[3];
+	u8 data[];			/* Optional for specific data */
+};
+
+#define WL_IOV_OP_BSSCFG_DISABLE		0
+#define WL_IOV_OP_BSSCFG_ENABLE			1
+#define WL_IOV_OP_MANUAL_STA_BSSCFG_CREATE	2
+#define WL_IOV_OP_MANUAL_AP_BSSCFG_CREATE	3
+
+bool check_vif_up(struct inff_cfg80211_vif *vif);
+int inff_cfg80211_del_apsta_iface(struct wiphy *wiphy, struct wireless_dev *wdev);
+struct wireless_dev *inff_mon_add_vif(struct wiphy *wiphy, const char *name);
+int inff_mon_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev);
+
+struct wireless_dev *inff_apsta_add_vif(struct wiphy *wiphy, const char *name,
+					struct vif_params *params,
+					enum nl80211_iftype type);
+enum nl80211_iftype inff_cfg80211_get_iftype(struct inff_if *ifp);
+
+struct inff_cfg80211_vif *inff_alloc_vif(struct inff_cfg80211_info *cfg, enum nl80211_iftype type);
+void inff_free_vif(struct inff_cfg80211_vif *vif);
+bool inff_is_apmode_operating(struct wiphy *wiphy);
+
+bool inff_is_apmode(struct inff_cfg80211_vif *vif);
+bool inff_is_ibssmode(struct inff_cfg80211_vif *vif);
+
+#endif /* INFF_INTERFACE_H */
-- 
2.25.1


