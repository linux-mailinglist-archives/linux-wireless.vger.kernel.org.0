Return-Path: <linux-wireless+bounces-8738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343019017CA
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E29286445
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4582494;
	Sun,  9 Jun 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TGEypZZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40307711F;
	Sun,  9 Jun 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957387; cv=none; b=KD77qOCLJJc3Gkt01YbRXy38N353b2Z583g2ZvMCTuJ2ug3QwPHoN+o1UYGEc6UcIEY+UC9sSjOfUQ4N6pOkaTX2hEnK2hxD6vsnTvwHXNpjIk/qG4m+CNR6DkvS+Z0UNhokPpax7cnjLtmRiQXmw3I3wGaQba2AJ2Y6I807H0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957387; c=relaxed/simple;
	bh=BsL8H/SzSfV8X+d60t6w6ejdd2LYuvc0MQOi9mIlRFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EploKnqRUTLzv6dUtmcCVjEWo88EGB3HMaeQpmYteFuDoFFuGI1KCewwRXKEd/NgoFUSZNPouOSMmqJS+yx49MG4431/EOsQHksijkbYamkuyef4fjHe1MWj3enNs15Comz9C2nkn5cG3bUM2HD21R0iwv0jM+nR35CC12+WZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TGEypZZX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMa7Z118579;
	Sun, 9 Jun 2024 13:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957356;
	bh=t3eHj47MnuXbXmcX9CTFvUliCzM4+WloYvy9YXrJRnY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TGEypZZXKj1IrPF9HaquaJWEw2/9R1dUQmv2jAt+Ian05MXtjPTSHzQFnrnxQdmiG
	 QiUkheRnyOukh8t06Q6GPgp5CWf+SHXclQeGHdgrE+VKvfbs3yaxpw7oLBptB/DhLZ
	 wkzn/wWCp2ZZxiIOOKRcFV3Lhus5hq5u3GLmZInU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMaGq053438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:36 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:36 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMZFt034536;
	Sun, 9 Jun 2024 13:22:36 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>
Subject: [PATCH v2 04/17] wifi: cc33xx: Add cmd.c, cmd.h
Date: Sun, 9 Jun 2024 21:20:49 +0300
Message-ID: <20240609182102.2950457-5-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

This is the command infrastructure for the CC33xx.
Similar to wlcore, all commands eventually reach
__cc33xx_cmd_send which fills a generic command
header and send the buffer via the IO abstraction layer.
Unlike wlcore, there is no polling for command completion
which is received via an interrupt which signals
cc->command_complete.
---
 drivers/net/wireless/ti/cc33xx/cmd.c | 2030 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/cmd.h |  700 +++++++++
 2 files changed, 2730 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/cmd.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/cmd.h

diff --git a/drivers/net/wireless/ti/cc33xx/cmd.c b/drivers/net/wireless/ti/cc33xx/cmd.c
new file mode 100644
index 000000000000..9654b3fe1810
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/cmd.c
@@ -0,0 +1,2030 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "acx.h"
+#include "event.h"
+#include "io.h"
+#include "tx.h"
+
+#define CC33XX_REBOOT_TIMEOUT_MSEC		100
+
+static void init_cmd_header(struct cc33xx_cmd_header *header,
+			    size_t cmd_len, u16 id)
+{
+	header->NAB_header.len = cpu_to_le16(cmd_len);
+	WARN_ON(le16_to_cpu(header->NAB_header.len) != cmd_len);
+
+	header->NAB_header.sync_pattern = cpu_to_le32(HOST_SYNC_PATTERN);
+	header->NAB_header.opcode = cpu_to_le16(id);
+}
+
+int cc33xx_set_max_buffer_size(struct cc33xx *cc, enum buffer_size max_buffer_size)
+{
+	switch (max_buffer_size) {
+	case INI_MAX_BUFFER_SIZE:
+		/* INI FILE PAYLOAD SIZE + INI CMD PARAM + INT */
+		cc->max_cmd_size = CC33XX_INI_CMD_MAX_SIZE;
+		cc->max_cmd_size += sizeof(struct cc33xx_cmd_ini_params_download);
+		cc->max_cmd_size += sizeof(u32);
+		break;
+
+	case CMD_MAX_BUFFER_SIZE:
+		cc->max_cmd_size = CC33XX_CMD_MAX_SIZE;
+		break;
+
+	default:
+		cc33xx_warning("max_buffer_size invalid, not changing buffer size");
+		break;
+	}
+
+	return 0;
+}
+
+static int send_buffer(struct cc33xx *cc, int cmd_box_addr,
+		       void *buf, size_t len)
+{
+	size_t max_cmd_size_align;
+
+	memcpy(cc->cmd_buf, buf, len);
+
+	memset(cc->cmd_buf + len, 0, (CC33XX_CMD_BUFFER_SIZE) - len);
+
+	max_cmd_size_align = __ALIGN_MASK(cc->max_cmd_size,
+					  CC33XX_BUS_BLOCK_SIZE * 2 - 1);
+
+	return cc33xx_write(cc, cmd_box_addr, cc->cmd_buf,
+			    max_cmd_size_align, true);
+}
+
+/* send command to firmware
+ *
+ * @cc: cc struct
+ * @id: command id
+ * @buf: buffer containing the command, must work with dma
+ * @len: length of the buffer
+ * return the cmd status code on success.
+ */
+static int __cc33xx_cmd_send(struct cc33xx *cc, u16 id, void *buf,
+			     size_t len, size_t res_len, bool sync)
+{
+	struct cc33xx_cmd_header *cmd;
+	unsigned long timeout;
+	int ret;
+
+	if (id >= CMD_LAST_SUPPORTED_COMMAND) {
+		cc33xx_debug(DEBUG_CMD, "command ID: %d, blocked", id);
+		return CMD_STATUS_SUCCESS;
+	}
+
+	if (WARN_ON(len < sizeof(*cmd))		||
+	    WARN_ON(len > cc->max_cmd_size)	||
+	    WARN_ON(len % 4 != 0))
+		return -EIO;
+
+	cmd = buf;
+	cmd->id = cpu_to_le16(id);
+	cmd->status = 0;
+
+	init_cmd_header(cmd, len, id);
+	init_completion(&cc->command_complete);
+	ret = send_buffer(cc, NAB_DATA_ADDR, buf, len);
+
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(!sync))
+		return CMD_STATUS_SUCCESS;
+
+	timeout = msecs_to_jiffies(CC33XX_COMMAND_TIMEOUT);
+	ret = wait_for_completion_timeout(&cc->command_complete, timeout);
+
+	if (ret < 1) {
+		cc33xx_debug(DEBUG_CMD, "Command T.O");
+		return -EIO;
+	}
+
+	switch (id) {
+	case CMD_INTERROGATE:
+	case CMD_DEBUG_READ:
+	case CMD_TEST_MODE:
+	case CMD_BM_READ_DEVICE_INFO:
+		cc33xx_debug(DEBUG_CMD,
+			     "Response len %d, allocated buffer len %zu",
+			     cc->result_length, res_len);
+
+		if (!res_len)
+			break; /* Response should be discarded */
+
+		if (WARN_ON(cc->result_length > res_len)) {
+			cc33xx_error("Error, insufficient response buffer");
+			break;
+		}
+
+		memcpy(buf + sizeof(struct NAB_header),
+		       cc->command_result,
+			cc->result_length);
+
+		break;
+
+	default:
+		break;
+	}
+
+	return CMD_STATUS_SUCCESS;
+}
+
+/* send command to fw and return cmd status on success
+ * valid_rets contains a bitmap of allowed error codes
+ */
+static int cc33xx_cmd_send_failsafe(struct cc33xx *cc, u16 id, void *buf,
+				    size_t len, size_t res_len,
+				    unsigned long valid_rets)
+{
+	int ret = __cc33xx_cmd_send(cc, id, buf, len, res_len, true);
+
+	cc33xx_debug(DEBUG_TESTMODE, "CMD# %d, len=%zu", id, len);
+
+	if (ret < 0)
+		goto fail;
+
+	/* success is always a valid status */
+	valid_rets |= BIT(CMD_STATUS_SUCCESS);
+
+	if (ret >= MAX_COMMAND_STATUS || !test_bit(ret, &valid_rets)) {
+		cc33xx_error("command execute failure %d", ret);
+		ret = -EIO;
+	}
+
+	return ret;
+fail:
+	cc33xx_queue_recovery_work(cc);
+	return ret;
+}
+
+/* wrapper for cc33xx_cmd_send that accept only CMD_STATUS_SUCCESS
+ * return 0 on success.
+ */
+int cc33xx_cmd_send(struct cc33xx *cc, u16 id, void *buf,
+		    size_t len, size_t res_len)
+{
+	int ret;
+	/* Support id */
+	switch ((enum cc33xx_cmd)id) {
+	case CMD_EMPTY:
+	case CMD_START_DHCP_MGMT_SEQ:
+	case CMD_STOP_DHCP_MGMT_SEQ:
+	case CMD_START_SECURITY_MGMT_SEQ:
+	case CMD_STOP_SECURITY_MGMT_SEQ:
+	case CMD_START_ARP_MGMT_SEQ:
+	case CMD_STOP_ARP_MGMT_SEQ:
+	case CMD_START_DNS_MGMT_SEQ:
+	case CMD_STOP_DNS_MGMT_SEQ:
+	case CMD_SEND_DEAUTH_DISASSOC:
+	case CMD_SCHED_STATE_EVENT:
+	{
+		return 0;
+	} break;
+	default:
+	{
+		if ((enum cc33xx_cmd)id >= CMD_LAST_SUPPORTED_COMMAND)
+			return 0;
+		goto send;
+	}
+	}
+send:
+	ret = cc33xx_cmd_send_failsafe(cc, id, buf, len, res_len, 0);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int cc33xx_count_role_set_bits(unsigned long role_map)
+{
+	int count = 0;
+	/* if device bit is set ( BIT_2 = ROLE_DEVICE)
+	 * since role device is not counted
+	 * remove it from map
+	 */
+	role_map &= ~BIT(2);
+
+	while (role_map != 0) {
+		count += role_map & 1;
+		role_map >>= 1;
+	}
+
+	return count;
+}
+
+int cc33xx_cmd_role_enable(struct cc33xx *cc, u8 *addr,
+			   u8 role_type, u8 *role_id)
+{
+	struct cc33xx_cmd_role_enable *cmd;
+
+	int ret;
+	unsigned long role_count;
+
+	struct cc33xx_cmd_complete_role_enable *command_complete =
+		  (struct cc33xx_cmd_complete_role_enable *)&cc->command_result;
+
+	role_count = *cc->roles_map;
+	ret = cc33xx_count_role_set_bits(role_count);
+	cc33xx_debug(DEBUG_CMD, "cmd roles enabled: bitmap before: %ld, ret=%d",
+		     role_count, ret);
+
+	/* do not enable more than 2 roles at once, exception is device role */
+	if (ret >= 2 && role_type != CC33XX_ROLE_DEVICE) {
+		cc33xx_debug(DEBUG_CMD,
+			     "cmd role enable: 2 roles already have beed allocated");
+		cc33xx_error("failed to initiate cmd role enable");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role enable, role type %d, addr = %pM",
+		     role_type, addr);
+
+	if (WARN_ON(*role_id != CC33XX_INVALID_ROLE_ID))
+		return -EBUSY;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(cmd->mac_address, addr, ETH_ALEN);
+	cmd->role_type = role_type;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_ENABLE, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role enable");
+		goto out_free;
+	}
+	cc33xx_debug(DEBUG_CMD, "complete role_id = %d",
+		     command_complete->role_id);
+	__set_bit(command_complete->role_id, cc->roles_map);
+	*role_id = command_complete->role_id;
+
+out_free:
+	kfree(cmd);
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_disable(struct cc33xx *cc, u8 *role_id)
+{
+	struct cc33xx_cmd_role_disable *cmd;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD, "cmd role disable");
+
+	if (WARN_ON(*role_id == CC33XX_INVALID_ROLE_ID))
+		return -ENOENT;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	cmd->role_id = *role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_DISABLE, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role disable");
+		goto out_free;
+	}
+
+	__clear_bit(*role_id, cc->roles_map);
+	*role_id = CC33XX_INVALID_ROLE_ID;
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_set_link(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 link)
+{
+	unsigned long flags;
+
+	/* these bits are used by op_tx */
+	spin_lock_irqsave(&cc->cc_lock, flags);
+	__set_bit(link, cc->links_map);
+	__set_bit(link, wlvif->links_map);
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+	cc->links[link].wlvif = wlvif;
+
+	/* Take saved value for total freed packets from wlvif, in case this is
+	 * recovery/resume
+	 */
+	if (wlvif->bss_type != BSS_TYPE_AP_BSS)
+		cc->links[link].total_freed_pkts = wlvif->total_freed_pkts;
+
+	cc->active_link_count++;
+	return 0;
+}
+
+void cc33xx_clear_link(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 *hlid)
+{
+	unsigned long flags;
+
+	if (*hlid == CC33XX_INVALID_LINK_ID)
+		return;
+
+	/* these bits are used by op_tx */
+	spin_lock_irqsave(&cc->cc_lock, flags);
+	__clear_bit(*hlid, cc->links_map);
+	__clear_bit(*hlid, wlvif->links_map);
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+
+	cc->links[*hlid].prev_freed_pkts = 0;
+	cc->links[*hlid].ba_bitmap = 0;
+	eth_zero_addr(cc->links[*hlid].addr);
+
+	/* At this point op_tx() will not add more packets to the queues. We
+	 * can purge them.
+	 */
+	cc33xx_tx_reset_link_queues(cc, *hlid);
+	cc->links[*hlid].wlvif = NULL;
+
+	if (wlvif->bss_type == BSS_TYPE_AP_BSS &&
+	    *hlid == wlvif->ap.bcast_hlid) {
+		u32 sqn_padding = CC33XX_TX_SQN_POST_RECOVERY_PADDING;
+		/* save the total freed packets in the wlvif, in case this is
+		 * recovery or suspend
+		 */
+		wlvif->total_freed_pkts = cc->links[*hlid].total_freed_pkts;
+
+		/* increment the initial seq number on recovery to account for
+		 * transmitted packets that we haven't yet got in the FW status
+		 */
+		if (wlvif->encryption_type == KEY_GEM)
+			sqn_padding = CC33XX_TX_SQN_POST_RECOVERY_PADDING_GEM;
+
+		if (test_bit(CC33XX_FLAG_RECOVERY_IN_PROGRESS, &cc->flags))
+			wlvif->total_freed_pkts += sqn_padding;
+	}
+
+	cc->links[*hlid].total_freed_pkts = 0;
+
+	*hlid = CC33XX_INVALID_LINK_ID;
+	cc->active_link_count--;
+	WARN_ON_ONCE(cc->active_link_count < 0);
+}
+
+static u8 cc33xx_get_native_channel_type(u8 nl_channel_type)
+{
+	switch (nl_channel_type) {
+	case NL80211_CHAN_NO_HT:
+		return CC33XX_CHAN_NO_HT;
+	case NL80211_CHAN_HT20:
+		return CC33XX_CHAN_HT20;
+	case NL80211_CHAN_HT40MINUS:
+		return CC33XX_CHAN_HT40MINUS;
+	case NL80211_CHAN_HT40PLUS:
+		return CC33XX_CHAN_HT40PLUS;
+	default:
+		WARN_ON(1);
+		return CC33XX_CHAN_NO_HT;
+	}
+}
+
+static int cc33xx_cmd_role_start_dev(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				     enum nl80211_band band, int channel)
+{
+	struct cc33xx_cmd_role_start *cmd;
+	int ret;
+
+	struct cc33xx_cmd_complete_role_start *command_complete =
+		(struct cc33xx_cmd_complete_role_start *)&cc->command_result;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start dev %d", wlvif->dev_role_id);
+
+	cmd->role_id = wlvif->dev_role_id;
+	cmd->role_type = CC33XX_ROLE_DEVICE;
+	if (band == NL80211_BAND_5GHZ)
+		cmd->band = CC33XX_BAND_5GHZ;
+	cmd->channel = channel;
+	cmd->channel_type = cc33xx_get_native_channel_type(wlvif->channel_type);
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_START, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role device start");
+		goto err_hlid;
+	}
+
+	wlvif->dev_hlid = command_complete->sta.hlid;
+	cc->links[wlvif->dev_hlid].allocated_pkts = 0;
+	cc->session_ids[wlvif->dev_hlid] = command_complete->sta.session;
+	cc33xx_debug(DEBUG_CMD, "role start: roleid=%d, hlid=%d, session=%d ",
+		     wlvif->dev_role_id, command_complete->sta.hlid,
+		     command_complete->sta.session);
+	ret = cc33xx_set_link(cc, wlvif, wlvif->dev_hlid);
+	goto out_free;
+
+err_hlid:
+	/* clear links on error */
+	cc33xx_clear_link(cc, wlvif, &wlvif->dev_hlid);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_stop_transceiver(struct cc33xx *cc)
+{
+	struct cc33xx_cmd_role_stop *cmd;
+	int ret;
+
+	if (unlikely(cc->state != CC33XX_STATE_ON || !cc->plt)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	cc33xx_debug(DEBUG_CMD, "cmd role stop transceiver");
+
+	cmd->role_id = cc->plt_role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_STOP, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("transceiver - failed to initiate cmd role stop");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_plt_disable(struct cc33xx *cc)
+{
+	struct cc33xx_cmd_PLT_disable *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_send(cc, CMD_PLT_DISABLE, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("transceiver: failed to disable Transceiver mode");
+		goto out_free;
+	} else {
+		cc33xx_debug(DEBUG_CMD, "Succeed to disable Transceiver mode");
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+static int cc333xx_cmd_role_stop_dev(struct cc33xx *cc,
+				     struct cc33xx_vif *wlvif)
+{
+	struct cc33xx_cmd_role_stop *cmd;
+	int ret;
+
+	if (WARN_ON(wlvif->dev_hlid == CC33XX_INVALID_LINK_ID))
+		return -EINVAL;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role stop dev");
+
+	cmd->role_id = wlvif->dev_role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_STOP, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role stop");
+		goto out_free;
+	}
+
+	cc33xx_clear_link(cc, wlvif, &wlvif->dev_hlid);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_plt_enable(struct cc33xx *cc, u8 role_id)
+{
+	struct cc33xx_cmd_PLT_enable *cmd;
+	s32 ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_send(cc, CMD_PLT_ENABLE, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("Failed to send CMD_PLT_ENABLE");
+		goto out_free;
+	}
+	cc33xx_debug(DEBUG_CMD, "Success to send CMD_PLT_ENABLE");
+
+out_free:
+	kfree(cmd);
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_start_transceiver(struct cc33xx *cc, u8 role_id)
+{
+	struct cc33xx_cmd_role_start *cmd;
+	s32 ret;
+	u8 role_type = ROLE_TRANSCEIVER;
+
+	/* Default values */
+	u8 band = NL80211_BAND_2GHZ;
+	u8 channel = 6;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->role_type = role_type;
+	cmd->role_id = role_id;
+	cmd->channel = channel;
+	cmd->band = band;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_START, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role start PLT");
+		goto out_free;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start PLT. Role ID number: %u", role_id);
+
+out_free:
+	kfree(cmd);
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_start_sta(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
+	struct cc33xx_cmd_role_start *cmd;
+
+	u32 supported_rates;
+	int ret;
+
+	struct cc33xx_cmd_complete_role_start *command_complete =
+		(struct cc33xx_cmd_complete_role_start *)&cc->command_result;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start sta %d", wlvif->role_id);
+
+	cmd->role_id = wlvif->role_id;
+	cmd->role_type = CC33XX_ROLE_STA;
+	cmd->channel = wlvif->channel;
+	if (wlvif->band == NL80211_BAND_5GHZ) {
+		cmd->band = CC33XX_BAND_5GHZ;
+		cmd->sta.basic_rate_set = cpu_to_le32(wlvif->basic_rate_set
+							& ~CONF_TX_CCK_RATES);
+	} else {
+		cmd->sta.basic_rate_set = cpu_to_le32(wlvif->basic_rate_set);
+	}
+	cmd->sta.beacon_interval = cpu_to_le16(wlvif->beacon_int);
+	cmd->sta.ssid_type = CC33XX_SSID_TYPE_ANY;
+	cmd->sta.ssid_len = wlvif->ssid_len;
+	memcpy(cmd->sta.ssid, wlvif->ssid, wlvif->ssid_len);
+	memcpy(cmd->sta.bssid, vif->bss_conf.bssid, ETH_ALEN);
+
+	supported_rates = CONF_TX_ENABLED_RATES | CONF_TX_MCS_RATES | wlvif->rate_set;
+	if (wlvif->band == NL80211_BAND_5GHZ)
+		supported_rates &= ~CONF_TX_CCK_RATES;
+
+	if (wlvif->p2p)
+		supported_rates &= ~CONF_TX_CCK_RATES;
+
+	cmd->sta.local_rates = cpu_to_le32(supported_rates);
+
+	cmd->channel_type = cc33xx_get_native_channel_type(wlvif->channel_type);
+
+	/* We don't have the correct remote rates in this stage.  The
+	 * rates will be reconfigured later, after association, if the
+	 * firmware supports ACX_PEER_CAP.  Otherwise, there's nothing
+	 * we can do, so use all supported_rates here.
+	 */
+	cmd->sta.remote_rates = cpu_to_le32(supported_rates);
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_START, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role start sta");
+		goto err_hlid;
+	}
+
+	wlvif->sta.role_chan_type = wlvif->channel_type;
+
+	wlvif->sta.hlid = command_complete->sta.hlid;
+	cc->links[wlvif->sta.hlid].allocated_pkts = 0;
+	cc->session_ids[wlvif->sta.hlid] = command_complete->sta.session;
+	cc33xx_debug(DEBUG_CMD, "role start: roleid=%d, hlid=%d, session=%d basic_rate_set: 0x%x, remote_rates: 0x%x",
+		     wlvif->role_id,
+		     command_complete->sta.hlid, command_complete->sta.session,
+		     wlvif->basic_rate_set, wlvif->rate_set);
+	ret = cc33xx_set_link(cc, wlvif, wlvif->sta.hlid);
+
+	goto out_free;
+
+err_hlid:
+	cc33xx_clear_link(cc, wlvif, &wlvif->sta.hlid);
+
+out_free:
+	kfree(cmd);
+out:
+	return ret;
+}
+
+/* use this function to stop ibss as well */
+int cc33xx_cmd_role_stop_sta(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct cc33xx_cmd_role_stop *cmd;
+	int ret;
+
+	if (WARN_ON(wlvif->sta.hlid == CC33XX_INVALID_LINK_ID))
+		return -EINVAL;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role stop sta %d", wlvif->role_id);
+
+	cmd->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_STOP, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role stop sta");
+		goto out_free;
+	}
+
+	cc33xx_clear_link(cc, wlvif, &wlvif->sta.hlid);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_start_ap(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct cc33xx_cmd_role_start *cmd;
+	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	u32 supported_rates;
+	int ret;
+
+	struct cc33xx_cmd_complete_role_start *command_complete =
+		(struct cc33xx_cmd_complete_role_start *)&cc->command_result;
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start ap %d", wlvif->role_id);
+	cc33xx_debug(DEBUG_CMD, "cmd role start ap basic rateset: 0x%x",
+		     wlvif->basic_rate_set);
+
+	/* If MESH --> ssid_len is always 0 */
+	if (!ieee80211_vif_is_mesh(vif)) {
+		/* trying to use hidden SSID with an old hostapd version */
+		if (wlvif->ssid_len == 0 && !bss_conf->hidden_ssid) {
+			cc33xx_error("got a null SSID from beacon/bss");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->role_id = wlvif->role_id;
+	cmd->role_type = CC33XX_ROLE_AP;
+	cmd->ap.basic_rate_set = cpu_to_le32(wlvif->basic_rate_set);
+	cmd->ap.beacon_interval = cpu_to_le16(wlvif->beacon_int);
+	cmd->ap.dtim_interval = bss_conf->dtim_period;
+	cmd->ap.wmm = wlvif->wmm_enabled;
+	cmd->channel = wlvif->channel;
+	cmd->channel_type = cc33xx_get_native_channel_type(wlvif->channel_type);
+
+	supported_rates = CONF_TX_ENABLED_RATES | CONF_TX_MCS_RATES;
+	if (wlvif->p2p)
+		supported_rates &= ~CONF_TX_CCK_RATES;
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start ap with supported_rates 0x%08x",
+		     supported_rates);
+
+	cmd->ap.local_rates = cpu_to_le32(supported_rates);
+
+	switch (wlvif->band) {
+	case NL80211_BAND_2GHZ:
+		cmd->band = CC33XX_BAND_2_4GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		cmd->band = CC33XX_BAND_5GHZ;
+		break;
+	default:
+		cc33xx_warning("ap start - unknown band: %d", (int)wlvif->band);
+		cmd->band = CC33XX_BAND_2_4GHZ;
+		break;
+	}
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_START, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role start ap");
+		goto out_free_bcast;
+	}
+
+	wlvif->ap.global_hlid = command_complete->ap.global_hlid;
+	wlvif->ap.bcast_hlid  = command_complete->ap.broadcast_hlid;
+	cc->session_ids[wlvif->ap.global_hlid] = command_complete->ap.global_session_id;
+	cc->session_ids[wlvif->ap.bcast_hlid] = command_complete->ap.bcast_session_id;
+
+	cc33xx_debug(DEBUG_CMD, "role start: roleid=%d, global_hlid=%d, broadcast_hlid=%d, global_session_id=%d, bcast_session_id=%d, basic_rate_set: 0x%x, remote_rates: 0x%x",
+		     wlvif->role_id,
+		     command_complete->ap.global_hlid,
+		     command_complete->ap.broadcast_hlid,
+		     command_complete->ap.global_session_id,
+		     command_complete->ap.bcast_session_id,
+		     wlvif->basic_rate_set, wlvif->rate_set);
+
+	ret = cc33xx_set_link(cc, wlvif, wlvif->ap.global_hlid);
+	ret = cc33xx_set_link(cc, wlvif, wlvif->ap.bcast_hlid);
+
+	goto out_free;
+
+out_free_bcast:
+	cc33xx_clear_link(cc, wlvif, &wlvif->ap.bcast_hlid);
+	cc33xx_clear_link(cc, wlvif, &wlvif->ap.global_hlid);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_stop_ap(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct cc33xx_cmd_role_stop *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role stop ap %d", wlvif->role_id);
+
+	cmd->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_STOP, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role stop ap");
+		goto out_free;
+	}
+
+	cc33xx_clear_link(cc, wlvif, &wlvif->ap.bcast_hlid);
+	cc33xx_clear_link(cc, wlvif, &wlvif->ap.global_hlid);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_role_start_ibss(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
+	struct cc33xx_cmd_role_start *cmd;
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start ibss %d", wlvif->role_id);
+
+	cmd->role_id = wlvif->role_id;
+	cmd->role_type = CC33XX_ROLE_IBSS;
+	if (wlvif->band == NL80211_BAND_5GHZ)
+		cmd->band = CC33XX_BAND_5GHZ;
+	cmd->channel = wlvif->channel;
+	cmd->ibss.basic_rate_set = cpu_to_le32(wlvif->basic_rate_set);
+	cmd->ibss.beacon_interval = cpu_to_le16(wlvif->beacon_int);
+	cmd->ibss.dtim_interval = bss_conf->dtim_period;
+	cmd->ibss.ssid_type = CC33XX_SSID_TYPE_ANY;
+	cmd->ibss.ssid_len = wlvif->ssid_len;
+	memcpy(cmd->ibss.ssid, wlvif->ssid, wlvif->ssid_len);
+	memcpy(cmd->ibss.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	cmd->sta.local_rates = cpu_to_le32(wlvif->rate_set);
+
+	if (wlvif->sta.hlid == CC33XX_INVALID_LINK_ID) {
+		ret = cc33xx_set_link(cc, wlvif, wlvif->sta.hlid);
+		if (ret)
+			goto out_free;
+	}
+	cmd->ibss.hlid = wlvif->sta.hlid;
+	cmd->ibss.remote_rates = cpu_to_le32(wlvif->rate_set);
+
+	ret = cc33xx_cmd_send(cc, CMD_ROLE_START, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd role enable");
+		goto err_hlid;
+	}
+
+	goto out_free;
+
+err_hlid:
+	/* clear links on error. */
+	cc33xx_clear_link(cc, wlvif, &wlvif->sta.hlid);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+/* send test command to firmware
+ *
+ * @cc: cc struct
+ * @buf: buffer containing the command, with all headers, must work with dma
+ * @len: length of the buffer
+ * @answer: is answer needed
+ */
+int cc33xx_cmd_test(struct cc33xx *cc, void *buf, size_t buf_len, u8 answer)
+{
+	int ret;
+	size_t res_len = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd test");
+
+	if (answer)
+		res_len = buf_len;
+
+	ret = cc33xx_cmd_send(cc, CMD_TEST_MODE, buf, buf_len, res_len);
+
+	if (ret < 0) {
+		cc33xx_warning("TEST command failed");
+		return ret;
+	}
+
+	return ret;
+}
+
+/* read acx from firmware
+ *
+ * @cc: cc struct
+ * @id: acx id
+ * @buf: buffer for the response, including all headers, must work with dma
+ * @len: length of buf
+ */
+int cc33xx_cmd_interrogate(struct cc33xx *cc, u16 id, void *buf,
+			   size_t cmd_len, size_t res_len)
+{
+	struct acx_header *acx = buf;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD, "cmd interrogate");
+
+	acx->id = cpu_to_le16(id);
+
+	/* response payload length, does not include any headers */
+	acx->len = cpu_to_le16(res_len - sizeof(*acx));
+
+	ret = cc33xx_cmd_send(cc, CMD_INTERROGATE, acx, cmd_len, res_len);
+	if (ret < 0)
+		cc33xx_error("INTERROGATE command failed");
+
+	return ret;
+}
+
+/* read debug acx from firmware
+ *
+ * @cc: cc struct
+ * @id: acx id
+ * @buf: buffer for the response, including all headers, must work with dma
+ * @len: length of buf
+ */
+int cc33xx_cmd_debug_inter(struct cc33xx *cc, u16 id, void *buf,
+			   size_t cmd_len, size_t res_len)
+{
+	struct acx_header *acx = buf;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD, "cmd debug interrogate");
+
+	acx->id = cpu_to_le16(id);
+
+	/* response payload length, does not include any headers */
+	acx->len = cpu_to_le16(res_len - sizeof(*acx));
+
+	ret = cc33xx_cmd_send(cc, CMD_DEBUG_READ, acx, cmd_len, res_len);
+	if (ret < 0)
+		cc33xx_error("CMD_DEBUG_READ command failed");
+
+	return ret;
+}
+
+/* write acx value to firmware
+ *
+ * @cc: cc struct
+ * @id: acx id
+ * @buf: buffer containing acx, including all headers, must work with dma
+ * @len: length of buf
+ * @valid_rets: bitmap of valid cmd status codes (i.e. return values).
+ * return the cmd status on success.
+ */
+int cc33xx_cmd_configure_failsafe(struct cc33xx *cc, u16 id, void *buf,
+				  size_t len, unsigned long valid_rets)
+{
+	struct acx_header *acx = buf;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD, "cmd configure (%d), TSFL %x",
+		     id, cc->core_status->tsf);
+
+	if (WARN_ON_ONCE(len < sizeof(*acx)))
+		return -EIO;
+
+	acx->id = cpu_to_le16(id);
+
+	/* payload length, does not include any headers */
+	acx->len = cpu_to_le16(len - sizeof(*acx));
+
+	ret = cc33xx_cmd_send_failsafe(cc, CMD_CONFIGURE, acx, len, 0,
+				       valid_rets);
+	if (ret < 0) {
+		cc33xx_warning("CONFIGURE command NOK");
+		return ret;
+	}
+
+	return ret;
+}
+
+/* wrapper for cc33xx_cmd_configure that accepts only success status.
+ * return 0 on success
+ */
+int cc33xx_cmd_configure(struct cc33xx *cc, u16 id, void *buf, size_t len)
+{
+	int ret = cc33xx_cmd_configure_failsafe(cc, id, buf, len, 0);
+
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/* write acx value to firmware
+ *
+ * @cc: cc struct
+ * @id: acx id
+ * @buf: buffer containing debug, including all headers, must work with dma
+ * @len: length of buf
+ * @valid_rets: bitmap of valid cmd status codes (i.e. return values).
+ * return the cmd status on success.
+ */
+static int cc33xx_cmd_debug_failsafe(struct cc33xx *cc, u16 id, void *buf,
+				     size_t len, unsigned long valid_rets)
+{
+	struct debug_header *acx = buf;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD, "cmd debug (%d)", id);
+
+	if (WARN_ON_ONCE(len < sizeof(*acx)))
+		return -EIO;
+
+	acx->id = cpu_to_le16(id);
+
+	/* payload length, does not include any headers */
+	acx->len = cpu_to_le16(len - sizeof(*acx));
+
+	ret = cc33xx_cmd_send_failsafe(cc, CMD_DEBUG, acx, len, 0,
+				       valid_rets);
+	if (ret < 0) {
+		cc33xx_warning("CONFIGURE command NOK");
+		return ret;
+	}
+
+	return ret;
+}
+
+/* wrapper for cc33xx_cmd_debug that accepts only success status.
+ * return 0 on success
+ */
+int cc33xx_cmd_debug(struct cc33xx *cc, u16 id, void *buf, size_t len)
+{
+	int ret = cc33xx_cmd_debug_failsafe(cc, id, buf, len, 0);
+
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+int cc33xx_cmd_ps_mode(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		       u8 ps_mode, u16 auto_ps_timeout)
+{
+	struct cc33xx_cmd_ps_params *ps_params = NULL;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd set ps mode");
+
+	ps_params = kzalloc(sizeof(*ps_params), GFP_KERNEL);
+	if (!ps_params) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ps_params->role_id = wlvif->role_id;
+	ps_params->ps_mode = ps_mode;
+	ps_params->auto_ps_timeout = cpu_to_le16(auto_ps_timeout);
+
+	ret = cc33xx_cmd_send(cc, CMD_SET_PS_MODE, ps_params,
+			      sizeof(*ps_params), 0);
+	if (ret < 0) {
+		cc33xx_error("cmd set_ps_mode failed");
+		goto out;
+	}
+
+out:
+	kfree(ps_params);
+	return ret;
+}
+
+int cc33xx_cmd_set_default_wep_key(struct cc33xx *cc, u8 id, u8 hlid)
+{
+	struct cc33xx_cmd_set_keys *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd set_default_wep_key %d", id);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->hlid = hlid;
+	cmd->key_id = id;
+	cmd->lid_key_type = WEP_DEFAULT_LID_TYPE;
+	cmd->key_action = cpu_to_le16(KEY_SET_ID);
+	cmd->key_type = KEY_WEP;
+
+	ret = cc33xx_cmd_send(cc, CMD_SET_KEYS, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_warning("cmd set_default_wep_key failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(cmd);
+
+	return ret;
+}
+
+int cc33xx_cmd_set_sta_key(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   u16 action, u8 id, u8 key_type, u8 key_size,
+			   const u8 *key, const u8 *addr, u32 tx_seq_32,
+			   u16 tx_seq_16)
+{
+	struct cc33xx_cmd_set_keys *cmd;
+	int ret = 0;
+
+	/* hlid might have already been deleted */
+	if (wlvif->sta.hlid == CC33XX_INVALID_LINK_ID)
+		return 0;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->hlid = wlvif->sta.hlid;
+
+	if (key_type == KEY_WEP)
+		cmd->lid_key_type = WEP_DEFAULT_LID_TYPE;
+	else if (is_broadcast_ether_addr(addr))
+		cmd->lid_key_type = BROADCAST_LID_TYPE;
+	else
+		cmd->lid_key_type = UNICAST_LID_TYPE;
+
+	cmd->key_action = cpu_to_le16(action);
+	cmd->key_size = key_size;
+	cmd->key_type = key_type;
+
+	cmd->ac_seq_num16[0] = cpu_to_le16(tx_seq_16);
+	cmd->ac_seq_num32[0] = cpu_to_le32(tx_seq_32);
+
+	cmd->key_id = id;
+
+	if (key_type == KEY_TKIP) {
+		/* We get the key in the following form:
+		 * TKIP (16 bytes) - TX MIC (8 bytes) - RX MIC (8 bytes)
+		 * but the target is expecting:
+		 * TKIP - RX MIC - TX MIC
+		 */
+		memcpy(cmd->key, key, 16);
+		memcpy(cmd->key + 16, key + 24, 8);
+		memcpy(cmd->key + 24, key + 16, 8);
+
+	} else {
+		memcpy(cmd->key, key, key_size);
+	}
+
+	cc33xx_dump(DEBUG_CRYPT, "TARGET KEY: ", cmd, sizeof(*cmd));
+
+	ret = cc33xx_cmd_send(cc, CMD_SET_KEYS, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_warning("could not set keys");
+		goto out;
+	}
+
+out:
+	kfree(cmd);
+
+	return ret;
+}
+
+int cc33xx_cmd_set_ap_key(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  u16 action, u8 id, u8 key_type, u8 key_size,
+			  const u8 *key, u8 hlid, u32 tx_seq_32, u16 tx_seq_16)
+{
+	struct cc33xx_cmd_set_keys *cmd;
+	int ret = 0;
+	u8 lid_type;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (hlid == wlvif->ap.bcast_hlid) {
+		if (key_type == KEY_WEP)
+			lid_type = WEP_DEFAULT_LID_TYPE;
+		else
+			lid_type = BROADCAST_LID_TYPE;
+	} else {
+		lid_type = UNICAST_LID_TYPE;
+	}
+
+	cc33xx_debug(DEBUG_CRYPT, "ap key action: %d id: %d lid: %d type: %d hlid: %d",
+		     (int)action, (int)id, (int)lid_type,
+		     (int)key_type, (int)hlid);
+
+	cmd->lid_key_type = lid_type;
+	cmd->hlid = hlid;
+	cmd->key_action = cpu_to_le16(action);
+	cmd->key_size = key_size;
+	cmd->key_type = key_type;
+	cmd->key_id = id;
+	cmd->ac_seq_num16[0] = cpu_to_le16(tx_seq_16);
+	cmd->ac_seq_num32[0] = cpu_to_le32(tx_seq_32);
+
+	if (key_type == KEY_TKIP) {
+		/* We get the key in the following form:
+		 * TKIP (16 bytes) - TX MIC (8 bytes) - RX MIC (8 bytes)
+		 * but the target is expecting:
+		 * TKIP - RX MIC - TX MIC
+		 */
+		memcpy(cmd->key, key, 16);
+		memcpy(cmd->key + 16, key + 24, 8);
+		memcpy(cmd->key + 24, key + 16, 8);
+	} else {
+		memcpy(cmd->key, key, key_size);
+	}
+
+	cc33xx_dump(DEBUG_CRYPT, "TARGET AP KEY: ", cmd, sizeof(*cmd));
+
+	ret = cc33xx_cmd_send(cc, CMD_SET_KEYS, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_warning("could not set ap keys");
+		goto out;
+	}
+
+out:
+	kfree(cmd);
+	return ret;
+}
+
+int cc33xx_cmd_set_peer_state(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			      u8 hlid)
+{
+	struct cc33xx_cmd_set_peer_state *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd set peer state (hlid=%d)", hlid);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->hlid = hlid;
+	cmd->state = CC33XX_CMD_STA_STATE_CONNECTED;
+
+	ret = cc33xx_cmd_send(cc, CMD_SET_LINK_CONNECTION_STATE,
+			      cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send set peer state command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_add_peer(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			struct ieee80211_sta *sta, u8 *hlid, u8 is_connected)
+{
+	struct cc33xx_cmd_add_peer *cmd;
+
+	struct cc33xx_cmd_complete_add_peer *command_complete =
+		(struct cc33xx_cmd_complete_add_peer *)&cc->command_result;
+
+	int i, ret;
+	u32 sta_rates;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd add peer is ap %d", is_connected);
+	cmd->is_connected = is_connected;
+	cmd->role_id = wlvif->role_id;
+	cmd->role_type = CC33XX_ROLE_AP;
+	cmd->link_type = 1;
+
+	memcpy(cmd->addr, sta->addr, ETH_ALEN);
+	cmd->bss_index = CC33XX_AP_BSS_INDEX;
+	cmd->aid = cpu_to_le16(sta->aid);
+	cmd->sp_len = sta->max_sp;
+	cmd->wmm = sta->wme ? 1 : 0;
+
+	for (i = 0; i < NUM_ACCESS_CATEGORIES_COPY; i++) {
+		if (sta->wme && (sta->uapsd_queues & BIT(i))) {
+			cmd->psd_type[NUM_ACCESS_CATEGORIES_COPY - 1 - i] =
+					CC33XX_PSD_UPSD_TRIGGER;
+		} else {
+			cmd->psd_type[NUM_ACCESS_CATEGORIES_COPY - 1 - i] =
+					CC33XX_PSD_LEGACY;
+		}
+	}
+
+	sta_rates = sta->deflink.supp_rates[wlvif->band];
+	if (sta->deflink.ht_cap.ht_supported) {
+		sta_rates |=
+			(sta->deflink.ht_cap.mcs.rx_mask[0] << HW_HT_RATES_OFFSET) |
+			(sta->deflink.ht_cap.mcs.rx_mask[1] << HW_MIMO_RATES_OFFSET);
+	}
+
+	cmd->supported_rates =
+		cpu_to_le32(cc33xx_tx_enabled_rates_get(cc, sta_rates,
+							wlvif->band));
+
+	if (!cmd->supported_rates) {
+		cc33xx_debug(DEBUG_CMD,
+			     "peer has no supported rates yet, configuring basic rates: 0x%x",
+			     wlvif->basic_rate_set);
+		cmd->supported_rates = cpu_to_le32(wlvif->basic_rate_set);
+	}
+
+	cc33xx_debug(DEBUG_CMD, "new peer rates=0x%x queues=0x%x",
+		     cmd->supported_rates, sta->uapsd_queues);
+
+	if (sta->deflink.ht_cap.ht_supported) {
+		cmd->ht_capabilities = cpu_to_le32(sta->deflink.ht_cap.cap);
+		cmd->ht_capabilities |= cpu_to_le32(CC33XX_HT_CAP_HT_OPERATION);
+		cmd->ampdu_params = sta->deflink.ht_cap.ampdu_factor |
+				    sta->deflink.ht_cap.ampdu_density;
+	}
+
+	cmd->has_he = sta->deflink.he_cap.has_he;
+	cmd->mfp = sta->mfp;
+	ret = cc33xx_cmd_send(cc, CMD_ADD_PEER, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd add peer");
+		goto out_free;
+	}
+
+	if (hlid) {
+		if (le16_to_cpu(command_complete->header.status) == CMD_STATUS_SUCCESS) {
+			*hlid = command_complete->hlid;
+			cc->links[*hlid].allocated_pkts = 0;
+			cc->session_ids[*hlid] = command_complete->session_id;
+			cc33xx_debug(DEBUG_CMD, "new peer hlid=%d session_ids=%d",
+				     command_complete->hlid, command_complete->session_id);
+		} else {
+			ret = -EMLINK;
+		}
+	} else {
+		cc33xx_debug(DEBUG_CMD, "update peer done !");
+	}
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_remove_peer(struct cc33xx *cc,
+			   struct cc33xx_vif *wlvif, u8 hlid)
+{
+	struct cc33xx_cmd_remove_peer *cmd;
+	int ret;
+	bool timeout = false;
+
+	cc33xx_debug(DEBUG_CMD, "cmd remove peer %d", (int)hlid);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->hlid = hlid;
+
+	cmd->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_REMOVE_PEER, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to initiate cmd remove peer");
+		goto out_free;
+	}
+
+	ret = cc33xx_wait_for_event(cc, CC33XX_EVENT_PEER_REMOVE_COMPLETE,
+				    &timeout);
+
+	/* We are ok with a timeout here. The event is sometimes not sent
+	 * due to a firmware bug. In case of another error (like SDIO timeout)
+	 * queue a recovery.
+	 */
+	if (ret < 0)
+		cc33xx_queue_recovery_work(cc);
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+static int cc33xx_get_reg_conf_ch_idx(enum nl80211_band band, u16 ch)
+{
+	/* map the given band/channel to the respective predefined
+	 * bit expected by the fw
+	 */
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		/* channels 1..14 are mapped to 0..13 */
+		if (ch >= 1 && ch <= 14)
+			return ch - 1;
+		break;
+	case NL80211_BAND_5GHZ:
+		switch (ch) {
+		case 8 ... 16:
+			/* channels 8,12,16 are mapped to 18,19,20 */
+			return 18 + (ch - 8) / 4;
+		case 34 ... 48:
+			/* channels 34,36..48 are mapped to 21..28 */
+			return 21 + (ch - 34) / 2;
+		case 52 ... 64:
+			/* channels 52,56..64 are mapped to 29..32 */
+			return 29 + (ch - 52) / 4;
+		case 100 ... 140:
+			/* channels 100,104..140 are mapped to 33..43 */
+			return 33 + (ch - 100) / 4;
+		case 149 ... 165:
+			/* channels 149,153..165 are mapped to 44..48 */
+			return 44 + (ch - 149) / 4;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	cc33xx_error("%s: unknown band/channel: %d/%d", __func__, band, ch);
+	return -1;
+}
+
+void cc33xx_set_pending_regdomain_ch(struct cc33xx *cc, u16 channel,
+				     enum nl80211_band band)
+{
+	int ch_bit_idx = 0;
+
+	if (!(cc->quirks & CC33XX_QUIRK_REGDOMAIN_CONF))
+		return;
+
+	ch_bit_idx = cc33xx_get_reg_conf_ch_idx(band, channel);
+
+	if (ch_bit_idx >= 0 && ch_bit_idx <= CC33XX_MAX_CHANNELS)
+		__set_bit_le(ch_bit_idx, (long *)cc->reg_ch_conf_pending);
+}
+
+int cc33xx_cmd_regdomain_config_locked(struct cc33xx *cc)
+{
+	struct cc33xx_cmd_regdomain_dfs_config *cmd = NULL;
+	int ret = 0, i, b, ch_bit_idx;
+	__le32 tmp_ch_bitmap[2] __aligned(sizeof(unsigned long));
+	struct wiphy *wiphy = cc->hw->wiphy;
+	struct ieee80211_supported_band *band;
+	bool timeout = false;
+
+	if (!(cc->quirks & CC33XX_QUIRK_REGDOMAIN_CONF))
+		return 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd reg domain config");
+
+	memcpy(tmp_ch_bitmap, cc->reg_ch_conf_pending, sizeof(tmp_ch_bitmap));
+
+	for (b = NL80211_BAND_2GHZ; b <= NL80211_BAND_5GHZ; b++) {
+		band = wiphy->bands[b];
+		for (i = 0; i < band->n_channels; i++) {
+			struct ieee80211_channel *channel = &band->channels[i];
+			u16 ch = channel->hw_value;
+			u32 flags = channel->flags;
+
+			if (flags & (IEEE80211_CHAN_DISABLED |
+				     IEEE80211_CHAN_NO_IR))
+				continue;
+
+			if ((flags & IEEE80211_CHAN_RADAR) &&
+			    channel->dfs_state != NL80211_DFS_AVAILABLE)
+				continue;
+
+			ch_bit_idx = cc33xx_get_reg_conf_ch_idx(b, ch);
+			if (ch_bit_idx < 0)
+				continue;
+
+			__set_bit_le(ch_bit_idx, (long *)tmp_ch_bitmap);
+		}
+	}
+
+	if (!memcmp(tmp_ch_bitmap, cc->reg_ch_conf_last, sizeof(tmp_ch_bitmap)))
+		goto out;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->ch_bit_map1 = tmp_ch_bitmap[0];
+	cmd->ch_bit_map2 = tmp_ch_bitmap[1];
+	cmd->dfs_region = cc->dfs_region;
+
+	cc33xx_debug(DEBUG_CMD,
+		     "cmd reg domain bitmap1: 0x%08x, bitmap2: 0x%08x",
+		     cmd->ch_bit_map1, cmd->ch_bit_map2);
+
+	ret = cc33xx_cmd_send(cc, CMD_DFS_CHANNEL_CONFIG, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send reg domain dfs config");
+		goto out;
+	}
+
+	ret = cc33xx_wait_for_event(cc, CC33XX_EVENT_DFS_CONFIG_COMPLETE,
+				    &timeout);
+
+	if (ret < 0 || timeout) {
+		cc33xx_error("reg domain conf %serror",
+			     timeout ? "completion " : "");
+		ret = timeout ? -ETIMEDOUT : ret;
+		goto out;
+	}
+
+	memcpy(cc->reg_ch_conf_last, tmp_ch_bitmap, sizeof(tmp_ch_bitmap));
+	memset(cc->reg_ch_conf_pending, 0, sizeof(cc->reg_ch_conf_pending));
+
+out:
+	kfree(cmd);
+	return ret;
+}
+
+int cc33xx_cmd_config_fwlog(struct cc33xx *cc)
+{
+	struct cc33xx_cmd_config_fwlog *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd config firmware logger");
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->logger_mode = cc->conf.host_conf.fwlog.mode;
+	cmd->log_severity = cc->conf.host_conf.fwlog.severity;
+	cmd->timestamp = cc->conf.host_conf.fwlog.timestamp;
+	cmd->output = cc->conf.host_conf.fwlog.output;
+	cmd->threshold = cc->conf.host_conf.fwlog.threshold;
+
+	ret = cc33xx_cmd_send(cc, CMD_CONFIG_FWLOGGER, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send config firmware logger command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+static int cc33xx_cmd_roc(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  u8 role_id, enum nl80211_band band, u8 channel)
+{
+	struct cc33xx_cmd_roc *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd roc %d (%d)", channel, role_id);
+
+	if (WARN_ON(role_id == CC33XX_INVALID_ROLE_ID))
+		return -EINVAL;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->role_id = role_id;
+	cmd->channel = channel;
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		cmd->band = CC33XX_BAND_2_4GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		cmd->band = CC33XX_BAND_5GHZ;
+		break;
+	default:
+		cc33xx_error("roc - unknown band: %d", (int)wlvif->band);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	ret = cc33xx_cmd_send(cc, CMD_REMAIN_ON_CHANNEL, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send ROC command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+static int cc33xx_cmd_croc(struct cc33xx *cc, u8 role_id)
+{
+	struct cc33xx_cmd_croc *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd croc (%d)", role_id);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	cmd->role_id = role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_CANCEL_REMAIN_ON_CHANNEL, cmd,
+			      sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send ROC command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+int cc33xx_roc(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 role_id,
+	       enum nl80211_band band, u8 channel)
+{
+	int ret = 0;
+
+	if (WARN_ON(test_bit(role_id, cc->roc_map)))
+		return 0;
+
+	ret = cc33xx_cmd_roc(cc, wlvif, role_id, band, channel);
+	if (ret < 0)
+		goto out;
+
+	__set_bit(role_id, cc->roc_map);
+out:
+	return ret;
+}
+
+int cc33xx_croc(struct cc33xx *cc, u8 role_id)
+{
+	int ret = 0;
+
+	if (WARN_ON(!test_bit(role_id, cc->roc_map)))
+		return 0;
+
+	ret = cc33xx_cmd_croc(cc, role_id);
+	if (ret < 0)
+		goto out;
+
+	__clear_bit(role_id, cc->roc_map);
+
+	/* Rearm the tx watchdog when removing the last ROC. This prevents
+	 * recoveries due to just finished ROCs - when Tx hasn't yet had
+	 * a chance to get out.
+	 */
+	if (find_first_bit(cc->roc_map, CC33XX_MAX_ROLES) >= CC33XX_MAX_ROLES)
+		cc33xx_rearm_tx_watchdog_locked(cc);
+out:
+	return ret;
+}
+
+int cc33xx_cmd_stop_channel_switch(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct cc33xx_cmd_stop_channel_switch *cmd;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "cmd stop channel switch");
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_STOP_CHANNEL_SWITCH,
+			      cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to stop channel switch command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+
+out:
+	return ret;
+}
+
+/* start dev role and roc on its channel */
+int cc33xx_start_dev(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		     enum nl80211_band band, int channel)
+{
+	int ret;
+
+	if (WARN_ON(!(wlvif->bss_type == BSS_TYPE_STA_BSS ||
+		      wlvif->bss_type == BSS_TYPE_IBSS)))
+		return -EINVAL;
+
+	/* the dev role is already started for p2p mgmt interfaces */
+
+	if (!cc33xx_is_p2p_mgmt(wlvif)) {
+		ret = cc33xx_cmd_role_enable(cc,
+					     cc33xx_wlvif_to_vif(wlvif)->addr,
+					     CC33XX_ROLE_DEVICE,
+					     &wlvif->dev_role_id);
+		if (ret < 0)
+			goto out;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd role start dev");
+	ret = cc33xx_cmd_role_start_dev(cc, wlvif, band, channel);
+	if (ret < 0)
+		goto out_disable;
+
+	cc33xx_debug(DEBUG_CMD, "cmd roc");
+	ret = cc33xx_roc(cc, wlvif, wlvif->dev_role_id, band, channel);
+	if (ret < 0)
+		goto out_stop;
+
+	return 0;
+
+out_stop:
+	cc333xx_cmd_role_stop_dev(cc, wlvif);
+out_disable:
+	if (!cc33xx_is_p2p_mgmt(wlvif))
+		cc33xx_cmd_role_disable(cc, &wlvif->dev_role_id);
+out:
+	return ret;
+}
+
+/* croc dev hlid, and stop the role */
+int cc33xx_stop_dev(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	int ret;
+
+	if (WARN_ON(!(wlvif->bss_type == BSS_TYPE_STA_BSS ||
+		      wlvif->bss_type == BSS_TYPE_IBSS)))
+		return -EINVAL;
+
+	/* flush all pending packets */
+	ret = cc33xx_tx_work_locked(cc);
+	if (ret < 0)
+		goto out;
+
+	if (test_bit(wlvif->dev_role_id, cc->roc_map)) {
+		ret = cc33xx_croc(cc, wlvif->dev_role_id);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = cc333xx_cmd_role_stop_dev(cc, wlvif);
+	if (ret < 0)
+		goto out;
+
+	if (!cc33xx_is_p2p_mgmt(wlvif)) {
+		ret = cc33xx_cmd_role_disable(cc, &wlvif->dev_role_id);
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+int cc33xx_cmd_generic_cfg(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   u8 feature, u8 enable, u8 value)
+{
+	struct cc33xx_cmd_generic_cfg *cmd;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD,
+		     "cmd generic cfg (role %d feature %d enable %d value %d)",
+		     wlvif->role_id, feature, enable, value);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->role_id = wlvif->role_id;
+	cmd->feature = feature;
+	cmd->enable = enable;
+	cmd->value = value;
+
+	ret = cc33xx_cmd_send(cc, CMD_GENERIC_CFG, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send generic cfg command");
+		goto out_free;
+	}
+out_free:
+	kfree(cmd);
+	return ret;
+}
+
+int cmd_channel_switch(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		       struct ieee80211_channel_switch *ch_switch)
+{
+	struct cmd_channel_switch *cmd;
+	u32 supported_rates;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "cmd channel switch (role_id=%d, new channel=%d, count=%d, block tx=%d",
+		     wlvif->role_id, ch_switch->chandef.chan->hw_value,
+		     ch_switch->count, ch_switch->block_tx);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cmd->role_id = wlvif->role_id;
+	cmd->channel = ch_switch->chandef.chan->hw_value;
+	cmd->switch_time = ch_switch->count;
+	cmd->stop_tx = ch_switch->block_tx;
+
+	switch (ch_switch->chandef.chan->band) {
+	case NL80211_BAND_2GHZ:
+		cmd->band = CC33XX_BAND_2_4GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		cmd->band = CC33XX_BAND_5GHZ;
+		break;
+	default:
+		cc33xx_error("invalid channel switch band: %d",
+			     ch_switch->chandef.chan->band);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	supported_rates = CONF_TX_ENABLED_RATES | CONF_TX_MCS_RATES;
+	supported_rates |= wlvif->rate_set;
+	if (wlvif->p2p)
+		supported_rates &= ~CONF_TX_CCK_RATES;
+	cmd->local_supported_rates = cpu_to_le32(supported_rates);
+	cmd->channel_type = wlvif->channel_type;
+
+	ret = cc33xx_cmd_send(cc, CMD_CHANNEL_SWITCH, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send channel switch command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+out:
+	return ret;
+}
+
+int cmd_dfs_master_restart(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct cmd_dfs_master_restart *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd dfs master restart (role %d)",
+		     wlvif->role_id);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_send(cc, CMD_DFS_MASTER_RESTART,
+			      cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send dfs master restart command");
+		goto out_free;
+	}
+out_free:
+	kfree(cmd);
+	return ret;
+}
+
+int cmd_set_cac(struct cc33xx *cc, struct cc33xx_vif *wlvif, bool start)
+{
+	struct cmd_cac_start *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd cac (channel %d) %s",
+		     wlvif->channel, start ? "start" : "stop");
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->role_id = wlvif->role_id;
+	cmd->channel = wlvif->channel;
+	if (wlvif->band == NL80211_BAND_5GHZ)
+		cmd->band = CC33XX_BAND_5GHZ;
+	cmd->bandwidth = cc33xx_get_native_channel_type(wlvif->channel_type);
+
+	ret = cc33xx_cmd_send(cc, start ? CMD_CAC_START : CMD_CAC_STOP,
+			      cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send cac command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+	return ret;
+}
+
+int cmd_set_bd_addr(struct cc33xx *cc, u8 *bd_addr)
+{
+	struct cmd_set_bd_addr *cmd;
+	int ret = 0;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(cmd->bd_addr, bd_addr, sizeof(cmd->bd_addr));
+
+	ret = cc33xx_cmd_send(cc, CMD_SET_BD_ADDR, cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to set BD address");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+out:
+	return ret;
+}
+
+int cmd_get_device_info(struct cc33xx *cc, u8 *info_buffer, size_t buffer_len)
+{
+	struct cc33xx_cmd_get_device_info *cmd;
+	int ret = 0;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ret = cc33xx_cmd_send(cc, CMD_BM_READ_DEVICE_INFO, cmd,
+			      sizeof(*cmd), sizeof(*cmd));
+	if (ret < 0) {
+		cc33xx_error("Device info command failure ");
+	} else {
+		WARN_ON(buffer_len > sizeof(cmd->device_info));
+		memcpy(info_buffer, cmd->device_info, buffer_len);
+	}
+
+	kfree(cmd);
+
+	return ret;
+}
+
+int cmd_download_container_chunk(struct cc33xx *cc, u8 *chunk,
+				 size_t chunk_len, bool is_last_chunk)
+{
+	struct cc33xx_cmd_container_download *cmd;
+	const size_t command_size = sizeof(*cmd) + chunk_len;
+	int ret;
+	bool  is_sync_transfer = !is_last_chunk;
+
+	cmd = kzalloc(command_size, GFP_KERNEL);
+
+	if (!cmd) {
+		cc33xx_error("Chunk buffer allocation failure");
+		return -ENOMEM;
+	}
+
+	memcpy(cmd->payload, chunk, chunk_len);
+	cmd->length = cpu_to_le32(chunk_len);
+
+	if (is_last_chunk) {
+		cc33xx_debug(DEBUG_BOOT, "Suspending IRQ while device reboots");
+		cc33xx_disable_interrupts_nosync(cc);
+	}
+
+	ret = __cc33xx_cmd_send(cc, CMD_CONTAINER_DOWNLOAD, cmd,
+				command_size, sizeof(u32), is_sync_transfer);
+
+	kfree(cmd);
+
+	if (is_last_chunk) {
+		msleep(CC33XX_REBOOT_TIMEOUT_MSEC);
+		cc33xx_debug(DEBUG_BOOT, "Resuming IRQ");
+		cc33xx_enable_interrupts(cc);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/cmd.h b/drivers/net/wireless/ti/cc33xx/cmd.h
new file mode 100644
index 000000000000..f6e4877cf7b4
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/cmd.h
@@ -0,0 +1,700 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __CMD_H__
+#define __CMD_H__
+
+#include "cc33xx.h"
+
+struct acx_header;
+
+enum buffer_size {
+	INI_MAX_BUFFER_SIZE,
+	CMD_MAX_BUFFER_SIZE
+};
+
+int cc33xx_set_max_buffer_size(struct cc33xx *cc, enum buffer_size max_buffer_size);
+int cc33xx_cmd_send(struct cc33xx *cc, u16 id, void *buf,
+		    size_t len, size_t res_len);
+int cc33xx_cmd_role_enable(struct cc33xx *cc, u8 *addr,
+			   u8 role_type, u8 *role_id);
+int cc33xx_cmd_role_disable(struct cc33xx *cc, u8 *role_id);
+int cc33xx_cmd_role_start_sta(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_cmd_role_stop_sta(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_cmd_role_start_ap(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_cmd_role_stop_ap(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_cmd_role_start_ibss(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_start_dev(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		     enum nl80211_band band, int channel);
+int cc33xx_stop_dev(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_cmd_test(struct cc33xx *cc, void *buf, size_t buf_len, u8 answer);
+int cc33xx_cmd_interrogate(struct cc33xx *cc, u16 id, void *buf,
+			   size_t cmd_len, size_t res_len);
+int cc33xx_cmd_debug_inter(struct cc33xx *cc, u16 id, void *buf,
+			   size_t cmd_len, size_t res_len);
+int cc33xx_cmd_configure(struct cc33xx *cc, u16 id, void *buf, size_t len);
+int cc33xx_cmd_debug(struct cc33xx *cc, u16 id, void *buf, size_t len);
+int cc33xx_cmd_configure_failsafe(struct cc33xx *cc, u16 id, void *buf,
+				  size_t len, unsigned long valid_rets);
+int cc33xx_cmd_ps_mode(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		       u8 ps_mode, u16 auto_ps_timeout);
+int cc33xx_cmd_set_default_wep_key(struct cc33xx *cc, u8 id, u8 hlid);
+int cc33xx_cmd_set_sta_key(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   u16 action, u8 id, u8 key_type,
+			   u8 key_size, const u8 *key, const u8 *addr,
+			   u32 tx_seq_32, u16 tx_seq_16);
+int cc33xx_cmd_set_ap_key(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  u16 action, u8 id, u8 key_type, u8 key_size,
+			  const u8 *key, u8 hlid, u32 tx_seq_32, u16 tx_seq_16);
+int cc33xx_cmd_set_peer_state(struct cc33xx *cc,
+			      struct cc33xx_vif *wlvif, u8 hlid);
+int cc33xx_roc(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 role_id,
+	       enum nl80211_band band, u8 channel);
+int cc33xx_croc(struct cc33xx *cc, u8 role_id);
+int cc33xx_cmd_add_peer(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			struct ieee80211_sta *sta, u8 *hlid, u8 is_connected);
+int cc33xx_cmd_remove_peer(struct cc33xx *cc,
+			   struct cc33xx_vif *wlvif, u8 hlid);
+void cc33xx_set_pending_regdomain_ch(struct cc33xx *cc, u16 channel,
+				     enum nl80211_band band);
+int cc33xx_cmd_regdomain_config_locked(struct cc33xx *cc);
+int cc33xx_cmd_generic_cfg(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   u8 feature, u8 enable, u8 value);
+int cc33xx_cmd_config_fwlog(struct cc33xx *cc);
+int cc33xx_cmd_stop_channel_switch(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_set_link(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 link);
+void cc33xx_clear_link(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 *hlid);
+int cc33xx_cmd_role_start_transceiver(struct cc33xx *cc, u8 role_id);
+int cc33xx_cmd_role_stop_transceiver(struct cc33xx *cc);
+int cc33xx_cmd_plt_enable(struct cc33xx *cc, u8 role_id);
+int cc33xx_cmd_plt_disable(struct cc33xx *cc);
+int cmd_channel_switch(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		       struct ieee80211_channel_switch *ch_switch);
+int cmd_dfs_master_restart(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cmd_set_cac(struct cc33xx *cc, struct cc33xx_vif *wlvif, bool start);
+int cmd_set_bd_addr(struct cc33xx *cc, u8 *bd_addr);
+int cmd_get_device_info(struct cc33xx *cc, u8 *info_buffer, size_t buffer_len);
+int cmd_download_container_chunk(struct cc33xx *cc, u8 *chunk,
+				 size_t chunk_len, bool is_last_chunk);
+
+enum cc33xx_cmd {
+	CMD_EMPTY,
+	CMD_SET_KEYS = 1,
+	CMD_SET_LINK_CONNECTION_STATE = 2,
+
+	CMD_CHANNEL_SWITCH = 3,
+	CMD_STOP_CHANNEL_SWITCH = 4,
+
+	CMD_REMAIN_ON_CHANNEL = 5,
+	CMD_CANCEL_REMAIN_ON_CHANNEL = 6,
+
+	CMD_START_DHCP_MGMT_SEQ = 7,
+	CMD_STOP_DHCP_MGMT_SEQ = 8,
+
+	CMD_START_SECURITY_MGMT_SEQ = 9,
+	CMD_STOP_SECURITY_MGMT_SEQ = 10,
+
+	CMD_START_ARP_MGMT_SEQ = 11,
+	CMD_STOP_ARP_MGMT_SEQ = 12,
+
+	CMD_START_DNS_MGMT_SEQ = 13,
+	CMD_STOP_DNS_MGMT_SEQ = 14,
+
+	/* Access point commands */
+	CMD_ADD_PEER = 15,
+	CMD_REMOVE_PEER = 16,
+
+	/* Role API */
+	CMD_ROLE_ENABLE = 17,
+	CMD_ROLE_DISABLE = 18,
+	CMD_ROLE_START = 19,
+	CMD_ROLE_STOP = 20,
+
+	CMD_AP_SET_BEACON_INFO = 21, /* Set AP beacon template */
+
+	/* Managed sequence of sending deauth / disassoc frame */
+	CMD_SEND_DEAUTH_DISASSOC = 22,
+
+	CMD_SCHED_STATE_EVENT = 23,
+	CMD_SCAN = 24,
+	CMD_STOP_SCAN = 25,
+	CMD_SET_PROBE_IE = 26,
+
+	CMD_CONFIGURE = 27,
+	CMD_INTERROGATE = 28,
+
+	CMD_DEBUG = 29,
+	CMD_DEBUG_READ = 30,
+
+	CMD_TEST_MODE = 31,
+	CMD_PLT_ENABLE = 32,
+	CMD_PLT_DISABLE = 33,
+	CMD_CONNECTION_SCAN_SSID_CFG = 34,
+	CMD_BM_READ_DEVICE_INFO = 35,
+	CMD_CONTAINER_DOWNLOAD = 36,
+	CMD_DOWNLOAD_INI_PARAMS = 37,
+	CMD_SET_BD_ADDR = 38,
+	CMD_BLE_COMMANDS = 39,
+
+	CMD_LAST_SUPPORTED_COMMAND,
+
+	/* The following commands are legacy and are not yet supported */
+
+	CMD_SET_PS_MODE,
+	CMD_DFS_CHANNEL_CONFIG,
+	CMD_CONFIG_FWLOGGER,
+	CMD_START_FWLOGGER,
+	CMD_STOP_FWLOGGER,
+	CMD_GENERIC_CFG,
+	CMD_DFS_MASTER_RESTART,
+	CMD_CAC_START,
+	CMD_CAC_STOP,
+	CMD_DFS_RADAR_DETECTION_DEBUG,
+
+	MAX_COMMAND_ID_CC33xx = 0x7FFF,
+};
+
+#define MAX_CMD_PARAMS 572
+
+/* unit ms */
+#define CC33XX_COMMAND_TIMEOUT     2000
+#define CC33XX_CMD_TEMPL_MAX_SIZE  512
+#define CC33XX_EVENT_TIMEOUT       5000
+
+struct cc33xx_cmd_header {
+	struct NAB_header NAB_header;
+	__le16 id;
+	__le16 status;
+
+	/* payload */
+	u8 data[];
+} __packed;
+
+#define CC33XX_CMD_MAX_PARAMS 572
+
+struct cc33xx_command {
+	struct cc33xx_cmd_header header;
+	u8  parameters[CC33XX_CMD_MAX_PARAMS];
+} __packed;
+
+enum {
+	CMD_MAILBOX_IDLE		=  0,
+	CMD_STATUS_SUCCESS		=  1,
+	CMD_STATUS_UNKNOWN_CMD		=  2,
+	CMD_STATUS_UNKNOWN_IE		=  3,
+	CMD_STATUS_REJECT_MEAS_SG_ACTIVE	= 11,
+	CMD_STATUS_RX_BUSY		= 13,
+	CMD_STATUS_INVALID_PARAM		= 14,
+	CMD_STATUS_TEMPLATE_TOO_LARGE		= 15,
+	CMD_STATUS_OUT_OF_MEMORY		= 16,
+	CMD_STATUS_STA_TABLE_FULL		= 17,
+	CMD_STATUS_RADIO_ERROR		= 18,
+	CMD_STATUS_WRONG_NESTING		= 19,
+	CMD_STATUS_TIMEOUT		= 21, /* Driver internal use.*/
+	CMD_STATUS_FW_RESET		= 22, /* Driver internal use.*/
+	CMD_STATUS_TEMPLATE_OOM		= 23,
+	CMD_STATUS_NO_RX_BA_SESSION	= 24,
+
+	MAX_COMMAND_STATUS
+};
+
+enum {
+	BSS_TYPE_IBSS = 0,
+	BSS_TYPE_STA_BSS = 2,
+	BSS_TYPE_AP_BSS = 3,
+	MAX_BSS_TYPE = 0xFF
+};
+
+struct cc33xx_cmd_role_enable {
+	struct cc33xx_cmd_header header;
+
+	u8 role_type;
+	u8 mac_address[ETH_ALEN];
+	u8 padding;
+} __packed;
+
+struct command_complete_header {
+	__le16 id;
+	__le16 status;
+
+	/* payload */
+	u8 data[];
+} __packed;
+
+struct cc33xx_cmd_complete_role_enable {
+	struct command_complete_header header;
+	u8 role_id;
+	u8 padding[3];
+} __packed;
+
+struct cc33xx_cmd_role_disable {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 padding[3];
+} __packed;
+
+enum cc33xx_band {
+	CC33XX_BAND_2_4GHZ		= 0,
+	CC33XX_BAND_5GHZ		= 1,
+	CC33XX_BAND_JAPAN_4_9_GHZ	= 2,
+	CC33XX_BAND_DEFAULT		= CC33XX_BAND_2_4GHZ,
+	CC33XX_BAND_INVALID		= 0x7E,
+	CC33XX_BAND_MAX_RADIO		= 0x7F,
+};
+
+enum cc33xx_channel_type {
+	CC33XX_CHAN_NO_HT,
+	CC33XX_CHAN_HT20,
+	CC33XX_CHAN_HT40MINUS,
+	CC33XX_CHAN_HT40PLUS
+};
+
+struct cc33xx_cmd_role_start {
+	struct cc33xx_cmd_header header;
+	u8 role_id;
+	u8 role_type;
+	u8 band;
+	u8 channel;
+
+	u8 channel_type;
+
+	union {
+		struct {
+			u8 padding_1[54];
+		} __packed device;
+		/* sta & p2p_cli use the same struct */
+		struct {
+			u8 bssid[ETH_ALEN];
+
+			__le32 remote_rates; /* remote supported rates */
+
+			/* The target uses this field to determine the rate at
+			 * which to transmit control frame responses (such as
+			 * ACK or CTS frames).
+			 */
+			__le32 basic_rate_set;
+			__le32 local_rates; /* local supported rates */
+
+			u8 ssid_type;
+			u8 ssid_len;
+			u8 ssid[IEEE80211_MAX_SSID_LEN];
+
+			__le16 beacon_interval; /* in TBTTs */
+		} __packed sta;
+		struct {
+			u8 bssid[ETH_ALEN];
+			u8 hlid; /* data hlid */
+			u8 dtim_interval;
+			__le32 remote_rates; /* remote supported rates */
+
+			__le32 basic_rate_set;
+			__le32 local_rates; /* local supported rates */
+
+			u8 ssid_type;
+			u8 ssid_len;
+			u8 ssid[IEEE80211_MAX_SSID_LEN];
+
+			__le16 beacon_interval; /* in TBTTs */
+
+			u8 padding_1[2];
+		} __packed ibss;
+		/* ap & p2p_go use the same struct */
+		struct {
+			__le16 beacon_interval; /* in TBTTs */
+
+			__le32 basic_rate_set;
+			__le32 local_rates; /* local supported rates */
+
+			u8 dtim_interval;
+			/* ap supports wmm (note that there is additional
+			 * per-sta wmm configuration)
+			 */
+			u8 wmm;
+			u8 padding_1[42];
+		} __packed ap;
+	};
+	u8 padding;
+} __packed;
+
+struct cc33xx_cmd_complete_role_start {
+	struct command_complete_header header;
+	union {
+		struct {
+			u8 hlid;
+			u8 session;
+			u8 padding[2];
+		} __packed sta;
+		struct {
+			/* The host link id for the AP's global queue */
+			u8 global_hlid;
+			/* The host link id for the AP's broadcast queue */
+			u8 broadcast_hlid;
+			u8 bcast_session_id;
+			u8 global_session_id;
+		} __packed ap;
+	};
+} __packed;
+
+struct cc33xx_cmd_role_stop {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 padding[3];
+} __packed;
+
+struct cmd_enabledisable_path {
+	struct cc33xx_cmd_header header;
+
+	u8 channel;
+	u8 padding[3];
+} __packed;
+
+enum cc33xx_cmd_ps_mode_e {
+	STATION_AUTO_PS_MODE,   /* Dynamic Power Save */
+	STATION_ACTIVE_MODE,
+	STATION_POWER_SAVE_MODE
+};
+
+struct cc33xx_cmd_ps_params {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 ps_mode; /* STATION_* */
+	__le16 auto_ps_timeout;
+} __packed;
+
+/* HW encryption keys */
+#define NUM_ACCESS_CATEGORIES_COPY 4
+
+enum cc33xx_cmd_key_action {
+	KEY_ADD_OR_REPLACE = 1,
+	KEY_REMOVE         = 2,
+	KEY_SET_ID         = 3,
+	MAX_KEY_ACTION     = 0xffff,
+};
+
+enum cc33xx_cmd_lid_key_type {
+	UNICAST_LID_TYPE     = 0,
+	BROADCAST_LID_TYPE   = 1,
+	WEP_DEFAULT_LID_TYPE = 2
+};
+
+enum cc33xx_cmd_key_type {
+	KEY_NONE = 0,
+	KEY_WEP  = 1,
+	KEY_TKIP = 2,
+	KEY_AES  = 3, /* aes_ccmp_128 */
+	KEY_GEM  = 4,
+	KEY_IGTK = 5, /* bip_cmac_128 */
+	KEY_CMAC_256 = 6,
+	KEY_GMAC_128 = 7,
+	KEY_GMAC_256 = 8,
+	KEY_GCMP_256 = 9,
+	KEY_CCMP256 = 10,
+	KEY_GCMP128 = 11,
+};
+
+struct cc33xx_cmd_set_keys {
+	struct cc33xx_cmd_header header;
+
+	/* Indicates whether the HLID is a unicast key set
+	 * or broadcast key set. A special value 0xFF is
+	 * used to indicate that the HLID is on WEP-default
+	 * (multi-hlids). of type cc33xx_cmd_lid_key_type.
+	 */
+	u8 hlid;
+
+	/* In WEP-default network (hlid == 0xFF) used to
+	 * indicate which network STA/IBSS/AP role should be
+	 * changed
+	 */
+	u8 lid_key_type;
+
+	/* Key ID - For TKIP and AES key types, this field
+	 * indicates the value that should be inserted into
+	 * the KeyID field of frames transmitted using this
+	 * key entry. For broadcast keys the index use as a
+	 * marker for TX/RX key.
+	 * For WEP default network (HLID=0xFF), this field
+	 * indicates the ID of the key to add or remove.
+	 */
+	u8 key_id;
+	u8 reserved_1;
+
+	/* key_action_e */
+	__le16 key_action;
+
+	/* key size in bytes */
+	u8 key_size;
+
+	/* key_type_e */
+	u8 key_type;
+
+	/* This field holds the security key data to add to the STA table */
+	u8 key[MAX_KEY_SIZE];
+	__le16 ac_seq_num16[NUM_ACCESS_CATEGORIES_COPY];
+	__le32 ac_seq_num32[NUM_ACCESS_CATEGORIES_COPY];
+} __packed;
+
+struct cc33xx_cmd_test_header {
+	u8 id;
+	u8 padding[3];
+} __packed;
+
+#define CC33XX_CMD_STA_STATE_CONNECTED  1
+
+struct cc33xx_cmd_set_peer_state {
+	struct cc33xx_cmd_header header;
+
+	u8 hlid;
+	u8 state;
+	u8 padding[2];
+} __packed;
+
+struct cc33xx_cmd_roc {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 channel;
+	u8 band;
+	u8 padding;
+};
+
+struct cc33xx_cmd_croc {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 padding[3];
+};
+
+enum cc33xx_ssid_type {
+	CC33XX_SSID_TYPE_PUBLIC = 0,
+	CC33XX_SSID_TYPE_HIDDEN = 1,
+	CC33XX_SSID_TYPE_ANY = 2,
+};
+
+enum CC33XX_psd_type {
+	CC33XX_PSD_LEGACY = 0,
+	CC33XX_PSD_UPSD_TRIGGER = 1,
+	CC33XX_PSD_LEGACY_PSPOLL = 2,
+	CC33XX_PSD_SAPSD = 3
+};
+
+#define MAX_SIZE_BEACON_TEMP    (450)
+struct cc33xx_cmd_set_beacon_info {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	__le16 beacon_len;
+	u8 beacon[MAX_SIZE_BEACON_TEMP];
+	u8 padding[3];
+} __packed;
+
+struct cc33xx_cmd_add_peer {
+	struct cc33xx_cmd_header header;
+
+	u8 is_connected;
+	u8 role_id;
+	u8 role_type;
+	u8 link_type;
+	u8 addr[ETH_ALEN];
+	__le16 aid;
+	u8 psd_type[NUM_ACCESS_CATEGORIES_COPY];
+	__le32 supported_rates;
+	u8 bss_index;
+	u8 sp_len;
+	u8 wmm;
+	__le32 ht_capabilities;
+	u8  ampdu_params;
+
+	/* HE peer support */
+	bool has_he;
+	bool mfp;
+	u8 padding[2];
+} __packed;
+
+struct cc33xx_cmd_complete_add_peer {
+	struct command_complete_header header;
+	u8 hlid;
+	u8 session_id;
+} __packed;
+
+struct cc33xx_cmd_remove_peer {
+	struct cc33xx_cmd_header header;
+	u8 hlid;
+	u8 role_id;
+	u8 padding[2];
+} __packed;
+
+/* Continuous mode - packets are transferred to the host periodically
+ * via the data path.
+ * On demand - Log messages are stored in a cyclic buffer in the
+ * firmware, and only transferred to the host when explicitly requested
+ */
+enum cc33xx_fwlogger_log_mode {
+	CC33XX_FWLOG_CONTINUOUS,
+};
+
+/* Include/exclude timestamps from the log messages */
+enum cc33xx_fwlogger_timestamp {
+	CC33XX_FWLOG_TIMESTAMP_DISABLED,
+	CC33XX_FWLOG_TIMESTAMP_ENABLED
+};
+
+/* Logs can be routed to the debug pinouts (where available), to the host bus
+ * (SDIO/SPI), or dropped
+ */
+enum cc33xx_fwlogger_output {
+	CC33XX_FWLOG_OUTPUT_NONE,
+	CC33XX_FWLOG_OUTPUT_DBG_PINS,
+	CC33XX_FWLOG_OUTPUT_HOST,
+};
+
+struct cc33xx_cmd_regdomain_dfs_config {
+	struct cc33xx_cmd_header header;
+
+	__le32 ch_bit_map1;
+	__le32 ch_bit_map2;
+	u8 dfs_region;
+	u8 padding[3];
+} __packed;
+
+enum cc33xx_generic_cfg_feature {
+	CC33XX_CFG_FEATURE_RADAR_DEBUG = 2,
+};
+
+struct cc33xx_cmd_generic_cfg {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 feature;
+	u8 enable;
+	u8 value;
+} __packed;
+
+struct cc33xx_cmd_config_fwlog {
+	struct cc33xx_cmd_header header;
+
+	/* See enum cc33xx_fwlogger_log_mode */
+	u8 logger_mode;
+
+	/* Minimum log level threshold */
+	u8 log_severity;
+
+	/* Include/exclude timestamps from the log messages */
+	u8 timestamp;
+
+	/* See enum cc33xx_fwlogger_output */
+	u8 output;
+
+	/* Regulates the frequency of log messages */
+	u8 threshold;
+
+	u8 padding[3];
+} __packed;
+
+struct cc33xx_cmd_stop_channel_switch {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 padding[3];
+} __packed;
+
+/* Used to check radio status after calibration */
+#define MAX_TLV_LENGTH		500
+#define TEST_CMD_P2G_CAL	2	/* TX BiP */
+
+struct cc33xx_cmd_cal_p2g {
+	struct cc33xx_cmd_header header;
+
+	struct cc33xx_cmd_test_header test;
+
+	__le32 ver;
+	__le16 len;
+	u8 buf[MAX_TLV_LENGTH];
+	u8 type;
+	u8 padding;
+
+	__le16 radio_status;
+
+	u8 sub_band_mask;
+	u8 padding2;
+} __packed;
+
+struct cmd_channel_switch {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+
+	/* The new serving channel */
+	u8 channel;
+	/* Relative time of the serving channel switch in TBTT units */
+	u8 switch_time;
+	/* Stop the role TX, should expect it after radar detection */
+	u8 stop_tx;
+
+	__le32 local_supported_rates;
+
+	u8 channel_type;
+	u8 band;
+
+	u8 padding[2];
+} __packed;
+
+struct cmd_set_bd_addr {
+	struct cc33xx_cmd_header header;
+
+	u8 bd_addr[ETH_ALEN];
+	u8 padding[2];
+} __packed;
+
+struct cmd_dfs_master_restart {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 padding[3];
+} __packed;
+
+/* cac_start and cac_stop share the same params */
+struct cmd_cac_start {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 channel;
+	u8 band;
+	u8 bandwidth;
+} __packed;
+
+/* PLT structs */
+
+struct cc33xx_cmd_PLT_enable {
+	struct cc33xx_cmd_header header;
+	__le32 dummy;
+};
+
+struct cc33xx_cmd_PLT_disable {
+	struct cc33xx_cmd_header header;
+	__le32 dummy;
+};
+
+struct cc33xx_cmd_ini_params_download {
+	struct cc33xx_cmd_header header;
+	__le32 length;
+	u8 payload[];
+} __packed;
+
+struct cc33xx_cmd_container_download {
+	struct cc33xx_cmd_header header;
+	__le32 length;
+	u8 payload[];
+} __packed;
+
+struct cc33xx_cmd_get_device_info {
+	struct cc33xx_cmd_header header;
+	u8 device_info[700];
+} __packed;
+
+#endif /* __CC33XX_CMD_H__ */
-- 
2.25.1


