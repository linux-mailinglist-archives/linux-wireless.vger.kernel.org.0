Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACB4EA54
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfFUOO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 10:14:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39004 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUOO7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 10:14:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LE9mRl016447;
        Fri, 21 Jun 2019 07:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=i00A3W1dS4Q7uahEf78WyDC/mPQbpCfackrVkAiNEU0=;
 b=imyViNVW8ml2M1+JJA4Vz/ilOHtOvIjD5MyoZYZHyvlifqR4DG30d7MMg+yZ2tyNvsxi
 rRsrgBsKcpVC+bFJmgqCLb2BDsg63me78U9lWHOBIiJ/mmXm5R/djalmQ0Yjfwz0wr87
 y3HYIDKnDx79EtH7apTOyrCKtJlsgR+J8QesaP8s7Woxvg1ZUFzXGRYGI7oq9VjinUmv
 Unty7jKS4trwJ+Jhd6rPdciv5gCrpEemcmGLxPMLaQOZrhC8e5psqX5V73X+sS7MPpxH
 +bu7f5oXshyMiqp0GfWfeSRIbZmRzXuzbpnXAs6C4ZIDrmO4mYk5n4Ue3Hzokwvi5JSH qg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t8yp209rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 07:14:56 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 21 Jun
 2019 07:14:55 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 21 Jun 2019 07:14:54 -0700
Received: from gbhat-ThinkPad-T430.marvell.com (gbhat-thinkpad-t430.marvell.com [10.31.176.106])
        by maili.marvell.com (Postfix) with ESMTP id 76C703F703F;
        Fri, 21 Jun 2019 07:14:52 -0700 (PDT)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Brian Norris <briannorris@chromium.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        "Rakesh Parmar" <rakeshp@marvell.com>,
        Swati Kushwaha <swatiuma@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH] mwifiex: ignore processing invalid command response
Date:   Fri, 21 Jun 2019 19:44:44 +0530
Message-ID: <1561126484-7735-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Swati Kushwaha <swatiuma@marvell.com>

Firmware can send invalid command response, the processing of
which can attempt to modify unexpected context and cause issues.
To fix this, driver should check that the command response ID is
same as the one it downloaded, and ignore processing of invalid
response.

Signed-off-by: Swati Kushwaha <swatiuma@marvell.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   27 ++++++++++++++++--------
 drivers/net/wireless/marvell/mwifiex/main.h   |    2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 8c35441..133b03d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -39,10 +39,11 @@
 static void
 mwifiex_init_cmd_node(struct mwifiex_private *priv,
 		      struct cmd_ctrl_node *cmd_node,
-		      u32 cmd_oid, void *data_buf, bool sync)
+		      u32 cmd_no, void *data_buf, bool sync)
 {
 	cmd_node->priv = priv;
-	cmd_node->cmd_oid = cmd_oid;
+	cmd_node->cmd_no = cmd_no;
+
 	if (sync) {
 		cmd_node->wait_q_enabled = true;
 		cmd_node->cmd_wait_q_woken = false;
@@ -92,7 +93,7 @@
 mwifiex_clean_cmd_node(struct mwifiex_adapter *adapter,
 		       struct cmd_ctrl_node *cmd_node)
 {
-	cmd_node->cmd_oid = 0;
+	cmd_node->cmd_no = 0;
 	cmd_node->cmd_flag = 0;
 	cmd_node->data_buf = NULL;
 	cmd_node->wait_q_enabled = false;
@@ -201,6 +202,7 @@ static int mwifiex_dnld_cmd_to_fw(struct mwifiex_private *priv,
 	}
 
 	cmd_code = le16_to_cpu(host_cmd->command);
+	cmd_node->cmd_no = cmd_code;
 	cmd_size = le16_to_cpu(host_cmd->size);
 
 	if (adapter->hw_status == MWIFIEX_HW_STATUS_RESET &&
@@ -621,7 +623,7 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 	}
 
 	/* Initialize the command node */
-	mwifiex_init_cmd_node(priv, cmd_node, cmd_oid, data_buf, sync);
+	mwifiex_init_cmd_node(priv, cmd_node, cmd_no, data_buf, sync);
 
 	if (!cmd_node->cmd_skb) {
 		mwifiex_dbg(adapter, ERROR,
@@ -822,9 +824,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 	uint16_t cmdresp_result;
 	unsigned long flags;
 
-	/* Now we got response from FW, cancel the command timer */
-	del_timer_sync(&adapter->cmd_timer);
-
 	if (!adapter->curr_cmd || !adapter->curr_cmd->resp_skb) {
 		resp = (struct host_cmd_ds_command *) adapter->upld_buf;
 		mwifiex_dbg(adapter, ERROR,
@@ -833,9 +832,20 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 		return -1;
 	}
 
+	resp = (struct host_cmd_ds_command *)adapter->curr_cmd->resp_skb->data;
+	orig_cmdresp_no = le16_to_cpu(resp->command);
+	cmdresp_no = (orig_cmdresp_no & HostCmd_CMD_ID_MASK);
+
+	if (adapter->curr_cmd->cmd_no != cmdresp_no) {
+		mwifiex_dbg(adapter, ERROR,
+			    "cmdresp error: cmd=0x%x cmd_resp=0x%x\n",
+			    adapter->curr_cmd->cmd_no, cmdresp_no);
+		return -1;
+	}
+	/* Now we got response from FW, cancel the command timer */
+	del_timer_sync(&adapter->cmd_timer);
 	clear_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags);
 
-	resp = (struct host_cmd_ds_command *) adapter->curr_cmd->resp_skb->data;
 	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
 		/* Copy original response back to response buffer */
 		struct mwifiex_ds_misc_cmd *hostcmd;
@@ -849,7 +859,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 			memcpy(hostcmd->cmd, resp, size);
 		}
 	}
-	orig_cmdresp_no = le16_to_cpu(resp->command);
 
 	/* Get BSS number and corresponding priv */
 	priv = mwifiex_get_priv_by_id(adapter,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index b025ba1..3e442c7 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -747,7 +747,7 @@ struct mwifiex_bss_prio_tbl {
 struct cmd_ctrl_node {
 	struct list_head list;
 	struct mwifiex_private *priv;
-	u32 cmd_oid;
+	u32 cmd_no;
 	u32 cmd_flag;
 	struct sk_buff *cmd_skb;
 	struct sk_buff *resp_skb;
-- 
1.7.1

