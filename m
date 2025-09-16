Return-Path: <linux-wireless+bounces-27394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D415BB7DCC0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FA51C063D3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC02E4274;
	Tue, 16 Sep 2025 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="LzG3Xi2f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083F2E2DF2
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061664; cv=none; b=eDybtshucTTZC0Bz+O670UfVNxMCrT5tBDTgWMhO9co79gv7QlK+sArccBznWpYiseDXcj499yvR64da91nQF8a+gWHiQz0hWY8YpHvLzjDLoqBgtKBqe6tAIzrbxJ+n9VcG2JB+UjU2Pho62/rVqCpjDR6cmHXlYJqIffOqtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061664; c=relaxed/simple;
	bh=qVuMdVuZJglVYjJKBgv1McBdTKL8LgXnnJbvy3Ttnww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCo5ET5IFCt4YFhqYn96VSU+5CNEJlhF33vC0u1fYikHRGpdln6/GRMJymivir0QpeBw08vnuQdHsWwUqYWIjNmisekW5d/WdQi5Sx5ehAkq3fJN0tTpTt7F7sX6FsnKhaVTSI+fjTdDmo1sfDR+c4hpAL5xdadKPZFEE/DzjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=LzG3Xi2f; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061661; x=1789597661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVuMdVuZJglVYjJKBgv1McBdTKL8LgXnnJbvy3Ttnww=;
  b=LzG3Xi2fMEFdNK9sGkkPJusQPICd4BHSX19bZKKiCaw0qqpa9tpr4hFa
   p3YINVQCUm1RvhrhaYMunDAuhcYwXMACnRqw082a5bgU4dy2532my8PE4
   Z+rJvPY+GDlhXk40NBABQgCKuoh/OCJft6QLjKAEGunHAO+P9X4DehxMG
   U=;
X-CSE-ConnectionGUID: 52JR3XnDSrmbNKVFgTsXIA==
X-CSE-MsgGUID: WbJ0lWj2QbKxrI5FKFI8kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918691"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918691"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:27:38 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:27:36 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:27:33 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 39/57] wifi: inffmac: add fweh.c/h
Date: Wed, 17 Sep 2025 03:47:59 +0530
Message-ID: <20250916221821.4387-45-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for registering and handling various types of
asynchronous events generated by the Device firmware.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/fweh.c | 1552 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/fweh.h |  402 +++++
 2 files changed, 1954 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/fweh.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/fweh.h

diff --git a/drivers/net/wireless/infineon/inffmac/fweh.c b/drivers/net/wireless/infineon/inffmac/fweh.c
new file mode 100644
index 000000000000..e8a5ae27a12c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/fweh.c
@@ -0,0 +1,1552 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/netdevice.h>
+
+#include "chanspec.h"
+#include "utils.h"
+#include "cfg80211.h"
+#include "core.h"
+#include "debug.h"
+#include "tracepoint.h"
+#include "fweh.h"
+#include "fwil.h"
+#include "proto.h"
+#include "common.h"
+#include "offload.h"
+#include "pmsr.h"
+#include "twt.h"
+#include "logger.h"
+
+/**
+ * struct inff_fweh_queue_item - event item on event queue.
+ *
+ * @q: list element for queuing.
+ * @code: event code.
+ * @ifidx: interface index related to this event.
+ * @ifaddr: ethernet address for interface.
+ * @emsg: common parameters of the firmware event message.
+ * @datalen: length of the data array
+ * @data: event specific data part of the firmware event.
+ */
+struct inff_fweh_queue_item {
+	struct list_head q;
+	enum inff_fweh_event_code code;
+	u8 ifidx;
+	u8 ifaddr[ETH_ALEN];
+	struct inff_event_msg_be emsg;
+	u32 datalen;
+	u8 data[] __counted_by(datalen);
+};
+
+/*
+ * struct inff_fweh_event_name - code, name mapping entry.
+ */
+struct inff_fweh_event_name {
+	enum inff_fweh_event_code code;
+	const char *name;
+};
+
+#ifdef DEBUG
+/* array for mapping code to event name */
+static struct inff_fweh_event_name fweh_event_names[] = {
+	{INFF_E_SET_SSID, "SET_SSID"},
+	{INFF_E_JOIN, "JOIN"},
+	{INFF_E_START, "START"},
+	{INFF_E_AUTH, "AUTH"},
+	{INFF_E_AUTH_IND, "AUTH_IND"},
+	{INFF_E_DEAUTH, "DEAUTH"},
+	{INFF_E_DEAUTH_IND, "DEAUTH_IND"},
+	{INFF_E_ASSOC, "ASSOC"},
+	{INFF_E_ASSOC_IND, "ASSOC_IND"},
+	{INFF_E_REASSOC, "REASSOC"},
+	{INFF_E_REASSOC_IND, "REASSOC_IND"},
+	{INFF_E_DISASSOC, "DISASSOC"},
+	{INFF_E_DISASSOC_IND, "DISASSOC_IND"},
+	{INFF_E_QUIET_START, "QUIET_START"},
+	{INFF_E_QUIET_END, "QUIET_END"},
+	{INFF_E_BEACON_RX, "BEACON_RX"},
+	{INFF_E_LINK, "LINK"},
+	{INFF_E_MIC_ERROR, "MIC_ERROR"},
+	{INFF_E_NDIS_LINK, "NDIS_LINK"},
+	{INFF_E_ROAM, "ROAM"},
+	{INFF_E_TXFAIL, "TXFAIL"},
+	{INFF_E_PMKID_CACHE, "PMKID_CACHE"},
+	{INFF_E_RETROGRADE_TSF, "RETROGRADE_TSF"},
+	{INFF_E_PRUNE, "PRUNE"},
+	{INFF_E_AUTOAUTH, "AUTOAUTH"},
+	{INFF_E_EAPOL_MSG, "EAPOL_MSG"},
+	{INFF_E_SCAN_COMPLETE, "SCAN_COMPLETE"},
+	{INFF_E_ADDTS_IND, "ADDTS_IND"},
+	{INFF_E_DELTS_IND, "DELTS_IND"},
+	{INFF_E_BCNSENT_IND, "BCNSENT_IND"},
+	{INFF_E_BCNRX_MSG, "BCNRX_MSG"},
+	{INFF_E_BCNLOST_MSG, "BCNLOST_MSG"},
+	{INFF_E_ROAM_PREP, "ROAM_PREP"},
+	{INFF_E_PFN_NET_FOUND, "PFN_NET_FOUND"},
+	{INFF_E_PFN_NET_LOST, "PFN_NET_LOST"},
+	{INFF_E_RESET_COMPLETE, "RESET_COMPLETE"},
+	{INFF_E_JOIN_START, "JOIN_START"},
+	{INFF_E_ROAM_START, "ROAM_START"},
+	{INFF_E_ASSOC_START, "ASSOC_START"},
+	{INFF_E_IBSS_ASSOC, "IBSS_ASSOC"},
+	{INFF_E_RADIO, "RADIO"},
+	{INFF_E_PSM_WATCHDOG, "PSM_WATCHDOG"},
+	{INFF_E_PROBREQ_MSG, "PROBREQ_MSG"},
+	{INFF_E_SCAN_CONFIRM_IND, "SCAN_CONFIRM_IND"},
+	{INFF_E_PSK_SUP, "PSK_SUP"},
+	{INFF_E_COUNTRY_CODE_CHANGED, "COUNTRY_CODE_CHANGED"},
+	{INFF_E_EXCEEDED_MEDIUM_TIME, "EXCEEDED_MEDIUM_TIME"},
+	{INFF_E_ICV_ERROR, "ICV_ERROR"},
+	{INFF_E_UNICAST_DECODE_ERROR, "UNICAST_DECODE_ERROR"},
+	{INFF_E_MULTICAST_DECODE_ERROR, "MULTICAST_DECODE_ERROR"},
+	{INFF_E_TRACE, "TRACE"},
+	{INFF_E_IF, "IF"},
+	{INFF_E_P2P_DISC_LISTEN_COMPLETE, "P2P_DISC_LISTEN_COMPLETE"},
+	{INFF_E_RSSI, "RSSI"},
+	{INFF_E_EXTLOG_MSG, "EXTLOG_MSG"},
+	{INFF_E_ACTION_FRAME, "ACTION_FRAME"},
+	{INFF_E_ACTION_FRAME_COMPLETE, "ACTION_FRAME_COMPLETE"},
+	{INFF_E_PRE_ASSOC_IND, "PRE_ASSOC_IND"},
+	{INFF_E_PRE_REASSOC_IND, "PRE_REASSOC_IND"},
+	{INFF_E_CHANNEL_ADOPTED, "CHANNEL_ADOPTED"},
+	{INFF_E_AP_STARTED, "AP_STARTED"},
+	{INFF_E_DFS_AP_STOP, "DFS_AP_STOP"},
+	{INFF_E_DFS_AP_RESUME, "DFS_AP_RESUME"},
+	{INFF_E_ESCAN_RESULT, "ESCAN_RESULT"},
+	{INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE, "ACTION_FRAME_OFF_CHAN_COMPLETE"},
+	{INFF_E_PROBERESP_MSG, "PROBERESP_MSG"},
+	{INFF_E_P2P_PROBEREQ_MSG, "P2P_PROBEREQ_MSG"},
+	{INFF_E_DCS_REQUEST, "DCS_REQUEST"},
+	{INFF_E_FIFO_CREDIT_MAP, "FIFO_CREDIT_MAP"},
+	{INFF_E_ACTION_FRAME_RX, "ACTION_FRAME_RX"},
+	{INFF_E_SA_COMPLETE_IND, "SA_COMPLETE_IND"},
+	{INFF_E_ASSOC_REQ_IE, "ASSOC_REQ_IE"},
+	{INFF_E_ASSOC_RESP_IE, "ASSOC_RESP_IE"},
+	{INFF_E_TDLS_PEER_EVENT, "TDLS_PEER_EVENT"},
+	{INFF_E_PROXD, "PROXD"},
+	{INFF_E_BCMC_CREDIT_SUPPORT, "BCMC_CREDIT_SUPPORT"},
+	{INFF_E_ULP, "ULP"},
+	{INFF_E_TWT_SETUP, "TWT_SETUP"},
+	{INFF_E_EXT_AUTH_REQ, "EXT_AUTH_REQ"},
+	{INFF_E_EXT_AUTH_FRAME_RX, "EXT_AUTH_FRAME_RX"},
+	{INFF_E_MGMT_FRAME_TXSTATUS, "MGMT_FRAME_TXSTATUS"},
+	{INFF_E_MGMT_FRAME_OFF_CHAN_COMPLETE, "MGMT_FRAME_OFF_CHAN_COMPLETE"},
+	{INFF_E_TWT_TEARDOWN, "TWT_TEARDOWN"},
+	{INFF_E_EXT_ASSOC_FRAME_RX, "EXT_ASSOC_FRAME_RX"},
+	{INFF_E_WLAN_SENSE_ENABLED, "WLAN_SENSE_ENABLED"},
+	{INFF_E_WLAN_SENSE_DATA, "WLAN_SENSE_DATA"},
+	{INFF_E_WLAN_SENSE_DISABLED, "WLAN_SENSE_DISABLED"},
+	{INFF_E_ICMP_ECHO_REQ, "ICMP_ECHO_REQ"}
+};
+
+/**
+ * inff_fweh_event_name() - returns name for given event code.
+ *
+ * @code: code to lookup.
+ */
+const char *inff_fweh_event_name(enum inff_fweh_event_code code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fweh_event_names); i++) {
+		if (fweh_event_names[i].code == code)
+			return fweh_event_names[i].name;
+	}
+	return "unknown";
+}
+#else
+const char *inff_fweh_event_name(enum inff_fweh_event_code code)
+{
+	return "nodebug";
+}
+#endif
+
+/**
+ * inff_fweh_queue_event() - create and queue event.
+ *
+ * @fweh: firmware event handling info.
+ * @event: event queue entry.
+ */
+static void inff_fweh_queue_event(struct inff_fweh_info *fweh,
+				  struct inff_fweh_queue_item *event)
+{
+	ulong flags;
+
+	spin_lock_irqsave(&fweh->evt_q_lock, flags);
+	list_add_tail(&event->q, &fweh->event_q);
+	spin_unlock_irqrestore(&fweh->evt_q_lock, flags);
+	schedule_work(&fweh->event_work);
+}
+
+static int inff_fweh_call_event_handler(struct inff_pub *drvr,
+					struct inff_if *ifp,
+					 enum inff_fweh_event_code code,
+					 struct inff_event_msg *emsg,
+					 void *data)
+{
+	struct inff_fweh_info *fweh;
+	int err = -EINVAL;
+
+	if (ifp) {
+		fweh = &ifp->drvr->fweh;
+
+		/* handle the event if valid interface and handler */
+		if (fweh->evt_handler[code])
+			err = fweh->evt_handler[code](ifp, emsg, data);
+		else
+			iphy_err(drvr, "unhandled event %d ignored\n", code);
+	} else {
+		iphy_err(drvr, "no interface object\n");
+	}
+	return err;
+}
+
+/**
+ * inff_fweh_handle_if_event() - handle IF event.
+ *
+ * @drvr: driver information object.
+ * @emsg: event message object.
+ * @data: event object.
+ */
+static void inff_fweh_handle_if_event(struct inff_pub *drvr,
+				      struct inff_event_msg *emsg,
+				       void *data)
+{
+	struct inff_if_event *ifevent = data;
+	struct inff_if *ifp;
+	bool is_p2pdev = false, is_wlan_sensedev = false;
+
+	inff_dbg(EVENT, "action: %u ifidx: %u bsscfgidx: %u flags: %u role: %u\n",
+		 ifevent->action, ifevent->ifidx, ifevent->bsscfgidx,
+		 ifevent->flags, ifevent->role);
+
+	/* The P2P Device interface event must not be ignored contrary to what
+	 * firmware tells us. Older firmware uses p2p noif, with sta role.
+	 * This should be accepted when p2pdev_setup is ongoing. TDLS setup will
+	 * use the same ifevent and should be ignored.
+	 */
+	is_p2pdev = ((ifevent->flags & INFF_E_IF_FLAG_NOIF) &&
+		     (ifevent->role == INFF_E_IF_ROLE_P2P_CLIENT ||
+		      ((ifevent->role == INFF_E_IF_ROLE_STA) &&
+		       (drvr->fweh.p2pdev_setup_ongoing))));
+
+	is_wlan_sensedev = ((ifevent->role == INFF_E_IF_ROLE_WLAN_SENSE) &&
+			    (drvr->fweh.wlan_sensedev_setup_ongoing));
+
+	if (!is_p2pdev && !is_wlan_sensedev &&
+	    (ifevent->flags & INFF_E_IF_FLAG_NOIF)) {
+		inff_dbg(EVENT, "event can be ignored\n");
+		return;
+	}
+
+	if (ifevent->ifidx >= INFF_MAX_IFS) {
+		iphy_err(drvr, "invalid interface index: %u\n", ifevent->ifidx);
+		return;
+	}
+
+	ifp = drvr->iflist[ifevent->bsscfgidx];
+
+	if (ifevent->action == INFF_E_IF_ADD) {
+		inff_dbg(EVENT, "adding %s (%pM)\n", emsg->ifname,
+			 emsg->addr);
+		ifp = inff_add_if(drvr, ifevent->bsscfgidx, ifevent->ifidx,
+				  emsg->ifname, emsg->addr, is_p2pdev, is_wlan_sensedev);
+		if (IS_ERR(ifp))
+			return;
+		if (!is_p2pdev && !is_wlan_sensedev)
+			inff_proto_add_if(drvr, ifp);
+		if (!drvr->fweh.evt_handler[INFF_E_IF])
+			if (inff_net_attach(ifp, false) < 0)
+				return;
+	}
+
+	if (ifp && ifevent->action == INFF_E_IF_CHANGE)
+		inff_proto_reset_if(drvr, ifp);
+
+	inff_fweh_call_event_handler(drvr, ifp, emsg->event_code, emsg,
+				     data);
+
+	if (ifp && ifevent->action == INFF_E_IF_DEL) {
+		bool armed = inff_cfg80211_vif_event_armed(drvr->config);
+
+		/* Default handling in case no-one waits for this event */
+		if (!armed)
+			inff_remove_interface(ifp, false);
+	}
+}
+
+/**
+ * inff_fweh_dequeue_event() - get event from the queue.
+ *
+ * @fweh: firmware event handling info.
+ */
+static struct inff_fweh_queue_item *
+inff_fweh_dequeue_event(struct inff_fweh_info *fweh)
+{
+	struct inff_fweh_queue_item *event = NULL;
+	ulong flags;
+
+	spin_lock_irqsave(&fweh->evt_q_lock, flags);
+	if (!list_empty(&fweh->event_q)) {
+		event = list_first_entry(&fweh->event_q,
+					 struct inff_fweh_queue_item, q);
+		list_del(&event->q);
+	}
+	spin_unlock_irqrestore(&fweh->evt_q_lock, flags);
+
+	return event;
+}
+
+/**
+ * inff_fweh_event_worker() - firmware event worker.
+ *
+ * @work: worker object.
+ */
+static void inff_fweh_event_worker(struct work_struct *work)
+{
+	struct inff_pub *drvr;
+	struct inff_if *ifp;
+	struct inff_fweh_info *fweh;
+	struct inff_fweh_queue_item *event;
+	int err = 0;
+	struct inff_event_msg_be *emsg_be;
+	struct inff_event_msg emsg;
+
+	fweh = container_of(work, struct inff_fweh_info, event_work);
+	drvr = container_of(fweh, struct inff_pub, fweh);
+
+	while ((event = inff_fweh_dequeue_event(fweh))) {
+		inff_dbg(EVENT, "event %s (%u) ifidx %u bsscfg %u addr %pM\n",
+			 inff_fweh_event_name(event->code), event->code,
+			  event->emsg.ifidx, event->emsg.bsscfgidx,
+			  event->emsg.addr);
+		if (event->emsg.bsscfgidx >= INFF_MAX_IFS) {
+			iphy_err(drvr, "invalid bsscfg index: %u\n", event->emsg.bsscfgidx);
+			goto event_free;
+		}
+
+		/* convert event message */
+		emsg_be = &event->emsg;
+		emsg.version = be16_to_cpu(emsg_be->version);
+		emsg.flags = be16_to_cpu(emsg_be->flags);
+		emsg.event_code = event->code;
+		emsg.status = be32_to_cpu(emsg_be->status);
+		emsg.reason = be32_to_cpu(emsg_be->reason);
+		emsg.auth_type = be32_to_cpu(emsg_be->auth_type);
+		emsg.datalen = be32_to_cpu(emsg_be->datalen);
+		memcpy(emsg.addr, emsg_be->addr, ETH_ALEN);
+		memcpy(emsg.ifname, emsg_be->ifname, sizeof(emsg.ifname));
+		emsg.ifidx = emsg_be->ifidx;
+		emsg.bsscfgidx = emsg_be->bsscfgidx;
+
+		inff_logring_fill(drvr, INFF_LOGRING_FW_EVENT, (u8 *)&emsg,
+				  sizeof(emsg));
+
+		inff_dbg(EVENT, "  version %u flags %u status %u reason %u\n",
+			 emsg.version, emsg.flags, emsg.status, emsg.reason);
+		inff_dbg_hex_dump(INFF_EVENT_ON(), event->data,
+				  min_t(u32, emsg.datalen, 64),
+				  "event payload, len=%d\n", emsg.datalen);
+
+		/* special handling of interface event */
+		if (event->code == INFF_E_IF) {
+			inff_fweh_handle_if_event(drvr, &emsg, event->data);
+			goto event_free;
+		}
+
+		if (event->code == INFF_E_TDLS_PEER_EVENT)
+			ifp = drvr->iflist[0];
+		else
+			ifp = drvr->iflist[emsg.bsscfgidx];
+		err = inff_fweh_call_event_handler(drvr, ifp, event->code,
+						   &emsg, event->data);
+		if (err) {
+			iphy_err(drvr, "event handler failed (%d)\n",
+				 event->code);
+			err = 0;
+		}
+event_free:
+		kfree(event);
+	}
+}
+
+/**
+ * inff_fweh_p2pdev_setup() - P2P device setup ongoing (or not).
+ *
+ * @ifp: ifp on which setup is taking place or finished.
+ * @ongoing: p2p device setup in progress (or not).
+ */
+void inff_fweh_p2pdev_setup(struct inff_if *ifp, bool ongoing)
+{
+	ifp->drvr->fweh.p2pdev_setup_ongoing = ongoing;
+}
+
+/**
+ * inff_fweh_wlan_sensedev_setup() - WLAN Sense device setup ongoing (or not).
+ *
+ * @ifp: ifp on which setup is taking place or finished.
+ * @ongoing: WLAN sense device setup in progress (or not).
+ */
+void inff_fweh_wlan_sensedev_setup(struct inff_if *ifp, bool ongoing)
+{
+	ifp->drvr->fweh.wlan_sensedev_setup_ongoing = ongoing;
+}
+
+static void inff_fweh_logring_event_print(u8 *data, u32 size)
+{
+	struct inff_logring_fw_event_item *evt_item =
+		(struct inff_logring_fw_event_item *)data;
+	struct inff_event_msg *emsg;
+
+	if (size != sizeof(*evt_item))
+		return;
+
+	emsg = &evt_item->emsg;
+
+	inff_dbg(INFO, "%llu: event %s (%u) ifidx %u bsscfg %u\n",
+		 evt_item->timestamp, inff_fweh_event_name(emsg->event_code),
+		 emsg->event_code, emsg->ifidx, emsg->bsscfgidx);
+}
+
+/**
+ * inff_fweh_attach() - initialize firmware event handling.
+ *
+ * @drvr: driver information object.
+ */
+void inff_fweh_attach(struct inff_pub *drvr)
+{
+	struct inff_fweh_info *fweh = &drvr->fweh;
+	s32 ret;
+
+	INIT_WORK(&fweh->event_work, inff_fweh_event_worker);
+	spin_lock_init(&fweh->evt_q_lock);
+	INIT_LIST_HEAD(&fweh->event_q);
+
+	ret = inff_logring_init(drvr, INFF_LOGRING_FW_EVENT,
+				sizeof(struct inff_logring_fw_event_item),
+				inff_fweh_logring_event_print);
+	if (ret)
+		inff_err("Logger: FW_EVENT logring initialization failed ret=%d\n", ret);
+}
+
+/**
+ * inff_fweh_detach() - cleanup firmware event handling.
+ *
+ * @drvr: driver information object.
+ */
+void inff_fweh_detach(struct inff_pub *drvr)
+{
+	struct inff_fweh_info *fweh = &drvr->fweh;
+
+	inff_logring_deinit(drvr, INFF_LOGRING_FW_EVENT);
+
+	/* cancel the worker if initialized */
+	if (fweh->event_work.func) {
+		cancel_work_sync(&fweh->event_work);
+		WARN_ON(!list_empty(&fweh->event_q));
+		memset(fweh->evt_handler, 0, sizeof(fweh->evt_handler));
+	}
+}
+
+/**
+ * inff_fweh_register() - register handler for given event code.
+ *
+ * @drvr: driver information object.
+ * @code: event code.
+ * @handler: handler for the given event code.
+ */
+int inff_fweh_register(struct inff_pub *drvr, enum inff_fweh_event_code code,
+		       inff_fweh_handler_t handler)
+{
+	if (drvr->fweh.evt_handler[code]) {
+		iphy_err(drvr, "event code %d already registered\n", code);
+		return -ENOSPC;
+	}
+	drvr->fweh.evt_handler[code] = handler;
+	inff_dbg(TRACE, "event handler registered for %s\n",
+		 inff_fweh_event_name(code));
+	return 0;
+}
+
+/**
+ * inff_fweh_unregister() - remove handler for given code.
+ *
+ * @drvr: driver information object.
+ * @code: event code.
+ */
+void inff_fweh_unregister(struct inff_pub *drvr,
+			  enum inff_fweh_event_code code)
+{
+	inff_dbg(TRACE, "event handler cleared for %s\n",
+		 inff_fweh_event_name(code));
+	drvr->fweh.evt_handler[code] = NULL;
+}
+
+/**
+ * inff_fweh_activate_events() - enables firmware events registered.
+ *
+ * @ifp: primary interface object.
+ */
+int inff_fweh_activate_events(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int i, err;
+	struct eventmsgs_ext *eventmask_msg;
+	u32 msglen;
+
+	msglen = EVENTMSGS_EXT_STRUCT_SIZE + INFF_EVENTING_MASK_LEN;
+	eventmask_msg = kzalloc(msglen, GFP_KERNEL);
+	if (!eventmask_msg)
+		return -ENOMEM;
+
+	for (i = 0; i < INFF_E_LAST; i++) {
+		if (ifp->drvr->fweh.evt_handler[i]) {
+			inff_dbg(EVENT, "enable event %s\n",
+				 inff_fweh_event_name(i));
+			setbit(eventmask_msg->mask, i);
+		}
+	}
+
+	/* want to handle IF event as well */
+	inff_dbg(EVENT, "enable event IF\n");
+	setbit(eventmask_msg->mask, INFF_E_IF);
+
+	eventmask_msg->ver = EVENTMSGS_VER;
+	eventmask_msg->command = EVENTMSGS_SET_MASK;
+	eventmask_msg->len = INFF_EVENTING_MASK_LEN;
+
+	err = inff_fil_iovar_data_set(ifp, "event_msgs_ext", eventmask_msg,
+				      msglen);
+	if (!err)
+		goto end;
+
+	err = inff_fil_iovar_data_set(ifp, "event_msgs", eventmask_msg->mask,
+				      INFF_EVENTING_MASK_LEN);
+	if (err)
+		iphy_err(drvr, "Set event_msgs error (%d)\n", err);
+
+end:
+	kfree(eventmask_msg);
+	return err;
+}
+
+/**
+ * inff_fweh_process_event() - process skb as firmware event.
+ *
+ * @drvr: driver information object.
+ * @event_packet: event packet to process.
+ * @packet_len: length of the packet
+ * @gfp: memory allocation flags.
+ *
+ * If the packet buffer contains a firmware event message it will
+ * dispatch the event to a registered handler (using worker).
+ */
+void inff_fweh_process_event(struct inff_pub *drvr,
+			     struct inff_event *event_packet,
+			      u32 packet_len, gfp_t gfp)
+{
+	enum inff_fweh_event_code code;
+	struct inff_fweh_info *fweh = &drvr->fweh;
+	struct inff_fweh_queue_item *event;
+	void *data;
+	u32 datalen;
+
+	/* get event info */
+	code = get_unaligned_be32(&event_packet->msg.event_type);
+	datalen = get_unaligned_be32(&event_packet->msg.datalen);
+	data = &event_packet[1];
+
+	if (code >= INFF_E_LAST)
+		return;
+
+	if (code != INFF_E_IF && !fweh->evt_handler[code])
+		return;
+
+	if (datalen > INFF_DCMD_MAXLEN ||
+	    datalen + sizeof(*event_packet) > packet_len)
+		return;
+
+	event = kzalloc(struct_size(event, data, datalen), gfp);
+	if (!event)
+		return;
+
+	event->datalen = datalen;
+	event->code = code;
+	event->ifidx = event_packet->msg.ifidx;
+
+	/* use memcpy to get aligned event message */
+	memcpy(&event->emsg, &event_packet->msg, sizeof(event->emsg));
+	memcpy(event->data, data, datalen);
+	memcpy(event->ifaddr, event_packet->eth.h_dest, ETH_ALEN);
+
+	inff_fweh_queue_event(fweh, event);
+}
+
+void inff_fweh_process_skb(struct inff_pub *drvr, struct sk_buff *skb, u16 stype,
+			   gfp_t gfp)
+{
+	struct inff_event *event_packet;
+	u16 subtype, usr_stype;
+
+	/* only process events when protocol matches */
+	if (skb->protocol != cpu_to_be16(ETH_P_LINK_CTL))
+		return;
+
+	if ((skb->len + ETH_HLEN) < sizeof(*event_packet))
+		return;
+
+	event_packet = (struct inff_event *)skb_mac_header(skb);
+
+	/* check subtype if needed */
+	if (unlikely(stype)) {
+		subtype = get_unaligned_be16(&event_packet->hdr.subtype);
+		if (subtype != stype)
+			return;
+	}
+
+	if (memcmp("\x00\x10\x18", &event_packet->hdr.oui[0],
+		   sizeof(event_packet->hdr.oui)))
+		return;
+
+	/* final match on usr_subtype */
+	usr_stype = get_unaligned_be16(&event_packet->hdr.usr_subtype);
+	if (usr_stype != INFILCP_INF_SUBTYPE_EVENT)
+		return;
+
+	inff_fweh_process_event(drvr, event_packet, skb->len + ETH_HLEN, gfp);
+}
+
+/* PFN result doesn't have all the info which are required by the supplicant
+ * (For e.g IEs) Do a target Escan so that sched scan results are reported
+ * via wl_inform_single_bss in the required format. Escan does require the
+ * scan request in the form of cfg80211_scan_request. For timebeing, create
+ * cfg80211_scan_request one out of the received PNO event.
+ */
+s32
+inff_notify_sched_scan_results(struct inff_if *ifp,
+			       const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_cfg80211_info *cfg = drvr->config;
+	struct inff_pno_net_info_le *netinfo, *netinfo_start;
+	struct cfg80211_scan_request *request = NULL;
+	struct wiphy *wiphy = cfg_to_wiphy(cfg);
+	int i, err = 0;
+	struct inff_pno_scanresults_le *pfn_result;
+	u32 bucket_map;
+	u32 result_count;
+	u32 status;
+	u32 datalen;
+
+	inff_dbg(SCAN, "Enter\n");
+
+	if (e->datalen < (sizeof(*pfn_result) + sizeof(*netinfo))) {
+		inff_dbg(SCAN, "Event data too small. Ignore\n");
+		return 0;
+	}
+
+	if (e->event_code == INFF_E_PFN_NET_LOST) {
+		inff_dbg(SCAN, "PFN NET LOST event. Do Nothing\n");
+		return 0;
+	}
+
+	pfn_result = (struct inff_pno_scanresults_le *)data;
+	result_count = le32_to_cpu(pfn_result->count);
+	status = le32_to_cpu(pfn_result->status);
+
+	/* PFN event is limited to fit 512 bytes so we may get
+	 * multiple NET_FOUND events. For now place a warning here.
+	 */
+	WARN_ON(status != INFF_PNO_SCAN_COMPLETE);
+	inff_dbg(SCAN, "PFN NET FOUND event. count: %d\n", result_count);
+	if (!result_count) {
+		iphy_err(drvr, "FALSE PNO Event. (pfn_count == 0)\n");
+		goto out_err;
+	}
+
+	netinfo_start = inff_get_netinfo_array(pfn_result);
+	/* To make sure e->datalen is big enough */
+	if (e->datalen >= ((void *)netinfo_start - (void *)pfn_result)) {
+		u32 cnt_sanity = ~0;
+
+		datalen = e->datalen - ((void *)netinfo_start - (void *)pfn_result);
+		if (datalen < result_count * sizeof(*netinfo) ||
+		    (result_count > cnt_sanity / sizeof(*netinfo))) {
+			inff_err("insufficient event data\n");
+			goto out_err;
+		}
+	} else {
+		inff_err("insufficient event data\n");
+		goto out_err;
+	}
+
+	request = inff_alloc_internal_escan_request(wiphy,
+						    result_count);
+	if (!request) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	bucket_map = 0;
+	for (i = 0; i < result_count; i++) {
+		netinfo = &netinfo_start[i];
+
+		if (netinfo->SSID_len > IEEE80211_MAX_SSID_LEN)
+			netinfo->SSID_len = IEEE80211_MAX_SSID_LEN;
+		inff_dbg(SCAN, "SSID:%.32s Channel:%d\n",
+			 netinfo->SSID, netinfo->channel);
+		bucket_map |= inff_pno_get_bucket_map(cfg->pno, netinfo);
+		err = inff_internal_escan_add_info(request,
+						   netinfo->SSID,
+						   netinfo->SSID_len,
+						   netinfo->channel);
+		if (err)
+			goto out_err;
+	}
+
+	if (!bucket_map)
+		goto free_req;
+
+	err = inff_start_internal_escan(ifp, bucket_map, request);
+	if (!err)
+		goto free_req;
+
+out_err:
+	cfg80211_sched_scan_stopped(wiphy, 0);
+free_req:
+	kfree(request);
+	return err;
+}
+
+static s32
+inff_notify_connect_status_ap(struct inff_cfg80211_info *cfg,
+			      struct net_device *ndev,
+			      const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = cfg->pub;
+	static int generation;
+	u32 event = e->event_code;
+	u32 reason = e->reason;
+	struct station_info *sinfo;
+
+	inff_dbg(CONN, "event %s (%u), reason %d\n",
+		 inff_fweh_event_name(event), event, reason);
+	if (event == INFF_E_LINK && reason == INFF_E_REASON_LINK_BSSCFG_DIS &&
+	    ndev != cfg_to_ndev(cfg)) {
+		inff_dbg(CONN, "AP mode link down\n");
+		complete(&cfg->vif_disabled);
+		return 0;
+	}
+
+	if ((event == INFF_E_ASSOC_IND || event == INFF_E_REASSOC_IND) &&
+	    reason == INFF_E_STATUS_SUCCESS) {
+		if (!data) {
+			iphy_err(drvr, "No IEs present in ASSOC/REASSOC_IND\n");
+			return -EINVAL;
+		}
+
+		sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+		if (!sinfo)
+			return -ENOMEM;
+
+		sinfo->assoc_req_ies = data;
+		sinfo->assoc_req_ies_len = e->datalen;
+		generation++;
+		sinfo->generation = generation;
+		cfg80211_new_sta(ndev, e->addr, sinfo, GFP_KERNEL);
+
+		kfree(sinfo);
+	} else if ((event == INFF_E_DISASSOC_IND) ||
+		   (event == INFF_E_DEAUTH_IND) ||
+		   (event == INFF_E_DEAUTH)) {
+		cfg80211_del_sta(ndev, e->addr, GFP_KERNEL);
+	}
+	return 0;
+}
+
+s32
+inff_notify_roaming_status(struct inff_if *ifp,
+			   const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	u32 event = e->event_code;
+	u32 status = e->status;
+
+	if (event == INFF_E_ROAM && status == INFF_E_STATUS_SUCCESS) {
+		if (test_bit(INFF_VIF_STATUS_CONNECTED,
+			     &ifp->vif->sme_state)) {
+			if (ifp->vif->profile.is_ft)
+				inff_bss_roaming_done(cfg, ifp->ndev, e);
+		} else {
+			inff_bss_connect_done(cfg, ifp->ndev, e, true);
+			inff_net_setcarrier(ifp, true);
+		}
+	}
+
+	return 0;
+}
+
+s32
+inff_notify_mic_status(struct inff_if *ifp,
+		       const struct inff_event_msg *e, void *data)
+{
+	u16 flags = e->flags;
+	enum nl80211_key_type key_type;
+
+	if (flags & INFF_EVENT_MSG_GROUP)
+		key_type = NL80211_KEYTYPE_GROUP;
+	else
+		key_type = NL80211_KEYTYPE_PAIRWISE;
+
+	cfg80211_michael_mic_failure(ifp->ndev, (u8 *)&e->addr, key_type, -1,
+				     NULL, GFP_KERNEL);
+
+	return 0;
+}
+
+s32 inff_notify_rssi(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	struct inff_rssi_be *info = data;
+	s32 rssi, snr = 0, noise = 0;
+	s32 low, high, last;
+
+	if (e->datalen >= sizeof(*info)) {
+		rssi = be32_to_cpu(info->rssi);
+		snr = be32_to_cpu(info->snr);
+		noise = be32_to_cpu(info->noise);
+	} else if (e->datalen >= sizeof(rssi)) {
+		rssi = be32_to_cpu(*(__be32 *)data);
+	} else {
+		inff_err("insufficient RSSI event data\n");
+		return 0;
+	}
+
+	low = vif->cqm_rssi_low;
+	high = vif->cqm_rssi_high;
+	last = vif->cqm_rssi_last;
+
+	inff_dbg(TRACE, "rssi=%d snr=%d noise=%d low=%d high=%d last=%d\n",
+		 rssi, snr, noise, low, high, last);
+
+	vif->cqm_rssi_last = rssi;
+
+	if (rssi <= low || rssi == 0) {
+		inff_dbg(INFO, "LOW rssi=%d\n", rssi);
+		cfg80211_cqm_rssi_notify(ifp->ndev,
+					 NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
+					 rssi, GFP_KERNEL);
+	} else if (rssi > high) {
+		inff_dbg(INFO, "HIGH rssi=%d\n", rssi);
+		cfg80211_cqm_rssi_notify(ifp->ndev,
+					 NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
+					 rssi, GFP_KERNEL);
+	}
+
+	return 0;
+}
+
+s32 inff_notify_vif_event(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_if_event *ifevent = (struct inff_if_event *)data;
+	struct inff_cfg80211_vif_event *event = &cfg->vif_event;
+	struct inff_cfg80211_vif *vif;
+	enum nl80211_iftype iftype = NL80211_IFTYPE_UNSPECIFIED;
+	bool vif_pend = false;
+	int err;
+
+	inff_dbg(TRACE, "Enter: action %u ifidx %u bsscfgidx %u flags %u role %u\n",
+		 ifevent->action, ifevent->ifidx, ifevent->bsscfgidx, ifevent->flags,
+		 ifevent->role);
+
+	spin_lock(&event->vif_event_lock);
+
+	event->action = ifevent->action;
+	vif = event->vif;
+
+	switch (ifevent->action) {
+	case INFF_E_IF_ADD:
+		/* waiting process may have timed out */
+		if (!vif) {
+			/* handle IF_ADD event from firmware */
+			spin_unlock(&event->vif_event_lock);
+			vif_pend = true;
+			if (ifevent->role == WL_INTERFACE_CREATE_STA)
+				iftype = NL80211_IFTYPE_STATION;
+			else if (ifevent->role == WL_INTERFACE_CREATE_AP)
+				iftype = NL80211_IFTYPE_AP;
+			else
+				vif_pend = false;
+
+			if (vif_pend) {
+				vif = inff_alloc_vif(cfg, iftype);
+				if (IS_ERR(vif)) {
+					inff_err("Role:%d failed to alloc vif\n",
+						 ifevent->role);
+					return PTR_ERR(vif);
+				}
+			} else {
+				inff_err("Invalid Role:%d\n", ifevent->role);
+				return -EBADF;
+			}
+		}
+
+		ifp->vif = vif;
+		vif->ifp = ifp;
+		if (ifp->ndev) {
+			vif->wdev.netdev = ifp->ndev;
+			ifp->ndev->ieee80211_ptr = &vif->wdev;
+			SET_NETDEV_DEV(ifp->ndev, wiphy_dev(cfg->wiphy));
+		}
+
+		if (vif_pend) {
+			err = inff_net_attach(ifp, false);
+			if (err) {
+				inff_err("netdevice register failed with err:%d\n",
+					 err);
+				inff_free_vif(vif);
+				free_netdev(ifp->ndev);
+			}
+			return err;
+		}
+
+		spin_unlock(&event->vif_event_lock);
+		wake_up(&event->vif_wq);
+		return 0;
+
+	case INFF_E_IF_DEL:
+		spin_unlock(&event->vif_event_lock);
+		/* event may not be upon user request */
+		if (inff_cfg80211_vif_event_armed(cfg))
+			wake_up(&event->vif_wq);
+		return 0;
+
+	case INFF_E_IF_CHANGE:
+		spin_unlock(&event->vif_event_lock);
+		wake_up(&event->vif_wq);
+		return 0;
+
+	default:
+		spin_unlock(&event->vif_event_lock);
+		break;
+	}
+	return -EINVAL;
+}
+
+s32
+inff_notify_ext_auth_request(struct inff_if *ifp,
+			     const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct cfg80211_external_auth_params params;
+	struct inff_auth_req_status_le *auth_req =
+		(struct inff_auth_req_status_le *)data;
+	s32 err = 0;
+	struct inff_auth_req_status_info_le_v2 *auth_req_v2 = NULL;
+	struct inff_bss_info_le *bi = NULL;
+	struct inff_cfg80211_info *cfg = drvr->config;
+
+	inff_dbg(INFO, "Enter: event %s (%d) received\n",
+		 inff_fweh_event_name(e->event_code), e->event_code);
+
+	if (drvr->wlc_ver.wlc_ver_major > INFF_AUTH_STATUS_V2_FW_MAJOR ||
+	    (drvr->wlc_ver.wlc_ver_major == INFF_AUTH_STATUS_V2_FW_MAJOR &&
+	    drvr->wlc_ver.wlc_ver_minor >= INFF_AUTH_STATUS_V2_FW_MINOR)) {
+		auth_req_v2 = (struct inff_auth_req_status_info_le_v2 *)data;
+		if (e->datalen < sizeof(*auth_req_v2)) {
+			inff_err("Ext auth req event data too small. Ignoring event\n");
+			return -EINVAL;
+		}
+		/* Inform bss info to cfg80211 layer as during roaming
+		 * Supplicant might not have scan results,if scan results
+		 * are not found the SAE auth uses HNP by default and
+		 * Target AP will reject the connection.
+		 */
+		if (e->datalen > sizeof(*auth_req_v2)) {
+			bi = (struct inff_bss_info_le *)&auth_req_v2->bss_info_le;
+			if (bi) {
+				err = inff_inform_single_bss(cfg, bi);
+				if (err) {
+					inff_err("failed to update bss info, err=%d\n", err);
+					return err;
+				}
+			} else {
+				inff_err("External Auth request bss info is null\n");
+				return -EINVAL;
+			}
+		}
+		/* 10 ms delay to update results in cfg80211 */
+		inff_delay(10);
+		memset(&params, 0, sizeof(params));
+		params.action = NL80211_EXTERNAL_AUTH_START;
+		params.key_mgmt_suite = ntohl(WLAN_AKM_SUITE_SAE);
+		params.status = WLAN_STATUS_SUCCESS;
+		params.ssid.ssid_len = min_t(u32, IEEE80211_MAX_SSID_LEN, auth_req_v2->ssid_len);
+		memcpy(params.ssid.ssid, auth_req_v2->ssid, params.ssid.ssid_len);
+		memcpy(params.bssid, auth_req_v2->peer_mac, ETH_ALEN);
+	} else {
+		if (e->datalen < sizeof(*auth_req)) {
+			iphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+				 inff_fweh_event_name(e->event_code), e->event_code);
+			return -EINVAL;
+		}
+
+		memset(&params, 0, sizeof(params));
+		params.action = NL80211_EXTERNAL_AUTH_START;
+		params.key_mgmt_suite = ntohl(WLAN_AKM_SUITE_SAE);
+		params.status = WLAN_STATUS_SUCCESS;
+		params.ssid.ssid_len = min_t(u32, 32, le32_to_cpu(auth_req->ssid_len));
+		memcpy(params.ssid.ssid, auth_req->ssid, params.ssid.ssid_len);
+		memcpy(params.bssid, auth_req->peer_mac, ETH_ALEN);
+	}
+	err = cfg80211_external_auth_request(ifp->ndev, &params, GFP_ATOMIC);
+	if (err)
+		iphy_err(drvr, "Ext Auth request to supplicant failed (%d)\n",
+			 err);
+
+	return err;
+}
+
+s32
+inff_notify_auth_frame_rx(struct inff_if *ifp,
+			  const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_cfg80211_info *cfg = drvr->config;
+	struct wireless_dev *wdev;
+	u32 mgmt_frame_len = e->datalen - sizeof(struct inff_rx_mgmt_data);
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	u8 *frame = (u8 *)(rxframe + 1);
+	struct inff_chan ch;
+	struct ieee80211_mgmt *mgmt_frame;
+	s32 freq;
+
+	inff_dbg(INFO, "Enter: event %s (%d) received\n",
+		 inff_fweh_event_name(e->event_code), e->event_code);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		iphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+			 inff_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
+	wdev = &ifp->vif->wdev;
+	WARN_ON(!wdev);
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	cfg->d11inf.decchspec(&ch);
+
+	mgmt_frame = kzalloc(mgmt_frame_len, GFP_KERNEL);
+	if (!mgmt_frame)
+		return -ENOMEM;
+
+	mgmt_frame->frame_control = cpu_to_le16(IEEE80211_STYPE_AUTH);
+	memcpy(mgmt_frame->da, ifp->mac_addr, ETH_ALEN);
+	memcpy(mgmt_frame->sa, e->addr, ETH_ALEN);
+	inff_fil_cmd_data_get(ifp, INFF_C_GET_BSSID, mgmt_frame->bssid,
+			      ETH_ALEN);
+	frame += offsetof(struct ieee80211_mgmt, u);
+	unsafe_memcpy(&mgmt_frame->u, frame,
+		      mgmt_frame_len - offsetof(struct ieee80211_mgmt, u),
+		      /* alloc enough buf*/);
+
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
+					      inff_d11_chan_band_to_nl80211(ch.band));
+
+	cfg80211_rx_mgmt(wdev, freq, 0, (u8 *)mgmt_frame, mgmt_frame_len,
+			 NL80211_RXMGMT_FLAG_EXTERNAL_AUTH);
+	kfree(mgmt_frame);
+	return 0;
+}
+
+s32
+inff_notify_mgmt_tx_status(struct inff_if *ifp,
+			   const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	u32 *packet_id = (u32 *)data;
+
+	inff_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		  e->status);
+
+	if (!test_bit(INFF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status) ||
+	    (*packet_id != vif->mgmt_tx_id))
+		return 0;
+
+	if (e->event_code == INFF_E_MGMT_FRAME_TXSTATUS) {
+		if (e->status == INFF_E_STATUS_SUCCESS)
+			set_bit(INFF_MGMT_TX_ACK, &vif->mgmt_tx_status);
+		else
+			set_bit(INFF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
+	} else {
+		set_bit(INFF_MGMT_TX_OFF_CHAN_COMPLETED, &vif->mgmt_tx_status);
+	}
+
+	complete(&vif->mgmt_tx);
+	return 0;
+}
+
+s32
+inff_notify_rssi_change_ind(struct inff_if *ifp,
+			    const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct wl_event_data_rssi *value = (struct wl_event_data_rssi *)data;
+	s32 rssi = 0;
+
+	inff_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		 e->status);
+
+	if (!cfg->cqm_info.enable)
+		return 0;
+
+	rssi = ntohl(value->rssi);
+	inff_dbg(TRACE, "rssi: %d, threshold: %d, send event(%s)\n",
+		 rssi, cfg->cqm_info.rssi_threshold,
+		 rssi > cfg->cqm_info.rssi_threshold ? "HIGH" : "LOW");
+	cfg80211_cqm_rssi_notify(cfg_to_ndev(cfg),
+				 (rssi > cfg->cqm_info.rssi_threshold ?
+					NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH :
+					NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW),
+				 rssi, GFP_KERNEL);
+
+	return 0;
+}
+
+s32
+inff_notify_beacon_loss(struct inff_if *ifp,
+			const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct cfg80211_bss *bss;
+	struct net_device *ndev = ifp->ndev;
+
+	inff_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		  e->status);
+
+	switch (ifp->drvr->settings->roamoff) {
+	case INFF_ROAMOFF_EN_BCNLOST_MSG:
+		/* On beacon loss event, Supplicant triggers new scan request
+		 * with NL80211_SCAN_FLAG_FLUSH Flag set, but lost AP bss entry
+		 * still remained as it is held by cfg as associated. Unlinking this
+		 * current BSS from cfg cached bss list on beacon loss event here,
+		 * would allow supplicant to receive new scanned entries
+		 * without current bss and select new bss to trigger roam.
+		 */
+		bss = cfg80211_get_bss(cfg->wiphy, NULL, profile->bssid, 0, 0,
+				       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
+		if (bss) {
+			cfg80211_unlink_bss(cfg->wiphy, bss);
+			cfg80211_put_bss(cfg->wiphy, bss);
+		}
+
+		cfg80211_cqm_beacon_loss_notify(cfg_to_ndev(cfg), GFP_KERNEL);
+		break;
+	case INFF_ROAMOFF_EN_DISCONNECT_EVT:
+		inff_link_down(ifp->vif,
+			       WLAN_REASON_UNSPECIFIED,
+			       true);
+		inff_init_prof(ndev_to_prof(ndev));
+		if (ndev != cfg_to_ndev(cfg))
+			complete(&cfg->vif_disabled);
+		inff_net_setcarrier(ifp, false);
+		break;
+
+	case INFF_ROAMOFF_DISABLE:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+s32
+inff_notify_ext_assoc_frame_rx(struct inff_if *ifp,
+			       const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev = ifp->ndev;
+	u32 mgmt_frame_len = e->datalen - sizeof(struct inff_rx_mgmt_data);
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	u8 *frame = (u8 *)(rxframe + 1);
+	struct cfg80211_update_owe_info owe_info;
+	struct ieee80211_mgmt *mgmt_frame = (struct ieee80211_mgmt *)frame;
+
+	inff_dbg(INFO, "Enter: event %s (%d) received\n",
+		 inff_fweh_event_name(e->event_code), e->event_code);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		iphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+			 inff_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
+	memset(&owe_info, 0, sizeof(struct cfg80211_update_owe_info));
+	owe_info.ie_len = mgmt_frame_len - offsetof(struct ieee80211_mgmt, u);
+	memcpy(owe_info.peer, e->addr, ETH_ALEN);
+	owe_info.ie = kzalloc(owe_info.ie_len, GFP_KERNEL);
+	owe_info.assoc_link_id = -1;
+
+	if (!owe_info.ie)
+		return -ENOMEM;
+
+	if (ieee80211_is_assoc_req(mgmt_frame->frame_control)) {
+		frame += offsetof(struct ieee80211_mgmt, u.assoc_req.variable);
+	} else if (ieee80211_is_reassoc_req(mgmt_frame->frame_control)) {
+		frame += offsetof(struct ieee80211_mgmt, u.reassoc_req.variable);
+	} else {
+		iphy_err(drvr, "unexpected FC:0x%x\n", mgmt_frame->frame_control);
+		return -EINVAL;
+	}
+
+	memcpy((u8 *)owe_info.ie, frame, owe_info.ie_len);
+	cfg80211_update_owe_info_event(ndev, &owe_info, GFP_KERNEL);
+
+	kfree(owe_info.ie);
+	return 0;
+}
+
+s32
+inff_notify_assoc_req_ie(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
+	u32 event = e->event_code;
+	u32 status = e->status;
+	u32 req_len = e->datalen;
+
+	inff_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		  e->status);
+
+	if (event == INFF_E_ASSOC_REQ_IE && status == INFF_E_STATUS_SUCCESS) {
+		if (test_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state) ||
+		    test_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)) {
+			inff_clear_assoc_req_ie(cfg);
+
+			conn_info->req_ie_len = req_len;
+			conn_info->req_ie = kmemdup(data, conn_info->req_ie_len, GFP_KERNEL);
+			if (!conn_info->req_ie)
+				conn_info->req_ie_len = 0;
+			inff_dbg(CONN, "req ie (%p) req len (%d)\n", conn_info->req_ie,
+				 conn_info->req_ie_len);
+		} else {
+			inff_err("No (Re)connection is in progress, Ignore event\n");
+		}
+	} else {
+		inff_err("Failed to handle the event\n");
+	}
+
+	return 0;
+}
+
+s32
+inff_notify_assoc_resp_ie(struct inff_if *ifp,
+			  const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
+	struct inff_cfg80211_edcf_acparam edcf_acparam_info[EDCF_AC_COUNT];
+	u32 event = e->event_code;
+	u32 status = e->status;
+	u32 resp_len = e->datalen;
+	s32 err = 0;
+
+	inff_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		  e->status);
+
+	if (event == INFF_E_ASSOC_RESP_IE && status == INFF_E_STATUS_SUCCESS) {
+		if (test_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state) ||
+		    test_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)) {
+			inff_clear_assoc_resp_ie(cfg);
+
+			conn_info->resp_ie_len = resp_len;
+			conn_info->resp_ie = kmemdup(data, conn_info->resp_ie_len, GFP_KERNEL);
+			if (!conn_info->resp_ie)
+				conn_info->resp_ie_len = 0;
+
+			inff_dbg(CONN, "resp ie (%p) resp len (%d)\n", conn_info->resp_ie,
+				 conn_info->resp_ie_len);
+			err = inff_fil_iovar_data_get(ifp, "wme_ac_sta",
+						      edcf_acparam_info,
+						       sizeof(edcf_acparam_info));
+			if (err) {
+				inff_err("could not get wme_ac_sta (%d)\n", err);
+				inff_clear_assoc_resp_ie(cfg);
+			} else {
+				inff_wifi_prioritize_acparams(edcf_acparam_info,
+							      cfg->ac_priority);
+			}
+		} else {
+			inff_err("No (Re)connection is in progress, Ignore event\n");
+		}
+	} else {
+		inff_err("Failed to handle the event\n");
+	}
+
+	return 0;
+}
+
+static u16 inff_map_fw_linkdown_reason(const struct inff_event_msg *e)
+{
+	u16 reason;
+
+	switch (e->event_code) {
+	case INFF_E_DEAUTH:
+	case INFF_E_DEAUTH_IND:
+	case INFF_E_DISASSOC_IND:
+		reason = e->reason;
+		break;
+	case INFF_E_LINK:
+	default:
+		reason = 0;
+		break;
+	}
+	return reason;
+}
+
+s32
+inff_notify_connect_status(struct inff_if *ifp,
+			   const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct net_device *ndev = ifp->ndev;
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct ieee80211_channel *chan;
+	s32 err = 0;
+
+	if (e->event_code == INFF_E_DEAUTH ||
+	    e->event_code == INFF_E_DEAUTH_IND ||
+	    e->event_code == INFF_E_DISASSOC_IND ||
+	    (e->event_code == INFF_E_LINK && !e->flags)) {
+		inff_proto_delete_peer(ifp->drvr, ifp->ifidx, (u8 *)e->addr);
+	}
+
+	if (inff_is_apmode(ifp->vif)) {
+		if (e->event_code == INFF_E_ASSOC_IND ||
+		    e->event_code == INFF_E_REASSOC_IND) {
+			inff_findadd_sta(ifp, e->addr);
+		} else if ((e->event_code == INFF_E_DISASSOC_IND) ||
+				(e->event_code == INFF_E_DEAUTH_IND) ||
+				(e->event_code == INFF_E_DEAUTH)) {
+			inff_del_sta(ifp, e->addr);
+		}
+		err = inff_notify_connect_status_ap(cfg, ndev, e, data);
+		inff_mchan_config(cfg);
+	} else if (inff_is_linkup(ifp->vif, e)) {
+		inff_dbg(CONN, "Linkup\n");
+		if (inff_is_ibssmode(ifp->vif)) {
+			inff_inform_ibss(cfg, ndev, e->addr);
+			chan = ieee80211_get_channel(cfg->wiphy, cfg->channel);
+			memcpy(profile->bssid, e->addr, ETH_ALEN);
+			cfg80211_ibss_joined(ndev, e->addr, chan, GFP_KERNEL);
+			clear_bit(INFF_VIF_STATUS_CONNECTING,
+				  &ifp->vif->sme_state);
+			set_bit(INFF_VIF_STATUS_CONNECTED,
+				&ifp->vif->sme_state);
+		} else {
+			if (e->event_code == INFF_E_LINK && !profile->is_ft &&
+			    test_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state)) {
+				inff_bss_roaming_done(cfg, ndev, e);
+			} else {
+				inff_bss_connect_done(cfg, ndev, e, true);
+			}
+		}
+		inff_net_setcarrier(ifp, true);
+		inff_mchan_config(cfg);
+	} else if (inff_is_linkdown(ifp->vif, e)) {
+		inff_dbg(CONN, "Linkdown\n");
+		if (!inff_is_ibssmode(ifp->vif) &&
+		    (test_bit(INFF_VIF_STATUS_CONNECTED,
+			      &ifp->vif->sme_state) ||
+		     test_bit(INFF_VIF_STATUS_CONNECTING,
+			      &ifp->vif->sme_state))) {
+			if (test_bit(INFF_VIF_STATUS_CONNECTED,
+				     &ifp->vif->sme_state) &&
+			    memcmp(profile->bssid, e->addr, ETH_ALEN))
+				return err;
+
+			inff_bss_connect_done(cfg, ndev, e, false);
+			inff_link_down(ifp->vif,
+				       inff_map_fw_linkdown_reason(e),
+					e->event_code &
+					(INFF_E_DEAUTH_IND |
+					INFF_E_DISASSOC_IND)
+					? false : true);
+			inff_init_prof(ndev_to_prof(ndev));
+			if (ndev != cfg_to_ndev(cfg))
+				complete(&cfg->vif_disabled);
+			inff_net_setcarrier(ifp, false);
+		}
+		inff_proto_cleanup_if(ifp->drvr, ifp);
+	} else if (inff_is_nonetwork(cfg, e)) {
+		if (inff_is_ibssmode(ifp->vif))
+			clear_bit(INFF_VIF_STATUS_CONNECTING,
+				  &ifp->vif->sme_state);
+		else
+			inff_bss_connect_done(cfg, ndev, e, false);
+	}
+
+	return err;
+}
+
+s32
+inff_notify_csa_completion_ind(struct inff_if *ifp,
+			       const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg;
+	struct net_device *ndev;
+	struct wiphy *wiphy;
+	struct cfg80211_chan_def chandef;
+	struct wireless_dev *wdev;
+
+	int error = 0;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	if (unlikely(e->status)) {
+		inff_err("status:0x%x\n", e->status);
+		return -EINVAL;
+	}
+
+	if (!ifp)
+		return -EINVAL;
+	else if (!ifp->drvr)
+		return -EINVAL;
+
+	cfg = ifp->drvr->config;
+	ndev = ifp->ndev;
+	wiphy = cfg_to_wiphy(cfg);
+
+	if (!cfg || !ndev || !wiphy)
+		return -EINVAL;
+
+	wdev = ndev->ieee80211_ptr;
+	if (!wdev)
+		return -EINVAL;
+
+	if (!wdev->u.ibss.current_bss) {
+		inff_err("Got csa_completion event while no connection\n");
+		return -EINVAL;
+	}
+
+	memset(&chandef, 0, sizeof(chandef));
+	/* Reuse cfg80211 call to get chandef */
+	error = inff_cfg80211_get_channel(wiphy, wdev, 0, &chandef);
+	if (unlikely(error)) {
+		inff_err("Get chandef error: %d\n", error);
+		return -EINVAL;
+	}
+
+	/* Send channel switch notification only for STA mode */
+	if (wdev->iftype == NL80211_IFTYPE_STATION) {
+		cfg80211_ch_switch_notify(ndev, &chandef, 0);
+		inff_dbg(TRACE, "CSA sent upstream\n");
+	}
+
+	return 0;
+}
+
+void inff_register_event_handlers(struct inff_cfg80211_info *cfg)
+{
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct wl_rssi_event rssi_event = {};
+	int err = 0;
+
+	/* get supported version from firmware side */
+	err = inff_fil_iovar_data_get(ifp, "rssi_event", &rssi_event,
+				      sizeof(rssi_event));
+	if (err)
+		inff_err("fail to get supported rssi_event version, err=%d\n", err);
+
+	inff_fweh_register(cfg->pub, INFF_E_LINK,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_DEAUTH_IND,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_DEAUTH,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_DISASSOC_IND,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_ASSOC_IND,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_REASSOC_IND,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_ROAM,
+			   inff_notify_roaming_status);
+	inff_fweh_register(cfg->pub, INFF_E_MIC_ERROR,
+			   inff_notify_mic_status);
+	inff_fweh_register(cfg->pub, INFF_E_SET_SSID,
+			   inff_notify_connect_status);
+	inff_fweh_register(cfg->pub, INFF_E_PFN_NET_FOUND,
+			   inff_notify_sched_scan_results);
+	inff_fweh_register(cfg->pub, INFF_E_SA_COMPLETE_IND,
+			   inff_notify_csa_completion_ind);
+	inff_fweh_register(cfg->pub, INFF_E_IF,
+			   inff_notify_vif_event);
+	inff_fweh_register(cfg->pub, INFF_E_P2P_PROBEREQ_MSG,
+			   inff_p2p_notify_rx_mgmt_p2p_probereq);
+	inff_fweh_register(cfg->pub, INFF_E_P2P_DISC_LISTEN_COMPLETE,
+			   inff_p2p_notify_listen_complete);
+	inff_fweh_register(cfg->pub, INFF_E_ACTION_FRAME_RX,
+			   inff_p2p_notify_action_frame_rx);
+	inff_fweh_register(cfg->pub, INFF_E_ACTION_FRAME_COMPLETE,
+			   inff_p2p_notify_action_tx_complete);
+	inff_fweh_register(cfg->pub, INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE,
+			   inff_p2p_notify_action_tx_complete);
+	inff_fweh_register(cfg->pub, INFF_E_PSK_SUP,
+			   inff_notify_connect_status);
+	if (rssi_event.version == WL_RSSI_EVENT_VERSION_NEW)
+		inff_fweh_register(cfg->pub, INFF_E_RSSI,
+				   inff_notify_rssi_change_ind);
+	else if (rssi_event.version == WL_RSSI_EVENT_VERSION_OLD)
+		inff_fweh_register(cfg->pub, INFF_E_RSSI,
+				   inff_notify_rssi);
+	inff_fweh_register(cfg->pub, INFF_E_EXT_AUTH_REQ,
+			   inff_notify_ext_auth_request);
+	inff_fweh_register(cfg->pub, INFF_E_EXT_AUTH_FRAME_RX,
+			   inff_notify_auth_frame_rx);
+	inff_fweh_register(cfg->pub, INFF_E_MGMT_FRAME_TXSTATUS,
+			   inff_notify_mgmt_tx_status);
+	inff_fweh_register(cfg->pub, INFF_E_MGMT_FRAME_OFF_CHAN_COMPLETE,
+			   inff_notify_mgmt_tx_status);
+	inff_fweh_register(cfg->pub, INFF_E_BCNLOST_MSG,
+			   inff_notify_beacon_loss);
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_TWT)) {
+		inff_fweh_register(cfg->pub, INFF_E_TWT_SETUP,
+				   inff_notify_twt_event);
+		inff_fweh_register(cfg->pub, INFF_E_TWT_TEARDOWN,
+				   inff_notify_twt_event);
+	}
+	inff_fweh_register(cfg->pub, INFF_E_EXT_ASSOC_FRAME_RX,
+			   inff_notify_ext_assoc_frame_rx);
+	inff_fweh_register(cfg->pub, INFF_E_ASSOC_REQ_IE,
+			   inff_notify_assoc_req_ie);
+	inff_fweh_register(cfg->pub, INFF_E_ASSOC_RESP_IE,
+			   inff_notify_assoc_resp_ie);
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FTM))
+		inff_fweh_register(cfg->pub, INFF_E_PROXD,
+				   inff_notify_ftm_evt);
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_WLAN_SENSE)) {
+		inff_fweh_register(cfg->pub, INFF_E_WLAN_SENSE_ENABLED,
+				   inff_notify_wlan_sense_event);
+		inff_fweh_register(cfg->pub, INFF_E_WLAN_SENSE_DATA,
+				   inff_notify_wlan_sense_event);
+		inff_fweh_register(cfg->pub, INFF_E_WLAN_SENSE_DISABLED,
+				   inff_notify_wlan_sense_event);
+	}
+	inff_fweh_register(cfg->pub, INFF_E_ICMP_ECHO_REQ,
+			   inff_notify_icmp_echo_req_event);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/fweh.h b/drivers/net/wireless/infineon/inffmac/fweh.h
new file mode 100644
index 000000000000..fcbc00ba145d
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/fweh.h
@@ -0,0 +1,402 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FWEH_H
+#define INFF_FWEH_H
+
+#include <linux/unaligned.h>
+#include <linux/skbuff.h>
+#include <linux/if_ether.h>
+#include <linux/if.h>
+
+/* formward declarations */
+struct inff_pub;
+struct inff_if;
+struct inff_cfg80211_info;
+
+/* list of firmware events */
+/* firmware event codes sent by the dongle */
+enum inff_fweh_event_code {
+	INFF_E_SET_SSID = 0,
+	INFF_E_JOIN = 1,
+	INFF_E_START = 2,
+	INFF_E_AUTH = 3,
+	INFF_E_AUTH_IND = 4,
+	INFF_E_DEAUTH = 5,
+	INFF_E_DEAUTH_IND = 6,
+	INFF_E_ASSOC = 7,
+	INFF_E_ASSOC_IND = 8,
+	INFF_E_REASSOC = 9,
+	INFF_E_REASSOC_IND = 10,
+	INFF_E_DISASSOC = 11,
+	INFF_E_DISASSOC_IND = 12,
+	INFF_E_QUIET_START = 13,
+	INFF_E_QUIET_END = 14,
+	INFF_E_BEACON_RX = 15,
+	INFF_E_LINK = 16,
+	INFF_E_MIC_ERROR = 17,
+	INFF_E_NDIS_LINK = 18,
+	INFF_E_ROAM = 19,
+	INFF_E_TXFAIL = 20,
+	INFF_E_PMKID_CACHE = 21,
+	INFF_E_RETROGRADE_TSF = 22,
+	INFF_E_PRUNE = 23,
+	INFF_E_AUTOAUTH = 24,
+	INFF_E_EAPOL_MSG = 25,
+	INFF_E_SCAN_COMPLETE = 26,
+	INFF_E_ADDTS_IND = 27,
+	INFF_E_DELTS_IND = 28,
+	INFF_E_BCNSENT_IND = 29,
+	INFF_E_BCNRX_MSG = 30,
+	INFF_E_BCNLOST_MSG = 31,
+	INFF_E_ROAM_PREP = 32,
+	INFF_E_PFN_NET_FOUND = 33,
+	INFF_E_PFN_NET_LOST = 34,
+	INFF_E_RESET_COMPLETE = 35,
+	INFF_E_JOIN_START = 36,
+	INFF_E_ROAM_START = 37,
+	INFF_E_ASSOC_START = 38,
+	INFF_E_IBSS_ASSOC = 39,
+	INFF_E_RADIO = 40,
+	INFF_E_PSM_WATCHDOG = 41,
+	INFF_E_PROBREQ_MSG = 44,
+	INFF_E_SCAN_CONFIRM_IND = 45,
+	INFF_E_PSK_SUP = 46,
+	INFF_E_COUNTRY_CODE_CHANGED = 47,
+	INFF_E_EXCEEDED_MEDIUM_TIME = 48,
+	INFF_E_ICV_ERROR = 49,
+	INFF_E_UNICAST_DECODE_ERROR = 50,
+	INFF_E_MULTICAST_DECODE_ERROR = 51,
+	INFF_E_TRACE = 52,
+	INFF_E_IF = 54,
+	INFF_E_P2P_DISC_LISTEN_COMPLETE = 55,
+	INFF_E_RSSI = 56,
+	INFF_E_EXTLOG_MSG = 58,
+	INFF_E_ACTION_FRAME = 59,
+	INFF_E_ACTION_FRAME_COMPLETE = 60,
+	INFF_E_PRE_ASSOC_IND = 61,
+	INFF_E_PRE_REASSOC_IND = 62,
+	INFF_E_CHANNEL_ADOPTED = 63,
+	INFF_E_AP_STARTED = 64,
+	INFF_E_DFS_AP_STOP = 65,
+	INFF_E_DFS_AP_RESUME = 66,
+	INFF_E_ESCAN_RESULT = 69,
+	INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE = 70,
+	INFF_E_PROBERESP_MSG = 71,
+	INFF_E_P2P_PROBEREQ_MSG = 72,
+	INFF_E_DCS_REQUEST = 73,
+	INFF_E_FIFO_CREDIT_MAP = 74,
+	INFF_E_ACTION_FRAME_RX = 75,
+	INFF_E_SA_COMPLETE_IND = 80,
+	INFF_E_ASSOC_REQ_IE = 87,
+	INFF_E_ASSOC_RESP_IE = 88,
+	INFF_E_TDLS_PEER_EVENT = 92,
+	INFF_E_PROXD = 109,
+	INFF_E_BCMC_CREDIT_SUPPORT = 127,
+	INFF_E_ULP = 146,
+	INFF_E_TWT_SETUP = 157,
+	INFF_E_EXT_AUTH_REQ = 187,
+	INFF_E_EXT_AUTH_FRAME_RX = 188,
+	INFF_E_MGMT_FRAME_TXSTATUS = 189,
+	INFF_E_MGMT_FRAME_OFF_CHAN_COMPLETE = 190,
+	INFF_E_TWT_TEARDOWN = 195,
+	INFF_E_EXT_ASSOC_FRAME_RX = 196,
+	INFF_E_WLAN_SENSE_ENABLED = 198,
+	INFF_E_WLAN_SENSE_DATA = 199,
+	INFF_E_WLAN_SENSE_DISABLED = 200,
+	INFF_E_ICMP_ECHO_REQ = 202,
+	/* this determines event mask length which must match
+	 * minimum length check in device firmware so it is
+	 * hard-coded here.
+	 */
+	INFF_E_LAST = 203
+};
+
+#define INFF_EVENTING_MASK_LEN		DIV_ROUND_UP(INFF_E_LAST, 8)
+
+/* flags field values in struct inff_event_msg */
+#define INFF_EVENT_MSG_LINK		0x01
+#define INFF_EVENT_MSG_FLUSHTXQ	0x02
+#define INFF_EVENT_MSG_GROUP		0x04
+
+/* status field values in struct inff_event_msg */
+#define INFF_E_STATUS_SUCCESS			0
+#define INFF_E_STATUS_FAIL			1
+#define INFF_E_STATUS_TIMEOUT			2
+#define INFF_E_STATUS_NO_NETWORKS		3
+#define INFF_E_STATUS_ABORT			4
+#define INFF_E_STATUS_NO_ACK			5
+#define INFF_E_STATUS_UNSOLICITED		6
+#define INFF_E_STATUS_ATTEMPT			7
+#define INFF_E_STATUS_PARTIAL			8
+#define INFF_E_STATUS_NEWSCAN			9
+#define INFF_E_STATUS_NEWASSOC			10
+#define INFF_E_STATUS_11HQUIET			11
+#define INFF_E_STATUS_SUPPRESS			12
+#define INFF_E_STATUS_NOCHANS			13
+#define INFF_E_STATUS_CS_ABORT			15
+#define INFF_E_STATUS_ERROR			16
+
+/* status field values for PSK_SUP event */
+#define INFF_E_STATUS_FWSUP_WAIT_M1		4
+#define INFF_E_STATUS_FWSUP_PREP_M2		5
+#define INFF_E_STATUS_FWSUP_COMPLETED		6
+#define INFF_E_STATUS_FWSUP_TIMEOUT		7
+#define INFF_E_STATUS_FWSUP_WAIT_M3		8
+#define INFF_E_STATUS_FWSUP_PREP_M4		9
+#define INFF_E_STATUS_FWSUP_WAIT_G1		10
+#define INFF_E_STATUS_FWSUP_PREP_G2		11
+
+/* reason field values in struct inff_event_msg */
+#define INFF_E_REASON_INITIAL_ASSOC		0
+#define INFF_E_REASON_LOW_RSSI			1
+#define INFF_E_REASON_DEAUTH			2
+#define INFF_E_REASON_DISASSOC			3
+#define INFF_E_REASON_BCNS_LOST		4
+#define INFF_E_REASON_MINTXRATE		9
+#define INFF_E_REASON_TXFAIL			10
+
+#define INFF_E_REASON_LINK_BSSCFG_DIS		4
+#define INFF_E_REASON_FAST_ROAM_FAILED		5
+#define INFF_E_REASON_DIRECTED_ROAM		6
+#define INFF_E_REASON_TSPEC_REJECTED		7
+#define INFF_E_REASON_BETTER_AP		8
+
+#define INFF_E_REASON_TDLS_PEER_DISCOVERED	0
+#define INFF_E_REASON_TDLS_PEER_CONNECTED	1
+#define INFF_E_REASON_TDLS_PEER_DISCONNECTED	2
+
+/* reason field values for PSK_SUP event */
+#define INFF_E_REASON_FWSUP_OTHER		0
+#define INFF_E_REASON_FWSUP_DECRYPT_KEY_DATA	1
+#define INFF_E_REASON_FWSUP_BAD_UCAST_WEP128	2
+#define INFF_E_REASON_FWSUP_BAD_UCAST_WEP40	3
+#define INFF_E_REASON_FWSUP_UNSUP_KEY_LEN	4
+#define INFF_E_REASON_FWSUP_PW_KEY_CIPHER	5
+#define INFF_E_REASON_FWSUP_MSG3_TOO_MANY_IE	6
+#define INFF_E_REASON_FWSUP_MSG3_IE_MISMATCH	7
+#define INFF_E_REASON_FWSUP_NO_INSTALL_FLAG	8
+#define INFF_E_REASON_FWSUP_MSG3_NO_GTK	9
+#define INFF_E_REASON_FWSUP_GRP_KEY_CIPHER	10
+#define INFF_E_REASON_FWSUP_GRP_MSG1_NO_GTK	11
+#define INFF_E_REASON_FWSUP_GTK_DECRYPT_FAIL	12
+#define INFF_E_REASON_FWSUP_SEND_FAIL		13
+#define INFF_E_REASON_FWSUP_DEAUTH		14
+#define INFF_E_REASON_FWSUP_WPA_PSK_TMO	15
+#define INFF_E_REASON_FWSUP_WPA_PSK_M1_TMO	16
+#define INFF_E_REASON_FWSUP_WPA_PSK_M3_TMO	17
+
+/* action field values for inff_ifevent */
+#define INFF_E_IF_ADD				1
+#define INFF_E_IF_DEL				2
+#define INFF_E_IF_CHANGE			3
+
+/* flag field values for inff_ifevent */
+#define INFF_E_IF_FLAG_NOIF			1
+
+/* role field values for inff_ifevent */
+#define INFF_E_IF_ROLE_STA			0
+#define INFF_E_IF_ROLE_AP			1
+#define INFF_E_IF_ROLE_WDS			2
+#define INFF_E_IF_ROLE_P2P_GO			3
+#define INFF_E_IF_ROLE_P2P_CLIENT		4
+#define INFF_E_IF_ROLE_WLAN_SENSE               10
+
+/**
+ * definitions for event packet validation.
+ */
+#define INFILCP_INF_SUBTYPE_EVENT		1
+#define INFILCP_SUBTYPE_VENDOR_LONG		32769
+
+/**
+ * struct inff_ethhdr - Infineon specific ether header.
+ *
+ * @subtype: subtype for this packet.
+ * @length: TODO: length of appended data.
+ * @version: version indication.
+ * @oui: OUI of this packet.
+ * @usr_subtype: subtype for this OUI.
+ */
+struct inff_ethhdr {
+	__be16 subtype;
+	__be16 length;
+	u8 version;
+	u8 oui[3];
+	__be16 usr_subtype;
+} __packed;
+
+struct inff_event_msg_be {
+	__be16 version;
+	__be16 flags;
+	__be32 event_type;
+	__be32 status;
+	__be32 reason;
+	__be32 auth_type;
+	__be32 datalen;
+	u8 addr[ETH_ALEN];
+	char ifname[IFNAMSIZ];
+	u8 ifidx;
+	u8 bsscfgidx;
+} __packed;
+
+/**
+ * struct inff_event - contents of Infineon event packet.
+ *
+ * @eth: standard ether header.
+ * @hdr: Infineon specific ether header.
+ * @msg: common part of the actual event message.
+ */
+struct inff_event {
+	struct ethhdr eth;
+	struct inff_ethhdr hdr;
+	struct inff_event_msg_be msg;
+} __packed;
+
+/**
+ * struct inff_event_msg - firmware event message.
+ *
+ * @version: version information.
+ * @flags: event flags.
+ * @event_code: firmware event code.
+ * @status: status information.
+ * @reason: reason code.
+ * @auth_type: authentication type.
+ * @datalen: length of event data buffer.
+ * @addr: ether address.
+ * @ifname: interface name.
+ * @ifidx: interface index.
+ * @bsscfgidx: bsscfg index.
+ */
+struct inff_event_msg {
+	u16 version;
+	u16 flags;
+	u32 event_code;
+	u32 status;
+	u32 reason;
+	s32 auth_type;
+	u32 datalen;
+	u8 addr[ETH_ALEN];
+	char ifname[IFNAMSIZ];
+	u8 ifidx;
+	u8 bsscfgidx;
+};
+
+struct inff_if_event {
+	u8 ifidx;
+	u8 action;
+	u8 flags;
+	u8 bsscfgidx;
+	u8 role;
+};
+
+enum event_msgs_ext_command {
+	EVENTMSGS_NONE		=	0,
+	EVENTMSGS_SET_BIT	=	1,
+	EVENTMSGS_RESET_BIT	=	2,
+	EVENTMSGS_SET_MASK	=	3
+};
+
+#define EVENTMSGS_VER 1
+#define EVENTMSGS_EXT_STRUCT_SIZE	offsetof(struct eventmsgs_ext, mask[0])
+
+/* len-	for SET it would be mask size from the application to the firmware */
+/*		for GET it would be actual firmware mask size */
+/* maxgetsize -	is only used for GET. indicate max mask size that the */
+/*				application can read from the firmware */
+struct eventmsgs_ext {
+	u8	ver;
+	u8	command;
+	u8	len;
+	u8	maxgetsize;
+	u8	mask[];
+};
+
+typedef int (*inff_fweh_handler_t)(struct inff_if *ifp,
+				    const struct inff_event_msg *evtmsg,
+				    void *data);
+
+/**
+ * struct inff_fweh_info - firmware event handling information.
+ *
+ * @p2pdev_setup_ongoing: P2P device creation in progress.
+ * @wlan_sensedev_setup_ongoing: WLAN Sense device creation in progress.
+ * @event_work: event worker.
+ * @evt_q_lock: lock for event queue protection.
+ * @event_q: event queue.
+ * @evt_handler: registered event handlers.
+ */
+struct inff_fweh_info {
+	bool p2pdev_setup_ongoing;
+	bool wlan_sensedev_setup_ongoing;
+	struct work_struct event_work;
+	spinlock_t evt_q_lock;	/* lock for event queue protection */
+	struct list_head event_q;
+
+	int (*evt_handler[INFF_E_LAST])(struct inff_if *ifp,
+					const struct inff_event_msg *evtmsg,
+					void *data);
+};
+
+const char *inff_fweh_event_name(enum inff_fweh_event_code code);
+
+void inff_fweh_attach(struct inff_pub *drvr);
+void inff_fweh_detach(struct inff_pub *drvr);
+int inff_fweh_register(struct inff_pub *drvr, enum inff_fweh_event_code code,
+		       int (*handler)(struct inff_if *ifp,
+				      const struct inff_event_msg *evtmsg,
+				       void *data));
+void inff_fweh_unregister(struct inff_pub *drvr,
+			  enum inff_fweh_event_code code);
+int inff_fweh_activate_events(struct inff_if *ifp);
+void inff_fweh_process_event(struct inff_pub *drvr,
+			     struct inff_event *event_packet,
+			      u32 packet_len, gfp_t gfp);
+void inff_fweh_process_skb(struct inff_pub *drvr, struct sk_buff *skb, u16 stype,
+			   gfp_t gfp);
+void inff_fweh_p2pdev_setup(struct inff_if *ifp, bool ongoing);
+void inff_fweh_wlan_sensedev_setup(struct inff_if *ifp, bool ongoing);
+
+s32 inff_notify_connect_status(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32
+inff_notify_sched_scan_results(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_roaming_status(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32
+inff_notify_assoc_resp_ie(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_assoc_req_ie(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32
+inff_notify_ext_assoc_frame_rx(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_beacon_loss(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_rssi_change_ind(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_mgmt_tx_status(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_auth_frame_rx(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_ext_auth_request(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_vif_event(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_rssi(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_mic_status(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32 inff_notify_roaming_status(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+s32
+inff_notify_csa_completion_ind(struct inff_if *ifp, const struct inff_event_msg *e, void *data);
+
+void inff_register_event_handlers(struct inff_cfg80211_info *cfg);
+
+#endif /* INFF_FWEH_H */
-- 
2.25.1


