Return-Path: <linux-wireless+bounces-30775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F539D1B415
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82724308FE96
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7DC2EB840;
	Tue, 13 Jan 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="HvwYYM3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99D276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336742; cv=none; b=m2ZpPl2wxMhXyYLeKToC5PH827mB2jRPoX4BaAHtOLwq1uCoPH7auDl/zUpDM2bFn+yAw4vL7hCq2piolcaxnSxTc9kK78D1pDKwHRaQNfGB3msdZkJ5jouzHzrfwvR+TmkQzhzSiJpDQb1kYuYXv3hRt7dqrkDsOx6/NyJClmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336742; c=relaxed/simple;
	bh=uEzbhf7jSwQaZH8y+CrwJf63UTifRL1RO65M+jVQW0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APrRCE/XPSkDt5J/OyQAwj//Aj6TUew78V5FVBE3wvj8gIY6Nfs0R3RFkCZUPuxOJA+dGfI/jwPbQK7T/uebjLpc6tw6mbkvKTUU83Vib9BfI42HGITGC+5F32RTbp6Clm6E7BCrWDep6KnQXhgdcg1hIiH7OnAbMBkgFyIyYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=HvwYYM3V; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336741; x=1799872741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEzbhf7jSwQaZH8y+CrwJf63UTifRL1RO65M+jVQW0U=;
  b=HvwYYM3VkozRAgR9OnvX2Z2Z4iSA0TY+PbH9xT0O+WsHrE/3vNexggLU
   ZiKHmE9fvYVybKGtyAN+J/sQB53lbaE1l0fNaHaDvk9ID2VKcC3DkApgN
   CGTsCmdC4ydA18zS3Mn6JCYf6peUrxTv4te+Bb9rf8EY1W7cNjOI1SZfc
   Y=;
X-CSE-ConnectionGUID: ar72OGqfTiiyjYhpzti91w==
X-CSE-MsgGUID: 07kSjejvQRqDPwYtdDOV7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568457"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568457"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:38:59 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:38:58 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:38:56 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 20/34] wifi: inffmac: add interface.c/h
Date: Wed, 14 Jan 2026 02:03:33 +0530
Message-ID: <20260113203350.16734-21-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

Implementions the functions for creating, mananging and deleting various
type of WLAN interfaces.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/interface.c | 803 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/interface.h | 183 ++++
 2 files changed, 986 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.h

diff --git a/drivers/net/wireless/infineon/inffmac/interface.c b/drivers/net/wireless/infineon/inffmac/interface.c
new file mode 100644
index 000000000000..51fe24725a97
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/interface.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
+
+#include "main.h"
+#include "utils.h"
+#include "chan.h"
+#include "debug.h"
+#include "bus_proto.h"
+#include "p2p.h"
+#include "fwsignal.h"
+#include "cfg80211.h"
+#include "interface.h"
+#include "feature.h"
+#include "dev_cmd.h"
+#include "dev_evt.h"
+#include "net.h"
+#include "twt.h"
+#include "chip.h"
+#include "security.h"
+
+bool
+inff_vif_is_linkup(struct inff_cfg80211_vif *vif,
+		   const struct inff_event_msg *e)
+{
+	u32 event = e->event_code;
+	u32 status = e->status;
+
+	if ((vif->profile.use_fwsup == INFF_PROFILE_FWSUP_PSK ||
+	     vif->profile.use_fwsup == INFF_PROFILE_FWSUP_SAE) &&
+	    event == INFF_E_PSK_SUP &&
+	    status == INFF_E_STATUS_FWSUP_COMPLETED)
+		set_bit(INFF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+	if (event == INFF_E_LINK && status == INFF_E_STATUS_SUCCESS &&
+	    (e->flags & INFF_EVENT_MSG_LINK)) {
+		inff_dbg(CONN, "Processing set ssid\n");
+		memcpy(vif->profile.bssid, e->addr, ETH_ALEN);
+		if (vif->profile.use_fwsup != INFF_PROFILE_FWSUP_PSK &&
+		    vif->profile.use_fwsup != INFF_PROFILE_FWSUP_SAE)
+			return true;
+
+		set_bit(INFF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
+	}
+
+	if (test_bit(INFF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state) &&
+	    test_bit(INFF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state)) {
+		clear_bit(INFF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+		clear_bit(INFF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
+		return true;
+	}
+	return false;
+}
+
+bool
+inff_vif_is_linkdown(struct inff_cfg80211_vif *vif,
+		     const struct inff_event_msg *e)
+{
+	u32 event = e->event_code;
+	u16 flags = e->flags;
+	u32 status = e->status;
+
+	if (event == INFF_E_DEAUTH || event == INFF_E_DEAUTH_IND ||
+	    event == INFF_E_DISASSOC_IND ||
+	    (event == INFF_E_LINK && !(flags & INFF_EVENT_MSG_LINK)) ||
+	    (event == INFF_E_SET_SSID && status != INFF_E_STATUS_SUCCESS)) {
+		inff_dbg(CONN, "Processing link down\n");
+		clear_bit(INFF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+		clear_bit(INFF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
+		return true;
+	}
+	return false;
+}
+
+void
+inff_cp_cfg80211_link_up(struct inff_if *ifp, u8 *bssid)
+{
+	struct net_device *ndev = ifp->ndev;
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct cfg80211_connect_resp_params conn_params;
+
+	if (!test_and_clear_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state))
+		return;
+
+	inff_dbg(CONN, "Connecting --> Connected, ifp %pM\n", bssid);
+
+	memset(&conn_params, 0, sizeof(conn_params));
+
+	conn_params.links[0].bssid = bssid;
+	conn_params.req_ie = NULL;
+	conn_params.req_ie_len = 0;
+	conn_params.resp_ie = NULL;
+	conn_params.resp_ie_len = 0;
+
+	conn_params.status = WLAN_STATUS_SUCCESS;
+
+	set_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state);
+	cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
+
+	if (profile->use_fwsup == INFF_PROFILE_FWSUP_CP) {
+		cfg80211_port_authorized(ndev, bssid, NULL, 0, GFP_KERNEL);
+		inff_dbg(CONN, "Report port authorized\n");
+	}
+}
+
+void
+inff_cp_cfg80211_link_down(struct inff_if *ifp)
+{
+	struct net_device *ndev = ifp->ndev;
+
+	if (!test_and_clear_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state))
+		return;
+
+	cfg80211_disconnected(ndev, 0, NULL, 0, true, GFP_KERNEL);
+}
+
+bool
+inff_vif_is_nonetwork(struct inff_cfg80211_info *cfg,
+		      const struct inff_event_msg *e)
+{
+	u32 event = e->event_code;
+	u32 status = e->status;
+
+	if (event == INFF_E_LINK && status == INFF_E_STATUS_NO_NETWORKS) {
+		inff_dbg(CONN, "Processing Link %s & no network found\n",
+			 e->flags & INFF_EVENT_MSG_LINK ? "up" : "down");
+		return true;
+	}
+
+	if (event == INFF_E_SET_SSID && status != INFF_E_STATUS_SUCCESS) {
+		inff_dbg(CONN, "Processing connecting & no network found\n");
+		return true;
+	}
+
+	if (event == INFF_E_PSK_SUP &&
+	    status != INFF_E_STATUS_FWSUP_COMPLETED) {
+		inff_dbg(CONN, "Processing failed supplicant state: %u\n",
+			 status);
+		return true;
+	}
+
+	return false;
+}
+
+void
+inff_link_down(struct inff_cfg80211_vif *vif, u16 reason,
+	       bool locally_generated)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(vif->wdev.wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	bool bus_up = drvr->bus_if->state == INFF_BUS_UP;
+	s32 err = 0;
+
+	if (test_and_clear_bit(INFF_VIF_STATUS_CONNECTED, &vif->sme_state)) {
+		if (bus_up) {
+			inff_dbg(INFO, "Call WLC_DISASSOC to stop excess roaming\n");
+			err = inff_fwcmd_cmd_data_set(vif->ifp,
+						      INFF_C_DISASSOC, NULL, 0);
+			if (err) {
+				iphy_err(drvr, "WLC_DISASSOC failed (%d)\n",
+					 err);
+			} else {
+				if (inff_feat_is_enabled(vif->ifp, INFF_FEAT_TWT)) {
+					/* Cleanup TWT Session list */
+					inff_twt_cleanup_all_sess(vif->ifp);
+				}
+			}
+		}
+
+		if (vif->wdev.iftype == NL80211_IFTYPE_STATION ||
+		    vif->wdev.iftype == NL80211_IFTYPE_P2P_CLIENT)
+			cfg80211_disconnected(vif->wdev.netdev, reason, NULL, 0,
+					      locally_generated, GFP_KERNEL);
+	}
+	clear_bit(INFF_VIF_STATUS_CONNECTING, &vif->sme_state);
+	clear_bit(INFF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+	clear_bit(INFF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
+	clear_bit(INFF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
+	if (vif->profile.use_fwsup != INFF_PROFILE_FWSUP_NONE) {
+		if (bus_up)
+			inff_set_pmk(vif->ifp, NULL, 0);
+		vif->profile.use_fwsup = INFF_PROFILE_FWSUP_NONE;
+	}
+}
+
+bool
+inff_get_vif_state_any(struct inff_cfg80211_info *cfg,
+		       unsigned long state)
+{
+	struct inff_cfg80211_vif *vif;
+
+	list_for_each_entry(vif, &cfg->vif_list, list) {
+		if (test_bit(state, &vif->sme_state))
+			return true;
+	}
+	return false;
+}
+
+static bool
+inff_vif_event_equals(struct inff_cfg80211_vif_event *event,
+		      u8 action)
+{
+	u8 evt_action;
+
+	spin_lock(&event->vif_event_lock);
+	evt_action = event->action;
+	spin_unlock(&event->vif_event_lock);
+	return evt_action == action;
+}
+
+void
+inff_arm_vif_event(struct inff_cfg80211_info *cfg,
+		   struct inff_cfg80211_vif *vif)
+{
+	struct inff_cfg80211_vif_event *event = &cfg->vif_event;
+
+	spin_lock(&event->vif_event_lock);
+	event->vif = vif;
+	event->action = 0;
+	spin_unlock(&event->vif_event_lock);
+}
+
+void
+inff_disarm_vif_event(struct inff_cfg80211_info *cfg)
+{
+	struct inff_cfg80211_vif_event *event = &cfg->vif_event;
+
+	spin_lock(&event->vif_event_lock);
+	event->vif = NULL;
+	event->action = 0;
+	spin_unlock(&event->vif_event_lock);
+}
+
+bool
+inff_vif_event_armed(struct inff_cfg80211_info *cfg)
+{
+	struct inff_cfg80211_vif_event *event = &cfg->vif_event;
+	bool armed;
+
+	spin_lock(&event->vif_event_lock);
+	armed = (event->vif) ? true : false;
+	spin_unlock(&event->vif_event_lock);
+
+	return armed;
+}
+
+int
+inff_wait_vif_event(struct inff_cfg80211_info *cfg,
+		    u8 action, ulong timeout)
+{
+	struct inff_cfg80211_vif_event *event = &cfg->vif_event;
+
+	return wait_event_timeout(event->vif_wq,
+				  inff_vif_event_equals(event, action),
+				  timeout);
+}
+
+int
+inff_vif_add_validate(struct inff_cfg80211_info *cfg,
+		      enum nl80211_iftype new_type)
+{
+	struct inff_cfg80211_vif *pos;
+	struct iface_combination_params params = {
+		.num_different_channels = 1,
+	};
+
+	list_for_each_entry(pos, &cfg->vif_list, list)
+		params.iftype_num[pos->wdev.iftype]++;
+
+	params.iftype_num[new_type]++;
+	return cfg80211_check_combinations(cfg->wiphy, &params);
+}
+
+int
+inff_vif_change_validate(struct inff_cfg80211_info *cfg,
+			 struct inff_cfg80211_vif *vif,
+			 enum nl80211_iftype new_type)
+{
+	struct inff_cfg80211_vif *pos;
+	bool check_combos = false;
+	int ret = 0;
+	struct iface_combination_params params = {
+		.num_different_channels = 1,
+	};
+
+	list_for_each_entry(pos, &cfg->vif_list, list)
+		if (pos == vif) {
+			params.iftype_num[new_type]++;
+		} else {
+			/* concurrent interfaces so need check combinations */
+			check_combos = true;
+			params.iftype_num[pos->wdev.iftype]++;
+		}
+
+	if (check_combos)
+		ret = cfg80211_check_combinations(cfg->wiphy, &params);
+
+	return ret;
+}
+
+bool
+inff_check_vif_up(struct inff_cfg80211_vif *vif)
+{
+	if (!test_bit(INFF_VIF_STATUS_READY, &vif->sme_state)) {
+		inff_dbg(INFO, "device is not ready : status (%lu)\n",
+			 vif->sme_state);
+		return false;
+	}
+	return true;
+}
+
+bool
+inff_vif_is_apmode_operating(struct wiphy *wiphy)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_cfg80211_vif *vif;
+	bool ret = false;
+
+	list_for_each_entry(vif, &cfg->vif_list, list) {
+		if (inff_vif_is_apmode(vif) &&
+		    test_bit(INFF_VIF_STATUS_AP_CREATED, &vif->sme_state))
+			ret = true;
+	}
+
+	return ret;
+}
+
+bool
+inff_vif_is_apmode(struct inff_cfg80211_vif *vif)
+{
+	enum nl80211_iftype iftype;
+
+	iftype = vif->wdev.iftype;
+	return iftype == NL80211_IFTYPE_AP || iftype == NL80211_IFTYPE_P2P_GO;
+}
+
+bool
+inff_vif_is_ibssmode(struct inff_cfg80211_vif *vif)
+{
+	return vif->wdev.iftype == NL80211_IFTYPE_ADHOC;
+}
+
+static void
+inff_set_vif_macaddr(struct inff_if *ifp, u8 *mac_addr)
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
+static int
+inff_vif_req_create(struct inff_if *ifp, enum nl80211_iftype type,
+		    u8 *vif_macaddr)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_interface_create_v2 iface_v2;
+	struct inff_interface_create_v3 iface_v3;
+	u8 macaddr[ETH_ALEN];
+	u32 iface_create_ver = 0;
+	u8 iftype;
+	int err;
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		iftype = INFF_INTERFACE_CREATE_STA;
+		if (!is_zero_ether_addr(vif_macaddr))
+			memcpy(macaddr, vif_macaddr, ETH_ALEN);
+		else
+			inff_set_vif_macaddr(ifp, macaddr);
+		break;
+	case NL80211_IFTYPE_AP:
+		iftype = INFF_INTERFACE_CREATE_AP;
+		inff_set_vif_macaddr(ifp, macaddr);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		goto fail;
+	}
+
+	switch (drvr->bus_if->chip) {
+	case INF_CC_43022_CHIP_ID:
+		/* interface_create version 2 */
+		memset(&iface_v2, 0, sizeof(iface_v2));
+		iface_v2.ver = INFF_INTERFACE_CREATE_VER_2;
+		iface_v2.flags = INFF_INTERFACE_MAC_USE;
+		iface_v2.iftype = iftype;
+		memcpy(iface_v2.mac_addr, macaddr, ETH_ALEN);
+
+		err = inff_fwcmd_iovar_data_get(ifp, "interface_create",
+						&iface_v2, sizeof(iface_v2));
+		break;
+	case INF_CC_5557X_CHIP_ID:
+		fallthrough;
+	case INF_CC_5551X_CHIP_ID:
+		/* interface_create version 3+ */
+		/* get supported version from firmware side */
+		err = inff_fwcmd_bsscfg_int_get(ifp, "interface_create",
+						&iface_create_ver);
+		if (err) {
+			iphy_err(drvr,
+				 "failed to get interface create ver, err=%d\n",
+				 err);
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		switch (iface_create_ver) {
+		case INFF_INTERFACE_CREATE_VER_3:
+			memset(&iface_v3, 0, sizeof(iface_v3));
+			iface_v3.ver = INFF_INTERFACE_CREATE_VER_3;
+			iface_v3.flags = INFF_INTERFACE_MAC_USE;
+			iface_v3.iftype = iftype;
+			memcpy(iface_v3.mac_addr, macaddr, ETH_ALEN);
+
+			err = inff_fwcmd_iovar_data_get(ifp, "interface_create",
+							&iface_v3, sizeof(iface_v3));
+			break;
+		default:
+			inff_err("unsupported interface create ver (v%d)\n",
+				 iface_create_ver);
+			err = -EOPNOTSUPP;
+			break;
+		}
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+fail:
+	if (err) {
+		iphy_err(drvr,
+			 "failed to request interface creation, err=%d\n",
+			 err);
+		return -EIO;
+	}
+
+	inff_dbg(INFO, "requested interface creation\n");
+
+	return 0;
+}
+
+static int
+inff_vif_req_remove(struct inff_if *ifp, enum nl80211_iftype type)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int err;
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		err = inff_fwcmd_bsscfg_data_set(ifp, "interface_remove", NULL, 0);
+		if (err) {
+			iphy_err(drvr,
+				 "failed to request interface removal, err=%d\n",
+				 err);
+			return -EIO;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	inff_dbg(INFO, "requested interface removal\n");
+
+	return 0;
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
+struct wireless_dev *
+inff_apsta_add_vif(struct wiphy *wiphy, const char *name,
+		   struct vif_params *params,
+		   enum nl80211_iftype type)
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
+	if (inff_vif_event_armed(cfg))
+		return ERR_PTR(-EBUSY);
+
+	inff_dbg(INFO, "Adding vif \"%s\"\n", name);
+
+	vif = inff_alloc_vif(cfg, type);
+	if (IS_ERR(vif))
+		return (struct wireless_dev *)vif;
+
+	inff_arm_vif_event(cfg, vif);
+
+	err = inff_vif_req_create(ifp, type, params->macaddr);
+	if (err) {
+		inff_disarm_vif_event(cfg);
+		goto fail;
+	}
+
+	/* wait for firmware event */
+	err = inff_wait_vif_event(cfg, INFF_E_IF_ADD,
+				  INFF_VIF_EVENT_TIMEOUT);
+	inff_disarm_vif_event(cfg);
+	if (!err) {
+		iphy_err(drvr, "vif event timeout occurred\n");
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
+int
+inff_apsta_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = wdev->netdev;
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	int ret;
+	int err;
+
+	inff_arm_vif_event(cfg, ifp->vif);
+
+	err = inff_vif_req_remove(ifp, wdev->iftype);
+	if (err)
+		goto err_unarm;
+
+	/* wait for firmware event */
+	ret = inff_wait_vif_event(cfg, INFF_E_IF_DEL,
+				  INFF_VIF_EVENT_TIMEOUT);
+	if (!ret) {
+		iphy_err(drvr, "vif event timeout occurred\n");
+		err = -EIO;
+		goto err_unarm;
+	}
+
+	inff_net_del_if(drvr, ifp, true);
+
+err_unarm:
+	inff_disarm_vif_event(cfg);
+	return err;
+}
+
+/**
+ * inff_setup_ifmodes() - determine interface modes and combinations.
+ *
+ * @wiphy: wiphy object.
+ * @ifp: interface object needed for feat module api.
+ *
+ * The interface modes and combinations are determined dynamically here
+ * based on firmware functionality.
+ *
+ * no p2p and no mbss:
+ *
+ *	#STA <= 1, #AP <= 1, channels = 1, 2 total
+ *
+ * no p2p and mbss:
+ *
+ *	#STA <= 1, #AP <= 1, channels = 1, 2 total
+ *	#AP <= 4, matching BI, channels = 1, 4 total
+ *
+ * no p2p and rsdb:
+ *	#STA <= 1, #AP <= 2, channels = 2, 4 total
+ *
+ * p2p, no mchan, and mbss:
+ *
+ *	#STA <= 1, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 1, channels = 1, 3 total
+ *	#STA <= 1, #P2P-DEV <= 1, #AP <= 1, #P2P-CL <= 1, channels = 1, 4 total
+ *	#AP <= 4, matching BI, channels = 1, 4 total
+ *
+ * p2p, mchan, and mbss:
+ *
+ *	#STA <= 2, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 1, channels = 2, 3 total
+ *	#STA <= 1, #P2P-DEV <= 1, #AP <= 1, #P2P-CL <= 1, channels = 1, 4 total
+ *	#AP <= 4, matching BI, channels = 1, 4 total
+ *
+ * p2p, rsdb, and no mbss:
+ *	#STA <= 1, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 2, AP <= 2,
+ *	 channels = 2, 4 total
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int
+inff_setup_ifmodes(struct wiphy *wiphy, struct inff_if *ifp)
+{
+	struct ieee80211_iface_combination *combo = NULL;
+	struct ieee80211_iface_limit *c0_limits = NULL;
+	struct ieee80211_iface_limit *p2p_limits = NULL;
+	struct ieee80211_iface_limit *mbss_limits = NULL;
+	bool mbss, p2p, rsdb, mchan;
+	int i, c, n_combos, n_limits, p2p_num_infs;
+
+	if (inff_socitype_is_cp(ifp->drvr->bus_if)) {
+		n_combos = 1;
+		combo = kcalloc(n_combos, sizeof(*combo), GFP_KERNEL);
+		if (!combo)
+			goto err;
+
+		wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					 BIT(NL80211_IFTYPE_AP);
+
+		c = 0;
+		i = 0;
+		n_limits = 2;
+		c0_limits = kcalloc(n_limits, sizeof(*c0_limits), GFP_KERNEL);
+		if (!c0_limits)
+			goto err;
+
+		combo[c].num_different_channels = 1;
+		c0_limits[i].max = 1;
+		c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
+
+		c0_limits[i].max = 1;
+		c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+
+		combo[c].max_interfaces = i;
+
+		combo[c].n_limits = i;
+		combo[c].limits = c0_limits;
+
+	} else {
+		mbss = inff_feat_is_enabled(ifp, INFF_FEAT_MBSS);
+		p2p = inff_feat_is_enabled(ifp, INFF_FEAT_P2P);
+		rsdb = inff_feat_is_enabled(ifp, INFF_FEAT_RSDB);
+		mchan = inff_feat_is_enabled(ifp, INFF_FEAT_MCHAN);
+
+		n_combos = 1 + !!(p2p && !rsdb) + !!mbss;
+		combo = kcalloc(n_combos, sizeof(*combo), GFP_KERNEL);
+		if (!combo)
+			goto err;
+
+		wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					 BIT(NL80211_IFTYPE_ADHOC) |
+					 BIT(NL80211_IFTYPE_AP);
+		if (p2p)
+			wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
+						  BIT(NL80211_IFTYPE_P2P_GO) |
+						  BIT(NL80211_IFTYPE_P2P_DEVICE);
+
+		c = 0;
+		i = 0;
+		n_limits = 1 + (p2p ? 2 : 0) + (rsdb || !p2p);
+
+		c0_limits = kcalloc(n_limits, sizeof(*c0_limits), GFP_KERNEL);
+		if (!c0_limits)
+			goto err;
+
+		combo[c].num_different_channels = 1 + (rsdb || (p2p && mchan));
+		c0_limits[i].max = 1 + (p2p && mchan);
+		c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
+		if (p2p) {
+			c0_limits[i].max = 1;
+			c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_DEVICE);
+			c0_limits[i].max = 1 + rsdb;
+			c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			       BIT(NL80211_IFTYPE_P2P_GO);
+		}
+		if (p2p && rsdb) {
+			c0_limits[i].max = 2;
+			c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+			combo[c].max_interfaces = 4;
+		} else if (p2p) {
+			combo[c].max_interfaces = i;
+		} else if (rsdb) {
+			c0_limits[i].max = 2;
+			c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+			combo[c].max_interfaces = 3;
+		} else {
+			c0_limits[i].max = 1;
+			c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+			combo[c].max_interfaces = i;
+		}
+		combo[c].n_limits = i;
+		combo[c].limits = c0_limits;
+
+		if (p2p && !rsdb) {
+			c++;
+			i = 0;
+			p2p_num_infs = 4;
+
+			p2p_limits = kcalloc(p2p_num_infs, sizeof(*p2p_limits), GFP_KERNEL);
+			if (!p2p_limits)
+				goto err;
+			p2p_limits[i].max = 1;
+			p2p_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
+			p2p_limits[i].max = 1;
+			p2p_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+			p2p_limits[i].max = 1;
+			p2p_limits[i++].types = BIT(NL80211_IFTYPE_P2P_CLIENT);
+			p2p_limits[i].max = 1;
+			p2p_limits[i++].types = BIT(NL80211_IFTYPE_P2P_DEVICE);
+
+			combo[c].num_different_channels = 1;
+			combo[c].max_interfaces = i;
+			combo[c].n_limits = i;
+			combo[c].limits = p2p_limits;
+		}
+
+		if (mbss) {
+			c++;
+			i = 0;
+			n_limits = 1;
+			mbss_limits = kcalloc(n_limits, sizeof(*mbss_limits),
+					      GFP_KERNEL);
+			if (!mbss_limits)
+				goto err;
+			mbss_limits[i].max = 4;
+			mbss_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+			combo[c].beacon_int_infra_match = true;
+			combo[c].num_different_channels = 1;
+			combo[c].max_interfaces = 4;
+			combo[c].n_limits = i;
+			combo[c].limits = mbss_limits;
+		}
+	}
+	wiphy->n_iface_combinations = n_combos;
+	wiphy->iface_combinations = combo;
+	return 0;
+
+err:
+	kfree(c0_limits);
+	kfree(p2p_limits);
+	kfree(mbss_limits);
+	kfree(combo);
+	return -ENOMEM;
+}
+
+struct inff_cfg80211_vif *
+inff_alloc_vif(struct inff_cfg80211_info *cfg,
+	       enum nl80211_iftype type)
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
+	memset(&vif->profile, 0, sizeof(vif->profile));
+
+	init_completion(&vif->mgmt_tx);
+	list_add_tail(&vif->list, &cfg->vif_list);
+	return vif;
+}
+
+void
+inff_free_vif(struct inff_cfg80211_vif *vif)
+{
+	list_del(&vif->list);
+	kfree(vif);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/interface.h b/drivers/net/wireless/infineon/inffmac/interface.h
new file mode 100644
index 000000000000..38be71e19133
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/interface.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_INTERFACE_H
+#define INFF_INTERFACE_H
+
+#define INFF_VIF_EVENT_TIMEOUT		msecs_to_jiffies(1500)
+
+#define INFF_INTERFACE_CREATE_VER_2		2
+#define INFF_INTERFACE_CREATE_VER_3		3
+
+#define INFF_INTERFACE_MAC_DONT_USE	0x0
+#define INFF_INTERFACE_MAC_USE		0x2
+
+#define INFF_INTERFACE_CREATE_STA	0x0
+#define INFF_INTERFACE_CREATE_AP	0x1
+
+struct inff_interface_create_v2 {
+	u16	ver;			/* structure version */
+	u8	pad1[2];
+	u32	flags;			/* flags for operation */
+	u8	mac_addr[ETH_ALEN];	/* MAC address */
+	u8	iftype;			/* type of interface created */
+	u8	pad2;
+	u32	wlc_index;		/* optional for wlc index */
+};
+
+struct inff_interface_create_v3 {
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
+/**
+ * enum inff_vif_status - bit indices for vif status.
+ *
+ * @INFF_VIF_STATUS_READY: ready for operation.
+ * @INFF_VIF_STATUS_CONNECTING: connect/join in progress.
+ * @INFF_VIF_STATUS_CONNECTED: connected/joined successfully.
+ * @INFF_VIF_STATUS_DISCONNECTING: disconnect/disable in progress.
+ * @INFF_VIF_STATUS_AP_CREATED: AP operation started.
+ * @INFF_VIF_STATUS_EAP_SUCCUSS: EAPOL handshake successful.
+ * @INFF_VIF_STATUS_ASSOC_SUCCESS: successful SET_SSID received.
+ */
+enum inff_vif_status {
+	INFF_VIF_STATUS_READY,
+	INFF_VIF_STATUS_CONNECTING,
+	INFF_VIF_STATUS_CONNECTED,
+	INFF_VIF_STATUS_DISCONNECTING,
+	INFF_VIF_STATUS_AP_CREATED,
+	INFF_VIF_STATUS_EAP_SUCCESS,
+	INFF_VIF_STATUS_ASSOC_SUCCESS,
+};
+
+/**
+ * struct inff_vif_saved_ie - holds saved IEs for a virtual interface.
+ *
+ * @probe_req_ie: IE info for probe request.
+ * @probe_res_ie: IE info for probe response.
+ * @beacon_ie: IE info for beacon frame.
+ * @assoc_res_ie: IE info for association response frame.
+ * @probe_req_ie_len: IE info length for probe request.
+ * @probe_res_ie_len: IE info length for probe response.
+ * @beacon_ie_len: IE info length for beacon frame.
+ * @assoc_res_ie_len: IE info length for association response frame.
+ */
+struct inff_vif_saved_ie {
+	u8  probe_req_ie[IE_MAX_LEN];
+	u8  probe_res_ie[IE_MAX_LEN];
+	u8  beacon_ie[IE_MAX_LEN];
+	u8  assoc_req_ie[IE_MAX_LEN];
+	u8  assoc_res_ie[IE_MAX_LEN];
+	u32 probe_req_ie_len;
+	u32 probe_res_ie_len;
+	u32 beacon_ie_len;
+	u32 assoc_req_ie_len;
+	u32 assoc_res_ie_len;
+};
+
+/**
+ * struct inff_cfg80211_profile - profile information.
+ *
+ * @bssid: bssid of joined/joining ibss.
+ * @sec: security information.
+ * @key: key information
+ */
+struct inff_cfg80211_profile {
+	u8 bssid[ETH_ALEN];
+	struct inff_cfg80211_security sec;
+	struct inff_wsec_key key[INFF_MAX_DEFAULT_KEYS];
+	enum inff_profile_fwsup use_fwsup;
+	u16 use_fwauth;
+	bool is_ft;
+	bool is_okc;
+};
+
+/**
+ * struct inff_cfg80211_vif - virtual interface specific information.
+ *
+ * @ifp: lower layer interface pointer
+ * @wdev: wireless device.
+ * @profile: profile information.
+ * @sme_state: SME state using enum inff_vif_status bits.
+ * @list: linked list.
+ * @mgmt_rx_reg: registered rx mgmt frame types.
+ * @cqm_rssi_low: Lower RSSI limit for CQM monitoring
+ * @cqm_rssi_high: Upper RSSI limit for CQM monitoring
+ * @cqm_rssi_last: Last RSSI reading for CQM monitoring
+ */
+struct inff_cfg80211_vif {
+	struct inff_if *ifp;
+	struct wireless_dev wdev;
+	struct inff_cfg80211_profile profile;
+	unsigned long sme_state;
+	struct inff_vif_saved_ie saved_ie;
+	struct list_head list;
+	struct completion mgmt_tx;
+	unsigned long mgmt_tx_status;
+	u32 mgmt_tx_id;
+	u16 mgmt_rx_reg;
+	int is_11d;
+	s32 cqm_rssi_low;
+	s32 cqm_rssi_high;
+	s32 cqm_rssi_last;
+};
+
+bool inff_vif_is_linkup(struct inff_cfg80211_vif *vif,
+			const struct inff_event_msg *e);
+bool inff_vif_is_linkdown(struct inff_cfg80211_vif *vif,
+			  const struct inff_event_msg *e);
+bool inff_vif_is_nonetwork(struct inff_cfg80211_info *cfg,
+			   const struct inff_event_msg *e);
+void inff_link_down(struct inff_cfg80211_vif *vif, u16 reason,
+		    bool locally_generated);
+bool inff_get_vif_state_any(struct inff_cfg80211_info *cfg,
+			    unsigned long state);
+void inff_arm_vif_event(struct inff_cfg80211_info *cfg,
+			struct inff_cfg80211_vif *vif);
+void inff_disarm_vif_event(struct inff_cfg80211_info *cfg);
+bool inff_vif_event_armed(struct inff_cfg80211_info *cfg);
+int inff_wait_vif_event(struct inff_cfg80211_info *cfg,
+			u8 action, ulong timeout);
+int inff_vif_add_validate(struct inff_cfg80211_info *cfg,
+			  enum nl80211_iftype new_type);
+int inff_vif_change_validate(struct inff_cfg80211_info *cfg,
+			     struct inff_cfg80211_vif *vif,
+			     enum nl80211_iftype new_type);
+bool inff_check_vif_up(struct inff_cfg80211_vif *vif);
+bool inff_vif_is_apmode_operating(struct wiphy *wiphy);
+bool inff_vif_is_apmode(struct inff_cfg80211_vif *vif);
+bool inff_vif_is_ibssmode(struct inff_cfg80211_vif *vif);
+struct wireless_dev *
+inff_apsta_add_vif(struct wiphy *wiphy, const char *name,
+		   struct vif_params *params,
+		   enum nl80211_iftype type);
+int inff_apsta_del_vif(struct wiphy *wiphy,
+		       struct wireless_dev *wdev);
+int inff_setup_ifmodes(struct wiphy *wiphy, struct inff_if *ifp);
+struct inff_cfg80211_vif *
+inff_alloc_vif(struct inff_cfg80211_info *cfg, enum nl80211_iftype type);
+void inff_free_vif(struct inff_cfg80211_vif *vif);
+void inff_cp_cfg80211_link_up(struct inff_if *ifp, u8 *bssid);
+void inff_cp_cfg80211_link_down(struct inff_if *ifp);
+
+#endif /* INFF_INTERFACE_H */
-- 
2.25.1


