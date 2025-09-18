Return-Path: <linux-wireless+bounces-27406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF6B7F3D1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932C37B8480
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D02F83AC;
	Tue, 16 Sep 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Hu6/4dcT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C62F3C2B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061817; cv=none; b=a7YjpWSBOWb/r1ppU8hBj/qhHHdNHv6MYWqbG93Vfi0U6B83kD3jRoWiqponWANYc0iEhpz7RXdDHYKC7exvIkwv8WpJq7D4yu+keMbJnYMSiQocB/+rfNUbnwn6E2jEdBOab6Ad8ebZIO8rSVaxPpu/mG1xILyU/7ReeeLiJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061817; c=relaxed/simple;
	bh=Mftk8u7p0AcZI7Bvvcbvgp3hBXJ3/LbhzIbeCzMNFp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nx1xW4Y18UN7clKnivxPHQlLuqnnaJtGO5EaiGLVTAjUQNutJuEd94Wgiz9PL1AD6DA9Ar+EIqqqbrAPC/xG64mIhOz9EKN5nLxwnAcrI6uuGOhQzBPHrpTtvZsTlhOhTt3Oq+PUGkQiAcZn0H8SVus4ExtSJGkHY8n477hI1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Hu6/4dcT; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061814; x=1789597814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mftk8u7p0AcZI7Bvvcbvgp3hBXJ3/LbhzIbeCzMNFp4=;
  b=Hu6/4dcTsEH19DnBDZx7T83qMPgAF8aQlPGWW7h+v+UWkkpntCGkHZi/
   VcWy0cLCs37jbqsqs2dSyi/yEafBoe7/N1S0Pd0XtY0PYOVwDMdYZgaLQ
   Ep0LCAl010rBNM0G6fOLh4cbXkpaMcddGdSMM/GQCp/pFg2MWHv8VNR4t
   I=;
X-CSE-ConnectionGUID: J988BsnrTN69zQ8xOExYNQ==
X-CSE-MsgGUID: c1FD3E1fQ4KLaEzORthlsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918841"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918841"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:30:11 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:30:09 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:30:06 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 51/57] wifi: inffmac: add p2p.c/h
Date: Wed, 17 Sep 2025 03:48:11 +0530
Message-ID: <20250916221821.4387-57-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the Wi-Fi Direct (Peer-to-Peer) Mode of connection
with a Peer device.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/p2p.c | 2605 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/p2p.h |  186 ++
 2 files changed, 2791 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/p2p.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/p2p.h

diff --git a/drivers/net/wireless/infineon/inffmac/p2p.c b/drivers/net/wireless/infineon/inffmac/p2p.c
new file mode 100644
index 000000000000..da27bc89bb6f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/p2p.c
@@ -0,0 +1,2605 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/rtnetlink.h>
+#include <net/cfg80211.h>
+
+#include "chanspec.h"
+#include "utils.h"
+#include "defs.h"
+#include "core.h"
+#include "debug.h"
+#include "fwil.h"
+#include "fwil_types.h"
+#include "p2p.h"
+#include "cfg80211.h"
+#include "feature.h"
+#include "security.h"
+
+/* parameters used for p2p escan */
+#define P2PAPI_SCAN_NPROBES 1
+#define P2PAPI_SCAN_DWELL_TIME_MS 80
+#define P2PAPI_SCAN_SOCIAL_DWELL_TIME_MS 40
+#define P2PAPI_SCAN_HOME_TIME_MS 60
+#define P2PAPI_SCAN_NPROBS_TIME_MS 30
+#define P2PAPI_SCAN_AF_SEARCH_DWELL_TIME_MS 100
+#define WL_SCAN_CONNECT_DWELL_TIME_MS 200
+#define WL_SCAN_JOIN_PROBE_INTERVAL_MS 20
+
+#define INFF_P2P_WILDCARD_SSID		"DIRECT-"
+#define INFF_P2P_WILDCARD_SSID_LEN	(sizeof(INFF_P2P_WILDCARD_SSID) - 1)
+
+#define SOCIAL_CHAN_1		1
+#define SOCIAL_CHAN_2		6
+#define SOCIAL_CHAN_3		11
+#define IS_P2P_SOCIAL_CHANNEL(channel) ({ \
+	typeof(channel) __channel = (channel); \
+	(__channel == SOCIAL_CHAN_1) || \
+	(__channel == SOCIAL_CHAN_2) || \
+	(__channel == SOCIAL_CHAN_3); \
+})
+
+#define INFF_P2P_TEMP_CHAN	SOCIAL_CHAN_3
+#define SOCIAL_CHAN_CNT		3
+#define AF_PEER_SEARCH_CNT	2
+
+#define INFF_SCB_TIMEOUT_VALUE	20
+
+#define P2P_VER			9	/* P2P version: 9=WiFi P2P v1.0 */
+#define P2P_PUB_AF_CATEGORY	0x04
+#define P2P_PUB_AF_ACTION	0x09
+#define P2P_AF_CATEGORY		0x7f
+#define P2P_OUI			"\x50\x6F\x9A"	/* P2P OUI */
+#define P2P_OUI_LEN		3		/* P2P OUI length */
+
+/* Action Frame Constants */
+#define DOT11_ACTION_HDR_LEN	2	/* action frame category + action */
+#define DOT11_ACTION_CAT_OFF	0	/* category offset */
+#define DOT11_ACTION_ACT_OFF	1	/* action offset */
+
+#define P2P_AF_DWELL_TIME		200
+#define P2P_AF_MIN_DWELL_TIME		100
+#define P2P_AF_MED_DWELL_TIME		400
+#define P2P_AF_LONG_DWELL_TIME		1000
+#define P2P_AF_TX_MAX_RETRY		5
+#define P2P_AF_MAX_WAIT_TIME		msecs_to_jiffies(2000)
+#define P2P_INVALID_CHANNEL		-1
+#define P2P_INVALID_CHANSPEC		0
+#define P2P_CHANNEL_SYNC_RETRY		5
+#define P2P_AF_FRM_SCAN_MAX_WAIT	msecs_to_jiffies(450)
+#define P2P_DEFAULT_SLEEP_TIME_VSDB	200
+#define P2P_AF_RETRY_DELAY_TIME		40
+
+/* WiFi P2P Public Action Frame OUI Subtypes */
+#define P2P_PAF_GON_REQ		0	/* Group Owner Negotiation Req */
+#define P2P_PAF_GON_RSP		1	/* Group Owner Negotiation Rsp */
+#define P2P_PAF_GON_CONF	2	/* Group Owner Negotiation Confirm */
+#define P2P_PAF_INVITE_REQ	3	/* P2P Invitation Request */
+#define P2P_PAF_INVITE_RSP	4	/* P2P Invitation Response */
+#define P2P_PAF_DEVDIS_REQ	5	/* Device Discoverability Request */
+#define P2P_PAF_DEVDIS_RSP	6	/* Device Discoverability Response */
+#define P2P_PAF_PROVDIS_REQ	7	/* Provision Discovery Request */
+#define P2P_PAF_PROVDIS_RSP	8	/* Provision Discovery Response */
+#define P2P_PAF_SUBTYPE_INVALID	255	/* Invalid Subtype */
+
+/* WiFi P2P Action Frame OUI Subtypes */
+#define P2P_AF_NOTICE_OF_ABSENCE	0	/* Notice of Absence */
+#define P2P_AF_PRESENCE_REQ		1	/* P2P Presence Request */
+#define P2P_AF_PRESENCE_RSP		2	/* P2P Presence Response */
+#define P2P_AF_GO_DISC_REQ		3	/* GO Discoverability Request */
+
+/* P2P Service Discovery related */
+#define P2PSD_ACTION_CATEGORY		0x04	/* Public action frame */
+#define P2PSD_ACTION_ID_GAS_IREQ	0x0a	/* GAS Initial Request AF */
+#define P2PSD_ACTION_ID_GAS_IRESP	0x0b	/* GAS Initial Response AF */
+#define P2PSD_ACTION_ID_GAS_CREQ	0x0c	/* GAS Comeback Request AF */
+#define P2PSD_ACTION_ID_GAS_CRESP	0x0d	/* GAS Comeback Response AF */
+
+#define INFF_P2P_DISABLE_TIMEOUT	msecs_to_jiffies(500)
+
+/* Mask for retry counter of custom dwell time */
+#define CUSTOM_RETRY_MASK 0xff000000
+/**
+ * struct inff_p2p_disc_st_le - set discovery state in firmware.
+ *
+ * @state: requested discovery state (see enum inff_p2p_disc_state).
+ * @chspec: channel parameter for %WL_P2P_DISC_ST_LISTEN state.
+ * @dwell: dwell time in ms for %WL_P2P_DISC_ST_LISTEN state.
+ */
+struct inff_p2p_disc_st_le {
+	u8 state;
+	__le16 chspec;
+	__le16 dwell;
+};
+
+/**
+ * enum inff_p2p_disc_state - P2P discovery state values
+ *
+ * @WL_P2P_DISC_ST_SCAN: P2P discovery with wildcard SSID and P2P IE.
+ * @WL_P2P_DISC_ST_LISTEN: P2P discovery off-channel for specified time.
+ * @WL_P2P_DISC_ST_SEARCH: P2P discovery with P2P wildcard SSID and P2P IE.
+ */
+enum inff_p2p_disc_state {
+	WL_P2P_DISC_ST_SCAN,
+	WL_P2P_DISC_ST_LISTEN,
+	WL_P2P_DISC_ST_SEARCH
+};
+
+/**
+ * struct inff_p2p_scan_le - P2P specific scan request.
+ *
+ * @type: type of scan method requested (values: 'E' or 'S').
+ * @reserved: reserved (ignored).
+ * @eparams: parameters used for type 'E'.
+ * @sparams: parameters used for type 'S'.
+ */
+struct inff_p2p_scan_le {
+	u8 type;
+	u8 reserved[3];
+	union {
+		struct inff_escan_params_le eparams;
+		struct inff_scan_params_le sparams;
+	};
+};
+
+/**
+ * struct inff_p2p_pub_act_frame - WiFi P2P Public Action Frame
+ *
+ * @category: P2P_PUB_AF_CATEGORY
+ * @action: P2P_PUB_AF_ACTION
+ * @oui: P2P_OUI
+ * @oui_type: OUI type - P2P_VER
+ * @subtype: OUI subtype - P2P_TYPE_*
+ * @dialog_token: nonzero, identifies req/rsp transaction
+ * @elts: Variable length information elements.
+ */
+struct inff_p2p_pub_act_frame {
+	u8	category;
+	u8	action;
+	u8	oui[3];
+	u8	oui_type;
+	u8	subtype;
+	u8	dialog_token;
+	u8	elts[];
+};
+
+/**
+ * struct inff_p2p_action_frame - WiFi P2P Action Frame
+ *
+ * @category: P2P_AF_CATEGORY
+ * @oui: OUI - P2P_OUI
+ * @type: OUI Type - P2P_VER
+ * @subtype: OUI Subtype - P2P_AF_*
+ * @dialog_token: nonzero, identifies req/resp tranaction
+ * @elts: Variable length information elements.
+ */
+struct inff_p2p_action_frame {
+	u8	category;
+	u8	oui[3];
+	u8	type;
+	u8	subtype;
+	u8	dialog_token;
+	u8	elts[];
+};
+
+/**
+ * struct inff_p2psd_gas_pub_act_frame - Wi-Fi GAS Public Action Frame
+ *
+ * @category: 0x04 Public Action Frame
+ * @action: 0x6c Advertisement Protocol
+ * @dialog_token: nonzero, identifies req/rsp transaction
+ * @query_data: Query Data. SD gas ireq SD gas iresp
+ */
+struct inff_p2psd_gas_pub_act_frame {
+	u8	category;
+	u8	action;
+	u8	dialog_token;
+	u8	query_data[];
+};
+
+/**
+ * struct inff_config_af_params - Action Frame Parameters for tx.
+ *
+ * @mpc_onoff: To make sure to send successfully action frame, we have to
+ *             turn off mpc  0: off, 1: on,  (-1): do nothing
+ * @search_channel: 1: search peer's channel to send af
+ * @extra_listen: keep the dwell time to get af response frame.
+ */
+struct inff_config_af_params {
+	s32 mpc_onoff;
+	bool search_channel;
+	bool extra_listen;
+};
+
+/**
+ * inff_p2p_is_pub_action() - true if p2p public type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is p2p public action type
+ */
+static bool inff_p2p_is_pub_action(void *frame, u32 frame_len)
+{
+	struct inff_p2p_pub_act_frame *pact_frm;
+
+	if (!frame)
+		return false;
+
+	pact_frm = (struct inff_p2p_pub_act_frame *)frame;
+	if (frame_len < sizeof(*pact_frm))
+		return false;
+
+	if (pact_frm->category == P2P_PUB_AF_CATEGORY &&
+	    pact_frm->action == P2P_PUB_AF_ACTION &&
+	    pact_frm->oui_type == P2P_VER &&
+	    memcmp(pact_frm->oui, WFA_OUI, P2P_OUI_LEN) == 0)
+		return true;
+
+	return false;
+}
+
+/**
+ * inff_p2p_is_dpp_pub_action() - true if dpp public type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is dpp public action type
+ */
+static bool inff_p2p_is_dpp_pub_action(void *frame, u32 frame_len)
+{
+	struct inff_p2p_pub_act_frame *pact_frm;
+
+	if (!frame)
+		return false;
+
+	pact_frm = (struct inff_p2p_pub_act_frame *)frame;
+	if (frame_len < sizeof(struct inff_p2p_pub_act_frame) - 1)
+		return false;
+
+	if (pact_frm->category == WLAN_CATEGORY_PUBLIC &&
+	    pact_frm->action == WLAN_PUB_ACTION_VENDOR_SPECIFIC &&
+	    pact_frm->oui_type == WLAN_OUI_TYPE_WFA_DPP &&
+	    memcmp(pact_frm->oui, WFA_OUI, TLV_OUI_LEN) == 0)
+		return true;
+
+	return false;
+}
+
+/**
+ * inff_p2p_is_p2p_action() - true if p2p action type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is p2p action type
+ */
+static bool inff_p2p_is_p2p_action(void *frame, u32 frame_len)
+{
+	struct inff_p2p_action_frame *act_frm;
+
+	if (!frame)
+		return false;
+
+	act_frm = (struct inff_p2p_action_frame *)frame;
+	if (frame_len < sizeof(*act_frm))
+		return false;
+
+	if (act_frm->category == P2P_AF_CATEGORY &&
+	    act_frm->type  == P2P_VER &&
+	    memcmp(act_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
+		return true;
+
+	return false;
+}
+
+/**
+ * inff_p2p_is_gas_action() - true if p2p gas action type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is p2p gas action type
+ */
+static bool inff_p2p_is_gas_action(void *frame, u32 frame_len)
+{
+	struct inff_p2psd_gas_pub_act_frame *sd_act_frm;
+
+	if (!frame)
+		return false;
+
+	sd_act_frm = (struct inff_p2psd_gas_pub_act_frame *)frame;
+	if (frame_len < sizeof(*sd_act_frm))
+		return false;
+
+	if (sd_act_frm->category != P2PSD_ACTION_CATEGORY)
+		return false;
+
+	if (sd_act_frm->action == P2PSD_ACTION_ID_GAS_IREQ ||
+	    sd_act_frm->action == P2PSD_ACTION_ID_GAS_IRESP ||
+	    sd_act_frm->action == P2PSD_ACTION_ID_GAS_CREQ ||
+	    sd_act_frm->action == P2PSD_ACTION_ID_GAS_CRESP)
+		return true;
+
+	return false;
+}
+
+/**
+ * inff_p2p_print_actframe() - debug print routine.
+ *
+ * @tx: Received or to be transmitted
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Print information about the p2p action frame
+ */
+
+#ifdef DEBUG
+
+static void inff_p2p_print_actframe(bool tx, void *frame, u32 frame_len)
+{
+	struct inff_p2p_pub_act_frame *pact_frm;
+	struct inff_p2p_action_frame *act_frm;
+	struct inff_p2psd_gas_pub_act_frame *sd_act_frm;
+
+	if (!frame || frame_len <= 2)
+		return;
+
+	if (inff_p2p_is_pub_action(frame, frame_len)) {
+		pact_frm = (struct inff_p2p_pub_act_frame *)frame;
+		switch (pact_frm->subtype) {
+		case P2P_PAF_GON_REQ:
+			inff_dbg(TRACE, "%s P2P Group Owner Negotiation Req Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_GON_RSP:
+			inff_dbg(TRACE, "%s P2P Group Owner Negotiation Rsp Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_GON_CONF:
+			inff_dbg(TRACE, "%s P2P Group Owner Negotiation Confirm Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_INVITE_REQ:
+			inff_dbg(TRACE, "%s P2P Invitation Request  Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_INVITE_RSP:
+			inff_dbg(TRACE, "%s P2P Invitation Response Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_DEVDIS_REQ:
+			inff_dbg(TRACE, "%s P2P Device Discoverability Request Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_DEVDIS_RSP:
+			inff_dbg(TRACE, "%s P2P Device Discoverability Response Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_PROVDIS_REQ:
+			inff_dbg(TRACE, "%s P2P Provision Discovery Request Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_PAF_PROVDIS_RSP:
+			inff_dbg(TRACE, "%s P2P Provision Discovery Response Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		default:
+			inff_dbg(TRACE, "%s Unknown P2P Public Action Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		}
+	} else if (inff_p2p_is_p2p_action(frame, frame_len)) {
+		act_frm = (struct inff_p2p_action_frame *)frame;
+		switch (act_frm->subtype) {
+		case P2P_AF_NOTICE_OF_ABSENCE:
+			inff_dbg(TRACE, "%s P2P Notice of Absence Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_AF_PRESENCE_REQ:
+			inff_dbg(TRACE, "%s P2P Presence Request Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_AF_PRESENCE_RSP:
+			inff_dbg(TRACE, "%s P2P Presence Response Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2P_AF_GO_DISC_REQ:
+			inff_dbg(TRACE, "%s P2P Discoverability Request Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		default:
+			inff_dbg(TRACE, "%s Unknown P2P Action Frame\n",
+				 (tx) ? "TX" : "RX");
+		}
+
+	} else if (inff_p2p_is_gas_action(frame, frame_len)) {
+		sd_act_frm = (struct inff_p2psd_gas_pub_act_frame *)frame;
+		switch (sd_act_frm->action) {
+		case P2PSD_ACTION_ID_GAS_IREQ:
+			inff_dbg(TRACE, "%s P2P GAS Initial Request\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2PSD_ACTION_ID_GAS_IRESP:
+			inff_dbg(TRACE, "%s P2P GAS Initial Response\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2PSD_ACTION_ID_GAS_CREQ:
+			inff_dbg(TRACE, "%s P2P GAS Comeback Request\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		case P2PSD_ACTION_ID_GAS_CRESP:
+			inff_dbg(TRACE, "%s P2P GAS Comeback Response\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		default:
+			inff_dbg(TRACE, "%s Unknown P2P GAS Frame\n",
+				 (tx) ? "TX" : "RX");
+			break;
+		}
+	}
+}
+
+#else
+
+static void inff_p2p_print_actframe(bool tx, void *frame, u32 frame_len)
+{
+}
+
+#endif
+
+/**
+ * inff_p2p_set_firmware() - prepare firmware for peer-to-peer operation.
+ *
+ * @ifp: ifp to use for iovars (primary).
+ * @p2p_mac: mac address to configure for p2p_da_override
+ */
+static int inff_p2p_set_firmware(struct inff_if *ifp, u8 *p2p_mac)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 ret = 0, apsta = 0;
+
+	ret = inff_fil_iovar_int_get(ifp, "apsta", &apsta);
+	if (ret) {
+		iphy_err(drvr, "failed to query apsta IOVAR");
+	} else if (!apsta) {
+		if (inff_fil_cmd_int_set(ifp, INFF_C_DOWN, 1) ||
+		    inff_fil_iovar_int_set(ifp, "apsta", 1) ||
+		    inff_fil_cmd_int_set(ifp, INFF_C_UP, 1)) {
+			iphy_err(drvr, "failed to set apsta IOVAR");
+		}
+	}
+
+	/* In case of COB type, firmware has default mac address
+	 * After Initializing firmware, we have to set current mac address to
+	 * firmware for P2P device address. This must be done with discovery
+	 * disabled.
+	 */
+	inff_fil_iovar_int_set(ifp, "p2p_disc", 0);
+
+	ret = inff_fil_iovar_data_set(ifp, "p2p_da_override", p2p_mac,
+				      ETH_ALEN);
+	if (ret)
+		iphy_err(drvr, "failed to update device address ret %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * inff_p2p_generate_bss_mac() - derive mac addresses for P2P.
+ *
+ * @p2p: P2P specific data.
+ * @dev_addr: optional device address.
+ *
+ * P2P needs mac addresses for P2P device and interface. If no device
+ * address it specified, these are derived from a random ethernet
+ * address.
+ */
+static void inff_p2p_generate_bss_mac(struct inff_p2p_info *p2p, u8 *dev_addr)
+{
+	struct inff_if *pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
+	bool random_addr = false;
+	bool local_admin = false;
+
+	if (!dev_addr || is_zero_ether_addr(dev_addr)) {
+		/* If the primary interface address is already locally
+		 * administered, create a new random address.
+		 */
+		if (pri_ifp->mac_addr[0] & 0x02) {
+			random_addr = true;
+		} else {
+			dev_addr = pri_ifp->mac_addr;
+			local_admin = true;
+		}
+	}
+
+	/* Generate the P2P Device Address obtaining a random ethernet
+	 * address with the locally administered bit set.
+	 */
+	if (random_addr)
+		eth_random_addr(p2p->dev_addr);
+	else
+		memcpy(p2p->dev_addr, dev_addr, ETH_ALEN);
+
+	if (local_admin)
+		p2p->dev_addr[0] |= 0x02;
+
+	/* Generate the P2P Interface Address.  If the discovery and connection
+	 * BSSCFGs need to simultaneously co-exist, then this address must be
+	 * different from the P2P Device Address, but also locally administered.
+	 */
+	memcpy(p2p->conn_int_addr, p2p->dev_addr, ETH_ALEN);
+	p2p->conn_int_addr[0] |= 0x02;
+	p2p->conn_int_addr[4] ^= 0x80;
+
+	memcpy(p2p->conn2_int_addr, p2p->dev_addr, ETH_ALEN);
+	p2p->conn2_int_addr[0] |= 0x02;
+	p2p->conn2_int_addr[4] ^= 0x90;
+}
+
+/**
+ * inff_p2p_scan_is_p2p_request() - is cfg80211 scan request a P2P scan.
+ *
+ * @request: the scan request as received from cfg80211.
+ *
+ * returns true if one of the ssids in the request matches the
+ * P2P wildcard ssid; otherwise returns false.
+ */
+static bool inff_p2p_scan_is_p2p_request(struct cfg80211_scan_request *request)
+{
+	struct cfg80211_ssid *ssids = request->ssids;
+	int i;
+
+	for (i = 0; i < request->n_ssids; i++) {
+		if (ssids[i].ssid_len != INFF_P2P_WILDCARD_SSID_LEN)
+			continue;
+
+		inff_dbg(INFO, "comparing ssid \"%s\"", ssids[i].ssid);
+		if (!memcmp(INFF_P2P_WILDCARD_SSID, ssids[i].ssid,
+			    INFF_P2P_WILDCARD_SSID_LEN))
+			return true;
+	}
+	return false;
+}
+
+/**
+ * inff_p2p_set_discover_state - set discover state in firmware.
+ *
+ * @ifp: low-level interface object.
+ * @state: discover state to set.
+ * @chanspec: channel parameters (for state @WL_P2P_DISC_ST_LISTEN only).
+ * @listen_ms: duration to listen (for state @WL_P2P_DISC_ST_LISTEN only).
+ */
+static s32 inff_p2p_set_discover_state(struct inff_if *ifp, u8 state,
+				       u16 chanspec, u16 listen_ms)
+{
+	struct inff_p2p_disc_st_le discover_state;
+	s32 ret = 0;
+
+	inff_dbg(TRACE, "enter\n");
+
+	discover_state.state = state;
+	discover_state.chspec = cpu_to_le16(chanspec);
+	discover_state.dwell = cpu_to_le16(listen_ms);
+	ret = inff_fil_bsscfg_data_set(ifp, "p2p_state", &discover_state,
+				       sizeof(discover_state));
+	return ret;
+}
+
+/**
+ * inff_p2p_deinit_discovery() - disable P2P device discovery.
+ *
+ * @p2p: P2P specific data.
+ *
+ * Resets the discovery state and disables it in firmware.
+ */
+static s32 inff_p2p_deinit_discovery(struct inff_p2p_info *p2p)
+{
+	struct inff_cfg80211_vif *vif;
+
+	inff_dbg(TRACE, "enter\n");
+
+	/* Set the discovery state to SCAN */
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	(void)inff_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
+
+	/* Disable P2P discovery in the firmware */
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+	(void)inff_fil_iovar_int_set(vif->ifp, "p2p_disc", 0);
+
+	return 0;
+}
+
+/**
+ * inff_p2p_enable_discovery() - initialize and configure discovery.
+ *
+ * @p2p: P2P specific data.
+ *
+ * Initializes the discovery device and configure the virtual interface.
+ */
+static int inff_p2p_enable_discovery(struct inff_p2p_info *p2p)
+{
+	struct inff_pub *drvr = p2p->cfg->pub;
+	struct inff_cfg80211_vif *vif;
+	s32 ret = 0;
+
+	inff_dbg(TRACE, "enter\n");
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	if (!vif) {
+		iphy_err(drvr, "P2P config device not available\n");
+		ret = -EPERM;
+		goto exit;
+	}
+
+	if (test_bit(INFF_P2P_STATUS_ENABLED, &p2p->status)) {
+		inff_dbg(INFO, "P2P config device already configured\n");
+		goto exit;
+	}
+
+	/* Re-initialize P2P Discovery in the firmware */
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+	ret = inff_fil_iovar_int_set(vif->ifp, "p2p_disc", 1);
+	if (ret < 0) {
+		iphy_err(drvr, "set p2p_disc error\n");
+		goto exit;
+	}
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	ret = inff_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
+	if (ret < 0) {
+		iphy_err(drvr, "unable to set WL_P2P_DISC_ST_SCAN\n");
+		goto exit;
+	}
+
+	/*
+	 * Set wsec to any non-zero value in the discovery bsscfg
+	 * to ensure our P2P probe responses have the privacy bit
+	 * set in the 802.11 WPA IE. Some peer devices may not
+	 * initiate WPS with us if this bit is not set.
+	 */
+	ret = inff_fil_bsscfg_int_set(vif->ifp, "wsec", AES_ENABLED);
+	if (ret < 0) {
+		iphy_err(drvr, "wsec error %d\n", ret);
+		goto exit;
+	}
+
+	set_bit(INFF_P2P_STATUS_ENABLED, &p2p->status);
+exit:
+	return ret;
+}
+
+/**
+ * inff_p2p_escan() - initiate a P2P scan.
+ *
+ * @p2p: P2P specific data.
+ * @num_chans: number of channels to scan.
+ * @chanspecs: channel parameters for @num_chans channels.
+ * @search_state: P2P discover state to use.
+ * @bss_type: type of P2P bss.
+ */
+static s32 inff_p2p_escan(struct inff_p2p_info *p2p, u32 num_chans,
+			  u16 chanspecs[], s32 search_state,
+			  enum p2p_bss_type bss_type)
+{
+	struct inff_pub *drvr = p2p->cfg->pub;
+	s32 ret = 0;
+	s32 memsize = offsetof(struct inff_p2p_scan_le,
+			       eparams.params_le.channel_list);
+	s32 nprobes;
+	s32 active;
+	u32 i;
+	u8 *memblk;
+	struct inff_cfg80211_vif *vif;
+	struct inff_p2p_scan_le *p2p_params;
+	struct inff_scan_params_le *sparams;
+
+	memsize += num_chans * sizeof(__le16);
+	memblk = kzalloc(memsize, GFP_KERNEL);
+	if (!memblk)
+		return -ENOMEM;
+
+	vif = p2p->bss_idx[bss_type].vif;
+	if (!vif) {
+		iphy_err(drvr, "no vif for bss type %d\n", bss_type);
+		ret = -EINVAL;
+		goto exit;
+	}
+	p2p_params = (struct inff_p2p_scan_le *)memblk;
+	sparams = &p2p_params->eparams.params_le;
+
+	switch (search_state) {
+	case WL_P2P_DISC_ST_SEARCH:
+		/*
+		 * If we in SEARCH STATE, we don't need to set SSID explicitly
+		 * because dongle use P2P WILDCARD internally by default, use
+		 * null ssid, which it is already due to kzalloc.
+		 */
+		break;
+	case WL_P2P_DISC_ST_SCAN:
+		/*
+		 * wpa_supplicant has p2p_find command with type social or
+		 * progressive. For progressive, we need to set the ssid to
+		 * P2P WILDCARD because we just do broadcast scan unless
+		 * setting SSID.
+		 */
+		sparams->ssid_le.SSID_len =
+				cpu_to_le32(INFF_P2P_WILDCARD_SSID_LEN);
+		memcpy(sparams->ssid_le.SSID, INFF_P2P_WILDCARD_SSID,
+		       INFF_P2P_WILDCARD_SSID_LEN);
+		break;
+	default:
+		iphy_err(drvr, " invalid search state %d\n", search_state);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	inff_p2p_set_discover_state(vif->ifp, search_state, 0, 0);
+
+	/*
+	 * set p2p scan parameters.
+	 */
+	p2p_params->type = 'E';
+
+	/* determine the scan engine parameters */
+	sparams->bss_type = DOT11_BSSTYPE_ANY;
+	sparams->scan_type = INFF_SCANTYPE_ACTIVE;
+
+	eth_broadcast_addr(sparams->bssid);
+	sparams->home_time = cpu_to_le32(P2PAPI_SCAN_HOME_TIME_MS);
+
+	/*
+	 * SOCIAL_CHAN_CNT + 1 takes care of the Progressive scan
+	 * supported by the supplicant.
+	 */
+	if (num_chans == SOCIAL_CHAN_CNT || num_chans == (SOCIAL_CHAN_CNT + 1))
+		active = P2PAPI_SCAN_SOCIAL_DWELL_TIME_MS;
+	else if (num_chans == AF_PEER_SEARCH_CNT)
+		active = P2PAPI_SCAN_AF_SEARCH_DWELL_TIME_MS;
+	else if (inff_get_vif_state_any(p2p->cfg, INFF_VIF_STATUS_CONNECTED))
+		active = -1;
+	else
+		active = P2PAPI_SCAN_DWELL_TIME_MS;
+
+	/* Override scan params to find a peer for a connection */
+	if (num_chans == 1) {
+		active = WL_SCAN_CONNECT_DWELL_TIME_MS;
+		/* WAR to sync with presence period of VSDB GO.
+		 * send probe request more frequently
+		 */
+		nprobes = active / WL_SCAN_JOIN_PROBE_INTERVAL_MS;
+	} else {
+		nprobes = active / P2PAPI_SCAN_NPROBS_TIME_MS;
+	}
+
+	if (nprobes <= 0)
+		nprobes = 1;
+
+	inff_dbg(INFO, "nprobes # %d, active_time %d\n", nprobes, active);
+	sparams->active_time = cpu_to_le32(active);
+	sparams->nprobes = cpu_to_le32(nprobes);
+	sparams->passive_time = cpu_to_le32(-1);
+	sparams->channel_num = cpu_to_le32(num_chans &
+					   INFF_SCAN_PARAMS_COUNT_MASK);
+	for (i = 0; i < num_chans; i++)
+		sparams->channel_list[i] = cpu_to_le16(chanspecs[i]);
+
+	/* set the escan specific parameters */
+	p2p_params->eparams.version = cpu_to_le32(INFF_ESCAN_REQ_VERSION);
+	p2p_params->eparams.action =  cpu_to_le16(WL_ESCAN_ACTION_START);
+	p2p_params->eparams.sync_id = cpu_to_le16(0x1234);
+	/* perform p2p scan on primary device */
+	ret = inff_fil_bsscfg_data_set(vif->ifp, "p2p_scan", memblk, memsize);
+	if (!ret)
+		set_bit(INFF_SCAN_STATUS_BUSY, &p2p->cfg->scan_status);
+exit:
+	kfree(memblk);
+	return ret;
+}
+
+/**
+ * inff_p2p_run_escan() - escan callback for peer-to-peer.
+ *
+ * @cfg: driver private data for cfg80211 interface.
+ * @ifp: interface control.
+ * @request: scan request from cfg80211.
+ *
+ * Determines the P2P discovery state based to scan request parameters and
+ * validates the channels in the request.
+ */
+static s32 inff_p2p_run_escan(struct inff_cfg80211_info *cfg,
+			      struct inff_if *ifp,
+			       struct cfg80211_scan_request *request)
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_pub *drvr = cfg->pub;
+	s32 err = 0;
+	s32 search_state = WL_P2P_DISC_ST_SCAN;
+	struct inff_cfg80211_vif *vif;
+	struct net_device *dev = NULL;
+	int i, num_nodfs = 0;
+	u16 *chanspecs;
+
+	inff_dbg(TRACE, "enter\n");
+
+	if (!request) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (request->n_channels) {
+		chanspecs = kcalloc(request->n_channels, sizeof(*chanspecs),
+				    GFP_KERNEL);
+		if (!chanspecs) {
+			err = -ENOMEM;
+			goto exit;
+		}
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
+		if (vif)
+			dev = vif->wdev.netdev;
+		if (request->n_channels == 3 &&
+		    request->channels[0]->hw_value == SOCIAL_CHAN_1 &&
+		    request->channels[1]->hw_value == SOCIAL_CHAN_2 &&
+		    request->channels[2]->hw_value == SOCIAL_CHAN_3) {
+			/* SOCIAL CHANNELS 1, 6, 11 */
+			search_state = WL_P2P_DISC_ST_SEARCH;
+			inff_dbg(INFO, "P2P SEARCH PHASE START\n");
+		} else if (dev && vif->wdev.iftype == NL80211_IFTYPE_P2P_GO) {
+			/* If you are already a GO, then do SEARCH only */
+			inff_dbg(INFO, "Already a GO. Do SEARCH Only\n");
+			search_state = WL_P2P_DISC_ST_SEARCH;
+		} else {
+			inff_dbg(INFO, "P2P SCAN STATE START\n");
+		}
+
+		/*
+		 * no P2P scanning on passive or DFS channels.
+		 */
+		for (i = 0; i < request->n_channels; i++) {
+			struct ieee80211_channel *chan = request->channels[i];
+
+			if (chan->flags & (IEEE80211_CHAN_RADAR |
+					   IEEE80211_CHAN_NO_IR))
+				continue;
+
+			chanspecs[i] = channel_to_chanspec(&p2p->cfg->d11inf,
+							   chan);
+			inff_dbg(INFO, "%d: chan=%d, channel spec=%x\n",
+				 num_nodfs, chan->hw_value, chanspecs[i]);
+			num_nodfs++;
+		}
+		err = inff_p2p_escan(p2p, num_nodfs, chanspecs, search_state,
+				     P2PAPI_BSSCFG_DEVICE);
+		kfree(chanspecs);
+	}
+exit:
+	if (err)
+		iphy_err(drvr, "error (%d)\n", err);
+	return err;
+}
+
+/**
+ * inff_p2p_find_listen_channel() - find listen channel in ie string.
+ *
+ * @ie: string of information elements.
+ * @ie_len: length of string.
+ *
+ * Scan ie for p2p ie and look for attribute 6 channel. If available determine
+ * channel and return it.
+ */
+static s32 inff_p2p_find_listen_channel(const u8 *ie, u32 ie_len)
+{
+	u8 channel_ie[5];
+	s32 listen_channel;
+	s32 err;
+
+	err = cfg80211_get_p2p_attr(ie, ie_len,
+				    IEEE80211_P2P_ATTR_LISTEN_CHANNEL,
+				    channel_ie, sizeof(channel_ie));
+	if (err < 0)
+		return err;
+
+	/* listen channel subel length format:     */
+	/* 3(country) + 1(op. class) + 1(chan num) */
+	listen_channel = (s32)channel_ie[3 + 1];
+
+	if (listen_channel == SOCIAL_CHAN_1 ||
+	    listen_channel == SOCIAL_CHAN_2 ||
+	    listen_channel == SOCIAL_CHAN_3) {
+		inff_dbg(INFO, "Found my Listen Channel %d\n", listen_channel);
+		return listen_channel;
+	}
+
+	return -EPERM;
+}
+
+/**
+ * inff_p2p_scan_prep() - prepare scan based on request.
+ *
+ * @wiphy: wiphy device.
+ * @request: scan request from cfg80211.
+ * @vif: vif on which scan request is to be executed.
+ *
+ * Prepare the scan appropriately for type of scan requested. Overrides the
+ * escan .run() callback for peer-to-peer scanning.
+ */
+int inff_p2p_scan_prep(struct wiphy *wiphy,
+		       struct cfg80211_scan_request *request,
+		       struct inff_cfg80211_vif *vif)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	int err = 0;
+	struct inff_chan ch;
+
+	if (inff_p2p_scan_is_p2p_request(request)) {
+		/* find my listen channel */
+		err = inff_p2p_find_listen_channel(request->ie,
+						   request->ie_len);
+		if (err < 0)
+			return err;
+
+		ch.band = INFF_CHAN_BAND_2G;
+		ch.bw = INFF_CHAN_BW_20;
+		ch.sb = INFF_CHAN_SB_NONE;
+		ch.chnum = err;
+		p2p->cfg->d11inf.encchspec(&ch);
+		p2p->afx_hdl.my_listen_chan = ch.chspec;
+
+		clear_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
+		inff_dbg(INFO, "P2P: GO_NEG_PHASE status cleared\n");
+
+		err = inff_p2p_enable_discovery(p2p);
+		if (err)
+			return err;
+
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
+		/* override .run_escan() callback. */
+		cfg->escan_info.run = inff_p2p_run_escan;
+	}
+	err = inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_PRBREQ_FLAG,
+				   request->ie, request->ie_len);
+	return err;
+}
+
+/**
+ * inff_p2p_discover_listen() - set firmware to discover listen state.
+ *
+ * @p2p: p2p device.
+ * @chspec: chspec for discover listen.
+ * @duration: time in ms to stay on channel.
+ *
+ */
+static s32
+inff_p2p_discover_listen(struct inff_p2p_info *p2p, u16 chspec, u32 duration)
+{
+	struct inff_pub *drvr = p2p->cfg->pub;
+	struct inff_cfg80211_vif *vif;
+	s32 err = 0;
+
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	if (!vif) {
+		iphy_err(drvr, "Discovery is not set, so we have nothing to do\n");
+		err = -EPERM;
+		goto exit;
+	}
+
+	if (test_bit(INFF_P2P_STATUS_DISCOVER_LISTEN, &p2p->status)) {
+		iphy_err(drvr, "Previous LISTEN is not completed yet\n");
+		/* WAR: prevent cookie mismatch in wpa_supplicant return OK */
+		goto exit;
+	}
+
+	err = inff_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_LISTEN,
+					  chspec, (u16)duration);
+	if (!err) {
+		set_bit(INFF_P2P_STATUS_DISCOVER_LISTEN, &p2p->status);
+		p2p->remain_on_channel_cookie++;
+	}
+exit:
+	return err;
+}
+
+/**
+ * inff_p2p_remain_on_channel() - put device on channel and stay there.
+ *
+ * @wiphy: wiphy device.
+ * @wdev: wireless device.
+ * @channel: channel to stay on.
+ * @duration: time in ms to remain on channel.
+ * @cookie: cookie.
+ */
+int inff_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+			       struct ieee80211_channel *channel,
+			       unsigned int duration, u64 *cookie)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	s32 err;
+
+	err = inff_p2p_enable_discovery(p2p);
+	if (err)
+		goto exit;
+	err = inff_p2p_discover_listen(p2p, channel_to_chanspec(&cfg->d11inf, channel),
+				       duration);
+	if (err)
+		goto exit;
+
+	p2p->remin_on_channel_wdev = wdev;
+
+	memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
+	*cookie = p2p->remain_on_channel_cookie;
+	cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
+
+exit:
+	return err;
+}
+
+/**
+ * inff_p2p_notify_listen_complete() - p2p listen has completed.
+ *
+ * @ifp: interfac control.
+ * @e: event message. Not used, to make it usable for fweh event dispatcher.
+ * @data: payload of message. Not used.
+ *
+ */
+int inff_p2p_notify_listen_complete(struct inff_if *ifp,
+				    const struct inff_event_msg *e,
+				     void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct wireless_dev *wdev = p2p->remin_on_channel_wdev;
+
+	inff_dbg(TRACE, "Enter\n");
+	if (test_and_clear_bit(INFF_P2P_STATUS_DISCOVER_LISTEN,
+			       &p2p->status)) {
+		if (test_and_clear_bit(INFF_P2P_STATUS_WAITING_NEXT_AF_LISTEN,
+				       &p2p->status)) {
+			clear_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME,
+				  &p2p->status);
+			inff_dbg(INFO, "Listen DONE, wake up wait_next_af\n");
+			complete(&p2p->wait_next_af);
+		}
+
+		wdev = p2p->remin_on_channel_wdev ?
+			p2p->remin_on_channel_wdev :
+			&ifp->vif->wdev;
+
+		cfg80211_remain_on_channel_expired(wdev,
+						   p2p->remain_on_channel_cookie,
+						   &p2p->remain_on_channel,
+						   GFP_KERNEL);
+		p2p->remin_on_channel_wdev = NULL;
+	}
+	return 0;
+}
+
+/**
+ * inff_p2p_cancel_remain_on_channel() - cancel p2p listen state.
+ *
+ * @ifp: interfac control.
+ *
+ */
+void inff_p2p_cancel_remain_on_channel(struct inff_if *ifp)
+{
+	if (!ifp)
+		return;
+	inff_p2p_set_discover_state(ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
+	inff_p2p_notify_listen_complete(ifp, NULL, NULL);
+}
+
+/**
+ * inff_p2p_act_frm_search() - search function for action frame.
+ *
+ * @p2p: p2p device.
+ * @chspec: chspec on which action frame is to be trasmitted.
+ *
+ * search function to reach at common channel to send action frame. When
+ * channel is 0 then all social channels will be used to send af
+ */
+static s32 inff_p2p_act_frm_search(struct inff_p2p_info *p2p, u16 chspec)
+{
+	s32 err;
+	u32 channel_cnt;
+	u16 *default_chan_list;
+	u32 i;
+	struct inff_chan ch;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	if (chspec)
+		channel_cnt = AF_PEER_SEARCH_CNT;
+	else
+		channel_cnt = SOCIAL_CHAN_CNT;
+	default_chan_list = kcalloc(channel_cnt, sizeof(*default_chan_list),
+				    GFP_KERNEL);
+	if (!default_chan_list) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	if (chspec) {
+		for (i = 0; i < channel_cnt; i++)
+			default_chan_list[i] = chspec;
+	} else {
+		ch.band = INFF_CHAN_BAND_2G;
+		ch.bw = INFF_CHAN_BW_20;
+		ch.chnum = SOCIAL_CHAN_1;
+		p2p->cfg->d11inf.encchspec(&ch);
+		default_chan_list[0] = ch.chspec;
+		ch.chnum = SOCIAL_CHAN_2;
+		p2p->cfg->d11inf.encchspec(&ch);
+		default_chan_list[1] = ch.chspec;
+		ch.chnum = SOCIAL_CHAN_3;
+		p2p->cfg->d11inf.encchspec(&ch);
+		default_chan_list[2] = ch.chspec;
+	}
+	err = inff_p2p_escan(p2p, channel_cnt, default_chan_list,
+			     WL_P2P_DISC_ST_SEARCH, P2PAPI_BSSCFG_DEVICE);
+	kfree(default_chan_list);
+exit:
+	return err;
+}
+
+/**
+ * inff_p2p_afx_handler() - afx worker thread.
+ *
+ * @work:
+ *
+ */
+static void inff_p2p_afx_handler(struct work_struct *work)
+{
+	struct afx_hdl *afx_hdl = container_of(work, struct afx_hdl, afx_work);
+	struct inff_p2p_info *p2p = container_of(afx_hdl,
+						 struct inff_p2p_info,
+						 afx_hdl);
+	struct inff_pub *drvr = p2p->cfg->pub;
+	s32 err;
+
+	if (!afx_hdl->is_active)
+		return;
+
+	if (afx_hdl->is_listen && afx_hdl->my_listen_chan)
+		/* 100ms ~ 300ms */
+		err = inff_p2p_discover_listen(p2p, afx_hdl->my_listen_chan,
+					       100 * get_random_u32_inclusive(1, 3));
+	else
+		err = inff_p2p_act_frm_search(p2p, afx_hdl->peer_listen_chan);
+
+	if (err) {
+		iphy_err(drvr, "ERROR occurred! value is (%d)\n", err);
+		if (test_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL,
+			     &p2p->status))
+			complete(&afx_hdl->act_frm_scan);
+	}
+}
+
+/**
+ * inff_p2p_af_searching_channel() - search channel.
+ *
+ * @p2p: p2p device info struct.
+ *
+ */
+static u16 inff_p2p_af_searching_channel(struct inff_p2p_info *p2p)
+{
+	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
+	struct inff_cfg80211_vif *pri_vif;
+	s32 retry;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	pri_vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
+	reinit_completion(&afx_hdl->act_frm_scan);
+	set_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL, &p2p->status);
+	afx_hdl->is_active = true;
+	afx_hdl->peer_chan = P2P_INVALID_CHANSPEC;
+
+	/* Loop to wait until we find a peer's channel or the
+	 * pending action frame tx is cancelled.
+	 */
+	retry = 0;
+	while ((retry < P2P_CHANNEL_SYNC_RETRY) &&
+	       (afx_hdl->peer_chan == P2P_INVALID_CHANSPEC)) {
+		afx_hdl->is_listen = false;
+		inff_dbg(TRACE, "Scheduling action frame for sending.. (%d)\n",
+			 retry);
+		/* search peer on peer's listen channel */
+		schedule_work(&afx_hdl->afx_work);
+		wait_for_completion_timeout(&afx_hdl->act_frm_scan,
+					    P2P_AF_FRM_SCAN_MAX_WAIT);
+		if (afx_hdl->peer_chan != P2P_INVALID_CHANSPEC ||
+		    (!test_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL,
+			       &p2p->status)))
+			break;
+
+		if (afx_hdl->my_listen_chan) {
+			inff_dbg(TRACE, "Scheduling listen peer, chanspec=0x%04x\n",
+				 afx_hdl->my_listen_chan);
+			/* listen on my listen channel */
+			afx_hdl->is_listen = true;
+			schedule_work(&afx_hdl->afx_work);
+			wait_for_completion_timeout(&afx_hdl->act_frm_scan,
+						    P2P_AF_FRM_SCAN_MAX_WAIT);
+		}
+		if (afx_hdl->peer_chan != P2P_INVALID_CHANSPEC ||
+		    (!test_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL,
+			       &p2p->status)))
+			break;
+		retry++;
+
+		/* if sta is connected or connecting, sleep for a while before
+		 * retry af tx or finding a peer
+		 */
+		if (test_bit(INFF_VIF_STATUS_CONNECTED, &pri_vif->sme_state) ||
+		    test_bit(INFF_VIF_STATUS_CONNECTING, &pri_vif->sme_state))
+			msleep(P2P_DEFAULT_SLEEP_TIME_VSDB);
+	}
+
+	inff_dbg(TRACE, "Completed search/listen peer_chan=0x%4x\n",
+		 afx_hdl->peer_chan);
+	afx_hdl->is_active = false;
+
+	clear_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL, &p2p->status);
+
+	return afx_hdl->peer_chan;
+}
+
+/**
+ * inff_p2p_scan_finding_common_channel() - was escan used for finding channel
+ *
+ * @cfg: common configuration struct.
+ * @bi: bss info struct, result from scan.
+ *
+ */
+bool inff_p2p_scan_finding_common_channel(struct inff_cfg80211_info *cfg,
+					  struct inff_bss_info_le *bi)
+
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
+	u8 *ie;
+	s32 err;
+	u8 p2p_dev_addr[ETH_ALEN];
+
+	if (!test_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL, &p2p->status))
+		return false;
+
+	if (!bi) {
+		inff_dbg(TRACE, "ACTION FRAME SCAN Done\n");
+		if (afx_hdl->peer_chan == P2P_INVALID_CHANSPEC)
+			complete(&afx_hdl->act_frm_scan);
+		return true;
+	}
+
+	ie = ((u8 *)bi) + le16_to_cpu(bi->ie_offset);
+	memset(p2p_dev_addr, 0, sizeof(p2p_dev_addr));
+	err = cfg80211_get_p2p_attr(ie, le32_to_cpu(bi->ie_length),
+				    IEEE80211_P2P_ATTR_DEVICE_INFO,
+				    p2p_dev_addr, sizeof(p2p_dev_addr));
+	if (err < 0)
+		err = cfg80211_get_p2p_attr(ie, le32_to_cpu(bi->ie_length),
+					    IEEE80211_P2P_ATTR_DEVICE_ID,
+					    p2p_dev_addr, sizeof(p2p_dev_addr));
+	if (err >= 0 &&
+	    (ether_addr_equal(p2p_dev_addr, afx_hdl->tx_dst_addr))) {
+		afx_hdl->peer_chan = le16_to_cpu(bi->chanspec);
+		inff_dbg(TRACE, "ACTION FRAME SCAN : Peer %pM found, chanspec : 0x%04x\n",
+			 afx_hdl->tx_dst_addr, afx_hdl->peer_chan);
+		complete(&afx_hdl->act_frm_scan);
+	}
+	return true;
+}
+
+/**
+ * inff_p2p_abort_action_frame() - abort action frame.
+ *
+ * @cfg: common configuration struct.
+ *
+ */
+static s32 inff_p2p_abort_action_frame(struct inff_cfg80211_info *cfg)
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_cfg80211_vif *vif;
+	s32 err;
+	s32 int_val = 1;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
+	if (!vif)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
+	err = inff_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
+				       sizeof(s32));
+	if (err)
+		inff_err(" aborting action frame has failed (%d)\n", err);
+
+	return err;
+}
+
+/**
+ * inff_p2p_stop_wait_next_action_frame() - finish scan if af tx complete.
+ *
+ * @cfg: common configuration struct.
+ *
+ */
+static void
+inff_p2p_stop_wait_next_action_frame(struct inff_cfg80211_info *cfg)
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_if *ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
+	s32 err;
+
+	if (test_bit(INFF_P2P_STATUS_SENDING_ACT_FRAME, &p2p->status) &&
+	    (test_bit(INFF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status) ||
+	     test_bit(INFF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status))) {
+		inff_dbg(TRACE, "*** Wake UP ** abort actframe iovar\n");
+		/* if channel is not zero, "actfame" uses off channel scan.
+		 * So abort scan for off channel completion.
+		 */
+		if (p2p->af_sent_channel) {
+			/* abort actframe using actframe_abort or abort scan */
+			err = inff_p2p_abort_action_frame(cfg);
+			if (err)
+				inff_notify_escan_complete(cfg, ifp, true,
+							   true);
+		}
+	} else if (test_bit(INFF_P2P_STATUS_WAITING_NEXT_AF_LISTEN,
+			    &p2p->status)) {
+		inff_dbg(TRACE, "*** Wake UP ** abort listen for next af frame\n");
+		/* So abort scan to cancel listen */
+		inff_notify_escan_complete(cfg, ifp, true, true);
+	}
+}
+
+/**
+ * inff_p2p_gon_req_collision() - Check if go negotiaton collission
+ *
+ * @p2p: p2p device info struct.
+ * @mac: MAC address.
+ *
+ * return true if received action frame is to be dropped.
+ */
+static bool
+inff_p2p_gon_req_collision(struct inff_p2p_info *p2p, u8 *mac)
+{
+	struct inff_cfg80211_info *cfg = p2p->cfg;
+	struct inff_if *ifp;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	if (!test_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME, &p2p->status) ||
+	    !p2p->gon_req_action)
+		return false;
+
+	inff_dbg(TRACE, "GO Negotiation Request COLLISION !!!\n");
+	/* if sa(peer) addr is less than da(my) addr, then this device
+	 * process peer's gon request and block to send gon req.
+	 * if not (sa addr > da addr),
+	 * this device will process gon request and drop gon req of peer.
+	 */
+	ifp = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->ifp;
+	if (memcmp(mac, ifp->mac_addr, ETH_ALEN) < 0) {
+		inff_dbg(INFO, "Block transmit gon req !!!\n");
+		p2p->block_gon_req_tx = true;
+		/* if we are finding a common channel for sending af,
+		 * do not scan more to block to send current gon req
+		 */
+		if (test_and_clear_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL,
+				       &p2p->status))
+			complete(&p2p->afx_hdl.act_frm_scan);
+		if (test_and_clear_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME,
+				       &p2p->status))
+			inff_p2p_stop_wait_next_action_frame(cfg);
+		return false;
+	}
+
+	/* drop gon request of peer to process gon request by this device. */
+	inff_dbg(INFO, "Drop received gon req !!!\n");
+
+	return true;
+}
+
+/**
+ * inff_p2p_notify_action_frame_rx() - received action frame.
+ *
+ * @ifp: interfac control.
+ * @e: event message. Not used, to make it usable for fweh event dispatcher.
+ * @data: payload of message, containing action frame data.
+ *
+ */
+int inff_p2p_notify_action_frame_rx(struct inff_if *ifp,
+				    const struct inff_event_msg *e,
+				     void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_cfg80211_info *cfg = drvr->config;
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
+	struct wireless_dev *wdev;
+	u32 mgmt_frame_len = e->datalen - sizeof(struct inff_rx_mgmt_data);
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	u8 *frame = (u8 *)(rxframe + 1);
+	struct inff_p2p_pub_act_frame *act_frm;
+	struct inff_p2psd_gas_pub_act_frame *sd_act_frm;
+	struct inff_chan ch;
+	struct ieee80211_mgmt *mgmt_frame;
+	s32 freq;
+	u16 mgmt_type;
+	u8 action;
+
+	if (e->datalen < sizeof(*rxframe)) {
+		inff_dbg(SCAN, "Event data too small. Ignore\n");
+		return 0;
+	}
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	cfg->d11inf.decchspec(&ch);
+	/* Check if wpa_supplicant has registered for this frame */
+	inff_dbg(INFO, "ifp->vif->mgmt_rx_reg %04x\n", ifp->vif->mgmt_rx_reg);
+	mgmt_type = (IEEE80211_STYPE_ACTION & IEEE80211_FCTL_STYPE) >> 4;
+	if ((ifp->vif->mgmt_rx_reg & BIT(mgmt_type)) == 0)
+		return 0;
+
+	inff_p2p_print_actframe(false, frame, mgmt_frame_len);
+
+	action = P2P_PAF_SUBTYPE_INVALID;
+	if (inff_p2p_is_pub_action(frame, mgmt_frame_len)) {
+		act_frm = (struct inff_p2p_pub_act_frame *)frame;
+		action = act_frm->subtype;
+		if (action == P2P_PAF_GON_REQ &&
+		    (inff_p2p_gon_req_collision(p2p, (u8 *)e->addr))) {
+			if (test_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL,
+				     &p2p->status) &&
+			    (ether_addr_equal(afx_hdl->tx_dst_addr, e->addr))) {
+				afx_hdl->peer_chan = be16_to_cpu(rxframe->chanspec);
+				inff_dbg(INFO, "GON request: Peer found, chanspec=0x%04x\n",
+					 afx_hdl->peer_chan);
+				complete(&afx_hdl->act_frm_scan);
+			}
+			return 0;
+		}
+		/* After complete GO Negotiation, roll back to mpc mode */
+		if (action == P2P_PAF_GON_CONF ||
+		    action == P2P_PAF_PROVDIS_RSP)
+			inff_set_mpc(ifp, 1);
+		if (action == P2P_PAF_GON_CONF) {
+			inff_dbg(TRACE, "P2P: GO_NEG_PHASE status cleared\n");
+			clear_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
+		}
+	} else if (inff_p2p_is_gas_action(frame, mgmt_frame_len)) {
+		sd_act_frm = (struct inff_p2psd_gas_pub_act_frame *)frame;
+		action = sd_act_frm->action;
+	}
+
+	if (test_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME, &p2p->status) &&
+	    p2p->next_af_subtype == action) {
+		inff_dbg(TRACE, "We got a right next frame! (%d)\n", action);
+		clear_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME,
+			  &p2p->status);
+		/* Stop waiting for next AF. */
+		inff_p2p_stop_wait_next_action_frame(cfg);
+	}
+
+	mgmt_frame = kzalloc(offsetof(struct ieee80211_mgmt, u) +
+			     mgmt_frame_len, GFP_KERNEL);
+	if (!mgmt_frame)
+		return -ENOMEM;
+
+	memcpy(mgmt_frame->da, ifp->mac_addr, ETH_ALEN);
+	inff_fil_cmd_data_get(ifp, INFF_C_GET_BSSID, mgmt_frame->bssid,
+			      ETH_ALEN);
+	memcpy(mgmt_frame->sa, e->addr, ETH_ALEN);
+	mgmt_frame->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
+	memcpy(mgmt_frame->u.body, frame, mgmt_frame_len);
+	mgmt_frame_len += offsetof(struct ieee80211_mgmt, u.body);
+
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
+					      inff_d11_chan_band_to_nl80211(ch.band));
+
+	wdev = &ifp->vif->wdev;
+	cfg80211_rx_mgmt(wdev, freq, 0, (u8 *)mgmt_frame, mgmt_frame_len, 0);
+
+	kfree(mgmt_frame);
+	return 0;
+}
+
+/**
+ * inff_p2p_notify_action_tx_complete() - transmit action frame complete
+ *
+ * @ifp: interfac control.
+ * @e: event message. Not used, to make it usable for fweh event dispatcher.
+ * @data: not used.
+ *
+ */
+int inff_p2p_notify_action_tx_complete(struct inff_if *ifp,
+				       const struct inff_event_msg *e,
+					void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_p2p_info *p2p = &cfg->p2p;
+
+	inff_dbg(INFO, "Enter: event %s, status=%d\n",
+		 e->event_code == INFF_E_ACTION_FRAME_OFF_CHAN_COMPLETE ?
+		 "ACTION_FRAME_OFF_CHAN_COMPLETE" : "ACTION_FRAME_COMPLETE",
+		 e->status);
+
+	if (!test_bit(INFF_P2P_STATUS_SENDING_ACT_FRAME, &p2p->status))
+		return 0;
+
+	if (e->event_code == INFF_E_ACTION_FRAME_COMPLETE) {
+		if (e->status == INFF_E_STATUS_SUCCESS) {
+			set_bit(INFF_P2P_STATUS_ACTION_TX_COMPLETED,
+				&p2p->status);
+			if (!p2p->wait_for_offchan_complete)
+				complete(&p2p->send_af_done);
+		} else {
+			set_bit(INFF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
+			/* If there is no ack, we don't need to wait for
+			 * WLC_E_ACTION_FRAME_OFFCHAN_COMPLETE event
+			 */
+			inff_p2p_stop_wait_next_action_frame(cfg);
+		}
+
+	} else {
+		complete(&p2p->send_af_done);
+	}
+	return 0;
+}
+
+/**
+ * inff_p2p_tx_action_frame() - send action frame over fil.
+ *
+ * @p2p: p2p info struct for vif.
+ * @vif: vif to send.
+ * @af_params: action frame data/info.
+ * @band: nl80211 band info.
+ *
+ * Send an action frame immediately without doing channel synchronization.
+ *
+ * This function waits for a completion event before returning.
+ * The WLC_E_ACTION_FRAME_COMPLETE event will be received when the action
+ * frame is transmitted.
+ */
+static s32 inff_p2p_tx_action_frame(struct inff_p2p_info *p2p,
+				    struct inff_cfg80211_vif *vif,
+				    struct inff_fil_af_params_le *af_params,
+				    u8 band)
+{
+	struct inff_pub *drvr = p2p->cfg->pub;
+	s32 err = 0;
+	struct inff_fil_af_params_v2_le *af_params_v2;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	reinit_completion(&p2p->send_af_done);
+	clear_bit(INFF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
+	clear_bit(INFF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
+
+	if (drvr->wlc_ver.wlc_ver_major == INFF_AF_PARAM_V2_FW_MAJOR &&
+	    drvr->wlc_ver.wlc_ver_minor >= INFF_AF_PARAM_V2_FW_MINOR) {
+		af_params_v2 = kzalloc(sizeof(*af_params_v2), GFP_KERNEL);
+		if (!af_params_v2) {
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		/* set actframe iovar with af_params_v2 */
+		af_params_v2->band = nl80211_band_to_fwil(band);
+		af_params_v2->channel = af_params->channel;
+		af_params_v2->dwell_time = af_params->dwell_time;
+		memcpy(af_params_v2->bssid, af_params->bssid, ETH_ALEN);
+		memcpy(&af_params_v2->action_frame, &af_params->action_frame,
+		       sizeof(af_params_v2->action_frame));
+
+		err = inff_fil_bsscfg_data_set(vif->ifp, "actframe", af_params_v2,
+					       sizeof(*af_params_v2));
+		kfree(af_params_v2);
+	} else {
+		/* set actframe iovar with af_params */
+		err = inff_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
+					       sizeof(*af_params));
+	}
+
+	if (err) {
+		iphy_err(drvr, " sending action frame has failed\n");
+		goto exit;
+	}
+
+	p2p->af_sent_channel = le32_to_cpu(af_params->channel);
+	p2p->af_tx_sent_jiffies = jiffies;
+
+	if (test_bit(INFF_P2P_STATUS_DISCOVER_LISTEN, &p2p->status) &&
+	    p2p->af_sent_channel ==
+	    ieee80211_frequency_to_channel(p2p->remain_on_channel.center_freq))
+		p2p->wait_for_offchan_complete = false;
+	else
+		p2p->wait_for_offchan_complete = true;
+
+	inff_dbg(TRACE, "Waiting for %s tx completion event\n",
+		 (p2p->wait_for_offchan_complete) ?
+		 "off-channel" : "on-channel");
+
+	wait_for_completion_timeout(&p2p->send_af_done, P2P_AF_MAX_WAIT_TIME);
+
+	if (test_bit(INFF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status)) {
+		inff_dbg(TRACE, "TX action frame operation is success\n");
+	} else {
+		err = -EIO;
+		inff_dbg(TRACE, "TX action frame operation has failed\n");
+	}
+	/* clear status bit for action tx */
+	clear_bit(INFF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
+	clear_bit(INFF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
+
+exit:
+	return err;
+}
+
+/**
+ * inff_p2p_pub_af_tx() - public action frame tx routine.
+ *
+ * @cfg: driver private data for cfg80211 interface.
+ * @af_params: action frame data/info.
+ * @config_af_params: configuration data for action frame.
+ *
+ * routine which transmits ation frame public type.
+ */
+static s32 inff_p2p_pub_af_tx(struct inff_cfg80211_info *cfg,
+			      struct inff_fil_af_params_le *af_params,
+			       struct inff_config_af_params *config_af_params)
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_fil_action_frame_le *action_frame;
+	struct inff_p2p_pub_act_frame *act_frm;
+	s32 err = 0;
+	u16 ie_len;
+
+	action_frame = &af_params->action_frame;
+	act_frm = (struct inff_p2p_pub_act_frame *)(action_frame->data);
+
+	config_af_params->extra_listen = true;
+
+	switch (act_frm->subtype) {
+	case P2P_PAF_GON_REQ:
+		inff_dbg(TRACE, "P2P: GO_NEG_PHASE status set\n");
+		set_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
+		config_af_params->mpc_onoff = 0;
+		config_af_params->search_channel = true;
+		p2p->next_af_subtype = act_frm->subtype + 1;
+		p2p->gon_req_action = true;
+		/* increase dwell time to wait for RESP frame */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MED_DWELL_TIME);
+		break;
+	case P2P_PAF_GON_RSP:
+		p2p->next_af_subtype = act_frm->subtype + 1;
+		/* increase dwell time to wait for CONF frame */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MED_DWELL_TIME);
+		break;
+	case P2P_PAF_GON_CONF:
+		/* If we reached till GO Neg confirmation reset the filter */
+		inff_dbg(TRACE, "P2P: GO_NEG_PHASE status cleared\n");
+		clear_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
+		/* turn on mpc again if go nego is done */
+		config_af_params->mpc_onoff = 1;
+		/* minimize dwell time */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MIN_DWELL_TIME);
+		config_af_params->extra_listen = false;
+		break;
+	case P2P_PAF_INVITE_REQ:
+		config_af_params->search_channel = true;
+		p2p->next_af_subtype = act_frm->subtype + 1;
+		/* increase dwell time */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MED_DWELL_TIME);
+		break;
+	case P2P_PAF_INVITE_RSP:
+		/* minimize dwell time */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MIN_DWELL_TIME);
+		config_af_params->extra_listen = false;
+		break;
+	case P2P_PAF_DEVDIS_REQ:
+		config_af_params->search_channel = true;
+		p2p->next_af_subtype = act_frm->subtype + 1;
+		/* maximize dwell time to wait for RESP frame */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_LONG_DWELL_TIME);
+		break;
+	case P2P_PAF_DEVDIS_RSP:
+		/* minimize dwell time */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MIN_DWELL_TIME);
+		config_af_params->extra_listen = false;
+		break;
+	case P2P_PAF_PROVDIS_REQ:
+		ie_len = le16_to_cpu(action_frame->len) -
+			 offsetof(struct inff_p2p_pub_act_frame, elts);
+		if (cfg80211_get_p2p_attr(&act_frm->elts[0], ie_len,
+					  IEEE80211_P2P_ATTR_GROUP_ID,
+					  NULL, 0) < 0)
+			config_af_params->search_channel = true;
+		config_af_params->mpc_onoff = 0;
+		p2p->next_af_subtype = act_frm->subtype + 1;
+		/* increase dwell time to wait for RESP frame */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MED_DWELL_TIME);
+		break;
+	case P2P_PAF_PROVDIS_RSP:
+		/* wpa_supplicant send go nego req right after prov disc */
+		p2p->next_af_subtype = P2P_PAF_GON_REQ;
+		/* increase dwell time to MED level */
+		af_params->dwell_time = cpu_to_le32(P2P_AF_MED_DWELL_TIME);
+		config_af_params->extra_listen = false;
+		break;
+	default:
+		iphy_err(drvr, "Unknown p2p pub act frame subtype: %d\n",
+			 act_frm->subtype);
+		err = -EINVAL;
+	}
+	return err;
+}
+
+static bool inff_p2p_check_dwell_overflow(u32 requested_dwell,
+					  unsigned long dwell_jiffies)
+{
+	if ((requested_dwell & CUSTOM_RETRY_MASK) &&
+	    (jiffies_to_msecs(jiffies - dwell_jiffies) >
+	    (requested_dwell & ~CUSTOM_RETRY_MASK))) {
+		inff_err("Action frame TX retry time over dwell time!\n");
+		return true;
+	}
+	return false;
+}
+
+/**
+ * inff_p2p_send_action_frame() - send action frame .
+ *
+ * @cfg: driver private data for cfg80211 interface.
+ * @ndev: net device to transmit on.
+ * @af_params: configuration data for action frame.
+ * @vif: virtual interface to send
+ */
+bool inff_p2p_send_action_frame(struct inff_cfg80211_info *cfg,
+				struct net_device *ndev,
+				struct inff_fil_af_params_le *af_params,
+				struct inff_cfg80211_vif *vif,
+				struct ieee80211_channel *peer_listen_chan)
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_fil_action_frame_le *action_frame;
+	struct inff_config_af_params config_af_params;
+	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_chan ch;
+	u16 action_frame_len;
+	bool ack = false;
+	u8 category;
+	u8 action;
+	s32 tx_retry;
+	s32 extra_listen_time;
+	uint delta_ms;
+	unsigned long dwell_jiffies = 0;
+	bool dwell_overflow = false;
+	u32 requested_dwell = le32_to_cpu(af_params->dwell_time);
+
+	action_frame = &af_params->action_frame;
+	action_frame_len = le16_to_cpu(action_frame->len);
+
+	inff_p2p_print_actframe(true, action_frame->data, action_frame_len);
+
+	/* Add the default dwell time. Dwell time to stay off-channel */
+	/* to wait for a response action frame after transmitting an  */
+	/* GO Negotiation action frame                                */
+	af_params->dwell_time = cpu_to_le32(P2P_AF_DWELL_TIME);
+
+	category = action_frame->data[DOT11_ACTION_CAT_OFF];
+	action = action_frame->data[DOT11_ACTION_ACT_OFF];
+
+	/* initialize variables */
+	p2p->next_af_subtype = P2P_PAF_SUBTYPE_INVALID;
+	p2p->gon_req_action = false;
+
+	/* config parameters */
+	config_af_params.mpc_onoff = -1;
+	config_af_params.search_channel = false;
+	config_af_params.extra_listen = false;
+
+	if (inff_p2p_is_pub_action(action_frame->data, action_frame_len)) {
+		/* p2p public action frame process */
+		if (inff_p2p_pub_af_tx(cfg, af_params, &config_af_params)) {
+			/* Just send unknown subtype frame with */
+			/* default parameters.                  */
+			iphy_err(drvr, "P2P Public action frame, unknown subtype.\n");
+		}
+	} else if (inff_p2p_is_gas_action(action_frame->data,
+					   action_frame_len)) {
+		/* service discovery process */
+		if (action == P2PSD_ACTION_ID_GAS_IREQ ||
+		    action == P2PSD_ACTION_ID_GAS_CREQ) {
+			/* configure service discovery query frame */
+			config_af_params.search_channel = true;
+
+			/* save next af suptype to cancel */
+			/* remaining dwell time           */
+			p2p->next_af_subtype = action + 1;
+
+			af_params->dwell_time =
+				cpu_to_le32(P2P_AF_MED_DWELL_TIME);
+		} else if (action == P2PSD_ACTION_ID_GAS_IRESP ||
+			   action == P2PSD_ACTION_ID_GAS_CRESP) {
+			/* configure service discovery response frame */
+			af_params->dwell_time =
+				cpu_to_le32(P2P_AF_MIN_DWELL_TIME);
+		} else {
+			iphy_err(drvr, "Unknown action type: %d\n", action);
+			goto exit;
+		}
+	} else if (inff_p2p_is_p2p_action(action_frame->data,
+					   action_frame_len) ||
+		   inff_p2p_is_dpp_pub_action(action_frame->data,
+					      action_frame_len)) {
+		/* do not configure anything. it will be */
+		/* sent with a default configuration     */
+	} else {
+		iphy_err(drvr, "Unknown Frame: category 0x%x, action 0x%x\n",
+			 category, action);
+		return false;
+	}
+
+	/* if connecting on primary iface, sleep for a while before sending
+	 * af tx for VSDB
+	 */
+	if (test_bit(INFF_VIF_STATUS_CONNECTING,
+		     &p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->sme_state))
+		msleep(50);
+
+	/* if scan is ongoing, abort current scan. */
+	if (test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status))
+		inff_abort_scanning(cfg);
+
+	memcpy(afx_hdl->tx_dst_addr, action_frame->da, ETH_ALEN);
+
+	/* To make sure to send successfully action frame, turn off mpc */
+	if (config_af_params.mpc_onoff == 0)
+		inff_set_mpc(ifp, 0);
+
+	/* set status and destination address before sending af */
+	if (p2p->next_af_subtype != P2P_PAF_SUBTYPE_INVALID) {
+		/* set status to cancel the remained dwell time in rx process */
+		set_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME, &p2p->status);
+	}
+
+	p2p->af_sent_channel = 0;
+	set_bit(INFF_P2P_STATUS_SENDING_ACT_FRAME, &p2p->status);
+	/* validate channel and p2p ies */
+	if (config_af_params.search_channel &&
+	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
+		afx_hdl = &p2p->afx_hdl;
+		afx_hdl->peer_listen_chan = channel_to_chanspec(&cfg->d11inf, peer_listen_chan);
+
+		if (inff_p2p_af_searching_channel(p2p) ==
+							P2P_INVALID_CHANSPEC) {
+			iphy_err(drvr, "Couldn't find peer's channel.\n");
+			goto exit;
+		}
+
+		/* Abort scan even for VSDB scenarios. Scan gets aborted in
+		 * firmware but after the check of piggyback algorithm. To take
+		 * care of current piggback algo, lets abort the scan here
+		 * itself.
+		 */
+		inff_notify_escan_complete(cfg, ifp, true, true);
+
+		/* update channel */
+		ch.chspec = afx_hdl->peer_chan;
+		cfg->d11inf.decchspec(&ch);
+		af_params->channel = cpu_to_le32(ch.control_ch_num);
+	}
+	dwell_jiffies = jiffies;
+	dwell_overflow = inff_p2p_check_dwell_overflow(requested_dwell,
+						       dwell_jiffies);
+
+	tx_retry = 0;
+	while (!p2p->block_gon_req_tx &&
+	       (!ack) && (tx_retry < P2P_AF_TX_MAX_RETRY) &&
+		!dwell_overflow) {
+		if (af_params->channel)
+			msleep(P2P_AF_RETRY_DELAY_TIME);
+
+		ack = !inff_p2p_tx_action_frame(p2p, vif, af_params, peer_listen_chan->band);
+		tx_retry++;
+		dwell_overflow = inff_p2p_check_dwell_overflow(requested_dwell,
+							       dwell_jiffies);
+	}
+	if (!ack) {
+		iphy_err(drvr, "Failed to send Action Frame(retry %d)\n",
+			 tx_retry);
+		clear_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
+	}
+
+exit:
+	clear_bit(INFF_P2P_STATUS_SENDING_ACT_FRAME, &p2p->status);
+
+	/* WAR: sometimes dongle does not keep the dwell time of 'actframe'.
+	 * if we coundn't get the next action response frame and dongle does
+	 * not keep the dwell time, go to listen state again to get next action
+	 * response frame.
+	 */
+	ch.chspec = afx_hdl->my_listen_chan;
+	cfg->d11inf.decchspec(&ch);
+	if (ack && config_af_params.extra_listen && !p2p->block_gon_req_tx &&
+	    test_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME, &p2p->status) &&
+	    p2p->af_sent_channel == ch.control_ch_num) {
+		delta_ms = jiffies_to_msecs(jiffies - p2p->af_tx_sent_jiffies);
+		if (le32_to_cpu(af_params->dwell_time) > delta_ms)
+			extra_listen_time = le32_to_cpu(af_params->dwell_time) -
+					    delta_ms;
+		else
+			extra_listen_time = 0;
+		if (extra_listen_time > 50) {
+			set_bit(INFF_P2P_STATUS_WAITING_NEXT_AF_LISTEN,
+				&p2p->status);
+			inff_dbg(INFO, "Wait more time! actual af time:%d, calculated extra listen:%d\n",
+				 le32_to_cpu(af_params->dwell_time),
+				 extra_listen_time);
+			extra_listen_time += 100;
+			if (!inff_p2p_discover_listen(p2p,
+						      afx_hdl->my_listen_chan,
+						      extra_listen_time)) {
+				unsigned long duration;
+
+				extra_listen_time += 100;
+				duration = msecs_to_jiffies(extra_listen_time);
+				wait_for_completion_timeout(&p2p->wait_next_af,
+							    duration);
+			}
+			clear_bit(INFF_P2P_STATUS_WAITING_NEXT_AF_LISTEN,
+				  &p2p->status);
+		}
+	}
+
+	if (p2p->block_gon_req_tx) {
+		/* if ack is true, supplicant will wait more time(100ms).
+		 * so we will return it as a success to get more time .
+		 */
+		p2p->block_gon_req_tx = false;
+		ack = true;
+	}
+
+	clear_bit(INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME, &p2p->status);
+	/* if all done, turn mpc on again */
+	if (config_af_params.mpc_onoff == 1)
+		inff_set_mpc(ifp, 1);
+
+	return ack;
+}
+
+/**
+ * inff_p2p_notify_rx_mgmt_p2p_probereq() - Event handler for p2p probe req.
+ *
+ * @ifp: interface pointer for which event was received.
+ * @e: even message.
+ * @data: payload of event message (probe request).
+ */
+s32 inff_p2p_notify_rx_mgmt_p2p_probereq(struct inff_if *ifp,
+					 const struct inff_event_msg *e,
+					  void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	struct inff_rx_mgmt_data *rxframe = (struct inff_rx_mgmt_data *)data;
+	struct inff_chan ch;
+	u8 *mgmt_frame;
+	u32 mgmt_frame_len;
+	s32 freq;
+	u16 mgmt_type;
+
+	inff_dbg(INFO, "Enter: event %d reason %d\n", e->event_code,
+		 e->reason);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		inff_dbg(SCAN, "Event data too small. Ignore\n");
+		return 0;
+	}
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	cfg->d11inf.decchspec(&ch);
+
+	if (test_bit(INFF_P2P_STATUS_FINDING_COMMON_CHANNEL, &p2p->status) &&
+	    (ether_addr_equal(afx_hdl->tx_dst_addr, e->addr))) {
+		afx_hdl->peer_chan = be16_to_cpu(rxframe->chanspec);
+		inff_dbg(INFO, "PROBE REQUEST: Peer found, chanspec=0x%04x\n",
+			 afx_hdl->peer_chan);
+		complete(&afx_hdl->act_frm_scan);
+	}
+
+	/* Firmware sends us two proberesponses for each idx one. At the */
+	/* moment anything but bsscfgidx 0 is passed up to supplicant    */
+	if (e->bsscfgidx == 0)
+		return 0;
+
+	/* Filter any P2P probe reqs arriving during the GO-NEG Phase */
+	if (test_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status)) {
+		inff_dbg(INFO, "Filtering P2P probe_req in GO-NEG phase\n");
+		return 0;
+	}
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
+					      inff_d11_chan_band_to_nl80211(ch.band));
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
+ * inff_p2p_get_current_chanspec() - Get current operation channel.
+ *
+ * @p2p: P2P specific data.
+ * @chanspec: chanspec to be returned.
+ */
+static void inff_p2p_get_current_chanspec(struct inff_p2p_info *p2p,
+					  u16 *chanspec)
+{
+	struct inff_if *ifp;
+	u8 mac_addr[ETH_ALEN];
+	struct inff_chan ch;
+	struct inff_bss_info_le *bi;
+	u8 *buf;
+
+	ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
+
+	if (inff_fil_cmd_data_get(ifp, INFF_C_GET_BSSID, mac_addr,
+				  ETH_ALEN) == 0) {
+		buf = kzalloc(WL_BSS_INFO_MAX, GFP_KERNEL);
+		if (buf) {
+			*(__le32 *)buf = cpu_to_le32(WL_BSS_INFO_MAX);
+			if (inff_fil_cmd_data_get(ifp, INFF_C_GET_BSS_INFO,
+						  buf, WL_BSS_INFO_MAX) == 0) {
+				bi = (struct inff_bss_info_le *)(buf + 4);
+				*chanspec = le16_to_cpu(bi->chanspec);
+				kfree(buf);
+				return;
+			}
+			kfree(buf);
+		}
+	}
+	/* Use default channel for P2P */
+	ch.band = INFF_CHAN_BAND_2G;
+	ch.chnum = INFF_P2P_TEMP_CHAN;
+	ch.bw = INFF_CHAN_BW_20;
+	p2p->cfg->d11inf.encchspec(&ch);
+	*chanspec = ch.chspec;
+}
+
+/**
+ * inff_p2p_ifchange - Change a P2P Role.
+ * @cfg: driver private data for cfg80211 interface.
+ * @if_type: interface type.
+ * Returns 0 if success.
+ */
+int inff_p2p_ifchange(struct inff_cfg80211_info *cfg,
+		      enum inff_fil_p2p_if_types if_type)
+{
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_vif *vif;
+	struct inff_fil_p2p_if_le if_request;
+	s32 err;
+	u16 chanspec;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+	if (!vif) {
+		iphy_err(drvr, "vif for P2PAPI_BSSCFG_PRIMARY does not exist\n");
+		return -EPERM;
+	}
+	inff_notify_escan_complete(cfg, vif->ifp, true, true);
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
+	if (!vif) {
+		iphy_err(drvr, "vif for P2PAPI_BSSCFG_CONNECTION does not exist\n");
+		return -EPERM;
+	}
+	inff_set_mpc(vif->ifp, 0);
+
+	/* In concurrency case, STA may be already associated in a particular */
+	/* channel. so retrieve the current channel of primary interface and  */
+	/* then start the virtual interface on that.                          */
+	inff_p2p_get_current_chanspec(p2p, &chanspec);
+
+	if_request.type = cpu_to_le16((u16)if_type);
+	if_request.chspec = cpu_to_le16(chanspec);
+	memcpy(if_request.addr, p2p->conn_int_addr, sizeof(if_request.addr));
+
+	inff_cfg80211_arm_vif_event(cfg, vif);
+	err = inff_fil_iovar_data_set(vif->ifp, "p2p_ifupd", &if_request,
+				      sizeof(if_request));
+	if (err) {
+		iphy_err(drvr, "p2p_ifupd FAILED, err=%d\n", err);
+		inff_cfg80211_arm_vif_event(cfg, NULL);
+		return err;
+	}
+	err = inff_cfg80211_wait_vif_event(cfg, INFF_E_IF_CHANGE,
+					   INFF_VIF_EVENT_TIMEOUT);
+	inff_cfg80211_arm_vif_event(cfg, NULL);
+	if (!err)  {
+		iphy_err(drvr, "No INFF_E_IF_CHANGE event received\n");
+		return -EIO;
+	}
+
+	err = inff_fil_cmd_int_set(vif->ifp, INFF_C_SET_SCB_TIMEOUT,
+				   INFF_SCB_TIMEOUT_VALUE);
+
+	return err;
+}
+
+static int inff_p2p_request_p2p_if(struct inff_p2p_info *p2p,
+				   struct inff_if *ifp, u8 ea[ETH_ALEN],
+				    enum inff_fil_p2p_if_types iftype)
+{
+	struct inff_fil_p2p_if_le if_request;
+	int err;
+	u16 chanspec;
+
+	/* we need a default channel */
+	inff_p2p_get_current_chanspec(p2p, &chanspec);
+
+	/* fill the firmware request */
+	memcpy(if_request.addr, ea, ETH_ALEN);
+	if_request.type = cpu_to_le16((u16)iftype);
+	if_request.chspec = cpu_to_le16(chanspec);
+
+	err = inff_fil_iovar_data_set(ifp, "p2p_ifadd", &if_request,
+				      sizeof(if_request));
+
+	return err;
+}
+
+static int inff_p2p_disable_p2p_if(struct inff_cfg80211_vif *vif)
+{
+	struct inff_cfg80211_info *cfg = wdev_to_cfg(&vif->wdev);
+	struct net_device *pri_ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(pri_ndev);
+	const u8 *addr = vif->wdev.netdev->dev_addr;
+
+	return inff_fil_iovar_data_set(ifp, "p2p_ifdis", addr, ETH_ALEN);
+}
+
+static int inff_p2p_release_p2p_if(struct inff_cfg80211_vif *vif)
+{
+	struct inff_cfg80211_info *cfg = wdev_to_cfg(&vif->wdev);
+	struct net_device *pri_ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(pri_ndev);
+	const u8 *addr = vif->wdev.netdev->dev_addr;
+
+	return inff_fil_iovar_data_set(ifp, "p2p_ifdel", addr, ETH_ALEN);
+}
+
+/**
+ * inff_p2p_create_p2pdev() - create a P2P_DEVICE virtual interface.
+ *
+ * @p2p: P2P specific data.
+ * @wiphy: wiphy device of new interface.
+ * @addr: mac address for this new interface.
+ */
+static struct wireless_dev *inff_p2p_create_p2pdev(struct inff_p2p_info *p2p,
+						   struct wiphy *wiphy,
+						   u8 *addr)
+{
+	struct inff_pub *drvr = p2p->cfg->pub;
+	struct inff_cfg80211_vif *p2p_vif;
+	struct inff_if *p2p_ifp;
+	struct inff_if *pri_ifp;
+	int err;
+	u32 bsscfgidx;
+
+	if (p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+		return ERR_PTR(-ENOSPC);
+
+	p2p_vif = inff_alloc_vif(p2p->cfg, NL80211_IFTYPE_P2P_DEVICE);
+	if (IS_ERR(p2p_vif)) {
+		iphy_err(drvr, "could not create discovery vif\n");
+		return (struct wireless_dev *)p2p_vif;
+	}
+
+	pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
+
+	/* firmware requires unique mac address for p2pdev interface */
+	if (addr && ether_addr_equal(addr, pri_ifp->mac_addr)) {
+		iphy_err(drvr, "discovery vif must be different from primary interface\n");
+		err = -EINVAL;
+		goto fail;
+	}
+
+	inff_p2p_generate_bss_mac(p2p, addr);
+	inff_p2p_set_firmware(pri_ifp, p2p->dev_addr);
+
+	inff_cfg80211_arm_vif_event(p2p->cfg, p2p_vif);
+	inff_fweh_p2pdev_setup(pri_ifp, true);
+
+	/* Initialize P2P Discovery in the firmware */
+	err = inff_fil_iovar_int_set(pri_ifp, "p2p_disc", 1);
+	if (err < 0) {
+		iphy_err(drvr, "set p2p_disc error\n");
+		inff_fweh_p2pdev_setup(pri_ifp, false);
+		inff_cfg80211_arm_vif_event(p2p->cfg, NULL);
+		goto fail;
+	}
+
+	/* wait for firmware event */
+	err = inff_cfg80211_wait_vif_event(p2p->cfg, INFF_E_IF_ADD,
+					   INFF_VIF_EVENT_TIMEOUT);
+	inff_cfg80211_arm_vif_event(p2p->cfg, NULL);
+	inff_fweh_p2pdev_setup(pri_ifp, false);
+	if (!err) {
+		iphy_err(drvr, "timeout occurred\n");
+		err = -EIO;
+		goto fail;
+	}
+
+	/* discovery interface created */
+	p2p_ifp = p2p_vif->ifp;
+	p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif = p2p_vif;
+	memcpy(p2p_ifp->mac_addr, p2p->dev_addr, ETH_ALEN);
+	memcpy(&p2p_vif->wdev.address, p2p->dev_addr, sizeof(p2p->dev_addr));
+
+	/* verify bsscfg index for P2P discovery */
+	err = inff_fil_iovar_int_get(pri_ifp, "p2p_dev", &bsscfgidx);
+	if (err < 0) {
+		iphy_err(drvr, "retrieving discover bsscfg index failed\n");
+		goto fail;
+	}
+
+	WARN_ON(p2p_ifp->bsscfgidx != bsscfgidx);
+
+	init_completion(&p2p->send_af_done);
+	INIT_WORK(&p2p->afx_hdl.afx_work, inff_p2p_afx_handler);
+	init_completion(&p2p->afx_hdl.act_frm_scan);
+	init_completion(&p2p->wait_next_af);
+
+	return &p2p_vif->wdev;
+
+fail:
+	inff_free_vif(p2p_vif);
+	return ERR_PTR(err);
+}
+
+static int inff_p2p_get_conn_idx(struct inff_cfg80211_info *cfg)
+{
+	int i;
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+
+	if (!ifp)
+		return -ENODEV;
+
+	for (i = P2PAPI_BSSCFG_CONNECTION; i < P2PAPI_BSSCFG_MAX; i++) {
+		if (!cfg->p2p.bss_idx[i].vif) {
+			if (i == P2PAPI_BSSCFG_CONNECTION2 &&
+			    !(inff_feat_is_enabled(ifp, INFF_FEAT_RSDB))) {
+				inff_err("Multi p2p not supported");
+				return -EIO;
+			}
+			return i;
+		}
+	}
+	return -EIO;
+}
+
+/**
+ * inff_p2p_add_vif() - create a new P2P virtual interface.
+ *
+ * @wiphy: wiphy device of new interface.
+ * @name: name of the new interface.
+ * @name_assign_type: origin of the interface name
+ * @type: nl80211 interface type.
+ * @params: contains mac address for P2P device.
+ */
+struct wireless_dev *inff_p2p_add_vif(struct wiphy *wiphy, const char *name,
+				      unsigned char name_assign_type,
+				      enum nl80211_iftype type,
+				      struct vif_params *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_vif *vif;
+	enum inff_fil_p2p_if_types iftype;
+	int err = 0;
+	int connidx;
+	u8 *p2p_intf_addr;
+
+	if (inff_cfg80211_vif_event_armed(cfg))
+		return ERR_PTR(-EBUSY);
+
+	inff_dbg(INFO, "adding vif \"%s\" (type=%d)\n", name, type);
+
+	switch (type) {
+	case NL80211_IFTYPE_P2P_CLIENT:
+		iftype = INFF_FIL_P2P_IF_CLIENT;
+		break;
+	case NL80211_IFTYPE_P2P_GO:
+		iftype = INFF_FIL_P2P_IF_GO;
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		return inff_p2p_create_p2pdev(&cfg->p2p, wiphy,
+					       params->macaddr);
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	vif = inff_alloc_vif(cfg, type);
+	if (IS_ERR(vif))
+		return (struct wireless_dev *)vif;
+	inff_cfg80211_arm_vif_event(cfg, vif);
+
+	connidx = inff_p2p_get_conn_idx(cfg);
+
+	if (connidx == P2PAPI_BSSCFG_CONNECTION)
+		p2p_intf_addr = cfg->p2p.conn_int_addr;
+	else if (connidx == P2PAPI_BSSCFG_CONNECTION2)
+		p2p_intf_addr = cfg->p2p.conn2_int_addr;
+	else
+		err = -EINVAL;
+
+	if (!err)
+		err =  inff_p2p_request_p2p_if(&cfg->p2p, ifp,
+					       p2p_intf_addr, iftype);
+
+	if (err) {
+		inff_err("request p2p interface failed\n");
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
+	ifp->ndev->name_assign_type = name_assign_type;
+	err = inff_net_attach(ifp, true);
+	if (err) {
+		iphy_err(drvr, "Registering netdevice failed\n");
+		free_netdev(ifp->ndev);
+		goto fail;
+	}
+
+	cfg->p2p.bss_idx[connidx].vif = vif;
+	/* Disable firmware roaming for P2P interface  */
+	inff_fil_iovar_int_set(ifp, "roam_off", 1);
+	if (iftype == INFF_FIL_P2P_IF_GO) {
+		/* set station timeout for p2p */
+		inff_fil_cmd_int_set(ifp, INFF_C_SET_SCB_TIMEOUT,
+				     INFF_SCB_TIMEOUT_VALUE);
+	}
+	return &ifp->vif->wdev;
+
+fail:
+	inff_free_vif(vif);
+	return ERR_PTR(err);
+}
+
+/**
+ * inff_p2p_del_vif() - delete a P2P virtual interface.
+ *
+ * @wiphy: wiphy device of interface.
+ * @wdev: wireless device of interface.
+ */
+int inff_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_cfg80211_vif *vif;
+	enum nl80211_iftype iftype;
+	bool wait_for_disable = false;
+	int err;
+
+	inff_dbg(TRACE, "delete P2P vif\n");
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+
+	iftype = vif->wdev.iftype;
+	inff_cfg80211_arm_vif_event(cfg, vif);
+	switch (iftype) {
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (test_bit(INFF_VIF_STATUS_DISCONNECTING, &vif->sme_state))
+			wait_for_disable = true;
+		break;
+
+	case NL80211_IFTYPE_P2P_GO:
+		if (!inff_p2p_disable_p2p_if(vif))
+			wait_for_disable = true;
+		break;
+
+	case NL80211_IFTYPE_P2P_DEVICE:
+		if (!p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+			return 0;
+		inff_p2p_cancel_remain_on_channel(vif->ifp);
+		inff_p2p_deinit_discovery(p2p);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	clear_bit(INFF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
+	inff_dbg(INFO, "P2P: GO_NEG_PHASE status cleared\n");
+
+	if (wait_for_disable)
+		wait_for_completion_timeout(&cfg->vif_disabled,
+					    INFF_P2P_DISABLE_TIMEOUT);
+
+	err = 0;
+	if (iftype != NL80211_IFTYPE_P2P_DEVICE) {
+		inff_vif_clear_mgmt_ies(vif);
+		err = inff_p2p_release_p2p_if(vif);
+	}
+	if (!err) {
+		/* wait for firmware event */
+		err = inff_cfg80211_wait_vif_event(cfg, INFF_E_IF_DEL,
+						   INFF_VIF_EVENT_TIMEOUT);
+		if (!err)
+			err = -EIO;
+		else
+			err = 0;
+	}
+	inff_remove_interface(vif->ifp, true);
+
+	inff_cfg80211_arm_vif_event(cfg, NULL);
+	if (iftype != NL80211_IFTYPE_P2P_DEVICE) {
+		if (vif == p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif)
+			p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif = NULL;
+		if (vif == p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION2].vif)
+			p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION2].vif = NULL;
+	}
+
+	return err;
+}
+
+void inff_p2p_ifp_removed(struct inff_if *ifp, bool locked)
+{
+	struct inff_cfg80211_info *cfg;
+	struct inff_cfg80211_vif *vif;
+
+	inff_dbg(INFO, "P2P: device interface removed\n");
+	vif = ifp->vif;
+	cfg = wdev_to_cfg(&vif->wdev);
+	cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif = NULL;
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
+int inff_p2p_start_device(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_cfg80211_vif *vif;
+	int err;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	mutex_lock(&cfg->usr_sync);
+	err = inff_p2p_enable_discovery(p2p);
+	if (!err)
+		set_bit(INFF_VIF_STATUS_READY, &vif->sme_state);
+	mutex_unlock(&cfg->usr_sync);
+	return err;
+}
+
+void inff_p2p_stop_device(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+	struct inff_cfg80211_vif *vif;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	/* This call can be result of the unregister_wdev call. In that case
+	 * we dont want to do anything anymore. Just return. The config vif
+	 * will have been cleared at this point.
+	 */
+	if (p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif == vif) {
+		mutex_lock(&cfg->usr_sync);
+		/* Set the discovery state to SCAN */
+		(void)inff_p2p_set_discover_state(vif->ifp,
+						   WL_P2P_DISC_ST_SCAN, 0, 0);
+		inff_abort_scanning(cfg);
+		clear_bit(INFF_VIF_STATUS_READY, &vif->sme_state);
+		mutex_unlock(&cfg->usr_sync);
+	}
+}
+
+/**
+ * inff_p2p_attach() - attach for P2P.
+ *
+ * @cfg: driver private data for cfg80211 interface.
+ * @p2pdev_forced: create p2p device interface at attach.
+ */
+s32 inff_p2p_attach(struct inff_cfg80211_info *cfg, bool p2pdev_forced)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_p2p_info *p2p;
+	struct inff_if *pri_ifp;
+	s32 err = 0;
+	void *err_ptr;
+
+	p2p = &cfg->p2p;
+	p2p->cfg = cfg;
+
+	pri_ifp = inff_get_ifp(cfg->pub, 0);
+	p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif = pri_ifp->vif;
+	init_completion(&p2p->send_af_done);
+
+	if (p2pdev_forced) {
+		err_ptr = inff_p2p_create_p2pdev(p2p, NULL, NULL);
+		if (IS_ERR(err_ptr)) {
+			iphy_err(drvr, "P2P device creation failed.\n");
+			err = PTR_ERR(err_ptr);
+		}
+	} else {
+		p2p->p2pdev_dynamically = true;
+	}
+	return err;
+}
+
+/**
+ * inff_p2p_detach() - detach P2P.
+ *
+ * @p2p: P2P specific data.
+ */
+void inff_p2p_detach(struct inff_p2p_info *p2p)
+{
+	struct inff_cfg80211_vif *vif;
+
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	if (vif) {
+		inff_p2p_cancel_remain_on_channel(vif->ifp);
+		inff_p2p_deinit_discovery(p2p);
+		inff_remove_interface(vif->ifp, false);
+	}
+	/* just set it all to zero */
+	memset(p2p, 0, sizeof(*p2p));
+}
diff --git a/drivers/net/wireless/infineon/inffmac/p2p.h b/drivers/net/wireless/infineon/inffmac/p2p.h
new file mode 100644
index 000000000000..950d3e0419b3
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/p2p.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_P2P_H
+#define INFF_P2P_H
+
+#include <net/cfg80211.h>
+
+struct inff_cfg80211_info;
+
+/**
+ * enum p2p_bss_type - different type of BSS configurations.
+ *
+ * @P2PAPI_BSSCFG_PRIMARY: maps to driver's primary bsscfg.
+ * @P2PAPI_BSSCFG_DEVICE: maps to driver's P2P device discovery bsscfg.
+ * @P2PAPI_BSSCFG_CONNECTION: maps to driver's 1st P2P connection bsscfg.
+ * @P2PAPI_BSSCFG_CONNECTION2: maps to driver's 2nd P2P connection bsscfg.
+ * @P2PAPI_BSSCFG_MAX: used for range checking.
+ */
+enum p2p_bss_type {
+	P2PAPI_BSSCFG_PRIMARY, /* maps to driver's primary bsscfg */
+	P2PAPI_BSSCFG_DEVICE, /* maps to driver's P2P device discovery bsscfg */
+	P2PAPI_BSSCFG_CONNECTION, /* driver's 1st P2P connection bsscfg */
+	P2PAPI_BSSCFG_CONNECTION2, /* driver's 2nd P2P connection bsscfg */
+	P2PAPI_BSSCFG_MAX
+};
+
+/**
+ * struct p2p_bss - peer-to-peer bss related information.
+ *
+ * @vif: virtual interface of this P2P bss.
+ * @private_data: TBD
+ */
+struct p2p_bss {
+	struct inff_cfg80211_vif *vif;
+	void *private_data;
+};
+
+/**
+ * enum inff_p2p_status - P2P specific dongle status.
+ *
+ * @INFF_P2P_STATUS_IF_ADD: peer-to-peer vif add sent to dongle.
+ * @INFF_P2P_STATUS_IF_DEL: NOT-USED?
+ * @INFF_P2P_STATUS_IF_DELETING: peer-to-peer vif delete sent to dongle.
+ * @INFF_P2P_STATUS_IF_CHANGING: peer-to-peer vif change sent to dongle.
+ * @INFF_P2P_STATUS_IF_CHANGED: peer-to-peer vif change completed on dongle.
+ * @INFF_P2P_STATUS_ACTION_TX_COMPLETED: action frame tx completed.
+ * @INFF_P2P_STATUS_ACTION_TX_NOACK: action frame tx not acked.
+ * @INFF_P2P_STATUS_GO_NEG_PHASE: P2P GO negotiation ongoing.
+ * @INFF_P2P_STATUS_DISCOVER_LISTEN: P2P listen, remaining on channel.
+ * @INFF_P2P_STATUS_SENDING_ACT_FRAME: In the process of sending action frame.
+ * @INFF_P2P_STATUS_WAITING_NEXT_AF_LISTEN: extra listen time for af tx.
+ * @INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME: waiting for action frame response.
+ * @INFF_P2P_STATUS_FINDING_COMMON_CHANNEL: search channel for AF active.
+ */
+enum inff_p2p_status {
+	INFF_P2P_STATUS_ENABLED,
+	INFF_P2P_STATUS_IF_ADD,
+	INFF_P2P_STATUS_IF_DEL,
+	INFF_P2P_STATUS_IF_DELETING,
+	INFF_P2P_STATUS_IF_CHANGING,
+	INFF_P2P_STATUS_IF_CHANGED,
+	INFF_P2P_STATUS_ACTION_TX_COMPLETED,
+	INFF_P2P_STATUS_ACTION_TX_NOACK,
+	INFF_P2P_STATUS_GO_NEG_PHASE,
+	INFF_P2P_STATUS_DISCOVER_LISTEN,
+	INFF_P2P_STATUS_SENDING_ACT_FRAME,
+	INFF_P2P_STATUS_WAITING_NEXT_AF_LISTEN,
+	INFF_P2P_STATUS_WAITING_NEXT_ACT_FRAME,
+	INFF_P2P_STATUS_FINDING_COMMON_CHANNEL
+};
+
+/**
+ * struct afx_hdl - action frame off channel storage.
+ *
+ * @afx_work: worker thread for searching channel
+ * @act_frm_scan: thread synchronizing struct.
+ * @is_active: channel searching active.
+ * @peer_chan: current channel.
+ * @is_listen: sets mode for afx worker.
+ * @my_listen_chan: this peers listen channel.
+ * @peer_listen_chan: remote peers listen channel.
+ * @tx_dst_addr: mac address where tx af should be sent to.
+ */
+struct afx_hdl {
+	struct work_struct afx_work;
+	struct completion act_frm_scan;
+	bool is_active;
+	u16 peer_chan;
+	bool is_listen;
+	u16 my_listen_chan;
+	u16 peer_listen_chan;
+	u8 tx_dst_addr[ETH_ALEN];
+};
+
+/**
+ * struct inff_p2p_info - p2p specific driver information.
+ *
+ * @cfg: driver private data for cfg80211 interface.
+ * @status: status of P2P (see enum inff_p2p_status).
+ * @dev_addr: P2P device address.
+ * @int_addr: P2P interface address.
+ * @bss_idx: informate for P2P bss types.
+ * @listen_timer: timer for @WL_P2P_DISC_ST_LISTEN discover state.
+ * @listen_channel: channel for @WL_P2P_DISC_ST_LISTEN discover state.
+ * @remain_on_channel: contains copy of struct used by cfg80211.
+ * @remain_on_channel_cookie: cookie counter for remain on channel cmd
+ * @next_af_subtype: expected action frame subtype.
+ * @send_af_done: indication that action frame tx is complete.
+ * @afx_hdl: action frame search handler info.
+ * @af_sent_channel: channel action frame is sent.
+ * @af_tx_sent_jiffies: jiffies time when af tx was transmitted.
+ * @wait_next_af: thread synchronizing struct.
+ * @gon_req_action: about to send go negotiation requets frame.
+ * @block_gon_req_tx: drop tx go negotiation requets frame.
+ * @p2pdev_dynamically: is p2p device if created by module param or supplicant.
+ * @wait_for_offchan_complete: wait for off-channel tx completion event.
+ */
+struct inff_p2p_info {
+	struct inff_cfg80211_info *cfg;
+	unsigned long status;
+	u8 dev_addr[ETH_ALEN];
+	u8 conn_int_addr[ETH_ALEN];
+	u8 conn2_int_addr[ETH_ALEN];
+	struct p2p_bss bss_idx[P2PAPI_BSSCFG_MAX];
+	struct timer_list listen_timer;
+	u8 listen_channel;
+	struct ieee80211_channel remain_on_channel;
+	u32 remain_on_channel_cookie;
+	u8 next_af_subtype;
+	struct completion send_af_done;
+	struct afx_hdl afx_hdl;
+	u32 af_sent_channel;
+	unsigned long af_tx_sent_jiffies;
+	struct completion wait_next_af;
+	bool gon_req_action;
+	bool block_gon_req_tx;
+	bool p2pdev_dynamically;
+	bool wait_for_offchan_complete;
+	struct wireless_dev *remin_on_channel_wdev;
+};
+
+s32 inff_p2p_attach(struct inff_cfg80211_info *cfg, bool p2pdev_forced);
+void inff_p2p_detach(struct inff_p2p_info *p2p);
+struct wireless_dev *inff_p2p_add_vif(struct wiphy *wiphy, const char *name,
+				      unsigned char name_assign_type,
+				      enum nl80211_iftype type,
+				      struct vif_params *params);
+int inff_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev);
+int inff_p2p_ifchange(struct inff_cfg80211_info *cfg,
+		      enum inff_fil_p2p_if_types if_type);
+void inff_p2p_ifp_removed(struct inff_if *ifp, bool rtnl_locked);
+int inff_p2p_start_device(struct wiphy *wiphy, struct wireless_dev *wdev);
+void inff_p2p_stop_device(struct wiphy *wiphy, struct wireless_dev *wdev);
+int inff_p2p_scan_prep(struct wiphy *wiphy,
+		       struct cfg80211_scan_request *request,
+		       struct inff_cfg80211_vif *vif);
+int inff_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+			       struct ieee80211_channel *channel,
+			       unsigned int duration, u64 *cookie);
+int inff_p2p_notify_listen_complete(struct inff_if *ifp,
+				    const struct inff_event_msg *e,
+				    void *data);
+void inff_p2p_cancel_remain_on_channel(struct inff_if *ifp);
+int inff_p2p_notify_action_frame_rx(struct inff_if *ifp,
+				    const struct inff_event_msg *e,
+				    void *data);
+int inff_p2p_notify_action_tx_complete(struct inff_if *ifp,
+				       const struct inff_event_msg *e,
+				       void *data);
+bool inff_p2p_send_action_frame(struct inff_cfg80211_info *cfg,
+				struct net_device *ndev,
+				struct inff_fil_af_params_le *af_params,
+				struct inff_cfg80211_vif *vif,
+				struct ieee80211_channel *peer_listen_chan);
+bool inff_p2p_scan_finding_common_channel(struct inff_cfg80211_info *cfg,
+					  struct inff_bss_info_le *bi);
+s32 inff_p2p_notify_rx_mgmt_p2p_probereq(struct inff_if *ifp,
+					 const struct inff_event_msg *e,
+					 void *data);
+#endif /* INFF_P2P_H */
-- 
2.25.1


