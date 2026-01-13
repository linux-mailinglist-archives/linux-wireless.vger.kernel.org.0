Return-Path: <linux-wireless+bounces-30765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D679D1B3BD
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF76302A44E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D62BCF6C;
	Tue, 13 Jan 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="CuvHyTHu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69822772D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336617; cv=none; b=Pyx2DhYog1gjUPB7NPA0PxpIkpsMVp5XBUMvYABo6D8OOkCSb+VTgpjbMUs1QQNDfNOEgP7PTVvrw4hGMS/qcY0WDhBUWUs1FlP4Df6g3icySGcuwFrvcY3nJCF5JiZ/shpEkHHayOzKxYp5OqRiyFSAVVim+6B7RG727U3aaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336617; c=relaxed/simple;
	bh=WhBCKBAl/mG5ee8+a/b+2g6zWRRvnPbHfGMWxQAxp9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8glT409vvz7oR62LlgWl9NTunoemxNdD/3DVJ1t5zXgLiWuNjKSEhXW965IwO+mfM+9HQ72bghcxcfJGrFoTrDZWxdAj+Qj42RABKzIoxx8h4S0wyb7OlfzwoKkBYOQG1cPoIF4sLscHQKqPS0gGsNvEVvHMO2SMYelQylCyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=CuvHyTHu; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336614; x=1799872614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WhBCKBAl/mG5ee8+a/b+2g6zWRRvnPbHfGMWxQAxp9Y=;
  b=CuvHyTHufTnjPWcvGIwWzg27JvdUghgHBd5oYhfK1uN+cHt8lXxfgxXp
   pF5K8REoBrSVFQPXKN0HJzhCvlA4FKxkrP8dhWD3LlKA4BkSfZPXuOwVf
   UwQ1vRdc48sUjZ/9gMHPCGvLeZupwrqbjFqZSEXJS5ZeO9Rl5y8xwLHfz
   8=;
X-CSE-ConnectionGUID: QPefmdnrRrOWBBkbt5rNng==
X-CSE-MsgGUID: uoDE2WuvS5+5iBaQsO7qoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="139541866"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="139541866"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:36:52 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:36:51 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:36:49 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 11/34] wifi: inffmac: add vendor.c/h
Date: Wed, 14 Jan 2026 02:03:24 +0530
Message-ID: <20260113203350.16734-12-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for exposing an Infineon OUI-based vendor nl80211
interface for allowing Infineon's vendor-specific WLAN operations from
the user space.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/vendor.c    | 1344 +++++++++++++++++
 .../net/wireless/infineon/inffmac/vendor.h    |  322 ++++
 2 files changed, 1666 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.h

diff --git a/drivers/net/wireless/infineon/inffmac/vendor.c b/drivers/net/wireless/infineon/inffmac/vendor.c
new file mode 100644
index 000000000000..0c9e1a69ad8f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/vendor.c
@@ -0,0 +1,1344 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/inet.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+
+#include "main.h"
+#include "net.h"
+#include "cfg80211.h"
+#include "interface.h"
+#include "p2p.h"
+#include "debug.h"
+#include "bus_proto.h"
+#include "vendor.h"
+#include "dev_cmd.h"
+#include "he.h"
+#include "twt.h"
+#include "chip.h"
+
+static int
+inff_cfg80211_vndr_send_cmd_reply(struct wiphy *wiphy,
+				  const void  *data, int len)
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
+static int
+inff_cfg80211_vndr_cmds_int_get(struct inff_if *ifp,
+				u32 cmd, struct wiphy *wiphy)
+{
+	struct sk_buff *reply;
+	int get_value = 0;
+	int ret;
+
+	ret = inff_fwcmd_cmd_int_get(ifp, cmd, &get_value);
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
+static int
+inff_cfg80211_vndr_cmds_int_set(struct inff_if *ifp, int val, u32 cmd)
+{
+	int ret;
+
+	ret = inff_fwcmd_cmd_int_set(ifp, cmd, val);
+	if (ret < 0)
+		inff_err("Command %u set failure. Error : %d\n", cmd, ret);
+	return ret;
+}
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
+static int
+inff_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
+				     struct wireless_dev *wdev,
+				     const void *data, int len)
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
+	if (!dcmd_buf)
+		return -ENOMEM;
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
+		ret = inff_fwcmd_cmd_data_set(ifp, cmdhdr->cmd, dcmd_buf,
+					      ret_len);
+	else
+		ret = inff_fwcmd_cmd_data_get(ifp, cmdhdr->cmd, dcmd_buf,
+					      ret_len);
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
+		if (nla_put(reply, INFF_VENDOR_ATTR_DATA, msglen, wr_pointer) ||
+		    nla_put_u16(reply, INFF_VENDOR_ATTR_LEN, msglen)) {
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
+static int
+inff_cfg80211_vndr_cmds_frameburst(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
+				   const void *data, int len)
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
+static int
+inff_cfg80211_vndr_cmds_muedca_opt(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
+				   const void *data, int len)
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
+static int
+inff_cfg80211_vndr_cmds_ldpc_cap(struct wiphy *wiphy,
+				 struct wireless_dev *wdev,
+				 const void *data, int len)
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
+		ret = inff_fwcmd_iovar_int_get(ifp, "ldpc_cap", &buf);
+		if (ret) {
+			inff_err("get ldpc_cap error:%d\n", ret);
+
+			return ret;
+		}
+
+		inff_dbg(INFO, "get ldpc_cap: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		ret = inff_fwcmd_iovar_int_set(ifp, "ldpc_cap", val);
+		if (ret)
+			inff_err("set ldpc_cap error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+static int
+inff_cfg80211_vndr_cmds_amsdu(struct wiphy *wiphy,
+			      struct wireless_dev *wdev,
+			      const void *data, int len)
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
+		ret = inff_fwcmd_iovar_int_get(ifp, "amsdu", &get_amsdu);
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
+		ret = inff_fwcmd_iovar_int_set(ifp, "amsdu", val);
+		if (ret)
+			inff_err("set amsdu error:%d\n", ret);
+	}
+
+	return ret;
+}
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
+static const struct nla_policy
+inff_vendor_attr_twt_policy[INFF_VENDOR_ATTR_TWT_MAX + 1] = {
+	[INFF_VENDOR_ATTR_TWT_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_OPER] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_TWT_PARAMS] =
+		NLA_POLICY_NESTED(inff_vendor_attr_twt_param_policy),
+	[INFF_VENDOR_ATTR_TWT_MAX] = {.type = NLA_U8},
+};
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
+static int
+inff_cfg80211_vndr_cmds_twt(struct wiphy *wiphy, struct wireless_dev *wdev,
+			    const void  *data, int len)
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
+struct inff_iov_buf {
+	__le16	version;
+	__le16	len;
+	__le16	id;
+	u16	data[];
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
+static int
+inff_cfg80211_vndr_cmds_oce_enable(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
+				   const void *data, int len)
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
+		ret = inff_fwcmd_iovar_data_get(ifp, "oce",
+						param, sizeof(param));
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
+		ret = inff_fwcmd_iovar_data_set(ifp, "oce",
+						param, sizeof(param));
+		if (ret)
+			inff_err("set oce enable error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+static int
+inff_cfg80211_vndr_cmds_bss_color(struct wiphy *wiphy,
+				  struct wireless_dev *wdev,
+				  const void *data, int len)
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
+struct inff_randmac {
+	u16 version;
+	u16 len;	/* total length */
+	u16 subcmd_id;	/* subcommand id */
+	u8 data[0];	/* subcommand data */
+};
+
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
+static int
+inff_cfg80211_vndr_cmds_randmac(struct wiphy *wiphy,
+				struct wireless_dev *wdev,
+				const void *data, int len)
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
+		ret = inff_fwcmd_bsscfg_data_set(ifp, "randmac", (void *)&iov_buf, iov_buf.len);
+		if (ret)
+			inff_err("Failed to set randmac enable: %d\n", ret);
+	} else if (val == 0x0) {
+		iov_buf.subcmd_id = WL_RANDMAC_SUBCMD_DISABLE;
+		/* To set fw iovars of the form "wl randmac disable" using iw, call the
+		 * parent iovar "randmac" with the subcmd filled and passed along
+		 * ./iw dev wlan0 vendor send 0x000319 0x11 0x0
+		 */
+		ret = inff_fwcmd_bsscfg_data_set(ifp, "randmac", (void *)&iov_buf, iov_buf.len);
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
+		ret = inff_fwcmd_iovar_data_get(ifp, "randmac", (void *)buf, sizeof(buf));
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
+#define INFF_MBO_IOV_MAJOR_VER 1
+#define INFF_MBO_IOV_MINOR_VER 1
+#define INFF_MBO_IOV_MAJOR_VER_SHIFT 8
+#define INFF_MBO_IOV_VERSION \
+	((INFF_MBO_IOV_MAJOR_VER << INFF_MBO_IOV_MAJOR_VER_SHIFT) | \
+	  INFF_MBO_IOV_MINOR_VER)
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
+static const struct nla_policy
+inff_vendor_attr_mbo_policy[INFF_VENDOR_ATTR_MBO_MAX + 1] = {
+	[INFF_VENDOR_ATTR_MBO_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_CMD] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_MBO_PARAMS] =
+		NLA_POLICY_NESTED(inff_vendor_attr_mbo_param_policy),
+	[INFF_VENDOR_ATTR_MBO_MAX] = {.type = NLA_U8},
+};
+
+static int
+inff_cfg80211_vndr_cmds_mbo(struct wiphy *wiphy,
+			    struct wireless_dev *wdev,
+			    const void *data, int len)
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
+					inff_fwcmd_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_OPCLASS,
+							     &op_class, sizeof(op_class),
+							     (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_CHAN:
+				{
+					u8 chan;
+
+					chan = nla_get_u8(mbo_param_iter);
+					inff_fwcmd_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_CHAN,
+							     &chan, sizeof(chan),
+							     (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_PREFERENCE:
+				{
+					u8 pref;
+
+					pref = nla_get_u8(mbo_param_iter);
+					inff_fwcmd_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_PREFERENCE,
+							     &pref, sizeof(pref),
+							     (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_REASON_CODE:
+				{
+					u8 reason;
+
+					reason = nla_get_u8(mbo_param_iter);
+					inff_fwcmd_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_REASON_CODE,
+							     &reason, sizeof(reason),
+							     (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_CELL_DATA_CAP:
+				{
+					u8 cell_data_cap;
+					u16 id = INFF_VENDOR_ATTR_MBO_PARAM_CELL_DATA_CAP;
+
+					cell_data_cap = nla_get_u8(mbo_param_iter);
+					inff_fwcmd_pack_xtlv(id, &cell_data_cap,
+							     sizeof(cell_data_cap),
+							     (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_COUNTERS:
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_ENABLE:
+				{
+					u8 enable;
+
+					enable = nla_get_u8(mbo_param_iter);
+					inff_fwcmd_pack_xtlv(INFF_VENDOR_ATTR_MBO_PARAM_ENABLE,
+							     &enable, sizeof(enable),
+							     (char **)&mbo_xtlv, &buf_len);
+				}
+					break;
+				case INFF_VENDOR_ATTR_MBO_PARAM_SUB_ELEM_TYPE:
+				{
+					u8 type;
+					u16 id = INFF_VENDOR_ATTR_MBO_PARAM_SUB_ELEM_TYPE;
+
+					type = nla_get_u8(mbo_param_iter);
+					inff_fwcmd_pack_xtlv(id, &type, sizeof(type),
+							     (char **)&mbo_xtlv, &buf_len);
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
+	ret = inff_fwcmd_iovar_data_set(ifp, "mbo", param, buf_len);
+
+	if (ret)
+		inff_err("set mbo enable error:%d\n", ret);
+
+	return ret;
+}
+
+static int
+inff_cfg80211_vndr_cmds_mpc(struct wiphy *wiphy,
+			    struct wireless_dev *wdev,
+			    const void *data, int len)
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
+		ret = inff_fwcmd_iovar_int_get(ifp, "mpc", &buf);
+		if (ret) {
+			inff_err("get mpc error:%d\n", ret);
+			return ret;
+		}
+
+		inff_dbg(INFO, "get mpc: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		ret = inff_fwcmd_iovar_int_set(ifp, "mpc", val);
+		if (ret)
+			inff_err("set mpc error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+static int
+inff_cfg80211_vndr_cmds_giantrx(struct wiphy *wiphy,
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
+		ret = inff_fwcmd_iovar_int_get(ifp, "giantrx", &buf);
+		if (ret) {
+			inff_err("get giantrx error:%d\n", ret);
+			return ret;
+		}
+
+		inff_dbg(INFO, "get giantrx: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		inff_fwcmd_cmd_int_set(ifp, INFF_C_DOWN, 1);
+		ret = inff_fwcmd_iovar_int_set(ifp, "giantrx", val);
+		inff_fwcmd_cmd_int_set(ifp, INFF_C_UP, 1);
+		if (ret)
+			inff_err("set giantrx error:%d\n", ret);
+	}
+	return ret;
+}
+
+struct inff_maxidle_wnm {
+	u8  get_info;
+	int period;
+	int protect;
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
+static const struct nla_policy
+inff_vendor_attr_wnm_param_policy[INFF_VENDOR_ATTR_WNM_PARAM_MAX + 1] = {
+	[INFF_VENDOR_ATTR_WNM_PARAM_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_GET_INFO] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_IDLE_PERIOD] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_PROTECTION_OPT] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAM_MAX] = {.type = NLA_U8},
+};
+
+static const struct nla_policy
+inff_vendor_attr_wnm_policy[INFF_VENDOR_ATTR_WNM_MAX + 1] = {
+	[INFF_VENDOR_ATTR_WNM_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_CMD] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_WNM_PARAMS] =
+		NLA_POLICY_NESTED(inff_vendor_attr_wnm_param_policy),
+	[INFF_VENDOR_ATTR_WNM_MAX] = {.type = NLA_U8},
+};
+
+static int
+inff_cfg80211_vndr_cmds_wnm_max_idle(struct wiphy *wiphy,
+				     struct wireless_dev *wdev,
+				     const void  *data, int len)
+{
+	int tmp, attr_type = 0, wnm_param = 0, ret = 0;
+	const struct nlattr *attr_iter, *wnm_param_iter;
+
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	u8 param[64] = {0}, get_info = 0, wnm_id = 0;
+	u16 buf_len = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	nla_for_each_attr(attr_iter, data, len, tmp) {
+		attr_type = nla_type(attr_iter);
+
+		switch (attr_type) {
+		case INFF_VENDOR_ATTR_WNM_CMD:
+			wnm_id = nla_get_u8(attr_iter);
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
+			ret = inff_fwcmd_iovar_int_get(ifp, "wnm_maxidle", &get_period);
+			if (!ret)
+				ret = inff_cfg80211_vndr_send_cmd_reply(wiphy,
+									&get_period,
+									sizeof(get_period));
+		} else {
+			ret = inff_fwcmd_iovar_data_set(ifp, "wnm_maxidle", param, buf_len);
+		}
+	}
+	break;
+
+	default:
+		inff_err("unsupport wnm cmd:%u\n", wnm_id);
+		return -EINVAL;
+	}
+
+	if (ret)
+		inff_err("wnm %s error:%d\n", get_info ? "get" : "set", ret);
+
+	return ret;
+}
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
+static int
+inff_cfg80211_vndr_cmds_hwcaps(struct wiphy *wiphy,
+			       struct wireless_dev *wdev,
+			       const void *data, int len)
+{
+	int ret = 0, i;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct inff_bus *bus_if;
+	s32 buf[INFF_VENDOR_HW_CAPS_MAX] = {0};
+	u32 replaycnts;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+	bus_if = ifp->drvr->bus_if;
+
+	replaycnts = inff_chip_get_hw_caps_replaycnts(bus_if->chip_pub);
+	if (replaycnts) {
+		buf[INFF_VENDOR_HW_CAPS_REPLAYCNTS] = replaycnts;
+	} else {
+		inff_err("chip doesn't specify hw_caps_replaycnts\n");
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
+static int
+inff_cfg80211_vndr_cmds_wnm_wl_cap(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
+				   const void *data, int len)
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
+		ret = inff_fwcmd_iovar_int_get(ifp, "wnm", &buf);
+		if (ret) {
+			inff_err("get wnm_wl_cap error:%d\n", ret);
+			return ret;
+		}
+
+		inff_dbg(INFO, "get wnm_wl_cap: %d\n", buf);
+		inff_cfg80211_vndr_send_cmd_reply(wiphy, &buf, sizeof(int));
+	} else {
+		ret = inff_fwcmd_iovar_int_set(ifp, "wnm", val);
+		if (ret)
+			inff_err("set wnm_wl_cap error:%d\n", ret);
+	}
+
+	return ret;
+}
+
+static const struct nla_policy
+inff_vendor_attr_ssid_prot_policy[INFF_VENDOR_ATTR_SSID_PROT_MAX + 1] = {
+	[INFF_VENDOR_ATTR_SSID_PROT_UNSPEC] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_SSID_PROT_ENABLE] = {.type = NLA_U8},
+	[INFF_VENDOR_ATTR_SSID_PROT_MAX] = {.type = NLA_U8},
+};
+
+static int
+inff_cfg80211_vndr_cmds_ssid_prot(struct wiphy *wiphy,
+				  struct wireless_dev *wdev,
+				  const void *data, int len)
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
+			ret = inff_fwcmd_iovar_int_set(ifp, "ssid_protection", val);
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
+static int
+inff_cfg80211_vndr_cmds_mchan_config(struct wiphy *wiphy,
+				     struct wireless_dev *wdev,
+				     const void *data, int len)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	u8 val = *(u8 *)data;
+
+	if (val <= INFF_MCHAN_CONF_AUDIO)
+		cfg->mchan_conf = val;
+
+	return 0;
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
+int get_inff_num_vndr_cmds(void)
+{
+	int num = ARRAY_SIZE(inff_vendor_cmds);
+
+	return num;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/vendor.h b/drivers/net/wireless/infineon/inffmac/vendor.h
new file mode 100644
index 000000000000..a2fd2e8aef05
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/vendor.h
@@ -0,0 +1,322 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_VENDOR_H
+#define INFF_VENDOR_H
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
+	SCMD(RSV21)		= 21,
+	SCMD(RSV22)		= 22,
+	SCMD(RSV23)		= 23,
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
+enum inff_vendor_attr_mbo {
+	INFF_VENDOR_ATTR_MBO_UNSPEC,
+	INFF_VENDOR_ATTR_MBO_CMD,
+	INFF_VENDOR_ATTR_MBO_PARAMS,
+	INFF_VENDOR_ATTR_MBO_MAX
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
+enum inff_vendor_attr_wnm {
+	INFF_VENDOR_ATTR_WNM_UNSPEC,
+	INFF_VENDOR_ATTR_WNM_CMD,
+	INFF_VENDOR_ATTR_WNM_PARAMS,
+	INFF_VENDOR_ATTR_WNM_MAX
+};
+
+enum inff_vendor_attr_ssid_prot {
+	INFF_VENDOR_ATTR_SSID_PROT_UNSPEC,
+	INFF_VENDOR_ATTR_SSID_PROT_ENABLE,
+	INFF_VENDOR_ATTR_SSID_PROT_MAX
+};
+
+extern const struct wiphy_vendor_command inff_vendor_cmds[];
+int get_inff_num_vndr_cmds(void);
+
+#endif /* INFF_VENDOR_H */
-- 
2.25.1


