Return-Path: <linux-wireless+bounces-30768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9762D1B3FC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D535302E178
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAA276051;
	Tue, 13 Jan 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="AcIyyQW3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923C2772D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336645; cv=none; b=Zy1jyK+Hd1SsCMkAgaXYrMPnnDactuKT3QMiatkgp97YQ7PEztQ2zurYiJAX37aZ5SL89oehOJzPrE+DRP/BGOwu0SEbTMJH9HOJ7W7I+RN/pojmxKQffWW/ebylfcW2BmhQYbpk7JA+hUj9BX45aA67XA28/JaWvHaA291Yuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336645; c=relaxed/simple;
	bh=X7kYJnlnO3qM8WlvsXLMoAXKKbNMLt6DfbrEZHaOHEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5ZyB3eMCXbtc7IS8QUdWx2lnLBohr+Oudeg1dF4RDD4FL9/BJbMsdteHpqbtAHn+H5bUKUWzJGIZJ3gJa0U8beK+RfzhMbVpqNFpUlAL2o1HRg6vsc1gZ0AfupOl7PxLMxlLb/rg3TsrCAj1j5Y4av0Ypc94E7XaEO2kav1zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=AcIyyQW3; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336642; x=1799872642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7kYJnlnO3qM8WlvsXLMoAXKKbNMLt6DfbrEZHaOHEs=;
  b=AcIyyQW3GLh+E2nvHv4i2DnZsG/QBxILYOQq5XB37IbCB+2UmoigL5kU
   5TyiMtIJVRTUPSCIu/tc0kGSJpjPC7unLXGsVl1Z5icVU0ebN1BbgFEUT
   KlZYbG2KPCHoyfK/H1fu7MFHz5SIjG5AmzVBSkE+m2J8MaZqBdXjX4FRQ
   g=;
X-CSE-ConnectionGUID: ol7UU+wPTz2xdTnSHopWTg==
X-CSE-MsgGUID: cBtQACIUSDWmG4tEyz7aZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78107086"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="78107086"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:37:20 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:37:19 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:37:17 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 13/34] wifi: inffmac: add dev_evt.c/h
Date: Wed, 14 Jan 2026 02:03:26 +0530
Message-ID: <20260113203350.16734-14-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for registering and handling various types of
asynchronous events generated by the CP or the WLAN firmware in the
Device.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/dev_evt.c   | 1841 +++++++++++++++++
 .../net/wireless/infineon/inffmac/dev_evt.h   |  446 ++++
 2 files changed, 2287 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/dev_evt.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dev_evt.h

diff --git a/drivers/net/wireless/infineon/inffmac/dev_evt.c b/drivers/net/wireless/infineon/inffmac/dev_evt.c
new file mode 100644
index 000000000000..3fa1b21f5c0a
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/dev_evt.c
@@ -0,0 +1,1841 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/netdevice.h>
+
+#include "main.h"
+#include "chan.h"
+#include "utils.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "dev_evt.h"
+#include "dev_cmd.h"
+#include "interface.h"
+#include "bus_proto.h"
+#include "pmsr.h"
+#include "twt.h"
+#include "net.h"
+
+/**
+ * struct inff_fwevt_queue_item - event item on event queue.
+ *
+ * @q: list element for queuing.
+ * @code: event code.
+ * @ifidx: interface index related to this event.
+ * @ifaddr: ethernet address for interface.
+ * @emsg: common parameters of the firmware event message.
+ * @datalen: length of the data array
+ * @data: event specific data part of the firmware event.
+ */
+struct inff_fwevt_queue_item {
+	struct list_head q;
+	enum inff_fwevt_code code;
+	u8 ifidx;
+	u8 ifaddr[ETH_ALEN];
+	struct inff_event_msg_be emsg;
+	u32 datalen;
+	u8 data[] __counted_by(datalen);
+};
+
+/*
+ * struct inff_fwevt_code_name - code, name mapping entry.
+ */
+struct inff_fwevt_code_name {
+	enum inff_fwevt_code code;
+	const char *name;
+};
+
+#ifdef DEBUG
+/* array for mapping code to event name */
+static struct inff_fwevt_code_name
+fwevt_names[] = {
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
+	{INFF_E_ACTION_FRAME_TX_COMPLETE, "ACTION_FRAME_TX_COMPLETE"},
+	{INFF_E_PRE_ASSOC_IND, "PRE_ASSOC_IND"},
+	{INFF_E_PRE_REASSOC_IND, "PRE_REASSOC_IND"},
+	{INFF_E_CHANNEL_ADOPTED, "CHANNEL_ADOPTED"},
+	{INFF_E_AP_STARTED, "AP_STARTED"},
+	{INFF_E_DFS_AP_STOP, "DFS_AP_STOP"},
+	{INFF_E_DFS_AP_RESUME, "DFS_AP_RESUME"},
+	{INFF_E_ESCAN_RESULT, "ESCAN_RESULT"},
+	{INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE, "ACTION_FRAME_OFF_CHAN_COMPLETE"},
+	{INFF_E_PROBERESP_MSG, "PROBERESP_MSG"},
+	{INFF_E_PROBEREQ_MSG, "PROBEREQ_MSG"},
+	{INFF_E_DCS_REQUEST, "DCS_REQUEST"},
+	{INFF_E_FIFO_CREDIT_MAP, "FIFO_CREDIT_MAP"},
+	{INFF_E_ACTION_FRAME_RX_COMPLETE, "ACTION_FRAME_RX_COMPLETE"},
+	{INFF_E_SA_COMPLETE_IND, "SA_COMPLETE_IND"},
+	{INFF_E_ASSOC_REQ_IE, "ASSOC_REQ_IE"},
+	{INFF_E_ASSOC_RESP_IE, "ASSOC_RESP_IE"},
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
+};
+
+/**
+ * inff_fwevt_name() - returns name for given event code.
+ *
+ * @code: code to lookup.
+ */
+const char *
+inff_fwevt_name(enum inff_fwevt_code code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fwevt_names); i++) {
+		if (fwevt_names[i].code == code)
+			return fwevt_names[i].name;
+	}
+	return "unknown";
+}
+#else
+const char *
+inff_fwevt_name(enum inff_fwevt_code code)
+{
+	return "nodebug";
+}
+#endif
+
+/**
+ * inff_fwevt_queue_event() - create and queue event.
+ *
+ * @fwevt: firmware event handling info.
+ * @event: event queue entry.
+ */
+static void
+inff_fwevt_queue_event(struct inff_fwevt_info *fwevt,
+		       struct inff_fwevt_queue_item *event)
+{
+	ulong flags;
+
+	spin_lock_irqsave(&fwevt->evt_q_lock, flags);
+	list_add_tail(&event->q, &fwevt->event_q);
+	spin_unlock_irqrestore(&fwevt->evt_q_lock, flags);
+	schedule_work(&fwevt->event_work);
+}
+
+/**
+ * inff_fwevt_dequeue_event() - get event from the queue.
+ *
+ * @fwevt: firmware event handling info.
+ */
+static struct inff_fwevt_queue_item *
+inff_fwevt_dequeue_event(struct inff_fwevt_info *fwevt)
+{
+	struct inff_fwevt_queue_item *event = NULL;
+	ulong flags;
+
+	spin_lock_irqsave(&fwevt->evt_q_lock, flags);
+	if (!list_empty(&fwevt->event_q)) {
+		event = list_first_entry(&fwevt->event_q,
+					 struct inff_fwevt_queue_item, q);
+		list_del(&event->q);
+	}
+	spin_unlock_irqrestore(&fwevt->evt_q_lock, flags);
+
+	return event;
+}
+
+/**
+ * inff_fwevt_event_worker() - firmware event worker.
+ *
+ * @work: worker object.
+ */
+static void
+inff_fwevt_event_worker(struct work_struct *work)
+{
+	struct inff_pub *drvr;
+	struct inff_if *ifp;
+	struct inff_fwevt_info *fwevt;
+	struct inff_fwevt_queue_item *event;
+	struct inff_event_msg_be *emsg_be;
+	struct inff_event_msg emsg;
+
+	fwevt = container_of(work, struct inff_fwevt_info, event_work);
+	drvr = container_of(fwevt, struct inff_pub, fwevt);
+
+	while ((event = inff_fwevt_dequeue_event(fwevt))) {
+		inff_dbg(DEVEVT, "event %s (%u) ifidx %u bsscfg %u addr %pM\n",
+			 inff_fwevt_name(event->code), event->code,
+			 event->emsg.ifidx, event->emsg.bsscfgidx,
+			 event->emsg.addr);
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
+		inff_dbg(DEVEVT, "  version %u flags %u status %u reason %u\n",
+			 emsg.version, emsg.flags, emsg.status, emsg.reason);
+		inff_dbg_hex_dump(INFF_MSGLVL_ON(DEVEVT), event->data,
+				  min_t(u32, emsg.datalen, 64),
+				  "event payload, len=%d\n", emsg.datalen);
+
+		ifp = drvr->iflist[emsg.bsscfgidx];
+		if (!ifp)
+			ifp = inff_get_ifp(drvr, 0);
+
+		/* Call the registered event handler */
+		if (fwevt->evt_handler[event->code]) {
+			if (fwevt->evt_handler[event->code](ifp, &emsg, event->data))
+				iphy_err(drvr, "event handler failed (%d)\n",
+					 event->code);
+		} else {
+			iphy_err(drvr, "unhandled event %d ignored\n", event->code);
+		}
+event_free:
+		kfree(event);
+	}
+}
+
+/**
+ * inff_fwevt_attach() - initialize firmware event handling.
+ *
+ * @drvr: driver information object.
+ */
+void
+inff_fwevt_attach(struct inff_pub *drvr)
+{
+	struct inff_fwevt_info *fwevt = &drvr->fwevt;
+
+	INIT_WORK(&fwevt->event_work, inff_fwevt_event_worker);
+	spin_lock_init(&fwevt->evt_q_lock);
+	INIT_LIST_HEAD(&fwevt->event_q);
+}
+
+/**
+ * inff_fwevt_detach() - cleanup firmware event handling.
+ *
+ * @drvr: driver information object.
+ */
+void
+inff_fwevt_detach(struct inff_pub *drvr)
+{
+	struct inff_fwevt_info *fwevt = &drvr->fwevt;
+
+	/* cancel the worker if initialized */
+	if (fwevt->event_work.func) {
+		cancel_work_sync(&fwevt->event_work);
+		WARN_ON(!list_empty(&fwevt->event_q));
+		memset(fwevt->evt_handler, 0, sizeof(fwevt->evt_handler));
+	}
+}
+
+/**
+ * inff_fwevt_register() - register handler for given event code.
+ *
+ * @drvr: driver information object.
+ * @code: event code.
+ * @handler: handler for the given event code.
+ */
+int
+inff_fwevt_register(struct inff_pub *drvr, enum inff_fwevt_code code,
+		    inff_fwevt_handler_t handler)
+{
+	if (drvr->fwevt.evt_handler[code]) {
+		iphy_err(drvr, "event code %d already registered\n", code);
+		return -ENOSPC;
+	}
+	drvr->fwevt.evt_handler[code] = handler;
+	inff_dbg(TRACE, "event handler registered for %s\n",
+		 inff_fwevt_name(code));
+	return 0;
+}
+
+/**
+ * inff_fwevt_unregister() - remove handler for given code.
+ *
+ * @drvr: driver information object.
+ * @code: event code.
+ */
+void
+inff_fwevt_unregister(struct inff_pub *drvr,
+		      enum inff_fwevt_code code)
+{
+	inff_dbg(TRACE, "event handler cleared for %s\n",
+		 inff_fwevt_name(code));
+	drvr->fwevt.evt_handler[code] = NULL;
+}
+
+/**
+ * inff_fwevt_activate_events() - enables firmware events registered.
+ *
+ * @ifp: primary interface object.
+ */
+int
+inff_fwevt_activate_events(struct inff_if *ifp)
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
+		if (ifp->drvr->fwevt.evt_handler[i]) {
+			inff_dbg(DEVEVT, "enable event %s\n",
+				 inff_fwevt_name(i));
+			setbit(eventmask_msg->mask, i);
+		}
+	}
+
+	/* want to handle IF event as well */
+	inff_dbg(DEVEVT, "enable event IF\n");
+	setbit(eventmask_msg->mask, INFF_E_IF);
+
+	eventmask_msg->ver = EVENTMSGS_VER;
+	eventmask_msg->command = EVENTMSGS_SET_MASK;
+	eventmask_msg->len = INFF_EVENTING_MASK_LEN;
+
+	err = inff_fwcmd_iovar_data_set(ifp, "event_msgs_ext", eventmask_msg,
+					msglen);
+	if (!err)
+		goto end;
+
+	err = inff_fwcmd_iovar_data_set(ifp, "event_msgs", eventmask_msg->mask,
+					INFF_EVENTING_MASK_LEN);
+	if (err)
+		iphy_err(drvr, "Set event_msgs error (%d)\n", err);
+
+end:
+	kfree(eventmask_msg);
+	return err;
+}
+
+/**
+ * inff_fwevt_process_event() - process skb as firmware event.
+ *
+ * @drvr: driver information object.
+ * @event_packet: event packet to process.
+ * @packet_len: length of the packet
+ * @gfp: memory allocation flags.
+ *
+ * If the packet buffer contains a firmware event message it will
+ * dispatch the event to a registered handler (using worker).
+ */
+void
+inff_fwevt_process_event(struct inff_pub *drvr,
+			 struct inff_event *event_packet,
+			 u32 packet_len, gfp_t gfp)
+{
+	enum inff_fwevt_code code;
+	struct inff_fwevt_info *fwevt = &drvr->fwevt;
+	struct inff_fwevt_queue_item *event;
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
+	if (code != INFF_E_IF && !fwevt->evt_handler[code])
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
+	inff_fwevt_queue_event(fwevt, event);
+}
+
+void
+inff_fwevt_process_skb(struct inff_pub *drvr, struct sk_buff *skb, u16 stype,
+		       gfp_t gfp)
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
+	if (memcmp(INF_OUI, &event_packet->hdr.oui[0],
+		   sizeof(event_packet->hdr.oui)))
+		return;
+
+	/* final match on usr_subtype */
+	usr_stype = get_unaligned_be16(&event_packet->hdr.usr_subtype);
+	if (usr_stype != INFILCP_INF_SUBTYPE_EVENT)
+		return;
+
+	inff_fwevt_process_event(drvr, event_packet, skb->len + ETH_HLEN, gfp);
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
+	inff_dbg(CONN, "Event %s (%u), reason %d\n",
+		 inff_fwevt_name(event), event, reason);
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
+static s32
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
+static s32
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
+static s32
+inff_notify_rssi(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
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
+static s32
+inff_notify_vif_event(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_cfg80211_info *cfg = drvr->config;
+	struct inff_if_event *ifevent = (struct inff_if_event *)data;
+	struct inff_cfg80211_vif_event *event = &cfg->vif_event;
+	struct inff_cfg80211_vif *vif;
+	enum nl80211_iftype iftype = NL80211_IFTYPE_UNSPECIFIED;
+	int err = 0;
+
+	inff_dbg(DEVEVT, "%s (%d) action: %u ifidx: %u bsscfgidx: %u flags: %u role: %u\n",
+		 inff_fwevt_name(e->event_code), e->event_code,
+		 ifevent->action, ifevent->ifidx, ifevent->bsscfgidx,
+		 ifevent->flags, ifevent->role);
+
+	if (ifevent->ifidx >= INFF_MAX_IFS) {
+		iphy_err(drvr, "Invalid interface index: %u\n", ifevent->ifidx);
+		return -EINVAL;
+	}
+
+	spin_lock(&event->vif_event_lock);
+	event->action = ifevent->action;
+	vif = event->vif;
+
+	switch (ifevent->action) {
+	case INFF_E_IF_ADD:
+		inff_dbg(DEVEVT, "adding %s (%pM) interface\n", e->ifname,
+			 e->addr);
+
+		switch (ifevent->role) {
+		case INFF_E_IF_ROLE_STA:
+			iftype = NL80211_IFTYPE_STATION;
+			break;
+		case INFF_E_IF_ROLE_AP:
+			iftype = NL80211_IFTYPE_AP;
+			break;
+		case INFF_E_IF_ROLE_P2P_GO:
+			iftype = NL80211_IFTYPE_P2P_GO;
+			break;
+		case INFF_E_IF_ROLE_P2P_CLIENT:
+			iftype = NL80211_IFTYPE_P2P_CLIENT;
+
+			if (ifevent->flags & INFF_E_IF_FLAG_NOIF) {
+				/*
+				 * Treat this P2P Client Role NOIF event as
+				 * P2P Device interface event.
+				 */
+				iftype = NL80211_IFTYPE_P2P_DEVICE;
+			}
+			break;
+		default:
+			iphy_err(drvr, "Invalid interface role: %d\n", ifevent->role);
+			spin_unlock(&event->vif_event_lock);
+			return -EINVAL;
+		}
+
+		ifp = drvr->iflist[ifevent->bsscfgidx];
+		if (ifp) {
+			if (ifevent->bsscfgidx == 0) {
+				inff_dbg(INFO,
+					 "ignore IF ADD event for existing primary interface %s\n",
+					 ifp->ndev->name);
+				spin_unlock(&event->vif_event_lock);
+				return 0;
+			}
+
+			/*
+			 * Remove the corresponding existing interface, to add it again,
+			 * incase if its INFF_E_IF_DEL event was missed earlier.
+			 */
+			iphy_err(drvr,
+				 "netdev:%s already exists, removing to add it again\n",
+				 ifp->ndev->name);
+			inff_net_del_if(drvr, ifp, false);
+		}
+
+		ifp = inff_net_add_if(drvr, ifevent->bsscfgidx, ifevent->ifidx,
+				      e->ifname, e->addr, iftype);
+		if (IS_ERR_OR_NULL(ifp)) {
+			iphy_err(drvr, "interface (role: %d) addition error (%ld)\n",
+				 ifevent->role, PTR_ERR(ifp));
+			spin_unlock(&event->vif_event_lock);
+			return PTR_ERR(ifp);
+		}
+
+		if (!vif) {
+			spin_unlock(&event->vif_event_lock);
+			/* Interface Add event may not be upon user request */
+			vif = inff_alloc_vif(cfg, iftype);
+			if (IS_ERR(vif)) {
+				inff_net_del_if(drvr, ifp, false);
+				return PTR_ERR(vif);
+			}
+		}
+
+		ifp->vif = vif;
+		vif->ifp = ifp;
+
+		if (ifp->ndev) {
+			vif->wdev.netdev = ifp->ndev;
+			ifp->ndev->ieee80211_ptr = &vif->wdev;
+			SET_NETDEV_DEV(ifp->ndev, wiphy_dev(cfg->wiphy));
+		}
+
+		inff_proto_add_if(drvr, ifp);
+
+		spin_unlock(&event->vif_event_lock);
+		if (inff_vif_event_armed(cfg)) {
+			wake_up(&event->vif_wq);
+			break;
+		}
+
+		if (ifp->ndev) {
+			/* Interface Add event may not be upon user request */
+			err = inff_net_attach(ifp, false);
+			if (err) {
+				inff_err("netdevice register failed with err:%d\n",
+					 err);
+				inff_net_del_if(drvr, ifp, false);
+			}
+		}
+
+		break;
+	case INFF_E_IF_DEL:
+		inff_dbg(DEVEVT, "deleting %s (%pM) interface\n", e->ifname,
+			 e->addr);
+
+		spin_unlock(&event->vif_event_lock);
+		if (inff_vif_event_armed(cfg)) {
+			wake_up(&event->vif_wq);
+			break;
+		}
+
+		/* Interface Delete event may not be upon user request */
+		inff_net_del_if(drvr, ifp, false);
+
+		break;
+	case INFF_E_IF_CHANGE:
+		inff_dbg(DEVEVT, "changing %s (%pM) interface\n", e->ifname,
+			 e->addr);
+
+		inff_proto_reset_if(drvr, ifp);
+
+		spin_unlock(&event->vif_event_lock);
+		if (inff_vif_event_armed(cfg))
+			wake_up(&event->vif_wq);
+
+		break;
+	default:
+		err = -EINVAL;
+		spin_unlock(&event->vif_event_lock);
+		break;
+	}
+
+	return err;
+}
+
+static s32
+inff_notify_rx_mgmt_probereq(struct inff_if *ifp,
+			     const struct inff_event_msg *e,
+			     void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	struct inff_chan ch;
+	u8 *mgmt_frame;
+	u32 mgmt_frame_len;
+	s32 freq;
+	u16 mgmt_type;
+
+	inff_dbg(INFO, "Event %d reason %d\n", e->event_code,
+		 e->reason);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		inff_dbg(SCAN, "Event data too small. Ignore\n");
+		return 0;
+	}
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	inff_chan_decchspec(&ch);
+
+	if (inff_p2p_notify_rx_mgmt_p2p_probereq(&cfg->p2p, e, rxframe))
+		return 0;
+
+	/* Check if wpa_supplicant has registered for this frame */
+	inff_dbg(INFO, "vif->mgmt_rx_reg %04x\n", vif->mgmt_rx_reg);
+	mgmt_type = (IEEE80211_STYPE_PROBE_REQ & IEEE80211_FCTL_STYPE) >> 4;
+	if ((vif->mgmt_rx_reg & BIT(mgmt_type)) == 0)
+		return 0;
+
+	mgmt_frame = (u8 *)(rxframe + 1);
+	mgmt_frame_len = e->datalen - sizeof(*rxframe);
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
+					      inff_chan_band_to_nl80211(ch.band));
+
+	cfg80211_rx_mgmt(&vif->wdev, freq, 0, mgmt_frame, mgmt_frame_len, 0);
+
+	inff_dbg(INFO, "mgmt_frame_len (%d) , e->datalen (%d), chanspec (%04x), freq (%d)\n",
+		 mgmt_frame_len, e->datalen, ch.chspec, freq);
+
+	return 0;
+}
+
+/**
+ * inff_notify_action_rx_complete() - received action frame.
+ *
+ * @ifp: interfac control.
+ * @e: event message. Not used, to make it usable for fwevt dispatcher.
+ * @data: payload of message, containing action frame data.
+ *
+ */
+static int
+inff_notify_action_rx_complete(struct inff_if *ifp,
+			       const struct inff_event_msg *e,
+			       void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_cfg80211_info *cfg = drvr->config;
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	struct wireless_dev *wdev = &vif->wdev;
+	u32 mgmt_frame_len = e->datalen - sizeof(struct inff_rx_mgmt_data);
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	u8 *frame = (u8 *)(rxframe + 1);
+	struct inff_chan ch;
+	struct ieee80211_mgmt *mgmt_frame;
+	s32 freq, err;
+	u16 mgmt_type;
+
+	inff_dbg(INFO, "event %s, status=%d\n",
+		 inff_fwevt_name(e->event_code), e->status);
+	inff_print_action_frame(false, frame, mgmt_frame_len);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		inff_dbg(SCAN, "Event data too small. Ignore\n");
+		return 0;
+	}
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	inff_chan_decchspec(&ch);
+	/* Check if wpa_supplicant has registered for this frame */
+	inff_dbg(INFO, "ifp->vif->mgmt_rx_reg %04x\n", ifp->vif->mgmt_rx_reg);
+	mgmt_type = (IEEE80211_STYPE_ACTION & IEEE80211_FCTL_STYPE) >> 4;
+	if ((ifp->vif->mgmt_rx_reg & BIT(mgmt_type)) == 0)
+		return 0;
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_CLIENT:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		inff_p2p_action_rx_complete(p2p, ifp, frame, mgmt_frame_len,
+					    e->addr, ch.chspec);
+		break;
+	default:
+		inff_err("Received action frame tx completion for unsupported iface\n");
+		return -EINVAL;
+	}
+
+	mgmt_frame = kzalloc(offsetof(struct ieee80211_mgmt, u) +
+			     mgmt_frame_len, GFP_KERNEL);
+	if (!mgmt_frame)
+		return -ENOMEM;
+
+	memcpy(mgmt_frame->da, ifp->mac_addr, ETH_ALEN);
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BSSID, mgmt_frame->bssid,
+				      ETH_ALEN);
+	if (err)
+		iphy_err(drvr, "failed to get bssid: %d\n", err);
+
+	memcpy(mgmt_frame->sa, e->addr, ETH_ALEN);
+	mgmt_frame->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
+	memcpy(mgmt_frame->u.body, frame, mgmt_frame_len);
+	mgmt_frame_len += offsetof(struct ieee80211_mgmt, u.body);
+
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
+					      inff_chan_band_to_nl80211(ch.band));
+
+	cfg80211_rx_mgmt(wdev, freq, 0, (u8 *)mgmt_frame, mgmt_frame_len, 0);
+
+	kfree(mgmt_frame);
+	return 0;
+}
+
+/**
+ * inff_notify_action_tx_complete() - transmit action frame complete
+ *
+ * @ifp: interfac control.
+ * @e: event message. Not used, to make it usable for fwevt dispatcher.
+ * @data: not used.
+ *
+ */
+static int
+inff_notify_action_tx_complete(struct inff_if *ifp,
+			       const struct inff_event_msg *e,
+			       void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_vif *vif = ifp->vif;
+
+	inff_dbg(INFO, "event %s, status=%d\n",
+		 inff_fwevt_name(e->event_code), e->status);
+
+	switch (vif->wdev.iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		if (!test_bit(INFF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status))
+			return 0;
+
+		if (e->event_code == INFF_E_ACTION_FRAME_TX_COMPLETE) {
+			if (e->status == INFF_E_STATUS_SUCCESS)
+				set_bit(INFF_MGMT_TX_ACK, &vif->mgmt_tx_status);
+			else
+				set_bit(INFF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
+		} else if (e->event_code == INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE) {
+			set_bit(INFF_MGMT_TX_OFF_CHAN_COMPLETED, &vif->mgmt_tx_status);
+		}
+
+		complete(&vif->mgmt_tx);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_CLIENT:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		inff_p2p_action_tx_complete(&cfg->p2p, ifp, e);
+		break;
+	default:
+		inff_err("Received action frame tx completion for unsupported iface\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static s32
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
+	inff_dbg(INFO, "DEV EVENT: %s (%d) received\n",
+		 inff_fwevt_name(e->event_code), e->event_code);
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
+		params.key_mgmt_suite = WLAN_AKM_SUITE_SAE;
+		params.status = WLAN_STATUS_SUCCESS;
+		params.ssid.ssid_len = min_t(u32, IEEE80211_MAX_SSID_LEN,
+					     le32_to_cpu(auth_req_v2->ssid_len));
+		memcpy(params.ssid.ssid, auth_req_v2->ssid, params.ssid.ssid_len);
+		memcpy(params.bssid, auth_req_v2->peer_mac, ETH_ALEN);
+	} else {
+		if (e->datalen < sizeof(*auth_req)) {
+			iphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+				 inff_fwevt_name(e->event_code), e->event_code);
+			return -EINVAL;
+		}
+
+		memset(&params, 0, sizeof(params));
+		params.action = NL80211_EXTERNAL_AUTH_START;
+		params.key_mgmt_suite = WLAN_AKM_SUITE_SAE;
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
+static s32
+inff_notify_auth_frame_rx(struct inff_if *ifp,
+			  const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct wireless_dev *wdev;
+	u32 mgmt_frame_len = e->datalen - sizeof(struct inff_rx_mgmt_data);
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	u8 *frame = (u8 *)(rxframe + 1);
+	struct inff_chan ch;
+	struct ieee80211_mgmt *mgmt_frame;
+	s32 freq, err;
+
+	inff_dbg(INFO, "Event %s (%d) received\n",
+		 inff_fwevt_name(e->event_code), e->event_code);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		iphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+			 inff_fwevt_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
+	wdev = &ifp->vif->wdev;
+	WARN_ON(!wdev);
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	inff_chan_decchspec(&ch);
+
+	mgmt_frame = kzalloc(mgmt_frame_len, GFP_KERNEL);
+	if (!mgmt_frame)
+		return -ENOMEM;
+
+	mgmt_frame->frame_control = cpu_to_le16(IEEE80211_STYPE_AUTH);
+	memcpy(mgmt_frame->da, ifp->mac_addr, ETH_ALEN);
+	memcpy(mgmt_frame->sa, e->addr, ETH_ALEN);
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BSSID, mgmt_frame->bssid,
+				      ETH_ALEN);
+	if (err)
+		iphy_err(drvr, "failed to get bssid: %d\n", err);
+
+	frame += offsetof(struct ieee80211_mgmt, u);
+	unsafe_memcpy(&mgmt_frame->u, frame,
+		      mgmt_frame_len - offsetof(struct ieee80211_mgmt, u),
+		      /* alloc enough buf*/);
+
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
+					      inff_chan_band_to_nl80211(ch.band));
+
+	cfg80211_rx_mgmt(wdev, freq, 0, (u8 *)mgmt_frame, mgmt_frame_len,
+			 NL80211_RXMGMT_FLAG_EXTERNAL_AUTH);
+	kfree(mgmt_frame);
+	return 0;
+}
+
+static s32
+inff_notify_mgmt_tx_status(struct inff_if *ifp,
+			   const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	u32 *packet_id = (u32 *)data;
+
+	inff_dbg(INFO, "Event %s (%d), status=%d\n",
+		 inff_fwevt_name(e->event_code), e->event_code,
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
+static s32
+inff_notify_rssi_change_ind(struct inff_if *ifp,
+			    const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_rssi_be *value = data;
+	s32 rssi = 0;
+
+	inff_dbg(INFO, "Event %s (%d), status=%d\n",
+		 inff_fwevt_name(e->event_code), e->event_code,
+		 e->status);
+
+	if (!cfg->cqm_info.enable)
+		return 0;
+
+	rssi = be32_to_cpu(value->rssi);
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
+static s32
+inff_notify_beacon_loss(struct inff_if *ifp,
+			const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct cfg80211_bss *bss;
+	struct net_device *ndev = ifp->ndev;
+
+	inff_dbg(INFO, "Event %s (%d), status=%d\n",
+		 inff_fwevt_name(e->event_code), e->event_code,
+		 e->status);
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
+		bss = cfg80211_get_bss(cfg->wiphy, NULL, profile->bssid, NULL, 0,
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
+		memset(&ifp->vif->profile, 0, sizeof(ifp->vif->profile));
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
+static s32
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
+	inff_dbg(INFO, "Event %s (%d) received\n",
+		 inff_fwevt_name(e->event_code), e->event_code);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		iphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+			 inff_fwevt_name(e->event_code), e->event_code);
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
+static s32
+inff_notify_assoc_req_ie(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+	u32 event = e->event_code;
+	u32 status = e->status;
+	u32 req_len = e->datalen;
+
+	inff_dbg(INFO, "Event %s (%d), status=%d\n",
+		 inff_fwevt_name(e->event_code), e->event_code,
+		 e->status);
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
+static s32
+inff_notify_assoc_resp_ie(struct inff_if *ifp,
+			  const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+	struct inff_cfg80211_edcf_acparam edcf_acparam_info[EDCF_AC_COUNT];
+	u32 event = e->event_code;
+	u32 status = e->status;
+	u32 resp_len = e->datalen;
+	s32 err = 0;
+
+	inff_dbg(INFO, "Event %s (%d), status=%d\n",
+		 inff_fwevt_name(e->event_code), e->event_code,
+		 e->status);
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
+			err = inff_fwcmd_iovar_data_get(ifp, "wme_ac_sta",
+							edcf_acparam_info,
+							sizeof(edcf_acparam_info));
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
+static u16
+inff_map_fw_linkdown_reason(const struct inff_event_msg *e)
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
+static s32
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
+	if (inff_vif_is_apmode(ifp->vif)) {
+		if (e->event_code == INFF_E_ASSOC_IND ||
+		    e->event_code == INFF_E_REASSOC_IND) {
+			inff_findadd_sta(ifp, e->addr);
+		} else if ((e->event_code == INFF_E_DISASSOC_IND) ||
+				(e->event_code == INFF_E_DEAUTH_IND) ||
+				(e->event_code == INFF_E_DEAUTH)) {
+			inff_del_sta(ifp, e->addr);
+		}
+		err = inff_notify_connect_status_ap(cfg, ndev, e, data);
+		inff_chan_set_mchan_config(cfg);
+	} else if (inff_vif_is_linkup(ifp->vif, e)) {
+		inff_dbg(CONN, "Linkup\n");
+		if (inff_vif_is_ibssmode(ifp->vif)) {
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
+		inff_chan_set_mchan_config(cfg);
+	} else if (inff_vif_is_linkdown(ifp->vif, e)) {
+		inff_dbg(CONN, "Linkdown\n");
+		if (!inff_vif_is_ibssmode(ifp->vif) &&
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
+			memset(&ifp->vif->profile, 0,
+			       sizeof(ifp->vif->profile));
+			if (ndev != cfg_to_ndev(cfg))
+				complete(&cfg->vif_disabled);
+			inff_net_setcarrier(ifp, false);
+		}
+		inff_proto_cleanup_if(ifp->drvr, ifp);
+	} else if (inff_vif_is_nonetwork(cfg, e)) {
+		if (inff_vif_is_ibssmode(ifp->vif))
+			clear_bit(INFF_VIF_STATUS_CONNECTING,
+				  &ifp->vif->sme_state);
+		else
+			inff_bss_connect_done(cfg, ndev, e, false);
+	}
+
+	return err;
+}
+
+static s32
+inff_notify_csa_completion_ind(struct inff_if *ifp,
+			       const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg;
+	struct net_device *ndev;
+	struct wiphy *wiphy;
+	struct cfg80211_chan_def chandef;
+	struct wireless_dev *wdev;
+	int error = 0;
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
+
+	if (!cfg)
+		return -EINVAL;
+
+	wiphy = cfg->wiphy;
+
+	if (!ndev || !wiphy)
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
+void inff_fwevt_register_handlers(struct inff_cfg80211_info *cfg)
+{
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct inff_rssi_new_event_le rssi_event = {};
+	int err = 0;
+
+	/* get supported version from firmware side */
+	err = inff_fwcmd_iovar_data_get(ifp, "rssi_event", &rssi_event,
+					sizeof(rssi_event));
+	if (err)
+		inff_err("fail to get supported rssi_event version, err=%d\n", err);
+
+	inff_fwevt_register(cfg->pub, INFF_E_LINK,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_DEAUTH_IND,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_DEAUTH,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_DISASSOC_IND,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_ASSOC_IND,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_REASSOC_IND,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_ROAM,
+			    inff_notify_roaming_status);
+	inff_fwevt_register(cfg->pub, INFF_E_MIC_ERROR,
+			    inff_notify_mic_status);
+	inff_fwevt_register(cfg->pub, INFF_E_SET_SSID,
+			    inff_notify_connect_status);
+	inff_fwevt_register(cfg->pub, INFF_E_SA_COMPLETE_IND,
+			    inff_notify_csa_completion_ind);
+	inff_fwevt_register(cfg->pub, INFF_E_IF,
+			    inff_notify_vif_event);
+	inff_fwevt_register(cfg->pub, INFF_E_PROBEREQ_MSG,
+			    inff_notify_rx_mgmt_probereq);
+	inff_fwevt_register(cfg->pub, INFF_E_P2P_DISC_LISTEN_COMPLETE,
+			    inff_p2p_notify_listen_complete);
+	inff_fwevt_register(cfg->pub, INFF_E_ACTION_FRAME_RX_COMPLETE,
+			    inff_notify_action_rx_complete);
+	inff_fwevt_register(cfg->pub, INFF_E_ACTION_FRAME_TX_COMPLETE,
+			    inff_notify_action_tx_complete);
+	inff_fwevt_register(cfg->pub, INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE,
+			    inff_notify_action_tx_complete);
+	inff_fwevt_register(cfg->pub, INFF_E_PSK_SUP,
+			    inff_notify_connect_status);
+	if (rssi_event.version == WL_RSSI_EVENT_VERSION_NEW)
+		inff_fwevt_register(cfg->pub, INFF_E_RSSI,
+				    inff_notify_rssi_change_ind);
+	else if (rssi_event.version == WL_RSSI_EVENT_VERSION_OLD)
+		inff_fwevt_register(cfg->pub, INFF_E_RSSI,
+				    inff_notify_rssi);
+	inff_fwevt_register(cfg->pub, INFF_E_EXT_AUTH_REQ,
+			    inff_notify_ext_auth_request);
+	inff_fwevt_register(cfg->pub, INFF_E_EXT_AUTH_FRAME_RX,
+			    inff_notify_auth_frame_rx);
+	inff_fwevt_register(cfg->pub, INFF_E_MGMT_FRAME_TXSTATUS,
+			    inff_notify_mgmt_tx_status);
+	inff_fwevt_register(cfg->pub, INFF_E_MGMT_FRAME_OFF_CHAN_COMPLETE,
+			    inff_notify_mgmt_tx_status);
+	inff_fwevt_register(cfg->pub, INFF_E_BCNLOST_MSG,
+			    inff_notify_beacon_loss);
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_TWT)) {
+		inff_fwevt_register(cfg->pub, INFF_E_TWT_SETUP,
+				    inff_notify_twt_event);
+		inff_fwevt_register(cfg->pub, INFF_E_TWT_TEARDOWN,
+				    inff_notify_twt_event);
+	}
+	inff_fwevt_register(cfg->pub, INFF_E_EXT_ASSOC_FRAME_RX,
+			    inff_notify_ext_assoc_frame_rx);
+	inff_fwevt_register(cfg->pub, INFF_E_ASSOC_REQ_IE,
+			    inff_notify_assoc_req_ie);
+	inff_fwevt_register(cfg->pub, INFF_E_ASSOC_RESP_IE,
+			    inff_notify_assoc_resp_ie);
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FTM))
+		inff_fwevt_register(cfg->pub, INFF_E_PROXD,
+				    inff_notify_ftm_evt);
+}
+
+/*
+ * inff_cpevt_dequeue_event() - get event from the queue.
+ *
+ * @evi: event handling info.
+ * @event_q: event queue.
+ */
+static struct inff_cpevt_queue_item *
+inff_cpevt_dequeue_event(struct inff_cpevt_info *evi, struct list_head *event_q)
+{
+	struct inff_cpevt_queue_item *event = NULL;
+	ulong flags;
+
+	spin_lock_irqsave(&evi->lock, flags);
+	if (!list_empty(event_q)) {
+		event = list_first_entry(event_q,
+					 struct inff_cpevt_queue_item, list);
+		list_del(&event->list);
+	}
+	spin_unlock_irqrestore(&evi->lock, flags);
+
+	return event;
+}
+
+/*
+ * inff_cpevt_queue_event() - queue event.
+ * @evi: event handling info.
+ * @event: event item.
+ * @event_q: event queue.
+ */
+static void
+inff_cpevt_queue_event(struct inff_cpevt_info *evi,
+		       struct inff_cpevt_queue_item *event,
+		       struct list_head *event_q)
+{
+	ulong flags;
+
+	spin_lock_irqsave(&evi->lock, flags);
+	list_add_tail(&event->list, event_q);
+	spin_unlock_irqrestore(&evi->lock, flags);
+}
+
+static int
+inff_cpevt_alloc_buf(struct inff_cpevt_info *evi)
+{
+	struct inff_cpevt_queue_item *event_item;
+	u8 i;
+
+	INIT_LIST_HEAD(&evi->idle_q);
+	INIT_LIST_HEAD(&evi->wait_q);
+	INIT_LIST_HEAD(&evi->event_q);
+	INIT_LIST_HEAD(&evi->monitor_q);
+	spin_lock_init(&evi->lock);
+
+	for (i = 0; i < EVENT_MAX_RX_BUF; i++) {
+		event_item = kzalloc(sizeof(*event_item), GFP_KERNEL);
+		if (!event_item)
+			return -ENODATA;
+
+		INIT_LIST_HEAD(&event_item->list);
+		memset(&event_item->event, 0, sizeof(event_item->event));
+
+		spin_lock(&evi->lock);
+		list_add_tail(&event_item->list, &evi->idle_q);
+		spin_unlock(&evi->lock);
+	}
+
+	return 0;
+}
+
+static void
+inff_cpevt_free_buf(struct list_head *q, const char name[])
+{
+	struct inff_cpevt_queue_item *event_item;
+	struct inff_cpevt_queue_item *next = NULL;
+	u32 count = 0;
+
+	list_for_each_entry_safe(event_item, next, q, list) {
+		list_del(&event_item->list);
+		kfree(event_item);
+		count++;
+	}
+	inff_dbg(INFO, "%s Q: free pkt count %d\n", name, count);
+}
+
+static void
+inff_cp_set_link_state(struct inff_if *ifp, bool link)
+{
+	inff_net_setcarrier(ifp, link);
+	ifp->connected = link;
+}
+
+/*
+ * inff_notify_cpevent_nw() - handle network event.
+ *
+ * @drvr: driver information object.
+ * @event: Infineon event.
+ */
+static int
+inff_notify_cpevt_nw(struct inff_pub *drvr,
+		     struct inff_cpevt *event)
+{
+	struct inff_cpevt_nw *nw_ev = NULL;
+	struct inff_if *ifp = drvr->iflist[0];
+	int ret = 0;
+
+	if (event->version != INFF_CP_NW_EVENT_VER) {
+		inff_err("version (%d) != %d\n", event->version, INFF_CP_NW_EVENT_VER);
+		return -ENODATA;
+	}
+
+	if (event->len != sizeof(*nw_ev)) {
+		inff_err("len %d != nw_event %ld\n", event->len, sizeof(*nw_ev));
+		return -ENODATA;
+	}
+
+	nw_ev = (struct inff_cpevt_nw *)event->data;
+
+	switch (nw_ev->type) {
+	case INFF_CP_NW_EVENT_CONNECTED:
+		inff_dbg(DEVEVT, "CP NW_EVENT_CONNECTED\n");
+		inff_cp_cfg80211_link_up(ifp, nw_ev->u.mac);
+		inff_cp_set_link_state(ifp, true);
+		break;
+	case INFF_CP_NW_EVENT_CONNECT_FAILED:
+		inff_dbg(DEVEVT, "CP NW_EVENT_CONNECT_FAILED isn't handled\n");
+		break;
+	case INFF_CP_NW_EVENT_RECONNECTED:
+		inff_dbg(DEVEVT, "CP NW_EVENT_RECONNECTED isn't handled\n");
+		break;
+	case INFF_CP_NW_EVENT_DISCONNECTED:
+		inff_dbg(DEVEVT, "CP NW_EVENT_DISCONNECTED: reason %d\n", nw_ev->u.reason);
+		inff_cp_cfg80211_link_down(ifp);
+		inff_cp_set_link_state(ifp, false);
+		break;
+	case INFF_CP_NW_EVENT_IP_CHANGED:
+		inff_dbg(DEVEVT, "CP NW_EVENT_IP_CHANGED: ip %d.%d.%d.%d\n",
+			 ((nw_ev->u.ipv4 >> 0) & 0xFF),
+			 ((nw_ev->u.ipv4 >> 8) & 0xFF),
+			 ((nw_ev->u.ipv4 >> 16) & 0xFF),
+			 ((nw_ev->u.ipv4 >> 24) & 0xFF));
+		inff_cp_set_link_state(ifp, nw_ev->u.ipv4 ? true : false);
+		break;
+	default:
+		inff_err("unsupported wcm event: %d\n", nw_ev->type);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+inff_notify_cpevt_scan(struct inff_pub *drvr, struct inff_cpevt *event)
+{
+	struct inff_cpevt_scan *scan_ev = NULL;
+
+	if (event->version != INFF_CP_SCAN_EVENT_VER) {
+		inff_err("version (%d) != %d\n", event->version, INFF_CP_SCAN_EVENT_VER);
+		return -ENODATA;
+	}
+
+	if (event->len != sizeof(*scan_ev)) {
+		inff_err("len %d != scan_event %ld\n", event->len, sizeof(*scan_ev));
+		return -ENODATA;
+	}
+
+	scan_ev = (struct inff_cpevt_scan *)event->data;
+	return inff_cp_scan_event_handler(&drvr->config->scan, scan_ev);
+}
+
+static int
+inff_cpevt_handler(struct inff_pub *drvr, struct inff_cpevt *e)
+{
+	int ret = 0;
+
+	switch (e->type) {
+	case INFF_CP_E_NW:
+		ret = inff_notify_cpevt_nw(drvr, e);
+		break;
+	case INFF_CP_E_SCAN:
+		ret = inff_notify_cpevt_scan(drvr, e);
+		break;
+	default:
+		inff_err("unsupported event: %d\n", e->type);
+		/* driver bypass this event, keep forward to user */
+		break;
+	}
+
+	if (ret)
+		inff_err("handle event code (%d) failed\n", e->type);
+	return ret;
+}
+
+/*
+ * inff_cpevt_worker() - event worker.
+ *
+ * @work: worker object.
+ */
+static void
+inff_cpevt_worker(struct work_struct *work)
+{
+	struct inff_pub *drvr;
+	struct inff_cpevt_info *evi;
+	struct inff_cpevt_queue_item *event_item = NULL;
+
+	evi = container_of(work, struct inff_cpevt_info, event_work);
+	drvr = container_of(evi, struct inff_pub, evi);
+
+	while ((event_item = inff_cpevt_dequeue_event(evi, &evi->wait_q))) {
+		inff_cpevt_handler(drvr, &event_item->event);
+		inff_cpevt_queue_event(evi, event_item, &evi->idle_q);
+	}
+}
+
+/*
+ * inff_cpevt_attach() - initialize event handling.
+ * @drvr: driver information object.
+ */
+int
+inff_cpevt_attach(struct inff_pub *drvr)
+{
+	struct inff_cpevt_info *evi = &drvr->evi;
+
+	if (inff_cpevt_alloc_buf(evi)) {
+		inff_err("Failed to alloc event buffer\n");
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&evi->event_work, inff_cpevt_worker);
+
+	return 0;
+}
+
+/*
+ * inff_cpevt_detach() - cleanup event handling.
+ * @drvr: driver information object.
+ */
+void
+inff_cpevt_detach(struct inff_pub *drvr)
+{
+	struct inff_cpevt_info *evi = &drvr->evi;
+
+	/* cancel the worker if initialized */
+	if (evi->event_work.func)
+		cancel_work_sync(&evi->event_work);
+
+	spin_lock(&evi->lock);
+
+	inff_cpevt_free_buf(&evi->idle_q, "idle");
+	inff_cpevt_free_buf(&evi->wait_q, "wait");
+	inff_cpevt_free_buf(&evi->event_q, "event");
+	inff_cpevt_free_buf(&evi->monitor_q, "monitor");
+
+	spin_unlock(&evi->lock);
+}
+
+/*
+ * inff_cpevt_process_skb() - process skb as event.
+ * @drvr: driver information object.
+ * @pkt: event packet to process.
+ * @inirq: in irq.
+ * Dispatch the event packet to worker.
+ */
+void
+inff_cpevt_process_skb(struct inff_pub *drvr, struct sk_buff *pkt)
+{
+	struct inff_cpevt_info *evi = &drvr->evi;
+	struct inff_cpevt_queue_item *event_item;
+
+	if (pkt->len > sizeof(struct inff_cpevt)) {
+		inff_err("event len (%d) > %ld\n", pkt->len, sizeof(struct inff_cpevt));
+		return;
+	}
+
+	event_item = inff_cpevt_dequeue_event(evi, &evi->idle_q);
+	if (!event_item) {
+		inff_err("no buffer in idle q\n");
+		return;
+	}
+
+	memset(&event_item->event, 0, sizeof(event_item->event));
+	memcpy(&event_item->event, pkt->data, pkt->len);
+
+	inff_dbg_hex_dump(INFF_MSGLVL_ON(DEVEVT), pkt->data,
+			  min_t(u32, pkt->len, 64),
+			  "event payload, len=%d\n", pkt->len);
+
+	inff_cpevt_queue_event(evi, event_item, &evi->wait_q);
+
+	schedule_work(&evi->event_work);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/dev_evt.h b/drivers/net/wireless/infineon/inffmac/dev_evt.h
new file mode 100644
index 000000000000..d4d2e05d89fa
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/dev_evt.h
@@ -0,0 +1,446 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_DEV_EVT_H
+#define INFF_DEV_EVT_H
+
+#include <linux/unaligned.h>
+#include <linux/skbuff.h>
+#include <linux/if_ether.h>
+#include <linux/if.h>
+
+#define INF_OUI		"\x00\x03\x19"
+
+/* formward declarations */
+struct inff_pub;
+struct inff_if;
+struct inff_cfg80211_info;
+
+/* list of firmware events */
+/* firmware event codes sent by the dongle */
+enum inff_fwevt_code {
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
+	INFF_E_ACTION_FRAME_TX_COMPLETE = 60,
+	INFF_E_PRE_ASSOC_IND = 61,
+	INFF_E_PRE_REASSOC_IND = 62,
+	INFF_E_CHANNEL_ADOPTED = 63,
+	INFF_E_AP_STARTED = 64,
+	INFF_E_DFS_AP_STOP = 65,
+	INFF_E_DFS_AP_RESUME = 66,
+	INFF_E_ESCAN_RESULT = 69,
+	INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE = 70,
+	INFF_E_PROBERESP_MSG = 71,
+	INFF_E_PROBEREQ_MSG = 72,
+	INFF_E_DCS_REQUEST = 73,
+	INFF_E_FIFO_CREDIT_MAP = 74,
+	INFF_E_ACTION_FRAME_RX_COMPLETE = 75,
+	INFF_E_SA_COMPLETE_IND = 80,
+	INFF_E_ASSOC_REQ_IE = 87,
+	INFF_E_ASSOC_RESP_IE = 88,
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
+	/* this determines event mask length which must match
+	 * minimum length check in device firmware so it is
+	 * hard-coded here.
+	 */
+	INFF_E_LAST = 203
+};
+
+/* list of CP events */
+/* CP event codes sent by the dongle */
+enum inff_cpevt_code {
+	INFF_CP_E_NW = 0,
+	INFF_CP_E_SCAN = 1
+};
+
+enum {
+	INFF_CP_NW_EVENT_CONNECTED		= 0,	/* STA connected to the AP.         */
+	INFF_CP_NW_EVENT_CONNECT_FAILED		= 1,	/* STA connection to the AP failed. */
+	INFF_CP_NW_EVENT_RECONNECTED		= 2,	/* STA reconnected to the AP.       */
+	INFF_CP_NW_EVENT_DISCONNECTED		= 3,	/* STA disconnected from the AP.    */
+	INFF_CP_NW_EVENT_IP_CHANGED		= 4,	/* IP address change event.         */
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
+#define EVENT_MAX_DATA_LEN 1024
+#define EVENT_MAX_RX_BUF 10
+
+struct inff_cpevt {
+	u16 type;
+	u16 len;
+	u8 version;
+	u8 data[EVENT_MAX_DATA_LEN];
+};
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
+typedef int (*inff_fwevt_handler_t)(struct inff_if *ifp,
+				    const struct inff_event_msg *evtmsg,
+				    void *data);
+
+/**
+ * struct inff_fwevt_info - firmware event handling information.
+ *
+ * @event_work: event worker.
+ * @evt_q_lock: lock for event queue protection.
+ * @event_q: event queue.
+ * @evt_handler: registered event handlers.
+ */
+struct inff_fwevt_info {
+	struct work_struct event_work;
+	spinlock_t evt_q_lock;	/* lock for event queue protection */
+	struct list_head event_q;
+
+	int (*evt_handler[INFF_E_LAST])(struct inff_if *ifp,
+					const struct inff_event_msg *evtmsg,
+					void *data);
+};
+
+/*
+ * struct inff_cpevt_queue_item - event item on event queue.
+ *
+ * @list: list element for queuing.
+ * @event: event specific data part of the event.
+ */
+struct inff_cpevt_queue_item {
+	struct list_head list;
+	struct inff_cpevt event;
+};
+
+/*
+ * struct inff_cpevt_info - event handling information.
+ *
+ * @event_work: event worker.
+ * @event_q_lock: lock for event queue protection.
+ * @event_q: event queue.
+ */
+struct inff_cpevt_info {
+	struct work_struct event_work;
+	/* lock for event queue protection */
+	spinlock_t lock;
+	struct list_head idle_q;
+	struct list_head wait_q;
+	struct list_head event_q;
+	struct list_head monitor_q;
+};
+
+#define INFF_CP_NW_EVENT_VER 2
+
+/*
+ * struct inff_cpevt_new - contents of CP network event.
+ */
+struct inff_cpevt_nw {
+	u8 type;
+	union {
+		u8 mac[ETH_ALEN];
+		u32 ipv4;   /**< IPv4 address in network byte order. */
+		u32 reason;
+	} u;
+	u32 ipv6[4];
+} __packed;
+
+/* Scan Event */
+
+#define INFF_CP_SCAN_EVENT_VER		2
+#define INFF_CP_SCAN_IE_LEN_MAX		896
+
+/*
+ * struct inff_cpevt_scan - contents of CP scan event.
+ */
+struct inff_cpevt_scan {
+	u8     ssid_length;	/* SSID length */
+	char   ssid[IEEE80211_MAX_SSID_LEN + 1]; /* SSID of the access point */
+	u32    security_type;	/* WiFi security type */
+	u8     macaddr[ETH_ALEN];	/* MAC Address of the access point */
+	s16    signal_strength;	/* signal strength */
+	u8     channel;	/* channel number */
+	u8     band;	/* WiFi band of access point */
+	bool   scan_complete;	/* WiFi scan complete/incomplete */
+	u16    beacon_period;	/* Interval between two consecutive beacon frames. Unit: Kusec */
+	u16    capability;	/* Capability information */
+	u32    ie_len;	/* Length of the IE. */
+
+	/* Pointer to the received Beacon/Probe Response IE (Information Element). */
+	u8     ie[INFF_CP_SCAN_IE_LEN_MAX];
+} __packed;
+
+const char *inff_fwevt_name(enum inff_fwevt_code code);
+
+void inff_fwevt_attach(struct inff_pub *drvr);
+void inff_fwevt_detach(struct inff_pub *drvr);
+int inff_fwevt_register(struct inff_pub *drvr, enum inff_fwevt_code code,
+			int (*handler)(struct inff_if *ifp,
+				       const struct inff_event_msg *evtmsg,
+				       void *data));
+void inff_fwevt_unregister(struct inff_pub *drvr,
+			   enum inff_fwevt_code code);
+int inff_fwevt_activate_events(struct inff_if *ifp);
+void inff_fwevt_process_event(struct inff_pub *drvr,
+			      struct inff_event *event_packet,
+			      u32 packet_len, gfp_t gfp);
+void inff_fwevt_process_skb(struct inff_pub *drvr, struct sk_buff *skb, u16 stype,
+			    gfp_t gfp);
+void inff_fwevt_register_handlers(struct inff_cfg80211_info *cfg);
+
+int inff_cpevt_attach(struct inff_pub *drvr);
+void inff_cpevt_detach(struct inff_pub *drvr);
+void inff_cpevt_process_skb(struct inff_pub *drvr, struct sk_buff *pkt);
+
+#endif /* INFF_DEV_EVT_H */
-- 
2.25.1


