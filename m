Return-Path: <linux-wireless+bounces-27374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085EB7DC0F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878D6328227
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5682E0415;
	Tue, 16 Sep 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="op+EvfwB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098724A06A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061417; cv=none; b=HRd/HsjaM53meYsOM6TnLHdL+yutrwLrMSMlZVk3C6IeG0HOiCjx6rUf1v3ZjcigeASpS26AlWMxPZtpoBkwTDftLTjdWcwHkvHzEqxQ/7UzJsiEjZjXqA6oQ/13kmojHX6bblP+WMY9YI3v3filSLMMqrY5zjotF4jjGNwhKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061417; c=relaxed/simple;
	bh=9dUgtlnDvHnhqOlLYNJCsaDvif7KBNKXUYunIAdwiBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRHnQBRCOqEJMbQOT07MDwOGtQKcMy3kiWK6HsNUdkRoxuNf2pRggmUy51UVERfGHSDJUbw7cSLovE4xQXGT8bhDLZkV99YCMrs/wkArouAYkkXmmwHhs8ZsfxakmLW9FGQTv/7Dc3qguAIE4+O4ALEV9J8koFC0oeW7ihsBb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=op+EvfwB; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061413; x=1789597413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dUgtlnDvHnhqOlLYNJCsaDvif7KBNKXUYunIAdwiBE=;
  b=op+EvfwBte89EJRGqWDvEQTjFsmx4Of7xR6qmrKLh+CVPaI3cjq5ohsD
   uesVpyXFK4+rDX9VYeb7d5ZC7qdlCF6v4YQ37qDtuDqHk4GK8mTnfjYaa
   pogA3D1Khhkil4xv4ly2r4k9CArGJr2MDzvZHprJoyK6iaSSedvdcsKrf
   M=;
X-CSE-ConnectionGUID: iq+tX/YISk6kwKBQr+5CNg==
X-CSE-MsgGUID: r425f/KVQnyDBBQq2SFhBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918408"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918408"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:23:31 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:23:30 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:23:26 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 22/57] wifi: inffmac: add vendor.c/h
Date: Wed, 17 Sep 2025 03:47:39 +0530
Message-ID: <20250916221821.4387-25-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for exposing an Infineon OUI-based vendor nl80211
interface for allowing Infineon's vendor-specific WLAN operations from
the user space.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/vendor.c    |  338 +++++
 .../net/wireless/infineon/inffmac/vendor.h    |   54 +
 .../wireless/infineon/inffmac/vendor_inf.c    | 1344 +++++++++++++++++
 .../wireless/infineon/inffmac/vendor_inf.h    |  767 ++++++++++
 4 files changed, 2503 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor_inf.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor_inf.h

diff --git a/drivers/net/wireless/infineon/inffmac/vendor.c b/drivers/net/wireless/infineon/inffmac/vendor.c
new file mode 100644
index 000000000000..285a48504732
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/vendor.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+
+#include "fwil_types.h"
+#include "core.h"
+#include "p2p.h"
+#include "debug.h"
+#include "cfg80211.h"
+#include "vendor.h"
+#include "fwil.h"
+#include "common.h"
+#include "vendor_inf.h"
+
+static int inff_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
+						struct wireless_dev *wdev,
+						const void *data, int len)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	const struct inff_vndr_dcmd_hdr *cmdhdr = data;
+	struct sk_buff *reply;
+	unsigned int payload, ret_len;
+	void *dcmd_buf = NULL, *wr_pointer;
+	u16 msglen, maxmsglen = PAGE_SIZE - 0x100;
+	int ret;
+
+	if (len < sizeof(*cmdhdr)) {
+		inff_err("vendor command too short: %d\n", len);
+		return -EINVAL;
+	}
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	inff_dbg(TRACE, "ifidx=%d, cmd=%d\n", ifp->ifidx, cmdhdr->cmd);
+
+	if (cmdhdr->offset > len) {
+		inff_err("bad buffer offset %d > %d\n", cmdhdr->offset, len);
+		return -EINVAL;
+	}
+
+	len -= cmdhdr->offset;
+	ret_len = cmdhdr->len;
+	if (ret_len > 0 || len > 0) {
+		if (len > INFF_DCMD_MAXLEN) {
+			inff_err("oversize input buffer %d\n", len);
+			len = INFF_DCMD_MAXLEN;
+		}
+		if (ret_len > INFF_DCMD_MAXLEN) {
+			inff_err("oversize return buffer %d\n", ret_len);
+			ret_len = INFF_DCMD_MAXLEN;
+		}
+		payload = max_t(unsigned int, ret_len, len) + 1;
+		dcmd_buf = vzalloc(payload);
+		if (!dcmd_buf)
+			return -ENOMEM;
+
+		memcpy(dcmd_buf, (void *)cmdhdr + cmdhdr->offset, len);
+		*(char *)(dcmd_buf + len)  = '\0';
+	}
+
+	if (cmdhdr->cmd == INFF_C_SET_AP) {
+		if (*(int *)(dcmd_buf) == 1) {
+			ifp->vif->wdev.iftype = NL80211_IFTYPE_AP;
+			inff_net_setcarrier(ifp, true);
+		} else {
+			ifp->vif->wdev.iftype = NL80211_IFTYPE_STATION;
+		}
+		inff_cfg80211_update_proto_addr_mode(&vif->wdev);
+	}
+
+	if (cmdhdr->set)
+		ret = inff_fil_cmd_data_set(ifp, cmdhdr->cmd, dcmd_buf,
+					    ret_len);
+	else
+		ret = inff_fil_cmd_data_get(ifp, cmdhdr->cmd, dcmd_buf,
+					    ret_len);
+	if (ret != 0)
+		goto exit;
+
+	wr_pointer = dcmd_buf;
+	while (ret_len > 0) {
+		msglen = ret_len > maxmsglen ? maxmsglen : ret_len;
+		ret_len -= msglen;
+		payload = msglen + sizeof(msglen);
+		reply = cfg80211_vendor_cmd_alloc_reply_skb(wiphy, payload);
+		if (!reply) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		if (nla_put(reply, INFF_NLATTR_DATA, msglen, wr_pointer) ||
+		    nla_put_u16(reply, INFF_NLATTR_LEN, msglen)) {
+			kfree_skb(reply);
+			ret = -ENOBUFS;
+			break;
+		}
+
+		ret = cfg80211_vendor_cmd_reply(reply);
+		if (ret)
+			break;
+
+		wr_pointer += msglen;
+	}
+
+exit:
+	vfree(dcmd_buf);
+
+	return ret;
+}
+
+static int inff_cfg80211_vndr_cmds_int_get(struct inff_if *ifp,
+					   u32 cmd, struct wiphy *wiphy)
+{
+	struct sk_buff *reply;
+	int get_value = 0;
+	int ret;
+
+	ret = inff_fil_cmd_int_get(ifp, cmd, &get_value);
+	if (ret)
+		inff_err("Command %u get failure. Error :  %d\n", cmd, ret);
+
+	reply = cfg80211_vendor_cmd_alloc_reply_skb(wiphy, sizeof(int));
+	nla_put_nohdr(reply, sizeof(int), &get_value);
+	ret = cfg80211_vendor_cmd_reply(reply);
+	if (ret)
+		inff_err("Command %u failure. Error : %d\n", cmd, ret);
+	return ret;
+}
+
+static int inff_cfg80211_vndr_cmds_int_set(struct inff_if *ifp, int val, u32 cmd)
+{
+	int ret;
+
+	ret = inff_fil_cmd_int_set(ifp, cmd, val);
+	if (ret < 0)
+		inff_err("Command %u set failure. Error : %d\n", cmd, ret);
+	return ret;
+}
+
+static int inff_cfg80211_vndr_cmds_frameburst(struct wiphy *wiphy,
+					      struct wireless_dev *wdev,
+					      const void *data, int len)
+{
+	int ret;
+	int val = *(int *)data;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0x0 || val == 0x1) {
+		ret = inff_cfg80211_vndr_cmds_int_set(ifp, val,
+						      INFF_C_SET_FAKEFRAG);
+	} else if (val == 0xff) {
+		ret = inff_cfg80211_vndr_cmds_int_get(ifp,
+						      INFF_C_GET_FAKEFRAG,
+						      wiphy);
+	} else {
+		inff_err("Invalid Input\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+const struct wiphy_vendor_command inff_vendor_cmds[] = {
+	{
+		INFF_SUBCMD(DCMD,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_dcmd_handler)
+	},
+	{
+		INFF_SUBCMD(FRAMEBURST,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_frameburst)
+	},
+	{
+		INFF_SUBCMD(MUEDCA_OPT,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_muedca_opt)
+	},
+	{
+		INFF_SUBCMD(LDPC,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_ldpc_cap)
+	},
+	{
+		INFF_SUBCMD(AMSDU,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_amsdu)
+	},
+	{
+		INFF_SUBCMD(TWT,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    inff_vendor_attr_twt_policy,
+			    inff_cfg80211_vndr_cmds_twt),
+		.maxattr = INFF_VENDOR_ATTR_TWT_MAX
+	},
+	{
+		INFF_SUBCMD(OCE,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_oce_enable)
+	},
+	{
+		INFF_SUBCMD(BSSCOLOR,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_bss_color)
+	},
+	{
+		INFF_SUBCMD(RAND_MAC,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_randmac)
+	},
+	{
+		INFF_SUBCMD(MBO,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    inff_vendor_attr_mbo_policy,
+			    inff_cfg80211_vndr_cmds_mbo),
+		.maxattr = INFF_VENDOR_ATTR_MBO_MAX
+	},
+	{
+		INFF_SUBCMD(MPC,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_mpc)
+	},
+	{
+		INFF_SUBCMD(GIANTRX,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_giantrx)
+	},
+	{
+		INFF_SUBCMD(WNM,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    inff_vendor_attr_wnm_policy,
+			    inff_cfg80211_vndr_cmds_wnm_max_idle),
+		.maxattr = INFF_VENDOR_ATTR_WNM_MAX
+	},
+	{
+		INFF_SUBCMD(HWCAPS,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_hwcaps),
+	},
+	{
+		INFF_SUBCMD(WNM_WL_CAP,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_wnm_wl_cap)
+	},
+	{
+		INFF_SUBCMD(CMDSTR,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_str)
+	},
+	{
+		INFF_SUBCMD(PFN_CONFIG,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_config_pfn)
+	},
+	{
+		INFF_SUBCMD(PFN_STATUS,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_get_pfn_status)
+	},
+	{
+		INFF_SUBCMD(SSID_PROT,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    inff_vendor_attr_ssid_prot_policy,
+			    inff_cfg80211_vndr_cmds_ssid_prot),
+		.maxattr = INFF_VENDOR_ATTR_SSID_PROT_MAX
+	},
+	{
+		INFF_SUBCMD(MCHAN_CONFIG,
+			    (WIPHY_VENDOR_CMD_NEED_WDEV |
+			    WIPHY_VENDOR_CMD_NEED_NETDEV),
+			    VENDOR_CMD_RAW_DATA,
+			    inff_cfg80211_vndr_cmds_mchan_config)
+	},
+};
+
+const struct nl80211_vendor_cmd_info inff_vendor_events[] = {
+	INFF_SUBEVT(ICMP_ECHO_REQ)
+};
+
+int get_inff_num_vndr_cmds(void)
+{
+	int num = ARRAY_SIZE(inff_vendor_cmds);
+
+	return num;
+}
+
+int get_inff_num_vndr_evts(void)
+{
+	return ARRAY_SIZE(inff_vendor_events);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/vendor.h b/drivers/net/wireless/infineon/inffmac/vendor.h
new file mode 100644
index 000000000000..6e7d584d18a4
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/vendor.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_VENDOR_H
+#define INFF_VENDOR_H
+
+/**
+ * enum inff_nlattrs - nl80211 message attributes
+ *
+ * @INFF_NLATTR_LEN: message body length
+ * @INFF_NLATTR_DATA: message body
+ */
+enum inff_nlattrs {
+	INFF_NLATTR_UNSPEC,
+
+	INFF_NLATTR_LEN,
+	INFF_NLATTR_DATA,
+
+	__INFF_NLATTR_AFTER_LAST,
+	INFF_NLATTR_MAX = __INFF_NLATTR_AFTER_LAST - 1
+};
+
+/**
+ * struct inff_vndr_dcmd_hdr - message header for cfg80211 vendor command dcmd
+ *				support
+ *
+ * @cmd: common dongle cmd definition
+ * @len: length of expecting return buffer
+ * @offset: offset of data buffer
+ * @set: get or set request(optional)
+ * @magic: magic number for verification
+ */
+struct inff_vndr_dcmd_hdr {
+	uint cmd;
+	int len;
+	uint offset;
+	uint set;
+	uint magic;
+};
+
+extern const struct wiphy_vendor_command inff_vendor_cmds[];
+extern const struct nl80211_vendor_cmd_info inff_vendor_events[];
+s32 inff_wiphy_icmp_echo_req_event_handler(struct inff_if *ifp,
+					   const struct inff_event_msg *e,
+					   void *data);
+int get_inff_num_vndr_cmds(void);
+int get_inff_num_vndr_evts(void);
+
+#endif /* INFF_VENDOR_H */
diff --git a/drivers/net/wireless/infineon/inffmac/vendor_inf.c b/drivers/net/wireless/infineon/inffmac/vendor_inf.c
new file mode 100644
index 000000000000..4f9b896d4768
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/vendor_inf.c
@@ -0,0 +1,1344 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <net/netlink.h>
+#include "hw_ids.h"
+#include "core.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "fwil.h"
+#include "vendor_inf.h"
+#include "xtlv.h"
+#include "he.h"
+#include "twt.h"
+#include "pno.h"
+#include "bus.h"
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/jhash.h>
+#include <linux/hashtable.h>
+#include <linux/inet.h>
+#include "common.h"
+#include "chip.h"
+#include "offload.h"
+
+static const struct inff_vendor_cmdstr inff_vndr_cmdstr[] = {
+	{ "offload_config", inff_vndr_cmdstr_offload_config},
+	{ "mkeep_alive", inff_vndr_cmdstr_mkeep_alive},
+	{ "tko", inff_vndr_cmdstr_tko},
+	{ "icmp_echo_req", inff_vndr_cmdstr_icmp_echo_req},
+	{ NULL, NULL }
+};
+
+DEFINE_HASHTABLE(vndr_cmd_hashtbl, VNDR_CMD_HASH_BITS);
+
+static int inff_cfg80211_vndr_send_cmd_reply(struct wiphy *wiphy,
+					     const void  *data, int len)
+{
+	struct sk_buff *skb;
+
+	/* Alloc the SKB for vendor_event */
+	skb = cfg80211_vendor_cmd_alloc_reply_skb(wiphy, len);
+	if (unlikely(!skb)) {
+		inff_err("skb alloc failed\n");
+		return -ENOMEM;
+	}
+
+	/* Push the data to the skb */
+	nla_put_nohdr(skb, len, data);
+	return cfg80211_vendor_cmd_reply(skb);
+}
+
+int inff_vndr_cmdstr_hashtbl_init(void)
+{
+	int i;
+	u32 jhash_key;
+
+	inff_dbg(TRACE, "enter\n");
+
+	hash_init(vndr_cmd_hashtbl);
+
+	/* Initializing the VENDOR CMD hashtable with all the string commmands
+	 * and func_handler in inff_vndr_str_cmds
+	 */
+	for (i = 0; inff_vndr_cmdstr[i].name; i++) {
+		struct inff_vndr_cmdstr_hashtbl *vndr_hashtbl;
+
+		vndr_hashtbl = kzalloc(sizeof(*vndr_hashtbl), GFP_KERNEL);
+		if (!vndr_hashtbl)
+			return -ENOMEM;
+
+		vndr_hashtbl->vndr_cmd_addr = (struct inff_vendor_cmdstr *)&inff_vndr_cmdstr[i];
+		jhash_key = jhash(inff_vndr_cmdstr[i].name, strlen(inff_vndr_cmdstr[i].name), 0);
+		hash_add(vndr_cmd_hashtbl, &vndr_hashtbl->node, jhash_key);
+	}
+
+	return 0;
+}
+
+void inff_vndr_cmdstr_hashtbl_deinit(void)
+{
+	struct inff_vndr_cmdstr_hashtbl *vndr_hashtbl;
+	struct hlist_node *tmp_node;
+	int i;
+
+	hash_for_each_safe(vndr_cmd_hashtbl, i, tmp_node, vndr_hashtbl, node) {
+		hash_del(&vndr_hashtbl->node);
+		kfree(vndr_hashtbl);
+	}
+}
+
+static void
+inff_cfgvendor_twt_parse_params(const struct nlattr *attr_iter,
+				struct inff_twt_params *twt_params)
+{
+	int tmp, twt_param;
+	const struct nlattr *twt_param_iter;
+
+	nla_for_each_nested(twt_param_iter, attr_iter, tmp) {
+		twt_param = nla_type(twt_param_iter);
+		switch (twt_param) {
+		case INFF_VENDOR_ATTR_TWT_PARAM_NEGO_TYPE:
+			twt_params->negotiation_type = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_SETUP_CMD_TYPE:
+			twt_params->setup_cmd = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_DIALOG_TOKEN:
+			twt_params->dialog_token = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME:
+			twt_params->twt = nla_get_u64(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME_OFFSET:
+			twt_params->twt_offset = nla_get_u64(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION:
+			twt_params->min_twt = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_EXPONENT:
+			twt_params->exponent = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_MANTISSA:
+			twt_params->mantissa = nla_get_u16(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_REQUESTOR:
+			twt_params->requestor = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_TRIGGER:
+			twt_params->trigger = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_IMPLICIT:
+			twt_params->implicit = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_FLOW_TYPE:
+			twt_params->flow_type = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_FLOW_ID:
+			twt_params->flow_id = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_BCAST_TWT_ID:
+			twt_params->bcast_twt_id = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_PROTECTION:
+			twt_params->protection = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_CHANNEL:
+			twt_params->twt_channel = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_TWT_INFO_FRAME_DISABLED:
+			twt_params->twt_info_frame_disabled = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION_UNIT:
+			twt_params->min_twt_unit = nla_get_u8(twt_param_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAM_TEARDOWN_ALL_TWT:
+			twt_params->teardown_all_twt = nla_get_u8(twt_param_iter);
+			break;
+		default:
+			inff_dbg(TRACE, "Unknown TWT param %d, skipping\n",
+				 twt_param);
+			break;
+		}
+	}
+}
+
+int inff_cfg80211_vndr_cmds_twt(struct wiphy *wiphy, struct wireless_dev *wdev,
+				const void  *data, int len)
+{
+	int tmp, attr_type;
+	const struct nlattr *attr_iter;
+
+	struct inff_twt_params twt_params = {
+		.twt_oper = 0,
+		.negotiation_type = INFF_TWT_PARAM_NEGO_TYPE_ITWT,
+		.setup_cmd = INFF_TWT_OPER_SETUP_CMD_TYPE_REQUEST,
+		.dialog_token = 1,
+		.twt = 0,
+		.twt_offset = 0,
+		.requestor = 1,
+		.trigger = 0,
+		.implicit = 1,
+		.flow_type = 0,
+		.flow_id = 0,
+		.bcast_twt_id = 0,
+		.protection = 0,
+		.twt_channel = 0,
+		.twt_info_frame_disabled = 0,
+		.min_twt_unit = 0,
+		.teardown_all_twt = 0
+	};
+
+	nla_for_each_attr(attr_iter, data, len, tmp) {
+		attr_type = nla_type(attr_iter);
+
+		switch (attr_type) {
+		case INFF_VENDOR_ATTR_TWT_OPER:
+			twt_params.twt_oper = nla_get_u8(attr_iter);
+			break;
+		case INFF_VENDOR_ATTR_TWT_PARAMS:
+			inff_cfgvendor_twt_parse_params(attr_iter, &twt_params);
+			break;
+		default:
+			inff_dbg(TRACE, "Unknown TWT attribute %d, skipping\n",
+				 attr_type);
+			break;
+		}
+	}
+
+	return (int)inff_twt_oper(wiphy, wdev, twt_params);
+}
+
+int inff_cfg80211_vndr_cmds_bss_color(struct wiphy *wiphy,
+				      struct wireless_dev *wdev,
+				      const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	u8 val = *(u8 *)data;
+	u8 param[8] = {0};
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xa) {
+		ret = inff_he_get_bss_color(ifp, param, sizeof(param));
+		if (!ret)
+			inff_cfg80211_vndr_send_cmd_reply(wiphy, param, 1);
+	} else {
+		inff_dbg(INFO, "not support set bsscolor during runtime!\n");
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_muedca_opt(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	u8 val = *(u8 *)data;
+	u8 param[8] = {0};
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xa) {
+		ret = inff_he_get_muedca_opt(ifp, param, sizeof(param));
+		if (!ret)
+			inff_cfg80211_vndr_send_cmd_reply(wiphy, param, 1);
+	} else {
+		ret = inff_he_set_muedca_opt(ifp, val);
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_amsdu(struct wiphy *wiphy,
+				  struct wireless_dev *wdev,
+				  const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int val = *(s32 *)data;
+	s32 get_amsdu = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xa) {
+		ret = inff_fil_iovar_int_get(ifp, "amsdu", &get_amsdu);
+		if (ret) {
+			inff_err("get amsdu error:%d\n", ret);
+
+			return ret;
+		}
+
+		inff_dbg(INFO, "get amsdu: %d\n", get_amsdu);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy,
+						  &get_amsdu, sizeof(int));
+	} else {
+		ret = inff_fil_iovar_int_set(ifp, "amsdu", val);
+		if (ret)
+			inff_err("set amsdu error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_ldpc_cap(struct wiphy *wiphy,
+				     struct wireless_dev *wdev,
+				     const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int val = *(s32 *)data;
+	s32 buf = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xa) {
+		ret = inff_fil_iovar_int_get(ifp, "ldpc_cap", &buf);
+		if (ret) {
+			inff_err("get ldpc_cap error:%d\n", ret);
+
+			return ret;
+		}
+
+		inff_dbg(INFO, "get ldpc_cap: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		ret = inff_fil_iovar_int_set(ifp, "ldpc_cap", val);
+		if (ret)
+			inff_err("set ldpc_cap error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_oce_enable(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct inff_iov_buf *oce_iov;
+	struct inff_xtlv *oce_xtlv;
+	u8 val = *(u8 *)data;
+	u8 param[16] = {0};
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+	oce_iov = (struct inff_iov_buf *)param;
+	oce_iov->version = cpu_to_le16(INFF_OCE_IOV_VERSION);
+	oce_iov->id = cpu_to_le16(INFF_OCE_CMD_ENABLE);
+	oce_xtlv = (struct inff_xtlv *)oce_iov->data;
+
+	if (val == 0xa) {
+		/* To get fw iovars of the form "wl oce enable"
+		 * using iw, call the parent iovar "oce" with the subcmd
+		 * filled and passed along
+		 * ./iw dev wlan0 vendor recv 0x000319 0xf 0xa
+		 */
+		ret = inff_fil_iovar_data_get(ifp, "oce",
+					      param, sizeof(param));
+		if (ret) {
+			inff_err("get oce enable error:%d\n", ret);
+		} else {
+			inff_dbg(INFO,
+				 "get oce enable: %d\n", oce_xtlv->data[0]);
+			inff_cfg80211_vndr_send_cmd_reply(wiphy, oce_xtlv->data,
+							  sizeof(int));
+		}
+	} else {
+		oce_iov->len = cpu_to_le16(8);
+		oce_xtlv->id = cpu_to_le16(INFF_OCE_XTLV_ENABLE);
+		oce_xtlv->len = cpu_to_le16(1);
+		oce_xtlv->data[0] = val;
+		ret = inff_fil_iovar_data_set(ifp, "oce",
+					      param, sizeof(param));
+		if (ret)
+			inff_err("set oce enable error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_randmac(struct wiphy *wiphy,
+				    struct wireless_dev *wdev, const void *data, int len)
+{
+	int ret = 0;
+	struct inff_randmac iov_buf = {0};
+	u8 val = *(u8 *)data;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+	iov_buf.version = WL_RANDMAC_API_VERSION;
+	iov_buf.subcmd_id = WL_RANDMAC_SUBCMD_ENABLE;
+	iov_buf.len = offsetof(struct inff_randmac, data);
+
+	if (val == 0x1) {
+		/* To set fw iovars of the form "wl randmac enable" using iw, call the
+		 * parent iovar "randmac" with the subcmd filled and passed along
+		 * ./iw dev wlan0 vendor send 0x000319 0x11 0x1
+		 */
+		ret = inff_fil_bsscfg_data_set(ifp, "randmac", (void *)&iov_buf, iov_buf.len);
+		if (ret)
+			inff_err("Failed to set randmac enable: %d\n", ret);
+	} else if (val == 0x0) {
+		iov_buf.subcmd_id = WL_RANDMAC_SUBCMD_DISABLE;
+		/* To set fw iovars of the form "wl randmac disable" using iw, call the
+		 * parent iovar "randmac" with the subcmd filled and passed along
+		 * ./iw dev wlan0 vendor send 0x000319 0x11 0x0
+		 */
+		ret = inff_fil_bsscfg_data_set(ifp, "randmac", (void *)&iov_buf, iov_buf.len);
+		if (ret)
+			inff_err("Failed to set randmac disable: %d\n", ret);
+	} else if (val == 0xa) {
+		int result_data = 0;
+		struct inff_randmac *iov_resp = NULL;
+		u8 buf[64] = {0};
+		/* To get fw iovars of the form "wl randmac" using iw, call the
+		 * parent iovar "randmac" with the subcmd filled and passed along
+		 * ./iw dev wlan0 vendor recv 0x000319 0x11 0xa
+		 */
+		memcpy(buf, (void *)&iov_buf, iov_buf.len);
+		ret = inff_fil_iovar_data_get(ifp, "randmac", (void *)buf, sizeof(buf));
+		if (ret) {
+			inff_err("Failed to get randmac enable or disable: %d\n", ret);
+		} else {
+			iov_resp = (struct inff_randmac *)buf;
+			if (iov_resp->subcmd_id == WL_RANDMAC_SUBCMD_ENABLE)
+				result_data = 1;
+			inff_cfg80211_vndr_send_cmd_reply(wiphy, &result_data, sizeof(int));
+		}
+	}
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_mbo(struct wiphy *wiphy,
+				struct wireless_dev *wdev,
+				const void *data, int len)
+{
+	int ret = 0;
+	int tmp, attr_type, mbo_param;
+	const struct nlattr *attr_iter, *mbo_param_iter;
+
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct inff_iov_buf *mbo_iov;
+	struct inff_xtlv *mbo_xtlv;
+	u8 param[64] = {0};
+	u16 buf_len = 0, buf_len_start = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+	mbo_iov = (struct inff_iov_buf *)param;
+	mbo_iov->version = cpu_to_le16(INFF_MBO_IOV_VERSION);
+	mbo_xtlv = (struct inff_xtlv  *)mbo_iov->data;
+	buf_len_start = sizeof(param) - sizeof(struct inff_iov_buf);
+	buf_len = buf_len_start;
+
+	nla_for_each_attr(attr_iter, data, len, tmp) {
+		attr_type = nla_type(attr_iter);
+
+		switch (attr_type) {
+		case INFF_VENDOR_ATTR_MBO_CMD:
+			mbo_iov->id = cpu_to_le16(nla_get_u8(attr_iter));
+			break;
+		case INFF_VENDOR_ATTR_MBO_PARAMS:
+			nla_for_each_nested(mbo_param_iter, attr_iter, tmp) {
+				mbo_param = nla_type(mbo_param_iter);
+
+				switch (mbo_param) {
+				case INFF_VENDOR_ATTR_MBO_PARAM_OPCLASS:
+				{
+					u8 op_class;
+
+					op_class = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_OPCLASS,
+						       &op_class, sizeof(op_class),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_CHAN:
+				{
+					u8 chan;
+
+					chan = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_CHAN,
+						       &chan, sizeof(chan),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_PREFERENCE:
+				{
+					u8 pref;
+
+					pref = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_PREFERENCE,
+						       &pref, sizeof(pref),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_REASON_CODE:
+				{
+					u8 reason;
+
+					reason = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_REASON_CODE,
+						       &reason, sizeof(reason),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_CELL_DATA_CAP:
+				{
+					u8 cell_data_cap;
+
+					cell_data_cap = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_CELL_DATA_CAP,
+						       &cell_data_cap, sizeof(cell_data_cap),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_COUNTERS:
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_ENABLE:
+				{
+					u8 enable;
+
+					enable = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_ENABLE,
+						       &enable, sizeof(enable),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_SUB_ELEM_TYPE:
+				{
+					u8 type;
+
+					type = nla_get_u8(mbo_param_iter);
+					inff_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_SUB_ELEM_TYPE,
+						       &type, sizeof(type),
+						       (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_BTQ_TRIG_START_OFFSET:
+				case INFF_VENDOR_ATTR_MBO_PARAM_BTQ_TRIG_RSSI_DELTA:
+				case INFF_VENDOR_ATTR_MBO_PARAM_ANQP_CELL_SUPP:
+				case INFF_VENDOR_ATTR_MBO_PARAM_BIT_MASK:
+				case INFF_VENDOR_ATTR_MBO_PARAM_ASSOC_DISALLOWED:
+				case INFF_VENDOR_ATTR_MBO_PARAM_CELLULAR_DATA_PREF:
+					return -EOPNOTSUPP;
+				default:
+					inff_err("unknown mbo param attr:%d\n", mbo_param);
+					return -EINVAL;
+				}
+			}
+			break;
+		default:
+			inff_err("Unknown MBO attribute %d, skipping\n",
+				 attr_type);
+			return -EINVAL;
+		}
+	}
+
+	buf_len = buf_len_start - buf_len;
+	mbo_xtlv->len = cpu_to_le16(buf_len);
+	mbo_iov->len = cpu_to_le16(buf_len);
+	buf_len += sizeof(struct inff_iov_buf);
+	ret = inff_fil_iovar_data_set(ifp, "mbo", param, buf_len);
+
+	if (ret)
+		inff_err("set mbo enable error:%d\n", ret);
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_mpc(struct wiphy *wiphy,
+				struct wireless_dev *wdev,
+				const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int val = *(s32 *)data;
+	s32 buf = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xa) {
+		ret = inff_fil_iovar_int_get(ifp, "mpc", &buf);
+		if (ret) {
+			inff_err("get mpc error:%d\n", ret);
+			return ret;
+		}
+
+		inff_dbg(INFO, "get mpc: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		ret = inff_fil_iovar_int_set(ifp, "mpc", val);
+		if (ret)
+			inff_err("set mpc error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_giantrx(struct wiphy *wiphy,
+				    struct wireless_dev *wdev,
+				    const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int val = *(s32 *)data;
+	s32 buf = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xa) {
+		ret = inff_fil_iovar_int_get(ifp, "giantrx", &buf);
+		if (ret) {
+			inff_err("get giantrx error:%d\n", ret);
+			return ret;
+		}
+
+		inff_dbg(INFO, "get giantrx: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		inff_fil_cmd_int_set(ifp, INFF_C_DOWN, 1);
+		ret = inff_fil_iovar_int_set(ifp, "giantrx", val);
+		inff_fil_cmd_int_set(ifp, INFF_C_UP, 1);
+		if (ret)
+			inff_err("set giantrx error:%d\n", ret);
+	}
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_wnm_max_idle(struct wiphy *wiphy,
+					 struct wireless_dev *wdev,
+					 const void  *data, int len)
+{
+	int tmp, attr_type = 0, wnm_param = 0, ret = 0;
+	const struct nlattr *attr_iter, *wnm_param_iter;
+
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	u8 param[64] = {0}, get_info = 0;
+	u16 buf_len = 0, wnm_id = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	nla_for_each_attr(attr_iter, data, len, tmp) {
+		attr_type = nla_type(attr_iter);
+
+		switch (attr_type) {
+		case INFF_VENDOR_ATTR_WNM_CMD:
+			wnm_id = cpu_to_le16(nla_get_u8(attr_iter));
+			break;
+		case INFF_VENDOR_ATTR_WNM_PARAMS:
+			nla_for_each_nested(wnm_param_iter, attr_iter, tmp) {
+				wnm_param = nla_type(wnm_param_iter);
+				switch (wnm_param) {
+				case INFF_VENDOR_ATTR_WNM_PARAM_GET_INFO:
+				{
+					get_info = (int)nla_get_u8(wnm_param_iter);
+				}
+					break;
+				case INFF_VENDOR_ATTR_WNM_PARAM_IDLE_PERIOD:
+				{
+					int period;
+
+					period = (int)nla_get_u8(wnm_param_iter);
+					memcpy(&param[buf_len], &period, sizeof(period));
+					buf_len += sizeof(period);
+				}
+					break;
+				case INFF_VENDOR_ATTR_WNM_PARAM_PROTECTION_OPT:
+				{
+					int option;
+
+					option = (int)nla_get_u8(wnm_param_iter);
+					memcpy(&param[buf_len], &option, sizeof(option));
+					buf_len += sizeof(option);
+				}
+					break;
+				default:
+					inff_err("unknown wnm param attr:%d\n", wnm_param);
+					return -EINVAL;
+				}
+			}
+			break;
+		default:
+			inff_err("Unknown wnm attribute %d, skipping\n",
+				 attr_type);
+			return -EINVAL;
+		}
+	}
+
+	switch (wnm_id) {
+	case INFF_WNM_CMD_IOV_WNM_MAXIDLE:
+	{
+		if (get_info) {
+			int get_period = 0;
+
+			ret = inff_fil_iovar_int_get(ifp, "wnm_maxidle", &get_period);
+			if (!ret)
+				ret = inff_cfg80211_vndr_send_cmd_reply(wiphy,
+									&get_period,
+									sizeof(get_period));
+		} else {
+			ret = inff_fil_iovar_data_set(ifp, "wnm_maxidle", param, buf_len);
+		}
+	}
+	break;
+
+	default:
+		inff_err("unsupport wnm cmd:%d\n", wnm_id);
+		return -EINVAL;
+	}
+
+	if (ret)
+		inff_err("wnm %s error:%d\n", get_info ? "get" : "set", ret);
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_hwcaps(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
+				   const void *data, int len)
+{
+	int ret = 0, i;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct inff_bus *bus_if;
+	s32 buf[INFF_VENDOR_HW_CAPS_MAX] = {0};
+	struct inff_chip *ci;
+	struct inff_chip_specific *chip_spec;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+	bus_if = ifp->drvr->bus_if;
+	ci = bus_if->chip_pub;
+	chip_spec = &ci->chip_spec;
+
+	if (chip_spec->hw_caps_replaycnts) {
+		buf[INFF_VENDOR_HW_CAPS_REPLAYCNTS] = chip_spec->hw_caps_replaycnts;
+	} else {
+		inff_err("chip:%d doesn't specify hw_caps_replaycnts\n", ci->chip);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = inff_cfg80211_vndr_send_cmd_reply(wiphy, buf, sizeof(int));
+	if (ret) {
+		inff_dbg(INFO, "get HW capability error %d\n", ret);
+	} else {
+		for (i = 0; i < INFF_VENDOR_HW_CAPS_MAX; i++)
+			inff_dbg(INFO, "get %s: %d\n", hw_caps_name[i], buf[i]);
+	}
+
+done:
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_wnm_wl_cap(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len)
+{
+	int ret = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int val = *(s32 *)data;
+	s32 buf = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (val == 0xffff) {
+		ret = inff_fil_iovar_int_get(ifp, "wnm", &buf);
+		if (ret) {
+			inff_err("get wnm_wl_cap error:%d\n", ret);
+			return ret;
+		}
+
+		inff_dbg(INFO, "get wnm_wl_cap: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		ret = inff_fil_iovar_int_set(ifp, "wnm", val);
+		if (ret)
+			inff_err("set wnm_wl_cap error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+int inff_vndr_cmdstr_offload_config(struct wiphy *wiphy, struct wireless_dev *wdev,
+				    char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+				    long cmd_val[VNDR_CMD_VAL_NUM])
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int ret = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	/* IW CMDSTR TEMPLATE.
+	 * echo 'offload_config Enable 1 ' | \
+	 * iw dev wlan0 vendor send 0x000319 0x1C -
+	 *
+	 * echo 'offload_config Profile LowPwr 1 -s 0x3df ' | \
+	 * iw dev wlan0 vendor send 0x000319 0x1C -
+	 *
+	 */
+	if (inff_cfg80211_get_iftype(ifp) == NL80211_IFTYPE_STATION &&
+	    inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS)) {
+		if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 6) &&
+		    (memcmp(cmd_str[1], "Enable", 6)) == 0 &&
+		    (cmd_val[0] == 0 || cmd_val[0] == 1)) {
+			inff_offload_enable(ifp, inff_offload_feat, cmd_val[0]);
+		} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 7) &&
+				(memcmp(cmd_str[1], "Profile", 7)) == 0) {
+			if (cmd_str[2][0] != '\0') {
+				unsigned int ol_prof;
+
+				if ((strlen(cmd_str[2]) == 6) &&
+				    (memcmp(cmd_str[2], "LowPwr", 6)) == 0) {
+					ol_prof = INFF_OFFLOAD_PROF_TYPE_LOW_PWR;
+				} else if ((strlen(cmd_str[2]) == 6) &&
+					   (memcmp(cmd_str[2], "MidPwr", 6)) == 0) {
+					ol_prof = INFF_OFFLOAD_PROF_TYPE_MID_PWR;
+				} else if ((strlen(cmd_str[2]) == 7) &&
+					   (memcmp(cmd_str[2], "HighPwr", 7)) == 0) {
+					ol_prof = INFF_OFFLOAD_PROF_TYPE_HIGH_PWR;
+				} else {
+					inff_err("unknown offload_config Profile attr\n");
+					return -EINVAL;
+				}
+				if (cmd_str[3][0] != '\0' && (strlen(cmd_str[3]) == 2) &&
+				    (memcmp(cmd_str[3], "-s", 2)) == 0)
+					inff_offload_config(ifp, ~cmd_val[1], ol_prof, cmd_val[0]);
+				else
+					inff_offload_config(ifp, inff_offload_feat, ol_prof,
+							    cmd_val[0]);
+			} else {
+				inff_err("unknown offload_config Profile attr\n");
+				return -EINVAL;
+			}
+		} else {
+			inff_err("unknown offload_config attr\n");
+			return -EINVAL;
+		}
+	} else {
+		inff_err("Offload unsupported for iface %d\n", inff_cfg80211_get_iftype(ifp));
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+int inff_vndr_cmdstr_mkeep_alive(struct wiphy *wiphy, struct wireless_dev *wdev,
+				 char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+				 long *cmd_val)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int ret = 0;
+	bool immed_flag = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	/* NULL Keep-Alive
+	 * echo 'mkeep_alive 0 1000 ' | \
+	 * iw dev wlan0 vendor send 0x000319 0x1C -
+	 *
+	 * NAT Keep-Alive
+	 * echo 'mkeep_alive 0 1000 0x080027b1050a00904c3104
+	 * 0008004500001e000040004011c52a0a8830700a88302513c
+	 * 413c5000a00000a0d ' | \
+	 * iw dev wlan0 vendor send 0x000319 0x1C -
+	 */
+	if (cmd_val[0] < 0 || cmd_val[0] > 4 || cmd_val[1] < 0) {
+		inff_err("Invalid command value\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 9) &&
+	    (memcmp(cmd_str[1], "immediate", 9)) == 0)
+		immed_flag = 1;
+
+	ret = inff_offload_configure_mkeep_alive(ifp, immed_flag, &cmd_val[0],
+						 &cmd_val[1], &cmd_val[2],
+						 VNDR_CMD_VAL_NUM);
+exit:
+	return ret;
+}
+
+int inff_vndr_cmdstr_tko(struct wiphy *wiphy, struct wireless_dev *wdev,
+			 char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+			 long *cmd_val)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int ret = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 5) &&
+	    (memcmp(cmd_str[1], "param", 5) == 0) &&
+	    (cmd_val[0] >= 0 && cmd_val[1] >= 0 &&
+	     cmd_val[2] >= 0 && cmd_val[3] >= 0)) {
+		/* echo 'tko param 10 4 10 0 ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		ret = inff_offload_configure_tko(ifp, WL_TKO_SUBCMD_PARAM,
+						 &cmd_val[0], &cmd_val[1],
+						 &cmd_val[2], &cmd_val[3]);
+	} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 6) &&
+		   (memcmp(cmd_str[1], "enable", 6) == 0) &&
+		   (cmd_val[0] == 0 || cmd_val[0] == 1)) {
+		/* echo 'tko enable 1 ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		ret = inff_offload_configure_tko(ifp, WL_TKO_SUBCMD_ENABLE,
+						 &cmd_val[0], NULL, NULL, NULL);
+	} else {
+		inff_err("Invalid tko command format\n");
+		ret =  -EINVAL;
+	}
+
+	return ret;
+}
+
+/* inff_vndr_cmd_str_parse_ip()
+ * Get ip version. based on the ip version parse the command string into IP.
+ * In Param
+ * @cmd_str - String to be parsed.
+ * @ip_addr - Parsed IP address storage.
+ * Out Param
+ * @ip_ver -  Pointer to IP version.
+ * Return
+ * true - success.
+ * false - otherwise.
+ */
+static
+int inff_vndr_cmdstr_parse_ip(char *cmd_str, u8 *ip_addr, u8 *ip_ver)
+{
+	if (in4_pton(cmd_str, strlen(cmd_str), ip_addr, -1, NULL)) {
+		*ip_ver = INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V4;
+		inff_dbg(INFO, "Peer IP Version: %d Peer IPv4 Address: %pI4\n",
+			 *ip_ver, ip_addr);
+		return true;
+	} else if (in6_pton(cmd_str, strlen(cmd_str), ip_addr, -1, NULL)) {
+		*ip_ver = INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V6;
+		inff_dbg(INFO, "Peer IP Version: %d Peer IPv6 Address: %pI6\n",
+			 *ip_ver, ip_addr);
+		return true;
+	}
+
+	return false;
+}
+
+int inff_vndr_cmdstr_icmp_echo_req(struct wiphy *wiphy, struct wireless_dev *wdev,
+				   char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+				   long *cmd_val)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_cfg80211_info *cfg;
+	struct inff_if *ifp;
+	bool is_ip = false;
+	u8 cmd_type, enable = 0, ip_ver;
+	u32 periodicity = 0, duration = 0;
+	u8 ip_addr[INFF_IPV6_ADDR_LEN];
+	u8 mac_addr[ETH_ALEN];
+	struct inff_icmp_echo_req_get_info *icmp_echo_req_get_info;
+	int ret = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	cfg = ifp->drvr->config;
+
+	if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 6) &&
+	    (memcmp(cmd_str[1], "enable", 6) == 0) &&
+	     (cmd_val[0] == 0 || cmd_val[0] == 1)) {
+		/* echo 'icmp_echo_req enable 0/1 ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		cmd_type = INFF_OFFLOAD_ICMP_ECHO_REQ_ENAB;
+		enable = cmd_val[0];
+		inff_dbg(INFO, "Cmd Type: %d enable: %d\n", cmd_type, enable);
+	} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 3) &&
+		   (memcmp(cmd_str[1], "add", 3)) == 0) {
+		/* echo 'icmp_echo_req add <peer_ip> <peer_mac> <periodicity> <duration> ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		cmd_type = INFF_OFFLOAD_ICMP_ECHO_REQ_ADD;
+		is_ip = true;
+
+		if (cmd_str[3][0] != '\0') {
+			if (!mac_pton(cmd_str[3], mac_addr)) {
+				inff_err("Invalid icmp_echo_req peer MAC address\n");
+				return -EINVAL;
+			}
+		}
+
+		if (cmd_val[0] >= 0 && cmd_val[1] >= 0) {
+			periodicity = cmd_val[0];
+			duration = cmd_val[1];
+		}
+		inff_dbg(INFO, "Cmd Type: %d MAC Address: %pM Periodicity: %d Duration: %d\n",
+			 cmd_type, mac_addr, periodicity, duration);
+	} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 3) &&
+		   (memcmp(cmd_str[1], "del", 3)) == 0) {
+		/* echo 'icmp_echo_req del <peer_ip> ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		cmd_type = INFF_OFFLOAD_ICMP_ECHO_REQ_DEL;
+		is_ip = true;
+		inff_dbg(INFO, "Cmd Type: %d\n", cmd_type);
+	} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 5) &&
+		   (memcmp(cmd_str[1], "start", 5)) == 0) {
+		/* echo 'icmp_echo_req start <peer_ip> ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		cmd_type = INFF_OFFLOAD_ICMP_ECHO_REQ_START;
+		is_ip = true;
+		inff_dbg(INFO, "Cmd Type: %d\n", cmd_type);
+	} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 4) &&
+		   (memcmp(cmd_str[1], "stop", 4)) == 0) {
+		/* echo 'icmp_echo_req stop <peer_ip> ' | \
+		 * iw dev wlan0 vendor send 0x000319 0x1C -
+		 */
+		cmd_type = INFF_OFFLOAD_ICMP_ECHO_REQ_STOP;
+		is_ip = true;
+		inff_dbg(INFO, "Cmd type: %d\n", cmd_type);
+
+	} else if (cmd_str[1][0] != '\0' && (strlen(cmd_str[1]) == 4) &&
+		   (memcmp(cmd_str[1], "info", 4)) == 0) {
+		 /* echo 'icmp_echo_req info <peer_ip> ' | \
+		  * iw dev wlan0 vendor recv 0x000319 0x1C -
+		  *
+		  * echo 'icmp_echo_req info all ' | \
+		  * iw dev wlan0 vendor recv 0x000319 0x1C -
+		  */
+		cmd_type = INFF_OFFLOAD_ICMP_ECHO_REQ_INFO;
+
+		if (cmd_str[2][0] != '\0' && (strlen(cmd_str[2]) == 3) &&
+		    (memcmp(cmd_str[2], "all", 3)) == 0)
+			ip_ver = INFF_OFFLOAD_ICMP_ECHO_REQ_IP_BOTH;
+		else
+			is_ip = true;
+		inff_dbg(INFO, "Cmd Type: %d\n", cmd_type);
+	} else {
+		inff_err("Invalid icmp_echo_req command format\n");
+		return -EINVAL;
+	}
+
+	if (is_ip && (cmd_str[2][0] != '\0')) {
+		if (!inff_vndr_cmdstr_parse_ip(cmd_str[2], ip_addr, &ip_ver)) {
+			inff_err("Invalid  peer IP address\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = inff_offload_configure_icmp_echo_req(ifp, cmd_type, enable, ip_addr,
+						   ip_ver, mac_addr, periodicity,
+						   duration);
+	if (!ret && cmd_type == INFF_OFFLOAD_ICMP_ECHO_REQ_INFO) {
+		icmp_echo_req_get_info = (struct inff_icmp_echo_req_get_info *)cfg->extra_buf;
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, (void *)icmp_echo_req_get_info,
+						  icmp_echo_req_get_info->length);
+	}
+
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_str(struct wiphy *wiphy, struct wireless_dev *wdev,
+				const void *data, int len)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct inff_vndr_cmdstr_hashtbl *hash_entry;
+	u32 jhash_key;
+	int ret = 0, idx_str = 0, idx_val = 0;
+	unsigned long val;
+	char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN];
+	long *cmd_val = NULL;
+	char *tok = NULL, *buf = NULL;
+
+	cmd_val = kzalloc(sizeof(*cmd_val) * VNDR_CMD_VAL_NUM, GFP_KERNEL);
+	if (!cmd_val)
+		return -ENOMEM;
+
+	buf = (char *)data;
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	memset(cmd_str, '\0', VNDR_CMD_STR_NUM * VNDR_CMD_STR_MAX_LEN * sizeof(char));
+	memset(cmd_val, -1, VNDR_CMD_VAL_NUM * sizeof(*cmd_val));
+
+	while (idx_str < VNDR_CMD_STR_NUM && idx_val < VNDR_CMD_VAL_NUM &&
+	       ((tok = strsep(&buf, " ")) != NULL)) {
+		if (kstrtol(tok, 10, &val) == 0) {
+			cmd_val[idx_val] = val;
+			idx_val++;
+		} else if ((strncmp(tok, "0x", 2) == 0) || (strncmp(tok, "0X", 2) == 0)) {
+			if (kstrtol(tok, 16, &val) == 0) {
+				cmd_val[idx_val] = val;
+				idx_val++;
+
+			} else if (strnlen(tok, VNDR_CMD_VAL_NUM) >= 20) {
+			/* For larger input hex, split the hex pattern into 2 bytes each
+			 * and store it individually.
+			 */
+				tok = tok + 2;/* Skip past 0x */
+				if (strlen(tok) % 2 != 0) {
+					inff_err("Data invalid format. Even length required\n");
+					ret = -EINVAL;
+					goto exit;
+				}
+				while (*tok != '\0') {
+					char num[3];
+
+					if (idx_val >= VNDR_CMD_VAL_NUM) {
+						inff_err("pkt header hex length exceeded\n");
+						ret = -EINVAL;
+						goto exit;
+					}
+					memcpy(num, tok, 2);
+					num[2] = '\0';
+					if (kstrtol(num, 16, &val) == 0) {
+						cmd_val[idx_val] = val;
+					} else {
+						inff_err("Invalid hex pkt data\n");
+						ret = -EINVAL;
+						goto exit;
+					}
+					tok += 2;
+					idx_val++;
+				}
+				cmd_val[idx_val] = ' ';
+			} else {
+				inff_err("Failed to parse hex token\n");
+				ret = -EINVAL;
+				goto exit;
+			}
+		} else if (strnlen(tok, VNDR_CMD_STR_MAX_LEN) <= VNDR_CMD_STR_MAX_LEN) {
+			strscpy(cmd_str[idx_str], tok, strnlen(tok, VNDR_CMD_STR_MAX_LEN));
+			idx_str++;
+		} else {
+			inff_err("Failed to parse token\n");
+			ret = -EINVAL;
+			goto exit;
+		}
+	}
+	if (idx_str >= VNDR_CMD_STR_NUM || idx_val >= VNDR_CMD_VAL_NUM) {
+		inff_err("CMD parameter limit exceeded\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+	/* Run the user cmd string input via Jenkins hash to pass and search the entry in
+	 * vendor cmd hashtable initialized at load time.
+	 */
+	jhash_key = jhash(cmd_str[0], strlen(cmd_str[0]), 0);
+
+	/* Search the user entered vndr cmd entry in the hash table and call its corresponding
+	 * function handler.
+	 */
+	hash_for_each_possible(vndr_cmd_hashtbl, hash_entry, node, jhash_key) {
+		if (hash_entry->vndr_cmd_addr &&
+		    (strlen(cmd_str[0]) == strlen(hash_entry->vndr_cmd_addr->name)) &&
+		    memcmp(hash_entry->vndr_cmd_addr->name, cmd_str[0],
+			   strlen(hash_entry->vndr_cmd_addr->name)) == 0) {
+			ret = hash_entry->vndr_cmd_addr->func(wiphy, wdev,
+					cmd_str, cmd_val);
+			break;
+		}
+	}
+
+exit:
+	kfree(cmd_val);
+	return ret;
+}
+
+int inff_cfg80211_vndr_cmds_config_pfn(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len)
+{
+	int buflen;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct drv_config_pfn_params *pfn_data;
+
+	inff_dbg(TRACE, "Enter pfn_enable %d Network_blob count %d\n",
+		 cfg->pfn_enable, *((u8 *)data));
+
+	cfg->pfn_enable = 1;
+	pfn_data = (struct drv_config_pfn_params *)data;
+	cfg->pfn_data.pfn_config = pfn_data->pfn_config;
+	cfg->pfn_data.count = pfn_data->count;
+
+	if (cfg->pfn_data.count > INFF_PNO_MAX_PFN_COUNT) {
+		inff_dbg(TRACE, "Not in range. Max 16 ssids allowed to add in pfn list");
+		cfg->pfn_data.count = INFF_PNO_MAX_PFN_COUNT;
+	}
+
+	buflen = cfg->pfn_data.count * sizeof(struct network_blob);
+	cfg->pfn_data.network_blob_data = kmalloc(buflen, GFP_KERNEL);
+	memset(cfg->pfn_data.network_blob_data, '\0', buflen);
+	memcpy(cfg->pfn_data.network_blob_data, (u8 *)data + PFN_CONFIG_AND_COUNT_SIZE, buflen);
+	pfn_send_network_blob_fw(wiphy, wdev);
+	inff_dbg(TRACE, "Exit\n");
+	return 0;
+}
+
+int inff_cfg80211_vndr_cmds_get_pfn_status(struct wiphy *wiphy,
+					   struct wireless_dev *wdev,
+					   const void *data, int len)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	u8 *buf = NULL;
+	struct inff_bss_info_le *bi = NULL;
+	int err = 0, i = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct network_blob *network_blob_data = NULL;
+	struct inff_chan ch;
+	struct pfn_conn_info curr_bssid;
+
+	inff_dbg(TRACE, "Enter\n");
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+	if (cfg->pfn_enable != 1)
+		return 0;
+	buf = kzalloc(WL_BSS_INFO_MAX, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	*(u32 *)buf = cpu_to_le32(WL_BSS_INFO_MAX);
+	err = inff_fil_cmd_data_get(ifp, INFF_C_GET_BSS_INFO,
+				    buf, WL_BSS_INFO_MAX);
+	if (err) {
+		inff_err("pfn_status buf error:%d\n", err);
+		return err;
+	}
+	bi = (struct inff_bss_info_le *)(buf + 4);
+	memset(&curr_bssid, '\0', sizeof(struct pfn_conn_info));
+
+	if (bi->SSID_len > 0) {
+		memcpy(curr_bssid.SSID, bi->SSID, bi->SSID_len);
+		memcpy(curr_bssid.BSSID, bi->BSSID, ETH_ALEN);
+		curr_bssid.SSID_len = bi->SSID_len;
+		curr_bssid.RSSI = bi->RSSI;
+		curr_bssid.phy_noise = bi->phy_noise;
+		ch.chspec = le16_to_cpu(bi->chanspec);
+		cfg->d11inf.decchspec(&ch);
+		curr_bssid.channel = ch.control_ch_num;
+		curr_bssid.SNR = bi->SNR;
+
+		network_blob_data = cfg->pfn_data.network_blob_data;
+		for (; i < cfg->pfn_data.count && network_blob_data; i++) {
+			if (!strncmp(network_blob_data->ssid, bi->SSID, bi->SSID_len)) {
+				curr_bssid.proto = network_blob_data->proto;
+				curr_bssid.key_mgmt = network_blob_data->key_mgmt;
+				break;
+			}
+			network_blob_data++;
+		}
+	}
+	if (curr_bssid.SSID_len)
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, (void *)&curr_bssid,
+						  sizeof(struct pfn_conn_info));
+	kfree(buf);
+	inff_dbg(TRACE, "Exit\n");
+	return 0;
+}
+
+int inff_cfg80211_vndr_cmds_mchan_config(struct wiphy *wiphy,
+					 struct wireless_dev *wdev,
+					 const void *data, int len)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	u8 val = *(u8 *)data;
+
+	inff_dbg(TRACE, "enter, config: %d\n", val);
+
+	if (val <= INFF_MCHAN_CONF_AUDIO)
+		cfg->mchan_conf = val;
+
+	return 0;
+}
+
+int inff_cfg80211_vndr_cmds_ssid_prot(struct wiphy *wiphy,
+				      struct wireless_dev *wdev,
+				      const void *data, int len)
+{
+	int ret = 0;
+	int val = 0;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	const struct nlattr *attr_iter;
+	int tmp, attr_type = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	nla_for_each_attr(attr_iter, data, len, tmp) {
+		attr_type = nla_type(attr_iter);
+		if (attr_type == INFF_VENDOR_ATTR_SSID_PROT_ENABLE) {
+			val = nla_get_u8(attr_iter);
+			ret = inff_fil_iovar_int_set(ifp, "ssid_protection", val);
+			if (ret < 0)
+				inff_err("Failed set ssid_protection, ret=%d\n", ret);
+			else
+				inff_dbg(INFO, "ssid_protection is %s\n",
+					 val ? "enabled" : "disabled");
+		}
+	}
+	return ret;
+}
+
+int
+inff_cfg80211_vndr_evt_icmp_echo_req(struct wiphy *wiphy, struct wireless_dev *wdev,
+				     const void *data, int len)
+{
+	struct sk_buff *skb;
+
+	skb = cfg80211_vendor_event_alloc(wiphy, wdev, len, SEVT(ICMP_ECHO_REQ), GFP_KERNEL);
+	if (!skb) {
+		inff_dbg(EVENT, "NO MEM: can't allocate skb for vendor ICMP ECHO REQ EVENT\n");
+		return -ENOMEM;
+	}
+
+	if (nla_put(skb, NL80211_ATTR_VENDOR_DATA, len, data)) {
+		kfree_skb(skb);
+		inff_err("NO ROOM in skb for ICMP_ECHO_REQ_EVENT\n");
+		return -EMSGSIZE;
+	}
+
+	cfg80211_vendor_event(skb, GFP_KERNEL);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/vendor_inf.h b/drivers/net/wireless/infineon/inffmac/vendor_inf.h
new file mode 100644
index 000000000000..19cd22a80525
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/vendor_inf.h
@@ -0,0 +1,767 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2022-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_VENDOR_INF_H
+#define INFF_VENDOR_INF_H
+
+#include <net/netlink.h>
+#include <net/cfg80211.h>
+
+/* This file is a registry of identifier assignments from the Infineon
+ * OUI 00:03:19 for purposes other than MAC address assignment. New identifiers
+ * can be assigned through normal review process for changes to the upstream
+ * hostap.git repository.
+ */
+#define OUI_INF		0x000319
+
+#define SCMD(_CMD)	INFF_VENDOR_SCMD_##_CMD
+#define INFF_SUBCMD(_CMD, _FLAGS, _POLICY, _FN) \
+	{	\
+		.vendor_id = OUI_INF,	\
+		.subcmd = SCMD(_CMD)	\
+	},	\
+	.flags = (_FLAGS),	\
+	.policy = (_POLICY),	\
+	.doit = (_FN)
+
+#define SEVT(_EVT)	INFF_VENDOR_SEVT_##_EVT
+#define INFF_SUBEVT(_EVT) \
+	{	\
+		.vendor_id = OUI_INF,	\
+		.subcmd = SEVT(_EVT)	\
+	},
+
+struct inff_iov_buf {
+	u16	version;
+	u16	len;
+	u16	id;
+	u16	data[];
+};
+
+/*
+ * enum inff_nl80211_vendor_subcmds - INF nl80211 vendor command identifiers
+ *
+ * @INFF_VENDOR_SCMD_UNSPEC: Reserved value 0
+ *
+ * @INFF_VENDOR_SCMD_DCMD: Handle the Dongle commands triggered from the userspace utilities.
+ *	These commands will be passed to the Dongle for processing.
+ *
+ * @INFF_VENDOR_SCMD_FRAMEBURST: Control the Frameburst feature. This feature allows more
+ *	efficient use of the airtime between the transmitting and receiving WLAN devices.
+ *
+ * @INFF_VENDOR_SCMD_ACS: Configure the Automatic Channel Selection (ACS) feature.
+ *
+ * @INFF_VENDOR_SCMD_SET_MAC_P2P_DEV: Set MAC address for a P2P Discovery device.
+ *	Uses Vendor attribute INFF_VENDOR_ATTR_MAC_ADDR to pass the MAC address.
+ *
+ * @INFF_VENDOR_SCMD_MUEDCA_OPT: Configure Multi User Enhanced Distrubuted Channel Access (MU-EDCA).
+ *
+ * @INFF_VENDOR_SCMD_LDPC: Enable support for handling Low Density Parity Check (LDPC) Coding
+ *	in received payload.
+ *
+ * @INFF_VENDOR_SCMD_AMSDU: Control AMSDU aggregation for both TX & RX on all the TID queues.
+ *
+ * @INFF_VENDOR_SCMD_TWT: Configure Target Wake Time (TWT) Session with the needed parameters.
+ *	Uses Vendor attributes defined in the enum inff_vendor_attr_twt.
+ *
+ * @INFF_VENDOR_SCMD_OCE: Configure the Optimized Connectivity Experience (OCE) functionality
+ *	related parameters.
+ *
+ * @INFF_VENDOR_SCMD_BSSCOLOR: Set BSS Color (1-63) for AP Mode operation in HE.
+ *
+ * @INFF_VENDOR_SCMD_RAND_MAC: Configure the Random MAC module.
+ *
+ * @INFF_VENDOR_SCMD_MBO: Configure Multi Band Operation (MBO) functionality related parameters.
+ *
+ * @INFF_VENDOR_SCMD_MPC: Control the Minimum Power Consumption (MPC) feature.
+ *	This is a STA-only power saving feature and not related to 802.11 power save.
+ *
+ * @INFF_VENDOR_SCMD_GIANTRX: Allow handling RX MGMT Packts of size 1840 bytes.
+ *
+ * @INFF_VENDOR_SCMD_PFN_CONFIG: Send the Preferred Network (PFN) information to the Dongle
+ *
+ * @INFF_VENDOR_SCMD_PFN_STATUS: Fetch the Preferred Network (PFN) information from the Dongle
+ *	through the driver.
+ *
+ * @INFF_VENDOR_SCMD_WNM: Configure the Wireless Network Management (WNM) 802.11v functionaltiy
+ *	related parameters.
+ *
+ * @INFF_VENDOR_SCMD_HWCAPS: Get device's capability.
+ *
+ * @INFF_VENDOR_SCMD_CMDSTR: New vendor string infra subcmd to handle user supplied strings.
+ *	String parsing and calling corresponding function handler for a specific command
+ *	given by user.
+ *
+ * @INFF_VENDOR_SCMD_SSID_PROT: Vendor command to enable/disable SSID protection
+ *
+ * @INFF_VENDOR_SCMD_MAX: This acts as a the tail of cmds list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_nl80211_vendor_subcmds {
+	SCMD(UNSPEC)		= 0,
+	SCMD(DCMD)		= 1,
+	SCMD(RSV2)		= 2,
+	SCMD(RSV3)		= 3,
+	SCMD(RSV4)		= 4,
+	SCMD(RSV5)		= 5,
+	SCMD(FRAMEBURST)	= 6,
+	SCMD(RSV7)		= 7,
+	SCMD(RSV8)		= 8,
+	SCMD(ACS)		= 9,
+	SCMD(SET_MAC_P2P_DEV)	= 10,
+	SCMD(MUEDCA_OPT)	= 11,
+	SCMD(LDPC)		= 12,
+	SCMD(AMSDU)		= 13,
+	SCMD(TWT)		= 14,
+	SCMD(OCE)		= 15,
+	SCMD(BSSCOLOR)		= 16,
+	SCMD(RAND_MAC)		= 17,
+	SCMD(MBO)		= 18,
+	SCMD(MPC)		= 19,
+	SCMD(GIANTRX)		= 20,
+	SCMD(PFN_CONFIG)	= 21,
+	SCMD(PFN_STATUS)	= 22,
+	SCMD(RSV22)		= 23,
+	SCMD(RSV24)		= 24,
+	SCMD(WNM)		= 25,
+	SCMD(HWCAPS)		= 26,
+	SCMD(WNM_WL_CAP)	= 27,
+	SCMD(CMDSTR)		= 28,
+	SCMD(SSID_PROT)		= 30,
+	SCMD(MCHAN_CONFIG)	= 31,
+	SCMD(MAX)		= 32
+};
+
+/**
+ * enum inff_nl80211_vendor_events - INFF NL80211 Event identifiers
+ *
+ * @INFF_VENDOR_SCMD_UNPEC: Reserved value 0
+ *
+ * @INFF_VENDOR_SCMD_ICMP_ECHO_REQ
+ *	ICMP Echo Request Event
+ *
+ * @INFF_VENDOR_SCMD_MAX: This acts as a the tail of cmds list.
+ *      Make sure it located at the end of the list.
+ *
+ */
+enum inff_nl80211_vendor_events {
+	SEVT(UNSPEC)		= 0,
+	SEVT(ICMP_ECHO_REQ)	= 2,
+	SEVT(MAX)		= 3
+};
+
+/*
+ * enum inff_vendor_attr - INF nl80211 vendor attributes
+ *
+ * @INFF_VENDOR_ATTR_UNSPEC: Reserved value 0
+ *
+ * @INFF_VENDOR_ATTR_LEN: Dongle Command Message Body Length.
+ *
+ * @INFF_VENDOR_ATTR_DATA: Dongle Commend Message Body.
+ *
+ * @INFF_VENDOR_ATTR_MAC_ADDR: Medium Access Control (MAC) address.
+ *
+ * @INFF_VENDOR_ATTR_MAX: This acts as a the tail of attrs list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_vendor_attr {
+	INFF_VENDOR_ATTR_UNSPEC		= 0,
+	INFF_VENDOR_ATTR_LEN		= 1,
+	INFF_VENDOR_ATTR_DATA		= 2,
+	INFF_VENDOR_ATTR_MAC_ADDR	= 3,
+	/* Reserved 4-10 */
+	INFF_VENDOR_ATTR_MAX
+};
+
+#define INFF_MBO_IOV_MAJOR_VER 1
+#define INFF_MBO_IOV_MINOR_VER 1
+#define INFF_MBO_IOV_MAJOR_VER_SHIFT 8
+#define INFF_MBO_IOV_VERSION \
+	((INFF_MBO_IOV_MAJOR_VER << INFF_MBO_IOV_MAJOR_VER_SHIFT) | \
+	  INFF_MBO_IOV_MINOR_VER)
+
+enum inff_vendor_attr_mbo_param {
+	INFF_VENDOR_ATTR_MBO_PARAM_UNSPEC = 0,
+	INFF_VENDOR_ATTR_MBO_PARAM_OPCLASS = 1,
+	INFF_VENDOR_ATTR_MBO_PARAM_CHAN = 2,
+	INFF_VENDOR_ATTR_MBO_PARAM_PREFERENCE = 3,
+	INFF_VENDOR_ATTR_MBO_PARAM_REASON_CODE = 4,
+	INFF_VENDOR_ATTR_MBO_PARAM_CELL_DATA_CAP = 5,
+	INFF_VENDOR_ATTR_MBO_PARAM_COUNTERS = 6,
+	INFF_VENDOR_ATTR_MBO_PARAM_ENABLE = 7,
+	INFF_VENDOR_ATTR_MBO_PARAM_SUB_ELEM_TYPE = 8,
+	INFF_VENDOR_ATTR_MBO_PARAM_BTQ_TRIG_START_OFFSET = 9,
+	INFF_VENDOR_ATTR_MBO_PARAM_BTQ_TRIG_RSSI_DELTA = 10,
+	INFF_VENDOR_ATTR_MBO_PARAM_ANQP_CELL_SUPP = 11,
+	INFF_VENDOR_ATTR_MBO_PARAM_BIT_MASK = 12,
+	INFF_VENDOR_ATTR_MBO_PARAM_ASSOC_DISALLOWED = 13,
+	INFF_VENDOR_ATTR_MBO_PARAM_CELLULAR_DATA_PREF = 14,
+	INFF_VENDOR_ATTR_MBO_PARAM_MAX = 15
+};
+
+static const struct nla_policy
+inff_vendor_attr_mbo_param_policy[INFF_VENDOR_ATTR_MBO_PARAM_MAX + 1] = {
+	[INFF_VENDOR_ATTR_MBO_PARAM_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_OPCLASS] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_CHAN] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_PREFERENCE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_REASON_CODE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_CELL_DATA_CAP] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_COUNTERS] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_ENABLE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_SUB_ELEM_TYPE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_BTQ_TRIG_START_OFFSET] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_BTQ_TRIG_RSSI_DELTA] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_ANQP_CELL_SUPP] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_BIT_MASK] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_ASSOC_DISALLOWED] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_CELLULAR_DATA_PREF] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAM_MAX] = {.type = NLA_U8},
+};
+
+enum inff_vendor_attr_mbo {
+	INFF_VENDOR_ATTR_MBO_UNSPEC,
+	INFF_VENDOR_ATTR_MBO_CMD,
+	INFF_VENDOR_ATTR_MBO_PARAMS,
+	INFF_VENDOR_ATTR_MBO_MAX
+};
+
+static const struct nla_policy inff_vendor_attr_mbo_policy[INFF_VENDOR_ATTR_MBO_MAX + 1] = {
+	[INFF_VENDOR_ATTR_MBO_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_CMD] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAMS] =
+		NLA_POLICY_NESTED(inff_vendor_attr_mbo_param_policy),
+	[INFF_VENDOR_ATTR_MBO_MAX] = {.type = NLA_U8},
+};
+
+enum {
+	INFF_MBO_CMD_ADD_CHAN_PREF = 1,
+	INFF_MBO_CMD_DEL_CHAN_PREF = 2,
+	INFF_MBO_CMD_LIST_CHAN_PREF = 3,
+	INFF_MBO_CMD_CELLULAR_DATA_CAP = 4,
+	INFF_MBO_CMD_DUMP_COUNTERS = 5,
+	INFF_MBO_CMD_CLEAR_COUNTERS = 6,
+	INFF_MBO_CMD_FORCE_ASSOC = 7,
+	INFF_MBO_CMD_BSSTRANS_REJECT = 8,
+	INFF_MBO_CMD_SEND_NOTIF = 9,
+	INFF_MBO_CMD_LAST
+};
+
+enum {
+	INFF_MBO_XTLV_OPCLASS            = 0x1,
+	INFF_MBO_XTLV_CHAN               = 0x2,
+	INFF_MBO_XTLV_PREFERENCE         = 0x3,
+	INFF_MBO_XTLV_REASON_CODE        = 0x4,
+	INFF_MBO_XTLV_CELL_DATA_CAP      = 0x5,
+	INFF_MBO_XTLV_COUNTERS           = 0x6,
+	INFF_MBO_XTLV_ENABLE             = 0x7,
+	INFF_MBO_XTLV_SUB_ELEM_TYPE      = 0x8,
+	INFF_MBO_XTLV_BTQ_TRIG_START_OFFSET = 0x9,
+	INFF_MBO_XTLV_BTQ_TRIG_RSSI_DELTA = 0xa,
+	INFF_MBO_XTLV_ANQP_CELL_SUPP      = 0xb,
+	INFF_MBO_XTLV_BIT_MASK		= 0xc,
+	INFF_MBO_XTLV_ASSOC_DISALLOWED	= 0xd,
+	INFF_MBO_XTLV_CELLULAR_DATA_PREF = 0xe
+};
+
+/*
+ * enum inff_vendor_attr_twt - Attributes for the TWT vendor command
+ *
+ * @INFF_VENDOR_ATTR_TWT_UNSPEC: Reserved value 0
+ *
+ * @INFF_VENDOR_ATTR_TWT_OPER: To specify the type of TWT operation
+ *	to be performed. Uses attributes defined in enum inff_twt_oper.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAMS: Nester attributes representing the
+ *	parameters configured for TWT. These parameters are defined in
+ *	the enum inff_vendor_attr_twt_param.
+ *
+ * @INFF_VENDOR_ATTR_TWT_MAX: This acts as a the tail of cmds list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_vendor_attr_twt {
+	INFF_VENDOR_ATTR_TWT_UNSPEC,
+	INFF_VENDOR_ATTR_TWT_OPER,
+	INFF_VENDOR_ATTR_TWT_PARAMS,
+	INFF_VENDOR_ATTR_TWT_MAX
+};
+
+/*
+ * enum inff_twt_oper - TWT operation to be specified using the vendor
+ * attribute INFF_VENDOR_ATTR_TWT_OPER
+ *
+ * @INFF_TWT_OPER_UNSPEC: Reserved value 0
+ *
+ * @INFF_TWT_OPER_SETUP: Setup a TWT session. Required parameters are
+ *	obtained through the nested attrs under %INFF_VENDOR_ATTR_TWT_PARAMS.
+ *
+ * @INFF_TWT_OPER_TEARDOWN: Teardown the already negotiated TWT session.
+ *	Required parameters are obtained through the nested attrs under
+ *	INFF_VENDOR_ATTR_TWT_PARAMS.
+ *
+ * @INFF_TWT_OPER_MAX: This acts as a the tail of the list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_twt_oper {
+	INFF_TWT_OPER_UNSPEC,
+	INFF_TWT_OPER_SETUP,
+	INFF_TWT_OPER_TEARDOWN,
+	INFF_TWT_OPER_MAX
+};
+
+/*
+ * enum inff_vendor_attr_twt_param - TWT parameters
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_UNSPEC: Reserved value 0
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_NEGO_TYPE: Specifies the type of Negotiation to be
+ *	done during Setup. The four possible types are
+ *	0 - Individual TWT Negotiation
+ *	1 - Wake TBTT Negotiation
+ *	2 - Broadcast TWT in Beacon
+ *	3 - Broadcast TWT Membership Negotiation
+ *
+ *	The possible values are defined in the enum inff_twt_param_nego_type
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_SETUP_CMD_TYPE: Specifies the type of TWT Setup frame
+ *	when sent by the TWT Requesting STA
+ *	0 - Request
+ *	1 - Suggest
+ *	2 - Demand
+ *
+ *	when sent by the TWT Responding STA.
+ *	3 - Grouping
+ *	4 - Accept
+ *	5 - Alternate
+ *	6 - Dictate
+ *	7 - Reject
+ *
+ *	The possible values are defined in the enum inff_twt_oper_setup_cmd_type.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_DIALOG_TOKEN: Dialog Token used by the TWT Requesting STA to
+ *	identify the TWT Setup request/response transaction.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME: Target Wake Time TSF at which the STA has to wake up.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME_OFFSET: Target Wake Time TSF Offset from current TSF
+ *	in microseconds.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION: Nominal Minimum TWT Wake Duration.
+ *	Used along with %INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION_UNIT to derive Wake Duration.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_EXPONENT: TWT Wake Interval Exponent.
+ *	Used along with %INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_MANTISSA to derive Wake Interval.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_MANTISSA: TWT Wake Interval Mantissa.
+ *	Used along with %INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_EXPONENT to derive Wake Interval.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_REQUESTOR: Specify this is a TWT Requesting / Responding STA.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_TRIGGER: Specify Trigger based / Non-Trigger based TWT Session.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_IMPLICIT: Specify Implicit / Explicit TWT session.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_FLOW_TYPE: Specify Un-Announced / Announced TWT session.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_FLOW_ID: Flow ID is the unique identifier of an iTWT session.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_BCAST_TWT_ID: Broadcast TWT ID is the unique identifier of a
+ *	bTWT session.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_PROTECTION: Specifies whether Tx within SP is protected.
+ *	Set to 1 to indicate that TXOPs within the TWT SPs shall be initiated
+ *	with a NAV protection mechanism, such as (MU) RTS/CTS or CTS-to-self frame;
+ *	otherwise, it shall set it to 0.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_CHANNEL: TWT channel field which is set to 0, unless
+ *	the HE STA sets up a subchannel selective transmission operation.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_TWT_INFO_FRAME_DISABLED: TWT Information frame RX handing
+ *	disabled / enabled.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION_UNIT: Nominal Minimum TWT Wake Duration
+ *	Unit. 0 represents unit in "256 usecs" and 1 represents unit in "TUs".
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_TEARDOWN_ALL_TWT: Teardown all negotiated TWT sessions.
+ *
+ * @INFF_VENDOR_ATTR_TWT_PARAM_MAX: This acts as a the tail of the list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_vendor_attr_twt_param {
+	INFF_VENDOR_ATTR_TWT_PARAM_UNSPEC,
+	INFF_VENDOR_ATTR_TWT_PARAM_NEGO_TYPE,
+	INFF_VENDOR_ATTR_TWT_PARAM_SETUP_CMD_TYPE,
+	INFF_VENDOR_ATTR_TWT_PARAM_DIALOG_TOKEN,
+	INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME,
+	INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME_OFFSET,
+	INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION,
+	INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_EXPONENT,
+	INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_MANTISSA,
+	INFF_VENDOR_ATTR_TWT_PARAM_REQUESTOR,
+	INFF_VENDOR_ATTR_TWT_PARAM_TRIGGER,
+	INFF_VENDOR_ATTR_TWT_PARAM_IMPLICIT,
+	INFF_VENDOR_ATTR_TWT_PARAM_FLOW_TYPE,
+	INFF_VENDOR_ATTR_TWT_PARAM_FLOW_ID,
+	INFF_VENDOR_ATTR_TWT_PARAM_BCAST_TWT_ID,
+	INFF_VENDOR_ATTR_TWT_PARAM_PROTECTION,
+	INFF_VENDOR_ATTR_TWT_PARAM_CHANNEL,
+	INFF_VENDOR_ATTR_TWT_PARAM_TWT_INFO_FRAME_DISABLED,
+	INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION_UNIT,
+	INFF_VENDOR_ATTR_TWT_PARAM_TEARDOWN_ALL_TWT,
+	INFF_VENDOR_ATTR_TWT_PARAM_MAX
+};
+
+/*
+ * enum inff_twt_param_nego_type - TWT Session Negotiation Type Parameters
+ *
+ * @INFF_TWT_PARAM_NEGO_TYPE_ITWT: Individual TWT negotiation between TWT requesting STA
+ *	and TWT responding STA or individual TWT announcement by TWT Responder
+ *
+ * @INFF_TWT_PARAM_NEGO_TYPE_WAKE_TBTT: Wake TBTT and Wake interval negotiation between
+ *	TWT scheduled STA and TWT scheduling AP.
+ *
+ * @INFF_TWT_PARAM_NEGO_TYPE_BTWT_IE_BCN: Provide Broadcast TWT schedules to TWT scheduled
+ *	STAs by including the TWT element in broadcast Managemnet frames sent by TWT
+ *	scheduling AP.
+ *
+ * @INFF_TWT_PARAM_NEGO_TYPE_BTWT: Broadcast TWT negotiation between TWT requesting STA
+ *	and TWT responding STA. Manage Memberships in broadcast TWT schedules by including
+ *	the TWT element in individually addressed Management frames sent by either a TWT
+ *	scheduled STA or a TWT scheduling AP.
+ *
+ * @INFF_TWT_PARAM_NEGO_TYPE_MAX: This acts as a the tail of the list.
+ *      Make sure it located at the end of the list.
+ */
+enum inff_twt_param_nego_type {
+	INFF_TWT_PARAM_NEGO_TYPE_INVALID		= -1,
+	INFF_TWT_PARAM_NEGO_TYPE_ITWT		= 0,
+	INFF_TWT_PARAM_NEGO_TYPE_WAKE_TBTT	= 1,
+	INFF_TWT_PARAM_NEGO_TYPE_BTWT_IE_BCN	= 2,
+	INFF_TWT_PARAM_NEGO_TYPE_BTWT		= 3,
+	INFF_TWT_PARAM_NEGO_TYPE_MAX		= 4
+};
+
+/*
+ * enum inff_vendor_attr_twt_param - TWT Session setup command types
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_REQUEST: A TWT requesting or TWT scheduled STA
+ *	requests to join a TWT without specifying a target wake time. This type needs to
+ *	be used only by the TWT requesting STA.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_SUGGEST: A TWT requesting or TWT scheduled STA requests to
+ *	join a TWT without specifying a target wake time. This type needs to be used only
+ *	by the TWT requesting STA.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_DEMAND: A TWT requesting or TWT scheduled STA requests to
+ *	join a TWT and specifies a demanded set of TWT parameters. If the demanded set of
+ *	TWT parameters is not accommodated by the responding STA or TWT scheduling AP, then
+ *	the TWT requesting STA or TWT scheduled STA will reject the TWT setup. This type
+ *	needs to be used only by the TWT requesting STA.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_GROUPING: The TWT responding STA suggests TWT group
+ *	parameters that are different from the suggested or demanded TWT parameters of the
+ *	TWT requesting STA. This type needs to be used only by the S1G TWT Responding STA in
+ *	case of ITWT Setup Negotiation.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_ACCEPT: A TWT responding STA or TWT scheduling AP accepts
+ *	the TWT request with the TWT parameters (see NOTE) indicated in the TWT element
+ *	transmitted by the TWT requesting STA or TWT scheduled STA. This value is also used
+ *	in unsolicited TWT responses. This needs type needs to be used only by the TWT
+ *	responding STA.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_ALTERNATE: A TWT responding STA or TWT scheduling AP suggests
+ *	TWT parameters that are different from those suggested by the TWT requesting STA or
+ *	TWT scheduled STA. This needs type needs to be used only by the TWT reponding STA.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_DICTATE: A TWT responding STA or TWT scheduling AP indicates
+ *	TWT parameters that are different from those suggested by the TWT requesting STA or
+ *	TWT scheduled STA. This needs type needs to be used only by the TWT responding STA.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_REJECT: A TWT responding STA or TWT scheduling AP rejects
+ *	setup, or a TWT scheduling AP terminates an existing broadcast TWT, or a TWT
+ *	scheduled STA terminates its membership in a broadcast TWT.
+ *
+ * @INFF_TWT_OPER_SETUP_CMD_TYPE_MAX: This acts as a the tail of the list.
+ *	Make sure it located at the end of the list.
+ */
+enum inff_twt_oper_setup_cmd_type {
+	INFF_TWT_OPER_SETUP_CMD_TYPE_INVALID	= -1,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_REQUEST	= 0,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_SUGGEST	= 1,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_DEMAND	= 2,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_GROUPING	= 3,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_ACCEPT	= 4,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_ALTERNATE	= 5,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_DICTATE	= 6,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_REJECT	= 7,
+	INFF_TWT_OPER_SETUP_CMD_TYPE_MAX		= 8
+};
+
+#define INFF_OCE_IOV_MAJOR_VER 1
+#define INFF_OCE_IOV_MINOR_VER 1
+#define INFF_OCE_IOV_MAJOR_VER_SHIFT 8
+#define INFF_OCE_IOV_VERSION \
+	((INFF_OCE_IOV_MAJOR_VER << INFF_OCE_IOV_MAJOR_VER_SHIFT) | \
+	INFF_OCE_IOV_MINOR_VER)
+
+enum {
+	INFF_OCE_CMD_ENABLE = 1,
+	INFF_OCE_CMD_PROBE_DEF_TIME = 2,
+	INFF_OCE_CMD_FD_TX_PERIOD = 3,
+	INFF_OCE_CMD_FD_TX_DURATION = 4,
+	INFF_OCE_CMD_RSSI_TH = 5,
+	INFF_OCE_CMD_RWAN_LINKS = 6,
+	INFF_OCE_CMD_CU_TRIGGER = 7,
+	INFF_OCE_CMD_LAST
+};
+
+enum {
+	INFF_OCE_XTLV_ENABLE  = 0x1,
+	INFF_OCE_XTLV_PROBE_DEF_TIME  = 0x2,
+	INFF_OCE_XTLV_FD_TX_PERIOD    = 0x3,
+	INFF_OCE_XTLV_FD_TX_DURATION  = 0x4,
+	INFF_OCE_XTLV_RSSI_TH = 0x5,
+	INFF_OCE_XTLV_RWAN_LINKS = 0x6,
+	INFF_OCE_XTLV_CU_TRIGGER = 0x7
+};
+
+static const struct nla_policy
+inff_vendor_attr_twt_param_policy[INFF_VENDOR_ATTR_TWT_PARAM_MAX + 1] = {
+	[INFF_VENDOR_ATTR_TWT_PARAM_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_NEGO_TYPE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_SETUP_CMD_TYPE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_DIALOG_TOKEN] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME] = {.type = NLA_U64},
+	[INFF_VENDOR_ATTR_TWT_PARAM_WAKE_TIME_OFFSET] = {.type = NLA_U64},
+	[INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_EXPONENT] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_WAKE_INTVL_MANTISSA] = {.type = NLA_U16},
+	[INFF_VENDOR_ATTR_TWT_PARAM_REQUESTOR] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_TRIGGER] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_IMPLICIT] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_FLOW_TYPE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_FLOW_ID] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_BCAST_TWT_ID] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_PROTECTION] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_CHANNEL] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_TWT_INFO_FRAME_DISABLED] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_MIN_WAKE_DURATION_UNIT] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_TEARDOWN_ALL_TWT] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAM_MAX] = {.type = NLA_U8},
+};
+
+static const struct nla_policy inff_vendor_attr_twt_policy[INFF_VENDOR_ATTR_TWT_MAX + 1] = {
+	[INFF_VENDOR_ATTR_TWT_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_OPER] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAMS] =
+		NLA_POLICY_NESTED(inff_vendor_attr_twt_param_policy),
+	[INFF_VENDOR_ATTR_TWT_MAX] = {.type = NLA_U8},
+};
+
+/* randmac define/enum/struct
+ */
+#define WL_RANDMAC_API_VERSION		0x0100 /**< version 1.0 */
+#define WL_RANDMAC_API_MIN_VERSION	0x0100 /**< version 1.0 */
+
+/** subcommands that can apply to randmac */
+enum {
+	WL_RANDMAC_SUBCMD_NONE				= 0,
+	WL_RANDMAC_SUBCMD_GET_VERSION			= 1,
+	WL_RANDMAC_SUBCMD_ENABLE			= 2,
+	WL_RANDMAC_SUBCMD_DISABLE			= 3,
+	WL_RANDMAC_SUBCMD_CONFIG			= 4,
+	WL_RANDMAC_SUBCMD_STATS				= 5,
+	WL_RANDMAC_SUBCMD_CLEAR_STATS			= 6,
+	WL_RANDMAC_SUBCMD_MAX
+};
+
+struct inff_randmac {
+	u16 version;
+	u16 len;			/* total length */
+	u16 subcmd_id;	/* subcommand id */
+	u8 data[0];			/* subcommand data */
+};
+
+enum inff_vendor_attr_wnm_param {
+	INFF_VENDOR_ATTR_WNM_PARAM_UNSPEC,
+	INFF_VENDOR_ATTR_WNM_PARAM_GET_INFO,
+	INFF_VENDOR_ATTR_WNM_PARAM_IDLE_PERIOD,
+	INFF_VENDOR_ATTR_WNM_PARAM_PROTECTION_OPT,
+	INFF_VENDOR_ATTR_WNM_PARAM_MAX
+};
+
+static const struct nla_policy
+inff_vendor_attr_wnm_param_policy[INFF_VENDOR_ATTR_WNM_PARAM_MAX + 1] = {
+	[INFF_VENDOR_ATTR_WNM_PARAM_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_GET_INFO] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_IDLE_PERIOD] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_PROTECTION_OPT] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_MAX] = {.type = NLA_U8},
+};
+
+enum inff_vendor_attr_wnm {
+	INFF_VENDOR_ATTR_WNM_UNSPEC,
+	INFF_VENDOR_ATTR_WNM_CMD,
+	INFF_VENDOR_ATTR_WNM_PARAMS,
+	INFF_VENDOR_ATTR_WNM_MAX
+};
+
+enum inff_vendor_hw_caps {
+	INFF_VENDOR_HW_CAPS_REPLAYCNTS,
+	INFF_VENDOR_HW_CAPS_MAX
+};
+
+static const char * const hw_caps_name[] = {
+	[INFF_VENDOR_HW_CAPS_REPLAYCNTS] = "replay counters"
+};
+
+static const struct nla_policy inff_vendor_attr_wnm_policy[INFF_VENDOR_ATTR_WNM_MAX + 1] = {
+	[INFF_VENDOR_ATTR_WNM_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_CMD] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAMS] =
+		NLA_POLICY_NESTED(inff_vendor_attr_wnm_param_policy),
+	[INFF_VENDOR_ATTR_WNM_MAX] = {.type = NLA_U8},
+};
+
+enum {
+	INFF_WNM_CMD_IOV_WNM = 1,
+	INFF_WNM_CMD_IOV_WNM_MAXIDLE = 2,
+	INFF_WNM_CMD_IOV_WNM_TIMBC_OFFSET = 3,
+	INFF_WNM_CMD_IOV_WNM_BSSTRANS_URL = 4,
+	INFF_WNM_CMD_IOV_WNM_BSSTRANS_REQ = 5,
+	INFF_WNM_CMD_IOV_WNM_TFS_TCLASTYPE = 6,
+	INFF_WNM_CMD_IOV_WNM_PARP_DISCARD = 7,
+	INFF_WNM_CMD_IOV_WNM_PARP_ALLNODE = 8,
+	INFF_WNM_CMD_IOV_WNM_TIMBC_SET = 9,
+	INFF_WNM_CMD_IOV_WNM_TIMBC_STATUS = 10,
+	INFF_WNM_CMD_IOV_WNM_DMS_SET = 11,
+	INFF_WNM_CMD_IOV_WNM_DMS_TERM = 12,
+	INFF_WNM_CMD_IOV_WNM_SERVICE_TERM = 13,
+	INFF_WNM_CMD_IOV_WNM_SLEEP_INTV = 14,
+	INFF_WNM_CMD_IOV_WNM_SLEEP_MODE = 15,
+	INFF_WNM_CMD_IOV_WNM_BSSTRANS_QUERY = 16,
+	INFF_WNM_CMD_IOV_WNM_BSSTRANS_RESP = 17,
+	INFF_WNM_CMD_IOV_WNM_TCLAS_ADD = 18,
+	INFF_WNM_CMD_IOV_WNM_TCLAS_DEL = 19,
+	INFF_WNM_CMD_IOV_WNM_TCLAS_LIST = 20,
+	INFF_WNM_CMD_IOV_WNM_DMS_STATUS = 21,
+	INFF_WNM_CMD_IOV_WNM_KEEPALIVES_MAX_IDLE = 22,
+	INFF_WNM_CMD_IOV_WNM_PM_IGNORE_BCMC = 23,
+	INFF_WNM_CMD_IOV_WNM_DMS_DEPENDENCY = 24,
+	INFF_WNM_CMD_IOV_WNM_BSSTRANS_ROAMTHROTTLE = 25,
+	INFF_WNM_CMD_IOV_WNM_TFS_SET  = 26,
+	INFF_WNM_CMD_IOV_WNM_TFS_TERM = 27,
+	INFF_WNM_CMD_IOV_WNM_TFS_STATUS = 28,
+	INFF_WNM_CMD_IOV_WNM_BTQ_NBR_ADD = 29,
+	INFF_WNM_CMD_IOV_WNM_BTQ_NBR_DEL = 30,
+	INFF_WNM_CMD_IOV_WNM_BTQ_NBR_LIST = 31,
+	INFF_WNM_CMD_IOV_WNM_BSSTRANS_RSSI_RATE_MAP = 32,
+	INFF_WNM_CMD_IOV_WNM_KEEPALIVE_PKT_TYPE = 33,
+	INFF_WNM_CONFIG_CMD_IOV_WNM_TYPE_MAX
+};
+
+struct inff_maxidle_wnm {
+	u8  get_info;
+	int period;
+	int protect;
+};
+
+enum inff_vendor_attr_ssid_prot {
+	INFF_VENDOR_ATTR_SSID_PROT_UNSPEC,
+	INFF_VENDOR_ATTR_SSID_PROT_ENABLE,
+	INFF_VENDOR_ATTR_SSID_PROT_MAX
+};
+
+static const struct nla_policy
+inff_vendor_attr_ssid_prot_policy[INFF_VENDOR_ATTR_SSID_PROT_MAX + 1] = {
+	[INFF_VENDOR_ATTR_SSID_PROT_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_SSID_PROT_ENABLE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_SSID_PROT_MAX] = {.type = NLA_U8},
+};
+
+/* String based vendor commands infra
+ */
+#define VNDR_CMD_STR_NUM	15
+#define VNDR_CMD_STR_MAX_LEN	50
+#define VNDR_CMD_VAL_NUM	50
+#define VNDR_CMD_HASH_BITS	4
+
+struct inff_vendor_cmdstr {
+	const char *name;
+	int (*func)(struct wiphy *wiphy, struct wireless_dev *wdev,
+		    char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+		    long cmd_val[VNDR_CMD_VAL_NUM]);
+};
+
+struct inff_vndr_cmdstr_hashtbl {
+	struct inff_vendor_cmdstr *vndr_cmd_addr;
+	struct hlist_node node;
+};
+
+int inff_cfg80211_vndr_cmds_twt(struct wiphy *wiphy,
+				struct wireless_dev *wdev, const void  *data, int len);
+int inff_cfg80211_vndr_cmds_bss_color(struct wiphy *wiphy,
+				      struct wireless_dev *wdev,
+				      const void *data, int len);
+int inff_cfg80211_vndr_cmds_muedca_opt(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len);
+int inff_cfg80211_vndr_cmds_amsdu(struct wiphy *wiphy,
+				  struct wireless_dev *wdev,
+				  const void *data, int len);
+int inff_cfg80211_vndr_cmds_ldpc_cap(struct wiphy *wiphy,
+				     struct wireless_dev *wdev,
+				     const void *data, int len);
+int inff_cfg80211_vndr_cmds_oce_enable(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len);
+int inff_cfg80211_vndr_cmds_randmac(struct wiphy *wiphy,
+				    struct wireless_dev *wdev,
+				    const void *data, int len);
+int inff_cfg80211_vndr_cmds_mbo(struct wiphy *wiphy,
+				struct wireless_dev *wdev,
+				const void *data, int len);
+int inff_cfg80211_vndr_cmds_mpc(struct wiphy *wiphy,
+				struct wireless_dev *wdev,
+				const void *data, int len);
+int inff_cfg80211_vndr_cmds_giantrx(struct wiphy *wiphy,
+				    struct wireless_dev *wdev,
+				    const void *data, int len);
+int inff_cfg80211_vndr_cmds_wnm_max_idle(struct wiphy *wiphy,
+					 struct wireless_dev *wdev,
+					 const void *data, int len);
+int inff_cfg80211_vndr_cmds_hwcaps(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
+				   const void *data, int len);
+int inff_cfg80211_vndr_cmds_wnm_wl_cap(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       const void *data, int len);
+int inff_vndr_cmdstr_offload_config(struct wiphy *wiphy, struct wireless_dev *wdev,
+				    char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+				    long cmd_val[VNDR_CMD_VAL_NUM]);
+int inff_vndr_cmdstr_mkeep_alive(struct wiphy *wiphy, struct wireless_dev *wdev,
+				 char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+				 long *cmd_val);
+int inff_vndr_cmdstr_tko(struct wiphy *wiphy, struct wireless_dev *wdev,
+			 char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+			 long *cmd_val);
+int inff_vndr_cmdstr_icmp_echo_req(struct wiphy *wiphy, struct wireless_dev *wdev,
+				   char cmd_str[VNDR_CMD_STR_NUM][VNDR_CMD_STR_MAX_LEN],
+				   long *cmd_val);
+int inff_cfg80211_vndr_cmds_str(struct wiphy *wiphy, struct wireless_dev *wdev,
+				const void *data, int len);
+int inff_cfg80211_vndr_cmds_config_pfn(struct wiphy *wiphy,
+				       struct wireless_dev *wdev, const void  *data, int len);
+int inff_cfg80211_vndr_cmds_get_pfn_status(struct wiphy *wiphy,
+					   struct wireless_dev *wdev, const void  *data, int len);
+int inff_cfg80211_vndr_cmds_mchan_config(struct wiphy *wiphy,
+					 struct wireless_dev *wdev, const void *data, int len);
+int inff_cfg80211_vndr_cmds_ssid_prot(struct wiphy *wiphy,
+				      struct wireless_dev *wdev, const void *data, int len);
+int inff_cfg80211_vndr_evt_icmp_echo_req(struct wiphy *wiphy, struct wireless_dev *wdev,
+					 const void *data, int len);
+
+#endif /* INFF_VENDOR_INF_H */
-- 
2.25.1


