Return-Path: <linux-wireless+bounces-27361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9DCB7D8BC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E2E484889
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405B303C93;
	Tue, 16 Sep 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="hi1ru2Y3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC22877C1
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061255; cv=none; b=HXORIuE1UjPGyab6Iqj6i2NUYX2L7zist/iW+AI1SI7djAz7R95GQ/T/gkCOqGT8V1xyRKSaNoWdSxQkvlB6/Xd6wphma9JYDwFzqSWeS94o6j6/NhJIl4Fn5g7pVtrWfrRwew2SJPtb0Ub77I67fE5V4FHHUSo/MLF/kpoKULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061255; c=relaxed/simple;
	bh=EKlOOJlBbdFYgxhuacFXk/45tqtsD3tCydeTE77OvpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X74tV1YgP0UCLdmKUdDurJTzuqfR6566dwS1X3V/AjeBtbryiztp1SVaWHMdgJhPABVT8nVy6uImR5GbXASPYHhgXBDSsgBkT1UNIi/vaXMJGpUnf7cyIdb47qSf45zSMoiik9f6GA9ZhtcmXEo0/7idtoDLdvT3tX4JWX9DBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=hi1ru2Y3; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061253; x=1789597253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKlOOJlBbdFYgxhuacFXk/45tqtsD3tCydeTE77OvpQ=;
  b=hi1ru2Y3acdbqBCQNcNOKKuloO0L9Xq+MjW4z7qgt0GKN69dRqGGw7QR
   65Fqux5q4wIXwwjTVZzVsfm/mp8uhDky2q4SWn6vhTVF4BZ6N22xeQasx
   6L6VEKkzNeHEm0NllXuVDeXP2cUJYzpYp9dRDaPugCwpB72oE1RxMIeWB
   o=;
X-CSE-ConnectionGUID: ueY0BNMxRDGWvB8e+v447A==
X-CSE-MsgGUID: dhynHplBQqS9DdWGnOZFxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918192"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918192"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:20:51 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:20:49 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:20:46 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 11/57] wifi: inffmac: add twt.c/h
Date: Wed, 17 Sep 2025 03:47:26 +0530
Message-ID: <20250916221821.4387-12-gokulkumar.sivakumar@infineon.com>
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

Driver implementation for initiating and teardown an Individual Target Wake
Time (iTWT) session with supported TWT Responder Device. The requests from
the userspace for the sessions are handled by the driver through Infineon's
Vendor NL80211 commands.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/twt.c | 1200 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/twt.h |  334 ++++++
 2 files changed, 1534 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/twt.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/twt.h

diff --git a/drivers/net/wireless/infineon/inffmac/twt.c b/drivers/net/wireless/infineon/inffmac/twt.c
new file mode 100644
index 000000000000..0e5d598a6765
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/twt.c
@@ -0,0 +1,1200 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2023-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "twt.h"
+#include "debug.h"
+#include "fwil.h"
+#include "feature.h"
+#include "bus.h"
+#include "cfg80211.h"
+
+/**
+ * inff_twt_oper_str - array of twt operations in string
+ */
+const char *inff_twt_oper_str[INFF_TWT_OPER_MAX] = {
+	"Setup",
+	"Teardown"
+};
+
+/**
+ * inff_twt_nego_type_str - array of twt Negotiation types in string
+ */
+const char *inff_twt_nego_type_str[INFF_TWT_PARAM_NEGO_TYPE_MAX] = {
+	"iTWT",
+	"Wake TBTT",
+	"bTWT IE BCN",
+	"bTWT"
+};
+
+/**
+ * inff_twt_setup_cmd_str - array of twt setup commands in string
+ */
+const char *inff_twt_setup_cmd_str[INFF_TWT_OPER_SETUP_CMD_TYPE_MAX] = {
+	"Request",
+	"Suggest",
+	"Demand",
+	"Grouping",
+	"Accept",
+	"Alternate",
+	"Dictate",
+	"Reject"
+};
+
+/**
+ * inff_twt_sess_state_str - array of twt session states in string
+ */
+const char *inff_twt_sess_state_str[INFF_TWT_SESS_STATE_MAX] = {
+	"Unspec",
+	"Setup inprogress",
+	"Setup incomplete",
+	"Setup complete",
+	"Teardown inprogress",
+	"Teardown incomplete",
+	"Teardown complete"
+};
+
+/**
+ * inff_twt_wake_dur_to_min_twt() - Nominal Minimum Wake Duration derivation from Wake Duration
+ *
+ * @wake_dur: Wake Duration input.
+ * @min_twt_unit: Nomial Minimum Wake Duration Unit input.
+ *
+ * return: Nominal Minimum Wake Duration in units of min_twt_unit.
+ */
+static inline u8
+inff_twt_wake_dur_to_min_twt(u32 wake_dur, u8 min_twt_unit)
+{
+	u8 min_twt;
+
+	if (min_twt_unit) {
+		/*
+		 * If min_twt_unit is 1, then min_twt is
+		 * in units of TUs (i.e) 1024 uS.
+		 */
+		min_twt = wake_dur / WAKE_DUR_UNIT_TU;
+	} else {
+		/*
+		 * If min_twt_unit is 0, then min_twt is
+		 * in units of 256 uS.
+		 */
+		min_twt = wake_dur / WAKE_DUR_UNIT_DEF;
+	}
+
+	return min_twt;
+}
+
+/**
+ * inff_twt_min_twt_to_wake_dur() - Derive Wake Duration from the
+ *	Nominal Minimum Wake Duration
+ *
+ * @min_twt: Nominal Minimum Wake Duration input.
+ * @min_twt_unit: Nomial Minimum Wake Duration Unit input.
+ *	0 - 256 uS
+ *	1 - 1TU (or) 1024 uS
+ *
+ * return: Wake Duration in unit of microseconds.
+ */
+static inline u32
+inff_twt_min_twt_to_wake_dur(u8 min_twt, u8 min_twt_unit)
+{
+	u32 wake_dur;
+
+	if (min_twt_unit) {
+		/*
+		 * If min_twt_unit is 1, then min_twt is
+		 * in units of TUs (i.e) 1024 uS.
+		 */
+		wake_dur = (u32)min_twt * WAKE_DUR_UNIT_TU;
+	} else {
+		/*
+		 * If min_twt_unit is 0, then min_twt is
+		 * in units of 256 uS.
+		 */
+		wake_dur = (u32)min_twt * WAKE_DUR_UNIT_DEF;
+	}
+
+	return wake_dur;
+}
+
+/**
+ * inff_twt_u32_to_float() - Derive Wake Interval Mantissa and Exponent
+ *	from the Wake Interval
+ *
+ * @wake_int: Wake Interval input in microseconds.
+ * @exponent: pointer to Wake Interval Exponent output.
+ * @mantissa: pointer to Wake Interval Mantissa output.
+ */
+static inline void
+inff_twt_u32_to_float(u32 wake_int, u8 *exponent, u16 *mantissa)
+{
+	u8 lzs = (u8)__builtin_clz(wake_int); /* leading 0's */
+	u8 shift = lzs < 16 ? 16 - lzs : 0;
+
+	*mantissa = (u16)(wake_int >> shift);
+	*exponent = shift;
+}
+
+/**
+ * inff_twt_float_to_u32() - Derive Wake Interval derivation from
+ *	Wake Interval Mantissa & Exponent.
+ *
+ * @exponent: Wake Interval Exponent input.
+ * @mantissa: Wake Interval Mantissa input.
+ *
+ * return: Wake interval in unit of microseconds.
+ */
+static inline u32
+inff_twt_float_to_u32(u8 exponent, u16 mantissa)
+{
+	return (u32)mantissa << exponent;
+}
+
+/**
+ * inff_twt_get_next_dialog_token() - Return the next available Dialog token.
+ *
+ * return: Dialog token in u8.
+ */
+static inline u8
+inff_twt_get_next_dialog_token(void)
+{
+	static u8 dialog_token;
+
+	/* Continuous iteratation in the range 1-255 */
+	dialog_token = ((dialog_token + 0x1) % 0x100) ? : 1;
+
+	return dialog_token;
+}
+
+/**
+ * inff_twt_stats_read() - Read the contents of the debugfs file "twt_stats".
+ *
+ * @seq: sequence for debugfs entry.
+ * @data: raw data pointer.
+ *
+ * return: 0.
+ */
+static int
+inff_twt_stats_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	struct inff_pub *drvr = bus_if->drvr;
+	int i;
+
+	/* Return if the if TWT is not supported by Firmware */
+	if (!(drvr->feat_flags[INFF_FEAT_TWT / 8] & BIT(INFF_FEAT_TWT % 8)))
+		return 0;
+
+	/* Iterate the interface list in struct inff_pub */
+	for (i = 0; i < INFF_MAX_IFS; i++) {
+		struct inff_if *ifp = drvr->iflist[i];
+		struct inff_twt_session *twt_sess;
+
+		/* Skip interface if TWT session list in struct inff_if is empty */
+		if (!ifp || list_empty(&ifp->twt_sess_list))
+			continue;
+
+		seq_printf(seq, "ifname: %s, ifidx: %u, bsscfgidx: %d\n",
+			   inff_ifname(ifp), ifp->ifidx, ifp->bsscfgidx);
+
+		/* Iterate the TWT session list in struct inff_if */
+		list_for_each_entry(twt_sess, &ifp->twt_sess_list, list) {
+			struct inff_twt_params *twt_params;
+			u32 wake_dur, wake_int;
+
+			twt_params = &twt_sess->twt_params;
+
+			wake_dur = inff_twt_min_twt_to_wake_dur(twt_params->min_twt,
+								twt_params->min_twt_unit);
+			wake_int = inff_twt_float_to_u32(twt_params->exponent,
+							 twt_params->mantissa);
+
+			if (twt_params->negotiation_type == INFF_TWT_PARAM_NEGO_TYPE_ITWT)
+				seq_printf(seq, "\tiTWT, Flow ID: %u, Dialog Token: %u\n",
+					   twt_params->flow_id, twt_params->dialog_token);
+			else if (twt_params->negotiation_type == INFF_TWT_PARAM_NEGO_TYPE_BTWT)
+				seq_printf(seq, "\tbTWT, Bcast TWT ID: %u, Dialog Token: %u\n",
+					   twt_params->bcast_twt_id, twt_params->dialog_token);
+			else
+				continue;
+
+			seq_printf(seq, "\t\tSession state       : %s\n",
+				   inff_twt_sess_state_str[twt_sess->state]);
+			seq_printf(seq, "\t\tTWT peer            : %pM\n",
+				   twt_sess->peer_addr.octet);
+			seq_printf(seq, "\t\tTarget Wake Time    : %llu uS\n",
+				   twt_params->twt);
+			seq_printf(seq, "\t\tWake Duration       : %u uS\n",
+				   wake_dur);
+			seq_printf(seq, "\t\tWake Interval       : %u uS\n",
+				   wake_int);
+			seq_printf(seq, "\t\tSession type        : %s, %s, %s\n\n",
+				   twt_params->implicit ? "Implicit" : "Explicit",
+				   twt_params->trigger ? "Trigger based" : "Non-Trigger based",
+				   twt_params->flow_type ? "Un-Announced" : "Announced");
+		}
+	}
+	return 0;
+}
+
+/**
+ * inff_twt_debugfs_create() - create debugfs entries.
+ *
+ * @drvr: driver instance.
+ */
+void
+inff_twt_debugfs_create(struct inff_pub *drvr)
+{
+	inff_debugfs_add_entry(drvr, "twt_stats", inff_twt_stats_read);
+}
+
+/**
+ * inff_twt_cleanup_all_sess - Cleanup all TWT sessions from the driver list.
+ *
+ * @ifp: interface instatnce.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+s32
+inff_twt_cleanup_all_sess(struct inff_if *ifp)
+{
+	struct inff_twt_session *entry = NULL, *next = NULL;
+	s32 ret = 0;
+
+	if (!ifp) {
+		inff_err("TWT: Failed to cleanup sessions");
+		ret = -EIO;
+	}
+
+	spin_lock(&ifp->twt_sess_list_lock);
+
+	list_for_each_entry_safe(entry, next, &ifp->twt_sess_list, list) {
+		inff_dbg(TWT, "TWT: Deleting session(%u) with peer %pM",
+			 entry->twt_params.flow_id, entry->peer_addr.octet);
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	spin_unlock(&ifp->twt_sess_list_lock);
+
+	return ret;
+}
+
+/**
+ * inff_twt_lookup_sess_by_dialog_token() - Lookup a TWT sesssion information from
+ *	the driver list based on the Dialog Token.
+ *
+ * @ifp: interface instance
+ * @dialog_token: TWT session Dialog Token
+ *
+ * return: Pointer to a TWT session instance if lookup is successful, NULL on failure.
+ */
+static struct inff_twt_session *
+inff_twt_lookup_sess_by_dialog_token(struct inff_if *ifp, u8 dialog_token)
+{
+	struct inff_twt_session *iter = NULL;
+
+	if (list_empty(&ifp->twt_sess_list))
+		return NULL;
+
+	list_for_each_entry(iter, &ifp->twt_sess_list, list)
+		if (iter->twt_params.dialog_token == dialog_token)
+			return iter;
+
+	return NULL;
+}
+
+/**
+ * inff_itwt_lookup_sess_by_flowid() - Lookup an iTWT sesssion information from
+ *	the driver list based on the Flow ID.
+ *
+ * @ifp: interface instance
+ * @flow_id: iTWT session Flow ID
+ *
+ * return: Pointer to a TWT session instance if lookup is successful, NULL on failure.
+ */
+static struct inff_twt_session *
+inff_itwt_lookup_sess_by_flowid(struct inff_if *ifp, u8 flow_id)
+{
+	struct inff_twt_session *iter = NULL;
+
+	if (list_empty(&ifp->twt_sess_list))
+		return NULL;
+
+	list_for_each_entry(iter, &ifp->twt_sess_list, list) {
+		if (iter->twt_params.negotiation_type != INFF_TWT_PARAM_NEGO_TYPE_ITWT)
+			continue;
+
+		if (iter->twt_params.flow_id == flow_id)
+			return iter;
+	}
+
+	return NULL;
+}
+
+/**
+ * inff_twt_update_sess_state() - Update the state of the TWT Session in the driver list
+ *
+ * @ifp: interface instance.
+ * @twt_sess: TWT session to be updated.
+ * @state: TWT session state, Refer enum inff_twt_session_state.
+ * @err_msg: print this message if error happened.
+ * @flow_id: print flow id if error happened.
+ *
+ * return: 0 on successful updation, value < 0 on failure.
+ */
+static s32
+inff_twt_update_sess_state(struct inff_if *ifp, struct inff_twt_session *twt_sess,
+			   enum inff_twt_session_state state, u8 *err_msg, u8 flow_id)
+{
+	s32 ret = 0;
+
+	if (!twt_sess) {
+		inff_err("TWT: %s: Failed to update session(%u) with state(%s)",
+			 err_msg, flow_id,
+			 inff_twt_sess_state_str[state]);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	spin_lock(&ifp->twt_sess_list_lock);
+
+	twt_sess->state = state;
+	inff_dbg(TWT, "TWT: updated session(%u) with peer %pM, state(%s)",
+		 twt_sess->twt_params.flow_id, twt_sess->peer_addr.octet,
+		  inff_twt_sess_state_str[twt_sess->state]);
+
+	spin_unlock(&ifp->twt_sess_list_lock);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_update_sess() - Update TWT session info in the driver list.
+ *
+ * @ifp: interface instance.
+ * @twt_sess: TWT session to be updated.
+ * @peer_addr: TWT peer address.
+ * @state: TWT session state, Refer enum inff_twt_session_state.
+ * @twt_params: TWT session parameters.
+ *
+ * return: 0 on successful updation, value < 0 on failure.
+ */
+static s32
+inff_twt_update_sess(struct inff_if *ifp, struct inff_twt_session *twt_sess,
+		     const u8 *peer_addr, enum inff_twt_session_state state,
+		     struct inff_twt_params *twt_params)
+{
+	s32 ret = 0;
+
+	if (!twt_sess) {
+		inff_dbg(TWT, "TWT: session is not available to update");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	spin_lock(&ifp->twt_sess_list_lock);
+
+	memcpy(twt_sess->peer_addr.octet, peer_addr, ETH_ALEN);
+	twt_sess->state = state;
+	memcpy(&twt_sess->twt_params, twt_params,
+	       sizeof(struct inff_twt_params));
+
+	inff_dbg(TWT, "TWT: updated session(%u) with peer %pM, state(%s)",
+		 twt_sess->twt_params.flow_id,
+		 twt_sess->peer_addr.octet,
+		 inff_twt_sess_state_str[twt_sess->state]);
+
+	spin_unlock(&ifp->twt_sess_list_lock);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_del_sess() - Delete a TWT sesssion info from the driver list.
+ *
+ * @ifp: interface instance.
+ * @twt_sess: TWT session to be deleted.
+ *
+ * return: 0 on successful deletion, value < 0 on failure.
+ */
+static s32
+inff_twt_del_sess(struct inff_if *ifp, struct inff_twt_session *twt_sess)
+{
+	s32 ret = 0;
+	u8 flow_id;
+	u8 peer_addr[ETH_ALEN];
+
+	if (!twt_sess) {
+		inff_dbg(TWT, "TWT: session is not available to delete");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	spin_lock(&ifp->twt_sess_list_lock);
+
+	flow_id = twt_sess->twt_params.flow_id;
+	memcpy(peer_addr, twt_sess->peer_addr.octet, ETH_ALEN);
+
+	list_del(&twt_sess->list);
+	kfree(twt_sess);
+
+	inff_dbg(TWT, "TWT: Deleted session(%u) with peer %pM",
+		 flow_id, peer_addr);
+
+	spin_unlock(&ifp->twt_sess_list_lock);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_add_sess() - Add a TWT session info to the driver list.
+ *
+ * @ifp: interface instance.
+ * @peer_addr: TWT peer address.
+ * @state: TWT session state, Refer enum inff_twt_session_state.
+ * @twt_params: TWT session parameters.
+ *
+ * return: 0 on successful addition, value < 0 on failure.
+ */
+static s32
+inff_twt_add_sess(struct inff_if *ifp, const u8 *peer_addr,
+		  enum inff_twt_session_state state,
+		  struct inff_twt_params *twt_params)
+{
+	struct inff_twt_session *new_twt_sess;
+	s32 ret = 0;
+
+	new_twt_sess = kzalloc(sizeof(*new_twt_sess), GFP_ATOMIC);
+	if (!new_twt_sess) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	new_twt_sess->ifidx = ifp->ifidx;
+	new_twt_sess->bsscfgidx = ifp->bsscfgidx;
+	new_twt_sess->state = state;
+
+	memcpy(new_twt_sess->peer_addr.octet, peer_addr, ETH_ALEN);
+	memcpy(&new_twt_sess->twt_params, twt_params,
+	       sizeof(struct inff_twt_params));
+
+	spin_lock(&ifp->twt_sess_list_lock);
+
+	list_add_tail(&new_twt_sess->list, &ifp->twt_sess_list);
+	inff_dbg(TWT, "TWT: Added session(%u) with peer %pM, state (%s)",
+		 new_twt_sess->twt_params.flow_id,
+		 new_twt_sess->peer_addr.octet,
+		  inff_twt_sess_state_str[new_twt_sess->state]);
+
+	spin_unlock(&ifp->twt_sess_list_lock);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_event_timeout_handler - Iterate the session list and handle stale
+ *	TWT session entries which are failed to move to next state in FSM.
+ *
+ * @t: timer instance.
+ */
+void inff_twt_event_timeout_handler(struct timer_list *t)
+{
+	struct inff_if *ifp = timer_container_of(ifp, t, twt_evt_timeout);
+	struct inff_twt_session *twt_sess = NULL, *next = NULL;
+	unsigned long curr_ts = jiffies;
+	s32 ret = 0;
+
+	list_for_each_entry_safe(twt_sess, next, &ifp->twt_sess_list, list) {
+		/* For this session entry, Skip if the time since the TWT cmd sent to the
+		 * Firmware does not exceed the Event timeout configured.
+		 */
+		if (time_after(twt_sess->oper_start_ts + INFF_TWT_EVENT_TIMEOUT, curr_ts))
+			continue;
+
+		switch (twt_sess->state) {
+		case INFF_TWT_SESS_STATE_SETUP_INPROGRESS:
+			ret = inff_twt_update_sess_state(ifp, twt_sess,
+							 INFF_TWT_SESS_STATE_SETUP_INCOMPLETE,
+							 "Setup TIMEOUT",
+							 twt_sess->twt_params.flow_id);
+			if (ret)
+				continue;
+
+			break;
+		case INFF_TWT_SESS_STATE_TEARDOWN_INPROGRESS:
+			ret = inff_twt_update_sess_state(ifp, twt_sess,
+							 INFF_TWT_SESS_STATE_TEARDOWN_INCOMPLETE,
+							 "Teardown TIMEOUT",
+							 twt_sess->twt_params.flow_id);
+			if (ret)
+				continue;
+
+			break;
+		default:
+			continue;
+		}
+
+		ret = inff_twt_del_sess(ifp, twt_sess);
+		if (ret) {
+			inff_err("TWT: Failed to Delete session(%u) from list",
+				 twt_sess->twt_params.flow_id);
+			break;
+		}
+
+		inff_dbg(TWT, "TWT: Cleared stale session(%u) with peer %pM, state(%s)",
+			 twt_sess->twt_params.flow_id, twt_sess->peer_addr.octet,
+			 inff_twt_sess_state_str[twt_sess->state]);
+	}
+}
+
+/**
+ * inff_twt_setup_event_handler() - Handle the TWT Setup Event notification from Firmware.
+ *
+ * @ifp: interface instatnce.
+ * @e: event message.
+ * @data: payload of message, contains TWT session data.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_twt_setup_event_handler(struct inff_if *ifp, const struct inff_event_msg *e,
+			     void *data)
+{
+	struct inff_twt_setup_event *setup_event;
+	struct inff_twt_sdesc *setup_desc;
+	struct inff_twt_session *twt_sess = NULL;
+	struct inff_twt_params twt_params;
+	bool unsolicited_setup = false;
+	s32 ret = 0;
+
+	setup_event = (struct inff_twt_setup_event *)data;
+	setup_desc = (struct inff_twt_sdesc *)
+		     (data + sizeof(struct inff_twt_setup_event));
+
+	/* TWT Negotiation_type */
+	twt_params.negotiation_type = setup_desc->negotiation_type;
+
+	/* Dialog Token */
+	twt_params.dialog_token = setup_event->dialog;
+
+	switch (twt_params.negotiation_type) {
+	case INFF_TWT_PARAM_NEGO_TYPE_ITWT:
+		/* Flow ID */
+		twt_params.flow_id = setup_desc->flow_id;
+
+		/* Lookup the session list for the flow ID in the Setup Response */
+		twt_sess = inff_itwt_lookup_sess_by_flowid(ifp, twt_params.flow_id);
+		if (!twt_sess)
+			twt_sess = inff_twt_lookup_sess_by_dialog_token(ifp,
+									twt_params.dialog_token);
+
+		/* If this device requested for session setup, a session entry with
+		 * state(setup inprogess) would be already available, else this is an
+		 * Unsolicited Setup Response from the peer TWT device.
+		 */
+		if (!twt_sess || twt_sess->state != INFF_TWT_SESS_STATE_SETUP_INPROGRESS)
+			unsolicited_setup = true;
+
+		break;
+	case INFF_TWT_PARAM_NEGO_TYPE_BTWT:
+		/* Broadcast TWT ID */
+		twt_params.bcast_twt_id = setup_desc->bid;
+
+		/* TODO: Handle the Broadcast TWT Setup Event */
+		fallthrough;
+	default:
+		inff_err("TWT: Setup EVENT: Negotiation Type(%s) not handled",
+			 inff_twt_nego_type_str[twt_params.negotiation_type]);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* Setup Event */
+	twt_params.setup_cmd = setup_desc->setup_cmd;
+
+	/* Flowflags */
+	twt_params.implicit = (setup_desc->flow_flags & INFF_TWT_FLOW_FLAG_IMPLICIT) ? 1 : 0;
+	twt_params.flow_type = (setup_desc->flow_flags & INFF_TWT_FLOW_FLAG_UNANNOUNCED) ? 1 : 0;
+	twt_params.trigger = (setup_desc->flow_flags & INFF_TWT_FLOW_FLAG_TRIGGER) ? 1 : 0;
+	twt_params.requestor = (setup_desc->flow_flags & INFF_TWT_FLOW_FLAG_REQUEST) ? 1 : 0;
+	twt_params.protection = (setup_desc->flow_flags & INFF_TWT_FLOW_FLAG_PROTECT) ? 1 : 0;
+
+	/* Target Wake Time */
+	twt_params.twt = le64_to_cpu((u64)setup_desc->wake_time_h << 32) |
+			 le64_to_cpu((u64)setup_desc->wake_time_l);
+
+	/* Wake Duration or Service Period */
+	twt_params.min_twt_unit = 0;
+	twt_params.min_twt =
+		inff_twt_wake_dur_to_min_twt(le32_to_cpu(setup_desc->wake_dur),
+					     twt_params.min_twt_unit);
+
+	/* Wake Interval or Service Interval */
+	inff_twt_u32_to_float(le32_to_cpu(setup_desc->wake_int),
+			      &twt_params.exponent, &twt_params.mantissa);
+
+	inff_dbg(TWT, "TWT: Setup EVENT: %sResponse with cmd(%s) from peer %pM",
+		 unsolicited_setup ? "Un-Solicited " : "",
+		 inff_twt_setup_cmd_str[setup_desc->setup_cmd], e->addr);
+
+	switch (setup_desc->setup_cmd) {
+	case TWT_SETUP_CMD_REQUEST:
+		fallthrough;
+	case TWT_SETUP_CMD_SUGGEST:
+		fallthrough;
+	case TWT_SETUP_CMD_DEMAND:
+		fallthrough;
+	case TWT_SETUP_CMD_GROUPING:
+		ret = -EOPNOTSUPP;
+		goto exit;
+	case TWT_SETUP_CMD_ACCEPT:
+		if (!twt_sess)
+			ret = inff_twt_add_sess(ifp, e->addr,
+						INFF_TWT_SESS_STATE_SETUP_COMPLETE,
+						&twt_params);
+		else
+			ret = inff_twt_update_sess(ifp, twt_sess, e->addr,
+						   INFF_TWT_SESS_STATE_SETUP_COMPLETE,
+						   &twt_params);
+		break;
+	case TWT_SETUP_CMD_ALTERNATE:
+		fallthrough;
+	case TWT_SETUP_CMD_DICTATE:
+		ret = -EOPNOTSUPP;
+		goto exit;
+	case TWT_SETUP_CMD_REJECT:
+		if (!twt_sess)
+			/* Bail out, since nothing to handle on receiving Un-Solicited
+			 * Reject from the TWT peer for an un-available TWT session.
+			 */
+			break;
+
+		ret = inff_twt_update_sess_state(ifp, twt_sess,
+						 INFF_TWT_SESS_STATE_SETUP_INCOMPLETE,
+						 "Setup EVENT", twt_params.flow_id);
+		if (ret)
+			goto exit;
+
+		ret = inff_twt_del_sess(ifp, twt_sess);
+
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	if (ret) {
+		inff_err("TWT: Setup EVENT: Failed to add/update/del session(%u) with peer %pM",
+			 twt_params.flow_id, e->addr);
+		goto exit;
+	}
+
+	inff_dbg(TWT, "TWT: Setup EVENT: Session %s\n"
+		 "Dialog Token         : %u\n"
+		 "Setup command        : %s\n"
+		 "Flow flags           : 0x %02x\n"
+		 "Flow ID              : %u\n"
+		 "Broadcast TWT ID     : %u\n"
+		 "Wake Time H,L        : 0x %08x %08x\n"
+		 "Wake Type            : %u\n"
+		 "Wake Duration        : %u uS\n"
+		 "Wake Interval        : %u uS\n"
+		 "Negotiation type     : %s\n",
+		 inff_twt_sess_state_str[twt_sess->state], setup_event->dialog,
+		 inff_twt_setup_cmd_str[setup_desc->setup_cmd], setup_desc->flow_flags,
+		 setup_desc->flow_id, setup_desc->bid, setup_desc->wake_time_h,
+		 setup_desc->wake_time_l, setup_desc->wake_type, setup_desc->wake_dur,
+		 setup_desc->wake_int, inff_twt_nego_type_str[setup_desc->negotiation_type]);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_teardown_event_handler() - Handle the TWT Teardown Event notification from Firmware.
+ *
+ * @ifp: interface instatnce.
+ * @e: event message.
+ * @data: payload of message, contains TWT session data.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_twt_teardown_event_handler(struct inff_if *ifp, const struct inff_event_msg *e,
+				void *data)
+{
+	struct inff_twt_teardown_event *teardown_event;
+	struct inff_twt_teardesc *teardown_desc;
+	struct inff_twt_session *twt_sess = NULL;
+	struct inff_twt_params twt_params;
+	bool unsolicited_teardown = false;
+	s32 ret = 0;
+
+	teardown_event = (struct inff_twt_teardown_event *)data;
+	teardown_desc = (struct inff_twt_teardesc *)
+			(data + sizeof(struct inff_twt_teardown_event));
+
+	/* TWT Negotiation_type */
+	twt_params.negotiation_type = teardown_desc->negotiation_type;
+
+	/* Teardown all Negotiated TWT */
+	twt_params.teardown_all_twt = teardown_desc->alltwt;
+	if (twt_params.teardown_all_twt) {
+		ret = inff_twt_cleanup_all_sess(ifp);
+		goto exit;
+	}
+
+	switch (twt_params.negotiation_type) {
+	case INFF_TWT_PARAM_NEGO_TYPE_ITWT:
+		/* Flow ID */
+		twt_params.flow_id = teardown_desc->flow_id;
+
+		/* Lookup the session list for the received flow ID */
+		twt_sess = inff_itwt_lookup_sess_by_flowid(ifp, twt_params.flow_id);
+
+		/* If this device requested for session Teardown, a session entry with
+		 * state(setup inprogess) would be already available, else this is an
+		 * Unsolicited Teardown Response from the peer TWT device.
+		 */
+		if (!twt_sess || twt_sess->state != INFF_TWT_SESS_STATE_SETUP_INPROGRESS)
+			unsolicited_teardown = true;
+
+		break;
+	case INFF_TWT_PARAM_NEGO_TYPE_BTWT:
+		/* Broadcast TWT ID */
+		twt_params.bcast_twt_id = teardown_desc->bid;
+
+		/* TODO: Handle the Broadcast TWT Teardown Event */
+		fallthrough;
+	default:
+		inff_err("TWT: Teardown EVENT: Negotiation Type(%s) not handled\n",
+			 inff_twt_nego_type_str[twt_params.negotiation_type]);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	inff_dbg(TWT, "TWT: Teardown EVENT: %sResponse from peer %pM",
+		 unsolicited_teardown ? "Un-Solicited " : "", e->addr);
+
+	if (!twt_sess) {
+		inff_dbg(TWT, "TWT: Teardown EVENT: Un-available session(%u) for deletion",
+			 twt_params.flow_id);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = inff_twt_update_sess_state(ifp, twt_sess,
+					 INFF_TWT_SESS_STATE_TEARDOWN_COMPLETE,
+					 "Teardown EVENT", twt_params.flow_id);
+	if (ret)
+		goto exit;
+
+	ret = inff_twt_del_sess(ifp, twt_sess);
+	if (ret) {
+		inff_err("TWT: Teardown EVENT: Failed to Delete session from list");
+		goto exit;
+	}
+
+	inff_dbg(TWT, "TWT: Teardown EVENT: Session %s\n"
+		 "Flow ID              : %u\n"
+		 "Broadcast TWT ID     : %u\n"
+		 "Negotiation type     : %s\n"
+		 "Teardown all TWT     : %u\n",
+		 inff_twt_sess_state_str[twt_sess->state], teardown_desc->flow_id,
+		 teardown_desc->bid, inff_twt_nego_type_str[teardown_desc->negotiation_type],
+		 teardown_desc->alltwt);
+exit:
+	return ret;
+}
+
+/**
+ * inff_notify_twt_event() - Handle the TWT Event notifications from Firmware.
+ *
+ * @ifp: interface instatnce.
+ * @e: event message.
+ * @data: payload of message, contains TWT session data.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+s32
+inff_notify_twt_event(struct inff_if *ifp, const struct inff_event_msg *e, void *data)
+{
+	s32 ret;
+
+	if (!ifp) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	switch (e->event_code) {
+	case INFF_E_TWT_SETUP:
+		ret = inff_twt_setup_event_handler(ifp, e, data);
+		if (ret) {
+			inff_err("TWT: EVENT: Failed to handle TWT Setup event");
+			goto exit;
+		}
+		break;
+	case INFF_E_TWT_TEARDOWN:
+		ret = inff_twt_teardown_event_handler(ifp, e, data);
+		if (ret) {
+			inff_err("TWT: EVENT: Failed to handle TWT Teardown event");
+			goto exit;
+		}
+		break;
+	default:
+		inff_err("TWT: EVENT: Received event %d not handeled", e->event_code);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_setup_oper_handler() - Handle the TWT Setup Operation request from Userspace.
+ *
+ * @ifp: interface instance.
+ * @twt_params: TWT session parameters.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_twt_setup_oper_handler(struct inff_if *ifp, struct inff_twt_params twt_params)
+{
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	struct inff_twt_setup_oper val;
+	struct inff_twt_session *twt_sess = NULL;
+	s32 ret;
+
+	memset(&val, 0, sizeof(val));
+	val.version = INFF_TWT_SETUP_VER;
+	val.length = sizeof(val.version) + sizeof(val.length);
+
+	/* Default values, Override Below */
+	val.sdesc.flow_flags = 0x0;
+	val.sdesc.wake_dur = 0xFFFFFFFF;
+	val.sdesc.wake_int = 0xFFFFFFFF;
+	val.sdesc.wake_int_max = 0xFFFFFFFF;
+
+	/* TWT Negotiation_type */
+	val.sdesc.negotiation_type = (u8)twt_params.negotiation_type;
+
+	switch (val.sdesc.negotiation_type) {
+	case INFF_TWT_PARAM_NEGO_TYPE_ITWT:
+		/* Flow ID */
+		if ((twt_params.flow_id >= 0x0 && twt_params.flow_id <= 0x7)) {
+			/* Lookup the session list for the requested flow ID */
+			val.sdesc.flow_id = twt_params.flow_id;
+			twt_sess = inff_itwt_lookup_sess_by_flowid(ifp, twt_params.flow_id);
+			if (twt_sess) {
+				inff_err("TWT: Setup REQ: Skipping");
+				inff_err(" session(%u) entry is already available with state(%s)",
+					 twt_params.flow_id,
+					 inff_twt_sess_state_str[twt_sess->state]);
+				ret = -EINVAL;
+				goto exit;
+			}
+		} else if (twt_params.flow_id == 0xFF) {
+			/* Let the Firmware choose the Flow ID */
+			val.sdesc.flow_id = twt_params.flow_id;
+		} else {
+			inff_err("TWT: Setup REQ: flow ID: %d is invalid",
+				 twt_params.flow_id);
+			ret = -EINVAL;
+			goto exit;
+		}
+		break;
+	case INFF_TWT_PARAM_NEGO_TYPE_BTWT:
+		/* Broadcast TWT ID */
+		val.sdesc.bid = twt_params.bcast_twt_id;
+
+		/* TODO: Handle the Broadcast TWT Setup REQ */
+		fallthrough;
+	default:
+		inff_err("TWT: Setup REQ: Negotiation Type(%s) not handled",
+			 inff_twt_nego_type_str[twt_params.negotiation_type]);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* Setup command */
+	val.sdesc.setup_cmd = twt_params.setup_cmd;
+
+	/* Flow flags */
+	val.sdesc.flow_flags |= ((twt_params.negotiation_type & 0x02) >> 1 ?
+				 INFF_TWT_FLOW_FLAG_BROADCAST : 0);
+	val.sdesc.flow_flags |= (twt_params.implicit ? INFF_TWT_FLOW_FLAG_IMPLICIT : 0);
+	val.sdesc.flow_flags |= (twt_params.flow_type ? INFF_TWT_FLOW_FLAG_UNANNOUNCED : 0);
+	val.sdesc.flow_flags |= (twt_params.trigger ? INFF_TWT_FLOW_FLAG_TRIGGER : 0);
+	val.sdesc.flow_flags |= ((twt_params.negotiation_type & 0x01) ?
+				 INFF_TWT_FLOW_FLAG_WAKE_TBTT_NEGO : 0);
+	val.sdesc.flow_flags |= (twt_params.requestor ? INFF_TWT_FLOW_FLAG_REQUEST : 0);
+	val.sdesc.flow_flags |= (twt_params.protection ? INFF_TWT_FLOW_FLAG_PROTECT : 0);
+
+	if (twt_params.twt) {
+		/* Target Wake Time parameter */
+		val.sdesc.wake_time_h = cpu_to_le32((u32)(twt_params.twt >> 32));
+		val.sdesc.wake_time_l = cpu_to_le32((u32)(twt_params.twt));
+		val.sdesc.wake_type = INFF_TWT_WAKE_TIME_TYPE_BSS;
+	} else if (twt_params.twt_offset) {
+		/* Target Wake Time offset parameter */
+		val.sdesc.wake_time_h = cpu_to_le32((u32)(twt_params.twt_offset >> 32));
+		val.sdesc.wake_time_l = cpu_to_le32((u32)(twt_params.twt_offset));
+		val.sdesc.wake_type = INFF_TWT_WAKE_TIME_TYPE_OFFSET;
+	} else {
+		/* Let the Firmware choose the Target Wake Time */
+		val.sdesc.wake_time_h = 0x0;
+		val.sdesc.wake_time_l = 0x0;
+		val.sdesc.wake_type = INFF_TWT_WAKE_TIME_TYPE_AUTO;
+	}
+
+	/* Wake Duration or Service Period */
+	val.sdesc.wake_dur = cpu_to_le32(inff_twt_min_twt_to_wake_dur(twt_params.min_twt,
+								      twt_params.min_twt_unit));
+
+	/* Wake Interval or Service Interval */
+	val.sdesc.wake_int = cpu_to_le32(inff_twt_float_to_u32(twt_params.exponent,
+							       twt_params.mantissa));
+
+	/* Override Dialog Token passed from userpace with next available value in Driver */
+	twt_params.dialog_token = inff_twt_get_next_dialog_token();
+	val.dialog = cpu_to_le16((u16)twt_params.dialog_token);
+
+	/* Send the TWT Setup request to Firmware */
+	ret = inff_fil_xtlv_data_set(ifp, "twt", INFF_TWT_CMD_SETUP,
+				     (void *)&val, sizeof(val));
+	if (ret < 0) {
+		inff_err("TWT: Setup REQ: Failed, Firmware error(%d)", ret);
+		goto exit;
+	}
+
+	/* Add an entry setup with progress state */
+	ret = inff_twt_add_sess(ifp, vif->profile.bssid,
+				INFF_TWT_SESS_STATE_SETUP_INPROGRESS,
+				&twt_params);
+	if (ret < 0) {
+		inff_err("TWT: Setup REQ: Failed to add session");
+		goto exit;
+	}
+
+	/* Schedule the Cleanup timer to handle Setup Completion timeout */
+	mod_timer(&ifp->twt_evt_timeout, jiffies + INFF_TWT_EVENT_TIMEOUT);
+
+	inff_dbg(TWT, "TWT: Setup REQ: Session %s\n"
+		 "Dialog Token         : %u\n"
+		 "Setup command        : %s\n"
+		 "Flow flags           : 0x %02x\n"
+		 "Flow ID              : %u\n"
+		 "Broadcast TWT ID     : %u\n"
+		 "Wake Time H,L        : 0x %08x %08x\n"
+		 "Wake Type            : %u\n"
+		 "Wake Duration        : %u uS\n"
+		 "Wake Interval        : %u uS\n"
+		 "Negotiation type     : %s\n",
+		 inff_twt_sess_state_str[INFF_TWT_SESS_STATE_SETUP_INPROGRESS],
+		 val.dialog, inff_twt_setup_cmd_str[val.sdesc.setup_cmd],
+		 val.sdesc.flow_flags, val.sdesc.flow_id, val.sdesc.bid,
+		 val.sdesc.wake_time_h, val.sdesc.wake_time_l, val.sdesc.wake_type,
+		 val.sdesc.wake_dur, val.sdesc.wake_int,
+		 inff_twt_nego_type_str[val.sdesc.negotiation_type]);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_teardown_oper_handler() - Handle the TWT Teardown Operation request from Userspace.
+ *
+ * @ifp: interface instance.
+ * @twt_params: TWT session parameters.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+static s32
+inff_twt_teardown_oper_handler(struct inff_if *ifp, struct inff_twt_params twt_params)
+{
+	struct inff_twt_teardown_oper val;
+	struct inff_twt_session *twt_sess = NULL;
+	s32 ret;
+
+	memset(&val, 0, sizeof(val));
+	val.version = INFF_TWT_TEARDOWN_VER;
+	val.length = sizeof(val.version) + sizeof(val.length);
+
+	/* TWT Negotiation_type */
+	val.teardesc.negotiation_type = (u8)twt_params.negotiation_type;
+
+	/* Teardown All TWT */
+	val.teardesc.alltwt = twt_params.teardown_all_twt;
+	if (val.teardesc.alltwt) {
+		/* If Teardown all TWT is set, then check if the TWT session is not empty */
+		if (list_empty(&ifp->twt_sess_list)) {
+			inff_err("TWT: Teardown REQ: No active TWT sessions");
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		/* Reset Flow ID & Bcast TWT ID with a placeholder value */
+		twt_params.flow_id = 0xFF;
+		twt_params.bcast_twt_id = 0xFF;
+	}
+
+	switch (val.teardesc.negotiation_type) {
+	case INFF_TWT_PARAM_NEGO_TYPE_ITWT:
+		/* Flow ID */
+		if ((twt_params.flow_id >= 0x0 && twt_params.flow_id <= 0x7)) {
+			val.teardesc.flow_id = twt_params.flow_id;
+
+			/* Lookup the session list for the requested flow ID */
+			twt_sess = inff_itwt_lookup_sess_by_flowid(ifp, twt_params.flow_id);
+			if (!twt_sess ||
+			    twt_sess->state != INFF_TWT_SESS_STATE_SETUP_COMPLETE) {
+				inff_err("TWT: Teardown REQ: session(%u) is not active",
+					 twt_params.flow_id);
+				ret = -EINVAL;
+				goto exit;
+			}
+		} else if (twt_params.flow_id == 0xFF) {
+			val.teardesc.flow_id = twt_params.flow_id;
+		} else {
+			inff_err("TWT: Teardown REQ: session(%u) is invalid",
+				 twt_params.flow_id);
+			ret = -EINVAL;
+			goto exit;
+		}
+		break;
+	case INFF_TWT_PARAM_NEGO_TYPE_BTWT:
+		/* Broadcast TWT ID */
+		val.teardesc.bid = twt_params.bcast_twt_id;
+
+		/* TODO: Handle the Broadcast TWT Teardown REQ */
+		fallthrough;
+	default:
+		inff_err("TWT: Teardown REQ: Negotiation Type(%s) not handled",
+			 inff_twt_nego_type_str[twt_params.negotiation_type]);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* Send the TWT Teardown request to Firmware */
+	ret = inff_fil_xtlv_data_set(ifp, "twt", INFF_TWT_CMD_TEARDOWN,
+				     (void *)&val, sizeof(val));
+	if (ret < 0) {
+		inff_err("TWT: Teardown REQ: Failed, Firmware error(%d)", ret);
+		goto exit;
+	}
+
+	list_for_each_entry(twt_sess, &ifp->twt_sess_list, list) {
+		/* Skip updating the state of this session to "Teardown inprogress"
+		 * on one of the following cases
+		 *	1. The "Teardown all" session action is not requested by userspace.
+		 *	2. This session's Flow ID is not explcitly requested for Teardown.
+		 *	3. This session's state is not "setup complete".
+		 *	   i.e, it is not already active to teardown.
+		 */
+		if (!twt_params.teardown_all_twt ||
+		    twt_params.flow_id != twt_sess->twt_params.flow_id ||
+		    twt_sess->state != INFF_TWT_SESS_STATE_SETUP_COMPLETE)
+			continue;
+
+		ret = inff_twt_update_sess_state(ifp, twt_sess,
+						 INFF_TWT_SESS_STATE_TEARDOWN_INPROGRESS,
+						 "Teardown REQ", twt_params.flow_id);
+		if (ret)
+			goto exit;
+	}
+
+	/* Schedule the Cleanup timer to handle Teardown Completion timeout */
+	mod_timer(&ifp->twt_evt_timeout, jiffies + INFF_TWT_EVENT_TIMEOUT);
+
+	inff_dbg(TWT, "TWT: Teardown REQ: Session %s\n"
+		 "Flow ID              : %u\n"
+		 "Broadcast TWT ID     : %u\n"
+		 "Negotiation type     : %s\n"
+		 "Teardown all TWT     : %u\n",
+		 inff_twt_sess_state_str[INFF_TWT_SESS_STATE_TEARDOWN_INPROGRESS],
+		 val.teardesc.flow_id, val.teardesc.bid,
+		 inff_twt_nego_type_str[val.teardesc.negotiation_type],
+		 val.teardesc.alltwt);
+exit:
+	return ret;
+}
+
+/**
+ * inff_twt_oper() - Handle the TWT Operation requests from Userspace.
+ *
+ * @wiphy: wiphy object for cfg80211 interface.
+ * @wdev: wireless device.
+ * @twt_params: TWT session parameters.
+ *
+ * return: 0 on success, value < 0 on failure.
+ */
+s32
+inff_twt_oper(struct wiphy *wiphy, struct wireless_dev *wdev,
+	      struct inff_twt_params twt_params)
+{
+	struct inff_cfg80211_vif *vif = NULL;
+	struct inff_if *ifp = NULL;
+	s32 ret;
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
+	/* Check if TWT feature is supported in the Firmware */
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_TWT)) {
+		inff_err("TWT: REQ: Operation(%s) can't be handled, TWT not enabled on VIF(%s)",
+			 inff_twt_oper_str[twt_params.twt_oper], inff_ifname(ifp));
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* Check VIF operating Mode */
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_STATION:
+		if (!test_bit(INFF_VIF_STATUS_CONNECTED, &vif->sme_state)) {
+			inff_err("TWT: REQ: Operation(%s) invalid when VIF(%s) not connected with WLAN peer",
+				 inff_twt_oper_str[twt_params.twt_oper], inff_ifname(ifp));
+			ret = -ENOTCONN;
+			goto exit;
+		}
+
+		break;
+	case NL80211_IFTYPE_AP:
+		/* TODO: Handle the TWT operation requests for AP Mode */
+		fallthrough;
+	default:
+		inff_err("TWT: REQ: Operation(%s) not supported on VIF(%s) mode(%u)",
+			 inff_twt_oper_str[twt_params.twt_oper], inff_ifname(ifp),
+			 wdev->iftype);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* TWT Operation */
+	switch (twt_params.twt_oper) {
+	case INFF_TWT_OPER_SETUP:
+		ret = inff_twt_setup_oper_handler(ifp, twt_params);
+		break;
+	case INFF_TWT_OPER_TEARDOWN:
+		ret = inff_twt_teardown_oper_handler(ifp, twt_params);
+		break;
+	default:
+		inff_err("TWT: REQ: Operation(%s) not supported on VIF(%s)",
+			 inff_twt_oper_str[twt_params.twt_oper], inff_ifname(ifp));
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+exit:
+	return ret;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/twt.h b/drivers/net/wireless/infineon/inffmac/twt.h
new file mode 100644
index 000000000000..a7aa672ceb75
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/twt.h
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2023-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_TWT_H
+#define INFF_TWT_H
+
+#include <linux/sched.h>
+#include <linux/jiffies.h>
+#include "vendor_inf.h"
+#include "core.h"
+
+/* Min TWT Default Unit */
+#define WAKE_DUR_UNIT_DEF 256
+/* Min TWT Unit in TUs */
+#define WAKE_DUR_UNIT_TU 1024
+
+#define INFF_TWT_EVENT_TIMEOUT	msecs_to_jiffies(3000)
+/**
+ * enum inff_twt_cmd - TWT iovar subcmds handled by firmware TWT module
+ *
+ * @INFF_TWT_CMD_ENAB: Enable the firmware TWT module.
+ * @INFF_TWT_CMD_SETUP: Setup a TWT session with a TWT peer.
+ * @INFF_TWT_CMD_TEARDOWN: Teardown the active TWT session with a TWT peer.
+ */
+enum inff_twt_cmd {
+	INFF_TWT_CMD_ENAB,
+	INFF_TWT_CMD_SETUP,
+	INFF_TWT_CMD_TEARDOWN,
+};
+
+/* TWT iovar subcmd version */
+#define INFF_TWT_SETUP_VER	0u
+#define INFF_TWT_TEARDOWN_VER	0u
+
+/**
+ * enum inff_twt_flow_flag - TWT flow flags to be used in TWT iovar setup subcmd
+ *
+ * @INFF_TWT_FLOW_FLAG_BROADCAST: Broadcast TWT Session.
+ * @INFF_TWT_FLOW_FLAG_IMPLICIT: Implcit TWT session type.
+ * @INFF_TWT_FLOW_FLAG_UNANNOUNCED: Unannounced TWT session type.
+ * @INFF_TWT_FLOW_FLAG_TRIGGER: Trigger based TWT Session type.
+ * @INFF_TWT_FLOW_FLAG_WAKE_TBTT_NEGO: Wake TBTT Negotiation type.
+ * @INFF_TWT_FLOW_FLAG_REQUEST: TWT Session setup requestor.
+ * @INFF_TWT_FLOW_FLAG_RESPONDER_PM: Not used.
+ * @INFF_TWT_FLOW_FLAG_UNSOLICITED: Unsolicited TWT Session Setup.
+ * @INFF_TWT_FLOW_FLAG_PROTECT: Specifies whether Tx within SP is protected, Not used.
+ */
+enum inff_twt_flow_flag {
+	INFF_TWT_FLOW_FLAG_BROADCAST      = BIT(0),
+	INFF_TWT_FLOW_FLAG_IMPLICIT       = BIT(1),
+	INFF_TWT_FLOW_FLAG_UNANNOUNCED    = BIT(2),
+	INFF_TWT_FLOW_FLAG_TRIGGER        = BIT(3),
+	INFF_TWT_FLOW_FLAG_WAKE_TBTT_NEGO = BIT(4),
+	INFF_TWT_FLOW_FLAG_REQUEST        = BIT(5),
+	INFF_TWT_FLOW_FLAG_RESPONDER_PM   = BIT(6),
+	INFF_TWT_FLOW_FLAG_UNSOLICITED    = BIT(7),
+	INFF_TWT_FLOW_FLAG_PROTECT        = BIT(8)
+};
+
+/**
+ * enum inff_twt_session_state - TWT session state in the Host driver list
+ *
+ * @INFF_TWT_SESS_STATE_UNSPEC: Reserved value 0.
+ * @INFF_TWT_SESS_STATE_SETUP_INPROGRESS: TWT session setup request was sent
+ *	to the Firmware.
+ * @INFF_TWT_SESS_STATE_SETUP_INCOMPLETE: TWT session setup is incomplete,
+ *	because either the TWT peer did not send a response, or sent a Reject
+ *	response driver received a Reject Setup event from the Firmware.
+ * @INFF_TWT_SESS_STATE_SETUP_COMPLETE: TWT session setup is complete and received
+ *	setup event from the Firmware.
+ * @INFF_TWT_SESS_STATE_TEARDOWN_INPROGRESS: TWT session teardown request was sent
+ *	to the Firmware.
+ * @INFF_TWT_SESS_STATE_TEARDOWN_INCOMPLETE: TWT session teardown event timed out.
+ * @INFF_TWT_SESS_STATE_TEARDOWN_COMPLETE: TWT session teardown is complete and
+ *	received Teardown event from the Firmware.
+ * @INFF_TWT_SESS_STATE_MAX: This acts as a the tail of state list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_twt_session_state {
+	INFF_TWT_SESS_STATE_UNSPEC,
+	INFF_TWT_SESS_STATE_SETUP_INPROGRESS,
+	INFF_TWT_SESS_STATE_SETUP_INCOMPLETE,
+	INFF_TWT_SESS_STATE_SETUP_COMPLETE,
+	INFF_TWT_SESS_STATE_TEARDOWN_INPROGRESS,
+	INFF_TWT_SESS_STATE_TEARDOWN_INCOMPLETE,
+	INFF_TWT_SESS_STATE_TEARDOWN_COMPLETE,
+	INFF_TWT_SESS_STATE_MAX
+};
+
+/**
+ * struct inff_twt_params - TWT session parameters
+ *
+ * @twt_oper: TWT operation, Refer enum inff_twt_oper.
+ * @negotiation_type: Negotiation Type, Refer enum inff_twt_param_nego_type.
+ * @setup_cmd: Setup cmd, Refer enum inff_twt_oper_setup_cmd_type.
+ * @dialog_token: TWT Negotiation Dialog Token.
+ * @twt: Target Wake Time.
+ * @twt_offset: Target Wake Time Offset.
+ * @min_twt: Nominal Minimum Wake Duration.
+ * @exponent: Wake Interval Exponent.
+ * @mantissa: Wake Interval Mantissa.
+ * @requestor: TWT Session requestor or responder.
+ * @implicit: implicit or Explicit TWT session.
+ * @flow_type: Announced or Un-Announced TWT session.
+ * @flow_id: Flow ID.
+ * @bcast_twt_id: Broadcast TWT ID.
+ * @protection: Protection, Not used.
+ * @twt_channel: TWT Channel, Not used.
+ * @twt_info_frame_disabled: TWT information frame disabled, Not used.
+ * @min_twt_unit: Nominal Minimum Wake Duration Unit.
+ * @teardown_all_twt: Teardown All TWT.
+ */
+struct inff_twt_params {
+	enum inff_twt_oper twt_oper;
+	enum inff_twt_param_nego_type negotiation_type;
+	enum inff_twt_oper_setup_cmd_type setup_cmd;
+	u8 dialog_token;
+	u64 twt;
+	u64 twt_offset;
+	u8 min_twt;
+	u8 exponent;
+	u16 mantissa;
+	u8 requestor;
+	u8 trigger;
+	u8 implicit;
+	u8 flow_type;
+	u8 flow_id;
+	u8 bcast_twt_id;
+	u8 protection;
+	u8 twt_channel;
+	u8 twt_info_frame_disabled;
+	u8 min_twt_unit;
+	u8 teardown_all_twt;
+};
+
+/**
+ * struct inff_twt_session - TWT session structure.
+ *
+ * @ifidx: interface index.
+ * @bsscfgidx: bsscfg index.
+ * @peer: TWT peer address.
+ * @state: TWT session state, refer enum inff_twt_session_state.
+ * @twt_params: TWT session parameters.
+ * @oper_req_ts: TWT session operation (setup, teardown, etc..) start timestamp.
+ * @list: linked list.
+ */
+struct inff_twt_session {
+	u8 ifidx;
+	s32 bsscfgidx;
+	struct ether_addr peer_addr;
+	enum inff_twt_session_state state;
+	struct inff_twt_params twt_params;
+	unsigned long oper_start_ts;
+	struct list_head list;
+};
+
+/**
+ * enum inff_twt_wake_time_type - Type of the struct members wake_time_{h/l} in the
+ *	TWT Setup descriptor struct inff_twt_sdesc.
+ *
+ * @INFF_TWT_WAKE_TIME_TYPE_BSS: wake_time_{h/l} is the BSS TSF tiume.
+ * @INFF_TWT_WAKE_TIME_TYPE_OFFSET: wake_time_{h/l} is an offset of TSF time
+ *	when the iovar is processed.
+ * @INFF_TWT_WAKE_TIME_TYPE_AUTO: The target wake time is chosen internally by the Firmware.
+ */
+enum inff_twt_wake_time_type {
+	INFF_TWT_WAKE_TIME_TYPE_BSS,
+	INFF_TWT_WAKE_TIME_TYPE_OFFSET,
+	INFF_TWT_WAKE_TIME_TYPE_AUTO
+};
+
+/**
+ * struct inff_twt_sdesc - TWT Setup Descriptor.
+ *
+ * @setup_cmd: Setup command and event type. Refer enum inff_twt_oper_setup_cmd_type.
+ * @flow_flags: Flow attributes, Refer enum inff_twt_flow_flag.
+ * @flow_id: Flow ID, Range 0-7. Set to 0xFF for auto assignment.
+ * @wake_type: wake_time_{h/l} type, Refer enum inff_twt_wake_time_type.
+ * @wake_time_h: Target Wake Time, high 32 bits.
+ * @wake_time_l: Target Wake Time, Low 32 bits.
+ * @wake_dur: Target Wake Duration in unit of uS.
+ * @wake_int: Target Wake Interval.
+ * @btwt_persistence: Broadcast TWT Persistence.
+ * @wake_int_max: Max Wake interval(uS) for TWT.
+ * @duty_cycle_min: Min Duty cycle for TWT(Percentage).
+ * @pad: 1 byte pad.
+ * @bid: Brodacst TWT ID, Range 0-31. Set to 0xFF for auto assignment.
+ * @channel: TWT channel - Not used.
+ * @negotiation_type: Negotiation Type, Refer enum inff_twt_param_nego_type.
+ * @frame_recomm: Frame recommendation for broadcast TWTs - Not used.
+ */
+struct inff_twt_sdesc {
+	u8 setup_cmd;
+	u8 flow_flags;
+	u8 flow_id;
+	u8 wake_type;
+	u32 wake_time_h;
+	u32 wake_time_l;
+	u32 wake_dur;
+	u32 wake_int;
+	u32 btwt_persistence;
+	u32 wake_int_max;
+	u8 duty_cycle_min;
+	u8 pad;
+	u8 bid;
+	u8 channel;
+	u8 negotiation_type;
+	u8 frame_recomm;
+};
+
+/**
+ * struct inff_twt_setup_event - TWT Setup Completion event data from firmware TWT module
+ *
+ * @version: Structure version.
+ * @length:the byte count of fields from 'dialog' onwards.
+ * @dialog: the dialog token user supplied to the TWT setup API.
+ * @pad: 3 byte Pad.
+ * @status: Event status.
+ */
+struct inff_twt_setup_event {
+	u16 version;
+	u16 length;
+	u8 dialog;
+	u8 pad[3];
+	s32 status;
+	/* enum inff_twt_sdesc sdesc; */
+};
+
+/**
+ * struct inff_twt_setup_oper - TWT iovar Setup operation subcmd data to firmware TWT module
+ *
+ * @version: Structure version.
+ * @length: data length (starting after this field).
+ * @peer: TWT peer address.
+ * @pad: 2 byte Pad.
+ * @sdesc: TWT setup descriptor.
+ */
+struct inff_twt_setup_oper {
+	u16 version;
+	u16 length;
+	struct ether_addr peer;
+	u8 pad[2];
+	struct inff_twt_sdesc sdesc;
+	u16 dialog;
+};
+
+/**
+ * struct inff_twt_teardesc - TWT Teardown descriptor.
+ *
+ * @negotiation_type: Negotiation Type: Refer enum inff_twt_param_nego_type.
+ * @flow_id: Flow ID: Range 0-7. Set to 0xFF for auto assignment.
+ * @bid: Brodacst TWT ID: Range 0-31. Set to 0xFF for auto assignment.
+ * @alltwt: Teardown all TWT sessions: set to 0 or 1.
+ */
+struct inff_twt_teardesc {
+	u8 negotiation_type;
+	u8 flow_id;
+	u8 bid;
+	u8 alltwt;
+};
+
+/**
+ * struct inff_twt_teardown_event - TWT Teardown Completion event data from firmware TWT module.
+ *
+ * @version: structure version.
+ * @length: the byte count of fields from 'status' onwards.
+ * @status: Event status.
+ */
+struct inff_twt_teardown_event {
+	u16 version;
+	u16 length;
+	s32 status;
+	/* enum inff_twt_teardesc teardesc; */
+};
+
+/**
+ * struct inff_twt_teardown_oper - TWT iovar Teardown operation subcmd data to firmware TWT module.
+ *
+ * @version: structure version.
+ * @length: data length (starting after this field).
+ * @peer: TWT peer address.
+ * @teardesc: TWT Teardown descriptor.
+ */
+struct inff_twt_teardown_oper {
+	u16 version;
+	u16 length;
+	struct ether_addr peer;
+	struct inff_twt_teardesc teardesc;
+};
+
+/**
+ * inff_twt_debugfs_create() - create debugfs entries.
+ *
+ * @drvr: driver instance.
+ */
+void inff_twt_debugfs_create(struct inff_pub *drvr);
+
+/**
+ * inff_twt_cleanup_all_sess - Cleanup all TWT sessions from the driver list.
+ *
+ * @ifp: interface instatnce.
+ */
+s32 inff_twt_cleanup_all_sess(struct inff_if *ifp);
+
+/**
+ * inff_twt_event_timeout_handler - Iterate the session list and handle stale
+ *	TWT session entries which are failed to move to next state in FSM.
+ */
+void inff_twt_event_timeout_handler(struct timer_list *t);
+
+/**
+ * inff_notify_twt_event() - Handle the TWT Event notifications from Firmware.
+ *
+ * @ifp: interface instatnce.
+ * @e: event message.
+ * @data: payload of message, contains TWT session data.
+ */
+int inff_notify_twt_event(struct inff_if *ifp, const struct inff_event_msg *e,
+			  void *data);
+
+/**
+ * inff_twt_oper() - Handle the TWT Operation requests from Userspace.
+ *
+ * @wiphy: wiphy object for cfg80211 interface.
+ * @wdev: wireless device.
+ * @twt_params: TWT session parameters.
+ */
+int inff_twt_oper(struct wiphy *wiphy, struct wireless_dev *wdev,
+		  struct inff_twt_params twt_params);
+
+#endif /* INFF_TWT_H */
-- 
2.25.1


