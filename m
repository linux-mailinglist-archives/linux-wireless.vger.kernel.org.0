Return-Path: <linux-wireless+bounces-27359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B67B7D8DD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA613BB9D8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373E28C869;
	Tue, 16 Sep 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="lz3n+Lb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BF313D79
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061232; cv=none; b=hHoOFFjVoIwrVUZZLEMcTcoXNNxmtfh8TI3Rh8O83f/eZi9gOE/H0vQV0s7IyUueqVvuEsYmSDsCYNJJf0WpiCUT5FArGOnrj3frw6YpRVNVyX9Rr+AdNnokMr0FYyZZtKkoIsObElPNtwM9nMPSwe8VkjouVbAfN/8PGyM4fQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061232; c=relaxed/simple;
	bh=o8DksrL2+wIYPSs9EDoI7+8cccmE8pH4G6Jx/o7zzN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5vAaOd3l2UmbivKBPoKvrZtVm6el7uetRpId5X3lvOB1jKGhekcEN0p5dac9K1+BrVtMyAN4Bw6QhgDy9oROeI2KviThYY0mnHeO0Q6asmBTbi3iIT80h/6iKx4OnhNHfMIG6Zc2rpfk0vDOABOfbr8iEhAQpU5JmFoRC/l8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=lz3n+Lb1; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061227; x=1789597227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8DksrL2+wIYPSs9EDoI7+8cccmE8pH4G6Jx/o7zzN0=;
  b=lz3n+Lb1J3BUKgWITQZQyxltDBLb53o7Z9FFXHEwLYDTm3iv43IkDKaL
   Gmuu2eDUor8g6IB4w4fJDQ0a3Hdi/C2i7BdOwSS92xPDW4YkS1HrzF9N0
   /qO4YkcdTMK7i9vVNtrSSAbuj0KcKk8JtxWkIA52wocfoeKtaraDQD+Im
   0=;
X-CSE-ConnectionGUID: Tfr45d0AQmGeG7GzT/+3ZQ==
X-CSE-MsgGUID: 3p+fGHhkS+iTLb+/S03Qcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918168"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918168"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:20:26 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:20:25 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:20:22 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 09/57] wifi: inffmac: add offload.c/h
Date: Wed, 17 Sep 2025 03:47:24 +0530
Message-ID: <20250916221821.4387-10-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE810.infineon.com (172.23.29.36) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of Packet offload. The device driver provides user
option to configure a wide range of packet offloads in the device as per
the end use case, like MQTT Keepalive Ping Request offload, ICMP Echo
Ping Request offload, Multicast DNS Query Response offload, and ICMP
Echo Response offload.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/offload.c   | 429 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/offload.h   | 215 +++++++++
 2 files changed, 644 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/offload.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/offload.h

diff --git a/drivers/net/wireless/infineon/inffmac/offload.c b/drivers/net/wireless/infineon/inffmac/offload.c
new file mode 100644
index 000000000000..f0551ae0a26c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/offload.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/module.h>
+#include "offload.h"
+#include "feature.h"
+#include "fwil.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "vendor_inf.h"
+
+unsigned int inff_offload_prof = INFF_OFFLOAD_PROF_TYPE_LOW_PWR;
+module_param_named(offload_prof, inff_offload_prof, uint, 0400);
+MODULE_PARM_DESC(offload_prof,
+		 "Offload power profile: 1:low 2:mid 3:high (default:1)");
+
+unsigned int inff_offload_feat = INFF_OFFLOAD_ARP |
+				 INFF_OFFLOAD_ND |
+				 INFF_OFFLOAD_BDO |
+				 INFF_OFFLOAD_ICMP |
+				 INFF_OFFLOAD_TKO |
+				 INFF_OFFLOAD_DLTRO |
+				 INFF_OFFLOAD_PNO |
+				 INFF_OFFLOAD_KEEPALIVE |
+				 INFF_OFFLOAD_GTKOE |
+				 INFF_OFFLOAD_WOWLPF;
+module_param_named(offload_feat, inff_offload_feat, uint, 0400);
+MODULE_PARM_DESC(offload_feat,
+		 "Offload feat bitmap: 0:arp 1:nd 2:mdns 3:icmp 4:tcp-keepalive 5:dhcp-renewal 6:pno 7:keepalive 8:gtk 9:wowlpf (default: 0x1FF)");
+
+/* Offload features to firmware based on a user based power profile using module param
+ * offload_prof and offload_feat (provides flag list of all offloads).
+ * Default power profile : LowPwr with all offloads enabled.
+ */
+void
+inff_offload_config(struct inff_if *ifp, unsigned int ol_feat,
+		    unsigned int ol_profile, bool reset)
+{
+	struct inff_ol_cfg_v1 ol_cfg = {0};
+	u32 ol_feat_skip = ~ol_feat;
+	int err = 0;
+
+	ol_cfg.ver = INFF_OFFLOAD_CFG_VER_1;
+	ol_cfg.len = sizeof(ol_cfg);
+	ol_cfg.id = INFF_OFFLOAD_CFG_ID_PROF;
+	ol_cfg.offload_skip = ol_feat_skip;
+	ol_cfg.u.ol_profile.reset = reset;
+	ol_cfg.u.ol_profile.type = ol_profile;
+
+	err = inff_fil_iovar_data_set(ifp, "offload_config", &ol_cfg,
+				      sizeof(ol_cfg));
+	if (err < 0)
+		inff_err("failed to %s generic offload profile:%u feat:0x%x, err = %d",
+			 reset ? "reset" : "set", ol_profile, ol_feat, err);
+	else
+		inff_info("successfully %s generic offload profile:%u feat:0x%x",
+			  reset ? "reset" : "set", ol_profile, ol_feat);
+}
+
+/* Enable specific offloads that are not enabled in a power profile but have
+ * to be enabled in suspend state as host goes to sleep.
+ */
+void
+inff_offload_enable(struct inff_if *ifp, unsigned int ol_feat,
+		    bool enable)
+{
+	struct inff_ol_cfg_v1 ol_cfg = {0};
+	u32 ol_feat_skip = ~ol_feat;
+	int err = 0;
+
+	ol_cfg.ver = INFF_OFFLOAD_CFG_VER_1;
+	ol_cfg.len = sizeof(ol_cfg);
+	ol_cfg.id = INFF_OFFLOAD_CFG_ID_ACTIVATE;
+	ol_cfg.u.ol_activate.enable = enable;
+	ol_cfg.offload_skip = ol_feat_skip;
+
+	err = inff_fil_iovar_data_set(ifp, "offload_config", &ol_cfg,
+				      sizeof(ol_cfg));
+	if (err < 0)
+		inff_err("failed to %s generic offload feat:0x%x, err = %d",
+			 enable ? "enable" : "disable", ol_feat, err);
+	else
+		inff_info("successfully %s generic offload feat:0x%x",
+			  enable ? "enabled" : "disabled", ol_feat);
+}
+
+void
+inff_offload_host_ipv4_update(struct inff_if *ifp, unsigned int ol_feat,
+			      u32 ipaddr, bool is_add)
+{
+	struct inff_ol_cfg_v1 ol_cfg = {0};
+	u32 ol_feat_skip = ~ol_feat;
+	int err = 0;
+
+	ol_cfg.ver = INFF_OFFLOAD_CFG_VER_1;
+	ol_cfg.len = sizeof(ol_cfg);
+	ol_cfg.id = INFF_OFFLOAD_CFG_ID_INET_V4;
+	ol_cfg.u.ol_inet_v4.del = !is_add;
+	memcpy(ol_cfg.u.ol_inet_v4.host_ipv4.addr, &ipaddr, sizeof(struct ipv4_addr));
+	ol_cfg.offload_skip = ol_feat_skip;
+
+	err = inff_fil_iovar_data_set(ifp, "offload_config", &ol_cfg,
+				      sizeof(ol_cfg));
+	if (err < 0)
+		inff_err("failed to %s generic offload host address %pI4, err = %d",
+			 is_add ? "add" : "del", &ipaddr, err);
+	else
+		inff_dbg(TRACE, "successfully %s generic offload host address %pI4",
+			 is_add ? "added" : "deleted", &ipaddr);
+}
+
+int
+inff_offload_host_ipv6_update(struct inff_if *ifp, unsigned int ol_feat,
+			      void *ptr, u8 type, bool is_add)
+{
+	struct inff_ol_cfg_v1 ol_cfg = {0};
+	u32 ol_feat_skip = ~ol_feat;
+	int err = 0;
+
+	ol_cfg.ver = INFF_OFFLOAD_CFG_VER_1;
+	ol_cfg.len = sizeof(ol_cfg);
+	ol_cfg.id = INFF_OFFLOAD_CFG_ID_INET_V6;
+	ol_cfg.u.ol_inet_v6.del = !is_add;
+	ol_cfg.u.ol_inet_v6.type = type;
+	memcpy(ol_cfg.u.ol_inet_v6.host_ipv6.addr, ptr, sizeof(struct ipv6_addr));
+	ol_cfg.offload_skip = ol_feat_skip;
+
+	err = inff_fil_iovar_data_set(ifp, "offload_config", &ol_cfg,
+				      sizeof(ol_cfg));
+	if (err < 0)
+		inff_err("failed to %s host address %pI6 err = %d",
+			 is_add ? "add" : "del", ptr, err);
+	else
+		inff_dbg(TRACE, "successfully %s host address %pI6",
+			 is_add ? "add" : "del", ptr);
+
+	return err;
+}
+
+void
+inff_offload_configure_arp_nd(struct inff_if *ifp, bool enable)
+{
+	s32 err;
+	u32 mode;
+
+	if (enable && inff_is_apmode_operating(ifp->drvr->wiphy)) {
+		inff_dbg(TRACE, "Skip ARP/ND offload enable when soft AP is running\n");
+		return;
+	}
+
+	if (enable)
+		mode = INFF_OFFLOAD_ARP_AGENT | INFF_OFFLOAD_ARP_PEER_AUTO_REPLY;
+	else
+		mode = 0;
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS)) {
+		u32 feat_set = inff_offload_feat & (INFF_OFFLOAD_ARP | INFF_OFFLOAD_ND);
+
+		if (!feat_set)
+			return;
+
+		if (enable)
+			inff_offload_config(ifp, feat_set, inff_offload_prof, false);
+		else
+			inff_offload_config(ifp, feat_set, inff_offload_prof, true);
+	} else {
+		/* Try to set and enable ARP offload feature, this may fail, then it  */
+		/* is simply not supported and err 0 will be returned                 */
+		err = inff_fil_iovar_int_set(ifp, "arp_ol", mode);
+		if (err) {
+			inff_dbg(TRACE, "failed to set ARP offload mode to 0x%x, err = %d\n",
+				 mode, err);
+		} else {
+			err = inff_fil_iovar_int_set(ifp, "arpoe", enable);
+			if (err) {
+				inff_dbg(TRACE, "failed to configure (%d) ARP offload err = %d\n",
+					 enable, err);
+			} else {
+				inff_dbg(TRACE, "successfully configured (%d) ARP offload to 0x%x\n",
+					 enable, mode);
+			}
+		}
+
+		err = inff_fil_iovar_int_set(ifp, "ndoe", enable);
+		if (err) {
+			inff_dbg(TRACE, "failed to configure (%d) ND offload err = %d\n",
+				 enable, err);
+		} else {
+			inff_dbg(TRACE, "successfully configured (%d) ND offload to 0x%x\n",
+				 enable, mode);
+		}
+	}
+}
+
+int
+inff_offload_configure_mkeep_alive(struct inff_if *ifp, bool immed_flag,
+				   long *param0, long *param1, long *param2,
+				   int max_param_ct)
+{
+	u8 buf[150] = {0};
+	struct inff_mkeep_alive *mkeep_alive;
+	int ret = 0, i = 0, j = 0;
+
+	mkeep_alive = (struct inff_mkeep_alive *)buf;
+
+	mkeep_alive->period_msec = (u32)(*param1);
+
+	if (immed_flag) {
+		if (mkeep_alive->period_msec & WL_MKEEP_ALIVE_IMMEDIATE) {
+			inff_err("Period %d too large\n", mkeep_alive->period_msec);
+			ret = -EINVAL;
+			goto exit;
+		}
+		if (mkeep_alive->period_msec)
+			mkeep_alive->period_msec |= WL_MKEEP_ALIVE_IMMEDIATE;
+	}
+	mkeep_alive->version = WL_MKEEP_ALIVE_VERSION;
+	mkeep_alive->keep_alive_id = (u8)(*param0);
+	mkeep_alive->length = offsetof(struct inff_mkeep_alive, data);
+
+	/* If there is no hex value for pkt data, it is treated as NULL KA.
+	 * If there is hex value for pkt data, then copy hex as data and is
+	 * treated as NAT KA.
+	 */
+	if (mkeep_alive->period_msec > 0) {
+		if (param2[j] < 0) {
+			mkeep_alive->len_bytes = 0;
+		} else if (param2[j + 14] < 0) {
+			inff_err("Invalid pkt data. Required len bytes >= 14.\n");
+			ret = -EINVAL;
+			goto exit;
+		} else {
+			while (param2[j] != ' ') {
+				if (j <= max_param_ct) {
+					mkeep_alive->data[i] = param2[j];
+					j++;
+				}
+				i++;
+			}
+			mkeep_alive->len_bytes = i;
+		}
+	}
+	ret = inff_fil_iovar_data_set(ifp, "mkeep_alive", buf, sizeof(buf));
+	if (ret)
+		inff_err("Failed to set mkeeplive params: %d\n", ret);
+
+exit:
+	return ret;
+}
+
+int
+inff_offload_configure_tko(struct inff_if *ifp, long tko_subcmd_id, long *param0,
+			   long *param1, long *param2, long *param3)
+{
+	struct inff_tko *tko;
+	struct inff_tko_param *tko_param;
+	struct inff_tko_enable *tko_enable;
+	u8 buf[128] = {0};
+	int length;
+	int ret = 0;
+
+	tko = (struct inff_tko *)buf;
+
+	tko->subcmd_id = tko_subcmd_id;
+	switch (tko->subcmd_id) {
+	case WL_TKO_SUBCMD_ENABLE:
+		tko_enable = (struct inff_tko_enable *)tko->data;
+		tko->len = sizeof(*tko_enable);
+
+		tko_enable->enable = (u8)(*param0);
+		break;
+	case WL_TKO_SUBCMD_PARAM:
+		tko_param = (struct inff_tko_param *)tko->data;
+		tko->len = sizeof(*tko_param);
+
+		tko_param->interval = (u16)(*param0);
+		tko_param->retry_interval = (u16)(*param1);
+		tko_param->retry_count = (u16)(*param2);
+		tko_param->rst_delay = (s16)(*param3);
+		break;
+	default:
+		inff_err("offload tko subcmd id %d not recognized", tko->subcmd_id);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	length = offsetof(struct inff_tko, data) + tko->len;
+	ret = inff_fil_iovar_data_set(ifp, "tko", buf, length);
+	if (ret)
+		inff_err("Failed to configure tko: %d\n", ret);
+exit:
+	return ret;
+}
+
+/**
+ * inff_offload_configure_icmp_echo_req() - Prepare ICMP Echo Request IOVAR
+ * based on the ICMP Echo Request Parameters.
+ *
+ * @ifp - Pointer to inff_if structure.
+ * @u8 - Sub Command Type.
+ * @enable - Enable.
+ * @ip_addr - IP Address to be filled.
+ * @ip_ver - IP version.
+ * @mac_addr - MAC Address to be filled.
+ * @periodicity - Periodicity of ping in sec.
+ * @duration - Duration in sec.
+ * Return
+ * 0 - success
+ * Non Zero  - otherwise
+ */
+int
+inff_offload_configure_icmp_echo_req(struct inff_if *ifp, u8 cmd_type,
+				     u8 enable, u8 *ip_addr, u8 ip_ver,
+				     u8 *mac_addr, u32 periodicity, u32 duration)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_icmp_echo_req_cmd *icmp_echo_req_cmd;
+	struct inff_icmp_echo_req_peer_config *icmp_echo_req_peer_config;
+	struct inff_icmp_echo_req_peer_ip *icmp_echo_req_peer_ip;
+	int ret = 0;
+
+	memset(cfg->extra_buf, '\0', WL_EXTRA_BUF_MAX);
+	icmp_echo_req_cmd = (struct inff_icmp_echo_req_cmd *)cfg->extra_buf;
+
+	icmp_echo_req_cmd->version = INFF_OFFLOAD_ICMP_ECHO_REQ_VER;
+	icmp_echo_req_cmd->cmd_type = cmd_type;
+
+	switch (icmp_echo_req_cmd->cmd_type) {
+	case INFF_OFFLOAD_ICMP_ECHO_REQ_ENAB:
+		icmp_echo_req_cmd->data[0] = enable;
+		icmp_echo_req_cmd->length = sizeof(struct inff_icmp_echo_req_cmd) +
+					    sizeof(u8);
+		break;
+	case INFF_OFFLOAD_ICMP_ECHO_REQ_ADD:
+		icmp_echo_req_peer_config = (struct inff_icmp_echo_req_peer_config *)
+					    icmp_echo_req_cmd->data;
+		icmp_echo_req_cmd->length = sizeof(*icmp_echo_req_peer_config) +
+					    sizeof(struct inff_icmp_echo_req_cmd);
+		icmp_echo_req_peer_config->version = INFF_OFFLOAD_ICMP_ECHO_REQ_VER;
+		icmp_echo_req_peer_config->ip_ver = ip_ver;
+		memcpy(icmp_echo_req_peer_config->u.ipv6.addr, ip_addr,
+		       (icmp_echo_req_peer_config->ip_ver == INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V6) ?
+			INFF_IPV6_ADDR_LEN : INFF_IPV4_ADDR_LEN);
+		memcpy(icmp_echo_req_peer_config->mac_addr, mac_addr, ETH_ALEN);
+		icmp_echo_req_peer_config->periodicity = periodicity;
+		icmp_echo_req_peer_config->duration = duration;
+		icmp_echo_req_peer_config->length = sizeof(struct inff_icmp_echo_req_peer_config);
+		break;
+	case INFF_OFFLOAD_ICMP_ECHO_REQ_DEL:
+	case INFF_OFFLOAD_ICMP_ECHO_REQ_START:
+	case INFF_OFFLOAD_ICMP_ECHO_REQ_STOP:
+		icmp_echo_req_peer_ip = (struct inff_icmp_echo_req_peer_ip *)
+					icmp_echo_req_cmd->data;
+		icmp_echo_req_cmd->length = sizeof(*icmp_echo_req_peer_ip) +
+					    sizeof(struct inff_icmp_echo_req_cmd);
+		icmp_echo_req_peer_ip->version = INFF_OFFLOAD_ICMP_ECHO_REQ_VER;
+		icmp_echo_req_peer_ip->ip_ver = ip_ver;
+		memcpy(icmp_echo_req_peer_ip->u.ipv6.addr, ip_addr,
+		       (icmp_echo_req_peer_ip->ip_ver == INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V6) ?
+			INFF_IPV6_ADDR_LEN : INFF_IPV4_ADDR_LEN);
+		icmp_echo_req_peer_ip->length = sizeof(struct inff_icmp_echo_req_peer_ip);
+		break;
+	case INFF_OFFLOAD_ICMP_ECHO_REQ_INFO:
+		icmp_echo_req_peer_ip = (struct inff_icmp_echo_req_peer_ip *)
+					icmp_echo_req_cmd->data;
+		icmp_echo_req_cmd->length = sizeof(*icmp_echo_req_peer_ip) +
+					    sizeof(struct inff_icmp_echo_req_cmd);
+		icmp_echo_req_peer_ip->version = INFF_OFFLOAD_ICMP_ECHO_REQ_VER;
+		icmp_echo_req_peer_ip->ip_ver = ip_ver;
+		if (ip_ver != INFF_OFFLOAD_ICMP_ECHO_REQ_IP_BOTH) {
+			memcpy(icmp_echo_req_peer_ip->u.ipv6.addr, ip_addr,
+			       (icmp_echo_req_peer_ip->ip_ver == INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V6) ?
+				INFF_IPV6_ADDR_LEN : INFF_IPV4_ADDR_LEN);
+		}
+		icmp_echo_req_peer_ip->length = sizeof(struct inff_icmp_echo_req_peer_ip);
+		break;
+	default:
+		inff_err("offload icmp_echo_req subcmd id %d not recognized",
+			 icmp_echo_req_cmd->cmd_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (icmp_echo_req_cmd->cmd_type == INFF_OFFLOAD_ICMP_ECHO_REQ_INFO)
+		ret = inff_fil_iovar_data_get(ifp, "icmp_echo_req", cfg->extra_buf,
+					      WL_EXTRA_BUF_MAX);
+	else
+		ret = inff_fil_iovar_data_set(ifp, "icmp_echo_req", (u8 *)icmp_echo_req_cmd,
+					      icmp_echo_req_cmd->length);
+
+	if (ret)
+		inff_err("Failed to get icmp_echo_req info: %d\n", ret);
+
+	return ret;
+}
+
+s32
+inff_notify_icmp_echo_req_event(struct inff_if *ifp, const struct inff_event_msg *e,
+				void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct wiphy *wiphy = cfg_to_wiphy(cfg);
+	struct inff_icmp_echo_req_event *echo_req_event;
+
+	echo_req_event = (struct inff_icmp_echo_req_event *)data;
+
+	inff_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		 e->status);
+
+	inff_dbg(INFO, "icmp_echo_req_event reason = %d icmp_echo_req_event count = %d\n",
+		 echo_req_event->reason, echo_req_event->echo_req_cnt);
+
+	if (echo_req_event->ip_ver == INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V6) {
+		inff_dbg(INFO, "icmp_echo_req_event IPv6 address = %pI6",
+			 &echo_req_event->u.ipv6.addr);
+	} else if (echo_req_event->ip_ver == INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V4) {
+		inff_dbg(INFO, "icmp_echo_req_event IPv4 address = %pI4",
+			 &echo_req_event->u.ipv6.addr);
+	} else {
+		inff_err("Invalid IP address\n");
+		return -EINVAL;
+	}
+
+	return inff_cfg80211_vndr_evt_icmp_echo_req(wiphy, &ifp->vif->wdev, data,
+						    echo_req_event->length);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/offload.h b/drivers/net/wireless/infineon/inffmac/offload.h
new file mode 100644
index 000000000000..65b8711a99ed
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/offload.h
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_OFFLOAD_H
+#define INFF_OFFLOAD_H
+
+#include "core.h"
+#include "fwil_types.h"
+
+/* enum inff_offload_feats - Packet types to be offloaded to firmware for processing */
+enum inff_offload_feats {
+	INFF_OFFLOAD_ARP		= BIT(0),
+	INFF_OFFLOAD_ND			= BIT(1),
+	INFF_OFFLOAD_BDO		= BIT(2),
+	INFF_OFFLOAD_ICMP		= BIT(3),
+	INFF_OFFLOAD_TKO		= BIT(4),
+	INFF_OFFLOAD_DLTRO		= BIT(5),
+	INFF_OFFLOAD_PNO		= BIT(6),
+	INFF_OFFLOAD_KEEPALIVE		= BIT(7),
+	INFF_OFFLOAD_GTKOE		= BIT(8),
+	INFF_OFFLOAD_WOWLPF		= BIT(9)
+};
+
+enum inff_ol_cfg_id {
+	INFF_OFFLOAD_CFG_ID_PROF = 1,		/* Offload Profile Update */
+	INFF_OFFLOAD_CFG_ID_INET_V4,		/* ADD/DEL IPv4 Address */
+	INFF_OFFLOAD_CFG_ID_INET_V6,		/* ADD/DEL IPv6 Address */
+	INFF_OFFLOAD_CFG_ID_ACTIVATE,		/* Activate/Deactivate Offload */
+	/*  Add new type before this line */
+	INFF_OFFLOAD_CFG_ID_MAX			/* Max Offload Config ID */
+};
+
+enum inff_ol_prof_type {
+	INFF_OFFLOAD_PROF_TYPE_LOW_PWR = 1,	/* Low Power Profile */
+	INFF_OFFLOAD_PROF_TYPE_MID_PWR = 2,	/* Mid Power Profile */
+	INFF_OFFLOAD_PROF_TYPE_HIGH_PWR = 3,	/* High Power Profile */
+	/*  Add new type before this line */
+	INFF_OFFLOAD_PROF_TYPE_MAX		/* Max Offload Profile */
+};
+
+/* Offload profile configuration */
+struct inff_ol_cfg_v1 {
+	u16 ver;					/* version of this structure */
+	u16 len;					/* length of structure in bytes */
+	enum inff_ol_cfg_id id;			/* Offload Config ID */
+
+	union {
+		struct {
+			enum inff_ol_prof_type type;	/* offload profile type */
+			bool reset;			/* Remove profile configuration */
+			u8 pad[3];
+		} ol_profile;
+		struct {
+			struct ipv4_addr host_ipv4;
+			bool del;			/* 1:del 0:add host ipv4 address */
+			u8 pad[3];
+		} ol_inet_v4;
+		struct {
+			struct ipv6_addr host_ipv6;
+			u8 type;			/* 0:unicast 1:anycast */
+			bool del;			/* 1:del 0:add host ipv6 address */
+			u8 pad[2];
+		} ol_inet_v6;
+		struct {
+			bool enable;			/* enable/disable offload feature */
+			u8 pad[3];
+		} ol_activate;
+	} u;
+
+	u32 offload_skip;				/* Bitmap of offload to be skipped */
+};
+
+/* ARP Offload feature flags for arp_ol iovar */
+#define INFF_OFFLOAD_ARP_AGENT			0x00000001
+#define INFF_OFFLOAD_ARP_SNOOP			0x00000002
+#define INFF_OFFLOAD_ARP_HOST_AUTO_REPLY	0x00000004
+#define INFF_OFFLOAD_ARP_PEER_AUTO_REPLY	0x00000008
+
+#define WL_MKEEP_ALIVE_VERSION			1
+#define WL_MKEEP_ALIVE_IMMEDIATE		0x80000000
+
+struct inff_mkeep_alive {
+	u16 version;				/* Version for mkeep_alive */
+	u16 length;				/* length of fixed parameters in the structure */
+	u32 period_msec;			/* high bit on means immediate send */
+	u16 len_bytes;
+	u8 keep_alive_id;			/* 0 - 3 for N = 4 */
+	u8 data[];
+};
+
+struct inff_tko {
+	u16 subcmd_id;				/* subcommand id */
+	u16 len;				/* total length of data[] */
+	u8 data[];				/* subcommand data */
+};
+
+/* subcommand ids */
+#define WL_TKO_SUBCMD_PARAM		1	/* configure offload common parameters  */
+#define WL_TKO_SUBCMD_ENABLE		3	/* enable/disable */
+
+/* WL_TKO_SUBCMD_PARAM subcommand data */
+struct inff_tko_param {
+	u16 interval;		/* keepalive tx interval (secs) */
+	u16 retry_interval;	/* keepalive retry interval (secs) */
+	u16 retry_count;	/* retry_count */
+	s16 rst_delay;		/* delay to delay a RST frame from reaching the host */
+};
+
+struct inff_tko_enable {
+	u8 enable;				/* 1 - enable, 0 - disable */
+	u8 pad[3];				/* 4-byte struct alignment */
+};
+
+#define INFF_OFFLOAD_ICMP_ECHO_REQ_VER		1
+
+#define INFF_OFFLOAD_ICMP_ECHO_REQ_IP_BOTH	0
+#define INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V4	1
+#define INFF_OFFLOAD_ICMP_ECHO_REQ_IP_V6	2
+
+/* ICMP Echo Request Sub commands */
+enum {
+	INFF_OFFLOAD_ICMP_ECHO_REQ_ENAB,
+	INFF_OFFLOAD_ICMP_ECHO_REQ_ADD,
+	INFF_OFFLOAD_ICMP_ECHO_REQ_DEL,
+	INFF_OFFLOAD_ICMP_ECHO_REQ_START,
+	INFF_OFFLOAD_ICMP_ECHO_REQ_STOP,
+	INFF_OFFLOAD_ICMP_ECHO_REQ_INFO
+};
+
+struct inff_icmp_echo_req_peer_ip {
+	u16 version;
+	u16 length;
+	u8 ip_ver;				/* IP Version IPv4:1 IPv6:2 */
+	u8 pad[3];
+	union {
+		struct ipv4_addr ipv4;		/* Peer IPV4 Address */
+		struct ipv6_addr ipv6;		/* Peer IPV6 Address */
+	} u;
+};
+
+struct inff_icmp_echo_req_peer_config {
+	u16 version;
+	u16 length;
+	u8 ip_ver;				/* IP Version IPv4:1 IPv6:2 */
+	u8 pad[3];
+	u32 periodicity;			/* Periodicty of Ping in sec */
+	u32 duration;				/* Duration in sec  */
+	union {
+		struct ipv4_addr ipv4;		/* Peer IPv4 Address */
+		struct ipv6_addr ipv6;		/* Peer IPv6 Address */
+	} u;
+	u8 mac_addr[ETH_ALEN];			/* Peer Mac Address */
+};
+
+/* ICMP Echo Req IOVAR Struct */
+struct inff_icmp_echo_req_cmd {
+	u16 version;
+	u16 length;
+	u8 cmd_type;				/* ICMP Echo Req Cmd Type */
+	u8 pad[3];
+	u8 data[];				/* Data Pointing to Sub cmd structure */
+};
+
+/* ICMP Echo Request IOVAR INFO Struct */
+struct inff_icmp_echo_req_get_peer_info {
+	u32 state;					/* State of the Peer */
+	struct inff_icmp_echo_req_peer_config config;	/* Configuration of Peer */
+};
+
+struct inff_icmp_echo_req_get_info {
+	u16 version;
+	u16 length;
+	u8 enable;				/* Offload Enable */
+	u8 count;				/* Peer Count */
+	u8 pad[2];
+	u8 data[];				/* Data Pointing to get peer info structure */
+};
+
+struct inff_icmp_echo_req_event {
+	u16 version;
+	u16 length;
+	u8 ip_ver;			/* Peer IP Version IPv4:1 IPv6:2 */
+	u8 reason;			/* Event reason */
+	u8 pad[2];
+	u32 echo_req_cnt;		/* ICMP Echo Req Count */
+	union {
+		struct ipv4_addr ipv4;	/* Peer IPV4 Address */
+		struct ipv6_addr ipv6;	/* Peer IPV6 Address */
+	} u;
+};
+
+void inff_offload_config(struct inff_if *ifp, unsigned int ol_feat,
+			 unsigned int ol_profile, bool reset);
+void inff_offload_enable(struct inff_if *ifp, unsigned int ol_feat,
+			 bool enable);
+void inff_offload_host_ipv4_update(struct inff_if *ifp, unsigned int ol_feat,
+				   u32 ipaddr, bool is_add);
+int inff_offload_host_ipv6_update(struct inff_if *ifp, unsigned int ol_feat,
+				  void *ptr, u8 type, bool is_add);
+void inff_offload_configure_arp_nd(struct inff_if *ifp, bool enable);
+int inff_offload_configure_mkeep_alive(struct inff_if *ifp, bool immediate,
+				       long *param0, long *param1, long *param2,
+				       int max_param_ct);
+int inff_offload_configure_tko(struct inff_if *ifp, long tko_subcmd_id, long *param0,
+			       long *param1, long *param2, long *param3);
+int inff_offload_configure_icmp_echo_req(struct inff_if *ifp, u8 cmd_type,
+					 u8 enable, u8 *ip_addr, u8 ip_ver,
+					 u8 *mac_addr, u32 periodicity, u32 duration);
+s32 inff_notify_icmp_echo_req_event(struct inff_if *ifp, const struct inff_event_msg *e,
+				    void *data);
+
+#endif /* INFF_OFFLOAD_H */
-- 
2.25.1


